Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F160327BD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgI2Gch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI2Gcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:32:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6837BC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id q13so13338252ejo.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+v3CNWiULTSXTkzBN+W9pmDaVzfA2hpJcEqVzTq83Y=;
        b=KaSz8hGrumNfx/R+23PNmhyRItc7/Is255868qgs6uBAWnWvnK+WuoIAVANwsGFF1x
         idPgVdXevl2RZ+XyhLLIaG1E40F3TKDAf0VnutVyA/3x+JmcgTESVUObzadTHENU3KpZ
         M3dP/7kY5j9oO+YQfYw62yt4XcgkLM6TJHvRxdkQ1JEH2RR35nBEE/sO2RP2/VE50HDC
         kQ8pRz8jcG03tSfXMXNWRHwcSz7eRqO8/bjSRvy395VMuYVo9kY/Ua16kNC8qgFqywxJ
         1Snl0BbTzTPVx8J1UC6KXiasHN7+SshyZNkzA04zi3jKQLVJ+Ry9/HLAPAYWX62XCrBh
         WEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+v3CNWiULTSXTkzBN+W9pmDaVzfA2hpJcEqVzTq83Y=;
        b=Tw3cbbcw2DaAC8zY/JfGyFjd1+shCFsqqF5a2Qiyl0w0SGxk/G4Cvtm3DlOqgftBu8
         sib/iuNn3Z3hC0UTiDahnJnj2AUZAu3icTqw0vJjNR2jxiH6gJ/nwJzVjfvpK7SZscTj
         Zo3KZh5x2FFVGw+NNU7tI4E4jhBTWXkB6STZBcbXzqjSOic9wM9z+Kwz07HhLKWkxOH0
         i3/mWMnCvjl1GC+APWsWOY4v89n5l/hvWbR0kYbT0YtpEe+NAhRw4/l4IQd/SrK65LjX
         qVxJwCODIYeE+i27MadPwVWUAe6eRZDjMWaoZ/1iG08ml4IbKpYPA31P5AIruaFTIDtU
         PBxw==
X-Gm-Message-State: AOAM532jIA9QcbF3Wv6yJllPoC2+UPOstU1Cgb9aqxDVfSBjohuiZ7NF
        XiGqivZZ3aC/bD8yZ4tcKmm1Zjnhsuk=
X-Google-Smtp-Source: ABdhPJzKoC3hXw5jge+VadNKeezoyAgFUhqHsNPaznbGE+2CYzOLskBkKGcCwZoS96Y7ke8MvoAdyQ==
X-Received: by 2002:a17:906:8258:: with SMTP id f24mr2242609ejx.551.1601361155114;
        Mon, 28 Sep 2020 23:32:35 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id r8sm4730915edy.87.2020.09.28.23.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:32:34 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/8] staging: rtl8188eu: use ETH_ALEN
Date:   Tue, 29 Sep 2020 08:28:43 +0200
Message-Id: <20200929062847.23985-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929062847.23985-1-straube.linux@gmail.com>
References: <20200929062847.23985-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ETH_ALEN instead of hard coded array size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/include/rtw_security.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_security.h b/drivers/staging/rtl8188eu/include/rtw_security.h
index bfa080d6a1a9..737f1da81f6b 100644
--- a/drivers/staging/rtl8188eu/include/rtw_security.h
+++ b/drivers/staging/rtl8188eu/include/rtw_security.h
@@ -82,7 +82,7 @@ union Keytype {
 
 struct rt_pmkid_list {
 	u8	bUsed;
-	u8	bssid[6];
+	u8	bssid[ETH_ALEN];
 	u8	PMKID[16];
 	u8	SsidBuf[33];
 	u8	*ssid_octet;
-- 
2.28.0

