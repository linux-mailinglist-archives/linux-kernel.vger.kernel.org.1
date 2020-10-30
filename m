Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCC22A03FF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgJ3LVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJ3LVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:21:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6384BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:21:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k10so4703463wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PY8VY7Lg2r+nNtn/aiXnf3Ry80P2IGhr1b0m3sFi9DQ=;
        b=EifaV15jGWbv+xrYmi8PHuSMmiSPUIpOec8jdquckPbYszwXuOdaGWCDJ5fa3SMld+
         p7XY+v9sBhQ2TC69nFqrtW0kTzjUZh7uqP6z/YYMh6kWHO6PGBkLbjJ1C81JkgymScfp
         GzwfYqu0ycoicLJOHxHwvW03x5ViT6IaGYfGhx/6rpolX9Qjd4CNBV5w0UM1LK3qT8G6
         9EmDoQgnhMASbEVNr7Sa0aDEN0/Dzp3PXkVYgnx5SB4lARH0jSLoX05QZcJKlWPVlAHJ
         3buujft3D3dt60h8ts0XscmcLp5jftXxT3b/5+jwwuX36c27xwxlKiYdPNB/UCsP8a+T
         W5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PY8VY7Lg2r+nNtn/aiXnf3Ry80P2IGhr1b0m3sFi9DQ=;
        b=fKFk4nbc4zHGNgmo/+LaXCJ1G9H0UELuf/v8GlIiQZ05IwKPoXk+w9GQxuH+WRJce6
         A5EJe9GOKFYz1XWt+MjCThHLU+KMVlGNqAQ17q8o1Ac0oLZOFvz/Allci8GzGDPXzEDP
         OdoV2C6I8KNNYg6EjQ052DIN0KrU/9QmytejDZm9dW8h+c3GZ6MAqzHuiVSYkafcoOaJ
         6kAzEHTFTjKXMVKHe5/zvadAacClfXtdo7WcSPrWqxqCuCX4enVbveFcTU2iLa5cS73p
         BeFG++OepbFKbXxIQDLKqCeTDiAIBgAVrVjl2d7+Sg7yrDQChKFqO5KVATO9QPkmVCjb
         +lqQ==
X-Gm-Message-State: AOAM532ivZke4xCBv9CjRUCdbppRN3U7YRf4GMctqv3n9R37Ksm9jTPH
        HiZcnAiNMYUYsp4kkW+7LM7HQw==
X-Google-Smtp-Source: ABdhPJyYoG+Ufe4d6bH2/5AFGxInIECDMe61KRfWD5Evy7c+I7WSrVQJlVzvyO4uOU08BvV1rZtXXw==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr2544785wrs.423.1604056870033;
        Fri, 30 Oct 2020 04:21:10 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id d20sm10716237wra.38.2020.10.30.04.21.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2020 04:21:09 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [GIT PULL] interconnect fixes for 5.10
Date:   Fri, 30 Oct 2020 13:21:10 +0200
Message-Id: <20201030112110.2362-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here is a pull request with interconnect fixes for 5.10-rc. Please
take them into char-misc-linus when possible. All patches have been
in linux-next with no reported issues.

Thanks,
Georgi

The following changes since commit 86d6e5793e0fa3a510cff466894d0d3051fd716e:

  interconnect: imx: simplify the return expression of imx_icc_unregister (2020-09-21 11:15:02 +0300)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.10-rc2

for you to fetch changes up to fce52ad3483281930dc9215a68d69837f219f889:

  interconnect: qcom: use icc_sync state for sm8[12]50 (2020-10-27 16:01:22 +0200)

----------------------------------------------------------------
interconnect fixes for v5.10

This contains one core fix and a few driver fixes.
- Fix the core to perform also aggregation when setting the initial
  bandwidth with sync_state.
- Fixes in some drivers to make sure the correct sequence is used for
  initialization when we use sync_state.
- Fix in the sdm845 driver to prevent a board hang that was hit when
  bandwidth scaling for display and multimedia was enabled.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Dmitry Baryshkov (1):
      interconnect: qcom: use icc_sync state for sm8[12]50

Georgi Djakov (5):
      interconnect: qcom: sdm845: Enable keepalive for the MM1 BCM
      interconnect: Aggregate before setting initial bandwidth
      interconnect: qcom: sdm845: Init BCMs before creating the nodes
      interconnect: qcom: sc7180: Init BCMs before creating the nodes
      interconnect: qcom: Ensure that the floor bandwidth value is enforced

 drivers/interconnect/core.c          | 3 +++
 drivers/interconnect/qcom/icc-rpmh.c | 7 +++++++
 drivers/interconnect/qcom/sc7180.c   | 6 +++---
 drivers/interconnect/qcom/sdm845.c   | 8 ++++----
 drivers/interconnect/qcom/sm8150.c   | 7 ++++---
 drivers/interconnect/qcom/sm8250.c   | 7 ++++---
 6 files changed, 25 insertions(+), 13 deletions(-)
