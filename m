Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CDA2C1E76
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgKXGnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:43:16 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:23939
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgKXGnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:43:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATtp6wtQ/EkW9NJjLrJnN69SDSzwSlCvxoo5umxr3wZxVJD3fSLkICEILZ2+Nri03sFLz0fLVZ2qIxnRkpJh+aZjQbjr19Q/y0rGXLidRlMztqEd8rb4HMb8QIqrXCGq2a9U7liFXOO+gA4s2OsZLnNuwKhLrtPu51IrnrbTCMyj8to4KWMNrVuNDpyfOGwuJ2s/MuKI4jOeW645a+QXOzhu2kw0VpAdpTgCIjQP+YsUEccnrx5i1HX4LzBs57/E8I/XY6hoLvr9izkgwLzsIEq1Mk7mFbAL8rg7jGDluZuFV+NVZ45/dv7TE/YvTsF1TwYiRUUQ1he/+fskDW8yVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa8A0VH0O3NngdXpO/Cq5ugDqIQ3naQONtoOLHhvUxc=;
 b=mgej9QUPTOBDFrQ6zbgQlrVNfJiYirwlJUX+E7m5utWmGji7LFbm1a1J+bvSOIWCs/qyh3sN9VifDyQWnmroH//4A6RN0aer+Tba9CgBbeCqDL6Bg3soWQfmirkGFhuVqFM8r+aWM8qENxe7mj8vB0JZl0ZlWyt8w3ayxXjpsuTUFvycWQjPk7Q377/fPaplbe1p7TYhZJkUi8vRNvV/BB3C/gSCUgDqqfe9pf5pN4Z8IBVufGqGLYyyDOFRf6Q2VD4IzthjmLVzeAUzbWHMZWiz1MtUxUzMjeXSFY6YpA0VGVmzLhQYdibl+PYckeV2SXA9qZPy6ZruTm1kzAjaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oa8A0VH0O3NngdXpO/Cq5ugDqIQ3naQONtoOLHhvUxc=;
 b=rYv1LYi1whxYiUdzmdzNSfiLlsTOppo77cKKNxn0HUCZzEh+G2qfRC2l5z2rDGZVwim7UFmCapVfPlc8/wSHm4QlHUd0Bx/HnJFMqyf6mnb00g98c0nuRg6KJ2d2j9quDjtoRsFvsoEZh49A9AMc3OqBvEnrDCBG/LpVnCqoNvU=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB6859.eurprd04.prod.outlook.com (2603:10a6:10:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 24 Nov
 2020 06:43:12 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 06:43:12 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "pawell@cadence.com" <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Topic: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch
 class"
Thread-Index: AQHWwY7qvaWheOMvwU2q0XXgyvVqyqnW1uYA
Date:   Tue, 24 Nov 2020 06:43:12 +0000
Message-ID: <20201124064242.GA32310@b29397-desktop>
References: <20201123115051.30047-1-rogerq@ti.com>
In-Reply-To: <20201123115051.30047-1-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fecadf60-4175-4a75-23f3-08d8904436b1
x-ms-traffictypediagnostic: DB8PR04MB6859:
x-microsoft-antispam-prvs: <DB8PR04MB68593CF66762A7268DCBFF408BFB0@DB8PR04MB6859.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jRSU37YRhij1kP8//BYI9XN5a7Kyfi0Rc4DwG/eAOIp5bi+lVxIrDHLyFpIlLoulwv+fIE8vvybsLelI13CBlUl1qEboO405M9yek9t+/N5ibKrA0tQwNSKmERrRljQGhtXnSRmtF5eJPvpm1OsIhEiv7VBkbbDrtGUplCKcPh+2HTNCM6D1IDng882AZY5LUu00kGQrH+yC4PrslRUIY2T7CqwYP9ieWcF2KRaUwVPtFuR98i5FQStWXRmwI3v3huSvKvxwgBtAk+/7PX3/jEmmr/yJcw95ywGlu114Y5fAALQ5o1UVRLHr+A9c6isg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(396003)(376002)(39860400002)(346002)(366004)(91956017)(8936002)(4326008)(8676002)(53546011)(26005)(6506007)(186003)(478600001)(86362001)(33656002)(6486002)(5660300002)(44832011)(1076003)(316002)(66446008)(66556008)(83380400001)(64756008)(66476007)(66946007)(33716001)(6916009)(6512007)(76116006)(9686003)(2906002)(54906003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yKbn+H/fEbjfVgvTwaVXArxy7Auit0FQblylZmlwkXlFimPnRXZhIDYZrOO4aaR6osdTUkAWmAbgKc9d2Lpwsszgf4DcrmL8KD+8QxxYOFB5ewGNVtbGz9USR0kUVg/HW+Fe8zo0fEqgMXolALtKPIq3aj8Isf6T2RFl1pW2aWQ0M4XDWHTPYDuKGC7So8E2cqz3hvkgO4Q4UoZCZIblgTSmnL9JvZdZCObNLvp9WM/nSiNHj6vgF31hWZ8ZJD2FBGGU6DjFQAFHRGdYwPJHxkOPhN4O8zX2zKIq8AXNbhQ3tIb2FiYZdV4kll/xnUA4JC2JPw/35ec40U4JDwqUfPpXsXGK58RRBhNFBEgJB2IJZQ/UqOVVznIEnnhkNprPpftlB95QP+qpTqiB8jWrEQsahuD4frmw8sZb9o7UOGwAnexj3NtjeCNwlgwMbUUohYTtu328Pk9zw0Q86jnKXtUf/4IiUtwhGIRgU1NLgsBpXcxNikVTp9HZJ/+aA8gt2ohZty7i7uk75uc6tpHzkD88gyMCPC+V4ee1nZ16qxKJazLn5UQyqXXf0B5+7e0KVWY21/6FE6j+KBkqmLNhcIjAQ64ZoXUQWPmWG9B3yeDW3urJlg/ttytLpQcqHSrHOob9ddYuJeUeXHzEVYO1GcwtMvxGeQ/F+Ihn8DAhlmrZflEzcXX8rlomhfop7JDXvYaiqQtTIK+qyJAPIwHXiLWfEw2BryMoG0ZYn3pHDL4lxFoRuDWgGPL/FLyHNaIJGizwUv7JKv1ngD3PL2d8XfcUGc/D+Kc5T98u9wMz8KIqZZtIQ58LlNuJ5mCU0O8zOkRLybQjTiHDVph98mZG/faOPjecUuMu6lMKKprileuOtksK/sfuHiH7yDEyhob1ATgSOyRjH0NVpfkksOMXKw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <345099D80FA90448B80913EA319274E2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fecadf60-4175-4a75-23f3-08d8904436b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 06:43:12.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WC39KZvFtRI+PqEPDrz6HCgb3yqB6KZLsCJDa3MnpobTvnwA0vTbCgHbk6aQNiD1swx2FCgG7kqWTqy/GGXZZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6859
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-23 13:50:51, Roger Quadros wrote:
> This reverts commit 50642709f6590fe40afa6d22c32f23f5b842aed5.
>=20
> This commit breaks hardware based role switching on TI platforms.
> cdns->role_sw is always going to be non-zero as it is a pointer
> to the usb_role_switch instance. Some other means needs to be used
> if hardware based role switching is not required by the platform.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/cdns3/core.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index a0f73d4711ae..4c1445cf2ad0 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -280,10 +280,6 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
>  	enum usb_role real_role, current_role;
>  	int ret =3D 0;
> =20
> -	/* Depends on role switch class */
> -	if (cdns->role_sw)
> -		return 0;
> -
>  	pm_runtime_get_sync(cdns->dev);
> =20
>  	current_role =3D cdns->role;
> --=20

Hi Roger,

I am sorry about that. Do you use role switch /sys entry, if you have
used, I prefer using "usb-role-switch" property at dts to judge if
SoC OTG signals or external signals for role switch. If you have not
used it, I prefer only setting cdns->role_sw for role switch use cases.

--=20

Thanks,
Peter Chen=
