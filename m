Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEE3276CBC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgIXJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgIXJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:05:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360CFC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:05:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so2928722wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=syu1+DdR23/HGRuduqw4K/yh/8Bh3it6vTm8FUaofbE=;
        b=hE7qGLbLOokr8YNcfRBvb8hAjEPnsGvvN1wjIBNWzMMt1ccxltBObxe1n9BTOuvQi4
         7Src0szDq7oeP7DZj4HcAvEg6x+VyKNNpPtDNk1myep/t3LF908uWPJ+SBjL8kVL8iwV
         QaE2CFl6yS1YROjPcsUP3ki9vnwloL+ZcCCn59DQP0yEDExfjAMBeuREb7cZtekEeTbl
         o37zQlNjtthpruT5iCj7vrFQFYRA0sZqHqNzcBOaSsIYaeUKETK8nRrMyx64EV+vmlx3
         dwc+U38SwISln2bXzJF9Yk+bcmZo57rY2LGxHx0tM35xf2yVV4vUfs2ajVLkOTkxJvni
         EV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=syu1+DdR23/HGRuduqw4K/yh/8Bh3it6vTm8FUaofbE=;
        b=O4T27JjnxvPneoO0XH62U1+zzt3d4aPWgsoYFdA0X0y8zxNwqZvIGK4IkMAqfNdO8f
         Lt+tYAYQJPaX5BHEf8j8SlJbTuV9oFoyoN7ZdvwZU4Kj3/dMB14rjTPItjNgXsa2UuZf
         k1fs55NINaGbrAr0pMp/zGMgDDTT63x3bhYahdTHNIpFYUzII286Hf3qqV/EqYedhwab
         7GQuAepizUeJa2Hf+soYliAxwXwGiOMLIoKjfbpQyoVwtJx9ZFztNANwOOOKRLSO8Vea
         m5rfsV+mRMq9YJCSKIK6WJ7kZd2Do+6GZpgny5HOYpdNgjSX60ZZjc8FT1KGg4V5ANk1
         0LAA==
X-Gm-Message-State: AOAM531luizJEUyceEYHvPQ1fOKQOMBiQI2oWh6l7Lc/FypvLU3d6lXG
        HRaiS4HM1Wtm2IhNckckXwOc3w==
X-Google-Smtp-Source: ABdhPJw3psJtyBHRWuyRkTD8SbB0yRJoLQnsSyIwGb3Ylpmo+mIUwkuLEwOdZkXraMOYWg4zLD/4UQ==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr4139662wru.10.1600938357193;
        Thu, 24 Sep 2020 02:05:57 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:11e1:db8b:493b:54f4])
        by smtp.gmail.com with ESMTPSA id h2sm2861461wrp.69.2020.09.24.02.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 02:05:56 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org (open list:CLOCKSOURCE, CLOCKEVENT DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 01/10] dt-bindings: timer: renesas,cmt: Document r8a7742 CMT support
Date:   Thu, 24 Sep 2020 11:05:25 +0200
Message-Id: <20200924090534.2004630-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1f4f3f8f-2472-44af-0536-6bc76741d276@linaro.org>
References: <1f4f3f8f-2472-44af-0536-6bc76741d276@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document SoC specific compatible strings for r8a7742. No driver change
is needed as the fallback strings will activate the right code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200902091927.32211-1-prabhakar.mahadev-lad.rj@bp.renesas.com
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index 7e4dc5623da8..762b65094292 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -39,6 +39,7 @@ properties:
       - items:
           - enum:
               - renesas,r8a73a4-cmt0      # 32-bit CMT0 on R-Mobile APE6
+              - renesas,r8a7742-cmt0      # 32-bit CMT0 on RZ/G1H
               - renesas,r8a7743-cmt0      # 32-bit CMT0 on RZ/G1M
               - renesas,r8a7744-cmt0      # 32-bit CMT0 on RZ/G1N
               - renesas,r8a7745-cmt0      # 32-bit CMT0 on RZ/G1E
@@ -53,6 +54,7 @@ properties:
       - items:
           - enum:
               - renesas,r8a73a4-cmt1      # 48-bit CMT1 on R-Mobile APE6
+              - renesas,r8a7742-cmt1      # 48-bit CMT1 on RZ/G1H
               - renesas,r8a7743-cmt1      # 48-bit CMT1 on RZ/G1M
               - renesas,r8a7744-cmt1      # 48-bit CMT1 on RZ/G1N
               - renesas,r8a7745-cmt1      # 48-bit CMT1 on RZ/G1E
-- 
2.25.1

