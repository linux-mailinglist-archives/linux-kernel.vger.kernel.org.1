Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6653B2B8C72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgKSHiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgKSHiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:38:18 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DDDC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:38:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id v21so3468207pgi.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 23:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FluejX8Dzg1crQFPmryHIf3eruZYIbY+9wYWfggNbDk=;
        b=R+PKQ/gQiv0Raup9wfMhvJuZUps0i5f08XvP3gEi98krbmQPwGTWpjyezyEUwEinUr
         l17G6Qo3rL8fLQZ7CwvyKGCWZRVRLbPvNJ/W4lh56pQeveLEYYxMhxvzudUHiTiuijzg
         kc6ft3pwwyzimQ3B5KAQK1tgmya01imagxSXh7Ig0njJlXo7A5r8cfiEh4or8JlX58Ig
         vP0FSxqIxqvfCXM01d2gfx4MGajzsA8JpiMozb+3X5cD1pp+jpBD5Sv9ZrF1og71SHWI
         O65aaGx0UHPBUso8qZlr/6CIqKe8s8Dnw24vVGQZ1FNGDrMxbMP8cWWf1Pdb3y1IhNn+
         B8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FluejX8Dzg1crQFPmryHIf3eruZYIbY+9wYWfggNbDk=;
        b=ff4MH59acjZ5jcbPP16RbwIXDdwqz1fBDNimf6qeXO546QnCSD+cVBZnjkkSEFbsrd
         6b9Dz3aI5eP3wUUmwkByMrXuXMWWtfJNHqA0cOegwtbRHThFpZPkCnV/YrfOmHYDvwyo
         e1OMe2SQQ0ZhmehSuyA5OaRL4ce4CglvikOGI2BLJc/SfpOhMs8mhI7Zaz/hDzIRXd6D
         gZqfFDI2jXTbgw/08TGJ5k5cF4vaNfruby75ZanrAVP6FOE9YF0NR9z18HV++1sbN7/0
         iLAIwHTLixg6WTRZGBNOB4GFLlQzgr68JfIi4ai0J2DdyZOQzbk/PNmwdOAPMk1haytV
         UJ2g==
X-Gm-Message-State: AOAM532q5SQLhOU6M8aIFzDzuwkeglc7u1cmMA4Y32bbJIwArgeQ406J
        K8gfWh+r7Vyl66e8xbKrC1Ws1w==
X-Google-Smtp-Source: ABdhPJy/mQrDdYcvQo/2iZlIimE4ldtmARO1mo9caGOr1DAL7bWd+RHz1kY77jgIDtG4l4ZeEAnpsQ==
X-Received: by 2002:a17:90a:ae14:: with SMTP id t20mr3129691pjq.13.1605771498037;
        Wed, 18 Nov 2020 23:38:18 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id 35sm22559004pgp.26.2020.11.18.23.38.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 23:38:17 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Javi Merino <javi.merino@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH V3 0/2] cpufreq_cooling: Get effective CPU utilization from scheduler
Date:   Thu, 19 Nov 2020 13:08:06 +0530
Message-Id: <cover.1605770951.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset makes the cpufreq_cooling driver reuse the CPU utilization
metric provided by the scheduler instead of depending on idle and busy
times of a CPU, which aren't that accurate to measure the busyness of a
CPU for the next cycle. More details can be seen in the commit log of
patch 2/2.

V2->V3:
- Put the scheduler helpers within ifdef CONFIG_SMP.
- Keep both SMP and !SMP implementations in the cpufreq_cooling driver.
- Improved commit log with testing related information.

--
Viresh

Viresh Kumar (2):
  sched/core: Rename and move schedutil_cpu_util() to core.c
  thermal: cpufreq_cooling: Reuse sched_cpu_util() for SMP platforms

 drivers/thermal/cpufreq_cooling.c |  68 ++++++++++++++----
 include/linux/sched.h             |  21 ++++++
 kernel/sched/core.c               | 115 +++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c  | 116 +-----------------------------
 kernel/sched/fair.c               |   6 +-
 kernel/sched/sched.h              |  31 +-------
 6 files changed, 199 insertions(+), 158 deletions(-)


base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
-- 
2.25.0.rc1.19.g042ed3e048af

