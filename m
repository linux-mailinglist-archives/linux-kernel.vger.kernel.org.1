Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955AB2B6A87
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgKQQoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgKQQoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:44:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7870C221F9;
        Tue, 17 Nov 2020 16:44:13 +0000 (UTC)
Date:   Tue, 17 Nov 2020 11:44:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 4/9] platform/surface: aggregator: Add trace points
Message-ID: <20201117114411.30af7078@gandalf.local.home>
In-Reply-To: <20201115192143.21571-5-luzmaximilian@gmail.com>
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
        <20201115192143.21571-5-luzmaximilian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Nov 2020 20:21:38 +0100
Maximilian Luz <luzmaximilian@gmail.com> wrote:

> Add trace points to the Surface Aggregator subsystem core. These trace
> points can be used to track packets, requests, and allocations. They are
> further intended for debugging and testing/validation, specifically in
> combination with the error injection capabilities introduced in the
> subsequent commit.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> ---


>  	/*
>  	 * Lock packet and commit with memory barrier. If this packet has
>  	 * already been locked, it's going to be removed and completed by
> @@ -1154,6 +1167,8 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
>  	ktime_t next = KTIME_MAX;
>  	bool resub = false;
>  
> +	trace_ssam_ptl_timeout_reap("pending", atomic_read(&ptl->pending.count));

I noticed that the only two places that use timeout_reap, both have
"pending" as a string. Is this necessary to save? Would an enum work?


> +
>  	/*
>  	 * Mark reaper as "not pending". This is done before checking any
>  	 * packets to avoid lost-update type problems.
> @@ -1185,6 +1200,8 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
>  		// check if we still have some tries left
>  		try = ssh_packet_priority_get_try(READ_ONCE(p->priority));
>  		if (likely(try < SSH_PTL_MAX_PACKET_TRIES)) {
> +			trace_ssam_packet_timeout(p);
> +
>  			/*
>  			 * Submission fails if the packet has been locked, is
>  			 * already queued, or the layer is being shut down.
> @@ -1202,6 +1219,8 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
>  		if (test_and_set_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state))
>  			continue;
>  
> +		trace_ssam_packet_timeout(p);
> +
>  		/*
>  		 * We have now marked the packet as locked. Thus it cannot be
>  		 * added to the pending list again after we've removed it here.
> @@ -1366,6 +1385,8 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
>  	if (!frame)	// not enough data
>  		return aligned.ptr - source->ptr;
>  
> +	trace_ssam_rx_frame_received(frame);
> +
>  	switch (frame->type) {
>  	case SSH_FRAME_TYPE_ACK:
>  		ssh_ptl_acknowledge(ptl, frame->seq);
> diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
> index 2b0368bb2d79..0d3384fd2d4c 100644
> --- a/drivers/platform/surface/aggregator/ssh_request_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
> @@ -21,6 +21,8 @@
>  #include "ssh_packet_layer.h"
>  #include "ssh_request_layer.h"
>  
> +#include "trace.h"
> +
>  
>  /*
>   * SSH_RTL_REQUEST_TIMEOUT - Request timeout.
> @@ -141,6 +143,8 @@ static void ssh_rtl_complete_with_status(struct ssh_request *rqst, int status)
>  {
>  	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
>  
> +	trace_ssam_request_complete(rqst, status);
> +
>  	// rtl/ptl may not be set if we're cancelling before submitting
>  	rtl_dbg_cond(rtl, "rtl: completing request (rqid: 0x%04x, status: %d)\n",
>  		     ssh_request_get_rqid_safe(rqst), status);
> @@ -154,6 +158,8 @@ static void ssh_rtl_complete_with_rsp(struct ssh_request *rqst,
>  {
>  	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
>  
> +	trace_ssam_request_complete(rqst, 0);
> +
>  	rtl_dbg(rtl, "rtl: completing request with response (rqid: 0x%04x)\n",
>  		ssh_request_get_rqid(rqst));
>  
> @@ -326,6 +332,8 @@ static void ssh_rtl_tx_work_fn(struct work_struct *work)
>   */
>  int ssh_rtl_submit(struct ssh_rtl *rtl, struct ssh_request *rqst)
>  {
> +	trace_ssam_request_submit(rqst);
> +
>  	/*
>  	 * Ensure that requests expecting a response are sequenced. If this
>  	 * invariant ever changes, see the comment in ssh_rtl_complete() on what
> @@ -438,6 +446,8 @@ static void ssh_rtl_complete(struct ssh_rtl *rtl,
>  	struct ssh_request *p, *n;
>  	u16 rqid = get_unaligned_le16(&command->rqid);
>  
> +	trace_ssam_rx_response_received(command, command_data->len);
> +
>  	/*
>  	 * Get request from pending based on request ID and mark it as response
>  	 * received and locked.
> @@ -688,6 +698,8 @@ bool ssh_rtl_cancel(struct ssh_request *rqst, bool pending)
>  	if (test_and_set_bit(SSH_REQUEST_SF_CANCELED_BIT, &rqst->state))
>  		return true;
>  
> +	trace_ssam_request_cancel(rqst);
> +
>  	if (pending)
>  		canceled = ssh_rtl_cancel_pending(rqst);
>  	else
> @@ -777,6 +789,8 @@ static void ssh_rtl_timeout_reap(struct work_struct *work)
>  	ktime_t timeout = rtl->rtx_timeout.timeout;
>  	ktime_t next = KTIME_MAX;
>  
> +	trace_ssam_rtl_timeout_reap("pending", atomic_read(&rtl->pending.count));
> +
>  	/*
>  	 * Mark reaper as "not pending". This is done before checking any
>  	 * requests to avoid lost-update type problems.
> @@ -825,6 +839,8 @@ static void ssh_rtl_timeout_reap(struct work_struct *work)
>  
>  	// cancel and complete the request
>  	list_for_each_entry_safe(r, n, &claimed, node) {
> +		trace_ssam_request_timeout(r);
> +
>  		/*
>  		 * At this point we've removed the packet from pending. This
>  		 * means that we've obtained the last (only) reference of the
> @@ -850,6 +866,8 @@ static void ssh_rtl_timeout_reap(struct work_struct *work)
>  static void ssh_rtl_rx_event(struct ssh_rtl *rtl, const struct ssh_command *cmd,
>  			     const struct ssam_span *data)
>  {
> +	trace_ssam_rx_event_received(cmd, data->len);
> +
>  	rtl_dbg(rtl, "rtl: handling event (rqid: 0x%04x)\n",
>  		get_unaligned_le16(&cmd->rqid));
>  
> diff --git a/drivers/platform/surface/aggregator/trace.h b/drivers/platform/surface/aggregator/trace.h
> new file mode 100644
> index 000000000000..ead052c1ffab
> --- /dev/null
> +++ b/drivers/platform/surface/aggregator/trace.h
> @@ -0,0 +1,616 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Trace points for SSAM/SSH.
> + *
> + * Copyright (C) 2020 Maximilian Luz <luzmaximilian@gmail.com>
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM surface_aggregator
> +
> +#if !defined(_SURFACE_AGGREGATOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _SURFACE_AGGREGATOR_TRACE_H
> +
> +#include <linux/surface_aggregator/serial_hub.h>
> +
> +#include <asm/unaligned.h>
> +#include <linux/tracepoint.h>
> +
> +
> +TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_DATA_SEQ);
> +TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_DATA_NSQ);
> +TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_ACK);
> +TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_NAK);
> +
> +TRACE_DEFINE_ENUM(SSH_PACKET_SF_LOCKED_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_SF_QUEUED_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_SF_PENDING_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_SF_TRANSMITTING_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_SF_TRANSMITTED_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_SF_ACKED_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_SF_CANCELED_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_SF_COMPLETED_BIT);
> +
> +TRACE_DEFINE_ENUM(SSH_PACKET_TY_FLUSH_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_TY_SEQUENCED_BIT);
> +TRACE_DEFINE_ENUM(SSH_PACKET_TY_BLOCKING_BIT);
> +
> +TRACE_DEFINE_ENUM(SSH_PACKET_FLAGS_SF_MASK);
> +TRACE_DEFINE_ENUM(SSH_PACKET_FLAGS_TY_MASK);
> +
> +TRACE_DEFINE_ENUM(SSH_REQUEST_SF_LOCKED_BIT);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_SF_QUEUED_BIT);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_SF_PENDING_BIT);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_SF_TRANSMITTING_BIT);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_SF_TRANSMITTED_BIT);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_SF_RSPRCVD_BIT);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_SF_CANCELED_BIT);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_SF_COMPLETED_BIT);
> +
> +TRACE_DEFINE_ENUM(SSH_REQUEST_TY_FLUSH_BIT);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_TY_HAS_RESPONSE_BIT);
> +
> +TRACE_DEFINE_ENUM(SSH_REQUEST_FLAGS_SF_MASK);
> +TRACE_DEFINE_ENUM(SSH_REQUEST_FLAGS_TY_MASK);
> +
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_SAM);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_BAT);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_TMP);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_PMC);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_FAN);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_PoM);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_DBG);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_KBD);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_FWU);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_UNI);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_LPC);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_TCL);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_SFL);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_KIP);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_EXT);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_BLD);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_BAS);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_SEN);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_SRQ);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_MCU);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_HID);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_TCH);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_BKL);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_TAM);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_ACC);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_UFI);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_USC);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_PEN);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_VID);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_AUD);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_SMC);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_KPD);
> +TRACE_DEFINE_ENUM(SSAM_SSH_TC_REG);
> +
> +
> +#define SSAM_PTR_UID_LEN		9
> +#define SSAM_U8_FIELD_NOT_APPLICABLE	((u16)-1)
> +#define SSAM_SEQ_NOT_APPLICABLE		((u16)-1)
> +#define SSAM_RQID_NOT_APPLICABLE	((u32)-1)
> +#define SSAM_SSH_TC_NOT_APPLICABLE	0
> +
> +
> +#ifndef _SURFACE_AGGREGATOR_TRACE_HELPERS
> +#define _SURFACE_AGGREGATOR_TRACE_HELPERS
> +
> +/**
> + * ssam_trace_ptr_uid() - Convert the pointer to a non-pointer UID string.
> + * @ptr: The pointer to convert.
> + * @uid_str: A buffer of length SSAM_PTR_UID_LEN where the UID will be stored.
> + *
> + * Converts the given pointer into a UID string that is safe to be shared
> + * with userspace and logs, i.e. doesn't give away the real memory location.
> + */
> +static inline void ssam_trace_ptr_uid(const void *ptr, char *uid_str)
> +{
> +	char buf[2 * sizeof(void *) + 1];
> +
> +	snprintf(buf, ARRAY_SIZE(buf), "%p", ptr);
> +	memcpy(uid_str, &buf[ARRAY_SIZE(buf) - SSAM_PTR_UID_LEN],
> +	       SSAM_PTR_UID_LEN);

Is the above snprintf() to have the ptr turn into a hash?

Otherwise, couldn't you just truncate the value of ptr?

In any case, you want to make sure that ARRAY_SIZE(buf) is always bigger
than, or equal to, SSAM_PTR_UID_LEN, and you should probably stick a:

	BUILD_BUG_ON(ARRAY_SIZE(buf) < SSAM_PTR_UID_LEN);

in there, which would cause the build to fail if that was ever the case.

> +}
> +
> +/**
> + * ssam_trace_get_packet_seq() - Read the packet's sequence ID.
> + * @p: The packet.
> + *
> + * Return: Returns the packet's sequence ID (SEQ) field if present, or
> + * %SSAM_SEQ_NOT_APPLICABLE if not (e.g. flush packet).
> + */
> +static inline u16 ssam_trace_get_packet_seq(const struct ssh_packet *p)
> +{
> +	if (!p->data.ptr || p->data.len < SSH_MESSAGE_LENGTH(0))
> +		return SSAM_SEQ_NOT_APPLICABLE;
> +
> +	return p->data.ptr[SSH_MSGOFFSET_FRAME(seq)];
> +}
> +
> +/**
> + * ssam_trace_get_request_id() - Read the packet's request ID.
> + * @p: The packet.
> + *
> + * Return: Returns the packet's request ID (RQID) field if the packet
> + * represents a request with command data, or %SSAM_RQID_NOT_APPLICABLE if not
> + * (e.g. flush request, control packet).
> + */
> +static inline u32 ssam_trace_get_request_id(const struct ssh_packet *p)
> +{
> +	if (!p->data.ptr || p->data.len < SSH_COMMAND_MESSAGE_LENGTH(0))
> +		return SSAM_RQID_NOT_APPLICABLE;
> +
> +	return get_unaligned_le16(&p->data.ptr[SSH_MSGOFFSET_COMMAND(rqid)]);
> +}
> +
> +/**
> + * ssam_trace_get_request_tc() - Read the packet's request target category.
> + * @p: The packet.
> + *
> + * Return: Returns the packet's request target category (TC) field if the
> + * packet represents a request with command data, or %SSAM_TC_NOT_APPLICABLE
> + * if not (e.g. flush request, control packet).
> + */
> +static inline u32 ssam_trace_get_request_tc(const struct ssh_packet *p)
> +{
> +	if (!p->data.ptr || p->data.len < SSH_COMMAND_MESSAGE_LENGTH(0))
> +		return SSAM_SSH_TC_NOT_APPLICABLE;
> +
> +	return get_unaligned_le16(&p->data.ptr[SSH_MSGOFFSET_COMMAND(tc)]);
> +}
> +
> +#endif /* _SURFACE_AGGREGATOR_TRACE_HELPERS */
> +
> +#define ssam_trace_get_command_field_u8(packet, field) \
> +	((!packet || packet->data.len < SSH_COMMAND_MESSAGE_LENGTH(0)) \
> +	 ? 0 : p->data.ptr[SSH_MSGOFFSET_COMMAND(field)])

I think you want the above to be:

	? 0 : packet->data.ptr[SSH_MSGOFFSET_COMMAND(field)])

The only reason it worked, is because the caller passed in "p".

> +
> +#define ssam_show_generic_u8_field(value)				\
> +	__print_symbolic(value,						\
> +		{ SSAM_U8_FIELD_NOT_APPLICABLE,		"N/A" }		\
> +	)
> +
> +
> +#define ssam_show_frame_type(ty)					\
> +	__print_symbolic(ty,						\
> +		{ SSH_FRAME_TYPE_DATA_SEQ,		"DSEQ" },	\
> +		{ SSH_FRAME_TYPE_DATA_NSQ,		"DNSQ" },	\
> +		{ SSH_FRAME_TYPE_ACK,			"ACK"  },	\
> +		{ SSH_FRAME_TYPE_NAK,			"NAK"  }	\
> +	)
> +
> +#define ssam_show_packet_type(type)					\
> +	__print_flags(flags & SSH_PACKET_FLAGS_TY_MASK, "",		\
> +		{ BIT(SSH_PACKET_TY_FLUSH_BIT),		"F" },		\
> +		{ BIT(SSH_PACKET_TY_SEQUENCED_BIT),	"S" },		\
> +		{ BIT(SSH_PACKET_TY_BLOCKING_BIT),	"B" }		\
> +	)
> +
> +#define ssam_show_packet_state(state)					\
> +	__print_flags(flags & SSH_PACKET_FLAGS_SF_MASK, "",		\
> +		{ BIT(SSH_PACKET_SF_LOCKED_BIT),	"L" },		\
> +		{ BIT(SSH_PACKET_SF_QUEUED_BIT),	"Q" },		\
> +		{ BIT(SSH_PACKET_SF_PENDING_BIT),	"P" },		\
> +		{ BIT(SSH_PACKET_SF_TRANSMITTING_BIT),	"S" },		\
> +		{ BIT(SSH_PACKET_SF_TRANSMITTED_BIT),	"T" },		\
> +		{ BIT(SSH_PACKET_SF_ACKED_BIT),		"A" },		\
> +		{ BIT(SSH_PACKET_SF_CANCELED_BIT),	"C" },		\
> +		{ BIT(SSH_PACKET_SF_COMPLETED_BIT),	"F" }		\
> +	)
> +
> +#define ssam_show_packet_seq(seq)					\
> +	__print_symbolic(seq,						\
> +		{ SSAM_SEQ_NOT_APPLICABLE,		"N/A" }		\
> +	)
> +
> +
> +#define ssam_show_request_type(flags)					\
> +	__print_flags(flags & SSH_REQUEST_FLAGS_TY_MASK, "",		\
> +		{ BIT(SSH_REQUEST_TY_FLUSH_BIT),	"F" },		\
> +		{ BIT(SSH_REQUEST_TY_HAS_RESPONSE_BIT),	"R" }		\
> +	)
> +
> +#define ssam_show_request_state(flags)					\
> +	__print_flags(flags & SSH_REQUEST_FLAGS_SF_MASK, "",		\
> +		{ BIT(SSH_REQUEST_SF_LOCKED_BIT),	"L" },		\
> +		{ BIT(SSH_REQUEST_SF_QUEUED_BIT),	"Q" },		\
> +		{ BIT(SSH_REQUEST_SF_PENDING_BIT),	"P" },		\
> +		{ BIT(SSH_REQUEST_SF_TRANSMITTING_BIT),	"S" },		\
> +		{ BIT(SSH_REQUEST_SF_TRANSMITTED_BIT),	"T" },		\
> +		{ BIT(SSH_REQUEST_SF_RSPRCVD_BIT),	"A" },		\
> +		{ BIT(SSH_REQUEST_SF_CANCELED_BIT),	"C" },		\
> +		{ BIT(SSH_REQUEST_SF_COMPLETED_BIT),	"F" }		\
> +	)
> +
> +#define ssam_show_request_id(rqid)					\
> +	__print_symbolic(rqid,						\
> +		{ SSAM_RQID_NOT_APPLICABLE,		"N/A" }		\
> +	)
> +
> +#define ssam_show_ssh_tc(rqid)						\
> +	__print_symbolic(rqid,						\
> +		{ SSAM_SSH_TC_NOT_APPLICABLE,		"N/A" },	\
> +		{ SSAM_SSH_TC_SAM,			"SAM" },	\
> +		{ SSAM_SSH_TC_BAT,			"BAT" },	\
> +		{ SSAM_SSH_TC_TMP,			"TMP" },	\
> +		{ SSAM_SSH_TC_PMC,			"PMC" },	\
> +		{ SSAM_SSH_TC_FAN,			"FAN" },	\
> +		{ SSAM_SSH_TC_PoM,			"PoM" },	\
> +		{ SSAM_SSH_TC_DBG,			"DBG" },	\
> +		{ SSAM_SSH_TC_KBD,			"KBD" },	\
> +		{ SSAM_SSH_TC_FWU,			"FWU" },	\
> +		{ SSAM_SSH_TC_UNI,			"UNI" },	\
> +		{ SSAM_SSH_TC_LPC,			"LPC" },	\
> +		{ SSAM_SSH_TC_TCL,			"TCL" },	\
> +		{ SSAM_SSH_TC_SFL,			"SFL" },	\
> +		{ SSAM_SSH_TC_KIP,			"KIP" },	\
> +		{ SSAM_SSH_TC_EXT,			"EXT" },	\
> +		{ SSAM_SSH_TC_BLD,			"BLD" },	\
> +		{ SSAM_SSH_TC_BAS,			"BAS" },	\
> +		{ SSAM_SSH_TC_SEN,			"SEN" },	\
> +		{ SSAM_SSH_TC_SRQ,			"SRQ" },	\
> +		{ SSAM_SSH_TC_MCU,			"MCU" },	\
> +		{ SSAM_SSH_TC_HID,			"HID" },	\
> +		{ SSAM_SSH_TC_TCH,			"TCH" },	\
> +		{ SSAM_SSH_TC_BKL,			"BKL" },	\
> +		{ SSAM_SSH_TC_TAM,			"TAM" },	\
> +		{ SSAM_SSH_TC_ACC,			"ACC" },	\
> +		{ SSAM_SSH_TC_UFI,			"UFI" },	\
> +		{ SSAM_SSH_TC_USC,			"USC" },	\
> +		{ SSAM_SSH_TC_PEN,			"PEN" },	\
> +		{ SSAM_SSH_TC_VID,			"VID" },	\
> +		{ SSAM_SSH_TC_AUD,			"AUD" },	\
> +		{ SSAM_SSH_TC_SMC,			"SMC" },	\
> +		{ SSAM_SSH_TC_KPD,			"KPD" },	\
> +		{ SSAM_SSH_TC_REG,			"REG" }		\
> +	)
> +
> +
> +DECLARE_EVENT_CLASS(ssam_frame_class,
> +	TP_PROTO(const struct ssh_frame *frame),
> +
> +	TP_ARGS(frame),
> +
> +	TP_STRUCT__entry(
> +		__field(u8, type)
> +		__field(u8, seq)
> +		__field(u16, len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->type = frame->type;
> +		__entry->seq = frame->seq;
> +		__entry->len = get_unaligned_le16(&frame->len);
> +	),
> +
> +	TP_printk("ty=%s, seq=0x%02x, len=%u",
> +		ssam_show_frame_type(__entry->type),
> +		__entry->seq,
> +		__entry->len
> +	)
> +);
> +
> +#define DEFINE_SSAM_FRAME_EVENT(name)				\
> +	DEFINE_EVENT(ssam_frame_class, ssam_##name,		\
> +		TP_PROTO(const struct ssh_frame *frame),	\
> +		TP_ARGS(frame)					\
> +	)
> +
> +
> +DECLARE_EVENT_CLASS(ssam_command_class,
> +	TP_PROTO(const struct ssh_command *cmd, u16 len),
> +
> +	TP_ARGS(cmd, len),
> +
> +	TP_STRUCT__entry(
> +		__field(u16, rqid)
> +		__field(u16, len)
> +		__field(u8, tc)
> +		__field(u8, cid)
> +		__field(u8, iid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->rqid = get_unaligned_le16(&cmd->rqid);
> +		__entry->tc = cmd->tc;
> +		__entry->cid = cmd->cid;
> +		__entry->iid = cmd->iid;
> +		__entry->len = len;
> +	),
> +
> +	TP_printk("rqid=0x%04x, tc=%s, cid=0x%02x, iid=0x%02x, len=%u",
> +		__entry->rqid,
> +		ssam_show_ssh_tc(__entry->tc),
> +		__entry->cid,
> +		__entry->iid,
> +		__entry->len
> +	)
> +);
> +
> +#define DEFINE_SSAM_COMMAND_EVENT(name)					\
> +	DEFINE_EVENT(ssam_command_class, ssam_##name,			\
> +		TP_PROTO(const struct ssh_command *cmd, u16 len),	\
> +		TP_ARGS(cmd, len)					\
> +	)
> +
> +
> +DECLARE_EVENT_CLASS(ssam_packet_class,
> +	TP_PROTO(const struct ssh_packet *packet),
> +
> +	TP_ARGS(packet),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, state)
> +		__array(char, uid, SSAM_PTR_UID_LEN)
> +		__field(u8, priority)
> +		__field(u16, length)
> +		__field(u16, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->state = READ_ONCE(packet->state);
> +		ssam_trace_ptr_uid(packet, __entry->uid);
> +		__entry->priority = READ_ONCE(packet->priority);

I'm curious about the need for the read once here.

The rest seems fine.

-- Steve

> +		__entry->length = packet->data.len;
> +		__entry->seq = ssam_trace_get_packet_seq(packet);
> +	),
> +
> +	TP_printk("uid=%s, seq=%s, ty=%s, pri=0x%02x, len=%u, sta=%s",
> +		__entry->uid,
> +		ssam_show_packet_seq(__entry->seq),
> +		ssam_show_packet_type(__entry->state),
> +		__entry->priority,
> +		__entry->length,
> +		ssam_show_packet_state(__entry->state)
> +	)
> +);
> +
> +#define DEFINE_SSAM_PACKET_EVENT(name)				\
> +	DEFINE_EVENT(ssam_packet_class, ssam_##name,		\
> +		TP_PROTO(const struct ssh_packet *packet),	\
> +		TP_ARGS(packet)					\
> +	)
> +
> +
> +DECLARE_EVENT_CLASS(ssam_packet_status_class,
> +	TP_PROTO(const struct ssh_packet *packet, int status),
> +
> +	TP_ARGS(packet, status),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, state)
> +		__field(int, status)
> +		__array(char, uid, SSAM_PTR_UID_LEN)
> +		__field(u8, priority)
> +		__field(u16, length)
> +		__field(u16, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->state = READ_ONCE(packet->state);
> +		__entry->status = status;
> +		ssam_trace_ptr_uid(packet, __entry->uid);
> +		__entry->priority = READ_ONCE(packet->priority);
> +		__entry->length = packet->data.len;
> +		__entry->seq = ssam_trace_get_packet_seq(packet);
> +	),
> +
> +	TP_printk("uid=%s, seq=%s, ty=%s, pri=0x%02x, len=%u, sta=%s, status=%d",
> +		__entry->uid,
> +		ssam_show_packet_seq(__entry->seq),
> +		ssam_show_packet_type(__entry->state),
> +		__entry->priority,
> +		__entry->length,
> +		ssam_show_packet_state(__entry->state),
> +		__entry->status
> +	)
> +);
> +
> +#define DEFINE_SSAM_PACKET_STATUS_EVENT(name)				\
> +	DEFINE_EVENT(ssam_packet_status_class, ssam_##name,		\
> +		TP_PROTO(const struct ssh_packet *packet, int status),	\
> +		TP_ARGS(packet, status)					\
> +	)
> +
> +
