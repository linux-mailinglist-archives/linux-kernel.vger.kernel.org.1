Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50C027D962
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 22:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgI2U6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbgI2U6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 16:58:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E12C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t7so3408178pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3+N8jl4iLhxEDGW7b+2sUqmEtHRJsrmsOkpbsCci28=;
        b=RyBeF2LoJWmFx7cRTA0dxIqnOk43j8IDnZQNiKh1SxagTLajEc0seLhggi5jGNwyW8
         TQieKx9sVRWYYBlg9ZTWqVF9GjUMTSMzvBgAuB04mS5kOVDgLfLTVwkZgN1ci6I/0+g/
         ljpiR2ljIgE9OyOcGZzzg1Z0cU5Im372vb1CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G3+N8jl4iLhxEDGW7b+2sUqmEtHRJsrmsOkpbsCci28=;
        b=unmoba6SjrCoL3RUzbTDz1tRhPpCqU7xLUc2RkShTqMoz84I0TPMfphh0Ncx4kLzMu
         vj84l0DIHKnrcKx7KWKQ+LKTQzQhrqIh+s6njcdfFvzBXYhAkB6+IcPaFlogMiNSh7mT
         8Wm2mr1S2ycWM3shqNKwRqOGrGjHAVlqA74Sbsp3nAHUa9ep5GxE5x/YniRr2SUNKDzJ
         L8N0UHPhWm1v/zgyjd4xsGths79hIFzVLHoS/D/uexvlJ4ceX8ByiZZ4zVCHaJiQv0o9
         SpJfniNBzVgaio+95DYoki1PBXl6olIMFF8ASOuyKf79brKOOiJhRVjEJueeD7wyBfYv
         cowg==
X-Gm-Message-State: AOAM531Kr9zygtFmvYKQMsGraPbZvc169cl2vZx4stncjRa7A/eG6rd8
        zgNl8SCIDx8ydJSToHbDbFcLgg==
X-Google-Smtp-Source: ABdhPJyE/U1qwuzZg0kpvNJ18xK9ziz4FHxSxLVdwTW8gnEeYDBH1AMEUSknlOcfpPoDDQV5l8dW5A==
X-Received: by 2002:a17:90a:2d87:: with SMTP id p7mr3619978pjd.179.1601413096753;
        Tue, 29 Sep 2020 13:58:16 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:a2ce:c8ff:fec4:54a3])
        by smtp.gmail.com with ESMTPSA id k7sm5488101pjs.9.2020.09.29.13.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Sep 2020 13:58:16 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] nvmem: qfprom: Avoid untouchable regions
Date:   Tue, 29 Sep 2020 13:58:04 -0700
Message-Id: <20200929205807.2360405-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain fuses are protected by the XPU such that the AP cannot
access them. Attempting to do so causes an SError. Introduce an
SoC-specific compatible string, and then use that to determine
which fuse regions to present as Read as Zero / Write Ignore.


Evan Green (3):
  dt-bindings: nvmem: Add qcom,sc7180-qfprom compatible string
  arm64: dts: qcom: sc7180: Add soc-specific qfprom compat string
  nvmem: qfprom: Don't touch certain fuses

 .../bindings/nvmem/qcom,qfprom.yaml           |  4 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |  2 +-
 drivers/nvmem/qfprom.c                        | 55 +++++++++++++++++--
 3 files changed, 55 insertions(+), 6 deletions(-)

-- 
2.26.2

