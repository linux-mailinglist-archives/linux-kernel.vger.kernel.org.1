Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4027B298D06
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775385AbgJZMpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:45:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24418 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1775378AbgJZMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:45:44 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QCjWhg022962;
        Mon, 26 Oct 2020 05:45:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=yolc5uT0uLumkC/QzdVirxCiUWujmaCq4+8aNuvLj3c=;
 b=mAM+WxkKu6drCU4EWIYTWcXTIfn0y7MKJVvSFN3UUS9s/pYjHa+gPFXGnbAxGukxR4V6
 AyUT9WbajtEkKRSaDvUz1oZcZ44VuI8esvTz+BW7c9KAfxJJYjYGha48LDWt4QfcrV3M
 +1rhdLj30Z5AYTTn06blvmcifflxPYPjisk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34d3rtvrdr-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 26 Oct 2020 05:45:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 26 Oct 2020 05:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3A2Mi3eASwtHknT5bVlLHG6pr7gjV3rydPKAD22n4qJsWbvgLs7gkiwizBAU1H0fUUthZAGMXDr+0xt+eUQp2CWsW3ESIrf5IYNYshaA2gWjya5dpsRmioX7y64FMovT+bhiIfGObkZeUcelNnQcwDPNHImF4c1mpwkpl3Nw6cQJJkRUIjNQirWBdc1wd50z6+zyOoN47QluuuRfpR8W0Yzh6De7Eld5MN7s65tWyWW2jNaZy9in2cEVJDeumdbNi4QlkTGf1ebJa4h5WPwiD/0h1o1tAgWKUknX8ZzUPw4cpj3CClEuES1FTaAD54Awxn7LJ49iWOYKBZiFYg1PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yolc5uT0uLumkC/QzdVirxCiUWujmaCq4+8aNuvLj3c=;
 b=GVotokIJLeukQtqPUuXqBEj9FQTrytapEoW+TSvyDuy+1ppn8Ieproiqe7IHKgroSjBvwV1zAfiykGZWAyqcWWyih0jq3oPtBH/jg2a16mgOnHvhyjrI6bQU5zpNt4AKIQ7YwltH7wdsaRbVuWBwOD1WP06XDfZ70IYnjvr3uOU4IFdn/gs01GZyb3ULIUmHYpGwNov63ZFiXD/UKK0CHsCGECDWLU4aw4+5ACoqud6y+RYFfuojyFrFgFX+tOR4YIRWg/BQBmewZ0ejE/8wtBklp2B8FZ/rdTlCebhNDeUdfp+rXi4xgFxW+F9L54T9lnKwctqRJhFkNb+RlhVPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yolc5uT0uLumkC/QzdVirxCiUWujmaCq4+8aNuvLj3c=;
 b=YZ579b00L8DCWJibnbELB3+GVhNK8VDx7z0BkRXm8gIMaEYT7jgkaxhEQscG+xbYkkhvC59FP01HB2a8HrG2kK7DcgAovSvGWuzROjduKdyes5sziXCcXugsZZ6C6lMFhdYrzcGwTPz+Oe9Eorc+358BjLIM89pl3eUvG+R38n4=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=fb.com;
Received: from MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12)
 by MN2PR15MB2767.namprd15.prod.outlook.com (2603:10b6:208:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 12:45:31 +0000
Received: from MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7]) by MN2PR15MB2878.namprd15.prod.outlook.com
 ([fe80::38aa:c2b:59bf:1d7%6]) with mapi id 15.20.3477.029; Mon, 26 Oct 2020
 12:45:31 +0000
From:   "Chris Mason" <clm@fb.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix scheduler regression from "sched/fair: Rework
 load_balance()"
Date:   Mon, 26 Oct 2020 08:45:27 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <0014CA62-A632-495A-92B0-4B14C8CA193C@fb.com>
In-Reply-To: <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
References: <DB4481A8-FD4E-4879-9CD2-275ABAFC09CF@fb.com>
 <CAKfTPtBiOFXwV9SkZ=YBw16xoS6LSrKVR4sFX6r2hZPZ9_5-+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [172.101.208.204]
X-ClientProxiedBy: CH2PR19CA0023.namprd19.prod.outlook.com
 (2603:10b6:610:4d::33) To MN2PR15MB2878.namprd15.prod.outlook.com
 (2603:10b6:208:e9::12)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.129] (172.101.208.204) by CH2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:610:4d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 12:45:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b99cf933-f6f9-426b-7595-08d879ad05ab
X-MS-TrafficTypeDiagnostic: MN2PR15MB2767:
X-Microsoft-Antispam-PRVS: <MN2PR15MB276734A23F17BCF7F014D7C6D3190@MN2PR15MB2767.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQVp1bjCAs6Z5MVSHuko37JuMi9O745AEaX2icpOuHX2jqRKtnARwpLYn6l/KWpV76hZC+vX32+JNOP1PTq89jZxS4+W+5We1oM6NzBvG7WQ1pO3R1lju8Rxgi4pABT+6hpAuJqqFNSSnb7MthzCdgE51CG+HmE+DjgBEzTnCoCyEJvE7M3nbBc2Fb8V7DfjbbG3yBOsZ9GXP0oYHmmCjmZMR4RxzGbakD5orWmsqVBzBGBi8MtndcVHxNSNO+cqQX/HMqlIBCOfopb+Jy0MdU3z8fd0Z5wIKznr/TiTDjFfGYkJYbu2fWKOANNPNrk8/L7/D30CaLcDhsqcg1wfKYlC2q5B063LCUzdW/t5WGSgOZHWkZf1R6XV1Jmt7OlT7YE/WUBRxWWAD41BlN2AMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB2878.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(66946007)(66556008)(16576012)(66476007)(86362001)(33656002)(5660300002)(54906003)(4326008)(966005)(956004)(2906002)(186003)(8676002)(36756003)(6486002)(316002)(16526019)(2616005)(52116002)(26005)(53546011)(8936002)(478600001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Pm8MORjbx1YomYVJ+8ewyOY92h++OI7e/7ZRgMPn0mz/PqkhjqN34yCKdalO/dAnVL8n9mf5wFsoRCNGOqutTiIOUpGZqyQcit98fKG79NG1/A+VvzyioZErRoU8RzTr5x9aYnteuEsGPY8dzohLzeGzg1Csi54GboeUZ3zL28p/cNTlOFnVt6jgPAf+n2DyEOEZyTVrKDVAhFRPXiO+aQQejxIhfRUlAk2kFw3g6b8WoGU82qBSSupguZeqODQAQjAPV4pB2Gj7ujtWrjnYjZhPhzN+ci4zrg8iFzCakmigciIpt2L4OwZD4XrX3MGejLDEZ4n3OWXqHVpCDKEqPEXWv4q3Zm0wSpvvaVw1bAIVtA3z1zWSag4znLjf04lnfUHkSxOadXjnYeT9DX20KN9lUboyBITy5PZkzNhTjz5rE+bhTy/BH9ViXf4ssq0dBjb9kjLPl/o8ZfAy3r26ERIytcSN9fs2ct0Nd1it0zIu2vsS8xVhTzH6+kazc2m5OFaw6nS1DjU4UeTS6Y0EBK0fSDeYg2Fc5RO0ojEmD4c8UHi8FnNhaeLqL4b4fNaj1vGcBZfBHPCJijKtEe/PJGy8NWvrh8Jvs+JclFYA3pvvctzTkqhyh8RoWzt/fJrt0OsXVPJY66PUbVeLhYB56w==
X-MS-Exchange-CrossTenant-Network-Message-Id: b99cf933-f6f9-426b-7595-08d879ad05ab
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB2878.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 12:45:30.9498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Co84lPmAU1CRL8JRnr+Ml8BNJrXTiX8ssiaIku/ko1ynY9gRsWhNVryHT4QI3akZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2767
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-26_06:2020-10-26,2020-10-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct 2020, at 4:39, Vincent Guittot wrote:

> Hi Chris
>
> On Sat, 24 Oct 2020 at 01:49, Chris Mason <clm@fb.com> wrote:
>>
>> Hi everyone,
>>
>> We’re validating a new kernel in the fleet, and compared with v5.2,
>
> Which version are you using ?
> several improvements have been added since v5.5 and the rework of 
> load_balance

We’re validating v5.6, but all of the numbers referenced in this patch 
are against v5.9.  I usually try to back port my way to victory on this 
kind of thing, but mainline seems to behave exactly the same as 
0b0695f2b34a wrt this benchmark.

>
>> performance is ~2-3% lower for some of our workloads.  After some
>> digging, Johannes found that our involuntary context switch rate was 
>> ~2x
>> higher, and we were leaving a CPU idle a higher percentage of the 
>> time,
>> even though the workload was trying to saturate the system.
>>
>> We were able to reproduce the problem with schbench, and Johannes
>> bisected down to:
>>
>> commit 0b0695f2b34a4afa3f6e9aa1ff0e5336d8dad912
>> Author: Vincent Guittot <vincent.guittot@linaro.org>
>> Date:   Fri Oct 18 15:26:31 2019 +0200
>>
>>      sched/fair: Rework load_balance()
>>
>> Our working theory is the load balancing changes are leaving 
>> processes
>> behind busy CPUs instead of moving them onto idle ones.  I made a few
>> schbench modifications to make this easier to demonstrate:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mason/schbench.git/
>>
>> My VM has 40 cpus (20 cores, 2 threads per core), and my schbench
>> command line is:
>
> What is the topology ? are they all part of the same LLC ?

We’ve seen the regression on both single socket and dual socket bare 
metal intel systems.  On the VM I reproduced with, I saw similar 
latencies with and without siblings configured into the topology.

-chris
