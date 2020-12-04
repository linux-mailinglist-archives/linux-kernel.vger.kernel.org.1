Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33B02CEBDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgLDKIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDKIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:08:40 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:07:54 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id x6so796642wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phb77RRmwMx9FOp/xmUGf7SRH51PNvbCxvc4HcUSeE4=;
        b=j9P29CViKJdJak3UVUD76CuCEv7hNITzR/v2VxUcCeDG0I+PmqLd4FxTHQTbTPQilL
         0l/UmRlI3xo3vW6zhWJNxZNRiuZhDbLcuv5QpXjzIYFXZi87rUQuW/fBXLOGeoOMYIdX
         h6WeBUdToEsdtSMEIRpTp8kLSKHfW4nHyTisPsxCOB95sU2C9VrC7ms5axoq28pgc+oB
         +xi+DLx/fryIfsMzK7NeTsEQH59tIytsNFPqtTBlstWE+7m3/MW5sAaLBqwuAl7Aw8U/
         Flm/J6uimgtuPTrQK4KAXI0QRPxVSFkc7Th/hKT5XfMbT/GDo7Z6M7B2DAwFOw+N5J26
         bSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=phb77RRmwMx9FOp/xmUGf7SRH51PNvbCxvc4HcUSeE4=;
        b=DoUknJc/zQOnXZdsIMNu4i3Cc1C3/qRi4+48p0S22V7GHPbHYam8/+E72U/rbogIb6
         L+X+4x/lm1m89XsNwX3usHMrFBx8lRP/ELgpel2UQSMfj0ruBgL3taUKSYGVCUD4t305
         EmGecr7GARFlx3x4qcR5SMFk2fMFj+rv0mdMY13uGr5IMwvNOTm8dHzL+7r+49g2ggGx
         7LMscDv92bclT0AQ1Ypwqz9S0KxytMEg7giwm/sGwVPpXF5ihWSNS69cRs7OEtr5/Xkq
         WqYjFJWtKhRrAUmsSKfBeAieel2asNTCECZ4APSSxQ3Efgv967Y+jY42kvLao0NEHEZp
         EqZA==
X-Gm-Message-State: AOAM533lhNU+QsqO0TEogIglzbB0h86i5AWHiDTMhpR4gxO/9aX5oXNR
        aBQSONIGB+a/81WbRlKdR6IdCQqOh4gopw==
X-Google-Smtp-Source: ABdhPJzXEuT2SPVr0xRjGjbcbMb+lwCxOUUlJ3oUOZVUW2IgipiHytB3QW2hT8+5EEGY333c1uL9Kw==
X-Received: by 2002:adf:f0c3:: with SMTP id x3mr3898762wro.327.1607076473361;
        Fri, 04 Dec 2020 02:07:53 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 90sm2913435wrl.60.2020.12.04.02.07.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 02:07:52 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect changes for 5.11
Date:   Fri,  4 Dec 2020 12:07:55 +0200
Message-Id: <20201204100755.2350-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with the interconnect changes for the 5.11-rc1
merge window. The highlight is a new driver for Samsung Exynos SoCs.

Patches have been in linux-next without any reported issues. Please pull
into char-misc-next.

Thanks,
Georgi

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.11-rc1

for you to fetch changes up to 2a211904aca6e68b800177ba5094a0fbe0a8b522:

  MAINTAINERS: Add entry for Samsung interconnect drivers (2020-11-30 17:26:23 +0200)

----------------------------------------------------------------
interconnect changes for 5.11

Here are the interconnect changes for the 5.10-rc1 merge window
consisting of new driver and a cleanup.

Driver changes:
- New driver for Samsung Exynos SoCs
- Misc cleanups

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Georgi Djakov (1):
      interconnect: qcom: Simplify the vcd compare function

Sylwester Nawrocki (2):
      interconnect: Add generic interconnect driver for Exynos SoCs
      MAINTAINERS: Add entry for Samsung interconnect drivers

 MAINTAINERS                           |   8 +
 drivers/interconnect/Kconfig          |   1 +
 drivers/interconnect/Makefile         |   1 +
 drivers/interconnect/qcom/bcm-voter.c |  15 +-
 drivers/interconnect/samsung/Kconfig  |  13 +
 drivers/interconnect/samsung/Makefile |   4 +
 drivers/interconnect/samsung/exynos.c | 199 ++++++++
 7 files changed, 230 insertions(+), 11 deletions(-)
 create mode 100644 drivers/interconnect/samsung/Kconfig
 create mode 100644 drivers/interconnect/samsung/Makefile
 create mode 100644 drivers/interconnect/samsung/exynos.c
