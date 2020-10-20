Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A432292D71
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 20:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgJSSWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgJSSWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 14:22:47 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCF0C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:22:45 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id c10so96613oon.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 11:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpsiELiguu+j+d75TlHy7UatTKslEhtvU0VNkiyQTHE=;
        b=zs9NWLNI035QlA/VBI7c1W2y029/5QTx9et8nFbd2vTWzWmoW13w6gut5QKiSLyOcv
         /iVj0TrBKUDnDE5OOK6vn+u60m6BrHtX1IRsXHLSviusPu5cfGfTElzcPftNUTIyqb+5
         E+su2boKZjvNwFFmNS8aqEDOo0Jjbtg1gtVyM2FL7Ms+J9RzDLhxfGSWfp834QlaIY1m
         ijmyO8/Y7KSAJINJ4woLIJF1CDp4YRJ16sEY7erjyyciGpT1sF22495HxPKYwvnZZs7I
         +KkR94uCA3tX2dGV2S1EAS/MB6Zq605p5Z8vOgZ8QAa8Vw1VqM/BsgZyAnHlOwoamCvs
         nngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VpsiELiguu+j+d75TlHy7UatTKslEhtvU0VNkiyQTHE=;
        b=LutNS5yjLS1xi0aEjxNPkyukCbg7DatA3EjhVQq4HsUm0jCrONE5zq/TF9/G9YyE57
         VUBYCnvU/Mnqy1OdRevzmHPK7Pbr0/Wz0zlkDbEUTd/w6v3H6KzbxTzJdqP3rN7/y9yf
         Ui+2mNRGpXXC2PNQmIccJ4j0utk0q65JwjH+DIClATeaQpFyuVzvSsulf+HJ9hIb5ndL
         K8YFwpJrDztNigUjo/deHxYTYlW4c4w0hghSCPdVUBVdFCQ/762yGHaMKkkuJtXqJC3Z
         49zGQBaigpuPHy8coXwyGbkY6TyvVyxl5wabPlWKuQZ1y/TbTn+2j+6+EOLXChmpXsgf
         zZxA==
X-Gm-Message-State: AOAM531IjdiGVsv/csp4foKDYJtCPqgPvs5XVonPnMyGDjlG6WNre1sM
        kgLP8V7G0RRJVdKyupVdjFao4w==
X-Google-Smtp-Source: ABdhPJxsCpy/TBGLYx5Vl3+4B9L49mmC4/H7jkek9a/kPGO0kiKyGGtmak7p5gL4UV1db2SW7QYkbA==
X-Received: by 2002:a4a:972c:: with SMTP id u41mr931370ooi.10.1603131764686;
        Mon, 19 Oct 2020 11:22:44 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o8sm175296oog.47.2020.10.19.11.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 11:22:44 -0700 (PDT)
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
Subject: [PATCH v5 0/3] iommu/arm-smmu-qcom: Support maintaining bootloader mappings
Date:   Mon, 19 Oct 2020 11:23:20 -0700
Message-Id: <20201019182323.3162386-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the revised fourth attempt of inheriting the stream mapping for
the framebuffer on many Qualcomm platforms, in order to not hit
catastrophic faults during arm-smmu initialization.

The new approach does, based on Robin's suggestion, take a much more
direct approach with the allocation of a context bank for bypass
emulation and use of this context bank pretty much isolated to the
Qualcomm specific implementation.

The patchset has been tested to boot DB845c and RB5 (with splash screen)
and Lenovo Yoga C630 (with EFI framebuffer).

Bjorn Andersson (3):
  iommu/arm-smmu: Allow implementation specific write_s2cr
  iommu/arm-smmu-qcom: Read back stream mappings
  iommu/arm-smmu-qcom: Implement S2CR quirk

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 90 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 13 +++-
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 3 files changed, 101 insertions(+), 3 deletions(-)

-- 
2.28.0

