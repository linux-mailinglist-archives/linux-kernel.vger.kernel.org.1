Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396942FFBC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 05:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbhAVEfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 23:35:20 -0500
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:23521
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbhAVEfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 23:35:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP90jtFblhpgQB5lwTlucipH+Qp0H2H3nQJK63//3btnIBJ2Z0YPsW7tXL+P0dbOUG09bYtZ+Pv0ubCPVoGBemlzlgr69bSEHFtdQmJE4BjehwD2VdF4efqTLilNmMYapWD+xeolpT/Phm0c93VLmZtpSDQIcMgrfntpx26nWM512syVW8KA0xkz3UdfkJvjWjLSzvdDsJcq1onoI5yYxUcTyJr4q2n2OXtrRXGzC+M/OtaYP8yvP+HvdFLYxu5aVvMpoREJX9BC2Mf9scCFuSqn2/uEGEFSBe+A7XKgIht2EDobUeq29rayOKBzqVk8SAnOBU1UnH/4P1lUhHUUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17I2j3wGju5+SAta/m0t0fQRkdEgVy7ELsijfElGplw=;
 b=HDT5Cd2M6SPwecn9vhFCHlubjcQjvmzmjyKr0a1iIrdQkAZLvp/2JLf6uaMib+UTyFSDmYgR/of6/sUZHsMbcFKXx79Hs24yPf0jUWgUNLTZnDKBUqOu9Ubi+39IpFH0DU1S9opnrzetRuY1MNYEU9fMgWtRpUSCL6rl0UPpyesDZaalRGNEL54ktgNcLrFzgm2bLTmCrtJ2RyLKK0D72tQnmZeLLl6lSitZxqMxc6g1xN0M8icwUfFsq7fve8sdAuIIB5jsL5e1l8KBTVcg3vEJyikrKPnIF8wQEpRWH9LSDATqErrR7NJX44lsBHPzUIt0tgKmPJSMG9x3AWuAOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17I2j3wGju5+SAta/m0t0fQRkdEgVy7ELsijfElGplw=;
 b=QEG28D/Y4lOeeplFfb+E4cPkCx8/7Q6F7efHOaqs0fRfwfAwXQSdlGH0S0is8W+d6WbTUuKepAN+Pipx2EuP2lg23OyMVaIliguE4mulFYdWD9CZJOe86idUyV6zVDoM0nQPn35hfr7Gq2mLU9+EopB8OjldI3TyOmKkdOjuyOk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2763.namprd11.prod.outlook.com (2603:10b6:5:c6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 22 Jan
 2021 04:34:24 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 04:34:24 +0000
Date:   Thu, 21 Jan 2021 23:34:22 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 1/3] lib: add "all" and "none" as valid ranges to
 bitmap_parselist()
Message-ID: <20210122043421.GR16838@windriver.com>
References: <20210121223355.59780-1-paul.gortmaker@windriver.com>
 <20210121223355.59780-2-paul.gortmaker@windriver.com>
 <CAAH8bW8KKXnMqs-NEeB90emUz6o2Q1FLutYEAmG3cAwv0rwEhg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW8KKXnMqs-NEeB90emUz6o2Q1FLutYEAmG3cAwv0rwEhg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::23) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTXPR0101CA0010.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 04:34:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d41e7cd-0e88-4991-2aba-08d8be8eff03
X-MS-TrafficTypeDiagnostic: DM6PR11MB2763:
X-Microsoft-Antispam-PRVS: <DM6PR11MB2763417A25F3D98C18B34E1083A09@DM6PR11MB2763.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpPSm3MptYWotHUnR0nzHKnxNbdvYhGwudE7v9sjAi/822HYIR3k7uoEj4vECgAI5kKETBOVwqY4tejSdkce2hbterBRQ6cbDij+irAQcuqlApMdOW3qfxuevVB+MvWH7N2RErop9CZ9vkY0dcg5wn9X8hFJqK/kYK7CAfZ6PN3wD+uJMpCjpqoeuVNPT/bUaqaLSfCQsd8R/RvWHRojnS4+dFzfanPVmNQxhTsy7Ba+0P/RsaSnw6n1oQuunrGe7thEQypkF0Yj9lI73GFybNDtmQfvZ8JYiu7FnYbnw4XUWQBbALEA6jQRGLBGnGb/LP1qA8b2Iwo8Ig681x75sOeQtSEONueqWIeOMrg82bSSJZpGG3tri2kTsgLWne6RFMjWvYpABKciAHUzhHasJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39850400004)(396003)(376002)(2906002)(6916009)(2616005)(26005)(83380400001)(316002)(44832011)(53546011)(8886007)(16526019)(54906003)(1076003)(7696005)(52116002)(956004)(186003)(5660300002)(55016002)(8936002)(478600001)(86362001)(8676002)(4326008)(66946007)(66556008)(36756003)(33656002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bSfEfMcBuMwzpnYFJ+kVPrBEsO5Q5WmUfWumNlDI3FEGrTyWV3nlfdXCMOb2?=
 =?us-ascii?Q?ouL9lACYCdzp3oEoE1EzaZZHaqDmQpWsqI4Hkov8mgkcxBlE/75EJn4zcwAa?=
 =?us-ascii?Q?2H2Unzyyu0L1MtPpmWviVzIKTNJQPLG/itAv6v1hxNPbY4hxhdhfgysHVFUd?=
 =?us-ascii?Q?Kab1Pd8o/ECkHhiOHi6wT402Bk2YfmUaFWrc25i5p9sbdNQrkBQDbUqPT4ve?=
 =?us-ascii?Q?//oHiBBc/AJsV3DhZlI0vYHz71Ouv+Lxy8lR2vF6hCX3Jsp+pgXNbaJWXfCG?=
 =?us-ascii?Q?h+7DGW7AjLc5KZXmgXKC5U6G+DjTaUMbHUEqPlyNOeG0oHO5SgDpLSK3e9Dl?=
 =?us-ascii?Q?Ye9QQQ7NUrTjoVylAkERjGeehHSXzQ0SedkyU5GOnotlG7W5/W62ic4fgoYn?=
 =?us-ascii?Q?uosCivWdLxP6Ni4qU7QGSoSBm2bKIWW/iVeqMaRD8yYJdfDIb7nyTqaF0ZiZ?=
 =?us-ascii?Q?pR4UgDbeayJl69mDK5UuA+TsQ6MTVul5AeR5OGXDvK3WLmxVbT/LAGrj7Y6I?=
 =?us-ascii?Q?OkGPEAgKOGPI8e+2e8t5tN/pqU+l7h8uLQ4mEYX4j5i6Jq0rJb5e7go/BsdQ?=
 =?us-ascii?Q?L01mW+0WS85HJoLgfsFsixBRMckx7QbycsjbVXLMCuQ9K23pj8PP0q0Kngpu?=
 =?us-ascii?Q?4T10JPo0J9BIpdwl3JxeUFAciy9x+ZYqMQFQmhMxT3HoAYUeGyt8X9Zh2e0d?=
 =?us-ascii?Q?ETUwo5SGRNmou47a6WjWh6Vtl7ULGgB2kcE6lMUZdX8eCHFspB4lG9CJCipm?=
 =?us-ascii?Q?giD0auLEi1BN3fapUyCluEp02rlF+1RYXvjR1Z8gQi+N8BhfsDO+LjRUTNlw?=
 =?us-ascii?Q?SmEBjfylnVwCioyiEErrxji0aMhlAKQR4GrDjH8mI5CvYW8f/05htSOGoall?=
 =?us-ascii?Q?eyIus3AutukyfnCXh5Ak1JgxbwhRKgSle54rZ+7XUKkuGMjs/PN1y9wB9Vbt?=
 =?us-ascii?Q?JNam0paa1HNsy3h04WoTunybIJspqDS43MyXqOD4RZE7mZfDC8ySsq595cPi?=
 =?us-ascii?Q?S83h?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d41e7cd-0e88-4991-2aba-08d8be8eff03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 04:34:24.7270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRj1Cem5gvkugHBcm0fQg6vAvDoN+9AiAmYzmS3wPeT263i/eS5JLglxI/HABadVs9eKLhGlWU2UDx/MtwHpSPIjwLrBxvIEtvrNy8jj84A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 1/3] lib: add "all" and "none" as valid ranges to bitmap_parselist()] On 21/01/2021 (Thu 16:07) Yury Norov wrote:

> On Thu, Jan 21, 2021 at 2:34 PM Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> >
> > The use of "all" was originally RCU specific - I'd pushed it down to
> > being used for any CPU lists -- then Yuri suggested pushing it down
> > further to be used by any bitmap, which is done here.
> >
> > As a trivial one line extension, we also accept the inverse "none"
> > as a valid alias.
> >
> > Cc: Yury Norov <yury.norov@gmail.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.rst | 11 +++++++++++
> >  lib/bitmap.c                                    |  9 +++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
> > index 682ab28b5c94..5e080080b058 100644
> > --- a/Documentation/admin-guide/kernel-parameters.rst
> > +++ b/Documentation/admin-guide/kernel-parameters.rst
> > @@ -68,7 +68,18 @@ For example one can add to the command line following parameter:
> >
> >  where the final item represents CPUs 100,101,125,126,150,151,...
> >
> > +The following convenience aliases are also accepted and used:
> >
> > +        foo_cpus=all
> > +
> > +will provide an full/all-set cpu mask for the associated boot argument.
> > +
> > +        foo_cpus=none
> > +
> > +will provide an empty/cleared cpu mask for the associated boot argument.
> > +
> > +Note that "all" and "none" are not necessarily valid/sensible input values
> > +for each available boot parameter expecting a CPU list.
> 
> My question from v1 is still there: what about the line like
> "none,all", ok ",all,"

Apologies - I must have overlooked that somehow.  Let me address it now.

> or similar? If it's not legal, it should be mentioned in the comment,

OK, it is not legal.  So if desired, I can do this in the code...

 - * Optionally the self-descriptive "all" or "none" can be used.
 + * Optionally the self-descriptive stand alone "all" or "none" can be used.

...and a similar "stand alone" addition in kernel-parameters.rst above?

> if it is legal,
> the corresponding code should go to bitmap_parse_region(), just like for "N".

Non-standalone is not legal.  The strcmp ensures the "all" or "none" are
stand-alone.  And as can be seen in the testing below, any attempt to
combine them with commas or ranges or repeated instances is -EINVAL.
(And I'll look at adding such tests to bitmap_test.c as requested.)

> My personal preference is the latter option.

I'm a bit confused as to the value in adding code for supporting things
like ",all,none,all,,none" and then having to define some policy, like
"last processed takes precedence" or similar.   A strict stand-alone
"all" or "none" and everything else as -EINVAL as per below seems
logical.   Maybe I'm missing something and you can elaborate?

Thanks
Paul.
--

root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo all,none,all > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo none,all > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo all,all > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo all, > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo all > cpuset.cpus
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo ,none > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo none > cpuset.cpus
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 1,3,5,7,9,11,13,15 > cpuset.cpus
root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
1,3,5,7,9,11,13,15
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 1,3,5,7,9,11,13,all > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo none,3,5,7,9,11,13,15 > cpuset.cpus
/bin/echo: write error: Invalid argument
root@hackbox:/sys/fs/cgroup/cpuset/foo# 
