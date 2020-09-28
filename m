Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B827ABC7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgI1KZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:25:29 -0400
Received: from mail-eopbgr100108.outbound.protection.outlook.com ([40.107.10.108]:36109
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbgI1KZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOU+1hVByXndAb/RrSoYYQMej4bs6yKI4NzRwMloagpVxqeFeOMFGF/31HQaf5IJCIvJ5WD+GjSY70roG5RPv7wNbRimijxvMKMast18XRbLiDEHJuQpPcMFpP7DUwGVPqLcgiGCb7+Cafhpx68ScUKd+rcKHCu6B7u+yQjGf2W+AQE7KuAF14J0x5BywLwcww1EjwyH53XZxmMPXI5Ud8GruBxUENUgLh4vVFQn60KK+5IrGbSq7e1p/8Vrg4I7dWqypTAiS4HHWESbuRLqfcQN2WVftG7/xsdCHIZD0UNsl727bPUUbLK7QARjTd3FKOBMVILecZweNviDJrVyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=444dajPYRIv/w6ZD8nURolEmaokcJY4xDVVtiytGIAo=;
 b=Bakm7txQG6rb3TSdkv4B6Q15HY92ZfPQKLrhL5FJMxtzkppXfKBF91ozebDbs1dQhwfNUKwwwh1vb7g8hHJi3YHzmOw+Ut3g6xWYgdXpxD+w8TZ41rGTBQnYePpqVCPp2GrSnpG0BmBVp9wTXuDsSJpuZv71pWGAIknzCxhSS4WcfQQb2VjnMFuHCaZ5J6SqV3OIH81B/khKuMOBVGjO7NIp3xp60EaGOLbMe0dQHBbQE4u9Rima5sFW8y1D+uDZLJY+RsN+JHEQ4DN1/MgL4X5yIvUJmHC6VUntXX76j2Pl2O5m2hivae3BSjz6V8jiOVYZV/pZSvQKBWZVV4ylXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purelifi.com; dmarc=pass action=none header.from=purelifi.com;
 dkim=pass header.d=purelifi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purevlc.onmicrosoft.com; s=selector2-purevlc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=444dajPYRIv/w6ZD8nURolEmaokcJY4xDVVtiytGIAo=;
 b=GHM3kkOAH1UhGmQvtLuXeihZII3AQPdpyrK5xpQWb6DwsXZLSP2lwFjIBddUPvZh+PWlRT+IYKf44fnJSVKTL5/2mR6yY1A8hIyEWGBXfd0zRyM+YYAoiWdIVmuDlYdCOBBNKuS1zsHKRaVjnLBrOIsacjW/Ho+a26eMqLqmOTc=
Received: from CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6f::14)
 by CWLP265MB0324.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:1a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Mon, 28 Sep
 2020 10:25:24 +0000
Received: from CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e102:fffb:c3b6:780f]) by CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
 ([fe80::e102:fffb:c3b6:780f%8]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:25:24 +0000
From:   Srinivasan Raju <srini.raju@purelifi.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Rob Herring <robh@kernel.org>, information <info@purelifi.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mostafa Afgani <mostafa.afgani@purelifi.com>,
        open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] staging: Initial driver submission for pureLiFi devices
Thread-Topic: [PATCH] staging: Initial driver submission for pureLiFi devices
Thread-Index: AQHWkoZE6X9fo+Lqi0q3sBmm77AkSal36+wAgAAa6IqAAASaAIAF0mMg
Date:   Mon, 28 Sep 2020 10:25:24 +0000
Message-ID: <CWLP265MB1972D36F944B54A012FC45D9E0350@CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM>
References: <20200924151910.21693-1-srini.raju@purelifi.com>
 <20200924153636.GA1171035@kroah.com>
 <CWLP265MB19727D19DE7D0498EEB2B1E4E0390@CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM>,<20200924172922.GA1188119@kroah.com>
In-Reply-To: <20200924172922.GA1188119@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=purelifi.com;
x-originating-ip: [103.104.125.99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c058eb8c-7724-4c08-b885-08d86398cfc4
x-ms-traffictypediagnostic: CWLP265MB0324:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB0324796F9601ACB387A7C157E0350@CWLP265MB0324.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vb5zsMzf4fDXW51jUMykULO5UdjmLKLMGoMpo2JdApn++DP9fbaouMe4oTZ3vFy+O1QY4BUhkBAJKcxx3sS8Wpc+oD9pzR0/TIfIP5urT6eC9ZbGziWP5hpE4H44w8nMmdZfeQKTTKAOfQAMj3yUFvrj+JBzeCVSW9SWK1B/c/OGICGryAI3QdCfnZG7C+vD+ogf4/xuFssfdpO2mZ4cr6J1miI5YDs0hBZ52aZ1sdJYV+WsJhrIi4Zrmod6sutiGW2DO/nXyKxavRgur9hPpBhfo9XRnBuYUrD6W1U28UvM1Em7zXyXUV2CC7iCxvUaAntvOwYVaDfDfT7L9SDAsUU1XzIIeNXFsCEGZyzlIML31MyO94nf+kLOgndZe4fl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(136003)(396003)(366004)(346002)(39830400003)(376002)(26005)(2906002)(8936002)(7696005)(8676002)(55016002)(9686003)(76116006)(316002)(33656002)(91956017)(4326008)(66946007)(186003)(54906003)(71200400001)(6506007)(52536014)(6916009)(5660300002)(558084003)(66446008)(478600001)(66556008)(64756008)(86362001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: bJ0jeiy62AObjF9QvOolUAcYNWuW29Qu20XtBE0mJRI/1nYPVs10O7rAwKNBwzREuE9cdyw8KrWJqLO9A2AGZqlUnJGPFzd1zBCq+CmP+JTkLJGYw3zmYCfvDrOEIkYGrz0MS5CYfyQLLE31Sjsfjj2EFU/DLstIt1sWZA96znfMVHSR3fh44GJRwOJYZEYO3XJU6LIJUKJQBi5Gg7rJBBiZetEH0FGGoqYE7PjKGAItIV1ePV3+nQznOojmLtuT9RBnPNLXGiOWI6RBKqZ9mVkB9BXzTy8ghK1HpYETiIXpD+tS5J4b4rpWtax+hXw6xFd5Pf3XbIP8Cb9D2qrrg60ggQWbcRNROK1Pry8wXQNAd3P+P8+lnxEKU1eSMiO7ivvy4vc4XO3CGKv89T/NiGD23VQaojqsTuS9NkxKtK1QmNtTdzWH3GAn4AoRY15186rxPkcOXY4r8MNjk48++xILCLqQdQJ5U4URVzdLevNO/crm5QZh42FMynXID51gO+IVSL11MTa48dpYzqR/bsagWoFGPOjNvyMi4eMB8XNPdSjdh7FvBli6/wK1FT42j/sCMPu7zB+8ino9QrUvDKzaqMm6l98vG8J4LhDrgxGqLOVhKOyI76xFwd/a816txmUIRBN0X/AU0N0GZC2f5g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purelifi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB1972.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c058eb8c-7724-4c08-b885-08d86398cfc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:25:24.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5cf4eba2-7b8f-4236-bed4-a2ac41f1a6dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yDANOB0WphZmif9Iz+SbvZX1rk61J6cu1SGqmtpdLMN2CV9Sof9eHgSidV7voMBdllFjvW7jDb11xBHKm0UGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB0324
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
> There's nothing in the "how to submit a driver/patch" documentation that=
=0A=
> mentions that it has to go through staging first, does it?  If so, that=
=0A=
> needs to be changed...=0A=
=0A=
Thanks for the feedback Greg, Addressed your comments and resubmitted in /n=
et/wireless=0A=
=0A=
Regards=0A=
Srini=
