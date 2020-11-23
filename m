Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8DA2C0F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732376AbgKWPle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgKWPlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:41:32 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56511C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:41:32 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 1so17663043wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Uq8D+ZGI+Bc11T83i9o/qJZyW19SxDleKradfPQPuc=;
        b=u1zL4dcWJokw00I/TfBex3TsezuvaSBrSBcuWQpXvLQQTo+Fay5PgoDj+d3n9U9wVc
         mcp8nZKNfKizf4fjxsDBRyRwtlEaMU8bnnwBTlacrgXdDtmZuwjtOIYZCnxoHQqKOMhU
         wShOwEHiUZSZAAifogg1jKZ9sf5fdAnv6g3tm2JPIF4Q9bT1VOxYJT8p7UeLpRsKP9cn
         BmUIfLgTKxgRevP9hK0WHHkpPFEzQmA0+fGPzmmD9hDPKSBLo1GMglZB4OyL5h8kZFU6
         kckdAKtWEntdX3aRoCAedfKSE5Yt1CzCUU70q+HbMaObc4JGYRgsdbib9sF5NwfP357B
         zdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Uq8D+ZGI+Bc11T83i9o/qJZyW19SxDleKradfPQPuc=;
        b=DBs/btoVfKcEDpOsEYNUToXACphQbAbIiALnFvZrHdLO/uJRL6mxZst+dxCRN4rdlj
         RTNGNa4+c2sUmUn9g584mgo9ft2VGmNll6JbtQZm9vYl4SYJ5X42lsbDy/bmwTsnvo4N
         9jk2Y7NPrymavBNtEZcNi/C8dTPMapJftkLuQPbnjt09VveJWz6DGq/O2KvSAyRhoqVH
         AignhPnWiW2S8Znyne/PhdeTjZVVp+EXspEU7C7JpPPkcjWeuQgyDatn7x4IRlSjXGpu
         8Lgr3Q/jleZ559715GdTNlUYACFZQmXmcfhqEeTN94LsBBFYwZUehpAf5C0a4bwjkZD/
         0cIg==
X-Gm-Message-State: AOAM532TMi6JKRW8MNbM7GqZVezWrurFwTpsKt1dF9jIq3LYbIEe0fgt
        qIp3weDqttWpWKY+O/HDlt6ksA==
X-Google-Smtp-Source: ABdhPJz09JSt+VxjzsaxsjEEBzzgj5Y2lrP+kn9HKZbm8ilrgG+g0sGtv8sjIhfSGb8dmjeTAvgb/g==
X-Received: by 2002:a1c:a752:: with SMTP id q79mr24088747wme.24.1606146091006;
        Mon, 23 Nov 2020 07:41:31 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y20sm18422954wma.15.2020.11.23.07.41.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 07:41:30 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect fixes for 5.10-rc
Date:   Mon, 23 Nov 2020 17:41:30 +0200
Message-Id: <20201123154130.26972-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here is a pull request with a few interconnect fixes for 5.10-rc.
Please take them into char-misc-linus when possible. All patches
have been reviewed and tested. They have been also in linux-next
since last week.

Thanks,
Georgi

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.10-rc6

for you to fetch changes up to 017496af28e2589c2c2cb396baba0507179d2748:

  interconnect: fix memory trashing in of_count_icc_providers() (2020-11-20 16:01:35 +0200)

----------------------------------------------------------------
interconnect fixes for v5.10

This contains a few driver fixes and one core fix:
- Fix an excessive of_node_put() in the core.
- Fix boot regression and integer overflow on msm8974 platforms.
- Fix a minor issue on qcs404 and msm8916 platforms.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Georgi Djakov (4):
      interconnect: qcom: msm8974: Prevent integer overflow in rate
      interconnect: qcom: msm8974: Don't boost the NoC rate during boot
      interconnect: qcom: msm8916: Remove rpm-ids from non-RPM nodes
      interconnect: qcom: qcs404: Remove GPU and display RPM IDs

Marek Szyprowski (1):
      interconnect: fix memory trashing in of_count_icc_providers()

 drivers/interconnect/core.c         |  1 -
 drivers/interconnect/qcom/msm8916.c | 12 ++++----
 drivers/interconnect/qcom/msm8974.c | 12 ++++++++
 drivers/interconnect/qcom/qcs404.c  |  4 +--
 4 files changed, 20 insertions(+), 9 deletions(-)
