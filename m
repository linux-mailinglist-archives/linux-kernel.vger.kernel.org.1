Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84642EC2B0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbhAFRrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:47:09 -0500
Received: from mail-bn8nam11on2065.outbound.protection.outlook.com ([40.107.236.65]:10401
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727471AbhAFRrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:47:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOdFabvqNO3DCkWHNybp1vWf4kQqBRIMh9I/45bxiZtI5cdIPYQcfZOSL1XzyymjKztN+/8PT8jhuEKE35ssTL6NYiNiJ4C8wffoBMrgHSZFcwAL8pCyH6zMXF/QS/dN4X8YTnZqEZOoNm/2TUTNfkpVMftfstgT7+jpc4WV/OqYk1F8FwJE4R8HYXg3IJ6ujj0uYfReIroDuxC/MoIHgXtfdGdmeNKAKRIOIJkyojWTSWMimirngy42EqEbaWkpVA8uErQ2C4pX0ANli4K5NdmYHGyowHTv36izM08pTAxmayFE014ijrNyqk5KTPIbCo8tA3wb1O4DFDoiosXwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSGf1dpD6p1WoW9a8pZJuwbVhusdUupk9wRvkg0NJ2U=;
 b=nnsPle0ILdSCZYzRo2f4mE/Hjeyhwatmy0EWSwKvKneRLMj93xfp+uIjArm9qJkrqq+V8ZzaMidhJr9hlDoDLAsLzMW057mex+aGMGM3Lwb6VxNj9b0xHCgk3PzdsibnNp+rECtrOWrHQp4CVyS+wQNQUTt2o6dBgjL9wgknCNfzt6RMr+mV8Y1VUVgOOFxTlRS5thzqxnlx+mJyJD8I+e1lcIWVJ4LsRkFl4IBnI/TtMAQf4HNiRa/utGJf15LciT031/16cZ1rk1sAdcjJCpCJR0wTh2gtrMI8KQEgCQ0tjiTrhbggDgPCFwawMT4F9Nb/qszgEflAxCZCT/3ulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSGf1dpD6p1WoW9a8pZJuwbVhusdUupk9wRvkg0NJ2U=;
 b=eHRcrtWc8T10/LQnBIQJyAbAinHK+BYw4pvv2TEmZ2RhbCD9RJ+Cq2DbH/WD1g0nrP5i5snES3wAarGV/3ChCK6BHUwDx3b/AY/o+WRSY3G1bCcFVH99j/eaU12GUZuho6Cp+uXlP17on1w2qq3I85q4VqljsDxtB+AOQZdVzck=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3898.namprd11.prod.outlook.com (2603:10b6:5:19f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Wed, 6 Jan
 2021 17:45:54 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%6]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 17:45:54 +0000
Date:   Wed, 6 Jan 2021 12:45:51 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        yury.norov@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list
 specifications
Message-ID: <20210106174551.GB16838@windriver.com>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
 <20210106004956.11961-4-paulmck@kernel.org>
 <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::24) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YTOPR0101CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 17:45:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ba86ea3-0389-40ac-9dd9-08d8b26aead5
X-MS-TrafficTypeDiagnostic: DM6PR11MB3898:
X-Microsoft-Antispam-PRVS: <DM6PR11MB38987F4B22AFD06C97A998F683D00@DM6PR11MB3898.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cq7R+SoLq2H5AMiS9PrU+o0WcJULQdYCWKpZbXUeOxnqEbgyzOQ2rBLRp2CP4wsfW5eEX/LvEUQW81artkGCBGX0iTiDx17nhtpmY79wtsH9gMePzIgaAwS7A1rJ4KnAdvbXKt/IGBLVC/UINlnMQFWcyeAXsHcj9hMgfAWVK0o2H+pj4LmKhidOBa5FnA34xVIE/VR2txTID3Km6+okj/WbIlRP57dUNypxJ166TaHVkTlNOlwSyaVdH6pYjczS6Z9YOLDMyLhPCIE2tsf3wNIfF0bbG8MXVdWNNlHAjxvOFwA/7CSmGs49lmafSS6l7i4HwKX7QPR/+QnwFrYaZc1LtKWBkYJlDDDyjGmYzm3BDrtsuqz1KiLrWunXtAHL1UV/un39XOW8mc1mLshUOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(366004)(346002)(136003)(7696005)(66476007)(8676002)(44832011)(8886007)(4326008)(8936002)(1076003)(6916009)(478600001)(52116002)(66946007)(36756003)(55016002)(86362001)(16526019)(316002)(66556008)(2906002)(5660300002)(6666004)(956004)(2616005)(33656002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i1AXFFzl3H/B5ggf/z2mFhFC2+/bnzSaIb6VzybZat3APFjccmefnpPFHgUE?=
 =?us-ascii?Q?o2mKHpYvwGGBw3C4+03drGkG9FHhigKiKEF4dXbr00S4u/5817IHk+91KFkE?=
 =?us-ascii?Q?u2mbnPzbDRMgh++MzhMFC+hdwM9emkqvIoKodJqY7B/m0zzM9jprQdbG90VR?=
 =?us-ascii?Q?Xpx/IkDUSx5zc4KZZqv/ELmRy0URth2X1X9qErpKzngddfti4U6oDKbUhcFl?=
 =?us-ascii?Q?kw5ZaoA0Ajt3xrOUjpfgwUN8E8Z6nA2wOJgPdNktIwXW9AzNYV97tGxCxZUl?=
 =?us-ascii?Q?1ib1KYq0dtvbnK/KLicaHCtIHkpIjTaJMXjnYiJoY5fmbHiBvyUiH2Gpqifv?=
 =?us-ascii?Q?qCJZkWyzWbjdQReOwYjiQ0a5gVkv8idPAMK1g75Ck6+piVvF7trWOiHe3VKZ?=
 =?us-ascii?Q?rJyyxb1u+ZL7Xxpzj5eyI85KT3PklMCY2bem/sclOWAQP7yZF4WrijwWx/Hz?=
 =?us-ascii?Q?oRdHxfV5szRrK+zGTx1Dwlk2D+5FOKSL3rmOYUQXkDNDtQTtLarA6P+ihgZW?=
 =?us-ascii?Q?K5p+7mOQU3qz9gzrTsZQx7cSUvdK0dSk07x7mehgShUDerrbZ2xtl41wBe9O?=
 =?us-ascii?Q?Y9VLf27dQ5j6JniOhT9lfIRtzhc/6RGC6YR/734waqBGS7M3dPETUYmhEuTN?=
 =?us-ascii?Q?KI7egW4hoAcFIV4rjVDOENZQe4rmrI2R/cfqeVLoOtIdXDXDRAgrGC8uqU+M?=
 =?us-ascii?Q?nnbWonMjliJCV2DTPCM2lO30FRtlByEhI+aQ3PmCrIrf5yM+M71woskPg+RC?=
 =?us-ascii?Q?vKFIEYhiQdXVJbmx5dXjCjoHbECgY6JbBuUhU1Nm2xAuouG1ybkT3TIBttp8?=
 =?us-ascii?Q?2dkrZltqnt5Sc/chCa7lYQCxEHasrhoT3NR7xIZw3W9Mmz5PqoZIiM0guq/o?=
 =?us-ascii?Q?sNp2l054XVYI9ZjUXeAMEu/2A4yTmuAkCDw2lZJZ0Ano1idq4el3Gatikvaa?=
 =?us-ascii?Q?vwDIBcNTeM/c7rZ8729C7yTK7T7Dm6+DvoZxYwIgUSrMLFFszZ05J2C2Weh9?=
 =?us-ascii?Q?DjeE?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 17:45:54.8582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba86ea3-0389-40ac-9dd9-08d8b26aead5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j84zfLKUzt4DdBYNGZ30O/1cFDzq7sgQdoPBgNVXNwinIhByKigZKa/c4CvD9jtMUccXSxX38Oexr5KY+FrcOPOEjbxfbaulbOeQxcN7Mnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3898
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list specifications] On 06/01/2021 (Wed 10:49) Peter Zijlstra wrote:

> On Tue, Jan 05, 2021 at 04:49:55PM -0800, paulmck@kernel.org wrote:
> > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> > 
> > It seems that a common configuration is to use the 1st couple cores
> > for housekeeping tasks, and or driving a busy peripheral that generates
> > a lot of interrupts, or something similar.

[...]

> > A generic token replacement is used to substitute "last" with the
> > number of CPUs present before handing off to bitmap processing.  But
> > it could just as easily be used to replace any placeholder token with
> > any other token or value only known at/after boot.
> 
> Aside from the comments Yury made, on how all this is better in
> bitmap_parselist(), how about doing s/last/N/ here? For me something
> like: "4-N" reads much saner than "4-last".

OK, I can see N used as per university math classes... to indicate the
end point of a fixed set of numbers, but I confess to having had to
think about it for a bit (university was a long time ago).  I don't have
any strong opinion one way or another -- "last" vs. "N"...

> Also, it might make sense to teach all this about core/node topology,
> but that's going to be messy. Imagine something like "Core1-CoreN" or
> "Nore1-NodeN" to mean the mask all/{Core,Node}0.
> 
> And that is another feature that seems to be missing from parselist,
> all/except.

Seems reasonable, but I'm going to look at fixing up what I've got as
per Yury's comments before volunteering to muck around with more string
parsing code to add more features...

Thanks,
Paul.
--
