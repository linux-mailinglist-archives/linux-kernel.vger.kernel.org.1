Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE74F2992EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786523AbgJZQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:50:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36586 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1786371AbgJZQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:48:44 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QGaNLw010214;
        Mon, 26 Oct 2020 09:48:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Sz43j8Zs4bCttn+sq26IgxPDs5ahaHRI85f8KCcoHLk=;
 b=KNoRJsVYW2D48sOIRinCgsntDk1QYeGan5itQmJc9FvuMsLaYFy3Y9r0w/rykJaPpCfh
 5H4r0xkD+yiKORpc5HYLnMHB2vpJjtMKqKaX4Z2IXny3wUDp7Ly28J2snGyrCHuBP6pz
 vyjU/iqPNkW/yoIjkKzqzEgvPoqTQ4fHJ68= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34d3s9x253-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Oct 2020 09:48:37 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 09:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFzSdL0G4wJyO8/H5gJZ0mnCOiAwOI40XVGfHwbR/OnS1twFH38gJLw17fE4jthX0Be7UyT7Hpc7Mq2Ci+ZVGRXF5WlSQDP3i26kO6WB7sff4BGiy8pT6ncFzsEvZSmeGVsH5w2XvEIQFjFTMnP0OB+OXlBy9JMOVnJ3TKqIppes91hQDrdru4jRJCKlRv5BwjuO23+yrdK2iP+aWs2epJSTB5ws9eU8+1EjlPbyOKePrk/1TM1bIKTEGBEP3urApWETajoSgDpVRAL80MOicEWUDlsw/MHe+RCtkv8Ecqh1hRXALiMXNp9kKN8rG1uRC7yJdbNd7ONIR6GFggtEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz43j8Zs4bCttn+sq26IgxPDs5ahaHRI85f8KCcoHLk=;
 b=KC+Non/kipm323qq9HZ7eL4fsJwY1Tk3z9olBZ+1lBVPMLVcNCxT41CnUYeF/huuE0QxhUSKd56N+UU6ByorOOfDEGgLs0dBqRHBEhE0KJzVjR/evkrEI1dbTjciKadBX6vr2mmiVXocQ+7FYOQjR6a7JMWWL2XahLB+dkqHUL99RBXsqHiUjZatnI1vM0wjAJbDGxScto1vdFc3zcXPpDvkTrsdfel66yguMdja/XhZzOLpdyHOOYTWaWtwi0SiivUhrfJDOkPcbegEWDJ70ET5HLzo66gWgARZ0ma8xzAA0zEwRoHUDO+bgSKtgZEwDYCES/eWfr5A3tM5tlSUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sz43j8Zs4bCttn+sq26IgxPDs5ahaHRI85f8KCcoHLk=;
 b=Rdk5TT7Fz2EWrA0RhIcVsMQUZGV+aGpXlzMINT9p2wqjv79KEcHLOD56oL49FQaYB/IF43PGrYs1hn+/NL8E2QPilSpqehyONGzhuLhQiT6Qb7TD9r3FXbdsCUchvKlFzqUbzlgHfSW8pvDXW+u5Utv2Xt8Wfly6PnyVfZqRMjA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
 by MN2PR15MB3118.namprd15.prod.outlook.com (2603:10b6:208:f9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 16:48:32 +0000
Received: from MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7]) by MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7%6]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 16:48:32 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Date:   Mon, 26 Oct 2020 12:48:30 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <B23038A4-945F-48E9-8D38-EABE8204F208@fb.com>
In-Reply-To: <20201026162029.GA11367@vingu-book>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
 <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
 <20201026142455.GA13495@vingu-book>
 <465597a2250d69346cff73dd07817794d3e80244.camel@surriel.com>
 <CAKfTPtCVzass7GM5oj3o3y0ru4HQViWZc2+D-RpFoLvg=__FrA@mail.gmail.com>
 <334f491d2887a6ed7c5347d5125412849feb8a0a.camel@surriel.com>
 <CAKfTPtAfKn0jzOpPNR4NUb0zLs02iLQq2_UCDSCEwhTB2LDAig@mail.gmail.com>
 <20201026120445.6a5dbbbe@imladris.surriel.com>
 <20201026162029.GA11367@vingu-book>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c091:480::1:2ebd]
X-ClientProxiedBy: MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36)
 To MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.75.124] (2620:10d:c091:480::1:2ebd) by MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 16:48:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e142689-dd85-47a4-24b7-08d879cef938
X-MS-TrafficTypeDiagnostic: MN2PR15MB3118:
X-Microsoft-Antispam-PRVS: <MN2PR15MB31182FE3772799B90E202F5DD3190@MN2PR15MB3118.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6tR70XslCa/YLuER6irb5k6uk3fQh1b2lpCarrv/0CD2itBMcgabpshvTv3j8AhQputZEKegocc1XDJ3nLtG32P+fs3LqEGl60zDzLpyTd/QrIuA89yoFomg5qGAEWQiiIi/iq+H7j+4o8heIlyhZzgPMUZ6jAN6+D66uiSsF9mNxmPQZvPYBuHMna3p11zy007zlNHsGscKYHA2xAq7RAvGBH3rzEoRANLcQYTOim1VEwCuQbWDUmnGojIwVBs7uf6dAqERxlWOK4BkfgcWqRXLL7+476IfjSsmyAtPlO40P/2+5CyaaT8NDm6y0PB/Oy2Ln+1KUxV66VWDUW2D/Ei+S0TN0mZLDxcYuNtY+3PaWM1xmqBG2hHyfmrNydV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2878.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(66476007)(66946007)(316002)(83380400001)(5660300002)(86362001)(33656002)(54906003)(8676002)(186003)(2906002)(4326008)(6486002)(16526019)(956004)(6916009)(36756003)(66556008)(52116002)(8936002)(2616005)(53546011)(478600001)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fO6T1/SPuvWSVBCHNGYjqpvSZ6a4t2jHEonB5zpThZdZ2lXR6UjrzHk3cJOFZ3lKtnOV/7fg5XTo94CjxIpeJr8QQssqj64jJwoOAp6b45/DFjmUWD569sJN3VH4EN2mXUbBJs9OYS537Lrsf4+P132pWKz7zEXNeMsjr7XfQIZuorjXPd3iT6MTLZEaYeQzH+ZMjEWvEckwf1VEgEIN0bXg/LfhfarV+hPMduK89vFdqmHMM3fD7HbqF/p2EmzBIGAr+4Mf4xeLpm+THYYXR6Hov9cVLpLFtZEBSOJtLJOxcofylK264HguLfpUh6wzbqpntErNNrtbKUXN9CUK7BYKdjgc6TD2DK5j96GoEH+sLPD9crvq1MePBeMdFgehBNHMWsY8h7Ov/sDMJ+7Bi6kK+ojT+omUY5AZNziu4O3tHJnYIp4BTpEr4hy1h0qzcK2Ruo2tu1R626YzH8ZnHk5fYLo0s3iVDoGiwOhyOEkXhLmEnHwMnGK3ZDut7TLWhbxOQrtfcfwPFt0JBAfGlXsFrWg8JCv+AX1yFEUXIWn5EQvESQ/x+uHT3XNkda+darSArJgY881tltHgoHjvq71CfnoCKmmTz1rj90M5avakOPQc7/kJgg4L5iA9oZdzk73Dbq6ZzdG/QTx6qIkHaSibzIZ/DYDhHOO3BgIDcDZLGSSCWfyRO2jwYPRkNzlz
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e142689-dd85-47a4-24b7-08d879cef938
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2878.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 16:48:32.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: REALg09xVlZslrNwvBKTDyqRYgpvmhQDE1s18E7nEdwXrs5oTgN4gDXeSiIQe3MW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3118
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_08:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010260113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct 2020, at 12:20, Vincent Guittot wrote:

> Le lundi 26 oct. 2020 à 12:04:45 (-0400), Rik van Riel a écrit :
>> On Mon, 26 Oct 2020 16:42:14 +0100
>> Vincent Guittot <vincent.guittot@linaro.org> wrote:
>>> On Mon, 26 Oct 2020 at 16:04, Rik van Riel <riel@surriel.com> wrote:
>>
>>>> Could utilization estimates be off, either lagging or
>>>> simply having a wrong estimate for a task, resulting
>>>> in no task getting pulled sometimes, while doing a
>>>> migrate_task imbalance always moves over something?
>>>
>>> task and cpu utilization are not always up to fully synced and may 
>>> lag
>>> a bit which explains that sometimes LB can fail to migrate for a 
>>> small
>>> diff
>>
>> OK, running with this little snippet below, I see latencies
>> improve back to near where they used to be:
>>
>> Latency percentiles (usec) runtime 150 (s)
>>         50.0th: 13
>>         75.0th: 31
>>         90.0th: 69
>>         95.0th: 90
>>         *99.0th: 761
>>         99.5th: 2268
>>         99.9th: 9104
>>         min=1, max=16158
>>
>> I suspect the right/cleaner approach might be to use
>> migrate_task more in !CPU_NOT_IDLE cases?
>>
>> Running a task to an idle CPU immediately, instead of refusing
>> to have the load balancer move it, improves latencies for fairly
>> obvious reasons.
>>
>> I am not entirely clear on why the load balancer should need to
>> be any more conservative about moving tasks than the wakeup
>> path is in eg. select_idle_sibling.
>
>
> what you are suggesting is something like:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4978964e75e5..3b6fbf33abc2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9156,7 +9156,8 @@ static inline void calculate_imbalance(struct 
> lb_env *env, struct sd_lb_stats *s
>          * emptying busiest.
>          */
>         if (local->group_type == group_has_spare) {
> -               if (busiest->group_type > group_fully_busy) {
> +               if ((busiest->group_type > group_fully_busy) &&
> +                   !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
>                         /*
>                          * If busiest is overloaded, try to fill spare
>                          * capacity. This might end up creating spare 
> capacity
>
> which also fixes the problem for me and alignes LB with wakeup path 
> regarding the migration
> in the LLC

Vincent’s patch on top of 5.10-rc1 looks pretty great:

Latency percentiles (usec) runtime 90 (s) (3320 total samples)
         50.0th: 161 (1687 samples)
         75.0th: 200 (817 samples)
         90.0th: 228 (488 samples)
         95.0th: 254 (164 samples)
         *99.0th: 314 (131 samples)
         99.5th: 330 (17 samples)
         99.9th: 356 (13 samples)
         min=29, max=358

Next we test in prod, which probably won’t have answers until 
tomorrow.  Thanks again Vincent!

-chris
