Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3426D303EC3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbhAZNbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404410AbhAZN1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:27:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBAAC0698C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:26:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c6so19752844ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 05:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jJsyBSQ5fnIh7z+EGO1ct3NYyuJeKMfKI26SOZHy/5M=;
        b=nreZNHlarXxqqf5v1K41FArfFksX47QMYvpuQazuFPHcwCsFArVTbduVnLIzt9WudS
         TV8fBmKsTd6KRZXO+6PmPol6JoQevANIt/52yoKVyl7u7SOoOLr1JaKVIIBURin13/OS
         ozXZaN2EPwkbo5YSiSjLBn81LbdbKH14+6EUwaxblzZXRq5+WCCvCJmFjTFManR/E0Ml
         zFr3Tk1CYCjXMJELN7gy4dBmw/5tuQTNDQGrds//v6ZcmvXvGYwQmcW2Uwizfp5yJ08b
         LpFFLzJbO0gbmSnkj8OzClOly8qROT5daNyeuDJWHIXgEGW2Zk27TvJNn6Sist2aTXSR
         6/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJsyBSQ5fnIh7z+EGO1ct3NYyuJeKMfKI26SOZHy/5M=;
        b=o7AXYX3Qnk6VxwVC/CbTOcWLtvSnJLY8NVjbkRcjSuNXzfHsLUvyS3M8HCST8gffKo
         8rUFH8KLMvnoD1w9vG9flUnxmY6BYVSFBgszLYAIDMgqA3u2nrsptyNejGM+u1UqUIVu
         J7yy9DhS9vVStDfUNnzLSc42dXmYBn5JgAJLaTzqJQptD+YTmzdf0zphzSj7WfkCoMo7
         F6IZu2Np0+FjUuup8y/dlsirc2J5iwnpKC/tfuUUr4ZsSqPPesj3vBGPyx0QobWOSwZR
         fitVpQ6LhNhOtXUOUnmqX/czSTU+KMoqXG61ECr6PMhVpP8VcLcyOhdf3BOyjnGJpeN2
         mBSw==
X-Gm-Message-State: AOAM531oUxH4H7Q9vwnTQe8MOAhukyI/rzSuzFO9Kzkg3fJugRiovAk2
        gOHKOdOnZwwAhEbfS8wk7MEIGg==
X-Google-Smtp-Source: ABdhPJxbhLHk4eGRreEqF4cTHMfjlD/b2feroKVc/aXltYt5dPKG1lCH+uD6Eh2WG04mPRzB26UreQ==
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr4500539edc.135.1611667577953;
        Tue, 26 Jan 2021 05:26:17 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:65c9:91eb:731f:f2c8])
        by smtp.gmail.com with ESMTPSA id dh14sm12236010edb.11.2021.01.26.05.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 05:26:17 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
        UNGLinuxDriver@microchip.com, lgirdwood@gmail.com,
        broonie@kernel.org, matthias.bgg@gmail.com, jiaxin.yu@mediatek.com,
        shane.chien@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1 2/2] dt-bindings: mediatek: mt8192: Fix dt_binding_check warning
Date:   Tue, 26 Jan 2021 14:25:31 +0100
Message-Id: <20210126132531.2084711-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210126132531.2084711-1-robert.foss@linaro.org>
References: <20210126132531.2084711-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence indentation level warning reported by dt_binding_check in
order to reduce noise during routine checks.

$ make dt_binding_check
mt8192-mt6359-rt1015-rt5682.yaml:10:4: [warning] wrong indentation:
expected 2 but found 3 (indentation)

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 .../bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml           | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index bf8c8ba25009..54650823b29a 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
@@ -7,8 +7,8 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Mediatek MT8192 with MT6359, RT1015 and RT5682 ASoC sound card driver
 
 maintainers:
-   - Jiaxin Yu <jiaxin.yu@mediatek.com>
-   - Shane Chien <shane.chien@mediatek.com>
+  - Jiaxin Yu <jiaxin.yu@mediatek.com>
+  - Shane Chien <shane.chien@mediatek.com>
 
 description:
   This binding describes the MT8192 sound card.
-- 
2.27.0

