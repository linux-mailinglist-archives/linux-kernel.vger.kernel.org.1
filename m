Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03122E0560
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 05:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLVEeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 23:34:04 -0500
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:29185
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgLVEeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 23:34:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZqo7jtbzfJ9y2ulAOdIw85QpDcEGTgnF7cTmWdUJW24fC8EoYVIW54dbc0xXV99uwUTJYUgLIIYd6teSkjJIe4O9C27JDq+yoBc5kpOIZXXs6sdawPJsgRiS80NWPR2V3izvF9EYcEVQ0JvzqP4YmKGtpwwp3KJKyLg24U8i3cDPkSLQ4yqjgwBRjWgyKCniD0GBjTfYsWIOA6/Eq/loE3I5sihfp1rR9GiI7UIVgC/CsVV7joKZf9IdIofjvNsglU0+WePGPTxdfjjLpL+kA2foIozSRI/+i4Q6JGE2dnjhNUVu4FhPv/PuGujQcs15MTQB/6bi3iTMaE9VGseZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+AVPYqlmH4iHunbesCPUJTd5wPPyZ1VK/Z64vtwnaI=;
 b=hBoYPRLFtszjRFw9eAhNPAsemPdt4FldOgwKlEn34/vKXlxshINS/8U5qrp7ZDEcZNpjHGhjeTkBTuJ8OqHD5G34M9WlQZO4XLG+6+f7T4jVl5c5XptuyrCav1Ov35Xgs7DbR5NdbDkqwfmh6o8Ogjdt2GS+/mpBFZsDhuJhXVXceeRwO0O4J+u1FODnahfX3I967lFQULQPBwGpDBsOlHYTxUvjQ+T/EaWjhpzhJtNbsCjYdR/99FG/lJJ19UOhHFwExzn3KGWUYE63lci6Qc3QK6i08620dapgwXQ2qi/UTPZU+4noDLxZ65drIBppPHPRXZFvBppS1DCdKWU3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+AVPYqlmH4iHunbesCPUJTd5wPPyZ1VK/Z64vtwnaI=;
 b=tuyBHepSfl5EpBj64Zf8cGM+4ozUXHY7h5r30YgGKo8RQIVfXO6M2k0GcaXjsNkYKcXc6+cRUM6E3Cbde0W70c698zXwZkoYvDnf3dcI2DhHmRXotOd7gLdfHQuUskswSMMqPgQrSmh0wpUfz6jLSMhGQi3Nc2HcWWfBjVVm5+M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR12MB1350.namprd12.prod.outlook.com (2603:10b6:903:41::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Tue, 22 Dec
 2020 04:33:10 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818%6]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 04:33:10 +0000
Subject: Re: k10temp: ZEN3 readings are broken
To:     Guenter Roeck <linux@roeck-us.net>,
        Gabriel C <nix.or.die@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
From:   Wei Huang <wei.huang2@amd.com>
Message-ID: <9d551bb4-0bd8-937c-f1c1-f6a86a24898f@amd.com>
Date:   Mon, 21 Dec 2020 22:33:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: DM6PR01CA0022.prod.exchangelabs.com (2603:10b6:5:296::27)
 To CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.20.186] (165.204.77.11) by DM6PR01CA0022.prod.exchangelabs.com (2603:10b6:5:296::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29 via Frontend Transport; Tue, 22 Dec 2020 04:33:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e4f18020-667d-4b42-409a-08d8a632afde
X-MS-TrafficTypeDiagnostic: CY4PR12MB1350:
X-Microsoft-Antispam-PRVS: <CY4PR12MB13508644AE762FB4D17CDF53CFDF0@CY4PR12MB1350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxVweaUbYM2BNe/WGfElC9Ib1HP29D4zVkc0slBqxMwDT15Fy5hw6ts3hxSevleTE+4vUon80hL28w9AoofrMxX2Af8Ffy5ZQwlFRrUkDpWDlDGfrlWoMAsSpqdrrgNfTpfMP1J6z7Xp+LrtOH4jwnudlslnrWp7797+PTdXAs4SCTQTOCO/ql2puDHlO5d5C9yU1BVakPa00G4bUfTJ1IatC7EPY9t7IlRVnDxBIX2JteOrxi4MAInAKgoUoVMprGE4DEYO5NpDKt5C9avAB/JWBXuY8t4YRuD4Kc3yiKGoWRIlCNDZf0HrjwKXh+ByUEHIk6f3m3jq6fR174WE363lun386cPjYhZ9D8MBAly1EPbRqetMbtMP3FReXf1lCUpQk+QqrSyK7K0STj5ObadknJ2u2KGY4WD6QaRwQ8IRoBWcCL6adLhY80Vk09sYptpWsQc4mJ4YGkxRONb9srFJcQDm6MLcIIsY0yv9O6lCJgtQnvQSFS1D/+SNSCdid0VL6I6wWrmQ313vH4FN0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(16526019)(956004)(2616005)(31686004)(66946007)(26005)(66556008)(66476007)(2906002)(36756003)(186003)(8676002)(86362001)(53546011)(4326008)(6486002)(5660300002)(16576012)(83380400001)(52116002)(966005)(110136005)(316002)(478600001)(31696002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cFlOM3dTeGR4dmRpSFVQZGVrNEUxUENQR3Jjci9JQUdobk5telRsWm9sNG44?=
 =?utf-8?B?UFpIcko5TDNVa0c0dFN1NmR1ZG81VGFXTFRaVmdBdCt3QVhtaHJ2RnE2MXRp?=
 =?utf-8?B?YVVBRWtUZUtURnhiYVhYV1g0c3dIaE54akY3VmQ4U2FsYjV0Yzc5S3c5Rmkz?=
 =?utf-8?B?aThwWlJyS1hteXBoVzJPYmNDN2daSXJzejRnRm9YUmJSRVhVUzNvN0FRVmRJ?=
 =?utf-8?B?RmVkNmMwY2l4a0JQS053RXFydDJPdXBBSWthaFFONkZmNkIweDlnempMKzZp?=
 =?utf-8?B?TUd2Mzd3bTJ2V2RHeC9WWGlKRGpuN0F0dG10WC9LU29pL2NxbHg4UG5Fdno2?=
 =?utf-8?B?SXNqYUhEb09QbUhhbGNRMHJuUldYK1k3SlpFNlFNUnlxeFIxdWlpWnowY1Y0?=
 =?utf-8?B?QkdRR1I0R2gzQnZHbFZ0T1BlYkEvRlZENi8ybjliT21FWlpaVnUzQ25vZS9F?=
 =?utf-8?B?NVpEakVJRURlTkhYa0d3dGR4NnhKK1l4MWVkV1d1aC9Ob3Jibm9uR2lSa2RM?=
 =?utf-8?B?Z2dheFF3a0dUaXJEdjhSMXRrTE4wOHNLYTd0SnRkSWhmZFJyKzlGSkNUMHc2?=
 =?utf-8?B?MDZHdSsvb3BLdHdsTjY0aHhXUnFEZzJSSkVkelBzNnJVOXp5WUEzSS8vSzYy?=
 =?utf-8?B?aEhES2dvaFBzMUlsaGNHSHJDa1MwdFBZSjJpVDBRQzZ6OXlZdGt1Z1lQTU5H?=
 =?utf-8?B?WFQxaFRKZ3ZaeXZ0cXpWMWI0UUIxSWwwRCtsYmFvSFhWWDJaU3ZtUnpNaDUz?=
 =?utf-8?B?d3c2bzJjdDc3bVRubmt5ZEQ2Y1NSMzNzNmxadGJaZUw5M0pLN1BaN0FOU1Mr?=
 =?utf-8?B?SEk4cm1ndTRwZVd6My80U2NMUzMveGFjSmNUOGl2NEwyNjk0bFpMam1WeCty?=
 =?utf-8?B?WldEL0xNUWkxdUtsTldOdFBvYjVYQ2RRbGQxODBTMCtIQnBnVWxOcTI5UDJP?=
 =?utf-8?B?YkhGcWpaSzNyYlFIRmduejNNckUwOTFoUDRSMUZvSFV4cmsvRXp6dXB0dXVZ?=
 =?utf-8?B?QWNwUXEyNW54eXdFM0drNXd4WFlhSUpTV3VaMWgxR0g4dHhJbTM5aW9CRmlp?=
 =?utf-8?B?V1htVHhYM1BXTEdRMUdTV1dQS1dOaWViMTFOTk9ueGhuMUNIeVJON3dENWtu?=
 =?utf-8?B?TnMzUU84ZFNBaHJIVXYxTmNMRi8rWmcxaEtTVkhPQldkdmNxSE1PanNNZDlG?=
 =?utf-8?B?TzFTWE5IVkJzajZKY1o0VjlhbUVtNGlJQkxQalEveXdKb1Z2N0FvMEdGbnBn?=
 =?utf-8?B?S1VqQ1NVYks3Qm14aXMrRmh4ZS8xOVVHL3BzVjlHTEdrRzBBa2NPcDNXS2p1?=
 =?utf-8?Q?IMeL3P3l58EojFlHC24ZXg9xTDPdgME2wF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 04:33:10.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f18020-667d-4b42-409a-08d8a632afde
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8d6a3mg+SKHW/r6WlQzDRrakAVOSsXiDXQUUjhVMysAwMok05zi12kSbEc9uu+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1350
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/20 9:58 PM, Guenter Roeck wrote:
> Hi,
> 
> On 12/21/20 5:45 PM, Gabriel C wrote:
>> Hello Guenter,
>>
>> while trying to add ZEN3 support for zenpower out of tree modules, I find out
>> the in-kernel k10temp driver is broken with ZEN3 ( and partially ZEN2 even ).
>>
>> commit 55163a1c00fcb526e2aa9f7f952fb38d3543da5e added:
>>
>> case 0x0 ... 0x1:       /* Zen3 */
>>
>> however, this is wrong, we look for a model which is 0x21 for ZEN3,
>> these seem to
>> be steppings?

These are model numbers for server CPUs. I believe 0x21 is for desktop 
CPUs. In other words, current upstream code doesn't support your CPUs. 
You are welcomed to add support for 0x21, but it is wrong to remove 
support for 0x00/0x01.

>>
>> Also, PLANE0/1 are wrong too, Icore has zero readouts even when fixing
>> the model.
>>
>> Looking at these ( there is something missing for 0x71 ZEN2 Ryzens
>> also ) that should be:
>>
>> PLANE0  (ZEN_SVI_BASE + 0x10)
>> PLANE1  (ZEN_SVI_BASE + 0xc)

Same problem here with model 0x71. 0x31 is for server CPUs.

>>
>> Which is the same as for ZEN2 >= 0x71. Since this is not really
>> documented and I have some
>> confirmations of these numbers from *somewhere* :-) I created a demo patch only.
>>
>> I would like AMD people to really have a look at the driver and
>> confirm the changes, since
>> getting information from *somewhere*,  dosen't mean they are 100%
>> correct. However, the driver
>> is working with these changes.
>>
>> In any way the model needs changing to 0x21 even if we let the other
>> readings broken.
>>
>> There is my demo patch:
>>
>> https://crazy.dev.frugalware.org/fix-ZEN2-ZEN3-test1.patch

For family 19h, the patch should look like. But this might not matter 
anymore as suggested by Guenter below.

  /* F19h thermal registers through SMN */
#define F19H_M01_SVI_TEL_PLANE0			(ZEN_SVI_BASE + 0x14)
#define F19H_M01_SVI_TEL_PLANE1			(ZEN_SVI_BASE + 0x10)
+/* Zen3 Ryzen */
+#define F19H_M21H_SVI_TEL_PLANE0		(ZEN_SVI_BASE + 0x10)
+#define F19H_M21H_SVI_TEL_PLANE1		(ZEN_SVI_BASE + 0xc)

Then add the following change:

  		switch (boot_cpu_data.x86_model) {
		case 0x0 ... 0x1:	/* Zen3 */
  			data->show_current = true;
			data->svi_addr[0] = F19H_M01_SVI_TEL_PLANE0;
			data->svi_addr[1] = F19H_M01_SVI_TEL_PLANE1;
  			data->cfactor[0] = F19H_M01H_CFACTOR_ICORE;
  			data->cfactor[1] = F19H_M01H_CFACTOR_ISOC;
  			k10temp_get_ccd_support(pdev, data, 8);
+		case 0x21:	/* Zen3 */
+ 			data->show_current = true;
+			data->svi_addr[0] = F19H_M21H_SVI_TEL_PLANE0;
+			data->svi_addr[1] = F19H_M21H_SVI_TEL_PLANE1;
+ 			data->cfactor[0] = F19H_M01H_CFACTOR_ICORE;
+ 			data->cfactor[1] = F19H_M01H_CFACTOR_ISOC;
+ 			k10temp_get_ccd_support(pdev, data, 8);

>>
>> Also, there is some discuss and testing for both drivers:
>>
>> https://github.com/ocerman/zenpower/issues/39
>>
> 
> Thanks for the information. However, since I do not have time to actively maintain
> the driver, since each chip variant seems to use different addresses and scales,
> and since the information about voltages and currents is unpublished by AMD,
> I'll remove support for voltage/current readings from the upstream driver.
> I plan to send the patch doing that to Linus shortly after the commit window
> closes (or even before that).

I believe Guenter is talking about 
https://www.spinics.net/lists/linux-hwmon/msg10252.html.

> 
> Thanks,
> Guenter
> 
