Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976002E6EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 08:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgL2HN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 02:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgL2HN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:13:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942E5C0613D6;
        Mon, 28 Dec 2020 23:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=lBCNuS5v86MpcyX53G9VuW1LBgOBtl/EWWx2AJBcQwQ=; b=vb7cCCMqrqq16DgF7JC7l3MdZ0
        RAF0LsxgiRTTI3TtzQFnMsoiG1b3S1xICvCC1+JUXzFrndSXvCbLPhg8Z9uWyv5dub6DEFssBr3Nh
        PvlIZ1/dHk+k6/mNmq1UspfsDu9A9BuO9dHriDgxMIiSmz75AusICrw8y9kCz/NtMyE0HFEJKYOv0
        oaFzF0fFjZNuQlJObTB1LNE7qq+MdrCftyaxbQ7YWye536fup+b7o61QBRzXOdV1bOn3fv8W5IoG2
        DMkXjgLha4Yg/loNkxBDmbuqBkTQn5aHDbBarhrWuOPXYkf9wy/k1Sp22w4+XAqem03yuAv8ilAXm
        ZDgs3Gew==;
Received: from [2601:1c0:6280:3f0::2c43] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ku9Bx-00026A-RK; Tue, 29 Dec 2020 07:13:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        syzbot+297d20e437b79283bf6d@syzkaller.appspotmail.com,
        Yuyang Du <yuyang.du@intel.com>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: usbip: vhci_hcd: protect shift size
Date:   Mon, 28 Dec 2020 23:13:09 -0800
Message-Id: <20201229071309.18418-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix shift out-of-bounds in vhci_hcd.c:

  UBSAN: shift-out-of-bounds in ../drivers/usb/usbip/vhci_hcd.c:399:41
  shift exponent 768 is too large for 32-bit type 'int'

Fixes: 03cd00d538a6 ("usbip: vhci-hcd: Set the vhci structure up to work")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: syzbot+297d20e437b79283bf6d@syzkaller.appspotmail.com
Cc: Yuyang Du <yuyang.du@intel.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/usbip/vhci_hcd.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-5.10.orig/drivers/usb/usbip/vhci_hcd.c
+++ linux-5.10/drivers/usb/usbip/vhci_hcd.c
@@ -396,6 +396,8 @@ static int vhci_hub_control(struct usb_h
 		default:
 			usbip_dbg_vhci_rh(" ClearPortFeature: default %x\n",
 					  wValue);
+			if (wValue >= 32)
+				goto error;
 			vhci_hcd->port_status[rhport] &= ~(1 << wValue);
 			break;
 		}
