Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E986129A56E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507526AbgJ0HYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:24:08 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:54240 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbgJ0HYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:24:08 -0400
Received: by mail-yb1-f202.google.com with SMTP id a12so454119ybc.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 00:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=kqo5gmOuIUzH6rrL+KlWEsG4rVOW760GLWoKfNL/7PI=;
        b=voBA9S+FDTWKGqPNJw5H8sWZAcAT2Zwu2OMyafzgRdhSWWgLHOhe9PlF/NPgIpBj/u
         3cUWs8+C+LpKoaaxhSp9RPwm9oSSRkrcsaAAN/np2YaV8Z8SpY7OgDz1e7P76F76Q2iV
         zeFtZnml2WkjrTz8+DqcY/HLrfJtMQigZKoAswNvkBFJlwagyy7q4uO2vkbBZ/JbASsn
         4uTrMeNvcXwm22j3pfZxir7VqR4vGACxaHpaWeclNNhFvnl9itMoSwnhif8K/JwGIYg3
         I2Bf78Ea/gF9nZaXvDd688zMH4Q0O/NBdAZbxLT3OceIoG+7qxqjF/1HAg6K2xQ8Y3Za
         UxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=kqo5gmOuIUzH6rrL+KlWEsG4rVOW760GLWoKfNL/7PI=;
        b=tMgyk9ZGAE4kiAa1urshmphxKCVLtFu1hpPBHUQJWGFpz71Kn5qOpKhwKVUEMa8iUL
         /lxRpUZLSm+t4kVyUm5J4kMnqYhE+OSr8ODs5vIWtC0fySJdnm2/DPFCnhzaQZkOWJBi
         /L6rGlYG66a8CH7vyAYyQ6tfs6C3Rw4K1y4ARsY1uo8eWOD4NfQiY0JJIN5IDypWkNDY
         DY3QPXF4XAVp6dUkTgUlsY0G/JcnD8dAzU8xtC9Qux80ui7Vk3vivgurUoM1Yf1cQ6hO
         bX/W2aTPYA1A7H/ZHa78TXN/0flO7iMQ9FwRI1Yy4IbgLT4TRixkAGbpifdNNZ1MJS2u
         k7eA==
X-Gm-Message-State: AOAM530C6Oxeh5GwS/67wAUayL7Mqc5vPUqpwtE8wWXOdhISkjTLRZ0M
        lQkPM0EKQitjWg4B0dr4v59hi9R8YXR34zCxrrXMhNSB3fm31MPoEMGbauQoFefv0hiVyrJSPTv
        xI6ULZ0mUgP+JIxfzchHpLVFFOG/ZVrcmYbEDaSBuCIxplF3lRaPAtMIzzI4njETbQD4m124Qhg
        h2qYXJ
X-Google-Smtp-Source: ABdhPJzQlpampx1oIH8MR7GSaIiCwZ05+fkPNH8ID+XWI5/zjOSpROql0teRhz3Fe/NzcWSiv7wOVNDD6dl6jc4P
Sender: "victording via sendgmr" <victording@victording.syd.corp.google.com>
X-Received: from victording.syd.corp.google.com ([2401:fa00:9:14:f693:9fff:fef4:fa73])
 (user=victording job=sendgmr) by 2002:a25:b126:: with SMTP id
 g38mr1497239ybj.36.1603783446520; Tue, 27 Oct 2020 00:24:06 -0700 (PDT)
Date:   Tue, 27 Oct 2020 07:23:53 +0000
Message-Id: <20201027072358.13725-1-victording@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v3 0/4] powercap: Enable RAPL for AMD Fam17h and Fam19h
From:   Victor Ding <victording@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Victor Ding <victording@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for AMD Fam17h RAPL counters. As per
AMD PPR, Fam17h and Fam19h support RAPL counters to monitor power
usage. The RAPL counter operates as with Intel RAPL. Therefore, it is
beneficial to re-use existing framework for Intel, especially to
allow existing tools to seamlessly run on AMD.

From the user's point view, this series enables the following two sysfs
entry on AMD Fam17h or Fam19h:
  /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
  /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj

Changes in v3:
By Victor Ding <victording@google.com>
 - Rebased to the latest code.
 - Created a new rapl_defaults for AMD CPUs.
 - Removed redundant setting to zeros.
 - Stopped using the fake power limit domain 1.

Changes in v2:
By Kim Phillips <kim.phillips@amd.com>
- Added the Fam19h patch to the end of the series
- Added my Acked-by
- Added Daniel Lezcano to Cc
- (linux-pm was already on Cc)
- (No code changes)

Kim Phillips (1):
  powercap: Add AMD Fam19h RAPL support

Victor Ding (3):
  x86/msr-index: sort AMD RAPL MSRs by address
  powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
  powercap: Add AMD Fam17h RAPL support

 arch/x86/include/asm/msr-index.h     |  3 +-
 drivers/powercap/intel_rapl_common.c |  7 ++++
 drivers/powercap/intel_rapl_msr.c    | 51 ++++++++++++++++++++--------
 3 files changed, 45 insertions(+), 16 deletions(-)

-- 
2.29.0.rc2.309.g374f81d7ae-goog

