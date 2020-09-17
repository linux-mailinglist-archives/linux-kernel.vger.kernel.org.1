Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFB726DC24
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgIQMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:55:53 -0400
Received: from mail-eopbgr60103.outbound.protection.outlook.com ([40.107.6.103]:22257
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbgIQMxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6mZwmstit6AnovMAu8eMQ3KW5R9/m5Mepgv+TKrxAt7KExpsFmZaKgYV/WJlEJ991iE3pHo4MAEEm3HsT7RKpEUIHSkA99fiGrFJKfHBMGBXmsQ3wZ7TbbQUL/RLwT3sjq0yYolPW2xMP4w+coji55VcxAo2dPSw9qpppE4Jja0LGz9566oxvbUP6KdzGTk4CX2+8iM43nibZgbV0vo5GiK6k1lTjX7mKodDL4a6nftKbgmhqBZyvswWvGpKVzfgqDwatkW68ew4TNqMOmU4CLbFpzFscKnSPaqTX7kyiD1hrBwQtHwj3ZeMbWrx7fBfgUsamYnJPy2hDNPq9b6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ7xLLSWmCCFjyGM+3ppYpPCn6c0lzRR0uXjAYHNFKc=;
 b=cPbGXeLUZfBe2KQIK9d75i44UuiuVGuh04y3yp/P5Zdj8rAT7xueuGE7DAbZljUjPSkLV0v9v1nDLJMZZmspebHWfq3QTDNUc7LEypVDFEoTV/H5s7VfXAv28CqqG/CgVL3UTqtNPgoSJnXnPk/AsDshO2WYDvPNhLZAfzNjxbTeY0ukX94V0ZujZ+m5dJ6obKlIkq7UEfv2xZBHLp9SEXwlq/b/oZ85hHm/ITgdo8VoidaBW2RF+Ak8crliRFp2fAlt91fUhnHpKZiT+PuCFFaOWz8/OptdNcKPK6LfN4QiQKjux/HQvh4JI8nngLZhV/gLhQb7ER0/+zaRt8iQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ7xLLSWmCCFjyGM+3ppYpPCn6c0lzRR0uXjAYHNFKc=;
 b=hncvn+iv7qIrFufsDeJcrJGS6KxhLzI+4UBRyj84TfFEKzEakqC6gBPb9vnT8MLNaBpdvBeg0LeoyApDWr/8+mrgSkxYl99BPQWfIJXyLmecubfIo2VaF9kIBLsRtSJswkh7BHRnvzoVVg9riIS6inKHjpsS6jEbkJqhE/PosbE=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6485.eurprd02.prod.outlook.com (2603:10a6:10:19d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Thu, 17 Sep
 2020 12:53:46 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 12:53:45 +0000
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
To:     Nishanth Menon <nm@ti.com>
Cc:     Roger Quadros <rogerq@ti.com>, t-kristo@ti.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, kishon@ti.com
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
 <d8b8c070-577f-f778-e595-58517ffce6e3@axentia.se>
 <20200917122703.ojuzn6b3tvqbnssc@akan>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <02d57a88-ba7a-5944-8053-8f4ad03242d2@axentia.se>
Date:   Thu, 17 Sep 2020 14:53:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200917122703.ojuzn6b3tvqbnssc@akan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0046.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::14) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR0701CA0046.eurprd07.prod.outlook.com (2603:10a6:3:9e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend Transport; Thu, 17 Sep 2020 12:53:43 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e07bf107-963f-4db6-219e-08d85b08b674
X-MS-TrafficTypeDiagnostic: DBAPR02MB6485:
X-Microsoft-Antispam-PRVS: <DBAPR02MB6485D957F71DA6D44BB215F7BC3E0@DBAPR02MB6485.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUpRBS/j6nYjO+qq0FIftnVUH7mOVWjN/iZWJyP0eiaelcYJFhuSXcSqMDIaqLTdWJKju7ftTPQycKQoaUBP7i1Rqh3lIX9qnogRU0Mg2OEf9laHbOZt6VgvYpNV0MNT79+z1u99yLLuyQqEp9Ne1aLnjvsmuTUMzXIINIppQbrae/+OET7kPmhUlXFFCjtGNA4RyycJqr9727zCg1DAYs/TgMiE1k9qSgnFBc3Y/n4vfC07BfuoGgAyHsRPXReUuVpmjctXIxTh5U7vaHktEUrJQMPyHjFb0vyv+zaUQvqWTvT0qvMyxikIk7yDr1K/6D5YDbMf4/a4gGZ7dCWBOs45adeGIVd/hH3Y2wiFNv1LNIiVAdqWEr/37dIazC19
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39830400003)(376002)(136003)(396003)(31696002)(6916009)(5660300002)(2906002)(36916002)(8676002)(52116002)(4326008)(53546011)(86362001)(186003)(26005)(83380400001)(16526019)(31686004)(36756003)(66556008)(66946007)(6666004)(478600001)(16576012)(956004)(2616005)(316002)(6486002)(8936002)(66476007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tktUZYyJEQ2hAht5jKiRJeis7bXXBAGoH/nIL6vBlpVtmK/YqxhMeQmUHjZ0g1nJyRxvl5OkMMTwBlPn4O090Mi58onXZGspHWtgHdboW+VhSP5koD9bwo+QvOwNDZ2/INcaUiLcaQhobOBSTkfjbMiRrIRXS5iuV4MWspV7/j17KgMnIXuw93sZOhIBEOTe6dxCJ2q9sLsTjxI4qO0MPMvbYg1hqTvfLiYedX2ieg069n3R/NtyqByHoKzQmbUbEx++ZKV2WNIO8tU4YJrFYY1LkyFUSLxDYEs056kJv/vovDArSAJS+iyHRntDEU3TLHdaQoK0EG3UjcfIPXXn96BhbUIeDqfGhjGPESApquAWuZrFhV/xdEkMGIDxuOSuD9FAzWdYbkSBCBVLUoRSMj87Ui8xd393qE0MYqs7Brnnr3ahb3gYU9JRVDw7TsXe9Djd944wwm2i2GObTFhRH4PZvsdueupRjssrHDPnGk2k7fr39c2DUt9n52Ba2A0eiP0DtwVfnoFG0zbshD7j4KoN1HafsGFiXc7g3pybKalc5IjF5SWcYaXbelNlOQ+PAZFW/ZhDZUgZ1u1oU0wPB5FrKDgpu6dA6zm68tb0Cbtkk0Kp+0dJXuJP2pCuqRgLst1CMyWe6UYuqP+lQ7dnJg==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e07bf107-963f-4db6-219e-08d85b08b674
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 12:53:45.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDLfuoDsM47XqL3Fkwi5msPPIgdOQZGk7re9Me/JBB5JqMz4ISn4Yj07cnTOctaE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6485
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-09-17 14:27, Nishanth Menon wrote:
> On 11:45-20200917, Peter Rosin wrote:
> [...]
>>
>>>> Should not the defines start with J7200_WIZ? SERDES0 seems like a too
>>>> generic prefix, at least to me.
>>>
>>> Thanks, good point. I am not sure if WIZ should even be used.. It is
>>> a TI internal prefix for various serdes solutions, but I agree that
>>> SERDES0 is too generic a terminology. That said, we should cleanup
>>> include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
>>> j7200 changes.
>>
>> Right. As maintainer for the directory in question, I should have
>> been on Cc for that series too, but it appears I wasn't. Hence, I
> 
> yes, you should have been. The following commit introduced it.
> 
> commit b766e3b0d5f6 ("arm64: dts: ti: k3-j721e-main: Add system controller
> node and SERDES lane mux")
> 
>> didn't notice that file until now when I went looking for it. Why
>> wasn't I on Cc?
> 
> Got through the SoC tree - an oversight on our part[1] and should'nt have,
> Apologies on the bad call.
> 
> I would like to propose the following:
> a) The header should be renamed to be something more human friendly.
> b) The header should be renamed to be something TI specific and NOT per
> TI SoC.
> c) The macros need renaming to be less generic as it stands right now.
> 
> 
> If you ack the changes, I am guessing that the changes will impact dts
> a lot and would rather take the cleanups through SoC tree to maintain
> bisectability? OR I can pick on an immutable tag from you with just the
> header file change and pick on the dts - but I doubt that would be
> bisectable. Just worried that I have picked a bunch of cleanups already
> on the dts for 5.10, and would like to avoid a merge conflict.

[Our mails crossed.]

I do not have a tree and dt-patches should normally not go *through* me.
But I'd still like to see what's happening.

I did not realize this was going to cause a *lot* of churn in the dt
files. How bad can it be when the file is new in this cycle? And is it
worth it? But it seems you all see problems with the current naming and
in that case it must surely be better to fix it early?

And if it's a lot, maybe it needs to be more than one patch? I get the
feeling this will need to be taken care of by someone other than me,
because I'm just the maintainer of a very small subsystem and I don't
normally have to deal with "big" issues involving several trees. I would
be a bottleneck.

Cheers,
Peter
