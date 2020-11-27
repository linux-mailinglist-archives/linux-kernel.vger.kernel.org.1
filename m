Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7A52C6AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbgK0RnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:43:23 -0500
Received: from mail-dm6nam12on2044.outbound.protection.outlook.com ([40.107.243.44]:48149
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbgK0RnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:43:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkw3/Mmwy/MTl5g2Sl6ShQlaiIdpJxB/LKihdf6i/wPMIUaYbfd0XDuG+qFJH6U/Mx3w86W9rslGMfiMlVxCeGzwU3OGjX9W4Hd/YkA9KR8tCWhgLfJU/PyM95gL144U++wrGytatJ8VTJ5tEj/RW6Jh9q//wTuj+s+fmM4TEw9Q51BnLMqgc7oSaXCx0GQhfROROjkKdvh7/j9Z+NOp31n2JYZeKXhFprdDAlSrvbUNUWHTmoqA4DV67oEiT7sbBqD26lKFisMF/G+3vLGxlobjWkNv+g3MRJJgTpLR9WnGXyKJ8CvON41PPGegeCcwhWTFIGRWc4uwX791vrq3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WsB28z3jvsE5WjMmXnn24zsOxLmhWOEMB9TI10JkuY=;
 b=g60mBunMLx1rFDjMLxGMTe57g2osG8bWJvRTey0nr8jMUaCCHcaBq5XSLEANI0e/+5hgu6uZBk8Wjdl9+eJS0W30cQC/WAVeCBvqEH6PwsXj6bzXe0HRaBkqLI7OdMmna6mEqdkJZeGrVPzKO6e1LYMzBqxUJrUFIoHYCLoIH6MrFNKa5j6gq3wn3rBlSryKN3WIsq2PRuP2OTqP/ea+By7yliGq8txn9/WCHI4YKyGyVZcDLIyLQocOwq9ag9WJVTe+59TxyFOf5voHs4ny/x/V2KCmWyGJyJS6gmgw9DJTgIOnF251XPNIW8XRiaYiV7SKhu8SB4DklabFAgx+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WsB28z3jvsE5WjMmXnn24zsOxLmhWOEMB9TI10JkuY=;
 b=Fjce5X76Q81OFHmE/MxCcDICejX7knKL/KpnKxcD+mt04j2+AOmWeGSmikLq4JqAFuL9zMDVy+dOckSkAL0jv++2w2SiRYcMDXlgRw6SISObS2cB4swJwcKD/C+u7mlGoyDoNECkZzhF+afh1UkXU2RrsiDMAvapJmV5dUYl/T4=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2825.namprd11.prod.outlook.com (2603:10b6:5:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 27 Nov
 2020 17:43:19 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 17:43:19 +0000
Date:   Fri, 27 Nov 2020 12:43:16 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <20201127174316.GA11748@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
 <X8ElwBh9tw+OLHF+@alley>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8ElwBh9tw+OLHF+@alley>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::16) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 17:43:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c60e47d5-4ca5-43c2-9113-08d892fbed5e
X-MS-TrafficTypeDiagnostic: DM6PR11MB2825:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2825F870C0858658CC39C96283F80@DM6PR11MB2825.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zp1Aq/ECPeUh1bKpps0A3jGQRY3FgEulRTfv6stuSXknBDQ8bpHrS12nfhM5KORYpRfZ5TDZ23k0/kMlvHpPZ5BhKx95fT/5vsOBuP2I7E48Vg9VgmMFDZd7vhZVq31EBoyFCX953b6fsQvuj+C1tYDVqaeYCcBsHwnamrlRZxAzbxMUB7OAQYeoNnb3e49RJ9lrMb8IzXSPj8p2vB8FvT9Pr3ePaK7VEX74sIxg6tcsZWTt3lodwExSUJe5ROxcRSZgtpOW4gtEt+INsXZshPoSWfarbsCxO2Mn44KnXUwrVM7NjTLzhkCCv2MN39R+OfQrhjYmfVL2XsfikctIdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(1076003)(83380400001)(55016002)(2616005)(316002)(44832011)(26005)(54906003)(66556008)(186003)(16526019)(5660300002)(66946007)(2906002)(33656002)(956004)(66476007)(6916009)(8886007)(36756003)(86362001)(8676002)(52116002)(4001150100001)(7696005)(4326008)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ipWpScfHemZQJ32HOhGtbAmSkDrgpf5CuMW+8rIVx4XquC75ab2rCwL5qI09?=
 =?us-ascii?Q?5ciXzahJlj6sMKAr1eCd3TkKe+eHmRk0hgXDMZkr6wlNkoNO66mDQncgXeGy?=
 =?us-ascii?Q?ZcxQzYSIUXRIaaNkKsfzzkvEA3f/L7HCunNeuJORow4UafMyAPRLT9MhDR/m?=
 =?us-ascii?Q?aTHaxFn2ziTWtQvtqNFawnJfo+5SiqPVLJ/nt9UR81tK6zgt2KqwlEeLVCFu?=
 =?us-ascii?Q?84vAiVNGtMMx0A8/blu+/xMhHC8zA/EYeB2kd7+v2861jYAJuS6+RVwexwjP?=
 =?us-ascii?Q?xTBvc0MdNm2fhD+Oyf4H7r8EFpHzA7eQskPxIapsFzE2pT8KVSc9BssZAaNw?=
 =?us-ascii?Q?eQYTeoMmvhd3IzfFaY4RbuJ3nOvfM4A4/0OQLLBnZoEZ+PFSTN7vtBkOaFpl?=
 =?us-ascii?Q?2Y4GFnfqFXSC0QKF55+fUWLJ0LaP/3XA7FltOa2pGsGJ0dUpQ5152oIKpt9N?=
 =?us-ascii?Q?JK50WjjOhpuGATPwuSn/d6JmaNvv5sRk+dIK64BzzXaKkP4+Dmnp+ji6nWxO?=
 =?us-ascii?Q?vpuBAJQ9iwS7PE1MuCr9dPN3UcOxouacma8okj8R19XZesU7IpFXXjaOy7+c?=
 =?us-ascii?Q?Kiwx9kX4y5UxEOkUfvn7XzoqedkNGAg/9mLufg/G31djtoBDIVCAyGq780SB?=
 =?us-ascii?Q?sx0RpB6WKsKbFUfQ1SBhANJD0IgPykyW+jUofbBhHYvcMm/DBQ6l4bvLnQw5?=
 =?us-ascii?Q?3ZavuujyTvwh4p2j+TDAVNQJEa9MEnjl8wA4sIY9zdLVc4iFJk8rmJxnHM9q?=
 =?us-ascii?Q?l6h6rIeFjXf5mt3CCpMMDHJIeUtAjUI5LlNX7Bv+rPklKjSWg+aoiIo0X85y?=
 =?us-ascii?Q?5BNk8n8u/aPYzk7mQIoDrBFgvHhoXT3pDHXFgSczxgux8L4Cs0QozfuAv37s?=
 =?us-ascii?Q?OWqL+gc8BZhjv6BjL4gbLKwL0dE1NNhqsuZHJXw0QRezKUVOPvQ9TLmoJxGb?=
 =?us-ascii?Q?OAAzRi0cp5BgINyk8ObK3YZdQXqVX0NqPzJ/FVCHjnjDYAVWts7ybUo69T5C?=
 =?us-ascii?Q?mm9K?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60e47d5-4ca5-43c2-9113-08d892fbed5e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 17:43:19.1442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgeBIbA8rIctP3kEuxftIaykuoFhTcvNrUIIAupJNFORVPvoy05EpROgsam9hR+Mzy6jz59NatVNqAC1DoZwMGgE25Ovth1SjzqczMwWdYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2825
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 0/3] clear_warn_once: add timed interval resetting] On 27/11/2020 (Fri 17:13) Petr Mladek wrote:

> On Thu 2020-11-26 01:30:26, Paul Gortmaker wrote:
> > The existing clear_warn_once functionality is currently a manually
> > issued state reset via the file /sys/kernel/debug/clear_warn_once when
> > debugfs is mounted.  The idea being that a developer would be running
> > some tests, like LTP or similar, and want to check reproducibility
> > without having to reboot.
> > 
> > But you currently can't make use of clear_warn_once unless you've got
> > debugfs enabled and mounted - which may not be desired by some people
> > in some deployment situations.
> > 
> > The functionality added here allows for periodic resets in addition to
> > the one-shot reset it already had.  Then we allow for a boot-time setting
> > of the periodic resets so it can be used even when debugfs isn't mounted.
> > 
> > By having a periodic reset, we also open the door for having the various
> > "once" functions act as long period ratelimited messages, where a sysadmin
> > can pick an hour or a day reset if they are facing an issue and are
> > wondering "did this just happen once, or am I only being informed once?"
> 
> What is the primary problem that you wanted to solve, please?

You've captured it exactly below.

> 
> Do you have an example what particular printk_once() you were
> interested into?

Well, the one I encounter (directly/indirectly) most is the one I
mentioned in mainline 3ec25826ae3 - the throttling one.

> I guess that the main problem is that
> /sys/kernel/debug/clear_warn_once is available only when debugfs is
> mounted. And the periodic reset is just one possible solution
> that looks like a nice to have. Do I get it correctly, please?

That is exactly it.  I wanted the functionality of the clear but w/o the
debugfs requirement, and thinking backwards from there - came up with
the timer based solution.  Other uses and/or users of the periodic reset
seemed like an added bonus.  Enabling sysadmins to be able to gather
more data upon seeing an issue seems like a good thing.

> I am not completely against the idea. But I have some concerns.
> 
> 1. It allows to convert printk_once() into printk_ratelimited()
>    with some special semantic and interface. It opens possibilities
>    for creativity. It might be good and it also might create
>    problems that are hard to foresight now.

Actually that problem, if it is one, existed as soon as clear_warn_once
feature was added to the kernel years ago in v4.x kernel version:

  (while [ 1 ] ; do echo 1 > clear_warn_once ; sleep 1 ; done) &

The printk_once is now converted to printk_ratelimited for one second.

I thought about it a bunch, and of course we have the fact that this
extension is an opt-in thing, and hence the default is unchanged and
most people won't even know it exists, unless they actively go looking
for it in order to collect more information.

>    printk_ratelimited() is problematic, definitely, see below.

I can't argue that.

> 
> 2. printk_ratelimited() is typically used when a message might get
>    printed too often. It prevents overloading consoles, log daemons.
>    Also it helps to see other messages that might get lost otherwise.
> 
>    I have seen many discussions about what is the right ratelimit
>    for a particular message. I have to admit that it was mainly
>    related to console speed. The messages were lost with slow
>    consoles. People want to see more on fast consoles.

Yeah, I've seen those too, which is typically concerned with 10-1000
printk per second - but this isn't that discussion, and I don't want
it to be that discussion.

>    The periodic warn once should not have this problem because the
>    period would typically be long. And it would produce only
>    one message on each location.

Correct.  I even entertained setting a minimum, like 1m or 5m, but then
considered the old unix rule about the kernel not setting policy.
That said, if it made people more at ease, I'd be OK with setting a 1m
minimum on the reset - I can't think of a use case where faster than
that would ever make sense.

>    The problem is that it is a global setting. It would reset
>    all printk_once() callers. And I see two problems here:
> 
>        + Periodic reset might cause printing related problems
> 	 in the wrong order. Messages from victims first. Messages
> 	 about the root of the problem later (from next cycle).
> 	 It might create confusion.

The out-of-order problem exists already just like the ratelimited
"conversion" exists already as shown above - using the same script.

That aside, the out of order problem assumes 1) you have a linked pair
printk_once("root cause") and printk_once("victim") and 2) that they are
separated in time by something on the order of minutes.  Even if both #1
and #2 are true, the sysadmin will still see the very 1st "matched pair".

At that point -- it will be the sysadmin who has enabled the reset in
order to collect more data after seeing the matched pair with the
one-shot defaults, so they know what they are looking at already.

>        + People have problems to set the right ratelimit for
> 	 a particular message. It would be even bigger problem
> 	 to set the right ratelimit for the entire system.

I can't argue with that, other than to say again that this is a
different problem space.  Even though I didn't set a minimum, the
periodic implementation itself does set a minimum of two seconds.

> I do not know. Maybe I am just too paranoid today. Anyway, there
> are other possibilities:
> 
> + Move clear_warn_once from debugfs to a location that is always
>   available. For example, into /proc

I don't have a problem with that, other than won't we have to maintain
both interfaces forever?

> + Allow to change printk_once() to printk_n_times() globally. I mean
>   that it would print the same message only N-times instead on once.
>   It will print only first few occurrences, so it will not have
>   the problem with ordering.

As per above, you have the ordering "problem" already with the existing
clear_warn_once implementation and one line added to /etc/rc.local

That aside, the printk_once and "N times" solution always have the issue
of a sysadmin thinking "oh I guess whatever the issue was, magically
fixed itself".  I've never liked that aspect, but that is the design.

You and I might go and look at the source and see it was capped at N
times, but I think it is unrealistic to think all sysadmins would.

Good questions - good feedback.  I hope my answers helped.

Paul.
--

> 
> Any other opinion?
> 
> Best Regards,
> Petr
