Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665CF251C85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 17:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHYPot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 11:44:49 -0400
Received: from mail1.windriver.com ([147.11.146.13]:47779 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHYPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:44:48 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 07PFieiC001998
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Aug 2020 08:44:40 -0700 (PDT)
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 08:44:22 -0700
From:   <yanfei.xu@windriver.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] USB: integrate macro definitions into include/linux/usb.h
Date:   Tue, 25 Aug 2020 23:44:21 +0800
Message-ID: <20200825154421.5463-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

include/linux/usb.h also contains 'Hard limit' and 'Arbitrary limit'
macro definitions in it, hence we can integrate these from config.c
into include/linux/usb.h

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 drivers/usb/core/config.c | 3 ---
 include/linux/usb.h       | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 562a730befda..58c5d946cd86 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -14,9 +14,6 @@
 #include "usb.h"
 
 
-#define USB_MAXALTSETTING		128	/* Hard limit */
-
-#define USB_MAXCONFIG			8	/* Arbitrary limit */
 
 
 static inline const char *plural(int n)
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 20c555db4621..d0a117cfc6bd 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -275,9 +275,12 @@ void usb_put_intf(struct usb_interface *intf);
 
 /* Hard limit */
 #define USB_MAXENDPOINTS	30
+#define USB_MAXALTSETTING	128
+
 /* this maximum is arbitrary */
 #define USB_MAXINTERFACES	32
 #define USB_MAXIADS		(USB_MAXINTERFACES/2)
+#define USB_MAXCONFIG		8
 
 /*
  * USB Resume Timer: Every Host controller driver should drive the resume
-- 
2.18.2

