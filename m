Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937D02F27A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 06:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbhALFU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 00:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbhALFU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 00:20:58 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0729.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150FEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 21:20:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/DPX61yThfu/0YvUwlGpjboD+DvX52Z93MhbyOmmFYU2XbHURnaFQ+dfLdZ2jD6kZH48xGoPJpIg++NFCiv80kRz27vl+JHGxtPSmRZ6tH7mfNyIzHUu8Q+kL6yYLWfUYkwXXd2g66r527smK9zYsuRiZgSRLI6kEL+uBON7txHQqP2N5EBZBWvDk0QXovdg2GbYsrssZeHLXwihX20vgxTyo6u30OxcSkou74f/doROE5UuA+6bBYwjoYyi6dDJJVFNWSsxiwGMUGNINFbCDFnvkFN5adzfTUw7EXrEQcO+MhAbb614ZOZ2hAjJnhkAsU5Ue6LdQBz9Hzl5OKLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhP7H1UZ4Auqo36nece2UFbVExG3Wbw0gLQBGQdSu1M=;
 b=KA5BIUZ382vjh85A596lXhXApde8/Na+TBN2OpLeGO0hyqUMW02TTmv/naBFT5LofFYnIR0tdkT7pvwdtk3jVmDo41pYu0V1gFIcv9JwujVGjp92wCxqKei3TUB4K8ioTwgkvd0Abcw33Ad+C/buyIwmtEE9uX1OLeI1+5FafVOlJzNP5Pq8YDNb1i9TYT5C7VTpwA43v2R2Ys8PrhPTaa9erlD7MYOrt8YG4FpjFruLYn7D5kf+KWUVsUZKO8rCTmtV5Wb7pT/Fmtj5PqM9Q5WeMZ93lP9ewBeGlqPZ/1GB8zO6XeIepokkQpl99MOGNs7udAdNQUMNlzC7C0GKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhP7H1UZ4Auqo36nece2UFbVExG3Wbw0gLQBGQdSu1M=;
 b=em6gzHB//6CNEAuXweMJQij5F14pFb3HtdLtZO8M5hWGjRVMdZOeH9Gvhai9paFGB3dRSJckG/Ji1dQBObQEkHGTg7xZUAbfVMeNt2mr71IvLyWl/LEjt+mucYwUePof7HsX2Ck7A2swdQEJACqb4PFskASpz0F+ky9cQ9tLLaA=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4293.prod.exchangelabs.com (2603:10b6:a03:12::18) by
 BY5PR01MB5763.prod.exchangelabs.com (2603:10b6:a03:1cd::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.12; Tue, 12 Jan 2021 05:20:07 +0000
Received: from BYAPR01MB4293.prod.exchangelabs.com
 ([fe80::1854:ce25:a13:e381]) by BYAPR01MB4293.prod.exchangelabs.com
 ([fe80::1854:ce25:a13:e381%2]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:20:07 +0000
Date:   Mon, 11 Jan 2021 21:20:03 -0800
From:   Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com
Subject: Re: [PATCH] arm64: Kconfig: Increase NR_CPUS default to 512
Message-ID: <20210112052003.eeg725mmnyv67eop@con01sys-r111.scc-lab.amperecomputing.com>
References: <20210110053615.3594358-1-vanshikonda@os.amperecomputing.com>
 <20210111105636.GA7071@willie-the-truck>
 <20210111175741.ldifmv7uhdekbq5d@con01sys-r111.scc-lab.amperecomputing.com>
 <fb9542df-19cf-4db7-d112-0917e5b65e9f@infradead.org>
 <20210111182526.GB17941@gaia>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210111182526.GB17941@gaia>
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: CY4PR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:903:77::17) To BYAPR01MB4293.prod.exchangelabs.com
 (2603:10b6:a03:12::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (4.28.12.214) by CY4PR06CA0031.namprd06.prod.outlook.com (2603:10b6:903:77::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Tue, 12 Jan 2021 05:20:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9946b2cf-f398-4851-7b99-08d8b6b9b9ca
X-MS-TrafficTypeDiagnostic: BY5PR01MB5763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR01MB5763EBC8793FDD9CC31184A09DAA0@BY5PR01MB5763.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbyicGUnb4hFLiHgTds68KlN2PSfCPA2MIQWFz/n1N6JiAIEzzVMt7DERC1+VNLuMkxwA2ChXz9txPpPu2VSBdUn7aWWrjKZ4iej5usB2xt5xI94jK5hSKQNZpnmJfqmk8zZr/nrFCCeRJ2MKWpoK8aRef86QWLczXn2LWj7cnGhNFnjynB1Kuwi4Tof4VM6Eyrk+tcO58JzG+V4DclGhiXGCd4FIVMwRTcEAYDic57UUmlVcIgY4Sse+tPDRcAiGO1fHFA3IyXP7gfxTIu2iToh2qPYs+QRSk547G4BDrmL9kEej5f0kG/yk8iWZ/a5bpyy5iyvw7AmsMZUD6usT7KKL5W2fKVh6cBXXDCKoAXj7K7M+c6lKQ33gtRe+gWhALQ6u1koItQqMAqdldCqlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4293.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(66556008)(66476007)(6916009)(16526019)(316002)(1076003)(956004)(66946007)(86362001)(52116002)(6486002)(107886003)(53546011)(9686003)(8936002)(186003)(26005)(2906002)(6666004)(54906003)(8676002)(83380400001)(478600001)(6496006)(5660300002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bL9wH7k3IpoRn+GmQH3LiFysjbF5wmDM2wdL7vboJr9kI01LyXREuiIx29Yw?=
 =?us-ascii?Q?C1Zp/mWoRHkQBBdOB8uV8hx87O+7miBIVcowu/tpACiWXaM/S9Pb8b3SkRNL?=
 =?us-ascii?Q?DqfWjN9aJCJF0o++fg7dcTrIZsDHtOERr8MLpDcHzAng6sdBIiBQb4i2QDQt?=
 =?us-ascii?Q?H+b9oW7B7ADxBiL7e23b826d6sDpSgFiVZ2gUen7f2u4B9yy6r1Nc3g0GA3s?=
 =?us-ascii?Q?HsJbH+b8Y1jqEVFPmWrqU1/dkz3Oj40oztKGV31sGCkKRkWmdnzQC1UBRMcN?=
 =?us-ascii?Q?K9swdOzOci+EV2MOsi9UUq/QKpPeW/frfFquIJ5LpniukQqxHIA8yS6XHhZ2?=
 =?us-ascii?Q?nS5DnTIv18q3rV7EA3+5QSs1t24WRmvrgBc96WOEXf95uzcbfEzc9n/DzBNF?=
 =?us-ascii?Q?RFHnCuoSKI4kW2O3jLj1KXQb4+Rjeyq+HGd6uuX3Vs5bZhra5twIaCBvlNyA?=
 =?us-ascii?Q?EPrgvnKojsBUUSQEUTosDrqqR6seTy7q5/bZzWS88V2EKuDvBmhJ8GYlIa0z?=
 =?us-ascii?Q?kml/uOXgOojbAOUJ0nwqp+vkr1p9HNAs8wXJeAEcjwYsUTEP7PKn5HB07Oi+?=
 =?us-ascii?Q?a+lQ3NGtZUcTmQu5QniZ8c6jMSNkgrRAK+ylL4IG5FNhgingNTLByp1ENaf+?=
 =?us-ascii?Q?Qp/Aog5KscP5wCWolotz/eV7wdRYG2CAdLeWM4PgGXNzME7s9MWY5DmUMFde?=
 =?us-ascii?Q?0WFR9piZe5FhlZ74f8Wx+bCrjak2kFUIQiNzgoHVD3nBtPOJOOigqwp9Y/al?=
 =?us-ascii?Q?9LY2xgM4UmMsdXFT0WMoc9onPN48C9RSmWnNJUtpMZNGhPoAEj/6U8IBQaKZ?=
 =?us-ascii?Q?qB+VA+J0IDBrNiMLde/x5SF3QOWqMYiuouheddFxBTw2FX4DKHVdZrdsaaO4?=
 =?us-ascii?Q?J65Mzl7QJwH4ZjULmRJwIHjeU5l5gqfeVdmK/pKrKzVn0yHDhThL1lI6nA47?=
 =?us-ascii?Q?NZktHTcZoZKFI24LV3eRyRevVBxojjI6LN5jvj30VRI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4293.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 05:20:07.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-Network-Message-Id: 9946b2cf-f398-4851-7b99-08d8b6b9b9ca
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZCT1Eq1xfTys41m6+z8pyppTSlPrEWtoVZcbYZOYvej9JnZYeZs4c1W8hS1iHTioImFnz6oAvTHFoU1g4wo3Oq2Uud+jx0C2ihLvkWK+RUhZ3xya5EvyqWiiriuWNTA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR01MB5763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:25:27PM +0000, Catalin Marinas wrote:
>On Mon, Jan 11, 2021 at 10:03:18AM -0800, Randy Dunlap wrote:
>> On 1/11/21 9:57 AM, Vanshidhar Konda wrote:
>> > On Mon, Jan 11, 2021 at 10:56:36AM +0000, Will Deacon wrote:
>> >> On Sat, Jan 09, 2021 at 09:36:15PM -0800, vanshikonda@os.amperecomputing.com wrote:
>> >>> From: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>> >>>
>> >>> Increase the default value of NR_CPUS to 512 from 256. This will
>> >>> enable the defconfig kernel to support platforms that have upto
>> >>> 512 cores.
>> >>
>> >> Do we already support such a platform, and what is it? I'm fine with bumping.
>> >> the number, it's just nice to be able to say specifically _why_ we're dong
>> >> it.
>> >
>> > I'm not aware of any publicly available systems that run into the 256
>> > core limitation. At Ampere we have internal systems that would benefit
>> > from this change as they support more than 256 cores.
>>
>> But what does that have to do with the default value?
>> Do you expect to run defconfig kernels?
>> I don't ever expect that.
>
>We still aim for the arm64 defconfig to run on all supported SoCs, even
>if not optimally. Distros indeed tweak the config to their needs.

Would "all supported SoCs" mean only SoCs that are currently available
publicly? Could we include support for SoCs/systems in development but
to be available publicly in the next few years?

Thanks,
Vanshi

>
>-- 
>Catalin
