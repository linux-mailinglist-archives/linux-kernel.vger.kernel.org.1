Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BEA2B7D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgKRMB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:01:29 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:11559 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727050AbgKRMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:01:28 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 07:01:26 EST
IronPort-SDR: 43crEYb5mqIFISCDv7HBeKgtjQWL6bPVliEQVFOgRniUtdk5fFr6l5ZJ8r81SR5jYO6Q9xXka8
 lVlVtjTjo3shfmTvXw5oiFUFAZtNEIX3E4n5SHlJNWUmSktpkYuJjVQ0LpeI45RgojgZi6eE94
 lhT0+KClL+b1Ih31duhpQSWUjOKmZI/LnRw0QMHSmgCJib2+/t87tR7f4K1m2AzSw00tv9HdOY
 xWyY7NMzUxcFgEM4dVS7ucDFqP76YcgdQwFwG/r/PaJq2sW9IJVSsZA43fGq8XPSIi5mxZO3dg
 O7A=
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="21472048"
X-IronPort-AV: E=Sophos;i="5.77,486,1596466800"; 
   d="scan'208";a="21472048"
Received: from mail-os2jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 20:54:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnVdeVk+TBqOaW8DzEP2t/x6JE1phV5KFAQy0jn+sKRo6zTxm4SLVaD4nqDNkAWch2BcVJT02TpnSauozwgOsTQEt0Q653gVuaUHnIdr/aEGkTMV43dwFbJJ6z1qMs3Gro95CxRwGMSNdzoWTirU3v44ruJE2ntQiPj07m2/ibWvHBwvkV0QgCVkPKkM7v09ObtCY4txYfYKdgOKgWf0oLyMNwKyhQyJkLueLYmWUgwWD2s7TvYe72KffUIwpQOUEkoFSVa6FDYNJmKL1LCAk9qT4zpNVqdK0kM2IgxXALps1w4KINght91rBc6dRMGIrRTdgU/ZvhzeXtcylgNQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3MBA/LtBUazcmZ/SVNZliYMu8/G8VP7mqlWhVB6P+U=;
 b=Sav54r1SjHAkuHnBPDw+xRZwkgs9yPWPVUSaT5TBGPLcAMvb3lksMrSjSL32O4FXzeXl2AZGg7CQ/sSrMfpGw5G58cMyGRW0mrfqr1qCfTSpp709M0MxjyfKb5B28Ywo/KK+OBODUQJsjdUONpr8ZjxJASSw/76eVj/TUUaBoywO3C5LxGZh65qCE/u0Zx6fiV+sHaQW5kCkpe+3/xqgGvsuETwivmrfYJKRUd+w3m8mWW0U2tqpWJCzESIe5SekSmbDX0QW9Tyt/4aWC/ZBjiEYZtYs5r7honeeGWieUgRVu1DJcNgnph/OZNae7aCsFfmsdvTHs45dbbF5Lpn9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3MBA/LtBUazcmZ/SVNZliYMu8/G8VP7mqlWhVB6P+U=;
 b=KFH3m9H4MD+iXPFBw0E5grTK7P+MESxKTTN/yW1lR/d52nLM8I/vCYxrkYmXa8mJcIHMKF41JAGiXIpBNUv7vNFJPLw4RcrjCkgF1+c8w7dQyuQIdz5mLsZnnLO6Zh3J046DSt8kixMBJGdduraT3qWlvVU+KdeJ4uFYzDOkFkY=
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com (2603:1096:604:58::11)
 by OSBPR01MB4230.jpnprd01.prod.outlook.com (2603:1096:604:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 11:54:09 +0000
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::d122:64be:9d6c:c04b]) by OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::d122:64be:9d6c:c04b%6]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 11:54:09 +0000
From:   "ito-yuichi@fujitsu.com" <ito-yuichi@fujitsu.com>
To:     'Sumit Garg' <sumit.garg@linaro.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "msys.mizuma@gmail.com" <msys.mizuma@gmail.com>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 2/7] irqchip/gic-v3: Enable support for SGIs to act as
 NMIs
Thread-Topic: [PATCH v7 2/7] irqchip/gic-v3: Enable support for SGIs to act as
 NMIs
Thread-Index: AQHWsQ3EhjITrE0OvkCuaDLAUQx4dKnN3SoQ
Date:   Wed, 18 Nov 2020 11:54:09 +0000
Message-ID: <OSAPR01MB4227CBF50049454E627A948F8FE10@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <1604317487-14543-3-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1604317487-14543-3-git-send-email-sumit.garg@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd760e0c-c140-4f12-dac7-08d88bb8a8f6
x-ms-traffictypediagnostic: OSBPR01MB4230:
x-microsoft-antispam-prvs: <OSBPR01MB42306558F5A75FB117677BDC8FE10@OSBPR01MB4230.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cyYfrPJQQAzVWxtSZg6xqb6nD30ki1BtKL0VdMvnkGvYlbAE0Xb8//DMTmRBBE+MwM9q8zDj5CTFH2eJ7nF1q/GnTr2K3Jmkf6CMmKm0fN6fvODpdjfqtsx96kWtk5D7Pj/Q5ETI38Ofrr45F0XwZ3f8uFgZ4zKocMJDRvkIVaGgY2zwZdtxaY/CsdkeqHMFhIk+BL2PHcO1GU45/tp80SZ8NLZIBdMNgmyShNbr9cx5rv3yIhf7TpncZx0te22+w9Gr+zL1WLd6xehwbjjHDQq8iSLfdSJEG7FcKiQd2BTllEh5tW1N6UyH3FgE5CRegpm1wk1xNGk/8+yh7XR7Ra9ZOZkPH23I9HBLNJynZanYqw/8grDQvuyhT+wOqFRV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4227.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(52536014)(86362001)(7696005)(478600001)(8676002)(9686003)(5660300002)(83380400001)(6506007)(26005)(71200400001)(4326008)(66556008)(66476007)(66446008)(66946007)(64756008)(76116006)(33656002)(7416002)(186003)(85182001)(55016002)(54906003)(8936002)(316002)(110136005)(2906002)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wd+ycRRCtU3Yhpn4u5bXAZiipn+br8bGJmGNghkc8xEkqT4su4uvqKhuzO1bt2z/eW0HEH5l90R1YwyIWC4p9Lhiu2zSN4rEY5VZrGrMVDh45UAuCgav1TvbGOl0mYkf7FaQVsbRhEFNkPIvpayemiS1B6VJrkUo+SdUKd5AdQ3qkRud2uRfUH6+T/51Ld3bFgYYWa86TMumsE9wCbbyq8EM6UEtnTLxLgL5TCqRssYjr13+sWvq0UZ8nAz+0qvyCWhXUM2dtUqUAJlNX65bDDPVaTVm1abSLNAnKLLRQvXCOTXK+AqpXtbZTPJQlMeztqsMWUQP5tmDmBhWrIX9Ymytg/pWbIaRgCqkDgvq0x0THpt066Uz7obWh/keFuiTok3Cq23p7dgl+dStbg0lv+2QXPn3KscRM+s86H2NuiSLuelo5gaVG0Gx+Gf3SdT4vQLJR6q9y/ZsEjhr1RW48IZkxsXb3QB7HA3Res5Xij4fSQ+baPcCufEnlL1anhDx4VpcKwcnP8p+IDSgnabKltVdQIUoejcm1fHYSUPKMouk0F0lVbarRrEPDkJd5Mmq67UxfFr3dgrUXc75hBTib6U0RU0iuNZ+HaaohA4WoilrwneoBHeziKgB45ijo+altqsJ84gmBF/D9Yuz7aZ9kBccy10m0lOdMjhO6y4snT2Jub6co2e/IeXLXFeF2yeKg2Sp1ip/IbYArMwbYhFavP1Mfb5BgliVk3dOleO0kkjgto2D4385fN0w4ASvlhRoAPQqjfR/z+kU8IN55kk6J4J4UFYyv3LAcjHf2nhgb0E6H7vs/nKGlzChcL7BG+tIfZ79XPUFv+BPeJUEiWHBqcj01niMnTU1uC5aLCU6rim+3s3X/9gcq20QMWm8oFmwSVWLLhsD0k6iAnMpJ2AzcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4227.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd760e0c-c140-4f12-dac7-08d88bb8a8f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 11:54:09.6779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekpBGCUyuWU/Mo0B8c23EOMzJuSKRP5vLW/v6Nyhz4Qzg9r0qvOLytTNGEygWxlDQp1bBOx8GoGCjSZSkUX4gjQ6o7ZLAv/y88mQdW9ttuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4230
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

> Subject: [PATCH v7 2/7] irqchip/gic-v3: Enable support for SGIs to act as
> NMIs
>=20
> Add support to handle SGIs as pseudo NMIs. As SGIs or IPIs default to a
> special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI hand=
ler
> update in case of SGIs.
>=20
> Also, enable NMI support prior to gic_smp_init() as allocation of SGIs as
> IRQs/NMIs happen as part of this routine.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c =
index
> 16fecc0..7010ae2 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -461,6 +461,7 @@ static u32 gic_get_ppi_index(struct irq_data *d)
> static int gic_irq_nmi_setup(struct irq_data *d)  {
>  	struct irq_desc *desc =3D irq_to_desc(d->irq);
> +	u32 idx;
>=20
>  	if (!gic_supports_nmi())
>  		return -EINVAL;
> @@ -478,16 +479,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>  		return -EINVAL;
>=20
>  	/* desc lock should already be held */
> -	if (gic_irq_in_rdist(d)) {
> -		u32 idx =3D gic_get_ppi_index(d);
> +	switch (get_intid_range(d)) {
> +	case SGI_RANGE:
> +		break;
> +	case PPI_RANGE:
> +	case EPPI_RANGE:
> +		idx =3D gic_get_ppi_index(d);
>=20
>  		/* Setting up PPI as NMI, only switch handler for first NMI */
>  		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
>  			refcount_set(&ppi_nmi_refs[idx], 1);
>  			desc->handle_irq =3D
> handle_percpu_devid_fasteoi_nmi;
>  		}
> -	} else {
> +		break;
> +	default:
>  		desc->handle_irq =3D handle_fasteoi_nmi;
> +		break;
>  	}
>=20
>  	gic_irq_set_prio(d, GICD_INT_NMI_PRI); @@ -498,6 +505,7 @@
> static int gic_irq_nmi_setup(struct irq_data *d)  static void
> gic_irq_nmi_teardown(struct irq_data *d)  {
>  	struct irq_desc *desc =3D irq_to_desc(d->irq);
> +	u32 idx;
>=20
>  	if (WARN_ON(!gic_supports_nmi()))
>  		return;
> @@ -515,14 +523,20 @@ static void gic_irq_nmi_teardown(struct irq_data *d=
)
>  		return;
>=20
>  	/* desc lock should already be held */
> -	if (gic_irq_in_rdist(d)) {
> -		u32 idx =3D gic_get_ppi_index(d);
> +	switch (get_intid_range(d)) {
> +	case SGI_RANGE:
> +		break;
> +	case PPI_RANGE:
> +	case EPPI_RANGE:
> +		idx =3D gic_get_ppi_index(d);
>=20
>  		/* Tearing down NMI, only switch handler for last NMI */
>  		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
>  			desc->handle_irq =3D handle_percpu_devid_irq;
> -	} else {
> +		break;
> +	default:
>  		desc->handle_irq =3D handle_fasteoi_irq;
> +		break;
>  	}
>=20
>  	gic_irq_set_prio(d, GICD_INT_DEF_PRI); @@ -1708,6 +1722,7 @@
> static int __init gic_init_bases(void __iomem *dist_base,
>=20
>  	gic_dist_init();
>  	gic_cpu_init();
> +	gic_enable_nmi_support();
>  	gic_smp_init();
>  	gic_cpu_pm_init();
>=20
> @@ -1719,8 +1734,6 @@ static int __init gic_init_bases(void __iomem
> *dist_base,
>  			gicv2m_init(handle, gic_data.domain);
>  	}
>=20
> -	gic_enable_nmi_support();
> -
>  	return 0;
>=20
>  out_free:
> --
> 2.7.4

I checked for this patch and I think that's good.
I've tested this patch with FX1000 used my other patches.
The result is as follows.

$ echo 1 > /proc/sys/kernel/panic_on_rcu_stal
$ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
   : kernel panics and crash kernel boot
   : makedumpfile saves the system state at HARDLOCKUP in vmcore.

crash utility:
 #7 [fffffe0029e4fd30] lkdtm_HARDLOCKUP at fffffe0010856eec
 #8 [fffffe0029e4fd40] direct_entry at fffffe0010856c94
 #9 [fffffe0029e4fd90] full_proxy_write at fffffe001055ced0
#10 [fffffe0029e4fdd0] vfs_write at fffffe001047436c
#11 [fffffe0029e4fe10] ksys_write at fffffe001047466c
#12 [fffffe0029e4fe60] __arm64_sys_write at fffffe0010474718
#13 [fffffe0029e4fe70] do_el0_svc at fffffe00101590cc
#14 [fffffe0029e4fea0] el0_svc at fffffe0010147a30
#15 [fffffe0029e4feb0] el0_sync_handler at fffffe001014835c
#16 [fffffe0029e4fff0] el0_sync at fffffe0010142c14

Best regards,

Yuichi Ito
