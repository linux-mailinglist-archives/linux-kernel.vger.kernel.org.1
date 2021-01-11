Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375B72F0EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbhAKJVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:21:46 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:24424 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728262AbhAKJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:21:44 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10B9FWBW007313;
        Mon, 11 Jan 2021 01:20:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=NdCoZfG+IkEgiAXyeorsQ0SxE1Wp+7tVi1O4aGV8L5I=;
 b=YSNuazUIBZQvrTyAk+6iIzOlV6TxV5Y59DA3FwI/2WEHxY0pjjNHMPEaTTv2r5STMZ/w
 K6kMMf2bu98hAfbkeOjdRJMmPKtOsbVqI72eHFL9vLZTLmlTfCTiC5C5si8PeG152Xg/
 vgmeTO3bR8u2WI3EIDVY/reFYr82/J5NcD1yBoQ2tpkZSBQ8kGMaMXU2afkTXaRu+ABR
 2gBlmMBxsN0nUQGsEdwjq7umkUzZKgH73EqVQW5F8A785DYvizYsI83Yhd5Oz0hlrebB
 DGdOSoSMPatqCtaLr8SyTF5lkv34KHlxbFN/XFWcABmqrrurppjQo4LHBX1FANNH8EQh eQ== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2058.outbound.protection.outlook.com [104.47.38.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 35y8y24hx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 01:20:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjXEqDANux8SLK0aidGKI3dKTIAmFxsXT8aGwZZwrTy3BwAT8t94x/rvVc+T7PEGeT0RWvaKolRSSiHdNELulmNKcK8bWZ2vn0pvV9aKFG+BAfNnIzgNVucDXO9/WYVqmvJbf6FZjRqVKo+NkFd0cWPrIbP+hIhceMQK6csCA0WPj/c69NkXZ52140uyY1/JQrxU9WEcMgmtslPzVwSqM9p12an1pQufhklErhBGFtIhJRxrvg8p3AzvON266riJYShcITZIpqjhYC+F93ONBVdj3NKRfouKJynGisL2IHAgZNDeFio/5vFDOcfV7C6V6B6U+wMcGs5YakT8dd56GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdCoZfG+IkEgiAXyeorsQ0SxE1Wp+7tVi1O4aGV8L5I=;
 b=SuL1iS2glpnosJ8/4MUQTvvnCTKSPT3WScd/WOOIJF/xzTtZHVRZLjLfs5a1kaf4cAaw7xhwnmXrdckyrcALoO44LxmrovXSrKmooNEMRUffUq39munrCRoPxtEcOMe/WqN7Y577FxZTiafIK3eUsYey4lyXVxBmZBX+h3B8MQO4O5jICGZaiGk2xQFT6mki7QfWBcNFAPdyKKiIWD56mN+wJDKdcYno0/3KQyEPKnpEeIf51D5tp92WPExIt4uBxPRAAp84k626Q5fTn/t0V8CX/i/J4tjy55EsWbtzE+Bm7c8/zsQ6zI2uaeOEFfDF02hPXAvth9X2TcoLur12jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdCoZfG+IkEgiAXyeorsQ0SxE1Wp+7tVi1O4aGV8L5I=;
 b=ja+JeLjfl68QCZ7im+Cu7+vhqeUy9An/uYwNce66zpQbbUqkH/nw0Xq5RUiFqsgOP/JttCMKJyON71ZyEteqHP6Y9M0f+AsBID2EylVLhTUJqIwsrDlYzegWyro4AVhSW/S7RzBBCLi189BuI5mUg66eqYNDu3IL7adsoxn7zr0=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB7927.namprd07.prod.outlook.com (2603:10b6:a03:a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Mon, 11 Jan
 2021 09:20:31 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::34a2:314c:e80b:3be3]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::34a2:314c:e80b:3be3%7]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 09:20:31 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     "rogerq@ti.com" <rogerq@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH] usb: cdns3: Adds missing __iomem markers
Thread-Topic: [PATCH] usb: cdns3: Adds missing __iomem markers
Thread-Index: AQHW0hfCdxF+FADJ7kiWsaLMH3xpo6oiUKOg
Date:   Mon, 11 Jan 2021 09:20:31 +0000
Message-ID: <BYAPR07MB53815F102C9C56CBC7AAD89FDDAB0@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20201214125043.29710-1-pawell@cadence.com>
In-Reply-To: <20201214125043.29710-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctM2RjYTAzMTMtNTNlZS0xMWViLTg3NzYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDNkY2EwMzE1LTUzZWUtMTFlYi04Nzc2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzIyOCIgdD0iMTMyNTQ4MzA0Mjc4OTczNjk3IiBoPSJsVUlKSVZsaklSTG00c0FYSzdBTlhUQ1M5QkE9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 992e1c40-50ec-43d3-e770-08d8b61224f4
x-ms-traffictypediagnostic: BYAPR07MB7927:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB792735AC51BA1FC0698E6E8FDDAB0@BYAPR07MB7927.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lZ7ncl0znPj1OF/fP+uxuNm3InTRpsBLdqNjUODCCf19JQLo6Pz7F+TMLKdACaxKkUHI2B/cmT0sVEc6n65v+VhUCPGQzO64S/hT9UyiDl5dUesSfVQGalolHB4djP9pedl3yms1obYGoTuWdt+tB8/rHcrSgf8OQoRSkt+TYry1zyGSDUU5E5m406nHdriZcWss1hLjdfaqa36DTYQWuZkIq4KmBwv3ZULUKTwtiQeExfkjNyQzeM9uAbWuF4EkCwehjRIgz0+H1ZgKdW13i5qNOJrlI4wKAVSp9lCHOrk0UbZB6xR27/RtdYyljFhJG7dnMi2EzI56LSVFnl0JY/2sBM1UAEgqiJkKTxseMjrafCRmxy0i56Z77zev37ldDX6rG1i5fRqvEx1EllpxO02lW3gPr5/wU6CUE54o0geHvBXH1LCAqxGRYkoHGAg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(36092001)(316002)(26005)(8676002)(86362001)(83380400001)(7696005)(2906002)(55016002)(8936002)(9686003)(6506007)(478600001)(54906003)(4326008)(76116006)(66946007)(5660300002)(107886003)(186003)(71200400001)(6916009)(52536014)(66476007)(66446008)(66556008)(64756008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RGYCDsF9D7ub1tjoaqSVEjS4jbP48NtDk+eadmL4KQ6O4M8KIWA6ictIIXk9?=
 =?us-ascii?Q?3xJnkrekF6wCA6OTqLMA2ftyfjfWm+CK7sa98NXqyTp1s+JntE/wrUEPugFr?=
 =?us-ascii?Q?RoKZ5e+j/ocdeMjwsxZA17d238GqNYy2oteBXM+BTpa+LXgfdQPCmeXD8V5l?=
 =?us-ascii?Q?/5lSs6rk1D4OS1yKSXVN6hvXsiPJ2MP83D5WKEqB6wQmhpugPG2kVth5V7jd?=
 =?us-ascii?Q?/noysn5e9UO1jcUICQzK8X++yAmodWKMZ5g7Dyzx9WkoTv1qvgVtN2eo3V0e?=
 =?us-ascii?Q?SOXQ0RktHKOfCPYz3+1VR2W8+x8wQ0oIMt1A8aQfocHvaCNbo9nwzKHvJZIs?=
 =?us-ascii?Q?/bI6UQ2SywIcChJhrxAiAKlN+h96jlVKSIDMdPOmRxZpOobKbMKUhQLPujw6?=
 =?us-ascii?Q?oY9JCA6N3lXjGvjcAeDQxxOhHWzFR9L9aq89F3e7VLKRtU/joc/hi1n8xMZT?=
 =?us-ascii?Q?P14Vuvq4ac/lxs9kjXWmYh4iy4vcI5Ri6gds1iwlQSEZinKz52ce82FOb6CS?=
 =?us-ascii?Q?M44eOSSep37w0G0SCK14gzCQWlgRHXwTzfCa2DsdmxTP7jsWcpU4RQcDUtVm?=
 =?us-ascii?Q?ruYp0qInSD+tkm+rU7u/ouEb1L5qkST9WMK7uOTrn8VGjbKiNyrEwnVrcgeY?=
 =?us-ascii?Q?VtsO0IfxtNGCXnSuYQsCtq+CK0RJzHbRYzPmGci256NrFRxLGGcf+2AuTbe7?=
 =?us-ascii?Q?8BKjPw8Ks5gYJAjRFuAFD1gNm5Y9o3n3koycMlMZWDG2AR7dk/v9f6NSPer6?=
 =?us-ascii?Q?9Iw7atykq4cMAvbdUHOhd2/cldhDcDmsEl8HCe6zE5DsQblO5z8eGBWkarKj?=
 =?us-ascii?Q?Of1H4HSYonzancaU+pTZjBa2soYcgy2G4I0Uhrit21PU6wjrMBoKk+hcttSL?=
 =?us-ascii?Q?8Gng5vspefQ7bqFXfsICA/12M/cwRwQpaP5m7pVbWzHobHMr4bem8zWcQDny?=
 =?us-ascii?Q?KXU2kWcXQ0lOOgY/fFihcFiZ8qFuu7cGYHXws79aY78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992e1c40-50ec-43d3-e770-08d8b61224f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 09:20:31.7762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WHMw2CKLvfQSOOfGMx21+x7me0RFEl0DO7CglAYVwSGACT2TUdkmeeGxVAL+KXgKExFty6rvmd16Zqom3G/yEFPBKbRhEISs0GipV1gRABQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB7927
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-09_13:2021-01-07,2021-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=690 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101110056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

What about this patch, can you apply it into for-usb-next ?

Thanks
Pawel

>
>Patch adds missing __iomem markers in core.h file
>and makes some changes in drd.c file related with
>these markers.
>
>The lack of __iomem has reported by sparse checker
>on parsic architecture.
>
>Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>Reported-by: kernel test robot <lkp@intel.com>
>---
> drivers/usb/cdns3/core.h | 12 ++++++------
> drivers/usb/cdns3/drd.c  | 12 ++++++------
> 2 files changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>index f8e350cef699..bfa39795208e 100644
>--- a/drivers/usb/cdns3/core.h
>+++ b/drivers/usb/cdns3/core.h
>@@ -86,12 +86,12 @@ struct cdns {
> 	struct resource			xhci_res[CDNS_XHCI_RESOURCES_NUM];
> 	struct cdns3_usb_regs __iomem	*dev_regs;
>
>-	struct resource			otg_res;
>-	struct cdns3_otg_legacy_regs	*otg_v0_regs;
>-	struct cdns3_otg_regs		*otg_v1_regs;
>-	struct cdnsp_otg_regs		*otg_cdnsp_regs;
>-	struct cdns_otg_common_regs	*otg_regs;
>-	struct cdns_otg_irq_regs	*otg_irq_regs;
>+	struct resource				otg_res;
>+	struct cdns3_otg_legacy_regs __iomem	*otg_v0_regs;
>+	struct cdns3_otg_regs __iomem		*otg_v1_regs;
>+	struct cdnsp_otg_regs __iomem		*otg_cdnsp_regs;
>+	struct cdns_otg_common_regs __iomem	*otg_regs;
>+	struct cdns_otg_irq_reg __iomem		*otg_irq_regs;
> #define CDNS3_CONTROLLER_V0	0
> #define CDNS3_CONTROLLER_V1	1
> #define CDNSP_CONTROLLER_V2	2
>diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>index 605a413db727..0701853b501c 100644
>--- a/drivers/usb/cdns3/drd.c
>+++ b/drivers/usb/cdns3/drd.c
>@@ -27,7 +27,7 @@
>  */
> static int cdns_set_mode(struct cdns *cdns, enum usb_dr_mode mode)
> {
>-	u32 __iomem *override_reg;
>+	void __iomem  *override_reg;
> 	u32 reg;
>
> 	switch (mode) {
>@@ -406,7 +406,7 @@ int cdns_drd_init(struct cdns *cdns)
> 		cdns->otg_v1_regs =3D NULL;
> 		cdns->otg_cdnsp_regs =3D NULL;
> 		cdns->otg_regs =3D regs;
>-		cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs *)
>+		cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem  *)
> 				     &cdns->otg_v0_regs->ien;
> 		writel(1, &cdns->otg_v0_regs->simulate);
> 		dev_dbg(cdns->dev, "DRD version v0 (%08x)\n",
>@@ -416,14 +416,14 @@ int cdns_drd_init(struct cdns *cdns)
> 		cdns->otg_v1_regs =3D regs;
> 		cdns->otg_cdnsp_regs =3D regs;
>
>-		cdns->otg_regs =3D (void *)&cdns->otg_v1_regs->cmd;
>+		cdns->otg_regs =3D (void __iomem *)&cdns->otg_v1_regs->cmd;
>
>-		if (cdns->otg_cdnsp_regs->did =3D=3D OTG_CDNSP_DID) {
>-			cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs *)
>+		if (readl(cdns->otg_cdnsp_regs->did) =3D=3D OTG_CDNSP_DID) {
>+			cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem *)
> 					      &cdns->otg_cdnsp_regs->ien;
> 			cdns->version  =3D CDNSP_CONTROLLER_V2;
> 		} else {
>-			cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs *)
>+			cdns->otg_irq_regs =3D (struct cdns_otg_irq_regs __iomem *)
> 					      &cdns->otg_v1_regs->ien;
> 			writel(1, &cdns->otg_v1_regs->simulate);
> 			cdns->version  =3D CDNS3_CONTROLLER_V1;
>--
>2.17.1

