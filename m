Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2321B29C779
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828557AbgJ0Scp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36166 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828426AbgJ0ScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id e2so2472662wme.1;
        Tue, 27 Oct 2020 11:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=JFgeG23QtomWzS6Bha5qw611bEGje19zVx46h+fkAYzTIEQEBDZbDytqruHW1MHBYh
         hbc8NB4nOr8thDTFGHqduRXOXoFBlnKpnO0wrSfxEobmMiLKB6sgx0DSlrrbd/e8XGcc
         v3Q1np6j6sYXNpfOwkyo7ckuOUPScb55Qpob9lT1bzzh7g6w2Z52RaquJtpBmeFg59A+
         VlcLTMlpwf3+F4jjd3BnuiuWlxkJKnD+y7H5nW9kv+8EbPPjJmmRUyT/j9vhqbN/xt+4
         Cl7lri2vSikNhdmr83MYTg/n9cNYPlgX0Dv3lDkirzJ92qxxVXAF/Qm+GbCv5d9qy0AH
         EyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVJ/FVhCtH2Sw1ZFhzCNscPSk9Fte7d6nvWFGpvDBLs=;
        b=XQGaA3lJeWSc+FbPu3aW6FPHtkl6X+3+Kx8Aqsex6pqmlTKSoy6lMH/VoAq1qt+wd2
         Uv79SompAob/GjhppxVB5njG3OUSMm/yxgfH40cWmiDzmHeUfeBGBk0FhKyPz3l4vKNL
         nUmHpCzSni0acEn9dMbjFBihlZ0cr2tayk0NsVPzN9uLlORsC7+YLYbIxr5/umESdLFP
         X7A5oZQkeCgosxfvx2Th2UwZGNdDtfeE3jOeNmLjYGRaa2pgzarHHCNqamrz6/HPDalA
         28TFmUzo7TvY1VWo3Jzla52DSATPvWeH7UEl4R8wyWMCeG4J922T3sn4smXV6s4tQVge
         5Bmw==
X-Gm-Message-State: AOAM5327yjhWawVDvSOgOyxuNziQnh9P8edCzp29WabxhDO5kDdB34OI
        +0dvNQPFMnQEDWxtCuXJyNs=
X-Google-Smtp-Source: ABdhPJwFXy7NDinDWuVTnQgP1h3IJuPLQhmkRksX/wb66eKevjZt2XttkN7abcq/vklzoDAAuVhS7Q==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr3993245wma.24.1603823522148;
        Tue, 27 Oct 2020 11:32:02 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:32:01 -0700 (PDT)
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
        linux-sunxi@googlegroups.com, Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v9 09/14] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Tue, 27 Oct 2020 19:31:44 +0100
Message-Id: <20201027183149.145165-10-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
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

