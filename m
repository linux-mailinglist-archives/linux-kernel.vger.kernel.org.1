Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C45F2DABC8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgLOLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgLOLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:18:10 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB09C06138C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:17:26 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id z12so1029833pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znqjVcIUohDW9byeGOeLaaO4J3p/ISagnyXoutieqQM=;
        b=ejEKIWte6vShA1V5GcY+GH0Mrck0B5OCU2WR6/iX4Ky7NJzg4Opv+uxsU5ACKWlQZY
         CPU6dQ58qPSRzfHCIT8bkrUKVz4Qnsr6eSIEmrV8w2fcqFfhvJw4+s/Od+gNcBS4t05Y
         oe0xWb9ecbp7DJQxjRRnL4o7NNr4gD7tjFG9BsUTExjgaDbnF4d/6eEBMQzrTC4V2+yA
         N2IaqjrgHKsnBqCev9jG7WmYC9ZcAhlzI+Vw/cDu0fGyLXzuHCJaeZrX+oOeVXz+mvVZ
         l4yQWaUM1b8xgnQNHtvNkL1x2zpbXW7cCGE/n33gechYhxpnAlfIKzeqLuZNpjoq3kbW
         paJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znqjVcIUohDW9byeGOeLaaO4J3p/ISagnyXoutieqQM=;
        b=phUJqyLjCaQzEfpzG2LrJ8Fah/tp/XiI8vzjZk6q+NOLO7VnTxmXEZyQ0gXw6FIltd
         tbdjwX64cURtL6sZwQ/8MltBcvyB1mpNgozbIWKvVvb/tHIgrMJiFwa2D/iTGGZtWOfZ
         N2C5W20TuyZXa9wJ/eHB9FvMutmzpuKiJkY6CeQtd0EW3bToHhYwcY3Skop8DXMBQBQm
         f3tm42JVsMtraJSUlsGQ5Pce84Toz2t/TPXfMypr2Ar0C4K0gGl2dSzhedqwnTDX0M9e
         1NZZC5kqJWMWlmmEoMhmqDPx8dbG63IDgG9zAsL/FAK2zDH88lmGCPL5EnOLn2EMfILA
         uzHw==
X-Gm-Message-State: AOAM532ISCedIzmyLj3O5kZksdt2hX89epF5AGh0t+c3h+gY18RMPVF1
        8oJ1jJvfW9YDLIuTY0hIAMeFmA==
X-Google-Smtp-Source: ABdhPJyQGdP/zFJ+DNvgHPRi6JX9qraZ+XeSeuKDm/MOq8nFWxRk5VkZ0WX3+S5ZQJ4nqi15SfsZ1Q==
X-Received: by 2002:a17:90a:77c2:: with SMTP id e2mr3347228pjs.224.1608031046305;
        Tue, 15 Dec 2020 03:17:26 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id n127sm24278414pfd.143.2020.12.15.03.17.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 03:17:25 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC V2 0/2] cpufreq: cppc: Add support for frequency invariance
Date:   Tue, 15 Dec 2020 16:46:34 +0530
Message-Id: <cover.1608030508.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

CPPC cpufreq driver is used for ARM servers and this patch series tries
to provide frequency invariance support for them.

This is tested with some hacks, as I didn't have access to the right
hardware, on the ARM64 hikey board to check the overall functionality
and that works fine.

Ionela/Peter Puhov, it would be nice if you guys can give this a shot.

This is based of pm/linux-next and patches [1] and [2] which I sent
recently to cleanup arm64 topology stuff.

Changes since V1:
- The interface for setting the callbacks is improved, so different
  parts looking to provide their callbacks don't need to think about
  each other.

- Moved to per-cpu storage for storing the callback related data, AMU
  counters have higher priority with this.

--
viresh

[1] https://lore.kernel.org/lkml/7a171f710cdc0f808a2bfbd7db839c0d265527e7.1607579234.git.viresh.kumar@linaro.org/
[2] https://lore.kernel.org/lkml/5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org/

Viresh Kumar (2):
  topology: Allow multiple entities to provide sched_freq_tick()
    callback
  cpufreq: cppc: Add support for frequency invariance

 arch/arm64/include/asm/topology.h |   8 +-
 arch/arm64/kernel/topology.c      |  89 +++++++++----------
 drivers/base/arch_topology.c      |  56 +++++++++++-
 drivers/cpufreq/cppc_cpufreq.c    | 140 +++++++++++++++++++++++++++++-
 include/linux/arch_topology.h     |  14 ++-
 kernel/sched/core.c               |   1 +
 6 files changed, 244 insertions(+), 64 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

