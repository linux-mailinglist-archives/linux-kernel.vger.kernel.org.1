Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C842FF7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbhAUWSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbhAUWRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:17:52 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F185C06174A;
        Thu, 21 Jan 2021 14:17:11 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h7so4801756lfc.6;
        Thu, 21 Jan 2021 14:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTdcptpSm2/2kQ4ITDCD3u4iHif9C6Z32QhGryRFTNo=;
        b=X9nK5kWVUwdXGhRk1zgAC+0+3tmUxrMvkZHONXZR0R2Hv8rJpKyBuYQjkwDlxSbg4U
         sd8JLvpa8eDZifyYrKAUPdeSX7AUAbUzpzETzPENNY6cDGQZTb4T+flyKx0A0SU62p09
         WNaEH1W+DUGD9vjpuXl1vq5vdZPqW7vwC+EVuRz0rQoXjBtUj49AhwSFh8n6TcYCRVvQ
         flrgH5mzMBhPG21qeopZGBrcSgCAB9NjzJuBcGjs8kuQGM4zhgyHiyt2lroyqCiXmmfG
         WnO2y7aVvYxCHwzqS2T2vy4UZFZlG9ldIYtlwvvVWoIRXfs91aL9zLmpRfpr7u5gm3Dy
         1BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bTdcptpSm2/2kQ4ITDCD3u4iHif9C6Z32QhGryRFTNo=;
        b=NIKNkh7YdJIhxREvNym/0l+jzT2SgRHVh7h0DCvnB1QOJxktfBX7hzvqd99o+4Qvbs
         XR38xU7ZeTGSktjFm9xjiYV0eCptShZD2Js67dVqppR9ahwuwQUs+uH+wSkKkTQBTRpm
         SBREH+2ZgGyy2i/sJc+3uhnSNzqaWHVttaYedz5OMIQIB7ss+REQlMU5RiLbwTe0t0oA
         Qs2d1rDksFOJp97dTpH9vLhqujtf4FIN/N2OsVUZMvgFvs5FCHpc0QxoRWY1Q+wcVoY1
         tDCjd3WmgXB0yDPfWM1uzOEZlkLShpaJvkV/muVbQ/sHY9+GWthsOvQrvzmj8txF3i4L
         IIEQ==
X-Gm-Message-State: AOAM530MFvYfF05jOaLE0a8Vz2KIma3Ly/qpnexbKp2DgvbGirAwPFj2
        bK/+Ia1fPx5P2hE5y/iofc4=
X-Google-Smtp-Source: ABdhPJzw15v1ElGgpB6rx9040A2JaIEsnt0eyNRuGP9WeK4eNRxdxbDYCUnLCkCLuXpaek++4hsyYQ==
X-Received: by 2002:a19:c20a:: with SMTP id l10mr690111lfc.155.1611267430097;
        Thu, 21 Jan 2021 14:17:10 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f3sm717600ljn.129.2021.01.21.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:17:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3] regulator: Make regulator_sync_voltage() usable by coupled regulators
Date:   Fri, 22 Jan 2021 01:16:49 +0300
Message-Id: <20210121221649.23155-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make regulator_sync_voltage() to re-balance voltage state of a coupled
regulators instead of changing the voltage directly.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Dmitry Osipenko <digetx@gmail.com> # A500 T20 and Nexus7 T30
Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v3: - This patch is factored out from [1] to ease merging of the patches
      that will use the regulator_sync_voltage(). The goal is to get this
      change merged into 5.12, it will remove dependency for the Tegra Core
      power domain driver which will target 5.13.

      [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130

 drivers/regulator/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3ae5ccd9277d..032d4e7df682 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4148,6 +4148,12 @@ int regulator_sync_voltage(struct regulator *regulator)
 	if (ret < 0)
 		goto out;
 
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1) {
+		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+		goto out;
+	}
+
 	ret = _regulator_do_set_voltage(rdev, min_uV, max_uV);
 
 out:
-- 
2.29.2

