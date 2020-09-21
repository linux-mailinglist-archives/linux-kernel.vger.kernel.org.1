Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDD32718FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 03:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIUBWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 21:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgIUBWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 21:22:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9D1C0613D0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 18:22:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id q5so13464865qkc.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 18:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KW/OrouFozh3RJwtVM+1IEV7aFLl7Dv1KLSBeb4lSh0=;
        b=YXqYZLtHn6a1GIehKZlpms+NQ53oxoqIvzQuXO/Z51sMOnhjJ/jufd+38XU/6XF0R/
         hMZDD7P3wMrHEZA3lu7l5LMWLuCpVe/7IzN+tKCuOfLIenQc4PV5dBsdY57lucqRSxSK
         AbysYOeKnj1g0X5P115AKwh/yHHcTtnc9iDRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KW/OrouFozh3RJwtVM+1IEV7aFLl7Dv1KLSBeb4lSh0=;
        b=L6tUPpkM3QSGYVeJrm18cHgBcWgak391EbT3OKBW4gZfcDfJibr6OGlusb+L8IiA9i
         WtltytrKMLKo6eTy8IPsQoE9OZmU33O/QBrDLcFE3a8MN+G/BMqbK75OXyvrd6mjwzf3
         Ugj67ROpiA0rvqFH7yu/st11hg0Zh3/x6+XLPoNrg6clgLMDaxCbceKfO3stBlOrmrY9
         ykBlU/Lfz+fKtc0FTO/iSQhDIOEGP1Y6g7YFdO7vqv/j0vmwFIqBE22ejdzt6hPdNHyh
         wgBv65d3BKOkXsK6dRuP+trCCJx5HjPS4EWK6g/2dtdtZg/6pWnJpqNPzaBGD3iPbtFJ
         N7yQ==
X-Gm-Message-State: AOAM5312WhcucjoJf1LGYmKjgPjB8VRMQt7SBtAT5t4IU2YrfsiykaQ+
        ujQezfUA0BDFAAIKOCb8/yM4ySiSppt3NA==
X-Google-Smtp-Source: ABdhPJwaG8bbt8sAkQ/fz9zWyUNzi/QXFT18zr2Ppv2yeMK+HFe9BWh2Y5iXuG8gp+JjckfjvbOE2w==
X-Received: by 2002:a37:9c86:: with SMTP id f128mr43757610qke.30.1600651317388;
        Sun, 20 Sep 2020 18:21:57 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l26sm7741951qki.62.2020.09.20.18.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 18:21:56 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [RFC v5 0/5] Add support length of each segment in the segcblist (breaks TREE04)
Date:   Sun, 20 Sep 2020 21:21:47 -0400
Message-Id: <20200921012152.2831904-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


NOTE: I marked as RFC since TREE 04 fails even though TREE03 passes. I don't
see any RCU errors in the counters, however when shutdown thread tries to
shutdown the system, it hangs when trying to shutdown the rcu_barrier thread.
My suspicion is this is becaues I broke rcu_barrier() however I can't figure
out how/where.  I added a patch in this series that could fix it, but it still
does not alleviate TREE04's issues.  I also have a feeling this issue is
related to nocb mode.

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
v5: Various changes, bug fixes. Discovery of rcu_barrier issue.

v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
    Fixed minor nit from Davidlohr.
v1->v3: minor nits.
(https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@joelfernandes.org/)

Joel Fernandes (Google) (5):
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
rcu: Fix rcu_barrier() breakage from earlier patch
rcu/trace: Add tracing for how segcb list changes
rcu/segcblist: Remove useless rcupdate.h include

include/linux/rcu_segcblist.h |   3 +
include/trace/events/rcu.h    |  25 +++++
kernel/rcu/rcu_segcblist.c    | 174 +++++++++++++++++++++++-----------
kernel/rcu/rcu_segcblist.h    |  33 +++++--
kernel/rcu/srcutree.c         |   1 -
kernel/rcu/tree.c             |  22 +++--
6 files changed, 192 insertions(+), 66 deletions(-)

--
2.28.0.681.g6f77f65b4e-goog

