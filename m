Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BDF28A312
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390636AbgJJW6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730938AbgJJTwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:52:03 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B1C05BD41
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 06:07:26 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4C7lbF33r8zQlQv;
        Sat, 10 Oct 2020 15:07:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-disposition:content-type:content-type:mime-version
        :message-id:subject:subject:from:from:date:date:received; s=
        mail20150812; t=1602335238; bh=eCb88D5mCUgJI97N3SFHjW9CDr5Al9NBC
        UdsiYBWemI=; b=p0EIgiGCXJxA3vNxWxjaVTn+IS2CL0TwYE0L9KzxLuI21SoOx
        d3MxwowyWSCpGXQdqYdh1oSIe5aZLBqeZ+XLVHooExAsZFBqIA5n1pge2LWFOvFg
        5dIH/eokjX+QuduIPWxJNHLzvtdzgBOJCwXXHdl/KECxRmiP4wIKR8bPlsvdH4ED
        0OhTv1EIp3yclXANvdJn/k4HZQLszIuPDxXVTwa2q0aR0K5bbybaZGtDkXnG+oOI
        CqxOmiJT0CgaoCZWJyqoPaGV4odUoR2invSfkyZM0StCT4MpsaCywcJkvTuPnL0u
        awRev5IXVcLN3nletT2IJqJhYJraJq1wrGB2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1602335239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RIcBrNJIPly+xj6tVxYjqisWN/wTEfbudXy2NuO1oGI=;
        b=CAq3OtlFNUO+44EhEyParmTO964nBqR2NERmicfDry8pA8DL0IoDLmm0PkUwT4lKi4waMG
        6V1HJ/mBReWePIB8m7sIhgoz1OqYB2Qzdylvlu0igYrWhDTq1Hnk9b6rfqnKDG5j6vIfRJ
        1bsEEwIKr9iWrBycET2ZkIrZvFL1uPtC5Nz4cfd68+ILxSgVrlCucsY8VXv85ZrrdtPSV3
        dM0p2HMEt0rUsGI+xvhdMWHXkF5Gv4r3OAyMagXcin2rEk3ILuW+I/K56Ag4iuS+cUXqFX
        2ouMmi/FjApH1v9Vldd7LQp0sFH0Cq1g7h2qZ5iUUthOmLCA/HQHmD5ORzCxIw==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id pGSX-yWu0LxW; Sat, 10 Oct 2020 15:07:18 +0200 (CEST)
Date:   Sat, 10 Oct 2020 15:07:16 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: via_wdt: add VX900 support
Message-ID: <20201010130716.GA84929@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.51 / 15.00 / 15.00
X-Rspamd-Queue-Id: 7CABF1707
X-Rspamd-UID: 53ea1a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds watchdog support for the VIA VX900 chip-set, which is fully
backwards compatible to the older VIA chip-set watchdogs.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
---
 drivers/watchdog/via_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index eeb39f96e72e..b452ab253ac7 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -244,6 +244,7 @@ static const struct pci_device_id wdt_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_CX700) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX800) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX855) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX900) },
 	{ 0 }
 };
 
-- 
2.28.0

