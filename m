Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD121C38D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 14:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgEDMFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 08:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgEDMFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:05:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB21BC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 05:05:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f13so4773307qkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 05:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS++A28Sh4YuaqyBwWRbxbmVEu733+KrFFtrnA7xbs8=;
        b=rtVHEmP14tFavtrMl2kCsfA31NxuymsQu8umBMB3Dl7s+NzUCfNvdF4FiC+FL/QMGO
         HwyZKmyN3i3brVIudSE3r0cHWSKpv4hv90ZKfGANxC/gUc++i0uowHvDbr7n6JcmJV3d
         yTTtaf4Gardm8NucaNktiNDDpNSRFUW++FCJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS++A28Sh4YuaqyBwWRbxbmVEu733+KrFFtrnA7xbs8=;
        b=Xh2lbM7UbM88i5h26tVHe+++wgl8lMzk3wnMFqCy/gTDe7L2uRniN+92PJ0skbPAxS
         z2YV198+jbmxerVZgW+DC9cohjoeKKQ3u1BG1nUOncS+Ystwrsg3Sy/YKWhn8l/SYyQU
         xlZ2/FHDc/WSRWpVMmzxswGYMpgEpMtsVLp/+z9q7VsaF7vE/UUrnX5p9B8Y+Wqw2Al/
         SsbPsr732+0UdYdOd6QJzrXt3qWbR+HbD2inXVsiz6O3Oy3FNbqF4u9tyI2K8PJdWuOR
         c9lOHyI/GkJ1XDaYpKtL4v8iYuHvMb9xW7a9W8asxT8FRPTFN17zCLjYALnlDT4vs6tl
         caGg==
X-Gm-Message-State: AGi0PubYyPejqgHw531RWWsvoTMNHxeJc0EkPoXEqQnIGHIGN9BvcvBu
        1xoCkEEhi1uDgLWY+XJJ/Lw0UQytiiQ=
X-Google-Smtp-Source: APiQypLPAvbk14sQlHrVZi67scGx/9pMjn2HmrrOBspEAdaiBo+4EXf9zml7kfDGC+ee+0MlTeIxCA==
X-Received: by 2002:a37:48a:: with SMTP id 132mr16527293qke.390.1588593912487;
        Mon, 04 May 2020 05:05:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y50sm6194534qta.56.2020.05.04.05.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:05:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
        Petr Mladek <pmladek@suse.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, vpillai@digitalocean.com
Subject: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
Date:   Mon,  4 May 2020 08:05:00 -0400
Message-Id: <20200504120505.89351-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches clean up the usage of dynticks nesting counters simplifying the
code, while preserving the usecases.

It is a much needed simplification, makes the code less confusing, and prevents
future bugs such as those that arise from forgetting that the
dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
common situations.

rcutorture testing with all TREE RCU configurations succeed with
CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.

v1->v2:
- Rebase on v5.6-rc6

v2->v3:
- Rebase on rcu/dev with adjustments for tasks-RCU.

Joel Fernandes (Google) (4):
Revert b8c17e6664c4 ("rcu: Maintain special bits at bottom of
->dynticks counter")
rcu/tree: Add better tracing for dyntick-idle
rcu/tree: Clean up dynticks counter usage
rcu/tree: Remove dynticks_nmi_nesting counter

Madhuparna Bhowmik (1):
trace: events: rcu: Change description of rcu_dyntick trace event

.../Data-Structures/Data-Structures.rst       |  31 +--
Documentation/RCU/stallwarn.rst               |   6 +-
include/linux/rcutiny.h                       |   3 -
include/trace/events/rcu.h                    |  29 +--
kernel/rcu/rcu.h                              |   4 -
kernel/rcu/tree.c                             | 199 +++++++-----------
kernel/rcu/tree.h                             |   4 +-
kernel/rcu/tree_stall.h                       |   4 +-
8 files changed, 110 insertions(+), 170 deletions(-)

--
2.26.2.526.g744177e7f7-goog

