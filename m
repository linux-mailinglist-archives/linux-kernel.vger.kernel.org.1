Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EA527D090
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbgI2OFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:05:25 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com ([40.107.7.117]:44978
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728481AbgI2OFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfSqufvcrRhRShYgxwGGwXVCtcmaVrZ2GnxsTillCwc=;
 b=RbFFcd1YlNqzWGIzvJ5MnzniyLM/Ptf9Th2GmBc4MLEE+e1ScrKRaK8Inzn46hguTouCHNWCEkpaiFKFeL2H5Tv62iVUhPdlQDj0+i/2iA9ktC7xJKHuhvP3WWJ4ZLaz8wKku2wSZfDC1uuLvTPBh2t03jZEqfv9J1FrDSiStGA=
Received: from DB6PR1001CA0046.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::32)
 by AM7PR10MB3302.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 14:05:17 +0000
Received: from DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::8a) by DB6PR1001CA0046.outlook.office365.com
 (2603:10a6:4:55::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 14:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.169.0.179)
 smtp.mailfrom=aerq.com; roeck-us.net; dkim=pass (signature was verified)
 header.d=l2task.onmicrosoft.com;roeck-us.net; dmarc=none action=none
 header.from=aerq.com;
Received-SPF: Fail (protection.outlook.com: domain of aerq.com does not
 designate 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DB5EUR03FT054.mail.protection.outlook.com (10.152.20.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 14:05:15 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104)
         by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
         ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
         tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Tue, 29 Sep 2020 14:05:15 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 12189829
X-ExclaimerImprintLatency: 594545
X-ExclaimerImprintAction: b1ef9f508f464d698d1e0b4e74af7632
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQIun3JCfB4flBMbtEPCQvU8m0Cm4s9Nh30XWchSaJnXn7vCEtuS4gozib/1quzoKtJWSEFhPFZy5HKvYHbFUwtOCoCZVbDFyGxKPq+zyjq9VyoZCtibHeUgHzts/Ufg9x5XU4JTNA6m+ljghG3rF4zJ91X40MpXt2e3y7E7nBbQV6UAAd7f9o5IY0MfsQyDYnQaEy3dj+w+5ZL8xhcjAqwX0j1qbegpiqDLcGgiH3c2yBtSYpmTqhtbkOPdBCZ3+Salu8cLoD+xT0rTAm+ofy1WFafk9NBgn6f+T0Nc455LZbkr8qKwQPv7aoHBiBFd3tbSmO1VDgSvtjrXRsLbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfSqufvcrRhRShYgxwGGwXVCtcmaVrZ2GnxsTillCwc=;
 b=PTWstwanS58SIClL7+Hkr30YJImcGEYFAy7lSlgcxkelUsGFrtmBkkpgofb/JghUJQBjCzpq8HAtKCng+LhMAENkXNZMSdx/ke41cwkhfn6MgirKAR8Aj4Z/Oig/g2DRl+hzE6uTZYOdzCD0ZlvIwf0/5Q0eoV9AV5Q8t5+xeFf7K/FV/yH6QX9epEgESfg8sS/u75ySMBZAb1wl6T5duAHbCI1wRHRfmqrqCXnYheQ/28NRQ6hcGdbfb6enzEF4WO3OXZy7Ky1z3HcWlmQvzMgCLU8t0jxxet2c3yITc6AHNJBET9Ds2bujD4YQSa3Y3jcmw0HepWIX0GI1GpxyUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aerq.com; dmarc=pass action=none header.from=aerq.com;
 dkim=pass header.d=aerq.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=l2task.onmicrosoft.com; s=selector1-l2task-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfSqufvcrRhRShYgxwGGwXVCtcmaVrZ2GnxsTillCwc=;
 b=RbFFcd1YlNqzWGIzvJ5MnzniyLM/Ptf9Th2GmBc4MLEE+e1ScrKRaK8Inzn46hguTouCHNWCEkpaiFKFeL2H5Tv62iVUhPdlQDj0+i/2iA9ktC7xJKHuhvP3WWJ4ZLaz8wKku2wSZfDC1uuLvTPBh2t03jZEqfv9J1FrDSiStGA=
Received: from DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e4::19)
 by DB8PR10MB3227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:117::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 14:05:13 +0000
Received: from DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14f7:2e71:2913:d431]) by DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14f7:2e71:2913:d431%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 14:05:12 +0000
From:   "Bedel, Alban" <alban.bedel@aerq.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/3] hwmon: (lm75) Add regulator support
Thread-Topic: [PATCH v2 3/3] hwmon: (lm75) Add regulator support
Thread-Index: AQHWla2U/gsWLKRbgka8T+RV8aIAAal+QGMAgAFnWIA=
Date:   Tue, 29 Sep 2020 14:05:12 +0000
Message-ID: <d7d4c7343c30e237a71bcd9fc15b6a189c836480.camel@aerq.com>
References: <20200928153923.134151-1-alban.bedel@aerq.com>
         <20200928153923.134151-4-alban.bedel@aerq.com>
         <20200928163902.GE106276@roeck-us.net>
In-Reply-To: <20200928163902.GE106276@roeck-us.net>
Accept-Language: en-DE, de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Authentication-Results-Original: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=aerq.com;
x-originating-ip: [88.130.152.63]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: e7cdd9a4-e116-4cee-6dd3-08d86480b0db
x-ms-traffictypediagnostic: DB8PR10MB3227:|AM7PR10MB3302:
X-Microsoft-Antispam-PRVS: <AM7PR10MB3302AFE096327781DF511D2996320@AM7PR10MB3302.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5VWSEdyCZ+KRsnaQ59MwGS99BXEmMhmxr8XF7V7x0be9rMGQvzNtDhMNghblH/Fvysr7Bd6/YJcJu/KTS4lSKp05GISwXt+7Z/o314TGN8NNI0+uQ5zgZ5vhtl4zPmVsm5Um47mu2XytV0yjTyjfsQh45bJKf6QuFdOjGLHNtguvD1o1EgByAbffieEU34DWuduzbtB0mkYJhSTBqYduiE3oXXTOnTK0U9sGsFZY92qWdZf9XQAzVbf029sgMlavC+tKmN+tNNkz7DEqy5W8sxcJj5TDtHWmPNq8SqCWeFHJfm7VI2EbN82gQRKZSs/98ftGA14nqZ7y9tz8sTB/zKmzR/BuPiStrl6RVxbXOLlD1JqokEsEorAF0HS9ybPN
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3434.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(346002)(66556008)(91956017)(5660300002)(66946007)(66446008)(66616009)(36756003)(64756008)(76116006)(66476007)(2616005)(6512007)(71200400001)(83380400001)(99936003)(4326008)(26005)(6486002)(86362001)(54906003)(6916009)(8936002)(2906002)(186003)(508600001)(6506007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5Zhi+bAdsqMaNj2aeYkKf9FZPe5OgCyjmwT3ioutF1Vtd4asc/Vq3TbJWZaJ9mHEZBVFCOnqdLdmyxFnoXM9bPNtxoggHbJauHi6oYQSpwJ5zoLdK0Wahma16yZMBvqZcmTM2Vu9FaIjlidqlATN+OfIDqqCophN4LstXmoHby+gQ13sef4b4Yke2/boQf1a6C1oPxAMTRHNy88dvkXRuoP8QOCx00WiccCby2TUaFtm8Ta9oieDoJ20fS+3xWzBtyEaHdBZLk2aumm5H45AoeI0AeUVrnPLgiOYq0Nktpmu+326mtlWMwgFE2dVxVikjcwy3dh9WySw694lMt7kH+wYu+xJLec143O2DpMy4Kwkho+ejAW0Si+gM7uvDuEAw9bvaSpXIGii3R/0oivf+GOo+cQxGtq7ctmAYfV1ktccMqF6NL/RFtKlq7yVRCg7jogZVXNY0DW+9yHSIdq2TGXGdo0Llw+4MWQa/CRN3uzOApPoeCfpjRehNuIn4x0GG+sNWfi0qikVdIKM4Trr9Bzax2GKdfoGHu3j+UFabo+EcUmbMz066cGOH7l/c5GZQFjMVv5139/dgbBF6aUClGWYahgdpQxyVKiGhUp4WTZZUcofI+oOu2ACCtvLvTBC1KzdgwmGz1WFemngqIdM1w==
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Eurz/Vh7eIUxi+3YFlNl"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3227
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: efb0cbd7-5104-4c66-7550-08d86480af17
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3LhKL58Quyxct8BE1JIAolg4iTqOJtfR4ZQUpGn6JZFdNm53XazwHvPP+0+SRMwrDg7zynQy4AGUE5RWNdi2D4/yVofHHdt+F2Jmg52aTns3aWyTAEyDN9ZLdg05g260gOC/V44YaS+R/P/b9xaN8sIu/seyA/2IoFbetGSEBuYfSvej2NLCHw7FCk7SbZL5QERz8JNWB3qs/pPTtPBUOZ8XL3HOuMhutT1gGji+VZgZtyVRy+tipkxkxruRpiIEwrnqWzbj/M086xHHqlNZLSaIao9Z/QZHdUSkHsrq7iJmSvn26BovSOEXzjrjzIqde/8ZMgKynOtqxaFLmJAJabM9ErTHa1jNIohfJtPf5UpUg2eCS0ua1OVRSqGnL8jErPGnligGeBQaJcHKbpHcycZUh0gUqvXNU2TuaoauNF3Tay618RLtidO3OseGtAk
X-Forefront-Antispam-Report: CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(346002)(46966005)(21480400003)(4326008)(508600001)(8936002)(33964004)(6506007)(83380400001)(5660300002)(82310400003)(33310700002)(356005)(7596003)(7636003)(70206006)(8676002)(99936003)(2906002)(2616005)(86362001)(70586007)(47076004)(336012)(36756003)(6486002)(6916009)(6512007)(186003)(54906003)(26005);DIR:OUT;SFP:1102;
X-OriginatorOrg: aerq.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 14:05:15.2879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cdd9a4-e116-4cee-6dd3-08d86480b0db
X-MS-Exchange-CrossTenant-Id: bf24ff3e-ad0a-4c79-a44a-df7092489e22
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bf24ff3e-ad0a-4c79-a44a-df7092489e22;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT054.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3302
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-Eurz/Vh7eIUxi+3YFlNl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-09-28 at 09:39 -0700, Guenter Roeck wrote:
> On Mon, Sep 28, 2020 at 05:39:23PM +0200, Alban Bedel wrote:
> > Add regulator support for boards where the sensor first need to be
> > powered up before it can be used.
> >=20
> > Signed-off-by: Alban Bedel <alban.bedel@aerq.com>
> > ---
> > v2: Rely on dummy regulators instead of explicitly handling missing
> >     regulator
> > ---
> >  drivers/hwmon/lm75.c | 23 +++++++++++++++++++++--
> >  1 file changed, 21 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> > index ba0be48aeadd..e394df648c26 100644
> > --- a/drivers/hwmon/lm75.c
> > +++ b/drivers/hwmon/lm75.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/of.h>
> >  #include <linux/regmap.h>
> >  #include <linux/util_macros.h>
> > +#include <linux/regulator/consumer.h>
> >  #include "lm75.h"
> > =20
> >  /*
> > @@ -101,6 +102,7 @@ static const unsigned short normal_i2c[] =3D {
> > 0x48, 0x49, 0x4a, 0x4b, 0x4c,
> >  struct lm75_data {
> >  	struct i2c_client		*client;
> >  	struct regmap			*regmap;
> > +	struct regulator		*vs;
> >  	u8				orig_conf;
> >  	u8				current_conf;
> >  	u8				resolution;	/* In bits, 9 to 16
> > */
> > @@ -540,6 +542,7 @@ static void lm75_remove(void *data)
> >  	struct i2c_client *client =3D lm75->client;
> > =20
> >  	i2c_smbus_write_byte_data(client, LM75_REG_CONF, lm75-
> > >orig_conf);
> > +	regulator_disable(lm75->vs);
> >  }
> > =20
> >  static int
> > @@ -567,6 +570,10 @@ lm75_probe(struct i2c_client *client, const
> > struct i2c_device_id *id)
> >  	data->client =3D client;
> >  	data->kind =3D kind;
> > =20
> > +	data->vs =3D devm_regulator_get(dev, "vs");
> > +	if (IS_ERR(data->vs))
> > +		return PTR_ERR(data->vs);
> > +
> >  	data->regmap =3D devm_regmap_init_i2c(client,
> > &lm75_regmap_config);
> >  	if (IS_ERR(data->regmap))
> >  		return PTR_ERR(data->regmap);
> > @@ -581,11 +588,19 @@ lm75_probe(struct i2c_client *client, const
> > struct i2c_device_id *id)
> >  	data->sample_time =3D data->params->default_sample_time;
> >  	data->resolution =3D data->params->default_resolution;
> > =20
> > +	/* Enable the power */
> > +	err =3D regulator_enable(data->vs);
> > +	if (err) {
> > +		dev_err(dev, "failed to enable regulator: %d\n", err);
> > +		return err;
> > +	}
> > +
> >  	/* Cache original configuration */
> >  	status =3D i2c_smbus_read_byte_data(client, LM75_REG_CONF);
> >  	if (status < 0) {
> >  		dev_dbg(dev, "Can't read config? %d\n", status);
> > -		return status;
> > +		err =3D status;
> > +		goto disable_regulator;
>=20
> The point of using devm_add_action_or_reset() was specifically to avoid h=
aving
> to have the cleanup gotos. On top of that, the lm75_remove() function was
> specifically intended to clean up configuration data, not to do anything =
else.
> While hijacking lm75_remove() to also disable the regulator is technicall=
y
> correct, it makes the code more difficult to understand, and it creates a
> potential source for subsequently introduced bugs. Right now I am not inc=
lined
> to accept this code as-is. Please provide arguments for handling the clea=
nup
> this way instead of using devm_add_action_or_reset().

I wrote it that way to keep the memory usage lower, but I see your
point and will update the patch accordingly.

Alban


--=-Eurz/Vh7eIUxi+3YFlNl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0W61GceYqNjiMSkodJSaS524LbwFAl9zPxcACgkQdJSaS524
LbxYpxAAhDKsm5sfgQVnM6s2oJZ06uTuC0piidTqD8Upzxzf6R72oKb/s5dCer/E
PtqOXOYmG/a9ELHBmpIa8+0//ynWJ7EKUAtoC7M/kC66mBZ7Oo7f2bN8EVgXOfBQ
LT97+wVHYQhxmDsN6otJTnRqe/mjmn/cMJl9HZoYb3vpcKOTabeVlIq/h/uvNOZG
0GRN6o7jOEOPSMjCLUbfKLIL9Fzh25CGQiyf13ROQMCUEjGCZX6Vr666l/6Aj+Pf
JivJkB+knbUwQpUvZEEr5Lag10UmDnyNMtHxqMq4boc0ocMm9+SsIhDimNzXHPu7
X1rOB0ogTu6gHysbXNBXb1LRBDuPeFxCfto9jvwlEfmp9E7yxxbFAFveqHUFJrsy
/qJIfU8BcVu3DaZi974C8UcjzWLbjwVwhZKeRTy1ajVgbl+2r8UgU+67z42S1sjR
mc5jWWBHvFKwGFHgWfquH+rziG4shKpr1gSqCqtQvNUxsykqdjFtaTcC/VkpwR2c
+7lQW+vWXRB7Nqn0gybkxcPo9JwOGN9A1PboZ6Qufsor+iXNB0r8Ayxgo6ktz+SO
3BU0RBSezzIOFVpj3ShBBQIvRQNhV2+pIckrZGAfjKD87fV3e9q2msoie9mZJe7u
o9cgyKbtxtz1+DS9zXYNT6qo5ZJQytb42B+H929ZZhhevpmoDjs=
=D6SP
-----END PGP SIGNATURE-----

--=-Eurz/Vh7eIUxi+3YFlNl--
