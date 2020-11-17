Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A302B67CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgKQOtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:49:01 -0500
Received: from foss.arm.com ([217.140.110.172]:59170 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728198AbgKQOtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:49:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AE6F101E;
        Tue, 17 Nov 2020 06:49:00 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.59.185])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8894C3F718;
        Tue, 17 Nov 2020 06:48:59 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Cc:     james.clark@arm.com
Subject: [PATCH v5 00/12] perf tools: fix perf stat with large socket IDs
Date:   Tue, 17 Nov 2020 16:48:33 +0200
Message-Id: <20201117144845.13714-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v4:

* Test all fields in topology test, even if they should be -1
* Remove extra refcount from cpu_map__build_map()
* Reduce the changes in sort_aggr_thread()
* Move addition of cpu_aggr_map__put() and cpu_aggr_map__delete()
  into the commit where they are used so that they don't have
  to be changed to static in a separate commit

James Clark (12):
  perf tools: Improve topology test
  perf tools: Use allocator for perf_cpu_map
  perf tools: Add new struct for cpu aggregation
  perf tools: Replace aggregation ID with a struct
  perf tools: add new map type for aggregation
  perf tools: drop in cpu_aggr_map struct
  perf tools: Start using cpu_aggr_id in map
  perf tools: Add separate node member
  perf tools: Add separate socket member
  perf tools: Add separate die member
  perf tools: Add separate core member
  perf tools: Add separate thread member

 tools/perf/builtin-stat.c      | 128 ++++++++++++------------
 tools/perf/tests/topology.c    |  62 ++++++++++--
 tools/perf/util/cpumap.c       | 171 ++++++++++++++++++++++-----------
 tools/perf/util/cpumap.h       |  55 ++++++-----
 tools/perf/util/stat-display.c | 102 ++++++++++++--------
 tools/perf/util/stat.c         |   2 +-
 tools/perf/util/stat.h         |   9 +-
 7 files changed, 335 insertions(+), 194 deletions(-)

-- 
2.28.0

