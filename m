Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72D6275B91
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIWPWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:22:16 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10290C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:22:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q5so55995qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zsf+EwlQ/vJ5nQq6iEXR0Qv2IGG/PhQoRKnRcKN3RJk=;
        b=we1UoORwPWcI+UtqtoiXWDV6ejQSy9EcodZBvq8bfGaMnmNw25cQOwZdN2irQ1kRpj
         gHNrBqeRsi0z0mIs7StBtCi/s9PKZEYEAFeNCI2LFLu/G5FJVXuLX91md5NtX07s+phw
         wwtt92H40fOuN04kDbYpMYDYJbuOEl6WjJfis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zsf+EwlQ/vJ5nQq6iEXR0Qv2IGG/PhQoRKnRcKN3RJk=;
        b=BCQUTy9EevOfq9zMrpb/514eBI7SCGJ0sAdVbsjWwiTmcnF3ClGoxwLT83n79f4pmq
         7jKFg6yqWPf6zIRAEs8JernAurA7KvIu2LXGoq7CLXefv2V3ICfn0taujEKQA/SnkHU7
         X36vEA7KtNYLYl9f3Dk0mJrjtpHikuX7RlSddxAakmdg8GVFG4ojMjOEldcl72nKz2rU
         8AfmQejYW5SsTjrUQkKe2t/huOn32MJnEzK62CnpG2BQCh/KBIevNS5dBPINggjiAbDx
         V5nvnt3KQf+Pa9eVMZcgd1L23KcVc3DET7C9sHDa/9Gq3r0p8+5c8FD7bRJPLkx6Gqh/
         oUCQ==
X-Gm-Message-State: AOAM5308LO68YWBBv5ZODGOjkBX3k+U9P9anfhU/maZp3fuCV/7l1f28
        a7RXdwKsBU/4hQOcL5Yg46KOJb2eShrC/Q==
X-Google-Smtp-Source: ABdhPJyeuvIUk9cxpa08DtvNpej/wXfLpGEqMDDSx1FItXAPvuD88vu2da6n2UY6y3sbYS4vjr9BdQ==
X-Received: by 2002:a37:48c6:: with SMTP id v189mr403594qka.378.1600874534379;
        Wed, 23 Sep 2020 08:22:14 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g5sm37909qtx.43.2020.09.23.08.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:22:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH v6 0/4] Add support for length of each segment in the segcblist
Date:   Wed, 23 Sep 2020 11:22:07 -0400
Message-Id: <20200923152211.2403352-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This is required for several usecases identified. One of them being tracing how
the segmented callback list changes. Tracing this has identified issues in RCU
code in the past.

From Paul:
Another use case is of course more accurately determining whether a given CPU's
large pile of callbacks can be best served by making grace periods go faster,
invoking callbacks more vigorously, or both.  It should also be possible to
simplify some of the callback handling a bit, given that some of the unnatural
acts are due to there having been no per-batch counts.

Revision history:
v6: Fixed TREE04, and restored older logic to ensure rcu_barrier works.

v5: Various changes, bug fixes. Discovery of rcu_barrier issue.

v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
    Fixed minor nit from Davidlohr.
v1->v3: minor nits.
(https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@joelfernandes.org/)

Joel Fernandes (Google) (4):
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
rcu/trace: Add tracing for how segcb list changes
rcu/segcblist: Remove useless rcupdate.h include

include/linux/rcu_segcblist.h |   2 +
include/trace/events/rcu.h    |  25 ++++++
kernel/rcu/rcu_segcblist.c    | 161 +++++++++++++++++++++++++---------
kernel/rcu/rcu_segcblist.h    |   8 +-
kernel/rcu/tree.c             |  18 ++--
5 files changed, 165 insertions(+), 49 deletions(-)

--
2.28.0.681.g6f77f65b4e-goog

