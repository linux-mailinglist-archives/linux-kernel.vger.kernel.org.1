Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEE0290FAF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436793AbgJQFy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436473AbgJQFym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:54:42 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C27BC05BD22
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:38:27 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id f19so1142220oot.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVnRyUolr4BwE4IUvjoP1hOl3uNRFzt0UHkql5BKxNw=;
        b=HVEf5OkLA30lu7upPvgEAndNVgt9ByZLqZTN/3I7N0TGKpMYQPhEsQYecMcOoebQyM
         bKuU+MbxXCtvME9FcPcSHZV4Yt7sBLvFW3+q5Jq2f96uBFzyvZuIspFmN4HKnzxjwZlp
         e848Pu0nxdhikSe2csuI84B7/P23eaagd0nvZcVINR5cG1eNf4aD/05JzmpkjI1hR5cT
         LxQbczsWlIIm5rviRJQiPAx1r5Ay/DrGNjtfo1dq2NyBymD6oxyeKP2fEszZJTvZU/0k
         YnxCii5fSMpJN8VG+vsEW4NereiOoihx+FNYJgAEi+bRBaWZjELqL9Ie9l51k9C3Casa
         KdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jVnRyUolr4BwE4IUvjoP1hOl3uNRFzt0UHkql5BKxNw=;
        b=VlPKLey22OlRsmk+N7UOVyC+FNlO4oIabnTx8m1eRqPtd335zuhw8Z1SzG9LtY87tt
         H0k1LrNDflWv5w3gbr4Mx/x02QG4GQt/xKnXeYX94ctj3KzbUMHM7X0GagKzKlLgGqfV
         TcTC1iLSfCFsW5k8PYUDng3zsDY6tJll3dgS2ps7XInL7vi2/rO2Q6+vtrORUiNpBT+R
         jggVOIm61TrduIvCYrLve3v8KSd62WhJkbxVqo875ZwCYk6pJ8QBNjaucAPyJ11F3Db6
         w20GxCkUvRh49lbBsPGX9eMMhJyhy5pg4dC1aF9Bl25eiK+r6qrdtHZCcXQnzAp+bC+S
         uh/A==
X-Gm-Message-State: AOAM5330C4aLSK+PWjUDhY2us8Hqx4JumuMO6X00rs7m58ONFyKRA9b8
        +scIeblVe/0SosPU4Vw4w5wpTA==
X-Google-Smtp-Source: ABdhPJwK8Wa0Cux+ocIv9R1uy4sNW7NQ7SRmBhK1inNU0eLZjbU5Tvm0NB7XDk+asw3bkJ7gicxBHg==
X-Received: by 2002:a4a:d654:: with SMTP id y20mr5047456oos.90.1602909506462;
        Fri, 16 Oct 2020 21:38:26 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t65sm1640038oib.50.2020.10.16.21.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 21:38:25 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Thierry Reding <treding@nvidia.com>,
        Rob Clark <robdclark@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v4 0/3] iommu/arm-smmu-qcom: Support maintaining bootloader mappings
Date:   Fri, 16 Oct 2020 21:39:04 -0700
Message-Id: <20201017043907.2656013-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the fourth attempt of inheriting the stream mapping for the framebuffer
on many Qualcomm platforms, in order to not hit catastrophic faults during
arm-smmu initialization.

The new approach does, based on Robin's suggestion, take a much more direct
approach with the allocation of a context bank for bypass emulation and use of
this context bank pretty much isolated to the Qualcomm specific implementation.

As before the patchset has been tested to boot DB845c (with splash screen) and
Lenovo Yoga C630 (with EFI framebuffer).

Bjorn Andersson (3):
  iommu/arm-smmu: Allow implementation specific write_s2cr
  iommu/arm-smmu-qcom: Read back stream mappings
  iommu/arm-smmu-qcom: Implement S2CR quirk

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 92 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 22 ++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 3 files changed, 107 insertions(+), 8 deletions(-)

-- 
2.28.0

