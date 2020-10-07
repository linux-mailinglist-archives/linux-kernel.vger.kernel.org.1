Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD812859F1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgJGHxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:53:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgJGHxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:53:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0977aSFL074328;
        Wed, 7 Oct 2020 03:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=+wGJ6oKUeTM0xGxLa8/kZWQDJ8lLbEB6mDNlSUmM06E=;
 b=XedMw6INeq/yVbwiNKLcP3k9PdxevWQ2fxej0K2t29713nmmA7ebio8AFuTyxbBfU40Y
 Pzaaa+WRCXDZmUD+O/1RSYuEH8+BpboecIq5r02u8fFOr7e34jGN9GNNH4Ezy+IISzMI
 v7Sm4lz1k5D1uJCwUMZNepvFyVRde9LkJY5Zzsyp4YyTD8tYZlUZI5BBy2t70CqqlxyK
 iF2gbcs7S1wmpFrbGepUt3moIX9nWa/msrUYKof2dRHQzgIZZvbeh6J85j6lsxfmA/Nq
 8ScBSv3ncv/dHeANEEOFjQSExcJsu5Qk1armUYqLSRNlr2BqWY06FZlpztSdafJWFK+B Dw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3418rm1q4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 03:53:30 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0977lVvL015660;
        Wed, 7 Oct 2020 07:53:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 33xgx7t3fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Oct 2020 07:53:28 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0977rQtN25756128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Oct 2020 07:53:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37EB45204F;
        Wed,  7 Oct 2020 07:53:26 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id F3E2F52052;
        Wed,  7 Oct 2020 07:53:25 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     peterz@infradead.org
Cc:     hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
Date:   Wed, 07 Oct 2020 09:53:25 +0200
In-Reply-To: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
        (peterz@infradead.org's message of "Tue, 8 Sep 2020 15:30:31 +0200")
Message-ID: <yt9dimbm79qi.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_04:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 suspectscore=1
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010070045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

peterz@infradead.org writes:

> After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
> lock tracepoints are visible to lockdep and RCU-lockdep is finding a
> bunch more RCU violations that were previously hidden.
>
> Switch the idle->seqcount over to using raw_write_*() to avoid the
> lockdep annotation and thus the lock tracepoints.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [..]

I'm still seeing the splat below on s390 when irq tracing is enabled:

[ 1273.747948] =============================
[ 1273.747953] WARNING: suspicious RCU usage
[ 1273.747960] 5.9.0-20201006.rc8.git0.162c12a918a1.300.fc32.s390x+debug #1 Not tainted
[ 1273.747965] -----------------------------
[ 1273.747971] include/trace/events/lock.h:74 suspicious rcu_dereference_check() usage!
[ 1273.747976] other info that might help us debug this:
[ 1273.747982] rcu_scheduler_active = 2, debug_locks = 1
[ 1273.747987] RCU used illegally from extended quiescent state!
[ 1273.747993] 1 lock held by swapper/8/0:
[ 1273.747998]  #0: 000000010f7281b8 (max_trace_lock){..-.}-{2:2}, at: check_critical_timing+0x7c/0x1c8
[ 1273.748019] stack backtrace:
[ 1273.748034] CPU: 8 PID: 0 Comm: swapper/8 Not tainted 5.9.0-20201006.rc8.git0.162c12a918a1.300.fc32.s390x+debug #1
[ 1273.748040] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
[ 1273.748045] Call Trace:
[ 1273.748053]  [<000000010e656de0>] show_stack+0x90/0xf8 
[ 1273.748060]  [<000000010eea94da>] dump_stack+0xa2/0xd8 
[ 1273.748068]  [<000000010e711cc8>] trace_lock_acquired+0x178/0x180 
[ 1273.748075]  [<000000010e718ed4>] lock_contended+0x24/0xd8 
[ 1273.748083]  [<000000010f26d148>] _raw_spin_lock_irqsave+0xb0/0xd8 
[ 1273.748089]  [<000000010e7ec404>] check_critical_timing+0x7c/0x1c8 
[ 1273.748096]  [<000000010e7ecaa8>] tracer_hardirqs_on+0x128/0x148 
[ 1273.748103]  [<000000010e7eae0c>] trace_hardirqs_on+0x6c/0x1b0 
[ 1273.748110]  [<000000010e644ba8>] arch_cpu_idle+0x28/0x38 
[ 1273.748116]  [<000000010f26ccd6>] default_idle_call+0x56/0x98 
[ 1273.748124]  [<000000010e6da81a>] do_idle+0xf2/0x1b0 
[ 1273.748130]  [<000000010e6dab4e>] cpu_startup_entry+0x36/0x40 
[ 1273.748137]  [<000000010e6590fa>] smp_start_secondary+0x82/0x88 
[ 1273.748142] 1 lock held by swapper/8/0:
[ 1273.748147]  #0: 000000010f7281b8 (max_trace_lock){..-.}-{2:2}, at: check_critical_timing+0x7c/0x1c8

I think this happens because trace_lock_acquired gets called from idle
context?

Regards
Sven
