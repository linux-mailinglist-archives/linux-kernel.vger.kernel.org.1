Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED832CAA78
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgLASGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:06:08 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:27505
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbgLASGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:06:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlpUkhAt2zi846z9ieMumJmDiaPwS39Hsf02FSexcVx8v+iTNbBpp6s4uH225wiskOYRF7xYw+5RarNBoDJfiub8sLavycbzkF50quB6NykOHDqaNEeFnIjLOKAVg4WfsA0XR0rqjkKuxOsW/ICR1qfIvCDv4Bag599HfyoK7kWqWT5hI/CRxkUNmPmYw/Ydpu6QKly6cB6S1YwAesk3f9muGkKVqQe/8MPc5MwL/KeXk/uMoEOevnj+sbH3h0pwg08nBLOtRxkwEmUAVS/300h9+Ekg0CDK+AB8luNY2CSzoiZBBJxtMdmOU5c5SGMOy8XMi7QMZK7oDck4YrHBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvZo48OVqQMi3RwondisSs8lJ2fLZMeUh55UNSZXORM=;
 b=CKD34rFXhBYIxoQOAal7lOjk+gUTSzknLDLXzUVhplawhI09V9rn2msJuXjXKhwVRh4OqwKNZN8Wjltsc7GcZ7kI2laoCD8UW1GwDMIMUcYFsiHfIUeE0yQeYRjntLo3fEYYlMasKr1HyG85t2fTMx4j5gNnw782Qan/CNcjujmcBaO/XA19wf+Mw44qTpnJPzksVeZU3AOQGNQT2pi7TD6IDs7kSx7VasHjcDbcEbfRKLqodgpyTrbTor3b2L3t6Jrj80IO06LZiTKi/PKxJaS0iyWkNdM4hzcr4p6U4Z2qkmtfo3JTKudnuaK7XSiU9ynK9xKpbUDVXsmbnbT5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvZo48OVqQMi3RwondisSs8lJ2fLZMeUh55UNSZXORM=;
 b=lV8aUVN/BiNWw4c87j9JEX8euurXv7CoM+x3upRH5bzMyz+DhrqONCVt80MW/A8eus11CxQDQB2v0blXwX0kFA0OY435xR7Jnanm9IXdjxs+1o8LtNNQmVvUKpRJiqi0YYGqa5gk5q+pyseh/IC4PpoZW9XjV8GaxuRh0j8yIMs=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4188.namprd11.prod.outlook.com (2603:10b6:5:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 1 Dec
 2020 18:05:20 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 18:05:19 +0000
Date:   Tue, 1 Dec 2020 13:05:17 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <20201201180516.GD26693@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
 <20201130030828.GA1363814@tassilo.jf.intel.com>
 <20201130173842.GB26693@windriver.com>
 <X8Y75VZ8XXSZ3Wgr@alley>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8Y75VZ8XXSZ3Wgr@alley>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTBPR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::16) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTBPR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 1 Dec 2020 18:05:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb27f0a1-f6d8-4139-cbf2-08d89623aa3e
X-MS-TrafficTypeDiagnostic: DM6PR11MB4188:
X-Microsoft-Antispam-PRVS: <DM6PR11MB418838E3C0BF82655F87EAE783F40@DM6PR11MB4188.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSnZWnO0ddz7yFWsBh8jh3FCIveqrB3WkpknGeDCTakeMlJuE9dEZR+comQMVhOUHQC4HFyoBQNsoKn1xrl8o6Q0fd+2qIKZvYeKsxuJtPVSPlxfzbAEDzcBqhGojSRCxJRmm5ww/BHbiBz9PgylEXbFkLZno4AQFbchHd/aR7vToq4FCO9GaLyQCB4gipD0gCpudJo3a7ypclIUeTRCbFHTm3DO+NuB1jmoBk3jf07sr3axcvhRhU8sCtWPYDYQzs7vMQY5xlfFTjEQvuV5u9Xdmy6ICAqtcfFUwyLLGrCWEIqnIZq1KzrN+R8/5Gw6NuTRdgRQp5Y66rOjAZTovQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(366004)(39850400004)(33656002)(44832011)(956004)(2616005)(26005)(16526019)(6916009)(83380400001)(36756003)(478600001)(86362001)(5660300002)(2906002)(186003)(4326008)(8886007)(316002)(52116002)(54906003)(55016002)(8676002)(7696005)(8936002)(66556008)(66946007)(1076003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+JaeDahnRDJQ1Rrg9XbpGPmrsIqYTAga+nG1L2hyv4JVZ2igvQGmwttOIeZG?=
 =?us-ascii?Q?y7C1mCDsYLEVUXqB+VVR0u224q9cxr58RQYyyaVRLWuEC0danbKinj8cID39?=
 =?us-ascii?Q?46Oas2r8/BhEuWumw5zYvsklpambApHwEYmi3WNdTgU7zFgRhLhFo2RrXLj7?=
 =?us-ascii?Q?iw6yysHBAoRsfMqik8G8L9jV9u+TvVZXm5ucM88Rng0xX1H8GK3cRlDhDP00?=
 =?us-ascii?Q?hnSxsBZxRtmKyXgGlqn7abkm3EyTCVdxJrHKZ08fHStCDCZ8hVXv5Wqt6xtu?=
 =?us-ascii?Q?k5I3pBMwwPzfklV8Zq8oKyfzZ4iaZ0XZYnNe4fyjM1s1e0OCf0uVKpIyxygG?=
 =?us-ascii?Q?WWjhW9TIGvHyyJJDlWye3LCsfj3JFXebR9b89W5+92J3Dj9zeAFpQ2w+sT1q?=
 =?us-ascii?Q?Vt5yr6IajYoo6zQArit9NOrYQpn6E9PRJTPMb2prX12xioXdUhnle4+kdnFe?=
 =?us-ascii?Q?ymZXcGRu7kVqPdSts9L5VVEStXZH7B6b/sHePmMqfwJPDX6hK3z3pmjID0s9?=
 =?us-ascii?Q?qmJYKiGDBn32UJwEdbM/A4QTtrMWhKhabCtyw1MvniLtmqgJ//AvAD5C9mJT?=
 =?us-ascii?Q?k/B2pDHrjPaAmxdbsLIboOP+XpnaI8/WjieQ0S4/M5/g3mGI5NNG8s/4DWex?=
 =?us-ascii?Q?naL5+EVatWVhKRQzZl1ZbBu9UBIlyOXMmZtzHm8b8xalEAgDB2eS3gjPFGxR?=
 =?us-ascii?Q?9a/3DBVgpSrY0UyqYgeu+S4VRIVFADssDtBNejIteI1GpldlsX0V7XhANab/?=
 =?us-ascii?Q?rfg6s8ei68LypxdiFrlF1lWBZYIDtRIwtArT7KsNEsK/smB2pOetQ03Baujx?=
 =?us-ascii?Q?SRIC3WGv+i/zFIeEa6w1PhIC41+G+byx4xrJkVGMOT+LT3Hw5JCZkK/wh+Ia?=
 =?us-ascii?Q?qyj4u0JBkIaQxuCLYDnDwdL8rg2spaFk4GCKwZhKuSCHeRppL6cle9mh1IQP?=
 =?us-ascii?Q?DAKFP/Iw4/E8HLb4pzrInAGRAwaKE0szvqKcM72/tWdsGv3CAH4/zHim6Q6/?=
 =?us-ascii?Q?Cyte?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb27f0a1-f6d8-4139-cbf2-08d89623aa3e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 18:05:19.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EljEHlJowmBL7LDUM64kH0jlnFsxTejp7UbTHe4ZTCQ6MuAFDDQShKiyoi37frl/q9DAbBwRZUKu1z2gKE/7PLEWVpJ7vCx27z8MQdwBOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 0/3] clear_warn_once: add timed interval resetting] On 01/12/2020 (Tue 13:49) Petr Mladek wrote:

[...]

> Is this feature requested by RT people?
> Or is it just a possible use-case?
> 
> I am not sure that RT is a really good example. The cron job is only
> part of the problem. The message would create a noise on its own.
> It would be shown on console or read/stored by a userspace log
> daemon. I am not sure that RT people would really want to use this.

To be clear, no RT person requested this, and it is just one possible
use case.  Enabling the sysadmin to be able to collect more data on
recurrence equally applies to WARN_ONCE as it does printk_once.

> That said, I still do not have strong opinion about the feature.
> It might make sense on its own. But I still see it as a workaround
> for another problem.

I'm not sure how it could be a workaround for anything, really.  It
doesn't hide anything -- it would instead possibly cause more output.
It enables a sysadmin to collect more data on recurrence when asked to
by a developer like one of us -- without having to ask the sysadmin to
be rebuilding the kernel or altering the rootfs.  "Please boot with
this boot-arg, and run for 3 days and report what you see."

If you get a WARN_ONCE, and choose to ignore it - you have already
decided you are OK with running with something clearly broken (not
good).  Being able to easily check if it happens again over time seems
like a good step towards resolving the issue vs. ignoring it.

> Non-trivial periodic tasks sometimes cause problems. And we do not
> know how big avalanche of messages it might restart.

Without specifics, I can't really address what problems you speak of.
But with a 2m minimum, if we add that - we can definitely say the risk
of "big avalanche of messages" is zero and not an issue.  We could even
use 5 or 10m minimum w/o really changing what I'm trying to achieve here.

> Also the once is sometimes used on purpose. It prevents repeated delays
> on fast paths. I wonder if it can sometimes even prevent recursion.

Again, I can't really address an open speculation like that, other than
to say if we do have an example of such recursion blocking, we should
code it explicitly, so it doesn't hide as a trap and blow up if someone
removes the "_once" at a later date as a part of a mainline change.

> I know that everything is possible already now. But this patchset
> makes it more visible and easier to use.

So, I have one last idea that may address your concern of people abusing
the reset variable like it is something to be used everyday, blindly.

What if we unconditionally set TAINT_USER once it is used?  That also
assists with the fact that such abuse is possible now even without
any of these changes applied, as you have acknowledged.

We'd be making it 100% clear that a person shouldn't be hammering away
on the reset simply because it happens to be there.  The taint would
make it clear it isn't a "feature" but instead a debugging/information
gathering aid to only be used on occasion with a specific goal in mind.

I could do a v2 with a TAINT_USER addition, and a conversion to minutes,
with a 5m minimum.  But I won't spam people with that unless it resolves
the concerns that you (and anyone else) might have with misuse.

If people don't see the value in it easing data collection once an issue
is spotted, I'm fine with that and will shelf the patch set, and thank
people for their valuable time and feedback.

Paul.
--

> 
> Best Regards,
> Petr
