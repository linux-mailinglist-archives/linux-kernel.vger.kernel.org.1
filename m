Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06A02CC5F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbgLBSwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387805AbgLBSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:52:41 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF63C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:51:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id q13so6351868lfr.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCMRWJFHgW0epDmnZ3QZT3N00+SWcEpcWOZCRs/w+/Q=;
        b=BgeVDYkgUd3FtfoBxcBxfhoLaDwKbwMlfZDnj8LU8hy5khXtx6UnsnK55wR8xgxbu9
         rOIEqZl98VeqvIlqRhAbVkJRsxzuY3ciDcfQXO/YJ+7oOf7gA2ghOZX6DFLzuStvJD5u
         INb+Nsqo+DkNYSuINFNITtPAiGUlLwLuC7NWrReICLZ7KsDW14AUaTMwUy0pFPSXwEM/
         am42OH91QT5EcBo7jKX4diYfLJ5JlMb7RuajKnNKHjoS2zZfoPtuh4BzVVrdgQv9Ccdc
         HsyoBo/YhJfPE6QzIUKK2EcgOcOgP/EAx/kWYMoIplS+Zih8Hb7ecE7qfE+kCCF2sI6+
         Q35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCMRWJFHgW0epDmnZ3QZT3N00+SWcEpcWOZCRs/w+/Q=;
        b=nyGnNTjZ40a+5jh0nOTKiaXLwdnqrRu0Bael+UIBA6bYuNuU0f8AWJ7uXjwGmBAdf2
         EB5/1sJhVxJBmMI6R233dzkRNh+r6STrpGSU9QOo4zNOC+3eK92bJj6+9De6xE2oyaJD
         5HU3jUdt+gzAE84El4YWTRRi31HWPrYS4fa6VXenaPpQuPmcakHxBEjPscFeg+9cvYYk
         W6IXpBMcWM7FQ2zyyVB4jxdALHP9Zk6gFOYlNFpuAG07fXDBIw4zH8+tANwq7Rj60s+M
         RciM7hpJtk7HfEOutLQFMoQlUTx/nTgbC2XNhkWHci2M4AaRz/GS9+opNopyt6DNRkzw
         edVQ==
X-Gm-Message-State: AOAM532dr6+K0igev/c/uSE9TJ5BQq3lVFS5k1vRsOurpS6DsE+AE2EN
        GdnRA4PtbXXSgMOPQhzl/Kc7KN/ddl6veVC0
X-Google-Smtp-Source: ABdhPJx/tUZbr/lJ1lUD7HYMEzn6WHkSqY94xkZWmEGzXgjf+VUa7NZMiEeFAEj+ZCS4mCzSiIQC1Q==
X-Received: by 2002:a19:3c2:: with SMTP id 185mr1955420lfd.403.1606935113021;
        Wed, 02 Dec 2020 10:51:53 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id y134sm666365lff.162.2020.12.02.10.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:51:52 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v3 0/4] sdhci-xenon ACPI support
Date:   Wed,  2 Dec 2020 19:51:14 +0100
Message-Id: <20201202185118.29076-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The third version of the sdhci-xenon ACPI support
addresses a comment regarding clk_disable_unprepare
dependency on DT.

The MacchiatoBin firmware for testing can be obtained from:
https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp

Changelog:
v2->v3
  * Call clk_disable_unprepare unconditionally.
  * Add Adrian's Acked-by to all patches.

v1->v2
  * Split single commit to 4
  * Use device_match_data and dedicated ACPI ID's per controller
    variant


Marcin Wojtas (4):
  mmc: sdhci-xenon: use match data for controllers variants
  mmc: sdhci-xenon: switch to device_* API
  mmc: sdhci-xenon: use clk only with DT
  mmc: sdhci-xenon: introduce ACPI support

 drivers/mmc/host/sdhci-xenon.h     |  12 ++-
 drivers/mmc/host/sdhci-xenon-phy.c |  40 ++++----
 drivers/mmc/host/sdhci-xenon.c     | 101 +++++++++++++-------
 3 files changed, 97 insertions(+), 56 deletions(-)

-- 
2.29.0

