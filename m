Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF87299368
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787343AbgJZRJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:09:55 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36717 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787104AbgJZRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:09:55 -0400
Received: by mail-wr1-f47.google.com with SMTP id x7so13561553wrl.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFeyCOZuGu3TAYp3AEJCm2TEdGhGhIny1R6SggmTKY8=;
        b=Fl6Xm/43hXC4xGueHJyhjc4F097rffBBIx+Eq/oU+GjhX++JY5cRmILQZJp6rysLqo
         dJMmTFKSBRh+T7R96gq5W9AP/P7P+lzl5wr/2AMk6EefsApNiPb648JXKNawKuy1Hzzj
         mDUB2cbpuU4pB6KsLVXfaNlmuUdmpa4z6MP/7B+Vfhb7eFR362Y6yO3EM73JXnkUXUcU
         jaDBVRCmMIn527Eo0LUcosY0iP/rAm1ySPHt0eCd5FAMD2G+cEzfmFLRuHphtv7Udo1x
         20n0F4diTbwEbc6iZptgehfXaxG2KPMrjRV4MeVf9rZGSAfvHq9dab935vh0t1rsmg5o
         6E2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFeyCOZuGu3TAYp3AEJCm2TEdGhGhIny1R6SggmTKY8=;
        b=KGz8juMwt1Xpwc0gdj/t5EHo5pfUevsKmTuUGVp9n36QT69RK9qbSMTEkCmPQPwt2C
         qNvvWWAnTxotEzLZL7yksdA7D3vf3PzixP8B+kDQi+96OwRRPeKoA7YvJX1mTDENUm+r
         ve2pfEfWZQYhe98qTCZsE9HxeFkntuB4B7UTwim1ZdLklMBXuDIadpfr/PdSObDRcNsU
         RpbP/txU79togcSz5ZPVhozaaaRsIzDk9Vd+7OQmSWFMookmuTNuI3Cc9urccY3eKiUe
         NOUXvxTysepEPMKdxo3eFlZ21rBnuqcv1nD5PoMTnQATSarGjrqHsuXJlJnbOT86n52n
         RzDA==
X-Gm-Message-State: AOAM531JFNI3pndFBI2aVXi6PUlQSMOUvTN6Vkv5eCOc49+jiKZjbS+c
        77S4ByrIVeNac0Egh+QopjjH6dRjG5UXBQ==
X-Google-Smtp-Source: ABdhPJxSMbYOdUwlA0pB6HpbXDqkJfj/f2c0xOdjab4+4gWwvK7VFgL7/Bwmn3hC0aQtjgXUPy0NLA==
X-Received: by 2002:a5d:4e8d:: with SMTP id e13mr19102405wru.368.1603732191699;
        Mon, 26 Oct 2020 10:09:51 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id u133sm23136174wmb.6.2020.10.26.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:09:51 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org,
        spapothi@codeaurora.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 0/2] ASoC: qcom: add support for QRB5165 RB5 machine
Date:   Mon, 26 Oct 2020 17:09:45 +0000
Message-Id: <20201026170947.10567-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support to Qualcomm Robotics RB5 Development Kit based on
QRB5165 Robotics SoC. This board has 2 WSA881X smart speakers with onboard
DMIC connected to internal LPASS codec via WSA and VA macros respectively.
    
Srinivas Kandagatla (2):
  ASoC: qcom: dt-bindings: Add SM8250 sound card bindings
  ASoC: qcom: sm8250: add sound card qrb5165-rb5 support

 .../bindings/sound/qcom,sm8250.yaml           | 161 +++++++++++++
 sound/soc/qcom/Kconfig                        |  11 +
 sound/soc/qcom/Makefile                       |   2 +
 sound/soc/qcom/sm8250.c                       | 228 ++++++++++++++++++
 4 files changed, 402 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
 create mode 100644 sound/soc/qcom/sm8250.c

-- 
2.21.0

