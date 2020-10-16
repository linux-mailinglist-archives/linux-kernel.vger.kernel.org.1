Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6612901CC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405368AbgJPJYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:24:19 -0400
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:34948
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404499AbgJPJYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:24:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/wyLvT1ZguhtVIyWErOAwxZiek3fuYgp/92SxY+h/zR0W/csJLmtPh4nuKpdW3vqR7WMCLjR22ZwQmOB8iKx2Nn854OwWn8Ixlx8dKSE80PLFCjo/A3evwq1P2iPq3dxsXXiHEIWz5przv6ctAVx07ay5/D6EI5hdpUoaJjFIijBajhZKoFDFkXCcEbDkOfkiXexH61S/M5p+JLmTwVrSrt9QUyWd9yEioFSbJL0UIAR/78zk/zCc+pnNEh21w+rgqSzcun202w3SlRXCHiJipcNNE9/1t6zr4ERbqLrDkTjiOL3UrcOboNvRMMxYiM7C4alRY4INOhkRqVh+rM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0/5zS/t8BM1kIoF6h/iN4hsEzx1OmHTnLL9j+3qmds=;
 b=VBaKcoVuu5ar8ad5xjCchbCl+AX/hDAc752GqTiCiVXlxnd9RapGhlrQVGOtFXPa/aLfTTDYoV51haJBZ9LYIBId7Ot/OvR7gZvXtTOLHSb3nu6J7limWQZD9MoL50jS+u1k75xnIwGGJxR3xOnSkvjIAkNoRLnY5N/49LQ2UtzfMHKKcbykduqwI2fJ0oAT2QhVwegRTQk8m9/yzS/E3uj0XyzyyCAGGRX34AhLD/JLVsfRtAzDdQs2M6Qx2bBsfM1ZbJCsMNOQB/g9Zk722GP+6IuAItEuYFdIme0ckomz6g+1bwN4k0/Aj80D0+ld8maq0aWhQucFDyayOR6rww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0/5zS/t8BM1kIoF6h/iN4hsEzx1OmHTnLL9j+3qmds=;
 b=QJ/nq0XAjDkDONZUAi1BMsY3WmT/S+XIq1PgQ8mo/g3DxgkGVDZ3WQydjmjDxQ73tL0pwR0RBJRFydZ+nNC7YrjLQNMcdLM8g4/JoK3jhmE+dRKHnyE4NV6fLcpg8UtkazuAIpeVJ3yg33zpQHR07YW4HzZEjrFEExDdWXXCdlw=
Received: from VI1PR0401MB2446.eurprd04.prod.outlook.com
 (2603:10a6:800:4e::21) by VI1PR0401MB2446.eurprd04.prod.outlook.com
 (2603:10a6:800:4e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Fri, 16 Oct
 2020 09:24:10 +0000
Received: from VI1PR0401MB2446.eurprd04.prod.outlook.com
 ([fe80::c90a:a180:40a2:8996]) by VI1PR0401MB2446.eurprd04.prod.outlook.com
 ([fe80::c90a:a180:40a2:8996%12]) with mapi id 15.20.3477.024; Fri, 16 Oct
 2020 09:24:10 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Reinhard Pfau <pfau@gdsys.de>
Subject: RE: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan
 controller
Thread-Topic: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan
 controller
Thread-Index: AQHWo54a8ltQoVA500aCu7wxAPXsNw==
Date:   Fri, 16 Oct 2020 09:24:09 +0000
Message-ID: <VI1PR0401MB244636CEDEEC9E1F84FD18F78F030@VI1PR0401MB2446.eurprd04.prod.outlook.com>
References: <20200928104326.40386-1-biwen.li@oss.nxp.com>
 <20200929194937.GA1046240@bogus>
In-Reply-To: <20200929194937.GA1046240@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c326bce-4ab9-4e02-4d47-08d871b53d24
x-ms-traffictypediagnostic: VI1PR0401MB2446:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB24461313A2E04248AF734262CE030@VI1PR0401MB2446.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K53pOzrS65lhC2J/WkW3iB3X1TOwG3dEUSUTHLW7H2aEJuwKnpqiQxKq6wuM3ESXz5J4M/DDgJl37TkyUPY7bvC3LIby9v+oEWM0ty6wDdHMSLc8/zoaz1Q3dnccPWYJnt4e6Muakb4Z7VakKZ3LTT8ApIlq+VvR+dMcMOcYQZ+uWH4DlJwDbR6L0s4LTxwdsv64hebWIvGci2k3OweJITGkIEu8ISy6AO7sj03vwD9g43IjdYq5SiX52yAvqIo2PhBKRo0CtPsWSNoFeRN15qoDRgHkkRB/OwdC/Kw5oLAd9i8bhHif1ixllGFh8Jq7CbJjHU//SgBpYA0vFwAWMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2446.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(186003)(110136005)(54906003)(52536014)(316002)(55016002)(9686003)(8936002)(8676002)(7696005)(86362001)(33656002)(5660300002)(76116006)(71200400001)(478600001)(66946007)(66476007)(66556008)(66446008)(64756008)(26005)(4326008)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FhHMLFuzH/kHe9uZrNaqSlK+8Shj7qYHFbazsYLLUQAgng4m4NHmYI/rFQqW8sEL/Ld35fgcgauq+YpPskYgwPe+kV6uNoKtHVlFmmOHTqNbIFYnMHK6oe8lKm+EVN8FbFQyz9UM8tjiKflkmhySoExCw2WWG2iCjC6auBQwI3Iio7yv1oH23gsBKPNmH8GaYQoP53Hk+tEvLD5GuVIYaBMxlxVfeDS51S4i5603fY79fOtK6azXcP5i1zU9LbPs3b/D5LBL8DGq+QkQdYe+OsS5uptKUToiYtwU0Cm+hiZo2jgZ0hel/9Ci/WgylZxlad4XDimGeej24bXrEwO2WgBbtHY4IU18W94eIEwoFsINP15z7ToHHz6j8GTygMxeJ1JBwbrsrlO/+aMfbv7TZi/zI31RJoV9zNVllNJt73/0eQF53phWtpw1VIQEzrVXj09JhCqBICFheneExe6l/4WKgSzgNbkr+QQOk7aTKMzWx3Y/6ZGdU1Z2TRKJTj6Xjm16do9IjUOgXnYwO3UkDwNZMak/lnUuuxrA7lohVzA+tD7Yz4T6ZYW7jLVbj96roECrO77L7tYiJwFH55Mq++nGcjkg4NIAUONYj7tvNngxjczEYBYSs7nXmi9gH93SuEmIiHOL2aFJHXLFqnuBdQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2446.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c326bce-4ab9-4e02-4d47-08d871b53d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 09:24:10.0204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPRnx//iE69saqFPDXu4SbXZWveTItlYgyOrOi+5VkVrDmbI/4Dn+PoJmUeYbgwGNH6l4skC0vby3LubRlVnpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2446
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Mon, Sep 28, 2020 at 06:43:26PM +0800, Biwen Li wrote:
> > From: Reinhard Pfau <pfau@gdsys.de>
> >
> > Add support for SMSC EMC2305, EMC2303, EMC2302, EMC2301 fan controller
> > chips.
> > The driver primary supports the EMC2305 chip which provides RPM-based
> > PWM control and monitoring for up to 5 fans.
> >
> > According to the SMSC data sheets the EMC2303, EMC2302 and EMC2301
> > chips have basically the same functionality and register layout, but
> > support less fans and (in case of EMC2302 and EMC2301) less possible I2=
C
> addresses.
> > The driver supports them, too.
> >
> > The driver supports configuration via devicetree. This can also be
> > used to restrict the fans exposed via sysfs (see doc for details).
> >
> > Signed-off-by: Reinhard Pfau <pfau@gdsys.de>
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> >  .../devicetree/bindings/hwmon/emc2305.txt     |  33 +
>=20
> Split to a separate patch and should be in DT schema format.
> checkpatch.pl will tell you both of these things.
Okay, got it, thanks.
>=20
> >  Documentation/hwmon/emc2305.rst               |  34 +
> >  MAINTAINERS                                   |   8 +
> >  drivers/hwmon/Kconfig                         |  10 +
> >  drivers/hwmon/Makefile                        |   1 +
> >  drivers/hwmon/emc2305.c                       | 689
> ++++++++++++++++++
> >  6 files changed, 775 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/hwmon/emc2305.txt
> >  create mode 100644 Documentation/hwmon/emc2305.rst  create mode
> > 100644 drivers/hwmon/emc2305.c
