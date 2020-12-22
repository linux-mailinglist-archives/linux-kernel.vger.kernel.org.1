Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB482E05ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 07:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLVGJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 01:09:43 -0500
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:19063
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgLVGJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 01:09:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2GAxHOpaWrBRT/edNX9bN1fJSax5lnrQ5H2WR0i/ymhU6vJ/R1aGbCak7ukpRYWK5EFHON+XWPJciw3eKWcv9+H/Qo2Yk9fSc2dGUthn8COMP/kwIMBAZ+UbUD0NLcHeqszqqD3+KJtXSvF+stpQfnEp71kI0izXcy6Nn8iAq2YKtJk+c5/wqEa9h4+b5lYMDHp6cXrdnbVPQJbocLj5CG5O7ajKFVne5dss04fgC8HKzWPRAiIKzNSX/o/pPHS8m/nlg4fbenIkVYQHzNZcAnQeY/cLHoActFtkY7MEkKoDd63xYoxGBS+Y41QCCuyrEEuNbNQq/4Cp5Tb2Z5OhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz0wqZ/aYqLz1LLpe4usrwzrbw6vIgB3XHq6ePy/WYY=;
 b=K4LRrTWaXVSeCz6MKzaZXS3LukBTzp0Bpg+L1d+PSfW5qcM9s/xYDXq3Jh4tJ16Uzyz8y7/Msc5uOzr4BTTSChsDcPdfw78RTOqD89WUSfsFg0VbeAEyutRQcb2nMAHbS5ywRzwyBE5cABaVhGr5yk5aYsdkioz08dYUcGHTgctWbTZke2bIMszAi/+3fFG70rNHYb14lUnc4+e45msNGjz3IH+vg4z+isBIKgS/DOqA4yjOY4RkNimdsbjeyHQzH3eqt16U/OKoaCpVmI9SBP2zxpfJLX/QdJw7RcUcgFZkgdR/PLGuMxJVXZSB3xld/zmlYrbnuTIqOfAJm+gSFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz0wqZ/aYqLz1LLpe4usrwzrbw6vIgB3XHq6ePy/WYY=;
 b=zw/So1JjRU6B8ud+h+Fz3mXOHOAybiajljgLF6fMV3WAs/vmbGHuSYkvk7SpE/qakqcN7N8rTMAPKlpgifSdmWCoftK8Qv+B8JlolsBV+FO+gpju6slHavvy/NBYCMphWw0/UDHJFz2hPRhbyjNvPMtK9FH4g6bwUK/1iT2/f34=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR12MB1351.namprd12.prod.outlook.com (2603:10b6:903:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Tue, 22 Dec
 2020 06:08:52 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818%6]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 06:08:52 +0000
Subject: Re: k10temp: ZEN3 readings are broken
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com>
 <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
 <9d551bb4-0bd8-937c-f1c1-f6a86a24898f@amd.com>
 <CAEJqkgiE8VX9AHRokevVWghPyNcKCpSPH83TpomkHZZvaQAD0Q@mail.gmail.com>
From:   Wei Huang <wei.huang2@amd.com>
Message-ID: <66a77c9b-3394-b6d6-798f-eae89cf6954e@amd.com>
Date:   Tue, 22 Dec 2020 00:08:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
In-Reply-To: <CAEJqkgiE8VX9AHRokevVWghPyNcKCpSPH83TpomkHZZvaQAD0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN4PR0201CA0048.namprd02.prod.outlook.com
 (2603:10b6:803:2e::34) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.20.186] (165.204.77.11) by SN4PR0201CA0048.namprd02.prod.outlook.com (2603:10b6:803:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Tue, 22 Dec 2020 06:08:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9c07762a-d3da-49fb-2602-08d8a6400e98
X-MS-TrafficTypeDiagnostic: CY4PR12MB1351:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1351542708AD1AEE89CB9456CFDF0@CY4PR12MB1351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9QE0kBNdEhdLW663rXLMHrim1FXCkhUCEN4aICKgfVjsptfMkOgfejJ+MclTZAorIK8WCTYrpug7yyv9KILW/00cmzsZWXZbhtedSZU12EPgrtZ9oomrl3uBMQJK2t/T1RzHiK0sofR82fwf60GCIl56u1oXcu6lUNiFNRJde09Yxty8gFMMSp5ciGUzZirtzmSJjapbpozJW41oGRpHJ8AZfGtSeVnTbMWx+jQTErLEzqweOWQw6MkES0gjlRooWFq+sl1L+t7OSfsP1O02pTW+5WcOVi79Iyd9fbIOKEYOdpqjWxaL/fMQTmiQJIyuN+56r2vS8UIbu7XeKhmz9/+3MUGVUrrfbI788KkaeVZwh4Jt0INx24bgzBUnlZiRzhb8FXy1AdjDqx938MQ+VwGwbGJNQ/ikQ5VzbjbrNZmn1c+XeiRDReESL2dnmlDILOCboHCltLPB8ITARW2uwA/0T76shX0pnTnG1Skszj9A6tgTvrHBT9Zu8sw2+MUJhy7rXnTWpCWWiaDeExduOTQlbFenrFWOcooZBJ6IemV+65hHaBrDQrCPXMJLKgi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(2616005)(52116002)(5660300002)(36756003)(83380400001)(26005)(956004)(53546011)(6486002)(66946007)(66556008)(66476007)(16526019)(478600001)(8936002)(86362001)(316002)(6916009)(31686004)(966005)(54906003)(4326008)(16576012)(186003)(2906002)(31696002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ODIC7BqBM7GcX8oIcrYxN/jht8zBJoMgp+b6Lq5v+5OetdEbW8nJ/HLmatPsatvd1jJ20LH7eOaF2yyacBy5GXwiKYjCdWhioKR9Qjl/OFSULljIDYiRcRckYq8IOpGb+67aB6XeInYQo+pRnWpnRbXLdTqNlroU6550/Bo0Ymr7AM/DSTILQA6soDevFQw+zbPvGh8r1saSjfCCC1qqXPDNWo2wYY2DUzSJOd+8Nv9QXMtx7gkFTybD2DLHo5YTL6+egG/SEU+ILduSHi6VRmzUzVofsPSORXzToIUYjjuxxRiH7hkUQBVEk2vL7k16E1oy1XuboZXKgP7Li3lq8Z1tFyAnarvr9nXdLttrHkMPE3MLWfGPgwfMGAcj8qaQOe1hbbE9jkeNg0X+kx/DAYu4hloBc9LQ4zhU1aczvAKBgv8iy2o8jwM29XonClRSyTTyQk5eRdhDhrfds4IMTYsS7bYXXf0k02KBweQa10qHIrGQWooGPCMFkrXvk3Gu4kYmxbOwHJ7L7zkBog5l/ltQY+BQkrseo/njRN0ZIP8n+gkUcr/JfNK1oq7jL/ZJhrWvl3O8NGIJDOh8vGKu8+sl8jKqYtrARwOFBN3AnOms88Dt98aiMytvJM8lPZZdjDaJGwpIjksWj/voutFOK0uKiPu7iENJba0C4UvGdqaYXgySa8b6WNXLI3OpPek7zBgk699l5jlNLjBMfU/GBfqiyK3XfTWdbNrL4e8r/zAJPm+QCEV/Za1ybDCMb/IU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 06:08:52.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c07762a-d3da-49fb-2602-08d8a6400e98
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dajFJjs8M/8bOqBbSYrobKodZ7ZGINMDb/aKbT4ohH6xEe5RbUp76sEQvkMMMwGU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/20 11:09 PM, Gabriel C wrote:
> Am Di., 22. Dez. 2020 um 05:33 Uhr schrieb Wei Huang <wei.huang2@amd.com>:
>>
>>
>>
>> On 12/21/20 9:58 PM, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On 12/21/20 5:45 PM, Gabriel C wrote:
>>>> Hello Guenter,
>>>>
>>>> while trying to add ZEN3 support for zenpower out of tree modules, I find out
>>>> the in-kernel k10temp driver is broken with ZEN3 ( and partially ZEN2 even ).
>>>>
>>>> commit 55163a1c00fcb526e2aa9f7f952fb38d3543da5e added:
>>>>
>>>> case 0x0 ... 0x1:       /* Zen3 */
>>>>
>>>> however, this is wrong, we look for a model which is 0x21 for ZEN3,
>>>> these seem to
>>>> be steppings?
>>
>> These are model numbers for server CPUs. I believe 0x21 is for desktop
>> CPUs. In other words, current upstream code doesn't support your CPUs.
>> You are welcomed to add support for 0x21, but it is wrong to remove
>> support for 0x00/0x01.
> 
> I figured that myself after seeing what was committed to amd_energy driver.
> Would be better you as the author of the patch to have a better commit
> message to start with.
> 
> 
> commit 55163a1c00fcb526e2aa9f7f952fb38d3543da5e
> Author: Wei Huang <wei.huang2@amd.com>
> Date:   Mon Sep 14 15:07:15 2020 -0500
> 
>     hwmon: (k10temp) Add support for Zen3 CPUs
> ....
> 
> Which you didn't. That should read:
> 
> "Added support for NOT yet released SP3 ZEN3 CPU"
> 
> Right?

Yes. This subject line can be more clear with something like "Add 
support for Zen3 Server and TR CPUs".

> 
>>
>>>>
>>>> Also, PLANE0/1 are wrong too, Icore has zero readouts even when fixing
>>>> the model.
>>>>
>>>> Looking at these ( there is something missing for 0x71 ZEN2 Ryzens
>>>> also ) that should be:
>>>>
>>>> PLANE0  (ZEN_SVI_BASE + 0x10)
>>>> PLANE1  (ZEN_SVI_BASE + 0xc)
>>
>> Same problem here with model 0x71. 0x31 is for server CPUs.
> 
> Yes, is why I split both in my 'guess what the eff is this about' patch.
> 
> 0x31 is TR 3000/ Sp3 ZEN2 , while 0x71 is ZEN2 Desktop.
>>
>>>>
>>>> Which is the same as for ZEN2 >= 0x71. Since this is not really
>>>> documented and I have some
>>>> confirmations of these numbers from *somewhere* :-) I created a demo patch only.
>>>>
>>>> I would like AMD people to really have a look at the driver and
>>>> confirm the changes, since
>>>> getting information from *somewhere*,  dosen't mean they are 100%
>>>> correct. However, the driver
>>>> is working with these changes.
>>>>
>>>> In any way the model needs changing to 0x21 even if we let the other
>>>> readings broken.
>>>>
>>>> There is my demo patch:
>>>>
>>>> https://crazy.dev.frugalware.org/fix-ZEN2-ZEN3-test1.patch
>>
>> For family 19h, the patch should look like. But this might not matter
>> anymore as suggested by Guenter below.
>>
>>    /* F19h thermal registers through SMN */
>> #define F19H_M01_SVI_TEL_PLANE0                 (ZEN_SVI_BASE + 0x14)
>> #define F19H_M01_SVI_TEL_PLANE1                 (ZEN_SVI_BASE + 0x10)
>> +/* Zen3 Ryzen */
>> +#define F19H_M21H_SVI_TEL_PLANE0               (ZEN_SVI_BASE + 0x10)
>> +#define F19H_M21H_SVI_TEL_PLANE1               (ZEN_SVI_BASE + 0xc)
>>
>> Then add the following change:
>>
>>                  switch (boot_cpu_data.x86_model) {
>>                  case 0x0 ... 0x1:       /* Zen3 */
>>                          data->show_current = true;
>>                          data->svi_addr[0] = F19H_M01_SVI_TEL_PLANE0;
>>                          data->svi_addr[1] = F19H_M01_SVI_TEL_PLANE1;
>>                          data->cfactor[0] = F19H_M01H_CFACTOR_ICORE;
>>                          data->cfactor[1] = F19H_M01H_CFACTOR_ISOC;
>>                          k10temp_get_ccd_support(pdev, data, 8);
>> +               case 0x21:      /* Zen3 */
>> +                       data->show_current = true;
>> +                       data->svi_addr[0] = F19H_M21H_SVI_TEL_PLANE0;
>> +                       data->svi_addr[1] = F19H_M21H_SVI_TEL_PLANE1;
>> +                       data->cfactor[0] = F19H_M01H_CFACTOR_ICORE;
>> +                       data->cfactor[1] = F19H_M01H_CFACTOR_ISOC;
>> +                       k10temp_get_ccd_support(pdev, data, 8);
>>
>>>>
> 
> You are a really funny guy.
> After _all_ these are YOUR Company CPUs, and want me to fix these without docs?
> Sure I can, but the confusion started with your wrong commit message.

Sorry for the confusion. The review comments above was merely to point 
out server parts won't be supported if 0x0..0x1 is removed. I do 
appreciate the test results and bug report. The original commit 
unfortunately doesn't work on your CPUs. It was indeed a misfire from my 
side.

> 
> Besides, is that how AMD operates now?
> Let the customer pay thousands of euros for HW and then tell
> him to fix or add drivers support himself? Very interesting.
> 
> And yes it matters even after removing these.
> 
> case 0x0 ... 0x1:       /* Zen3 SP3 ( NOT YET RELEASED ) */
> case 0x21:      /* Zen3 Ryzen Desktop  */
>     ....
> 
> Right?
> 

