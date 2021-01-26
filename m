Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54E304E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390989AbhA0AbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:31:09 -0500
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:9088
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390526AbhAZRTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:19:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl/tLmgz+AVy7MMuSSA557QLxrzjdXAPrWGhOEbw7H6JnedAFHvi+koYVvxc5UDXAm5W932P4qXfx0Kfsuc7eQPYjXi7R058cKcvW51CkL1QjBht/aIRA7zkoY7GzjYQyW9UVkWm2+BWKjPh10Sbvf7T+yHgXofjWt0TczWXxKypldChcq3ffO4Y1FXcmDbu/UglnRQxIb0KgHKUXrTDEKtqAClwEsuREGd5C/B5AhzRBsYGpm01AkcSnqr+kHxIRZLHH3ZSVjtya+sMQO+NxNT47lMKVOtdwXR/GF2492fsM8ZNr97dXCc9bLW7GLXz0oVomEGSo/HEBt6ZUNzb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTMGDBmvPV+TasK3eYvYkHWPZHCuZzbnVw3mcCTSIxQ=;
 b=cG3/XrS5QgotCQs1066Vj6lW3eLxFIUWDlnMnRXwYwACJBqIo0SMRo7ZrpPak+1DjQLHqsCfYm+G/Wn1Uvzh2yreEgzIDcJK9w6rjIqwRloFakdhhbe4qVj5dxxjU327VPdMIZCxCSDDvomoyfc80R7CBYTbnVnPi5elf7rfIDImWmnIoO83Ca8TZbmFgBtmemP5+DuYonRKrwiEI4GpM0vExFwyIk8hrrbkoqVtrvd+JF12XCAVWvCTlF+ZbeMKffhRdYrpg0kGFqh8Jz7IsXAikqp15PnfOIOXAHx81IG9VayXrVerjZ8g/fvg84OUGTDFB7aC1ryGrLkUfzJWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTMGDBmvPV+TasK3eYvYkHWPZHCuZzbnVw3mcCTSIxQ=;
 b=pCxVURvQEZ55WjhwYb8y1yAZU/q3zPy4Bvd+vhhfk7LVwiPeSBuaWp/YNRDPgd3V8q40PP3IkbT6eg5qU08mWPQ8NEvKQcpvsw8r6MSgddsQJmxnYmlOEG5zkM6pCF+jB3S5iflEKnLWCIRl/2QUAhx+18p7bHne7V5H8KznTOE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2251.namprd11.prod.outlook.com (2603:10b6:4:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 17:18:14 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 17:18:14 +0000
Date:   Tue, 26 Jan 2021 12:18:12 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()
Message-ID: <20210126171811.GC23530@windriver.com>
References: <20210121223355.59780-1-paul.gortmaker@windriver.com>
 <20210121223355.59780-4-paul.gortmaker@windriver.com>
 <CAAH8bW8GYYsHy7c8KD3EL+a1mR+wCrj7WFS+Gp5=4CJbz7GpgA@mail.gmail.com>
 <20210122044357.GS16838@windriver.com>
 <CAAH8bW9UZZwnyXu5vFbxr4OpU8s-+61NzS0yg6gMGmH9Zty_mw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW9UZZwnyXu5vFbxr4OpU8s-+61NzS0yg6gMGmH9Zty_mw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Tue, 26 Jan 2021 17:18:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15f5f8d4-30ed-4b02-0ebe-08d8c21e5d78
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2251:
X-Microsoft-Antispam-PRVS: <DM5PR1101MB225120A94760AF9C73556CBB83BC9@DM5PR1101MB2251.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMBCBXXmWnBpNY5HUEKWv5Z8QSf5LPZ/sOAK+dB2IkyJXK+Ubw4fGFzEV/29lHarjlTK8gpQ1/7qpcmgmHuZSHBlUytZRiUTEpGN6ifrfVAitbiKzTbQQ/gUHkaXBYPRhOqS/e5QFmJMqtzq2wQ5S6czVz5pwhyK0owJLnC9VxU8/FUHDTnS50N2pqsGB+J5Q8ZPCdCVP2agx9SRuNHUeTFcrgQip/xSwAgVi27qYIGjnATciB6aFiFPAFsCG/fDgcPoYuAVFeCfSmXPskbGgvS8LxIk6+s6/KxNc9KWLSlVw52ckD3Mlc2V09wQmsQdpbwyxHdcmY3QdACn43qPaRZmOF+hwlNqFvN0RnTEWIldgkDAkXQSQ3pk4MTUb82ul2PLfGyMHkLUpyG7eWbi0iRnfr2DSJxoBlG7OVSvpN3I+L24KHbakETkwW0MRAU600EtEzQtw3eH8NG2gNdWqaZPYbC/NP5Fij1NkmdWvaQcyRGwbgdVtfF17TzWiqvvDmithmYYMtzzs/wmyE8e4HA1Z8+VF0WZhUM4LikpteWPTgNf6wOHb4RXdqD1oATfQIvEJLmzR59dUEe5g2V41tHr2kPlFyK115O2JWdVTig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(366004)(396003)(376002)(966005)(5660300002)(186003)(53546011)(7696005)(8886007)(26005)(8676002)(66946007)(83380400001)(55016002)(1076003)(2616005)(2906002)(44832011)(86362001)(52116002)(316002)(36756003)(33656002)(6916009)(956004)(8936002)(16526019)(66556008)(66476007)(478600001)(4326008)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bRlmer5PRiyANmkXCbJ4jxs25PeTdMITaWVwuc7fDmyLRAaE+321o8t/jn39?=
 =?us-ascii?Q?B2SIHqMNkOamZ82v2pH/9Ngbk3oRodPnGyYvOHuQC01CBp44h5rCe5T1JCPy?=
 =?us-ascii?Q?LXWUGEzbqREKFdZD5ttQjgaIX1iN/eWf2wv24lAzgirRskPzP2VfNVU44Ov0?=
 =?us-ascii?Q?7z/Yzu5iMrV+JXBnwQ9bPJ/Sq1J/jP9LyuKccB2nsUICHH24BBbeUY79gdxC?=
 =?us-ascii?Q?k7vOLdSjtd3ckcmPl7bo6Tds4+4cwMP+TAko3B1CQ+iLL9j0S07uvVjxFwi+?=
 =?us-ascii?Q?L+56JQMAM/r/lQnJjg0lqttiayl07a3SFmgM+G/StU4bOF57WHTDGdb/bPYa?=
 =?us-ascii?Q?+3ZZa+nKss/B58r4WT+Iivo3DyjoHYCTg7JIOxIxJYq8G3wDsc0ToEdCfX34?=
 =?us-ascii?Q?0RbvhusqQjZUR1nb7mia4lYQbxTMWIcejO7KS9f+nWpMeOKKkL4gUcW6fKzN?=
 =?us-ascii?Q?BXhYdg9Eck1G5ekIWPyJ2W4+JBMuuCwSyIrR+w6JgI3avIdLJxebq6kzqRXx?=
 =?us-ascii?Q?JURYvXCF6Z+jy3Ubl6ue6LdWnZ5owNsCIbbmrugLkbmwZ/fXGA51uj+sx0nA?=
 =?us-ascii?Q?V1EMbF7P9rKaSAVbryk9qTzRLZNCmm5RT6HC5nC/V1+ytMuPxmVrilwXUqE8?=
 =?us-ascii?Q?vubSq0VIm4fDFDzSsrEWfto8qc/dzudkAtRBIjW1iHK2u+z1WuLW2gGXJDO6?=
 =?us-ascii?Q?GyuWIDKAl70D7/fB2ggGN9fkgoOHz5Xxz7Cex6ci1T+JigJPGcI7x8DcPQKj?=
 =?us-ascii?Q?9mOp7e5mg3R6Fr09fvk+qii0Z3q1qD4uJ88rPH7PDz+szYd/gWKfsDDQ+kep?=
 =?us-ascii?Q?wjE+dqYmpi5tlTJG3q/If347+1EhYdovf3NPEDKmMXdwBf09eTydDrQ9f4cm?=
 =?us-ascii?Q?tAWJTBpS3Qc7+IC9mekvlJdHvsxZyT7A+sVapZPr3SAgId5k4BpIGBKj30xO?=
 =?us-ascii?Q?9aO30KhuojjTNfBfZOLtR1dMCwa66L7fOyTHv5bzVVj6ogwCH5iggdB5hnJK?=
 =?us-ascii?Q?8duMiddPvA8YDg6aPJg3e0TdGgRk5SabGIruYqW+jDTS3j0qsV4aPP0lea3L?=
 =?us-ascii?Q?sLMF0T4G?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f5f8d4-30ed-4b02-0ebe-08d8c21e5d78
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 17:18:14.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63Y0T4QMn8UO9A7UOTRolrPPVfhtXH/tMQHtXRIEElr0Csj6hm8Xx/AHe39W1tzpOdSEIm30GwBtd3i/8fu0ypJ32pdYQpKZatOPVCfGi1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2251
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()] On 22/01/2021 (Fri 15:08) Yury Norov wrote:

> On Thu, Jan 21, 2021 at 8:44 PM Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> >
> > [Re: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()] On 21/01/2021 (Thu 16:29) Yury Norov wrote:
> >
> > > On Thu, Jan 21, 2021 at 2:34 PM Paul Gortmaker
> > > <paul.gortmaker@windriver.com> wrote:
> > > >
> > > > While this is done for all bitmaps, the original use case in mind was
> > > > for CPU masks and cpulist_parse().  Credit to Yury who suggested to
> > > > push it down from CPU subsys to bitmap - it simplified things a lot.
> > >
> > > Can you convert your credit to Suggested-by or Reviewed-by? :)
> >
> > Sure, of course.

Now done for v3.

> >
> > [...]
> >
> > > > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > > > index a1010646fbe5..d498ea9d526b 100644
> > > > --- a/lib/bitmap.c
> > > > +++ b/lib/bitmap.c
> > > > @@ -571,7 +571,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
> > > >         return end;
> > > >  }
> > > >
> > > > -static const char *bitmap_parse_region(const char *str, struct region *r)
> > > > +static const char *bitmap_parse_region(const char *str, struct region *r, int nmaskbits)
> > > >  {
> > >
> > > in bitmap_parselist() you can store nmaskbits in the struct region, and avoid
> > > passing nmaskbits as a parameter.
> >
> > OK.   FWIW, I considered that and went with the param so as to not open
> > the door to someone possibly using an uninitialized struct value later.

Also now done - reduces parameter passing and enables moving a sanity
check from set_region into check_region where it IMHO belongs.

> >
> > > >         str = bitmap_getnum(str, &r->start);
> > > >         if (IS_ERR(str))
> > > > @@ -583,9 +583,15 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> > > >         if (*str != '-')
> > > >                 return ERR_PTR(-EINVAL);
> > > >
> > > > -       str = bitmap_getnum(str + 1, &r->end);
> > > > -       if (IS_ERR(str))
> > > > -               return str;
> > > > +       str++;
> > > > +       if (*str == 'N') {
> > > > +               r->end = nmaskbits - 1;
> > > > +               str++;
> > > > +       } else {
> > > > +               str = bitmap_getnum(str, &r->end);
> > > > +               if (IS_ERR(str))
> > > > +                       return str;
> > > > +       }
> > >
> > > Indeed it's much simpler. But I don't like that you increase the nesting level.
> > > Can you keep bitmap_parse_region() a single-tab style function?

No increase in nesting level in v3.

> >
> > Rather a strict coding style, but we can replace with:
> >
> >        if (*str == 'N') {
> >                r->end = nmaskbits - 1;
> >                str++;
> >        } else {
> >                str = bitmap_getnum(str, &r->end);
> >        }
> >
> >        if (IS_ERR(str))
> >                return str;
> >
> > Is that what you were after?
> >
> > > What about group size? Are you going to support N there, like "0-N:5/N"?
> >
> > No.  I would think that the group size has to be less than 1/2 of
> > the nmaskbits or you get the rather pointless case of just one group.
> > Plus conflating "end of range" with "group size" just adds confusion.
> > So it is currently not legal:
> >
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 4-N:2/4 > cpuset.cpus
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> > 4-5,8-9,12-13
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 4-N:2/N > cpuset.cpus
> > /bin/echo: write error: Invalid argument
> > root@hackbox:/sys/fs/cgroup/cpuset/foo#
> >
> > > What about "N-N"? Is it legal? Maybe hide new logic in bitmap_getnum()?
> >
> > The "N-N" is also not supported/legal.  The allowed use is listed as
> > being for the end of a range only.  The code enforces this by ensuring
> > the char previous is a '-'  ; hence a leading N is invalid:
> >
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N > cpuset.cpus
> > /bin/echo: write error: Invalid argument
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 0-N > cpuset.cpus
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> > 0-15
> > root@hackbox:/sys/fs/cgroup/cpuset/foo#
> >
> > I think "use for end of range only" makes sense in the mathematical
> > sense most of us have seen during school:  {0, 1, 2, ...  N-1, N} as
> > used in the end point of a range of numbers.  I could make the "only"
> > part more explicit and concrete in the comments/docs if desired.
> >
> > I'm not sure I see the value in complicating things in order to add
> > or extend support to non-intuitive use cases beyond that - to me that
> > seems to just make things more confusing for end users.  But again
> > if you've something in mind that I'm simply missing, then by all
> > means please elaborate.
> 
> OK, let me share my view on this. As you said in the patch description,
> N is substitution to the number of the last CPU, in your example sort of
> #define N (15).
> 
> So, when I do echo N-N > cpuset.cpus, I want it to work as if I do
> echo 15-15 > cpuset.cpus. Why? Because in my terribly huge config
> I just want to do s/15/N.

Okay, That might seem like a simple point, but it helped a lot in
letting me understand how you were looking at this and in turn what
kinds of "interesting" parameter combinations are currently accepted.

> 
> Now let's check how it works .
> 
> root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# echo 15-15>cpuset.cpus
> root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> 15
> root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# echo 0-0>cpuset.cpus
> root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> 0
> 
> OK, works as expected. And what about N?
> 
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 0-N > cpuset.cpus
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> > 0-15
> 
> OK, looks good.
> 
> > root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N > cpuset.cpus
> > /bin/echo: write error: Invalid argument
> 
> Why? If N is 15, it should work exactly as 15-15, but it doesn't...
> This is the source
> of confusion and unneeded refactoring of user scripts. (In practice of course
> nobody will use "N" because it's broken.) Documentation says nothing about
> this limitation, and this is a real example of "complicating things".

So the disconnect was that I was thinking "where does N make sense to
use" and you were thinking "N is just a number - let it be used anywhere
and let the sanity checks take care of the rest".  I can see that now.

I have added self-tests for some of these interesting (but yet valid)
inputs, like "15-15:15/15" as a way to document what is currently
supported.  I then copied those (i.e "N-N:N/N") to ensure that N is
consistent with being "just a number" as you outlined above.

> You can do better - parse "N" in bitmap_getnum() and avoid all that confusion.

N is now handled in getnum in v3 of the series and treated as simply
just another number, with no special cases related to where it appears.

> Same logic regarding all/none: all is the equivalent of 0-15, none is something
> like ", ,". Now let's try with "0-15,0-3, ," (imagine it's a result of
> merging configs).
> 
> root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# echo 0-15,0-3, , >cpuset.cpus
> root@yury-ThinkPad:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
> 0-15

Given that "none" has no users (now or envisioned) and basically amounts
to being a no-op as ", ," it seems to make sense to just drop it.  Which
made me reconsider implementing "all" as well.  Since "0-N" is the same
strlen as "all" and achieves exactly the same result, I've dropped the
idea of accepting "all" as well in the interest of keeping it simple.

Please have a look at v3 if you have the time and see if there are any
remaining things you'd like to see implemented differently, or things
I've inadvertently missed.  There are more commits (added tests) but
each change is hopefully a small, easy to review, standalone item.

It seems like vger/lkml is having some issues, but assuming the mails
eventually get through, the v3 series should get archived at:

https://lore.kernel.org/lkml/20210126171141.122639-1-paul.gortmaker@windriver.com/

Thanks,
Paul.
--

> 
> OK, works. But if I do 's/0-15/all' and 's/ /none', things get broken. This
> again brings a special case where it can be avoided - just  parse all/none
> at the beginning of bitmap_parse_region().
> 
> After reading the description, one can think that you introduce simple and
> convenient extensions to existing interface. In fact this is a new interface
> which is mostly incompatible with the existing one.
> 
> > > I would also like to see tests covering new functionality. As a user of "N",
> > > I want to be 100% sure that this "N" is a full equivalent of NR_CPUS, including
> > > error codes that the parser returns. Otherwise it will be hard to maintain the
> > > transition.
> >
> > That is a reasonable request.  I will look into adding "N" based type
> > tests to the existing bitmap test cases in a separate commit.
> >
> > Thanks,
> > Paul.
> > --
> >
> > >
> > > >         if (end_of_region(*str))
> > > >                 goto no_pattern;
> > > > @@ -628,6 +634,8 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> > > >   * Syntax: range:used_size/group_size
> > > >   * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
> > > >   * Optionally the self-descriptive "all" or "none" can be used.
> > > > + * The value 'N' can be used as the end of a range to indicate the maximum
> > > > + * allowed value; i.e (nmaskbits - 1).
> > > >   *
> > > >   * Returns: 0 on success, -errno on invalid input strings. Error values:
> > > >   *
> > > > @@ -656,7 +664,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> > > >                 if (buf == NULL)
> > > >                         return 0;
> > > >
> > > > -               buf = bitmap_parse_region(buf, &r);
> > > > +               buf = bitmap_parse_region(buf, &r, nmaskbits);
> > > >                 if (IS_ERR(buf))
> > > >                         return PTR_ERR(buf);
> > > >
> > > > --
> > > > 2.17.1
> > > >
