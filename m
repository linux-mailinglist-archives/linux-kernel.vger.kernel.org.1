Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4567621C949
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgGLMd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 08:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgGLMd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 08:33:27 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440A1C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 05:33:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id k17so5674670lfg.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 05:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6sNIw2XPzIq0VfJGAFCHOZVum8taNf/8D8Ge/FQ7ik=;
        b=XTSQMi3c2DwdMBZx3YYbYBCEc30+2fs3vNdLDyjwOhV+mr8KgRWmX8+mEp0KCeVN5k
         TpkbUndSDw17EVXMgUVfJmC5KFuPrrBsxgVpXZOBtwmmxqWpoKhgSwLTkV0bu508Eepz
         AL9rzA1A/DVXvWRvaDYd05qss38pRCEd6nHKsYbkKOvnnai498K05vhkx+i/BUcLtMjD
         n9g0XINzdoXEXhMH+TIAQpTHz6pl+8XccdClDoMcSmK6qToSgVcCs55uvwxtXm1ejElV
         bOn+lKX6HDEdaxiI/OQWkgJx6ht3tZbT3eQjHtWUozeXELRUGgSTdRSdSu8r8w+63GDb
         ukKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6sNIw2XPzIq0VfJGAFCHOZVum8taNf/8D8Ge/FQ7ik=;
        b=b9JZTCtXEmOGMpo728kOjhHXCiEufFSuUw56Jopo8AIxcjSiG8jBOTwLPVwhnrVcAc
         2/Bj0ThPGnEd2ASHuTIljTtFwOmKVIDERJOBGTssW+OhEXTHsXFtmgYePGniw4Wyh/iP
         yWKpvVxGcL9335VXHZ01i4etSXyeqVtM8kcTiNzsKdYgoyGKtNn8bZGtrqJ2odH4Lw2f
         Dyfm6hL2GXn+0FwdiypMACDLFTi6tD0uMQMYkfBTl/83q4CLaxJtLcrxqf5DFRghZaqz
         QMd/iWG5sGPTf1kSq5O4K+C0QYuSdZggTmaUjY2h0NzfX2lwGQQPkK2PAEq5mw2x4hhe
         V8Hg==
X-Gm-Message-State: AOAM530EKtpMOuBJWQsJFa67FE4I9Acso238VaTyWWY4RZ1szKKkz6gT
        2y9PGYX46H+5AbWCup1wMBZfgr5r
X-Google-Smtp-Source: ABdhPJwn/U7bMpXBeJBWvB7sqdmC+drDGd/YsFLewuXZCGZrYjrcy6IAvPfbdXfK3E8gM7eBYCd1Aw==
X-Received: by 2002:ac2:5593:: with SMTP id v19mr48799025lfg.43.1594557205710;
        Sun, 12 Jul 2020 05:33:25 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id e10sm3422877ljb.118.2020.07.12.05.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 05:33:25 -0700 (PDT)
Received: (nullmailer pid 553466 invoked by uid 1000);
        Sun, 12 Jul 2020 12:38:30 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Soumyajit Deb <debsoumyajit100@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused members of struct xmit_buf
Date:   Sun, 12 Jul 2020 15:38:21 +0300
Message-Id: <20200712123821.553420-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused members of struct xmit_buf: alloc_sz, ff_hwaddr,
dma_transfer_addr, bpending and last.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/include/rtw_xmit.h  | 5 -----
 drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h b/drivers/staging/rtl8188eu/include/rtw_xmit.h
index 12d16e98176a..3c03987c81a1 100644
--- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
+++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
@@ -193,14 +193,9 @@ struct xmit_buf {
 	void *priv_data;
 	u16 ext_tag; /*  0: Normal xmitbuf, 1: extension xmitbuf. */
 	u16 flags;
-	u32 alloc_sz;
 	u32  len;
 	struct submit_ctx *sctx;
-	u32	ff_hwaddr;
 	struct urb *pxmit_urb[8];
-	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
-	u8 bpending[8];
-	int last[8];
 };
 
 struct xmit_frame {
diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
index 017e1d628461..61ced1160951 100644
--- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
@@ -24,7 +24,6 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter,
 		return _FAIL;
 
 	pxmitbuf->pbuf = PTR_ALIGN(pxmitbuf->pallocated_buf, XMITBUF_ALIGN_SZ);
-	pxmitbuf->dma_transfer_addr = 0;
 
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-- 
2.26.2

