Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE59727C238
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgI2KTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:19:03 -0400
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:37203
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgI2KTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:19:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhN/nS+Nq0VrL7aEnNDkNpqM89RFNNBm8nbXvLdSLLQ79ahV0HvsAuU/HMMiQe6anq/rV9ed/vJkgnbQncCGEgnA9wdDsuJ6d9X/zaac/j2wzS5nyS0a1SeHqDyC/tt0wea4MSYs4BdfCszec6gA3fVDeKiSz1CB4q1GIJqhpUTe7HOIuqnYdg9OL31tbQNnOsFEw06V6EFW/LADkOf5rV+x7dqc5aRuJXQ6Kh9KaN72LIcgeRi8yJMffjuFTu1t/7gxOCcdGKoBgGxXm+lUVqJtvzlk/beoXwFoHMjrcRfZ4DRpSuglDwQ4SVfhGTqsKQA6adxdiXlJd7Rwf4j/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3iJiqycZZlziR3GK/QHx/x1sCdpq0ltYBozgvTzKN0=;
 b=WOquIaVbXlCSyz6aCrOGARaFYJ6JrtKy8lsK0Wd5DxxxvHo0aQV+H0MFYPcJ/sZrkD7zRMzRjNwACOVkJlz8/WPORM3SGpA53LOHoldg4U/5XasucVcATTx0SYLiJeINA/4rbcR70ky+r8kyxINTrfuDemAh7M0MnwvrB4xQTNuvWIj5v3JN2KAP2pNxyOJ7eLDlg+vbo80pDAf2LZIfTcihsfWPTY2AtKgFmA/c9z9MSPvfW3JRowOD0cRCu5Ak3p7b2YGcHs4rivHv2vgIg5fvE5lFybmi6yPhCGt1rKMV4zyf5ezqv31+i4fLNc/zJmSikyj9JSxicoxXCzc96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3iJiqycZZlziR3GK/QHx/x1sCdpq0ltYBozgvTzKN0=;
 b=lmpWI/FkZ/8dseAghmasaUiswE9gxD94A+hfv8oXexkhZ1c1jqwt9iMsAoh8kRyDXD/hkN4tczHYJhaYqW4GFkjVaIjKDOfjkMC6bT4tjza0q417sZT3L4b37R9SBXcBTG9/EPrZGhfv27/8qtxG8FQkzfL45Ojl3oAgDYGcKYw=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Tue, 29 Sep
 2020 10:18:59 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 10:18:59 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Reinhard Pfau <pfau@gdsys.de>
Subject: RE: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan
 controller
Thread-Topic: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan
 controller
Thread-Index: AQHWlknykGKAx8F3l0ypnNqJIqmdbw==
Date:   Tue, 29 Sep 2020 10:18:59 +0000
Message-ID: <DB6PR0401MB243843B6CAF36CBECFE742BB8F320@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20200928104326.40386-1-biwen.li@oss.nxp.com>
 <20200928162839.GB106276@roeck-us.net>
In-Reply-To: <20200928162839.GB106276@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7d9d6f1-b0f9-4503-e009-08d8646114a7
x-ms-traffictypediagnostic: DB8PR04MB6907:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6907148FB43AED65E34A7D8FCE320@DB8PR04MB6907.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxHy2TJNRis0Sb1iqG2X1wb3jnBoMOw6S1xhReA9S5ftqphEi9kvCdOzHZXtm4ublWKt2zj/0R7FIm+m0nhbhHXsU1jd6RFwgCTT1IBA3fxOHbFuDg7vcBe4t8L2ASFhFL33rOvD0FVYprGZI0pcpVhG/N6wV4tHyB/jIdjk9zAzs8z3j8x+rQXkvWtVXWQ44cNiflVykNitx6p+cUuz+H/eGJJIi1PmugvL6WCbg/4G2r64+kjOfVPUIpfTYEYYD4hUv+mAbJc9q5nW+Z15TkMLxaKl2ZtPAdAlmw7bC668puHfwMyzpgW/6E5+KvRM4bSdHbtD+0RxCwdDVeICk2y0pi0kphflytBPRavpIMn9imqgWepvJHYUDjPdp2Pi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(55016002)(6506007)(54906003)(110136005)(33656002)(26005)(316002)(76116006)(8936002)(7696005)(186003)(66946007)(5660300002)(8676002)(478600001)(9686003)(71200400001)(52536014)(2906002)(4326008)(558084003)(66476007)(64756008)(66556008)(66446008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fqmMgs4xCxmiuRB5Li18JPyx9vDQbfzzXEdl3USTxUrexaXP0pUYepsIItNtJGDRdxRCDwad2YbXOU+K6zs3aFyn66gT4ES+uuoFdne3j/3cVQilsQwWix4WVZE/TLzoWsITEvIdSvUiANE8fHpMCM3rLaynRepZGO54v9CNs77pxFsz8NZXWmQtwcFsYPX1cXHFy2CbSWNtql4sogOY1BMiuk7GYQZ+YsQq5mkUO0vxnlshI3gg9fCm3gIRRTVCIIaWaSnmsIk9Qe1N0ng1iG2foVQcYFxxqvXe8Jtqqvcn3BnM16fQwi8Z13FC8hUqwolooxEBvtFxfal/n6nB7Bjpq0wf3VIfJuNkjmwCrIEZSIPtlZn3wFwYZna6QU38jQ5KRZ+/joNLURUAouBSFcUU4DISY/Pge7M+1gH2XOwjxxnN5Awlp3KhTqG2bX6+16VcAJ+Rw4JV1Fx8QmvMvnN+HbF6K3MuCv6XjDeB4++DCtul//oJLZR4tjZsUK2m/wMb3Ag61RHrx2kxVA3YhI1q+eM7sgjgdxpZSa7kp3kvf9nEJvvV0j9BGyHGWDKQabaAME9K2yWGy2DSipfxfj2KcgeFWCXeRz/J2VCY4C5V+g0kGIML+/nHupb1IpXej2LVnPx963SBSATvs35EFQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d9d6f1-b0f9-4503-e009-08d8646114a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 10:18:59.3576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYaBaI1oV7qA1RLNnet3aGuB4a1Y5eeJd2srf/POnXZpwGQ2p1Gi4gxfXezVvoYoQLlzyX0A3iW1jPavjeau4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +	hwmon_dev =3D devm_hwmon_device_register_with_groups(&client->dev,
> > +							   client->name, data,
> > +							   data->groups);
>=20
> New drivers must use "[devm_]hwmon_device_register_with_info" to register
> with the hwmon subsystem.
Hi Guenter,

Got it, thanks.

Best Regards,
Biwen Li
>=20
> Guenter
