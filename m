Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCE727B897
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 02:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgI2AEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 20:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgI2AEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 20:04:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6560C0613D3;
        Mon, 28 Sep 2020 17:04:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s19so3035plp.3;
        Mon, 28 Sep 2020 17:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2F2+5D5YYyNtX412eaEEkRAVLuYFhL798dSPFQt/UiI=;
        b=KN7aVqVR2irl+UwyQ/zwfgh5MAtJqeXE2N50vSO/iqptVA7aYfjoFof5Ns9kuNbscY
         rzp0TsTPcIGTWZIA+i+EPEwRQfgP24eHdkOBtltnAgOw/CEjGTNCZZw1h1+h+22JBRv0
         P2uWeCDjzsbVnf5pafKMnnSGrrJ7Uw5g9LZkqAjAkc2mOpMTfUuJLLtYDnSGGXiRHStS
         7HV53RqU5CE7dw7qzLUpmyzHotpwRVwcT3V4hniOJHD72f2kJw4XrhOAzq4CleSxXHZU
         LICALTYjQJzbtI42zVkbs9SaeBBWVC36agePjxCRhiz1zQduauhwV2UZVRArEaCDJgYb
         hebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2F2+5D5YYyNtX412eaEEkRAVLuYFhL798dSPFQt/UiI=;
        b=maRNy/gPHYHpngy9faVEdATZuhiVJkEumAv+t7May7qYl+TB+gJEhc53wHpmFKVlXU
         paBhggvVI3lt5MrbvdymWnVhViDZQLjTxqEwQ7TQwGazRJ4CT/wvNtl1Ssv/FNmE93Ul
         2L81lWG4fI+7Y9yXjh+FCGYpPmGJ6dU6+4u69/ORgN343lGPI9VRnc586nWlHNKZjzdV
         MZKfi+jvZi9jRVBe+K7khOAsIjjY1maB9Q5+u7EXZGmqv2kmoCTA8HKhUZ/xvxr+77hl
         BcBESpzMT9CkRBH/vX+aMmbWU17wecGTnk3a+gxiu4vpXw/ejuGx5PSM5JTYpvdgdwUk
         +iEg==
X-Gm-Message-State: AOAM531FOVCT26t1j2qT9QRHdWHN4lx2mq5h09aigkhvwbCFAgV33RGX
        g4/f4ck9jo4vrqUqrZUx+f4=
X-Google-Smtp-Source: ABdhPJwgFda4M/Fy6oERQj0m1JqZSIWvhaK/zpKP1yJw7KCeqXlbxVK7LrTLpsSN/pB8+dspfSVhBA==
X-Received: by 2002:a17:902:9b89:b029:d2:42a6:88f with SMTP id y9-20020a1709029b89b02900d242a6088fmr1789567plp.71.1601337886094;
        Mon, 28 Sep 2020 17:04:46 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id fz23sm2392814pjb.36.2020.09.28.17.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 17:04:45 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iommu/tegra-smmu: Two followup changes
Date:   Mon, 28 Sep 2020 16:58:59 -0700
Message-Id: <20200928235901.28337-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two followup patches for tegra-smmu:
PATCH-1 is a clean-up patch for the recently applied SWGROUP change.
PATCH-2 fixes a potential race condition

Changelog
v1->v2:
 * Separated first two changs of V1 so they may get applied first,
   since the other three changes need some extra time to finalize.

Nicolin Chen (2):
  iommu/tegra-smmu: Unwrap tegra_smmu_group_get
  iommu/tegra-smmu: Expend mutex protection range

 drivers/iommu/tegra-smmu.c | 53 ++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

-- 
2.17.1

