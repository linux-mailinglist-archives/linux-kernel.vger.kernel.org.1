Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658B52AFF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 07:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgKLGOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 01:14:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725290AbgKLGOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 01:14:38 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AC63IZ1171441;
        Thu, 12 Nov 2020 01:13:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZT0CFz77qbYUv5tKfJs3PFEiPvJMKpLi7jbkTW60L7o=;
 b=pXAZ6GlH3jSZnL/RGKS1ropdKKerkqq7Vm5qOj3QmIhnYAhWa4pWhpq5ZaIAeYO/Ze6D
 klB/gs/2GBc9GMPCD+JeDaZy8hwNpITkgZwmGBZl/UdnNo81C7c5hX//Y9esHNWxpLMX
 37q+mkCf9NF3sjLDhKYDbrnbJtoEPdsaEyvddy5avbkQt6xDMJaDJsoKBdYlYatZS6Qz
 gkIrdfgyWP8I9SJs/u8Ka9JG3M9ZgEo6budxslgrBlwYl7L9TbpozKROc7WVHKxqCTHr
 ENZZD+PnhzCC4Qp1AdOHNYjJrf/YzCrITvH/8nvHjqpsUlWW7Jnta06URb8J2yb++KRY kg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34r8a96jgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 01:13:57 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AC63dWl173931;
        Thu, 12 Nov 2020 01:13:57 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34r8a96jfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 01:13:56 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AC6CQcZ022909;
        Thu, 12 Nov 2020 06:13:54 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 34nk78nbkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 06:13:54 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AC6DpKO61341984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 06:13:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF97A4C04A;
        Thu, 12 Nov 2020 06:13:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A2334C04E;
        Thu, 12 Nov 2020 06:13:48 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.77.203.181])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Nov 2020 06:13:47 +0000 (GMT)
Subject: Re: Scheduler wakeup path tuning surface: Interface discussion
To:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>, riel@surriel.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
From:   Parth Shah <parth@linux.ibm.com>
Message-ID: <5a1b78c0-f286-bfaf-55bf-132093801131@linux.ibm.com>
Date:   Thu, 12 Nov 2020 11:43:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87imfi2qbk.derkling@matbug.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_12:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I was analyzing LPC 2020 discussion regarding Latency-nice interface and
have below points to initiate further discussion:

1. There was consensus that having interface like "Latency-nice" to
provide scheduler hints about task latency requirement can be very useful.

2. There are two use-case regarding the change in the number of CPUs to
be searched in select_idle_cpu path:
- milli-seconds optimization: Perform more scans to find idle CPUs to
reduce latency in milliseconds
- micro-seconds optimization: Perform less searches and queue it to any
CPU when system is overloaded

Both these optimization are contradictory since one requires to reduce
search space for latency sensitive task while other wants to increase
it. Though we can think about tuning select_idle_cpu path by keeping
mask of idle CPUs or applying other tricks, it will always be a
trade-off to search more or less and that's where latency-nice like
attribute can be useful for task aware decisions.

3. Using range is non-deterministic, meaning it is difficult to classify
a task should be marked with value of -18 or -19 and there will be
non-deterministic impact on system performance between these values.

And that's where should we even think of using "Flags" or other type
instead of range where we just say if a task is latency-sensitive or not
and won't classify if a task is "relatively" latency-nice than others?


Best,
Parth
