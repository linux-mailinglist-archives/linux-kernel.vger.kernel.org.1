Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75B52A8626
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgKEScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEScl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:32:41 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867C2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:32:39 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 23so1686342wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EzsSyiLMCRK+KGDhNZ+R1SpsWBwHUGJI8fLyzOWfOPc=;
        b=Ihy/ccYbfQuL8CY3AV/7PFlwZHYTScu4+VHf3kA0aewBp25A0L2/LzVVKm9HlSuhaY
         KHOW0ZPcVSCS1LnpB7xAH+lGtyBvT5ZD85naP/OMfQFSZwIeuAAaRL+8Hg2sY/FHNZUv
         i/nDkr9lv0m3ifPO9UvBfYW2E8eUc5HM0axSFc3cUdoynh4BuVgE5pVWUeO5fEQwFH5Z
         katUdjj575WJ7cr7Oa1QI8RYSOw5unjy3+4HnnX68scb2pQjK2Ar3obXr7GINVXXAlY/
         0J/4U2pD4pZ0lwtbQBW7waHYtzQiYoIFHd7y1ZtX5NmftUq6NvZqvOCtc5BCEbdYFNQ8
         5+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EzsSyiLMCRK+KGDhNZ+R1SpsWBwHUGJI8fLyzOWfOPc=;
        b=AxeRX302AEqofgM3yjYKujjxCpG/Xy8a0K5+1RbNOfOE9zFYh68mvhL7ajzxshozF2
         EZsx6hvyFQw0fRzfEHtq1KGPTm3/JTLrWPZqQp86TEVRzYSPqWm4yoeN9Latebmem7/L
         LpiXY7NB171VJwFW6Os82ssnft/C4zoOcuWmBJvxngJI9MJbog1bHAW4OotdO8A9TUd3
         SaLsicTVTeasXiCKNdWVz8mrMy8iJSrvv9nTOk85Z7DbyQvbr/mS5tGgKjzWcYuQaYx+
         6l6V+ZInGYw4miB3sn6++kRzz9q1G7lDjUjGSYK4WwgpBJ+Qgo71r20qtKjpRcy1OLVP
         Vlhg==
X-Gm-Message-State: AOAM530pYEuFUJNXexjkmCTTb1rudYEjesNegBlKASdMvX2xnmLuZpzx
        RcUwees2ebfE0RQS29iYj1M=
X-Google-Smtp-Source: ABdhPJwYMLivlMkBEGmwo9N6/VlzMpq8975Eagk68r0UhrmZs+k27JwjgIOZZRSm3dCqM5w/aqyWig==
X-Received: by 2002:a05:600c:256:: with SMTP id 22mr4086352wmj.120.1604601158135;
        Thu, 05 Nov 2020 10:32:38 -0800 (PST)
Received: from matteo-xps-15-9560.lan ([2a01:4b00:a40c:9900::14e])
        by smtp.gmail.com with ESMTPSA id h8sm3569601wro.14.2020.11.05.10.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:32:37 -0800 (PST)
From:   Matteo Scordino <matteo.scordino@gmail.com>
To:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v4 0/3] Elimo Impetus and Initium support
Date:   Thu,  5 Nov 2020 18:32:28 +0000
Message-Id: <20201105183231.12952-1-matteo.scordino@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029022000.601913-1-matteo.scordino@gmail.com>
References: <20201029022000.601913-1-matteo.scordino@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Removed a redundant node and a redundant alias as suggested for V3

Matteo Scordino (3):
  ARM: dts: sun8i: s3: Add dtsi for the Elimo Impetus SoM
  dt-bindings: arm: sunxi: add Elimo bindings
  ARM: dts: sun8i: s3: Add dts for the Elimo Initium SBC

 .../devicetree/bindings/arm/sunxi.yaml        | 13 ++++++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi | 44 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts  | 29 ++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-impetus.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-s3-elimo-initium.dts

-- 
2.20.1

