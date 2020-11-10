Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8564A2AD958
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgKJOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:55:32 -0500
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:28541
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730231AbgKJOzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:55:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRP6ztOwZHBN1xXmxt21OmAgMa+DS3a9wNJd05ZxNg42avZB44m3jdEHpOBLzM6sdRQx7TBGiVCsLfEAqXS/SCkmsR221V6lxpJrbJslUmAEhRnlRqfKVBY+RzEkHm0LYrtn+cZ6FGMfddTCuZyg0hpGGF+/JcXqBYNK15xNHDfLMAx25Z3Q8TkOQ2De5ZYvNCzLtNVG+a7/K92w3k2CFk+W3P5I/NW/VOU6yMEMrqAWi0MI7B7OOO+e0fTGkV1eKR6uwmZtj2NhQQHfRyDfaUYhCP6zf6vcWiD7DnVGbziC9UVJv2G8Jps2Q56u59RyZQVqfm8ivnjdiAisfXkaTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tQ85vJF6X42dARRxNk3UT21c6SXF8x5K24csqNGbn8=;
 b=CHln/37GSAhE+KASv3MGBo0pKopmrKMmwyYS+JbkbpFQUtn3S1b9mfCqq/Yuf3jFEF2kNwUvuCYNp1N5GLhdG2d+oNl8WLuMW7UXR2lbOvRebmfsM1RY7LyLXcGq1o7DrWiKLwCNYLg8uHJb4FZzX5vXD1A3sdRAjafGxRcDjIF/qLltF23950YV42YCnVEttgeI8LHf4JcB0+VqnjBU6EWFCY/1f5DXAs0RkWlEUQ1qhnQF3C6OqyaBeApbAQpA5BcJlXzItVMuIV2jdI88Bs2sDc7j6zrBSfzgOttzCvRmk/UztX9WnxhUVlJwvCYpDdetwYfBHfrVdFKwe0utMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tQ85vJF6X42dARRxNk3UT21c6SXF8x5K24csqNGbn8=;
 b=KazTylOx4Lesgt/hgx8rPqkGzGrII9db0ciKBk1OBiX0LJoyyW2IFD8dgLTKWzAbe40ujdNXnzwV/zpVArstREGn1mvIKYRyaKcD0CpfnN0x2Cf/Yx3tvgECL1dF1l+wvZ1Bv65W0QtsxumKy5BBaLGIwRWWUCA7sq/iIZkSNa4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0217.namprd12.prod.outlook.com (2603:10b6:4:54::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.22; Tue, 10 Nov 2020 14:55:27 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.034; Tue, 10 Nov 2020
 14:55:27 +0000
Subject: Re: [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        x86 <x86@kernel.org>, Qian Cai <cai@redhat.com>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
 <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
 <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com>
Date:   Tue, 10 Nov 2020 08:55:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <87d00lgu13.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:805:ca::36) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN6PR16CA0059.namprd16.prod.outlook.com (2603:10b6:805:ca::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend Transport; Tue, 10 Nov 2020 14:55:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 76fed25f-8bce-4c03-c521-08d88588a940
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0217:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02170067010440EF8CE70A94ECE90@DM5PR1201MB0217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:158;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 45udgAO26zwLETAFbx3FMTH2vWAnamoPHZ5U8BjTyGpJVYzxFc2vGb7DP1AtsYo2ExBCpQaANvTQnxbAY6zIz88eNxVp1JPZWdgBRAf/HztMpa+txh9cY7cxjXrWZk0dhMqTRE67B1SJ6/ZkLfDW9IdvICXWIwRrFzFmkPO/AgiG0ubxxew0DmMasgqc+AJPZLSzO5e/B4prIDL7A/GhO2O61y+beWS5uW3WcwPdA4hiE+v6064SGHqnRiXfX576UaLgS7HsSwhac+XmbIxBhRrBOar2LxocvMiVxp5yhAbBQ6n1O1a5aiqUTqQG7bjeT2oXFQK43uLu7JcwK66UaBOOIY1dbVNjalU8thE2JUCMj8KB2Xis4f0XD4EndF5C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(52116002)(2906002)(478600001)(316002)(86362001)(16526019)(54906003)(956004)(2616005)(16576012)(110136005)(5660300002)(6486002)(4326008)(186003)(8676002)(26005)(8936002)(53546011)(66946007)(66476007)(66556008)(31696002)(83380400001)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: g1W5rA/T4sWq+RfJRBpD1nMh0xYse4E2N5XtlT75KNQxyf9+8zZlBtmx6A1v47ALRwuwqmh6wn67fXMsPw/cCtNOvuuIrBAgqrPK4UlaACqYrHTmdWBAOmmLwAsfXmNkB8zTSmVGfwTVeSBBhkQEuAj5NzgnIJG5bTZmQboThn0RgJOqXMVfjMRHB96x8vZJD/HhM4F1K2L9gS0QBadm6PdBEPMVDRV+0F0L8A1jdPfTGFcnSFyBAAuTp0MHo5BkXg1JzCw7IHtA01YNiYYqNuisJ84J2EvM4qbXXuAnESxWiJNcV0fvgfi6AjfHIYY10gxUVNAkaJfQL+4f3n0z4Gg0xUJfK4JSWmqxAXJxw+yxVfRJ9Nk5tu/U+1i33IO3fRk4VS7JJtDOhMvHKluuc7qqZhPl+hgGWtYFOUNX30tCNvJSu0fxgI6wSWD0XRYXV/jQvRPygBMLIdkcRWzY+ppuKBqjhoAfJAcuNcOxEQhSgEx6kgx+p1wWnQzlp0u4zj4S4psewVQwB5yZVq/WN7yBPuF8WOyKyzxiBHn5UdLfPbEfG19ieFofwu2P2zaBTJQxABOryo3oaX3EgyBxQ6HnGnNujOF24MKO+PsuPFEdxvuC4QlzP8ySkdTc3wDllMcAsXeZ488ljDlBlTXDVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fed25f-8bce-4c03-c521-08d88588a940
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 14:55:27.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpJJkxGzXS//lGgyZ3XGvRBOClMgOCnPCFaud8cG08ZYdhOpza3tx4loxBwC73H0jQtFqi/cZjTEEEU/BOKVnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 8:34 AM, Thomas Gleixner wrote:
> On Tue, Nov 10 2020 at 07:10, Borislav Petkov wrote:
> 
>> On Mon, Nov 09, 2020 at 05:15:03PM -0600, Tom Lendacky wrote:
>>> [  105.325371] hpet: Lost 9601 RTC interrupts
>>> [  105.485766] hpet: Lost 9600 RTC interrupts
>>> [  105.639182] hpet: Lost 9601 RTC interrupts
>>> [  105.792155] hpet: Lost 9601 RTC interrupts
>>> [  105.947076] hpet: Lost 9601 RTC interrupts
>>> [  106.100876] hpet: Lost 9600 RTC interrupts
>>> [  106.253444] hpet: Lost 9601 RTC interrupts
>>> [  106.406722] hpet: Lost 9601 RTC interrupts
>>>
>>> preventing the system from booting. I bisected it to this commit.
>>
>> I bisected it to the exact same thing too, on an AMD laptop, after seeing what
>> you're seeing.
> 
> Bah. I'm a moron.
> 
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -809,9 +809,9 @@ static bool irq_is_level(int idx)
>  	case MP_IRQTRIG_DEFAULT:
>  		/*
>  		 * Conforms to spec, ie. bus-type dependent trigger
> -		 * mode. PCI defaults to egde, ISA to level.
> +		 * mode. PCI defaults to level, ISA to edge.
>  		 */
> -		level = test_bit(bus, mp_bus_not_pci);
> +		level = !test_bit(bus, mp_bus_not_pci);
>  		/* Take EISA into account */
>  		return eisa_irq_is_level(idx, bus, level);
>  	case MP_IRQTRIG_EDGE:
> 

I was about to send the dmesg output when I saw this. A quick test with
this change resolves the boot issue, thanks!

I'm still seeing the warning at arch/x86/kernel/apic/apic.c:2527, but I'll
start a separate thread on that.

Thanks,
Tom
