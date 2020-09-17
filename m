Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2053C26DBFB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgIQMsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:48:33 -0400
Received: from mail-db8eur05on2106.outbound.protection.outlook.com ([40.107.20.106]:24398
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbgIQMif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:38:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+NYUUwUWmjoML7U07iOmLvUSnl+kyr+pAzgpClAVHZH/7zGfBkmyNBjxKbDa+3rxG5JJcHtC2EPSdNJYaEQan7OqNqdTVSlDALnme/eBovOQK8gKAuFqQDw2zSWQWep6J+a0g2WBU7FLg1VgsmxJlKhsI5tZywJPfpBK17PtWJoFg3AN/LDb7cD6oi9f7ViZE5TNvDioc3fYtfWOtMd4wdHMGU7tm8IZjE7+i8Os1X5uaP9PuCflUuK7rLRegLyNx0IYLRV9nWvoBXLU0s2l+3AQlWWcLXnsgkLNXFQLNrrEpsPjGMkh6i2tMHu1SBHLZkM+wNHNztJGzUOpQD+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1/YolMr8ZVG1oFaiO6eilS00PtWVgf1CnrWMWHyoS8=;
 b=SMh9X939TOjvsLe3MVosGdQ70DdvP8c8uZBPgAE28LqrLRUwAaeuNmL4ZbayEnvqSZM/l0+BXbWYgJF/GYd8rvQgLZGOiDiea6NdRTv9YTknvZUgtP4gtSDbsLNp8pXjCHMu3fEtjKCsBexS4noPnWMleQExDxABTkVysyZpRGvSIz2ytXAb2NMYjx9MTXIg+vXeDsd4ketpYauP6xNtiUJkrRxIFEG0Hq+UCaoE3gHURpDn5DCmYYMmHi9bEQHqckQaYj9+9Cl4T4jXa6Vv2xY/OfmnJ9H5e0lH51X20w4BsFLUCyJvq9miMYYFY02kyy69xaogSIxIX2qAj9Lvqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1/YolMr8ZVG1oFaiO6eilS00PtWVgf1CnrWMWHyoS8=;
 b=Fd8/rD1zimiVgyuvsCicNvpHX54TMvfWfqan7dJy8zbcFaCJa/+yHSd8X1Yb6lMuCunxdBHaTjwianhUZWvJmeWIIUaxSpBDbynGnKkjw0WLAwLJsfmRN5RyvGhMFUqqVGggKfg8L25YItvsoq8XDD1g1WAYcOLsH3yz8n8Uqxk=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5100.eurprd02.prod.outlook.com (2603:10a6:10:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 12:37:37 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 12:37:37 +0000
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
To:     Roger Quadros <rogerq@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     t-kristo@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        nsekhar@ti.com, kishon@ti.com
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
 <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
 <20200916154536.m552ft2jzfsaeokr@akan>
 <08c84d02-abe1-8399-50fb-9268c7130f8a@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ad1d6964-f553-3a22-65fd-58bc5a166f80@axentia.se>
Date:   Thu, 17 Sep 2020 14:37:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <08c84d02-abe1-8399-50fb-9268c7130f8a@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR02CA0113.eurprd02.prod.outlook.com
 (2603:10a6:7:29::42) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR02CA0113.eurprd02.prod.outlook.com (2603:10a6:7:29::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Thu, 17 Sep 2020 12:37:35 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d6311b7-554b-4cd3-7869-08d85b067556
X-MS-TrafficTypeDiagnostic: DB7PR02MB5100:
X-Microsoft-Antispam-PRVS: <DB7PR02MB5100873AF109766EDC75E7C8BC3E0@DB7PR02MB5100.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0CuivN/XbgnNYLD37HDyLNlBWONJgk5GOr5n6FftEecj7B2GHfwgguAcTov/3chENqmMC9qtueFsjRlxHs66nVnI0aqZahTk7ZExMH83hQGw83FaSj0WfpZoaCOnxYAfnDUjMmYz+Vgl/r4EEwMkdwU2EIljGi3vAYdkOXzUocYogw5a5zNEiNqix3zYo9XIrAG8uIlQdXbfbRCaT4dx9FgCAYIrKFx6u4i4WuatdQCxcSNEt+PCypD7TJsfmNJPk7O13BCO4OazXPfsZSWhKJI5XNi5ZmPeSb2bbfFcN8Io1zb+t8XdVlzRX5dQfmW7LNxrlYi8lS536hI07rnjcpHmfDTmkBlFyf948Ggtjxac0XiyePxnS5br63E3x7Qe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(376002)(39840400004)(346002)(5660300002)(86362001)(8676002)(8936002)(31686004)(31696002)(4326008)(36756003)(66476007)(16526019)(66946007)(66556008)(316002)(186003)(956004)(6486002)(2616005)(6666004)(2906002)(110136005)(478600001)(16576012)(52116002)(36916002)(26005)(53546011)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9lgpvYIKs1BqGxYTw0i3g1xJ0aoHdo/Aacxtmx9r/1tERTIbJ3NNN104udJqz06SRLH/tgqpK2Oq++EtMATIIOK5zX0Efc6ztCzdeVK68q40vhaKMox3/ZBH7Yr6nxp6npk+5wvc6+BKMuItRJWqOc0RJBz02FinmuJ/+y5RxCzXWgTAEtAhJDuaXOgSvt78JkteoWnzoe7M4K7ec+QcLmNl0gFdXa9NcW2JvSBB7/vY+Y8wnovxvq6nl/sw9sX9tAfMTytDFgLwgNwHG727dpCnBASPNhIvz77GGaXVgD56m0uXdIZAhZMqTDy+z0ev/01uc+y75HaQkBFrNKUpP4gbqMN7djbSM5sdJijy/psqZeGyC4E22xZC8ePeWX14MNAQ6t41Qy7ZQ7b1NH2ejOkpClZvF/7AEYToHjmUc3htZH3dIVaL0Dam/QCpVUGjlpkGu5Jvri1ZGWHf82hoFR3qUDkOR0fKyYMo2EikyhOlylpoJkap3cjkxW+u6nyTruDnYS1RI76Y8Brodw/lRVyLCP+pdh7w/FfIKdcYJLYXzEsdp9Cywa4ufpmQLyMwDZqaib3QZg3Dm7YncZgujKgO3jKKHtZejzlm8iAAcOQi6pl+c4zJovyqRjjQOu+0OFc042y/JMqwRak/ug0ezg==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6311b7-554b-4cd3-7869-08d85b067556
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 12:37:37.2396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M8IgwWNJ9fDIrivRNcZwoa/yf6OIw9LJO62zHWX254SEblSz1wA0B7qX9uu5BExh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2020-09-17 14:00, Roger Quadros wrote:
> Hi Peter & Nishanth,
> 
> On 16/09/2020 18:45, Nishanth Menon wrote:
>> On 06:52-20200916, Peter Rosin wrote:
>>> Hi,
>>>
>>> Sorry for the delay.
>>>
>>> On 2020-09-15 13:20, Roger Quadros wrote:
>>>> Each SERDES lane mux can select upto 4 different IPs.
>>>> There are 4 lanes in each J7200 SERDES. Define all
>>>> the possible functions in this file.
>>>>
>>>> Cc: Peter Rosin <peda@axentia.se>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>   include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
>>>>   1 file changed, 29 insertions(+)
>>>>   create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h
>>>>
>>>> diff --git a/include/dt-bindings/mux/mux-j7200-wiz.h b/include/dt-bindings/mux/mux-j7200-wiz.h
>>>> new file mode 100644
>>>> index 000000000000..b091b1185a36
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/mux/mux-j7200-wiz.h
>>>> @@ -0,0 +1,29 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * This header provides constants for J7200 WIZ.
>>>> + */
>>>> +
>>>> +#ifndef _DT_BINDINGS_J7200_WIZ
>>>> +#define _DT_BINDINGS_J7200_WIZ
>>>> +
>>>> +#define SERDES0_LANE0_QSGMII_LANE3	0x0
>>>> +#define SERDES0_LANE0_PCIE1_LANE0	0x1
>>>> +#define SERDES0_LANE0_IP3_UNUSED	0x2
>>>> +#define SERDES0_LANE0_IP4_UNUSED	0x3
>>>> +
>>>> +#define SERDES0_LANE1_QSGMII_LANE4	0x0
>>>> +#define SERDES0_LANE1_PCIE1_LANE1	0x1
>>>> +#define SERDES0_LANE1_IP3_UNUSED	0x2
>>>> +#define SERDES0_LANE1_IP4_UNUSED	0x3
>>>> +
>>>> +#define SERDES0_LANE2_QSGMII_LANE1	0x0
>>>> +#define SERDES0_LANE2_PCIE1_LANE2	0x1
>>>> +#define SERDES0_LANE2_IP3_UNUSED	0x2
>>>> +#define SERDES0_LANE2_IP4_UNUSED	0x3
>>>> +
>>>> +#define SERDES0_LANE3_QSGMII_LANE2	0x0
>>>> +#define SERDES0_LANE3_PCIE1_LANE3	0x1
>>>> +#define SERDES0_LANE3_USB		0x2
>>>> +#define SERDES0_LANE3_IP4_UNUSED	0x3
>>>> +
>>>> +#endif /* _DT_BINDINGS_J7200_WIZ */
>>>
>>> Should not the defines start with J7200_WIZ? SERDES0 seems like a too
>>> generic prefix, at least to me.
>>
>> Thanks, good point. I am not sure if WIZ should even be used.. It is
>> a TI internal prefix for various serdes solutions, but I agree that
>> SERDES0 is too generic a terminology. That said, we should cleanup
>> include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
>> j7200 changes.
>>
> 
> I'm planning to put all TI SERDES definitions in one header file "ti-serdes-mux.h"
> and add SOC specific prefixes to the macros.
> 
> This will mean some churn in the existing DT files. (only 2 so far)
> 
> Are you guys OK if I do the change in one patch to avoid a broken build in between.
> You guys can then decide whose tree it goes through.
> 
> The new SoC addition will be separate of course.

We should get these changes done before 5.9 is released.

Not breaking the build for each intermediate step is always a priority.
Also, renaming mux-j721e-wiz.h to ti-serdes-mux.h and renaming the macros
could be seen as orthogonal, and it is certainly possible to do that
as two patches without breaking the build in between. It would just need
changes on both sides of the interface in both patches. But I wouldn't
worry about separating this into two patches, just do a rename patch and
be done with it. Then follow up with additions for j7200.

However, now that we are renaming things anyway, do we really need "mux"
in the name of the file itself?
I personally find .../dt-dbindings/mux/ti-serdes.h descriptive enough.

Cheers,
Peter
