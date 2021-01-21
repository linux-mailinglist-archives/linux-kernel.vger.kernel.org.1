Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180F12FF826
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbhAUWoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:44:17 -0500
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:35265
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbhAUWoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:44:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlHB0iww+C58ENFZJwjkO2l2/3rctrPbC71ZafXaikpToUWaL6hlw9Slc5JPES2A6md7IK9oe7DkcWNMNzC+jkAX3ZA9W/6hcWpdEMI0yhUJxYqBNm/olwSNg3NEkg8Lv+8pzbSuyAaqUWJ8q9a0LX6E/jWHUixeBCh/eMHN27CYqfvl6iZsHKVo9+cZmLdbNkR4qdGthhvPTfNbIwlQxdiA7Whv1MdJiGa7Opzyyab+sDd3scjcWgcj+VN9ajoGcfqvcCl3Jr5tB0ZmtgCguZ7KnYh2cCHZUPf/ABbizlqBc4HAA9F7r6UxJYGJSg/upp4OMM6KpiaLRKd77Pm4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCo3oWfppe0agiYF83xoIQb2+8R5L/rO6qcyI/XOXzQ=;
 b=VVo+k7i3BJaNUAR9mu5Uaoo+ZgFQVwoLcPtcf1v0Qye11wZZgdY0S4P5J+ZL0FgZIfZN5BsULoxWTulkzW2WyH9pvAaLHqYgvJzY+I+EPZgNHlMeaK33UIeNiubyVHptS7/r6uDc7LXDQ6964nxLP73wXTj9c0igbhP2jj1aQUDTUcX3yO9IrGHbGGWzqvcUgq3ODfw3i+rIx6lsl7OX1wNPRYzgREvcfJGKzxAWob8xkaRGGspFoIRtXvSmdGYmMN8obfOjHcA/SyYJ9gmfW7hYzM5T+/akwYCu4iLFso8SCqXi0c5VRosDKpsGWYY4+EZgt/Peb5SOEXzRLbHeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCo3oWfppe0agiYF83xoIQb2+8R5L/rO6qcyI/XOXzQ=;
 b=lJ+EaQ5x2lnNgHTaKotrFwbQrzJsyPzB16Scm7XvS34V8M9FLDvyoW7tjw/gVLXzQTMm+jd+10twdIH34u2prv0y85Z5rtcf6uy/R64R6Pojq8e23wLZubmaMh2VvhORSVOvcI9BWsyiJjyQSnisHflw7A4l23C900/YyUxyeUY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR11MB2011.namprd11.prod.outlook.com (2603:10b6:3:f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.13; Thu, 21 Jan 2021 22:42:55 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::87:8baa:7135:501d%4]) with mapi id 15.20.3784.013; Thu, 21 Jan 2021
 22:42:55 +0000
Date:   Thu, 21 Jan 2021 17:42:52 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     paulmck@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC cpumask] Allow "all", "none", and "last" in cpumask
 strings
Message-ID: <20210121224252.GQ16838@windriver.com>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
 <CAAH8bW95nyx6PEnPiBPoHMLoduvgU9KO7N=K7mhLORkA+zzhDw@mail.gmail.com>
 <CAAH8bW8-q-2LaTC5DE0PnUBqs3V_69EAefLvwdZoeFSow8NYZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH8bW8-q-2LaTC5DE0PnUBqs3V_69EAefLvwdZoeFSow8NYZA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19)
 To DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by YT1PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 22:42:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b76c6701-7935-4d5c-cfaa-08d8be5de4a5
X-MS-TrafficTypeDiagnostic: DM5PR11MB2011:
X-Microsoft-Antispam-PRVS: <DM5PR11MB20110F672F7257DBD1EA694E83A10@DM5PR11MB2011.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwGicLLzcu+8DxYqxPRP7tfmH/7gbRQI8vW/AutHpNWTuAe6MVsonQPtiOrRyvO2gIyKfkmu9dd0l/GSPORSozXvKUjsITSHwno5Onn/Kp3kCu2cvU0S8r/OGBfwvlltchIEBL+61SzPkG4TkYyMKhFDATUrESnXdxBK2OODe7jqXaNSJf+1IX+VLOG9FGLKaraxRZVjBE/Dmq5bjxaWhS2ueA56c2YTFXF9Ufo0F42uA/Qc/rPPR3NjPt3gnW6MHTz2tIRbbyTmMfClSoj6P644c1L8fnPLRNHbd7EQiQ4xL20banxzkyb5iVZqbL74ZOh7AQiO4Wu0JIfIcZxuHnZY1RfLTzaw9crGvV7WsW9oh+DSAPgqWJGI0dg6QsM94vwUlFQqc0v70PtqL13K6bfcuusMiI2y7wSpPqS32zWJbQXJaC8nECTIv6i/MOQgpsqlh+0jjKakCvwI330ZQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(376002)(366004)(5660300002)(86362001)(316002)(8886007)(7696005)(66946007)(66476007)(55016002)(1076003)(52116002)(2616005)(44832011)(956004)(54906003)(83380400001)(186003)(26005)(16526019)(8676002)(2906002)(478600001)(8936002)(33656002)(36756003)(6916009)(4326008)(66556008)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b1RPZTJPSjdoNTZVUDFMT3JlaFVtbzBNOUx6dmc0clp0RnBRUGRsQm9mQjUw?=
 =?utf-8?B?K3E3eXExbU83V2VsQXZzeTNVRjd2dU9JdDFISzVZdDMrUy9xNVB0cnpHa3pQ?=
 =?utf-8?B?TXBEU3lUdlhDSHYyZ1VxRTlUanYvRTh0aU54anNIM3cwRVNSbDZSV0ExSHVy?=
 =?utf-8?B?WEVuZTlGM1hUNWVHSGxId0VlL1pMT3UrNGl3N3VCekdxN0NlNk12R00yKzRp?=
 =?utf-8?B?bGJ5L29FemIveWdtNkZYSXMwaHNvSzhSNTM5K1E3THdXQjNhMVRmU2F2QUJh?=
 =?utf-8?B?YVJncHlKMitQKzBiR3RzNTR4V0dvOFQwcVVOSnRTeUpKTVNHbXRWWHo1cmg5?=
 =?utf-8?B?SjFJQjBOd0htOTVPdUxUaDZPVDJ2bUI3bS9vVmFkaDl2SWE2REk3NHVQb1h5?=
 =?utf-8?B?S05wL3JDTW1JUXhRRmcrZk1FZDhnRStpVG5NV21NYTFtaU5qWGEzLzlsUHh6?=
 =?utf-8?B?K1Z1bUVqWjA1MkJwcDFOQXd1YzRaMU1UV3ljVGplTkNNRzE2VmgzQjVnZXJ3?=
 =?utf-8?B?Z2hGOXpDL1QyYTlhTmxnbUZpbW1nc3VyQ013STJhRmtnSWZUN0s3VlBsTWc5?=
 =?utf-8?B?L3JtUWpKZzFFYVFtQzRzUXFzWWE4aFMvOVF6c055c081UjMrQjU4UWxCalVD?=
 =?utf-8?B?Z011Y25Ud0g5Qnc1R0hLL2dVdjlRaHZWN0JqQzBqSHlrNUVaR1BHdCtRUmRN?=
 =?utf-8?B?ZktFL2pTVUNCYjlhR1BjQjg1MnlJVE9oUmIwbVFIanQ5M0U5UTRJdnhLR2Jm?=
 =?utf-8?B?U2Y5NFArK05RUEtxT2lib1dGU1c4aERScUNrRXdjajZNWnFwQ01rc3A1ZFpX?=
 =?utf-8?B?U092eUtHVUdpTmhYYjh2cURGeFVGT3MzVnEvV3ovUGZuYjRldUxwWjBWNVZ1?=
 =?utf-8?B?cS9SR0JkamJBRWRIcU11ZWsvUHgzdENiNC9uaW1hYjE5TlQyV3VwcmIxSDY0?=
 =?utf-8?B?YmJLS2VEZEdGaHRvMGJFc0lZb0tVRUVuODh2NVNMVk41bjRKR2lpdGx1d2tr?=
 =?utf-8?B?Z0V1QXpSMVJqcXptWjBrWjVEbjhJcWxwOE9mWVJGdU9IWEsvUlBidmFBZWtU?=
 =?utf-8?B?Vzl4K05OK2RFeFAycHZ1UjNPcXBINXNSRVRxUWFTSEJZNGpOSzI2dmJ4aFBR?=
 =?utf-8?B?dnI5WHArSFR3MmZPWjBvRUtYRkJKNWhWT083US91WW9iU3p2NlAxM2dnc0Fi?=
 =?utf-8?B?dm8zSkJHcGF5cG5nQ0ZxZTRsbjAxMW5xMVRybnVUcU1EdTdxR3doQU1UVWNw?=
 =?utf-8?B?RXoyS1VRVEFLVlYvbzN0L0hNUDlrdldCUDk4cTVqaTZCeW5RRGFVeXBrMG5T?=
 =?utf-8?Q?fK1wkIl/uxm1+VbJx7YBbPikIy8wb63d6u?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76c6701-7935-4d5c-cfaa-08d8be5de4a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 22:42:55.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOJBJkAlUHVwBN/qtyNDvOUeH0qXYujPTapbfnLLZNXdQMcfF9eAqVwROBbQHQkFW6BtriEC0LeDY00rRXRjdTY+VQum2WLJJ7tA6D7RxDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB2011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH RFC cpumask] Allow "all", "none", and "last" in cpumask strings] On 20/01/2021 (Wed 23:11) Yury Norov wrote:

> Hi Paul,
> 
> Today I found this series in linux-next despite downsides discovered during
> the review. This series introduces absolutely unneeded cap on the number of
> cpus in the system (9999), and also adds unsafe and non-optimal code.
> 
> In addition to that, I observe this warning on powerpc:
>   CC      lib/cpumask.o
> lib/cpumask.c: In function ‘cpulist_parse’:
> lib/cpumask.c:222:17: warning: cast from pointer to integer of
> different size [-Wpointer-to-int-cast]
>   222 |   memblock_free((phys_addr_t)cpulist, len);
>       |                 ^
> 
> Can you please revert this series unless all the problems will be fixed?

That was my fault - I should have explicitly asked PaulM to yank it once
I didn't get to creating v2 immediately.  Sorry.

Your suggested changes made things much more simple and smaller - thanks!

I believe v2 does address all the problems - please have a look when you
have some time.  It should be easier to review, given the smaller size.

https://lore.kernel.org/lkml/20210121223355.59780-1-paul.gortmaker@windriver.com/

Thanks again,
Paul.
--

> 
> Thanks,
> Yury
