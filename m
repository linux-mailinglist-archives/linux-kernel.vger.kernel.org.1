Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324402AC929
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgKIXPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:15:08 -0500
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:8641
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729585AbgKIXPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:15:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDmVu+7JyI8U1Or+o/D4hJWd7tOuLaLcYDi4wMf4ZkUQHdu80mwYiRCcfA1mwV5UOelnKIiAYXyNd19gVKgZXD8zNhCxzaH+o8zCq0mMKL3dwmzqRXpxVRWmwGI1jizzvCF/jvyXs2l0ahka1zu5vBO90mmLHaZnrnLRU6D0Oo/yCQks7mmXnIULS+byp6qbdHK6l75XxK9//Dhy/oCb1h/uLNOc0wV9hTjZIUmjD9K80qa1daU8S9F3SKv/9UUmKhrHLLH0sznyz8MXK+Q+nky+jmn3/ZxZASdpnKYaLJzshtA/H2qhb280PzLQp0MxuHcjK9Q67R3PuYB72WajVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayW56KjOrbm2FtXrwE+0VQIu1WQUIarr3FwiWvZmv2k=;
 b=Vk8y5DpjwrtLUUQyakMVL+VW9a2QtauOnmXuuQdrpYKAnO2dRDJ85FgmSAd8FZ8lkjSpKgeI7UrHNRJJ2DNbZ4ymbd87x1G3LucmcHXGLbWSJmbn0k7j4oEYxETEWO01yP1n3nihQMuU8rWEriBHkGtj1xzohB6YtH8ifZUqK0ZLiiZWsa9AODncFaxnk13anXhX/eiyXyOzmz+Nya7HM+cEhNAv+oWdNC7QiK12291IuNdBSSWc+eA/NgkcaXw2D8KH+IbORHAl4b8tn1qs4y62m/IOCekvy/Kag1oxIqvnWFoyMgzdbTIiWrNsf9yt45qODq1BihHJ0I8/iSuIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayW56KjOrbm2FtXrwE+0VQIu1WQUIarr3FwiWvZmv2k=;
 b=AL4xZebXocu7OfZUl0pRSXuJLtEedYbx9qqhDMy+qvD0uLCu+DR7cBbSEh0LanlJRuVTSm5TJxDHTe57IEuxfJnW1Ghlmrgp3uTDdi5kaDtP4SC1GAOi5vUIyS1zrrf4BvQFiMboqzgK/ycEUMF00Aa/zr/mJ/SKE7MpEPWQqR0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.22; Mon, 9 Nov 2020 23:15:05 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 23:15:05 +0000
Subject: Re: [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>
References: <20201024213535.443185-20-dwmw2@infradead.org>
 <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com>
Date:   Mon, 9 Nov 2020 17:15:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <160397373817.397.3191135882528008704.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA9PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:806:23::17) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SA9PR13CA0072.namprd13.prod.outlook.com (2603:10b6:806:23::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Mon, 9 Nov 2020 23:15:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b4fb831-f8a2-48e9-e4a1-08d885054ae1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0219E35A96A14EDDA31276D0ECEA0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7d9LrtoJu++cbk1N+MyM11Ws/B3srdLbGYTQLBBhSIRFEDUaY1+9JPjcL0Thq6V1QkZC1fd3snD55W1nM1oenMdMjGpR/pclHVLSZpoHA/5GRnxAop/h+xt3mmJQ5Q0pRo+wzB7EDH+r5CxssdpgduwbgBIR5q+u1xYawN8z2lSUkAEo/kRWC0OVt9UA1NX5zz9ESo+t25gahltgGXjJTJwddaBwRNnaUo7GwAFHJxY38jQ3o0wgEyp4lAjHg2l8rso/bsxRKGA4HHwCVh7FFDUG9xkmSdVajrA5DyCWskdYVzMgZYJjK9V9KhlSO4+s7MLJTP65Az1YQ59gSiWN2LDdfa3YVnIf68eVv29pC63io+7d8w2s6F0TH8M0S7ob0TnlE9yPqTIgqO2MYYeeoCFHTceOteBCMnVE6yNJQAwyTzV3aq1sCekubtudNP6WG9zywPiMsjQvcK2iftKB4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8676002)(31696002)(26005)(8936002)(16526019)(2616005)(186003)(6486002)(36756003)(83380400001)(52116002)(31686004)(53546011)(86362001)(478600001)(66476007)(66556008)(66946007)(6916009)(966005)(4326008)(16576012)(54906003)(2906002)(5660300002)(956004)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: n3vY3grdJoLYREDwpysl10YXRhPR4AX3eU8CNJwGdKzHlrqiCZc66xXpd3vjEtEVeCp2oL6Fd+qYlnSC0AJqWuKzoi7hXF+JE2F8NJCbRHUNpv2PaPNqfqBrjCwETv3+QgVFkgReF5PnSGP16X+F9wi9ZbCdxhiIZxpRzFf9f7LbS7jXIUUMBhPlao06L6iY5bsmairaVkhL5lUGS63sMZhgTYPBXx5/fGkp0kQmDbbT9w85sh5YFqkvyk+9VbMtmmrHTGKfJ/nt5w3STNcnQZfgDzOvlmngz2K37qQTVxDt48hm1oytx+vhVq+tg+htonJ68cRglBeHPplyXDpS3mmHxN62B3wSj1nLTc8KNFzF7JKix26jp/dj9gLu65cqt9aOluW5/AC4pmCBT58e8t72GyKsS19BpnedfMeTWWouwPgIO0MGuCQlM5DqiOD5qbdPXKitLHG6BsEgHvU/frnde6cOyDh9u7yA0/3hd84LVGQLZABRC3kXpbtlhrzAQL4LFqkENmKMDTClxavaK2vN9H620btLA5dpFmWvFy73yP9aF3zkiusaU3amXFN0pxBvrux1fygg06gvfoGMRvf1nJoEuhIeiUOa4ebJ3TBgH7/IdgwuEQjrKhsL2I9wV6g5a7F5C/fTFmCUmuHhhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4fb831-f8a2-48e9-e4a1-08d885054ae1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 23:15:05.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDPL0iyxzwhtxFZHXkV46Xd7J/CuXt2j8xWHLd8x/UYC8x7cL0cIA7y3hF+vMt7b07oVrLp7JUnoH3uKm2BhXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/20 7:15 AM, tip-bot2 for Thomas Gleixner wrote:
> The following commit has been merged into the x86/apic branch of tip:
> 
> Commit-ID:     a27dca645d2c0f31abb7858aa0e10b2fa0f2f659
> Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=a27dca645d2c0f31abb7858aa0e10b2fa0f2f659
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Sat, 24 Oct 2020 22:35:19 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 28 Oct 2020 20:26:26 +01:00
> 
> x86/io_apic: Cleanup trigger/polarity helpers
> 
> 'trigger' and 'polarity' are used throughout the I/O-APIC code for handling
> the trigger type (edge/level) and the active low/high configuration. While
> there are defines for initializing these variables and struct members, they
> are not used consequently and the meaning of 'trigger' and 'polarity' is
> opaque and confusing at best.
> 
> Rename them to 'is_level' and 'active_low' and make them boolean in various
> structs so it's entirely clear what the meaning is.

Running the tip tree on my second generation EPYC system I'm seeing lots
of the following:

[  105.325371] hpet: Lost 9601 RTC interrupts
[  105.485766] hpet: Lost 9600 RTC interrupts
[  105.639182] hpet: Lost 9601 RTC interrupts
[  105.792155] hpet: Lost 9601 RTC interrupts
[  105.947076] hpet: Lost 9601 RTC interrupts
[  106.100876] hpet: Lost 9600 RTC interrupts
[  106.253444] hpet: Lost 9601 RTC interrupts
[  106.406722] hpet: Lost 9601 RTC interrupts

preventing the system from booting. I bisected it to this commit.

Additionally, I'm seeing warnings and error messages (which I haven't
bisected, yet) along these lines:

[   12.790801] WARNING: CPU: 135 PID: 1 at arch/x86/kernel/apic/apic.c:2505 __irq_msi_compose_msg+0x79/0x80
[   98.121716] irq 3: nobody cared (try booting with the "irqpoll" option)
[  100.692087] irq 15: nobody cared (try booting with the "irqpoll" option)
[  100.800217] irq 11: nobody cared (try booting with the "irqpoll" option)
[  100.800407] irq 10: nobody cared (try booting with the "irqpoll" option)

Thanks,
Tom

