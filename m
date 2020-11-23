Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C722C0479
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgKWLZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:25:15 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:28414 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728923AbgKWLZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:25:14 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ANBNKWd017647;
        Mon, 23 Nov 2020 03:24:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=zvcZUHOO3fLHcx+GU//096JX0wY/C0c3iQyMbMsmRTk=;
 b=r+Ory6VmMfgH0omyUANr7izsrptWvwLoanWBxNQlRTBjQ98E1CAXAlc74Zi4BensO/MV
 vVaWcVQMtDLvIOqMMYWQS+PwUfCjN0aJaFPgIJL5iCFl0J5/sFDNrrVH47xlQcf9Mne6
 z/3shVMPd3dhWA/V7stWB/3PBeJXvN0x8+9A9mTYsF+iRXYMPXK217TvuNNgiIvYHK8S
 zXP7c7pvYligOXN77ydrgk7SRbQr9rdMYU32gXU16wSEd0xXM+6pO1l9ORALr1Jqpr3E
 pCRR0S6DgU4g+1M3TAN6HT98BdNjUgnrXEmeZVOfHB4NhO29IxxuajgoPrO+ENkY64a2 5Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34y0aywrfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 03:24:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYYM6vhRtbq89o/1TUCpYfBG/t21x1ItLgdfRXO/FzI2k3tBlCPgJKfemD68X8eVmBOzWRB5HJFiU6NIlIp2/19AGM1OZKe2qarRbnXDkzsExa8IpbBtFUsuRk1ht3j9WT6aucj18nEtQzsOtRSKwupyNKv47t/SBjXB7lmMqwdAFSbPzjfteiZXr0pRcJPFVyF1nvF/Lt0dfCmHNROR+KDmUGgxqoxeqAAcfHAIIvIg+WVdjYXvbhHDJLlJq2YHNDbmkX1GHxEeavHmh0MXVa/4UTgoY/fFj8l8/tY9IsIiTrdGwBeOvk3p3gyv3KuW6inNEw2ccJtOJOXQUXQfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvcZUHOO3fLHcx+GU//096JX0wY/C0c3iQyMbMsmRTk=;
 b=Wu2J7W5eQoNyiXd9NUjgFLDSuGA8OSN2TmTupPX4IogxhmnVnTu2mTY23aIo7lAR+z5UH6rS5klJuVWcdFx51GPMiHJ0BCQsst6BzEFyKSVS9zPxpDBDZlitAHi9qsQrHPctAtBEIssv6VdH45ajvHcVQT+jC49w9ZYy1GIKVcFoau+KgLr5qi4OO0vfAAtfrtNELtDMl32t/q/S2jlPnAG1pNP2374l0TkhVX+46amS6MabvDvNG7zyXwJAL/mHxeBx1pRZV1pFN3K8ATSuJOZM4ynV9x8NR0k5S4SbX8E9fJkwZg/qbEJSRm5qClxAv2tcpMiP4ZlpGM9rI5ZxpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvcZUHOO3fLHcx+GU//096JX0wY/C0c3iQyMbMsmRTk=;
 b=PvzgO8gc3oJgjFpmH2Ls8Z2hDE0Jf5KU/cWdRxkKPJ07MAyXI9PhXx17OuMM7vNoB9iT/9pFKPLl1H6Fi/yxgf6n0f5mBWKqWWmxWwP31bmzFwNUfyeZAyCuriaY3XK8viUhGOjQ4HFDVUrUDUx3miyqKih3MUo2xOrh0NGi9ZY=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM5PR07MB3097.namprd07.prod.outlook.com (2603:10b6:3:eb::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Mon, 23 Nov 2020 11:24:39 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::5c52:d1b0:b595:cfc1%3]) with mapi id 15.20.3589.022; Mon, 23 Nov 2020
 11:24:39 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: fix NULL pointer dereference on no platform
 data
Thread-Topic: [PATCH] usb: cdns3: fix NULL pointer dereference on no platform
 data
Thread-Index: AQHWwYZYHPX8ySLV70yqfPPTZ98GaKnVkmOQ
Date:   Mon, 23 Nov 2020 11:24:39 +0000
Message-ID: <DM6PR07MB552920936C6FE0EF14FD25F1DDFC0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20201123104931.2653-1-rogerq@ti.com>
In-Reply-To: <20201123104931.2653-1-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzZkNTJmMjMtMmQ3ZS0xMWViLTg3NzUtYTQ0Y2M4MWIwYzU1XGFtZS10ZXN0XDc2ZDUyZjI1LTJkN2UtMTFlYi04Nzc1LWE0NGNjODFiMGM1NWJvZHkudHh0IiBzej0iMTkwMSIgdD0iMTMyNTA2MDQyNzU3OTIzNzYzIiBoPSJIQ25FMGN6T3lmUzBzclhhWWI0VXRPeExrb289IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [34.99.247.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf99f194-327f-447f-43b4-08d88fa25df3
x-ms-traffictypediagnostic: DM5PR07MB3097:
x-microsoft-antispam-prvs: <DM5PR07MB309799BC3ED477615D6DE46FDDFC0@DM5PR07MB3097.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bt+DalshZv2xe/i3E58cszsCB9ekXRWuIWIISLbWoF37foc6840BYE2mgy2Xh/oUoN+dn7JyTQFPWArzMbSMAw7LqlajK1uDlRVqfPut3643r1RCzGz0I6MRez0+n0Vb74AxNk28YozuNV5sOFEBwysqQkGLc40pCP9tP1g40TWjXiPAgLj0c/SXd2llE8jY0OQGYiSCh9LoiC5Hp8wLwCiVL0RnglQbok/Uvjw92I67Z+jcZhai19kPSUsxkstN8h2HZHauRrDdqICb8VEI+1Z7+9nHHkKNVQwUFscEE1WFeuaaHn/0CXkFKDVeMeRxQsTSbg+BRKs+GcO8SWR60eyUN77aAVnbnSx2U9/9DyGewLy+xh/vVS3LZUbSpf93
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(36092001)(9686003)(110136005)(7696005)(8676002)(4326008)(5660300002)(55016002)(26005)(6506007)(2906002)(8936002)(186003)(66946007)(66476007)(66556008)(64756008)(66446008)(86362001)(33656002)(316002)(54906003)(76116006)(478600001)(52536014)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /Qt9b8nqa3VbFI+Ymcb89PVW3o2PWaRtad9T3Tjx5UU5cC/aHedsY6PwPd1jFkoFu6/X4InARz7PFLoJiQWb08TYJ2AlaMI+ukGzE+2FtvTT0iSKzNyUjduPSPwZEm2379ZxZIJEyID1KCNTP1bObzEVAxaXhblxVXMu4M8MRRiY5URaf1xthKKqYdCDpCm9d9g4yEcf8s5gBBsuEgjpUC+xzc9XGE0OTT9ggwnvyTyNHrAmUDV757ofh6BtFr53NsQUFytibFOZ9Ex8oFvD4AAc54Awap/iBH06W5f7P9xzLUZHkHZjzickwM8wNt1z5wYMgmt4pYKbfRiYxsZxVi4LJ+ostoV24HeIG9pb/7sD6tJtnLSEv67MmmGnjDZwvwxX9/NiC+FyyjcsSNU04ERJWrrQm4VhztV4Pf2At3UnEncgzZcZ52Tcv1miST5PwxnBphcNNURl25UedLALKAC8rgJ6/ZGCOwMSHGlLFk5c+b1xx+FkN/WjkAPnpHiSJxzbW5YY/g9UBiv1THUcGhmwD7SXCGK5zRf8ZRX9Bh2mvXGZBll100qjKZUpdpb0JK4O3IgOiiZTIcP9w45YXjfaKsPgiFQw3kXYXSCe8y4D3gHxxyRaVuXilcFC5ICle3VqWi8EQbnryljufApNZfLqsRZORcnG/TKPbZlVAGT9snmuG6K247e08b7dVs+a8B3v6xm2FQpaUlCYw3EBU3HEVUqCvV0AHOL0Unr8PG0VmjMIPtsCItSbItzkAeO8YBYLZcHxnwm+d7HJP7MLwF6dnV3gR6gCOPSqtXr45Ch5v5kOP4YO/1SGSLVjWVO4zKRU1XZv9/r85FNdPDdissIlNeTw/xA227PEqbxj3obUC6on0whE8RWBNbBxFiitvsfhNeaCpBqcBIBmEfD90g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf99f194-327f-447f-43b4-08d88fa25df3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 11:24:39.5363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMLrmW76pYbek3YD8TD693nokAo4ynj/tD6rW2H40ib5DuCXYrJsEY5fGn+D6hJXzpPumMeIywrq1Z665DNsvOKURM781G3ALNYMFKocF/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3097
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-23_06:2020-11-23,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=920 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011230079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>
>Some platforms (e.g. TI) will not have any platform data which will
>lead to NULL pointer dereference if we don't check for NULL pdata.
>
>Fixes: a284b7fd1b8f ("usb: cdns3: add quirk for enable runtime pm by defau=
lt")
>Reported-by: Nishanth Menon <nm@ti.com>
>Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Pawel Laszczak <pawell@cadence.com>

I see the same issue on my PCI based platform.=20

But I afraid that there will be some conflict with applying my CDSNP series=
 after
applying this patch on Peter Chen branch :(

>---
> drivers/usb/cdns3/core.c | 2 +-
> drivers/usb/cdns3/host.c | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>index 54d841aa626f..0f08aebce86d 100644
>--- a/drivers/usb/cdns3/core.c
>+++ b/drivers/usb/cdns3/core.c
>@@ -559,7 +559,7 @@ static int cdns3_probe(struct platform_device *pdev)
> 	device_set_wakeup_capable(dev, true);
> 	pm_runtime_set_active(dev);
> 	pm_runtime_enable(dev);
>-	if (!(cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
>+	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALL=
OW)))
> 		pm_runtime_forbid(dev);
>
> 	/*
>diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
>index 08103785a17a..ec89f2e5430f 100644
>--- a/drivers/usb/cdns3/host.c
>+++ b/drivers/usb/cdns3/host.c
>@@ -59,7 +59,7 @@ static int __cdns3_host_init(struct cdns3 *cdns)
> 		goto err1;
> 	}
>
>-	if (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)
>+	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW=
))
> 		cdns->xhci_plat_data->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>
> 	ret =3D platform_device_add_data(xhci, cdns->xhci_plat_data,

--
Regards,
Pawel Laszczak
