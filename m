Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2A4281D74
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJBVKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:10:52 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:54625
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725379AbgJBVKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:10:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYqdEm5WtDeZ5gQjtPkZ6vlsG8jUcrtm/LVGcHhcrGKzWyzArbUiSuh07BYxsLV36IhcIg6WlAuPgE2SFgHc5Zl+I+eOnsR7se4ouXUGHuymdaaRAZ39OceU+RHfwH59rkQ69CoIq/I2QqZulnFdTVCVz7WSnSKDoolO1TL9pzb0L+Iqm1p8wUS9huBnz9dQQ9TW7lcvXw+YELHAn2bLDOXKGcoIki/WjkCPPM472/3qEBRiarNSsMPwTjHw0meW+oUy8DRsjRptH+RCy9DN+vNZZwYj9geI793VqnllgEXofx/UZg7zktkavXobNzrK4IE3dpwgOvHWMjm/sBsQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJKlbxlI+dnCBEXq+owBoVjqBlwbp1OMK7UcxrMomW0=;
 b=VeVReINmXdfMm4lyvsE7c7hFKoA2JteLqd9+J4CHJ365yc8vMuNXt2Giw5OIYnKomCznSCD2fn53OWR6vxiV7TWyXX39oJv5nR93+CuTaHEamhWYzE72R9NWITx0hLZSOkIr72XVVe3N7l/xMQhVKHePyyarJTnBKYjdnYzCSZQFhlRjnZTtoKnmSV/1brUFAYMQTAbkSY/PJVpB74c1HmXc0m5QSt7vk5W+6S0c6d1Ku+CLatCdeMZUFnayroDTXyjxM/UYS4KptZdb3gacOF3mK53+IyS9jKymCdd7AAjGFgekhYj+G3KeYuY+4ITif34HpzwfOprsuZK2jLC4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJKlbxlI+dnCBEXq+owBoVjqBlwbp1OMK7UcxrMomW0=;
 b=eVtPgPvrUKU+x+pUqeU0yDEVHo6am7AKOZmSehf4ZRx2XKRyPgzkCbTUS/8fTVzur1saNusLy8yzCrX5JhJltBthHvejKL1S5GNQLApOnlDBFkO6YPr8PCTOSeLLTo5hl/wIGUngsnFT/mqk2oIN/AErDr3YZcodVxxdQznu8go=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1698.namprd12.prod.outlook.com (2603:10b6:404:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Fri, 2 Oct
 2020 21:10:45 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::3054:612a:b2d7:f46d%6]) with mapi id 15.20.3412.029; Fri, 2 Oct 2020
 21:10:45 +0000
Subject: Re: [PATCH] perf/x86/intel: Fix n_metric for the canceled group
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com
References: <20200930142935.13482-1-kan.liang@linux.intel.com>
 <20201002110258.GV2628@hirez.programming.kicks-ass.net>
 <fd79f565-2b5b-027a-eb46-b251e9cc9f18@linux.intel.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <fc89da87-6070-beda-2437-4089257c55aa@amd.com>
Date:   Fri, 2 Oct 2020 16:10:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <fd79f565-2b5b-027a-eb46-b251e9cc9f18@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM5PR18CA0077.namprd18.prod.outlook.com (2603:10b6:3:3::15)
 To BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.17.193] (165.204.77.11) by DM5PR18CA0077.namprd18.prod.outlook.com (2603:10b6:3:3::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Fri, 2 Oct 2020 21:10:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b1d973a8-6382-466e-c17c-08d86717a06b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1698:
X-Microsoft-Antispam-PRVS: <BN6PR12MB169863C0BA8913C19DD82F4087310@BN6PR12MB1698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5zekpcIKsxn979N6smAbd6BRjIKQZDFBAvEK6myzZhrE/zFf1ye4FvIftvolg6jLZ+7u2uHiGc0HHX0QpUxiNmwss/fjJEQyjfJ7XmK3qNlD8bZa7XlpVikNtuwM4Qv+b8OsDkgy9II7UjD10O677rldXGUI6MmOddt6R5ujOuY5gemlRdfPz7iqXpfaHEBdREvgsFkHfpb63wxhenMJ2nHybzuZrW3Bl+BXm2dHlbfa66VfguyNcPQzvE8nd5ugVA+x6SfABTzsP8qX4bWoegj7dHuHopDY39XBLccefh8KAkeHK3gRP24UjLXog435GoZDB8CWlcDAT1OubELjyhoXx6yUss5HWpAi24eZMtXvYjXlbo76VT7MO7qcU8e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(4326008)(2616005)(66946007)(31696002)(31686004)(5660300002)(66476007)(956004)(316002)(478600001)(66556008)(110136005)(26005)(8936002)(186003)(83380400001)(86362001)(44832011)(8676002)(2906002)(16526019)(36756003)(6486002)(52116002)(53546011)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Fmc1/vm1DOkqV8EuTN2HDYVXM3+M3QvUsJAaVcgS7P3lb5+IjJsoWD7ThiP8P8NIzC5Ed5GJOXgdUjaU4ODlAXH5U3x3qgwN6Tw6w0Rmhy7aGvkk+Xve46iWkmlNxu/OZoTMU6JNNLtPmWhrqJ7kkcHXYTtFb9GTUWRr+tRFUB3IVEdaf/WbQUH0gKAaCXf+Tdd0qdQMUdDHLJxo+JU/p0F3CDIeP2/iSig4cHbam1wId0D0clRGfmhmkySB9BluJTjfybbk0OPyETDSonRRkZHoHkqBgBFRdGrTbzt+LTJlHthVru5uJnqM8B3NyOxGNxHmFoB+TTp5YnaGQDchu7jvsPEOhZXg3YZRuG5BlPIrQxXGMliSrGZsyAkCaDOmvFV9pJ4h8PBbd4t+VD+y+gWWhvDXmDs8iNwVc4xbeJMarxxI6YBr/7fltyec0v4RGRhAEDf85VJAKBUhZC+XiHzxpjvhkJLoxr4pYQ+CYb9rd5t5XduCcaXJXotPQqPWTxJmIlC5tLIJrEZivimFDki9m9efPWwOO9uk54CZS3wyaBZ0z/eCrfkcKfpHPCUsorrwNZeMNRZygxu2neieJQs8+dN+T1TwWmBrz0vsnh85ByJBQ7oiMYrEXmiNSO0sFj77vJPhraajFzcqBebnKQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d973a8-6382-466e-c17c-08d86717a06b
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 21:10:44.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuB4dCW5FzO73WkVUCSbKetLDXpOHT9ohfc3DHx9AKoNv3nw0a74VnWX+izdg9arCLRCQHglRtP7mE1kmeBGOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1698
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/20 8:16 AM, Liang, Kan wrote:
> On 10/2/2020 7:02 AM, Peter Zijlstra wrote:
>> On Wed, Sep 30, 2020 at 07:29:35AM -0700, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> When a group that has TopDown members is failed to be scheduled, any
>>> later TopDown groups will not return valid values.
>>>
>>> Here is an example.
>>>
>>> A background perf that occupies all the GP counters and the fixed
>>> counter 1.
>>>   $perf stat -e "{cycles,cycles,cycles,cycles,cycles,cycles,cycles,
>>>                   cycles,cycles}:D" -a
>>>
>>> A user monitors a TopDown group. It works well, because the fixed
>>> counter 3 and the PERF_METRICS are available.
>>>   $perf stat -x, --topdown -- ./workload
>>>     retiring,bad speculation,frontend bound,backend bound,
>>>     18.0,16.1,40.4,25.5,
>>>
>>> Then the user tries to monitor a group that has TopDown members.
>>> Because of the cycles event, the group is failed to be scheduled.
>>>   $perf stat -x, -e '{slots,topdown-retiring,topdown-be-bound,
>>>                       topdown-fe-bound,topdown-bad-spec,cycles}'
>>>                       -- ./workload
>>>      <not counted>,,slots,0,0.00,,
>>>      <not counted>,,topdown-retiring,0,0.00,,
>>>      <not counted>,,topdown-be-bound,0,0.00,,
>>>      <not counted>,,topdown-fe-bound,0,0.00,,
>>>      <not counted>,,topdown-bad-spec,0,0.00,,
>>>      <not counted>,,cycles,0,0.00,,
>>>
>>> The user tries to monitor a TopDown group again. It doesn't work anymore.
>>>   $perf stat -x, --topdown -- ./workload
>>>
>>>      ,,,,,
>>>
>>> In a txn, cancel_txn() is to truncate the event_list for a canceled
>>> group and update the number of events added in this transaction.
>>> However, the number of TopDown events added in this transaction is not
>>> updated. The kernel will probably fail to add new Topdown events.
>>>
>>> Check if the canceled group has Topdown events. If so, subtract the
>>> TopDown events from n_metric accordingly.
>>>
>>> Fixes: 7b2c05a15d29 ("perf/x86/intel: Generic support for hardware TopDown metrics")
>>> Reported-by: Andi Kleen <ak@linux.intel.com>
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>> ---

>>
>> Urgh, I'd much rather we add n_txn_metric. But also, while looking at
>> this, don't we have the same problem with n_pair ?
>>
>> Something like this perhaps...
>>
> 
> Sure. For the perf metric, the below patch fixes the problem.
> 
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Tested-by: Kim Phillips <kim.phillips@amd.com>

Excerpt from test script:

sudo perf stat -e "{cycles,cycles,cycles,cycles}:D" -a sleep 10 &

# should succeed:
sudo perf stat -e "{fp_ret_sse_avx_ops.all}:D" -a workload

# should fail:
sudo perf stat -e "{fp_ret_sse_avx_ops.all,fp_ret_sse_avx_ops.all,cycles}:D" -a workload

# previously failed, now succeeds with this patch:
sudo perf stat -e "{fp_ret_sse_avx_ops.all}:D" -a workload

Thanks both,

Kim
