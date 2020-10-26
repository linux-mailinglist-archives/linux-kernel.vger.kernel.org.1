Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885B92995D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790921AbgJZSx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41150 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790542AbgJZSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:53:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id s9so13866395wro.8;
        Mon, 26 Oct 2020 11:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Q1L59OjiDLpqGnNODju6fMwtd7Ss5Fh+8syeSPkSMs=;
        b=iw8Tt0Is9e1poafENrpZRdDGZVwI7kf1UF12fsc7eBsHdZG7m/c+OWT9rpHv00odup
         dtimc86iK7hxhdNQiK1T2fHMKOB41WAQarBsqN7LAHDC/vE/NMqBNRwLgU/ojm1MWIRe
         TrpqOy0sgIPCyhQ6iJp9FdUq6gpdFdyFj+a1Pi2qU8WzCPgj089ano7c43mgJwr1SCLZ
         VBQqHv/KZRwg1VYINGpImGAbKEdYS5t36i3vLyjSEII8IZlxSTYIxcYx9JVCLyden0Mg
         Jo/OYJxHDb7A9p2M/q2S3MGkYq+DfxE97bporPOXdUEgZX3RuNpmRqe3g8iH/MVFb/L1
         yJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Q1L59OjiDLpqGnNODju6fMwtd7Ss5Fh+8syeSPkSMs=;
        b=O5Oeq9u+2o95v1phVkFxFhY7iX+jag7ykdg8yej119n3A2VQqQbHmVlgYt4zoinFS/
         DQc62WjVGNf4ZW5WwKGVZ3kXrsazqqnS2M5cAtK2/slSpCbgjylli9TYoIAusDs1DJph
         hmO9kBIu2PrVci6MIOpjZncNdwhTcujMtMhbOPxUKAr7kfTl95zn3+hlSstpgb2fPhP5
         D1i+kCfRLB7B/gKP0CvWomazQHiaNCy+uJGIDA6YcRU3Ls7PEQUGshJgRkJU8EvenXFS
         Fujf8+Ga8z9WS143AZR4i8PA2LZLVCDfD4RdO/bsQ09W7vOkDvZnDOYgD/BxQLIahKz/
         NEGA==
X-Gm-Message-State: AOAM531JYTHlzfsZXh1tFJdXqFsAP4E+rZe22rxToQV1eQdL0XXp8ch0
        5Kj+qyt4YabAiTpbH9g2/ow=
X-Google-Smtp-Source: ABdhPJyiT4V5gb6oDpX/aFZI1JeMO7JWfrwtaDrhwLJO/4XfXKX9LirC57kBfE+n68pmsi9+UXUx2A==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr19000599wrq.236.1603738376721;
        Mon, 26 Oct 2020 11:52:56 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:55 -0700 (PDT)
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
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v8 12/14] arm64: defconfig: Enable Allwinner i2s driver
Date:   Mon, 26 Oct 2020 19:52:37 +0100
Message-Id: <20201026185239.379417-13-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Allwinner I2S driver for arm64 defconfig.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 17a2df6a263e..3f89f427a355 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -706,6 +706,7 @@ CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
 CONFIG_SND_SOC_SAMSUNG=y
 CONFIG_SND_SOC_RCAR=m
+CONFIG_SND_SUN4I_I2S=m
 CONFIG_SND_SUN4I_SPDIF=m
 CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA210_AHUB=m
-- 
2.25.1

