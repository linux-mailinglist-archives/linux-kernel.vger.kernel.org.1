Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF428C897
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 08:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbgJMGVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 02:21:08 -0400
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:54113
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388527AbgJMGVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 02:21:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwPHZp8HOcOUHa5uHvUZ2NZ1hHS6OcNTFnltZMDqJf0bQO6nk82ok9Lf3P4SyilD0HACBWQg3FPSKbuVXhWao13/VmCyDL1W8WHEZE9HPiJSyTKWbWG4a0EVwmnMY8yf+KSBOG58E4K6QKGJfE1mDfHFQYzDL1QpaoEQBhb+wrTz7VVt/qnkbZvZTSgPIV6GoEcFc1wOSjBEOMGrkKSr8SkD08aDHekHnTwQE5fWVXSdKTYJ3EpdzFjzlZ/WLVQp/Q21RBuRIhuN8tJfVWKGGKYGdoBMv64sa6IRBjO4xsPJUmZNmvu5PAJx9mcODL1hRap71FCJliTNW3CXIa55fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBmXK83pyKqt/dFKuWJC35dL+38WuMioeH4RD7gJ1eg=;
 b=OiFR30ARYeM57RKuIlmJNhmK6naUkvTNwhn44HJwMuol2kR5M3qyqQT2rizpH7t7+aM3OoqKAaxsUHpHb+vhXly4IFnzMs8UwzcCGF6QcaLbbe8lFYQkwMtU+GCLbvcoYwfYWp0mJDe4M9xpidv3kg1vz0RVw2m7WHzRiGxPInXd5wSlXKPqA8RPKmv4MtOIO/K/UtoM+5NRG/dTUU6TJ214kcDvqdb38pYkjhXsscxiC8MD/Ar8Udw6W4eZDXqc2H+Bic/PvKntIz0elwHoygn5YDYqxFO81IdgoLAXqdT/3EnC8mWrkn3222j3hhIqfxV1XjSP9Ug/pMhx1Cszbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBmXK83pyKqt/dFKuWJC35dL+38WuMioeH4RD7gJ1eg=;
 b=Phlv7KB+3U3LFge4mz9QQPR24u3zwCtw/uN2vwrwYYVeOLOsIH6Whv1uYeUYnh7EViMVPvzD+EcUpbZ0iSl9OcEI0xamyngeXmwh7SbljrsY/MW6TBsrbZykrOKVMRikxViPB9JbBjujgXunhMGWQERd/puFiwlNxTLVV5HuuxA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB2613.namprd11.prod.outlook.com (2603:10b6:a02:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Tue, 13 Oct
 2020 06:21:05 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 06:21:04 +0000
Subject: Re: IRQs in /proc/irq/* that aren't listed in /proc/interrupts?
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <c74773ba-10ff-ba3a-b144-da5c2a34c74e@windriver.com>
 <87wnzvp75p.fsf@nanos.tec.linutronix.de>
From:   Chris Friesen <chris.friesen@windriver.com>
Message-ID: <0d3cff4f-619f-3479-2195-e07451636249@windriver.com>
Date:   Tue, 13 Oct 2020 00:21:02 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <87wnzvp75p.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by BYAPR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:74::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Tue, 13 Oct 2020 06:21:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eecd791b-05c7-474f-8288-08d86f4029c5
X-MS-TrafficTypeDiagnostic: BYAPR11MB2613:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2613F28080A7AF4621F1775EF6040@BYAPR11MB2613.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MXlmfgM4qHTpAnCbCwnfUXmYA1sWVhB/LVUSXxD5zdW1iJs6/Qcw7J8KSMvuHu0vGID/GSa3bj9YwV+lrXDWTsQQWKLSIORjEvB/2Iva3EnTueGYUSIgr1o2hLzrGQtb4FMV/PILdI7mp8UKSzfJGWrBKgWHD88toe2m3lKwYg6RMMz7xrgj7K+DZBgdOMK7QpknL5YUMAf9XdAfBAjU9QoMxM1HARuZbcI4ItBfFqX6khMveM2RxKanh7VjA5FrHqWh1Do3xEF93klKtTROOFqgBo7li6BlXlHzX2j/VAtExBU9yv+FhqOkOM2H50nu06g6VJaMhWQ4C4gQ0dr1vRqTs7PbfXybssGsoz6NnvoCoYdE6Y1JYuFb0J/DIsBD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5120.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39850400004)(376002)(396003)(31696002)(53546011)(5660300002)(4744005)(52116002)(478600001)(66946007)(2616005)(36756003)(956004)(2906002)(86362001)(316002)(16526019)(66476007)(26005)(31686004)(110136005)(66556008)(186003)(16576012)(8936002)(6486002)(44832011)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5NR6j0pECO4IbfjrDzfGbqNjajx1stPhbG0+XydQ5Uo9H8QOpblIlz0W4WlbU8IDYxsWLiSqWJDiDqHgTUj3ZY1qM1NJLFd7PSggA5wnQdTJSjPZ75Awbo5Zs3YRPJtnY7wSJBZVgIQR1KzzOYk6fhlSuYlPlEwKtwv021DMNmkde72gxezb0A/cXdhrH34Bc7FDo3aDa+4c1aOdB7TuYxqUNvyzScFVbjKmyzSgZ83khGeX6A9ZH5qthRnZYk1NhV+lhTdQzeTEiXq0CSXU/0S8kbOhSPP0+S8tO71/t0bNLHa4kvf806CC21vegL0dyR149Jh5b9V0TLpkTQ59fs5on6qZIw1Sp4sCD/4aDq330Z0P89C8Ucw2ko1WmwQIqZGDk1XEQmE7a8KP6I88a/zyM4YLm8gzF1qULltFnShHi3iO4qE4lPpQoB9+TmKMadcq1w1U6y6NeoZphz/6FHjGY0XA5QLf3q/MLYrRbepZr2g4OZMmtb1lUS4XEMKyH4v+AIMclHf2lo3glWDCNTYRxXnPftyCqi5gn0i9wvQ1qmtTDF9sC2jRSB825oc3ljsfvC7QiYF9InaSuPFoLwjiMrASz95lScpAVU6eS4Urcu/vhA5k5rnFjxG6jOh7nEYB1EC/S+yA8U5fb+nOkg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecd791b-05c7-474f-8288-08d86f4029c5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 06:21:04.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i0dXfFVSnru4UudnFeLeSo6jJP/T/AsP4WTfUJ+oQPQegHJSfJfbkHgBcY+jHPoO0+7iMQFLEJffrBuV1KSEzv6jZj1ePoVz6B7lYFUfMQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2613
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2020 1:37 PM, Thomas Gleixner wrote:
> On Mon, Oct 12 2020 at 12:40, Chris Friesen wrote:
>> On one of my X86-64 systems /proc/interrupts starts with the following
>> interrupts (per-cpu info snipped):
>>
>>     0:      IR-IO-APIC-edge      timer
>>      4:      IR-IO-APIC-edge      serial
>>      8:      IR-IO-APIC-edge      rtc0
>>      9:      IR-IO-APIC-fasteoi   acpi
>>     17:      IR-IO-APIC-fasteoi   ehci_hcd:usb1, hpilo
>>
>>
>> On this same system /proc/irq shows these interrupts:
>>
>> 0-15, 17
>>
>> Is there any way to determine what the interrupts are that aren't listed
>> in /proc/interrupts?
> 
> They are simply unused

I wonder if it might be clearer to just not report them at all if 
they're not used?

Anyways, thanks for the explanation.

Chris
