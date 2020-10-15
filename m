Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262E628EA65
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbgJOBkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389012AbgJOBjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:39:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA91C0F26D5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:23:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so2087806ioo.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qqUc6oLuA3wydK6eova2ntHUOVFh7ZAPTYJ0QwAAxE=;
        b=QUu1tscRPul83dOHWS6L7NjV2mnKXCfx/hSWTelutMAHUCzpJCfPdYK6CzgyhcIJPb
         /lQLiUy+gGItyKusUyYmKb+TKlKsALw4GM+W8ZuNHwMqa+fzLQxTB53sxZNwIWbKMzxn
         EFvnP46Y1EBA/UpMSRQ9XLYLx1uWhLRQjbjOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qqUc6oLuA3wydK6eova2ntHUOVFh7ZAPTYJ0QwAAxE=;
        b=dvgvYDeu0eUJEY+Ay08GBTLd4uJf/FIE19GAVpDwJbFQWo/mDMSwE1VS1dSStBbqew
         xoDoK/Ry8zaVqN9UU+ZYQL7PG8UOFcq8vG9yrdc0fqs5R0GxA4hthlRQ+ROZD9NcNaX5
         N+mdPYNQUTFyh4GajNJRJvg4UZEe4MZjtJqLIpHlFE+TddXcovt8LltkGsWOdEWBx74U
         RjgMFp8i/H1o9uNqsu3Em+35kzwUnqltf4vgftmqdsgDyx6rO4tFSbt6Ff3eH1Ud5XoA
         b/L91nCkMElF5cPI6CD2nUiUjKHamUQv/ZOC/MvHbFhVQuR4raGDNyg8rrRYrG+WpdRE
         71aQ==
X-Gm-Message-State: AOAM531y/p9RqIFZEnNK4hhxAiEFCQPggduqYhdJeiIiYedXWsg+n5oA
        yBWaS4bWI9QzFEkXtziOfMvQP2F8D8dGsA==
X-Google-Smtp-Source: ABdhPJxoO9v2xfAArjZyQUn7/gbeOAwuxwNck84l4IaTGIbUQXUgdmy4uu3EGTdxZCEkzU3VlvFf1Q==
X-Received: by 2002:a6b:b2c5:: with SMTP id b188mr1364466iof.90.1602721385747;
        Wed, 14 Oct 2020 17:23:05 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id r4sm1075622ilc.32.2020.10.14.17.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 17:23:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v7 0/6] Add support for length of each segment in the segcblist
Date:   Wed, 14 Oct 2020 20:22:55 -0400
Message-Id: <20201015002301.101830-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required for several usecases identified. One of them being tracing how
the segmented callback list changes. Tracing this has identified issues in RCU
code in the past.

>From Paul:
Another use case is of course more accurately determining whether a given CPU's
large pile of callbacks can be best served by making grace periods go faster,
invoking callbacks more vigorously, or both.  It should also be possible to
simplify some of the callback handling a bit, given that some of the unnatural
acts are due to there having been no per-batch counts.

Revision history:
v7: Cleaned up memory barriers (thanks fweisbec@ for reviewing), made minor
corrections per Neeraj (thanks).

v6: Fixed TREE04, and restored older logic to ensure rcu_barrier works.

v5: Various changes, bug fixes. Discovery of rcu_barrier issue.

v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
    Fixed minor nit from Davidlohr.
v1->v3: minor nits.
(https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@xxxxxxxxxxxxxxxxx/)

Joel Fernandes (Google) (6):
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
rcu/trace: Add tracing for how segcb list changes
rcu/segcblist: Remove useless rcupdate.h include
rcu/tree: Remove redundant smp_mb() in rcu_do_batch
rcu/segcblist: Add additional comments to explain smp_mb()

include/linux/rcu_segcblist.h |   2 +
include/trace/events/rcu.h    |  25 +++++
kernel/rcu/rcu_segcblist.c    | 205 ++++++++++++++++++++++++++--------
kernel/rcu/rcu_segcblist.h    |   8 +-
kernel/rcu/tree.c             |  21 ++--
5 files changed, 203 insertions(+), 58 deletions(-)

--
2.28.0.1011.ga647a8990f-goog

