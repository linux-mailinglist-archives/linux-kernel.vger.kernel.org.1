Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3B9272086
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgIUKWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgIUKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:21:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BFBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so12125605wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Phn676ck9fxFNj85BpKV8apw8QC3TViwDCE0eTe2lKw=;
        b=SPcgfzwxG+7TAk0IVdcJAFHhW8FgtzKodBdFxADUrLFsEGadjF7vCav7EEu+lU0+GP
         NoSmoxIDJ3mjicDERBPfRbNj0tsMIMvrPFRtjvcX38BcDEyPZ+/MtRLdkL1pEoHeC0J+
         gXrEKMhnbxYg66roPjpaq84u95xIeiKLqFwr6gZRgbMVE1Ejz55JtyaTrEwjb4KbTcfG
         PpIGABEtexnVZHJNYqRPwi+RilJspBYCpSHEv7rBDHbghA1z5RyiTEM2DE/c619SP3FJ
         TbuHDmkJTLnNPptMWYqQEXm86UexWo+n/qwGjWsOL0TI/mnhmAyDZPYrSSrudAVE9pX/
         XHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Phn676ck9fxFNj85BpKV8apw8QC3TViwDCE0eTe2lKw=;
        b=pplBLaGn/xaQC4dv9dzGQ8iFl5tby/wY8Kru9Q1kLNAFVCa7oSUS3jNJtbYKn4oVDV
         Fudd1bj+K1HjNHaxdUW5kdsq/WE1zWDVMLtfM7Fgmck7Glixd7gloXwObFyg1daBKaYC
         iBYf1IK6ljTQYx01MF+WEsgHFr1wWIyPKvrClGb8xThVmELkL+QMSoP/pm+OyVQRtqJT
         GWRb8mHO/lDP65h3BT47YBzf39V47pitUYdQZFcX355SYTUz0LOo2A6crRniXN7jPM6T
         rN4HOW1NzIECabN/spNijmaIC+X2Jx29TVlnhrRAhJxQoL9Q4AZ8iZZGJkS7XCz5H8gF
         zfEw==
X-Gm-Message-State: AOAM5329EJr3aS93ORpnNgjJl4uRzo1OWXRwxv0vXfmCt0pI1IPe64vv
        QrSfNFUFyWVVg490XCgkBlRkZg==
X-Google-Smtp-Source: ABdhPJzidbt0pzET/EtSowQUwY6EY9mSfVSCXN4I8uUlbcM+UuJ2gQy4RnxaDKlVsybR+D7AZPvq9A==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr50274670wru.89.1600683660027;
        Mon, 21 Sep 2020 03:21:00 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 29/49] staging: media: zoran: convert mdelay to udelay
Date:   Mon, 21 Sep 2020 10:20:04 +0000
Message-Id: <1600683624-5863-30-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As asked by checkpath, let's use udelay.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
index 3a353130afb9..82d522c1a528 100644
--- a/drivers/staging/media/zoran/zoran_device.c
+++ b/drivers/staging/media/zoran/zoran_device.c
@@ -1315,9 +1315,9 @@ void zoran_init_hardware(struct zoran *zr)
 void zr36057_restart(struct zoran *zr)
 {
 	btwrite(0, ZR36057_SPGPPCR);
-	mdelay(1);
+	udelay(1000);
 	btor(ZR36057_SPGPPCR_SoftReset, ZR36057_SPGPPCR);
-	mdelay(1);
+	udelay(1000);
 
 	/* assert P_Reset */
 	btwrite(0, ZR36057_JPC);
-- 
2.26.2

