Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12B2C010D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgKWIDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 03:03:05 -0500
Received: from de-smtp-delivery-52.mimecast.com ([51.163.158.52]:43706 "EHLO
        de-smtp-delivery-52.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbgKWIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 03:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1606118580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DQbAFRNHsPkHIFIITgP2VFBsCmQ8omAA7VeQtL3fiHM=;
        b=Gck9EW64zn1JcOpcl681hOenx/XYLwbv411kxIN6WbktwOhelQ+f3Jbs9RTQYFRwefJikq
        ZYaQ20n6Kf7GkvsLDxQn6r4/2R/zdiJ8sLIVfwNz4KhX+4an+tPqD2QN4W+Zj4388YqHJr
        f0ZDBQramkbEeKNQ90ks0nyJP6kYiFY=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2109.outbound.protection.outlook.com [104.47.18.109])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-1-yH3ptdugNPaOcXgAWcgf5Q-1; Mon, 23 Nov 2020 09:01:36 +0100
X-MC-Unique: yH3ptdugNPaOcXgAWcgf5Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPzKNyVxZmTTuhE2xWsaDvqRefN9K01xYg1hSVRvKXIBEISFdVgyRVsmuUjiEDDbLla++TMmHwSgbFkQIoQTm6QU+ecCQCOO9mVxnJD9ON4c14JEBtHCnzKJzC/ubHGgxbSnQTCdsbSmuWkYHqMjsYYD0ntVNC7BU7AeMKphkTyZkvAeJg11Yyd5FBCy96UCfQIMPowFNaduLz83Kdq2mPEJiX1jIXd9qKsOW6BVn2yXhbjnbkvZ74KMMcfHiDpFu3dxB7oj5gADOl7kB6jYEK3ItqocrWyk7kA/R2Pjp3yvX2f7JUd0LqK0wwbx3LvivRzwHVu1NUlwfy6YQDZ0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgs6w/NBxfFiRth0A/GFlbrS3QDYBeECxfvIP9NKFuk=;
 b=Iut9s4hzBjm+B+Dn/ugKecsBJcGglJNUbWupCic3ZhcHcUDDyO2WUKjmnOId1s1K4J6sMSF0ifc3iQIPI7uhdIFDA6MKDLieT7UOR+2N7WjTEXon+93bjghgZ/oUM7xF5YkH8MMW4vvXjspxnkijjvD9521gNtXnjTa6tgTkUNtPUJBPu+gD+ZJmvRMn1/+tIKFspSGOLB3kQ14nkbQqtqSmTEGiiJ4WlbPvBn5/kVSNWoXuti95F/4G/QF3UYeq3tB6kZzdmYejfRsU/ahBfXdth6pbx1OCAlPTL0HeixXF4ZZWpIW4JONEFr2KbRvL1UDIia0ftwm79REYBrjWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7934.eurprd04.prod.outlook.com (2603:10a6:102:ca::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 08:01:35 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 08:01:35 +0000
Subject: Re: About regression caused by commit aea6cb99703e ("regulator:
 resolve supply after creating regulator")
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        broonie@kernel.org
References: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
 <20201108171811.GB10914@qmqm.qmqm.pl>
 <858790f6-8b22-4fe7-bb74-56904ad203bd@suse.com>
 <cea48473-eeb1-db60-cc0d-ebf9a26aaf0c@siemens.com>
 <20201122163534.GA16669@qmqm.qmqm.pl>
 <85cc66a3-2625-acd5-ca28-6ef0abaadd21@siemens.com>
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
Message-ID: <a139a25a-61ef-1317-5cdb-c782fec5002b@suse.com>
Date:   Mon, 23 Nov 2020 16:01:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <85cc66a3-2625-acd5-ca28-6ef0abaadd21@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR08CA0035.namprd08.prod.outlook.com
 (2603:10b6:a03:100::48) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0035.namprd08.prod.outlook.com (2603:10b6:a03:100::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 08:01:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a92bca-5332-4c61-ff9f-08d88f85ffb5
X-MS-TrafficTypeDiagnostic: PA4PR04MB7934:
X-Microsoft-Antispam-PRVS: <PA4PR04MB7934E1154AF310291500B846D6FC0@PA4PR04MB7934.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waARNFnc30P2fnS2jSUsypxyBMQlIUUxjC4Y/a6hSkcT2qqhNCeq8x0uM9UbO0u4JqSv8YozW/aFDIU3z8tFdd/U/mH99FmEob16m4fvNwu9jmZ9ySVdnk7PRX/+9OYykPx/oMWN6HwaozaSr7zuPnz3kY/PhBACNJ8jBtXNB5lMyDgS5R6vPGdXyOkJZKCkTd4qtMHhaz7eU920Y2PxHrRDISd4qFAVJ7eMuF6uKIHIb63jwAbf0vayAdBF2zPI4Od30/34jY0O1oEkMWVYKzMAhx+RDYSoZYekrVYTMEgZvpHLlEvogzxg1dNcBXlGtb285KPU7/D8SH62yCtIS0HkOv/6Mpr5TMYa/CNKvvbkixQ6oBkZJsYWTJBzm6V3oPG4HEn0li9pu1GQZ7wT0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(956004)(86362001)(316002)(26005)(66476007)(186003)(478600001)(5660300002)(66946007)(2616005)(54906003)(6706004)(16526019)(66556008)(6486002)(110136005)(8676002)(16576012)(31696002)(36756003)(2906002)(6666004)(52116002)(53546011)(8936002)(4326008)(31686004)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eiyEGp6mVr587hGYL53zYieYdTpHBBK9PBUQW2v6P7G+ZTAiaWxUdWAUfKfsBVvIHB3bq9kgDxC0g5vYaZxYzV/C56KiKUa8/7Y26+4bv4mhQ8LZCv6W/U0gPKNUndFr0WyBjqOQrW7BIQHuVn/gkZOZP1l+dVy5WBi03alNK8UpIQdppVT31sfzEuDyWnvS5twGmN3/Rz549Zayp3LAX2phwuvd0/aGE1A7j1D3e7KBvkhsUPeDpx7FmM4xZHHQZvFVnL23bMOVwq+nD44KsyNB5GnRJ/ENAujqEqXz+LLJeyNGoSBcwQot5z/HzQeiR7n7xZVmHm+ucRM5Wr8dBZ56wYZ++0P7p1QyLwudD5Sgyf5z4cBSFdbBIvge9ZDwUFyGJ9s7QdD/+NWOOr5LpZzHqq/+cWBCsf6pviEzia8v0RrSKhafcyBhcw2uaO1RntU0lh1M64XNNKFRTgn9xlTy8PudaFa5e7J+LzZ2AI3TNoy4dwAltcvuYEewwt1fAC2v3PcIJpdbAwXrCvOIYZspmy8e/uAxgwLVA1YT98U0v0YEv7XoDlb9O2fn4+S1gaxlQGQEWoehH9Nj0iiNvG2VWGIMZDaKO5LoJOabsoTNvRO5nHBGW8h9rAA9ijbOqP1+DAv9JlER1b9c1p0RzVnH6iEFyvpAx/YDaTVrAr2WZn9u0SoNF+2S1FcqLy1W5ZxMednLNUXHgXXtfvxSbLesoKfpELLVmUHobHoQNZik1WKMjwCKhXdSaH42BERrZ9PUB23aD5S9EK17wNuYGiDQXjfu8dnQtTMx1z6hk0k+KAY0lOutGYP8ewNqXcgf7NPow03Il2mcGsem8nZ4JVp3kKIbQEFiNjZ1wI9rO24Ls2QafldWdRuOHHB4bVoWd5YgBqTJ/o6O20Gc9CAnCA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a92bca-5332-4c61-ff9f-08d88f85ffb5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 08:01:35.8137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJUlR5bjpvWGlVVNXjaUAUrD37EJNba0y+NoFKlmQlQjKtEe9BdyhsASr/BFMqf0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7934
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/23 =E4=B8=8B=E5=8D=882:47, Jan Kiszka wrote:
> On 22.11.20 17:35, Micha=C5=82 Miros=C5=82aw wrote:
>> On Sun, Nov 22, 2020 at 03:43:33PM +0100, Jan Kiszka wrote:
>>> On 09.11.20 00:28, Qu Wenruo wrote:
>>>> On 2020/11/9 =E4=B8=8A=E5=8D=881:18, Micha=C5=82 Miros=C5=82aw wrote:
>>>>> On Sun, Nov 08, 2020 at 03:35:33PM +0800, Qu Wenruo wrote:
>> [...]
>>>>>> It turns out that, commit aea6cb99703e ("regulator: resolve supply a=
fter
>>>>>> creating regulator") seems to be the cause.
>> [...]
>>> We are still missing some magic fix for stable trees: On the STM32MP15x=
,
>>> things are broken since 5.4.73 now. And 5.9.y is not booting as well on
>>> that board. Reverting the original commit make it boot again.
>>>
>>> Linus master is fine, though, but I'm tired of bisecting. Any
>>> suggestions? Or is there something queued up already?
>>
>> You might want to look at `git log --grep=3Daea6cb99703e` if you can't
>> wait for a stable backport.
>>
>=20
> Good. Is that flagged and tested for 5.9/5.4 (and whatever is also
> affected) already?

The offending commit is only introduced in v5.10, thus I don't beleive
v5.9/v5.4 is affected unless the commit is backported.

Thanks,
Qu
>=20
> Jan
>=20

