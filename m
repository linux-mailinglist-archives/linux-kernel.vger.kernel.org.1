Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979822CA5D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbgLAOhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:37:01 -0500
Received: from mail-co1nam11on2045.outbound.protection.outlook.com ([40.107.220.45]:28257
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729168AbgLAOhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:37:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+3DIy1X7IlbQv40ogvMxhYtH2Ut+ZX32aXMhAErQHk9LJqgKtraoiXknL+FsyCXviFBvsdNOEgehXMWjFhybAcgv0NwBZ7jE2Y+XTdKbz8wojiB1HaLT2tFThbuYdmB7zL2qLoB9Ma125odXwAnh0EhGG1clXRkQs5rv7bfOlTgLBntxX2T/D/1c/u5QH5hRz2RIc0AJ74N37Al8Ha+Vld3ulRLWxFonkRa3iENx7gtdQygPODUKtDLUxKqJjHhZihXpZZTqfL+5pvRMUmsNTE6a8VE6R2jrZWvosmW8+IE7MGl89BP+FDm/X2FY9aH+HI9QtKeytkB4xEKoGsGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gaj80RwgwDF3L4YMNscxHp9PwoVi4O58hPPWW6xXU4U=;
 b=VTPAmk8eTPOiWnLOWHZm8XrLqgXbFMlpycFXPYhvmO+jMSXBrXcLgECKZVBNkKOM0yal2qkqVQuKW9D3CsEPhd8cTTVNgV8S/Pg7DPRa5jaP2SIg4XgxhrLXxwU2znMm0Qrb56fm6YXNIvI/HWh4nNxV4nTmSX/hMRvbRUjZuJQbY+VqD+jPzfOx6ZL2ve1mWnzKIq8d+ZKBhuiJRlcZPK9uTolnvrjoL+ABD9tvm8vVGIMA8h8kkQYfjHlsXdWYySv2NboEfhe1OjM+Ee5D2ffEuf4/sAEShyeAAFA+B1ErjA55yEgCb/DzV/Zh9ZOEgDQgj7hi1q2vQV5i+1MmmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gaj80RwgwDF3L4YMNscxHp9PwoVi4O58hPPWW6xXU4U=;
 b=1VvHJJxd38Amc+2FGWT+I4bz5g2XjJTYfhLg63QitxL8/sEJthuyCRgsM4ODDIA4AXDVM7z67aZkOvBapAAjEvGgufZ1vc3UKc3ebKvTwiCGt6MvGjWKzoENaRzIoIIZhpdcQVNKeBZ8wT1/60QyE/hTTfHmdYO6CgIv4twuUto=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.23; Tue, 1 Dec 2020 14:36:08 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 14:36:08 +0000
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
To:     Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Lauren=c8=9biu_Nicola?= <lnicola@dend.ro>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20201126074734.12664-1-lnicola@dend.ro>
 <875z5rk68z.fsf@nanos.tec.linutronix.de>
 <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
 <87lfeiiy10.fsf@nanos.tec.linutronix.de>
 <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com>
 <87tut6h10u.fsf@nanos.tec.linutronix.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <dd42cc78-bef0-907c-ffa5-e8b8f29ef363@amd.com>
Date:   Tue, 1 Dec 2020 08:36:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87tut6h10u.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: DM5PR12CA0021.namprd12.prod.outlook.com (2603:10b6:4:1::31)
 To DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM5PR12CA0021.namprd12.prod.outlook.com (2603:10b6:4:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend Transport; Tue, 1 Dec 2020 14:36:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab2bba0d-14fa-4e64-4505-08d8960670bd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:
X-Microsoft-Antispam-PRVS: <DM6PR12MB405850FBBD91FCA92FE2E2F9ECF40@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RRjx6MvcnvvJskcdQspMMvXMdwoxcghwiOTOZpVbKKcTscEuxw/A7ux0UYdiluak0SJ1A23zapY4tZgOCiNBFF7LNMgdxfUGyKvfi816cX8arqH898wC/HQHh/GzUdhT7XwRalosHBVy1UyICYJ33t0HCWaA/6hm2vzZ1RLP5z9VJPQB6XK5QiBXBqqf9HTg6lQUWc9zsZMflqGcngXyCXdk55uuGMq/gVL7qgfkTNaIdFmtg+UzKEOeItweKgvl9nOn6ggdDyG0DiHLT5xaRPYsV+m2zXZRTwhDvDgKFiDSb4uR93kmKqpbHLrRPEOwLmTbq2WBpzV9NMKFliZGAnrYRPHOOeLDp5A7rSWs96ig90rcmYxgR7/xs9AcGxJT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(8936002)(31696002)(26005)(16576012)(110136005)(86362001)(31686004)(316002)(36756003)(4326008)(6486002)(66946007)(66476007)(5660300002)(83380400001)(8676002)(66556008)(478600001)(52116002)(2616005)(956004)(53546011)(16526019)(186003)(66574015)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aEh3TjNCd28ydjBieHVHMno5RkR1dk9kekNIMnZ6WUZLZHNsYjVQTVF6UzRp?=
 =?utf-8?B?Sk1peGVnU29hOWw4ejFPNUk4MjVib0xtenZDZXJBZXkzSXBKRUpnYjkrZzZi?=
 =?utf-8?B?d1VMbTMwRVlMUVhGMzVkdVkvbVEwNFJaNTZ0Z3FTVGN6ZVpmY3F4QytrZk8x?=
 =?utf-8?B?cjNoWTdNZEFZZXZJeVhSc3k1NGZ4YW5PK3RqazRsRDQvdkd1NzdWdXY4RE8z?=
 =?utf-8?B?OWFwbC9ocFl0WHhJa0xKSFY4UWlEa3BWNXdiMHhwNmJKcGd1aUNXOUkyTmM5?=
 =?utf-8?B?aURsMWhRbVJMU2pnK1dCek1ZcTZLU2RoUlRkbm5SSkhtd3E0eEtVRllsWHUr?=
 =?utf-8?B?M1BhWEw2SnRGdjFEMFRYQktTZnErN2M1UUhPZm9hNVdUbHdzeXloVmY3Nmxa?=
 =?utf-8?B?aHEyRUgvU01DZXhNQU1LNFllOUVXV3gwWnMrbjBKS3BKdkM3ZjdubVBpN1px?=
 =?utf-8?B?VERHNUExN3hGVk9EQWVJdTBSM0h2Y042M2hrUDFSYkVoUTY3RmJJeWwzZmRP?=
 =?utf-8?B?NDRKU1Ftc3czMWpxbDJNVDN0MEhmMDZGcUROdlJ1OTY5S1YwczgyZkYvT2NL?=
 =?utf-8?B?RnZWdS9nL1VQUlRsTzBhYnZON0VMbXU0bWVNcnp2aUtwTXNIdmlmRE1iZ1FC?=
 =?utf-8?B?d2E2dnd2bm1OeXRGYTh4Tllyc01WdDZJL1UzNFNlc3J5ZFIxRkxZejZJMVNF?=
 =?utf-8?B?T3RXTjBxQVJZcjI5RjZtVngzWDZQL2tLclFVaWZxcnBnTFlnVklONitFTngz?=
 =?utf-8?B?Tzd5OGpLYUtGcS8yN05lTzlaYTVrS2hLUk1ncndzQjFmR0FHTng3ZTZncG11?=
 =?utf-8?B?WWdScytpUGUvWVM2ZEdib1BXU3dnTTZsOHgrZ1poUG9yY2tJNTRXN3ZvMFhJ?=
 =?utf-8?B?SnBvLzJLZ2UwOTJRcXBGd0tyaDRMWjlHTkFta0lnd2ZOUzF4YnlXR3lzdElk?=
 =?utf-8?B?VE4xWlJuMmI5dFZhMEZXZDkrWFE5ci95NE1DM0c0N3FiRmFCNkRYQS9adFhp?=
 =?utf-8?B?ZkZxNThwVWVOQUR4Z3QyUlZVamxqUXlicFcyeWVkM3FBSzlWZE1SOXJUVTAr?=
 =?utf-8?B?NVhtMU93NjNkUVFYNUQwdGw1RGdrRkFRSk1SV3pFTTJyNGN0K1NhTHR5YXVC?=
 =?utf-8?B?V3duRmtMREVCU09jQy80NTJlbXF4c29XeTNNTys3N0o4NVZGMDdJeGtCSlNa?=
 =?utf-8?B?bGJjTHRZdi8wbVd2RDNrWWVrbGJQRGhSUDlranVqSnhTRmdpcE1UYkhQOXRs?=
 =?utf-8?B?UzhKMTVrdEd1bmt2R0RsbjhRTFB2eEpwc3Erd0NSSytwZmduQmJMa0ZKd1Z0?=
 =?utf-8?Q?wFGIIqByw7sNkzJ/SxUE6NvzMl8szbbEoy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2bba0d-14fa-4e64-4505-08d8960670bd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 14:36:08.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rbQ75Pmva8XUXuHgREcsIIlNkEtdoYZtR/T7YxY2CAevG7/kVZGI3477YOU/oJg4Q7Le8NVubY+bH7H5QYi1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/20 5:34 PM, Thomas Gleixner wrote:
> On Mon, Nov 30 2020 at 19:22, Laurențiu Nicola wrote:
>> On Mon, Nov 30, 2020, at 18:56, Thomas Gleixner wrote:
>>>> That's right, sorry. It still boots, but it's no longer "quiet",
>>>> that's what I meant.
>>>
>>> Right, but surpressing that is not a solution.
>>
>> I'm just downgrading it from "emergency" to "error". It will still be
>> displayed for most users snd anyone looking in dmesg. But I'm unlikely
>> to convince my motherboard manufacturer to fix this in the BIOS, and
>> the errors are basically unactionable and uninformative (unlike say
>> "can't set up page mappings" or "your CPU might be on fire" which
>> would really imply a crash soon).
> 
> The point is that for some cases this can result in a non working
> machine which just hangs and if it's below the usual loglevel cutoff,
> then it's not visible, which is more annoying than a non-quiet boot if
> you're affected.
> 
> We are looking into a way to mitigate that AMD wreckage, but so far we
> don't even know where exactly this comes from. The reason why we are
> pretty sure that it is a BIOS/Firmware issue is that some people
> reported it to be gone after a BIOS update and quite some machines do
> not have this issue at all.

Thomas has reported this to me previously and I have reported it to our
BIOS team. That previously reported problem has been fixed in BIOS, but
I'm not sure at what AGESA level the fix will be rolled out.

@Laurențiu, what is the exact model of the processor you are running?

Thanks,
Tom

> 
> Just for completeness sake. Can you provide the line in /proc/interrupts
> for irq 7 on that machine?
> 
> Thanks,
> 
>         tglx
> 
