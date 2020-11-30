Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCEB2C7FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgK3IZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:25:12 -0500
Received: from mail-eopbgr30054.outbound.protection.outlook.com ([40.107.3.54]:31839
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbgK3IZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:25:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8zH9gqvFZ9YAI15ZF6hZG3HZfRo65nYOx2RHmyt8Oz06qF+D/Tkm1sHIWVl8ZckGAl0zxIjLBR3DYDUuPZ6MJxJuk7xCIOL3pE/EDBeNNn+SC8TOAurwQKwhK+qFt9bFCGgo8hlR0zJPo6FCNH1ICX84KnnI/vgNpwHb4bxfiP7PXGSanqpAcS9t1vTJ5RN2DliFI+y6tMmDzCZBIaKj73+GH75krzKQcAPB7nr8XMSWl4GVWmZk2aZCoBUW6rdwE/2GgNJ7nP/nzBYEsul3502WToKZCUyle++Yssqxybrk/9nzY2uybNSMKHU5OMWX04lfc2+Id8jOqNbltP4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1AilLtKi0jl7PxgV5/ir1LM+8oFHaOH3BUaws+yNrw=;
 b=hG5imwJW7q/DNnnY/6ZfgKfKzHujT/It17u31s43LD0r5PLZMP/q52zvQnaBh7t7dDphH5IKTGIaK0zvsxOkMM+55kBx5W4hsry6TJyIlW+4PelFem+NbZVOHlYdK6fH9QKUMSm4Abr6wufBQBz4TqhxzYoBQXCNgZZw4sg325Yb+Unu0L/wNxwVFS9hD85vRIZRxTI+8oZEGBZ1wyobx0R+8S/MRx9Q0waheAZ6PQlvuPRGj5F+0u5ys/WlQsh/rHyMVn5rN22kW8qTOrVJOEigW3mmM65yujvMDkNYT7Jfi694q85+jrQTV3Mx/85g90wiNKE5eLg9f5yMzadeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1AilLtKi0jl7PxgV5/ir1LM+8oFHaOH3BUaws+yNrw=;
 b=qSnbhkv3hc3ncmQVu1+H3aUfE54BwN7AB/xmrCIgh5qt1Q4yxw6hT/ktBna/Es0sLNXfPOYbdSS+uD4Z4U3R2X5mJOCAmgedQ08BnWn9FufbWUsrLGwX18Q62TRM/bo8rgSyBLtiPtmNfv+lqIfgrF113xIFMHRMsKrl2iieQak=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB7PR04MB4444.eurprd04.prod.outlook.com (2603:10a6:5:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 30 Nov
 2020 08:24:17 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::f0c9:fd48:c8d1:5c22]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::f0c9:fd48:c8d1:5c22%11]) with mapi id 15.20.3611.025; Mon, 30 Nov
 2020 08:24:17 +0000
From:   Biwen Li <biwen.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [v3 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
Thread-Topic: [EXT] Re: [v3 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
Thread-Index: AQHWxsgYpP6sSSK1iEmWgP/gNfOyMqngVbYAgAAAcXA=
Date:   Mon, 30 Nov 2020 08:24:17 +0000
Message-ID: <DB6PR0401MB2438A99130A339416F2BC9038FF50@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20201130033055.38462-1-biwen.li@oss.nxp.com>
 <1271261ba2ad021041e0ba331c96a2d7@kernel.org>
In-Reply-To: <1271261ba2ad021041e0ba331c96a2d7@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 688ec9a3-8e54-4856-611a-08d895095466
x-ms-traffictypediagnostic: DB7PR04MB4444:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4444C4AA1C1BAED961DDA1628FF50@DB7PR04MB4444.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:64;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EdZwPLWIsr2/e7M/xWLAV5zfTjoWwXfjJoQeHn8KTY5HeT0VreCSKopogHkH75ed1GZlD0Z9GHAiCON9f4zeAOR7y84qXq0vJDKBsCf6tY5B73l4yB6OXku9TDVm/gDWsaFXd8jyCO0ShukFfhaFfIOC4b4mLRRrmucL8I3DOwsgf+0KKR4tRz233wI3DPpszKwK4ISmuMu7zqCvklyuQsO8ebVdsPezqfX+CUgdtQiHmtzdDjd35NYDK92Q7HuxVruDpq5BUz5xo4ufe8BsrLiemp6upgkhMACP36ewc35pJYvz7WUHPsxfgjlzcF0NoaMS7hheJH/ual6WrI7t/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(64756008)(316002)(7696005)(44832011)(33656002)(2906002)(110136005)(83380400001)(5660300002)(54906003)(53546011)(4001150100001)(8676002)(52536014)(71200400001)(8936002)(55016002)(6506007)(26005)(9686003)(76116006)(478600001)(66946007)(66556008)(86362001)(186003)(66476007)(4326008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?I/kFgCtfkCuhBdOahHjs7/JN7IbZCCS0h1IiHOV0GICXrjv5YeH8+aRIFQe/?=
 =?us-ascii?Q?1FsJTtWs0Ayww+f8KTaSQjc37SuRYkg2cl6BcuOtOg2o6ihcoVaa2JFeRuwv?=
 =?us-ascii?Q?FlUQZpxzA4psJ6ISwAUA0XZ8m7Cdrh7DIXpLWGPQYOotYQ09eiX0RkgiUsOk?=
 =?us-ascii?Q?9RxhfFcPjOVTKU5vxqX/NHqm8ThKxN+C9sF5ms+BCt3lhXAi6iWcE2FeTt7b?=
 =?us-ascii?Q?lWlajA4jJwW+2cBuUlKW2WWED5gPw01AJ0HiwnttYVBlqiL4aBy1/NcnamOt?=
 =?us-ascii?Q?IvDCF5qr9kol82bZK/i4Nt+f6g30FbssQxEhG9nZxgDdB/bE1Fqo5DBpv8gu?=
 =?us-ascii?Q?oARU8r3fWlEECA+QrUjmRYCbTm8kNmeN4QDWnmCAuLHLElrlYLvJaT23RoDe?=
 =?us-ascii?Q?J83qOwhbFaX2MAG5qtgFqHJOX2OD7iydtxMFBzVlTsz66BampQIlFoH+mO3s?=
 =?us-ascii?Q?iPyhFL/vke/ap7a/b62MoekUzWymdcDNawiGEB7g9HkAYwI0D7L/L7vKxRri?=
 =?us-ascii?Q?7jqH8tBo9NTpBCFvXVPvvZCmQah/PkSpQG3PwAD4ayzrBP71Jg6eeqFFcjth?=
 =?us-ascii?Q?o0M3CICFFBViZjOlgQ+iPo/YdVb0C4EIqUrhhqQ32vvLlUCcfOOrzclGJLpy?=
 =?us-ascii?Q?0U5a3X96NlX/uCdMc1Oyt2B/E9s5DiZDU5dv5wvCjRZuB0gGHwHY8FgfSxTa?=
 =?us-ascii?Q?EQATL86O6ZLukBxlWSwCGPqgKP/C4mOgy3TRypgYD4Unbbf569ns/sKfChCJ?=
 =?us-ascii?Q?D2CrkJ59Z69rcXbhfSjhyoUeObijgvJ7UnAFnL3pE6EopbFsThN1HDyDsmxP?=
 =?us-ascii?Q?c/0V6N7oducsxF9KHEGCf1Em/oeEOQicN2wzv2W2SL+dG94Ac/5uRf6Cf7YL?=
 =?us-ascii?Q?dbKo6txZ/aubzuEQMj+72EgtKV5QT6+U2dUJmhvvRYeFwV+Fs0XHV/oRAU0C?=
 =?us-ascii?Q?syhsShu6Mq4bYb0KHoLebLSmtGUQ7ltHeObF+RU9/6w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688ec9a3-8e54-4856-611a-08d895095466
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 08:24:17.3706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hmj1rd7m7zwpdxoR/LkvKTIuNcr4ZQKArSRc7q3dAQDU5CjcQ/WJp4Ne7g+KGxZiTSEab6SfZgoZVHBqZMOu3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4444
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On 2020-11-30 03:30, Biwen Li wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add an new IRQ chip declaration for LS1043A and LS1088A
> > - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
> > - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> > Change in v3:
> >       - cleanup code
> >       - remove robust copyright
> >
> > Change in v2:
> >       - add despcription of bit reverse
> >       - update copyright
> >
> >  drivers/irqchip/irq-ls-extirq.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-ls-extirq.c
> > b/drivers/irqchip/irq-ls-extirq.c index 4d1179fed77c..47804ce78b21
> > 100644
> > --- a/drivers/irqchip/irq-ls-extirq.c
> > +++ b/drivers/irqchip/irq-ls-extirq.c
> > @@ -18,7 +18,7 @@
> >  struct ls_extirq_data {
> >       struct regmap           *syscon;
> >       u32                     intpcr;
> > -     bool                    bit_reverse;
> > +     bool                    is_ls1021a_or_ls1043a;
> >       u32                     nirq;
> >       struct irq_fwspec       map[MAXIRQ];
> >  };
> > @@ -30,7 +30,7 @@ ls_extirq_set_type(struct irq_data *data, unsigned
> > int type)
> >       irq_hw_number_t hwirq =3D data->hwirq;
> >       u32 value, mask;
> >
> > -     if (priv->bit_reverse)
> > +     if (priv->is_ls1021a_or_ls1043a)
> >               mask =3D 1U << (31 - hwirq);
> >       else
> >               mask =3D 1U << hwirq;
> > @@ -174,14 +174,9 @@ ls_extirq_of_init(struct device_node *node,
> > struct device_node *parent)
> >       if (ret)
> >               goto out;
> >
> > -     if (of_device_is_compatible(node, "fsl,ls1021a-extirq")) {
> > -             u32 revcr;
> > -
> > -             ret =3D regmap_read(priv->syscon, LS1021A_SCFGREVCR,
> &revcr);
> > -             if (ret)
> > -                     goto out;
> > -             priv->bit_reverse =3D (revcr !=3D 0);
> > -     }
>=20
> This isn't explained in the commit message. You are changing the way you =
infer
> some properties, and that's not innocent. Please describe all important c=
hanges
> in the commit message.
Sure, will update commit message for this.
>=20
> > +     if (of_device_is_compatible(node, "fsl,ls1021a-extirq") || \
>=20
> Spurious trailing \?
Don't need it, will remove it in v4.
>=20
> > +         of_device_is_compatible(node, "fsl,ls1043a-extirq"))
> > +             priv->is_ls1021a_or_ls1043a =3D true;
>=20
> Which is better written as:
>=20
>          priv->is_ls1021a_or_ls1043a =3D (of_device_is_compatible(node,
> "fsl,ls1021a-extirq") ||
>=20
> of_device_is_compatible(node, "fsl,ls1043a-extirq"));
Sure, np. Will update it in v4.
> >
> >       domain =3D irq_domain_add_hierarchy(parent_domain, 0, priv->nirq,
> node,
> >                                         &extirq_domain_ops, priv);
> @@
> > -195,3 +190,5 @@ ls_extirq_of_init(struct device_node *node, struct
> > device_node *parent)  }
> >
> >  IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq",
> > ls_extirq_of_init);
> > +IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq",
> > ls_extirq_of_init);
> > +IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq",
> > ls_extirq_of_init);
>=20
> Thanks,
>=20
>          M.
> --
> Jazz is not dead. It just smells funny...
