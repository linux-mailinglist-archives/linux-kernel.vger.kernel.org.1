Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE17279DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbgI0DhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbgI0DhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:37:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF822C0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:37:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so1843029pgd.4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQaUnoAH1C1tw4/jDIjVLHYjHISZCikIVgp2rtLZhwI=;
        b=YyZKNo6xzcr41ymQJx7mMCSbM2sehFkPgOet4qGlnngbvePG7kkBMB9dLwqD30IaH7
         +oQraSZFM63Zc5yQT5oGbguKOx1m4JQrvjGN/R8Si7+HqKCrgFYvhpVRKGLOvSKVMvVt
         gAIhP3b+sWQBgL3Ym42Vk2irm0wYR/61tKeboQbxMAb7JXodEHhttlBoLLl97BDd4ksr
         27vhaVcajQHe2KyO8r4LpOirfy9U8P8pgXQzlqfN26UlLImEDQ0zSlbvB3d8rvFCQl5T
         W2lQlse8386qWpkRyscPUSHgOfC9b6HVFYBdivjMyFCppZeZXM8bFhAnePYe+0P9wWuO
         uTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RQaUnoAH1C1tw4/jDIjVLHYjHISZCikIVgp2rtLZhwI=;
        b=uMvH2LEwIZU1P6gPwEDg3Cr822SzJF0y/SKmt6Zx5tFTjMaF2/EMjBaTOeKVAuvSEY
         jaf1EUDYyQ9rd1bHC7so08j2cDoZMfkN8ZKNC6h4hYpcBvBJCkESNXr/N8A38Jhbhd81
         PUNneBMFgPKMgmXzaNgsJF5jxNlV5yat3tIXESR0UvgLAsMTi42fLph5wHoHYXErKCyu
         OexD7nQmJ92uVo/yXB3coRwTDSSNVnuyrReQUl/HRqC8rDFmWSHBo0nb0J3d4cMOW6wQ
         optdeurazYidwQkVbUXBgOGEuIFuU95SeAMUtHu5ZCQDXTf/F6F49tqPINUv94I/CX0V
         1SMA==
X-Gm-Message-State: AOAM530b5sYscWJ5rUPDd56/ycHFEzZBEP+FnqmlunYyfq6GxVrXydj9
        pLCvUZRYhbmngN0YsnK78+iA
X-Google-Smtp-Source: ABdhPJwAmBj1HbUO+eiZYhoX+EmaV6ljDLkA4vaZDYE/Y0L07qGO89B2pLbeGAZG7VPR4PwJokcaqw==
X-Received: by 2002:a63:3:: with SMTP id 3mr4454205pga.44.1601177820216;
        Sat, 26 Sep 2020 20:37:00 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:980:cb63:5c53:a3bf:dd6b:614d])
        by smtp.gmail.com with ESMTPSA id gx5sm2821439pjb.57.2020.09.26.20.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 20:36:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] MHI changes for v5.10 - Take two
Date:   Sun, 27 Sep 2020 09:06:47 +0530
Message-Id: <20200927033652.11789-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This is the second set of MHI patches for v5.10. The summary is below:

* Fixed the format specifier used in debugfs interface. The issue was
  identified by building for ARM32 machine.

NOTE: I've sent this patch separately for review.

* Removed the auto-start option for MHI channels. This is done to avoid
  receiving spurious uplink from MHI client device when the client driver
  is not up. The corresponding qrtr change is also included with Dave's ACK.

* Moved MHI_MAX_MTU define out of internal header to global to use it in
  client drivers.

Please consider merging!

Thanks,
Mani

Hemant Kumar (1):
  bus: mhi: core: Move MHI_MAX_MTU to external header file

Loic Poulain (3):
  bus: mhi: debugfs: Print channel context read-pointer
  bus: mhi: Remove auto-start option
  net: qrtr: Start MHI channels during init

Manivannan Sadhasivam (1):
  bus: mhi: core: debugfs: Use correct format specifiers for addresses

 drivers/bus/mhi/core/debugfs.c  | 15 ++++++++-------
 drivers/bus/mhi/core/init.c     |  9 ---------
 drivers/bus/mhi/core/internal.h |  2 --
 include/linux/mhi.h             |  5 +++--
 net/qrtr/mhi.c                  |  5 +++++
 5 files changed, 16 insertions(+), 20 deletions(-)

-- 
2.17.1

