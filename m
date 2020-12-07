Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642292D0CC9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgLGJQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:16:16 -0500
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:56941 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgLGJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:16:15 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 4E9FABEC6E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 09:15:27 +0000 (GMT)
Received: (qmail 11227 invoked from network); 7 Dec 2020 09:15:27 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 7 Dec 2020 09:15:26 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 0/4] Reduce worst-case scanning of runqueues in select_idle_sibling
Date:   Mon,  7 Dec 2020 09:15:12 +0000
Message-Id: <20201207091516.24683-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a minimal series to reduce the amount of runqueue scanning in
select_idle_sibling in the worst case.

Patch 1 removes SIS_AVG_CPU because it's unused.

Patch 2 improves the hit rate of p->recent_used_cpu to reduce the amount
	of scanning. It should be relatively uncontroversial

Patch 3-4 scans the runqueues in a single pass for select_idle_core()
	and select_idle_cpu() so runqueues are not scanned twice. It's
	a tradeoff because it benefits deep scans but introduces overhead
	for shallow scans.

Even if patch 3-4 is rejected to allow more time for Aubrey's idle cpu mask
approach to stand on its own, patches 1-2 should be fine. The main decision
with patch 4 is whether select_idle_core() should do a full scan when searching
for an idle core, whether it should be throttled in some other fashion or
whether it should be just left alone.

-- 
2.26.2

