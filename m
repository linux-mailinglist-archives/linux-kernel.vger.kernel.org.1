Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60FE220702
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 10:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgGOI0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 04:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgGOI0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:26:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01FEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so1515838wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BobjFLO4jAQDqgFYhhcPSkxXTsZfQxwIQ+LKOwR6wxQ=;
        b=Y7XBEzNJjKc0Iuki0fXG/IizMD/riuqZahAKVS5ebLIzW5x2fZVTWpy6exLgM6WY7l
         MF9LP/7Xb73DNN2spvTOF9U36s88+O3xtWMOpIrpF6Sfgc6j8e7zmWpbIi/9xhjsLvTN
         bj2xzlqQnQVI1Z1Lxz4/XkyLus0x8gaJZGHsyxNwKzOK2WqczCwK17WtLXmLVOLbx18H
         XCI7GnBRBA9oT6RsfcnuGN0ieJqplA8sZb+RI6WQ9nCptOpGfXGMqYhszYvn5o/NwNuZ
         UERu0D4MChT9C/fh+6wACJzJYspQllNfLiFilJvDcQnAJPp0/4qiGdv3Z94HEh1VkFTk
         57Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BobjFLO4jAQDqgFYhhcPSkxXTsZfQxwIQ+LKOwR6wxQ=;
        b=tQgMqxvlbJKVg+vEXO1IG+x+o1eU7aXjZ2yShsL8MAdCOKWkkXb5+zdJWFoqhVC1t7
         J/9a5xKT1Nf+Gif15HwfZLKfqAiOy0kdxGIVC73iT4rGWE4lGie3w+K6/91fD9lsFZ56
         HYKa/3/sU+cPZXbp2TyK4RlB5meqcQ/sC8NfpOmi4u0n8gCg0fwdX3u1x4ei+/fDJUAi
         KsCRQ4NXT8fwGtqkTuHpOqeBnPOl3k++gWAW8SsADTefUAtp09dJOnGTSePZuq0u3YTr
         f42uPDbLKb5zl9K1/33xnA6RB7LSkkz2NPAQ3hHQxqLe5oa63JrxEXOMFGEVb2R8DVYx
         OolQ==
X-Gm-Message-State: AOAM531NmkTyCT3nBxPqPXebJhsZIfdQr7Oso4o5gsdhgzW7xc5JA9xi
        lOw2dGde/0zf7cjFPrSRh4Xu6A==
X-Google-Smtp-Source: ABdhPJxavdVbilJtal4t/mMwWHDIMZMCfoDSecxBHUP8XJKJCPrqVA0w2Y2RAT0AGordCCwSHDd0xA==
X-Received: by 2002:a05:6000:86:: with SMTP id m6mr9906018wrx.173.1594801598417;
        Wed, 15 Jul 2020 01:26:38 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id h13sm2400361wml.42.2020.07.15.01.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:26:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 00/13] Rid W=1 warnings in CPUFreq
Date:   Wed, 15 Jul 2020 09:26:21 +0100
Message-Id: <20200715082634.3024816-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in drivers/cpufreq.

Hurrah!

Changelog

v1 => v2:
 - Collect *-bys
 - Use __maybe_unused instead of removing device IDs
 - Use __always_unused instead of using unused variables
 - Include architecture header instead of creating new include file

Lee Jones (13):
  cpufreq: freq_table: Demote obvious misuse of kerneldoc to standard
    comment blocks
  cpufreq: cpufreq: Demote lots of function headers unworthy of
    kerneldoc status
  cpufreq: cpufreq_governor: Demote store_sampling_rate() header to
    standard comment block
  cpufreq: sti-cpufreq: Fix some formatting and misspelling issues
  cpufreq: pasemi: Include header file for {check,restore}_astate
    prototypes
  cpufreq: powernv-cpufreq: Functions only used in call-backs should be
    static
  cpufreq: powernv-cpufreq: Fix a bunch of kerneldoc related issues
  cpufreq: acpi-cpufreq: Mark 'dummy' variable as __always_unused
  cpufreq: acpi-cpufreq: Mark sometimes used ID structs as
    __maybe_unused
  cpufreq: powernow-k8: Mark 'hi' and 'lo' dummy variables as
    __always_unused
  cpufreq: pcc-cpufreq: Mark sometimes used ID structs as __maybe_unused
  cpufreq: intel_pstate: Supply struct attribute description for
    get_aperf_mperf_shift()
  cpufreq: amd_freq_sensitivity: Mark sometimes used ID structs as
    __maybe_unused

 drivers/cpufreq/acpi-cpufreq.c         |  8 +++----
 drivers/cpufreq/amd_freq_sensitivity.c |  2 +-
 drivers/cpufreq/cpufreq.c              | 32 ++++++++++++++------------
 drivers/cpufreq/cpufreq_governor.c     |  2 +-
 drivers/cpufreq/freq_table.c           |  6 ++---
 drivers/cpufreq/intel_pstate.c         |  2 ++
 drivers/cpufreq/pasemi-cpufreq.c       |  2 ++
 drivers/cpufreq/pcc-cpufreq.c          |  2 +-
 drivers/cpufreq/powernow-k8.c          |  4 ++--
 drivers/cpufreq/powernv-cpufreq.c      | 15 ++++++------
 drivers/cpufreq/sti-cpufreq.c          |  8 +++----
 11 files changed, 45 insertions(+), 38 deletions(-)

-- 
2.25.1

