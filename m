Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF4491A2A90
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 22:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgDHUlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 16:41:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40138 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbgDHUlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:41:12 -0400
Received: by mail-lj1-f196.google.com with SMTP id 142so4601544ljj.7;
        Wed, 08 Apr 2020 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9tkgMFNzJvbwS5Mj8KGdhRxtWizvU/2l3mcyErW424=;
        b=YjB1QneSvIfpJa4V/gCbK2LuSJUcp14XXYZPdEvcICvAUbk2nCDiDLU297Ebe/sT5x
         XgU89p3pAoORAeZ7K+7t3Babi2ElXg32UqUotKNketV2wE793Iqq7QFddIUOY5YTJ2CU
         nD4EnCdOmqJBV/7QSBhGz9LQFN++v6hxHwevPb0xHU9WSJQAL57ENFegTVEEDW0GpIFG
         hspLMNuGvQ0dnxssWI429ip0Rgd4EC0N4EBLxPayp7hqB2cu5QNxDlmEbtb4at6jbPVb
         PZ/gb/zLA70DgOK/pW7/kvhobUz64XQIo4HZWy/iJZYFAXUs+TDqbe9HKiH8iyNuU9yn
         211w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9tkgMFNzJvbwS5Mj8KGdhRxtWizvU/2l3mcyErW424=;
        b=AhFQgEMabOKSEPwq4XxKKWROCpHJmoQ2t8b1ifxVC7wb+TcSeccTOYXtLvYcmRu2Uh
         1HvcuchgPn9OMXbFC54qH/zCYCZTrfKLPqwPLjmO7hOn+IEaXVVl2POm70Pwt3B+VB1W
         ASyiceqJoGly926aNKMMeSDniW4l8f5K5pUxBi5bvIZOfpq4NZ+0nJXsadn/Iz+plG5+
         gyaChzBZS2RDpU3hdRl+dHuuiXjmYvbzdKvQZnNEEL6we2KfZO3gegOmxcjrPkIjPENs
         b+3H7wnWtcyQ+9Y9GYbwWVB0TzqQZi+dwlQGPXy0lkfrsJgaShqoJdxupRblbw1SCd6T
         tGTQ==
X-Gm-Message-State: AGi0PubMUZU0Isyp3EYig0zpulezQxqvXlYYgpnoctI7UaOSsAFhS35o
        OTq/XBSNmZHZczGncFEoh7M=
X-Google-Smtp-Source: APiQypKvGZphY5/stmNBFOd7pCKvbiHB3zBaZjVez3MYVG/9mQLaz87vJ0+LbuaubJlO0dPen0dU1g==
X-Received: by 2002:a2e:a308:: with SMTP id l8mr2638628lje.282.1586378469639;
        Wed, 08 Apr 2020 13:41:09 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id p14sm13189727lfe.87.2020.04.08.13.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:41:09 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
Date:   Wed,  8 Apr 2020 23:39:44 +0300
Message-Id: <20200408203945.10329-6-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408203945.10329-1-digetx@gmail.com>
References: <20200408203945.10329-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra30-based ASUS Google Nexus 7 tablet device.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 7fd0b66c69b2..fb3bbf7a5fb4 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -62,6 +62,13 @@ properties:
               - toradex,colibri_t30-eval-v3
           - const: toradex,colibri_t30
           - const: nvidia,tegra30
+      - items:
+          - const: asus,grouper
+          - const: nvidia,tegra30
+      - items:
+          - const: asus,tilapia
+          - const: asus,grouper
+          - const: nvidia,tegra30
       - items:
           - enum:
               - nvidia,dalmore
-- 
2.25.1

