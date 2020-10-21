Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B906A2952B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504677AbgJUTIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441200AbgJUTIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:08:18 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17AEC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:18 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q199so3121405qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9Kg/TgEEAwz+IelTGb09lowYE0dFmOxL25uAWCOofo=;
        b=enybzjH3Yn2KZzVK3i9SK/mk2ALvQ4YHPbKyiNX+OsMXhTX/N/yLcUI8lDkw+RC6aR
         K7h7HVIZ2TPVX/I7OZI2OT+NqQDrB03Q0UyFwxtDr79sM9Z3Qcb8PReVmqrSN6AspHqF
         dYCo4ielmbhI0CNXG5R7Dt0+F1J5UmFFimNxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9Kg/TgEEAwz+IelTGb09lowYE0dFmOxL25uAWCOofo=;
        b=mh7usmH6RcOtdeps/zTQkHU3X5OCUcNtoNEOIgIuGGVs92P4TrlLcBwVjbmgJN94kH
         BjvQOmM6+USylTjlzVbbDzYaCkt7Jxq/FBJ1SvfR1PnCNzxXWVO7G3UH8IlZtYUCsB3H
         mKaS9YatMbJEk7LeYP/YH3AOz3bUhIUegPYQ/NmswMz0u9dCjvCfgGCmd7WNH8+fIA9t
         1lMF2IgdX7NZjVnSckBMVFqFZZoVb9t9oa4NHW4yDyc50bKLm4ZWdnt8stxX3nCQY5eA
         Yg5F2f78Xn+dGzR9vTbQY3Qcwr0itNYB5mN4FIREk1VP7XfbeyMlLyEzhotMXax4K5tQ
         5jzg==
X-Gm-Message-State: AOAM530GkxncJaZw3WwZKuhfHJp7j7tkPTktbI6MjpzudhebqbWKcVRt
        20Jhgh40IgkdvwQJMpbmYM9fJ/YtQoo7/w==
X-Google-Smtp-Source: ABdhPJwFCVEmNPuw4HT/WxGRYQjLBlcDOMGyWmMepgBxukxg8Ec6dcBTVwWvjaKijM0CFFHgMwIPBg==
X-Received: by 2002:ae9:de82:: with SMTP id s124mr4662627qkf.379.1603307297364;
        Wed, 21 Oct 2020 12:08:17 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g11sm1913982qkl.30.2020.10.21.12.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:08:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v8 0/6] Add support for length of each segment in the segcblist
Date:   Wed, 21 Oct 2020 15:08:07 -0400
Message-Id: <20201021190813.3005054-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joel Fernandes <joelaf@google.com>

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
v8: Small style changes, making the seglen as non-atomic since it is always
    under lock (Frederic).

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
rcu/tree: segcblist: Remove redundant smp_mb()s
rcu/segcblist: Add additional comments to explain smp_mb()

include/linux/rcu_segcblist.h |   1 +
include/trace/events/rcu.h    |  25 +++++
kernel/rcu/rcu_segcblist.c    | 195 +++++++++++++++++++++++++---------
kernel/rcu/rcu_segcblist.h    |   8 +-
kernel/rcu/tree.c             |  21 ++--
5 files changed, 192 insertions(+), 58 deletions(-)

--
2.29.0.rc1.297.gfa9743e501-goog

