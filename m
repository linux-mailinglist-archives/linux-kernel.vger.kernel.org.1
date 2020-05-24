Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086AA1E02BE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 22:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgEXU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 16:29:59 -0400
Received: from outbound-smtp58.blacknight.com ([46.22.136.242]:54709 "EHLO
        outbound-smtp58.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgEXU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 16:29:59 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id 1A55DFA973
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:29:57 +0100 (IST)
Received: (qmail 3104 invoked from network); 24 May 2020 20:29:56 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 May 2020 20:29:56 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jirka Hladky <jhladky@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        valentin.schneider@arm.com, Hillf Danton <hdanton@sina.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Optimise try_to_wake_up() when wakee is descheduling
Date:   Sun, 24 May 2020 21:29:54 +0100
Message-Id: <20200524202956.27665-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two patches optimise try_to_wake_up() when the wakee is
descheduling. In a vanilla kernel, there can be excessive time spent
spinning on p->on_rq. This is fine if it's a strictly synchronous wakeup
and the waker is going to sleep but in other cases, the waker spins until
it can do work that can be deferred to the wakee.

The first patch frontloads work that can be done before p->on_rq is
checked.  If it's a wakeup on a CPU that does not share cache then the
wakelist is used instead of spinning. The second patch goes a little
further and uses the wakelist if the wakee is descheduling and is the
only task running on the target CPU.

The performance impact is documented in the changelog of the second patch.

 kernel/sched/core.c  | 81 ++++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h |  3 +-
 2 files changed, 61 insertions(+), 23 deletions(-)

-- 
2.26.1

