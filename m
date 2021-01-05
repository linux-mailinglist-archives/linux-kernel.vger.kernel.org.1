Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5491F2EAC11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbhAENl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbhAENl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:41:56 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F7AC061793;
        Tue,  5 Jan 2021 05:41:16 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q22so18366040pfk.12;
        Tue, 05 Jan 2021 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7letHSDRCJNOKJup/ibw3oXnsHB5WSZt5JN9/sgSl30=;
        b=vKYsQIii0viONYsWTKyxDgRcMWT6dxiC4v3Z4rBOx0CNx8uejtD9XX3AONAa5p89zY
         Z7DmiVrppiviEcZC0/MHANQc8Vpq5s4PDyvbz+gpYmafQAyMirebJHBiAHNkDp2KG9g0
         8D5w+OakfKl09h0EFT3oY+FfmbFKV2ecU6x5ZUKA3PqxZkZNfgxDg428GxBf+ZEYL69x
         ek6tfdhIv1UWlOZlo1ADwOLqgTBiiOuVgT0A5Ml2hXzfHecwYVt6o6bq2ElVnUNcGZnY
         UCABMhEILHNjyIqrw7F5a3kluTspAt8lqCl2F/ivcK8tSK/9TWfobtHdUhvqF4wH64Yf
         grDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7letHSDRCJNOKJup/ibw3oXnsHB5WSZt5JN9/sgSl30=;
        b=YEOiBjcdn9VxkhVojpY0j6S63KlmiVSkzhq0vB0ndAupaep9gpiaQqocdtmJnW3Rre
         B5TvsECyjNvsxoWQvq7hb8qBC2k/R1LCbYCt0s/nUE91ruBfJbzZh5ZiC6IhNaCan/uy
         ejIx19kHMW/jSjQ6pKKfhK2xmSpTHbwhhKmdfPZFyD84fRODsibrjhfzR38udab4iFkW
         7LWcn28ltRFja5psZabYyi9MqzUnfY7eIKnyFrcg4xioTDDu1CV9z2SVIZZdkzE+oZGQ
         w/NkIp2q2/99OyhhiwtZ0DqHMKMAHFJ5Nr23DHMYUX08HH6HtffulH9tH3GaMi4Qfptv
         ohBg==
X-Gm-Message-State: AOAM5320Ti3Fj37UpNm5YkHEr6Cnmlp8mgU8m2yzZiEXFf6H3DQIw+vQ
        XwRMcCqyHMMd04Soz0JhdlfiavLHBwc=
X-Google-Smtp-Source: ABdhPJz5tlUxfXLPXqLG9+l/LBsDN5VNJMy8cvu/qtpxDz04gex44o3Ys8BntdM4CnffzC+urYWo6w==
X-Received: by 2002:a65:624a:: with SMTP id q10mr32512331pgv.194.1609854076436;
        Tue, 05 Jan 2021 05:41:16 -0800 (PST)
Received: from masabert (oki-109-236-4-100.jptransit.net. [109.236.4.100])
        by smtp.gmail.com with ESMTPSA id d20sm3425041pjz.3.2021.01.05.05.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:41:15 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id 626FB236040C; Tue,  5 Jan 2021 22:41:11 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] csky: Fix a typo in Kconfig
Date:   Tue,  5 Jan 2021 22:41:07 +0900
Message-Id: <20210105134107.217920-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/csky/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 7f1721101ea0..ce680f6e3b4b 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -243,7 +243,7 @@ menuconfig HAVE_TCM
 	bool "Tightly-Coupled/Sram Memory"
 	select GENERIC_ALLOCATOR
 	help
-	  The implementation are not only used by TCM (Tightly-Coupled Meory)
+	  The implementation are not only used by TCM (Tightly-Coupled Memory)
 	  but also used by sram on SOC bus. It follow existed linux tcm
 	  software interface, so that old tcm application codes could be
 	  re-used directly.
-- 
2.25.0

