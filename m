Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3452057C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbgFWQrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:47:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:39240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733096AbgFWQp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08E25AEB1;
        Tue, 23 Jun 2020 16:45:25 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 30/50] staging: vchiq: Export vchiq_msg_queue_push
Date:   Tue, 23 Jun 2020 18:42:16 +0200
Message-Id: <20200623164235.29566-31-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchiq consumer drivers may need to use this function in order to get the
benefits of vchiq's per service message queueing mechanism.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index 8fd51d885a18..c99caa3add57 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -107,6 +107,7 @@ extern enum vchiq_status vchiq_use_service(unsigned int service);
 extern enum vchiq_status vchiq_release_service(unsigned int service);
 extern enum vchiq_status vchiq_queue_kernel_message(unsigned int handle,
 						    void *context, size_t size);
+extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
 extern void           vchiq_release_message(unsigned int service,
 	struct vchiq_header *header);
 extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
-- 
2.27.0

