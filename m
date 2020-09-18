Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3C426F847
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgIRIbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgIRIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:31:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3B5C061756
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:31:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id k13so2475752pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7g3/3HRNTSbPMO+XtztpkLjskFShJd05xhi/n73t2b4=;
        b=J3Jq/M3KnJTcWXxQ/OmDCmtw9TKMVom83ObJCwfMadXSAPRuA4l/Jm2QB0eR4ojdNs
         fPQo5XjYTFreg2ms90MvHm4DvWmPFmn67LMERc9pHP3vJ0cCl4LLTglj56jPBMAbtfpq
         rB5yxrY/2z7aI/sV6h7qHpU7ZHO+WQxXuMtTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7g3/3HRNTSbPMO+XtztpkLjskFShJd05xhi/n73t2b4=;
        b=S9UB2G66F2YCKNJIEHr3Kcxu/YAShPzoJoFVgDXt+jKjEaKRSe6MqsbE9uSkQrJ4RH
         l0gZevXf2ZguiuqA2O+mnfTZqXGnjD1gl6ptUBUJ2Cg+/DRLL/dZgV5t7HJkie78TiNN
         XiKtFTSo3/kJ48Phcmr173QSMpXZiM1FhgellY4O5F4ZzVO7njf83170aaA7IjJc5H0W
         eW1GjEqrzpOVQm53E7LXQURetbzMf1o0TZQP0Gs1TkMfGLrrTEG2QLJuh9E4mZCDmr3P
         Vwaer1K0goi4phCH7oG183akOMozwD9JukTQ5rmEWUVjkSRBycTyarxUNe98utqL0tnn
         MUOw==
X-Gm-Message-State: AOAM532gefkmnuGWtLY2wCqLbrZZTOurulIOJCd1fZThVQDZZG6rXoh7
        9mgUl+H1eBOtT4KDye/GlcTqog==
X-Google-Smtp-Source: ABdhPJyo5ajOR3Sys6kLV1edGsPyxX+u0k7ZFoM2H/iELQtDmH1lb8MEP86ne6oEPQdxsCBI364jDQ==
X-Received: by 2002:a62:3585:0:b029:142:2501:3985 with SMTP id c127-20020a6235850000b029014225013985mr15239835pfa.74.1600417889074;
        Fri, 18 Sep 2020 01:31:29 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id g206sm2193172pfb.178.2020.09.18.01.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 01:31:28 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/5] spi: spi-mtk-nor: Add mt8192 support.
Date:   Fri, 18 Sep 2020 16:31:18 +0800
Message-Id: <20200918083124.3921207-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds 36bit dma address and power management
supports for mt8192-nor.

Changes in v2:
- Add power management support
- Fix bugs in checking spi memory operation.
- use dma_alloc_coherent for allocating bounce buffer
- code cleanups

Ikjoon Jang (5):
  dt-bindings: spi: add mt8192-nor compatible string
  spi: spi-mtk-nor: fix mishandled logics in checking SPI memory
    operation
  spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
  spi: spi-mtk-nor: support 36bit dma addressing to mediatek
  spi: spi-mtk-nor: Add power management support

 .../bindings/spi/mediatek,spi-mtk-nor.yaml    |   1 +
 drivers/spi/spi-mtk-nor.c                     | 242 ++++++++++++------
 2 files changed, 170 insertions(+), 73 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

