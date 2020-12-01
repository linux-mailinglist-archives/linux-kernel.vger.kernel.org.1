Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C228A2CA10F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbgLALN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:13:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730183AbgLALN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:13:26 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1B3aqq068391;
        Tue, 1 Dec 2020 06:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=CRbrZlcxtyheNMGS1l2aRWIuMKxowCI8eynd4savJhc=;
 b=ehGRgFZzqdqOzS3tykpBWkGOv1yd2Pnqd5iFyFgugdR2SAPogvLt3RbjOEUN4pB+YCyd
 IXVEn/ye9mL1EHYBqxSnlC9eqnIiRE6sglKwfDn27Sffpny55lnroDvo7jryiC68RHRZ
 y+26q7De36Ab6RSYXL/HUuWy+j3OzsXd0n37sqdLtE66JAGD77AsInwpNQjAt0BHHDff
 8+NJ8qKDz1Mpv+kq0b1k0cIlbvJP19FCEK0+1mpZCW4SXhsi3dYlgECoFStA8jMeBMP9
 MhHQc9Mf1GRf0fyGYsPqZ/yl9wRi5zG0j/p3T1CrWk91zXn9iIFhq2Yibo97zjpUY1OO 1Q== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355jwuudhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:12:24 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1B73V3018535;
        Tue, 1 Dec 2020 11:12:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 353e684h9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 11:12:22 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1BCJHh33161708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 11:12:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13B6CA4051;
        Tue,  1 Dec 2020 11:12:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADC7FA404D;
        Tue,  1 Dec 2020 11:12:18 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Dec 2020 11:12:18 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org,
        mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
References: <20201120114145.197714127@infradead.org>
        <20201120114925.594122626@infradead.org>
        <20201130210003.GA40619@roeck-us.net>
        <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
Date:   Tue, 01 Dec 2020 12:12:18 +0100
In-Reply-To: <20201201110209.GQ3040@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 1 Dec 2020 12:02:09 +0100")
Message-ID: <yt9d4kl56ar1.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_04:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=628 spamscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Nov 30, 2020 at 01:00:03PM -0800, Guenter Roeck wrote:
>> On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
>> > We call arch_cpu_idle() with RCU disabled, but then use
>> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
>> > 
>> > Switch all arch_cpu_idle() implementations to use
>> > raw_local_irq_{en,dis}able() and carefully manage the
>> > lockdep,rcu,tracing state like we do in entry.
>> > 
>> > (XXX: we really should change arch_cpu_idle() to not return with
>> > interrupts enabled)
>> > 
>> 
>> Has this patch been tested on s390 ? Reason for asking is that it causes
>> all my s390 emulations to crash. Reverting it fixes the problem.
>
> My understanding is that it changes the error on s390. Previously it
> would complain about the local_irq_enable() in arch_cpu_idle(), now it
> complains when taking an interrupt during idle.

The errors on s390 all were fixed in the meantime. I cannot say which
patch fixed it, but we haven't seen any warning in our internal CI
during the last weeks. So reverting the patch would likely fix the issue
for us.

s390 is likely to switch to generic entry with the next merge window (im
working on it), so all that stuff will be easier than.
