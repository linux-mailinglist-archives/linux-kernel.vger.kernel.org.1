Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58292DB5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgLOVMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgLOVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:12:39 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70309C06179C;
        Tue, 15 Dec 2020 13:11:58 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id w13so43047655lfd.5;
        Tue, 15 Dec 2020 13:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3X74Gn92CmzSE0xtNR4fTjTY8tQLz8gMoh5Chc512BI=;
        b=dds+v7hZ7Djneam6IRNyv3CLv58my/l1WQ3CllrmCsg7ndvIN9n1AtZSqGhXkTcdRr
         ToZBuh2CuTAwkcOxUc6oRVQYO3f+++YINUT/fxnotxKIsB/j5ddOuWTux8QuFN1SplAn
         m+tsqxwN9nBOZLYV4VoAPUQ4JfUNTOc9GGd0aV7IvC+TsEjSyxRDjFpnowceGhkunLkM
         oxQq19J5rmFjUvq2bpoOziot3CKccb/kA2/MCnFmKSeaCMXfD63OQIqL8slsuoYCE7ZH
         eTamlKk/0DsRMRsf5j9guzYx59BmFqG4Rkg9tmTzIfQ1FcgDri5jjJYzH3V4YhLVVnrn
         lB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3X74Gn92CmzSE0xtNR4fTjTY8tQLz8gMoh5Chc512BI=;
        b=kfNrwNFYTC7KJE/jXI8GzOGtuYSlz13fY0pWedDq5Lsp+f6hHaJ3G1Cq0gTi/Mkqt3
         CiOE7oX58k6mzN+SmKr06gRIlXTI6iYxHz4Nb5xchjYzioaQCTQmxgq++ScUOZyld8ZT
         7ejpPeeCCpfrSHKOQggD1MAI1sigDrUMutoEYLx8I/6qN/CDKNDWCLEP2XMS6T1DcGyg
         KU8Hh1NP7GXMEnntIKN2i1eKYXRA85UfcWX5HPCKaC9h/BlFbGen4eYEgL7KNKRaNZhR
         VrXYrdDHuZWqDTFQBxjGO80uMPICpLjwg7VsbgO4dcq92YNDftNK5W6kqA3/C/XOLbYp
         n4Ig==
X-Gm-Message-State: AOAM533BgtMeD+CGY3de4FWNsufFae6/BwSIpyhywmWIA4V8nLtqy/Zt
        Rxgem56xtdLrh8YNMAsHcog=
X-Google-Smtp-Source: ABdhPJwqXcOjBiNZg04/EhQpWThWi0CPuB4RAqPLg9ArnmDMEXIbI9DANKqzmUAKfkWXBrDdMWGsvQ==
X-Received: by 2002:a2e:9654:: with SMTP id z20mr6739941ljh.54.1608066717031;
        Tue, 15 Dec 2020 13:11:57 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id k11sm2572079lji.95.2020.12.15.13.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 13:11:56 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] Couple improvements for Tegra clk driver
Date:   Wed, 16 Dec 2020 00:11:47 +0300
Message-Id: <20201215211150.21214-1-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes couple minor problems of the Tegra clk driver.
Please review and apply, thanks in advance.

Dmitry Osipenko (3):
  clk: tegra30: Use 300MHz for video decoder by default
  clk: tegra: Fix refcounting of gate clocks
  clk: tegra: Ensure that PLLU configuration is applied properly

 drivers/clk/tegra/clk-periph-gate.c | 72 +++++++++++++++++++----------
 drivers/clk/tegra/clk-periph.c      | 11 +++++
 drivers/clk/tegra/clk-pll.c         |  9 ++--
 drivers/clk/tegra/clk-tegra30.c     |  2 +-
 4 files changed, 63 insertions(+), 31 deletions(-)

-- 
2.29.2

