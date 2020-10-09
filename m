Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6C128892A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbgJIMsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732391AbgJIMsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602247700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ma9SFMzdkJ5yBVRsnLxMjp1y9pGoX30Pnen2ZZiqr2c=;
        b=YzZHxFMx92JG+gEAjgwJAQeT7/csjBqPOVm8xaVdBq8j4NcmWZLUfo/+dwhp7JoUElMLhg
        udGZhp0UaZ4CULGTH1mVAR7rdLBxT6PGSWRTfupeLhH7GRiicUgCX5n6quhqjh/xvXDgZj
        vKPfr7/r3DCpDC54059Gr/spDKAjzNQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-uTsW6QCnMI6CR47MhPGmOQ-1; Fri, 09 Oct 2020 08:48:18 -0400
X-MC-Unique: uTsW6QCnMI6CR47MhPGmOQ-1
Received: by mail-wm1-f70.google.com with SMTP id o136so4035311wme.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 05:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ma9SFMzdkJ5yBVRsnLxMjp1y9pGoX30Pnen2ZZiqr2c=;
        b=ByQn+KzWFzqCGv0cafg8fQJ8UseMYRCrqVA/93MeLKhPOMQEN0iIEQM4JC/jeYV8LV
         BdAMxAE66Pfz/PS8r0zf1ESXbXRYFC4f701S8RLZMQSDdinsb4IYjd1DVPni0FG6pR/2
         1EAVmgnCycg8lO8ZIGKsNCMNJOeMbQjTya8WM459dY37K4CxOaDYx/X8LmRbULXFWyFq
         uZVqRRpE7nTq2xR5OXg4eXqfkUWddgI8/ftGih4x8pKjA8N5hxWi4WUPFyGB5dW8WFAJ
         u5ma0Pt3Mgp7MXeDy8XbNre+9DvOcxH/0fbFdH+RWHGfBj1WUVbK30oXZqQmMSPX8z5P
         GCbg==
X-Gm-Message-State: AOAM532UgeGu1BP90EAmZDeO6HFH6Nk1yLclhD5ZFHlI5lI9cu3duEw4
        i/svLNTgZA+TY8kP0EIetlX7sQa5C+I8M1gLYqk6CKw6B349VfKXrnYSRTq29AZd4emAUWk2sQD
        WnqFHQds+IjA6bf8iPacWKE3q
X-Received: by 2002:a1c:dd0b:: with SMTP id u11mr13791365wmg.186.1602247697164;
        Fri, 09 Oct 2020 05:48:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/SF4ChAJKbRcFTapWkvjhgpreOJnLpLJRd4p4YON4As2iwS/TFebC8I8ajLwpyNDeDdDSDg==
X-Received: by 2002:a1c:dd0b:: with SMTP id u11mr13791343wmg.186.1602247696899;
        Fri, 09 Oct 2020 05:48:16 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.23.182])
        by smtp.gmail.com with ESMTPSA id j13sm12542411wru.86.2020.10.09.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 05:48:16 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, williams@redhat.com, echaudro@redhat.com,
        atheurer@redhat.com, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 5.9 RT] net: openvswitch: Fix using smp_processor_id() in preemptible code
Date:   Fri,  9 Oct 2020 14:47:59 +0200
Message-Id: <20201009124759.592550-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following BUG has been reported (slightly edited):

 BUG: using smp_processor_id() in preemptible [00000000] code: handler106/3082
 caller is flow_lookup.isra.15+0x2c/0xf0 [openvswitch]
 CPU: 46 PID: 3082 Comm: handler106 Not tainted ... #1
 Hardware name: Dell Inc. PowerEdge R640/06DKY5, BIOS 2.5.4 01/13/2020
 Call Trace:
  dump_stack+0x5c/0x80
  check_preemption_disabled+0xc4/0xd0
  flow_lookup.isra.15+0x2c/0xf0 [openvswitch]
  ovs_flow_tbl_lookup+0x3b/0x60 [openvswitch]
  ovs_flow_cmd_new+0x2d8/0x430 [openvswitch]
  ? __switch_to_asm+0x35/0x70
  ? __switch_to_asm+0x41/0x70
  ? __switch_to_asm+0x35/0x70
  genl_family_rcv_msg+0x1d7/0x410
  ? migrate_enable+0x123/0x3a0
  genl_rcv_msg+0x47/0x8c
  ? __kmalloc_node_track_caller+0xff/0x2e0
  ? genl_family_rcv_msg+0x410/0x410
  netlink_rcv_skb+0x4c/0x120
  genl_rcv+0x24/0x40
  netlink_unicast+0x197/0x230
  netlink_sendmsg+0x204/0x3d0
  sock_sendmsg+0x4c/0x50
  ___sys_sendmsg+0x29f/0x300
  ? migrate_enable+0x123/0x3a0
  ? ep_send_events_proc+0x8a/0x1f0
  ? ep_scan_ready_list.constprop.23+0x237/0x260
  ? rt_spin_unlock+0x23/0x40
  ? ep_poll+0x1b3/0x390
  ? __fget+0x72/0xa0
  __sys_sendmsg+0x57/0xa0
  do_syscall_64+0x87/0x1a0
  entry_SYSCALL_64_after_hwframe+0x65/0xca
 RIP: 0033:0x7f1ed72ccb07
 Code: ...
 RSP: 002b:00007f1ecbd9ba80 EFLAGS: 00003293 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 000000000000007b RCX: 00007f1ed72ccb07
 RDX: 0000000000000000 RSI: 00007f1ecbd9bb10 RDI: 000000000000007b
 RBP: 00007f1ecbd9bb10 R08: 0000000000000000 R09: 00007f1ecbd9d390
 R10: 0000000019616156 R11: 0000000000003293 R12: 0000000000000000
 R13: 00007f1ecbd9d338 R14: 00007f1ecbd9bfb0 R15: 00007f1ecbd9bb10

This happens because openvswitch/flow_table::flow_lookup() accesses
per-cpu data while being preemptible (and migratable).

Fix it by adding get/put_cpu_light(), so that, even if preempted, the
task executing this code is not migrated (operation is also guarded by
ovs_mutex mutex).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 net/openvswitch/flow_table.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index e2235849a57e..7df27ef7da09 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -732,11 +732,14 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
 				   u32 *n_cache_hit,
 				   u32 *index)
 {
-	u64 *usage_counters = this_cpu_ptr(ma->masks_usage_cntr);
+	u64 *usage_counters;
 	struct sw_flow *flow;
 	struct sw_flow_mask *mask;
 	int i;
 
+	get_cpu_light();
+	usage_counters = this_cpu_ptr(ma->masks_usage_cntr);
+
 	if (likely(*index < ma->max)) {
 		mask = rcu_dereference_ovsl(ma->masks[*index]);
 		if (mask) {
@@ -746,6 +749,7 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
 				usage_counters[*index]++;
 				u64_stats_update_end(&ma->syncp);
 				(*n_cache_hit)++;
+				put_cpu_light();
 				return flow;
 			}
 		}
@@ -766,10 +770,12 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
 			u64_stats_update_begin(&ma->syncp);
 			usage_counters[*index]++;
 			u64_stats_update_end(&ma->syncp);
+			put_cpu_light();
 			return flow;
 		}
 	}
 
+	put_cpu_light();
 	return NULL;
 }
 
-- 
2.26.2

