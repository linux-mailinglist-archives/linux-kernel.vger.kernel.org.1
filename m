Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2162AA9F8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 08:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgKHHfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 02:35:53 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:34361 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgKHHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 02:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604820950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
        bh=xfIoPmT2Bl2EaGibEJvhX9bvD1AQHS/RVcltdW4eL0E=;
        b=fEt0SlPHsu/HcS5xwE++P2xqXjoUWj36nUHpDlfUr6QScTcC46Rhv0K6FBRPt1DkBsKFgp
        qq3TkKdmwoj6QKD4B2mGOmRJKr1NoehnBs96CCmDx5fCztTd+Xlp5Uv8x3PMOrRlsZMXNI
        x0ULeIlN7bm5VETwTQtejkPK2+DajmY=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2059.outbound.protection.outlook.com [104.47.13.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-lhZEeIhGOmyJmCNNEV2DMg-1; Sun, 08 Nov 2020 08:35:48 +0100
X-MC-Unique: lhZEeIhGOmyJmCNNEV2DMg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjyIdi3m6t7L9u1akWEU7Vf8sA7og25d2tEXc2vYepg0SX3gUNr99H8G5S/HWYUPn9KEGY4+YoN8mQ7z6TgjrjI+/rFdSOLKBr8W7g5iN/2u4YhXkpXjEPAlJqsFykcD1xRkmQN+YXZ+z+0kh1qWe3mPliLsGiQnJIAJX08r/1woMrmYKVikrIhHSDFV5sp7VloL8qCqaowmuJmMVbKbLMAlX1JwGVga2k8+Sh2JQxzhzcdDf+h9ayVpXgUc4qtvCrJejQdyQjNLurtAV7r3RMjGo/TOXlhV84B9/PCGstB8GivtAq7wrscNgcuE7UQQ5U+6LBMD0U7LKHgTEJeH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7MxzMgDZup9Aj0HFrAB7rqcax1KrQUY+RDrcX8/e3k=;
 b=N2u2NT5CKmpMl79T/gzeNU1A/KCRN8NIwnsHcF5HDueOeizS3LKiC4mzvVekpnCrRJiUt3jRldeNoXNHP11m9igSalmkUViuW4S8hgCxZ25bAdzWc6fxh9+3AQHqh0ABxsZJl57r755vTPXq7fDlIgJLrwAtYZuh6mxjYsJnjYD1qp171LxgTGgow1JUuEBQwZDegkTm4fYP3/mDnx81kddHSjszqx8wZ5rI5Wg5N1YfaeZbAbqas2mlZwE5m8aMJUOHUFLmt/62tQYRnJQBRTxpXGiAcbGZXg3lkVqsQvaHKK7DlRTYjc9eK5kF96vexlKn3WUorFtMm923jh31IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7211.eurprd04.prod.outlook.com (2603:10a6:102:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 07:35:47 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.023; Sun, 8 Nov 2020
 07:35:47 +0000
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     broonie@kernel.org
From:   Qu Wenruo <wqu@suse.com>
Subject: About regression caused by commit aea6cb99703e ("regulator: resolve
 supply after creating regulator")
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
Date:   Sun, 8 Nov 2020 15:35:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6 via Frontend Transport; Sun, 8 Nov 2020 07:35:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 797c89b9-9288-4a94-321f-08d883b8e8aa
X-MS-TrafficTypeDiagnostic: PR3PR04MB7211:
X-Microsoft-Antispam-PRVS: <PR3PR04MB721141CE7D65301D646F2FBCD6EB0@PR3PR04MB7211.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1aaPoGuSo3UtR4ajrAYiY42REwZy8tUyNuwNFjSNWNbfLIT175aFiQ1XnJ+gbLwzeLF9O5Mbom4MYw0iA0kdIUdTj6pgJfGsd5EGNqLDu8edQwH8vlW5xg/QCdhnnDPd1cqdFXlKJeIjnas/VgRoEI7VSjRS2z/e/OtlLjDObxUswBuAYufAEzhca3hGJsR6rRUJvvkt8j0k6V6kY6CyTkHt5hKQqwhs0akKy62KGOB5ieDs8ofpjUZD2A4pYnCjHpvViiWgSwAPwF+rmR4VwWGjdwTsz4DFUpex3VQCXl01nXP0d/LNEmON2CY2Q8XssNF7PqUVu31PYqQwu69c3octXK5ha7gLLPNo1hTWHX92b+8m531fE5BET43I8HStB3AeVpIRPpgDPEibrZ1+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(136003)(346002)(186003)(16526019)(26005)(4326008)(6666004)(478600001)(2616005)(956004)(6706004)(36756003)(83380400001)(31686004)(2906002)(5660300002)(110136005)(16576012)(316002)(52116002)(31696002)(6486002)(66556008)(66476007)(66946007)(8676002)(8936002)(86362001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EKlRrXyM2vTjPVz4ZLzppM5emeafQ6OlFTWNNLlbVI/ljWjxxcRKwM8Qu3UYSv/+tcQr0GT+AtmMsXZCwAZgHpytnv47slHe8qn+ixUy4GR3TKgtnrNg+8sOIQFIqbS/Cd1CYcRkgy+WfpCdeq8a3vNmXEUY7J0jTRa/LEg670LgSA/qp1DHmpFOgAzawr49zafF8gBJxTMDfmBwuvM5+JxqHcI8ghvvsM84bQMtGptEge1emBft1Qk6fNyIOlVec5B2+ruQEioVDi9nPoJJXR4nEbUFrkGuH4YE7Mjqo03uzEJTcsQtQujlF9TyxWd/3B/GUa6pwudl5VtIYCMyh39FUvMa6G7n+s2NH9igZRfitQFVbVhnTNfLtNa+RJp4P2MUJnrBZ/+AIaZQynPrFwiW5fUHzwRNKJr+NhK+1P24Z4sa6vrSTlAWhgf6+4hFpZFmz+qBMGBqGJt97PUI0UDS4eLUttTjt8Qa1OehqMWKqazekFlTG2kj9lvFW6keEUUBFK+LlOIKX0uuhCY8T9eMK3Hqf86R0CyVvngEdzvaWgrGP3vcggAyGDMCbRb4F+9GxuWb0AkIegAEpRMyA+rLj3Qxluc4Eq8LDqVQnsb6rrtI0uFf4R3GON/PlMhZJLdaC50WDb0ggWlD0YT5uQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797c89b9-9288-4a94-321f-08d883b8e8aa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 07:35:47.5346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ud4syV4htHeEaS1Bi/Fbqg7Pu6am5ZyiAiTx0Cq+ubMNFY25YunJ6o5m5H0DFbF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7211
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micha=C5=82,

Recently when testing v5.10-rc2, I found my RK3399 boards failed to boot
from NVME.

It turns out that, commit aea6cb99703e ("regulator: resolve supply after
creating regulator") seems to be the cause.

In RK3399 board, vpcie1v8 and vpcie0v9 of the pcie controller is
provided by RK808 regulator.
With that commit, now RK808 regulator fails to register:

[    1.402500] rk808-regulator rk808-regulator: there is no dvs0 gpio
[    1.403104] rk808-regulator rk808-regulator: there is no dvs1 gpio
[    1.419856] rk808 0-001b: failed to register 12 regulator
[    1.422801] rk808-regulator: probe of rk808-regulator failed with
error -22

Since voltages from rk808 are not proper registered, then it prevents
the rockchip PCIE controller to find its voltage provider:

[    1.855276] rockchip_pcie_probe: parse_host_dt err=3D-517


I currently tested with that commit reverted, then the RK808 works again.

Is this a known regression? Or the RK808 device tree is out of spec?

It would help a lot to fix the problem before the regression makes all
RK3399 boards to lose their ability to initialize PCIE controller.


BTW I didn't find that patch submitted to mail lists like
linux-arm-kernel. I doubt if that commit really got enough testing from
arm community, especially considering that currently ARM is the biggest
user of device-tree and regulators.

Maybe it's a good idea to also submit such patches to arm related mail
lists next time?

Thanks,
Qu

