Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604222D382B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgLIBP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:15:58 -0500
Received: from mail-eopbgr760049.outbound.protection.outlook.com ([40.107.76.49]:65164
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbgLIBP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:15:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM6uoBgVIeqpr0EUzAgg/b4whdXGj+RO3KId+QvvrOfb3roGGf5tVSGV0Vjy/s6DL/QdZkSU2tgpvPuIRvUCTIMmORuDrdGJEPLfEzao4c2PZrycbPq0GtxgPl68dPLynXwZ7pZDNsVbGuQj7X+1Q67ltkk7KojepwLyxrV8H6W0hdoPCmdeZw3kMNAztvQl3rapNyMm5SgLAfEefj1LvsiX1sRvYD+OI9ef0BelirgWzVR1Jo8IKigAegmvglbH84ypT3ZEfsRtkerMSt60pXl/voDJavZpIAw8Ws7EknIoFWrU73Hou36/aUq4o6hOYDePFbK7gkC92MQDFy7KwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVObYYsyjj+cFmsjKD9DZIvxQ+ZFGP5/3XMVod8VKL0=;
 b=l8Fxk8Zg1ne7B9gSfea5afSvpYPGdad3UkShW2Wt6KnAVcfE+1hG7nW3SXUmc216McGNh1alZl+9BJ6eVajSyDlUHFifc8kQOIN78/oWJIzUC+HL2QO5naGLbxerlNsrkOPoHDRuCBfLWHERzUFJ6UOIAuzotwiyo/2Bg5fD1yloT4g3MRmqBlsixVz/4WfGTF/EmdhUKsoE3KAtxWykE58shASe/QAmSu2e1qUBNEGtVPrLMcEphAlgDnA7JoB8jDc7puXs88Ygs7kRB9xt1rcH7JdiHkXhiejijBTfKI2siSTUGtxbMBs8lyFnvCii2Xq85XyF/x+xHJG+J0A7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVObYYsyjj+cFmsjKD9DZIvxQ+ZFGP5/3XMVod8VKL0=;
 b=eFQvgErvbKVhsheYyvS2POeqe0WZ0ny9/EBlpGZ/1sniGqsnpnCfC3ZIgV9YNV9W5OyA+iWW4GpJzg6YfYF3DdtJOtMHh+Z2WA+n7r8qK4gi1nnrqzG7PNLYumFCYpmytHvFS4D2AlwQpEQPuHZuMXuKP2gOaWsps7i2TesE8Rw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1527.namprd11.prod.outlook.com (2603:10b6:910:c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Wed, 9 Dec
 2020 01:15:14 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::501b:362c:9295:dad0]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::501b:362c:9295:dad0%5]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 01:15:14 +0000
Subject: Re: [PATCH] clk: zynqmp: enable COMMON_CLK_ZYNQMP for ARCH_ZYNQMP
 automatically
To:     Michal Simek <michal.simek@xilinx.com>, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201208123508.998073-1-quanyang.wang@windriver.com>
 <0a0d16a7-0d49-3a89-76a1-141758b138e7@xilinx.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <d41c7f60-c9ea-f37b-65ed-4c9b4f5703a0@windriver.com>
Date:   Wed, 9 Dec 2020 09:14:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <0a0d16a7-0d49-3a89-76a1-141758b138e7@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 01:15:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80aa6f90-a681-4fc3-bec1-08d89bdfe238
X-MS-TrafficTypeDiagnostic: CY4PR11MB1527:
X-Microsoft-Antispam-PRVS: <CY4PR11MB152716E7D4D5C8D4DC951CDFF0CC0@CY4PR11MB1527.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lfWs336yo+Ok+nIIrc4qruKZwOeDD2njURCRxuDjK3s0BfgD9Im2M0lM+H9wW3UMo/CFahzgVAyLtDuRdnAHvK89LRsRxTI6XDWDXZrl7wAojmdk/zxzdUdOacQ/YmmmySP0OB3WP+w4tGs31nHGyzCHgmFc9IfG8lh/3cWGYEy3i6bhta0+y5oAfgkB6kfogp7IYDx2nYf1/48oyIq2+b6kx2EWY4WfNdFGvaO9rEywaAdogTW6kdU9TVURRBUMndtAWKT6583eps3+Rh7hkQK5QpNaYwkK+QwlxPgp90H0ryaVs8YQ8Ful2s8nq20rpQgN5tQG8LsLf9LbEeoqqr0bLr8DHqgY+NMPnB7n54AGkS5pRRb6FUL7aDbTYMwgVtbBtsvfFPxR7fOOXQ8c5ZP78leaW13mhzXTXm3X12oDToXkmWnsGjyB4wTGcPImRkVFJ5lw5DcjtiefAjrg6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(53546011)(66556008)(86362001)(83380400001)(16576012)(66476007)(6666004)(31686004)(508600001)(6486002)(66946007)(2906002)(8676002)(34490700003)(52116002)(4326008)(8936002)(2616005)(36756003)(956004)(31696002)(186003)(26005)(6706004)(16526019)(5660300002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c0hrbnBDK0o2aXVrdjZZZXY1RjlxMmNJWGs0aHJYUG5RL2NrbGpsNFVPYlh3?=
 =?utf-8?B?TDZBWmNSQ05NZk5mM25MM0dNKzBOZGwxU1dGVEJDRE1BUzhiQnhFc3lsM2dW?=
 =?utf-8?B?UUdoWjUrcjZWdVJPTlhrSHVZRTdpY3JLWjZpSXpKSTZ3WXIrRU13WWFoZjJ6?=
 =?utf-8?B?c3JvSVJlRVR5VmRqaHNXY1dxdXQ2b055cXlNdEJhdkpTT2hQeTBDdGk5dVQz?=
 =?utf-8?B?K2VvMk04YzBIdXEwcWU4eW1ObTNRM3RIdi9IWHJkc3RZTHZhbU9HSFVTYkJu?=
 =?utf-8?B?ZmJSVHQvVWxlcUxxQldmckhjRE85Z2YzWEp5cmwvVjhpK1NXbldJZ2pHVWNr?=
 =?utf-8?B?NmlXR28vSStUWXhObmwwWlEzb3ZYaG5pWnRjSVBVOFZMRFdINW9QZUs0eDZu?=
 =?utf-8?B?ZHlIS3F1c2ZVNWxOSlpmVkJRMXhnS1FJdUVNRmFYdHM1SjJlaExPY1RQb2lN?=
 =?utf-8?B?d0ROYWh2SC9MSE04SW1rSGxrd0hYTjRVbXBOUDRjYjFndkFoNktMTEtVcmM3?=
 =?utf-8?B?bzJnWmhsbHp0MGFIM2pQSHhrT28wL04zdTFuUnMrMXUwVFgrdlQwazQvVkNv?=
 =?utf-8?B?Q2cxeGVpb0Y2RnZRcFFqMUJqRjVoNnlPSXpBZENLUWZaL3lGOEg3SENUU3FB?=
 =?utf-8?B?RUNXUDNuWnZYMHAwaEYwbmptdkN4RDljNW1jMVBkUnpHOGVwanFsNlAwSWFq?=
 =?utf-8?B?VnMrTTdCQ2tsKzgvalNnT0VoU2hhRmp6M0lVSGNyaHpSMU1xOVZhcVFnQzVl?=
 =?utf-8?B?NTFZb1RsbXRkczlQQjEwTWt0ZHVBTDh3TUdSVGs4dmFjdjBxM1FicGNtdlJ3?=
 =?utf-8?B?c2NBb0p2cFg1ZWl1azVqaE95WjBielFkL3QvTlkxU2t5a1dwR1N6V0tDYnhk?=
 =?utf-8?B?NXl2VkoySTlhN2FsYXhUMHlmOXdRYlpaaEtuTlM4K2JET2YwMkNiRHZuSnZE?=
 =?utf-8?B?V1FNWStVVmlqSkRENUdDZ0V4NTBNem9ZUThQdHNFYnhreWl2TFVDT28yeVYr?=
 =?utf-8?B?V2JRUldKL0RUR1JPRk1uQlNzMldHeHQ4ZGJ6d0NyYmMvN2hnZThtSUxxd1Rp?=
 =?utf-8?B?SUZvV3huV0pPN1A1eStFTkh5M2NwRmFWSDBCYWJIc2FwR3kvc25pQzlVYTda?=
 =?utf-8?B?ZC9aMExZMUhmQWkvVi9qcGJ1NTZsUVd0ak9zYlhYRW9TYzNpeVF0Ykw3QjZV?=
 =?utf-8?B?QWxFYlpaYytBTXBOUFEyeHlNQitmTmJ6VUZrVEtiSUlDKzNBQTdMZVZnSFY0?=
 =?utf-8?B?cllTMGtpaFFGWGxjZjdiWERROE9XTkZsSk14NHJ6RTB4cmJnVlE2bEtWdUJG?=
 =?utf-8?Q?4i1megBjOKmKE=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 01:15:14.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aa6f90-a681-4fc3-bec1-08d89bdfe238
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvwpGvdzUVDg4FjhEoage8uDVIBDCYe+1ZS8yb74cyYt72bzgwu1gYvUR+g8wGkNOrBbSmm62GaTbKkrNsmtoUMSLzWaPVLxheob6pVJnNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1527
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 12/8/20 8:42 PM, Michal Simek wrote:
> Hi,
>
> On 08. 12. 20 13:35, quanyang.wang@windriver.com wrote:
>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>
>> The Zynqmp Ultrascale clock controller generates clocks for peripherals,
>> so we need to enable it when ARCH_ZYNQMP is selected.
>>
>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>> ---
>>   drivers/clk/zynqmp/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
>> index 17086059be8b..a8aa58bbb790 100644
>> --- a/drivers/clk/zynqmp/Kconfig
>> +++ b/drivers/clk/zynqmp/Kconfig
>> @@ -4,6 +4,7 @@ config COMMON_CLK_ZYNQMP
>>   	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
>>   	depends on ARCH_ZYNQMP || COMPILE_TEST
>>   	depends on ZYNQMP_FIRMWARE
>> +	default ARCH_ZYNQMP
> This is not right. If you look 2 lines above.
>
>>   	help
>>   	  Support for the Zynqmp Ultrascale clock controller.
>>   	  It has a dependency on the PMU firmware.
>>
> And we were talking about enabling this driver in defconfig. Not via
> Kconfig. This fragment was designed in a way that this clock controller
> doesn't need to be used. It is our default but if you want to use for
> example fixed clock you also can.
> This enables space for being able to use for example different firmware.

Thanks for your reply. I will enable this driver in defconfig.

Best Regards

Quanyang

>
> Thanks,
> Michal
