Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0702EF0D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbhAHKq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:46:59 -0500
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:23463
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbhAHKq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:46:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGYxlV81NTo3m1SU+meKM07GZg+b77ppUg/12dWbyWMbj6cSi+eaqgs/kTK/vYu8f26JO/Pl5jc6SV8p8RWtfVqsTtw0+GhpmLziQyrkfXXB+IW1Ds0sexum3egrKdOGvTin+89MvIPPjwKdVDT+eSVyDUs1ffuNnFg086+ySYdcHO5iaMrOQrBLr7rMZVUy2O9ZhdSt49i0/YCLd19tmI350zdc/JKgVxpXcTckXMvFdCTRfRRIB6CU5M5x1fXLTyqaAmpCer+tVgyKTsGUNQoPzqg0A4zIBjc+f7R5rhnrTGNvTAAu27d0/S9bUjU5fdfG0XbAKSnyAY4Xx1u7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO/aCiXdxMzWTyk9oDBCnkAaDye+mkd073k2w0ngrIY=;
 b=LDMBO5auX4XD4loAJtQqKS2Yf1R5o5vNqa+DREH0h/Hz4QSsuWPhMlcQCttsn8PPLAxwD5shFYq9jcn3jRUTrPTVmKTxXmVUD2h6WtvG3bld8LGo/QgkIxBJiyOLkoa/MpA9u93dtuOiCAaGoeU2Coc9l8uVmpyvq7mNSVhpkx+JQ6Nohw4aB97e2nH+vR49JQVB8D92kdlnoWHeUtrZDz9BRdByXTLGteksUKG59L3VuiB9/HT5Aptdtcp/n77rZsQsdYoP6warZyo7N8Y3REanlRwgfr0dJ4UiDjw7ZPFABhlG2mPrt9YEBCebh/SYJl3/LRAIXXcKQDNMSrsXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UO/aCiXdxMzWTyk9oDBCnkAaDye+mkd073k2w0ngrIY=;
 b=ZJKBiodxxddZePebG7iQ8m8nLS2MNAbsbIgWFC/9L8AFr83/OyQNUkO8sGJyW14ydw6QaT4fNGjP7FfDs4ZsCrPTkKJdROpgiSeglkHNcN32AhhFRqjFwjrhdMNpjsRtS+oZ9OSfiS642cs7W2mtaCy3mzwlVJTBSoAA2YtGwPM=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB5992.eurprd02.prod.outlook.com (2603:10a6:10:187::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 10:46:09 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7975:bb50:c24:9e4f%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 10:46:09 +0000
Subject: Re: [PATCH 4/7] dt-bindings: ti-serdes-mux: Add defines for AM64 SoC
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Swapnil Jakhade <sjakhade@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20201224114250.1083-1-kishon@ti.com>
 <20201224114250.1083-5-kishon@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <cb53a07e-98ed-71df-7e0c-acd78484ab6e@axentia.se>
Date:   Fri, 8 Jan 2021 11:46:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201224114250.1083-5-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1PR0402CA0013.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::23) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0402CA0013.eurprd04.prod.outlook.com (2603:10a6:3:d0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 10:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7a6513c-d111-43f0-5371-08d8b3c29bbf
X-MS-TrafficTypeDiagnostic: DBAPR02MB5992:
X-Microsoft-Antispam-PRVS: <DBAPR02MB5992422500E091E55C9C1ADABCAE0@DBAPR02MB5992.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGIaitB8PVKMdtjQx4m6GJQ3u7H1GaCJTZG33vh/+0QK3UHRmJZ3fmZfnMix8gcLgyiuxfmMyCrnnL99lBywgtqEup8VgQRdzf1o40PKtf3nf9SWAPSGn4GAPRqjTN6a6JG6osIaWRdxR67kSUB4Wq57+GUt7WT1+Rhw1SePrGpoUEgnWlrzbBPWkQ8DvC7nYzqU9RmZ3OjLIp3rQtiD1V9h03sTvE5Cb9caeq2rrWdXPBpBfkiF9SR7GI8u2FUcW9ZQhiGEmg0Sjw+6/NOaHgNQ2ncveCjOTbiUmKLI4JhfUT89+OzdMjxL566/FrCmYCS1L/zF9bdtJbGH3YHAzlshm1RB7BGayzxRF6/BtMQTC7L0qpWZSRj22PdHDBzziubeiKfIUPfLFFCkRPNQHnhOYYSdWwXolFjw4VcAvVm4gmW1N/fU+knR599HxBem2LOWPzaJjgson7KGWa5i2Khym0PcIxRapsocbXknj98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(346002)(396003)(136003)(376002)(2906002)(16526019)(956004)(8676002)(4001150100001)(6486002)(26005)(53546011)(31696002)(2616005)(5660300002)(36916002)(66556008)(6666004)(316002)(66476007)(66946007)(16576012)(31686004)(186003)(8936002)(4326008)(478600001)(110136005)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UndLTElObk9ld3pMTERKSkgzeTdvUk5ML21YODQ1TW9hVTZNeE42dlc0alM1?=
 =?utf-8?B?WUpHekp6R1lmYjFpTzd3K3Z5b1pRU1NVNnNTcWZVNm5TaWc4bGE5dm1qUHRl?=
 =?utf-8?B?eC8xT1FWOVI4SVFuTFpVWWk1aW5IVWdlcVFYQjNoV1diWkI5REh5NVRnV25z?=
 =?utf-8?B?aWZCaHBPcXNOQmQ1djZjNjFzZ2IvUUtsU1NDWVlWL0ZVNFRpaWNKTk9NYk95?=
 =?utf-8?B?V3Rla0dqanRnVkVwL0VPakNUVEJpN1lyS3ZJK203WGhOcWVJb1NEWnRwY2gw?=
 =?utf-8?B?UThPdzlIc2dPRmVPM2NWblFpcmZmTEhKc3JxdUlyY2ppZjAvaDUzQVd5N0JX?=
 =?utf-8?B?b2VhR2dZYTUrOE9XRlFFZ011TzNaRDlPSTgwZ3JERjQyenRzNlNWNCtFOTky?=
 =?utf-8?B?TkVHVzBCTmdpSWpaUXBDaUhpcWc2c25DbUoyRzM3U1R0TmJmOWJDUXFSUXhG?=
 =?utf-8?B?ZlM0dmZFcTh5cjljMW1qaGp6TUwxZis4SVZyZzlZMEtXdFlBM2xrRllQYWZC?=
 =?utf-8?B?K2RLbVo5NHFkSFJPUVcrQmZVZERoT1cvVWVnRDRRaE5UM2dmeUpzSHZuQzNn?=
 =?utf-8?B?UUFGbGxvVk9ZWHlRYTh1VFBCeW84NE1ObFA1TzFmeFFrcHViMkZ5WXZrcTlU?=
 =?utf-8?B?QUQvYjg2NnNjNjUyQndBM3ZqRVZhaTE1NmF6RWxsN0RFSUNIN0pYVitkYTNN?=
 =?utf-8?B?RmJheS9XYjFWWExyODRpZVk0VEhnb3JLSmtSQzh1ZHUzWVRLQjJRWi8wNGpS?=
 =?utf-8?B?K2lxeUVGLzZvQnpSZWpaeUJKRzhuYUNJTWh1ZjliWjRUR1l4NnIvYVU1MkdJ?=
 =?utf-8?B?S1p2UjhmTU0xeFJPY0VNWWtTSlovT2RVU210bmlPR0ltOGoxNHRsemFvRVBK?=
 =?utf-8?B?QlVxaHpPNTRHZ1hTS0lGMTE0bkVreldVTzd5M1JBdGlDM1pYaGhaR1l3dUlO?=
 =?utf-8?B?VFRYVjRwcWlMRmZwbVBvQ254dU56NVQzSEdDWHRKWkFEWE00ei9RT2VvWUZ0?=
 =?utf-8?B?NE5DaUFWYUJMaUpaT0JhT1pXOWlaMzdWd0NQeGNOS2JiZW41WmVubnJUUFlT?=
 =?utf-8?B?R0ZLekVOVmcwSU5oL0tIWCtUNXlsQ1lIUEI1R0dweG9rMmlNNzVUTGN3Uitj?=
 =?utf-8?B?cmVyRXl1d2RpcmJaSEVFaHcyZEVSRXhGUXExNmQ1SVJDUElnUFBrSHRSODgy?=
 =?utf-8?B?UjdXL0FXWWpBUWtNNjQ4NzFPYzJCYjZ3N0N6SG1LeDg4VFgyVjNZbHlFR3E3?=
 =?utf-8?B?dURtSHVkMitxdXJaaTFJdFNHWDdvNkJ0ek5XNzZEZDJTOXdacUIxY3RxZlg5?=
 =?utf-8?Q?xSjP7lpTlqF/yXLOt8Icp4pC22cyGWDxfY?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 10:46:09.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a6513c-d111-43f0-5371-08d8b3c29bbf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cp0WuvvNt6BvZXEAMF3VlonQEDsgd6p9S0rLRRROaavvDPbYjIiakpzuNQZZXJOx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB5992
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2020-12-24 12:42, Kishon Vijay Abraham I wrote:
> AM64 has a single lane SERDES which can be configured to be used
> with either PCIe or USB. Define the possilbe values for the SERDES
> function in AM64 SoC here.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  include/dt-bindings/mux/ti-serdes.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
> index 9047ec6bd3cf..68e0f76deed1 100644
> --- a/include/dt-bindings/mux/ti-serdes.h
> +++ b/include/dt-bindings/mux/ti-serdes.h
> @@ -90,4 +90,8 @@
>  #define J7200_SERDES0_LANE3_USB			0x2
>  #define J7200_SERDES0_LANE3_IP4_UNUSED		0x3
>  
> +/* AM64 */

In case you end up keeping these defines, despite the comment by Rob...

Nitpick, the J721E and J7200 sections have a blank line here, between the
header comment and the actual defines. But mehh...

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> +#define AM64_SERDES0_LANE0_PCIE0		0x0
> +#define AM64_SERDES0_LANE0_USB			0x1
> +
>  #endif /* _DT_BINDINGS_MUX_TI_SERDES */
> 
