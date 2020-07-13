Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD08521B08E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 09:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGJHwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 03:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgGJHwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:52:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D549FC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:52:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so5355671ljm.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oFIrmZGV+ZEuN3a4UzFRY4jDqpbgwIVGMqqY/aPagw=;
        b=Kf35N59M9qiHElyqYUKFB+j6ySnjXJey2z9LT5MipIrL6XBCtUfYeNKYQfO5Maukte
         VWc9VzwDDDJLSwgx48gy0dwBvAA9dEx/MstTHNASWFjMKtfgVmg7xqipD3DkAhzNCYZp
         qw1CIj7mQWwCBLe0FI8xBrkXDbVw7tHhRFDm2GAj4ap/2L2M/ee5nXQ1llWmWEINzlVE
         mDvrgVQn/ckEpSKxumS7CI1bfyiNa0jwf7/DwudEdtmrrT7ituMyalLelmH5wPp/GEMf
         fUi20hvfC5kjxVUz41Nua9nRU+RGlWJnHaNdalpHPotlRuSFCH0Fd0NG6eOQlg3ytPtI
         Ra6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+oFIrmZGV+ZEuN3a4UzFRY4jDqpbgwIVGMqqY/aPagw=;
        b=WBt44cD6/+pg5OQgfPLotToAJcMOtcdXj01oP4NC2kfflDHWKGkkoMuS/iHF9/nBwH
         nlFh/1IbBKgJXkC+F+gxlxDOvcZJdRzjAxjDlV/smzX/Hteb+Hpas2SF0Oydt2e3jsgo
         WPYiRmEnYk201c3NDTrYW8fM0Q1Zfmcp5VBgJR2ZUW+Zk7/fgFH2SjE+eKE4qduC0nCT
         9KzHTEJyR37Jc7dhFRABt0G/vPhGmLTqjtOmCKjRv2IeJ8B+sGFhzy9qE6kXLj26Uyqi
         pvlQQ7rcYNBmJXN1MtpSJ6eJyxqKho3F8ymffUMEE66s7As3B1yDPEHX6gW1hcT7lfb0
         IzGg==
X-Gm-Message-State: AOAM531XTk4Emt23VnRphJyxjFb1+M2qLWiodiZ5gUb/2R6gR9jv6dR3
        8xCReciAzkfWiFXn0Ddf/ssHyg==
X-Google-Smtp-Source: ABdhPJxSos7J5sZ8wIpuqp/f0cczF3c92h0YoRJNJrQCv5ckuVMprrqgF7XztA8wxvvCASff49ocjw==
X-Received: by 2002:a2e:730c:: with SMTP id o12mr33201055ljc.165.1594367556217;
        Fri, 10 Jul 2020 00:52:36 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id v3sm1629478ljj.110.2020.07.10.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 00:52:35 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.8-rc5
Date:   Fri, 10 Jul 2020 09:52:34 +0200
Message-Id: <20200710075234.24987-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.8-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc1

for you to fetch changes up to 3ec2d5113ea5e182b759b613dc1f7108ba7aac9e:

  mmc: sdhci-msm: Override DLL_CONFIG only if the valid value is supplied (2020-07-08 15:30:35 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-msm: Override DLL_CONFIG only with valid values
 - owl-mmc: Get rid of of_match_ptr() macro to fix warning
 - meson-gx: Limit segments to 1 to fix G12A/G12B SoCs

----------------------------------------------------------------
Manivannan Sadhasivam (1):
      mmc: owl-mmc: Get rid of of_match_ptr() macro

Neil Armstrong (1):
      mmc: meson-gx: limit segments to 1 when dram-access-quirk is needed

Veerabhadrarao Badiganti (1):
      mmc: sdhci-msm: Override DLL_CONFIG only if the valid value is supplied

 drivers/mmc/host/meson-gx-mmc.c | 6 ++++--
 drivers/mmc/host/owl-mmc.c      | 2 +-
 drivers/mmc/host/sdhci-msm.c    | 5 +++--
 3 files changed, 8 insertions(+), 5 deletions(-)
