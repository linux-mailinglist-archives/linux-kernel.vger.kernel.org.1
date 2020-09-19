Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9030270C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 10:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgISIyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 04:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISIyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 04:54:20 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02767C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:54:20 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 19so7473524qtp.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 01:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8RkoIvJj/P1T7mgVICWKb37QwYd4KVIZEz69XNANi5M=;
        b=cigkbj0lcJ59ciYcNd6AWopkcIZ3+DmIZGt+u+7OEvMbOqH6lNwtjfu+z+NWAyWHul
         p4Xaj6KY8kEVxTgo0WKLe6JELJPdUfB6HVeo7CJG1a0WFgmoDMxiK92o9Bu6DIqDKMVh
         CUqCYCT1EvEzqT8yoCwCsiCVkoZ5f4vgN/sgciLO7KsdqN3KrvhBGXwCEZlszzgIufHI
         Ly8VO7HD+zHd1lXOg/fImNfBUWdRPz9quwBjSSbbnUb9cTRAAkmwIwvg3eo1j8fekEIK
         ryfypECF4DmVZDSzZZ1RqNy2TBNhPWmxmhaRu18BcN2gvEDXxw27Dw4pQ942kTYMkSQq
         F5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8RkoIvJj/P1T7mgVICWKb37QwYd4KVIZEz69XNANi5M=;
        b=opeNU9Bm2iyVT2txrbkAn4oPBcCQMiXfzmMYWvqLNskLUfvgTdOxXRpPuKheuRZ6tg
         gJ5yhErQ1AmUAT1LeyqsZqLYOiatAA7maQ+akhrFPJxDGEFKsHORbS3eNkepo2AT/01i
         PdHMx1CJa+DXRdYNUPNOB9f9NB84c7m1xSst2TIAmj2q8OI8++lIMgifjJdD1BirbXb2
         joJ0W8qlDtg0oROC6u8ZckFOUtp1XSaI2l+yz6J7WYNWhrCVeXAdf6NXTsUtGrIYTkVe
         ek6zLjWcpiEUJ2qbnyzTpb1L0mFxdMQwGVd/gLK8wHevAaRaRvUeAoN1cGGA8hKzh+oN
         RAtA==
X-Gm-Message-State: AOAM532EKBIkyHd9Yz6yZ0VpnaBqeiLN+58gHlg3RWLVMXqRBrmr6k7L
        6MjxxnP9jrUqsocRxrFkaJY=
X-Google-Smtp-Source: ABdhPJzg4Kdphi97Ym9wZXhTnKCYneZmO6m2ez0Gd8A0LMSFFV71QRPYbSENnKqXxuxJBlBr+PFi0g==
X-Received: by 2002:ac8:5b47:: with SMTP id n7mr24137816qtw.7.1600505659317;
        Sat, 19 Sep 2020 01:54:19 -0700 (PDT)
Received: from localhost.localdomain (dslb-002-204-143-169.002.204.pools.vodafone-ip.de. [2.204.143.169])
        by smtp.gmail.com with ESMTPSA id v90sm3924836qtd.66.2020.09.19.01.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 01:54:18 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, lorian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8712: use shorter array initializations
Date:   Sat, 19 Sep 2020 10:50:32 +0200
Message-Id: <20200919085032.32453-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200919085032.32453-1-straube.linux@gmail.com>
References: <20200919085032.32453-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use empty brace syntax to initialize zero valued arrays.
Simplifies and shortens the code a little bit.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 7093903b3af1..fd99782a400a 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -352,7 +352,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 	struct	pkt_attrib  *pattrib = &pxmitframe->attrib;
 	struct	security_priv *psecpriv = &padapter->securitypriv;
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
-	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
+	u8 priority[4] = {};
 	bool bmcst = is_multicast_ether_addr(pattrib->ra);
 
 	if (pattrib->psta)
@@ -363,9 +363,8 @@ static int xmitframe_addmic(struct _adapter *padapter,
 	if (pattrib->encrypt == _TKIP_) {
 		/*encode mic code*/
 		if (stainfo) {
-			u8 null_key[16] = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
-					   0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
-					   0x0, 0x0};
+			u8 null_key[16] = {};
+
 			pframe = pxmitframe->buf_addr + TXDESC_OFFSET;
 			if (bmcst) {
 				if (!memcmp(psecpriv->XGrptxmickey
-- 
2.28.0

