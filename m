Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9E2AA9FB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 08:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgKHHlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 02:41:19 -0500
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:38173 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgKHHlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 02:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604821275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=NhqpOqAo7nuDyRSjDt9mZiS8lxpD7zqqL8WEayG68Vk=;
        b=CeOmsMah5u9O3HtBk1BG8t6BcdgVCkAVJ28+/AxJmBjcStXnI46lkYQrcSg7EBeqsF6svR
        fL6TSLHQocKrAtUUhG/Yb02WOLf2PCU95snEKvzhQrc5NMSwFYiqu63VjvJ8S0hCRg8Bz6
        3NgFZBxcRaPNWK8swJLHX+IcCfSwr5w=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-35-FPwOMZgbP3-olGVU-h6xcw-1; Sun, 08 Nov 2020 08:41:14 +0100
X-MC-Unique: FPwOMZgbP3-olGVU-h6xcw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE27Vs34qgxEGqRHFzKCXtO77alT49S8SXWDZwxHOq+LBsTNx51sND09qZGH8XM58C9wdvuPzKecaGoZevpNhw0HsusouL++sDJpBiIxbPs9TQeBrDqr70XKUObbZyy0mIL6vgzmxc7oiD9N3XPiPa271didvrVCg88d0QvcX/3CzD6S2wVr6r857SY53y2TwLwg90GDXCxZMRIEE2qR4KsZdMf8nQsr1xFeEQ6ZkXxVaV9gMADN6NWZSZ6/g06WDuo89ksWdMkmkTfK3rtzbjwyhehxk9TaYsTbNjurhosv/YmdThc7sMTD8QarMFgss3zCmf2da3OzEtnir+jCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTCjQ0hMAfiNo508p3pCmUg+YkysWlT8JcSoPcolyks=;
 b=JjQhvFJQ02TFFGoFZQ/4X/KEiFjIrQ6bkgFvnw0hpdAeOw7qWQxfHnzLXmFemir+5u8UPuVRXLIqjXaB5RtiwJUHBXljOLDrgSlUdzo1tw3BtNjoJ5Jk5RjGPx3Ji9aHGPNvSeU4ZRbQc2PHBVmEDVft2ULrZBzgnKiKSHVo9lsbgi2emOjPQRAbhehkEmlNZ1hA3VF08q0pfIGOimteC9s9DIyPc6yOBbTAxic4QgUvw58ux5Sfo4fX+jDz0ETDKTWrBqvzmd0QDiMgkxn6kxYGuyVWE0/JEHfQ5hNJxr88CN4aZDbHuA4HK5zNI8EmuqnmAe6gc537EiW4dj7mpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7244.eurprd04.prod.outlook.com (2603:10a6:102:8e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Sun, 8 Nov
 2020 07:41:12 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3541.023; Sun, 8 Nov 2020
 07:41:12 +0000
Subject: Re: About regression caused by commit aea6cb99703e ("regulator:
 resolve supply after creating regulator")
From:   Qu Wenruo <wqu@suse.com>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC:     broonie@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
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
Message-ID: <52106dff-aa57-da4b-dcc3-3dedba82a3e8@suse.com>
Date:   Sun, 8 Nov 2020 15:40:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BYAPR04CA0028.namprd04.prod.outlook.com
 (2603:10b6:a03:40::41) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:40::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Sun, 8 Nov 2020 07:41:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99db47c2-45bc-4fc3-76de-08d883b9aa71
X-MS-TrafficTypeDiagnostic: PR3PR04MB7244:
X-Microsoft-Antispam-PRVS: <PR3PR04MB72443360FEFA100126728717D6EB0@PR3PR04MB7244.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkrf5ZINw9NiP+KnG9PkleFec3V8UlkdsTGa066ZAQ4fQQ4zSFC2XT5I6qDrAwjyGR7Qry4nNryjYv/kfJVRehsPAAiHUWo0sLSzir+EzYBxLgu3uASP3RiA1Z5dIwXNvpuN2rQJezZpJqSty9w3/mwf1BMHEJI7VUgqf9Bik0rOAuil9733+cAkMmAaNrKBxvZ2PIpFpgvD35nHb7SgCmYfYZaipLg7phcBOhwPUbGgxeLUtNIzE6DEAMdyZ+fTYCNbWLI9/kmstA6orvUFVRARCCj/V/Jbkv2saAXemphikaD4FI/RMhIvfgFuk56YniS5tdAraBIfRgu8ykSVXlizzlBhxUrSgqvlH2X7cQi3/SK9lf9+X1wVIofHdUT3c/zup4/3OIa1PKZUjUSXZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(5660300002)(31696002)(16526019)(186003)(36756003)(52116002)(86362001)(478600001)(31686004)(8936002)(2616005)(2906002)(6706004)(26005)(956004)(6666004)(66556008)(66476007)(316002)(16576012)(110136005)(6486002)(83380400001)(66946007)(8676002)(4326008)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kUgRCzHgMXYjnaZ2vZnAY883UmfCqiw+rstOZlb3rdoF6qmA7yVW7rhujpBtrJRRFXvrDcaoz+sXaHGkCHUVgUwwjkkmJ3q8AvPc3P3phHZd6VWRn8VxGs+Ns5dn1PMFNHHOm1MQ3aarAGgx4WwLCDfcGlnUepPALOj3LUMvbLkzj1AcFwIO4XjfWrBwOF5Z1trEPuVav1xrNsASuCOgao70c0Iv2qUFFxaSSVZ9u+PI/qgg5fgyWRo5t3TSSxaAUFFx/9KsOJq299VywsoN43HGss8qvahOruUcjFMKZ0+KzKUcQWdQKrZ9a1e5Xyq5qp8wmSMMQeYisHTRk3KVVvh237A/OR2DXQl7Im/htLRvl2Y0FeRNXfpkkg7lbPsxJ/kTM/NIPK94OFkZXxW9hIkI4eBZAfAjHTZjMUXMdj4mheI3fmHw+/6OK6a+6+uhflRaRoi4jcP3CFSuBrBskI7ocnW6LOCLodkXiqY8PiX2zm+oarzTKXGyNLVmIO3khQE5GEbVfVejnrHH4Vj2xO390eaC6OIofw4rCMb+ZRJZSm5rFTsJWHWMgSIV0T3xmOxOIdWjHvaqG5Uo19z174dtY2uP/0KtjBuOY42y0M5kwQJ2h6Mg+T6Nh0QIjjOPfFwSlw7fixJClvx8flZ7yw==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99db47c2-45bc-4fc3-76de-08d883b9aa71
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 07:41:12.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f506+diTdoVe0d2jakoV2cK1IvXl5cYEfa7usG18Or78rCOJEF2MP6ZcCdzQeJfc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7244
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add Rockchip and device tree mail lists to the CC, just in case we
need to update the device tree for RK808.

On 2020/11/8 =E4=B8=8B=E5=8D=883:35, Qu Wenruo wrote:
> Hi Micha=C5=82,
>=20
> Recently when testing v5.10-rc2, I found my RK3399 boards failed to boot
> from NVME.
>=20
> It turns out that, commit aea6cb99703e ("regulator: resolve supply after
> creating regulator") seems to be the cause.
>=20
> In RK3399 board, vpcie1v8 and vpcie0v9 of the pcie controller is
> provided by RK808 regulator.
> With that commit, now RK808 regulator fails to register:
>=20
> [    1.402500] rk808-regulator rk808-regulator: there is no dvs0 gpio
> [    1.403104] rk808-regulator rk808-regulator: there is no dvs1 gpio
> [    1.419856] rk808 0-001b: failed to register 12 regulator
> [    1.422801] rk808-regulator: probe of rk808-regulator failed with
> error -22
>=20
> Since voltages from rk808 are not proper registered, then it prevents
> the rockchip PCIE controller to find its voltage provider:
>=20
> [    1.855276] rockchip_pcie_probe: parse_host_dt err=3D-517
>=20
>=20
> I currently tested with that commit reverted, then the RK808 works again.
>=20
> Is this a known regression? Or the RK808 device tree is out of spec?
>=20
> It would help a lot to fix the problem before the regression makes all
> RK3399 boards to lose their ability to initialize PCIE controller.
>=20
>=20
> BTW I didn't find that patch submitted to mail lists like
> linux-arm-kernel. I doubt if that commit really got enough testing from
> arm community, especially considering that currently ARM is the biggest
> user of device-tree and regulators.
>=20
> Maybe it's a good idea to also submit such patches to arm related mail
> lists next time?
>=20
> Thanks,
> Qu
>=20

