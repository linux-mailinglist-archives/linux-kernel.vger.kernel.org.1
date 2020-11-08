Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D12AAE42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 00:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgKHX2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 18:28:31 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:41867 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727929AbgKHX2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 18:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604878107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=itFU42BtRdAjXsFCNJEWVbitPT7MVcF+V0OVNjBtgPc=;
        b=TN843INQ4b5fzE8e3gqXGnTosfFXmNzjmvkUnp/9NFtBXjfqC6WshXNM4NZLHeIvHQJp7r
        xH8uzYJT57hW5CMmemFwq29ULeSC47sfbJ8t3JTytk7RnylDl2NOxRg42gRBQl64Rc/yq7
        73mmCyLhD+b8bqVJtj4Us2QMLNz2Hlw=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-CDN0jRrbMmy_qV4BtM2_Cg-1; Mon, 09 Nov 2020 00:28:26 +0100
X-MC-Unique: CDN0jRrbMmy_qV4BtM2_Cg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFqm98MSF8AhfRu6FELUI/KF4iM6oUq54spjReJamYRgty9Hbpp32GIzfwKCDLWtn6Bn2U3FzV+MLN+mLGpuJBeJH/VPf5Te6PT0eg0ii/0+rV5QTd9JUAEKXaxz7vvaZR/KCZOa4L+5sNINnfeM/gtGl+XiAUqCfUZMtlQDq0Q+8oFT4q4at5LoSxJOSX7LPlQse+IlCIhvOYbw4kH87eZXB8cEC2tzY3EnGpCTUSLg/D4lE4WKDRi3fCyrwDWxqxFbtPikrfaqMWXQs8uhZw3PwwAEEGd2dFKaR8TAldaYS4CJD463+e9slCmw/q6KZOH38JNvTttmAAlWElw2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h5izuMyPQURr0UfTIvTTVAT5uMhrZAbFiDNsmIJBDU=;
 b=BZtJbwMDzwX0UNUxepTjPquCeYdoDPoTdAks4Hk6Gtw3yCFyTVnoa/Gin+v5laErX8xRGVnKvpnUJeJYxaGx8KMgqfTuBLlouytROuMQBHp71UjqhfWmGmpVX9l//n50H9FQcViX5Q3f0uHbYnNDFyBxiu0TuCLJX2mgz1LxugjYx4DYBtO2r/diEDTNQ4H4r6dJex2voBaKDQiGepLf5ZwlS+dnBPZZtr9VHAHjql+EbMAs6gWGOzUYeNiSQ/eTNelk3SEB8qKlF+qqCmhkaYH5gHlxg9mi5s9XOmXos89+4x5Vx4DFhX1xlEOSGMfw+/bZkOlrEjZPQWZBCaeY4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7323.eurprd04.prod.outlook.com (2603:10a6:102:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 23:28:24 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.025; Sun, 8 Nov 2020
 23:28:24 +0000
Subject: Re: About regression caused by commit aea6cb99703e ("regulator:
 resolve supply after creating regulator")
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        broonie@kernel.org
References: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
 <20201108171811.GB10914@qmqm.qmqm.pl>
From:   Qu Wenruo <wqu@suse.com>
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
Message-ID: <858790f6-8b22-4fe7-bb74-56904ad203bd@suse.com>
Date:   Mon, 9 Nov 2020 07:28:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201108171811.GB10914@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::24) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:a03:33e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Sun, 8 Nov 2020 23:28:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c635d141-f8fb-4e8f-21e9-08d8843dfc98
X-MS-TrafficTypeDiagnostic: PR3PR04MB7323:
X-Microsoft-Antispam-PRVS: <PR3PR04MB7323F2B07DD303ECCD3ABEABD6EB0@PR3PR04MB7323.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Wtn5bT07j6LXBSSkMBKhUKRNm0s0FxScZkZQ5gv9EMMvcDZqr3R2f0usUMKb/o1b7YuQvRzmWglWCJbRepPjHvsihPEw+Wg4GJznTp5CIVzpzYkpSGQVw1a7oEppppdO3VnbNw3sKxwaPWL2VY8W4c+8R0nkh2A7xVh60sfwlk9Zic4mHKAhG3aYS2ggmu6eE+jgmfMEQndl9CBrOr3dyUC5mujTVhbLpp0ouOA0cNERPRisaEpBbgGkcGpe5b9PV4Ry6H4aXdiylpvkkPF/UlbQZuqziZyBLM+p2UuHyUK2Vu6/9XbEXzDy87WIyc0DSas54hAqnhr0jKqe66bBG6wrq1Jwn3l6kfjS3DcnUF2zpA5abzxZqI2i18jpLWlDuzOOkf4aiYAm7ccYqQwYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(376002)(39860400002)(86362001)(66574015)(66556008)(66476007)(5660300002)(66946007)(31696002)(4326008)(6486002)(54906003)(16576012)(956004)(6916009)(83380400001)(186003)(6706004)(26005)(52116002)(8676002)(2906002)(8936002)(36756003)(31686004)(6666004)(16526019)(316002)(478600001)(2616005)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 67qOIH6esjzhvUu6q2s9/5aK7ercia/UvJ7H64JZQYrnyq9cPa4cXcm0ssa4WCg7WSYzckVDzaYxbEUGjPCWeCmTWh2K2S3gSviuPkxRObtKiXLpZfGdwmfXfY/aJspI+pywGMeRB/cC+XdhkJyQCFJCP5fp7arVgPWBCv5NojsaXXVZRsDCqMq63kHLFAqR7SDS0f2NeMQLvCvYXhwol6OFtkDQuOKNdB/xHULPOaQAMp+v+H7Y1ZffUsqvQYYSIFD7/gilVOKy+NkIPBva9bY96uzwWkzBKAlHRxWfn4gxW2ncVZoxi+WlUTosIrJeEfW+ah07SMRG5XXlIUFmMHPH4CvadxONcm0jysFZVJUblRrt1n+d34AVRa7ZD6amdPS6fkOC6hNHnB1pRj+R0nUjFO/pgjgHMah9g9QsflVO8GUBno21pMCLULqMqSMUFzfkFOxJKeiPODs04Y8dLXMEpBq6F09cXx2BzNl7k8vrIs6lxiaGDlb6UQDPxLTtZX3CZVBGxrdoAPJ79sJOAKJlR0dfTocRqDgEu8GwJdZtj/qQRXW0d2r4XdaM2/ZGCVHMz2IgJDCz5aUTmEp5t/fnDpACrMFoVqR1TgffJeTFGDXdEQ8seT6LhuTGl9KhdXeAWCVUcbHMkmOvg4WRMA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c635d141-f8fb-4e8f-21e9-08d8843dfc98
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 23:28:24.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZYaj/cWz64M9jW5jW09oMvNai9o2CckH7FL2ful/A9cTs2DnZ155kcUg+s8c8Ug
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/9 =E4=B8=8A=E5=8D=881:18, Micha=C5=82 Miros=C5=82aw wrote:
> On Sun, Nov 08, 2020 at 03:35:33PM +0800, Qu Wenruo wrote:
>> Hi Micha=C5=82,
>>
>> Recently when testing v5.10-rc2, I found my RK3399 boards failed to boot
>> from NVME.
>>
>> It turns out that, commit aea6cb99703e ("regulator: resolve supply after
>> creating regulator") seems to be the cause.
>>
>> In RK3399 board, vpcie1v8 and vpcie0v9 of the pcie controller is
>> provided by RK808 regulator.
>> With that commit, now RK808 regulator fails to register:
>>
>> [    1.402500] rk808-regulator rk808-regulator: there is no dvs0 gpio
>> [    1.403104] rk808-regulator rk808-regulator: there is no dvs1 gpio
>> [    1.419856] rk808 0-001b: failed to register 12 regulator
>> [    1.422801] rk808-regulator: probe of rk808-regulator failed with
>> error -22
>=20
> Hi,
>=20
> This looks lika the problem fixed by commit cf1ad559a20d ("regulator: def=
er
> probe when trying to get voltage from unresolved supply") recently accept=
ed
> to regulator tree [1]. Can you verify this?

Thanks, tested with that commit cherry picked to v5.10-rc2 and it solves
the problem.

Thanks,
Qu
>=20
> [1] git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-nex=
t=20
> =20
> Best Regards
> Micha=C5=82=C2=A0Miros=C5=82aw
>=20

