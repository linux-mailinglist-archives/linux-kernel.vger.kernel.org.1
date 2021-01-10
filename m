Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7612F0A60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 00:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbhAJXZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 18:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbhAJXZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 18:25:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613CEC0617A2;
        Sun, 10 Jan 2021 15:24:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y23so13435133wmi.1;
        Sun, 10 Jan 2021 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JIOSC/i/0EBgHvOloOEK1Z2ZW040Bk9xwSmCAqjjzc0=;
        b=pN4l2zjiHx3I1otNZR1Cx4RRRm2yHPeAALH831CLMhdm9eU3PstpdxxnCknwGVWoY9
         N6XHEi6idUHipPcSckBztAV9WZhyUOmxvTOJo9er/wI8pJJKIx63cukxWQ8pbkUtQIz/
         PuMWR190c4u1WHehgsXY2XaSbMeHXpy2QLDCem0tlCYcxQeNnYHTQXUEbcgfbB3nvr5h
         vlpynfnLaMItEp8ZmS010sK9GbsExXXC0JSisu1qsKxnJ8AC+pt+BTsbh6ViET95hDYR
         uKi7T6DqTzfD5XcBoLioPxIy1dahQjt83jUiDM1kpaSTTOs8ctUij6/pk9wXx2aJs7zL
         jIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIOSC/i/0EBgHvOloOEK1Z2ZW040Bk9xwSmCAqjjzc0=;
        b=W9Eka0zqvNMNhYDuYhNQ2uMGJNM8w7ngV1My6lcxnj5bBnp6V2EBBlqsyXkxFa9+jj
         X5e6TOtbBTy6tlYiNdp0ugtrHOmHPmou784T8vqbwED9Kspu3Qvj6vyw3VlAqRDkWbc3
         guHTfFP6wgV0Gtjn52JfAfXiA+CIdd4sx7XJu7lEo5Rqy4mrmippdSbsLvloN0HXzWw1
         jIJYZSrCfdpHTQ9uJDCmL3Zzo0cElk4XWHgYVELHvkYgGLnJJrILCMnr+mUp/hTcld8G
         k112TEcYOHkdSsi5vgUTaOaIT4fmVF282QpV3XpwXif66F4xCsg4v6mburXayJs6y+0v
         MAgA==
X-Gm-Message-State: AOAM531K8xq+m0im9G+hNSsUvTzB5VlxqidtyuYGowIKX2ZI3a9V5k7V
        w/rs0SBVZZFpkTNmR5bkT2g=
X-Google-Smtp-Source: ABdhPJzSj9MOscC45PoOFZmRkWyoG2JuVCAe0IIV7jATCH5mJuZZeJ3L43kaJ3o52+TySl14yjEtpQ==
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr12457537wmi.146.1610321063691;
        Sun, 10 Jan 2021 15:24:23 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270029536a450755141e.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:2953:6a45:755:141e])
        by smtp.gmail.com with ESMTPSA id a12sm23426104wrh.71.2021.01.10.15.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 15:24:23 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 3/3] arm64: defconfig: Enable PF8x00 as builtin
Date:   Mon, 11 Jan 2021 00:24:07 +0100
Message-Id: <20210110232407.1666059-4-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210110232407.1666059-1-adrien.grassein@gmail.com>
References: <20210110232407.1666059-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is mandatory for the nitrogen8m mini board
when booting from the sdcard slot.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 3ca9d03d5cb3..bd6ac11ad6fc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -603,6 +603,7 @@ CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_PCA9450=y
+CONFIG_REGULATOR_PF8X00=y
 CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
-- 
2.25.1

