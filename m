Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1405E2CA205
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390301AbgLAL5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:57:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387398AbgLAL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:57:33 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BX0bc111105;
        Tue, 1 Dec 2020 06:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=6Uq1pBXTUJQ0I5Z0XX8ssaCGOTNU/guwHEsEYmYuW0Q=;
 b=Sn8Cdkt13Jyv7oyRe7IGm8TTwlSJLl/pgkEZIM30F7jF7CzF3ihPvIAapdHYBk89oGj1
 qOJsGt8eOjvrtxcbngQVKaLSyR+c/aavLfWfC+8oJ91DAVvuHYk2qxl/GHcQqOujpxJn
 VcEhKYkEUmWZW9nJmq7IJ664pNykNfheRuauJI+8V1aon7WtecOvrmXrcjTxBgBxTVi2
 5tEqRPg+cCWS61Pp8Av2kCh4h86wlsZXTdZtiIsG/uWva/SXuXUTYNIoFO+87gkezT+m
 2NZRwRmPy/4xIelsDkx3R+7XErxZvlHNFczDRJlqD1jOOBn0bwskc8IL1KcDVMZw8M/j pw== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355j4px7jw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:56:33 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BktlX030612;
        Tue, 1 Dec 2020 11:56:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 353e684k29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 11:56:30 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1BuRkS51904846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 11:56:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5E9B52057;
        Tue,  1 Dec 2020 11:56:27 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 646815204E;
        Tue,  1 Dec 2020 11:56:27 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org,
        mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
References: <20201120114145.197714127@infradead.org>
        <20201120114925.594122626@infradead.org>
        <20201130210003.GA40619@roeck-us.net>
        <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
Date:   Tue, 01 Dec 2020 12:56:27 +0100
In-Reply-To: <20201201110209.GQ3040@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 1 Dec 2020 12:02:09 +0100")
Message-ID: <yt9dh7p54u50.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_04:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=580 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

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

I looked into adding the required functionality for s390, but the code
we would need to add to entry.S is rather large - as you noted we would
have to duplicate large portions of irqentry_enter() into our code.
Given that s390 was fine before that patch, can you revert it and submit
it again during the next merge window?

Thanks
Sven
