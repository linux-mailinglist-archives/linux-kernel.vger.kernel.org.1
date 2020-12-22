Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC62E0DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgLVR0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:26:37 -0500
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:42241
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727084AbgLVR0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:26:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlEWZBRGI147apzr3cuBsVWG8hMcxR2DhR/QrZM0fVnmUWZpK9SiVYXE2VJ6QKIzOPcojn+vuzbEu92dEUl4ylCYEB2XXdc1m5E94vEzZJX5nHzcHQECe8FW1PEec6UmtlKODDWqHM4Mncc8aWUGtXGeCWcuPjhmpzT+kBcPq61iuKI7hzECj3sFcCMpeRtWxSKh1bwzxrElE+mI0mTWZwyAf5aMKPk8IgefwzA7qRg0Wns71W8FDIjPj+89BZXg4LdOE/5dsC1K0QeuezGHTs0G+a3k1z5PaoqOO1Trcwg8uGoYrIUM2vPMGwH8LVjRr+jOybAXfFtYTGb0h/MNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOvHUum7DmyyA3BNU9bxostE5sc8tCHSnrZ3QrSr+bg=;
 b=XCKukb0xe4DmYdqLkdiuPeAwwhBGuSytzwMrzd2cZbjPx6MjoiIMGxsZ0XgMNYnaJkg5klUcFo4eEAlLwrmx9RDXhqwOv7RMzPpQqwlgKuVv5a9Dv90giJTPrpnt1A6VogSyJnHVH/f4Sm8kpAyX5KiEfzputLgX5DwNNHRv0bHsO0szW6FYJugaBa7QR/KS5dz7/9mB4NZ8n63scuTO/TYd+GR47Qa0iiSq7Cqw9hZU+qCXJ3lbHaPC7DiX76bOq7GLEkV9oVNIy0qPAxfSTIMEeURUPZhh6+c8hrd6C/xi/JTH222TufdlY4AgFiy66gcFycmBzb/u6wjVbPKr8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOvHUum7DmyyA3BNU9bxostE5sc8tCHSnrZ3QrSr+bg=;
 b=n4BEr1sbkowJTv33LCc2Ry7/atcrWgamI5ji9XK2I6giN3YSOF5MBhIiuH2gD5Nkmu3nvXWhB8YkNlABsQbiLzIp8Ewh2a/+aKK5HmCYo2GLeUpBZrC5hq2aipl3CbZJ9KhBc6PqYzj3sp6/adGg/tydtoFQ2pZkjg7HkfdZT4s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17)
 by SN6PR12MB4621.namprd12.prod.outlook.com (2603:10b6:805:e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 22 Dec
 2020 17:25:44 +0000
Received: from SN1PR12MB2495.namprd12.prod.outlook.com
 ([fe80::c9d:1af9:30b:c4ef]) by SN1PR12MB2495.namprd12.prod.outlook.com
 ([fe80::c9d:1af9:30b:c4ef%4]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 17:25:44 +0000
Subject: Re: amd-pmc s2idle driver issues
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Alexander Monakov <amonakov@ispras.ru>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <alpine.LNX.2.20.13.2012202341520.6949@monopod.intra.ispras.ru>
 <MN2PR12MB448821DBD2DAA296FAE29A7AF7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <alpine.LNX.2.20.13.2012221720290.10565@monopod.intra.ispras.ru>
 <MN2PR12MB4488CC1657EAEAB16886A200F7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <alpine.LNX.2.20.13.2012221834180.10565@monopod.intra.ispras.ru>
 <MN2PR12MB44884E97C8F01FA474C74F72F7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Message-ID: <470204a1-fe54-c4d8-5352-059334a65c1d@amd.com>
Date:   Tue, 22 Dec 2020 22:55:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <MN2PR12MB44884E97C8F01FA474C74F72F7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: PN2PR01CA0130.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::15) To SN1PR12MB2495.namprd12.prod.outlook.com
 (2603:10b6:802:32::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.89.180] (165.204.159.242) by PN2PR01CA0130.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Tue, 22 Dec 2020 17:25:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0d9e1c6-a6a2-48e0-3138-08d8a69e9ce9
X-MS-TrafficTypeDiagnostic: SN6PR12MB4621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB46210A5497EB568FE3853CA99ADF0@SN6PR12MB4621.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9K7Fz1JKGfl/YFL4/yMYaugPijmSS4hfIyKRtc+/NUbzUi88O1lky9Kkz7W4BbH4IVWqwtkSKssDva+qVGH5/E4lMKWY9fx4rgbcsBktazasdXRuNgYrARyYVDYpr8FJh/0H6b+FHLubgbM3XA7+he36sN1mqjXF0Eqv8eWVNa3iBcylTaM59a+5gbIExRAN43nZfhXTBGFsOkJQSTuzvOSP38fbB9UaaXAOLgvsqw39nsg3yqbcCDVjIFGK+Ni17mJ2w3lw+WM6v//LcNvr2Vn6gxoYl20Yf13Sm4/uck4a0LojxgDXerWZPpAYISbwXPACjjvLufssqyeaP6RLKOGt2todGS1k41JewLNCsKV9vTyAh3dRjvgzEDJ7PvHOoEh3mVebgXn86Odskrdn814kQ2+SSdNK4z0eQLs996nKXKDbHjjTB/JiQzx9m+uolYNdnWUus9NiQ3Cl0np7ye/aYZLV9fDU1qdWv4WOF3CYhIRHKFKCCgrARBMvVymjA1zigDlYOlsuRkNPgCOJVC9CqVNfA/4Fi+OsLl9EFiyRl2jCM6o4vrysiMGHIu7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(53546011)(86362001)(83380400001)(66556008)(66476007)(66946007)(31696002)(4326008)(8936002)(316002)(16576012)(36756003)(110136005)(54906003)(31686004)(2906002)(52116002)(478600001)(26005)(6486002)(5660300002)(6666004)(966005)(16526019)(186003)(8676002)(2616005)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c2NROFNMN0ZkSWtzVTRFTGEyQnA2NlpzSGNJTWtXMEoxRk02RmVLbW9vNXhW?=
 =?utf-8?B?UmdJMUM5ZTcxVVdWYTJvTEFRSE90SGdUV3NLN0c4VjZBaGZBenRURVdyU3RW?=
 =?utf-8?B?Wk9QV2RhWWd5alkwN0ZjZ2o4OEQwbGRmVzV5Vytxc1RHZlNFNzRtc25pNWp4?=
 =?utf-8?B?WW8wYUVXMjdaVlEwb054dCtiaTZ1S0QrMzZTaGswUi9aejJMU25rRE9MNjl4?=
 =?utf-8?B?UEJzYjBXMGdydnJzdEtWYTk1eS9sUHY0b2lTK2c0RUlxajIzU1RTRXM3QXBv?=
 =?utf-8?B?ZzJaUklMNkRLcWRxMWRhQ2pYd2FnaEpuR2VIWGIvZTNlWmZxa0pOQmFPT3BB?=
 =?utf-8?B?QzRSeCtocldUK0tXYTArcXFVVGg2Z1FOb2xBbml4aTg4R21Gam1SYUtmdmIx?=
 =?utf-8?B?YkVlazJ6SHFhclhXcmttWFFNVGZlUWdYWjRQQ0Q2aHFXelRNYWIrU0RLVXh3?=
 =?utf-8?B?aFp0OTZaK041RWVjWWh4Q2pJZW1WVVhtdzhRZXI3WnpkMGRJVGZISDRJQlpW?=
 =?utf-8?B?b3dzNzZ1dmp1RWYzSzdhY1puUi9rdEswT01GaHp5b1k4MnpDaXhYSjVOMGVQ?=
 =?utf-8?B?Z3ZCUStTUlJnZ3FBSkp4UmczYnIzOEpUdXJRS2QzVjRUZFVTR2dacTVTSUZM?=
 =?utf-8?B?VDhWajJoYndTY053TXRQOElFZHBEZU1yYTU2M2cySmR2WjFPS3p1YnZIcHhT?=
 =?utf-8?B?TnpuODByUHJ4WE9hbGM4S2tDTkZ2NUFyam5od0tkSGxkZzFLcHZNT2xvakN0?=
 =?utf-8?B?T2Q1TVNFcE5ld2hub2Z6U2krYjlpWkx3UVMrcVRqQXdNK3F2ZUdhaEpVYUtk?=
 =?utf-8?B?YXlZWkd2OTB0dTVwV0xJMW94N2ZGckFIeXA4a3VieUhueHRVZ2lhUkNsV0NM?=
 =?utf-8?B?anFtRkwxYmE0N3YzU3BvN1ZiYmZaNXBSTDRMaGtRYnFORFhRUDRHdW96dlNW?=
 =?utf-8?B?UDNCQ2htZmhsM09VWSt6V3JjQ0dlNStaNk9tWnh2N2ZWelFPNGgveWhqeG5m?=
 =?utf-8?B?R240bXNzeXgrY2ZSUHVNaVFmejVwSk5aZDNTSGlBcDVQSWNiMHFaV1NqblJP?=
 =?utf-8?B?ZlZmaHkwSFcvZnBONzRESFZVeHVGZ2lRclBVd0JIcERWb0Z6RFJpQkwyTCtt?=
 =?utf-8?B?b0QwLzBVbUJtY0t5WUVDZmIvN1JLYnNFMWE4VVFGUFV1Q2wvK1pCL2svMHpT?=
 =?utf-8?B?Um9RVkhBYm1pajJZMlUxdjJWd21oRERBM2ZWMDM0YkRSZFJpZ2NFbW1KYTlz?=
 =?utf-8?B?QjFxdngrMFZvYWdVZEZtOGpRV2VWZXd2NWVTM0tHWVNkdTFtSWlJVTVCSkdh?=
 =?utf-8?Q?5XyY3z1YskzT3YNuMIUgoQRphb4QzvjBaV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 17:25:43.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d9e1c6-a6a2-48e0-3138-08d8a69e9ce9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDuhw9eTaaZDm9Kt3JccG/Fg4UvMGeML3StO1Pb2TmbFaJlBp7eTHfpVrubpzCVoS37U0EEou3qudIMryjjm2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4621
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2020 10:14 PM, Deucher, Alexander wrote:
> [AMD Public Use]
> 
>> -----Original Message-----
>> From: Alexander Monakov <amonakov@ispras.ru>
>> Sent: Tuesday, December 22, 2020 10:57 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: platform-driver-x86@vger.kernel.org; S-k, Shyam-sundar <Shyam-
>> sundar.S-k@amd.com>; Hans de Goede <hdegoede@redhat.com>; linux-
>> kernel@vger.kernel.org
>> Subject: RE: amd-pmc s2idle driver issues
>>
>> On Tue, 22 Dec 2020, Deucher, Alexander wrote:
>>
>>>> Yes. Out-of-the-box it's a "modern standby" laptop. There's a "hidden"
>>>> bios menu with extra settings that apparently allows to select legacy S3.
>>>> I did not change it, so I'm testing the "modern" mode.
>>>>
>>>> Note that this driver fetches SMU version from MMIO, which looks odd
>>>> to
>>>> me:
>>>> elsewhere (i.e. in the amdgpu driver) SMU version is retrieved by
>>>> issuing the corresponding SMU command, as far as I can tell.
>>>
>>> There are multiple interfaces to the SMU. It's shared by the entire
>>> SoC on APUs.
>>
>> Just pointing that out because evidently this interface does not work on this
>> laptop, producing all-ones instead of something resembling a version
>> number.
>>
>> Which APU generations does this driver support? If it does not support
>> Renoir
>> (yet?) it should be documented in the Kconfig text. Is Renoir support related
>> to missing AMD0005 ACPI id binding, and borked version number info?
> 
> The current code supports both Raven/Picasso and Renoir parts. At least some Renoir parts are supported as that is what we are mainly testing now.  I'm not sure why some boards have AMDI0005 vs AMD0005. We'll have to check with the sbios or windows teams.
> 

I think newer sbios'es have the AMDI0005 for Renior also. So, I am guessing you might be running an older BIOS. This driver is supposed to work for all generations of RYZEN starting from Picasso (provided you the right bios which supports modern standby).

You can keep an eye if some of the devices are not entering the lowest device state if your kernel is built with this patch: 
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=146f1ed852a87b802ed6e71c31e189c64871383c

Also, on my reference platform I see the debugfs giving some valid information. Since you have a sbios with AMD0005, I cannot comment much on it.

Thanks,
Shyam
