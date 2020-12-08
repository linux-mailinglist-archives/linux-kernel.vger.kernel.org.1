Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4302D2E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbgLHPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:36:05 -0500
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:45239 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730001AbgLHPgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:36:04 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 196721C3B7A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:35:13 +0000 (GMT)
Received: (qmail 9668 invoked from network); 8 Dec 2020 15:35:12 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 8 Dec 2020 15:35:12 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/4] Reduce scanning of runqueues in select_idle_sibling
Date:   Tue,  8 Dec 2020 15:34:57 +0000
Message-Id: <20201208153501.1467-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog since v1
o Drop single-pass patch						(vincent)
o Scope variables used for SIS_AVG_CPU					(dietmar)
o Remove redundant assignment						(dietmar

This reduces the amount of runqueue scanning in select_idle_sibling in
the worst case.

Patch 1 removes SIS_AVG_CPU because it's unused.

Patch 2 moves all SIS_PROP-related calculations under SIS_PROP

Patch 3 improves the hit rate of p->recent_used_cpu to reduce the amount
	of scanning. It should be relatively uncontroversial

Patch 4 returns an idle candidate if one is found while scanning for a
	free core.

-- 
2.26.2

Mel Gorman (4):
  sched/fair: Remove SIS_AVG_CPU
  sched/fair: Move avg_scan_cost calculations under SIS_PROP
  sched/fair: Do not replace recent_used_cpu with the new target
  sched/fair: Return an idle cpu if one is found after a failed search
    for an idle core

 kernel/sched/fair.c     | 51 ++++++++++++++++++++---------------------
 kernel/sched/features.h |  1 -
 2 files changed, 25 insertions(+), 27 deletions(-)

-- 
2.26.2

