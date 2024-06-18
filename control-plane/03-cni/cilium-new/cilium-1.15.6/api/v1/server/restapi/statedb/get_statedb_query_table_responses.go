// Code generated by go-swagger; DO NOT EDIT.

// Copyright Authors of Cilium
// SPDX-License-Identifier: Apache-2.0

package statedb

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"io"
	"net/http"

	"github.com/go-openapi/runtime"

	"github.com/cilium/cilium/api/v1/models"
)

// GetStatedbQueryTableOKCode is the HTTP code returned for type GetStatedbQueryTableOK
const GetStatedbQueryTableOKCode int = 200

/*
GetStatedbQueryTableOK Success

swagger:response getStatedbQueryTableOK
*/
type GetStatedbQueryTableOK struct {

	/*
	  In: Body
	*/
	Payload io.ReadCloser `json:"body,omitempty"`
}

// NewGetStatedbQueryTableOK creates GetStatedbQueryTableOK with default headers values
func NewGetStatedbQueryTableOK() *GetStatedbQueryTableOK {

	return &GetStatedbQueryTableOK{}
}

// WithPayload adds the payload to the get statedb query table o k response
func (o *GetStatedbQueryTableOK) WithPayload(payload io.ReadCloser) *GetStatedbQueryTableOK {
	o.Payload = payload
	return o
}

// SetPayload sets the payload to the get statedb query table o k response
func (o *GetStatedbQueryTableOK) SetPayload(payload io.ReadCloser) {
	o.Payload = payload
}

// WriteResponse to the client
func (o *GetStatedbQueryTableOK) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.WriteHeader(200)
	payload := o.Payload
	if err := producer.Produce(rw, payload); err != nil {
		panic(err) // let the recovery middleware deal with this
	}
}

// GetStatedbQueryTableBadRequestCode is the HTTP code returned for type GetStatedbQueryTableBadRequest
const GetStatedbQueryTableBadRequestCode int = 400

/*
GetStatedbQueryTableBadRequest Invalid parameters

swagger:response getStatedbQueryTableBadRequest
*/
type GetStatedbQueryTableBadRequest struct {

	/*
	  In: Body
	*/
	Payload models.Error `json:"body,omitempty"`
}

// NewGetStatedbQueryTableBadRequest creates GetStatedbQueryTableBadRequest with default headers values
func NewGetStatedbQueryTableBadRequest() *GetStatedbQueryTableBadRequest {

	return &GetStatedbQueryTableBadRequest{}
}

// WithPayload adds the payload to the get statedb query table bad request response
func (o *GetStatedbQueryTableBadRequest) WithPayload(payload models.Error) *GetStatedbQueryTableBadRequest {
	o.Payload = payload
	return o
}

// SetPayload sets the payload to the get statedb query table bad request response
func (o *GetStatedbQueryTableBadRequest) SetPayload(payload models.Error) {
	o.Payload = payload
}

// WriteResponse to the client
func (o *GetStatedbQueryTableBadRequest) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.WriteHeader(400)
	payload := o.Payload
	if err := producer.Produce(rw, payload); err != nil {
		panic(err) // let the recovery middleware deal with this
	}
}

// GetStatedbQueryTableNotFoundCode is the HTTP code returned for type GetStatedbQueryTableNotFound
const GetStatedbQueryTableNotFoundCode int = 404

/*
GetStatedbQueryTableNotFound Table or Index not found

swagger:response getStatedbQueryTableNotFound
*/
type GetStatedbQueryTableNotFound struct {
}

// NewGetStatedbQueryTableNotFound creates GetStatedbQueryTableNotFound with default headers values
func NewGetStatedbQueryTableNotFound() *GetStatedbQueryTableNotFound {

	return &GetStatedbQueryTableNotFound{}
}

// WriteResponse to the client
func (o *GetStatedbQueryTableNotFound) WriteResponse(rw http.ResponseWriter, producer runtime.Producer) {

	rw.Header().Del(runtime.HeaderContentType) //Remove Content-Type on empty responses

	rw.WriteHeader(404)
}
