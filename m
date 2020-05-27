Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C1B1E40C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgE0Lyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:54:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:41156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgE0Ly3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 788BDACF2;
        Wed, 27 May 2020 11:54:30 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 17/50] staging: vchi_common: Get rid of all unused definitions
Date:   Wed, 27 May 2020 13:53:22 +0200
Message-Id: <20200527115400.31391-18-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a series of structures and enums defined but never used. Get
rid of them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchi/vchi_common.h              | 65 -------------------
 1 file changed, 65 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_common.h b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
index 0f79bea4757d..e07376fe4dfd 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_common.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
@@ -10,23 +10,7 @@ enum vchi_flags {
 	VCHI_FLAGS_BLOCK_UNTIL_OP_COMPLETE   = 0x1,   // waits for message to be received, or sent (NB. not the same as being seen on other side)
 	VCHI_FLAGS_CALLBACK_WHEN_OP_COMPLETE = 0x2,   // run a callback when message sent
 	VCHI_FLAGS_BLOCK_UNTIL_QUEUED        = 0x4,   // return once the transfer is in a queue ready to go
-	VCHI_FLAGS_ALLOW_PARTIAL             = 0x8,
 	VCHI_FLAGS_BLOCK_UNTIL_DATA_READ     = 0x10,
-	VCHI_FLAGS_CALLBACK_WHEN_DATA_READ   = 0x20,
-
-	VCHI_FLAGS_ALIGN_SLOT            = 0x000080,  // internal use only
-	VCHI_FLAGS_BULK_AUX_QUEUED       = 0x010000,  // internal use only
-	VCHI_FLAGS_BULK_AUX_COMPLETE     = 0x020000,  // internal use only
-	VCHI_FLAGS_BULK_DATA_QUEUED      = 0x040000,  // internal use only
-	VCHI_FLAGS_BULK_DATA_COMPLETE    = 0x080000,  // internal use only
-	VCHI_FLAGS_INTERNAL              = 0xFF0000
-};
-
-// constants for vchi_crc_control()
-enum vchi_crc_control {
-	VCHI_CRC_NOTHING = -1,
-	VCHI_CRC_PER_SERVICE = 0,
-	VCHI_CRC_EVERYTHING = 1,
 };
 
 //callback reasons when an event occurs on a service
@@ -47,58 +31,9 @@ enum vchi_callback_reason {
 	VCHI_CALLBACK_BULK_RECEIVE_ABORTED,
 };
 
-// service control options
-enum vchi_service_option {
-	VCHI_SERVICE_OPTION_MIN,
-
-	VCHI_SERVICE_OPTION_TRACE,
-	VCHI_SERVICE_OPTION_SYNCHRONOUS,
-
-	VCHI_SERVICE_OPTION_MAX
-};
-
 //Callback used by all services / bulk transfers
 typedef void (*vchi_callback)(void *callback_param, //my service local param
 			      enum vchi_callback_reason reason,
 			      void *handle); //for transmitting msg's only
 
-/*
- * Define vector struct for scatter-gather (vector) operations
- * Vectors can be nested - if a vector element has negative length, then
- * the data pointer is treated as pointing to another vector array, with
- * '-vec_len' elements. Thus to append a header onto an existing vector,
- * you can do this:
- *
- * void foo(const struct vchi_msg_vector *v, int n)
- * {
- *    struct vchi_msg_vector nv[2];
- *    nv[0].vec_base = my_header;
- *    nv[0].vec_len = sizeof my_header;
- *    nv[1].vec_base = v;
- *    nv[1].vec_len = -n;
- *    ...
- *
- */
-struct vchi_msg_vector {
-	const void *vec_base;
-	int32_t vec_len;
-};
-
-/*
- * Iterator structure for reading ahead through received message queue.
- * Allocated by client, initialised by vchi_msg_look_ahead. Fields are for
- * internal VCHI use only.
- * Iterates over messages in queue at the instant of the call to
- * vchi_msg_lookahead - will not proceed to messages received since.
- * Behaviour is undefined if an iterator is used again after messages for that
- * service are removed/dequeued by any means other than vchi_msg_iter_...
- * calls on the iterator itself.
- */
-struct vchi_msg_iter {
-	struct opaque_vchi_service_t *service;
-	void *last;
-	void *next;
-	void *remove;
-};
-
 #endif // VCHI_COMMON_H_
-- 
2.26.2

