Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAAF299079
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783080AbgJZPFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:05:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37856 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1782910AbgJZPFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:05:51 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QF0Ql3002628;
        Mon, 26 Oct 2020 08:05:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=t/AsGt5+bq45VXMk+Xj4cE5vRvdsPrVpR0YMxO+xWL0=;
 b=jRswoK0svoetZcUDbj0ms14v7jGCWZGAmh6TsvYBn0R5mTuD8ItzlfxFtXQN7pj5ByCT
 VFGm+F6EeOn2fmDDDygO8NdrF5jx4VRtYr4+7O/CnxeGl1c/ozyS0xF+7sF9RgsfxG2B
 plnudS+rxHJUPkGYUCETtVB9yTfmfhHH3l8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34d43k5en9-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Oct 2020 08:05:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 08:05:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZuXJs9K5OJ/KR2neFtTkqsTxhP+6TRpSr2XngdFPwQ9TEQ1wqKEEbwR4ZB/n2zDki3U52w+Jc/sqTWwESXhkjnHkf0JIX1BVbl7EUiZ74oxy3VHWgkNooParATzEuYJa47/7w34BLr7EWXv8IWHDl5KaUZb/Txpt6Yckd6vbECINxmIlJNN6MPnKJUGykpCySZBsibRYwZvw+yQtyDW+YaNljmFzFi/46kUIV/QnRbr64LhIOOzOAUjo4D1SQHkzGUuEROkl+E62hnB6yWGxCtu/0dTwbubWC9TVGLRhuRonWAB1Ts49IuFLb4k1NWJlhTSPhUyMa3gGGH334fzgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/AsGt5+bq45VXMk+Xj4cE5vRvdsPrVpR0YMxO+xWL0=;
 b=Ufvc914FxufjwACYoEqy94bCxu11qvTBZs9W4wvCNUt1CqTM4eOtLTSkEwWWkAzhHfao/FmTIuHZqH/5U2257nBQ/4JjJwmWNjrMua+EKiFnUsHlzNpr4gLZI8pARqO5iaeJ2hNw65io8rwshl9qWt5tQ48lHIKOhDQZvtqwaGcFObfYzHDYaRBomKrOfVRrrUhpHy733ZrpSR1HTSmFcJVo3mb3Ml82kaDW/Fh1/8Cb82DcM5ufTezCFcGv1865esBqTu//aL2razEVJHvJZo56Ryo2oB7elweEglHTeiqzwuua+Zj9KeoouoKwrbvFTpY5zcsjLlRRV8BTV1Gonw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/AsGt5+bq45VXMk+Xj4cE5vRvdsPrVpR0YMxO+xWL0=;
 b=dvvAbxwliHRgvCa3V5CEIZhxBLRFcV1xjGLH0qm6txIayOTDAVDtHg301uCR9SLkN7ug7QKftCOP6U4L6dBeT57I0esY70rTea+5GZkFQODMHYuVJ2IMwIgM5cGUOB/MBU87iVl8UVmMCobT4cea84PQaNs6mmQdgOwlUZnSUeA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
 by MN2PR15MB2718.namprd15.prod.outlook.com (2603:10b6:208:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 26 Oct
 2020 15:05:39 +0000
Received: from MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7]) by MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7%6]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 15:05:39 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Date:   Mon, 26 Oct 2020 11:05:35 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <83A9BEDF-20BB-4BAD-AABD-0EECB92BF8DF@fb.com>
In-Reply-To: <20201026142455.GA13495@vingu-book>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
 <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
 <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
 <20201026142455.GA13495@vingu-book>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c091:480::1:2ebd]
X-ClientProxiedBy: BL1PR13CA0150.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::35) To MN2PR15MB2878.namprd15.prod.outlook.com
 (2603:10b6:208:e9::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [100.109.75.124] (2620:10d:c091:480::1:2ebd) by BL1PR13CA0150.namprd13.prod.outlook.com (2603:10b6:208:2bb::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.9 via Frontend Transport; Mon, 26 Oct 2020 15:05:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 084721df-a787-42b4-ddee-08d879c0999f
X-MS-TrafficTypeDiagnostic: MN2PR15MB2718:
X-Microsoft-Antispam-PRVS: <MN2PR15MB27186DF147A94EF27E2A593CD3190@MN2PR15MB2718.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HtC58uIURTgpbkP3/MXFHpKgrjZf/tLeX2LGLWrbcyX91VVQMAECcWk/2cNzybej4alb4RCnMoou80cLUqZ0Q0aH5693VyVxyHXCWFiZkC07gwB1tA4LsRmB/JgASE8Rut1ydIdsPvWdtFAwOQ7Cg+LKHWbIjky/kW0sLHYL/WAH/iZGYb7ItfL1LrR4B4jL8BLu2NnEDnIdG2hBP3Amkczkm8A6ujfdlJAdnEIG0AAddiS2W1XaoNujUQlzAOjNTUOsW0dJFq4fpfOI7sRL/oftEjjB/e0rWvdBSAZfxjtL6L133r5viRSjgL7ZmT+F37tl4f7I9J48vM69s6dHiAeOpAwev3MT+yTqriievn01J79fNVSlWM+9lxabj0cp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2878.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(39860400002)(346002)(66946007)(5660300002)(53546011)(52116002)(6666004)(54906003)(83380400001)(2616005)(2906002)(8676002)(956004)(316002)(8936002)(66574015)(86362001)(6486002)(4326008)(6916009)(66476007)(66556008)(186003)(33656002)(16526019)(478600001)(36756003)(78286007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1nASTZtv/w39NW5VWpJDB/uYVJhP4ilQZUt3M/QjkV0l+C5QecuRDByJbIxFcDLqeYKpfiQ/oE4NSp/SZYFi1HIonq2RGNrpb2DSBzMebE3nf1lxS+Uahre55l2Xs6D2849Khgk8+umSpivn4peaXUQHJn2uNbVoeSx8SH4QK5QIgkadj4a/5zugtfMoZAlF6XupwZ9yzxYSWPQzHwInq3UXVzFkV9m8rK9G7XqMLDa8FowJLVTkc+wKnqE5JCub9ZmxqWxb+zPyJXkIzG0BbKcQYMfbiNB0h9SrYW27DZboA3UEHXaxeg1XPOaPt1nC1gpNSii7rari/qFKjXezjJsJsXU0h21Q1GjRx8dk/ImMe1QN6zF2MuYnrxbaDyzhW0LqEuOCAm+JfD9RprD/MICeocxyMG6HMWjKXPcb4WbMPNUVZ106PwF6CUWK1YDvABeMe3Ko+cbvTQyT8cUpSZ3DAcOQ+cqPUlm3tsNkTsMF3P0dxLWfqaUyAN9JDOk6ftpfN8bGmH3quaLFuONeBZAqq38CM01BwG6VmsbVHdVMuiMok3S4DwAXmH7HLIRF5BJRks1hknYA4h8kJXwJ4E88M1AVdzl/5ZMspqRINsZyzpBKUJQh3z3YuxddAgNgtIy3h8ZhPLrBGqOaqqGY1EjRApNVKlq7w9yLOCoMTardXqH4sB3+pfaoOf0WK9dM
X-MS-Exchange-CrossTenant-Network-Message-Id: 084721df-a787-42b4-ddee-08d879c0999f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2878.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 15:05:39.2277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0adM9Z3XIc2cuVhS+x8nnF97m+9RoPzTLzRmpul9XfGL8Ur0gAKCXxkDsSiXAUO+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2718
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_08:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26 Oct 2020, at 10:24, Vincent Guittot wrote:

> Le lundi 26 oct. 2020 à 08:45:27 (-0400), Chris Mason a écrit :
>> On 26 Oct 2020, at 4:39, Vincent Guittot wrote:
>>
>>> Hi Chris
>>>
>>> On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
>>>>
>>>> Hi everyone,
>>>>
>>>> We’re validating a new kernel in the fleet, and compared with 
>>>> v5.2,
>>>
>>> Which version are you using ?
>>> several improvements have been added since v5.5 and the rework of
>>> load_balance
>>
>> We’re validating v5.6, but all of the numbers referenced in this 
>> patch are
>> against v5.9.  I usually try to back port my way to victory on this 
>> kind of
>> thing, but mainline seems to behave exactly the same as 0b0695f2b34a 
>> wrt
>> this benchmark.
>
> ok. Thanks for the confirmation
>
> I have been able to reproduce the problem on my setup.

Thanks for taking a look!  Can I ask what parameters you used on 
schbench, and what kind of results you saw?  Mostly I’m trying to make 
sure it’s a useful tool, but also the patch didn’t change things 
here.

>
> Could you try the fix below ?
>
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9049,7 +9049,8 @@ static inline void calculate_imbalance(struct 
> lb_env *env, struct sd_lb_stats *s
>          * emptying busiest.
>          */
>         if (local->group_type == group_has_spare) {
> -               if (busiest->group_type > group_fully_busy) {
> +               if ((busiest->group_type > group_fully_busy) &&
> +                   (busiest->group_weight > 1)) {
>                         /*
>                          * If busiest is overloaded, try to fill spare
>                          * capacity. This might end up creating spare 
> capacity
>
>
> When we calculate an imbalance at te smallest level, ie between CPUs 
> (group_weight == 1),
> we should try to spread tasks on cpus instead of trying to fill spare 
> capacity.

With this patch on top of v5.9, my latencies are unchanged.  I’m 
building against current Linus now just in case I’m missing other 
fixes.

-chris
