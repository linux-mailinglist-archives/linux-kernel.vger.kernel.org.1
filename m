Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF12CA94A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLARGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:06:12 -0500
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:63550
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726485AbgLARGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:06:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqunXItgvDCdEW3R0L2+yxPP5JXAsOJHfDnG/7W2ScZEGpq/8qFRJKG5YYSqDoeI2wgmmtGJQFIntB0SjOG3RV8nSbEPdPvI2IITKsxsHq7pqrxNOSlC98R/5TP6A7+T4EiqRTvfS3urhqmjMuXVBdWZpqrpNB8Li6rbY+mUq5AVx32if+qWLw2J8rZd3Zj8CJiObc/a426AAr1SaGpYXXCn/1GDcjw0oFlrTCGZU8ncR3le+IeCyNhncRYk3A1c/WHMDtkFc/PzB5uOK9TftJfUH2VcJKZMaiv30OK9sCl6HqFhG/ZcKK6rLQsNt25L48n4skWuGV2jqtpLhuB4Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQE693Mjdt2G3nhY5Tob80QYh0Gny3LrjJpuUTPVa5U=;
 b=d85wxqS7+GQnRmWzDTqJ2DYkmOB8NLY10lCE5SpuwKOqHz9cG+2QrPJ8zPktwlMNcwEHThkrwE4lGWsN3ZMfRzf2n/4EshEtjee4BVPOWwqDrCQSpGpInrjkWpWg3XZbHkmwfT0OC8sd9Fok13EqayHKbDk7uMU8ZneYOzF4lQXDH1TI6UKNuyd+dLKdZ2fmpsxjKYY3vcbK1SBxLlsVy4hjJDxqGqLJEDSvQhJmOPNG51sss59u4IH36t0zsUpdCgHrAU3TIyHsnJDFYYny/2guI0uJR4L3XkZvG/ZyTTf5m+rHvmSBVsTSBUqIZ/dDa6XD0aiCJasbgHMFWaoHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQE693Mjdt2G3nhY5Tob80QYh0Gny3LrjJpuUTPVa5U=;
 b=PMFHrUjoHbnb0jKP6Z7U9iN8vBVSqFG/Ck65CF8oXFZJ8L3e5DwphVCqQsO1oM4iTKc1pZQlbACtG/Usoel4NuL0/5fD+yyqvoOAZoI9V9Jys3pZ3k0blJnBdYwyZAvQ9yiKIooUe6hfoILIbslIr1t3UgTAMkmVTzdwUz+2e8A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB2826.namprd12.prod.outlook.com (2603:10b6:5:76::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Tue, 1 Dec 2020 17:05:19 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::d95e:b9d:1d6a:e845%12]) with mapi id 15.20.3611.025; Tue, 1 Dec 2020
 17:05:19 +0000
Subject: Re: [PATCH] x86/irq: Lower unhandled irq error severity
To:     =?UTF-8?Q?Lauren=c8=9biu_Nicola?= <lnicola@dend.ro>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@kernel.org, bp@alien8.de, x86@kernel.org, trivial@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20201126074734.12664-1-lnicola@dend.ro>
 <875z5rk68z.fsf@nanos.tec.linutronix.de>
 <ea40c3e8-0be1-4783-ba1e-86c96cf8e4af@www.fastmail.com>
 <87lfeiiy10.fsf@nanos.tec.linutronix.de>
 <96085c8a-b144-4fd3-b1fb-45763b5b64a4@www.fastmail.com>
 <87tut6h10u.fsf@nanos.tec.linutronix.de>
 <dd42cc78-bef0-907c-ffa5-e8b8f29ef363@amd.com>
 <66fba38b-73a9-4596-83ee-e0ec9a4ffffa@www.fastmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <02c7b204-239d-8940-e022-8337be4a0cd5@amd.com>
Date:   Tue, 1 Dec 2020 11:05:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <66fba38b-73a9-4596-83ee-e0ec9a4ffffa@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0701CA0044.namprd07.prod.outlook.com
 (2603:10b6:803:2d::17) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN4PR0701CA0044.namprd07.prod.outlook.com (2603:10b6:803:2d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 1 Dec 2020 17:05:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 18162f2e-7700-4958-2a5d-08d8961b4819
X-MS-TrafficTypeDiagnostic: DM6PR12MB2826:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28261E7A213CF9A4DEB4DB2AECF40@DM6PR12MB2826.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNFH7tlXbWc/MLb9NpfIamx/jJJMHUqIqAYit1ctg4/bfm1Z8HOYqN3/J86B+pNvpAEdCeMIEmmuCeLjo7IPQqltYTCKRF4Rx53qlqOZbCjBYsw9BqRRRtEg9iy9yUlkQ2Qtl1HtmBv5SJDSy4lvQC65PXIjtDk1pSLyrNm3Y+Yx5Kzm6xx8y8tVjUCDJNIRpkSO7awwHXamHtb+1n0Clgoylr2XXIHhu4xaZWWHTK2wSrQVzmK3taYeZBWjp4yZlFDyTfjzALtIZB1LHtKOQssLun59GGcCGwlJe204GqmlZswOLj59WrCyfW970LAaq/lGfUhz6DekY/rCsdiDUzfVTA0BaIa+EYi8QvXUEgikGyS0afnqTEcPNgNv6I/X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(31696002)(6486002)(110136005)(2906002)(316002)(16576012)(31686004)(36756003)(956004)(2616005)(86362001)(8936002)(66574015)(66946007)(66556008)(8676002)(478600001)(4326008)(4744005)(66476007)(16526019)(52116002)(186003)(53546011)(5660300002)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Wml4L1g4a0RIdjY5YXE2S01WdWpDbGZ2QkxIaTNWOU9IT0U1d09WODRlTnky?=
 =?utf-8?B?K0hFTmpUL09TelBVR2lFaWhQZThOMWFxbGNRMGt3aW9xQnRkUGNhdXp6bEMx?=
 =?utf-8?B?SGV1VnFLdGs3ejRVdTVTNHlOYkhBenFXbjZVZEpoVWEyeXpkSnFDa0FCQjV4?=
 =?utf-8?B?eGw5Vi9Mb2FMS1dPQWh0TS8yWjlYVUp1NHR1TVI3dEM1RWdKb1lRS0ZXVnJY?=
 =?utf-8?B?SjVZZTNBa0FnT0w2QkdDY3RFeGtlSkVKZ3hLUzRWdUVUTkM4bzFmR0tEN3Ix?=
 =?utf-8?B?NzFCaGZ5T2NVVUFJL0M4ak1zVDk4ODZ4eUNFejkyVG9xL1VtRFptNWNHQWUz?=
 =?utf-8?B?ckc1S3pwRmU2WmZtRVhBTitVaEdCVHBnTDMyRldESUkrSlk1SXVDWkpYN3A2?=
 =?utf-8?B?RnprM1VmeTcvWEZmZWlOdXN6bi9nMFNEQTVZY3RRNXl4WXlsMGFBb25IT29x?=
 =?utf-8?B?ZStkdHAxSnBGZnFhc3p4aHlYUGdqNm13QlpOMTlUUHRRTGo3bTJLVnV3WTNu?=
 =?utf-8?B?MHh6UXRURE1TWnNNM0owLzlLZkJKZU5ubFJEeEIxekd4Y3RVOFRlM3lKTzNP?=
 =?utf-8?B?NlRUZmlSamU4UU9ZRWV1dlJqU1plSnF2RWdtdU9LeEpFOVJLc1V6YkhDM25m?=
 =?utf-8?B?dzhNN05VcmdSN2NOUENPZC94TnAyVXl2cWVRZHZkbWYyL0t1SE9RWFdIN3VQ?=
 =?utf-8?B?cE1LQjBhRGtyQVFFNkVxaFp6WkRGdHVVYlo5dHBya05VOGRWcjZXQjBMTXln?=
 =?utf-8?B?MnltcUEwMDJIeE9QcTVqUERUYkdnQ2dDZmFTN2sxeU9MclhCOTRUVjdvQXBV?=
 =?utf-8?B?Z0h2VUwzL2VXYWlTREhVS2owTEIzaVRSU0Z2UzdhblRXZzRaaGtvdEdUT1U2?=
 =?utf-8?B?VHgvME00TVgvTDlRTnRLSlo5UE81VUxRYnFzdmFFUkp5bUZib0hRRnB0RlNo?=
 =?utf-8?B?ajFxaFJReEowRFdmK1R6RHlDNzA1cjlKNEtQd2NYUTVTTS9SczMyVmoxSmxF?=
 =?utf-8?B?WFZxNCt6OU5OM3NHS1VhNmxxME1lWHhxUkk5MHVxZ1h5bndTcnEyMGlpQ2hW?=
 =?utf-8?B?WEhPSVVxdkMvR2ZaUU1LcUNPaVNqcnltc0doNlo0OUhjZ1pVOHdjRnZMZlhm?=
 =?utf-8?B?VkZ0S0JSRncrTGY3b1B5NmxVUFpubi9NNXpuRzBuMDFsbVFhVDc2MTN1NTZ3?=
 =?utf-8?B?Nm5jY2xQNjdIV2dzYUEyL210QkFMT2pyYnE3eUdQaWR0QTQwZS8yaGQ3MEwx?=
 =?utf-8?B?ZFZSVzYyQW4xNjkrb3pnc09ralB0SkwwRXMySW1scVB0bjdMZnNGQmVpZWhW?=
 =?utf-8?Q?AeJDaGlYKJtx+8DxZf9b02/wWn0ifRQX78?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18162f2e-7700-4958-2a5d-08d8961b4819
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 17:05:19.3376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9NX9BdlFKQ9bhMn/X3sfYz9510gnODwzZckQIwTz3WXarF9NflU7tozLYM9v1X2inO2oHSy2q0tO4u2IrOZuaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2826
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 8:44 AM, Laurențiu Nicola wrote:
> On Tue, Dec 1, 2020, at 16:36, Tom Lendacky wrote:
>>
>> Thomas has reported this to me previously and I have reported it to our
>> BIOS team. That previously reported problem has been fixed in BIOS, but
>> I'm not sure at what AGESA level the fix will be rolled out.
>>
>> @Laurențiu, what is the exact model of the processor you are running?
> 
> It's a Ryzen 5950X with a B550 motherboard (AGESA V2 PI 1.1.0.0 Patch C).

Ok, I will forward on the information.

Thanks,
Tom

> 
> Laurențiu
> 
