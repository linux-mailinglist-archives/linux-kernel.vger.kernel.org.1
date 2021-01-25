Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8FE303920
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 10:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391280AbhAZJh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 04:37:58 -0500
Received: from de-out1.bosch-org.com ([139.15.230.186]:43016 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730973AbhAYSu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:50:27 -0500
X-Greylist: delayed 21228 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 13:50:17 EST
Received: from fe0vm1649.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 4DPf6T6rqvz1XLGST;
        Mon, 25 Jan 2021 19:49:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key2-intmail; t=1611600562;
        bh=e+muQfjpYN/grXRvOTQOUaZ8Y+XBA+2ynN1FkqkpBr4=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=d78WJXj2hcPo8yEz29V7fTSATJ3aHwZenl3ztzjToDFKDKsmsjLGyZ9JpiGNifCsS
         R9IKPvQDSQtuabpsDmyAQCK8fr1Yf+zodskSDNkz3Offc1C2JEV2qoTVNQV39OAuby
         9FbzwzgyUGE9pO0+hAIhEkWRw7Qm9OCW8OH1SxCk=
Received: from si0vm4642.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1649.rbesz01.com (Postfix) with ESMTPS id 4DPf6T6YFxz1wv;
        Mon, 25 Jan 2021 19:49:21 +0100 (CET)
X-AuditID: 0a3aad12-f07ff700000020f1-b5-600f12b13563
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm4642.rbesz01.com (SMG Outbound) with SMTP id 10.D7.08433.1B21F006; Mon, 25 Jan 2021 19:49:21 +0100 (CET)
Received: from FE-MBX2043.de.bosch.com (fe-mbx2043.de.bosch.com [10.3.231.53])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 4DPf6T5lPcz6CjZP6;
        Mon, 25 Jan 2021 19:49:21 +0100 (CET)
Received: from FE-MBX2051.de.bosch.com (10.3.231.61) by
 FE-MBX2043.de.bosch.com (10.3.231.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 25 Jan 2021 19:49:21 +0100
Received: from FE-MBX2051.de.bosch.com ([fe80::9402:faf1:5852:4e2f]) by
 FE-MBX2051.de.bosch.com ([fe80::9402:faf1:5852:4e2f%6]) with mapi id
 15.01.2106.006; Mon, 25 Jan 2021 19:49:21 +0100
From:   "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Adam.Thomson.Opensource@diasemi.com" 
        <Adam.Thomson.Opensource@diasemi.com>,
        "stwiss.opensource@diasemi.com" <stwiss.opensource@diasemi.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
        "Streidl Hubert (BT-FIR/ENG1-Grb)" <Hubert.Streidl@de.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
Subject: [PATCH 1/1] mfd: da9063: Support SMBus and I2C mode
Thread-Topic: [PATCH 1/1] mfd: da9063: Support SMBus and I2C mode
Thread-Index: AQHW8xlUd4non6+XsUm+Dh7IRb1SI6o4rktw
Date:   Mon, 25 Jan 2021 18:49:21 +0000
Message-ID: <38bea27bd11b453e9b69dcdb6a0b4e48@de.bosch.com>
References: <20210125125458.1302525-1-mark.jonas@de.bosch.com>
 <20210125125458.1302525-2-mark.jonas@de.bosch.com>
In-Reply-To: <20210125125458.1302525-2-mark.jonas@de.bosch.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.141.241.3]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXCZbVWVnejEH+CQccPE4ul75cyW8w/co7V
        4v7Xo4wWl3fNYbM4uuces0Xr3iPsFld/r2ex2Nt6kdmBw2PFJ32PnbPusntsWtXJ5nHn2h42
        j8+b5AJYo7hsUlJzMstSi/TtErgyjhyezlJw16LiysULjA2ME/W6GDk5JARMJJ7u+sPaxcjF
        ISQwnUni6cJuNghnL6PEun0HWSCct4wSS269ZwZpERI4wCix8lgtiM0mYCex//UbJhBbRKBW
        Yt3WDUwgDcwCrSwS8yddZAFJCAvYSPTe/MIMUeQo8ePMORYI20hi6cRP7CA2i4CqxJp/3WA2
        r4C1xMfzE5gglhVLHJv0GszmFLCXaLvXwwpiMwrISmzYcB5sJrOAuMSmZ99ZIf4RkFiyByIu
        ISAq8fLxP6i4gsTxxyuYIOr1JG5MncIGYWtLLFv4mhlir6DEyZlPWCYwis9CMnYWkpZZSFpm
        IWlZwMiyilG0ONOgLNfEzMRIrygptbjKwFAvOT93EyMkZoV2MP7q+KB3iJGJg/EQowQHs5II
        7249ngQh3pTEyqrUovz4otKc1OJDjNIcLErivCo8G+OEBNITS1KzU1MLUotgskwcnFINTNsr
        v/SXzag6Od/21S2jop0lu1L7xQ+6bDk5U8HUR+ZmbXznPfElupWa5/tavjjNT/J1d0mv3+/b
        uiA4nlf/9g6N3pSsayauezamXRWZu4/9IGPDmnfzIs56VXhf2sFpNDO64McGme3mDysnay+U
        qBS/elZsZaHMpxMXcy5zWPmo/4m9nFT7tfBEr3OFWVDv22v/e1N3HVd8c7p6qlBYcr9iwqZf
        vk0ighEarRdNZJPiDF64lQrOKjWsXflE7sWECTt9I66297741NQu0nz44OeYp/Nuv5X53LHL
        67G3wuUjUZcj5LycBZ8wHbQ4mB7VZWtxjTelm9V5bqtlfvjyqokaNcd3Wlauje8RnaCmxFKc
        kWioxVxUnAgAOQQ0YkgDAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I also intended to send a cover-letter but it was somehow lost. Here it is:

On an NXP i.MX6 Solo processor we are running an application which makes us=
e of real-time threads (SCHED_RR). In combination with a DA9063 we experien=
ced (rare) random shut-downs and reboots. We found that the issue was cause=
d by a combination of the (default) DA9063 SMBus mode and non-atomic I2C tr=
ansactions of the i.MX6 I2C driver. Because a transaction could be idle for=
 longer than the SMBus clock time-out due to a real-time thread the DA9063 =
would time-out and receive the second half of the transaction as an uninten=
ded message.

The solution we are giving to review in this patch is to allow using the I2=
C mode of the DA9063. We kindly ask for feedback and eventually hope for an=
 integration to the mainline.

Because we are on a vendor kernel we were not able to test this patch on th=
e current mainline kernel. Though, we tested a (very similar) patch on our =
(close to mainline) Linux 4.14 and 5.4 vendor kernels.

Cheers,
Mark

 Mark Jonas

Building Technologies, Panel Software Fire (BT-FIR/ENG1-Grb)
Bosch Sicherheitssysteme=A0GmbH | Postfach 11 11 | 85626 Grasbrunn | GERMAN=
Y | www.boschsecurity.com

Sitz: Stuttgart, Registergericht: Amtsgericht Stuttgart HRB 23118
Aufsichtsratsvorsitzender: Christian Fischer; Gesch=E4ftsf=FChrung: Tanja R=
=FCckert, Andreas Bartz, Thomas Quante

> -----Urspr=FCngliche Nachricht-----
> Von: Mark Jonas <mark.jonas@de.bosch.com>
> Gesendet: Montag, 25. Januar 2021 13:55
> An: Support Opensource <support.opensource@diasemi.com>; Lee Jones
> <lee.jones@linaro.org>; Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> Adam.Thomson.Opensource@diasemi.com; stwiss.opensource@diasemi.com;
> marek.vasut@gmail.com; RUAN Tingquan (BT-FIR/ENG1-Zhu)
> <Tingquan.Ruan@cn.bosch.com>; Streidl Hubert (BT-FIR/ENG1-Grb)
> <Hubert.Streidl@de.bosch.com>; Jonas Mark (BT-FIR/ENG1-Grb)
> <Mark.Jonas@de.bosch.com>
> Betreff: [PATCH 1/1] mfd: da9063: Support SMBus and I2C mode
>=20
> From: Hubert Streidl <hubert.streidl@de.bosch.com>
>=20
> By default the PMIC DA9063 2-wire interface is SMBus compliant. This mean=
s
> the PMIC will automatically reset the interface when the clock signal cea=
ses for
> more than the SMBus timeout of 35 ms.
>=20
> If the I2C driver / device is not capable of creating atomic I2C transact=
ions, a
> context change can cause a ceasing of the the clock signal. This can happ=
en if
> for example a real-time thread is scheduled.
> Then the DA9063 in SMBus mode will reset the 2-wire interface.
> Subsequently a write message could end up in the wrong register. This cou=
ld
> cause unpredictable system behavior.
>=20
> The DA9063 PMIC also supports an I2C compliant mode for the 2-wire interf=
ace.
> This mode does not reset the interface when the clock signal ceases. Thus=
 the
> problem depicted above does not occur.
>=20
> This patch makes the I2C mode configurable by device tree. The SMBus
> compliant mode is kept as the default.
>=20
> Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>  Documentation/devicetree/bindings/mfd/da9063.txt |  7 +++++++
>  drivers/mfd/da9063-core.c                        |  9 +++++++++
>  drivers/mfd/da9063-i2c.c                         | 13 +++++++++++++
>  include/linux/mfd/da9063/core.h                  |  1 +
>  include/linux/mfd/da9063/registers.h             |  3 +++
>  5 files changed, 33 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt
> b/Documentation/devicetree/bindings/mfd/da9063.txt
> index 8da879935c59..256f2a25fe0a 100644
> --- a/Documentation/devicetree/bindings/mfd/da9063.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9063.txt
> @@ -19,6 +19,12 @@ Required properties:
>  - interrupts : IRQ line information.
>  - interrupt-controller
>=20
> +Optional properties:
> +
> +- i2c-mode : Switch serial 2-wire interface into I2C mode. Without this
> +  property the PMIC uses the SMBus mode (resets the interface if the
> +clock
> +  ceases for a longer time than the SMBus timeout).
> +
>  Sub-nodes:
>=20
>  - regulators : This node defines the settings for the LDOs and BUCKs.
> @@ -77,6 +83,7 @@ Example:
>  		interrupt-parent =3D <&gpio6>;
>  		interrupts =3D <11 IRQ_TYPE_LEVEL_LOW>;
>  		interrupt-controller;
> +		i2c-mode;
>=20
>  		rtc {
>  			compatible =3D "dlg,da9063-rtc";
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c index
> df407c3afce3..baa1e4310c8c 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -162,6 +162,15 @@ int da9063_device_init(struct da9063 *da9063,
> unsigned int irq)  {
>  	int ret;
>=20
> +	if (da9063->i2cmode) {
> +		ret =3D regmap_update_bits(da9063->regmap,
> DA9063_REG_CONFIG_J,
> +				DA9063_TWOWIRE_TO, 0);
> +		if (ret < 0) {
> +			dev_err(da9063->dev, "Cannot enable I2C mode.\n");
> +			return -EIO;
> +		}
> +	}
> +
>  	ret =3D da9063_clear_fault_log(da9063);
>  	if (ret < 0)
>  		dev_err(da9063->dev, "Cannot clear fault log\n"); diff --git
> a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c index
> 3781d0bb7786..af0bf13ab43e 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -351,6 +351,17 @@ static const struct of_device_id da9063_dt_ids[] =3D=
 {
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, da9063_dt_ids);
> +
> +static void da9063_i2c_parse_dt(struct i2c_client *client, struct
> +da9063 *da9063) {
> +	struct device_node *np =3D client->dev.of_node;
> +
> +	if (of_property_read_bool(np, "i2c-mode"))
> +		da9063->i2cmode =3D true;
> +	else
> +		da9063->i2cmode =3D false;
> +}
> +
>  static int da9063_i2c_probe(struct i2c_client *i2c,
>  			    const struct i2c_device_id *id)
>  {
> @@ -366,6 +377,8 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
>  	da9063->chip_irq =3D i2c->irq;
>  	da9063->type =3D id->driver_data;
>=20
> +	da9063_i2c_parse_dt(i2c, da9063);
> +
>  	ret =3D da9063_get_device_type(i2c, da9063);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/c=
ore.h
> index fa7a43f02f27..866864c50f78 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -77,6 +77,7 @@ struct da9063 {
>  	enum da9063_type type;
>  	unsigned char	variant_code;
>  	unsigned int	flags;
> +	bool	i2cmode;
>=20
>  	/* Control interface */
>  	struct regmap	*regmap;
> diff --git a/include/linux/mfd/da9063/registers.h
> b/include/linux/mfd/da9063/registers.h
> index 1dbabf1b3cb8..6e0f66a2e727 100644
> --- a/include/linux/mfd/da9063/registers.h
> +++ b/include/linux/mfd/da9063/registers.h
> @@ -1037,6 +1037,9 @@
>  #define		DA9063_NONKEY_PIN_AUTODOWN	0x02
>  #define		DA9063_NONKEY_PIN_AUTOFLPRT	0x03
>=20
> +/* DA9063_REG_CONFIG_J (addr=3D0x10F) */
> +#define DA9063_TWOWIRE_TO			0x40
> +
>  /* DA9063_REG_MON_REG_5 (addr=3D0x116) */
>  #define DA9063_MON_A8_IDX_MASK			0x07
>  #define		DA9063_MON_A8_IDX_NONE		0x00
> --
> 2.25.1

