Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07D2EBCDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbhAFK5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbhAFK5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:57:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE13C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:56:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l23so1400101pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPiIqyne/u2Qz7AT5xYGckeWrlA53eIMGFnUpQY9JS8=;
        b=iLjpm8js4Re0AdUQSF0wkcd9zweF7RDqc4Xkhi+SSknrlPp3zzxJ6klxXq13VLfAyE
         dJ3mzAle8o6bTHjvNFv/jmSRzha2tyYoQ3PFcrb/o4ZxZv94JwcrLMG9KQeLRswcWYOt
         ISgWyKUZVBVK0XjlXkEkZzBQh9YpBQ7c3pALVo5iI8kTUq9MPZUseikFB4uxqMPYgW2u
         l66ZxyBhgz94KiNm0QmQZJJ0e5WIiq6zQLZyo45htXepyIW6nLWpLADNr9yQTkTTa1FG
         MShvhlrWeIMotPafAHaPUUs63Zsxx05N0g+cRzoOTJCybMKvO+UiUsUu+Oqu473GiLW4
         kCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPiIqyne/u2Qz7AT5xYGckeWrlA53eIMGFnUpQY9JS8=;
        b=TD3Ac0xlAUm/DQU+z3AMmhG4eEAfg+WOaq8Wy5gnbnyMj+MdN/L+2UgxD19bGk1DnI
         KizC1BBjxqEFumhQw2wquvwP4YF9lNVlKnuF12ORZslebJBTgF1HHtKG6wXzy29NLPWx
         DfC483/pNAC2q8wjaLK8LzTRdz1Wy5i1dybBWM9/GKnYfgkCJ9wFDZXyvjwB3vdIxRB8
         4L+0uupcukqIS1e23yLXSY5CtmLnCJyoY14D+YbXLtPoaO4pu0Co+PdZYP8xN2dlXNqE
         t9Ybe5qnzUAgHrW73/TZVDteVuOFemmxsqy0Fry8s4OEx+lN5MkyYnqAeGGZ3ZNW7NUE
         dl5w==
X-Gm-Message-State: AOAM531fmvWxoW4TA4LLf+KdnktE/PZOd526qBYRnhSDhnTNNE4BTo07
        a3dNM+jxQTPxbMy35OgHomAc/7hgDDBVZg==
X-Google-Smtp-Source: ABdhPJzweOgvF+qbyLNlM34M3Ns1C7KJzu6XTJ/enIHxwL14K03QnQGLNhhRbOUTC9omp3gXq6BVeg==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr3791246pjg.15.1609930618898;
        Wed, 06 Jan 2021 02:56:58 -0800 (PST)
Received: from masabert (oki-109-236-4-100.jptransit.net. [109.236.4.100])
        by smtp.gmail.com with ESMTPSA id 123sm2408449pgf.38.2021.01.06.02.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:56:58 -0800 (PST)
Received: by masabert (Postfix, from userid 1000)
        id E79A3236036D; Wed,  6 Jan 2021 19:56:54 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linusw@kernel.org, kaloz@openwrt.org, khalasa@piap.pl,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ARM: ixp4xx: Fix typos in Kconfig
Date:   Wed,  6 Jan 2021 19:56:52 +0900
Message-Id: <20210106105652.240472-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes some spelling typos in Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 arch/arm/mach-ixp4xx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index f7211b57b1e7..c4f719993190 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -7,7 +7,7 @@ comment "IXP4xx Platforms"
 
 config MACH_IXP4XX_OF
 	bool
-	prompt "Devce Tree IXP4xx boards"
+	prompt "Device Tree IXP4xx boards"
 	default y
 	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
 	select I2C
@@ -115,7 +115,7 @@ config ARCH_PRPMC1100
 	bool "PrPMC1100"
 	help
 	  Say 'Y' here if you want your kernel to support the Motorola
-	  PrPCM1100 Processor Mezanine Module. For more information on
+	  PrPMC1100 Processor Mezanine Module. For more information on
 	  this platform, see <file:Documentation/arm/ixp4xx.rst>.
 
 config MACH_NAS100D
-- 
2.25.0

