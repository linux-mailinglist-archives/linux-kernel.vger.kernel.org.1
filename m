Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11EF02D52E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbgLJEgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:36:22 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30436 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731718AbgLJEgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607574981; x=1639110981;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rowJIWJPEnW+ZVMN1crnV8bYJ6JiVar9PpxHVBOHyRA=;
  b=HeXuSr/2T4nTU/jH8nNz1meNqK1pO6+DqYssmqHUTAQKS4FBGfv1Qsyb
   bn/Ao4cHpftxgsomBtNFXp/MJPrqpDR/KKKd6NxMvQYGB2WZEoqS3hf0F
   dKm3W5Q7CniQcJqRHT7R9nKTSYngVieEmLqFcwU7buH3w6hCL0C07CTzK
   7zPXUhZrqOgasRhn8ssIZmzHUCKHLO04vQ+0rbbCjc5GEgHlH6m0ZTDKT
   +yJQWX/M6S6tb0y7ETtwbK4Xr70MRhTIdxCX+Gce4QqABK0NuJV3MiTfx
   ZwF3wd0ERcT/d34r4EXweBdfu3Hi8P9oXf4EAREpq59kpbkIZg3yxZODI
   w==;
IronPort-SDR: 9KmJbDw/XMrjo45XyNnsNnkVVg4xATlut9xmhj8qnw5X15EN45NHfVw361gYnwmqKh1hUFlyBN
 Fb9O+Qk3Il0k0yeLePCKcHxKvdjBPpJu0LW8D7lnmkEQjt8YjGBzdzfWHkrzsCaylq3tpMIsLe
 /HsMbckOb19Z+iE45z6tIPXRI2yh6ZvPGn4rCPXajvS7t6h3Y8Xsx/saW5Cl3bLTLxA83PP56E
 OzQJEX5Pn6FxpusbJtIJSJXtzb+FNXRCtVHKK/oNzrxZEub/6/hrYWlz4lT9cNr7KkA02TS+hO
 imY=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="154872628"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 12:35:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jw5O3YJXnO8EX+AYWL72o92tU1b246WdUKHY0pVNs47aDgvEEmIrA8gjNH7nvwOdTlZb4XMPlOwVbReVloHoLMNeHXXumkdXM9+hpeRgSsS4+eK5JLhZGXmFym7PbmlghpzAUOJwZ9bCwQ+7MsozCpCDZphUgyJ6mytkv2acNuL/Ekra8RAsAHCmlDD+2zdavkcMWlal2z5yzFGtA6OsDxIhig2A9FJLS2fkjPzgktDVq87xsoyAAcucVGTscppzTulDu2IPczNMF1E/nASl/87cHfTnbr5dbSNEyJv4kuNHFxxZS/6AJ84DSfwZU4GFMik6G93Y8/Z6syl/aHfbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rowJIWJPEnW+ZVMN1crnV8bYJ6JiVar9PpxHVBOHyRA=;
 b=SNdDhRed9mr5b7RxVwTB0KtQgAGswphik11KJiBlqV5RjtR9Fa6zdLLDOVVqSv3/CoThOuVqgXwvgfGz1g0JfdCMKstAXXqITUODJ9GuUD3N6QblQj0BqWhR88R+nQwR2ObVDvClk1CzhvmfhguVfJKlPNiwpszHu6JwIJqy5tG2K34RHZSKl6nG2y1pqcnurLeV94OlR5WapZ64rW+DgG2oMvkjEXasXC6w79Edq2Utbh142js2vkbNZ2mMEfxROKj3GZwMoSZJmzAlHW4Z6qAA2K04mu7iJCfIETgbUuYCToTY3kruXsuBg0K4mBrF4s+wSZkwoVuYCitJ8CwsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rowJIWJPEnW+ZVMN1crnV8bYJ6JiVar9PpxHVBOHyRA=;
 b=JK7iccs3WS1K5hUUSBLYcp2+T+Zboi/XckranyHFGkeLbTsiiQvGvV8JqG1f+svv/9yLmJsb+MRdJCZItkVtZ6vWZkyuDlLInEeU6IOk94c4YTzTbzi6w2txnkRfLLggbcKdJfGtF+o3zM6z+jFPVtm2EV5WEnrNZOv2HeV/vLc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7121.namprd04.prod.outlook.com (2603:10b6:a03:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 10 Dec
 2020 04:35:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Thu, 10 Dec 2020
 04:35:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
Thread-Topic: [PATCH] nvme: hwmon: fix crash on device teardown
Thread-Index: AQHWznPAcs+o6vD1E0OUFO0WxpdK0Q==
Date:   Thu, 10 Dec 2020 04:35:14 +0000
Message-ID: <BYAPR04MB4965A005E5CED1890293ED7A86CB0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201209213228.5044-1-ematsumiya@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a1ca9d6-a03f-493c-c836-08d89cc4fd08
x-ms-traffictypediagnostic: BY5PR04MB7121:
x-microsoft-antispam-prvs: <BY5PR04MB712113D8F060F8E28D8FA8BE86CB0@BY5PR04MB7121.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/7QOpvG4oh0tT33vRoJ9EhrgVv0lJdikaurB3KVVNiJt0tjhnX/k/SKkus4sKe81Zr9ZlpGnMbq0N/UV+bxEFK6JAOSzBqzfhuCtptAdsMzn+YTFK62iD7oSp0jUHMNN/VA/lIf+6IBWTeD7BBa15muvNU6c9NKlACFArEX6FQVD2V20kOLbyOo4uhteeczF3CA3VYNFTuaDB2nPWA8N6IIXDn6tLpNjvqFlgGvCC/m5L6sOz9WOEDWqrX24WOtU9inffQ2kQMZiNj94E2JEFVdhzn82A00vSz67m4gSW0CHYe6ua1JIf3P2BmOWDETmU+Fb4Paz6ydzzxnJWTj4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(66446008)(110136005)(83380400001)(4744005)(5660300002)(71200400001)(66946007)(52536014)(64756008)(66476007)(9686003)(86362001)(53546011)(8676002)(4326008)(55016002)(66556008)(6506007)(76116006)(33656002)(186003)(54906003)(8936002)(26005)(508600001)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vi8kfdL5qbNa0x0GsoIxXbAwlr4474wBGCIUSxfVmi6XN1PHQ4VYENovTWLQ?=
 =?us-ascii?Q?Ss4eBYi8TyT4lgpiEzWZsI0x2fkN6yxXlaUJnPbf+Oa6wg0rAFfUf5GMl/qP?=
 =?us-ascii?Q?Gg5EpRhB5Viy72PvMafIIIDxTabstJvWgGLiISQOeKnQWE6FWJjSyly6jwEz?=
 =?us-ascii?Q?RsxQMffhfIp1yzHt5jwYAN+sTs3dVNrrYtDdC+4snUIjzw4otFwL75dCBctm?=
 =?us-ascii?Q?xsa5F4PD4BlTkZrApmu1JS+y9/PRSsvgmLv1MNDbrN/J7piDPnSoIu2E9eRy?=
 =?us-ascii?Q?v2YwSckfxs1sNsqscZTOe7VX2OdmcZrIME2iBKpjjn2iN9RcvikUpXJUJ7V/?=
 =?us-ascii?Q?AuuL7P4d+nFQrQQyuAZNDqBYhpoVbwi5av1rI7ns99sQynEy2dJ0z9v7xDnM?=
 =?us-ascii?Q?QeuXC12vd2tWcxyvZsv+zMZpoYMm7kJzbx7kugh9tAbb/zt3LvdnxrVU8tTP?=
 =?us-ascii?Q?I6Z0F3fxBUgt6OEXp8Z+ww2xb0A6EBgphxehgzOydXS68ucAH9ES7jdnINk6?=
 =?us-ascii?Q?k5Olgin3fzp7p+WCmGEqoTJLYeMuKTyUSwyg4xRFFAbDKxmshmwk3LFZxd2m?=
 =?us-ascii?Q?AgXLWebAYP27H0dKtkTQypTKrDRD/meZQWgaJTOU95oTm6LNa8HEPUtLzWsQ?=
 =?us-ascii?Q?kaTGwGkFTUYRPHk/TM+t81W06Xn1IjqrPoTG2ATZUyuXSfqFV+07oewjw+R+?=
 =?us-ascii?Q?wlH/tG16ZOz6CTFMOA4jAIp+NP3GLrh7CQrrgPcXpi8x+qrJaS+rjYWFFHe5?=
 =?us-ascii?Q?k2bPm3moQO/3pF1X8/7L1aDm4Dnr+7OVnsr6WHIqQAM8Ljfrn3yt/cKQvLEd?=
 =?us-ascii?Q?DcM1zvPFKKXrcyL4cEqnM6EpLlIRZHtIQym+01XmDcplm7t6oV13Pljs9pvo?=
 =?us-ascii?Q?hXwP+HFo/TG8xewB0kTgXPIAITxAwyw7e+NufHIhPh2O9zE92jXJ2kb10unw?=
 =?us-ascii?Q?1Lf6AbUkD5QZbUxoWfo8AAniSjMkYCAIs5yyLDnuIibzlH4N4xmieFH/2R1e?=
 =?us-ascii?Q?2Lsj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1ca9d6-a03f-493c-c836-08d89cc4fd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 04:35:14.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5a34NYx7Q4w+AC0AQo/Vqe6b963U57Hq+FXgpFmtgquVDmCCtsIOdb+6TmSWEIB0O8a4wNYOyqM7ePS9rULTx2WPPTxBaxJDhlsIg86Sado=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enzo,=0A=
On 12/9/20 13:39, Enzo Matsumiya wrote:=0A=
> Fix a possible NULL pointer dereference when trying to read=0A=
> hwmon sysfs entries associated to NVMe-oF devices that were=0A=
> hot-removed or disconnected.=0A=
>=0A=
> Unregister the NVMe hwmon device upon controller teardown=0A=
> (nvme_stop_ctrl()).=0A=
>=0A=
> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>=0A=
(Without looking into the code)=0A=
=0A=
Do you have blktests testcases for NVMeOFhot-removed and disconnected=0A=
device scenario to produce the problem ?=0A=
