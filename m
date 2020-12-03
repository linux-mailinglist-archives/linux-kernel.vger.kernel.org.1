Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E22CE0AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgLCV2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgLCV2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:28:02 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35AAC061A56;
        Thu,  3 Dec 2020 13:27:08 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k4so3707765edl.0;
        Thu, 03 Dec 2020 13:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jlIGlaIktCrhUdl3A+AFEttyDs4gtlaQUOm8P+70A28=;
        b=jZFuWeeDYetrILyOUMmJz6f3z5SS5RteQIF6cPqqFbt0cU1voABToK517WEXBmdtVB
         P71s8F9c5ms7TfV+JwjQ1S+bPAhsjDJwuZKsIYgQioLbgJ4JVjp6eSC2J22v3NLeApg/
         Gl4KukbOUpM0oFudyllTBZy0FekSqTszo1djuUJ9l3eqL78XMv+SogroVT3GbwmMHVpb
         crdiwMyZiKZv6eSbcrB5TKQ9obhvpT65eWsmjZyu46g8U8N87Ke/q4UngRzLxel/wpLv
         jwCC1fGUUzCDGhTYhr9B/GHBygXIAbnDjt9Wsy+cTCFypLnm5TghyA6o42y3MWK0q2vw
         +4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jlIGlaIktCrhUdl3A+AFEttyDs4gtlaQUOm8P+70A28=;
        b=h7UCSmcdljYDcfLI+LOTR+7d+PT/SdFCG3Afwxa44Zwajw2aQTTiJHr8Hr/D7DscqD
         ws0hwAW+zw9nZ2oQ1X59qC9Qquh+rauOhmXRT2quDH8iojn5Z7tUIGuXwr3C8suv+mjN
         tiYTj/6yEEu5KUnuFUjQ2iUC0fnemglGRL9l/AXpKKwClFug2JN/+78ltzTck9H81HUZ
         3UBxuoPIpwBeMrYWoY3TZqHKTto0qXlk9OlgBIAr6NTBbnJFbh4e3xRRU9Rt59vU3M8x
         h30a3AxnDc43maEuwuQfgfMFJTfJdEs77WvT2ZGHUuQ/Heik+DUTB6+k7qc9wUtRzzo9
         VXLQ==
X-Gm-Message-State: AOAM530NQgoDBoyPb1O46vrLUZobTZFmPDdl4gHmqwRecYhhzfMnr4vc
        CH8NqvcKkL6ZQxR8hzia7ntZTCc1ATI=
X-Google-Smtp-Source: ABdhPJzIDQxPAak0H8eRJnZWVxlNefKe2rGx8aeKU5V4dOT1tLsV+irDczIS3UlEAiQrdEUmsqnXdQ==
X-Received: by 2002:a05:6402:128d:: with SMTP id w13mr4644326edv.56.1607030826591;
        Thu, 03 Dec 2020 13:27:06 -0800 (PST)
Received: from xws.fritz.box (pd9e5a6ef.dip0.t-ipconnect.de. [217.229.166.239])
        by smtp.gmail.com with ESMTPSA id e3sm1656169ejq.96.2020.12.03.13.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:27:05 -0800 (PST)
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
Subject: [PATCH v2 5/9] platform/surface: aggregator: Add error injection capabilities
Date:   Thu,  3 Dec 2020 22:26:36 +0100
Message-Id: <20201203212640.663931-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203212640.663931-1-luzmaximilian@gmail.com>
References: <20201203212640.663931-1-luzmaximilian@gmail.com>
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
index ce34941ef91b..48f40c345e29 100644
--- a/drivers/platform/surface/aggregator/Kconfig
+++ b/drivers/platform/surface/aggregator/Kconfig
@@ -41,3 +41,17 @@ menuconfig SURFACE_AGGREGATOR
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
index f5ec58a1faa2..0205be9380bf 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -7,6 +7,7 @@

 #include <asm/unaligned.h>
 #include <linux/atomic.h>
+#include <linux/error-injection.h>
 #include <linux/jiffies.h>
 #include <linux/kfifo.h>
 #include <linux/kref.h>
@@ -225,6 +226,286 @@
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
@@ -769,6 +1050,13 @@ static int ssh_ptl_tx_packet(struct ssh_ptl *ptl, struct ssh_packet *packet)
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
@@ -780,7 +1068,7 @@ static int ssh_ptl_tx_packet(struct ssh_ptl *ptl, struct ssh_packet *packet)
 		buf = packet->data.ptr + offset;
 		len = packet->data.len - offset;

-		status = serdev_device_write_buf(ptl->serdev, buf, len);
+		status = ssh_ptl_write_buf(ptl, packet, buf, len);
 		if (status < 0)
 			return status;

@@ -1389,6 +1677,9 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 	bool syn_found;
 	int status;

+	/* Error injection: Modify data to simulate corrupt SYN bytes. */
+	ssh_ptl_rx_inject_invalid_syn(ptl, source);
+
 	/* Find SYN. */
 	syn_found = sshp_find_syn(source, &aligned);

@@ -1419,6 +1710,9 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 	if (unlikely(!syn_found))
 		return aligned.ptr - source->ptr;

+	/* Error injection: Modify data to simulate corruption. */
+	ssh_ptl_rx_inject_invalid_data(ptl, &aligned);
+
 	/* Parse and validate frame. */
 	status = sshp_parse_frame(&ptl->serdev->dev, &aligned, &frame, &payload,
 				  SSH_PTL_RX_BUF_LEN);
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index e91d2ed4c173..bf1782c85063 100644
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

