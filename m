Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE08B27D1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgI2On1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:43:27 -0400
Received: from mail-dm6nam10on2056.outbound.protection.outlook.com ([40.107.93.56]:7265
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728630AbgI2OnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:43:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ5aWf1snPHOO9ZWFgRRDVLhKurPqIKe2zxtbRWLgCI/skhYL+hGBFtzPtBYU0GGgBq4HovbLZJqQP2Atv4xt5rxb0pciftu8zmIzn2VfLP2vVkjfEAA0W5UpzGYL4N3FTWQ3tCFhX9X4Jg7XkiVGy7bUXPI+gJifMU6t+qx/E6sKOIJd4WzV5pj2kmAnjjAnBUUSjU4ZKG5aDdPjrD/jrv7olN9d4MOKFPRri/4CoxKiRgMwEzrvhEqp1M5a9cpIYNXREjP1yU2q1J+YLPrz+QOx6gQ01HhB9fLLX/PItMmUvydB1nb8rap6MJUoiNCqeo/hWxMuBtFYHiBTcn6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WVS/ko1J9y03y6dj5s3FxQeekMEceg0KZmh5c6jxwA=;
 b=D3BtkrPkQ7r7avBlHGiuyLXEb2piZuiMBeAcsUORwTgO4zwjE0ov4QfSss9fomGARG24Gorufgz1Sy6xoE2t8aM2r8yo6ItsziUROsD85HeZ83r3N4VAKqv+0oDL70LEtE4fWt8OsuooBYm8Salah5/3L5Vch+hiE1vabstwsaid0DxcvpJgaF1tbJgOzvvi1gaIKRwfp1q7PjmThaVha2TBQTT+dkr8Kj5PwLkTiuOAtYit7FO/EfedR9lvTu/TFSYqxmhhtoeNezdSR/RdJV+T9yaQp3V5urQ321AZ5XAGi//kNQsWqOzvvKj57IzcuYUxZqZ9BTNOhO6TQ+o7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WVS/ko1J9y03y6dj5s3FxQeekMEceg0KZmh5c6jxwA=;
 b=ouSmD1kZgPlwXpxEYraOjBJO+6E/g0+MQNtED/rmTIP5jJCOpi1d1APJeFo17AqKOmqsD4jA7j2m+452w2B6EievUZyIyZxTc/72Nmx6oD/bp9p8J2Aq1k5rZCt9PwAsGdNp2GwRA9+KbfO0m19bxBuXZchtjdqUh1J/ybUWxzQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1570.namprd12.prod.outlook.com (2603:10b6:405:5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 14:43:22 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 14:43:21 +0000
Subject: Re: [PATCH] rcu,ftrace: Fix ftrace recursion
To:     Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
References: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <459f3c42-4e18-0a71-fd84-122342bdb4fe@amd.com>
Date:   Tue, 29 Sep 2020 09:43:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN2PR01CA0068.prod.exchangelabs.com (2603:10b6:800::36) To
 BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.17.193] (165.204.77.11) by SN2PR01CA0068.prod.exchangelabs.com (2603:10b6:800::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 14:43:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f8eaef3e-ffd8-4f11-aeea-08d864860331
X-MS-TrafficTypeDiagnostic: BN6PR12MB1570:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15701F85CCC5F6D8E4F82E8A87320@BN6PR12MB1570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkLIH5u8MK8OSI5MtXuSGY6eC93hD6dbk+J63vJJ0X2sovlXWJtXdetdoJNUlAyCPS2lc8lqIfAwJzP9mfXOEuYTV17Dd3T0LUpe+cnk9wYty4Ort4WsAYrqp1Gpwx++UcEvzOCmVR1GtFECEptCj0s+gHUAARQis2w9hHWi8CkQrWQlJihhvSPTpFKBWlkHNj2VJ6hgUyAuGhJdyKPWrcJAyM00sARcz7LIKcdtUjwusUT5rMPsJj37Q/BVQpQrNCPTmSVZyZ5q5R1MP3eeFtdeMInARmxDOJn0tGM1XhUIVIfgOeetHoItIyxCCWK+/yPlb9+h8s7kGC+GhGVQJdExRSJnnXJOmqDS+jTvSFAwrIAiOks+RJhSWMnDgCfr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(6486002)(36756003)(8936002)(2906002)(53546011)(5660300002)(52116002)(31696002)(186003)(16526019)(86362001)(4744005)(31686004)(478600001)(26005)(4326008)(2616005)(8676002)(66556008)(66476007)(66946007)(110136005)(316002)(44832011)(956004)(16576012)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /fBOuhUDzky0lGwxNOPQVidJwjB0XBfxJntSCx3NHHakOf5T+gr5sslpCmRuxXw4URKPj9eHxY5V2al/pNDBB3WZqW9SKX4otXqdPupkmt318TyIDz9mSgU1lk1Pe7a39Q82qZXOni4PFg7PLKTw+DJnuOvFl/OXzP6ZuhiljZ9ZO1nPDvyijDVAzXe+iUsbj9ebSETuvSEX8s+zRXk7krVncSp6gouvvC3k+RViZU6UqTjSGrrNQ4Mohk+/CPm7uWEsfc9Of2YT/ZFXhJDFOUwSCpra+lIAoPlBcfu25BTM/6sFom5bctsLvfe9r4Cca0V73GNm7aJOlRkSOp9h4yzqc2cLmCuTuuul4InPhKdSyKwUe21gFAD9Ia4H+Mh0g+lqpOkzkroXSdN8+VFzMimzIXyqr5zQYGPszsFiwqZ38UIhNbAQ2wjBBaSNCHFuFcrqX8RzbhoPwfS+2PxQ7etWH6EUWk/3swlc/csRuFE3FaauPN3XCBROx66UEiISW+5tTeufjOv0sabp8ASTNfyY8lFvr0VGrn2SwHiNxZvx/XaJgbOtal+epkwu44Fb9NWX+VBQNHyd0ygt5qiO5KyQ4z/yuCay5Kvs3/fVPzrUogpX8cMvLb9yhHmhrGjPwIDyzGK6HgcdZrO0YfBiJA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8eaef3e-ffd8-4f11-aeea-08d864860331
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 14:43:21.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emj2L25QtfY2Q+xd4e0L3tqgl1lti8IdsDXMp3bqkTvc06N1tL+c78fdAgC6KmdoF3jqoGKKSoU92zLEOqRXlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1570
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 6:33 AM, Peter Zijlstra wrote:
> 
> Kim reported that perf-ftrace made his box unhappy. It turns out that
> commit:
> 
>   ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
> 
> removed one too many notrace. Probably due to there not being a helpful
> comment.
> 
> Reinstate the notrace and add a comment to avoid loosing it again.
> 
> Fixes: ff5c4f5cad33 ("rcu/tree: Mark the idle relevant functions noinstr")
> Reported-by: Kim Phillips <kim.phillips@amd.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
