Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8292F195B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 16:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbhAKPRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 10:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbhAKPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 10:17:38 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC02EC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:17:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 190so173600wmz.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 07:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3V5kTTS4a3gz1m9EB+LiOHUnvU/xEqJ67ethW81gCEU=;
        b=Ue2pE50LK8hgmdGzCq1pb3qowjevnViBjTsApMPbErJMwtTgMRdh8+JdAAW47V+KAg
         XicKlCVkxVHHbj+S5fGPs+Eps/7ETjlTvu1kfrkofRXYCdwxq2aMgU6IyuluObvbygq1
         36bjw9zE6zrqHp56YJ+Zd5NeHeY/oVlO5TGt1oeo61iNWPDUpufQd9mpPOXqNLPxy7Ws
         QBly51FK7NjRIfDGoMyFyQuyntYIsnmiHCdt5SamE9npWQPZfMNQG678jsy2fER/RD8+
         fC+oo8tc4NAC6pjHh0d7fHodSQb9GcOZ2ORP8Wzqi04WVTTSdvUV5i6yu6EoY4BBn4wQ
         2YCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3V5kTTS4a3gz1m9EB+LiOHUnvU/xEqJ67ethW81gCEU=;
        b=aV6FgzmXG6LnzX1LAccuUw9/lUbUh2SlsoeYMvPnSSsDq+s6sruaxz+Am3wlNKzn+U
         HWFT4rm6HqDhDOgly90vJSvHQCHoLRdWvC3/0Dw0sTqq8vkCx/wNkkHBM8UHrwPu3f7B
         kvw3oHOfcVMhEQGBoJs7pNx9ymCpcOyKvVE9Qt6nAOUpE9DICaOk1EjaK6HNY4GCzd7v
         dY5EIYRtNftLJBXTjUVYnMv+CTFFCF72CcrgC4KwAIYIJC33rwHZ69AyZNXZEoka6PXW
         +Zb1lwk0ghdRtwifBemtLaYa7WNOqcQmA+q8G31YLQbmvoWWvgPO0aR0XSQTexIJe3bc
         j/Fg==
X-Gm-Message-State: AOAM5335XlfDunchjE6aQVSPdT+SJWNjZWjPqMgoASLXkd96AlrscYgU
        uki9dFdMfpNmdyyYX4dxLZY=
X-Google-Smtp-Source: ABdhPJwt7MSBlYrmbAe7A8nsKgB9BV6xeDPh5jjs81Sl6n7ZL2DYnDy+CsIsmqw3wsrQ5GTfe0fp4w==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr181601wml.174.1610378241664;
        Mon, 11 Jan 2021 07:17:21 -0800 (PST)
Received: from Saturn.local.all ([81.221.211.103])
        by smtp.gmail.com with ESMTPSA id h5sm25549623wrp.56.2021.01.11.07.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 07:17:21 -0800 (PST)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 1/1] ARM: imx: build suspend-imx6.S with arm instruction set
Date:   Mon, 11 Jan 2021 16:17:04 +0100
Message-Id: <20210111151704.26296-2-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210111151704.26296-1-max.krummenacher@toradex.com>
References: <20210111151704.26296-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is configured to use the Thumb-2 instruction set
"suspend-to-memory" fails to resume. Observed on a Colibri iMX6ULL
(i.MX 6ULL) and Apalis iMX6 (i.MX 6Q).

It looks like the CPU resumes unconditionally in ARM instruction mode
and then chokes on the presented Thumb-2 code it should execute.

Fix this by using the arm instruction set for all code in
suspend-imx6.S.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 arch/arm/mach-imx/suspend-imx6.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/suspend-imx6.S b/arch/arm/mach-imx/suspend-imx6.S
index 1eabf2d2834be..e06f946b75b96 100644
--- a/arch/arm/mach-imx/suspend-imx6.S
+++ b/arch/arm/mach-imx/suspend-imx6.S
@@ -67,6 +67,7 @@
 #define MX6Q_CCM_CCR	0x0
 
 	.align 3
+	.arm
 
 	.macro  sync_l2_cache
 
-- 
2.26.2

