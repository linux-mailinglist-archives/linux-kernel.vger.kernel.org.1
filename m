Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BA72D565C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388697AbgLJJNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:13:25 -0500
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:28961
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732085AbgLJJNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:13:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCRjPDkDjsqORjLx38HMct9AEDcLx6VJnp7q3UUo+BiDgpuakM63Jg+y5RE7wdJmDP/AFFCnYR4deJIk7a80cHiTP48cI00TnyAR3D8YGM4nXtjxu3onUSD3qNaOP+aHPKx6r/HjihtbS979WMZf33b/UKMQnXn8sQKyzGwYTXB+71QRP/6/YsTAfvkEW2ur4eZAJhzqFqLf5HqQcPnhFzErx11udtHv9YaQ9FifyCkycgGZ72M3BKvCFnDblJRkQpdKUh2G4UIxXsWLez8/2361r+/4PQFnGkEH5cgMPKfhfAF3xN9equsL+6Ah7tCH6hQv2qD75ENq6YYEv1v53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNxkT2oPMX0ehP6QGaFuJnlnTn94n7vSr4sFuoErM9s=;
 b=A4ZLCdri1a7tpLHkp1yfnHwZ3RN+iT1UZtQSclvuPq1lWne0vHOpHCWxqy9SNTgk7ARjcur13knrffvfLTtodq957e+q5ZavvOEidC7AikS+nubasiw7Ke7GKGcPQZl/EW81Ub9AU1n52UXWwRn4YaF4SwhYKotuNrRjdOhSJ1mnrKryTnjhmJMzWP2XOCql8v6wFAh4DbcAYoYxHVrL7uHQXetN7IrSTsj66NsdIkiO2kuVo4JY9TapCfefTFA6AeOFMOeXuPYDkA/PuQbJLBjBByEDp3/K2s5MfuUUi38iN0q5WiqwTT92L1imJ0fOks6UOZeOmm9Y6gWy/zSg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNxkT2oPMX0ehP6QGaFuJnlnTn94n7vSr4sFuoErM9s=;
 b=MUoryfrYgqpXxv75ghjoGHw3KfQ60u2ogAT0rsQ7nDh4zd+CR5dxDrhgmGLd3yotf3yu58vbwhESjM6kH0kJ9KA2pTJxNNxc8jyv7Tsnarb7qdIeJyuKo6a/Y9t0QXItYmXxS2nemXA1kLQnLY207sV1tvSmvWgu+eOBkHiSjDA=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SN2PR03MB2141.namprd03.prod.outlook.com (2603:10b6:804:b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 09:12:33 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 09:12:33 +0000
Date:   Thu, 10 Dec 2020 17:12:24 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 0/8] arm/arm64: dts: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201210171224.74943144@xhacker.debian>
In-Reply-To: <CACRpkdbywjEaKORgS4GkWXkX9DOX0318hKoc0YY=o0NtBjyYcA@mail.gmail.com>
References: <20201109170258.4a70c768@xhacker.debian>
        <CACRpkdbywjEaKORgS4GkWXkX9DOX0318hKoc0YY=o0NtBjyYcA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:a03:331::11) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0066.namprd03.prod.outlook.com (2603:10b6:a03:331::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 09:12:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 723b2b74-64c6-4dbc-4561-08d89cebbab4
X-MS-TrafficTypeDiagnostic: SN2PR03MB2141:
X-Microsoft-Antispam-PRVS: <SN2PR03MB2141CE34A344C979C3288B69EDCB0@SN2PR03MB2141.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPrgETS/bzFMOdP7ekh9aqd/HZeR6VoecqCCVV8PAdds5vKemtMGbFlD6jdeK5vde+3FZCmOLzqpsZrQK7ZKPNYFn4/UE1QCyaDf31qpLK/PX9i/MSvN+tp8CUEreTxeN732SBDwfDLWQ49YLaFomKz84XYEmbU17LdmqwugfDsL9IJcqY8U2eMTgrYRaBuLWazbW5vEL59nwCqnSr7t90Q9UxMhl7NJiQ+HNkXlpH+oeulArFq82w3KlwYwte3ZD6ghGxnpGJAlJP2Wf4RjnyiN5HF+mRNWXan+fUvEsHdWt/UHxz+mMTO5yghX69Hw9yvOodS+dkwrPeiHV/IP+LyqP/6VR6VT1bFf7CkhmU0aQxV5ntbMbeLInBkPSoK6p7+IfA2xIeglIEyxQcUZlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(55016002)(9686003)(6506007)(956004)(1076003)(4326008)(53546011)(6666004)(8936002)(2906002)(8676002)(83380400001)(7416002)(5660300002)(52116002)(86362001)(4744005)(16526019)(6916009)(7696005)(508600001)(66946007)(186003)(54906003)(34490700003)(26005)(66476007)(66556008)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ARrmW91/Yk2h7b6LZgQf5HiUPLLn1ZSUtEWt4b8Zi7dNqx4s4iXoSZLK6W1z?=
 =?us-ascii?Q?kWBNOS3eGwijkJERfatQqQ0NXDqtEFwMbWrTgvaAlPd6BqJbjTHbMzdAcBps?=
 =?us-ascii?Q?Gx9ew+RiXpyF43YQBEu8HHgEwon6sGeDZRlyHGWcwGsSLTX2EQ57PqB5jeLd?=
 =?us-ascii?Q?ZpWGS7gBzp+RQ0ZYkTseTzBUM9nqRxDpnS5LeGnhGfhJfBY8/Os1SyXuqqjp?=
 =?us-ascii?Q?GsTBIHJ/y+3qZZlQAVUKXQUsv2xu9G3u5x7J/gWmb7wZa3EOfczHkytk9zas?=
 =?us-ascii?Q?Ey072B+xDfM9+m/uvJn8WlLThwkoX6vL85m9C0Lrwqtaay9v6ij+xKmgL3nD?=
 =?us-ascii?Q?mvtp7LFmvQgQqigTg2XWt0qtfb4ZJD/9fENDlELnVKYyVhD3CCiGAAb2S2iZ?=
 =?us-ascii?Q?vR5V05wLkgSFOgcW+uzhCioYtfe6TOwfTlOr7e3COeje/tS4fSCkEXvv9/tw?=
 =?us-ascii?Q?O7X1KJ2kziumW4cYvyM9fSzGFLDzFviyic2lU9c8YSnijSgY2vMSjS6BItTL?=
 =?us-ascii?Q?Ntb+oWM2rRJNFIboItQUgXIK+37TIp2Rm5SmyfgSMyEGhOYhWTbEhQkSPmLZ?=
 =?us-ascii?Q?YybgM/gIFQcImMBMKXxP4NZfTIOfWAIxBPYdWX67K3AtqC0v/Ra/Gvx41ZWa?=
 =?us-ascii?Q?DocGx4Y8HXeh/0LGxNQDbhbN7k07CTKHw91dkLFlxMmi2iIXJ3SZkXasW0xC?=
 =?us-ascii?Q?kqieB7N1P6iySETktKVazjPBqTBZtbmy/nJKKcoksjsz36usp7MzDKAk0zKx?=
 =?us-ascii?Q?BLdXxGY1m+QEBGcH4e7bHYLYht0B+Nh72nvtZXko1MNcE/S7EcSQ1akR2zuH?=
 =?us-ascii?Q?Bq25gW6Ypf96iXKby1pWLhrs3YlsET3X5ieGgGMW9dcoR7XXsb0qEUM0BRvg?=
 =?us-ascii?Q?NpdY+tyB3ryLvKzXbR61cibmFbNPxHHd1tlBLPDLNydh6YszuFrMgYw8LUJi?=
 =?us-ascii?Q?8NLpdFWLXSXAyQYGZ+hwl9rz5hGcGVYNlkUXuw9XwBrVPYfH2b609D/44PMJ?=
 =?us-ascii?Q?Ukob?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 09:12:33.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-Network-Message-Id: 723b2b74-64c6-4dbc-4561-08d89cebbab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mv3Z+ji4szRWGfuRkoK1YEBcVK/vNspPakTYJqIVamCOrFgnRDZpgaSHGkyFHb/Qmg4GgWJHUgNJMS2lLozoBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR03MB2141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 15:43:36 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:


> 
> 
> On Mon, Nov 9, 2020 at 10:07 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> 
> > To remove similar errors as below for all snps dw gpio users:
> >
> > OF: /...gpio-port@0: could not find phandle
> >
> > Commit 7569486d79ae ("gpio: dwapb: Add ngpios DT-property support")
> > explained the reason of above errors well and added the generic
> > "ngpios" property, let's use it.  
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> For all 8 patches.

> Thanks for cleaning this up!
> 
> Yours,
> Linus Walleij

Hi all,

I merged patch6 and patch7 to berlin, will send out a berlin SoC dts
Pull-Request today.

For other patches, I see Wei has taken patch4, will other patches be
taken by each SoC maintainers?

thanks
