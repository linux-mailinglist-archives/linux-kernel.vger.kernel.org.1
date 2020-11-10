Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156F92AD055
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKJHWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgKJHWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:22:11 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E1EC0613CF;
        Mon,  9 Nov 2020 23:22:10 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id y7so10573889pfq.11;
        Mon, 09 Nov 2020 23:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=m6tsI6vZLfIOGN9wjxc2B8Hx0bcrTnQ1WgjjtJhiAxM=;
        b=hXdt4Wj+U8TXSrNYk85tfPQyaSLQX8lwdjU6bH2sNPPBf7zmx5OkXp6nQWGPqTOIBp
         YWzE3pTWgM2Rro8ZcsEQXWODmdZImbqVYq3nNGW7QyvxSgK3mdWIFTctp/90VjgTYTnD
         abbOhxeJvN908jmacnaTTZgB0IBLvj4SQ/IxJG0vx2yny94F44DxHuvIsFABn7U9m29p
         x26nrvEwNYSJyHIN9mOUOzO5TtYHuCxsz5F/ix4gqQ1Y1m/PeCMUpZxtOCkko//5z6Zf
         YZdYf7QsZb4OqOFNe4sRVXP2zC3mR5YtKo8LcqTipKgzu+lLZH6+V/dv8W0m9hIEChhq
         dXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m6tsI6vZLfIOGN9wjxc2B8Hx0bcrTnQ1WgjjtJhiAxM=;
        b=phKPr6bxIuoESHC6Lrg9yJyO0U03hvUlOPT2wBFGrIK2PW58S8bJ2WHfZSY+KnqjFW
         SZt8ej386imj/Po56NMhyav2xsl4R1UtIFGflu8a1n38CxGFIF3tVzyWNY82A5jhoVxp
         YDZ1sZbxnTSyjJynMt+fhXhyJqGoHnHfi2VDCX3uh1GUHoUoGCzH2MdGFgwnQcEa/SUf
         DdLXiBqts7K0HEKLs4mhHEmYq/UAGL09zJ2R7f3AJW/SBZt3bTTF8fDTsEG+Qta5wSQD
         du4gtttOnwToGnSHIE9ewSpRFCZ9UglDXwdhX1ti7kPV7LpSaAwLxjMnpR9sFC8/Jqhb
         edbw==
X-Gm-Message-State: AOAM530/kZw1qqWEZqxWc0I0V1duu5td7WxWIgN6+3dcxMvhhM+oGD5F
        z2bbDUiZv5SFQCYzvLvE82s=
X-Google-Smtp-Source: ABdhPJzYQvMef+/qWUw8dey1QJTJqoDr9khYcPxNfUhdeyoAHJCdnBB/f1QdASjgDe4U8UL0HUYkmg==
X-Received: by 2002:a17:90a:f00a:: with SMTP id bt10mr3389011pjb.91.1604992930418;
        Mon, 09 Nov 2020 23:22:10 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id ck4sm2020721pjb.50.2020.11.09.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 23:22:09 -0800 (PST)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH] ARM: dts: aspeed: wedge400: Fix FMC flash0 layout
Date:   Mon,  9 Nov 2020 23:21:59 -0800
Message-Id: <20201110072159.7941-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Update "data0" partition's size from 8MB to 4MB to fix "partition data0
extends beyond the end of device" warning at bootup time.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
index ad1fcad3676c..63a3dd548f30 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge400.dts
@@ -124,8 +124,8 @@
 		 * "data0" partition (4MB) is reserved for persistent
 		 * data store.
 		 */
-		data0@3800000 {
-			reg = <0x7c00000 0x800000>;
+		data0@7c00000 {
+			reg = <0x7c00000 0x400000>;
 			label = "data0";
 		};
 
-- 
2.17.1

