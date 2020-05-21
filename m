Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6B1DCE16
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgEUNdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 09:33:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4877 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729497AbgEUNdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:33:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D6B1EC6BA5F8B4BE7E53;
        Thu, 21 May 2020 21:33:03 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 21:32:56 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Bin <huawei.libin@huawei.com>,
        "Xie XiuQi" <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Subject: [PATCH 0/4] perf: Fix memory errors
Date:   Thu, 21 May 2020 21:32:14 +0800
Message-ID: <20200521133218.30150-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several memory errors in perf tool.

Hongbo Yao (1):
  perf metrictroup: Fix memory leak of metric_events

Li Bin (2):
  perf svghelper: Fix memory leak in svg_build_topology_map
  perf util: Fix potential segment fault in put_tracepoints_path

Xie XiuQi (1):
  perf util: Fix memory leak of prefix_if_not_in

 tools/perf/util/metricgroup.c      |  3 +++
 tools/perf/util/sort.c             |  2 +-
 tools/perf/util/svghelper.c        | 10 +++++++---
 tools/perf/util/trace-event-info.c |  2 +-
 4 files changed, 12 insertions(+), 5 deletions(-)

-- 
2.17.1

