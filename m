Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE5B2716B0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgITSIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgITSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3EC0613CE;
        Sun, 20 Sep 2020 11:08:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s12so10436015wrw.11;
        Sun, 20 Sep 2020 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=gS8kVQ8uhQvfH7SKx1asvVvVov1DKce4OuW0QEaOqhw6J1WXHn0U5FxWsDae7Bw1Rm
         t9bI9P1cH5vMOqGsFeVcQKMSe2h3Rc2Xn5cbd+fxZbOGz2veWh+8sKoNmrZivORDA0EX
         VQw/d/HIm0XCVzukAtZ40uIzl0elrm49zR/FgoNZiRQVXeUOIMz+pJdKS8AUM9N/G78O
         8lq1DujM2y/diJ4/A9kn8jcAZBHgjCOIN7fgcf8i4ZGWzFNuw+rbUht2szHalEt9gFll
         RFMZLHnRzH08v8elBLlE3lM8NCinETdLqmBrrepiPQkVt6o1TdWOrung3EyAlgEVMT0r
         MZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=eCrrr3sNpOGHKCB2gH1qkU1hGzvuGRp0tg1///11pVJedddZkNWAJUHs47rxbagYwm
         X9aE5h/VOFdEb2iD4jR1VN3sOV7wHNWr1W/u38ql/8utTJ/0G7nRSseynlt55h1v/5KQ
         70t9b+QGleYwR9BYHFdPo89ek19RqPM/cNJ4iefq9cX0HpXLfaWiQlfxssXmrbTu/lgT
         +QS3hRySE4o0oT70AwpN+DKPst2a8xPKXH+skZgovxlSd/1GMWH1zkOzEFggiepn9/Ig
         iaGyupzZyp/K994XAYwFyKk8xGPDmk87TX9uQkF+ew7b+Ayt349VN0FLVexfAUjowR7D
         uwNw==
X-Gm-Message-State: AOAM530N2bfwJ/wvmOxUMEvNf4PXbyQaDXvE9+fGyEQVs9/aq6DJp6QF
        1EGLCjp6jtbk9rKKI0XurFU=
X-Google-Smtp-Source: ABdhPJzKk1yEj8zjqx4Yx+PhKjt6jPujVYrSLTKzaVhqwL347LKjg2H4cV17fsfnsJb2yostmFYSzQ==
X-Received: by 2002:adf:f084:: with SMTP id n4mr24893043wro.26.1600625290130;
        Sun, 20 Sep 2020 11:08:10 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:09 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 03/19] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Sun, 20 Sep 2020 20:07:42 +0200
Message-Id: <20200920180758.592217-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to H3, except that it supports up to 16 channels
and thus few registers have fields on different position.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 112ae00d63c1..606ad2d884a8 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2s
           - const: allwinner,sun8i-h3-i2s
+      - const: allwinner,sun50i-h6-i2s
 
   reg:
     maxItems: 1
@@ -59,6 +60,7 @@ allOf:
               - allwinner,sun8i-a83t-i2s
               - allwinner,sun8i-h3-i2s
               - allwinner,sun50i-a64-codec-i2s
+              - allwinner,sun50i-h6-i2s
 
     then:
       required:
-- 
2.25.1

