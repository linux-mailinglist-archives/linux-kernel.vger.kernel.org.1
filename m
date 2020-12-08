Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4D2D343E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgLHUeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:34:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DB0C0617B0;
        Tue,  8 Dec 2020 12:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Wa0bu8J/tGA6dn35GnlM9+AUoiXQqtWZJhjrsPBx07I=; b=BhCWWmPogKtTQSKegBJ63j3V9o
        UeQiTiseqDXVSSuOxY4anLCy4UJLyGb8Win/XyVeh1+W6I1+6jWPPxDKMSDR5v+CwTum1ocNW30C+
        ghmjfQ3iTVc0tFcsB/GDqdBeeKKP9DkFhSCAkLCJv1wUEWUUrAG8hCanaJFj/5mzzFCk7y4N/3aK8
        CmhJLD/1emgycCNAG/67eDPKz44NMsPj/l8HnZBAbDtBzKaqloV1B2cSMovp5EMDAT08C865ZHETe
        AHAqT+kJlMuW5bBWZxdrKl00EraGp6hr7YM+jJBO4w+hsOyfQTcwNJfvxRXNmrbWSbRTzDKHwPWpz
        aJH9kG9w==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmj5U-0000Xb-UT; Tue, 08 Dec 2020 19:55:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH -next] usb: cdns3: fix warning when USB_CDNS_HOST is not set
Date:   Tue,  8 Dec 2020 11:55:47 -0800
Message-Id: <20201208195547.30076-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build warning when USB_CDNS_HOST is not enabled:

In file included from ../drivers/usb/cdns3/core.c:23:0:
../drivers/usb/cdns3/host-export.h:27:51: warning: ‘struct usb_hcd’ declared inside parameter list will not be visible outside of this definition or declaration
 static inline int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
                                                   ^~~~~~~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Chen <peter.chen@nxp.com>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/host-export.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20201208.orig/drivers/usb/cdns3/host-export.h
+++ linux-next-20201208/drivers/usb/cdns3/host-export.h
@@ -9,10 +9,10 @@
 #ifndef __LINUX_CDNS3_HOST_EXPORT
 #define __LINUX_CDNS3_HOST_EXPORT
 
-#if IS_ENABLED(CONFIG_USB_CDNS_HOST)
-
 struct usb_hcd;
 
+#if IS_ENABLED(CONFIG_USB_CDNS_HOST)
+
 int cdns_host_init(struct cdns *cdns);
 int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd);
 
