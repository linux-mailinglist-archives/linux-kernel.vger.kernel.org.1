Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182B02B63FC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbgKQNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:43:32 -0500
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:39615 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387426AbgKQNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:42:27 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id B49F9FAEEC
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 13:42:23 +0000 (GMT)
Received: (qmail 10513 invoked from network); 17 Nov 2020 13:42:23 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 17 Nov 2020 13:42:23 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 0/3] Revisit NUMA imbalance tolerance and fork balancing
Date:   Tue, 17 Nov 2020 13:42:19 +0000
Message-Id: <20201117134222.31482-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When NUMA and CPU balancing were reconciled, there was an attempt to allow
a degree of imbalance but it caused more problems than it solved. Instead,
imbalance was only allowed with an almost idle NUMA domain. A lot of the
problems have since been addressed so it's time for a revisit. There is
also an issue with how fork is balanced across threads. It's mentioned
in this context as patch 2 and 3 should share similar behaviour in terms
of a nodes utilisation.

Patch 1 is just a cosmetic rename

Patch 2 allows a "floating" imbalance to exist so communicating tasks can
	remain on the same domain until utilisation is higher. It aims
	to balance compute availability with memory bandwidth.

Patch 3 is the interesting one. Currently fork can allow a NUMA node
	to be completely utilised as long as there are idle CPUs until
	the load balancer gets involved. This caused serious problems
	with a real workload that unfortunately I cannot share many
	details about but there is a proxy reproducer.

 kernel/sched/fair.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)
