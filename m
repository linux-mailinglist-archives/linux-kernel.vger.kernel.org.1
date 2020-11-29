Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C6F2C779B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 06:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgK2FNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 00:13:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4637 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgK2FNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 00:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606626800; x=1638162800;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Q+9wc14wfuQMmnGUaM9/mziQvC1sLY7wMPn3qSE38LY=;
  b=Ya6lrH4KRDaucDc3wZQY9WJoSBNWfabZJloM4G6KWKqh9ygJHezjC6wf
   zzQ6OjaQf/jpmUwxkekFm0wa96NXEl8XnGaM23VxgYNSe5EClqr+mr7rW
   ZxI++QeiFRpqdHNPaoE3gxE7SeS2Nz1jAzkO545X3Pcgy6+16N3al9RUx
   ImkxUZ9JCRujQz/wvu4OFIb3C72nRRCW2FoWo07oQJPCF3CIXAcUke8SA
   ck49sJ12Qs8wa0eFUxgRu/mmPbKc5vUVJXPNlTNqIDS3Ak69JLUkJ1ht3
   A/+smZTDWwMxhpfj8jzQ/IfhsucW2HkbC2+dbr2Z7jNYqCGxI85h7v2Nb
   A==;
IronPort-SDR: QpFT9fdXxa/REvwLe7IFHzZW5O6yCn45WhqmlHD4wt0FI6DGEbNVGcru4mYNDe6cT5vzAemGC2
 GjPggiZFUz52+10ca2ss+kIJQzYXiONYvmLKCHPFp69RHSvyMqClvthOZmj5ZnCOyDqSj793jE
 qZ/qYNCcQmeAveeVfaUdMIGQYz+DsqC2WxzrYw9W83hsZpiUfUcpJJHn/8YBGpHj97xgRuQXIU
 pxCU0VJgWe51pTtW8aifllCiUnmvZLYm3T0WEbCjUFVQT/j1hFvwdjankBDal++fsPKFrPxu0q
 XNo=
X-IronPort-AV: E=Sophos;i="5.78,378,1599494400"; 
   d="scan'208";a="263842854"
Received: from mail-dm6nam08lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2020 13:12:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZqpk8uWm1RlvVcHfmvpn7IAW/hpqAz+OzZiETMZxt3cdpYRBSIUh6PSEO2KmJF8Id4ZjdpWtFYvDan2q8e3gvD3g+C0hyONtH48OLrWHS4xwzIfwOtv9PsmrHjHXLc2f+/ESAulSFz8B/TzrAoTjCZ6fbA2UHuZnogpFrIp9IAi9zJ9gQAAaA4YwMwCQIlTP3pfs3yuGlUHFg3xLFMWxkdXwyC8BsixZjItteFatBHR0w/f1d7Ya5CLUza1Oask6EZzK3sW+YyEM4CxiFYbn6L4k4AtC3hezZ/Lvk8M/Wl9xC+hE8e5MbyUlNBVN4vJE8esvyU9i70tLCLFTDSs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+9wc14wfuQMmnGUaM9/mziQvC1sLY7wMPn3qSE38LY=;
 b=hDMNPF3z1yXU0LDUaXSmqRw3/AAxbsM1h4fRI+qHci9E6oDQ+41QY6cft+ssHgUGWns78zPCJh0jGVkaZyVagnc8d1Rwq3O2PpFQfedGCylGaAu3IZ/mbg+XzqVg8Nt6edTykPogYRds4mxLFsWVHbRSlTV7d6aD7fPl0889gc8yIRZmryBdDRytsGb964AyyCrHPBd870hh4mCpwPdxuEtOS8hM1OqqACRbX25Drr2pPGtWpvyx1X3+fSSsnTXVlh7HnHg/38l8BwjPbok7h1JNTIYyHLbGtj/HFuUEeiEN4JHppy3jA8LwHo7i3L5KhyrpR6GcQkA/t+532mSZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+9wc14wfuQMmnGUaM9/mziQvC1sLY7wMPn3qSE38LY=;
 b=VOe0JD2jBGsMED3wg6HXBWpBH+zQN8kKTQ3VvZsR4BpO1XU7jbt0T4oitVZzejaMq2CmhsFBg0ZZSp3qpEcJUP9lq59lN9VZIQS5VPz2TU640b01xRVxSlP8fsCEr7WplIQE4xBwjkG2PjS37iemR2jC3t2UDZqtg49by5dGh2w=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4104.namprd04.prod.outlook.com (2603:10b6:a02:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 05:12:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3589.032; Sun, 29 Nov 2020
 05:12:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: Kconfig: Fix spelling mistake "incuding" ->
 "including"
Thread-Topic: [PATCH] nvmet: Kconfig: Fix spelling mistake "incuding" ->
 "including"
Thread-Index: AQHWxEUozpSyZKKBoUa2H0DZ/NMn0A==
Date:   Sun, 29 Nov 2020 05:12:10 +0000
Message-ID: <BYAPR04MB496572FCDC8EEC3B232497F186F60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201126224029.13527-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 710fbae2-b44e-42ce-e852-08d894255370
x-ms-traffictypediagnostic: BYAPR04MB4104:
x-microsoft-antispam-prvs: <BYAPR04MB410423EE69A955BB4713F04786F60@BYAPR04MB4104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Pa2cG9xz21wpi4ZWIM+vL3XAqzNb875ue0GGKcF0fMBkvmlBH2OJjFiGJolGY/iHMVsbTaEmrJ1Bp0Cgva552uTSh1dbjtYuXsg9hV9h+1hlXUzU0HWlEM8KfvPrZwQxdX/Vl3KdBlpNqQ0voQ54eA7g9pylPQ8k8jO7tMIllkuVgUbA01gfkRN5//QqS5OY8mlbI5fyZ9Ebwrr9g/6jZfmBtbROn3GE/8VUelsMduAU/7QlAQtKUSaDjQJZbuL1LOnjhLs/7xYse/s86bwZS+e63iomrG+fg7V9CWn45Ls+fQi3nrulycwmYryxp1T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(39850400004)(376002)(71200400001)(8676002)(86362001)(8936002)(9686003)(558084003)(54906003)(5660300002)(110136005)(316002)(4326008)(33656002)(55016002)(478600001)(7696005)(186003)(53546011)(66446008)(64756008)(2906002)(6506007)(66476007)(66556008)(26005)(76116006)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ipJ/FzY3miFTVtC/EjPmU38RiWt622noEhx0eboQ2MtDfthSCb5j6WESQt/w?=
 =?us-ascii?Q?NHohaC7CBOa58/ljdYcqRtfcrTHpxkbnqu3mYTcCPjpYZ2jmCIZLizx32JGl?=
 =?us-ascii?Q?NtIUlW7EAh1tEwC0l2dqRWK0Tk0aJbuFlA2iatYZLavWUZkCMuQVE0t1R4Ib?=
 =?us-ascii?Q?VTE7vs8sK/jfuMhK2j3DvO0o6yJxRFD4zBrCKa+owIO+wZQAMGldxB2Vv8C5?=
 =?us-ascii?Q?LGhMbV6231LtL+0y2SSQFTzgHt1b1hhBqOaJ6eaVH1nKXHKpZ8J2QQqc6uRf?=
 =?us-ascii?Q?FqYOYXZbcKA2QCnSidiBCEKTa2jmPBchODYQylDCABXELv2hhpqMLU/qY72A?=
 =?us-ascii?Q?a0poJxGdtgWOJUszkvb6QXfc8sFYuPRvP6hMtJ6LGpn8lQ6wCBgEwHxKC3lG?=
 =?us-ascii?Q?EDBp0KKd/C713jRKQ93SC9XVSeX5H9/t7YrgIrSO8C05KW1xzUytJ2taxyKV?=
 =?us-ascii?Q?eiXck2xO2uWdJdjSr48hdJZsuPmXKFaauY+bNFt7jwXJAu6CyMcTlJpHPiwv?=
 =?us-ascii?Q?4S6oM8dChIAyK101gt9Lbw1HIOechPehEPVddSYFu8T7LBWnqgUUo+LHa+GG?=
 =?us-ascii?Q?DhZqgIwBB1uhHUWS2F1jbkfFvWQGKhh9eycpd2RKW20zZMxxWwanmJKHFsfD?=
 =?us-ascii?Q?NhRcTVnN3yGz/ta5e7xVItNX6ou0q+UUfohys/2wHMBLaxZn0eHbEa0dpIAQ?=
 =?us-ascii?Q?j96YY4oCiRFAlh6RcRJGX10VJZYEp60BrOv9CwvzeIOSMk3mXYMMS9b9+SfL?=
 =?us-ascii?Q?SKKNHM24TjtIZdmWGu1nXHNl4vg1OCcsWdYNpQ9N3UY1Tr/uDujpn+1MMw9g?=
 =?us-ascii?Q?VinX9LEY39CLiSlp12L/iJEKD6WNZeFWcZVHpr+wPUePPDz60XdrsIyTiMVf?=
 =?us-ascii?Q?qdDtWnQ9+PUTpK/2jsteuN4VvXrlhiTljd8S694wVf9CMjoYWq6Zgxrx63Qx?=
 =?us-ascii?Q?hW0mIVvsNt7KHdAYkL6JwjyOj9MIF2rJnsc1cJ09hVfj1oSZDhQlL9zmt+E8?=
 =?us-ascii?Q?O23I?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710fbae2-b44e-42ce-e852-08d894255370
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2020 05:12:10.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vom28RUGtZUAbLnkEVbIz1QhBwyAWUlU0x8CPoHDrL2OXGjCO20q7KPLC/hHFzWmTUuSlvOTCOMdfcPkzrkYn840Dh0d4O6hwPBaWqmLRAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/20 14:40, Colin King wrote:=0A=
> From: Colin Ian King <colin.king@canonical.com>=0A=
>=0A=
> There is a spelling mistake in the Kconfig help text. Fix it.=0A=
>=0A=
> Signed-off-by: Colin Ian King <colin.king@canonical.com>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
