Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98FC27BD2C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgI2Gcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgI2Gcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:32:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAEDC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id h26so3250015ejq.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PlpRTHPfsQbt8cF0PyuzOtJYzSAE/D04UwzIPu9Ecuw=;
        b=EjFVmcsz+JPujl3lApj0NOwA2aVknMDCURrU2CWXDEUUoXhdlkLv4AGDEAar9D9IqD
         wXAJqIGAzslwIeGng9hQ7bunPTyLB8xl9Vc9oeyoZJQh9ECxVHxhDqxwtj6dnXXIOZ3Y
         mFk7sh5uW15CQ3vQL0Ack+W5LV9j9JgxerjxfT2OzdKaHhb8lCAE9P5JSt3UEwHKXfvP
         6ugt8LymREhemWEcyDZ+5A0Z0tGjqfoLgORH1/cgWxV/liYRadQBSIVf14QsUYkdkVP8
         eoVc4+bQI1Yl5fynyJq2eB/dBKiDLaj8Ae8XSNhm3FNIMw5e0q9P45MNme709Q9z44+Z
         SYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PlpRTHPfsQbt8cF0PyuzOtJYzSAE/D04UwzIPu9Ecuw=;
        b=J4ivXFENwvrEm9TwSZJtPa3EGRj7ib7EBsnaGbtIOvj4GIzBwEXqyUg6h6JxD6j0vI
         riO5kcRT6FCBAhlxVCtvHYOfxH6TU5lGgBytc6PDbKc+hSETMJwEj4+1w5K9nGPVpQoI
         djEbtUipoOzQM1coUHE80s/Irzh3iPq3DpRQXO4SNDCgz+vfsqeHX9OI1La1octftwP3
         N8MiRVfly4Epe/EkolTfQDn6Uw+m9nKUcppGuBmy1qhGIv//btDuLlWxiIxbhbvBjx17
         OCapxxbK8QmvOixamd4D/fSq73CEx9PEwOjpvn15MfdFhveQOnHZITayb+EqrD1HeWQF
         lVCw==
X-Gm-Message-State: AOAM530t7AFDo//qvNarqWM1cLwMqe6nceWSWojfzLmDTaV/V8gjlXPA
        9dNTkl8h3AAI3A0evZz/qA0=
X-Google-Smtp-Source: ABdhPJzyewZMd20nxQPTtWurYG7BsEyDQMhJwffyCTSC3oG06OUKMFmcw6PHflleOiBMD2Ak2IJT1w==
X-Received: by 2002:a17:906:9941:: with SMTP id zm1mr2332350ejb.288.1601361159436;
        Mon, 28 Sep 2020 23:32:39 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id r8sm4730915edy.87.2020.09.28.23.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:32:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: rtl8188eu: clean up indent style issue
Date:   Tue, 29 Sep 2020 08:28:47 +0200
Message-Id: <20200929062847.23985-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929062847.23985-1-straube.linux@gmail.com>
References: <20200929062847.23985-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace spaces with tab to clear checkpatch error.

ERROR: code indent should use tabs where possible

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 668a24f25fce..14be5a703615 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1730,7 +1730,7 @@ int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	    (ndisauthmode == Ndis802_11AuthModeWPAPSK))
 		authmode = _WPA_IE_ID_;
 	else if ((ndisauthmode == Ndis802_11AuthModeWPA2) ||
-	         (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
+		 (ndisauthmode == Ndis802_11AuthModeWPA2PSK))
 		authmode = _WPA2_IE_ID_;
 	else
 		authmode = 0x0;
-- 
2.28.0

