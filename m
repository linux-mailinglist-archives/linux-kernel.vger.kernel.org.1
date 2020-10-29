Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A136D29DC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbgJ2Aa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgJ2A2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:28:38 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0E1C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:28:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 1so471739ple.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0LDlgcrX0fTy8G8ru/vcpjFBOXvVtIG9PCAS8YM1+BM=;
        b=XVh8FmbWZByklsfuhcxri/99HqwoYvxpsz2YHwrdIaEuCatu/oQBDjSTqVzV+xyQ4l
         vjHBkW76l8dH8Nmb2E8S89Z8NKduZWA/1MdCRhObe6UQ+gWQdLpD2VzCC+KYu/CoiaGY
         k/2xW/5NoH63op6cTEAkDUDwoPIjT/iH4KAjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0LDlgcrX0fTy8G8ru/vcpjFBOXvVtIG9PCAS8YM1+BM=;
        b=s+n+SKwKoK5cI+Jybm4BJwDXKRfurp/Taq96eYuvwmGtRQjaRdImWoyg+nvI5VOLzs
         ROhQkU3OuSS/kantGH0zimPmYXTpzrKht771zAnPA4hVfyTQraKtNGbQ61JjBiEqnNzb
         ucTGwohNSRNTVbE8t5NiLNMVZbDAsXvIRoeSil/ecJewC3Q0j417plgihuUYat7xxo1M
         IUlsbfPnIF13CiH+cA3eCMilREOgwAbRoD5iWANgQt38DKgTf4VQQztd8Kl2iKzQyvPd
         9CpBDLJQ4CN4xLVLch4T9mdcpvjtNe8zg+UAhGIyPxxFUk5GdrcQaUbHfkEfhU+EMi4i
         uHIg==
X-Gm-Message-State: AOAM533q8LbdW2Aeb8TCeob3X2MV8adYxHfHCUssapmyitUOtQ+zmpXS
        5GTxKJUjYi9zcF8e+iCUc3tCwg==
X-Google-Smtp-Source: ABdhPJx4SwYDCGcxrzDITC5oKVfN6ljKGWxLSvwiYYuUt7t1zU9WiXpzVkggpeS9ohVjCwCxH+l83w==
X-Received: by 2002:a17:902:744a:b029:d6:8b8c:622d with SMTP id e10-20020a170902744ab02900d68b8c622dmr173631plt.67.1603931316319;
        Wed, 28 Oct 2020 17:28:36 -0700 (PDT)
Received: from evgreen-glaptop.cheshire.ch ([2601:646:c780:1404:250:b6ff:fee1:7d4c])
        by smtp.gmail.com with ESMTPSA id u13sm743625pfl.162.2020.10.28.17.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Oct 2020 17:28:35 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] nvmem: qfprom: Avoid untouchable regions
Date:   Wed, 28 Oct 2020 17:28:23 -0700
Message-Id: <20201029002827.1729915-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain fuses are protected by the XPU such that the AP cannot
access them. Attempting to do so causes an SError. Introduce an
SoC-specific compatible string, and introduce support into the
nvmem core to avoid accessing specified regions. Then use those
new elements in the qfprom driver to avoid SErrors when usermode
accesses certain registers.

Changes in v3:
 - Fixed example (Doug and rob-bot)
 - Use min()/max() macros instead of defining my own (Doug)
 - Comment changes to indicate sorting (Doug)
 - Add function to validate keepouts are proper (Doug)

Changes in v2:
 - Add other soc compatible strings (Doug)
 - Fix compatible string definition (Doug)
 - Introduced keepout regions into the core (Srini)
 - Use new core support in qfprom (Srini)

Evan Green (4):
  dt-bindings: nvmem: Add soc qfprom compatible strings
  arm64: dts: qcom: sc7180: Add soc-specific qfprom compat string
  nvmem: core: Add support for keepout regions
  nvmem: qfprom: Don't touch certain fuses

 .../bindings/nvmem/qcom,qfprom.yaml           |  17 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi          |   2 +-
 drivers/nvmem/core.c                          | 153 +++++++++++++++++-
 drivers/nvmem/qfprom.c                        |  30 ++++
 include/linux/nvmem-provider.h                |  17 ++
 5 files changed, 211 insertions(+), 8 deletions(-)

-- 
2.26.2

