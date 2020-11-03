Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215692A47FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgKCO0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbgKCO0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:26:08 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B6EC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 06:26:08 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h12so11705602qtu.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 06:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFL7dVDfXNm5vtnmwHtQwhQMGcGnnQrFNvHpqb+k+Ro=;
        b=m/MsTIVOByd2e8T5GHX++XPIJ45s+RU9A99sAo57vatmJcea6Twgwv8Gorrypt3NK3
         0EjHvWZH8uRrdY1T+sz492AzusRY6tg3XMNwmufCs2oYZJaAZ7hDaT2AtCFIX1BkGWBS
         iZtOUtnscLcdHWNi+wJ/v+TwdDtatLMAnMZyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OFL7dVDfXNm5vtnmwHtQwhQMGcGnnQrFNvHpqb+k+Ro=;
        b=Cp+mbj0pCCrmVS26uw1urq3bCZM8JJbW1TlwswXEpCEhnXxQk+p2UtrCyJxT+64AiX
         Vafw3wm9n93pBbAimp1q9bvYmjAR/L3L0BskVPrF6HfGQG1Z0bIoXffEX9Rh3lTYCNgf
         krqNlXeujdNSlxV1Fj1IwljeeG7AGGcdeDK1gzHmOO1A/iRepNl06NHxm1S24kuvkvMx
         x52j6IbJufGUmbn9uHc3MXecPNBRMnGt8srHO3JM54X+6uRGDf2AERzGsZhYXL/UkblJ
         Me1hO0gmcyLJp2oE2lP3IErm5IE+6CNJN9n68VPhrRFrTyyrg27bMkni+EF3UF3+cB9s
         znRw==
X-Gm-Message-State: AOAM531CXUw3FonEqGhFU7OxAZCzTm2uqWKh5dTFoyycWF3Ua4gkB6Ki
        1yQslYhpjNX2RFxqGif6ZfGc6BxgZFLrRg==
X-Google-Smtp-Source: ABdhPJyez4bk4O2JYt+Gbe7KqeyxQQ2Ozr9Yx/ldgen8/bBlvzWQH1jtwZD1v5Z1Oy4dARp6XvG3cA==
X-Received: by 2002:ac8:376b:: with SMTP id p40mr5915285qtb.231.1604413567648;
        Tue, 03 Nov 2020 06:26:07 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id l30sm10564967qta.73.2020.11.03.06.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 06:26:06 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: [PATCH v9 0/7] Add support for length of each segment in the segcblist
Date:   Tue,  3 Nov 2020 09:25:56 -0500
Message-Id: <20201103142603.1302207-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
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
v9: Fix SRCU issues, other minor style changes (Frederic). Added Frederic's
Reviewed-by to all but the last patch..

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

Joel Fernandes (Google) (7):
rcu/tree: Make rcu_do_batch count how many callbacks were executed
rcu/segcblist: Add counters to segcblist datastructure
srcu: Fix invoke_rcu_callbacks() segcb length adjustment
rcu/trace: Add tracing for how segcb list changes
rcu/segcblist: Remove useless rcupdate.h include
rcu/tree: segcblist: Remove redundant smp_mb()s
rcu/segcblist: Add additional comments to explain smp_mb()

include/linux/rcu_segcblist.h |   1 +
include/trace/events/rcu.h    |  25 +++++
kernel/rcu/rcu_segcblist.c    | 198 +++++++++++++++++++++++++---------
kernel/rcu/rcu_segcblist.h    |   8 +-
kernel/rcu/srcutree.c         |   5 +-
kernel/rcu/tree.c             |  21 ++--
6 files changed, 199 insertions(+), 59 deletions(-)

--
2.29.1.341.ge80a0c044ae-goog

