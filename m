Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333312DAFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgLOOp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41325 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729573AbgLOOov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WP4MHFK276He1ovS56JmuJGYPtk2hckli9gFlvFjohc=;
        b=Knq5Vg9MvipHnOrywQtKhgFUjfCilYvWjXDukVCtdHuQBwDneRFKL580rj3/nhDmM40+if
        sIY6mfy32bFdc1PkpPxz3kxQiYOJ6WbkNMJArC4rcnYWL1bfpAbDWR0VmS9VUp0AK4gP89
        NBa8wY+G6CAnyHrRtdO+9HDaUV8jlwk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-AljatkeWNeKVMX5Uao2vQA-1; Tue, 15 Dec 2020 09:43:20 -0500
X-MC-Unique: AljatkeWNeKVMX5Uao2vQA-1
Received: by mail-ej1-f72.google.com with SMTP id u25so6092411ejf.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WP4MHFK276He1ovS56JmuJGYPtk2hckli9gFlvFjohc=;
        b=t4/qOjEWRDsVfYbnWGbb9ALHDneYYD3DCVpdNHoTKaL711+plYwosAyejOcSPhvqHd
         fzHm9HS4MjFA2wYRYJ771HiglvInpLBP1evk/KaXbnl3Njx9MwwXvG60Zo3N4aGxZCee
         78/HlM8HVj90pn5L/GHk5CYK2izXfFA9qR+KzRHxKM+/oSUC1Abr4u7OIldkwY0nRkoR
         tarvJchrU7q4S77GMJItCY6T9Y1G94WwylqG2f/ZQKAut44aQwrx/3NweBm78tzbTHPA
         2tFzzaGgp81b1mj1AxGkq1oNNQQ18zm1VQYn+Y6hwx7IwTWUAVXyD1uvJtldWqHJt+47
         jV7g==
X-Gm-Message-State: AOAM531TagH28Cv+PT9q2byw6Z1dTJ5x0O3SmWR9ISq9W/DBFhjHnZV4
        r/pN8mmp0Zi8yH65eVe6uTqa3HF7VyztU3aHgJH+ku8dS3s9jAHXEwF7GUclKTuw9KYIr4ikI3h
        mXIk8qMP+bGgzWwGjYO6+v7rk
X-Received: by 2002:a17:906:3513:: with SMTP id r19mr26782364eja.445.1608043399253;
        Tue, 15 Dec 2020 06:43:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxF3qlIRB3gorLRtSdSEBKbHQHSSunXjraEY9IoJTi+d44zpWNUBzelgCpx16jOAWmwiG5eTQ==
X-Received: by 2002:a17:906:3513:: with SMTP id r19mr26782338eja.445.1608043398925;
        Tue, 15 Dec 2020 06:43:18 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i13sm9295669edu.22.2020.12.15.06.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 06:43:18 -0800 (PST)
Subject: Re: [PATCH v2 5/9] platform/surface: aggregator: Add error injection
 capabilities
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Barnab=c3=a1s_P=c5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
 <20201203212640.663931-6-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e6293b33-163f-87a0-7420-6c3cae40de18@redhat.com>
Date:   Tue, 15 Dec 2020 15:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201203212640.663931-6-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/3/20 10:26 PM, Maximilian Luz wrote:
> This commit adds error injection hooks to the Surface Serial Hub
> communication protocol implementation, to:
> 
>  - simulate simple serial transmission errors,
> 
>  - drop packets, requests, and responses, simulating communication
>    failures and potentially trigger retransmission timeouts, as well as
> 
>  - inject invalid data into submitted and received packets.
> 
> Together with the trace points introduced in the previous commit, these
> facilities are intended to aid in testing, validation, and debugging of
> the Surface Aggregator communication layer.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
> 
> Changes in v1 (from RFC):
>  - remove unnecessary default in Kconfig entry
> 
> Changes in v2:
>  - use dedicated trace event class for data error injection
>  - spell check comments and strings, fix typos
>  - unify comment style
>  - run checkpatch --strict, fix warnings and style issues
> 
> ---
>  drivers/platform/surface/aggregator/Kconfig   |  14 +
>  .../surface/aggregator/ssh_packet_layer.c     | 296 +++++++++++++++++-
>  .../surface/aggregator/ssh_request_layer.c    |  35 +++
>  drivers/platform/surface/aggregator/trace.h   |  31 ++
>  4 files changed, 375 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
> index ce34941ef91b..48f40c345e29 100644
> --- a/drivers/platform/surface/aggregator/Kconfig
> +++ b/drivers/platform/surface/aggregator/Kconfig
> @@ -41,3 +41,17 @@ menuconfig SURFACE_AGGREGATOR
>  	  Choose m if you want to build the SAM subsystem core and SSH driver as
>  	  module, y if you want to build it into the kernel and n if you don't
>  	  want it at all.
> +
> +config SURFACE_AGGREGATOR_ERROR_INJECTION
> +	bool "Surface System Aggregator Module Error Injection Capabilities"
> +	depends on SURFACE_AGGREGATOR
> +	depends on FUNCTION_ERROR_INJECTION
> +	help
> +	  Provides error-injection capabilities for the Surface System
> +	  Aggregator Module subsystem and Surface Serial Hub driver.
> +
> +	  Specifically, exports error injection hooks to be used with the
> +	  kernel's function error injection capabilities to simulate underlying
> +	  transport and communication problems, such as invalid data sent to or
> +	  received from the EC, dropped data, and communication timeouts.
> +	  Intended for development and debugging.
> diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> index f5ec58a1faa2..0205be9380bf 100644
> --- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
> @@ -7,6 +7,7 @@
> 
>  #include <asm/unaligned.h>
>  #include <linux/atomic.h>
> +#include <linux/error-injection.h>
>  #include <linux/jiffies.h>
>  #include <linux/kfifo.h>
>  #include <linux/kref.h>
> @@ -225,6 +226,286 @@
>   */
>  #define SSH_PTL_RX_FIFO_LEN			4096
> 
> +#ifdef CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION
> +
> +/**
> + * ssh_ptl_should_drop_ack_packet() - Error injection hook to drop ACK packets.
> + *
> + * Useful to test detection and handling of automated re-transmits by the EC.
> + * Specifically of packets that the EC considers not-ACKed but the driver
> + * already considers ACKed (due to dropped ACK). In this case, the EC
> + * re-transmits the packet-to-be-ACKed and the driver should detect it as
> + * duplicate/already handled. Note that the driver should still send an ACK
> + * for the re-transmitted packet.
> + */
> +static noinline bool ssh_ptl_should_drop_ack_packet(void)
> +{
> +	return false;
> +}
> +ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_ack_packet, TRUE);
> +
> +/**
> + * ssh_ptl_should_drop_nak_packet() - Error injection hook to drop NAK packets.
> + *
> + * Useful to test/force automated (timeout-based) re-transmit by the EC.
> + * Specifically, packets that have not reached the driver completely/with valid
> + * checksums. Only useful in combination with receival of (injected) bad data.
> + */
> +static noinline bool ssh_ptl_should_drop_nak_packet(void)
> +{
> +	return false;
> +}
> +ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_nak_packet, TRUE);
> +
> +/**
> + * ssh_ptl_should_drop_dsq_packet() - Error injection hook to drop sequenced
> + * data packet.
> + *
> + * Useful to test re-transmit timeout of the driver. If the data packet has not
> + * been ACKed after a certain time, the driver should re-transmit the packet up
> + * to limited number of times defined in SSH_PTL_MAX_PACKET_TRIES.
> + */
> +static noinline bool ssh_ptl_should_drop_dsq_packet(void)
> +{
> +	return false;
> +}
> +ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_dsq_packet, TRUE);
> +
> +/**
> + * ssh_ptl_should_fail_write() - Error injection hook to make
> + * serdev_device_write() fail.
> + *
> + * Hook to simulate errors in serdev_device_write when transmitting packets.
> + */
> +static noinline int ssh_ptl_should_fail_write(void)
> +{
> +	return 0;
> +}
> +ALLOW_ERROR_INJECTION(ssh_ptl_should_fail_write, ERRNO);
> +
> +/**
> + * ssh_ptl_should_corrupt_tx_data() - Error injection hook to simulate invalid
> + * data being sent to the EC.
> + *
> + * Hook to simulate corrupt/invalid data being sent from host (driver) to EC.
> + * Causes the packet data to be actively corrupted by overwriting it with
> + * pre-defined values, such that it becomes invalid, causing the EC to respond
> + * with a NAK packet. Useful to test handling of NAK packets received by the
> + * driver.
> + */
> +static noinline bool ssh_ptl_should_corrupt_tx_data(void)
> +{
> +	return false;
> +}
> +ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_tx_data, TRUE);
> +
> +/**
> + * ssh_ptl_should_corrupt_rx_syn() - Error injection hook to simulate invalid
> + * data being sent by the EC.
> + *
> + * Hook to simulate invalid SYN bytes, i.e. an invalid start of messages and
> + * test handling thereof in the driver.
> + */
> +static noinline bool ssh_ptl_should_corrupt_rx_syn(void)
> +{
> +	return false;
> +}
> +ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_rx_syn, TRUE);
> +
> +/**
> + * ssh_ptl_should_corrupt_rx_data() - Error injection hook to simulate invalid
> + * data being sent by the EC.
> + *
> + * Hook to simulate invalid data/checksum of the message frame and test handling
> + * thereof in the driver.
> + */
> +static noinline bool ssh_ptl_should_corrupt_rx_data(void)
> +{
> +	return false;
> +}
> +ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_rx_data, TRUE);
> +
> +static bool __ssh_ptl_should_drop_ack_packet(struct ssh_packet *packet)
> +{
> +	if (likely(!ssh_ptl_should_drop_ack_packet()))
> +		return false;
> +
> +	trace_ssam_ei_tx_drop_ack_packet(packet);
> +	ptl_info(packet->ptl, "packet error injection: dropping ACK packet %p\n",
> +		 packet);
> +
> +	return true;
> +}
> +
> +static bool __ssh_ptl_should_drop_nak_packet(struct ssh_packet *packet)
> +{
> +	if (likely(!ssh_ptl_should_drop_nak_packet()))
> +		return false;
> +
> +	trace_ssam_ei_tx_drop_nak_packet(packet);
> +	ptl_info(packet->ptl, "packet error injection: dropping NAK packet %p\n",
> +		 packet);
> +
> +	return true;
> +}
> +
> +static bool __ssh_ptl_should_drop_dsq_packet(struct ssh_packet *packet)
> +{
> +	if (likely(!ssh_ptl_should_drop_dsq_packet()))
> +		return false;
> +
> +	trace_ssam_ei_tx_drop_dsq_packet(packet);
> +	ptl_info(packet->ptl,
> +		 "packet error injection: dropping sequenced data packet %p\n",
> +		 packet);
> +
> +	return true;
> +}
> +
> +static bool ssh_ptl_should_drop_packet(struct ssh_packet *packet)
> +{
> +	/* Ignore packets that don't carry any data (i.e. flush). */
> +	if (!packet->data.ptr || !packet->data.len)
> +		return false;
> +
> +	switch (packet->data.ptr[SSH_MSGOFFSET_FRAME(type)]) {
> +	case SSH_FRAME_TYPE_ACK:
> +		return __ssh_ptl_should_drop_ack_packet(packet);
> +
> +	case SSH_FRAME_TYPE_NAK:
> +		return __ssh_ptl_should_drop_nak_packet(packet);
> +
> +	case SSH_FRAME_TYPE_DATA_SEQ:
> +		return __ssh_ptl_should_drop_dsq_packet(packet);
> +
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int ssh_ptl_write_buf(struct ssh_ptl *ptl, struct ssh_packet *packet,
> +			     const unsigned char *buf, size_t count)
> +{
> +	int status;
> +
> +	status = ssh_ptl_should_fail_write();
> +	if (unlikely(status)) {
> +		trace_ssam_ei_tx_fail_write(packet, status);
> +		ptl_info(packet->ptl,
> +			 "packet error injection: simulating transmit error %d, packet %p\n",
> +			 status, packet);
> +
> +		return status;
> +	}
> +
> +	return serdev_device_write_buf(ptl->serdev, buf, count);
> +}
> +
> +static void ssh_ptl_tx_inject_invalid_data(struct ssh_packet *packet)
> +{
> +	/* Ignore packets that don't carry any data (i.e. flush). */
> +	if (!packet->data.ptr || !packet->data.len)
> +		return;
> +
> +	/* Only allow sequenced data packets to be modified. */
> +	if (packet->data.ptr[SSH_MSGOFFSET_FRAME(type)] != SSH_FRAME_TYPE_DATA_SEQ)
> +		return;
> +
> +	if (likely(!ssh_ptl_should_corrupt_tx_data()))
> +		return;
> +
> +	trace_ssam_ei_tx_corrupt_data(packet);
> +	ptl_info(packet->ptl,
> +		 "packet error injection: simulating invalid transmit data on packet %p\n",
> +		 packet);
> +
> +	/*
> +	 * NB: The value 0xb3 has been chosen more or less randomly so that it
> +	 * doesn't have any (major) overlap with the SYN bytes (aa 55) and is
> +	 * non-trivial (i.e. non-zero, non-0xff).
> +	 */
> +	memset(packet->data.ptr, 0xb3, packet->data.len);
> +}
> +
> +static void ssh_ptl_rx_inject_invalid_syn(struct ssh_ptl *ptl,
> +					  struct ssam_span *data)
> +{
> +	struct ssam_span frame;
> +
> +	/* Check if there actually is something to corrupt. */
> +	if (!sshp_find_syn(data, &frame))
> +		return;
> +
> +	if (likely(!ssh_ptl_should_corrupt_rx_syn()))
> +		return;
> +
> +	trace_ssam_ei_rx_corrupt_syn(data->len);
> +
> +	data->ptr[1] = 0xb3;	/* Set second byte of SYN to "random" value. */
> +}
> +
> +static void ssh_ptl_rx_inject_invalid_data(struct ssh_ptl *ptl,
> +					   struct ssam_span *frame)
> +{
> +	size_t payload_len, message_len;
> +	struct ssh_frame *sshf;
> +
> +	/* Ignore incomplete messages, will get handled once it's complete. */
> +	if (frame->len < SSH_MESSAGE_LENGTH(0))
> +		return;
> +
> +	/* Ignore incomplete messages, part 2. */
> +	payload_len = get_unaligned_le16(&frame->ptr[SSH_MSGOFFSET_FRAME(len)]);
> +	message_len = SSH_MESSAGE_LENGTH(payload_len);
> +	if (frame->len < message_len)
> +		return;
> +
> +	if (likely(!ssh_ptl_should_corrupt_rx_data()))
> +		return;
> +
> +	sshf = (struct ssh_frame *)&frame->ptr[SSH_MSGOFFSET_FRAME(type)];
> +	trace_ssam_ei_rx_corrupt_data(sshf);
> +
> +	/*
> +	 * Flip bits in first byte of payload checksum. This is basically
> +	 * equivalent to a payload/frame data error without us having to worry
> +	 * about (the, arguably pretty small, probability of) accidental
> +	 * checksum collisions.
> +	 */
> +	frame->ptr[frame->len - 2] = ~frame->ptr[frame->len - 2];
> +}
> +
> +#else /* CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION */
> +
> +static inline bool ssh_ptl_should_drop_packet(struct ssh_packet *packet)
> +{
> +	return false;
> +}
> +
> +static inline int ssh_ptl_write_buf(struct ssh_ptl *ptl,
> +				    struct ssh_packet *packet,
> +				    const unsigned char *buf,
> +				    size_t count)
> +{
> +	return serdev_device_write_buf(ptl->serdev, buf, count);
> +}
> +
> +static inline void ssh_ptl_tx_inject_invalid_data(struct ssh_packet *packet)
> +{
> +}
> +
> +static inline void ssh_ptl_rx_inject_invalid_syn(struct ssh_ptl *ptl,
> +						 struct ssam_span *data)
> +{
> +}
> +
> +static inline void ssh_ptl_rx_inject_invalid_data(struct ssh_ptl *ptl,
> +						  struct ssam_span *frame)
> +{
> +}
> +
> +#endif /* CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION */
> +
>  static void __ssh_ptl_packet_release(struct kref *kref)
>  {
>  	struct ssh_packet *p = container_of(kref, struct ssh_packet, refcnt);
> @@ -769,6 +1050,13 @@ static int ssh_ptl_tx_packet(struct ssh_ptl *ptl, struct ssh_packet *packet)
>  	if (unlikely(!packet->data.ptr))
>  		return 0;
> 
> +	/* Error injection: drop packet to simulate transmission problem. */
> +	if (ssh_ptl_should_drop_packet(packet))
> +		return 0;
> +
> +	/* Error injection: simulate invalid packet data. */
> +	ssh_ptl_tx_inject_invalid_data(packet);
> +
>  	ptl_dbg(ptl, "tx: sending data (length: %zu)\n", packet->data.len);
>  	print_hex_dump_debug("tx: ", DUMP_PREFIX_OFFSET, 16, 1,
>  			     packet->data.ptr, packet->data.len, false);
> @@ -780,7 +1068,7 @@ static int ssh_ptl_tx_packet(struct ssh_ptl *ptl, struct ssh_packet *packet)
>  		buf = packet->data.ptr + offset;
>  		len = packet->data.len - offset;
> 
> -		status = serdev_device_write_buf(ptl->serdev, buf, len);
> +		status = ssh_ptl_write_buf(ptl, packet, buf, len);
>  		if (status < 0)
>  			return status;
> 
> @@ -1389,6 +1677,9 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
>  	bool syn_found;
>  	int status;
> 
> +	/* Error injection: Modify data to simulate corrupt SYN bytes. */
> +	ssh_ptl_rx_inject_invalid_syn(ptl, source);
> +
>  	/* Find SYN. */
>  	syn_found = sshp_find_syn(source, &aligned);
> 
> @@ -1419,6 +1710,9 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
>  	if (unlikely(!syn_found))
>  		return aligned.ptr - source->ptr;
> 
> +	/* Error injection: Modify data to simulate corruption. */
> +	ssh_ptl_rx_inject_invalid_data(ptl, &aligned);
> +
>  	/* Parse and validate frame. */
>  	status = sshp_parse_frame(&ptl->serdev->dev, &aligned, &frame, &payload,
>  				  SSH_PTL_RX_BUF_LEN);
> diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
> index e91d2ed4c173..bf1782c85063 100644
> --- a/drivers/platform/surface/aggregator/ssh_request_layer.c
> +++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
> @@ -8,6 +8,7 @@
>  #include <asm/unaligned.h>
>  #include <linux/atomic.h>
>  #include <linux/completion.h>
> +#include <linux/error-injection.h>
>  #include <linux/ktime.h>
>  #include <linux/limits.h>
>  #include <linux/list.h>
> @@ -58,6 +59,30 @@
>   */
>  #define SSH_RTL_TX_BATCH		10
> 
> +#ifdef CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION
> +
> +/**
> + * ssh_rtl_should_drop_response() - Error injection hook to drop request
> + * responses.
> + *
> + * Useful to cause request transmission timeouts in the driver by dropping the
> + * response to a request.
> + */
> +static noinline bool ssh_rtl_should_drop_response(void)
> +{
> +	return false;
> +}
> +ALLOW_ERROR_INJECTION(ssh_rtl_should_drop_response, TRUE);
> +
> +#else
> +
> +static inline bool ssh_rtl_should_drop_response(void)
> +{
> +	return false;
> +}
> +
> +#endif
> +
>  static u16 ssh_request_get_rqid(struct ssh_request *rqst)
>  {
>  	return get_unaligned_le16(rqst->packet.data.ptr
> @@ -459,6 +484,16 @@ static void ssh_rtl_complete(struct ssh_rtl *rtl,
>  		if (unlikely(ssh_request_get_rqid(p) != rqid))
>  			continue;
> 
> +		/* Simulate response timeout. */
> +		if (ssh_rtl_should_drop_response()) {
> +			spin_unlock(&rtl->pending.lock);
> +
> +			trace_ssam_ei_rx_drop_response(p);
> +			rtl_info(rtl, "request error injection: dropping response for request %p\n",
> +				 &p->packet);
> +			return;
> +		}
> +
>  		/*
>  		 * Mark as "response received" and "locked" as we're going to
>  		 * complete it.
> diff --git a/drivers/platform/surface/aggregator/trace.h b/drivers/platform/surface/aggregator/trace.h
> index dcca8007d876..eb332bb53ae4 100644
> --- a/drivers/platform/surface/aggregator/trace.h
> +++ b/drivers/platform/surface/aggregator/trace.h
> @@ -565,6 +565,28 @@ DECLARE_EVENT_CLASS(ssam_pending_class,
>  		TP_ARGS(pending)					\
>  	)
> 
> +DECLARE_EVENT_CLASS(ssam_data_class,
> +	TP_PROTO(size_t length),
> +
> +	TP_ARGS(length),
> +
> +	TP_STRUCT__entry(
> +		__field(size_t, length)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->length = length;
> +	),
> +
> +	TP_printk("length=%zu", __entry->length)
> +);
> +
> +#define DEFINE_SSAM_DATA_EVENT(name)					\
> +	DEFINE_EVENT(ssam_data_class, ssam_##name,			\
> +		TP_PROTO(size_t length),				\
> +		TP_ARGS(length)						\
> +	)
> +
>  DEFINE_SSAM_FRAME_EVENT(rx_frame_received);
>  DEFINE_SSAM_COMMAND_EVENT(rx_response_received);
>  DEFINE_SSAM_COMMAND_EVENT(rx_event_received);
> @@ -583,6 +605,15 @@ DEFINE_SSAM_REQUEST_EVENT(request_cancel);
>  DEFINE_SSAM_REQUEST_STATUS_EVENT(request_complete);
>  DEFINE_SSAM_PENDING_EVENT(rtl_timeout_reap);
> 
> +DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_ack_packet);
> +DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_nak_packet);
> +DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_dsq_packet);
> +DEFINE_SSAM_PACKET_STATUS_EVENT(ei_tx_fail_write);
> +DEFINE_SSAM_PACKET_EVENT(ei_tx_corrupt_data);
> +DEFINE_SSAM_DATA_EVENT(ei_rx_corrupt_syn);
> +DEFINE_SSAM_FRAME_EVENT(ei_rx_corrupt_data);
> +DEFINE_SSAM_REQUEST_EVENT(ei_rx_drop_response);
> +
>  DEFINE_SSAM_ALLOC_EVENT(ctrl_packet_alloc);
>  DEFINE_SSAM_FREE_EVENT(ctrl_packet_free);
> 
> --
> 2.29.2
> 

