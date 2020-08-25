Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75EF250FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 04:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHYCs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 22:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbgHYCsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:48:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C29C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:48:50 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i20so9750491qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDQbTxMp1C6CYIxUrZbkzWdwK+GUKbU9bbcwziJlLJM=;
        b=Y+quge4vKDkMBkG9K2uI17oyg6nOzsVtgH5Wj/BPuvqKsGNZI6V44MgZJOtabTfEoT
         ogB+Ub3YppTetYQm4v3e1Jf8cpg97taw40ZfkweT7BvtMmG21cfNN8KYAOQuO2jPnen8
         tQg94Peaiuzb0nBxC4tUqHVzV0FxdNnve5dF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WDQbTxMp1C6CYIxUrZbkzWdwK+GUKbU9bbcwziJlLJM=;
        b=B26accCpfXrsVz13MH6udqI1NyNnkv/i3Nseu+i2Z3hccbmLC+B6YEzjIm9nBYIuM1
         7s6c5vZE67ceWqFqoDAs+N9+iQbTqkZptI8ufmPw/3IQjAOKYop4GB1T93CToZE/p+hT
         cBmgPnvZG1WARSWqS7H7fTcepmue+w1IIEzOUCuP3ylGoaQVfIBLuVWnaxDNsEsvL/4h
         BSWf5/toRCG9KaX7dRwhUQJ3DYqRcVbcPO1f8VBlVx/TW5yZ3GqUkI1AgN11bq0h+8PN
         F4AKYb7qZMxEVMO4m29jCPh3DG6W+/JQ189XrrjWe3j2sU1hiCWX+cEEWCD4AmmuSDvP
         7y/Q==
X-Gm-Message-State: AOAM530ghnEipa7m3IEV3H41tcckMJn5WlQ03PV67O8coy0g+RCJwSAy
        9B0Z9BqF9NS6Mig1FmYI1LB35W/Y2KzRmA==
X-Google-Smtp-Source: ABdhPJylkywYmbfoh8Km/IDLOzejn31ir/4h2j9L5LsuD9gSx2laJes3GgJLz2xbP7d5ycHUDQ7mAA==
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr7549813qkk.293.1598323729632;
        Mon, 24 Aug 2020 19:48:49 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n14sm2159188qtk.50.2020.08.24.19.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:48:48 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        boqun.feng@gmail.com, dave@stgolabs.net,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: [PATCH v4 -rcu 0/4] Maintain the length of each segment in the segcblist
Date:   Mon, 24 Aug 2020 22:48:38 -0400
Message-Id: <20200825024842.3408659-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for several usecases identified. One of them being tracing how
the segmented callback list changes. Tracing this has identified issues in RCU
code in the past. The trace patch is the last one in this series.

Passes 30 minutes of TREE01, TREE03, TREE07.  Testing of other TREE configs is
in progress.

Patches are based on -rcu commit:
4f43de2a419a ("Merge branch 'lkmm-dev.2020.08.24a' into HEAD")

Revision history:
v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
    Fixed minor nit from Davidlohr.
v1->v3: minor nits.
(https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@joelfernandes.org/)

Joel Fernandes (Google) (4):
rcu/segcblist: Do not depend on rcl->len to store the segcb len during
merge
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
rcu/trace: Add tracing for how segcb list changes

include/linux/rcu_segcblist.h |   2 +
include/trace/events/rcu.h    |  25 +++++++
kernel/rcu/rcu_segcblist.c    | 119 ++++++++++++++++++++++++++++++++--
kernel/rcu/rcu_segcblist.h    |   8 +++
kernel/rcu/tree.c             |  32 +++++++--
5 files changed, 175 insertions(+), 11 deletions(-)

--
2.28.0.297.g1956fa8f8d-goog

