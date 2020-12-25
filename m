Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3144A2E29DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 06:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgLYF2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 00:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgLYF2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 00:28:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B9CC061573
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 21:28:05 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s21so2129771pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 21:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OXt7vHDOprZwsYDOZ3gdmuS5KXkGBSPvwkcE4hpi9oI=;
        b=w+h8vk7o69RyY5/ruUBWB/+K/rdoC3jVuVD2QxzrcOPsv5Z72Gl/tNv7msxsPwdbgA
         ETxOxaZNL26DjR9onNdkncoDNaGZtf7XeyOWvwQTxnZEaJhVtJL/ZUQRam61iVJ19oYq
         wjy+1dGxAr2HJEG9fp09eI28Nib/poEJnY7SCgnYv04a2uTQx5Ww4wg8Dz+dvEkgbI5U
         NJhwisIZlzDgo4ZOJkR3ducC/gsY1T6ZP0hLmYOGVxSxJMsiuT/mtSNNirkYJzcq1ycs
         33xbCMr9XfwO+iE1WhY0Wfpth/7WM6II9fOjAmni1o9S71nvW79y7jDfsJTekQ7N4UZQ
         FkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OXt7vHDOprZwsYDOZ3gdmuS5KXkGBSPvwkcE4hpi9oI=;
        b=DXC3JneGUPWrZ4ncFjLIaCTFXgsVCJqjikXb5a3cz8VevEujCIc8i+BA/MeCY+xNR7
         cRbOtclZ5VOhx+vA2Tysa/vwa9jsSJu+QpnfrXM/Q3IG8vo+nCwiJofg69FKSyBzuTj+
         TFu4bijXc8q8Xew4vie2lPpUm30Kz8iJSIRAjz5yBpgr7x8zGPoNSzHQOQD9CwkqToEW
         hk6oV5/U0dPhHVq02mFtjsoyXhuvheFoOjIa9uW/h4Tsq6FECU4osORqnEmPEeLlsb4W
         5dCnn6qXxC8R44TuHRgmlNmci/8EfPl6dMchnFM04yLvMwOhF1fdq4SNWZFmLleX7sPd
         rfmQ==
X-Gm-Message-State: AOAM533EWBCXIyX/xIsfLjBkXFjns+ynnSWriRvJml1X6YnAiq3hUtHn
        oRyPK+/K8XLgqb4ZltgVkEBfaQ==
X-Google-Smtp-Source: ABdhPJwhWfbB5E05OuHKLsUgJ20zZPuw5Ncs32FaevwqX75oEl/Xzcg8ElKubPaY8sfXO+St6Q2Beg==
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id 144-20020a6218960000b0290197491cbe38mr30346836pfy.15.1608874083438;
        Thu, 24 Dec 2020 21:28:03 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id h16sm30305603pgd.62.2020.12.24.21.28.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Dec 2020 21:28:02 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        He Zhe <zhe.he@windriver.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/3] perf arm64: Support SDT
Date:   Fri, 25 Dec 2020 13:27:48 +0800
Message-Id: <20201225052751.24513-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to enable SDT on Arm64.

Since Arm64 SDT marker in ELF file is different from other archs,
especially for using stack pointer (sp) to retrieve data for local
variables, patch 01 is used to fixup the arguments for this special
case.  Patch 02 is to add argument support for Arm64 SDT.

This patch set has been verified on Arm64/x86_64 platforms with a
testing program usdt_test.  The testing approach is described in the
patch set v1 [1].

Changes from v1:
* Added Arnaldo's patch for fixing memory leak (Arnaldo);
* Refined patch "perf probe: Fixup Arm64 SDT arguments" to use
  asprintf() and check pointer is valid or not (Arnaldo);
* Minor changes in patch "perf arm64: Add argument support for SDT"
  for the regular expression;
* Added Masami's Ack tag for patch 03.

[1] https://lore.kernel.org/patchwork/cover/1356212/


Arnaldo Carvalho de Melo (1):
  perf probe: Fix memory leak in synthesize_sdt_probe_command()

Leo Yan (2):
  perf probe: Fixup Arm64 SDT arguments
  perf arm64: Add argument support for SDT

 tools/perf/arch/arm64/util/perf_regs.c | 94 ++++++++++++++++++++++++++
 tools/perf/util/probe-file.c           | 49 ++++++++++++--
 2 files changed, 139 insertions(+), 4 deletions(-)

-- 
2.17.1

