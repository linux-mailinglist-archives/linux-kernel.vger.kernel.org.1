Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC772D47C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbgLIRWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:22:48 -0500
Received: from mail-bn8nam11on2052.outbound.protection.outlook.com ([40.107.236.52]:34336
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728516AbgLIRWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:22:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXRTzd01lhe0aYj/IopeIHScbLyBLyU/KjzAhLIKHYXpKYH+tkDR1LCNTK/Q0hUtxzFi1uckmCg4rLJcymAcc2UySaAh/EHGzOkbP4nK89nOujJDkDbqO1pa0u0r4VMJUWd295MZuz3gSIbt+p0OM7/0uZlVmTLw5d+B+iWrHDWgQ/rxdymEoMFyBtkB+2wqYOitbsDsc+cOP7pDmHyzIo0bt9BXBR/BKeGazaapBdupSpThxMqYUXFhd2/xIEPv+i1f9JM1gxSVoS7qDWHpWJ5nIjdBQmNzt5zDRQgPMiriKD8TXS/NbYn6NHlNCrzUi2jZ9cmZF7Fw/x2EOCGpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4dQIXz/mzq+qmIXOfTxC2wUkRmQ0MxAN0keZfEdazU=;
 b=WhZYrtmj886/IREecgf1lDHDIwQHwNSFyhmZofLdiy7Vvb50XH9v8IN4Wd4XtqfuVqfJjGqjWq7uFwaHGc+oRSD/K8f9LrL0aSgt/VSMNAWXuPAAZJTBQ1DWyEExNaUBxE0YWCVyIu0LLru8e5p4GO23D4izMxwik6balCfjxDpQoX/e6btRkrrhVAsYac+Fv5mssku42KkQvlesJegZbPVAl+TOESZf3qPr7sap4MlNzed7N+c9SRP5sdsNGMzapBxGnRxYlCkAa6YHAYth4vzPsDcPA0+ZmgTqD0d1rclKmYMZIQ9khqfPMFzxeQY47fypTL8cFt8J5KN+aACEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4dQIXz/mzq+qmIXOfTxC2wUkRmQ0MxAN0keZfEdazU=;
 b=Mv7Tg++VwI8t8/DiFiEH2l0CVk29uWZp/V0XisHWl/9tjbJmP/VO7K5pzQSe0pPg/7OP54juvCpcKrvsoRmIxd+EE3GTlfTmFbZoa5U8vE3qU9R5LHHwVpuE8rro5ezphAw7sslSaj4aUtrHFPNlOWfc0YMmUz4bdJFeu0PtJhI=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3577.namprd11.prod.outlook.com (2603:10b6:5:137::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Wed, 9 Dec
 2020 17:21:59 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%6]) with mapi id 15.20.3632.021; Wed, 9 Dec 2020
 17:21:59 +0000
Date:   Wed, 9 Dec 2020 12:21:56 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <20201209172156.GB25342@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
 <X9D9MwJzUCuwQPNb@alley>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9D9MwJzUCuwQPNb@alley>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::8) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0099.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 17:21:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2c16872-a7d0-42b8-a544-08d89c66ef93
X-MS-TrafficTypeDiagnostic: DM6PR11MB3577:
X-Microsoft-Antispam-PRVS: <DM6PR11MB35773FA17278B5E7A3F6073B83CC0@DM6PR11MB3577.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wT4SyYz74ShOLHdF33YwbxYHHvlGSGhMHjAlcFxp+zk5nQMYE4vcEUePf/qRha5/9Y5sHYn8rtArIG3P/WQDt8kRu7ow0C2g13jvedIhvC2tf4Mn0uPCcOWKJXc4LC9obXmsrxjCuV/S4IseyoN89FDOuNrVdgZEv9n1CnmCR33z69kURcN1RAD+bcbktJzWieRJ7w33axrLoObvHVxZPL1USpx1DfTvUUpQwlnYOsQ1ek6UT61tby5TPQd8uWfYIIqzGR/oV54ljJlpa/2ArBhsOhmccoXcpjIaP3R8S/KsnZbW2m45YhsMHcNoub/F5e0iiUkMDDBWwmGkJToOd5xLNRWVfZRBHkPU3Gi//1FF2BADWTC3EzgEFxzxdA4p5vfTI6cwUnVYZaXGvGEy4e2+fBS713gFxLsNMl3TbaSrhKyz0s/r+QUU0IAQ/0aPm7QmanMHb45By1b30SJgAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(26005)(5660300002)(7696005)(33656002)(6916009)(4001150100001)(16526019)(86362001)(34490700003)(186003)(83380400001)(66476007)(54906003)(8886007)(966005)(1076003)(8936002)(52116002)(36756003)(4326008)(2616005)(55016002)(44832011)(2906002)(956004)(66946007)(508600001)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uH+HR43APWw1fJwZTYkPI8bBFlArms/doPBl7ammqWEc37PKpUPSEsxGcyMC?=
 =?us-ascii?Q?FeMmOPpCXWwkjpmHy4KLa2XnXWEYcHhPfFyIR5ADGW/JYRY2B5x05ku0SKtn?=
 =?us-ascii?Q?L2yv/n6TJy22XWtcDnYANnOuWLLOHV1Fwztl7yZA+2cFgVfTUL9JavzPCbZq?=
 =?us-ascii?Q?Xd79fSvHAArd7ukG7Onntx2e6fj41KiCS22GcWs0waokhScUL8uBIDep5UG7?=
 =?us-ascii?Q?0eHEHqETVX7i7zJQk9hHAKfwXiqqf1OE7EUql2E5tzTTUsRGSenFT7R0txrW?=
 =?us-ascii?Q?/rcGFBcMZR4UI3WDl74zop69meGNSlAtMKhTQqXM0ZxIb7R8Lsjm9zCRWDj+?=
 =?us-ascii?Q?u4lpAChqgfn+yaovKxrPAF8xonEEKiiJb6V5Eo0M2uwwKwQ90+e53izkBwdS?=
 =?us-ascii?Q?nz3G6/KJnvYpv/H8hBLNTUpO+DTYleDuuxEf5MsK+eGUIGtUwNIiT0JQ4xTL?=
 =?us-ascii?Q?PnBHwETkrf2RJ5UqLsXvOp3LkdllEIeWSk29m3+dswA7L95TDSI9qgxw6KtE?=
 =?us-ascii?Q?i77BEHW+n1EsfYUhdWXi8cUNtyNAwDscXP6BhDiH115r0k6KrqX5HBzsECcC?=
 =?us-ascii?Q?j8r7tKCfltSLGVuNd/NDAuIlit4UsSdf8rCCJ9cJLUDWGKXHdsb7/1dMP14j?=
 =?us-ascii?Q?lEp3qC+CyzsTZy195pEyXM1U7aHcdUl3qdj+LBMhiHCfN1gGcmHixu932i69?=
 =?us-ascii?Q?qhdorrIUOcqFGL7fo//GubyMLaEjfRMyuqbuE1bQN7cIbGHh1ePEXMaiLIlF?=
 =?us-ascii?Q?uZMEoE2reMoGBbA+DWFRvHdT2UJTzp2aQpcShbPTdB3wa+rPY7qFDNj43fuN?=
 =?us-ascii?Q?g3zShq7QuYuXpmttc3vmJ/9WiHptFd3bKMvctza+Ov7cLrKJkRkJ0UoJ9coi?=
 =?us-ascii?Q?BHEPio7X2SGkQJdSzPbNr/A9KPQkCvwh6TnBmxve5XgwgNms8qBTdSSygmg4?=
 =?us-ascii?Q?rKI609E0rM/XTPauX6OUMSita9cn9+irBCCkR48vlQS6nTjX3xwauMbXkqcW?=
 =?us-ascii?Q?GLbG?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 17:21:59.1688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c16872-a7d0-42b8-a544-08d89c66ef93
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8CR914m2IFI9B7mT4fBDetP5YZTsCgqN+ITUjQsgoYPlT15fcgKe5IBm0soVzp3/mveLHKb3ywUSHwYSvFc4tDNetTSKBDkvipSipZXfwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3577
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 0/3] clear_warn_once: add timed interval resetting] On 09/12/2020 (Wed 17:37) Petr Mladek wrote:

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
> OK, I though more about it and I NACK this patchset.

Not a problem.  Thanks again for your time and explaining your thoughts.

At least it is out there if anyone wants to use it and they can follow
the discussion here when considering the pros/cons of doing so.

Paul.
--

> 
> My reason:
> 
> 1. The primary purpose was to provide a way to reset warn_once() without
>    debugfs. From this POV, the solution is rather complicated: timers
>    and another kernel parameter.
> 
> 2. I am not aware of any convincing argument why debugfs could not be
>    mounted on the debugged system.
> 
> 3. Debugfs provides many more debugging facilities. It is designed for
>    this purpose. It does not look like a good strategy to provide
>    alternative interfaces just to avoid it.
> 
> 4. There were mentioned several other use cases for this feature,
>    like RT systems. But it was not clear that it was really needed
>    or that people would really use it.
> 
> 5. Some code might even rely on that it is called only once, see commit
>    dfbf2897d00499f94cd ("bug: set warn variable before calling
>    WARN()") or the recent
>    https://lore.kernel.org/r/20201029142406.3c46855a@gandalf.local.home
> 
>    It should better stay as debugging feature that should be used with
>    care.
> 
> 
> 6. It creates system wide ratelimited printk().
> 
>    We have printk_ratelimited() for this. And it is quite problematic.
>    It is supposed to prevent flood of printk() messages. But it does
>    not work well because the limits depend on more factors, like:
>    system size, conditions, console speed.
> 
>    Yes, the proposed feature is supposed to solve another problem
>    (lack of messages). But it is a global action that would
>     re-enable >1000 messages that were limited to be printed
>     only once because they could be too frequent. As a result:
> 
> 	+ it might cause flood of printk() messages
> 
> 	+ it is hard to define a good system wide time limit;
> 	  it was even unclear what should be the lower limit.
> 
> 	+ it will restart the messages at some "random" point,
> 	  so that the relation of the reported events would
> 	  be unclear.
> 
>   From the API point of view:
> 
> 	+ printk_ratelimited() is used when we want to see that a
> 	  problem is still there. It is per-message setting.
> 
> 	+ printk_once() is used when even printk_ratelimited() would
> 	  be too much. It is per-message setting.
> 
> 	+ The new printk_repeated_once() is a strange mix of this two
> 	  with the global setting. It does not fit much.
> 
> 
> Best Regards,
> Petr
> 
> PS: I did not answer your last mail because it looked like an endless
>     fight over words or point of views. I decided to make a summary
>     of my view instead. These are reason why I nacked it.
> 
>     I know that there might be different views but so far no arguments
>     changed mine. And I do not know how to explain it better.
