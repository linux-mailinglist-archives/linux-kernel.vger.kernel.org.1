Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00D624483B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 12:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgHNKpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 06:45:12 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46942 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727052AbgHNKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:45:06 -0400
Received: from ticat.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxKMQmazZfBOYIAA--.181S2;
        Fri, 14 Aug 2020 18:44:55 +0800 (CST)
From:   Peng Fan <fanpeng@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf bench numa: Remove dead code in parse_nodes_opt()
Date:   Fri, 14 Aug 2020 18:44:54 +0800
Message-Id: <1597401894-27549-1-git-send-email-fanpeng@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxKMQmazZfBOYIAA--.181S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY07k0a2IF6F4UM7kC6x804xWl14x267AK
        xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j
        6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr
        1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z2
        80aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Av
        z4vE14v_Gw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
        UKeHDUUUUU=
X-CM-SenderInfo: xidq1vtqj6z05rqj20fqof0/1tbiAQAIEl3QvMMVegAAsG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function parse_nodes_opt(), the statement "return 0;" is dead 
code, remove it.

Signed-off-by: Peng Fan <fanpeng@loongson.cn>
---
 tools/perf/bench/numa.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 5797253..70c8c2c 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -729,8 +729,6 @@ static int parse_nodes_opt(const struct option *opt __maybe_unused,
 		return -1;
 
 	return parse_node_list(arg);
-
-	return 0;
 }
 
 #define BIT(x) (1ul << x)
-- 
2.1.0

