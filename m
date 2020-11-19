Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7848B2B8A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgKSDxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgKSDxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:53:01 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837DBC0613D4;
        Wed, 18 Nov 2020 19:53:01 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id t16so4820024oie.11;
        Wed, 18 Nov 2020 19:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSokh3hSyp9Wrxw7u+Bsx/a3PrubmjReLxXi4etOleQ=;
        b=dTdWIuI1swXKTAkItc38BwjeWtAd8tefm2iJMSO69NfaUgmkIMni2W99ZJKT5nchCU
         cbmCsQPxhL1nJo+uO2GxhKK3JUvFVxssiHPfGzUAf+vRjJmiAVMTmiMAs7SgYxKCc2SE
         TMwhQCDxNyxFnJ4dFPEf/XcatNemUaONpayB0+9hg7tsudZOKCaSaYGf4g4mUeLma5sY
         ZWCjVYebeDbcdOWkBp3ZvGEVwY2BbGYfh9IDN7LzCBcfqq5HNi6Web3f3W+nGipy2oR1
         0atjOFrBRNL+Vlvcb8KusBvluBiEJwVCTwtbNZVw0s0VUWxytyjJtVFTiI5EalkclXOi
         HwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kSokh3hSyp9Wrxw7u+Bsx/a3PrubmjReLxXi4etOleQ=;
        b=HZYTFmyE1aWv0ZkYwe9GMJnOHrdDszCXt2yfFRbdT96SdFGQfJ+XiKekwApR6LMTGA
         4F0Q1cDxBN7376+KuFQ3VhgiT3r/2phJ9R87YwhOcHfWllkHlfqDMvLrSmRmSM/y9eVQ
         N4RwVfDTnB+FGJdaww8dXs1a+Ych4Gb7hQpDuzUYBDC0TjwfpPBcr715/GxBG1AkKSvH
         kyJjrzlUG1D54DG+dENCgGk0fn1LukOikDPqbf+DmybMv7Z6Yw2/JQfucA/ATLXeJHfJ
         1bMgwJbVVM1SviN2lwGp7dt1Pb0Mp+INWlyzyJjBdlcC63hPFkRtlIWqwlGZL476kqW+
         MKpg==
X-Gm-Message-State: AOAM530qerlrfB6WIEo2516OIchVHCqMTGWXDoQnkBJ3uiInxMi8zK1X
        BJ/p1f7TPsQkRrCED/DWhAk=
X-Google-Smtp-Source: ABdhPJyE43RaQb6ABcSQLbVyVhIJGYBpvqM1+kGjDM0DSFBA1D3LYwjtEtQg76wnkI8tgPtWDr0RGw==
X-Received: by 2002:aca:d19:: with SMTP id 25mr1690322oin.112.1605757981016;
        Wed, 18 Nov 2020 19:53:01 -0800 (PST)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id k20sm8320926ots.53.2020.11.18.19.52.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 19:53:00 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 0/4] sched: support schedstat for RT sched class
Date:   Thu, 19 Nov 2020 11:52:26 +0800
Message-Id: <20201119035230.45330-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to measure the latency of RT tasks in our production
environment with schedstat facility, but currently schedstat is only
supported for fair sched class. This patchset enable it for RT sched class
as well.

The schedstat statistics are defined in struct sched_entity, which is a
member of struct task_struct, so we can resue it for RT sched class.

The schedstat usage in RT sched class is similar with fair sched class,
for example,
		fair				RT
enqueue		update_stats_enqueue_fair	update_stats_enqueue_rt
dequeue		update_stats_dequeue_fair	update_stats_dequeue_rt
put_prev_task	update_stats_wait_start		update_stats_wait_start
set_next_task	update_stats_wait_end		update_stats_wait_end
show		/proc/[pid]/sched		/proc/[pid]/sched

The sched:sched_stats_* tracepoints can be used to trace RT tasks as
well after that patchset.

PATCH #1 ~ #3 are the preparation of PATCH #4.

Yafang Shao (4):
  sched: define task_of() as a common helper
  sched: make schedstats helpers not depend on cfs_rq
  sched: define update_stats_curr_start() as a common helper
  sched, rt: support schedstat for RT sched class

 kernel/sched/fair.c  | 173 ++-----------------------------------------
 kernel/sched/rt.c    |  63 +++++++++++++++-
 kernel/sched/sched.h |  23 ++++++
 kernel/sched/stats.c | 134 +++++++++++++++++++++++++++++++++
 kernel/sched/stats.h |  11 +++
 5 files changed, 236 insertions(+), 168 deletions(-)

-- 
2.18.4

