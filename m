Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5FA2C8AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgK3RSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:18:50 -0500
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:12896
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728981AbgK3RSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:18:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENILT85oTcCs8OP4ZicmStwnzLp2wCs55ya4qyNpZeqefAJcQhPC0+bVUvHIusgwL9uhrvlrxMpeTz/GEsfH1Xslv7/IiDnEyX5If1aIqUeDYwLCPzupofR58zfh0b2esTCycTiqjBCLz/z8GE1E1pBdnbSiC5U7hKbmzzwf/BIs6cnOwRWB97Po8QuAhFSo+O5tIQdxa6V+GrbjkJ0gRdwbnJCc9Nz8eejmCISE/lqGtmQraAEkMZWhGGhm7xcidUgaRFPFocXUCOOzXzrQ8AwgYVowMsaTdI7F2bkfbVRkAl7o2eZ8STaH+M7+V7ie5YODrOx4pUu6Nxu1hhi8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+gTXe2lZVxxchmioby1IyshSMwP393cj69S4IkpVw0=;
 b=UrRyTU3hS/3Yoctt5DRRkdA84lJcxXf0gkNFswFmb18/I9Bhy6BU9Shzbr+bkRddzO2pAQTUchM5ttpuv5DB0sLe/5uB3tqZW5Sauwer91rXIb7hlJNEKyuy+QeCyw12Nd8I7LOKKJGxqMw8WGW1AeZ9SzAcwOWnlQeGSfVYfnCN44S8ebXDdMa5GxLJmfcmuIHbed5D98CaNtIWpaLeZMpa1b9UU2h7t1diGDPHIXrEhXvNIrd3Dm1/7C0LdoQGmjcoAb7mqtB9p5AaucZDjvyXBtx3bb2pVCXhl+DTPD1TVupMvzLP1V0SXQVuTkEGQixE5QSLkf3FW5eVcyXF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+gTXe2lZVxxchmioby1IyshSMwP393cj69S4IkpVw0=;
 b=EWKHAVWlitR/4wahEwwkIRGOx52Sxknolqms0tlGzfpyQpFS3cNOZ304Abufs1O2A2UztVoE3tZ2eel7H/87te/xhmAbDZSLCxKJh4AaJHq5oeYfaz+zwoRUzRy2j4xvCV2z1PzYyUXrGeIrg8l8tnq5M8/E7xzLE5pxCRpFNYI=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB1292.namprd11.prod.outlook.com (2603:10b6:3:7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Mon, 30 Nov 2020 17:18:02 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3611.031; Mon, 30 Nov 2020
 17:18:02 +0000
Date:   Mon, 30 Nov 2020 12:17:59 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 2/3] clear_warn_once: bind a timer to written reset value
Message-ID: <20201130171759.GA26693@windriver.com>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
 <20201126063029.2030-3-paul.gortmaker@windriver.com>
 <20201130112024.34bcbbd1@gandalf.local.home>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130112024.34bcbbd1@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::26) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0057.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 17:18:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd36cb80-6291-4a0d-bc89-08d89553e49e
X-MS-TrafficTypeDiagnostic: DM5PR11MB1292:
X-Microsoft-Antispam-PRVS: <DM5PR11MB12923414F978A5F6FEB032A983F50@DM5PR11MB1292.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wY0M2O5dtzJnWf83kybqBa0nxst1o2c+VkSGJXemuGk9wBDNWDr9qq3lGXVSuNN9tvfU5H4F7yDnC0cN5U9VAlW5dfgjYcgjQSYUsQMvhM0NG45ACARqki9XZx8WbBF65/Ayrpq1LsWPoM7Yd7MawkjA0EmHnMt/pI5aJ4m0xZZDDzB8VojVl/EZWr9lfkCu3+kgY3PMDBlPZAbfpfWvZiY+3w5dKg/bimT43DAr6T66oQdGR3zZ/RKpk2bUlJhPBaHdEsGfnpVUM3hGdLcyIBN2tvDp4ssngtFkOLlhc4/G+4NcWKevqc8PBvL4+VJmszUi5FT29rweUx2dHv7SouM/goWsKAIJqecOWXNYKg1Xu4bADFTcpe+rd6kZ+S08BziKtio/jo4JaFv0x+RWvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39850400004)(396003)(66946007)(66556008)(16526019)(4326008)(966005)(66476007)(478600001)(186003)(6916009)(83380400001)(2906002)(36756003)(8936002)(1076003)(956004)(2616005)(8676002)(52116002)(54906003)(316002)(55016002)(6666004)(44832011)(86362001)(5660300002)(26005)(7696005)(33656002)(8886007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1ZIwlcmo3qgqLmqIYsOWDkUQ8Rm/yxzbGzHI3UTiDVljMAiPOWzCeKoMqUJk?=
 =?us-ascii?Q?Y6ajMr4/a2rLT1Ek/K9Zz7iRp8GhulSZM7tMLDijp3tlPb6eoTCg5lc0ima3?=
 =?us-ascii?Q?PnHaNY82dnjp59zT2efQm5kifbu5dKobURlTpIivyJIOL/d+LNSQCXS13yrW?=
 =?us-ascii?Q?tfFQA5gHLsRhInknTQcTUnAJYEB5El50vkuFzILgLNf6sRZ2eHmmtL0wop/Q?=
 =?us-ascii?Q?LEnrxS3t9GAQ8tee+3F52oH0qFg8HE7Zq+pj+2WyYKyhFhUPJQWirFFk5lER?=
 =?us-ascii?Q?b8dYUWX2uynH0FCaTt5yflwbDb6J7N6RqqpSQ61WXy4ILWaSAS3k8ajswzAe?=
 =?us-ascii?Q?ZhXqceBLWS/MCpKoZxTUefztf0ke8uw2/Ad6d5OmMgLVx4k5cWiNrRWN2yQQ?=
 =?us-ascii?Q?zRBYKVz3WILE0gyPmCbaezMdlkGHuRcz0hfYU8di9uTiDwZxYYrdqCasrhw5?=
 =?us-ascii?Q?0IFM+dxxwZa5jH+Hhn2EDDZnVapX2oJTqxt6N0Oy/Fh5JIJ4UFWfYSpB1TMF?=
 =?us-ascii?Q?ukTHUyfhAq5vLAB+jWIQUDXCZHtZ/6ehz7frSAQ1wVtbvWhuwAnUBKNtNEm0?=
 =?us-ascii?Q?xv2MOi4jL06tfKE0e0sk54gU2tfv2En+Ec0qeo3rEFXeMy6UT8mCOYSLj250?=
 =?us-ascii?Q?feocjXlbQ7blSGJZugHNs5CoQLrtF2H1X0gTYCQsDpB9r65Xrb+aV5H3HN8u?=
 =?us-ascii?Q?NbfVxmAzfMKMeGrAD6RMVBxjf7mYbxwqlrSFj5rUCtYF+bLlHu96j9xKFt9D?=
 =?us-ascii?Q?v44E6yErtqSw1HHQRt674vNtVxr51fr2ri0lwLIzed4oW+uSFpvyLMCWlmrZ?=
 =?us-ascii?Q?tqZ/wqNj7Z4ekC4fm+vOiekoIVi3LQqxegt43w0AVwfeT7KPCKbXJyRTrHCn?=
 =?us-ascii?Q?Rb1YNLoaJxGvu7i7Roz0R2Hoph0QW0iqwEPsGFw/OHBfmgoxbjMDtSiE46Qq?=
 =?us-ascii?Q?4IsMZETxY6ot3PEJL39rTtYmQvkzqbVVOqGqN4Oq16rUIP2dDwR+POKlMWKe?=
 =?us-ascii?Q?4Gy4?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd36cb80-6291-4a0d-bc89-08d89553e49e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 17:18:02.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLawz+yarNrWDnJqe1+uVcrWCM83jMVzZRdCOf4T7TIbcuu7tszQTvYGbnd84w3hFHqEWEH5a4oJQI7zn6A0YHQ+NwzyNemT01tcurKj6aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1292
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 2/3] clear_warn_once: bind a timer to written reset value] On 30/11/2020 (Mon 11:20) Steven Rostedt wrote:

> On Thu, 26 Nov 2020 01:30:28 -0500
> Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> 
> > +++ b/Documentation/admin-guide/clearing-warn-once.rst
> > @@ -7,3 +7,12 @@ echo 1 > /sys/kernel/debug/clear_warn_once
> >  
> >  clears the state and allows the warnings to print once again.
> >  This can be useful after test suite runs to reproduce problems.
> > +
> > +Values greater than one set a timer for a periodic state reset; e.g.
> > +
> > +echo 3600 > /sys/kernel/debug/clear_warn_once
> 
> I wonder if the value should be in minutes and not seconds, otherwise, a
> wrong value could possibly DoS the machine, if you were to write 2 into it.
> If there were a lot of warnings in high frequency events.
> 
> Or is dumping out a bunch of warnings every 2 seconds not be a problem?

It doesn't seem to be a problem - at least in that running a defconfig
build on an otherwise out of the box common distro doesn't seem to trip
any WARN or printk_once events in my testing.  Of course there may be a
use case out there that is doing lots of them, however.

> Anyway, would there ever be a need to have it cleared in less than 1 minute
> intervals?

I don't think so - as I said in another follow up from last week:

https://lore.kernel.org/lkml/20201127174316.GA11748@windriver.com/

I'd also indicated in the above that I'd be fine with adding a minimum
of 1m if people feel better about that.  Also maybe moving the units to
minutes instead of seconds helps implicitly convey the intended use
better -- i.e. "don't be smashing on this every second" -- maybe that
was your point as well - and I'd agree with that.

Paul.
--

> 
> -- Steve
> 
> 
> > +
> > +will establish an hourly state reset, effectively turning WARN_ONCE
> > +into a long period rate-limited warning.
