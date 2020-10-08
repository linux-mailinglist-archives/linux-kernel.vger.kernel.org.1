Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8C287114
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgJHI6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:58:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53236 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbgJHI6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:58:24 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0988YHRx048866;
        Thu, 8 Oct 2020 04:58:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=pirVXN2LrxE0BrQiLpZpp/TC/Zo0/c3h8/K7vcNKEyg=;
 b=dUgWmniZZ6kBw/MY/T9FoYWYLX9gFhRykscGvD+V2HGu7dzIzjdhytsMiWmV3PeWaXFn
 hEbYx78ssl8EQ4r8ow6T/xZOlfN9H1i5ZB0LCp5T6axXRCfj6cnypuZoBWH4YuBMO19l
 QeDYOlK0AcliM4y316uAeGHBH7ZPa/w53abtWPdKCSKkNWjgfkyvNNh69o87Q2F5Yag8
 5ZQqFpT3OGLw0gCCSXJDDQ4CrraVR1/WAncmVlnCS06zqDgp/QuRXwBGhe35jjMMqvO0
 7ekpEv11Oggt4Ep4bNBGo+9+aW1ldVTXsQDDAy62uHaeQpvLuhgle8Uyt1JTEpgnl2HD Sg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 341wwrbfrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 04:58:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0988vW0i015008;
        Thu, 8 Oct 2020 08:58:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 33xgx854j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 08:58:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0988w6we13566210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Oct 2020 08:58:06 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB310A4062;
        Thu,  8 Oct 2020 08:58:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA282A4060;
        Thu,  8 Oct 2020 08:58:05 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Oct 2020 08:58:05 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
        <yt9dimbm79qi.fsf@linux.ibm.com>
        <20201007100551.GC2628@hirez.programming.kicks-ass.net>
        <20201007125625.GK2651@hirez.programming.kicks-ass.net>
Date:   Thu, 08 Oct 2020 10:58:05 +0200
In-Reply-To: <20201007125625.GK2651@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 7 Oct 2020 14:56:25 +0200")
Message-ID: <yt9dy2khrt5u.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_04:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010080060
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Oct 07, 2020 at 12:05:51PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 07, 2020 at 09:53:25AM +0200, Sven Schnelle wrote:
>> > Hi Peter,
>> > 
>> > peterz@infradead.org writes:
>> > 
>> > > After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
>> > > lock tracepoints are visible to lockdep and RCU-lockdep is finding a
>> > > bunch more RCU violations that were previously hidden.
>> > >
>> > > Switch the idle->seqcount over to using raw_write_*() to avoid the
>> > > lockdep annotation and thus the lock tracepoints.
>> > >
>> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
>> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > > [..]
>> > 
>> > I'm still seeing the splat below on s390 when irq tracing is enabled:
>> 
>> Damn... :/
>> 
>> This one is tricky, trouble seems to be that arch_cpu_idle() is defined
>> to enable interrupts (no doubt because ot x86 :/), but we call it before
>> rcu_exit_idle().
>> 
>> What a mess... let me rummage around the various archs to see what makes
>> most sense here.
>
> Maybe something like so, I've not yet tested it. I need to figure out
> how to force x86 into this path.

I've gave this patch a quick test on linux-next from today and haven't
seen the splat again. However it wasn't happening all the time, so will
test it a bit longer. I haven't looked into the tracing code in detail,
but i guess it was only happening when the lock was contented.

The only thing with this patch is that rcu complains that it gets called
with interrupts enabled on s390 when rcu_irq_enter() is called. But a
few trace_hardirqs_{on,off} at the beginning and end of the IRQ handlers
are fixing this. Will check why this worked in the past.

Sven
