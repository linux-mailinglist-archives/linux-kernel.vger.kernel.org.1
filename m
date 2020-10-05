Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C577028312C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJEH4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgJEH4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:56:33 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DC7C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 00:56:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a1so479167pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mH7edDuC95rp9652QxLQjfjq1vuOkDjmbsdc1O4M4ZE=;
        b=Jc0yCaI25EikNxoWQ86qLK6HcjzlcKYXU1ECKBbrnShwjgBzlfZfJPa9DWq9OQqINq
         vfXqCT5cYjwfNCfF4Eqkx3RgHYD8idImlfDRh4pXhd/Fg0L5p6QqMwl3GMt9TgNy5mS6
         ZlbeKRq5Qor3ZPnuytLVn10+ArFizYmUXCC20NoFQcL5JBqlIsvxMPXXvOHWtAsTNWj4
         ps678/iwYAf7+yVnXpEWXDYpYfQRUEmsKSYA4tOrXJ/cC5ayLI3DwYuPS+c9pmZNdk7R
         uBLXhA3mQxSxfSWOdhtejzekgCaFd8Q1e6npNiBuK878JWFCMSkNdMGJbG2uS7+Jqb32
         vCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mH7edDuC95rp9652QxLQjfjq1vuOkDjmbsdc1O4M4ZE=;
        b=N4E1bykyhXay+i28FGPvEjgdgmi3CqelyBbYbrxo5Xs5BTkaXEiJF2FTj8Isf3zKYW
         GUMzE1Y0hjAYE+4C8y+KN56yClicDtmx9UMTKe87nMf9NaL6rommcYl9JjKZvYj++Byf
         BQOO0ZKBSPc6nbEbQESQWgbkhNQDm59xzFhRRF6RSxgxJsPy6Db3NmgTDztnw0nlCl6+
         OUJB1iepqOFF2fEwtbbknuQbZ7L4CP+/ncChMNYbNDCZOGpg195zMpSg8OUltyS0x800
         VLqBE6cYdeA6gXIceMcJysRohFp8laUMVZKu3bYrY8/MJjKrdTbLcOLTK6G8UzK/NliY
         73tA==
X-Gm-Message-State: AOAM530/VyLxIs9DoOWcgMD12UJaJO17w1jOU3GVogKVWYaSOOh3bpOK
        n+RFjzF72URjjvzWqt3q7Luoww==
X-Google-Smtp-Source: ABdhPJwMzOfefnTJXiOPc6ysjwW9PvTdqj9lIzCIwV7CrWVO7k5avufb59YK1uht5UsgHcp0iOFw9Q==
X-Received: by 2002:a17:90a:420b:: with SMTP id o11mr9876075pjg.142.1601884591801;
        Mon, 05 Oct 2020 00:56:31 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id d12sm9851018pgd.93.2020.10.05.00.56.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 00:56:30 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        cristian.marussi@arm.com, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 0/5] cpufreq: Record stats with fast-switching
Date:   Mon,  5 Oct 2020 13:26:00 +0530
Message-Id: <cover.1601884370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We disabled recording cpufreq stats when fast switching was introduced
to the cpufreq core as the cpufreq stats required to take a spinlock and
that can't be allowed (for performance reasons) on scheduler's hot path.

Here is an attempt to get rid of the lock and bring back the support.

V2->V3:
- Use READ/WRITE_ONCE() for reset-time as well.
- Use unlikely for few conditionals in the hot path.
- Better changelogs.
- Rebase changes.

V1-V2:
- Use READ_ONCE/WRITE_ONCE instead of atomic in the first patch.

--
Viresh

Viresh Kumar (5):
  cpufreq: stats: Defer stats update to
    cpufreq_stats_record_transition()
  cpufreq: stats: Remove locking
  cpufreq: stats: Mark few conditionals with unlikely()
  cpufreq: stats: Enable stats for fast-switch as well
  cpufreq: Move traces and update to policy->cur to cpufreq core

 drivers/cpufreq/cpufreq.c        | 11 ++++
 drivers/cpufreq/cpufreq_stats.c  | 89 ++++++++++++++++++++------------
 kernel/sched/cpufreq_schedutil.c | 12 +----
 3 files changed, 69 insertions(+), 43 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

