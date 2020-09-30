Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC23027E310
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgI3Hyf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 03:54:35 -0400
Received: from mail-eopbgr1300114.outbound.protection.outlook.com ([40.107.130.114]:2128
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgI3Hyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:54:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJaQOh+aXE8OSBSQnPavTIJCYqpFF6EWDTjDLz4kYPL5DiYKuI0COS8qqV9LFBBoIDGn9s9p6zjgiqm2U97QIID+KSPwQ2a16lRJJxHBAhAGI0Eil9ycxL9jKaU1vwn80aofHPYerecYMQB7+JOAZlOaW7rmfFeKuLm4nGR7njsMZPZULn2dX48JEO4i/g2vDRr4FZ3GxymzCA7GPgZQKr9lcxcS0oXxZXSUHM0iEhNfHvBdzah36AQYHShNf2F3yUqBPIK4KUZtS4xVAmToWfHa9yFuj2O9lS6miPJiWdp+OsNtayfFMqXj2w9DutKLb+4Us8k8g34G3+ebKNFFFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERRxUTKJihBaa/SaMpYpK+TMzP5Zda+RfvqmF6EOYv4=;
 b=E+if8Hggsw4MMigSsew92am/mfXtlUDdbObme4vrqZcXSNoSLBtMnM6oI8U2C2vZ8wRbiF4CquHktkQEaiWpaL/UJHdC2gCQiNQPrCIVmKs5IA6fPq8YlK85mucrSdb7QJELf7LyVA/3x0vdfZApXK98bpmqmSSVMqeSgcX/jmPlmzVMnRh1PDj4Y7x98cSZe4qBdGzAM8BBz+W9fCgPpmod0yhJxT1em0zPfHBOwjkB/TqeJ2DLN0VA6jk6lXa1QQt2sLiKbi0mMOePlpv8LRy0UOdIwZUrr1NSrarLTCjd24NG7TzJ4lxLtVjtVpnX+H0sLwRdBG8NwVCFx+RS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by HK2PR0601MB2004.apcprd06.prod.outlook.com (2603:1096:202:e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Wed, 30 Sep
 2020 07:54:30 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::a1a1:8859:d07a:2473]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::a1a1:8859:d07a:2473%3]) with mapi id 15.20.3433.034; Wed, 30 Sep 2020
 07:54:30 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Joel Stanley <joel@jms.id.au>
CC:     Robert Lippert <rlippert@google.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Corey Minyard <minyard@acm.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: RE: [PATCH 0/4] Remove LPC register partitioning
Thread-Topic: [PATCH 0/4] Remove LPC register partitioning
Thread-Index: AQHWh+7F/kBF9JQr+U229w2dj+FSMali0RCAgAAL8QCAABZ/UIAa0rqAgAMLCICAABvgwA==
Date:   Wed, 30 Sep 2020 07:54:30 +0000
Message-ID: <HK0PR06MB37793A5D2B57972AFFFBAA0E91330@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
 <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
 <551926fc-7bd4-4a0e-8fcf-4675dcdba22b@www.fastmail.com>
 <HK0PR06MB37796D91EC7290A69F2655E491240@HK0PR06MB3779.apcprd06.prod.outlook.com>
 <HK0PR06MB33800F282095AA96884B2FC0F2350@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <485ec282-568f-458c-a91e-14c89415b8e5@www.fastmail.com>
In-Reply-To: <485ec282-568f-458c-a91e-14c89415b8e5@www.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a80fb44c-eec7-483b-f197-08d865161022
x-ms-traffictypediagnostic: HK2PR0601MB2004:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0601MB20045BC807C343B58E6389DA91330@HK2PR0601MB2004.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KHciGghVJ9yQc5/N6L+jLpx90RdO9EE2myO7eojaCfHsPsC6CT6gyIufNWbV03BPKQKJCgwWJGkdonhvDSzitvyb5ChtN57ZEaTTN2xZlf5W9kU8IFJeg88F7zApDgeWbGYSJGV6An4iA2iddcOD+79w2/bMncVeq7Z3Njd3M8NAflwS8T2ssRY+EjrmyR9VciSpRz8gbM9gzbmTErRh/BgM8V+7eax9oJhn5RaKBLq1qexVns1nxiUIxy2zzSQpFPh7wKh3tOAmLvH0oXoYw4t4/xl6FeEgmN18FJQBjS8GwhM+vSpdYeHTeYo+NOmFpVjRjkuGntQhh/9SnbuhGpDxE+dCivE6XRdKPhZDKxZh1b0n6gdZH58BWs5U08I5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(396003)(39840400004)(346002)(33656002)(54906003)(110136005)(8936002)(7416002)(8676002)(66946007)(86362001)(83380400001)(186003)(26005)(71200400001)(9686003)(2906002)(5660300002)(76116006)(66476007)(55016002)(66446008)(64756008)(66556008)(316002)(4326008)(478600001)(7696005)(55236004)(53546011)(52536014)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: i734jfUz7n393aVbssWjmeITEI1wtdfgnc9BaCtzzmFm6L/8GJpgNzcv+hiT1tyx0sfU9KhPPqTt/yuTpCZVihUjTbcZIOnqyEJ7SttuJMKC2uFVHwSUdp1Ni3s7x68Hhztfw+aL+GOctQVuC+FnXjcjqdUwDQTBfJBEvUIEZrzsf1eRoZYm8OBeXIk8GdN+F9yVSEcDWIZSin0lDG1sz3objDXQxiEPTf9bTGiuDhV62Eq0B2BId6ZHh1lHs5N4542Uis2JgcUNEKQQnshNn8p1raGfT7JeCxf3yoXIgIVSLj5Kkl6TnF/Sv/IZpzLI8zBevJa1QibIOtM5NVwahKbIOqW7swPFmtJu6P035fZlcxUUAV8AISFl0oxcmPhvRatvXAzXPiMvG+K1Ywl97dENjGe2QF5NjyWtGqqUsrMgMhi9f/TZvX06oDXQNWPXKfkhuWJtTc1/RJLq2pi821dke4dPu/SypaRfAuwMByxlbO9dLIUZgAdbCt2tL2GTk2C7K6/TKbTg1x1/0fQ4rMNNjWcXqBzkkYdlxTNv7BUP0tsDEv2WNVJtT6Z9989wUto6uwlfPtJqu5Gs9qCiDWX0A+dBMOwD71ET0F4zPIIbCh548YcCIv1UZijwETAkKsJylpEvaLSXXpWvOPI/0Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80fb44c-eec7-483b-f197-08d865161022
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:54:30.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4XQCKOGyJnSVE+5Wtaoj5oHecppH9Jxq5SinO2lidtG+pY0/LyVAlQ6hjmG/SgvYf6Dc3c+JdUdrpWdif5O2CNGMD3Z4jYfzNL3v6l81no8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB2004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Wednesday, September 30, 2020 2:12 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>; ChiaWei Wang
> <chiawei_wang@aspeedtech.com>; Joel Stanley <joel@jms.id.au>
> Subject: Re: [PATCH 0/4] Remove LPC register partitioning
> 
> 
> 
> On Mon, 28 Sep 2020, at 17:13, Ryan Chen wrote:
> > Hello Joel & Andrew,
> > 	Those patches are more organize for ASPEED SOC LPC register layout.
> > 	Does those patches have any feedback?
> 
> I support getting the problem fixed. However, the series also needs to fix the
> LPC devicetree binding at
> 
> Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> 
> What's proposed isn't backwards compatible. We need to agree that a
> breaking change is the way we want to go and get Rob's buy-in. Given the
> impact of the change I'd prefer we don't try to maintain backwards
> compatibility. All known users of the binding ship the dtb with the kernel.
> 
> Can we get a v2 with the binding documentation fixed? That will probably need
> some review.
Yes, I will fix the binding documentation and resend the v2 patch for the review.
Thanks.
