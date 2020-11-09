Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6092AB808
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgKIMSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729735AbgKIMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:18:35 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1208BC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:18:35 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id x15so3830338pll.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 04:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Rwi6JrG1Bh8jLLcugHVfWoJr8ivQS6AwCC3H82H1b4=;
        b=I7miMOGhEdT7J0NAhMTCfKP0YfrV8cuu7jT+qTWfzx/UnjvsFFumY3ebjucZ/PY2pX
         ky0LqVkrGZhe6mB1ixA2yMyu82I9qlME5l0pgUcbg1SSgGYKpmjCRQRm5SnNQf3K0Tg8
         m15vf4PW2cnoTUbupzdVt1Vk6w6U7qPXghp8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Rwi6JrG1Bh8jLLcugHVfWoJr8ivQS6AwCC3H82H1b4=;
        b=TDKOY/Q+e+zX7jRiNv7wuu7YUCYay/0B1DFEqW3qyMsNxqfzcY6XNYhIlE/AU9qs07
         H/hF37WcG4DRPO9BEYmswL0jqD4KCIbYGqnzPwLhv+2tX5EGAq4JqM0SRTeMaYQRvNXx
         XZuqf/w1KDngV4a1TybjHrQN6DBIfJUXM42R6giXFcWlKCPSuj+g3Bcu+ecW5CJ6Oskn
         0QS3sRD1AjfJ+DRh2xV1NkpVzze8bG9xE5ONFZ0OJbhOaEdbx+D6fMhLs88HafKG8MaP
         B9R2nGASrqdXcfzu/0yt3c8erzOeFD2EDwAFyUFMGeWZsniyb0QUqmJAk0q19YCQKbKU
         UhEQ==
X-Gm-Message-State: AOAM5308rTcivPXpECuWIe1ch70VuPPaBDH/kJpDA+bM2V+lhNNxe6i3
        25M+VAODdE3D+a2FhI4RaMId1TXFT7xDfQ==
X-Google-Smtp-Source: ABdhPJwIBAsn/3BnPLGIM6HYZYH0I3QBpnJKi9ej88OHsCBcUhLvc1UBv92TWmV6pvx2zGKesCPqAg==
X-Received: by 2002:a17:902:c411:b029:d7:dd6e:60b4 with SMTP id k17-20020a170902c411b02900d7dd6e60b4mr5462718plk.66.1604924314644;
        Mon, 09 Nov 2020 04:18:34 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id i123sm11425204pfc.13.2020.11.09.04.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 04:18:34 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        maz@kernel.org, w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v3 4/5] ARM: mstar: Add gpio controller to MStar base dtsi
Date:   Mon,  9 Nov 2020 21:17:30 +0900
Message-Id: <20201109121731.1537580-5-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109121731.1537580-1-daniel@0x0f.com>
References: <20201109121731.1537580-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO controller is at the same address in all of the
currently known chips so create a node for it in the base
dtsi.

Some extra properties are needed to actually use it so
disable it by default.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index f07880561e11..81369bc07f78 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -109,6 +109,16 @@ l3bridge: l3bridge@204400 {
 				reg = <0x204400 0x200>;
 			};
 
+			gpio: gpio@207800 {
+				#gpio-cells = <2>;
+				reg = <0x207800 0x200>;
+				gpio-controller;
+				#interrupt-cells = <2>;
+				interrupt-controller;
+				interrupt-parent = <&intc_fiq>;
+				status = "disabled";
+			};
+
 			pm_uart: uart@221000 {
 				compatible = "ns16550a";
 				reg = <0x221000 0x100>;
-- 
2.29.2

