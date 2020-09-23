Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A90B27527C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWHwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgIWHwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:52:18 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12B2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 00:52:17 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Bx9PW0Xz2zKmXM;
        Wed, 23 Sep 2020 09:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received; s=
        mail20150812; t=1600847531; bh=6x/NlDpeN0DB4htPrOmX8f8ORN4dY7kdB
        WWuXsA25kY=; b=Xb8YmU43xR3/MCH8VIGVymoTf098ETeredv9qxIMsI23lEvEx
        z8okqcX2kpQ5rMCgMKm0IyBfCR6NQRtpE5vpNJZYpEP3i3/aMEq5Yfoo4PqsuyvQ
        BmUMk4nhlzRkLlrft5qxtYCB/Bh/a7r2E+ajGgjszhkbIXeAqunt26q1hsEguxYU
        USaXM+1+R9t2HYxTh1jdXc9bARNpkGmugHlkyI76/PfjD3Oc3CPtzHjjv2qJp/KR
        BYajlu9BcIwelNCm88AoPuUAXF6xA7tb7h4irWZU1tRstlam6OPYKd5xS7RcAVqS
        3HP5OQ3XvrZhEOJvK+qqIqHRXmpQzVExblOow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1600847533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Icq7cP+wMHNnro8gIuiVm70of9SQ9Tuq0x6o7gJMlns=;
        b=YcSyCzzgnZuI03DDyIV310W1on6o6HMNgUhOVx9GJNYvVEKSZ4XNWVFie2+d0zJQ0EYeF+
        AoC1MmvuPfbYAJlK+vdVKR11NKb1rX5GdSLaaOm1ExvxKMDCqaVAbs+7iwFtV23WWEGTls
        D/a4nE4RCbB+r/SP0tr2nc6TcxSuFh0b6rgN1UqvHDe2iCA96O+BLW+BghJoLAO6WMyM8h
        JuPy+gZRZj34Z6HqZZvIijObbRadoSbjIw9OfHTxZG6e9BWApaeiS9PFVeQ9Xt0AfpyIyM
        sMkS2sZWK5x5yJtP6CUjXejUvdKO5nvVqcJbpmqntF2zExv9H4UzSjxCeRprww==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id Y7IEH6svcVv6; Wed, 23 Sep 2020 09:52:11 +0200 (CEST)
Date:   Wed, 23 Sep 2020 09:52:09 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH] net: usb: ax88179_178a: add Toshiba usb 3.0 adapter
Message-ID: <20200923075209.GA145354@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.59 / 15.00 / 15.00
X-Rspamd-Queue-Id: 0CFC617DA
X-Rspamd-UID: f78be8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the driver_info and usb ids of the AX88179 based Toshiba USB 3.0
ethernet adapter.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
---
 drivers/net/usb/ax88179_178a.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index ac7bc436da33..ed078e5a3629 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1829,6 +1829,19 @@ static const struct driver_info belkin_info = {
 	.tx_fixup = ax88179_tx_fixup,
 };
 
+static const struct driver_info toshiba_info = {
+	.description = "Toshiba USB Ethernet Adapter",
+	.bind	= ax88179_bind,
+	.unbind = ax88179_unbind,
+	.status = ax88179_status,
+	.link_reset = ax88179_link_reset,
+	.reset	= ax88179_reset,
+	.stop = ax88179_stop,
+	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
+	.rx_fixup = ax88179_rx_fixup,
+	.tx_fixup = ax88179_tx_fixup,
+};
+
 static const struct usb_device_id products[] = {
 {
 	/* ASIX AX88179 10/100/1000 */
@@ -1862,6 +1875,10 @@ static const struct usb_device_id products[] = {
 	/* Belkin B2B128 USB 3.0 Hub + Gigabit Ethernet Adapter */
 	USB_DEVICE(0x050d, 0x0128),
 	.driver_info = (unsigned long)&belkin_info,
+}, {
+	/* Toshiba USB 3.0 GBit Ethernet Adapter */
+	USB_DEVICE(0x0930, 0x0a13),
+	.driver_info = (unsigned long)&toshiba_info,
 },
 	{ },
 };
-- 
2.28.0

