Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8958C26BB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgIPExF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 00:53:05 -0400
Received: from mail-eopbgr50113.outbound.protection.outlook.com ([40.107.5.113]:45366
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbgIPExD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 00:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEgwvXX1Pvyl6Dw8RXGOhs9hMKKXtxOKhmaukTm0qSSMrq6ks0N/W1ph+nxyhrcED5tzKN2lKNuuar0H1chhtxTSyb3zezKeV3H3Ht+Y49E1AOBbSyxZkjnF7gPKfmVWWUWqrYujma+tOJHSlCZpvujyol+7GB7HyJE9qv+x4/o/W7VuUmS2PnR18u951X5VivPmD/8VEhxsYHA2zWI5gq1E+9GsKjhRo6s6d24XH1MC3LnD7Aw5YsY8BXwC0t7OReOgvDFgfSNsVV0dQc5QrbYrf4cMuVOkZKJy/nNZgAr+0bHjFsBPdm7OJAnnglxQpt9G2MfG8bEcScdgKaX6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVw77rlgu5fr1GQRDmhd/5SHTh8BQoIY9WER70IFCmY=;
 b=AcKJCLQgGcqwZgA4LzPtv5OYCEXTzd1mkzHDQcptshOrcupe8t1y8zMwYLCU+QewIrqyEl//cxV6xUicCFzBXDCsjwoGNj82eiNsr3u1NTGAQddi0V1FIvJ1qpCEVvmmU/3XLXafR3wPuIxwnDA0M7/6mU1V4UI1DSD1sLgecdMF/7m5iZeB7nauo3N3MwKHoUsWgvCpG61UiVvJakIvUiquSUZzyLjqzzMQjNQjiEjRa6Gz3zXISgAMa8n8Ck68LQaG5pLBMeU6pXP+Wamn/Lg4fk9OKeaiEPGe34RNEK9bLKbd6YjhJseUOwbrDopkh00TXbmz60vqQTwxm+HeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVw77rlgu5fr1GQRDmhd/5SHTh8BQoIY9WER70IFCmY=;
 b=ZEciWRAjUtcE2xBEVjDxlE6/tANF3lj11NCh3jWtRogJlep5sxdvb3t62j2/F0QpKB1/wrJGfWmsAK+pb8pZrrOIMdxU4gCVnioZwrn6R5ZDf3s9370KgypWz/ciZHT0b6PTyI6JfR+E9XXqyF2KRzleiEm3TY2Cl8ijTHhFR5M=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5964.eurprd02.prod.outlook.com (2603:10a6:10:11e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 04:52:57 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3391.011; Wed, 16 Sep 2020
 04:52:57 +0000
Subject: Re: [PATCH v3 1/6] dt-bindings: mux-j7200-wiz: Add lane function
 defines
To:     Roger Quadros <rogerq@ti.com>, t-kristo@ti.com, nm@ti.com
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        nsekhar@ti.com, kishon@ti.com
References: <20200915112038.30219-1-rogerq@ti.com>
 <20200915112038.30219-2-rogerq@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e28e98a0-f3fc-29bd-d7a6-cc45f3a69ede@axentia.se>
Date:   Wed, 16 Sep 2020 06:52:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200915112038.30219-2-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::34)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 04:52:55 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e71ecb1-ef0b-45dc-1123-08d859fc614b
X-MS-TrafficTypeDiagnostic: DB8PR02MB5964:
X-Microsoft-Antispam-PRVS: <DB8PR02MB59640D75B66EEB158F04317CBC210@DB8PR02MB5964.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f01eL+mJBLo6k4RcFakpVHRhUV0YBjILwtaQPpocYGdXwzLiEiURziY6wkvqGM6W7xG4oxp281XLSDmMU7v2zxHkDRqNCcKk6KqxSgTJVGI48McGYi+DPPPw6Z5r7s4VmwsYhHTnoDRmSZlMCnWMp4C9uomHiPwsuhAuThYH/gR5RW5ybdKyUYZpUnnUv6TZBphf33SvXf6VUliiXCyOj/Ag5OxJkIh6XZzjJ9U0l0sjaFqPwvYqj2njQ4CqLp5cAR5EeaziMW6PFi7wawhx/9Lq4Fud1jMcWmv/AhD++3Es00TReyPAYJt5O8K4NsG1H24Qoith45/dsdFpcq3Fp+O7cigICVg83REsxyWFBpgRILYxljIgkPbrZmXz2Wxx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(376002)(39830400003)(31696002)(478600001)(16526019)(186003)(4326008)(66476007)(5660300002)(26005)(66946007)(6666004)(6486002)(956004)(66556008)(86362001)(31686004)(53546011)(8936002)(2616005)(316002)(36756003)(52116002)(16576012)(8676002)(2906002)(36916002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 0EaoAJWZWkaWiJC+whckVSvftxuUcoQy/tIJTV3t9+l23ArneSDAV2G02A4THh39P4kAYFaZcNuYw+/pOTnnHRItCzqZS/FQJ/Jm4vDdRW6Xs9TXr1vlebvQ9+lhbI6tJaDCnJNpmUYYwALI7OLizB+QgjV3TzjYKzPJoaKxXYYXgxuEIcI9eGl8kp+Z1rl3WjL3kCKGbJh86Rr1zcB6j6HQx8T6WI2VxsoHL0GPK/yifFWv1IEA4JHbrtqt2OfnhzU6aRrx8HBkcKKXfsNst1DrCKtO5xLDwiCdz/b6xOI0k5B3n1/UFlD8CKIghLT0PcKQMR+G8TG8TMJA+cKpvPoHc0hha8m/2Y9elSMuC+WI8M7tQ1ehyJryNrMmdB1p2UxGGLzS5zcIf06PMFSJvZV/lhVwLhlg8/IgMZwHa9VNv1oDYJ7jHZPn5SAO01AJPtHX8ylmgZDpvQVTCxR3lFZjfB236Pc0JHOuYxZmWlox0wXxMrxueJ+HmwKAn56zr5xK1EKQxOUp50dobtQ8CMxTUxiBfnAn8G3JpQpRO8wUVFUKqlFCQhsNVFwJUvBZcuXRngR7f2mRw6528FDbH6uJ8SEk30oFvM1wHfG35GCOhFZBet6wjCYf3iXAesAomGH/37W51pwd8c1tDTSaew==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e71ecb1-ef0b-45dc-1123-08d859fc614b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 04:52:57.4913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jmtlT2dJQecOotX9JGLhS38pdX3nhu8UzovL+aS/W/uH4ZcNF4/omdHrL2wgStw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the delay.

On 2020-09-15 13:20, Roger Quadros wrote:
> Each SERDES lane mux can select upto 4 different IPs.
> There are 4 lanes in each J7200 SERDES. Define all
> the possible functions in this file.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  include/dt-bindings/mux/mux-j7200-wiz.h | 29 +++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h
> 
> diff --git a/include/dt-bindings/mux/mux-j7200-wiz.h b/include/dt-bindings/mux/mux-j7200-wiz.h
> new file mode 100644
> index 000000000000..b091b1185a36
> --- /dev/null
> +++ b/include/dt-bindings/mux/mux-j7200-wiz.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for J7200 WIZ.
> + */
> +
> +#ifndef _DT_BINDINGS_J7200_WIZ
> +#define _DT_BINDINGS_J7200_WIZ
> +
> +#define SERDES0_LANE0_QSGMII_LANE3	0x0
> +#define SERDES0_LANE0_PCIE1_LANE0	0x1
> +#define SERDES0_LANE0_IP3_UNUSED	0x2
> +#define SERDES0_LANE0_IP4_UNUSED	0x3
> +
> +#define SERDES0_LANE1_QSGMII_LANE4	0x0
> +#define SERDES0_LANE1_PCIE1_LANE1	0x1
> +#define SERDES0_LANE1_IP3_UNUSED	0x2
> +#define SERDES0_LANE1_IP4_UNUSED	0x3
> +
> +#define SERDES0_LANE2_QSGMII_LANE1	0x0
> +#define SERDES0_LANE2_PCIE1_LANE2	0x1
> +#define SERDES0_LANE2_IP3_UNUSED	0x2
> +#define SERDES0_LANE2_IP4_UNUSED	0x3
> +
> +#define SERDES0_LANE3_QSGMII_LANE2	0x0
> +#define SERDES0_LANE3_PCIE1_LANE3	0x1
> +#define SERDES0_LANE3_USB		0x2
> +#define SERDES0_LANE3_IP4_UNUSED	0x3
> +
> +#endif /* _DT_BINDINGS_J7200_WIZ */

Should not the defines start with J7200_WIZ? SERDES0 seems like a too
generic prefix, at least to me.

Cheers,
Peter
