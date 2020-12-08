Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322162D21D7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgLHEJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgLHEJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:39 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3FC0611CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:57 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id t9so10031493ilf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HwpMKueyptN2eIepuXOY9cYUJEcZH7sf0NCC3OLkPCs=;
        b=NTyLQ8MXTKKPf/kK5GJm/MQ3UGmGD33SH76jpgZdEs4CHtTL1AcTZzUWVmz9/JFudE
         1l7QfTdd9D44rTeRaPbgv7U/BcKvPDLDpXGKbb0naejr89mX/JpsiynTAaM50qVtv4zr
         sMe5OA9VA5YOFqeq+GiYmd9K34aJYBQ73DbVbUzVZ2MkfRVstYug/GhYCb/FZ0Q5urWk
         FNy4WxKX7g4wUE2AX+jhn/QlBsquAklyygtq3myUVgZcjPd4aNSrr5uFk7HTrAlWauCE
         K4lwtFgKxIY7iBFeCzMhrF3fxrJ0dN5yLJHE2sLNTxvGBVMZJrFjweZezwkBkdxT6ugg
         bTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HwpMKueyptN2eIepuXOY9cYUJEcZH7sf0NCC3OLkPCs=;
        b=AsDk1CoWv9CVBZNc6KVJGdFS3tXmKKltajIvsHn/CEdjinSFDwlK3vOK/TpG5WfYiU
         iLwgJWT44ONnC5ORsEOmtlxx36L3Idra/ZpYNmXSv0ZGhkrNWQ6HvORauLcc2yXARBsD
         QrKiSTHIbclmUOaEPfuo6c91m9AbcHJZl2AkV7ovZRelILoM2kAtm9g2MX4l01Jxvz/E
         J5U3M8aEjUN0yIjpM3EIBQ35kA2AbPk1qGQ/CtEKmszCYAdNQrCLWCDWA7sLwvi6Nhji
         yDhNYSLto02zhq1wJ9EBJRFtZpkLYdb4njjtpuJNCepWSgi7LLTC88Jj9AggsGDLC32p
         yyhw==
X-Gm-Message-State: AOAM532dOKu935CvtGWSPwSSabvTwCvL/ri8WaQEX4rQBQF9G3zbs3UM
        opSoYUrjuLTu6Xaf8+mNmzA=
X-Google-Smtp-Source: ABdhPJwBjrv2hEYo3WZQBfIH8w/A7FOc/lh2pOHiMWPiM8F+1xVTqpoKhGuRhBcmRxZ99brefZZqNA==
X-Received: by 2002:a05:6e02:194c:: with SMTP id x12mr8860799ilu.175.1607400477141;
        Mon, 07 Dec 2020 20:07:57 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:56 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 17/21] staging: rtl8723bs: replace EID_BSSCoexistence
Date:   Mon,  7 Dec 2020 22:07:29 -0600
Message-Id: <20201208040733.379197-18-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique EID_BSSCoexistence constant with kernel provided
WLAN_EID_BSS_COEX_2040 from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index e9b14fc8b10f..b6e255f6cdc5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4096,7 +4096,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 		iedata |= BIT(2);/* 20 MHz BSS Width Request */
 
-		pframe = rtw_set_ie(pframe, EID_BSSCoexistence,  1, &iedata, &(pattrib->pktlen));
+		pframe = rtw_set_ie(pframe, WLAN_EID_BSS_COEX_2040,  1, &iedata, &(pattrib->pktlen));
 
 	}
 
-- 
2.25.1

