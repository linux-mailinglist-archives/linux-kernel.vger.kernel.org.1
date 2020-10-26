Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E420298F74
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781646AbgJZOgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:36:23 -0400
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:29774
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1781541AbgJZOfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:35:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxvqgKxvDXrXy/Y1C8jJopwA11BW2Gg3V+eTA0ZftaWb/vuUnzOfnz4Y3AcWDdYbG59NEJi94axvu7/gZEZjRPnNBdWBqJoiXDC2O8/xIzWA7RY7/85+HL8feK/eyAOuzDQjHoq3zJEvK8Tp+Tbfgh+rJ3PO/E7ml9NL6bhFbR7g3Uxolj10/GAPY1IlAW+0jtk/KNBNyf7ygSv6tBnFjVUnDtVn+0Zd60ykEAvsnZWl6W0zPzhvGFyXHZ2s8tjcQyevYv5iscphcFPeJv4GinCnew5pyxynPt8V3m45hO2Hj+EzfHPdqdVnatRQVT888j/NDV2YOdjCs9U/NxWR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34lHZHyMhBgJK1LuretdZFXBK819/yFDHmW+iKAgX90=;
 b=S6bFamBb/4K7ZdZJmeJ/YLzv8yJFq4GpNkVhsBhXXQ5DuKW82Zdf9NvTya3fPMeH6ifLQ2RSDRV/d9GV/RAdrxUKjvtTZjKu0y0D1aU0bu5HB0VRJI5o0+ButcVrBsnr1blbkPz4Q5aQ5AgUr53wuCWC79j6E3MGLPt6gzQHSaljDoHEN9ivyRd7xuC7e0BkLacn6pwvMepjonwqTRhjKkMD4HcRkG9dtn4bDG70hQBXBLp8FTuTQSLZZd4CRPyhXkfTEKts0ncbfUN8Ts2+C4oXQiVn7mOP0pncwQUarBCAZ9QwbCLltDQtao5AtQ98+W6sV0uIauhbH2y7QVTRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34lHZHyMhBgJK1LuretdZFXBK819/yFDHmW+iKAgX90=;
 b=jpH4vfE7gvdw1FU0bkfTg4VMMQMA3q3NHOUfaZid+ZzmRXfOUTnvo0pQmj3RNYYjKQM7cAWhfNq9PGEiMBjCk81N9n6DLJtX9FfzM/fjwQ2r6OZOoSe1vDFmU67+ir96z83CSrcYmX8qCjpKziOZMUo9vxbX3s4jro4MeGU02r0=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VI1PR04MB7021.eurprd04.prod.outlook.com (2603:10a6:800:127::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 14:35:48 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 14:35:48 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
 lx2162aqds board
Thread-Topic: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
 lx2162aqds board
Thread-Index: AQHWlkeurGQdD2+DsEqewDNggGW2b6mewAuAgArj2gCAAHnWYA==
Date:   Mon, 26 Oct 2020 14:35:47 +0000
Message-ID: <VE1PR04MB66876F05E9988139C03294498F190@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
 <AM7PR04MB6885980FC5B035B955D009BA8E1E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201026071839.GE9880@dragon>
In-Reply-To: <20201026071839.GE9880@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 272a75c0-53b2-4f1e-d495-08d879bc6e19
x-ms-traffictypediagnostic: VI1PR04MB7021:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB702157941386D167EA1B5C598F190@VI1PR04MB7021.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IwZJgWHmBA8aANukA/W6jftDtuzrBcCzAi01FP4vO8iZ8qwNLO3UNfKyZsF0rBerC2tCoM4SqJewTJEFull4gOoWnnkvx/xxaEMU0WEvsMKjlhUunMwbsmruB4xU//YKFibinEET3JZ2FO6NfaHi4tVg4VI36whFAzWPiKLpqx3qjjWry/O/pGau6Aljm0kwV+Jd6arB+YDmCa4s6PdADibVzKPuehq7dx5JLm2ucVFv2UWExsjTwc/tN8Xr5Q58BL4aj2bknw6xuvup6GkJusWv3R8KzTdjcoVTjnUngRs6SupF/6snGK0+Gsri4Bc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(83380400001)(2906002)(316002)(52536014)(186003)(8936002)(9686003)(33656002)(7696005)(55016002)(86362001)(8676002)(53546011)(6636002)(478600001)(6506007)(5660300002)(66556008)(66476007)(110136005)(66446008)(26005)(76116006)(4326008)(54906003)(64756008)(71200400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mmT2bvw/daV6W95mDQrSPC+//3ikfojIZVVszGvzGbUw2mEB3A+2Zodysnc8YQxaiHYpJKZu78iC6kELYep+u+Hb/li4B4MRv1ZLvL0ByXgXxbrjqh5BQCNxoYoIoFtQz09b6n9TdGTvF0H17oOkmCkmqhmQm8pE5bEvUu+zLjMIXJ4FZJNNycznmq6Hs00nf9iafWJStjDnU4FMvfPFDtOHrzQhe9Y+czf2o91v7ABLTj7sgLAGi2O+vmlnqul8kcGi9ooswTgLIlCYDBdwlfnpbshqx0+vByE1keTCGKGJRkHPYfYtExkK1LpdZ1uotxd8Kh8nr/nOknPj0ou8P74twjSfJmFmpvSGJNu0eSH6XF2p6UkKHK655vl5/zxBTc4e70ABBCBjKiScXNaTpNo5OPhv/ey7G1/23vlM2AlGEqqzGlFgtkN6PiJjx2vGYpoTaAyaZzrK2XXwO8caNAmTkMFWmlGnGQs7sQHVdi5yBqNZA4mjXorsq0qpzvPdXvfGMVWjQYltQw7LfAa6CnXA/09sb7g2nZYNWcqK8ToeaGsa/bSNjNhv1q5UR93/I/BvsG7F9FZ1MnohBhZjpxmxe2gQQsAq6G/grX5PM75I/ltYTnYzJIPCI5wJxtJknttvCbNpYoNgxp7LmuL1/Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272a75c0-53b2-4f1e-d495-08d879bc6e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 14:35:47.9834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0ryKCAwe5i2ZIPSUw3lKB+bL77MBH0eypq8Z4GtY71GjNrZOd501GxU7ArD91YWIi5WTeOoSQWB1TwouE77TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7021
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Monday, October 26, 2020 2:19 AM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: robh+dt@kernel.org; Varun Sethi <V.Sethi@nxp.com>; Leo Li
> <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ioana Ciornei
> <ioana.ciornei@nxp.com>; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: Re: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
> lx2162aqds board
>=20
> On Mon, Oct 19, 2020 at 09:00:33AM +0000, Meenakshi Aggarwal wrote:
> > Hi,
> >
> > Any further comments?
>=20
> Please address the following checkpatch warnings.
>=20
> WARNING: DT compatible string "nxp,lx2162a-qds" appears un-documented
> -- check ./Documentation/devicetree/bindings/
> #49: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:13:
> +	compatible =3D "nxp,lx2162a-qds", "fsl,lx2160a";
>=20
> WARNING: DT compatible string "ethernet-phy-id001c.c916" appears un-
> documented -- check ./Documentation/devicetree/bindings/
> #80: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:44:
> +				compatible =3D "ethernet-phy-id001c.c916";

Interesting that it doesn't match the following in Documentation/devicetree=
/bindings/net/ethernet-phy.yaml

      - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
        description:
          If the PHY reports an incorrect ID (or none at all) then the
          compatible list may contain an entry with the correct PHY ID
          in the above form.
          The first group of digits is the 16 bit Phy Identifier 1
          register, this is the chip vendor OUI bits 3:18. The
          second group of digits is the Phy Identifier 2 register,
          this is the chip vendor OUI bits 19:24, followed by 10
          bits of a vendor specific ID.

>=20
> WARNING: DT compatible string "ethernet-phy-id001c.c916" appears un-
> documented -- check ./Documentation/devicetree/bindings/
> #92: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:56:
> +				compatible =3D "ethernet-phy-id001c.c916";
>=20
>=20
> Shawn
