Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7A26D7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIQJpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:45:49 -0400
Received: from mail-eopbgr130122.outbound.protection.outlook.com ([40.107.13.122]:40416
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbgIQJpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:45:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+7Y7HXTaDYmIsrarBxhPFta6O7NBmKMkSl5wLohgjiRzCuaI9/7uFJkJ78byf0O/z2seRTyH9Vk9dc1REDrX7oL40kKy9gSAS3vpBL3i/wPu59dstJhKsJrbPOGI1HxWUOwksnl6fw3CALpETWxizBNMADIUrDnGzxksS2LuFLaP/EwgfSUGut9Rlwzj6SxRmwN4I8fT7XgiTqbEhoP8Gd8EiYJq9EWg4GenYqlyLGyPk3q6GXe0UNPFGF82wbAINl7QzzwnkhFXKb2M6EqRFjgCDWLKocGFXELNsG39WtEnW8syjC9bCqF35pvhE8l0K0zZ/v1E5Si902TYC2dHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doDf9KML8A/yuuw1QjJ8tyCsMAJw11oO7VwNmSPBwVQ=;
 b=VHtetXI8qLwS0u2zqSD3wdSbTIrgWqKKfMpbM85wLrScTDiStk0kZ2m6JqAx1rbn3RN97vo1651ZzSYniegvdUc/ZxabYtx25yx2vFxdwioV/hDxnoHY/7c5jY1aSnKrv8N9QXpstEqIDo7039Ubb7NP6OiTWrKJAPWRyZgOzvT45fqunzVLH4FapWGEDMswIyNOBayAllGsi/LjApf6oxe7PV4glYoTI3C4u/HpAMpE8bc720jVJzrZ9wmy3+/arIRwCa4dDk6bGoT+1q+Ik3w1obCKIwdFfxIm0Aia8VmCFn3/F78+Svx3K3U+wKSWcm+YF9NPd4xN1wGByu8SxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doDf9KML8A/yuuw1QjJ8tyCsMAJw11oO7VwNmSPBwVQ=;
 b=OPMtO/0sYwqhNkXbRp1GB0Z8mW+HCM01F9KeUOkMGpkQTLz/X9+080sKSWfl3RT4UG7/kqZwadLWNRSl3+NawfKD5i++8YRlDvOZ0m6xs7znwX/qkCmehCnkMKm7Uwnj2Jfu3uRfBZ7PNacc1klQkCpLbsE85QUKo4gW3eWXClE=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5100.eurprd02.prod.outlook.com (2603:10a6:10:75::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 09:45:39 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3391.011; Thu, 17 Sep 2020
 09:45:39 +0000
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
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d8b8c070-577f-f778-e595-58517ffce6e3@axentia.se>
Date:   Thu, 17 Sep 2020 11:45:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200916154536.m552ft2jzfsaeokr@akan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::26)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 09:45:38 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e271ae5b-019b-46ed-7d13-08d85aee6f7a
X-MS-TrafficTypeDiagnostic: DB7PR02MB5100:
X-Microsoft-Antispam-PRVS: <DB7PR02MB5100A2F80A8E7F1052D3E2AFBC3E0@DB7PR02MB5100.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7r5NmweJm/yJ1K8TGWY/JG6M2O4OiZ6VZi1sFXw5IIt8X3n0jKdPoF7T1zR2S63YiG4kVIB9ZKMy1DjpO5NZio6my7EFjd6cpye6Sq5HLo3eqmqZef7g8+kYSyVuVEHUJE7XmHx1h/A3Wi3bqBgxsYB+7rjoM0ZkSOMc9xA6wBVXsXAyBqdpW7xS051eXVO9b/5MpQssx3xuC9pconhiPOQEjNkATJuiHyPGwq3LBlMf7Y5lF1ojhl735iCrlwH8QRNBbwo6+o0qHv4RNHPUb3/yz/B5bu72UBZUioFDhZHiU+LNEQ0Ih1GeT+SU+i7joSaqIWGiQSyfvxrR3cHW75VXm//EeErhGgblqIjlA+0ALDSOWxB2fuT3uUDGnfHZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39830400003)(2616005)(6486002)(66556008)(66476007)(16526019)(66946007)(316002)(186003)(26005)(52116002)(53546011)(478600001)(956004)(16576012)(6916009)(36916002)(2906002)(6666004)(5660300002)(86362001)(8676002)(83380400001)(36756003)(31686004)(31696002)(4326008)(8936002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 1nu7Qvr+Bmdem05ZA+HyjGZNobSF+JYN3Prn3/42QDo1/tfPn4km54ZO7Ou0GTa56+xy2j/2zhRoS+ftiRJ2UFOKAo2j22CRTy+fWB2HFkrQk19Ok0XsDv5KCc1Qn6tC4eYR2EM4Qm4eMYSKXMmKnRaVz+Rzi25+altyUeuk3uApLMf0ONgaWL2Qf0RUu+QOWUbC1aKpPv91yqb/XUtUp99BGLr8WVG8XwYt3pu1qJ+GnBAGXXR/I29u6lLFKdi75WrcvnCgDd4eEBtILIvuIp94mRUXp/0TAi88pvkSJ0UXcK7iWXtd84mhSDxmLphr5s5YEDw0wk1/kspkp6WHqEIF958j2y438UWBbx6KAlU6ToJMN4YVByFb/WboKr18guKW/YwjubnzRkbVLV72nsMiSCT415qsnyFha1uWMlA2843YCRaGdUdkBM1QgPBKd+FmPYwvNze02RNA0mqquxSDKdPXeZlvbns7HZC/AuOdmS9HDZdXSJCqhIapYyBk9RbD1/PJ0uMYDf+oKteRpo+J1dcvfkQlcDq9U8IuaAITBO72XZ6GNCE3DEHUYf1et5K/S7ut2kPsJF2LxVbaEKh6Qk9/XsuH2NA7lOT4qd2oskaHuYlCcH9A4M6/NKfDrX+1U3kpgDlW56GZeYOgBw==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e271ae5b-019b-46ed-7d13-08d85aee6f7a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 09:45:39.4048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exlz4bMecbNmQYbOXx5MctKH6s6euIHfNwhwwRCUfqPSU5HDjtLLZR4bWA8wkaVO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5100
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2020-09-16 17:45, Nishanth Menon wrote:
> On 06:52-20200916, Peter Rosin wrote:
>> Hi,
>>
>> Sorry for the delay.
>>
>> On 2020-09-15 13:20, Roger Quadros wrote:
>>> Each SERDES lane mux can select upto 4 different IPs.
>>> There are 4 lanes in each J7200 SERDES. Define all
>>> the possible functions in this file.
>>>
>>> Cc: Peter Rosin <peda@axentia.se>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---

*snip*

>> Should not the defines start with J7200_WIZ? SERDES0 seems like a too
>> generic prefix, at least to me.
> 
> Thanks, good point. I am not sure if WIZ should even be used.. It is
> a TI internal prefix for various serdes solutions, but I agree that
> SERDES0 is too generic a terminology. That said, we should cleanup
> include/dt-bindings/mux/mux-j721e-wiz.h as well, prior to introducing
> j7200 changes.

Right. As maintainer for the directory in question, I should have
been on Cc for that series too, but it appears I wasn't. Hence, I
didn't notice that file until now when I went looking for it. Why
wasn't I on Cc?

Cheers,
Peter
