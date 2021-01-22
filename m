Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D932FFBE9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 05:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbhAVEou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 23:44:50 -0500
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:10977
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbhAVEos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 23:44:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fU7Hd/R6NOZ13LQvP6CEhTPzk4jSwfDn6W0zZsx8Y3ARxSM/ayqx45xwDJrJ+8guKldqRzxMJFwCAwX2vMGrUwvZsr6SjzHkC73EcW1aJNl17w9FQX9RRhfA+iE1oODbgAUYAR/2awoKLr/E/dHhHk7Bbn9w/irxafA7Nifi6SOSNkujfzeITZl1ZFbpUCNTq/9lNLQb3QW1uIcRrq5HRLZgBXz+cklxBzWlJIhieXLL6YXpw0PcFSlFC6i89vKgXonPKDkPzFbqIgjzFdYc5hy8UAGYSSnf0PBNTdV+igQIsn0Oxqgu8eZ+Uuee0CSVQos5QyRnL37MtA8APtE5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHr24IQ8L0IFcZYK4Y773H0mmJjWT8rRqCAURWXULBM=;
 b=nW6a4x/TaQHKa3iSo5wg1rJTrGVuE49JXxSNc6cvklX97OCXBh0/OnERXDUQMDu6LiLvFOHGU7EGVZVALjPQJSrGJ1zNbn9mNhi8V8N7xw3Leqztf/Tegihb+l2otnZdvZ0sDxhTqskU2wqbuilolmtG5rKqnm/7dmgkgCGFq/Y96kpZriIQyv5LFE7Ed90x6Ma9q+f2k6G1AJM5aWGsBPfsx4qOV9fJUngSR/cq1ej7RCitUOJgJ4cpqLarZ5r/c/2JWJDJjZ9YTJsh1tfNbnLrJKG8DybojQT1vB9MLpbfrX4AGU2eJxa+wAfWB1OcWztXhdb72GhqRWM/4uJnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHr24IQ8L0IFcZYK4Y773H0mmJjWT8rRqCAURWXULBM=;
 b=TE3fKkJpbXac1IslwbglrfuRCkH8IPKXhTAruVpCUuap/Exx/z+gIpHuBdsMzuSefrh33uzHuRWFIvWYcgRZ5Wdqdklgn5S8HKb+MxgiTGXtzQjxYKL6uITJWVMEeb3U5BzRcJvn+3xssQIFO6AzhZ9/TBirNizoMW8eRfZalf4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 22 Jan
 2021 04:44:00 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 04:44:00 +0000
Date:   Thu, 21 Jan 2021 23:43:58 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()
Message-ID: <20210122044357.GS16838@windriver.com>
References: <20210121223355.59780-1-paul.gortmaker@windriver.com>
 <20210121223355.59780-4-paul.gortmaker@windriver.com>
 <CAAH8bW8GYYsHy7c8KD3EL+a1mR+wCrj7WFS+Gp5=4CJbz7GpgA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW8GYYsHy7c8KD3EL+a1mR+wCrj7WFS+Gp5=4CJbz7GpgA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::46) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTOPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 04:43:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c043b9b3-2f6f-40e7-360e-08d8be905603
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-Microsoft-Antispam-PRVS: <DM6PR11MB276383E68E8C16DAD502A7A883A09@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JIoCkYScugnj7OcAma+cReRCZt9avwvCSoXd41JWL1VbvGO09B4Gfi/RoQjrEvrDg7LCfcZEP2d4Bx5K9GvpESoVchv9drwC84cgmh7inzMmOLXW0w8j8nrIDido9FI6EE3WLyq3z82lELjxIe9UF6VWxdR+PsHIoLG+JMgrYFDswiNsJZKHHZ7LVWzp9tGFG47kpmoLMVFjkIRkxdq68sTIOAldMwc+oOKYzvCdNsbZBMQEx73rLgkdTvAwxnz7lHpT4zS4WiGD+Gn/ZGE/cM2LxrWVeDzfMqSKDO0meIUCrSmX8kHrxKhmJUp2LIRciI5vqB1GsUL9mG3wrj+pwTdrub2ZJvZ+A1JO4W7cqbTA/AC8Lby/6FmcFZvunp1GkZsq4KouvonZjop5cJecw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(66556008)(8676002)(4326008)(66946007)(8936002)(55016002)(86362001)(478600001)(66476007)(36756003)(33656002)(53546011)(44832011)(2906002)(6916009)(2616005)(316002)(83380400001)(26005)(8886007)(5660300002)(186003)(16526019)(956004)(52116002)(54906003)(1076003)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1+1d8w81WrJM5Oqu4aTAmJ1wC+a1azUf69SuODHoYJERbrkersWV3AoXhso/?=
 =?us-ascii?Q?pC3JQsW4vvwzM5psDimy+mt0z/HXQgUTF3g53OMZHo9C8nO3E0Zjk00NAyUt?=
 =?us-ascii?Q?gHLkAcSY3lyIMgzXbehptLgMRk5/r+9/pn9DKcNoSKDtUTes+tFZseFx1iXf?=
 =?us-ascii?Q?z4e6l8R5wKGxriOoL1bYQ1b7/ch6cefwzC1QWd4rjQwYHFF/2sG+DXoY7d+/?=
 =?us-ascii?Q?5TlqBKqhwa4lNwmSORZySVeOj4u73YYKt2Vm8OI1Z/d9hsk78zGzzXpSfejb?=
 =?us-ascii?Q?ykxXoMGrWF9UBGJ26HNsH9Mm1YC3R2RkW81sT6m/fOK6xD9sZ7lUN/uX7y4R?=
 =?us-ascii?Q?pFDx+wkqV3HGq7I4hvsIA5PVDu2AtEgdQ3xxsGFgj628pX8XWk7SV5CAaPI0?=
 =?us-ascii?Q?0kujU0o/bgB4nKszl5KUA/KOc0U/6I7S8bKozIfso/Gy9oPtFGUL/Lq3MRtN?=
 =?us-ascii?Q?FumjOMwv0ScReQE1JfDdNuLGTEanUGplrjePiQyaGUrFGDLoLaCmc9QvCx6N?=
 =?us-ascii?Q?CEv6ocIxwyCIQyFcDcQmmEzlJ5lAc+TuPonFsH+tzKvob8IYQUA7UOxqloD0?=
 =?us-ascii?Q?HzvefWlam3Hxwj299qOq5L6KoO6VJFyviqgS4GcBPYRtIIh+QIThNtYKQmYQ?=
 =?us-ascii?Q?B5sqeWeyQnoz9UiszsARJ4QligcZ5509+H5oytHXm9im5sw1N66YRa76o8bN?=
 =?us-ascii?Q?Ob5Z78KlyLN5i5ZDr0Mer7WDHV+5HHctzdgfm0lqw07EODmuQ88Vmks5ONJ1?=
 =?us-ascii?Q?HTIp7Ly2iBM1X7/BuBLypkqI48EJbG6io90TEi9zFQvksbiMOZfdW0aeQgoz?=
 =?us-ascii?Q?i0wzk1gMipQiJG653T81xXoVq2A0yEThNLpWyq+f2kfwJ36eqwPUE4BXrgVq?=
 =?us-ascii?Q?6X8jvi01lkQEexdSTjMZ4M9VIzVKeEWIUkvM6L1PlwdHCJoUhC3nFYR+cI/v?=
 =?us-ascii?Q?oSDFwV7PDK76GYp779JoQ9z04XFXeLG/3MOoxIa6H5oY7hkuwGdKzBEqU5F5?=
 =?us-ascii?Q?XVm2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c043b9b3-2f6f-40e7-360e-08d8be905603
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 04:44:00.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAMxtP66qkNuC+8HGqwYZrwqvhgyQFUxEYWkxeb1TBCk9kdwsNMH2NVywB4f8tsawwPodB5sDIp7WLGC8IS3BI/jHqJfeH7lasvolvNr1YE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 3/3] lib: support N as end of range in bitmap_parselist()] On 21/01/2021 (Thu 16:29) Yury Norov wrote:

> On Thu, Jan 21, 2021 at 2:34 PM Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> >
> > While this is done for all bitmaps, the original use case in mind was
> > for CPU masks and cpulist_parse().  Credit to Yury who suggested to
> > push it down from CPU subsys to bitmap - it simplified things a lot.
> 
> Can you convert your credit to Suggested-by or Reviewed-by? :)

Sure, of course.

[...]

> > diff --git a/lib/bitmap.c b/lib/bitmap.c
> > index a1010646fbe5..d498ea9d526b 100644
> > --- a/lib/bitmap.c
> > +++ b/lib/bitmap.c
> > @@ -571,7 +571,7 @@ static const char *bitmap_find_region_reverse(const char *start, const char *end
> >         return end;
> >  }
> >
> > -static const char *bitmap_parse_region(const char *str, struct region *r)
> > +static const char *bitmap_parse_region(const char *str, struct region *r, int nmaskbits)
> >  {
> 
> in bitmap_parselist() you can store nmaskbits in the struct region, and avoid
> passing nmaskbits as a parameter.

OK.   FWIW, I considered that and went with the param so as to not open
the door to someone possibly using an uninitialized struct value later.

> >         str = bitmap_getnum(str, &r->start);
> >         if (IS_ERR(str))
> > @@ -583,9 +583,15 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> >         if (*str != '-')
> >                 return ERR_PTR(-EINVAL);
> >
> > -       str = bitmap_getnum(str + 1, &r->end);
> > -       if (IS_ERR(str))
> > -               return str;
> > +       str++;
> > +       if (*str == 'N') {
> > +               r->end = nmaskbits - 1;
> > +               str++;
> > +       } else {
> > +               str = bitmap_getnum(str, &r->end);
> > +               if (IS_ERR(str))
> > +                       return str;
> > +       }
> 
> Indeed it's much simpler. But I don't like that you increase the nesting level.
> Can you keep bitmap_parse_region() a single-tab style function?

Rather a strict coding style, but we can replace with:

       if (*str == 'N') {
               r->end = nmaskbits - 1;
               str++;
       } else {
               str = bitmap_getnum(str, &r->end);
       }

       if (IS_ERR(str))
               return str;

Is that what you were after?

> What about group size? Are you going to support N there, like "0-N:5/N"?

No.  I would think that the group size has to be less than 1/2 of
the nmaskbits or you get the rather pointless case of just one group.
Plus conflating "end of range" with "group size" just adds confusion.
So it is currently not legal:

root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 4-N:2/4 > cpuset.cpus
root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
4-5,8-9,12-13
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 4-N:2/N > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo#

> What about "N-N"? Is it legal? Maybe hide new logic in bitmap_getnum()?

The "N-N" is also not supported/legal.  The allowed use is listed as
being for the end of a range only.  The code enforces this by ensuring
the char previous is a '-'  ; hence a leading N is invalid:

root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 0-N > cpuset.cpus
root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
0-15
root@hackbox:/sys/fs/cgroup/cpuset/foo#

I think "use for end of range only" makes sense in the mathematical
sense most of us have seen during school:  {0, 1, 2, ...  N-1, N} as
used in the end point of a range of numbers.  I could make the "only"
part more explicit and concrete in the comments/docs if desired.

I'm not sure I see the value in complicating things in order to add
or extend support to non-intuitive use cases beyond that - to me that
seems to just make things more confusing for end users.  But again
if you've something in mind that I'm simply missing, then by all
means please elaborate.

> I would also like to see tests covering new functionality. As a user of "N",
> I want to be 100% sure that this "N" is a full equivalent of NR_CPUS, including
> error codes that the parser returns. Otherwise it will be hard to maintain the
> transition.

That is a reasonable request.  I will look into adding "N" based type
tests to the existing bitmap test cases in a separate commit.

Thanks,
Paul.
--

> 
> >         if (end_of_region(*str))
> >                 goto no_pattern;
> > @@ -628,6 +634,8 @@ static const char *bitmap_parse_region(const char *str, struct region *r)
> >   * Syntax: range:used_size/group_size
> >   * Example: 0-1023:2/256 ==> 0,1,256,257,512,513,768,769
> >   * Optionally the self-descriptive "all" or "none" can be used.
> > + * The value 'N' can be used as the end of a range to indicate the maximum
> > + * allowed value; i.e (nmaskbits - 1).
> >   *
> >   * Returns: 0 on success, -errno on invalid input strings. Error values:
> >   *
> > @@ -656,7 +664,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> >                 if (buf == NULL)
> >                         return 0;
> >
> > -               buf = bitmap_parse_region(buf, &r);
> > +               buf = bitmap_parse_region(buf, &r, nmaskbits);
> >                 if (IS_ERR(buf))
> >                         return PTR_ERR(buf);
> >
> > --
> > 2.17.1
> >
