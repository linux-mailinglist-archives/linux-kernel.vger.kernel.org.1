Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB151E40C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgE0Lym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:54:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:40806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbgE0LyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 37455AF38;
        Wed, 27 May 2020 11:54:23 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 11/50] staging: vchi: Get rid of all useless callback reasons
Date:   Wed, 27 May 2020 13:53:16 +0200
Message-Id: <20200527115400.31391-12-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are neither produced nor expected, so just delete them.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchi/vchi_common.h              | 40 ++-----------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_common.h b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
index 7fc04e38936d..0f79bea4757d 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_common.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_common.h
@@ -31,8 +31,6 @@ enum vchi_crc_control {
 
 //callback reasons when an event occurs on a service
 enum vchi_callback_reason {
-	VCHI_CALLBACK_REASON_MIN,
-
 	/*
 	 * This indicates that there is data available handle is the msg id that
 	 * was transmitted with the data
@@ -41,44 +39,12 @@ enum vchi_callback_reason {
 	 * Tasks get kicked by the callback, reset their event and try and read
 	 * from the fifo until it fails
 	 */
+	VCHI_CALLBACK_SERVICE_CLOSED,
 	VCHI_CALLBACK_MSG_AVAILABLE,
-	VCHI_CALLBACK_MSG_SENT,
-	VCHI_CALLBACK_MSG_SPACE_AVAILABLE, // XXX not yet implemented
-
-	// This indicates that a transfer from the other side has completed
-	VCHI_CALLBACK_BULK_RECEIVED,
-	//This indicates that data queued up to be sent has now gone
-	//handle is the msg id that was used when sending the data
 	VCHI_CALLBACK_BULK_SENT,
-	VCHI_CALLBACK_BULK_RX_SPACE_AVAILABLE, // XXX not yet implemented
-	VCHI_CALLBACK_BULK_TX_SPACE_AVAILABLE, // XXX not yet implemented
-
-	VCHI_CALLBACK_SERVICE_CLOSED,
-
-	/*
-	 * this side has sent XOFF to peer due to lack of data consumption by
-	 * service (suggests the service may need to take some recovery action
-	 * if it has been deliberately holding off consuming data)
-	 */
-	VCHI_CALLBACK_SENT_XOFF,
-	VCHI_CALLBACK_SENT_XON,
-
-	// indicates that a bulk transfer has finished reading the source buffer
-	VCHI_CALLBACK_BULK_DATA_READ,
-
-	// power notification events (currently host side only)
-	VCHI_CALLBACK_PEER_OFF,
-	VCHI_CALLBACK_PEER_SUSPENDED,
-	VCHI_CALLBACK_PEER_ON,
-	VCHI_CALLBACK_PEER_RESUMED,
-	VCHI_CALLBACK_FORCED_POWER_OFF,
-
-	// some extra notifications provided by vchiq_arm
-	VCHI_CALLBACK_SERVICE_OPENED,
-	VCHI_CALLBACK_BULK_RECEIVE_ABORTED,
+	VCHI_CALLBACK_BULK_RECEIVED,
 	VCHI_CALLBACK_BULK_TRANSMIT_ABORTED,
-
-	VCHI_CALLBACK_REASON_MAX
+	VCHI_CALLBACK_BULK_RECEIVE_ABORTED,
 };
 
 // service control options
-- 
2.26.2

