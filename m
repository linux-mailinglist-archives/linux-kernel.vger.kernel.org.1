Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF19282B03
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJDNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgJDNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 09:35:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E46C0613CE;
        Sun,  4 Oct 2020 06:35:35 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c62so8710593qke.1;
        Sun, 04 Oct 2020 06:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GdMuyxsbVZIjvN8C24RgnButiYoPlCvAUwNgP4R+JK4=;
        b=B054CBI71xDz3HkFD7sP5tVUKkYe3qZF+XJ8G0DZoOCF1KmmcM02p11RCuec/cEOFF
         soca4Yl4SUBwp0wC27UJ7xSAxMiVg5FK4SfjJG+aa41VTvFxpjU437liZzy0neQMbzmU
         f3SbkD9/4CbvcRevA88VC0CVDbX/F1uWGBjDkncfCkCl6Ilz1PEor9ZC3HxLveIM/mZH
         oF+1In9cmnEjKx1HYpklcUlCF6ipqPnN2vNbQ2LW9hEsQvZ+GpEj07Yd/6bF+p6nu8OG
         FMgdYDvEsbroJvgcQfRnWKXhMZrWDiVwZc7V5hBzoi5kI5mIX2R+w2rf4HpGsMbomf/1
         Nenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GdMuyxsbVZIjvN8C24RgnButiYoPlCvAUwNgP4R+JK4=;
        b=EZQPINJ8ojJ5rs2cYcfZaXwo68EhkqoRqYuZHDcZyTiaN/h/nh9cL00Uc09HtP8eiI
         OWCbLMRejYjRvpRI0M3orhbk41kMb5q/5Ul3wwtbY3PU8V9JD14HRWGoPt0zT9WeontX
         E/4LUrJwWZIyOY1wk1Skfn6yQJzBU+RWNN2gmNf7CYMuHMdGz/JtnH4YQftN9wQ4pS7x
         ey1vahKCAFfVdL3+gI4BpWpIIPdgLQ1goKENo1ecqlBmdNBwED6mpKUYPePePIWy06ZR
         J2UMyDeaXHoN9Cv1ilWGYufmlDv4tKl1kaffh2idbw/IAgQDJoR1SlsDZ4iSiIaxJIBz
         66rA==
X-Gm-Message-State: AOAM531vknSB4DyXQN/Ls35a4OqVWFyxnEnie6KW1v1P6We9ykcmRt9R
        HRMQLfIWdPPwtv1/l0TkiyAf/FHj6Ts49A0G
X-Google-Smtp-Source: ABdhPJxi+AiiswEzaHEs1P7kpUNHqnvoXCBWO/4C0c6pRNATgALq8FNl8M9GVw4osajp95Ufq9856g==
X-Received: by 2002:a37:7747:: with SMTP id s68mr5301926qkc.491.1601818534623;
        Sun, 04 Oct 2020 06:35:34 -0700 (PDT)
Received: from rockpro64.hsd1.md.comcast.net ([2601:153:900:7730::20])
        by smtp.gmail.com with ESMTPSA id b9sm5539369qta.39.2020.10.04.06.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 06:35:34 -0700 (PDT)
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
Subject: [PATCH v3 3/3] dt-bindings: ARM: tegra: Add Ouya game console
Date:   Sun,  4 Oct 2020 13:31:14 +0000
Message-Id: <20201004133114.845230-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004133114.845230-1-pgwipeout@gmail.com>
References: <20201004133114.845230-1-pgwipeout@gmail.com>
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

