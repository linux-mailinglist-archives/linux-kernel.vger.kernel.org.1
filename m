Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D52990FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783843AbgJZP27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:28:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7762 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1783835AbgJZP26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:28:58 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QFGut5022303;
        Mon, 26 Oct 2020 08:28:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FesaTwgnxDxCeEHEwcIh7zU/l6bnC7MGlCbLlzlWC4k=;
 b=eXwS3p8InGGyY/T1L+EQvbyz4jIkQoz7c4zODAiTvCqAciaT5lQbhktqfVzq6FlDSK3j
 QfOV+TVT3mKPvdU7trgv20a95vHK+udUENXcOts2WokzWLhXr4KR6HdE5zcf6Jf0ZD5B
 OL67GIrOyvYS1JZkniiK0ht7f7zhJ9v/TB0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34d3s9wjke-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Oct 2020 08:28:51 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 08:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghbKrEJCw6n4LYa2UDcoBPwmf07a3XmWwm6No7MIFVdsYQoiQOuo/d3Fpth4V1pnSfMlJQDDr0Y6jwk2hTIyLlpnXfvbkkOEAfmYZbu+XEePq+UzNQZ5kKw56PInseKxyZ0HR7BkgmanpvtpSU1L9g6Iu8iigSDOrgdYdQoxUe2r59cS3rZ9EtP1ScJfLD9KrkWgsnTW4jibDK3DDLRCCst7ubAQeJEnNIcaAdx+EBtCOC+dz18d33bg4ohu7pq1JPcOxuvHIxY8yIkfnR6toPtc8ymH3KpNBXn0QuwzUoxcDyRIjVP3GlVzZxfJ0LsKYGWNOl7vVVrq/9tGKyGYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FesaTwgnxDxCeEHEwcIh7zU/l6bnC7MGlCbLlzlWC4k=;
 b=IL0k1sGSIjV4e6WCGDflPIqXy/TuVipnZW7FQQqoOweVN0Q3xqJTSn132R0ThKJiacaUskBc3lALEl5OQnbWxo9ww+WzWOlyctASJ3JLK14htEYXJ8vZZGdjP/Tzsgx2h5IYa78tPKjXJBatswWMZql4jEOsRlY/VgpN1v7zqdQ4mrr64LXKXIo8pHz7f0IfYu8NXuHtBw3sKc26gIYjDxnva+zL9mKMalSb4cAi7qI4J3KWO17KYoHg/tbHtWnlRAGUmTGQZsjGXxebPPq1X9CoqDJ9RQxIQ1joSWBok7pb7ZE2Rtl/KhHZmUKvNmPfGVK584rQrVo3tX9zZWKQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FesaTwgnxDxCeEHEwcIh7zU/l6bnC7MGlCbLlzlWC4k=;
 b=Dllv7qCWoHCAPBW9E6isut6ToyWsba/BbAJfuAkTlYQJ3EOBJ7wyD3abuz9YnK/u0y+/u6F/nFV+Avww+GBHP0fqLu7iS24uGloTkutZ10+1ND1L5TBbodFZB2ZWTDc0BUookUb/wcZZEA3Fhn7Isv1c32+uzTk4pssoE8UTbHY=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
 by MN2PR15MB2557.namprd15.prod.outlook.com (2603:10b6:208:123::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 26 Oct
 2020 15:28:45 +0000
Received: from MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7]) by MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7%6]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 15:28:45 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Date:   Mon, 26 Oct 2020 11:28:43 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <E3EBECF9-D16E-4D5B-B4F7-675B42624F19@fb.com>
In-Reply-To: <83A9BEDF-20BB-4BAD-AABD-0EECB92BF8DF@fb.com>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
 <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
 <20201026142455.GA13495@vingu-book>
 <83A9BEDF-20BB-4BAD-AABD-0EECB92BF8DF@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c091:480::1:2ebd]
X-ClientProxiedBy: MN2PR14CA0021.namprd14.prod.outlook.com
 (2603:10b6:208:23e::26) To MN2PR15MB2878.namprd15.prod.outlook.com
 (2603:10b6:208:e9::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.75.124] (2620:10d:c091:480::1:2ebd) by MN2PR14CA0021.namprd14.prod.outlook.com (2603:10b6:208:23e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 26 Oct 2020 15:28:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d4e9da-69a7-41bc-1fe4-08d879c3d3d4
X-MS-TrafficTypeDiagnostic: MN2PR15MB2557:
X-Microsoft-Antispam-PRVS: <MN2PR15MB2557BED02B98BE4A164564A6D3190@MN2PR15MB2557.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkEkuizvRiTNxBY5k5AtZ63K9NZodZmb2+Y9YoHDAGe6V1LSSm4hqWBXyiZKgOgQMtrWxnkV0TeeRJLVoaYEAZUhCiSUe24wkSXrM3h3h1YrWyWPPiVKJh8lvPOt38Qxaq3X8LDs8e43eIYXc8/pDn3mFRxyjl+9JrTZzgCmvmWRa0kqmXlOl94+sD8dJtoeHZehacFWcCCL8/d68XJrzPfALDhUSjw8fXhvGQwoFL47ZsC7l4bmc41y3cL60zbUE8hSjHHuhuKEWp6pFzez6YVxFgkHWcBl7SmEQfZm7oZPZVCUZuSSHL0Joah2Vt+DeR8Y9R4I0SnDFLdpxnk5WfiEVB0OzMrmHk14Jv9LoADgaISJ8Bq9LB5Se45rzEVZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2878.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(376002)(396003)(53546011)(2906002)(36756003)(6916009)(5660300002)(16526019)(478600001)(66476007)(2616005)(33656002)(52116002)(956004)(186003)(66556008)(54906003)(6486002)(66946007)(316002)(8676002)(4326008)(86362001)(8936002)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: /9LBd2T/+nRHXhZuxQ/bNi5XJF35fGWFelY16N6Gr93Fw7LxIhiFty0rUzzM9cvFELTbui5O/Dhee0zA/Y5f8Yfh9yquhVhTCRW22TPPvqNgePvWT34zKTvw0sKdKQJKceNENICZ2ankzmyRjzIVIgTDFbkQu6lZuCpyh/Yn4omFMcQEX1EqX5BH/iIyOeeHDuswyYIaLK1bMrIR/khcKYGwepGELEwFsRuMGNfmjBQ1n2Nal7AW2oqdEp+RFii+PUTdB42a7NZzq2eGlBARQgCEN57y1DwcbnL8wKRQybewBmob5wdQDgK1hdKh7UnwFo1R2e7Eu9SEh55DpgOv9SALRoa5BNAqpP0geH7boSvHUB1mgcqDASFE4sKIytoxtQjXDjBA2vnR/E9GzJ/C2IDc1DAKZARbomAA/4Hk39j0NJeyUyhl3cLXHvAxyFjZSEBRwGUHZ4HYxtP29rqOqtPF1/a4767DZNSHcpIGSMBX5VJJNUY2mQ4jqdYWRSQHlICTP5e6zJZxQO0+4bKzv32FJ9qqkfMLElkXgDP9PChSpScGmn19RsdM0o+BoiSWEHqKLqShYaBn9Mnn6CmjJQXxCcf3e10jJG4TJVSqQQ10oWwiFtoj8GfD9fdxlsdv6g0wqrbmzJIwI2+Iuq+GtTteai6W/gdQNoXPIEFdfASmdHLgr93MZIvHvQKehcR+
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d4e9da-69a7-41bc-1fe4-08d879c3d3d4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2878.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 15:28:45.3322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/rEFjWQghvg+Uu307sodfIyhiu82m1gJo5yZWs1Uzh2D3mitRqLVkI99iOp/ASO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2557
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_08:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010260108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct 2020, at 11:05, Chris Mason wrote:

> On 26 Oct 2020, at 10:24, Vincent Guittot wrote:
>
>>
>> Could you try the fix below ?
>>
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -9049,7 +9049,8 @@ static inline void calculate_imbalance(struct 
>> lb_env *env, struct sd_lb_stats *s
>>          * emptying busiest.
>>          */
>>         if (local->group_type == group_has_spare) {
>> -               if (busiest->group_type > group_fully_busy) {
>> +               if ((busiest->group_type > group_fully_busy) &&
>> +                   (busiest->group_weight > 1)) {
>>                         /*
>>                          * If busiest is overloaded, try to fill 
>> spare
>>                          * capacity. This might end up creating spare 
>> capacity
>>
>>
>> When we calculate an imbalance at te smallest level, ie between CPUs 
>> (group_weight == 1),
>> we should try to spread tasks on cpus instead of trying to fill spare 
>> capacity.
>
> With this patch on top of v5.9, my latencies are unchanged.  I’m 
> building against current Linus now just in case I’m missing other 
> fixes.
>

I reran things to make sure the nothing changed on my test box this 
weekend:

5.4.0-rc1-00009-gfcf0553db6f4 (last good kernel)
Latency percentiles (usec) runtime 30 (s) (1000 total samples)
         50.0th: 180 (502 samples)
         75.0th: 227 (251 samples)
         90.0th: 268 (147 samples)
         95.0th: 300 (50 samples)
         *99.0th: 338 (41 samples)
         99.5th: 344 (4 samples)
         99.9th: 1186 (5 samples)
         min=25, max=1185

5.4.0-rc1-00010-g0b0695f2b34a (first bad kernel)
Latency percentiles (usec) runtime 150 (s) (960 total samples)
         50.0th: 166 (488 samples)
         75.0th: 210 (232 samples)
         90.0th: 254 (145 samples)
         95.0th: 299 (47 samples)
         *99.0th: 12688 (39 samples)
         99.5th: 13008 (5 samples)
         99.9th: 13104 (4 samples)
         min=24, max=13100

3650b228f83adda7e5ee532e2b90429c03f7b9ec (v5.10-rc1) + your patch

Latency percentiles (usec) runtime 30 (s) (1000 total samples)
         50.0th: 169 (505 samples)
         75.0th: 210 (246 samples)
         90.0th: 267 (151 samples)
         95.0th: 305 (48 samples)
         *99.0th: 12656 (40 samples)
         99.5th: 12944 (5 samples)
         99.9th: 13168 (5 samples)
         min=44, max=13155

-chris
