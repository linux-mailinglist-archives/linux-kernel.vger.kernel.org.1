Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0972DB435
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbgLOTDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:03:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731728AbgLOTDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:03:36 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BFIYnUk131535;
        Tue, 15 Dec 2020 14:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=5Z33GuTd4hAWAvbIH+IbFIk8bK8hOJ/6cSRWLY+7khk=;
 b=tPxXRHaJzkL/upAwe6u1vtX0dec2Bc4CO2ArPYg9dl7KxuMNgzAOKCzpaksytm4OSXJC
 TwYjpyT1/G1FJc26roptqs2y7pdcc+bpcyXoUld3JtCdip1lqhghqstHe9DnNYuRBxJq
 h0w7zK76ot8D1Q58Bn/GsOYxRRq+Tu8ytmBE9QdZkM8CAwZQnq8ZIOc/CkQSxiFAFFkC
 XRBSswzjg8M5rMoYXTJJzlaEmEgLR4274izzQEMeR1hx16e6u9B6pG4vQx2rnMG8rxwC
 KRSwGy3uXGVEva7odaNMUC3bLT+WaXvNScJX56XyLPXk1gh0jLO8hRrk73YGXNxgzxNY VA== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35f093qkwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 14:01:58 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BFIrBYS024876;
        Tue, 15 Dec 2020 19:01:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8d91v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 19:01:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BFJ1smC31195578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 19:01:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 263D211C054;
        Tue, 15 Dec 2020 19:01:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7FDB11C04A;
        Tue, 15 Dec 2020 19:01:53 +0000 (GMT)
Received: from osiris (unknown [9.171.86.132])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 15 Dec 2020 19:01:53 +0000 (GMT)
Date:   Tue, 15 Dec 2020 20:01:52 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: __local_bh_enable_ip() vs lockdep
Message-ID: <20201215190152.GA22285@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_12:2020-12-15,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=250
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the ftrace stack tracer kernel selftest is able to trigger the warning
below from time to time. This looks like there is an ordering problem
in __local_bh_enable_ip():
first there is a call to lockdep_softirqs_on() and afterwards
preempt_count_sub() is ftraced before it was able to modify
preempt_count:

[ 1016.245418] ------------[ cut here ]------------
[ 1016.245428] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
[ 1016.245441] WARNING: CPU: 8 PID: 8300 at kernel/locking/lockdep.c:5298 check_flags.part.0+0x196/0x208
[ 1016.245580] CPU: 8 PID: 8300 Comm: sshd Not tainted 5.11.0-20201215.rc0.git0.d33ce49dca6c.300.fc33.s390x+debug #1
...
[ 1016.245691] Call Trace:
[ 1016.245698]  [<000000004c1537fa>] check_flags.part.0+0x19a/0x208
[ 1016.245705] ([<000000004c1537f6>] check_flags.part.0+0x196/0x208)
[ 1016.245711]  [<000000004cced786>] lock_is_held_type+0x8e/0x1b8
[ 1016.245716]  [<000000004c172924>] rcu_read_lock_sched_held+0x64/0xb8
[ 1016.245724]  [<000000004c1b151c>] module_assert_mutex_or_preempt+0x34/0x68
[ 1016.245730]  [<000000004c1b2e04>] __module_address.part.0+0x2c/0x118
[ 1016.245735]  [<000000004c1b9dca>] __module_text_address+0x3a/0x90
[ 1016.245741]  [<000000004c1b9ed4>] is_module_text_address+0x34/0x78
[ 1016.245748]  [<000000004c0f9a1a>] kernel_text_address+0x5a/0x130
[ 1016.245752]  [<000000004c0f9b16>] __kernel_text_address+0x26/0x70
[ 1016.245757]  [<000000004c094038>] unwind_get_return_address+0x40/0x68
[ 1016.245763]  [<000000004c099dac>] arch_stack_walk+0xac/0xd0
[ 1016.245768]  [<000000004c18be10>] stack_trace_save+0x50/0x68
[ 1016.245774]  [<000000004c22d80c>] check_stack+0xc4/0x348
[ 1016.245780]  [<000000004c22db46>] stack_trace_call+0xb6/0xd0
[ 1016.245785]  [<000000004cd00082>] ftrace_caller+0x7a/0x7e
[ 1016.245791]  [<000000004c1081d6>] preempt_count_sub+0x6/0x138 <---
[ 1016.245795]  [<000000004c0d3d46>] __local_bh_enable_ip+0x13e/0x190 <---
[ 1016.245811]  [<000003ff8023c34c>] nft_update_chain_stats+0xdc/0x168 [nf_tables]
[ 1016.245820]  [<000003ff8023c916>] nft_do_chain+0x53e/0x550 [nf_tables]
[ 1016.245827]  [<000003ff80251974>] nft_do_chain_ipv4+0x6c/0x78 [nf_tables]
[ 1016.245833]  [<000000004cb0ab00>] nf_hook_slow+0x58/0xf8
[ 1016.245839]  [<000000004cb1dc24>] nf_hook.constprop.0+0xfc/0x1d0
[ 1016.245844]  [<000000004cb207b2>] __ip_local_out+0x92/0xe8
[ 1016.245848]  [<000000004cb20d00>] __ip_queue_xmit+0x1d8/0x640
[ 1016.245854]  [<000000004cb4578c>] __tcp_transmit_skb+0x3dc/0x770
[ 1016.245858]  [<000000004cb46e86>] tcp_write_xmit+0x38e/0x758
[ 1016.245863]  [<000000004cb47298>] __tcp_push_pending_frames+0x48/0x118
[ 1016.245868]  [<000000004cb2f604>] tcp_sendmsg_locked+0x95c/0xb78
[ 1016.245872]  [<000000004cb2f864>] tcp_sendmsg+0x44/0x68
[ 1016.245878]  [<000000004ca30c3c>] sock_sendmsg+0x64/0x78
[ 1016.245882]  [<000000004ca30cc2>] sock_write_iter+0x72/0x98
[ 1016.245887]  [<000000004c3dcfda>] new_sync_write+0x10a/0x198
[ 1016.245891]  [<000000004c3dd6a6>] vfs_write.part.0+0x196/0x290
[ 1016.245896]  [<000000004c3e0220>] ksys_write+0xb8/0xf8
[ 1016.245900]  [<000000004ccfd326>] system_call+0xe2/0x29c
[ 1016.245904] INFO: lockdep is turned off.
