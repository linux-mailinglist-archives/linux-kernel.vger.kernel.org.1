Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABED2D3C07
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgLIHMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:12:22 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:35438 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbgLIHMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1607497870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OqpHLdzY6zGgHClcpxWpAm81jYeb0f8/V8d5t+bCW7E=;
        b=aRlwBnjj5Y718le1WcfKaD1GCYTNJ1a5bjtd9TvWcWVLesXmedytBplcjyG7sOGj0gWfMM
        NHrBKnPEW0TWvODHmOzgO4tIM+mf2MhWArYFXhNSt2Hr+0pwa6HashLWks9nJkJmOEVtWU
        jExeO7RvYI9Uga7eHfNY9SCmuHpKCB4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-2-NC4J9nSvPJCfpiSUgarxpQ-1; Wed, 09 Dec 2020 08:11:08 +0100
X-MC-Unique: NC4J9nSvPJCfpiSUgarxpQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3MNJe0mTPfTMHJdvRXdRBSztx+PCihfrQSUndEQBvslf6JGn/x8lJ1RqrkTXDQ3DIGf0R7NSh6PQP82kMoalBCUDYeWpJ1+QkxcmiqEijdf5n0iBi+Qq1GiGSTQr9DIGShLCOqqVlsDEibKn5rqgiEAVs3BPLUxOX28Ee24P2YfouixmS2IK/1cC9wQfogJbgx3ibH4QlSvrRoHSuxF8zOVTtsABRrkRv5K0OZYLeIXJ4x1CN5tQfUa7kinK/L1Gu1XMokaJo//pqsn0P8HQW4Q3SlB03muMCZa8YtpFZeXT3ETasNihxdkLMR8OsshpHytYGdkg5kLhF7h2bwurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqpHLdzY6zGgHClcpxWpAm81jYeb0f8/V8d5t+bCW7E=;
 b=CiSuUvkUohOKeQ5RdAnSnFP4kyLKT4yN1Td0l5yZ9F7YBxFjnMcMnj8XZEjssJOBfWVM98F+8RuoeisIH5DpA148OxQ18g001LvQHAd1D7FnmuExoW58EaGViiUyzJ6cOUsw/m5HMkzpjHmdLCBeXA7XlI/WorZE/af400eEDhq+MZywvXqvtGCKXelpwxsIClWuxfp9Z7DB/InyTxHz93tMVLE+rF+SyZUJdLHcMPA1TRyIRyicuVh6jYlhry0R3NTf0Zw5/WU4ranSL9iSSmGiuSWNb+803VK4gYPeYLFg9sJ8WhoccTFku7s2Iohvt8QnZEXlGqQ2St739j+WCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=suse.com;
Received: from DB7PR04MB5177.eurprd04.prod.outlook.com (2603:10a6:10:20::21)
 by DB7PR04MB4539.eurprd04.prod.outlook.com (2603:10a6:5:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 07:11:08 +0000
Received: from DB7PR04MB5177.eurprd04.prod.outlook.com
 ([fe80::7585:5b21:1072:f5ff]) by DB7PR04MB5177.eurprd04.prod.outlook.com
 ([fe80::7585:5b21:1072:f5ff%7]) with mapi id 15.20.3632.023; Wed, 9 Dec 2020
 07:11:07 +0000
Date:   Wed, 9 Dec 2020 15:10:57 +0800
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
Message-ID: <20201209071057.GA17640@syu-laptop>
References: <3ba26c8d-04ac-1822-d5c2-4a8906f7fd9a@redhat.com>
 <871rh1gcck.fsf@nanos.tec.linutronix.de>
 <20201209063304.GF23060@syu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209063304.GF23060@syu-laptop>
X-Originating-IP: [39.12.134.194]
X-ClientProxiedBy: AM0PR01CA0133.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::38) To DB7PR04MB5177.eurprd04.prod.outlook.com
 (2603:10a6:10:20::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from syu-laptop (39.12.134.194) by AM0PR01CA0133.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 07:11:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f691cddf-adeb-4505-e35d-08d89c1199b2
X-MS-TrafficTypeDiagnostic: DB7PR04MB4539:
X-Microsoft-Antispam-PRVS: <DB7PR04MB45395665512EE30B2A3B604ABFCC0@DB7PR04MB4539.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Im+TaPdCtgoMNS6Jc4kWrZxM7B+06BbPOWlmovQg5S420oDY4nX4Bz+NIaadeUkNWowCbmGqtxyupRzTd2Lx5jsK/41Y9WZFYhbpXW97L7NQ+THzLh8BSbnKT9sBqrqw47Ag2r0ohuQCg2rA4zNnbQzD4WR6dgGZsMxoDUPVKLyr6n2IRHJe0EpxetcBBbo7/ly/dkZcLCQ4NtgPtvTz3j421+lhxwLbIRZyL7oz4maqIFSJ9VxxtR+QFSZfTetIZm8cDgHeAGiZt2qVe8unsLMuCyYcdYaSsZ+B4jEc+urmFJF1uTvb3oPEJfPtW2Lr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB5177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(7416002)(33656002)(86362001)(26005)(186003)(16526019)(6496006)(52116002)(6666004)(54906003)(2906002)(5660300002)(6916009)(4326008)(8936002)(33716001)(9686003)(66476007)(66556008)(55016002)(83380400001)(1076003)(66946007)(508600001)(8676002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZlA1WlJVOHpJd0FleWVVR1NRaDJBbklES2NDMXBuTTczUndmTkE1M1NWMHg0?=
 =?utf-8?B?MHFiWlpYQ3dQQjAwZGJoS0poSm9rYUNMUnJRWmJZdHgzbDlyUWlzcDBwVm9N?=
 =?utf-8?B?L1JITVBIbnI5elJKWGR0WENFdUR2NjR3SGdSQXBwUk1TVmxYQTl3czZSajcx?=
 =?utf-8?B?RnlzZHF2NVJTcXZOazdEcDhWNUYycnhGdEhCbmNxQnRSNjk1S2E3Yy9HT2Vk?=
 =?utf-8?B?YXhJWDd6TlZkblJKTDVUSTNGdUN1VWEvUDlqK0w4Umxmc2Z4UGtCeXVxTXFS?=
 =?utf-8?B?ci82K1ZMeDZQWjZjL0hiMCtmR3NybWw4eU1WY2JNdnY1K2F4blYxbzFNbFZD?=
 =?utf-8?B?YnEwSm1iN2V5eGhkQS9zd0c2SXdVb2ltVlNnVGNmeG5oN2pNYzQ5NUhMSmlY?=
 =?utf-8?B?Y1F5cXFUS0JxTUladURzYmFUZlJ2RDY4bVoraDJWUGw3SnBkUXhyeTVnVXJn?=
 =?utf-8?B?K3NDTkRQOUJJVEUwUDRlaThITmhDWGJKL0NYVnBSL3VncHh1cDRrQXdhMlIw?=
 =?utf-8?B?eWlVeTZ5anNHQkRxL3VpWEt2SG5vYW93R21pMDFMeFVJamhDQU5WNUo4QVMz?=
 =?utf-8?B?WTRhZzJjVGdnYUpPcjRTaUpPWXpFYXJ4TDFQdnYxdUVKVHdjcFdyQVNhSnJ1?=
 =?utf-8?B?MC81RnowbDEwd0lPeXR3NEZjR3lOSDZTQ3FuYjdOclFZR3lhUElMTTMrWHcx?=
 =?utf-8?B?WFlzQ1Q1QTRyZktBS3VuTXpISG4vY1dsVFlSUlVISXNITFEwOUViZFcwMHhB?=
 =?utf-8?B?Y1ROa2UxLzhRYWhndGZPNU1RSjdvbUpCYk1wYlYvWEZDT2tXRWJNNkczM1JK?=
 =?utf-8?B?SUMrL0Jyejg2QjRYem8ySkgwQnBmSGN6N0NZWXRLNW9QSFZ5M0VZODdjbkh5?=
 =?utf-8?B?STJxMzJ2NlFPbVljaE1iWUNNZ3ZnanhWeTNoUXYrY29uVmtOYUJIQ2R2anpw?=
 =?utf-8?B?TmJXcGFCemFueWxEemNsM0FnUlg2UjhjNnVPNkh5QzErK0V4TERuem5PRVNi?=
 =?utf-8?B?dWNGMXdIZ1h2dCswVlFMSXlxM2c5UHVTZ3d3MG9PeHVFcGJ6bGtFYUl5ekxN?=
 =?utf-8?B?TFcxTnFqc1M5NXFFeG1FaHFPNmp2MlIrVkJnWTA1NVhhaFFlV2JvQUR1TTQx?=
 =?utf-8?B?S29LS2hMaDIzTnBMR0lBeHRrd0FlK1Y5cGJEWnE4S21HdkZaOUpQbDJtMmlw?=
 =?utf-8?B?eUxnUGo3ZUMvUHJ3RXFTVUFScUJ6aFNMM1JYbm9sVjFWTXJ3R1A1N3pPdFR4?=
 =?utf-8?B?bzVFRU1VcVVTd0xSVmhaMTdzSW1ySjZsbE9peFV1RHBsUVdtSXRZaTNFKzJ3?=
 =?utf-8?Q?QGlkdBYLpZ6e8xHHh5l7j0of7l6261uKzo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB5177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 07:11:07.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: f691cddf-adeb-4505-e35d-08d89c1199b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTAXdTGnkclVM8dGpo8HS+SJpErjlKf3b5A9tj5O8dkE0P8EzAFh3uTegahHsKomXK7/UkE3rp+0rhLkFiRhwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 02:33:04PM +0800, Shung-Hsi Yu wrote:
> Hi Thomas,
> 
> On Tue, Nov 10, 2020 at 09:56:27PM +0100, Thomas Gleixner wrote:
> > The real problem is irqbalanced aggressively exhausting the vector space
> > of a _whole_ socket to the point that there is not a single vector left
> > for serial. That's the problem you want to fix.
> 
> I believe this warning also gets triggered even when there's _no_ vector
> exhaustion.
> 
> This seem to happen when the IRQ's affinity mask is set (wrongly) to CPUs on
> a different NUMA node (e.g. cpumask_of_node(1) when the irqd->irq == 0).
                                                     typo ^^^^^^^^^^^^^^

Should be "affinity mask set to cpumask_of_node(1) when
irq_data_get_node(irqd) == 0".


Shung-Hsi

>   $ lscpu
>   ...
>   NUMA node0 CPU(s):   0-25,52-77
>   NUMA node1 CPU(s):   26-51,78-103
> 
>   $ cat /sys/kernel/debug/tracing/trace
>            ...
>   irqbalance-1994    [017] d...    74.912799: irq_matrix_alloc: bit=33 cpu=26 online=1 avl=198 alloc=3 managed=1 online_maps=104 global_avl=20687, global_rsvd=341, total_alloc=217
>   irqbalance-1994    [017] d...    74.912802: vector_alloc: irq=4 vector=33 reserved=0 ret=0
>   irqbalance-1994    [017] d...    74.912804: vector_update: irq=4 vector=33 cpu=26 prev_vector=33 prev_cpu=7
>   irqbalance-1994    [017] d...    74.912805: vector_config: irq=4 vector=33 cpu=26 apicdest=0x00000040
>       <idle>-0       [007] d.h.    74.970733: vector_free_moved: irq=4 cpu=7 vector=33 is_managed=0
>       <idle>-0       [007] d.h.    74.970738: irq_matrix_free: bit=33 cpu=7 online=1 avl=200 alloc=1 managed=1 online_maps=104 global_avl=20687, global_rsvd=341, total_alloc=217
>            ...
>     (agetty)-3004    [047] d...    81.731231: vector_deactivate: irq=4 is_managed=0 can_reserve=1 reserve=0
>     (agetty)-3004    [047] d...    81.738035: vector_clear: irq=4 vector=33 cpu=26 prev_vector=0 prev_cpu=7
>     (agetty)-3004    [047] d...    81.738040: irq_matrix_free: bit=33 cpu=26 online=1 avl=199 alloc=2 managed=1 online_maps=104 global_avl=20689, global_rsvd=341, total_alloc=215
>     (agetty)-3004    [047] d...    81.738046: irq_matrix_reserve: online_maps=104 global_avl=20689, global_rsvd=342, total_alloc=215
>     (agetty)-3004    [047] d...    81.766739: vector_reserve: irq=4 ret=0
>     (agetty)-3004    [047] d...    81.766741: vector_config: irq=4 vector=239 cpu=0 apicdest=0x00000000
>     (agetty)-3004    [047] d...    81.777152: vector_activate: irq=4 is_managed=0 can_reserve=1 reserve=0
>     (agetty)-3004    [047] d...    81.777157: vector_alloc: irq=4 vector=0 reserved=1 ret=-22
>     ----------------------------------------> irq_matrix_alloc() failed with
>                                               EINVAL because the cpumask
>                                               passed in is empty, which is a
>                                               result of affmask being
>                                               (ff,ffffc000,000fffff,fc000000)
>                                               and cpumask_of_node(node)
>                                               being
>                                               (00,00003fff,fff00000,03ffffff). 
> 
>     (agetty)-3004    [047] d...    81.789349: irq_matrix_alloc: bit=33 cpu=1 online=1 avl=199 alloc=2 managed=1 online_maps=104 global_avl=20688, global_rsvd=341, total_alloc=216
>     (agetty)-3004    [047] d...    81.789351: vector_alloc: irq=4 vector=33 reserved=1 ret=0
>     (agetty)-3004    [047] d...    81.789353: vector_update: irq=4 vector=33 cpu=1 prev_vector=0 prev_cpu=26
>     (agetty)-3004    [047] d...    81.789355: vector_config: irq=4 vector=33 cpu=1 apicdest=0x00000002
>     ----------------------------------------> "irq 4: Affinity broken due to
>                                               vector space exhaustion."
>                                               warning shows up
> 
>     (agetty)-3004    [047] d...    81.900783: irq_matrix_alloc: bit=33 cpu=26 online=1 avl=198 alloc=3 managed=1 online_maps=104 global_avl=20687, global_rsvd=341, total_alloc=217
>     (agetty)-3004    [047] d...    82.053535: vector_alloc: irq=4 vector=33 reserved=0 ret=0
>     (agetty)-3004    [047] d...    82.053536: vector_update: irq=4 vector=33 cpu=26 prev_vector=33 prev_cpu=1
>     (agetty)-3004    [047] d...    82.053538: vector_config: irq=4 vector=33 cpu=26 apicdest=0x00000040

