Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE642BA118
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgKTD1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 22:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgKTD1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:27:04 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C4CC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 19:27:04 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id s9so8540835ljo.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 19:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9yk9CQBv+wHVI+u3khuln/FnkAkgCRh1kbuFM32wYo=;
        b=HScsIqszCe4ZeQN7agASe0mHYVTAAsmRlik/QecWIfQ7ENPlG9DvXMFMMm6Fi1Jg/E
         vQiHWZRnEsl9X/K7wdfIsSH9uTdutyzbtQzsql708OAM2pNnOnOf5QZSCu2ztHymLDWj
         ssVN2kECw79wU/VrU5muycbjsBoXNc8rfHNnba0JT9XlKTjA9pbykEQWAEjIgHR7MPkl
         xNKIfSE8Xe4UupU44IZVa0Q6rgIK24quNEGewMp++YHzRcwCi4aVp6K+8Ot2do5EXS+q
         HxflTZPg5rIU2MxgYDT3XegXKmSYswaphvf6BeAc0Ew+GbXe1g68z7lVt5juGOQj6lGn
         qpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9yk9CQBv+wHVI+u3khuln/FnkAkgCRh1kbuFM32wYo=;
        b=atGIehKG2JUAZHKogTby7ZRk0G/ScvpQWtkE4Kbb16gvAyRX4rHIV+MEEm5+ydjL/6
         a5gBOUl2gmBmF19/bDwAwxhwaxC2HWHIm25JVD4aUh59mKwWzKeLN++X2ydydfsM8Yeg
         RDMhyNbnFERho0TWqqwCJ9nOX6D8F9/Zn0d8HCkoxCkucFU9Oo+3UB1IwfebkTz1qwl+
         D/RTREQPt9WPaL+NsYtzpNiBUlpvp/nMhU9KZ6e8ue9f2kvuz+Fw/5906UQ5i7gZyCZM
         rHOT0hSSRsTRWvfEfc0Ln9PnjGO63DMdqM8DRoDZ58UWb46awhcGjMYIcORVhm/VdfS0
         cozw==
X-Gm-Message-State: AOAM530/upQgKt9w9V+ek9r2vGNZ1w8SbFyCpb7N24p2nno5AU1gjCRb
        KhJ3vBd32MkOsIJHnxDnBbeHfPAwAeoBs8YO
X-Google-Smtp-Source: ABdhPJw/xASpUOgSh8LBQvQ2MraAR2lQubQ5Vtuk4iIgbG9734HMINhrlkWn+g0fljbxEVKi23Zh4w==
X-Received: by 2002:a2e:8846:: with SMTP id z6mr7270703ljj.311.1605842821629;
        Thu, 19 Nov 2020 19:27:01 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id s26sm153647lji.31.2020.11.19.19.27.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 19:27:00 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 0/4] sdhci-xenon ACPI support
Date:   Fri, 20 Nov 2020 04:26:35 +0100
Message-Id: <20201120032639.24386-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The second version of the sdhci-xenon ACPI support
is now split into 4 patches instead of a single one.
There are minor functional differencse - match_data
introduction and using dedicated ACPI ID per
controller variant.

The MacchiatoBin firmware for testing can be obtained from:
https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp

Changelog:
v1->v2
  * Split single commit to 4
  * Use device_match_data and dedicated ACPI ID's per controller
    variant

Marcin Wojtas (4):
  mmc: sdhci-xenon: use match data for controllers variants
  mmc: sdhci-xenon: switch to device_* API
  mmc: sdhci-xenon: use clk only with DT
  mmc: sdhci-xenon: introduce ACPI support

 drivers/mmc/host/sdhci-xenon.h     |  12 +-
 drivers/mmc/host/sdhci-xenon-phy.c |  40 ++++---
 drivers/mmc/host/sdhci-xenon.c     | 120 +++++++++++++-------
 3 files changed, 110 insertions(+), 62 deletions(-)

-- 
2.29.0

