Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B120263CB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 07:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIJFrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 01:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIJFqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:46:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D6C061757
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 22:46:47 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j34so3640485pgi.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 22:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtxeUWrBvMNP2Y8KaLxhs4rPoG0ZGE6ZXep9roUJTTI=;
        b=ni0hwv4SK+Yn1AQHStWD0LBZvoGzYAHaoXq94POyX7VX4VhMHOifOOKEMHU1WZk6jf
         XvPb2j3qHc7XX6tzQW6QGyUWHeXwi8sgXsmtUpj2yEHoyXmVdFXwCpvZO/goxlAbmS6G
         MGXBH28wzofwKq4HSd0FhLCD5PVSHoIIWLrUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtxeUWrBvMNP2Y8KaLxhs4rPoG0ZGE6ZXep9roUJTTI=;
        b=LegznAB/BzealfzdcgZb5dlkBDqIgNxX4dFH1C+6LrO6dWFSgRXJllAnWF7TgMLZGR
         GrJafpfivIq2D98B5ytHEdJXjZZ1camdhpiGBnHDyRojXSVsckN99f04ZV4NcbiGaJys
         KgnHDJG1Fe3wVqHdCJSZTZW97+RP/Y2x6i9BCXpLMD5ufQNzt1RZEwaZCf3LjG0NkUB3
         GdRln+siEW9VMdSb1juZt9UNwb8g1RbJgbwfZ19PWYnVD09Ep/4H6chbz7UzsZCPtHgP
         Zlvo6Yil944ZjhaAQiHqbUvVYdUdK4PfRmi6FAC5qD+eoRwsUML281uZGY12k5BCfs06
         JjGg==
X-Gm-Message-State: AOAM530YgBlti6CCLAm6m6vO+bbwthvYGsmt7C+bCSQPbMfDBge97nq4
        E2Rhu9cvOArmMVzcDwlbJsmcUw==
X-Google-Smtp-Source: ABdhPJyj1mfhyj/UVHKPgWsS2TbntfcsawXpCCu4tsBd/teTjIQtkGi104/d+aCaqRrrolJlbM9Ubg==
X-Received: by 2002:a65:5849:: with SMTP id s9mr3185543pgr.439.1599716806553;
        Wed, 09 Sep 2020 22:46:46 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id r6sm4598159pfq.11.2020.09.09.22.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 22:46:46 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 2/2] arm64: dts: mt8183: kukui: Set uart0 to mmio32 iotype
Date:   Thu, 10 Sep 2020 13:46:35 +0800
Message-Id: <20200910054635.3337487-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200910054635.3337487-1-hsinyi@chromium.org>
References: <20200910054635.3337487-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set uart0 iotype to mmio32 to make earlycon work with stdout-path.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index f0a070535b340..f6991bdaac1c6 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -750,6 +750,8 @@ &u3phy {
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_default>;
+	reg-io-width = <4>;
+	reg-shift = <2>;
 	status = "okay";
 };
 
-- 
2.28.0.526.ge36021eeef-goog

