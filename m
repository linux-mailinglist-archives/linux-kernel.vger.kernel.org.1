Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A384297477
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbgJWQhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbgJWQdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33495246A9;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=Hv3Ehg3kTw6mL0c8DIamVwpl0TjhhlhRQyeLYyTHoe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACDS0rg2ZzKVKSkkIt/nbSZC2aXVth9Lg6KXYJ80ULPC4mmNTxgIrDQCKgpeZT/AB
         zCb4Nk3UoukNIGd2TE52FlCojs+I+tL0fziMX4NdqZvtpRwj4BftFdlBegQWnaoWd+
         r3yy5e7f7LEjxE+J/Wg9vK0Y4y0uQMDH6fSZMzhQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Awk-3i; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 31/56] usb: dwc3: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:18 +0200
Message-Id: <0b964be3884def04fcd20ea5c12cb90d0014871c.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a common comment marked, instead, with kernel-doc
notation.

Also, some identifiers have different names between their
prototypes and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/usb/dwc3/core.c        | 2 +-
 drivers/usb/dwc3/core.h        | 2 +-
 drivers/usb/gadget/composite.c | 2 +-
 drivers/usb/typec/mux.c        | 2 +-
 include/linux/usb/composite.h  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index bdf0925da6b6..841daec70b6e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * core.c - DesignWare USB3 DRD Controller Core file
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 74323b10a64a..2f95f08ca511 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1277,7 +1277,7 @@ struct dwc3_event_type {
 #define DWC3_DEPEVT_EPCMDCMPLT		0x07
 
 /**
- * struct dwc3_event_depvt - Device Endpoint Events
+ * struct dwc3_event_depevt - Device Endpoint Events
  * @one_bit: indicates this is an endpoint event (not used)
  * @endpoint_number: number of the endpoint
  * @endpoint_event: The event we have:
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 05b176c82cc5..c6d455f2bb92 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1245,7 +1245,7 @@ int usb_string_id(struct usb_composite_dev *cdev)
 EXPORT_SYMBOL_GPL(usb_string_id);
 
 /**
- * usb_string_ids() - allocate unused string IDs in batch
+ * usb_string_ids_tab() - allocate unused string IDs in batch
  * @cdev: the device whose string descriptor IDs are being allocated
  * @str: an array of usb_string objects to assign numbers to
  * Context: single threaded during gadget setup
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index b069a5122aaa..cf720e944aaa 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -71,7 +71,7 @@ struct typec_switch *fwnode_typec_switch_get(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(fwnode_typec_switch_get);
 
 /**
- * typec_put_switch - Release USB Type-C orientation switch
+ * typec_switch_put - Release USB Type-C orientation switch
  * @sw: USB Type-C orientation switch
  *
  * Decrement reference count for @sw.
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 2040696d75b6..a2d229ab63ba 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -437,7 +437,7 @@ static inline struct usb_composite_driver *to_cdriver(
 #define OS_STRING_IDX			0xEE
 
 /**
- * struct usb_composite_device - represents one composite usb gadget
+ * struct usb_composite_dev - represents one composite usb gadget
  * @gadget: read-only, abstracts the gadget's usb peripheral controller
  * @req: used for control responses; buffer is pre-allocated
  * @os_desc_req: used for OS descriptors responses; buffer is pre-allocated
-- 
2.26.2

