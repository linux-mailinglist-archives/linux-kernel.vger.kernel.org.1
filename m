Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74A92422CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 01:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgHKXS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 19:18:26 -0400
Received: from mail4.tencent.com ([183.57.53.109]:39215 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:18:26 -0400
Received: from EX-SZ021.tencent.com (unknown [10.28.6.73])
        by mail4.tencent.com (Postfix) with ESMTP id 7BC2772530;
        Wed, 12 Aug 2020 07:18:21 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1597187901;
        bh=ccbasj18elNigywhvKIXQ5fmp3tYk0m6zTnBvcl6CV8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=deFFdOdnS7w1NEmgc6Ka6XjQUzsgmS2As+bwQ5p4FCTFQMkUz4MYeOWZdYXwQQbBn
         f2TfEtKJpXVOuMfdo/pV1F/sOnhftYcA252l00EG0nNxi1TekDibOwu+ENZf9OeAZY
         MIQiiV1Itf3tx2MlnD6YkBg/v9e8/VxDQNo4VZJw=
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ021.tencent.com
 (10.28.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 12 Aug
 2020 07:18:21 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ012.tencent.com
 (10.28.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 12 Aug
 2020 07:18:21 +0800
Received: from EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b]) by
 EX-SZ012.tencent.com ([fe80::f57b:8971:e6d4:fe6b%3]) with mapi id
 15.01.1847.007; Wed, 12 Aug 2020 07:18:21 +0800
From:   =?iso-2022-jp?B?YmVuYmppYW5nKBskQj5VSTcbKEIp?= 
        <benbjiang@tencent.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
CC:     Jiang Biao <benbjiang@gmail.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair: Optimize dequeue_task_fair()(Internet mail)
Thread-Topic: [PATCH] sched/fair: Optimize dequeue_task_fair()(Internet mail)
Thread-Index: AQHWb7uHIOwUFikfVEWDShzE3PLAcakymr+AgABqtoA=
Date:   Tue, 11 Aug 2020 23:18:21 +0000
Message-ID: <FA4A95BE-596A-4550-BB28-959938D19729@tencent.com>
References: <20200811084310.27130-1-benbjiang@tencent.com>
 <9a2ddb2d-4c9a-a85d-cba2-0956b6d953c0@arm.com>
In-Reply-To: <9a2ddb2d-4c9a-a85d-cba2-0956b6d953c0@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [9.19.161.120]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <694C00228257544F84CF6DE302BE3910@tencent.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Aug 12, 2020, at 12:55 AM, Dietmar Eggemann <dietmar.eggemann@arm.com>=
 wrote:
>=20
> On 11/08/2020 10:43, Jiang Biao wrote:
>> Similar optimization as what has been done in commit,
>> 7d148be69e3a(sched/fair: Optimize enqueue_task_fair())
>>=20
>> dequeue_task_fair jumps to dequeue_throttle label when cfs_rq_of(se) is
>> throttled which means that se can't be NULL. We can move the label after
>> the if (!se) statement and remove the if(!se) statment as se is always
>> NULL when reaching this point.
>>=20
>> Besides, trying to keep the same pattern with enqueue_task_fair can make
>> it more readable.
>>=20
>> Signed-off-by: Jiang Biao <benbjiang@tencent.com>
>> ---
>> kernel/sched/fair.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 04fa8dbcfa4d..cbbeafdfa8b7 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5618,10 +5618,10 @@ static void dequeue_task_fair(struct rq *rq, str=
uct task_struct *p, int flags)
>>=20
>> 	}
>>=20
>> -dequeue_throttle:
>> -	if (!se)
>> -		sub_nr_running(rq, 1);
>> +	/* At this point se is NULL and we are at root level*/
>> +	sub_nr_running(rq, 1);
>>=20
>> +dequeue_throttle:
>> 	/* balance early to pull high priority tasks */
>> 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>> 		rq->next_balance =3D jiffies;
>=20
> There is already a similar patch in master.
>=20
> 423d02e1463b - sched/fair: Optimize dequeue_task_fair() (2020-06-25 Peng
> Wang)
Indeed, my local repo has been outdated, sorry for the interruption. :)

Thx.
Regards,
Jiang

