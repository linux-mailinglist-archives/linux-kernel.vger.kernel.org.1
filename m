Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF61E2762CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgIWVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgIWVES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:04:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47FC0613CE;
        Wed, 23 Sep 2020 14:04:17 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t138so1230702qka.0;
        Wed, 23 Sep 2020 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdMuyxsbVZIjvN8C24RgnButiYoPlCvAUwNgP4R+JK4=;
        b=q5T6yFbpjcpV7r6GXzWLiKIeSRx0kyCFrwX+P10a9jxYPYr4nTAjxO/Mr8LocQmF9k
         U2cpAV2u2Hq4Jd2i5HLtHmijXnNnaksaT1SXZSzHviivUl7Wycy1yqQsKY5aakAih2S2
         MbCxaHGfCexM2KsHgUxEAugPvYfDrd6v4blBUN1rb8/nmRHDSuCvAFsRHF4AI4B1w5F4
         +aXlVTi+AGq0H393PBaMw5X9N60CaslJliwTfaR5AKKr58mJ1aLO8SAaus5k+JDxQ7TM
         UDz+tQkNH89otm26CeSepY4sMm50ymDpr55E2eBA07RcH3nrT/ZTZBEKeEW191CE4gn0
         NO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdMuyxsbVZIjvN8C24RgnButiYoPlCvAUwNgP4R+JK4=;
        b=JIeYAAC0P7SqkGa83Gi1IS3dzVYuu8WSblMx1mPtMQBubxzMBSFHBqFniOUNZMg58L
         3nnodlV5LM/9kxRMGy4TzuA+THGitmXOk4QjUnpu4Pv/qGztVqmO3S4PYPIPamIbMaqZ
         rBB01NNoc7EE4wZYYtKPxogJ6C0PxitUGs4FrBul+KyRCweDyOczD5QzUz9IVBLUq182
         ySwozIEaGtuEsX2BJwPJOPaBMCBcfyxrROmlHvg70lxS8VWtMvQHcvazz37wnmwkFYoG
         OqSzYKxvw7gvH6b4a7tXpXLeQoZa1r6brIrZwc0fE5KOSr+qCQpKHpTCJum9GjhSbXkm
         4Mcg==
X-Gm-Message-State: AOAM5318mKa3Jb/M/lQkgAzuxJhlSRxpv+DPkxyacgOW8PxPuk/wJUKP
        xIXH+BoFI7MZhEYDXT+jtcA=
X-Google-Smtp-Source: ABdhPJxPs4GSf8jYHnAAqVy/PBBA277u6YjKaVWGJGiDUljVXLQX82EQ2x+Nbe/rvXjsJT9xGOZefw==
X-Received: by 2002:a37:a347:: with SMTP id m68mr1802170qke.81.1600895057055;
        Wed, 23 Sep 2020 14:04:17 -0700 (PDT)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
        by smtp.gmail.com with ESMTPSA id h18sm753419qkl.12.2020.09.23.14.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 14:04:16 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Bob Ham <rah@settrans.net>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Brougham <jusplainmike@gmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 3/3] dt-bindings: ARM: tegra: Add Ouya game console
Date:   Wed, 23 Sep 2020 21:03:52 +0000
Message-Id: <20200923210352.1176386-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923210352.1176386-1-pgwipeout@gmail.com>
References: <20200923210352.1176386-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra30-based Ouya game console.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index e0b3debaee9e..a8bafe68315f 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -69,6 +69,9 @@ properties:
           - const: asus,tilapia
           - const: asus,grouper
           - const: nvidia,tegra30
+      - items:
+          - const: ouya,ouya
+          - const: nvidia,tegra30
       - items:
           - enum:
               - nvidia,dalmore
-- 
2.25.1

