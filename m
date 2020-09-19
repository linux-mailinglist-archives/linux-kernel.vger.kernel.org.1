Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB21270EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 16:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgISOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 10:55:40 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:17889
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbgISOzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 10:55:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpvCzpSEuZYBsuRd+6609RtLo/Vy3OYSRYchrOtXId8BssIhEZhnbYQsKIXX2S8+7zNmyVAkYBu4kyABjmeBvdiC2zs/AuL98H8GxtZB0SspF+v+Z3TbqqyWEA92yV3xuSA0LXmuK41ZVw+YBkz8oRufSt4hpJhYpluEIyI5ISB9gOTm69tdyqu7okG5m/SjDK3Cf3iAbipTklwVrc/cgXr8QGvpHPvMWEOajeMC0JKfGMCVIvYjplJE9ZEvNQiTi9C9eKOAqmjtGLQb5/vmjUUrm5L9fhBmuE9QWAuMphKxzTlSBLv1RCsJKoGua9/FOrb99ynkAnjDmztPT8ULjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdrfx1jQfwX799L2S+PfPA0cyJIKmCHN3zVyEco2xRg=;
 b=EKqw9rTI8YlkWjbPsVc9nxZoYurrGZ8O3FxdOP81JieFWPKkCHM4faeVIo6iFZi4YSxVw5D5QEANksR3AkdGwI0shVkXtrTAJAj/CN2xefL0P+qolB535i6wAFjm4wyeGijLoH4BDOX3GjlK68a+U/KorWx6lXjcSgHCrKwVTT9tPnm23lmCH8+Pk3QRYqebj0hDcOtGt3+2ygxYckRbPMyV/Fdu2MjDBUOTJO+BMkvMSesSG7ltzeuffwANFSTTnxuytBMK52/kAtp0DExciBVQ9OKpji9SWrUmunbKdaeJeSGKSWtY/VQR6UKSjrffJ31ANycJaMfJ6inaOl22xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pdrfx1jQfwX799L2S+PfPA0cyJIKmCHN3zVyEco2xRg=;
 b=Ef+EwQjmR9JnkBAhgVJce7wZsZKJ5UGeCaVsmlGPGDLuEh//SZPtqR6LRnU2dN388oCZFPjkwneQ46tXNDhkHPPZi4oCzvKfl946fwyXHya2wu5OqpjNV1LhijK76TNB3vWs2wrN/HxLKmb4loIxXLn5iwxYDZQ59thiwEAVkPA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Sat, 19 Sep
 2020 14:55:35 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::3581:4d13:b613:eb81]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::3581:4d13:b613:eb81%7]) with mapi id 15.20.3391.019; Sat, 19 Sep 2020
 14:55:35 +0000
Subject: Re: [PATCH v2] sched, mm: Optimize current_gfp_context()
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michel Lespinasse <walken@google.com>,
        linux-kernel@vger.kernel.org
References: <20200618212936.9776-1-longman@redhat.com>
 <20200811152921.1d43e34ad7aff928c6c1267f@linux-foundation.org>
 <a5b29e4d-cc9e-a422-e7b4-e68e0dee37c7@windriver.com>
 <c8f3c589-c4c4-f132-8759-24a44cfa73f4@redhat.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <a6b1ea3c-a186-c807-a0af-19c0149f1402@windriver.com>
Date:   Sat, 19 Sep 2020 22:55:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <c8f3c589-c4c4-f132-8759-24a44cfa73f4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HKAPR04CA0004.apcprd04.prod.outlook.com (2603:1096:203:d0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Sat, 19 Sep 2020 14:55:33 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86209909-b0bf-4302-5ccd-08d85cac1067
X-MS-TrafficTypeDiagnostic: BY5PR11MB4226:
X-Microsoft-Antispam-PRVS: <BY5PR11MB422624186AFC6AE9C5A6DD0CE43C0@BY5PR11MB4226.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMd7G+8nuNGfcPswT/fMN9odGMd3ES3w0mXKh41t0zb8w/N4SDZxltUYV654Pvaloxz3F4bGawujYfuLRhLjPB+LOrgpxxPmz/0PY61+TrXd/KrC2moTtbCVgOjYB8LjA1vGPMSUd4BYPGdY1gIYeqOVEsFdrvv6l7lYCeq/Esr6I8KFaqcZEK4vuNp0ftSblClQtcfGCp+eJsrHBNn9Z7bqfYKLt8+s1ONBgihrTP4x0/Fjw7gMALas/Tdb25Ch15GFmMPLVbD+pq9vr2/Rkq6NpPvvcb94zXMDMfqRBPTxF3UyqiZkCyhsKg7ALqNiFTalvnxs+H3Ugkr8k2Nem4zKrXxFX+BLJ0TqXrfOECWHzkuSdFRz5MaiLl4sajnxJRWGn1anISi1v3Yvj7oWkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(366004)(346002)(396003)(376002)(5660300002)(86362001)(956004)(2616005)(16526019)(26005)(52116002)(186003)(6486002)(6916009)(6706004)(53546011)(4326008)(66946007)(66476007)(16576012)(316002)(83380400001)(31686004)(66556008)(8676002)(54906003)(36756003)(6666004)(2906002)(8936002)(31696002)(478600001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Rcnze47QmKYq0t2IZEwUXuEVxx07CGuAz1JV1b3ERtiqMNsf8g9noMhNL4VtrIbDCrrJgPFBkkLVGZjDJdwNiOGqMZ656aDJzO0SLQuQy8UkadBPnt+RiBMDiVKzY7jyZqivSQ/9i94BdG4OHUZlNhHq7JR71fdk5Uw46NJjb7NB1G9a8GiVxBnjRFYusbQvbpGMaXbAxrYZJBLdkCbkAh9vWiyuM1Kxf6u1mvtsYDW66Hm6NIkSuUxUHCQnr/xeKW3Tbzr2V1Q1YAEHR2LfrS9eneZrgAMm3nrngJP9LVx1vLJkpwbVzygvmjHcFroIs88c1jUC7fF0hfpHjuVtzzsVa0zGOeHwtkLtZqbjn15KcEx2iZDJ1qHBC6pXffLAXq9VerWJT6R4PmmmvpHjJhCu+YlBfNIN9cLEuUqPiwHgSPCyKt8n0yvhEjGe/aJtJe7Cbb7yKxqkVzW+OyQOaz39P8ba6fMIkjfdcNC+rcdhOwhERBikLYRuZZBv0owSwKh+5uevYXJgUd/XJi46VuySHW6/cXLCvhmaqS2PhQ/THQRfr7H0JWiQTViTrFeC97ro7mkv9gkp74fjFiIbbgPk0z+2G7qkC9TWgY+ZslLnauUM/VJV6D4AKCmdRxtrE2k/9GteriSuHmFZkRpUbQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86209909-b0bf-4302-5ccd-08d85cac1067
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2020 14:55:35.6042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqcNffNiERkMOsGWydShBs+anmUtj/AprhwpGpDXpOx1XVSkuC2aZQfUFoim2KO2G+pPHeSAuW06Bnc1V+Dq+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/20 11:18 PM, Waiman Long wrote:
> On 9/18/20 2:44 AM, Xu, Yanfei wrote:
>> Hi Waiman,
>>
>> On 8/12/20 6:29 AM, Andrew Morton wrote:
>>> On Thu, 18 Jun 2020 17:29:36 -0400 Waiman Long <longman@redhat.com> 
>>> wrote:
>>>
>>>> The current_gfp_context() converts a number of PF_MEMALLOC_* 
>>>> per-process
>>>> flags into the corresponding GFP_* flags for memory allocation. In
>>>> that function, current->flags is accessed 3 times. That may lead to
>>>> duplicated access of the same memory location.
>>>>
>> I have a puzzle about this comment, what's the meaning about "That may
>> lead to duplicated access of the same memory location". After using
>> variable 'pflags', will it not duplicated access the same memory
>> location?
>> Looking forward to your reply :)
> 
> That condition usually won't happen on a non-debug kernel. However, if 
> certain debugging capability is turned on, access to current will be 
> compiled into a bunch of checks and memory accesses. So if current is 
> used multiple times, the same set of codes will be duplicated the same 
> number of times slowing down the operation and increasing code size. By 
> accessing current once, we avoid this overhead in a debug kernel.
> 
> Cheers,
> Longman
> 
Hah， got it.
Thanks for your detailed explain！

cheers，
Yanfei
