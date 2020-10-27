Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3044129A57C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507617AbgJ0HZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:25:49 -0400
Received: from mail-eopbgr60120.outbound.protection.outlook.com ([40.107.6.120]:44353
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507609AbgJ0HZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:25:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/u3z48iaT4djfcSEFo8LuZU7ozEdZ3edf6scQ0T2FycY28YZdmjC02VJaR4D2f6VUXCwshdQiob3DvryY040U3GsMHOdkCb9lp6kG6JYM78C1bsGL2XgLePBSy6Y0NP7j50aDHzlB8x2VTKz9aKeC4eR3uPyJcZT103PYLd/Zg7qCBT2L80R2VGFgmV57zfVQwKG/WVMgEldaPlkJqXNYvreKCUdoM/2BUh+EjBIX+7+ju3P+uvVSsE/Y+zBF95PrWML2TDTbSskOuRKXUeY49DKltkJjnHaCqAfnO0qkA950OlZcu0xjkH1R1CEnqolfwt2TVqfSik2yQ7E1xRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czVIa/0bQy9GTbw5HZTtOjb72/vm1JbXmobrbOP6xiA=;
 b=aM0IFqrSecdyN4GG6AwJ+mg7iRWSpAJAkzd5JuXn8j3dcfgfjyHGwMD+uUVqBUdfIWO1WwucKMBGK8JsK7UW7YW86M54ZMDX5FX5oLms3buhnoeQWIIbMsiZ7OoCKMOFfzymi5KpcgWMmbgzU2Lhs/tRvmxbOQBRVSB7+0+eOReZc8LyWZIvErOsWzLQ6WO0EzS96O/coACbh+vmqKxaSZkQ0yp5bOm9HpvL46ncWG3Cqcb0eVq/rNYIrToUYidOVraglB0/x0TaoLloL8GAxQ70brGglWLVMJMJfWINOTMDqdXh9uNcYzFloY6/njDyNwtO0hqZcCiAm6NHqkmDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czVIa/0bQy9GTbw5HZTtOjb72/vm1JbXmobrbOP6xiA=;
 b=NKBvckX8C12aMWOuj7Fuk2+qCROluC7iDjWEZeqlkQNGaZm/fG98TWDA/GRcagFQp+z2ZJd09kuyaT37asiqgFqm7uiOJJ+z8vvMRwxi7oxYmJXVGHLPSlyF0Wev4GYKUcN9z1brgIXo1rR/Cjzg/z9R1DN7ZLriIDfOpOQRAGQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 27 Oct
 2020 07:25:46 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:25:45 +0000
Subject: Re: [PATCH] printf: fix Woverride-init warning for EDEADLK errno
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20201026215004.3893088-1-arnd@kernel.org>
 <8f5c673a-0265-a6d0-57fc-98c788caadc9@rasmusvillemoes.dk>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <6f2ee165-781a-5bde-bab9-a7e738f69f18@prevas.dk>
Date:   Tue, 27 Oct 2020 08:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <8f5c673a-0265-a6d0-57fc-98c788caadc9@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM3PR07CA0139.eurprd07.prod.outlook.com
 (2603:10a6:207:8::25) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM3PR07CA0139.eurprd07.prod.outlook.com (2603:10a6:207:8::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend Transport; Tue, 27 Oct 2020 07:25:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4d87dd0-4590-4f50-7b32-08d87a4984f8
X-MS-TrafficTypeDiagnostic: AM0PR10MB3329:
X-Microsoft-Antispam-PRVS: <AM0PR10MB33292E747C67FA79EAC9B2F893160@AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:262;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dXhdLDnKOf1vYRYxFSSRBwh0xeEz2Io6T/hmmkCDTM9DW8sFxBv5idZJoilTZCd2xkwV5qJzQh48nRTzT5/hjTyD+X/XCT26MYVn3JXKQ1BBN21BtUXLY40L4BSu9G1mtfj2Lud1wJrxnBtbwuAHOxXmd+Hqforj9jr4ovPjaG58tQw0kMdeK2RQ8tfXh6eh1LsafIgTWCiHjJp2aVxoO+k7fiyDxfQyNBQnlitTbeGLHmFKQ8wKZy24lsmQ4caDp035PZiZVxAzy8CACnz3iESOkQrt4BBtrrhIsgP4dw45oaceROK/8mxUP6Zl8LYnhB0opwJaCrO7SvwTkdKVjbBgFA6sxNxSFPZ2IvtodqndbfztMS4T4ojIfjGRN1hA4hiYwwElCD0nCwfs7wIqifcchmo/z5YdDsYVGodHQtjbcm/saRdZzzBW67QKsgEqdvNWpg89yrk5AJSW8vmfSeDWUTIFlxmUvH+JYNIvgz7cshL09t9M/QucXdQOAcR0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39840400004)(366004)(396003)(376002)(136003)(16576012)(8676002)(6486002)(316002)(36756003)(31686004)(15974865002)(52116002)(5660300002)(478600001)(44832011)(956004)(66556008)(66946007)(66476007)(2906002)(86362001)(8976002)(83380400001)(110136005)(2616005)(8936002)(186003)(16526019)(4326008)(31696002)(26005)(43740500002)(18886075002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: yXU7kcjc1INkRAZY7B+GLmmLOdtojRmmXVOQuijK6/PKcxCtBgZi/n8BE3edGHW03LbkcBbfbVsU0XGUjK+4e8m5l7zqb63V941TuHEKeQific4AlBi/cHC5va59f2ErQEznM4ETCjiZKTWe1CkC0uKGy2QJ46hMbdeRjtpCihA7lVvlnDrTr3ZMefOdQyqk+nYPiPkoY0I8Ck7/H3wzkZS+KnqM2YosjlvnkWttWuLilfYcu95fU+3RBjEUhoob0iTWXh2e3dAa+GHu0gvEfckcsH4ph1Xtf1V/9Xl7AhFeEjlOoiOfgPzd2PrkDLRY9NMndBtQArp6Xhv1rCEpFxjnAMDVNsv9Ze2Zms+ooTfRYc3OhTZK91OasYnVcZpM41Z8Kmt9rBLpzjSLUNVsUUw/PZ79GRph7xr/FiKn+AhJ7xRNFMNe3BR0KBa+wOR7YZxi3As+fkNp3qauvUhTdOn2omw7SD+ByDYeLBD0cWdQpTOLMOvXBzGCUx94IRspeC2BpIVTaOiudx0Ho+bEk10rWqeclM5z1Z4/v21w92fbN6M5KsHVLEH0vQN9ESvX9+VxWkfUnCj4FsUQ++PnNmb65sL6/VlzuI1qCnfVoiLFmLJ9WIFfRJbrXTbso9bp/SCNDyVWnjFWO994Dtz8jQ==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d87dd0-4590-4f50-7b32-08d87a4984f8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 07:25:45.6802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWY+lHEJKoulZy947rM+DeZ+pXkbN4mlrcbOeQ4TliT0yXemPZX/0zvFRK2Eznz/7Nfsf/VD1xPvveTNhfJmablg6y90J55nijYyqWEBUlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2020 08.23, Rasmus Villemoes wrote:

> How about we do this instead?
> 
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Missed:

Subject: lib/errname.o: disable -Woverride-init

> 
> The table of errno value->name contains a few duplicate entries since
> e.g. EDEADLK == EDEADLOCK on most architectures. For the known cases,
> the most used symbolic constant is listed last so that takes
> precedence - the idea being that if someone sees "can't do that:
> -EDEADLK" in dmesg, grepping for EDEADLK is more likely to find the
> place where that error was generated (grepping for "can't do that"
> will find the printk() that emitted it, but the source would often be
> a few calls down).
> 
> However, that means one gets
> 
>   warning: initialized field overwritten [-Woverride-init]
> 
> when building with W=1. As the use of multiple initializers for the
> same entry here is quite deliberate, explicitly disable that warning
> for errname.o.
> 
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Fixes: 57f5677e535b ("printf: add support for printing symbolic error
> names")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/Makefile b/lib/Makefile
> index ce45af50983a2a5e3582..a98119519e100103818d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -224,6 +224,7 @@ obj-$(CONFIG_HAVE_ARCH_TRACEHOOK) += syscall.o
> 
>  obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
>  obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
> +CFLAGS_errname.o += $(call cc-disable-warning, override-init)
> 
>  obj-$(CONFIG_NLATTR) += nlattr.o
> 


-- 
Rasmus Villemoes
Software Developer
Prevas A/S
Hedeager 3
DK-8200 Aarhus N
+45 51210274
rasmus.villemoes@prevas.dk
www.prevas.dk
