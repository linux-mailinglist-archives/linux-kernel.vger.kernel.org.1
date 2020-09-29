Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BCB27BD24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgI2Gcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgI2Gcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:32:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A37DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so13420492ejk.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ygH8c0/xNa/L0WeRqAttajGmFCGSI3CQQznLpjHOeI=;
        b=RFefGDaPLk/BdTI0MuXP9sB/TcXZFxg3LKu3B0V0aTK0w/5iAs7K3yua5b1/BwjTUZ
         tm6zx4xGbmEAu4XGcmgp6AyPk7GNFyfcX4S5wy9l2Cq6LwqqJqlwNdFCN47MtX2rqyo3
         XFTsVyocRP85sU/BLD1GaymZ4p2YllhMb74FuMQAZno3cT1W6OgXaS6TOddOaK5+v16T
         PY25HLYpp6ysBVjWMdqiXTtyOdE2rt1Fblg5w4h3Wzj7/FzzJpgTX9rGuS5xSBvXJePT
         riDT10+Vg/YG+Gv4Gv4BE3OOytGtaXGEIDuzVxoV1OP+nHfSTxsDVjYIgw9cKaYnwcro
         yMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ygH8c0/xNa/L0WeRqAttajGmFCGSI3CQQznLpjHOeI=;
        b=uPe7gU3V5qkGMisyTVh+8Z1pS5V1P8NVXoLosHN+tpQJ+UMoWSzZucB0CRbP+jkK1b
         J37R5qQT0Lj81J9jWsqPyZbkJMwnSUppx07Bmud5+NM9YLSON2kHRhjZdFah/JEWnrky
         p7hJZbTDZxc4GGbiNtgLKvHDV7xK0LOPCyHFDxmd4UGUEHdoWrs50WOcr4GMFH6D7Qv5
         X/DEcdr19eAi4oUDOSUSnM8Z7VuqhT6ahycc6wIU7TKPVUqsNt8dvo8Hx3C2xyC4sP/d
         HC19pJ80w7uQRSiSUmVr0+Yf1Y2ZLsQyXdgQapSk0HszYuQ/+aFiL8NT1hkMKpyNLY8M
         YcQg==
X-Gm-Message-State: AOAM532ysI8OWtUVbJnm1WVLE+F3wW5fGVjtjk/Gdzn9imOziw+d3kaS
        jdXHw2nyzKFgvU5qacRTeQk=
X-Google-Smtp-Source: ABdhPJzC8WHlD8JpD7ZWD6a+vTEyfsM7azwKe2wwMcEzQAH1RzV+WJwPkvGHD2/C/Uhv8k4xb/tk9g==
X-Received: by 2002:a17:906:91d3:: with SMTP id b19mr2391419ejx.235.1601361152992;
        Mon, 28 Sep 2020 23:32:32 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id r8sm4730915edy.87.2020.09.28.23.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:32:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/8] staging: rtl8188eu: clean up comparsions to NULL
Date:   Tue, 29 Sep 2020 08:28:41 +0200
Message-Id: <20200929062847.23985-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929062847.23985-1-straube.linux@gmail.com>
References: <20200929062847.23985-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up remaining comparsions to NULL reported by checkpatch.
x == NULL -> !x
x != NULL -> x

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index b7a8c199de54..46ba55a8952a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -142,7 +142,7 @@ void rtw_wep_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	struct sk_buff *skb;
 	struct lib80211_crypto_ops *crypto_ops;
 
-	if (pxmitframe->buf_addr == NULL)
+	if (!pxmitframe->buf_addr)
 		return;
 
 	if ((pattrib->encrypt != _WEP40_) && (pattrib->encrypt != _WEP104_))
@@ -589,7 +589,7 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
 	u32	res = _SUCCESS;
 
-	if (pxmitframe->buf_addr == NULL)
+	if (!pxmitframe->buf_addr)
 		return _FAIL;
 
 	hw_hdr_offset = TXDESC_SIZE +
@@ -602,7 +602,7 @@ u32	rtw_tkip_encrypt(struct adapter *padapter, struct xmit_frame *pxmitframe)
 		else
 			stainfo = rtw_get_stainfo(&padapter->stapriv, &pattrib->ra[0]);
 
-		if (stainfo != NULL) {
+		if (stainfo) {
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo!= NULL!!!\n", __func__));
 
 			if (is_multicast_ether_addr(pattrib->ra))
@@ -834,7 +834,7 @@ u32 rtw_aes_decrypt(struct adapter *padapter, struct recv_frame *precvframe)
 	if (prxattrib->encrypt == _AES_) {
 		struct sta_info *stainfo = rtw_get_stainfo(&padapter->stapriv, &prxattrib->ta[0]);
 
-		if (stainfo != NULL) {
+		if (stainfo) {
 			int key_idx;
 			const int key_length = 16, iv_len = 8, icv_len = 8;
 			struct sk_buff *skb = precvframe->pkt;
-- 
2.28.0

