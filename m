Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0A2E001D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgLUSlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgLUSlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:41:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43444C0611C5;
        Mon, 21 Dec 2020 10:40:24 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i9so12109842wrc.4;
        Mon, 21 Dec 2020 10:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5LTkRUuHTKbBAPM+io0b63ZxV7hHDlZwLOntBQAj7TY=;
        b=fSRoj+2gVQLSDl2woTCXCynsOGRfc2IvMzWkqBlW4Vccy3Yc6vFK5ByHX8b/V7dHes
         rXwKJAoQyHYfK3iZeWzdrxUW3sAzaFQ4ZG37c3ciS4VvRT18e/a7yPIRkqrwBv69fIM+
         t8za7rAK//HfNl/+IO7mEgcFJcwPTS66G05cMcV4pbI5zILDfowInbhVgT+483oB89VH
         UWSnVSGi9E46nmy+b/qY0a0EPb8qu7Sx9t0syI5u0cnfvbukkjPATBmbxy8w5ygpasAP
         BWWwJfWIBU1ocytpi2uI8DzDL+pJoHt+CxzZ52QujueEfHk3SfA+QU1mwilRdaFnPiaA
         1bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5LTkRUuHTKbBAPM+io0b63ZxV7hHDlZwLOntBQAj7TY=;
        b=rBNIJAjOV2mzUdIVo/xPbkimmEm9T98qe5ACES2B7jeED8kWUpqrUGxyfBR20prr7w
         cgtJyW6iM1i1hF690kzCpC7jPUH+LvPIFK978B2nW/+tVnUkEqLJX1kKzSUUgs1eEtuN
         6D/MXmfZ42/ZLeHLUM/keqLDPcKYJCVg7K7f0bPEsCd4tCF/bGjuoz8961Ms71oMbRtj
         I9eHKCLEAFhkD7L844DbC8MPHHr/j7vgpU68r+3gP/Unf2UmSd6tgi6KuY6sFhNRpw9L
         uBIVEKCzvq0f+GG00jhBqeEHMP3rAYsXOxcU26tA4cAtdzB1tywx0mavB2KbZ8qwETX7
         6JAQ==
X-Gm-Message-State: AOAM530BQ/IBs98eQT3nObEg+h/8+c1E2VXa4tV1G+5MEbpMG9htufhm
        srCKc86YNnHJYdRkrw/285aWD1jJk+PptQ==
X-Google-Smtp-Source: ABdhPJw5zRx5hRwG6+0cz8ZEoARLwi8BJdZmZ4NCZOEx0nTP3q7wWm5wOVAjMLoSK/Ts75MsNFytzA==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr20588288wrp.14.1608576022371;
        Mon, 21 Dec 2020 10:40:22 -0800 (PST)
Received: from xws.fritz.box (pd9e5aae0.dip0.t-ipconnect.de. [217.229.170.224])
        by smtp.gmail.com with ESMTPSA id j7sm24528310wmb.40.2020.12.21.10.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:40:21 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 5/9] platform/surface: aggregator: Add error injection capabilities
Date:   Mon, 21 Dec 2020 19:39:55 +0100
Message-Id: <20201221183959.1186143-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221183959.1186143-1-luzmaximilian@gmail.com>
References: <20201221183959.1186143-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds error injection hooks to the Surface Serial Hub
communication protocol implementation, to:

 - simulate simple serial transmission errors,

 - drop packets, requests, and responses, simulating communication
   failures and potentially trigger retransmission timeouts, as well as

 - inject invalid data into submitted and received packets.

Together with the trace points introduced in the previous commit, these
facilities are intended to aid in testing, validation, and debugging of
the Surface Aggregator communication layer.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

Changes in v1 (from RFC):
 - remove unnecessary default in Kconfig entry

Changes in v2:
 - use dedicated trace event class for data error injection
 - spell check comments and strings, fix typos
 - unify comment style
 - run checkpatch --strict, fix warnings and style issues

---
 drivers/platform/surface/aggregator/Kconfig   |  14 +
 .../surface/aggregator/ssh_packet_layer.c     | 296 +++++++++++++++++-
 .../surface/aggregator/ssh_request_layer.c    |  35 +++
 drivers/platform/surface/aggregator/trace.h   |  31 ++
 4 files changed, 375 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/Kconfig b/drivers/platform/surface/aggregator/Kconfig
index e9f4ad96e40a..e417bac67088 100644
--- a/drivers/platform/surface/aggregator/Kconfig
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -40,3 +40,17 @@ menuconfig SURFACE_AGGREGATOR
 	  Choose m if you want to build the SAM subsystem core and SSH driver as
 	  module, y if you want to build it into the kernel and n if you don't
 	  want it at all.
+
+config SURFACE_AGGREGATOR_ERROR_INJECTION
+	bool "Surface System Aggregator Module Error Injection Capabilities"
+	depends on SURFACE_AGGREGATOR
+	depends on FUNCTION_ERROR_INJECTION
+	help
+	  Provides error-injection capabilities for the Surface System
+	  Aggregator Module subsystem and Surface Serial Hub driver.
+
+	  Specifically, exports error injection hooks to be used with the
+	  kernel's function error injection capabilities to simulate underlying
+	  transport and communication problems, such as invalid data sent to or
+	  received from the EC, dropped data, and communication timeouts.
+	  Intended for development and debugging.
diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index c4f082e57372..74f0faaa2b27 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -7,6 +7,7 @@
 
 #include <asm/unaligned.h>
 #include <linux/atomic.h>
+#include <linux/error-injection.h>
 #include <linux/jiffies.h>
 #include <linux/kfifo.h>
 #include <linux/kref.h>
@@ -226,6 +227,286 @@
  */
 #define SSH_PTL_RX_FIFO_LEN			4096
 
+#ifdef CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION
+
+/**
+ * ssh_ptl_should_drop_ack_packet() - Error injection hook to drop ACK packets.
+ *
+ * Useful to test detection and handling of automated re-transmits by the EC.
+ * Specifically of packets that the EC considers not-ACKed but the driver
+ * already considers ACKed (due to dropped ACK). In this case, the EC
+ * re-transmits the packet-to-be-ACKed and the driver should detect it as
+ * duplicate/already handled. Note that the driver should still send an ACK
+ * for the re-transmitted packet.
+ */
+static noinline bool ssh_ptl_should_drop_ack_packet(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_ack_packet, TRUE);
+
+/**
+ * ssh_ptl_should_drop_nak_packet() - Error injection hook to drop NAK packets.
+ *
+ * Useful to test/force automated (timeout-based) re-transmit by the EC.
+ * Specifically, packets that have not reached the driver completely/with valid
+ * checksums. Only useful in combination with receival of (injected) bad data.
+ */
+static noinline bool ssh_ptl_should_drop_nak_packet(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_nak_packet, TRUE);
+
+/**
+ * ssh_ptl_should_drop_dsq_packet() - Error injection hook to drop sequenced
+ * data packet.
+ *
+ * Useful to test re-transmit timeout of the driver. If the data packet has not
+ * been ACKed after a certain time, the driver should re-transmit the packet up
+ * to limited number of times defined in SSH_PTL_MAX_PACKET_TRIES.
+ */
+static noinline bool ssh_ptl_should_drop_dsq_packet(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_dsq_packet, TRUE);
+
+/**
+ * ssh_ptl_should_fail_write() - Error injection hook to make
+ * serdev_device_write() fail.
+ *
+ * Hook to simulate errors in serdev_device_write when transmitting packets.
+ */
+static noinline int ssh_ptl_should_fail_write(void)
+{
+	return 0;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_fail_write, ERRNO);
+
+/**
+ * ssh_ptl_should_corrupt_tx_data() - Error injection hook to simulate invalid
+ * data being sent to the EC.
+ *
+ * Hook to simulate corrupt/invalid data being sent from host (driver) to EC.
+ * Causes the packet data to be actively corrupted by overwriting it with
+ * pre-defined values, such that it becomes invalid, causing the EC to respond
+ * with a NAK packet. Useful to test handling of NAK packets received by the
+ * driver.
+ */
+static noinline bool ssh_ptl_should_corrupt_tx_data(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_tx_data, TRUE);
+
+/**
+ * ssh_ptl_should_corrupt_rx_syn() - Error injection hook to simulate invalid
+ * data being sent by the EC.
+ *
+ * Hook to simulate invalid SYN bytes, i.e. an invalid start of messages and
+ * test handling thereof in the driver.
+ */
+static noinline bool ssh_ptl_should_corrupt_rx_syn(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_rx_syn, TRUE);
+
+/**
+ * ssh_ptl_should_corrupt_rx_data() - Error injection hook to simulate invalid
+ * data being sent by the EC.
+ *
+ * Hook to simulate invalid data/checksum of the message frame and test handling
+ * thereof in the driver.
+ */
+static noinline bool ssh_ptl_should_corrupt_rx_data(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_rx_data, TRUE);
+
+static bool __ssh_ptl_should_drop_ack_packet(struct ssh_packet *packet)
+{
+	if (likely(!ssh_ptl_should_drop_ack_packet()))
+		return false;
+
+	trace_ssam_ei_tx_drop_ack_packet(packet);
+	ptl_info(packet->ptl, "packet error injection: dropping ACK packet %p\n",
+		 packet);
+
+	return true;
+}
+
+static bool __ssh_ptl_should_drop_nak_packet(struct ssh_packet *packet)
+{
+	if (likely(!ssh_ptl_should_drop_nak_packet()))
+		return false;
+
+	trace_ssam_ei_tx_drop_nak_packet(packet);
+	ptl_info(packet->ptl, "packet error injection: dropping NAK packet %p\n",
+		 packet);
+
+	return true;
+}
+
+static bool __ssh_ptl_should_drop_dsq_packet(struct ssh_packet *packet)
+{
+	if (likely(!ssh_ptl_should_drop_dsq_packet()))
+		return false;
+
+	trace_ssam_ei_tx_drop_dsq_packet(packet);
+	ptl_info(packet->ptl,
+		 "packet error injection: dropping sequenced data packet %p\n",
+		 packet);
+
+	return true;
+}
+
+static bool ssh_ptl_should_drop_packet(struct ssh_packet *packet)
+{
+	/* Ignore packets that don't carry any data (i.e. flush). */
+	if (!packet->data.ptr || !packet->data.len)
+		return false;
+
+	switch (packet->data.ptr[SSH_MSGOFFSET_FRAME(type)]) {
+	case SSH_FRAME_TYPE_ACK:
+		return __ssh_ptl_should_drop_ack_packet(packet);
+
+	case SSH_FRAME_TYPE_NAK:
+		return __ssh_ptl_should_drop_nak_packet(packet);
+
+	case SSH_FRAME_TYPE_DATA_SEQ:
+		return __ssh_ptl_should_drop_dsq_packet(packet);
+
+	default:
+		return false;
+	}
+}
+
+static int ssh_ptl_write_buf(struct ssh_ptl *ptl, struct ssh_packet *packet,
+			     const unsigned char *buf, size_t count)
+{
+	int status;
+
+	status = ssh_ptl_should_fail_write();
+	if (unlikely(status)) {
+		trace_ssam_ei_tx_fail_write(packet, status);
+		ptl_info(packet->ptl,
+			 "packet error injection: simulating transmit error %d, packet %p\n",
+			 status, packet);
+
+		return status;
+	}
+
+	return serdev_device_write_buf(ptl->serdev, buf, count);
+}
+
+static void ssh_ptl_tx_inject_invalid_data(struct ssh_packet *packet)
+{
+	/* Ignore packets that don't carry any data (i.e. flush). */
+	if (!packet->data.ptr || !packet->data.len)
+		return;
+
+	/* Only allow sequenced data packets to be modified. */
+	if (packet->data.ptr[SSH_MSGOFFSET_FRAME(type)] != SSH_FRAME_TYPE_DATA_SEQ)
+		return;
+
+	if (likely(!ssh_ptl_should_corrupt_tx_data()))
+		return;
+
+	trace_ssam_ei_tx_corrupt_data(packet);
+	ptl_info(packet->ptl,
+		 "packet error injection: simulating invalid transmit data on packet %p\n",
+		 packet);
+
+	/*
+	 * NB: The value 0xb3 has been chosen more or less randomly so that it
+	 * doesn't have any (major) overlap with the SYN bytes (aa 55) and is
+	 * non-trivial (i.e. non-zero, non-0xff).
+	 */
+	memset(packet->data.ptr, 0xb3, packet->data.len);
+}
+
+static void ssh_ptl_rx_inject_invalid_syn(struct ssh_ptl *ptl,
+					  struct ssam_span *data)
+{
+	struct ssam_span frame;
+
+	/* Check if there actually is something to corrupt. */
+	if (!sshp_find_syn(data, &frame))
+		return;
+
+	if (likely(!ssh_ptl_should_corrupt_rx_syn()))
+		return;
+
+	trace_ssam_ei_rx_corrupt_syn(data->len);
+
+	data->ptr[1] = 0xb3;	/* Set second byte of SYN to "random" value. */
+}
+
+static void ssh_ptl_rx_inject_invalid_data(struct ssh_ptl *ptl,
+					   struct ssam_span *frame)
+{
+	size_t payload_len, message_len;
+	struct ssh_frame *sshf;
+
+	/* Ignore incomplete messages, will get handled once it's complete. */
+	if (frame->len < SSH_MESSAGE_LENGTH(0))
+		return;
+
+	/* Ignore incomplete messages, part 2. */
+	payload_len = get_unaligned_le16(&frame->ptr[SSH_MSGOFFSET_FRAME(len)]);
+	message_len = SSH_MESSAGE_LENGTH(payload_len);
+	if (frame->len < message_len)
+		return;
+
+	if (likely(!ssh_ptl_should_corrupt_rx_data()))
+		return;
+
+	sshf = (struct ssh_frame *)&frame->ptr[SSH_MSGOFFSET_FRAME(type)];
+	trace_ssam_ei_rx_corrupt_data(sshf);
+
+	/*
+	 * Flip bits in first byte of payload checksum. This is basically
+	 * equivalent to a payload/frame data error without us having to worry
+	 * about (the, arguably pretty small, probability of) accidental
+	 * checksum collisions.
+	 */
+	frame->ptr[frame->len - 2] = ~frame->ptr[frame->len - 2];
+}
+
+#else /* CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION */
+
+static inline bool ssh_ptl_should_drop_packet(struct ssh_packet *packet)
+{
+	return false;
+}
+
+static inline int ssh_ptl_write_buf(struct ssh_ptl *ptl,
+				    struct ssh_packet *packet,
+				    const unsigned char *buf,
+				    size_t count)
+{
+	return serdev_device_write_buf(ptl->serdev, buf, count);
+}
+
+static inline void ssh_ptl_tx_inject_invalid_data(struct ssh_packet *packet)
+{
+}
+
+static inline void ssh_ptl_rx_inject_invalid_syn(struct ssh_ptl *ptl,
+						 struct ssam_span *data)
+{
+}
+
+static inline void ssh_ptl_rx_inject_invalid_data(struct ssh_ptl *ptl,
+						  struct ssam_span *frame)
+{
+}
+
+#endif /* CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION */
+
 static void __ssh_ptl_packet_release(struct kref *kref)
 {
 	struct ssh_packet *p = container_of(kref, struct ssh_packet, refcnt);
@@ -776,6 +1057,13 @@ static int ssh_ptl_tx_packet(struct ssh_ptl *ptl, struct ssh_packet *packet)
 	if (unlikely(!packet->data.ptr))
 		return 0;
 
+	/* Error injection: drop packet to simulate transmission problem. */
+	if (ssh_ptl_should_drop_packet(packet))
+		return 0;
+
+	/* Error injection: simulate invalid packet data. */
+	ssh_ptl_tx_inject_invalid_data(packet);
+
 	ptl_dbg(ptl, "tx: sending data (length: %zu)\n", packet->data.len);
 	print_hex_dump_debug("tx: ", DUMP_PREFIX_OFFSET, 16, 1,
 			     packet->data.ptr, packet->data.len, false);
@@ -787,7 +1075,7 @@ static int ssh_ptl_tx_packet(struct ssh_ptl *ptl, struct ssh_packet *packet)
 		buf = packet->data.ptr + offset;
 		len = packet->data.len - offset;
 
-		status = serdev_device_write_buf(ptl->serdev, buf, len);
+		status = ssh_ptl_write_buf(ptl, packet, buf, len);
 		if (status < 0)
 			return status;
 
@@ -1400,6 +1688,9 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 	bool syn_found;
 	int status;
 
+	/* Error injection: Modify data to simulate corrupt SYN bytes. */
+	ssh_ptl_rx_inject_invalid_syn(ptl, source);
+
 	/* Find SYN. */
 	syn_found = sshp_find_syn(source, &aligned);
 
@@ -1430,6 +1721,9 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 	if (unlikely(!syn_found))
 		return aligned.ptr - source->ptr;
 
+	/* Error injection: Modify data to simulate corruption. */
+	ssh_ptl_rx_inject_invalid_data(ptl, &aligned);
+
 	/* Parse and validate frame. */
 	status = sshp_parse_frame(&ptl->serdev->dev, &aligned, &frame, &payload,
 				  SSH_PTL_RX_BUF_LEN);
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index b649d71840fd..bb1c862411a2 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -8,6 +8,7 @@
 #include <asm/unaligned.h>
 #include <linux/atomic.h>
 #include <linux/completion.h>
+#include <linux/error-injection.h>
 #include <linux/ktime.h>
 #include <linux/limits.h>
 #include <linux/list.h>
@@ -58,6 +59,30 @@
  */
 #define SSH_RTL_TX_BATCH		10
 
+#ifdef CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION
+
+/**
+ * ssh_rtl_should_drop_response() - Error injection hook to drop request
+ * responses.
+ *
+ * Useful to cause request transmission timeouts in the driver by dropping the
+ * response to a request.
+ */
+static noinline bool ssh_rtl_should_drop_response(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_rtl_should_drop_response, TRUE);
+
+#else
+
+static inline bool ssh_rtl_should_drop_response(void)
+{
+	return false;
+}
+
+#endif
+
 static u16 ssh_request_get_rqid(struct ssh_request *rqst)
 {
 	return get_unaligned_le16(rqst->packet.data.ptr
@@ -459,6 +484,16 @@ static void ssh_rtl_complete(struct ssh_rtl *rtl,
 		if (unlikely(ssh_request_get_rqid(p) != rqid))
 			continue;
 
+		/* Simulate response timeout. */
+		if (ssh_rtl_should_drop_response()) {
+			spin_unlock(&rtl->pending.lock);
+
+			trace_ssam_ei_rx_drop_response(p);
+			rtl_info(rtl, "request error injection: dropping response for request %p\n",
+				 &p->packet);
+			return;
+		}
+
 		/*
 		 * Mark as "response received" and "locked" as we're going to
 		 * complete it.
diff --git a/drivers/platform/surface/aggregator/trace.h b/drivers/platform/surface/aggregator/trace.h
index dcca8007d876..eb332bb53ae4 100644
--- a/drivers/platform/surface/aggregator/trace.h
+++ b/drivers/platform/surface/aggregator/trace.h
@@ -565,6 +565,28 @@ DECLARE_EVENT_CLASS(ssam_pending_class,
 		TP_ARGS(pending)					\
 	)
 
+DECLARE_EVENT_CLASS(ssam_data_class,
+	TP_PROTO(size_t length),
+
+	TP_ARGS(length),
+
+	TP_STRUCT__entry(
+		__field(size_t, length)
+	),
+
+	TP_fast_assign(
+		__entry->length = length;
+	),
+
+	TP_printk("length=%zu", __entry->length)
+);
+
+#define DEFINE_SSAM_DATA_EVENT(name)					\
+	DEFINE_EVENT(ssam_data_class, ssam_##name,			\
+		TP_PROTO(size_t length),				\
+		TP_ARGS(length)						\
+	)
+
 DEFINE_SSAM_FRAME_EVENT(rx_frame_received);
 DEFINE_SSAM_COMMAND_EVENT(rx_response_received);
 DEFINE_SSAM_COMMAND_EVENT(rx_event_received);
@@ -583,6 +605,15 @@ DEFINE_SSAM_REQUEST_EVENT(request_cancel);
 DEFINE_SSAM_REQUEST_STATUS_EVENT(request_complete);
 DEFINE_SSAM_PENDING_EVENT(rtl_timeout_reap);
 
+DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_ack_packet);
+DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_nak_packet);
+DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_dsq_packet);
+DEFINE_SSAM_PACKET_STATUS_EVENT(ei_tx_fail_write);
+DEFINE_SSAM_PACKET_EVENT(ei_tx_corrupt_data);
+DEFINE_SSAM_DATA_EVENT(ei_rx_corrupt_syn);
+DEFINE_SSAM_FRAME_EVENT(ei_rx_corrupt_data);
+DEFINE_SSAM_REQUEST_EVENT(ei_rx_drop_response);
+
 DEFINE_SSAM_ALLOC_EVENT(ctrl_packet_alloc);
 DEFINE_SSAM_FREE_EVENT(ctrl_packet_free);
 
-- 
2.29.2

