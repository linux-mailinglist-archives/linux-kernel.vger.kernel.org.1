Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536982D3B82
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 07:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgLIGe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 01:34:28 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:57470 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727765AbgLIGe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 01:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607495598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E66XTuF9S6V6oDfPaAuyEjQFA8d+e4b2TR44kS+gsBU=;
        b=dzoZy86bCYIRCnKfA74PasAv64LUjJuKkxl3uINaKl8um6jSerOQBMTgEeYUbtdfVakHcI
        KcQS+TyiMlsdAYr6HXJIDkFqWFGhvyvGQY/yGhTtwhB2ti3OyOCDS15TNeA8QYV9WbwkUg
        mszQAFewxxN47BQKbswtVHM+5Nf37T0=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2107.outbound.protection.outlook.com [104.47.18.107])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-SdgT_GUlPmG1JmvbHrYu1Q-1; Wed, 09 Dec 2020 07:33:16 +0100
X-MC-Unique: SdgT_GUlPmG1JmvbHrYu1Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lroR34DRnfX6oM1+39Xy3fiRKsaAYrh518/IkKtNmDAOmOE5d1wWR0Xe/Qo2g42hR/hO5JyTUZORAvZWU5G2W1ccq863aZnimbHOV9GTvsXGFVQxSLaaJ98jZiE0/8igm1SvbIczZCNGpSJWudfV+7fgWVbORAqAZY5WkfX3bZ7k7EntIVfVX+GyBExiHHuQaj7jDkbqooNqVwpfRaLSTLI68xYeZy3leTQP4I04EXBCGUcdt0x65+luEPiisi8Lsq2EVNDt+I5J2CvzZBCgadOMcTBUKV4p6WazFdiLZ9sGQzL8mLTYTFoL8MNDLV5G/RgRw6Z7dikbUYNsRFuSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E66XTuF9S6V6oDfPaAuyEjQFA8d+e4b2TR44kS+gsBU=;
 b=Y3addAchJM/Dn4Kt6MBFaWQh54nGAPGWIDdRfaEQK3CLDGGk77y69lREwHmShjy3nIuc7qPfSxEQ61WqA/cZFxiDsAAi79utOxJCcAbrH6ak0igO9U51KrVCcPr9uVOZ/3Pj24iLpsGDimKrcHr+Wdz5lCC2vT7y5+kjl4+TE14J8T44xla+ni3aMuvn7ZwN/wWTs6px5miSRlhp9Cqu24i2xmBMhTykUHFtyxlnE2JCq08Xil15KZeVUQJA3dr8zIRvJqwZLxrBKbq3J16ss3JQz94zTP41yyiJatC/42qtcWLKh4iva/HBJaC9Si8ck+5pdsGo3PR5mN25qGUROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5177.eurprd04.prod.outlook.com (2603:10a6:10:20::21)
 by DBBPR04MB6236.eurprd04.prod.outlook.com (2603:10a6:10:c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 9 Dec
 2020 06:33:14 +0000
Received: from DB7PR04MB5177.eurprd04.prod.outlook.com
 ([fe80::7585:5b21:1072:f5ff]) by DB7PR04MB5177.eurprd04.prod.outlook.com
 ([fe80::7585:5b21:1072:f5ff%7]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 06:33:14 +0000
Date:   Wed, 9 Dec 2020 14:33:04 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Marc Zyngier <maz@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: "irq 4: Affinity broken due to vector space exhaustion." warning
 on restart of ttyS0 console
Message-ID: <20201209063304.GF23060@syu-laptop>
References: <3ba26c8d-04ac-1822-d5c2-4a8906f7fd9a@redhat.com>
 <871rh1gcck.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871rh1gcck.fsf@nanos.tec.linutronix.de>
X-Originating-IP: [39.12.134.194]
X-ClientProxiedBy: AM4PR0701CA0038.eurprd07.prod.outlook.com
 (2603:10a6:200:42::48) To DB7PR04MB5177.eurprd04.prod.outlook.com
 (2603:10a6:10:20::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from syu-laptop (39.12.134.194) by AM4PR0701CA0038.eurprd07.prod.outlook.com (2603:10a6:200:42::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.8 via Frontend Transport; Wed, 9 Dec 2020 06:33:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 760acda8-59c7-450e-794a-08d89c0c4e93
X-MS-TrafficTypeDiagnostic: DBBPR04MB6236:
X-Microsoft-Antispam-PRVS: <DBBPR04MB62364DCB15ECBCC159BD9C40BFCC0@DBBPR04MB6236.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nW2CkWZEW+hFVF7324YyEEdqWqnHm9MvlNjmXNNNXtcdDT/4pFjm2Ij5qcgGVO3qkRLo18BWeI/BQafCf0xnwo6OrUbobiF6kFDaNYhh4CTUvmyZnpFw8Jvj3k53SsYn1CLl44OPQoSJkk8N/+/mK+MkrbJh8GdwsJKmqqO+7DSQL7rWTmcmjO70aaIuird22wwuK6Inn+vIotFR/2R2S6UdpZD6TsxQdw/IcPNTf4vtt0sIEYDX1qwpQWcQ1Z1fmx+F/9UqlG9rpeIrxh8daUvmMsabCho8ttE4YZpYyGDWkJRU+hX2izuX+oJjbZH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(6666004)(54906003)(33656002)(7416002)(26005)(83380400001)(8676002)(4326008)(6916009)(6496006)(52116002)(1076003)(66946007)(66556008)(33716001)(2906002)(66476007)(5660300002)(186003)(956004)(55016002)(16526019)(9686003)(86362001)(508600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TkdjaGVqcWE2eWplWlljck51VTYrbXdDZHREWFduNlBpblF4UkxnODl3MnBs?=
 =?utf-8?B?dGc4VzBaZURXcjJkN3RnSUxvRlR5SzhMeHg4NjJ0TE5hNkdINnNpWFRsRTBi?=
 =?utf-8?B?VVQyVnVxbXRaZk5tVjAyaXpZekpmeUtIVGRFYUNERmRmQ3RrSUcxaTBucHB3?=
 =?utf-8?B?R1hqVWoybzlxUVUvSWlmY1lSZDJmREJya2VwUmpkSjdiSG1Xdzh3SHQxd3pw?=
 =?utf-8?B?WDlxSit1UUlMaWluVmozdk41ZGo2akM4aHJIUlBVa0kwbU5GOFRyc2Q4SzFY?=
 =?utf-8?B?MTlYejFNUjVWdnViMXlscWU0VlVMbUpqbHZBbERLNGNNamhuYjE3NWNTa0J1?=
 =?utf-8?B?dE9JbTNybFBzeDNoMkZ5U0F1VEZTTE53TkR4SXFnbWFrMlFzakt3MjM3NldM?=
 =?utf-8?B?RjFKbjNwVTJFbXhoYmdkK1VVT3A0MG9ST0U4VE9OdWhsVlgyU21RUitWUE95?=
 =?utf-8?B?aDBTM0Y1bE5UNldORXdPSnFaM0xzbVRJYkRFS2FKMEJpa1VYTGNTN2NXdVZh?=
 =?utf-8?B?d1BXeW9nMmdjcTkrclFBdjBrN3hiOWpCaFhSbjRDc09tOUN2NkhOUm0vWnVX?=
 =?utf-8?B?STVwZGYyVmRLQ0MvSkpiQUtVMWtRdkkyM09GckJaaEZwTmZkRHd5MzlYaVVk?=
 =?utf-8?B?Qk9VcUwySXFkMVNtVzRjYXB5MTJoR1JZR1NzckdJaTBSQkdxMkVWQTZVb3NO?=
 =?utf-8?B?b2J3eWdPSG9tMC9MMTlwVzVhZVVkKzgyalExN2R2VmQ4cEwzdDZ3dHdkZjEv?=
 =?utf-8?B?VC93aVVUMTExcmZjck9SYTVEdXBGMnB2bG1nNkd4UG8zSzhldFBDeEFlZk1J?=
 =?utf-8?B?eVVPZUpVTktjakdEdWVBSUc1RktZWWMyMVFuMjlIeFUrb0FzVFYvTkRnWUs2?=
 =?utf-8?B?V3AvcnQyMk1XK0NiWFdtWmpuQlBteWNHczZ1dG8wLy9OakV0T1FqdnVVeFlH?=
 =?utf-8?B?dVBkLzd5ZVZDMURocEZ1YjlQQ1NXdHBxNWNicm9td092ZXc0TFY2NFFOaGor?=
 =?utf-8?B?Q1RjQ21ZNHhCcTFJd0Z0eWJGcGx5Y01SUTJWbXdtQitRTGFPMFRURFpEcE5N?=
 =?utf-8?B?VHpUWXpVYTROL1RZbTc2cVpuVlVTY1lhZU8vejdsbE1yWG5MOWFGYXRwZjhm?=
 =?utf-8?B?R2lHdFRIaEJzT2lOTU92bzVnbDJLUXFUeWZwSENBTXZqZHNMOHBldlI2aWU3?=
 =?utf-8?B?SjJJVDVMTHkzMVVHY3J2SlYyR1hhWklQc0pzMW1McG1nYXFEOTV6dyt3MUNR?=
 =?utf-8?B?Qm9SeUQ5L0tiaW83TTdDY2lIdW1RYllhUUM1TnBvd1o5cXJ6U1hiamtMS0dN?=
 =?utf-8?Q?THj9BTFNdkfBOMaEJDQICqvuagkeasgBR2?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 06:33:14.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 760acda8-59c7-450e-794a-08d89c0c4e93
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFq+mdbXV6GXiCKBPgdooaFsv1zZ5CwqzwJ9O7HtpjmiyGQ7XLZjE4YZRdDi7lBqGWGKvIZEF6Gdi/nkqA/Zrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6236
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Nov 10, 2020 at 09:56:27PM +0100, Thomas Gleixner wrote:
> The real problem is irqbalanced aggressively exhausting the vector space
> of a _whole_ socket to the point that there is not a single vector left
> for serial. That's the problem you want to fix.

I believe this warning also gets triggered even when there's _no_ vector
exhaustion.

This seem to happen when the IRQ's affinity mask is set (wrongly) to CPUs on
a different NUMA node (e.g. cpumask_of_node(1) when the irqd->irq == 0).

  $ lscpu
  ...
  NUMA node0 CPU(s):   0-25,52-77
  NUMA node1 CPU(s):   26-51,78-103

  $ cat /sys/kernel/debug/tracing/trace
           ...
  irqbalance-1994    [017] d...    74.912799: irq_matrix_alloc: bit=33 cpu=26 online=1 avl=198 alloc=3 managed=1 online_maps=104 global_avl=20687, global_rsvd=341, total_alloc=217
  irqbalance-1994    [017] d...    74.912802: vector_alloc: irq=4 vector=33 reserved=0 ret=0
  irqbalance-1994    [017] d...    74.912804: vector_update: irq=4 vector=33 cpu=26 prev_vector=33 prev_cpu=7
  irqbalance-1994    [017] d...    74.912805: vector_config: irq=4 vector=33 cpu=26 apicdest=0x00000040
      <idle>-0       [007] d.h.    74.970733: vector_free_moved: irq=4 cpu=7 vector=33 is_managed=0
      <idle>-0       [007] d.h.    74.970738: irq_matrix_free: bit=33 cpu=7 online=1 avl=200 alloc=1 managed=1 online_maps=104 global_avl=20687, global_rsvd=341, total_alloc=217
           ...
    (agetty)-3004    [047] d...    81.731231: vector_deactivate: irq=4 is_managed=0 can_reserve=1 reserve=0
    (agetty)-3004    [047] d...    81.738035: vector_clear: irq=4 vector=33 cpu=26 prev_vector=0 prev_cpu=7
    (agetty)-3004    [047] d...    81.738040: irq_matrix_free: bit=33 cpu=26 online=1 avl=199 alloc=2 managed=1 online_maps=104 global_avl=20689, global_rsvd=341, total_alloc=215
    (agetty)-3004    [047] d...    81.738046: irq_matrix_reserve: online_maps=104 global_avl=20689, global_rsvd=342, total_alloc=215
    (agetty)-3004    [047] d...    81.766739: vector_reserve: irq=4 ret=0
    (agetty)-3004    [047] d...    81.766741: vector_config: irq=4 vector=239 cpu=0 apicdest=0x00000000
    (agetty)-3004    [047] d...    81.777152: vector_activate: irq=4 is_managed=0 can_reserve=1 reserve=0
    (agetty)-3004    [047] d...    81.777157: vector_alloc: irq=4 vector=0 reserved=1 ret=-22
    ----------------------------------------> irq_matrix_alloc() failed with
                                              EINVAL because the cpumask
                                              passed in is empty, which is a
                                              result of affmask being
                                              (ff,ffffc000,000fffff,fc000000)
                                              and cpumask_of_node(node)
                                              being
                                              (00,00003fff,fff00000,03ffffff). 

    (agetty)-3004    [047] d...    81.789349: irq_matrix_alloc: bit=33 cpu=1 online=1 avl=199 alloc=2 managed=1 online_maps=104 global_avl=20688, global_rsvd=341, total_alloc=216
    (agetty)-3004    [047] d...    81.789351: vector_alloc: irq=4 vector=33 reserved=1 ret=0
    (agetty)-3004    [047] d...    81.789353: vector_update: irq=4 vector=33 cpu=1 prev_vector=0 prev_cpu=26
    (agetty)-3004    [047] d...    81.789355: vector_config: irq=4 vector=33 cpu=1 apicdest=0x00000002
    ----------------------------------------> "irq 4: Affinity broken due to
                                              vector space exhaustion."
                                              warning shows up

    (agetty)-3004    [047] d...    81.900783: irq_matrix_alloc: bit=33 cpu=26 online=1 avl=198 alloc=3 managed=1 online_maps=104 global_avl=20687, global_rsvd=341, total_alloc=217
    (agetty)-3004    [047] d...    82.053535: vector_alloc: irq=4 vector=33 reserved=0 ret=0
    (agetty)-3004    [047] d...    82.053536: vector_update: irq=4 vector=33 cpu=26 prev_vector=33 prev_cpu=1
    (agetty)-3004    [047] d...    82.053538: vector_config: irq=4 vector=33 cpu=26 apicdest=0x00000040


Shung-Hsi Yu

