Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C679D29D50C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgJ1V4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:56:32 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:44753
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbgJ1V40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:56:26 -0400
Received: from AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 19:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU4f+qzCgMt3OxIpqUK9kk1ZQdHxaCg7MhD09iuC1EF0XwPEZVH52oZaKn5zqOj8xeZlsiM7mjfd98Zu/n7mn4bjBL4q2DbyPAjXja229g5RzN+m9WAcCV16Ot+M4I65+VCTL9KU6ED2kZGUQPKhMe6bfts66n6VuBXae0H3WiCnPQdj01Rcr/RySEIUt2utrPGAjFv8RWPiO/RyEG0YezBxgkDj7S4o35aJKGzXjzmM/9ZZKSWizXiEwVvuilWq+WMhBylAID6d05sLzE1DZH2ZmMVFpx/8Oy2C7Ly1OBm0v62b90SdN4eth2iG0EzALe+GAYgB+wRj1g+gKAPmrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBVXM7+hXx6DdoUKvoAOCBzcsv3/WG0d2p88YedJd0E=;
 b=QKG0B5n4NrdLwWQo+Vqr74Jg2cbrGlICFx1VR4L2UliVYpxBN1byfB5cwmL2ev0WU+hjUwXYtS47xqeYfT6ej5CrZP6eakse+XhCxJp0PsYfcAUpZ3mQ/x9+YHkiIoxBY/SvhjYs0KdyRZGs4zfcBzXyvfhsWpbzAy4+twRiyoJp+5u3B9fudKZxs1uAKnsgb6Vm5oc6XGgeg0Iwz4ZpPeZxRX8Ty+iTx+vG4KkmFCBvFrWBLPW18DcrJJtZEkg7Af/NZTRIo3p7EDbWu5T1XOAONWQthRB5p4g4l2SWfrJn6uOylx9d+shVakPFJDLNGsFvCXXQYh0iYapAw8Rx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBVXM7+hXx6DdoUKvoAOCBzcsv3/WG0d2p88YedJd0E=;
 b=H7Msg4JAnYhU3uNOmreUCzTK27kMqJ1WQZR5mtMEJuPkb2jYHDE0huf1W7zFtSjYubaCE6bqMK+TsykWZYTstPAvOAdiPSYp3Hguh+A68qQfk6xZtbb0tju8h/xwcJzRiF6YifowYWEqPgJvI2KtcG3JoI1/LnOki2Wpr40xSJM=
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com (2603:10a6:208:c8::16)
 by AM8PR04MB7441.eurprd04.prod.outlook.com (2603:10a6:20b:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 07:15:04 +0000
Received: from AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::2a:11b5:6807:7518]) by AM0PR04MB4947.eurprd04.prod.outlook.com
 ([fe80::2a:11b5:6807:7518%5]) with mapi id 15.20.3477.028; Wed, 28 Oct 2020
 07:15:04 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Vinod Koul <vkoul@kernel.org>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Nikhil Rao <nikhil.rao@intel.com>
Subject: RE: [PATCH char-misc-next 1/1] misc: mic: remove the MIC drivers
Thread-Topic: [PATCH char-misc-next 1/1] misc: mic: remove the MIC drivers
Thread-Index: AQHWrNlbEPAQLrrJzEKOzh29sm0v+6msmd6w
Date:   Wed, 28 Oct 2020 07:15:03 +0000
Message-ID: <AM0PR04MB49475C9C9184480DEDF28D8E92170@AM0PR04MB4947.eurprd04.prod.outlook.com>
References: <8c1443136563de34699d2c084df478181c205db4.1603854416.git.sudeep.dutt@intel.com>
In-Reply-To: <8c1443136563de34699d2c084df478181c205db4.1603854416.git.sudeep.dutt@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db23041c-cfc4-4e87-931f-08d87b113109
x-ms-traffictypediagnostic: AM8PR04MB7441:|AM8PR04MB8002:
x-microsoft-antispam-prvs: <AM8PR04MB7441FAB3E9CD79FE7414DDAC92170@AM8PR04MB7441.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WVWCpRV2RI92xobdtNhG4CrFyNLq7ung51Rsn/svVqTT9OLa/7IHMUnc8LpxIATbjozfiWiWO7Z97gG5EWaEh84gqnO7P2MP1sb7YaTn+MnvKbjI4rp/OykS8PaA2JP4fY9nnVpEKgZwinNOPYvJ1rtl35nIqvoB57og9AJP3qkskjGODe/cZfPSZQCX8wIYyNbX9nYLbRerPf515lUjpeC2ktPerOn5HIcyEdL0ceFCs7Dq0aFkFUGEV+dtMKjDXY+BYogp1nArWCT1u3kNzTvnlz4xw2s19BWvolTPDH3mb0oQy+JAjO5F4sw6zyRvZ8M95esZyET1rFJAjxn8jGwteiYHU7HJb83KF1mL8pPssy7OS1jnVAVBlUGX8tj654w6lfVDpYaG8tZkI/neVNWGdVZmh6vV/+V5M0ozAQ008rjHpO2tMfOqncgb2q8pr0hMeCpd7QKCbG8zYECGxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(966005)(8936002)(8676002)(45080400002)(6506007)(7696005)(478600001)(83380400001)(7416002)(4326008)(26005)(9686003)(18074004)(316002)(2906002)(71200400001)(55016002)(110136005)(5660300002)(66574015)(186003)(52536014)(54906003)(30864003)(66446008)(64756008)(44832011)(66476007)(66556008)(76116006)(86362001)(33656002)(66946007)(2004002)(569008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VG/KY6+8cpK8I4LgNmA5oVqNG2zA5T2tEOwdk5D8A/zSVFkwEe0ZIYHhCsutgV9+T3H+VBACWq1/hgof1ylzc2npcn+AmuPKsDru9r4XCeQ6pS2aTGR/RcHt8/FL2klI0aUhfT1ptx3mPcv1NF7JdAk7ZBiVbycjQT4Pc7aiWFzez6sBgqGm18Q3b9zf31J2VKUBIm+0c/7TbBMjGUsbDRlqahtY3qooG95hg/q1xDqIn80MEZrgkBiFvkgUxpa3Nnqqd6yr2GtrJKWKhUkm0SzcRNgR1oCwKk9+0oBwtcQ/9r6zN5kx/7LvnsepjuoaXNfHTqEslvHMuHrngfdqvLHI9NZ9quQZGG/SZqs78cd5t1zdrAH7eT35Olea12jLymJCjQhm/TmR6hcg+Z0fxd7vgulDvq3yyjhvsENlwVh1HynIV0aXdG+0UHEjMoTeIPd+KuXTwAX4XZH/7Lz6Z06fH68oK+a0u1x+3SrUw5vS5oc6lVrRwisfohYZhhhA05S3CrMQPyA63LQzHmCSgTj4AenNvEpUOrVX9dWDrvu/xWgdPOR9PGPv51RePUBKy9a11ePjxPT1x6IT0qmmIN4iSqmRWQJCHcvHsgmx+1YNBZzMawG+9BG9zIqtjva2ZgHhyT+N3tYmxHgz10ck6w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4947.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db23041c-cfc4-4e87-931f-08d87b113109
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 07:15:03.4160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AdkuXusH7cR3z3Ekl36WiqnS3METW2BPSprqS9cikUcrqo963vMZAwu97V4ob3V0SeHTJKf+KGfSa7I4pB5VMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7441
X-OriginatorOrg: nxp.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Subject: [PATCH char-misc-next 1/1] misc: mic: remove the MIC drivers
>=20
> This patch removes the MIC drivers from the kernel tree
> since the corresponding devices have been discontinued.
>=20
> Removing the dma and char-misc changes in one patch and
> merging via the char-misc tree is best to avoid any
> potential build breakage.
>=20
> Cc: Nikhil Rao <nikhil.rao@intel.com>
> Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Signed-off-by: Sudeep Dutt <sudeep.dutt@intel.com>

Reviewed-by: Sherry Sun <sherry.sun@nxp.com>=20

> ---
>  Documentation/misc-devices/mic/index.rst      |   16 -
>  .../misc-devices/mic/mic_overview.rst         |   85 -
>  .../misc-devices/mic/scif_overview.rst        |  108 -
>  MAINTAINERS                                   |   16 -
>  drivers/dma/Kconfig                           |   18 -
>  drivers/dma/Makefile                          |    1 -
>  drivers/dma/mic_x100_dma.c                    |  770 -------
>  drivers/dma/mic_x100_dma.h                    |  275 ---
>  drivers/misc/Kconfig                          |    1 -
>  drivers/misc/Makefile                         |    1 -
>  drivers/misc/mic/Kconfig                      |  141 --
>  drivers/misc/mic/Makefile                     |   12 -
>  drivers/misc/mic/bus/Makefile                 |    9 -
>  drivers/misc/mic/bus/cosm_bus.c               |  130 --
>  drivers/misc/mic/bus/cosm_bus.h               |  125 --
>  drivers/misc/mic/bus/mic_bus.c                |  194 --
>  drivers/misc/mic/bus/scif_bus.c               |  201 --
>  drivers/misc/mic/bus/scif_bus.h               |  125 --
>  drivers/misc/mic/bus/vop_bus.c                |  194 --
>  drivers/misc/mic/bus/vop_bus.h                |  129 --
>  drivers/misc/mic/card/Makefile                |   11 -
>  drivers/misc/mic/card/mic_debugfs.c           |   85 -
>  drivers/misc/mic/card/mic_device.c            |  417 ----
>  drivers/misc/mic/card/mic_device.h            |  137 --
>  drivers/misc/mic/card/mic_x100.c              |  347 ---
>  drivers/misc/mic/card/mic_x100.h              |   37 -
>  drivers/misc/mic/common/mic_dev.h             |   55 -
>  drivers/misc/mic/cosm/Makefile                |   11 -
>  drivers/misc/mic/cosm/cosm_debugfs.c          |  116 -
>  drivers/misc/mic/cosm/cosm_main.c             |  382 ----
>  drivers/misc/mic/cosm/cosm_main.h             |   61 -
>  drivers/misc/mic/cosm/cosm_scif_server.c      |  399 ----
>  drivers/misc/mic/cosm/cosm_sysfs.c            |  449 ----
>  drivers/misc/mic/cosm_client/Makefile         |    8 -
>  .../misc/mic/cosm_client/cosm_scif_client.c   |  269 ---
>  drivers/misc/mic/host/Makefile                |   12 -
>  drivers/misc/mic/host/mic_boot.c              |  588 -----
>  drivers/misc/mic/host/mic_debugfs.c           |  149 --
>  drivers/misc/mic/host/mic_device.h            |  157 --
>  drivers/misc/mic/host/mic_intr.c              |  635 ------
>  drivers/misc/mic/host/mic_intr.h              |  137 --
>  drivers/misc/mic/host/mic_main.c              |  335 ---
>  drivers/misc/mic/host/mic_smpt.c              |  427 ----
>  drivers/misc/mic/host/mic_smpt.h              |   87 -
>  drivers/misc/mic/host/mic_x100.c              |  585 -----
>  drivers/misc/mic/host/mic_x100.h              |   77 -
>  drivers/misc/mic/scif/Makefile                |   21 -
>  drivers/misc/mic/scif/scif_api.c              | 1485 -------------
>  drivers/misc/mic/scif/scif_debugfs.c          |  116 -
>  drivers/misc/mic/scif/scif_dma.c              | 1940 -----------------
>  drivers/misc/mic/scif/scif_epd.c              |  357 ---
>  drivers/misc/mic/scif/scif_epd.h              |  200 --
>  drivers/misc/mic/scif/scif_fd.c               |  462 ----
>  drivers/misc/mic/scif/scif_fence.c            |  783 -------
>  drivers/misc/mic/scif/scif_main.c             |  351 ---
>  drivers/misc/mic/scif/scif_main.h             |  274 ---
>  drivers/misc/mic/scif/scif_map.h              |  127 --
>  drivers/misc/mic/scif/scif_mmap.c             |  690 ------
>  drivers/misc/mic/scif/scif_nm.c               |  229 --
>  drivers/misc/mic/scif/scif_nodeqp.c           | 1349 ------------
>  drivers/misc/mic/scif/scif_nodeqp.h           |  221 --
>  drivers/misc/mic/scif/scif_peer_bus.c         |  175 --
>  drivers/misc/mic/scif/scif_peer_bus.h         |   23 -
>  drivers/misc/mic/scif/scif_ports.c            |  116 -
>  drivers/misc/mic/scif/scif_rb.c               |  240 --
>  drivers/misc/mic/scif/scif_rb.h               |  100 -
>  drivers/misc/mic/scif/scif_rma.c              | 1760 ---------------
>  drivers/misc/mic/scif/scif_rma.h              |  477 ----
>  drivers/misc/mic/scif/scif_rma_list.c         |  282 ---
>  drivers/misc/mic/scif/scif_rma_list.h         |   48 -
>  drivers/misc/mic/vop/Makefile                 |   10 -
>  drivers/misc/mic/vop/vop_debugfs.c            |  184 --
>  drivers/misc/mic/vop/vop_main.c               |  784 -------
>  drivers/misc/mic/vop/vop_main.h               |  158 --
>  drivers/misc/mic/vop/vop_vringh.c             | 1166 ----------
>  include/linux/mic_bus.h                       |  100 -
>  include/linux/scif.h                          | 1339 ------------
>  include/uapi/linux/mic_common.h               |  235 --
>  include/uapi/linux/mic_ioctl.h                |   77 -
>  samples/mic/mpssd/.gitignore                  |    2 -
>  samples/mic/mpssd/Makefile                    |   28 -
>  samples/mic/mpssd/micctrl                     |  162 --
>  samples/mic/mpssd/mpss                        |  189 --
>  samples/mic/mpssd/mpssd.c                     | 1815 ---------------
>  samples/mic/mpssd/mpssd.h                     |   89 -
>  samples/mic/mpssd/sysfs.c                     |   91 -
>  86 files changed, 26779 deletions(-)
>  delete mode 100644 Documentation/misc-devices/mic/index.rst
>  delete mode 100644 Documentation/misc-devices/mic/mic_overview.rst
>  delete mode 100644 Documentation/misc-devices/mic/scif_overview.rst
>  delete mode 100644 drivers/dma/mic_x100_dma.c
>  delete mode 100644 drivers/dma/mic_x100_dma.h
>  delete mode 100644 drivers/misc/mic/Kconfig
>  delete mode 100644 drivers/misc/mic/Makefile
>  delete mode 100644 drivers/misc/mic/bus/Makefile
>  delete mode 100644 drivers/misc/mic/bus/cosm_bus.c
>  delete mode 100644 drivers/misc/mic/bus/cosm_bus.h
>  delete mode 100644 drivers/misc/mic/bus/mic_bus.c
>  delete mode 100644 drivers/misc/mic/bus/scif_bus.c
>  delete mode 100644 drivers/misc/mic/bus/scif_bus.h
>  delete mode 100644 drivers/misc/mic/bus/vop_bus.c
>  delete mode 100644 drivers/misc/mic/bus/vop_bus.h
>  delete mode 100644 drivers/misc/mic/card/Makefile
>  delete mode 100644 drivers/misc/mic/card/mic_debugfs.c
>  delete mode 100644 drivers/misc/mic/card/mic_device.c
>  delete mode 100644 drivers/misc/mic/card/mic_device.h
>  delete mode 100644 drivers/misc/mic/card/mic_x100.c
>  delete mode 100644 drivers/misc/mic/card/mic_x100.h
>  delete mode 100644 drivers/misc/mic/common/mic_dev.h
>  delete mode 100644 drivers/misc/mic/cosm/Makefile
>  delete mode 100644 drivers/misc/mic/cosm/cosm_debugfs.c
>  delete mode 100644 drivers/misc/mic/cosm/cosm_main.c
>  delete mode 100644 drivers/misc/mic/cosm/cosm_main.h
>  delete mode 100644 drivers/misc/mic/cosm/cosm_scif_server.c
>  delete mode 100644 drivers/misc/mic/cosm/cosm_sysfs.c
>  delete mode 100644 drivers/misc/mic/cosm_client/Makefile
>  delete mode 100644 drivers/misc/mic/cosm_client/cosm_scif_client.c
>  delete mode 100644 drivers/misc/mic/host/Makefile
>  delete mode 100644 drivers/misc/mic/host/mic_boot.c
>  delete mode 100644 drivers/misc/mic/host/mic_debugfs.c
>  delete mode 100644 drivers/misc/mic/host/mic_device.h
>  delete mode 100644 drivers/misc/mic/host/mic_intr.c
>  delete mode 100644 drivers/misc/mic/host/mic_intr.h
>  delete mode 100644 drivers/misc/mic/host/mic_main.c
>  delete mode 100644 drivers/misc/mic/host/mic_smpt.c
>  delete mode 100644 drivers/misc/mic/host/mic_smpt.h
>  delete mode 100644 drivers/misc/mic/host/mic_x100.c
>  delete mode 100644 drivers/misc/mic/host/mic_x100.h
>  delete mode 100644 drivers/misc/mic/scif/Makefile
>  delete mode 100644 drivers/misc/mic/scif/scif_api.c
>  delete mode 100644 drivers/misc/mic/scif/scif_debugfs.c
>  delete mode 100644 drivers/misc/mic/scif/scif_dma.c
>  delete mode 100644 drivers/misc/mic/scif/scif_epd.c
>  delete mode 100644 drivers/misc/mic/scif/scif_epd.h
>  delete mode 100644 drivers/misc/mic/scif/scif_fd.c
>  delete mode 100644 drivers/misc/mic/scif/scif_fence.c
>  delete mode 100644 drivers/misc/mic/scif/scif_main.c
>  delete mode 100644 drivers/misc/mic/scif/scif_main.h
>  delete mode 100644 drivers/misc/mic/scif/scif_map.h
>  delete mode 100644 drivers/misc/mic/scif/scif_mmap.c
>  delete mode 100644 drivers/misc/mic/scif/scif_nm.c
>  delete mode 100644 drivers/misc/mic/scif/scif_nodeqp.c
>  delete mode 100644 drivers/misc/mic/scif/scif_nodeqp.h
>  delete mode 100644 drivers/misc/mic/scif/scif_peer_bus.c
>  delete mode 100644 drivers/misc/mic/scif/scif_peer_bus.h
>  delete mode 100644 drivers/misc/mic/scif/scif_ports.c
>  delete mode 100644 drivers/misc/mic/scif/scif_rb.c
>  delete mode 100644 drivers/misc/mic/scif/scif_rb.h
>  delete mode 100644 drivers/misc/mic/scif/scif_rma.c
>  delete mode 100644 drivers/misc/mic/scif/scif_rma.h
>  delete mode 100644 drivers/misc/mic/scif/scif_rma_list.c
>  delete mode 100644 drivers/misc/mic/scif/scif_rma_list.h
>  delete mode 100644 drivers/misc/mic/vop/Makefile
>  delete mode 100644 drivers/misc/mic/vop/vop_debugfs.c
>  delete mode 100644 drivers/misc/mic/vop/vop_main.c
>  delete mode 100644 drivers/misc/mic/vop/vop_main.h
>  delete mode 100644 drivers/misc/mic/vop/vop_vringh.c
>  delete mode 100644 include/linux/mic_bus.h
>  delete mode 100644 include/linux/scif.h
>  delete mode 100644 include/uapi/linux/mic_common.h
>  delete mode 100644 include/uapi/linux/mic_ioctl.h
>  delete mode 100644 samples/mic/mpssd/.gitignore
>  delete mode 100644 samples/mic/mpssd/Makefile
>  delete mode 100755 samples/mic/mpssd/micctrl
>  delete mode 100755 samples/mic/mpssd/mpss
>  delete mode 100644 samples/mic/mpssd/mpssd.c
>  delete mode 100644 samples/mic/mpssd/mpssd.h
>  delete mode 100644 samples/mic/mpssd/sysfs.c
>=20
> diff --git a/Documentation/misc-devices/mic/index.rst
> b/Documentation/misc-devices/mic/index.rst
> deleted file mode 100644
> index 3a8d06367ef1..000000000000
> --- a/Documentation/misc-devices/mic/index.rst
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Intel Many Integrated Core (MIC) architecture
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -.. toctree::
> -    :maxdepth: 1
> -
> -    mic_overview
> -    scif_overview
> -
> -.. only::  subproject and html
> -
> -   Indices
> -   =3D=3D=3D=3D=3D=3D=3D
> -
> -   * :ref:`genindex`
> diff --git a/Documentation/misc-devices/mic/mic_overview.rst
> b/Documentation/misc-devices/mic/mic_overview.rst
> deleted file mode 100644
> index 17d956bdaf7c..000000000000
> --- a/Documentation/misc-devices/mic/mic_overview.rst
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -Intel Many Integrated Core (MIC) architecture overview
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> -
> -An Intel MIC X100 device is a PCIe form factor add-in coprocessor
> -card based on the Intel Many Integrated Core (MIC) architecture
> -that runs a Linux OS. It is a PCIe endpoint in a platform and therefore
> -implements the three required standard address spaces i.e. configuration=
,
> -memory and I/O. The host OS loads a device driver as is typical for
> -PCIe devices. The card itself runs a bootstrap after reset that
> -transfers control to the card OS downloaded from the host driver. The
> -host driver supports OSPM suspend and resume operations. It shuts down
> -the card during suspend and reboots the card OS during resume.
> -The card OS as shipped by Intel is a Linux kernel with modifications
> -for the X100 devices.
> -
> -Since it is a PCIe card, it does not have the ability to host hardware
> -devices for networking, storage and console. We provide these devices
> -on X100 coprocessors thus enabling a self-bootable equivalent
> -environment for applications. A key benefit of our solution is that it
> -leverages the standard virtio framework for network, disk and console
> -devices, though in our case the virtio framework is used across a PCIe
> -bus. A Virtio Over PCIe (VOP) driver allows creating user space
> -backends or devices on the host which are used to probe virtio drivers
> -for these devices on the MIC card. The existing VRINGH infrastructure
> -in the kernel is used to access virtio rings from the host. The card
> -VOP driver allows card virtio drivers to communicate with their user
> -space backends on the host via a device page. Ring 3 apps on the host
> -can add, remove and configure virtio devices. A thin MIC specific
> -virtio_config_ops is implemented which is borrowed heavily from
> -previous similar implementations in lguest and s390.
> -
> -MIC PCIe card has a dma controller with 8 channels. These channels are
> -shared between the host s/w and the card s/w. 0 to 3 are used by host
> -and 4 to 7 by card. As the dma device doesn't show up as PCIe device,
> -a virtual bus called mic bus is created and virtual dma devices are
> -created on it by the host/card drivers. On host the channels are private
> -and used only by the host driver to transfer data for the virtio devices=
.
> -
> -The Symmetric Communication Interface (SCIF (pronounced as skiff)) is a
> -low level communications API across PCIe currently implemented for MIC.
> -More details are available at scif_overview.txt.
> -
> -The Coprocessor State Management (COSM) driver on the host allows for
> -boot, shutdown and reset of Intel MIC devices. It communicates with a
> COSM
> -"client" driver on the MIC cards over SCIF to perform these functions.
> -
> -Here is a block diagram of the various components described above. The
> -virtio backends are situated on the host rather than the card given bett=
er
> -single threaded performance for the host compared to MIC, the ability of
> -the host to initiate DMA's to/from the card using the MIC DMA engine and
> -the fact that the virtio block storage backend can only be on the host::
> -
> -               +----------+           |             +----------+
> -               | Card OS  |           |             | Host OS  |
> -               +----------+           |             +----------+
> -                                      |
> -        +-------+ +--------+ +------+ | +---------+  +--------+ +-------=
-+
> -        | Virtio| |Virtio  | |Virtio| | |Virtio   |  |Virtio  | |Virtio =
 |
> -        | Net   | |Console | |Block | | |Net      |  |Console | |Block  =
 |
> -        | Driver| |Driver  | |Driver| | |backend  |  |backend | |backend=
 |
> -        +---+---+ +---+----+ +--+---+ | +---------+  +----+---+ +-------=
-+
> -            |         |         |     |      |            |         |
> -            |         |         |     |User  |            |         |
> -            |         |         |     |------|------------|--+------|---=
----
> -            +---------+---------+     |Kernel                |
> -                      |               |                      |
> -  +---------+     +---+----+ +------+ | +------+ +------+ +--+---+  +---=
----+
> -  |MIC DMA  |     |  VOP   | | SCIF | | | SCIF | | COSM | | VOP  |  |MIC=
 DMA|
> -  +---+-----+     +---+----+ +--+---+ | +--+---+ +--+---+ +------+  +---=
-+--+
> -      |               |         |     |    |        |                   =
 |
> -  +---+-----+     +---+----+ +--+---+ | +--+---+ +--+---+ +------+  +---=
-+--+
> -  |MIC      |     |  VOP   | |SCIF  | | |SCIF  | | COSM | | VOP  |  | MI=
C   |
> -  |HW Bus   |     |  HW Bus| |HW Bus| | |HW Bus| | Bus  | |HW Bus|  |HW
> Bus |
> -  +---------+     +--------+ +--+---+ | +--+---+ +------+ +------+  +---=
----+
> -      |               |         |     |       |     |                   =
 |
> -      |   +-----------+--+      |     |       |    +---------------+    =
 |
> -      |   |Intel MIC     |      |     |       |    |Intel MIC      |    =
 |
> -      |   |Card Driver   |      |     |       |    |Host Driver    |    =
 |
> -      +---+--------------+------+     |       +----+---------------+----=
-+
> -                 |                    |                   |
> -             +----------------------------------------------------------=
---+
> -             |                                                          =
   |
> -             |                    PCIe Bus                              =
   |
> -             +----------------------------------------------------------=
---+
> diff --git a/Documentation/misc-devices/mic/scif_overview.rst
> b/Documentation/misc-devices/mic/scif_overview.rst
> deleted file mode 100644
> index 4c8ad9e43706..000000000000
> --- a/Documentation/misc-devices/mic/scif_overview.rst
> +++ /dev/null
> @@ -1,108 +0,0 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Symmetric Communication Interface (SCIF)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The Symmetric Communication Interface (SCIF (pronounced as skiff)) is a
> low
> -level communications API across PCIe currently implemented for MIC.
> Currently
> -SCIF provides inter-node communication within a single host platform,
> where a
> -node is a MIC Coprocessor or Xeon based host. SCIF abstracts the details=
 of
> -communicating over the PCIe bus while providing an API that is symmetric
> -across all the nodes in the PCIe network. An important design objective =
for
> SCIF
> -is to deliver the maximum possible performance given the communication
> -abilities of the hardware. SCIF has been used to implement an offload
> compiler
> -runtime and OFED support for MPI implementations for MIC coprocessors.
> -
> -SCIF API Components
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -The SCIF API has the following parts:
> -
> -1. Connection establishment using a client server model
> -2. Byte stream messaging intended for short messages
> -3. Node enumeration to determine online nodes
> -4. Poll semantics for detection of incoming connections and messages
> -5. Memory registration to pin down pages
> -6. Remote memory mapping for low latency CPU accesses via mmap
> -7. Remote DMA (RDMA) for high bandwidth DMA transfers
> -8. Fence APIs for RDMA synchronization
> -
> -SCIF exposes the notion of a connection which can be used by peer
> processes on
> -nodes in a SCIF PCIe "network" to share memory "windows" and to
> communicate. A
> -process in a SCIF node initiates a SCIF connection to a peer process on =
a
> -different node via a SCIF "endpoint". SCIF endpoints support messaging A=
PIs
> -which are similar to connection oriented socket APIs. Connected SCIF
> endpoints
> -can also register local memory which is followed by data transfer using
> either
> -DMA, CPU copies or remote memory mapping via mmap. SCIF supports
> both user and
> -kernel mode clients which are functionally equivalent.
> -
> -SCIF Performance for MIC
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -DMA bandwidth comparison between the TCP (over ethernet over PCIe)
> stack versus
> -SCIF shows the performance advantages of SCIF for HPC applications and
> -runtimes::
> -
> -             Comparison of TCP and SCIF based BW
> -
> -  Throughput (GB/sec)
> -    8 +                                             PCIe Bandwidth *****=
*
> -      +                                                        TCP #####=
#
> -    7 +    **************************************             SCIF %%%%%=
%
> -      |                       %%%%%%%%%%%%%%%%%%%
> -    6 +                   %%%%
> -      |                 %%
> -      |               %%%
> -    5 +              %%
> -      |            %%
> -    4 +           %%
> -      |          %%
> -    3 +         %%
> -      |        %
> -    2 +      %%
> -      |     %%
> -      |    %
> -    1 +
> -      +    ######################################
> -    0 +++---+++--+--+-+--+--+-++-+--+-++-+--+-++-+-
> -      1       10     100      1000   10000   100000
> -                   Transfer Size (KBytes)
> -
> -SCIF allows memory sharing via mmap(..) between processes on different
> PCIe
> -nodes and thus provides bare-metal PCIe latency. The round trip SCIF mma=
p
> -latency from the host to an x100 MIC for an 8 byte message is 0.44 usecs=
.
> -
> -SCIF has a user space library which is a thin IOCTL wrapper providing a =
user
> -space API similar to the kernel API in scif.h. The SCIF user space libra=
ry
> -is distributed @
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591938987%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3DJazqZ0AMWUqcOWdQVOC3NNlFj1C9kr7ZbZvVUyJDNKY%3D&amp;res
> erved=3D0
> -
> -Here is some pseudo code for an example of how two applications on two
> PCIe
> -nodes would typically use the SCIF API::
> -
> -  Process A (on node A)			Process B (on node B)
> -
> -  /* get online node information */
> -  scif_get_node_ids(..)			scif_get_node_ids(..)
> -  scif_open(..)				scif_open(..)
> -  scif_bind(..)				scif_bind(..)
> -  scif_listen(..)
> -  scif_accept(..)				scif_connect(..)
> -  /* SCIF connection established */
> -
> -  /* Send and receive short messages */
> -  scif_send(..)/scif_recv(..)		scif_send(..)/scif_recv(..)
> -
> -  /* Register memory */
> -  scif_register(..)			scif_register(..)
> -
> -  /* RDMA */
> -  scif_readfrom(..)/scif_writeto(..)	scif_readfrom(..)/scif_writeto(..)
> -
> -  /* Fence DMAs */
> -  scif_fence_signal(..)			scif_fence_signal(..)
> -
> -  mmap(..)				mmap(..)
> -
> -  /* Access remote registered memory */
> -
> -  /* Close the endpoints */
> -  scif_close(..)				scif_close(..)
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..9289a9b43a51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8976,22 +8976,6 @@ S:	Supported
>  W:
> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> 2F01.org%2Flinux-
> acpi&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc4f87f9
> 3e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637
> 394520591938987%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dv
> Eqv097LekcuBg9%2BGkD5wKYBSujDYSO2MCp129b6O2k%3D&amp;reserved=3D
> 0
>  F:	drivers/platform/x86/intel_menlow.c
>=20
> -INTEL MIC DRIVERS (mic)
> -M:	Sudeep Dutt <sudeep.dutt@intel.com>
> -M:	Ashutosh Dixit <ashutosh.dixit@intel.com>
> -S:	Supported
> -W:
> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> 2Fgithub.com%2Fsudeepdutt%2Fmic&amp;data=3D04%7C01%7Csherry.sun%4
> 0nxp.com%7Cf4d4a5577fcc4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C637394520591938987%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI
> 6Mn0%3D%7C1000&amp;sdata=3D6CC4zdrpmy6vpT%2F%2FHnGH21D%2Fs8lr
> VVYSJBDuqm449hA%3D&amp;reserved=3D0
> -W:
> 	https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2
> Fsoftware.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591938987%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3DEYeS%2B8VAjYKOzOZ5CuVm%2FB1lxNVgIY5K2kzmyOSCXsA%3D&amp;
> reserved=3D0
> -F:	Documentation/misc-devices/mic/
> -F:	drivers/dma/mic_x100_dma.c
> -F:	drivers/dma/mic_x100_dma.h
> -F:	drivers/misc/mic/
> -F:	include/linux/mic_bus.h
> -F:	include/linux/scif.h
> -F:	include/uapi/linux/mic_common.h
> -F:	include/uapi/linux/mic_ioctl.h
> -F:	include/uapi/linux/scif_ioctl.h
> -
>  INTEL P-Unit IPC DRIVER
>  M:	Zha Qipeng <qipeng.zha@intel.com>
>  L:	platform-driver-x86@vger.kernel.org
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 518a1437862a..90284ffda58a 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -318,24 +318,6 @@ config INTEL_IOP_ADMA
>  	help
>  	  Enable support for the Intel(R) IOP Series RAID engines.
>=20
> -config INTEL_MIC_X100_DMA
> -	tristate "Intel MIC X100 DMA Driver"
> -	depends on 64BIT && X86 && INTEL_MIC_BUS
> -	select DMA_ENGINE
> -	help
> -	  This enables DMA support for the Intel Many Integrated Core
> -	  (MIC) family of PCIe form factor coprocessor X100 devices that
> -	  run a 64 bit Linux OS. This driver will be used by both MIC
> -	  host and card drivers.
> -
> -	  If you are building host kernel with a MIC device or a card
> -	  kernel for a MIC device, then say M (recommended) or Y, else
> -	  say N. If unsure say N.
> -
> -	  More information about the Intel MIC family as well as the Linux
> -	  OS and tools for MIC to use with this driver are available from
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591943962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3Dp3GqcxhfjjI76nVd2ejarp1i49GXx5%2Be6pvcFgHdiDI%3D&amp;reserve
> d=3D0>.
> -
>  config K3_DMA
>  	tristate "Hisilicon K3 DMA support"
>  	depends on ARCH_HI3xxx || ARCH_HISI || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index e60f81331d4c..948a8da05f8b 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -44,7 +44,6 @@ obj-$(CONFIG_INTEL_IDMA64) +=3D idma64.o
>  obj-$(CONFIG_INTEL_IOATDMA) +=3D ioat/
>  obj-$(CONFIG_INTEL_IDXD) +=3D idxd/
>  obj-$(CONFIG_INTEL_IOP_ADMA) +=3D iop-adma.o
> -obj-$(CONFIG_INTEL_MIC_X100_DMA) +=3D mic_x100_dma.o
>  obj-$(CONFIG_K3_DMA) +=3D k3dma.o
>  obj-$(CONFIG_LPC18XX_DMAMUX) +=3D lpc18xx-dmamux.o
>  obj-$(CONFIG_MILBEAUT_HDMAC) +=3D milbeaut-hdmac.o
> diff --git a/drivers/dma/mic_x100_dma.c b/drivers/dma/mic_x100_dma.c
> deleted file mode 100644
> index fea8608a7810..000000000000
> --- a/drivers/dma/mic_x100_dma.c
> +++ /dev/null
> @@ -1,770 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel MIC X100 DMA Driver.
> - *
> - * Adapted from IOAT dma driver.
> - */
> -#include <linux/module.h>
> -#include <linux/io.h>
> -#include <linux/seq_file.h>
> -#include <linux/vmalloc.h>
> -
> -#include "mic_x100_dma.h"
> -
> -#define MIC_DMA_MAX_XFER_SIZE_CARD  (1 * 1024 * 1024 -\
> -				       MIC_DMA_ALIGN_BYTES)
> -#define MIC_DMA_MAX_XFER_SIZE_HOST  (1 * 1024 * 1024 >> 1)
> -#define MIC_DMA_DESC_TYPE_SHIFT	60
> -#define MIC_DMA_MEMCPY_LEN_SHIFT 46
> -#define MIC_DMA_STAT_INTR_SHIFT 59
> -
> -/* high-water mark for pushing dma descriptors */
> -static int mic_dma_pending_level =3D 4;
> -
> -/* Status descriptor is used to write a 64 bit value to a memory locatio=
n */
> -enum mic_dma_desc_format_type {
> -	MIC_DMA_MEMCPY =3D 1,
> -	MIC_DMA_STATUS,
> -};
> -
> -static inline u32 mic_dma_hw_ring_inc(u32 val)
> -{
> -	return (val + 1) % MIC_DMA_DESC_RX_SIZE;
> -}
> -
> -static inline u32 mic_dma_hw_ring_dec(u32 val)
> -{
> -	return val ? val - 1 : MIC_DMA_DESC_RX_SIZE - 1;
> -}
> -
> -static inline void mic_dma_hw_ring_inc_head(struct mic_dma_chan *ch)
> -{
> -	ch->head =3D mic_dma_hw_ring_inc(ch->head);
> -}
> -
> -/* Prepare a memcpy desc */
> -static inline void mic_dma_memcpy_desc(struct mic_dma_desc *desc,
> -	dma_addr_t src_phys, dma_addr_t dst_phys, u64 size)
> -{
> -	u64 qw0, qw1;
> -
> -	qw0 =3D src_phys;
> -	qw0 |=3D (size >> MIC_DMA_ALIGN_SHIFT) <<
> MIC_DMA_MEMCPY_LEN_SHIFT;
> -	qw1 =3D MIC_DMA_MEMCPY;
> -	qw1 <<=3D MIC_DMA_DESC_TYPE_SHIFT;
> -	qw1 |=3D dst_phys;
> -	desc->qw0 =3D qw0;
> -	desc->qw1 =3D qw1;
> -}
> -
> -/* Prepare a status desc. with @data to be written at @dst_phys */
> -static inline void mic_dma_prep_status_desc(struct mic_dma_desc *desc,
> u64 data,
> -	dma_addr_t dst_phys, bool generate_intr)
> -{
> -	u64 qw0, qw1;
> -
> -	qw0 =3D data;
> -	qw1 =3D (u64) MIC_DMA_STATUS << MIC_DMA_DESC_TYPE_SHIFT |
> dst_phys;
> -	if (generate_intr)
> -		qw1 |=3D (1ULL << MIC_DMA_STAT_INTR_SHIFT);
> -	desc->qw0 =3D qw0;
> -	desc->qw1 =3D qw1;
> -}
> -
> -static void mic_dma_cleanup(struct mic_dma_chan *ch)
> -{
> -	struct dma_async_tx_descriptor *tx;
> -	u32 tail;
> -	u32 last_tail;
> -
> -	spin_lock(&ch->cleanup_lock);
> -	tail =3D mic_dma_read_cmp_cnt(ch);
> -	/*
> -	 * This is the barrier pair for smp_wmb() in fn.
> -	 * mic_dma_tx_submit_unlock. It's required so that we read the
> -	 * updated cookie value from tx->cookie.
> -	 */
> -	smp_rmb();
> -	for (last_tail =3D ch->last_tail; tail !=3D last_tail;) {
> -		tx =3D &ch->tx_array[last_tail];
> -		if (tx->cookie) {
> -			dma_cookie_complete(tx);
> -			dmaengine_desc_get_callback_invoke(tx, NULL);
> -			tx->callback =3D NULL;
> -		}
> -		last_tail =3D mic_dma_hw_ring_inc(last_tail);
> -	}
> -	/* finish all completion callbacks before incrementing tail */
> -	smp_mb();
> -	ch->last_tail =3D last_tail;
> -	spin_unlock(&ch->cleanup_lock);
> -}
> -
> -static u32 mic_dma_ring_count(u32 head, u32 tail)
> -{
> -	u32 count;
> -
> -	if (head >=3D tail)
> -		count =3D (tail - 0) + (MIC_DMA_DESC_RX_SIZE - head);
> -	else
> -		count =3D tail - head;
> -	return count - 1;
> -}
> -
> -/* Returns the num. of free descriptors on success, -ENOMEM on failure *=
/
> -static int mic_dma_avail_desc_ring_space(struct mic_dma_chan *ch, int
> required)
> -{
> -	struct device *dev =3D mic_dma_ch_to_device(ch);
> -	u32 count;
> -
> -	count =3D mic_dma_ring_count(ch->head, ch->last_tail);
> -	if (count < required) {
> -		mic_dma_cleanup(ch);
> -		count =3D mic_dma_ring_count(ch->head, ch->last_tail);
> -	}
> -
> -	if (count < required) {
> -		dev_dbg(dev, "Not enough desc space");
> -		dev_dbg(dev, "%s %d required=3D%u, avail=3D%u\n",
> -			__func__, __LINE__, required, count);
> -		return -ENOMEM;
> -	} else {
> -		return count;
> -	}
> -}
> -
> -/* Program memcpy descriptors into the descriptor ring and update s/w
> head ptr*/
> -static int mic_dma_prog_memcpy_desc(struct mic_dma_chan *ch,
> dma_addr_t src,
> -				    dma_addr_t dst, size_t len)
> -{
> -	size_t current_transfer_len;
> -	size_t max_xfer_size =3D to_mic_dma_dev(ch)->max_xfer_size;
> -	/* 3 is added to make sure we have enough space for status desc */
> -	int num_desc =3D len / max_xfer_size + 3;
> -	int ret;
> -
> -	if (len % max_xfer_size)
> -		num_desc++;
> -
> -	ret =3D mic_dma_avail_desc_ring_space(ch, num_desc);
> -	if (ret < 0)
> -		return ret;
> -	do {
> -		current_transfer_len =3D min(len, max_xfer_size);
> -		mic_dma_memcpy_desc(&ch->desc_ring[ch->head],
> -				    src, dst, current_transfer_len);
> -		mic_dma_hw_ring_inc_head(ch);
> -		len -=3D current_transfer_len;
> -		dst =3D dst + current_transfer_len;
> -		src =3D src + current_transfer_len;
> -	} while (len > 0);
> -	return 0;
> -}
> -
> -/* It's a h/w quirk and h/w needs 2 status descriptors for every status =
desc
> */
> -static void mic_dma_prog_intr(struct mic_dma_chan *ch)
> -{
> -	mic_dma_prep_status_desc(&ch->desc_ring[ch->head], 0,
> -				 ch->status_dest_micpa, false);
> -	mic_dma_hw_ring_inc_head(ch);
> -	mic_dma_prep_status_desc(&ch->desc_ring[ch->head], 0,
> -				 ch->status_dest_micpa, true);
> -	mic_dma_hw_ring_inc_head(ch);
> -}
> -
> -/* Wrapper function to program memcpy descriptors/status descriptors */
> -static int mic_dma_do_dma(struct mic_dma_chan *ch, int flags,
> dma_addr_t src,
> -			  dma_addr_t dst, size_t len)
> -{
> -	if (len && -ENOMEM =3D=3D mic_dma_prog_memcpy_desc(ch, src, dst,
> len)) {
> -		return -ENOMEM;
> -	} else {
> -		/* 3 is the maximum number of status descriptors */
> -		int ret =3D mic_dma_avail_desc_ring_space(ch, 3);
> -
> -		if (ret < 0)
> -			return ret;
> -	}
> -
> -	/* Above mic_dma_prog_memcpy_desc() makes sure we have
> enough space */
> -	if (flags & DMA_PREP_FENCE) {
> -		mic_dma_prep_status_desc(&ch->desc_ring[ch->head], 0,
> -					 ch->status_dest_micpa, false);
> -		mic_dma_hw_ring_inc_head(ch);
> -	}
> -
> -	if (flags & DMA_PREP_INTERRUPT)
> -		mic_dma_prog_intr(ch);
> -
> -	return 0;
> -}
> -
> -static inline void mic_dma_issue_pending(struct dma_chan *ch)
> -{
> -	struct mic_dma_chan *mic_ch =3D to_mic_dma_chan(ch);
> -
> -	spin_lock(&mic_ch->issue_lock);
> -	/*
> -	 * Write to head triggers h/w to act on the descriptors.
> -	 * On MIC, writing the same head value twice causes
> -	 * a h/w error. On second write, h/w assumes we filled
> -	 * the entire ring & overwrote some of the descriptors.
> -	 */
> -	if (mic_ch->issued =3D=3D mic_ch->submitted)
> -		goto out;
> -	mic_ch->issued =3D mic_ch->submitted;
> -	/*
> -	 * make descriptor updates visible before advancing head,
> -	 * this is purposefully not smp_wmb() since we are also
> -	 * publishing the descriptor updates to a dma device
> -	 */
> -	wmb();
> -	mic_dma_write_reg(mic_ch, MIC_DMA_REG_DHPR, mic_ch->issued);
> -out:
> -	spin_unlock(&mic_ch->issue_lock);
> -}
> -
> -static inline void mic_dma_update_pending(struct mic_dma_chan *ch)
> -{
> -	if (mic_dma_ring_count(ch->issued, ch->submitted)
> -			> mic_dma_pending_level)
> -		mic_dma_issue_pending(&ch->api_ch);
> -}
> -
> -static dma_cookie_t mic_dma_tx_submit_unlock(struct
> dma_async_tx_descriptor *tx)
> -{
> -	struct mic_dma_chan *mic_ch =3D to_mic_dma_chan(tx->chan);
> -	dma_cookie_t cookie;
> -
> -	dma_cookie_assign(tx);
> -	cookie =3D tx->cookie;
> -	/*
> -	 * We need an smp write barrier here because another CPU might
> see
> -	 * an update to submitted and update h/w head even before we
> -	 * assigned a cookie to this tx.
> -	 */
> -	smp_wmb();
> -	mic_ch->submitted =3D mic_ch->head;
> -	spin_unlock(&mic_ch->prep_lock);
> -	mic_dma_update_pending(mic_ch);
> -	return cookie;
> -}
> -
> -static inline struct dma_async_tx_descriptor *
> -allocate_tx(struct mic_dma_chan *ch)
> -{
> -	u32 idx =3D mic_dma_hw_ring_dec(ch->head);
> -	struct dma_async_tx_descriptor *tx =3D &ch->tx_array[idx];
> -
> -	dma_async_tx_descriptor_init(tx, &ch->api_ch);
> -	tx->tx_submit =3D mic_dma_tx_submit_unlock;
> -	return tx;
> -}
> -
> -/* Program a status descriptor with dst as address and value to be writt=
en
> */
> -static struct dma_async_tx_descriptor *
> -mic_dma_prep_status_lock(struct dma_chan *ch, dma_addr_t dst, u64
> src_val,
> -			 unsigned long flags)
> -{
> -	struct mic_dma_chan *mic_ch =3D to_mic_dma_chan(ch);
> -	int result;
> -
> -	spin_lock(&mic_ch->prep_lock);
> -	result =3D mic_dma_avail_desc_ring_space(mic_ch, 4);
> -	if (result < 0)
> -		goto error;
> -	mic_dma_prep_status_desc(&mic_ch->desc_ring[mic_ch->head],
> src_val, dst,
> -				 false);
> -	mic_dma_hw_ring_inc_head(mic_ch);
> -	result =3D mic_dma_do_dma(mic_ch, flags, 0, 0, 0);
> -	if (result < 0)
> -		goto error;
> -
> -	return allocate_tx(mic_ch);
> -error:
> -	dev_err(mic_dma_ch_to_device(mic_ch),
> -		"Error enqueueing dma status descriptor, error=3D%d\n",
> result);
> -	spin_unlock(&mic_ch->prep_lock);
> -	return NULL;
> -}
> -
> -/*
> - * Prepare a memcpy descriptor to be added to the ring.
> - * Note that the temporary descriptor adds an extra overhead of copying =
the
> - * descriptor to ring. So, we copy directly to the descriptor ring
> - */
> -static struct dma_async_tx_descriptor *
> -mic_dma_prep_memcpy_lock(struct dma_chan *ch, dma_addr_t dma_dest,
> -			 dma_addr_t dma_src, size_t len, unsigned long flags)
> -{
> -	struct mic_dma_chan *mic_ch =3D to_mic_dma_chan(ch);
> -	struct device *dev =3D mic_dma_ch_to_device(mic_ch);
> -	int result;
> -
> -	if (!len && !flags)
> -		return NULL;
> -
> -	spin_lock(&mic_ch->prep_lock);
> -	result =3D mic_dma_do_dma(mic_ch, flags, dma_src, dma_dest, len);
> -	if (result >=3D 0)
> -		return allocate_tx(mic_ch);
> -	dev_err(dev, "Error enqueueing dma, error=3D%d\n", result);
> -	spin_unlock(&mic_ch->prep_lock);
> -	return NULL;
> -}
> -
> -static struct dma_async_tx_descriptor *
> -mic_dma_prep_interrupt_lock(struct dma_chan *ch, unsigned long flags)
> -{
> -	struct mic_dma_chan *mic_ch =3D to_mic_dma_chan(ch);
> -	int ret;
> -
> -	spin_lock(&mic_ch->prep_lock);
> -	ret =3D mic_dma_do_dma(mic_ch, flags, 0, 0, 0);
> -	if (!ret)
> -		return allocate_tx(mic_ch);
> -	spin_unlock(&mic_ch->prep_lock);
> -	return NULL;
> -}
> -
> -/* Return the status of the transaction */
> -static enum dma_status
> -mic_dma_tx_status(struct dma_chan *ch, dma_cookie_t cookie,
> -		  struct dma_tx_state *txstate)
> -{
> -	struct mic_dma_chan *mic_ch =3D to_mic_dma_chan(ch);
> -
> -	if (DMA_COMPLETE !=3D dma_cookie_status(ch, cookie, txstate))
> -		mic_dma_cleanup(mic_ch);
> -
> -	return dma_cookie_status(ch, cookie, txstate);
> -}
> -
> -static irqreturn_t mic_dma_thread_fn(int irq, void *data)
> -{
> -	mic_dma_cleanup((struct mic_dma_chan *)data);
> -	return IRQ_HANDLED;
> -}
> -
> -static irqreturn_t mic_dma_intr_handler(int irq, void *data)
> -{
> -	struct mic_dma_chan *ch =3D ((struct mic_dma_chan *)data);
> -
> -	mic_dma_ack_interrupt(ch);
> -	return IRQ_WAKE_THREAD;
> -}
> -
> -static int mic_dma_alloc_desc_ring(struct mic_dma_chan *ch)
> -{
> -	u64 desc_ring_size =3D MIC_DMA_DESC_RX_SIZE * sizeof(*ch-
> >desc_ring);
> -	struct device *dev =3D &to_mbus_device(ch)->dev;
> -
> -	desc_ring_size =3D ALIGN(desc_ring_size, MIC_DMA_ALIGN_BYTES);
> -	ch->desc_ring =3D kzalloc(desc_ring_size, GFP_KERNEL);
> -
> -	if (!ch->desc_ring)
> -		return -ENOMEM;
> -
> -	ch->desc_ring_micpa =3D dma_map_single(dev, ch->desc_ring,
> -					     desc_ring_size,
> DMA_BIDIRECTIONAL);
> -	if (dma_mapping_error(dev, ch->desc_ring_micpa))
> -		goto map_error;
> -
> -	ch->tx_array =3D vzalloc(array_size(MIC_DMA_DESC_RX_SIZE,
> -					  sizeof(*ch->tx_array)));
> -	if (!ch->tx_array)
> -		goto tx_error;
> -	return 0;
> -tx_error:
> -	dma_unmap_single(dev, ch->desc_ring_micpa, desc_ring_size,
> -			 DMA_BIDIRECTIONAL);
> -map_error:
> -	kfree(ch->desc_ring);
> -	return -ENOMEM;
> -}
> -
> -static void mic_dma_free_desc_ring(struct mic_dma_chan *ch)
> -{
> -	u64 desc_ring_size =3D MIC_DMA_DESC_RX_SIZE * sizeof(*ch-
> >desc_ring);
> -
> -	vfree(ch->tx_array);
> -	desc_ring_size =3D ALIGN(desc_ring_size, MIC_DMA_ALIGN_BYTES);
> -	dma_unmap_single(&to_mbus_device(ch)->dev, ch-
> >desc_ring_micpa,
> -			 desc_ring_size, DMA_BIDIRECTIONAL);
> -	kfree(ch->desc_ring);
> -	ch->desc_ring =3D NULL;
> -}
> -
> -static void mic_dma_free_status_dest(struct mic_dma_chan *ch)
> -{
> -	dma_unmap_single(&to_mbus_device(ch)->dev, ch-
> >status_dest_micpa,
> -			 L1_CACHE_BYTES, DMA_BIDIRECTIONAL);
> -	kfree(ch->status_dest);
> -}
> -
> -static int mic_dma_alloc_status_dest(struct mic_dma_chan *ch)
> -{
> -	struct device *dev =3D &to_mbus_device(ch)->dev;
> -
> -	ch->status_dest =3D kzalloc(L1_CACHE_BYTES, GFP_KERNEL);
> -	if (!ch->status_dest)
> -		return -ENOMEM;
> -	ch->status_dest_micpa =3D dma_map_single(dev, ch->status_dest,
> -					L1_CACHE_BYTES,
> DMA_BIDIRECTIONAL);
> -	if (dma_mapping_error(dev, ch->status_dest_micpa)) {
> -		kfree(ch->status_dest);
> -		ch->status_dest =3D NULL;
> -		return -ENOMEM;
> -	}
> -	return 0;
> -}
> -
> -static int mic_dma_check_chan(struct mic_dma_chan *ch)
> -{
> -	if (mic_dma_read_reg(ch, MIC_DMA_REG_DCHERR) ||
> -	    mic_dma_read_reg(ch, MIC_DMA_REG_DSTAT) &
> MIC_DMA_CHAN_QUIESCE) {
> -		mic_dma_disable_chan(ch);
> -		mic_dma_chan_mask_intr(ch);
> -		dev_err(mic_dma_ch_to_device(ch),
> -			"%s %d error setting up mic dma chan %d\n",
> -			__func__, __LINE__, ch->ch_num);
> -		return -EBUSY;
> -	}
> -	return 0;
> -}
> -
> -static int mic_dma_chan_setup(struct mic_dma_chan *ch)
> -{
> -	if (MIC_DMA_CHAN_MIC =3D=3D ch->owner)
> -		mic_dma_chan_set_owner(ch);
> -	mic_dma_disable_chan(ch);
> -	mic_dma_chan_mask_intr(ch);
> -	mic_dma_write_reg(ch, MIC_DMA_REG_DCHERRMSK, 0);
> -	mic_dma_chan_set_desc_ring(ch);
> -	ch->last_tail =3D mic_dma_read_reg(ch, MIC_DMA_REG_DTPR);
> -	ch->head =3D ch->last_tail;
> -	ch->issued =3D 0;
> -	mic_dma_chan_unmask_intr(ch);
> -	mic_dma_enable_chan(ch);
> -	return mic_dma_check_chan(ch);
> -}
> -
> -static void mic_dma_chan_destroy(struct mic_dma_chan *ch)
> -{
> -	mic_dma_disable_chan(ch);
> -	mic_dma_chan_mask_intr(ch);
> -}
> -
> -static int mic_dma_setup_irq(struct mic_dma_chan *ch)
> -{
> -	ch->cookie =3D
> -		to_mbus_hw_ops(ch)-
> >request_threaded_irq(to_mbus_device(ch),
> -			mic_dma_intr_handler, mic_dma_thread_fn,
> -			"mic dma_channel", ch, ch->ch_num);
> -	return PTR_ERR_OR_ZERO(ch->cookie);
> -}
> -
> -static inline void mic_dma_free_irq(struct mic_dma_chan *ch)
> -{
> -	to_mbus_hw_ops(ch)->free_irq(to_mbus_device(ch), ch->cookie, ch);
> -}
> -
> -static int mic_dma_chan_init(struct mic_dma_chan *ch)
> -{
> -	int ret =3D mic_dma_alloc_desc_ring(ch);
> -
> -	if (ret)
> -		goto ring_error;
> -	ret =3D mic_dma_alloc_status_dest(ch);
> -	if (ret)
> -		goto status_error;
> -	ret =3D mic_dma_chan_setup(ch);
> -	if (ret)
> -		goto chan_error;
> -	return ret;
> -chan_error:
> -	mic_dma_free_status_dest(ch);
> -status_error:
> -	mic_dma_free_desc_ring(ch);
> -ring_error:
> -	return ret;
> -}
> -
> -static int mic_dma_drain_chan(struct mic_dma_chan *ch)
> -{
> -	struct dma_async_tx_descriptor *tx;
> -	int err =3D 0;
> -	dma_cookie_t cookie;
> -
> -	tx =3D mic_dma_prep_memcpy_lock(&ch->api_ch, 0, 0, 0,
> DMA_PREP_FENCE);
> -	if (!tx) {
> -		err =3D -ENOMEM;
> -		goto error;
> -	}
> -
> -	cookie =3D tx->tx_submit(tx);
> -	if (dma_submit_error(cookie))
> -		err =3D -ENOMEM;
> -	else
> -		err =3D dma_sync_wait(&ch->api_ch, cookie);
> -	if (err) {
> -		dev_err(mic_dma_ch_to_device(ch), "%s %d TO chan
> 0x%x\n",
> -			__func__, __LINE__, ch->ch_num);
> -		err =3D -EIO;
> -	}
> -error:
> -	mic_dma_cleanup(ch);
> -	return err;
> -}
> -
> -static inline void mic_dma_chan_uninit(struct mic_dma_chan *ch)
> -{
> -	mic_dma_chan_destroy(ch);
> -	mic_dma_cleanup(ch);
> -	mic_dma_free_status_dest(ch);
> -	mic_dma_free_desc_ring(ch);
> -}
> -
> -static int mic_dma_init(struct mic_dma_device *mic_dma_dev,
> -			enum mic_dma_chan_owner owner)
> -{
> -	int i, first_chan =3D mic_dma_dev->start_ch;
> -	struct mic_dma_chan *ch;
> -	int ret;
> -
> -	for (i =3D first_chan; i < first_chan + MIC_DMA_NUM_CHAN; i++) {
> -		ch =3D &mic_dma_dev->mic_ch[i];
> -		ch->ch_num =3D i;
> -		ch->owner =3D owner;
> -		spin_lock_init(&ch->cleanup_lock);
> -		spin_lock_init(&ch->prep_lock);
> -		spin_lock_init(&ch->issue_lock);
> -		ret =3D mic_dma_setup_irq(ch);
> -		if (ret)
> -			goto error;
> -	}
> -	return 0;
> -error:
> -	for (i =3D i - 1; i >=3D first_chan; i--)
> -		mic_dma_free_irq(ch);
> -	return ret;
> -}
> -
> -static void mic_dma_uninit(struct mic_dma_device *mic_dma_dev)
> -{
> -	int i, first_chan =3D mic_dma_dev->start_ch;
> -	struct mic_dma_chan *ch;
> -
> -	for (i =3D first_chan; i < first_chan + MIC_DMA_NUM_CHAN; i++) {
> -		ch =3D &mic_dma_dev->mic_ch[i];
> -		mic_dma_free_irq(ch);
> -	}
> -}
> -
> -static int mic_dma_alloc_chan_resources(struct dma_chan *ch)
> -{
> -	int ret =3D mic_dma_chan_init(to_mic_dma_chan(ch));
> -	if (ret)
> -		return ret;
> -	return MIC_DMA_DESC_RX_SIZE;
> -}
> -
> -static void mic_dma_free_chan_resources(struct dma_chan *ch)
> -{
> -	struct mic_dma_chan *mic_ch =3D to_mic_dma_chan(ch);
> -	mic_dma_drain_chan(mic_ch);
> -	mic_dma_chan_uninit(mic_ch);
> -}
> -
> -/* Set the fn. handlers and register the dma device with dma api */
> -static int mic_dma_register_dma_device(struct mic_dma_device
> *mic_dma_dev,
> -				       enum mic_dma_chan_owner owner)
> -{
> -	int i, first_chan =3D mic_dma_dev->start_ch;
> -
> -	dma_cap_zero(mic_dma_dev->dma_dev.cap_mask);
> -	/*
> -	 * This dma engine is not capable of host memory to host memory
> -	 * transfers
> -	 */
> -	dma_cap_set(DMA_MEMCPY, mic_dma_dev->dma_dev.cap_mask);
> -
> -	if (MIC_DMA_CHAN_HOST =3D=3D owner)
> -		dma_cap_set(DMA_PRIVATE, mic_dma_dev-
> >dma_dev.cap_mask);
> -	mic_dma_dev->dma_dev.device_alloc_chan_resources =3D
> -		mic_dma_alloc_chan_resources;
> -	mic_dma_dev->dma_dev.device_free_chan_resources =3D
> -		mic_dma_free_chan_resources;
> -	mic_dma_dev->dma_dev.device_tx_status =3D mic_dma_tx_status;
> -	mic_dma_dev->dma_dev.device_prep_dma_memcpy =3D
> mic_dma_prep_memcpy_lock;
> -	mic_dma_dev->dma_dev.device_prep_dma_imm_data =3D
> -		mic_dma_prep_status_lock;
> -	mic_dma_dev->dma_dev.device_prep_dma_interrupt =3D
> -		mic_dma_prep_interrupt_lock;
> -	mic_dma_dev->dma_dev.device_issue_pending =3D
> mic_dma_issue_pending;
> -	mic_dma_dev->dma_dev.copy_align =3D MIC_DMA_ALIGN_SHIFT;
> -	INIT_LIST_HEAD(&mic_dma_dev->dma_dev.channels);
> -	for (i =3D first_chan; i < first_chan + MIC_DMA_NUM_CHAN; i++) {
> -		mic_dma_dev->mic_ch[i].api_ch.device =3D &mic_dma_dev-
> >dma_dev;
> -		dma_cookie_init(&mic_dma_dev->mic_ch[i].api_ch);
> -		list_add_tail(&mic_dma_dev->mic_ch[i].api_ch.device_node,
> -			      &mic_dma_dev->dma_dev.channels);
> -	}
> -	return dmaenginem_async_device_register(&mic_dma_dev-
> >dma_dev);
> -}
> -
> -/*
> - * Initializes dma channels and registers the dma device with the
> - * dma engine api.
> - */
> -static struct mic_dma_device *mic_dma_dev_reg(struct mbus_device
> *mbdev,
> -					      enum mic_dma_chan_owner
> owner)
> -{
> -	struct mic_dma_device *mic_dma_dev;
> -	int ret;
> -	struct device *dev =3D &mbdev->dev;
> -
> -	mic_dma_dev =3D devm_kzalloc(dev, sizeof(*mic_dma_dev),
> GFP_KERNEL);
> -	if (!mic_dma_dev) {
> -		ret =3D -ENOMEM;
> -		goto alloc_error;
> -	}
> -	mic_dma_dev->mbdev =3D mbdev;
> -	mic_dma_dev->dma_dev.dev =3D dev;
> -	mic_dma_dev->mmio =3D mbdev->mmio_va;
> -	if (MIC_DMA_CHAN_HOST =3D=3D owner) {
> -		mic_dma_dev->start_ch =3D 0;
> -		mic_dma_dev->max_xfer_size =3D
> MIC_DMA_MAX_XFER_SIZE_HOST;
> -	} else {
> -		mic_dma_dev->start_ch =3D 4;
> -		mic_dma_dev->max_xfer_size =3D
> MIC_DMA_MAX_XFER_SIZE_CARD;
> -	}
> -	ret =3D mic_dma_init(mic_dma_dev, owner);
> -	if (ret)
> -		goto init_error;
> -	ret =3D mic_dma_register_dma_device(mic_dma_dev, owner);
> -	if (ret)
> -		goto reg_error;
> -	return mic_dma_dev;
> -reg_error:
> -	mic_dma_uninit(mic_dma_dev);
> -init_error:
> -	mic_dma_dev =3D NULL;
> -alloc_error:
> -	dev_err(dev, "Error at %s %d ret=3D%d\n", __func__, __LINE__, ret);
> -	return mic_dma_dev;
> -}
> -
> -static void mic_dma_dev_unreg(struct mic_dma_device *mic_dma_dev)
> -{
> -	mic_dma_uninit(mic_dma_dev);
> -}
> -
> -/* DEBUGFS CODE */
> -static int mic_dma_reg_show(struct seq_file *s, void *pos)
> -{
> -	struct mic_dma_device *mic_dma_dev =3D s->private;
> -	int i, chan_num, first_chan =3D mic_dma_dev->start_ch;
> -	struct mic_dma_chan *ch;
> -
> -	seq_printf(s, "SBOX_DCR: %#x\n",
> -		   mic_dma_mmio_read(&mic_dma_dev->mic_ch[first_chan],
> -				     MIC_DMA_SBOX_BASE +
> MIC_DMA_SBOX_DCR));
> -	seq_puts(s, "DMA Channel Registers\n");
> -	seq_printf(s, "%-10s| %-10s %-10s %-10s %-10s %-10s",
> -		   "Channel", "DCAR", "DTPR", "DHPR", "DRAR_HI",
> "DRAR_LO");
> -	seq_printf(s, " %-11s %-14s %-10s\n", "DCHERR", "DCHERRMSK",
> "DSTAT");
> -	for (i =3D first_chan; i < first_chan + MIC_DMA_NUM_CHAN; i++) {
> -		ch =3D &mic_dma_dev->mic_ch[i];
> -		chan_num =3D ch->ch_num;
> -		seq_printf(s, "%-10i| %-#10x %-#10x %-#10x %-#10x",
> -			   chan_num,
> -			   mic_dma_read_reg(ch, MIC_DMA_REG_DCAR),
> -			   mic_dma_read_reg(ch, MIC_DMA_REG_DTPR),
> -			   mic_dma_read_reg(ch, MIC_DMA_REG_DHPR),
> -			   mic_dma_read_reg(ch, MIC_DMA_REG_DRAR_HI));
> -		seq_printf(s, " %-#10x %-#10x %-#14x %-#10x\n",
> -			   mic_dma_read_reg(ch, MIC_DMA_REG_DRAR_LO),
> -			   mic_dma_read_reg(ch, MIC_DMA_REG_DCHERR),
> -			   mic_dma_read_reg(ch,
> MIC_DMA_REG_DCHERRMSK),
> -			   mic_dma_read_reg(ch, MIC_DMA_REG_DSTAT));
> -	}
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(mic_dma_reg);
> -
> -/* Debugfs parent dir */
> -static struct dentry *mic_dma_dbg;
> -
> -static int mic_dma_driver_probe(struct mbus_device *mbdev)
> -{
> -	struct mic_dma_device *mic_dma_dev;
> -	enum mic_dma_chan_owner owner;
> -
> -	if (MBUS_DEV_DMA_MIC =3D=3D mbdev->id.device)
> -		owner =3D MIC_DMA_CHAN_MIC;
> -	else
> -		owner =3D MIC_DMA_CHAN_HOST;
> -
> -	mic_dma_dev =3D mic_dma_dev_reg(mbdev, owner);
> -	dev_set_drvdata(&mbdev->dev, mic_dma_dev);
> -
> -	if (mic_dma_dbg) {
> -		mic_dma_dev->dbg_dir =3D
> debugfs_create_dir(dev_name(&mbdev->dev),
> -							  mic_dma_dbg);
> -		debugfs_create_file("mic_dma_reg", 0444, mic_dma_dev-
> >dbg_dir,
> -				    mic_dma_dev, &mic_dma_reg_fops);
> -	}
> -	return 0;
> -}
> -
> -static void mic_dma_driver_remove(struct mbus_device *mbdev)
> -{
> -	struct mic_dma_device *mic_dma_dev;
> -
> -	mic_dma_dev =3D dev_get_drvdata(&mbdev->dev);
> -	debugfs_remove_recursive(mic_dma_dev->dbg_dir);
> -	mic_dma_dev_unreg(mic_dma_dev);
> -}
> -
> -static struct mbus_device_id id_table[] =3D {
> -	{MBUS_DEV_DMA_MIC, MBUS_DEV_ANY_ID},
> -	{MBUS_DEV_DMA_HOST, MBUS_DEV_ANY_ID},
> -	{0},
> -};
> -
> -static struct mbus_driver mic_dma_driver =3D {
> -	.driver.name =3D	KBUILD_MODNAME,
> -	.driver.owner =3D	THIS_MODULE,
> -	.id_table =3D id_table,
> -	.probe =3D mic_dma_driver_probe,
> -	.remove =3D mic_dma_driver_remove,
> -};
> -
> -static int __init mic_x100_dma_init(void)
> -{
> -	int rc =3D mbus_register_driver(&mic_dma_driver);
> -	if (rc)
> -		return rc;
> -	mic_dma_dbg =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> -	return 0;
> -}
> -
> -static void __exit mic_x100_dma_exit(void)
> -{
> -	debugfs_remove_recursive(mic_dma_dbg);
> -	mbus_unregister_driver(&mic_dma_driver);
> -}
> -
> -module_init(mic_x100_dma_init);
> -module_exit(mic_x100_dma_exit);
> -
> -MODULE_DEVICE_TABLE(mbus, id_table);
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) MIC X100 DMA Driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/mic_x100_dma.h b/drivers/dma/mic_x100_dma.h
> deleted file mode 100644
> index 68ef43a91714..000000000000
> --- a/drivers/dma/mic_x100_dma.h
> +++ /dev/null
> @@ -1,275 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel MIC X100 DMA Driver.
> - *
> - * Adapted from IOAT dma driver.
> - */
> -#ifndef _MIC_X100_DMA_H_
> -#define _MIC_X100_DMA_H_
> -
> -#include <linux/kernel.h>
> -#include <linux/delay.h>
> -#include <linux/sched.h>
> -#include <linux/debugfs.h>
> -#include <linux/slab.h>
> -#include <linux/interrupt.h>
> -#include <linux/mic_bus.h>
> -
> -#include "dmaengine.h"
> -
> -/*
> - * MIC has a total of 8 dma channels.
> - * Four channels are assigned for host SW use & the remaining for MIC SW=
.
> - * MIC DMA transfer size & addresses need to be 64 byte aligned.
> - */
> -#define MIC_DMA_MAX_NUM_CHAN	8
> -#define MIC_DMA_NUM_CHAN	4
> -#define MIC_DMA_ALIGN_SHIFT	DMAENGINE_ALIGN_64_BYTES
> -#define MIC_DMA_ALIGN_BYTES	(1 << MIC_DMA_ALIGN_SHIFT)
> -#define MIC_DMA_DESC_RX_SIZE	(128 * 1024 - 4)
> -
> -/*
> - * Register descriptions
> - * All the registers are 32 bit registers.
> - * DCR is a global register and all others are per-channel.
> - * DCR - bits 0, 2, 4, 6, 8, 10, 12, 14 - enable bits for channels 0 to =
7
> - *	 bits 1, 3, 5, 7, 9, 11, 13, 15 - owner bits for channels 0 to 7
> - * DCAR - bit 24 & 25 interrupt masks for mic owned & host owned channel=
s
> - * DHPR - head of the descriptor ring updated by s/w
> - * DTPR - tail of the descriptor ring updated by h/w
> - * DRAR_LO - lower 32 bits of descriptor ring's mic address
> - * DRAR_HI - 3:0 - remaining 4 bits of descriptor ring's mic address
> - *	     20:4 descriptor ring size
> - *	     25:21 mic smpt entry number
> - * DSTAT - 16:0 h/w completion count; 31:28 dma engine status
> - * DCHERR - this register is non-zero on error
> - * DCHERRMSK - interrupt mask register
> - */
> -#define MIC_DMA_HW_CMP_CNT_MASK		0x1ffff
> -#define MIC_DMA_CHAN_QUIESCE		0x20000000
> -#define MIC_DMA_SBOX_BASE		0x00010000
> -#define MIC_DMA_SBOX_DCR		0x0000A280
> -#define MIC_DMA_SBOX_CH_BASE		0x0001A000
> -#define MIC_DMA_SBOX_CHAN_OFF		0x40
> -#define MIC_DMA_SBOX_DCAR_IM0		(0x1 << 24)
> -#define MIC_DMA_SBOX_DCAR_IM1		(0x1 << 25)
> -#define MIC_DMA_SBOX_DRARHI_SYS_MASK	(0x1 << 26)
> -#define MIC_DMA_REG_DCAR		0
> -#define MIC_DMA_REG_DHPR		4
> -#define MIC_DMA_REG_DTPR		8
> -#define MIC_DMA_REG_DRAR_LO		20
> -#define MIC_DMA_REG_DRAR_HI		24
> -#define MIC_DMA_REG_DSTAT		32
> -#define MIC_DMA_REG_DCHERR		44
> -#define MIC_DMA_REG_DCHERRMSK		48
> -
> -/* HW dma desc */
> -struct mic_dma_desc {
> -	u64 qw0;
> -	u64 qw1;
> -};
> -
> -enum mic_dma_chan_owner {
> -	MIC_DMA_CHAN_MIC =3D 0,
> -	MIC_DMA_CHAN_HOST
> -};
> -
> -/*
> - * mic_dma_chan - channel specific information
> - * @ch_num: channel number
> - * @owner: owner of this channel
> - * @last_tail: cached value of descriptor ring tail
> - * @head: index of next descriptor in desc_ring
> - * @issued: hardware notification point
> - * @submitted: index that will be used to submit descriptors to h/w
> - * @api_ch: dma engine api channel
> - * @desc_ring: dma descriptor ring
> - * @desc_ring_micpa: mic physical address of desc_ring
> - * @status_dest: destination for status (fence) descriptor
> - * @status_dest_micpa: mic address for status_dest,
> - *		       DMA controller uses this address
> - * @tx_array: array of async_tx
> - * @cleanup_lock: lock held when processing completed tx
> - * @prep_lock: lock held in prep_memcpy & released in tx_submit
> - * @issue_lock: lock used to synchronize writes to head
> - * @cookie: mic_irq cookie used with mic irq request
> - */
> -struct mic_dma_chan {
> -	int ch_num;
> -	enum mic_dma_chan_owner owner;
> -	u32 last_tail;
> -	u32 head;
> -	u32 issued;
> -	u32 submitted;
> -	struct dma_chan api_ch;
> -	struct mic_dma_desc *desc_ring;
> -	dma_addr_t desc_ring_micpa;
> -	u64 *status_dest;
> -	dma_addr_t status_dest_micpa;
> -	struct dma_async_tx_descriptor *tx_array;
> -	spinlock_t cleanup_lock;
> -	spinlock_t prep_lock;
> -	spinlock_t issue_lock;
> -	struct mic_irq *cookie;
> -};
> -
> -/*
> - * struct mic_dma_device - per mic device
> - * @mic_ch: dma channels
> - * @dma_dev: underlying dma device
> - * @mbdev: mic bus dma device
> - * @mmio: virtual address of the mmio space
> - * @dbg_dir: debugfs directory
> - * @start_ch: first channel number that can be used
> - * @max_xfer_size: maximum transfer size per dma descriptor
> - */
> -struct mic_dma_device {
> -	struct mic_dma_chan mic_ch[MIC_DMA_MAX_NUM_CHAN];
> -	struct dma_device dma_dev;
> -	struct mbus_device *mbdev;
> -	void __iomem *mmio;
> -	struct dentry *dbg_dir;
> -	int start_ch;
> -	size_t max_xfer_size;
> -};
> -
> -static inline struct mic_dma_chan *to_mic_dma_chan(struct dma_chan *ch)
> -{
> -	return container_of(ch, struct mic_dma_chan, api_ch);
> -}
> -
> -static inline struct mic_dma_device *to_mic_dma_dev(struct mic_dma_chan
> *ch)
> -{
> -	return
> -	container_of((const typeof(((struct mic_dma_device *)0)->mic_ch)*)
> -		     (ch - ch->ch_num), struct mic_dma_device, mic_ch);
> -}
> -
> -static inline struct mbus_device *to_mbus_device(struct mic_dma_chan *ch=
)
> -{
> -	return to_mic_dma_dev(ch)->mbdev;
> -}
> -
> -static inline struct mbus_hw_ops *to_mbus_hw_ops(struct mic_dma_chan
> *ch)
> -{
> -	return to_mbus_device(ch)->hw_ops;
> -}
> -
> -static inline struct device *mic_dma_ch_to_device(struct mic_dma_chan *c=
h)
> -{
> -	return to_mic_dma_dev(ch)->dma_dev.dev;
> -}
> -
> -static inline void __iomem *mic_dma_chan_to_mmio(struct mic_dma_chan
> *ch)
> -{
> -	return to_mic_dma_dev(ch)->mmio;
> -}
> -
> -static inline u32 mic_dma_read_reg(struct mic_dma_chan *ch, u32 reg)
> -{
> -	return ioread32(mic_dma_chan_to_mmio(ch) +
> MIC_DMA_SBOX_CH_BASE +
> -			ch->ch_num * MIC_DMA_SBOX_CHAN_OFF + reg);
> -}
> -
> -static inline void mic_dma_write_reg(struct mic_dma_chan *ch, u32 reg, u=
32
> val)
> -{
> -	iowrite32(val, mic_dma_chan_to_mmio(ch) +
> MIC_DMA_SBOX_CH_BASE +
> -		  ch->ch_num * MIC_DMA_SBOX_CHAN_OFF + reg);
> -}
> -
> -static inline u32 mic_dma_mmio_read(struct mic_dma_chan *ch, u32 offset)
> -{
> -	return ioread32(mic_dma_chan_to_mmio(ch) + offset);
> -}
> -
> -static inline void mic_dma_mmio_write(struct mic_dma_chan *ch, u32 val,
> -				      u32 offset)
> -{
> -	iowrite32(val, mic_dma_chan_to_mmio(ch) + offset);
> -}
> -
> -static inline u32 mic_dma_read_cmp_cnt(struct mic_dma_chan *ch)
> -{
> -	return mic_dma_read_reg(ch, MIC_DMA_REG_DSTAT) &
> -	       MIC_DMA_HW_CMP_CNT_MASK;
> -}
> -
> -static inline void mic_dma_chan_set_owner(struct mic_dma_chan *ch)
> -{
> -	u32 dcr =3D mic_dma_mmio_read(ch, MIC_DMA_SBOX_BASE +
> MIC_DMA_SBOX_DCR);
> -	u32 chan_num =3D ch->ch_num;
> -
> -	dcr =3D (dcr & ~(0x1 << (chan_num * 2))) | (ch->owner << (chan_num *
> 2));
> -	mic_dma_mmio_write(ch, dcr, MIC_DMA_SBOX_BASE +
> MIC_DMA_SBOX_DCR);
> -}
> -
> -static inline void mic_dma_enable_chan(struct mic_dma_chan *ch)
> -{
> -	u32 dcr =3D mic_dma_mmio_read(ch, MIC_DMA_SBOX_BASE +
> MIC_DMA_SBOX_DCR);
> -
> -	dcr |=3D 2 << (ch->ch_num << 1);
> -	mic_dma_mmio_write(ch, dcr, MIC_DMA_SBOX_BASE +
> MIC_DMA_SBOX_DCR);
> -}
> -
> -static inline void mic_dma_disable_chan(struct mic_dma_chan *ch)
> -{
> -	u32 dcr =3D mic_dma_mmio_read(ch, MIC_DMA_SBOX_BASE +
> MIC_DMA_SBOX_DCR);
> -
> -	dcr &=3D ~(2 << (ch->ch_num << 1));
> -	mic_dma_mmio_write(ch, dcr, MIC_DMA_SBOX_BASE +
> MIC_DMA_SBOX_DCR);
> -}
> -
> -static void mic_dma_chan_set_desc_ring(struct mic_dma_chan *ch)
> -{
> -	u32 drar_hi;
> -	dma_addr_t desc_ring_micpa =3D ch->desc_ring_micpa;
> -
> -	drar_hi =3D (MIC_DMA_DESC_RX_SIZE & 0x1ffff) << 4;
> -	if (MIC_DMA_CHAN_MIC =3D=3D ch->owner) {
> -		drar_hi |=3D (desc_ring_micpa >> 32) & 0xf;
> -	} else {
> -		drar_hi |=3D MIC_DMA_SBOX_DRARHI_SYS_MASK;
> -		drar_hi |=3D ((desc_ring_micpa >> 34)
> -			    & 0x1f) << 21;
> -		drar_hi |=3D (desc_ring_micpa >> 32) & 0x3;
> -	}
> -	mic_dma_write_reg(ch, MIC_DMA_REG_DRAR_LO, (u32)
> desc_ring_micpa);
> -	mic_dma_write_reg(ch, MIC_DMA_REG_DRAR_HI, drar_hi);
> -}
> -
> -static inline void mic_dma_chan_mask_intr(struct mic_dma_chan *ch)
> -{
> -	u32 dcar =3D mic_dma_read_reg(ch, MIC_DMA_REG_DCAR);
> -
> -	if (MIC_DMA_CHAN_MIC =3D=3D ch->owner)
> -		dcar |=3D MIC_DMA_SBOX_DCAR_IM0;
> -	else
> -		dcar |=3D MIC_DMA_SBOX_DCAR_IM1;
> -	mic_dma_write_reg(ch, MIC_DMA_REG_DCAR, dcar);
> -}
> -
> -static inline void mic_dma_chan_unmask_intr(struct mic_dma_chan *ch)
> -{
> -	u32 dcar =3D mic_dma_read_reg(ch, MIC_DMA_REG_DCAR);
> -
> -	if (MIC_DMA_CHAN_MIC =3D=3D ch->owner)
> -		dcar &=3D ~MIC_DMA_SBOX_DCAR_IM0;
> -	else
> -		dcar &=3D ~MIC_DMA_SBOX_DCAR_IM1;
> -	mic_dma_write_reg(ch, MIC_DMA_REG_DCAR, dcar);
> -}
> -
> -static void mic_dma_ack_interrupt(struct mic_dma_chan *ch)
> -{
> -	if (MIC_DMA_CHAN_MIC =3D=3D ch->owner) {
> -		/* HW errata */
> -		mic_dma_chan_mask_intr(ch);
> -		mic_dma_chan_unmask_intr(ch);
> -	}
> -	to_mbus_hw_ops(ch)->ack_interrupt(to_mbus_device(ch), ch-
> >ch_num);
> -}
> -#endif
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index d5ce8082b0a0..fafa8b0d8099 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -474,7 +474,6 @@ source "drivers/misc/lis3lv02d/Kconfig"
>  source "drivers/misc/altera-stapl/Kconfig"
>  source "drivers/misc/mei/Kconfig"
>  source "drivers/misc/vmw_vmci/Kconfig"
> -source "drivers/misc/mic/Kconfig"
>  source "drivers/misc/genwqe/Kconfig"
>  source "drivers/misc/echo/Kconfig"
>  source "drivers/misc/cxl/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 2521359e8ef7..d23231e73330 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -46,7 +46,6 @@ obj-$(CONFIG_VMWARE_VMCI)	+=3D vmw_vmci/
>  obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+=3D lattice-ecp3-config.o
>  obj-$(CONFIG_SRAM)		+=3D sram.o
>  obj-$(CONFIG_SRAM_EXEC)		+=3D sram-exec.o
> -obj-y				+=3D mic/
>  obj-$(CONFIG_GENWQE)		+=3D genwqe/
>  obj-$(CONFIG_ECHO)		+=3D echo/
>  obj-$(CONFIG_CXL_BASE)		+=3D cxl/
> diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
> deleted file mode 100644
> index 8a7c2c5711d5..000000000000
> --- a/drivers/misc/mic/Kconfig
> +++ /dev/null
> @@ -1,141 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -menu "Intel MIC & related support"
> -
> -config INTEL_MIC_BUS
> -	tristate "Intel MIC Bus Driver"
> -	depends on 64BIT && PCI && X86
> -	select DMA_OPS
> -	help
> -	  This option is selected by any driver which registers a
> -	  device or driver on the MIC Bus, such as CONFIG_INTEL_MIC_HOST,
> -	  CONFIG_INTEL_MIC_CARD, CONFIG_INTEL_MIC_X100_DMA etc.
> -
> -	  If you are building a host/card kernel with an Intel MIC device
> -	  then say M (recommended) or Y, else say N. If unsure say N.
> -
> -	  More information about the Intel MIC family as well as the Linux
> -	  OS and tools for MIC to use with this driver are available from
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591943962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3Dp3GqcxhfjjI76nVd2ejarp1i49GXx5%2Be6pvcFgHdiDI%3D&amp;reserve
> d=3D0>.
> -
> -config SCIF_BUS
> -	tristate "SCIF Bus Driver"
> -	depends on 64BIT && PCI && X86
> -	select DMA_OPS
> -	help
> -	  This option is selected by any driver which registers a
> -	  device or driver on the SCIF Bus, such as CONFIG_INTEL_MIC_HOST
> -	  and CONFIG_INTEL_MIC_CARD.
> -
> -	  If you are building a host/card kernel with an Intel MIC device
> -	  then say M (recommended) or Y, else say N. If unsure say N.
> -
> -	  More information about the Intel MIC family as well as the Linux
> -	  OS and tools for MIC to use with this driver are available from
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591943962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3Dp3GqcxhfjjI76nVd2ejarp1i49GXx5%2Be6pvcFgHdiDI%3D&amp;reserve
> d=3D0>.
> -
> -config VOP_BUS
> -	tristate "VOP Bus Driver"
> -	depends on HAS_DMA
> -	select DMA_OPS
> -	help
> -	  This option is selected by any driver which registers a
> -	  device or driver on the VOP Bus, such as CONFIG_INTEL_MIC_HOST
> -	  and CONFIG_INTEL_MIC_CARD.
> -
> -	  If you are building a host/card kernel with an Intel MIC device
> -	  then say M (recommended) or Y, else say N. If unsure say N.
> -
> -	  More information about the Intel MIC family as well as the Linux
> -	  OS and tools for MIC to use with this driver are available from
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591943962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3Dp3GqcxhfjjI76nVd2ejarp1i49GXx5%2Be6pvcFgHdiDI%3D&amp;reserve
> d=3D0>.
> -
> -config INTEL_MIC_HOST
> -	tristate "Intel MIC Host Driver"
> -	depends on 64BIT && PCI && X86
> -	depends on INTEL_MIC_BUS && SCIF_BUS && MIC_COSM &&
> VOP_BUS
> -	select DMA_OPS
> -	help
> -	  This enables Host Driver support for the Intel Many Integrated
> -	  Core (MIC) family of PCIe form factor coprocessor devices that
> -	  run a 64 bit Linux OS. The driver manages card OS state and
> -	  enables communication between host and card. Intel MIC X100
> -	  devices are currently supported.
> -
> -	  If you are building a host kernel with an Intel MIC device then
> -	  say M (recommended) or Y, else say N. If unsure say N.
> -
> -	  More information about the Intel MIC family as well as the Linux
> -	  OS and tools for MIC to use with this driver are available from
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591943962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3Dp3GqcxhfjjI76nVd2ejarp1i49GXx5%2Be6pvcFgHdiDI%3D&amp;reserve
> d=3D0>.
> -
> -config INTEL_MIC_CARD
> -	tristate "Intel MIC Card Driver"
> -	depends on 64BIT && X86
> -	depends on INTEL_MIC_BUS && SCIF_BUS && MIC_COSM &&
> VOP_BUS
> -	select VIRTIO
> -	help
> -	  This enables card driver support for the Intel Many Integrated
> -	  Core (MIC) device family. The card driver communicates shutdown/
> -	  crash events to the host and allows registration/configuration of
> -	  virtio devices. Intel MIC X100 devices are currently supported.
> -
> -	  If you are building a card kernel for an Intel MIC device then
> -	  say M (recommended) or Y, else say N. If unsure say N.
> -
> -	  For more information see
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591943962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3Dp3GqcxhfjjI76nVd2ejarp1i49GXx5%2Be6pvcFgHdiDI%3D&amp;reserve
> d=3D0>.
> -
> -config SCIF
> -	tristate "SCIF Driver"
> -	depends on 64BIT && PCI && X86 && SCIF_BUS &&
> IOMMU_SUPPORT
> -	select IOMMU_IOVA
> -	help
> -	  This enables SCIF Driver support for the Intel Many Integrated
> -	  Core (MIC) family of PCIe form factor coprocessor devices that
> -	  run a 64 bit Linux OS. The Symmetric Communication Interface
> -	  (SCIF (pronounced as skiff)) is a low level communications API
> -	  across PCIe currently implemented for MIC.
> -
> -	  If you are building a host kernel with an Intel MIC device then
> -	  say M (recommended) or Y, else say N. If unsure say N.
> -
> -	  More information about the Intel MIC family as well as the Linux
> -	  OS and tools for MIC to use with this driver are available from
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591943962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3Dp3GqcxhfjjI76nVd2ejarp1i49GXx5%2Be6pvcFgHdiDI%3D&amp;reserve
> d=3D0>.
> -
> -config MIC_COSM
> -	tristate "Intel MIC Coprocessor State Management (COSM) Drivers"
> -	depends on 64BIT && PCI && X86 && SCIF
> -	help
> -	  This enables COSM driver support for the Intel Many
> -	  Integrated Core (MIC) family of PCIe form factor coprocessor
> -	  devices. COSM drivers implement functions such as boot,
> -	  shutdown, reset and reboot of MIC devices.
> -
> -	  If you are building a host kernel with an Intel MIC device then
> -	  say M (recommended) or Y, else say N. If unsure say N.
> -
> -	  More information about the Intel MIC family as well as the Linux
> -	  OS and tools for MIC to use with this driver are available from
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591943962%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3Dp3GqcxhfjjI76nVd2ejarp1i49GXx5%2Be6pvcFgHdiDI%3D&amp;reserve
> d=3D0>.
> -
> -config VOP
> -	tristate "VOP Driver"
> -	depends on VOP_BUS
> -	select VHOST_RING
> -	select VIRTIO
> -	help
> -	  This enables VOP (Virtio over PCIe) Driver support for the Intel
> -	  Many Integrated Core (MIC) family of PCIe form factor coprocessor
> -	  devices. The VOP driver allows virtio drivers, e.g. net, console
> -	  and block drivers, on the card connect to user space virtio
> -	  devices on the host.
> -
> -	  If you are building a host kernel with an Intel MIC device then
> -	  say M (recommended) or Y, else say N. If unsure say N.
> -
> -	  More information about the Intel MIC family as well as the Linux
> -	  OS and tools for MIC to use with this driver are available from
> -
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsoftw
> are.intel.com%2Fen-us%2Fmic-
> developer&amp;data=3D04%7C01%7Csherry.sun%40nxp.com%7Cf4d4a5577fcc
> 4f87f93e08d87af0768e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C637394520591948943%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;
> sdata=3DvgbArTat4RQ2quACATuImDmQr2vnfhvXFKAEKm2few8%3D&amp;rese
> rved=3D0>.
> -
> -endmenu
> diff --git a/drivers/misc/mic/Makefile b/drivers/misc/mic/Makefile
> deleted file mode 100644
> index 1a43622b183f..000000000000
> --- a/drivers/misc/mic/Makefile
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile - Intel MIC Linux driver.
> -# Copyright(c) 2013, Intel Corporation.
> -#
> -obj-$(CONFIG_INTEL_MIC_HOST) +=3D host/
> -obj-$(CONFIG_INTEL_MIC_CARD) +=3D card/
> -obj-y +=3D bus/
> -obj-$(CONFIG_SCIF) +=3D scif/
> -obj-$(CONFIG_MIC_COSM) +=3D cosm/
> -obj-$(CONFIG_MIC_COSM) +=3D cosm_client/
> -obj-$(CONFIG_VOP) +=3D vop/
> diff --git a/drivers/misc/mic/bus/Makefile b/drivers/misc/mic/bus/Makefil=
e
> deleted file mode 100644
> index 0a6aa21b2f67..000000000000
> --- a/drivers/misc/mic/bus/Makefile
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Makefile - Intel MIC Linux driver.
> -# Copyright(c) 2014, Intel Corporation.
> -#
> -obj-$(CONFIG_INTEL_MIC_BUS) +=3D mic_bus.o
> -obj-$(CONFIG_SCIF_BUS) +=3D scif_bus.o
> -obj-$(CONFIG_MIC_COSM) +=3D cosm_bus.o
> -obj-$(CONFIG_VOP_BUS) +=3D vop_bus.o
> diff --git a/drivers/misc/mic/bus/cosm_bus.c
> b/drivers/misc/mic/bus/cosm_bus.c
> deleted file mode 100644
> index 5f2141c71738..000000000000
> --- a/drivers/misc/mic/bus/cosm_bus.c
> +++ /dev/null
> @@ -1,130 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel MIC COSM Bus Driver
> - */
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/idr.h>
> -#include "cosm_bus.h"
> -
> -/* Unique numbering for cosm devices. */
> -static DEFINE_IDA(cosm_index_ida);
> -
> -static int cosm_dev_probe(struct device *d)
> -{
> -	struct cosm_device *dev =3D dev_to_cosm(d);
> -	struct cosm_driver *drv =3D drv_to_cosm(dev->dev.driver);
> -
> -	return drv->probe(dev);
> -}
> -
> -static int cosm_dev_remove(struct device *d)
> -{
> -	struct cosm_device *dev =3D dev_to_cosm(d);
> -	struct cosm_driver *drv =3D drv_to_cosm(dev->dev.driver);
> -
> -	drv->remove(dev);
> -	return 0;
> -}
> -
> -static struct bus_type cosm_bus =3D {
> -	.name  =3D "cosm_bus",
> -	.probe =3D cosm_dev_probe,
> -	.remove =3D cosm_dev_remove,
> -};
> -
> -int cosm_register_driver(struct cosm_driver *driver)
> -{
> -	driver->driver.bus =3D &cosm_bus;
> -	return driver_register(&driver->driver);
> -}
> -EXPORT_SYMBOL_GPL(cosm_register_driver);
> -
> -void cosm_unregister_driver(struct cosm_driver *driver)
> -{
> -	driver_unregister(&driver->driver);
> -}
> -EXPORT_SYMBOL_GPL(cosm_unregister_driver);
> -
> -static inline void cosm_release_dev(struct device *d)
> -{
> -	struct cosm_device *cdev =3D dev_to_cosm(d);
> -
> -	kfree(cdev);
> -}
> -
> -struct cosm_device *
> -cosm_register_device(struct device *pdev, struct cosm_hw_ops *hw_ops)
> -{
> -	struct cosm_device *cdev;
> -	int ret;
> -
> -	cdev =3D kzalloc(sizeof(*cdev), GFP_KERNEL);
> -	if (!cdev)
> -		return ERR_PTR(-ENOMEM);
> -
> -	cdev->dev.parent =3D pdev;
> -	cdev->dev.release =3D cosm_release_dev;
> -	cdev->hw_ops =3D hw_ops;
> -	dev_set_drvdata(&cdev->dev, cdev);
> -	cdev->dev.bus =3D &cosm_bus;
> -
> -	/* Assign a unique device index and hence name */
> -	ret =3D ida_simple_get(&cosm_index_ida, 0, 0, GFP_KERNEL);
> -	if (ret < 0)
> -		goto free_cdev;
> -
> -	cdev->index =3D ret;
> -	cdev->dev.id =3D ret;
> -	dev_set_name(&cdev->dev, "cosm-dev%u", cdev->index);
> -
> -	ret =3D device_register(&cdev->dev);
> -	if (ret)
> -		goto ida_remove;
> -	return cdev;
> -ida_remove:
> -	ida_simple_remove(&cosm_index_ida, cdev->index);
> -free_cdev:
> -	put_device(&cdev->dev);
> -	return ERR_PTR(ret);
> -}
> -EXPORT_SYMBOL_GPL(cosm_register_device);
> -
> -void cosm_unregister_device(struct cosm_device *dev)
> -{
> -	int index =3D dev->index; /* save for after device release */
> -
> -	device_unregister(&dev->dev);
> -	ida_simple_remove(&cosm_index_ida, index);
> -}
> -EXPORT_SYMBOL_GPL(cosm_unregister_device);
> -
> -struct cosm_device *cosm_find_cdev_by_id(int id)
> -{
> -	struct device *dev =3D subsys_find_device_by_id(&cosm_bus, id, NULL);
> -
> -	return dev ? container_of(dev, struct cosm_device, dev) : NULL;
> -}
> -EXPORT_SYMBOL_GPL(cosm_find_cdev_by_id);
> -
> -static int __init cosm_init(void)
> -{
> -	return bus_register(&cosm_bus);
> -}
> -
> -static void __exit cosm_exit(void)
> -{
> -	bus_unregister(&cosm_bus);
> -	ida_destroy(&cosm_index_ida);
> -}
> -
> -core_initcall(cosm_init);
> -module_exit(cosm_exit);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) MIC card OS state management bus
> driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/bus/cosm_bus.h
> b/drivers/misc/mic/bus/cosm_bus.h
> deleted file mode 100644
> index d50d7aea168d..000000000000
> --- a/drivers/misc/mic/bus/cosm_bus.h
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel MIC COSM Bus Driver
> - */
> -#ifndef _COSM_BUS_H_
> -#define _COSM_BUS_H_
> -
> -#include <linux/scif.h>
> -#include <linux/mic_common.h>
> -#include "../common/mic_dev.h"
> -
> -/**
> - * cosm_device - representation of a cosm device
> - *
> - * @attr_group: Pointer to list of sysfs attribute groups.
> - * @sdev: Device for sysfs entries.
> - * @state: MIC state.
> - * @prev_state: MIC state previous to MIC_RESETTING
> - * @shutdown_status: MIC status reported by card for shutdown/crashes.
> - * @shutdown_status_int: Internal shutdown status maintained by the
> driver
> - * @cosm_mutex: Mutex for synchronizing access to data structures.
> - * @reset_trigger_work: Work for triggering reset requests.
> - * @scif_work: Work for handling per device SCIF connections
> - * @cmdline: Kernel command line.
> - * @firmware: Firmware file name.
> - * @ramdisk: Ramdisk file name.
> - * @bootmode: Boot mode i.e. "linux" or "elf" for flash updates.
> - * @log_buf_addr: Log buffer address for MIC.
> - * @log_buf_len: Log buffer length address for MIC.
> - * @state_sysfs: Sysfs dirent for notifying ring 3 about MIC state chang=
es.
> - * @hw_ops: the hardware bus ops for this device.
> - * @dev: underlying device.
> - * @index: unique position on the cosm bus
> - * @dbg_dir: debug fs directory
> - * @newepd: new endpoint from scif accept to be assigned to this cdev
> - * @epd: SCIF endpoint for this cdev
> - * @heartbeat_watchdog_enable: if heartbeat watchdog is enabled for this
> cdev
> - * @sysfs_heartbeat_enable: sysfs setting for disabling heartbeat
> notification
> - */
> -struct cosm_device {
> -	const struct attribute_group **attr_group;
> -	struct device *sdev;
> -	u8 state;
> -	u8 prev_state;
> -	u8 shutdown_status;
> -	u8 shutdown_status_int;
> -	struct mutex cosm_mutex;
> -	struct work_struct reset_trigger_work;
> -	struct work_struct scif_work;
> -	char *cmdline;
> -	char *firmware;
> -	char *ramdisk;
> -	char *bootmode;
> -	void *log_buf_addr;
> -	int *log_buf_len;
> -	struct kernfs_node *state_sysfs;
> -	struct cosm_hw_ops *hw_ops;
> -	struct device dev;
> -	int index;
> -	struct dentry *dbg_dir;
> -	scif_epd_t newepd;
> -	scif_epd_t epd;
> -	bool heartbeat_watchdog_enable;
> -	bool sysfs_heartbeat_enable;
> -};
> -
> -/**
> - * cosm_driver - operations for a cosm driver
> - *
> - * @driver: underlying device driver (populate name and owner).
> - * @probe: the function to call when a device is found.  Returns 0 or -e=
rrno.
> - * @remove: the function to call when a device is removed.
> - */
> -struct cosm_driver {
> -	struct device_driver driver;
> -	int (*probe)(struct cosm_device *dev);
> -	void (*remove)(struct cosm_device *dev);
> -};
> -
> -/**
> - * cosm_hw_ops - cosm bus ops
> - *
> - * @reset: trigger MIC reset
> - * @force_reset: force MIC reset
> - * @post_reset: inform MIC reset is complete
> - * @ready: is MIC ready for OS download
> - * @start: boot MIC
> - * @stop: prepare MIC for reset
> - * @family: return MIC HW family string
> - * @stepping: return MIC HW stepping string
> - * @aper: return MIC PCIe aperture
> - */
> -struct cosm_hw_ops {
> -	void (*reset)(struct cosm_device *cdev);
> -	void (*force_reset)(struct cosm_device *cdev);
> -	void (*post_reset)(struct cosm_device *cdev, enum mic_states state);
> -	bool (*ready)(struct cosm_device *cdev);
> -	int (*start)(struct cosm_device *cdev, int id);
> -	void (*stop)(struct cosm_device *cdev, bool force);
> -	ssize_t (*family)(struct cosm_device *cdev, char *buf);
> -	ssize_t (*stepping)(struct cosm_device *cdev, char *buf);
> -	struct mic_mw *(*aper)(struct cosm_device *cdev);
> -};
> -
> -struct cosm_device *
> -cosm_register_device(struct device *pdev, struct cosm_hw_ops *hw_ops);
> -void cosm_unregister_device(struct cosm_device *dev);
> -int cosm_register_driver(struct cosm_driver *drv);
> -void cosm_unregister_driver(struct cosm_driver *drv);
> -struct cosm_device *cosm_find_cdev_by_id(int id);
> -
> -static inline struct cosm_device *dev_to_cosm(struct device *dev)
> -{
> -	return container_of(dev, struct cosm_device, dev);
> -}
> -
> -static inline struct cosm_driver *drv_to_cosm(struct device_driver *drv)
> -{
> -	return container_of(drv, struct cosm_driver, driver);
> -}
> -#endif /* _COSM_BUS_H */
> diff --git a/drivers/misc/mic/bus/mic_bus.c
> b/drivers/misc/mic/bus/mic_bus.c
> deleted file mode 100644
> index a08cb29692a8..000000000000
> --- a/drivers/misc/mic/bus/mic_bus.c
> +++ /dev/null
> @@ -1,194 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel MIC Bus driver.
> - *
> - * This implementation is very similar to the the virtio bus driver
> - * implementation @ drivers/virtio/virtio.c
> - */
> -#include <linux/dma-map-ops.h>
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/idr.h>
> -#include <linux/mic_bus.h>
> -
> -static ssize_t device_show(struct device *d,
> -			   struct device_attribute *attr, char *buf)
> -{
> -	struct mbus_device *dev =3D dev_to_mbus(d);
> -	return sprintf(buf, "0x%04x\n", dev->id.device);
> -}
> -static DEVICE_ATTR_RO(device);
> -
> -static ssize_t vendor_show(struct device *d,
> -			   struct device_attribute *attr, char *buf)
> -{
> -	struct mbus_device *dev =3D dev_to_mbus(d);
> -	return sprintf(buf, "0x%04x\n", dev->id.vendor);
> -}
> -static DEVICE_ATTR_RO(vendor);
> -
> -static ssize_t modalias_show(struct device *d,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct mbus_device *dev =3D dev_to_mbus(d);
> -	return sprintf(buf, "mbus:d%08Xv%08X\n",
> -		       dev->id.device, dev->id.vendor);
> -}
> -static DEVICE_ATTR_RO(modalias);
> -
> -static struct attribute *mbus_dev_attrs[] =3D {
> -	&dev_attr_device.attr,
> -	&dev_attr_vendor.attr,
> -	&dev_attr_modalias.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(mbus_dev);
> -
> -static inline int mbus_id_match(const struct mbus_device *dev,
> -				const struct mbus_device_id *id)
> -{
> -	if (id->device !=3D dev->id.device && id->device !=3D MBUS_DEV_ANY_ID)
> -		return 0;
> -
> -	return id->vendor =3D=3D MBUS_DEV_ANY_ID || id->vendor =3D=3D dev-
> >id.vendor;
> -}
> -
> -/*
> - * This looks through all the IDs a driver claims to support.  If any of=
 them
> - * match, we return 1 and the kernel will call mbus_dev_probe().
> - */
> -static int mbus_dev_match(struct device *dv, struct device_driver *dr)
> -{
> -	unsigned int i;
> -	struct mbus_device *dev =3D dev_to_mbus(dv);
> -	const struct mbus_device_id *ids;
> -
> -	ids =3D drv_to_mbus(dr)->id_table;
> -	for (i =3D 0; ids[i].device; i++)
> -		if (mbus_id_match(dev, &ids[i]))
> -			return 1;
> -	return 0;
> -}
> -
> -static int mbus_uevent(struct device *dv, struct kobj_uevent_env *env)
> -{
> -	struct mbus_device *dev =3D dev_to_mbus(dv);
> -
> -	return add_uevent_var(env, "MODALIAS=3Dmbus:d%08Xv%08X",
> -			      dev->id.device, dev->id.vendor);
> -}
> -
> -static int mbus_dev_probe(struct device *d)
> -{
> -	int err;
> -	struct mbus_device *dev =3D dev_to_mbus(d);
> -	struct mbus_driver *drv =3D drv_to_mbus(dev->dev.driver);
> -
> -	err =3D drv->probe(dev);
> -	if (!err)
> -		if (drv->scan)
> -			drv->scan(dev);
> -	return err;
> -}
> -
> -static int mbus_dev_remove(struct device *d)
> -{
> -	struct mbus_device *dev =3D dev_to_mbus(d);
> -	struct mbus_driver *drv =3D drv_to_mbus(dev->dev.driver);
> -
> -	drv->remove(dev);
> -	return 0;
> -}
> -
> -static struct bus_type mic_bus =3D {
> -	.name  =3D "mic_bus",
> -	.match =3D mbus_dev_match,
> -	.dev_groups =3D mbus_dev_groups,
> -	.uevent =3D mbus_uevent,
> -	.probe =3D mbus_dev_probe,
> -	.remove =3D mbus_dev_remove,
> -};
> -
> -int mbus_register_driver(struct mbus_driver *driver)
> -{
> -	driver->driver.bus =3D &mic_bus;
> -	return driver_register(&driver->driver);
> -}
> -EXPORT_SYMBOL_GPL(mbus_register_driver);
> -
> -void mbus_unregister_driver(struct mbus_driver *driver)
> -{
> -	driver_unregister(&driver->driver);
> -}
> -EXPORT_SYMBOL_GPL(mbus_unregister_driver);
> -
> -static void mbus_release_dev(struct device *d)
> -{
> -	struct mbus_device *mbdev =3D dev_to_mbus(d);
> -	kfree(mbdev);
> -}
> -
> -struct mbus_device *
> -mbus_register_device(struct device *pdev, int id, const struct
> dma_map_ops *dma_ops,
> -		     struct mbus_hw_ops *hw_ops, int index,
> -		     void __iomem *mmio_va)
> -{
> -	int ret;
> -	struct mbus_device *mbdev;
> -
> -	mbdev =3D kzalloc(sizeof(*mbdev), GFP_KERNEL);
> -	if (!mbdev)
> -		return ERR_PTR(-ENOMEM);
> -
> -	mbdev->mmio_va =3D mmio_va;
> -	mbdev->dev.parent =3D pdev;
> -	mbdev->id.device =3D id;
> -	mbdev->id.vendor =3D MBUS_DEV_ANY_ID;
> -	mbdev->dev.dma_ops =3D dma_ops;
> -	mbdev->dev.dma_mask =3D &mbdev->dev.coherent_dma_mask;
> -	dma_set_mask(&mbdev->dev, DMA_BIT_MASK(64));
> -	mbdev->dev.release =3D mbus_release_dev;
> -	mbdev->hw_ops =3D hw_ops;
> -	mbdev->dev.bus =3D &mic_bus;
> -	mbdev->index =3D index;
> -	dev_set_name(&mbdev->dev, "mbus-dev%u", mbdev->index);
> -	/*
> -	 * device_register() causes the bus infrastructure to look for a
> -	 * matching driver.
> -	 */
> -	ret =3D device_register(&mbdev->dev);
> -	if (ret)
> -		goto free_mbdev;
> -	return mbdev;
> -free_mbdev:
> -	put_device(&mbdev->dev);
> -	return ERR_PTR(ret);
> -}
> -EXPORT_SYMBOL_GPL(mbus_register_device);
> -
> -void mbus_unregister_device(struct mbus_device *mbdev)
> -{
> -	device_unregister(&mbdev->dev);
> -}
> -EXPORT_SYMBOL_GPL(mbus_unregister_device);
> -
> -static int __init mbus_init(void)
> -{
> -	return bus_register(&mic_bus);
> -}
> -
> -static void __exit mbus_exit(void)
> -{
> -	bus_unregister(&mic_bus);
> -}
> -
> -core_initcall(mbus_init);
> -module_exit(mbus_exit);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) MIC Bus driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/bus/scif_bus.c
> b/drivers/misc/mic/bus/scif_bus.c
> deleted file mode 100644
> index ad7c3604f151..000000000000
> --- a/drivers/misc/mic/bus/scif_bus.c
> +++ /dev/null
> @@ -1,201 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel Symmetric Communications Interface Bus driver.
> - */
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/idr.h>
> -#include <linux/dma-map-ops.h>
> -
> -#include "scif_bus.h"
> -
> -static ssize_t device_show(struct device *d,
> -			   struct device_attribute *attr, char *buf)
> -{
> -	struct scif_hw_dev *dev =3D dev_to_scif(d);
> -
> -	return sprintf(buf, "0x%04x\n", dev->id.device);
> -}
> -static DEVICE_ATTR_RO(device);
> -
> -static ssize_t vendor_show(struct device *d,
> -			   struct device_attribute *attr, char *buf)
> -{
> -	struct scif_hw_dev *dev =3D dev_to_scif(d);
> -
> -	return sprintf(buf, "0x%04x\n", dev->id.vendor);
> -}
> -static DEVICE_ATTR_RO(vendor);
> -
> -static ssize_t modalias_show(struct device *d,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct scif_hw_dev *dev =3D dev_to_scif(d);
> -
> -	return sprintf(buf, "scif:d%08Xv%08X\n",
> -		       dev->id.device, dev->id.vendor);
> -}
> -static DEVICE_ATTR_RO(modalias);
> -
> -static struct attribute *scif_dev_attrs[] =3D {
> -	&dev_attr_device.attr,
> -	&dev_attr_vendor.attr,
> -	&dev_attr_modalias.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(scif_dev);
> -
> -static inline int scif_id_match(const struct scif_hw_dev *dev,
> -				const struct scif_hw_dev_id *id)
> -{
> -	if (id->device !=3D dev->id.device && id->device !=3D SCIF_DEV_ANY_ID)
> -		return 0;
> -
> -	return id->vendor =3D=3D SCIF_DEV_ANY_ID || id->vendor =3D=3D dev-
> >id.vendor;
> -}
> -
> -/*
> - * This looks through all the IDs a driver claims to support.  If any of=
 them
> - * match, we return 1 and the kernel will call scif_dev_probe().
> - */
> -static int scif_dev_match(struct device *dv, struct device_driver *dr)
> -{
> -	unsigned int i;
> -	struct scif_hw_dev *dev =3D dev_to_scif(dv);
> -	const struct scif_hw_dev_id *ids;
> -
> -	ids =3D drv_to_scif(dr)->id_table;
> -	for (i =3D 0; ids[i].device; i++)
> -		if (scif_id_match(dev, &ids[i]))
> -			return 1;
> -	return 0;
> -}
> -
> -static int scif_uevent(struct device *dv, struct kobj_uevent_env *env)
> -{
> -	struct scif_hw_dev *dev =3D dev_to_scif(dv);
> -
> -	return add_uevent_var(env, "MODALIAS=3Dscif:d%08Xv%08X",
> -			      dev->id.device, dev->id.vendor);
> -}
> -
> -static int scif_dev_probe(struct device *d)
> -{
> -	struct scif_hw_dev *dev =3D dev_to_scif(d);
> -	struct scif_driver *drv =3D drv_to_scif(dev->dev.driver);
> -
> -	return drv->probe(dev);
> -}
> -
> -static int scif_dev_remove(struct device *d)
> -{
> -	struct scif_hw_dev *dev =3D dev_to_scif(d);
> -	struct scif_driver *drv =3D drv_to_scif(dev->dev.driver);
> -
> -	drv->remove(dev);
> -	return 0;
> -}
> -
> -static struct bus_type scif_bus =3D {
> -	.name  =3D "scif_bus",
> -	.match =3D scif_dev_match,
> -	.dev_groups =3D scif_dev_groups,
> -	.uevent =3D scif_uevent,
> -	.probe =3D scif_dev_probe,
> -	.remove =3D scif_dev_remove,
> -};
> -
> -int scif_register_driver(struct scif_driver *driver)
> -{
> -	driver->driver.bus =3D &scif_bus;
> -	return driver_register(&driver->driver);
> -}
> -EXPORT_SYMBOL_GPL(scif_register_driver);
> -
> -void scif_unregister_driver(struct scif_driver *driver)
> -{
> -	driver_unregister(&driver->driver);
> -}
> -EXPORT_SYMBOL_GPL(scif_unregister_driver);
> -
> -static void scif_release_dev(struct device *d)
> -{
> -	struct scif_hw_dev *sdev =3D dev_to_scif(d);
> -
> -	kfree(sdev);
> -}
> -
> -struct scif_hw_dev *
> -scif_register_device(struct device *pdev, int id, const struct dma_map_o=
ps
> *dma_ops,
> -		     struct scif_hw_ops *hw_ops, u8 dnode, u8 snode,
> -		     struct mic_mw *mmio, struct mic_mw *aper, void *dp,
> -		     void __iomem *rdp, struct dma_chan **chan, int
> num_chan,
> -		     bool card_rel_da)
> -{
> -	int ret;
> -	struct scif_hw_dev *sdev;
> -
> -	sdev =3D kzalloc(sizeof(*sdev), GFP_KERNEL);
> -	if (!sdev)
> -		return ERR_PTR(-ENOMEM);
> -
> -	sdev->dev.parent =3D pdev;
> -	sdev->id.device =3D id;
> -	sdev->id.vendor =3D SCIF_DEV_ANY_ID;
> -	sdev->dev.dma_ops =3D dma_ops;
> -	sdev->dev.release =3D scif_release_dev;
> -	sdev->hw_ops =3D hw_ops;
> -	sdev->dnode =3D dnode;
> -	sdev->snode =3D snode;
> -	dev_set_drvdata(&sdev->dev, sdev);
> -	sdev->dev.bus =3D &scif_bus;
> -	sdev->mmio =3D mmio;
> -	sdev->aper =3D aper;
> -	sdev->dp =3D dp;
> -	sdev->rdp =3D rdp;
> -	sdev->dev.dma_mask =3D &sdev->dev.coherent_dma_mask;
> -	dma_set_mask(&sdev->dev, DMA_BIT_MASK(64));
> -	sdev->dma_ch =3D chan;
> -	sdev->num_dma_ch =3D num_chan;
> -	sdev->card_rel_da =3D card_rel_da;
> -	dev_set_name(&sdev->dev, "scif-dev%u", sdev->dnode);
> -	/*
> -	 * device_register() causes the bus infrastructure to look for a
> -	 * matching driver.
> -	 */
> -	ret =3D device_register(&sdev->dev);
> -	if (ret)
> -		goto free_sdev;
> -	return sdev;
> -free_sdev:
> -	put_device(&sdev->dev);
> -	return ERR_PTR(ret);
> -}
> -EXPORT_SYMBOL_GPL(scif_register_device);
> -
> -void scif_unregister_device(struct scif_hw_dev *sdev)
> -{
> -	device_unregister(&sdev->dev);
> -}
> -EXPORT_SYMBOL_GPL(scif_unregister_device);
> -
> -static int __init scif_init(void)
> -{
> -	return bus_register(&scif_bus);
> -}
> -
> -static void __exit scif_exit(void)
> -{
> -	bus_unregister(&scif_bus);
> -}
> -
> -core_initcall(scif_init);
> -module_exit(scif_exit);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) SCIF Bus driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/bus/scif_bus.h
> b/drivers/misc/mic/bus/scif_bus.h
> deleted file mode 100644
> index 4981eb56f879..000000000000
> --- a/drivers/misc/mic/bus/scif_bus.h
> +++ /dev/null
> @@ -1,125 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel Symmetric Communications Interface Bus driver.
> - */
> -#ifndef _SCIF_BUS_H_
> -#define _SCIF_BUS_H_
> -/*
> - * Everything a scif driver needs to work with any particular scif
> - * hardware abstraction layer.
> - */
> -#include <linux/dma-map-ops.h>
> -
> -#include <linux/mic_common.h>
> -#include "../common/mic_dev.h"
> -
> -struct scif_hw_dev_id {
> -	u32 device;
> -	u32 vendor;
> -};
> -
> -#define MIC_SCIF_DEV 1
> -#define SCIF_DEV_ANY_ID 0xffffffff
> -
> -/**
> - * scif_hw_dev - representation of a hardware device abstracted for scif
> - * @hw_ops: the hardware ops supported by this device
> - * @id: the device type identification (used to match it with a driver)
> - * @mmio: MMIO memory window
> - * @aper: Aperture memory window
> - * @dev: underlying device
> - * @dnode - The destination node which this device will communicate with=
.
> - * @snode - The source node for this device.
> - * @dp - Self device page
> - * @rdp - Remote device page
> - * @dma_ch - Array of DMA channels
> - * @num_dma_ch - Number of DMA channels available
> - * @card_rel_da - Set to true if DMA addresses programmed in the DMA
> engine
> - *		are relative to the card point of view
> - */
> -struct scif_hw_dev {
> -	struct scif_hw_ops *hw_ops;
> -	struct scif_hw_dev_id id;
> -	struct mic_mw *mmio;
> -	struct mic_mw *aper;
> -	struct device dev;
> -	u8 dnode;
> -	u8 snode;
> -	void *dp;
> -	void __iomem *rdp;
> -	struct dma_chan **dma_ch;
> -	int num_dma_ch;
> -	bool card_rel_da;
> -};
> -
> -/**
> - * scif_driver - operations for a scif I/O driver
> - * @driver: underlying device driver (populate name and owner).
> - * @id_table: the ids serviced by this driver.
> - * @probe: the function to call when a device is found.  Returns 0 or -e=
rrno.
> - * @remove: the function to call when a device is removed.
> - */
> -struct scif_driver {
> -	struct device_driver driver;
> -	const struct scif_hw_dev_id *id_table;
> -	int (*probe)(struct scif_hw_dev *dev);
> -	void (*remove)(struct scif_hw_dev *dev);
> -};
> -
> -/**
> - * scif_hw_ops - Hardware operations for accessing a SCIF device on the =
SCIF
> bus.
> - *
> - * @next_db: Obtain the next available doorbell.
> - * @request_irq: Request an interrupt on a particular doorbell.
> - * @free_irq: Free an interrupt requested previously.
> - * @ack_interrupt: acknowledge an interrupt in the ISR.
> - * @send_intr: Send an interrupt to the remote node on a specified doorb=
ell.
> - * @send_p2p_intr: Send an interrupt to the peer node on a specified
> doorbell
> - * which is specifically targeted for a peer to peer node.
> - * @remap: Map a buffer with the specified physical address and length.
> - * @unmap: Unmap a buffer previously mapped.
> - */
> -struct scif_hw_ops {
> -	int (*next_db)(struct scif_hw_dev *sdev);
> -	struct mic_irq * (*request_irq)(struct scif_hw_dev *sdev,
> -					irqreturn_t (*func)(int irq,
> -							    void *data),
> -					const char *name, void *data,
> -					int db);
> -	void (*free_irq)(struct scif_hw_dev *sdev,
> -			 struct mic_irq *cookie, void *data);
> -	void (*ack_interrupt)(struct scif_hw_dev *sdev, int num);
> -	void (*send_intr)(struct scif_hw_dev *sdev, int db);
> -	void (*send_p2p_intr)(struct scif_hw_dev *sdev, int db,
> -			      struct mic_mw *mw);
> -	void __iomem * (*remap)(struct scif_hw_dev *sdev,
> -				  phys_addr_t pa, size_t len);
> -	void (*unmap)(struct scif_hw_dev *sdev, void __iomem *va);
> -};
> -
> -int scif_register_driver(struct scif_driver *driver);
> -void scif_unregister_driver(struct scif_driver *driver);
> -struct scif_hw_dev *
> -scif_register_device(struct device *pdev, int id,
> -		     const struct dma_map_ops *dma_ops,
> -		     struct scif_hw_ops *hw_ops, u8 dnode, u8 snode,
> -		     struct mic_mw *mmio, struct mic_mw *aper,
> -		     void *dp, void __iomem *rdp,
> -		     struct dma_chan **chan, int num_chan,
> -		     bool card_rel_da);
> -void scif_unregister_device(struct scif_hw_dev *sdev);
> -
> -static inline struct scif_hw_dev *dev_to_scif(struct device *dev)
> -{
> -	return container_of(dev, struct scif_hw_dev, dev);
> -}
> -
> -static inline struct scif_driver *drv_to_scif(struct device_driver *drv)
> -{
> -	return container_of(drv, struct scif_driver, driver);
> -}
> -#endif /* _SCIF_BUS_H */
> diff --git a/drivers/misc/mic/bus/vop_bus.c
> b/drivers/misc/mic/bus/vop_bus.c
> deleted file mode 100644
> index 6935ddca1bd5..000000000000
> --- a/drivers/misc/mic/bus/vop_bus.c
> +++ /dev/null
> @@ -1,194 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2016 Intel Corporation.
> - *
> - * Intel Virtio Over PCIe (VOP) Bus driver.
> - */
> -#include <linux/slab.h>
> -#include <linux/module.h>
> -#include <linux/idr.h>
> -#include <linux/dma-map-ops.h>
> -
> -#include "vop_bus.h"
> -
> -static ssize_t device_show(struct device *d,
> -			   struct device_attribute *attr, char *buf)
> -{
> -	struct vop_device *dev =3D dev_to_vop(d);
> -
> -	return sprintf(buf, "0x%04x\n", dev->id.device);
> -}
> -static DEVICE_ATTR_RO(device);
> -
> -static ssize_t vendor_show(struct device *d,
> -			   struct device_attribute *attr, char *buf)
> -{
> -	struct vop_device *dev =3D dev_to_vop(d);
> -
> -	return sprintf(buf, "0x%04x\n", dev->id.vendor);
> -}
> -static DEVICE_ATTR_RO(vendor);
> -
> -static ssize_t modalias_show(struct device *d,
> -			     struct device_attribute *attr, char *buf)
> -{
> -	struct vop_device *dev =3D dev_to_vop(d);
> -
> -	return sprintf(buf, "vop:d%08Xv%08X\n",
> -		       dev->id.device, dev->id.vendor);
> -}
> -static DEVICE_ATTR_RO(modalias);
> -
> -static struct attribute *vop_dev_attrs[] =3D {
> -	&dev_attr_device.attr,
> -	&dev_attr_vendor.attr,
> -	&dev_attr_modalias.attr,
> -	NULL,
> -};
> -ATTRIBUTE_GROUPS(vop_dev);
> -
> -static inline int vop_id_match(const struct vop_device *dev,
> -			       const struct vop_device_id *id)
> -{
> -	if (id->device !=3D dev->id.device && id->device !=3D VOP_DEV_ANY_ID)
> -		return 0;
> -
> -	return id->vendor =3D=3D VOP_DEV_ANY_ID || id->vendor =3D=3D dev-
> >id.vendor;
> -}
> -
> -/*
> - * This looks through all the IDs a driver claims to support.  If any of=
 them
> - * match, we return 1 and the kernel will call vop_dev_probe().
> - */
> -static int vop_dev_match(struct device *dv, struct device_driver *dr)
> -{
> -	unsigned int i;
> -	struct vop_device *dev =3D dev_to_vop(dv);
> -	const struct vop_device_id *ids;
> -
> -	ids =3D drv_to_vop(dr)->id_table;
> -	for (i =3D 0; ids[i].device; i++)
> -		if (vop_id_match(dev, &ids[i]))
> -			return 1;
> -	return 0;
> -}
> -
> -static int vop_uevent(struct device *dv, struct kobj_uevent_env *env)
> -{
> -	struct vop_device *dev =3D dev_to_vop(dv);
> -
> -	return add_uevent_var(env, "MODALIAS=3Dvop:d%08Xv%08X",
> -			      dev->id.device, dev->id.vendor);
> -}
> -
> -static int vop_dev_probe(struct device *d)
> -{
> -	struct vop_device *dev =3D dev_to_vop(d);
> -	struct vop_driver *drv =3D drv_to_vop(dev->dev.driver);
> -
> -	return drv->probe(dev);
> -}
> -
> -static int vop_dev_remove(struct device *d)
> -{
> -	struct vop_device *dev =3D dev_to_vop(d);
> -	struct vop_driver *drv =3D drv_to_vop(dev->dev.driver);
> -
> -	drv->remove(dev);
> -	return 0;
> -}
> -
> -static struct bus_type vop_bus =3D {
> -	.name  =3D "vop_bus",
> -	.match =3D vop_dev_match,
> -	.dev_groups =3D vop_dev_groups,
> -	.uevent =3D vop_uevent,
> -	.probe =3D vop_dev_probe,
> -	.remove =3D vop_dev_remove,
> -};
> -
> -int vop_register_driver(struct vop_driver *driver)
> -{
> -	driver->driver.bus =3D &vop_bus;
> -	return driver_register(&driver->driver);
> -}
> -EXPORT_SYMBOL_GPL(vop_register_driver);
> -
> -void vop_unregister_driver(struct vop_driver *driver)
> -{
> -	driver_unregister(&driver->driver);
> -}
> -EXPORT_SYMBOL_GPL(vop_unregister_driver);
> -
> -static void vop_release_dev(struct device *d)
> -{
> -	struct vop_device *dev =3D dev_to_vop(d);
> -
> -	kfree(dev);
> -}
> -
> -struct vop_device *
> -vop_register_device(struct device *pdev, int id,
> -		    const struct dma_map_ops *dma_ops,
> -		    struct vop_hw_ops *hw_ops, u8 dnode, struct mic_mw
> *aper,
> -		    struct dma_chan *chan)
> -{
> -	int ret;
> -	struct vop_device *vdev;
> -
> -	vdev =3D kzalloc(sizeof(*vdev), GFP_KERNEL);
> -	if (!vdev)
> -		return ERR_PTR(-ENOMEM);
> -
> -	vdev->dev.parent =3D pdev;
> -	vdev->id.device =3D id;
> -	vdev->id.vendor =3D VOP_DEV_ANY_ID;
> -	vdev->dev.dma_ops =3D dma_ops;
> -	vdev->dev.dma_mask =3D &vdev->dev.coherent_dma_mask;
> -	dma_set_mask(&vdev->dev, DMA_BIT_MASK(64));
> -	vdev->dev.release =3D vop_release_dev;
> -	vdev->hw_ops =3D hw_ops;
> -	vdev->dev.bus =3D &vop_bus;
> -	vdev->dnode =3D dnode;
> -	vdev->aper =3D aper;
> -	vdev->dma_ch =3D chan;
> -	vdev->index =3D dnode - 1;
> -	dev_set_name(&vdev->dev, "vop-dev%u", vdev->index);
> -	/*
> -	 * device_register() causes the bus infrastructure to look for a
> -	 * matching driver.
> -	 */
> -	ret =3D device_register(&vdev->dev);
> -	if (ret)
> -		goto free_vdev;
> -	return vdev;
> -free_vdev:
> -	put_device(&vdev->dev);
> -	return ERR_PTR(ret);
> -}
> -EXPORT_SYMBOL_GPL(vop_register_device);
> -
> -void vop_unregister_device(struct vop_device *dev)
> -{
> -	device_unregister(&dev->dev);
> -}
> -EXPORT_SYMBOL_GPL(vop_unregister_device);
> -
> -static int __init vop_init(void)
> -{
> -	return bus_register(&vop_bus);
> -}
> -
> -static void __exit vop_exit(void)
> -{
> -	bus_unregister(&vop_bus);
> -}
> -
> -core_initcall(vop_init);
> -module_exit(vop_exit);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) VOP Bus driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/bus/vop_bus.h
> b/drivers/misc/mic/bus/vop_bus.h
> deleted file mode 100644
> index 4fa02808c1e2..000000000000
> --- a/drivers/misc/mic/bus/vop_bus.h
> +++ /dev/null
> @@ -1,129 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2016 Intel Corporation.
> - *
> - * Intel Virtio over PCIe Bus driver.
> - */
> -#ifndef _VOP_BUS_H_
> -#define _VOP_BUS_H_
> -/*
> - * Everything a vop driver needs to work with any particular vop
> - * implementation.
> - */
> -#include <linux/dmaengine.h>
> -#include <linux/interrupt.h>
> -
> -#include "../common/mic_dev.h"
> -
> -struct vop_device_id {
> -	u32 device;
> -	u32 vendor;
> -};
> -
> -#define VOP_DEV_TRNSP 1
> -#define VOP_DEV_ANY_ID 0xffffffff
> -/*
> - * Size of the internal buffer used during DMA's as an intermediate buff=
er
> - * for copy to/from user. Must be an integral number of pages.
> - */
> -#define VOP_INT_DMA_BUF_SIZE PAGE_ALIGN(64 * 1024ULL)
> -
> -/**
> - * vop_device - representation of a device using vop
> - * @hw_ops: the hardware ops supported by this device.
> - * @id: the device type identification (used to match it with a driver).
> - * @dev: underlying device.
> - * @dnode - The destination node which this device will communicate with=
.
> - * @aper: Aperture memory window
> - * @dma_ch - DMA channel
> - * @index: unique position on the vop bus
> - */
> -struct vop_device {
> -	struct vop_hw_ops *hw_ops;
> -	struct vop_device_id id;
> -	struct device dev;
> -	u8 dnode;
> -	struct mic_mw *aper;
> -	struct dma_chan *dma_ch;
> -	int index;
> -};
> -
> -/**
> - * vop_driver - operations for a vop I/O driver
> - * @driver: underlying device driver (populate name and owner).
> - * @id_table: the ids serviced by this driver.
> - * @probe: the function to call when a device is found.  Returns 0 or -e=
rrno.
> - * @remove: the function to call when a device is removed.
> - */
> -struct vop_driver {
> -	struct device_driver driver;
> -	const struct vop_device_id *id_table;
> -	int (*probe)(struct vop_device *dev);
> -	void (*remove)(struct vop_device *dev);
> -};
> -
> -/**
> - * vop_hw_ops - Hardware operations for accessing a VOP device on the
> VOP bus.
> - *
> - * @next_db: Obtain the next available doorbell.
> - * @request_irq: Request an interrupt on a particular doorbell.
> - * @free_irq: Free an interrupt requested previously.
> - * @ack_interrupt: acknowledge an interrupt in the ISR.
> - * @get_remote_dp: Get access to the virtio device page used by the remo=
te
> - *                 node to add/remove/configure virtio devices.
> - * @get_dp: Get access to the virtio device page used by the self
> - *          node to add/remove/configure virtio devices.
> - * @send_intr: Send an interrupt to the peer node on a specified doorbel=
l.
> - * @remap: Map a buffer with the specified DMA address and length.
> - * @unmap: Unmap a buffer previously mapped.
> - * @dma_filter: The DMA filter function to use for obtaining access to
> - *		a DMA channel on the peer node.
> - */
> -struct vop_hw_ops {
> -	int (*next_db)(struct vop_device *vpdev);
> -	struct mic_irq *(*request_irq)(struct vop_device *vpdev,
> -				       irqreturn_t (*func)(int irq, void *data),
> -				       const char *name, void *data,
> -				       int intr_src);
> -	void (*free_irq)(struct vop_device *vpdev,
> -			 struct mic_irq *cookie, void *data);
> -	void (*ack_interrupt)(struct vop_device *vpdev, int num);
> -	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
> -	void * (*get_dp)(struct vop_device *vpdev);
> -	void (*send_intr)(struct vop_device *vpdev, int db);
> -	void __iomem * (*remap)(struct vop_device *vpdev,
> -				  dma_addr_t pa, size_t len);
> -	void (*unmap)(struct vop_device *vpdev, void __iomem *va);
> -};
> -
> -struct vop_device *
> -vop_register_device(struct device *pdev, int id,
> -		    const struct dma_map_ops *dma_ops,
> -		    struct vop_hw_ops *hw_ops, u8 dnode, struct mic_mw
> *aper,
> -		    struct dma_chan *chan);
> -void vop_unregister_device(struct vop_device *dev);
> -int vop_register_driver(struct vop_driver *drv);
> -void vop_unregister_driver(struct vop_driver *drv);
> -
> -/*
> - * module_vop_driver() - Helper macro for drivers that don't do
> - * anything special in module init/exit.  This eliminates a lot of
> - * boilerplate.  Each module may only use this macro once, and
> - * calling it replaces module_init() and module_exit()
> - */
> -#define module_vop_driver(__vop_driver) \
> -	module_driver(__vop_driver, vop_register_driver, \
> -			vop_unregister_driver)
> -
> -static inline struct vop_device *dev_to_vop(struct device *dev)
> -{
> -	return container_of(dev, struct vop_device, dev);
> -}
> -
> -static inline struct vop_driver *drv_to_vop(struct device_driver *drv)
> -{
> -	return container_of(drv, struct vop_driver, driver);
> -}
> -#endif /* _VOP_BUS_H */
> diff --git a/drivers/misc/mic/card/Makefile b/drivers/misc/mic/card/Makef=
ile
> deleted file mode 100644
> index 921a7e7e0fbd..000000000000
> --- a/drivers/misc/mic/card/Makefile
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile - Intel MIC Linux driver.
> -# Copyright(c) 2013, Intel Corporation.
> -#
> -ccflags-y +=3D -DINTEL_MIC_CARD
> -
> -obj-$(CONFIG_INTEL_MIC_CARD) +=3D mic_card.o
> -mic_card-y +=3D mic_x100.o
> -mic_card-y +=3D mic_device.o
> -mic_card-y +=3D mic_debugfs.o
> diff --git a/drivers/misc/mic/card/mic_debugfs.c
> b/drivers/misc/mic/card/mic_debugfs.c
> deleted file mode 100644
> index 4c326e8f4d99..000000000000
> --- a/drivers/misc/mic/card/mic_debugfs.c
> +++ /dev/null
> @@ -1,85 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Disclaimer: The codes contained in these modules may be specific to
> - * the Intel Software Development Platform codenamed: Knights Ferry, and
> - * the Intel product codenamed: Knights Corner, and are not backward
> - * compatible with other Intel products. Additionally, Intel will NOT
> - * support the codes or instruction set in future products.
> - *
> - * Intel MIC Card driver.
> - */
> -#include <linux/debugfs.h>
> -#include <linux/delay.h>
> -#include <linux/seq_file.h>
> -#include <linux/interrupt.h>
> -#include <linux/device.h>
> -
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -
> -/* Debugfs parent dir */
> -static struct dentry *mic_dbg;
> -
> -/*
> - * mic_intr_show - Send interrupts to host.
> - */
> -static int mic_intr_show(struct seq_file *s, void *unused)
> -{
> -	struct mic_driver *mdrv =3D s->private;
> -	struct mic_device *mdev =3D &mdrv->mdev;
> -
> -	mic_send_intr(mdev, 0);
> -	msleep(1000);
> -	mic_send_intr(mdev, 1);
> -	msleep(1000);
> -	mic_send_intr(mdev, 2);
> -	msleep(1000);
> -	mic_send_intr(mdev, 3);
> -	msleep(1000);
> -
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(mic_intr);
> -
> -/*
> - * mic_create_card_debug_dir - Initialize MIC debugfs entries.
> - */
> -void __init mic_create_card_debug_dir(struct mic_driver *mdrv)
> -{
> -	if (!mic_dbg)
> -		return;
> -
> -	mdrv->dbg_dir =3D debugfs_create_dir(mdrv->name, mic_dbg);
> -
> -	debugfs_create_file("intr_test", 0444, mdrv->dbg_dir, mdrv,
> -			    &mic_intr_fops);
> -}
> -
> -/*
> - * mic_delete_card_debug_dir - Uninitialize MIC debugfs entries.
> - */
> -void mic_delete_card_debug_dir(struct mic_driver *mdrv)
> -{
> -	debugfs_remove_recursive(mdrv->dbg_dir);
> -}
> -
> -/*
> - * mic_init_card_debugfs - Initialize global debugfs entry.
> - */
> -void __init mic_init_card_debugfs(void)
> -{
> -	mic_dbg =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> -}
> -
> -/*
> - * mic_exit_card_debugfs - Uninitialize global debugfs entry
> - */
> -void mic_exit_card_debugfs(void)
> -{
> -	debugfs_remove(mic_dbg);
> -}
> diff --git a/drivers/misc/mic/card/mic_device.c
> b/drivers/misc/mic/card/mic_device.c
> deleted file mode 100644
> index a15606259bdc..000000000000
> --- a/drivers/misc/mic/card/mic_device.c
> +++ /dev/null
> @@ -1,417 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Disclaimer: The codes contained in these modules may be specific to
> - * the Intel Software Development Platform codenamed: Knights Ferry, and
> - * the Intel product codenamed: Knights Corner, and are not backward
> - * compatible with other Intel products. Additionally, Intel will NOT
> - * support the codes or instruction set in future products.
> - *
> - * Intel MIC Card driver.
> - */
> -#include <linux/module.h>
> -#include <linux/pci.h>
> -#include <linux/interrupt.h>
> -#include <linux/reboot.h>
> -#include <linux/dmaengine.h>
> -#include <linux/kmod.h>
> -
> -#include <linux/mic_common.h>
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -
> -static struct mic_driver *g_drv;
> -
> -static int __init mic_dp_init(void)
> -{
> -	struct mic_driver *mdrv =3D g_drv;
> -	struct mic_device *mdev =3D &mdrv->mdev;
> -	struct mic_bootparam __iomem *bootparam;
> -	u64 lo, hi, dp_dma_addr;
> -	u32 magic;
> -
> -	lo =3D mic_read_spad(&mdrv->mdev, MIC_DPLO_SPAD);
> -	hi =3D mic_read_spad(&mdrv->mdev, MIC_DPHI_SPAD);
> -
> -	dp_dma_addr =3D lo | (hi << 32);
> -	mdrv->dp =3D mic_card_map(mdev, dp_dma_addr, MIC_DP_SIZE);
> -	if (!mdrv->dp) {
> -		dev_err(mdrv->dev, "Cannot remap Aperture BAR\n");
> -		return -ENOMEM;
> -	}
> -	bootparam =3D mdrv->dp;
> -	magic =3D ioread32(&bootparam->magic);
> -	if (MIC_MAGIC !=3D magic) {
> -		dev_err(mdrv->dev, "bootparam magic mismatch 0x%x\n",
> magic);
> -		return -EIO;
> -	}
> -	return 0;
> -}
> -
> -/* Uninitialize the device page */
> -static void mic_dp_uninit(void)
> -{
> -	mic_card_unmap(&g_drv->mdev, g_drv->dp);
> -}
> -
> -/**
> - * mic_request_card_irq - request an irq.
> - *
> - * @handler: interrupt handler passed to request_threaded_irq.
> - * @thread_fn: thread fn. passed to request_threaded_irq.
> - * @name: The ASCII name of the callee requesting the irq.
> - * @data: private data that is returned back when calling the
> - * function handler.
> - * @index: The doorbell index of the requester.
> - *
> - * returns: The cookie that is transparent to the caller. Passed
> - * back when calling mic_free_irq. An appropriate error code
> - * is returned on failure. Caller needs to use IS_ERR(return_val)
> - * to check for failure and PTR_ERR(return_val) to obtained the
> - * error code.
> - *
> - */
> -struct mic_irq *
> -mic_request_card_irq(irq_handler_t handler,
> -		     irq_handler_t thread_fn, const char *name,
> -		     void *data, int index)
> -{
> -	int rc =3D 0;
> -	unsigned long cookie;
> -	struct mic_driver *mdrv =3D g_drv;
> -
> -	rc  =3D request_threaded_irq(mic_db_to_irq(mdrv, index), handler,
> -				   thread_fn, 0, name, data);
> -	if (rc) {
> -		dev_err(mdrv->dev, "request_threaded_irq failed rc =3D %d\n",
> rc);
> -		goto err;
> -	}
> -	mdrv->irq_info.irq_usage_count[index]++;
> -	cookie =3D index;
> -	return (struct mic_irq *)cookie;
> -err:
> -	return ERR_PTR(rc);
> -}
> -
> -/**
> - * mic_free_card_irq - free irq.
> - *
> - * @cookie: cookie obtained during a successful call to
> mic_request_threaded_irq
> - * @data: private data specified by the calling function during the
> - * mic_request_threaded_irq
> - *
> - * returns: none.
> - */
> -void mic_free_card_irq(struct mic_irq *cookie, void *data)
> -{
> -	int index;
> -	struct mic_driver *mdrv =3D g_drv;
> -
> -	index =3D (unsigned long)cookie & 0xFFFFU;
> -	free_irq(mic_db_to_irq(mdrv, index), data);
> -	mdrv->irq_info.irq_usage_count[index]--;
> -}
> -
> -/**
> - * mic_next_card_db - Get the doorbell with minimum usage count.
> - *
> - * Returns the irq index.
> - */
> -int mic_next_card_db(void)
> -{
> -	int i;
> -	int index =3D 0;
> -	struct mic_driver *mdrv =3D g_drv;
> -
> -	for (i =3D 0; i < mdrv->intr_info.num_intr; i++) {
> -		if (mdrv->irq_info.irq_usage_count[i] <
> -			mdrv->irq_info.irq_usage_count[index])
> -			index =3D i;
> -	}
> -
> -	return index;
> -}
> -
> -/**
> - * mic_init_irq - Initialize irq information.
> - *
> - * Returns 0 in success. Appropriate error code on failure.
> - */
> -static int mic_init_irq(void)
> -{
> -	struct mic_driver *mdrv =3D g_drv;
> -
> -	mdrv->irq_info.irq_usage_count =3D kzalloc((sizeof(u32) *
> -			mdrv->intr_info.num_intr),
> -			GFP_KERNEL);
> -	if (!mdrv->irq_info.irq_usage_count)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -/**
> - * mic_uninit_irq - Uninitialize irq information.
> - *
> - * None.
> - */
> -static void mic_uninit_irq(void)
> -{
> -	struct mic_driver *mdrv =3D g_drv;
> -
> -	kfree(mdrv->irq_info.irq_usage_count);
> -}
> -
> -static inline struct mic_driver *scdev_to_mdrv(struct scif_hw_dev *scdev=
)
> -{
> -	return dev_get_drvdata(scdev->dev.parent);
> -}
> -
> -static struct mic_irq *
> -___mic_request_irq(struct scif_hw_dev *scdev,
> -		   irqreturn_t (*func)(int irq, void *data),
> -				       const char *name, void *data,
> -				       int db)
> -{
> -	return mic_request_card_irq(func, NULL, name, data, db);
> -}
> -
> -static void
> -___mic_free_irq(struct scif_hw_dev *scdev,
> -		struct mic_irq *cookie, void *data)
> -{
> -	return mic_free_card_irq(cookie, data);
> -}
> -
> -static void ___mic_ack_interrupt(struct scif_hw_dev *scdev, int num)
> -{
> -	struct mic_driver *mdrv =3D scdev_to_mdrv(scdev);
> -
> -	mic_ack_interrupt(&mdrv->mdev);
> -}
> -
> -static int ___mic_next_db(struct scif_hw_dev *scdev)
> -{
> -	return mic_next_card_db();
> -}
> -
> -static void ___mic_send_intr(struct scif_hw_dev *scdev, int db)
> -{
> -	struct mic_driver *mdrv =3D scdev_to_mdrv(scdev);
> -
> -	mic_send_intr(&mdrv->mdev, db);
> -}
> -
> -static void ___mic_send_p2p_intr(struct scif_hw_dev *scdev, int db,
> -				 struct mic_mw *mw)
> -{
> -	mic_send_p2p_intr(db, mw);
> -}
> -
> -static void __iomem *
> -___mic_ioremap(struct scif_hw_dev *scdev,
> -	       phys_addr_t pa, size_t len)
> -{
> -	struct mic_driver *mdrv =3D scdev_to_mdrv(scdev);
> -
> -	return mic_card_map(&mdrv->mdev, pa, len);
> -}
> -
> -static void ___mic_iounmap(struct scif_hw_dev *scdev, void __iomem *va)
> -{
> -	struct mic_driver *mdrv =3D scdev_to_mdrv(scdev);
> -
> -	mic_card_unmap(&mdrv->mdev, va);
> -}
> -
> -static struct scif_hw_ops scif_hw_ops =3D {
> -	.request_irq =3D ___mic_request_irq,
> -	.free_irq =3D ___mic_free_irq,
> -	.ack_interrupt =3D ___mic_ack_interrupt,
> -	.next_db =3D ___mic_next_db,
> -	.send_intr =3D ___mic_send_intr,
> -	.send_p2p_intr =3D ___mic_send_p2p_intr,
> -	.remap =3D ___mic_ioremap,
> -	.unmap =3D ___mic_iounmap,
> -};
> -
> -static inline struct mic_driver *vpdev_to_mdrv(struct vop_device *vpdev)
> -{
> -	return dev_get_drvdata(vpdev->dev.parent);
> -}
> -
> -static struct mic_irq *
> -__mic_request_irq(struct vop_device *vpdev,
> -		  irqreturn_t (*func)(int irq, void *data),
> -		   const char *name, void *data, int intr_src)
> -{
> -	return mic_request_card_irq(func, NULL, name, data, intr_src);
> -}
> -
> -static void __mic_free_irq(struct vop_device *vpdev,
> -			   struct mic_irq *cookie, void *data)
> -{
> -	return mic_free_card_irq(cookie, data);
> -}
> -
> -static void __mic_ack_interrupt(struct vop_device *vpdev, int num)
> -{
> -	struct mic_driver *mdrv =3D vpdev_to_mdrv(vpdev);
> -
> -	mic_ack_interrupt(&mdrv->mdev);
> -}
> -
> -static int __mic_next_db(struct vop_device *vpdev)
> -{
> -	return mic_next_card_db();
> -}
> -
> -static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)
> -{
> -	struct mic_driver *mdrv =3D vpdev_to_mdrv(vpdev);
> -
> -	return mdrv->dp;
> -}
> -
> -static void __mic_send_intr(struct vop_device *vpdev, int db)
> -{
> -	struct mic_driver *mdrv =3D vpdev_to_mdrv(vpdev);
> -
> -	mic_send_intr(&mdrv->mdev, db);
> -}
> -
> -static void __iomem *__mic_ioremap(struct vop_device *vpdev,
> -				   dma_addr_t pa, size_t len)
> -{
> -	struct mic_driver *mdrv =3D vpdev_to_mdrv(vpdev);
> -
> -	return mic_card_map(&mdrv->mdev, pa, len);
> -}
> -
> -static void __mic_iounmap(struct vop_device *vpdev, void __iomem *va)
> -{
> -	struct mic_driver *mdrv =3D vpdev_to_mdrv(vpdev);
> -
> -	mic_card_unmap(&mdrv->mdev, va);
> -}
> -
> -static struct vop_hw_ops vop_hw_ops =3D {
> -	.request_irq =3D __mic_request_irq,
> -	.free_irq =3D __mic_free_irq,
> -	.ack_interrupt =3D __mic_ack_interrupt,
> -	.next_db =3D __mic_next_db,
> -	.get_remote_dp =3D __mic_get_remote_dp,
> -	.send_intr =3D __mic_send_intr,
> -	.remap =3D __mic_ioremap,
> -	.unmap =3D __mic_iounmap,
> -};
> -
> -static int mic_request_dma_chans(struct mic_driver *mdrv)
> -{
> -	dma_cap_mask_t mask;
> -	struct dma_chan *chan;
> -
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_MEMCPY, mask);
> -
> -	do {
> -		chan =3D dma_request_channel(mask, NULL, NULL);
> -		if (chan) {
> -			mdrv->dma_ch[mdrv->num_dma_ch++] =3D chan;
> -			if (mdrv->num_dma_ch >=3D MIC_MAX_DMA_CHAN)
> -				break;
> -		}
> -	} while (chan);
> -	dev_info(mdrv->dev, "DMA channels # %d\n", mdrv->num_dma_ch);
> -	return mdrv->num_dma_ch;
> -}
> -
> -static void mic_free_dma_chans(struct mic_driver *mdrv)
> -{
> -	int i =3D 0;
> -
> -	for (i =3D 0; i < mdrv->num_dma_ch; i++) {
> -		dma_release_channel(mdrv->dma_ch[i]);
> -		mdrv->dma_ch[i] =3D NULL;
> -	}
> -	mdrv->num_dma_ch =3D 0;
> -}
> -
> -/*
> - * mic_driver_init - MIC driver initialization tasks.
> - *
> - * Returns 0 in success. Appropriate error code on failure.
> - */
> -int __init mic_driver_init(struct mic_driver *mdrv)
> -{
> -	int rc;
> -	struct mic_bootparam __iomem *bootparam;
> -	u8 node_id;
> -
> -	g_drv =3D mdrv;
> -	/* Unloading the card module is not supported. */
> -	if (!try_module_get(mdrv->dev->driver->owner)) {
> -		rc =3D -ENODEV;
> -		goto done;
> -	}
> -	rc =3D mic_dp_init();
> -	if (rc)
> -		goto put;
> -	rc =3D mic_init_irq();
> -	if (rc)
> -		goto dp_uninit;
> -	if (!mic_request_dma_chans(mdrv)) {
> -		rc =3D -ENODEV;
> -		goto irq_uninit;
> -	}
> -	mdrv->vpdev =3D vop_register_device(mdrv->dev, VOP_DEV_TRNSP,
> -					  NULL, &vop_hw_ops, 0,
> -					  NULL, mdrv->dma_ch[0]);
> -	if (IS_ERR(mdrv->vpdev)) {
> -		rc =3D PTR_ERR(mdrv->vpdev);
> -		goto dma_free;
> -	}
> -	bootparam =3D mdrv->dp;
> -	node_id =3D ioread8(&bootparam->node_id);
> -	mdrv->scdev =3D scif_register_device(mdrv->dev, MIC_SCIF_DEV,
> -					   NULL, &scif_hw_ops,
> -					   0, node_id, &mdrv->mdev.mmio,
> NULL,
> -					   NULL, mdrv->dp, mdrv->dma_ch,
> -					   mdrv->num_dma_ch, true);
> -	if (IS_ERR(mdrv->scdev)) {
> -		rc =3D PTR_ERR(mdrv->scdev);
> -		goto vop_remove;
> -	}
> -	mic_create_card_debug_dir(mdrv);
> -done:
> -	return rc;
> -vop_remove:
> -	vop_unregister_device(mdrv->vpdev);
> -dma_free:
> -	mic_free_dma_chans(mdrv);
> -irq_uninit:
> -	mic_uninit_irq();
> -dp_uninit:
> -	mic_dp_uninit();
> -put:
> -	module_put(mdrv->dev->driver->owner);
> -	return rc;
> -}
> -
> -/*
> - * mic_driver_uninit - MIC driver uninitialization tasks.
> - *
> - * Returns None
> - */
> -void mic_driver_uninit(struct mic_driver *mdrv)
> -{
> -	mic_delete_card_debug_dir(mdrv);
> -	scif_unregister_device(mdrv->scdev);
> -	vop_unregister_device(mdrv->vpdev);
> -	mic_free_dma_chans(mdrv);
> -	mic_uninit_irq();
> -	mic_dp_uninit();
> -	module_put(mdrv->dev->driver->owner);
> -}
> diff --git a/drivers/misc/mic/card/mic_device.h
> b/drivers/misc/mic/card/mic_device.h
> deleted file mode 100644
> index d6cc69a235a3..000000000000
> --- a/drivers/misc/mic/card/mic_device.h
> +++ /dev/null
> @@ -1,137 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Disclaimer: The codes contained in these modules may be specific to
> - * the Intel Software Development Platform codenamed: Knights Ferry, and
> - * the Intel product codenamed: Knights Corner, and are not backward
> - * compatible with other Intel products. Additionally, Intel will NOT
> - * support the codes or instruction set in future products.
> - *
> - * Intel MIC Card driver.
> - */
> -#ifndef _MIC_CARD_DEVICE_H_
> -#define _MIC_CARD_DEVICE_H_
> -
> -#include <linux/workqueue.h>
> -#include <linux/io.h>
> -#include <linux/interrupt.h>
> -#include <linux/mic_bus.h>
> -#include "../bus/scif_bus.h"
> -#include "../bus/vop_bus.h"
> -
> -/**
> - * struct mic_intr_info - Contains h/w specific interrupt sources info
> - *
> - * @num_intr: The number of irqs available
> - */
> -struct mic_intr_info {
> -	u32 num_intr;
> -};
> -
> -/**
> - * struct mic_irq_info - OS specific irq information
> - *
> - * @irq_usage_count: usage count array tracking the number of sources
> - * assigned for each irq.
> - */
> -struct mic_irq_info {
> -	int *irq_usage_count;
> -};
> -
> -/**
> - * struct mic_device -  MIC device information.
> - *
> - * @mmio: MMIO bar information.
> - */
> -struct mic_device {
> -	struct mic_mw mmio;
> -};
> -
> -/**
> - * struct mic_driver - MIC card driver information.
> - *
> - * @name: Name for MIC driver.
> - * @dbg_dir: debugfs directory of this MIC device.
> - * @dev: The device backing this MIC.
> - * @dp: The pointer to the virtio device page.
> - * @mdev: MIC device information for the host.
> - * @hotplug_work: Hot plug work for adding/removing virtio devices.
> - * @irq_info: The OS specific irq information
> - * @intr_info: H/W specific interrupt information.
> - * @dma_mbdev: dma device on the MIC virtual bus.
> - * @dma_ch - Array of DMA channels
> - * @num_dma_ch - Number of DMA channels available
> - * @scdev: SCIF device on the SCIF virtual bus.
> - * @vpdev: Virtio over PCIe device on the VOP virtual bus.
> - */
> -struct mic_driver {
> -	char name[20];
> -	struct dentry *dbg_dir;
> -	struct device *dev;
> -	void __iomem *dp;
> -	struct mic_device mdev;
> -	struct work_struct hotplug_work;
> -	struct mic_irq_info irq_info;
> -	struct mic_intr_info intr_info;
> -	struct mbus_device *dma_mbdev;
> -	struct dma_chan *dma_ch[MIC_MAX_DMA_CHAN];
> -	int num_dma_ch;
> -	struct scif_hw_dev *scdev;
> -	struct vop_device *vpdev;
> -};
> -
> -/**
> - * struct mic_irq - opaque pointer used as cookie
> - */
> -struct mic_irq;
> -
> -/**
> - * mic_mmio_read - read from an MMIO register.
> - * @mw: MMIO register base virtual address.
> - * @offset: register offset.
> - *
> - * RETURNS: register value.
> - */
> -static inline u32 mic_mmio_read(struct mic_mw *mw, u32 offset)
> -{
> -	return ioread32(mw->va + offset);
> -}
> -
> -/**
> - * mic_mmio_write - write to an MMIO register.
> - * @mw: MMIO register base virtual address.
> - * @val: the data value to put into the register
> - * @offset: register offset.
> - *
> - * RETURNS: none.
> - */
> -static inline void
> -mic_mmio_write(struct mic_mw *mw, u32 val, u32 offset)
> -{
> -	iowrite32(val, mw->va + offset);
> -}
> -
> -int mic_driver_init(struct mic_driver *mdrv);
> -void mic_driver_uninit(struct mic_driver *mdrv);
> -int mic_next_card_db(void);
> -struct mic_irq *
> -mic_request_card_irq(irq_handler_t handler, irq_handler_t thread_fn,
> -		     const char *name, void *data, int db);
> -void mic_free_card_irq(struct mic_irq *cookie, void *data);
> -u32 mic_read_spad(struct mic_device *mdev, unsigned int idx);
> -void mic_send_intr(struct mic_device *mdev, int doorbell);
> -void mic_send_p2p_intr(int doorbell, struct mic_mw *mw);
> -int mic_db_to_irq(struct mic_driver *mdrv, int db);
> -u32 mic_ack_interrupt(struct mic_device *mdev);
> -void mic_hw_intr_init(struct mic_driver *mdrv);
> -void __iomem *
> -mic_card_map(struct mic_device *mdev, dma_addr_t addr, size_t size);
> -void mic_card_unmap(struct mic_device *mdev, void __iomem *addr);
> -void __init mic_create_card_debug_dir(struct mic_driver *mdrv);
> -void mic_delete_card_debug_dir(struct mic_driver *mdrv);
> -void __init mic_init_card_debugfs(void);
> -void mic_exit_card_debugfs(void);
> -#endif
> diff --git a/drivers/misc/mic/card/mic_x100.c
> b/drivers/misc/mic/card/mic_x100.c
> deleted file mode 100644
> index c8bff2916d3d..000000000000
> --- a/drivers/misc/mic/card/mic_x100.c
> +++ /dev/null
> @@ -1,347 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Disclaimer: The codes contained in these modules may be specific to
> - * the Intel Software Development Platform codenamed: Knights Ferry, and
> - * the Intel product codenamed: Knights Corner, and are not backward
> - * compatible with other Intel products. Additionally, Intel will NOT
> - * support the codes or instruction set in future products.
> - *
> - * Intel MIC Card driver.
> - */
> -#include <linux/module.h>
> -#include <linux/pci.h>
> -#include <linux/platform_device.h>
> -
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -#include "mic_x100.h"
> -
> -static const char mic_driver_name[] =3D "mic";
> -
> -static struct mic_driver g_drv;
> -
> -/**
> - * mic_read_spad - read from the scratchpad register
> - * @mdev: pointer to mic_device instance
> - * @idx: index to scratchpad register, 0 based
> - *
> - * This function allows reading of the 32bit scratchpad register.
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -u32 mic_read_spad(struct mic_device *mdev, unsigned int idx)
> -{
> -	return mic_mmio_read(&mdev->mmio,
> -		MIC_X100_SBOX_BASE_ADDRESS +
> -		MIC_X100_SBOX_SPAD0 + idx * 4);
> -}
> -
> -/**
> - * __mic_send_intr - Send interrupt to Host.
> - * @mdev: pointer to mic_device instance
> - * @doorbell: Doorbell number.
> - */
> -void mic_send_intr(struct mic_device *mdev, int doorbell)
> -{
> -	struct mic_mw *mw =3D &mdev->mmio;
> -
> -	if (doorbell > MIC_X100_MAX_DOORBELL_IDX)
> -		return;
> -	/* Ensure that the interrupt is ordered w.r.t previous stores. */
> -	wmb();
> -	mic_mmio_write(mw, MIC_X100_SBOX_SDBIC0_DBREQ_BIT,
> -		       MIC_X100_SBOX_BASE_ADDRESS +
> -		       (MIC_X100_SBOX_SDBIC0 + (4 * doorbell)));
> -}
> -
> -/*
> - * mic_x100_send_sbox_intr - Send an MIC_X100_SBOX interrupt to MIC.
> - */
> -static void mic_x100_send_sbox_intr(struct mic_mw *mw, int doorbell)
> -{
> -	u64 apic_icr_offset =3D MIC_X100_SBOX_APICICR0 + doorbell * 8;
> -	u32 apicicr_low =3D mic_mmio_read(mw,
> MIC_X100_SBOX_BASE_ADDRESS +
> -					apic_icr_offset);
> -
> -	/* for MIC we need to make sure we "hit" the send_icr bit (13) */
> -	apicicr_low =3D (apicicr_low | (1 << 13));
> -	/*
> -	 * Ensure that the interrupt is ordered w.r.t. previous stores
> -	 * to main memory. Fence instructions are not implemented in X100
> -	 * since execution is in order but a compiler barrier is still
> -	 * required.
> -	 */
> -	wmb();
> -	mic_mmio_write(mw, apicicr_low,
> -		       MIC_X100_SBOX_BASE_ADDRESS + apic_icr_offset);
> -}
> -
> -static void mic_x100_send_rdmasr_intr(struct mic_mw *mw, int doorbell)
> -{
> -	int rdmasr_offset =3D MIC_X100_SBOX_RDMASR0 + (doorbell << 2);
> -	/*
> -	 * Ensure that the interrupt is ordered w.r.t. previous stores
> -	 * to main memory. Fence instructions are not implemented in X100
> -	 * since execution is in order but a compiler barrier is still
> -	 * required.
> -	 */
> -	wmb();
> -	mic_mmio_write(mw, 0, MIC_X100_SBOX_BASE_ADDRESS +
> rdmasr_offset);
> -}
> -
> -/**
> - * mic_ack_interrupt - Device specific interrupt handling.
> - * @mdev: pointer to mic_device instance
> - *
> - * Returns: bitmask of doorbell events triggered.
> - */
> -u32 mic_ack_interrupt(struct mic_device *mdev)
> -{
> -	return 0;
> -}
> -
> -static inline int mic_get_sbox_irq(int db)
> -{
> -	return MIC_X100_IRQ_BASE + db;
> -}
> -
> -static inline int mic_get_rdmasr_irq(int index)
> -{
> -	return  MIC_X100_RDMASR_IRQ_BASE + index;
> -}
> -
> -void mic_send_p2p_intr(int db, struct mic_mw *mw)
> -{
> -	int rdmasr_index;
> -
> -	if (db < MIC_X100_NUM_SBOX_IRQ) {
> -		mic_x100_send_sbox_intr(mw, db);
> -	} else {
> -		rdmasr_index =3D db - MIC_X100_NUM_SBOX_IRQ;
> -		mic_x100_send_rdmasr_intr(mw, rdmasr_index);
> -	}
> -}
> -
> -/**
> - * mic_hw_intr_init - Initialize h/w specific interrupt
> - * information.
> - * @mdrv: pointer to mic_driver
> - */
> -void mic_hw_intr_init(struct mic_driver *mdrv)
> -{
> -	mdrv->intr_info.num_intr =3D MIC_X100_NUM_SBOX_IRQ +
> -				MIC_X100_NUM_RDMASR_IRQ;
> -}
> -
> -/**
> - * mic_db_to_irq - Retrieve irq number corresponding to a doorbell.
> - * @mdrv: pointer to mic_driver
> - * @db: The doorbell obtained for which the irq is needed. Doorbell
> - * may correspond to an sbox doorbell or an rdmasr index.
> - *
> - * Returns the irq corresponding to the doorbell.
> - */
> -int mic_db_to_irq(struct mic_driver *mdrv, int db)
> -{
> -	int rdmasr_index;
> -
> -	/*
> -	 * The total number of doorbell interrupts on the card are 16. Indices
> -	 * 0-8 falls in the SBOX category and 8-15 fall in the RDMASR category.
> -	 */
> -	if (db < MIC_X100_NUM_SBOX_IRQ) {
> -		return mic_get_sbox_irq(db);
> -	} else {
> -		rdmasr_index =3D db - MIC_X100_NUM_SBOX_IRQ;
> -		return mic_get_rdmasr_irq(rdmasr_index);
> -	}
> -}
> -
> -/*
> - * mic_card_map - Allocate virtual address for a remote memory region.
> - * @mdev: pointer to mic_device instance.
> - * @addr: Remote DMA address.
> - * @size: Size of the region.
> - *
> - * Returns: Virtual address backing the remote memory region.
> - */
> -void __iomem *
> -mic_card_map(struct mic_device *mdev, dma_addr_t addr, size_t size)
> -{
> -	return ioremap(addr, size);
> -}
> -
> -/*
> - * mic_card_unmap - Unmap the virtual address for a remote memory
> region.
> - * @mdev: pointer to mic_device instance.
> - * @addr: Virtual address for remote memory region.
> - *
> - * Returns: None.
> - */
> -void mic_card_unmap(struct mic_device *mdev, void __iomem *addr)
> -{
> -	iounmap(addr);
> -}
> -
> -static inline struct mic_driver *mbdev_to_mdrv(struct mbus_device *mbdev=
)
> -{
> -	return dev_get_drvdata(mbdev->dev.parent);
> -}
> -
> -static struct mic_irq *
> -_mic_request_threaded_irq(struct mbus_device *mbdev,
> -			  irq_handler_t handler, irq_handler_t thread_fn,
> -			  const char *name, void *data, int intr_src)
> -{
> -	int rc =3D 0;
> -	unsigned int irq =3D intr_src;
> -	unsigned long cookie =3D irq;
> -
> -	rc  =3D request_threaded_irq(irq, handler, thread_fn, 0, name, data);
> -	if (rc) {
> -		dev_err(mbdev_to_mdrv(mbdev)->dev,
> -			"request_threaded_irq failed rc =3D %d\n", rc);
> -		return ERR_PTR(rc);
> -	}
> -	return (struct mic_irq *)cookie;
> -}
> -
> -static void _mic_free_irq(struct mbus_device *mbdev,
> -			  struct mic_irq *cookie, void *data)
> -{
> -	unsigned long irq =3D (unsigned long)cookie;
> -	free_irq(irq, data);
> -}
> -
> -static void _mic_ack_interrupt(struct mbus_device *mbdev, int num)
> -{
> -	mic_ack_interrupt(&mbdev_to_mdrv(mbdev)->mdev);
> -}
> -
> -static struct mbus_hw_ops mbus_hw_ops =3D {
> -	.request_threaded_irq =3D _mic_request_threaded_irq,
> -	.free_irq =3D _mic_free_irq,
> -	.ack_interrupt =3D _mic_ack_interrupt,
> -};
> -
> -static int __init mic_probe(struct platform_device *pdev)
> -{
> -	struct mic_driver *mdrv =3D &g_drv;
> -	struct mic_device *mdev =3D &mdrv->mdev;
> -	int rc =3D 0;
> -
> -	mdrv->dev =3D &pdev->dev;
> -	snprintf(mdrv->name, sizeof(mic_driver_name), mic_driver_name);
> -
> -	/* FIXME: use dma_set_mask_and_coherent() and check result */
> -	dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> -
> -	mdev->mmio.pa =3D MIC_X100_MMIO_BASE;
> -	mdev->mmio.len =3D MIC_X100_MMIO_LEN;
> -	mdev->mmio.va =3D devm_ioremap(&pdev->dev,
> MIC_X100_MMIO_BASE,
> -				     MIC_X100_MMIO_LEN);
> -	if (!mdev->mmio.va) {
> -		dev_err(&pdev->dev, "Cannot remap MMIO BAR\n");
> -		rc =3D -EIO;
> -		goto done;
> -	}
> -	mic_hw_intr_init(mdrv);
> -	platform_set_drvdata(pdev, mdrv);
> -	mdrv->dma_mbdev =3D mbus_register_device(mdrv->dev,
> MBUS_DEV_DMA_MIC,
> -					       NULL, &mbus_hw_ops, 0,
> -					       mdrv->mdev.mmio.va);
> -	if (IS_ERR(mdrv->dma_mbdev)) {
> -		rc =3D PTR_ERR(mdrv->dma_mbdev);
> -		dev_err(&pdev->dev, "mbus_add_device failed rc %d\n", rc);
> -		goto done;
> -	}
> -	rc =3D mic_driver_init(mdrv);
> -	if (rc) {
> -		dev_err(&pdev->dev, "mic_driver_init failed rc %d\n", rc);
> -		goto remove_dma;
> -	}
> -done:
> -	return rc;
> -remove_dma:
> -	mbus_unregister_device(mdrv->dma_mbdev);
> -	return rc;
> -}
> -
> -static int mic_remove(struct platform_device *pdev)
> -{
> -	struct mic_driver *mdrv =3D &g_drv;
> -
> -	mic_driver_uninit(mdrv);
> -	mbus_unregister_device(mdrv->dma_mbdev);
> -	return 0;
> -}
> -
> -static void mic_platform_shutdown(struct platform_device *pdev)
> -{
> -	mic_remove(pdev);
> -}
> -
> -static struct platform_driver __refdata mic_platform_driver =3D {
> -	.probe =3D mic_probe,
> -	.remove =3D mic_remove,
> -	.shutdown =3D mic_platform_shutdown,
> -	.driver         =3D {
> -		.name   =3D mic_driver_name,
> -	},
> -};
> -
> -static struct platform_device *mic_platform_dev;
> -
> -static int __init mic_init(void)
> -{
> -	int ret;
> -	struct cpuinfo_x86 *c =3D &cpu_data(0);
> -
> -	if (!(c->x86 =3D=3D 11 && c->x86_model =3D=3D 1)) {
> -		ret =3D -ENODEV;
> -		pr_err("%s not running on X100 ret %d\n", __func__, ret);
> -		goto done;
> -	}
> -
> -	request_module("mic_x100_dma");
> -	mic_init_card_debugfs();
> -
> -	mic_platform_dev =3D
> platform_device_register_simple(mic_driver_name,
> -							   0, NULL, 0);
> -	ret =3D PTR_ERR_OR_ZERO(mic_platform_dev);
> -	if (ret) {
> -		pr_err("platform_device_register_full ret %d\n", ret);
> -		goto cleanup_debugfs;
> -	}
> -	ret =3D platform_driver_register(&mic_platform_driver);
> -	if (ret) {
> -		pr_err("platform_driver_register ret %d\n", ret);
> -		goto device_unregister;
> -	}
> -	return ret;
> -
> -device_unregister:
> -	platform_device_unregister(mic_platform_dev);
> -cleanup_debugfs:
> -	mic_exit_card_debugfs();
> -done:
> -	return ret;
> -}
> -
> -static void __exit mic_exit(void)
> -{
> -	platform_driver_unregister(&mic_platform_driver);
> -	platform_device_unregister(mic_platform_dev);
> -	mic_exit_card_debugfs();
> -}
> -
> -module_init(mic_init);
> -module_exit(mic_exit);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) MIC X100 Card driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/card/mic_x100.h
> b/drivers/misc/mic/card/mic_x100.h
> deleted file mode 100644
> index 46644dde0c07..000000000000
> --- a/drivers/misc/mic/card/mic_x100.h
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Disclaimer: The codes contained in these modules may be specific to
> - * the Intel Software Development Platform codenamed: Knights Ferry, and
> - * the Intel product codenamed: Knights Corner, and are not backward
> - * compatible with other Intel products. Additionally, Intel will NOT
> - * support the codes or instruction set in future products.
> - *
> - * Intel MIC Card driver.
> - */
> -#ifndef _MIC_X100_CARD_H_
> -#define _MIC_X100_CARD_H_
> -
> -#define MIC_X100_MMIO_BASE 0x08007C0000ULL
> -#define MIC_X100_MMIO_LEN 0x00020000ULL
> -#define MIC_X100_SBOX_BASE_ADDRESS 0x00010000ULL
> -
> -#define MIC_X100_SBOX_SPAD0 0x0000AB20
> -#define MIC_X100_SBOX_SDBIC0 0x0000CC90
> -#define MIC_X100_SBOX_SDBIC0_DBREQ_BIT 0x80000000
> -#define MIC_X100_SBOX_RDMASR0	0x0000B180
> -#define MIC_X100_SBOX_APICICR0 0x0000A9D0
> -
> -#define MIC_X100_MAX_DOORBELL_IDX 8
> -
> -#define MIC_X100_NUM_SBOX_IRQ 8
> -#define MIC_X100_NUM_RDMASR_IRQ 8
> -#define MIC_X100_SBOX_IRQ_BASE 0
> -#define MIC_X100_RDMASR_IRQ_BASE 17
> -
> -#define MIC_X100_IRQ_BASE 26
> -
> -#endif
> diff --git a/drivers/misc/mic/common/mic_dev.h
> b/drivers/misc/mic/common/mic_dev.h
> deleted file mode 100644
> index f94f08df0260..000000000000
> --- a/drivers/misc/mic/common/mic_dev.h
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC driver.
> - */
> -#ifndef __MIC_DEV_H__
> -#define __MIC_DEV_H__
> -
> -/* The maximum number of MIC devices supported in a single host system.
> */
> -#define MIC_MAX_NUM_DEVS 128
> -
> -/**
> - * enum mic_hw_family - The hardware family to which a device belongs.
> - */
> -enum mic_hw_family {
> -	MIC_FAMILY_X100 =3D 0,
> -	MIC_FAMILY_X200,
> -	MIC_FAMILY_UNKNOWN,
> -	MIC_FAMILY_LAST
> -};
> -
> -/**
> - * struct mic_mw - MIC memory window
> - *
> - * @pa: Base physical address.
> - * @va: Base ioremap'd virtual address.
> - * @len: Size of the memory window.
> - */
> -struct mic_mw {
> -	phys_addr_t pa;
> -	void __iomem *va;
> -	resource_size_t len;
> -};
> -
> -/*
> - * Scratch pad register offsets used by the host to communicate
> - * device page DMA address to the card.
> - */
> -#define MIC_DPLO_SPAD 14
> -#define MIC_DPHI_SPAD 15
> -
> -/*
> - * These values are supposed to be in the config_change field of the
> - * device page when the host sends a config change interrupt to the card=
.
> - */
> -#define MIC_VIRTIO_PARAM_DEV_REMOVE 0x1
> -#define MIC_VIRTIO_PARAM_CONFIG_CHANGED 0x2
> -
> -/* Maximum number of DMA channels */
> -#define MIC_MAX_DMA_CHAN 4
> -
> -#endif
> diff --git a/drivers/misc/mic/cosm/Makefile
> b/drivers/misc/mic/cosm/Makefile
> deleted file mode 100644
> index 97d74cb12030..000000000000
> --- a/drivers/misc/mic/cosm/Makefile
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile - Intel MIC Coprocessor State Management (COSM) Driver
> -# Copyright(c) 2015, Intel Corporation.
> -#
> -obj-$(CONFIG_MIC_COSM) +=3D mic_cosm.o
> -
> -mic_cosm-objs :=3D cosm_main.o
> -mic_cosm-objs +=3D cosm_debugfs.o
> -mic_cosm-objs +=3D cosm_sysfs.o
> -mic_cosm-objs +=3D cosm_scif_server.o
> diff --git a/drivers/misc/mic/cosm/cosm_debugfs.c
> b/drivers/misc/mic/cosm/cosm_debugfs.c
> deleted file mode 100644
> index cb55653cf1f9..000000000000
> --- a/drivers/misc/mic/cosm/cosm_debugfs.c
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel MIC Coprocessor State Management (COSM) Driver
> - */
> -
> -#include <linux/debugfs.h>
> -#include <linux/slab.h>
> -#include <linux/io.h>
> -#include "cosm_main.h"
> -
> -/* Debugfs parent dir */
> -static struct dentry *cosm_dbg;
> -
> -/*
> - * log_buf_show - Display MIC kernel log buffer
> - *
> - * log_buf addr/len is read from System.map by user space
> - * and populated in sysfs entries.
> - */
> -static int log_buf_show(struct seq_file *s, void *unused)
> -{
> -	void __iomem *log_buf_va;
> -	int __iomem *log_buf_len_va;
> -	struct cosm_device *cdev =3D s->private;
> -	void *kva;
> -	int size;
> -	u64 aper_offset;
> -
> -	if (!cdev || !cdev->log_buf_addr || !cdev->log_buf_len)
> -		goto done;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	switch (cdev->state) {
> -	case MIC_BOOTING:
> -	case MIC_ONLINE:
> -	case MIC_SHUTTING_DOWN:
> -		break;
> -	default:
> -		goto unlock;
> -	}
> -
> -	/*
> -	 * Card kernel will never be relocated and any kernel text/data
> mapping
> -	 * can be translated to phys address by subtracting
> __START_KERNEL_map.
> -	 */
> -	aper_offset =3D (u64)cdev->log_buf_len - __START_KERNEL_map;
> -	log_buf_len_va =3D cdev->hw_ops->aper(cdev)->va + aper_offset;
> -	aper_offset =3D (u64)cdev->log_buf_addr - __START_KERNEL_map;
> -	log_buf_va =3D cdev->hw_ops->aper(cdev)->va + aper_offset;
> -
> -	size =3D ioread32(log_buf_len_va);
> -	kva =3D kmalloc(size, GFP_KERNEL);
> -	if (!kva)
> -		goto unlock;
> -
> -	memcpy_fromio(kva, log_buf_va, size);
> -	seq_write(s, kva, size);
> -	kfree(kva);
> -unlock:
> -	mutex_unlock(&cdev->cosm_mutex);
> -done:
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(log_buf);
> -
> -/*
> - * force_reset_show - Force MIC reset
> - *
> - * Invokes the force_reset COSM bus op instead of the standard reset
> - * op in case a force reset of the MIC device is required
> - */
> -static int force_reset_show(struct seq_file *s, void *pos)
> -{
> -	struct cosm_device *cdev =3D s->private;
> -
> -	cosm_stop(cdev, true);
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(force_reset);
> -
> -void cosm_create_debug_dir(struct cosm_device *cdev)
> -{
> -	char name[16];
> -
> -	if (!cosm_dbg)
> -		return;
> -
> -	scnprintf(name, sizeof(name), "mic%d", cdev->index);
> -	cdev->dbg_dir =3D debugfs_create_dir(name, cosm_dbg);
> -
> -	debugfs_create_file("log_buf", 0444, cdev->dbg_dir, cdev,
> -			    &log_buf_fops);
> -	debugfs_create_file("force_reset", 0444, cdev->dbg_dir, cdev,
> -			    &force_reset_fops);
> -}
> -
> -void cosm_delete_debug_dir(struct cosm_device *cdev)
> -{
> -	debugfs_remove_recursive(cdev->dbg_dir);
> -}
> -
> -void cosm_init_debugfs(void)
> -{
> -	cosm_dbg =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> -}
> -
> -void cosm_exit_debugfs(void)
> -{
> -	debugfs_remove(cosm_dbg);
> -}
> diff --git a/drivers/misc/mic/cosm/cosm_main.c
> b/drivers/misc/mic/cosm/cosm_main.c
> deleted file mode 100644
> index ebb0eac43754..000000000000
> --- a/drivers/misc/mic/cosm/cosm_main.c
> +++ /dev/null
> @@ -1,382 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel MIC Coprocessor State Management (COSM) Driver
> - */
> -
> -#include <linux/module.h>
> -#include <linux/delay.h>
> -#include <linux/idr.h>
> -#include <linux/slab.h>
> -#include <linux/cred.h>
> -#include "cosm_main.h"
> -
> -static const char cosm_driver_name[] =3D "mic";
> -
> -/* COSM ID allocator */
> -static struct ida g_cosm_ida;
> -/* Class of MIC devices for sysfs accessibility. */
> -static struct class *g_cosm_class;
> -/* Number of MIC devices */
> -static atomic_t g_num_dev;
> -
> -/**
> - * cosm_hw_reset - Issue a HW reset for the MIC device
> - * @cdev: pointer to cosm_device instance
> - * @force: force a MIC to reset even if it is already reset and ready
> - */
> -static void cosm_hw_reset(struct cosm_device *cdev, bool force)
> -{
> -	int i;
> -
> -#define MIC_RESET_TO (45)
> -	if (force && cdev->hw_ops->force_reset)
> -		cdev->hw_ops->force_reset(cdev);
> -	else
> -		cdev->hw_ops->reset(cdev);
> -
> -	for (i =3D 0; i < MIC_RESET_TO; i++) {
> -		if (cdev->hw_ops->ready(cdev)) {
> -			cosm_set_state(cdev, MIC_READY);
> -			return;
> -		}
> -		/*
> -		 * Resets typically take 10s of seconds to complete.
> -		 * Since an MMIO read is required to check if the
> -		 * firmware is ready or not, a 1 second delay works nicely.
> -		 */
> -		msleep(1000);
> -	}
> -	cosm_set_state(cdev, MIC_RESET_FAILED);
> -}
> -
> -/**
> - * cosm_start - Start the MIC
> - * @cdev: pointer to cosm_device instance
> - *
> - * This function prepares an MIC for boot and initiates boot.
> - * RETURNS: An appropriate -ERRNO error value on error, or 0 for success=
.
> - */
> -int cosm_start(struct cosm_device *cdev)
> -{
> -	const struct cred *orig_cred;
> -	struct cred *override_cred;
> -	int rc;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	if (!cdev->bootmode) {
> -		dev_err(&cdev->dev, "%s %d bootmode not set\n",
> -			__func__, __LINE__);
> -		rc =3D -EINVAL;
> -		goto unlock_ret;
> -	}
> -retry:
> -	if (cdev->state !=3D MIC_READY) {
> -		dev_err(&cdev->dev, "%s %d MIC state not READY\n",
> -			__func__, __LINE__);
> -		rc =3D -EINVAL;
> -		goto unlock_ret;
> -	}
> -	if (!cdev->hw_ops->ready(cdev)) {
> -		cosm_hw_reset(cdev, false);
> -		/*
> -		 * The state will either be MIC_READY if the reset succeeded
> -		 * or MIC_RESET_FAILED if the firmware reset failed.
> -		 */
> -		goto retry;
> -	}
> -
> -	/*
> -	 * Set credentials to root to allow non-root user to download
> initramsfs
> -	 * with 600 permissions
> -	 */
> -	override_cred =3D prepare_creds();
> -	if (!override_cred) {
> -		dev_err(&cdev->dev, "%s %d prepare_creds failed\n",
> -			__func__, __LINE__);
> -		rc =3D -ENOMEM;
> -		goto unlock_ret;
> -	}
> -	override_cred->fsuid =3D GLOBAL_ROOT_UID;
> -	orig_cred =3D override_creds(override_cred);
> -
> -	rc =3D cdev->hw_ops->start(cdev, cdev->index);
> -
> -	revert_creds(orig_cred);
> -	put_cred(override_cred);
> -	if (rc)
> -		goto unlock_ret;
> -
> -	/*
> -	 * If linux is being booted, card is treated 'online' only
> -	 * when the scif interface in the card is up. If anything else
> -	 * is booted, we set card to 'online' immediately.
> -	 */
> -	if (!strcmp(cdev->bootmode, "linux"))
> -		cosm_set_state(cdev, MIC_BOOTING);
> -	else
> -		cosm_set_state(cdev, MIC_ONLINE);
> -unlock_ret:
> -	mutex_unlock(&cdev->cosm_mutex);
> -	if (rc)
> -		dev_err(&cdev->dev, "cosm_start failed rc %d\n", rc);
> -	return rc;
> -}
> -
> -/**
> - * cosm_stop - Prepare the MIC for reset and trigger reset
> - * @cdev: pointer to cosm_device instance
> - * @force: force a MIC to reset even if it is already reset and ready.
> - *
> - * RETURNS: None
> - */
> -void cosm_stop(struct cosm_device *cdev, bool force)
> -{
> -	mutex_lock(&cdev->cosm_mutex);
> -	if (cdev->state !=3D MIC_READY || force) {
> -		/*
> -		 * Don't call hw_ops if they have been called previously.
> -		 * stop(..) calls device_unregister and will crash the system if
> -		 * called multiple times.
> -		 */
> -		u8 state =3D cdev->state =3D=3D MIC_RESETTING ?
> -					cdev->prev_state : cdev->state;
> -		bool call_hw_ops =3D state !=3D MIC_RESET_FAILED &&
> -					state !=3D MIC_READY;
> -
> -		if (cdev->state !=3D MIC_RESETTING)
> -			cosm_set_state(cdev, MIC_RESETTING);
> -		cdev->heartbeat_watchdog_enable =3D false;
> -		if (call_hw_ops)
> -			cdev->hw_ops->stop(cdev, force);
> -		cosm_hw_reset(cdev, force);
> -		cosm_set_shutdown_status(cdev, MIC_NOP);
> -		if (call_hw_ops && cdev->hw_ops->post_reset)
> -			cdev->hw_ops->post_reset(cdev, cdev->state);
> -	}
> -	mutex_unlock(&cdev->cosm_mutex);
> -	flush_work(&cdev->scif_work);
> -}
> -
> -/**
> - * cosm_reset_trigger_work - Trigger MIC reset
> - * @work: The work structure
> - *
> - * This work is scheduled whenever the host wants to reset the MIC.
> - */
> -static void cosm_reset_trigger_work(struct work_struct *work)
> -{
> -	struct cosm_device *cdev =3D container_of(work, struct cosm_device,
> -						reset_trigger_work);
> -	cosm_stop(cdev, false);
> -}
> -
> -/**
> - * cosm_reset - Schedule MIC reset
> - * @cdev: pointer to cosm_device instance
> - *
> - * RETURNS: An -EINVAL if the card is already READY or 0 for success.
> - */
> -int cosm_reset(struct cosm_device *cdev)
> -{
> -	int rc =3D 0;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	if (cdev->state !=3D MIC_READY) {
> -		if (cdev->state !=3D MIC_RESETTING) {
> -			cdev->prev_state =3D cdev->state;
> -			cosm_set_state(cdev, MIC_RESETTING);
> -			schedule_work(&cdev->reset_trigger_work);
> -		}
> -	} else {
> -		dev_err(&cdev->dev, "%s %d MIC is READY\n", __func__,
> __LINE__);
> -		rc =3D -EINVAL;
> -	}
> -	mutex_unlock(&cdev->cosm_mutex);
> -	return rc;
> -}
> -
> -/**
> - * cosm_shutdown - Initiate MIC shutdown.
> - * @cdev: pointer to cosm_device instance
> - *
> - * RETURNS: None
> - */
> -int cosm_shutdown(struct cosm_device *cdev)
> -{
> -	struct cosm_msg msg =3D { .id =3D COSM_MSG_SHUTDOWN };
> -	int rc =3D 0;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	if (cdev->state !=3D MIC_ONLINE) {
> -		rc =3D -EINVAL;
> -		dev_err(&cdev->dev, "%s %d skipping shutdown in
> state: %s\n",
> -			__func__, __LINE__, cosm_state_string[cdev->state]);
> -		goto err;
> -	}
> -
> -	if (!cdev->epd) {
> -		rc =3D -ENOTCONN;
> -		dev_err(&cdev->dev, "%s %d scif endpoint not connected
> rc %d\n",
> -			__func__, __LINE__, rc);
> -		goto err;
> -	}
> -
> -	rc =3D scif_send(cdev->epd, &msg, sizeof(msg), SCIF_SEND_BLOCK);
> -	if (rc < 0) {
> -		dev_err(&cdev->dev, "%s %d scif_send failed rc %d\n",
> -			__func__, __LINE__, rc);
> -		goto err;
> -	}
> -	cdev->heartbeat_watchdog_enable =3D false;
> -	cosm_set_state(cdev, MIC_SHUTTING_DOWN);
> -	rc =3D 0;
> -err:
> -	mutex_unlock(&cdev->cosm_mutex);
> -	return rc;
> -}
> -
> -static int cosm_driver_probe(struct cosm_device *cdev)
> -{
> -	int rc;
> -
> -	/* Initialize SCIF server at first probe */
> -	if (atomic_add_return(1, &g_num_dev) =3D=3D 1) {
> -		rc =3D cosm_scif_init();
> -		if (rc)
> -			goto scif_exit;
> -	}
> -	mutex_init(&cdev->cosm_mutex);
> -	INIT_WORK(&cdev->reset_trigger_work, cosm_reset_trigger_work);
> -	INIT_WORK(&cdev->scif_work, cosm_scif_work);
> -	cdev->sysfs_heartbeat_enable =3D true;
> -	cosm_sysfs_init(cdev);
> -	cdev->sdev =3D device_create_with_groups(g_cosm_class, cdev-
> >dev.parent,
> -			       MKDEV(0, cdev->index), cdev, cdev->attr_group,
> -			       "mic%d", cdev->index);
> -	if (IS_ERR(cdev->sdev)) {
> -		rc =3D PTR_ERR(cdev->sdev);
> -		dev_err(&cdev->dev, "device_create_with_groups failed
> rc %d\n",
> -			rc);
> -		goto scif_exit;
> -	}
> -
> -	cdev->state_sysfs =3D sysfs_get_dirent(cdev->sdev->kobj.sd,
> -		"state");
> -	if (!cdev->state_sysfs) {
> -		rc =3D -ENODEV;
> -		dev_err(&cdev->dev, "sysfs_get_dirent failed rc %d\n", rc);
> -		goto destroy_device;
> -	}
> -	cosm_create_debug_dir(cdev);
> -	return 0;
> -destroy_device:
> -	device_destroy(g_cosm_class, MKDEV(0, cdev->index));
> -scif_exit:
> -	if (atomic_dec_and_test(&g_num_dev))
> -		cosm_scif_exit();
> -	return rc;
> -}
> -
> -static void cosm_driver_remove(struct cosm_device *cdev)
> -{
> -	cosm_delete_debug_dir(cdev);
> -	sysfs_put(cdev->state_sysfs);
> -	device_destroy(g_cosm_class, MKDEV(0, cdev->index));
> -	flush_work(&cdev->reset_trigger_work);
> -	cosm_stop(cdev, false);
> -	if (atomic_dec_and_test(&g_num_dev))
> -		cosm_scif_exit();
> -
> -	/* These sysfs entries might have allocated */
> -	kfree(cdev->cmdline);
> -	kfree(cdev->firmware);
> -	kfree(cdev->ramdisk);
> -	kfree(cdev->bootmode);
> -}
> -
> -static int cosm_suspend(struct device *dev)
> -{
> -	struct cosm_device *cdev =3D dev_to_cosm(dev);
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	switch (cdev->state) {
> -	/**
> -	 * Suspend/freeze hooks in userspace have already shutdown the
> card.
> -	 * Card should be 'ready' in most cases. It is however possible that
> -	 * some userspace application initiated a boot. In those cases, we
> -	 * simply reset the card.
> -	 */
> -	case MIC_ONLINE:
> -	case MIC_BOOTING:
> -	case MIC_SHUTTING_DOWN:
> -		mutex_unlock(&cdev->cosm_mutex);
> -		cosm_stop(cdev, false);
> -		break;
> -	default:
> -		mutex_unlock(&cdev->cosm_mutex);
> -		break;
> -	}
> -	return 0;
> -}
> -
> -static const struct dev_pm_ops cosm_pm_ops =3D {
> -	.suspend =3D cosm_suspend,
> -	.freeze =3D cosm_suspend
> -};
> -
> -static struct cosm_driver cosm_driver =3D {
> -	.driver =3D {
> -		.name =3D  KBUILD_MODNAME,
> -		.owner =3D THIS_MODULE,
> -		.pm =3D &cosm_pm_ops,
> -	},
> -	.probe =3D cosm_driver_probe,
> -	.remove =3D cosm_driver_remove
> -};
> -
> -static int __init cosm_init(void)
> -{
> -	int ret;
> -
> -	cosm_init_debugfs();
> -
> -	g_cosm_class =3D class_create(THIS_MODULE, cosm_driver_name);
> -	if (IS_ERR(g_cosm_class)) {
> -		ret =3D PTR_ERR(g_cosm_class);
> -		pr_err("class_create failed ret %d\n", ret);
> -		goto cleanup_debugfs;
> -	}
> -
> -	ida_init(&g_cosm_ida);
> -	ret =3D cosm_register_driver(&cosm_driver);
> -	if (ret) {
> -		pr_err("cosm_register_driver failed ret %d\n", ret);
> -		goto ida_destroy;
> -	}
> -	return 0;
> -ida_destroy:
> -	ida_destroy(&g_cosm_ida);
> -	class_destroy(g_cosm_class);
> -cleanup_debugfs:
> -	cosm_exit_debugfs();
> -	return ret;
> -}
> -
> -static void __exit cosm_exit(void)
> -{
> -	cosm_unregister_driver(&cosm_driver);
> -	ida_destroy(&g_cosm_ida);
> -	class_destroy(g_cosm_class);
> -	cosm_exit_debugfs();
> -}
> -
> -module_init(cosm_init);
> -module_exit(cosm_exit);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) MIC Coprocessor State Management
> (COSM) Driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/cosm/cosm_main.h
> b/drivers/misc/mic/cosm/cosm_main.h
> deleted file mode 100644
> index 5188ad245814..000000000000
> --- a/drivers/misc/mic/cosm/cosm_main.h
> +++ /dev/null
> @@ -1,61 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel MIC Coprocessor State Management (COSM) Driver
> - */
> -#ifndef _COSM_COSM_H_
> -#define _COSM_COSM_H_
> -
> -#include <linux/scif.h>
> -#include "../bus/cosm_bus.h"
> -
> -#define COSM_HEARTBEAT_SEND_SEC 30
> -#define SCIF_COSM_LISTEN_PORT  201
> -
> -/**
> - * enum COSM msg id's
> - * @COSM_MSG_SHUTDOWN: host->card trigger shutdown
> - * @COSM_MSG_SYNC_TIME: host->card send host time to card to sync
> time
> - * @COSM_MSG_HEARTBEAT: card->host heartbeat
> - * @COSM_MSG_SHUTDOWN_STATUS: card->host with shutdown status as
> payload
> - */
> -enum cosm_msg_id {
> -	COSM_MSG_SHUTDOWN,
> -	COSM_MSG_SYNC_TIME,
> -	COSM_MSG_HEARTBEAT,
> -	COSM_MSG_SHUTDOWN_STATUS,
> -};
> -
> -struct cosm_msg {
> -	u64 id;
> -	union {
> -		u64 shutdown_status;
> -		struct {
> -			u64 tv_sec;
> -			u64 tv_nsec;
> -		} timespec;
> -	};
> -};
> -
> -extern const char * const cosm_state_string[];
> -extern const char * const cosm_shutdown_status_string[];
> -
> -void cosm_sysfs_init(struct cosm_device *cdev);
> -int cosm_start(struct cosm_device *cdev);
> -void cosm_stop(struct cosm_device *cdev, bool force);
> -int cosm_reset(struct cosm_device *cdev);
> -int cosm_shutdown(struct cosm_device *cdev);
> -void cosm_set_state(struct cosm_device *cdev, u8 state);
> -void cosm_set_shutdown_status(struct cosm_device *cdev, u8 status);
> -void cosm_init_debugfs(void);
> -void cosm_exit_debugfs(void);
> -void cosm_create_debug_dir(struct cosm_device *cdev);
> -void cosm_delete_debug_dir(struct cosm_device *cdev);
> -int cosm_scif_init(void);
> -void cosm_scif_exit(void);
> -void cosm_scif_work(struct work_struct *work);
> -
> -#endif
> diff --git a/drivers/misc/mic/cosm/cosm_scif_server.c
> b/drivers/misc/mic/cosm/cosm_scif_server.c
> deleted file mode 100644
> index 7baec9fd8756..000000000000
> --- a/drivers/misc/mic/cosm/cosm_scif_server.c
> +++ /dev/null
> @@ -1,399 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel MIC Coprocessor State Management (COSM) Driver
> - */
> -#include <linux/kthread.h>
> -#include <linux/sched/signal.h>
> -
> -#include "cosm_main.h"
> -
> -/*
> - * The COSM driver uses SCIF to communicate between the management
> node and the
> - * MIC cards. SCIF is used to (a) Send a shutdown command to the card (b=
)
> - * receive a shutdown status back from the card upon completion of
> shutdown and
> - * (c) receive periodic heartbeat messages from the card used to deduce =
if
> the
> - * card has crashed.
> - *
> - * A COSM server consisting of a SCIF listening endpoint waits for incom=
ing
> - * connections from the card. Upon acceptance of the connection, a
> separate
> - * work-item is scheduled to handle SCIF message processing for that car=
d.
> The
> - * life-time of this work-item is therefore the time from which the
> connection
> - * from a card is accepted to the time at which the connection is closed=
. A
> new
> - * work-item starts each time the card boots and is alive till the card =
(a)
> - * shuts down (b) is reset (c) crashes (d) cosm_client driver on the car=
d is
> - * unloaded.
> - *
> - * From the point of view of COSM interactions with SCIF during card
> - * shutdown, reset and crash are as follows:
> - *
> - * Card shutdown
> - * -------------
> - * 1. COSM client on the card invokes orderly_poweroff() in response to
> SHUTDOWN
> - *    message from the host.
> - * 2. Card driver shutdown callback invokes scif_unregister_device(..)
> resulting
> - *    in scif_remove(..) getting called on the card
> - * 3. scif_remove -> scif_stop -> scif_handle_remove_node ->
> - *    scif_peer_unregister_device -> device_unregister for the host peer
> device
> - * 4. During device_unregister remove(..) method of cosm_client is invok=
ed
> which
> - *    closes the COSM SCIF endpoint on the card. This results in a
> SCIF_DISCNCT
> - *    message being sent to host SCIF. SCIF_DISCNCT message processing o=
n
> the
> - *    host SCIF sets the host COSM SCIF endpoint state to DISCONNECTED a=
nd
> wakes
> - *    up the host COSM thread blocked in scif_poll(..) resulting in
> - *    scif_poll(..)  returning EPOLLHUP.
> - * 5. On the card, scif_peer_release_dev is next called which results in=
 an
> - *    SCIF_EXIT message being sent to the host and after receiving the
> - *    SCIF_EXIT_ACK from the host the peer device teardown on the card i=
s
> - *    complete.
> - * 6. As part of the SCIF_EXIT message processing on the host, host send=
s a
> - *    SCIF_REMOVE_NODE to itself corresponding to the card being removed=
.
> This
> - *    starts a similar SCIF peer device teardown sequence on the host
> - *    corresponding to the card being shut down.
> - *
> - * Card reset
> - * ----------
> - * The case of interest here is when the card has not been previously sh=
ut
> down
> - * since most of the steps below are skipped in that case:
> -
> - * 1. cosm_stop(..) invokes hw_ops->stop(..) method of the base PCIe dri=
ver
> - *    which unregisters the SCIF HW device resulting in scif_remove(..) =
being
> - *    called on the host.
> - * 2. scif_remove(..) calls scif_disconnect_node(..) which results in a
> - *    SCIF_EXIT message being sent to the card.
> - * 3. The card executes scif_stop() as part of SCIF_EXIT message
> - *    processing. This results in the COSM endpoint on the card being cl=
osed
> and
> - *    the SCIF host peer device on the card getting unregistered similar=
 to
> - *    steps 3, 4 and 5 for the card shutdown case above. scif_poll(..) o=
n the
> - *    host returns EPOLLHUP as a result.
> - * 4. On the host, card peer device unregister and SCIF HW remove(..) al=
so
> - *    subsequently complete.
> - *
> - * Card crash
> - * ----------
> - * If a reset is issued after the card has crashed, there is no SCIF_DIS=
CNT
> - * message from the card which would result in scif_poll(..) returning
> - * EPOLLHUP. In this case when the host SCIF driver sends a
> SCIF_REMOVE_NODE
> - * message to itself resulting in the card SCIF peer device being unregi=
stered,
> - * this results in a scif_peer_release_dev -> scif_cleanup_scifdev->
> - * scif_invalidate_ep call sequence which sets the endpoint state to
> - * DISCONNECTED and results in scif_poll(..) returning EPOLLHUP.
> - */
> -
> -#define COSM_SCIF_BACKLOG 16
> -#define COSM_HEARTBEAT_CHECK_DELTA_SEC 10
> -#define COSM_HEARTBEAT_TIMEOUT_SEC \
> -		(COSM_HEARTBEAT_SEND_SEC +
> COSM_HEARTBEAT_CHECK_DELTA_SEC)
> -#define COSM_HEARTBEAT_TIMEOUT_MSEC
> (COSM_HEARTBEAT_TIMEOUT_SEC * MSEC_PER_SEC)
> -
> -static struct task_struct *server_thread;
> -static scif_epd_t listen_epd;
> -
> -/* Publish MIC card's shutdown status to user space MIC daemon */
> -static void cosm_update_mic_status(struct cosm_device *cdev)
> -{
> -	if (cdev->shutdown_status_int !=3D MIC_NOP) {
> -		cosm_set_shutdown_status(cdev, cdev-
> >shutdown_status_int);
> -		cdev->shutdown_status_int =3D MIC_NOP;
> -	}
> -}
> -
> -/* Store MIC card's shutdown status internally when it is received */
> -static void cosm_shutdown_status_int(struct cosm_device *cdev,
> -				     enum mic_status shutdown_status)
> -{
> -	switch (shutdown_status) {
> -	case MIC_HALTED:
> -	case MIC_POWER_OFF:
> -	case MIC_RESTART:
> -	case MIC_CRASHED:
> -		break;
> -	default:
> -		dev_err(&cdev->dev, "%s %d Unexpected
> shutdown_status %d\n",
> -			__func__, __LINE__, shutdown_status);
> -		return;
> -	};
> -	cdev->shutdown_status_int =3D shutdown_status;
> -	cdev->heartbeat_watchdog_enable =3D false;
> -
> -	if (cdev->state !=3D MIC_SHUTTING_DOWN)
> -		cosm_set_state(cdev, MIC_SHUTTING_DOWN);
> -}
> -
> -/* Non-blocking recv. Read and process all available messages */
> -static void cosm_scif_recv(struct cosm_device *cdev)
> -{
> -	struct cosm_msg msg;
> -	int rc;
> -
> -	while (1) {
> -		rc =3D scif_recv(cdev->epd, &msg, sizeof(msg), 0);
> -		if (!rc) {
> -			break;
> -		} else if (rc < 0) {
> -			dev_dbg(&cdev->dev, "%s: %d rc %d\n",
> -				__func__, __LINE__, rc);
> -			break;
> -		}
> -		dev_dbg(&cdev->dev, "%s: %d rc %d id 0x%llx\n",
> -			__func__, __LINE__, rc, msg.id);
> -
> -		switch (msg.id) {
> -		case COSM_MSG_SHUTDOWN_STATUS:
> -			cosm_shutdown_status_int(cdev,
> msg.shutdown_status);
> -			break;
> -		case COSM_MSG_HEARTBEAT:
> -			/* Nothing to do, heartbeat only unblocks scif_poll */
> -			break;
> -		default:
> -			dev_err(&cdev->dev, "%s: %d unknown
> msg.id %lld\n",
> -				__func__, __LINE__, msg.id);
> -			break;
> -		}
> -	}
> -}
> -
> -/* Publish crashed status for this MIC card */
> -static void cosm_set_crashed(struct cosm_device *cdev)
> -{
> -	dev_err(&cdev->dev, "node alive timeout\n");
> -	cosm_shutdown_status_int(cdev, MIC_CRASHED);
> -	cosm_update_mic_status(cdev);
> -}
> -
> -/* Send host time to the MIC card to sync system time between host and
> MIC */
> -static void cosm_send_time(struct cosm_device *cdev)
> -{
> -	struct cosm_msg msg =3D { .id =3D COSM_MSG_SYNC_TIME };
> -	struct timespec64 ts;
> -	int rc;
> -
> -	ktime_get_real_ts64(&ts);
> -	msg.timespec.tv_sec =3D ts.tv_sec;
> -	msg.timespec.tv_nsec =3D ts.tv_nsec;
> -
> -	rc =3D scif_send(cdev->epd, &msg, sizeof(msg), SCIF_SEND_BLOCK);
> -	if (rc < 0)
> -		dev_err(&cdev->dev, "%s %d scif_send failed rc %d\n",
> -			__func__, __LINE__, rc);
> -}
> -
> -/*
> - * Close this cosm_device's endpoint after its peer endpoint on the card=
 has
> - * been closed. In all cases except MIC card crash EPOLLHUP on the host =
is
> - * triggered by the client's endpoint being closed.
> - */
> -static void cosm_scif_close(struct cosm_device *cdev)
> -{
> -	/*
> -	 * Because SHUTDOWN_STATUS message is sent by the MIC cards in
> the
> -	 * reboot notifier when shutdown is still not complete, we notify
> mpssd
> -	 * to reset the card when SCIF endpoint is closed.
> -	 */
> -	cosm_update_mic_status(cdev);
> -	scif_close(cdev->epd);
> -	cdev->epd =3D NULL;
> -	dev_dbg(&cdev->dev, "%s %d\n", __func__, __LINE__);
> -}
> -
> -/*
> - * Set card state to ONLINE when a new SCIF connection from a MIC card i=
s
> - * received. Normally the state is BOOTING when the connection comes in,
> but can
> - * be ONLINE if cosm_client driver on the card was unloaded and then
> reloaded.
> - */
> -static int cosm_set_online(struct cosm_device *cdev)
> -{
> -	int rc =3D 0;
> -
> -	if (MIC_BOOTING =3D=3D cdev->state || MIC_ONLINE =3D=3D cdev->state) {
> -		cdev->heartbeat_watchdog_enable =3D cdev-
> >sysfs_heartbeat_enable;
> -		cdev->epd =3D cdev->newepd;
> -		if (cdev->state =3D=3D MIC_BOOTING)
> -			cosm_set_state(cdev, MIC_ONLINE);
> -		cosm_send_time(cdev);
> -		dev_dbg(&cdev->dev, "%s %d\n", __func__, __LINE__);
> -	} else {
> -		dev_warn(&cdev->dev, "%s %d not going online in
> state: %s\n",
> -			 __func__, __LINE__, cosm_state_string[cdev->state]);
> -		rc =3D -EINVAL;
> -	}
> -	/* Drop reference acquired by bus_find_device in the server thread
> */
> -	put_device(&cdev->dev);
> -	return rc;
> -}
> -
> -/*
> - * Work function for handling work for a SCIF connection from a particul=
ar
> MIC
> - * card. It first sets the card state to ONLINE and then calls scif_poll=
 to
> - * block on activity such as incoming messages on the SCIF endpoint. Whe=
n
> the
> - * endpoint is closed, the work function exits, completing its life cycl=
e, from
> - * MIC card boot to card shutdown/reset/crash.
> - */
> -void cosm_scif_work(struct work_struct *work)
> -{
> -	struct cosm_device *cdev =3D container_of(work, struct cosm_device,
> -						scif_work);
> -	struct scif_pollepd pollepd;
> -	int rc;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	if (cosm_set_online(cdev))
> -		goto exit;
> -
> -	while (1) {
> -		pollepd.epd =3D cdev->epd;
> -		pollepd.events =3D EPOLLIN;
> -
> -		/* Drop the mutex before blocking in scif_poll(..) */
> -		mutex_unlock(&cdev->cosm_mutex);
> -		/* poll(..) with timeout on our endpoint */
> -		rc =3D scif_poll(&pollepd, 1,
> COSM_HEARTBEAT_TIMEOUT_MSEC);
> -		mutex_lock(&cdev->cosm_mutex);
> -		if (rc < 0) {
> -			dev_err(&cdev->dev, "%s %d scif_poll rc %d\n",
> -				__func__, __LINE__, rc);
> -			continue;
> -		}
> -
> -		/* There is a message from the card */
> -		if (pollepd.revents & EPOLLIN)
> -			cosm_scif_recv(cdev);
> -
> -		/* The peer endpoint is closed or this endpoint disconnected
> */
> -		if (pollepd.revents & EPOLLHUP) {
> -			cosm_scif_close(cdev);
> -			break;
> -		}
> -
> -		/* Did we timeout from poll? */
> -		if (!rc && cdev->heartbeat_watchdog_enable)
> -			cosm_set_crashed(cdev);
> -	}
> -exit:
> -	dev_dbg(&cdev->dev, "%s %d exiting\n", __func__, __LINE__);
> -	mutex_unlock(&cdev->cosm_mutex);
> -}
> -
> -/*
> - * COSM SCIF server thread function. Accepts incoming SCIF connections
> from MIC
> - * cards, finds the correct cosm_device to associate that connection wit=
h and
> - * schedules individual work items for each MIC card.
> - */
> -static int cosm_scif_server(void *unused)
> -{
> -	struct cosm_device *cdev;
> -	scif_epd_t newepd;
> -	struct scif_port_id port_id;
> -	int rc;
> -
> -	allow_signal(SIGKILL);
> -
> -	while (!kthread_should_stop()) {
> -		rc =3D scif_accept(listen_epd, &port_id, &newepd,
> -				 SCIF_ACCEPT_SYNC);
> -		if (rc < 0) {
> -			if (-ERESTARTSYS !=3D rc)
> -				pr_err("%s %d rc %d\n", __func__, __LINE__,
> rc);
> -			continue;
> -		}
> -
> -		/*
> -		 * Associate the incoming connection with a particular
> -		 * cosm_device, COSM device ID =3D=3D SCIF node ID - 1
> -		 */
> -		cdev =3D cosm_find_cdev_by_id(port_id.node - 1);
> -		if (!cdev)
> -			continue;
> -		cdev->newepd =3D newepd;
> -		schedule_work(&cdev->scif_work);
> -	}
> -
> -	pr_debug("%s %d Server thread stopped\n", __func__, __LINE__);
> -	return 0;
> -}
> -
> -static int cosm_scif_listen(void)
> -{
> -	int rc;
> -
> -	listen_epd =3D scif_open();
> -	if (!listen_epd) {
> -		pr_err("%s %d scif_open failed\n", __func__, __LINE__);
> -		return -ENOMEM;
> -	}
> -
> -	rc =3D scif_bind(listen_epd, SCIF_COSM_LISTEN_PORT);
> -	if (rc < 0) {
> -		pr_err("%s %d scif_bind failed rc %d\n",
> -		       __func__, __LINE__, rc);
> -		goto err;
> -	}
> -
> -	rc =3D scif_listen(listen_epd, COSM_SCIF_BACKLOG);
> -	if (rc < 0) {
> -		pr_err("%s %d scif_listen rc %d\n", __func__, __LINE__, rc);
> -		goto err;
> -	}
> -	pr_debug("%s %d listen_epd set up\n", __func__, __LINE__);
> -	return 0;
> -err:
> -	scif_close(listen_epd);
> -	listen_epd =3D NULL;
> -	return rc;
> -}
> -
> -static void cosm_scif_listen_exit(void)
> -{
> -	pr_debug("%s %d closing listen_epd\n", __func__, __LINE__);
> -	if (listen_epd) {
> -		scif_close(listen_epd);
> -		listen_epd =3D NULL;
> -	}
> -}
> -
> -/*
> - * Create a listening SCIF endpoint and a server kthread which accepts
> incoming
> - * SCIF connections from MIC cards
> - */
> -int cosm_scif_init(void)
> -{
> -	int rc =3D cosm_scif_listen();
> -
> -	if (rc) {
> -		pr_err("%s %d cosm_scif_listen rc %d\n",
> -		       __func__, __LINE__, rc);
> -		goto err;
> -	}
> -
> -	server_thread =3D kthread_run(cosm_scif_server, NULL,
> "cosm_server");
> -	if (IS_ERR(server_thread)) {
> -		rc =3D PTR_ERR(server_thread);
> -		pr_err("%s %d kthread_run rc %d\n", __func__, __LINE__, rc);
> -		goto listen_exit;
> -	}
> -	return 0;
> -listen_exit:
> -	cosm_scif_listen_exit();
> -err:
> -	return rc;
> -}
> -
> -/* Stop the running server thread and close the listening SCIF endpoint =
*/
> -void cosm_scif_exit(void)
> -{
> -	int rc;
> -
> -	if (!IS_ERR_OR_NULL(server_thread)) {
> -		rc =3D send_sig(SIGKILL, server_thread, 0);
> -		if (rc) {
> -			pr_err("%s %d send_sig rc %d\n",
> -			       __func__, __LINE__, rc);
> -			return;
> -		}
> -		kthread_stop(server_thread);
> -	}
> -
> -	cosm_scif_listen_exit();
> -}
> diff --git a/drivers/misc/mic/cosm/cosm_sysfs.c
> b/drivers/misc/mic/cosm/cosm_sysfs.c
> deleted file mode 100644
> index e6dac967c1af..000000000000
> --- a/drivers/misc/mic/cosm/cosm_sysfs.c
> +++ /dev/null
> @@ -1,449 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel MIC Coprocessor State Management (COSM) Driver
> - */
> -#include <linux/slab.h>
> -#include "cosm_main.h"
> -
> -/*
> - * A state-to-string lookup table, for exposing a human readable state
> - * via sysfs. Always keep in sync with enum cosm_states
> - */
> -const char * const cosm_state_string[] =3D {
> -	[MIC_READY] =3D "ready",
> -	[MIC_BOOTING] =3D "booting",
> -	[MIC_ONLINE] =3D "online",
> -	[MIC_SHUTTING_DOWN] =3D "shutting_down",
> -	[MIC_RESETTING] =3D "resetting",
> -	[MIC_RESET_FAILED] =3D "reset_failed",
> -};
> -
> -/*
> - * A shutdown-status-to-string lookup table, for exposing a human
> - * readable state via sysfs. Always keep in sync with enum
> cosm_shutdown_status
> - */
> -const char * const cosm_shutdown_status_string[] =3D {
> -	[MIC_NOP] =3D "nop",
> -	[MIC_CRASHED] =3D "crashed",
> -	[MIC_HALTED] =3D "halted",
> -	[MIC_POWER_OFF] =3D "poweroff",
> -	[MIC_RESTART] =3D "restart",
> -};
> -
> -void cosm_set_shutdown_status(struct cosm_device *cdev, u8
> shutdown_status)
> -{
> -	dev_dbg(&cdev->dev, "Shutdown Status %s -> %s\n",
> -		cosm_shutdown_status_string[cdev->shutdown_status],
> -		cosm_shutdown_status_string[shutdown_status]);
> -	cdev->shutdown_status =3D shutdown_status;
> -}
> -
> -void cosm_set_state(struct cosm_device *cdev, u8 state)
> -{
> -	dev_dbg(&cdev->dev, "State %s -> %s\n",
> -		cosm_state_string[cdev->state],
> -		cosm_state_string[state]);
> -	cdev->state =3D state;
> -	sysfs_notify_dirent(cdev->state_sysfs);
> -}
> -
> -static ssize_t
> -family_show(struct device *dev, struct device_attribute *attr, char *buf=
)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	return cdev->hw_ops->family(cdev, buf);
> -}
> -static DEVICE_ATTR_RO(family);
> -
> -static ssize_t
> -stepping_show(struct device *dev, struct device_attribute *attr, char *b=
uf)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	return cdev->hw_ops->stepping(cdev, buf);
> -}
> -static DEVICE_ATTR_RO(stepping);
> -
> -static ssize_t
> -state_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev || cdev->state >=3D MIC_LAST)
> -		return -EINVAL;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%s\n",
> -		cosm_state_string[cdev->state]);
> -}
> -
> -static ssize_t
> -state_store(struct device *dev, struct device_attribute *attr,
> -	    const char *buf, size_t count)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -	int rc;
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	if (sysfs_streq(buf, "boot")) {
> -		rc =3D cosm_start(cdev);
> -		goto done;
> -	}
> -	if (sysfs_streq(buf, "reset")) {
> -		rc =3D cosm_reset(cdev);
> -		goto done;
> -	}
> -
> -	if (sysfs_streq(buf, "shutdown")) {
> -		rc =3D cosm_shutdown(cdev);
> -		goto done;
> -	}
> -	rc =3D -EINVAL;
> -done:
> -	if (rc)
> -		count =3D rc;
> -	return count;
> -}
> -static DEVICE_ATTR_RW(state);
> -
> -static ssize_t shutdown_status_show(struct device *dev,
> -				    struct device_attribute *attr, char *buf)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev || cdev->shutdown_status >=3D MIC_STATUS_LAST)
> -		return -EINVAL;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%s\n",
> -		cosm_shutdown_status_string[cdev->shutdown_status]);
> -}
> -static DEVICE_ATTR_RO(shutdown_status);
> -
> -static ssize_t
> -heartbeat_enable_show(struct device *dev,
> -		      struct device_attribute *attr, char *buf)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", cdev-
> >sysfs_heartbeat_enable);
> -}
> -
> -static ssize_t
> -heartbeat_enable_store(struct device *dev,
> -		       struct device_attribute *attr,
> -		       const char *buf, size_t count)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -	int enable;
> -	int ret;
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	ret =3D kstrtoint(buf, 10, &enable);
> -	if (ret)
> -		goto unlock;
> -
> -	cdev->sysfs_heartbeat_enable =3D enable;
> -	/* if state is not online, cdev->heartbeat_watchdog_enable is 0 */
> -	if (cdev->state =3D=3D MIC_ONLINE)
> -		cdev->heartbeat_watchdog_enable =3D enable;
> -	ret =3D count;
> -unlock:
> -	mutex_unlock(&cdev->cosm_mutex);
> -	return ret;
> -}
> -static DEVICE_ATTR_RW(heartbeat_enable);
> -
> -static ssize_t
> -cmdline_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -	char *cmdline;
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	cmdline =3D cdev->cmdline;
> -
> -	if (cmdline)
> -		return scnprintf(buf, PAGE_SIZE, "%s\n", cmdline);
> -	return 0;
> -}
> -
> -static ssize_t
> -cmdline_store(struct device *dev, struct device_attribute *attr,
> -	      const char *buf, size_t count)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	kfree(cdev->cmdline);
> -
> -	cdev->cmdline =3D kmalloc(count + 1, GFP_KERNEL);
> -	if (!cdev->cmdline) {
> -		count =3D -ENOMEM;
> -		goto unlock;
> -	}
> -
> -	strncpy(cdev->cmdline, buf, count);
> -
> -	if (cdev->cmdline[count - 1] =3D=3D '\n')
> -		cdev->cmdline[count - 1] =3D '\0';
> -	else
> -		cdev->cmdline[count] =3D '\0';
> -unlock:
> -	mutex_unlock(&cdev->cosm_mutex);
> -	return count;
> -}
> -static DEVICE_ATTR_RW(cmdline);
> -
> -static ssize_t
> -firmware_show(struct device *dev, struct device_attribute *attr, char *b=
uf)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -	char *firmware;
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	firmware =3D cdev->firmware;
> -
> -	if (firmware)
> -		return scnprintf(buf, PAGE_SIZE, "%s\n", firmware);
> -	return 0;
> -}
> -
> -static ssize_t
> -firmware_store(struct device *dev, struct device_attribute *attr,
> -	       const char *buf, size_t count)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	kfree(cdev->firmware);
> -
> -	cdev->firmware =3D kmalloc(count + 1, GFP_KERNEL);
> -	if (!cdev->firmware) {
> -		count =3D -ENOMEM;
> -		goto unlock;
> -	}
> -	strncpy(cdev->firmware, buf, count);
> -
> -	if (cdev->firmware[count - 1] =3D=3D '\n')
> -		cdev->firmware[count - 1] =3D '\0';
> -	else
> -		cdev->firmware[count] =3D '\0';
> -unlock:
> -	mutex_unlock(&cdev->cosm_mutex);
> -	return count;
> -}
> -static DEVICE_ATTR_RW(firmware);
> -
> -static ssize_t
> -ramdisk_show(struct device *dev, struct device_attribute *attr, char *bu=
f)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -	char *ramdisk;
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	ramdisk =3D cdev->ramdisk;
> -
> -	if (ramdisk)
> -		return scnprintf(buf, PAGE_SIZE, "%s\n", ramdisk);
> -	return 0;
> -}
> -
> -static ssize_t
> -ramdisk_store(struct device *dev, struct device_attribute *attr,
> -	      const char *buf, size_t count)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	kfree(cdev->ramdisk);
> -
> -	cdev->ramdisk =3D kmalloc(count + 1, GFP_KERNEL);
> -	if (!cdev->ramdisk) {
> -		count =3D -ENOMEM;
> -		goto unlock;
> -	}
> -
> -	strncpy(cdev->ramdisk, buf, count);
> -
> -	if (cdev->ramdisk[count - 1] =3D=3D '\n')
> -		cdev->ramdisk[count - 1] =3D '\0';
> -	else
> -		cdev->ramdisk[count] =3D '\0';
> -unlock:
> -	mutex_unlock(&cdev->cosm_mutex);
> -	return count;
> -}
> -static DEVICE_ATTR_RW(ramdisk);
> -
> -static ssize_t
> -bootmode_show(struct device *dev, struct device_attribute *attr, char *b=
uf)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -	char *bootmode;
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	bootmode =3D cdev->bootmode;
> -
> -	if (bootmode)
> -		return scnprintf(buf, PAGE_SIZE, "%s\n", bootmode);
> -	return 0;
> -}
> -
> -static ssize_t
> -bootmode_store(struct device *dev, struct device_attribute *attr,
> -	       const char *buf, size_t count)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	if (!sysfs_streq(buf, "linux") && !sysfs_streq(buf, "flash"))
> -		return -EINVAL;
> -
> -	mutex_lock(&cdev->cosm_mutex);
> -	kfree(cdev->bootmode);
> -
> -	cdev->bootmode =3D kmalloc(count + 1, GFP_KERNEL);
> -	if (!cdev->bootmode) {
> -		count =3D -ENOMEM;
> -		goto unlock;
> -	}
> -
> -	strncpy(cdev->bootmode, buf, count);
> -
> -	if (cdev->bootmode[count - 1] =3D=3D '\n')
> -		cdev->bootmode[count - 1] =3D '\0';
> -	else
> -		cdev->bootmode[count] =3D '\0';
> -unlock:
> -	mutex_unlock(&cdev->cosm_mutex);
> -	return count;
> -}
> -static DEVICE_ATTR_RW(bootmode);
> -
> -static ssize_t
> -log_buf_addr_show(struct device *dev, struct device_attribute *attr,
> -		  char *buf)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%p\n", cdev->log_buf_addr);
> -}
> -
> -static ssize_t
> -log_buf_addr_store(struct device *dev, struct device_attribute *attr,
> -		   const char *buf, size_t count)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -	int ret;
> -	unsigned long addr;
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	ret =3D kstrtoul(buf, 16, &addr);
> -	if (ret)
> -		goto exit;
> -
> -	cdev->log_buf_addr =3D (void *)addr;
> -	ret =3D count;
> -exit:
> -	return ret;
> -}
> -static DEVICE_ATTR_RW(log_buf_addr);
> -
> -static ssize_t
> -log_buf_len_show(struct device *dev, struct device_attribute *attr,
> -		 char *buf)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	return scnprintf(buf, PAGE_SIZE, "%p\n", cdev->log_buf_len);
> -}
> -
> -static ssize_t
> -log_buf_len_store(struct device *dev, struct device_attribute *attr,
> -		  const char *buf, size_t count)
> -{
> -	struct cosm_device *cdev =3D dev_get_drvdata(dev);
> -	int ret;
> -	unsigned long addr;
> -
> -	if (!cdev)
> -		return -EINVAL;
> -
> -	ret =3D kstrtoul(buf, 16, &addr);
> -	if (ret)
> -		goto exit;
> -
> -	cdev->log_buf_len =3D (int *)addr;
> -	ret =3D count;
> -exit:
> -	return ret;
> -}
> -static DEVICE_ATTR_RW(log_buf_len);
> -
> -static struct attribute *cosm_default_attrs[] =3D {
> -	&dev_attr_family.attr,
> -	&dev_attr_stepping.attr,
> -	&dev_attr_state.attr,
> -	&dev_attr_shutdown_status.attr,
> -	&dev_attr_heartbeat_enable.attr,
> -	&dev_attr_cmdline.attr,
> -	&dev_attr_firmware.attr,
> -	&dev_attr_ramdisk.attr,
> -	&dev_attr_bootmode.attr,
> -	&dev_attr_log_buf_addr.attr,
> -	&dev_attr_log_buf_len.attr,
> -
> -	NULL
> -};
> -
> -ATTRIBUTE_GROUPS(cosm_default);
> -
> -void cosm_sysfs_init(struct cosm_device *cdev)
> -{
> -	cdev->attr_group =3D cosm_default_groups;
> -}
> diff --git a/drivers/misc/mic/cosm_client/Makefile
> b/drivers/misc/mic/cosm_client/Makefile
> deleted file mode 100644
> index 5b62270bc2ab..000000000000
> --- a/drivers/misc/mic/cosm_client/Makefile
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Makefile - Intel MIC COSM Client Driver
> -# Copyright(c) 2015, Intel Corporation.
> -#
> -obj-$(CONFIG_MIC_COSM) +=3D cosm_client.o
> -
> -cosm_client-objs +=3D cosm_scif_client.o
> diff --git a/drivers/misc/mic/cosm_client/cosm_scif_client.c
> b/drivers/misc/mic/cosm_client/cosm_scif_client.c
> deleted file mode 100644
> index a03213dd9319..000000000000
> --- a/drivers/misc/mic/cosm_client/cosm_scif_client.c
> +++ /dev/null
> @@ -1,269 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel MIC COSM Client Driver
> - */
> -#include <linux/module.h>
> -#include <linux/delay.h>
> -#include <linux/reboot.h>
> -#include <linux/kthread.h>
> -#include <linux/sched/signal.h>
> -
> -#include "../cosm/cosm_main.h"
> -
> -#define COSM_SCIF_MAX_RETRIES 10
> -#define COSM_HEARTBEAT_SEND_MSEC (COSM_HEARTBEAT_SEND_SEC *
> MSEC_PER_SEC)
> -
> -static struct task_struct *client_thread;
> -static scif_epd_t client_epd;
> -static struct scif_peer_dev *client_spdev;
> -
> -/*
> - * Reboot notifier: receives shutdown status from the OS and communicate=
s
> it
> - * back to the COSM process on the host
> - */
> -static int cosm_reboot_event(struct notifier_block *this, unsigned long =
event,
> -			     void *ptr)
> -{
> -	struct cosm_msg msg =3D { .id =3D COSM_MSG_SHUTDOWN_STATUS };
> -	int rc;
> -
> -	event =3D (event =3D=3D SYS_RESTART) ? SYSTEM_RESTART : event;
> -	dev_info(&client_spdev->dev, "%s %d received event %ld\n",
> -		 __func__, __LINE__, event);
> -
> -	msg.shutdown_status =3D event;
> -	rc =3D scif_send(client_epd, &msg, sizeof(msg), SCIF_SEND_BLOCK);
> -	if (rc < 0)
> -		dev_err(&client_spdev->dev, "%s %d scif_send rc %d\n",
> -			__func__, __LINE__, rc);
> -
> -	return NOTIFY_DONE;
> -}
> -
> -static struct notifier_block cosm_reboot =3D {
> -	.notifier_call  =3D cosm_reboot_event,
> -};
> -
> -/* Set system time from timespec value received from the host */
> -static void cosm_set_time(struct cosm_msg *msg)
> -{
> -	struct timespec64 ts =3D {
> -		.tv_sec =3D msg->timespec.tv_sec,
> -		.tv_nsec =3D msg->timespec.tv_nsec,
> -	};
> -	int rc =3D do_settimeofday64(&ts);
> -
> -	if (rc)
> -		dev_err(&client_spdev->dev, "%s: %d settimeofday rc %d\n",
> -			__func__, __LINE__, rc);
> -}
> -
> -/* COSM client receive message processing */
> -static void cosm_client_recv(void)
> -{
> -	struct cosm_msg msg;
> -	int rc;
> -
> -	while (1) {
> -		rc =3D scif_recv(client_epd, &msg, sizeof(msg), 0);
> -		if (!rc) {
> -			return;
> -		} else if (rc < 0) {
> -			dev_err(&client_spdev->dev, "%s: %d rc %d\n",
> -				__func__, __LINE__, rc);
> -			return;
> -		}
> -
> -		dev_dbg(&client_spdev->dev, "%s: %d rc %d id 0x%llx\n",
> -			__func__, __LINE__, rc, msg.id);
> -
> -		switch (msg.id) {
> -		case COSM_MSG_SYNC_TIME:
> -			cosm_set_time(&msg);
> -			break;
> -		case COSM_MSG_SHUTDOWN:
> -			orderly_poweroff(true);
> -			break;
> -		default:
> -			dev_err(&client_spdev->dev, "%s: %d unknown
> id %lld\n",
> -				__func__, __LINE__, msg.id);
> -			break;
> -		}
> -	}
> -}
> -
> -/* Initiate connection to the COSM server on the host */
> -static int cosm_scif_connect(void)
> -{
> -	struct scif_port_id port_id;
> -	int i, rc;
> -
> -	client_epd =3D scif_open();
> -	if (!client_epd) {
> -		dev_err(&client_spdev->dev, "%s %d scif_open failed\n",
> -			__func__, __LINE__);
> -		return -ENOMEM;
> -	}
> -
> -	port_id.node =3D 0;
> -	port_id.port =3D SCIF_COSM_LISTEN_PORT;
> -
> -	for (i =3D 0; i < COSM_SCIF_MAX_RETRIES; i++) {
> -		rc =3D scif_connect(client_epd, &port_id);
> -		if (rc < 0)
> -			msleep(1000);
> -		else
> -			break;
> -	}
> -
> -	if (rc < 0) {
> -		dev_err(&client_spdev->dev, "%s %d scif_connect rc %d\n",
> -			__func__, __LINE__, rc);
> -		scif_close(client_epd);
> -		client_epd =3D NULL;
> -	}
> -	return rc < 0 ? rc : 0;
> -}
> -
> -/* Close host SCIF connection */
> -static void cosm_scif_connect_exit(void)
> -{
> -	if (client_epd) {
> -		scif_close(client_epd);
> -		client_epd =3D NULL;
> -	}
> -}
> -
> -/*
> - * COSM SCIF client thread function: waits for messages from the host an=
d
> sends
> - * a heartbeat to the host
> - */
> -static int cosm_scif_client(void *unused)
> -{
> -	struct cosm_msg msg =3D { .id =3D COSM_MSG_HEARTBEAT };
> -	struct scif_pollepd pollepd;
> -	int rc;
> -
> -	allow_signal(SIGKILL);
> -
> -	while (!kthread_should_stop()) {
> -		pollepd.epd =3D client_epd;
> -		pollepd.events =3D EPOLLIN;
> -
> -		rc =3D scif_poll(&pollepd, 1, COSM_HEARTBEAT_SEND_MSEC);
> -		if (rc < 0) {
> -			if (-EINTR !=3D rc)
> -				dev_err(&client_spdev->dev,
> -					"%s %d scif_poll rc %d\n",
> -					__func__, __LINE__, rc);
> -			continue;
> -		}
> -
> -		if (pollepd.revents & EPOLLIN)
> -			cosm_client_recv();
> -
> -		msg.id =3D COSM_MSG_HEARTBEAT;
> -		rc =3D scif_send(client_epd, &msg, sizeof(msg),
> SCIF_SEND_BLOCK);
> -		if (rc < 0)
> -			dev_err(&client_spdev->dev, "%s %d scif_send
> rc %d\n",
> -				__func__, __LINE__, rc);
> -	}
> -
> -	dev_dbg(&client_spdev->dev, "%s %d Client thread stopped\n",
> -		__func__, __LINE__);
> -	return 0;
> -}
> -
> -static void cosm_scif_probe(struct scif_peer_dev *spdev)
> -{
> -	int rc;
> -
> -	dev_dbg(&spdev->dev, "%s %d: dnode %d\n",
> -		__func__, __LINE__, spdev->dnode);
> -
> -	/* We are only interested in the host with spdev->dnode =3D=3D 0 */
> -	if (spdev->dnode)
> -		return;
> -
> -	client_spdev =3D spdev;
> -	rc =3D cosm_scif_connect();
> -	if (rc)
> -		goto exit;
> -
> -	rc =3D register_reboot_notifier(&cosm_reboot);
> -	if (rc) {
> -		dev_err(&spdev->dev,
> -			"reboot notifier registration failed rc %d\n", rc);
> -		goto connect_exit;
> -	}
> -
> -	client_thread =3D kthread_run(cosm_scif_client, NULL, "cosm_client");
> -	if (IS_ERR(client_thread)) {
> -		rc =3D PTR_ERR(client_thread);
> -		dev_err(&spdev->dev, "%s %d kthread_run rc %d\n",
> -			__func__, __LINE__, rc);
> -		goto unreg_reboot;
> -	}
> -	return;
> -unreg_reboot:
> -	unregister_reboot_notifier(&cosm_reboot);
> -connect_exit:
> -	cosm_scif_connect_exit();
> -exit:
> -	client_spdev =3D NULL;
> -}
> -
> -static void cosm_scif_remove(struct scif_peer_dev *spdev)
> -{
> -	int rc;
> -
> -	dev_dbg(&spdev->dev, "%s %d: dnode %d\n",
> -		__func__, __LINE__, spdev->dnode);
> -
> -	if (spdev->dnode)
> -		return;
> -
> -	if (!IS_ERR_OR_NULL(client_thread)) {
> -		rc =3D send_sig(SIGKILL, client_thread, 0);
> -		if (rc) {
> -			pr_err("%s %d send_sig rc %d\n",
> -			       __func__, __LINE__, rc);
> -			return;
> -		}
> -		kthread_stop(client_thread);
> -	}
> -	unregister_reboot_notifier(&cosm_reboot);
> -	cosm_scif_connect_exit();
> -	client_spdev =3D NULL;
> -}
> -
> -static struct scif_client scif_client_cosm =3D {
> -	.name =3D KBUILD_MODNAME,
> -	.probe =3D cosm_scif_probe,
> -	.remove =3D cosm_scif_remove,
> -};
> -
> -static int __init cosm_client_init(void)
> -{
> -	int rc =3D scif_client_register(&scif_client_cosm);
> -
> -	if (rc)
> -		pr_err("scif_client_register failed rc %d\n", rc);
> -	return rc;
> -}
> -
> -static void __exit cosm_client_exit(void)
> -{
> -	scif_client_unregister(&scif_client_cosm);
> -}
> -
> -module_init(cosm_client_init);
> -module_exit(cosm_client_exit);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) MIC card OS state management client
> driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/host/Makefile b/drivers/misc/mic/host/Makef=
ile
> deleted file mode 100644
> index 25f153367980..000000000000
> --- a/drivers/misc/mic/host/Makefile
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile - Intel MIC Linux driver.
> -# Copyright(c) 2013, Intel Corporation.
> -#
> -obj-$(CONFIG_INTEL_MIC_HOST) +=3D mic_host.o
> -mic_host-objs :=3D mic_main.o
> -mic_host-objs +=3D mic_x100.o
> -mic_host-objs +=3D mic_smpt.o
> -mic_host-objs +=3D mic_intr.o
> -mic_host-objs +=3D mic_boot.o
> -mic_host-objs +=3D mic_debugfs.o
> diff --git a/drivers/misc/mic/host/mic_boot.c
> b/drivers/misc/mic/host/mic_boot.c
> deleted file mode 100644
> index 8cb85b8b3e19..000000000000
> --- a/drivers/misc/mic/host/mic_boot.c
> +++ /dev/null
> @@ -1,588 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#include <linux/delay.h>
> -#include <linux/firmware.h>
> -#include <linux/pci.h>
> -#include <linux/kmod.h>
> -#include <linux/dma-map-ops.h>
> -#include <linux/mic_common.h>
> -#include <linux/mic_bus.h>
> -#include "../bus/scif_bus.h"
> -#include "../bus/vop_bus.h"
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -#include "mic_smpt.h"
> -
> -static inline struct mic_device *vpdev_to_mdev(struct device *dev)
> -{
> -	return dev_get_drvdata(dev->parent);
> -}
> -
> -static dma_addr_t
> -_mic_dma_map_page(struct device *dev, struct page *page,
> -		  unsigned long offset, size_t size,
> -		  enum dma_data_direction dir, unsigned long attrs)
> -{
> -	void *va =3D phys_to_virt(page_to_phys(page)) + offset;
> -	struct mic_device *mdev =3D vpdev_to_mdev(dev);
> -
> -	return mic_map_single(mdev, va, size);
> -}
> -
> -static void _mic_dma_unmap_page(struct device *dev, dma_addr_t
> dma_addr,
> -				size_t size, enum dma_data_direction dir,
> -				unsigned long attrs)
> -{
> -	struct mic_device *mdev =3D vpdev_to_mdev(dev);
> -
> -	mic_unmap_single(mdev, dma_addr, size);
> -}
> -
> -static const struct dma_map_ops _mic_dma_ops =3D {
> -	.map_page =3D _mic_dma_map_page,
> -	.unmap_page =3D _mic_dma_unmap_page,
> -};
> -
> -static struct mic_irq *
> -__mic_request_irq(struct vop_device *vpdev,
> -		  irqreturn_t (*func)(int irq, void *data),
> -		  const char *name, void *data, int intr_src)
> -{
> -	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> -
> -	return mic_request_threaded_irq(mdev, func, NULL, name, data,
> -					intr_src, MIC_INTR_DB);
> -}
> -
> -static void __mic_free_irq(struct vop_device *vpdev,
> -			   struct mic_irq *cookie, void *data)
> -{
> -	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> -
> -	mic_free_irq(mdev, cookie, data);
> -}
> -
> -static void __mic_ack_interrupt(struct vop_device *vpdev, int num)
> -{
> -	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> -
> -	mdev->ops->intr_workarounds(mdev);
> -}
> -
> -static int __mic_next_db(struct vop_device *vpdev)
> -{
> -	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> -
> -	return mic_next_db(mdev);
> -}
> -
> -static void *__mic_get_dp(struct vop_device *vpdev)
> -{
> -	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> -
> -	return mdev->dp;
> -}
> -
> -static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)
> -{
> -	return NULL;
> -}
> -
> -static void __mic_send_intr(struct vop_device *vpdev, int db)
> -{
> -	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> -
> -	mdev->ops->send_intr(mdev, db);
> -}
> -
> -static void __iomem *__mic_ioremap(struct vop_device *vpdev,
> -				   dma_addr_t pa, size_t len)
> -{
> -	struct mic_device *mdev =3D vpdev_to_mdev(&vpdev->dev);
> -
> -	return mdev->aper.va + pa;
> -}
> -
> -static void __mic_iounmap(struct vop_device *vpdev, void __iomem *va)
> -{
> -	/* nothing to do */
> -}
> -
> -static struct vop_hw_ops vop_hw_ops =3D {
> -	.request_irq =3D __mic_request_irq,
> -	.free_irq =3D __mic_free_irq,
> -	.ack_interrupt =3D __mic_ack_interrupt,
> -	.next_db =3D __mic_next_db,
> -	.get_dp =3D __mic_get_dp,
> -	.get_remote_dp =3D __mic_get_remote_dp,
> -	.send_intr =3D __mic_send_intr,
> -	.remap =3D __mic_ioremap,
> -	.unmap =3D __mic_iounmap,
> -};
> -
> -static inline struct mic_device *scdev_to_mdev(struct scif_hw_dev *scdev=
)
> -{
> -	return dev_get_drvdata(scdev->dev.parent);
> -}
> -
> -static void *__mic_dma_alloc(struct device *dev, size_t size,
> -			     dma_addr_t *dma_handle, gfp_t gfp,
> -			     unsigned long attrs)
> -{
> -	struct scif_hw_dev *scdev =3D dev_get_drvdata(dev);
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -	dma_addr_t tmp;
> -	void *va =3D kzalloc(size, gfp);
> -
> -	if (va) {
> -		tmp =3D mic_map_single(mdev, va, size);
> -		if (dma_mapping_error(dev, tmp)) {
> -			kfree(va);
> -			va =3D NULL;
> -		} else {
> -			*dma_handle =3D tmp;
> -		}
> -	}
> -	return va;
> -}
> -
> -static void __mic_dma_free(struct device *dev, size_t size, void *vaddr,
> -			   dma_addr_t dma_handle, unsigned long attrs)
> -{
> -	struct scif_hw_dev *scdev =3D dev_get_drvdata(dev);
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	mic_unmap_single(mdev, dma_handle, size);
> -	kfree(vaddr);
> -}
> -
> -static dma_addr_t
> -__mic_dma_map_page(struct device *dev, struct page *page, unsigned long
> offset,
> -		   size_t size, enum dma_data_direction dir,
> -		   unsigned long attrs)
> -{
> -	void *va =3D phys_to_virt(page_to_phys(page)) + offset;
> -	struct scif_hw_dev *scdev =3D dev_get_drvdata(dev);
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	return mic_map_single(mdev, va, size);
> -}
> -
> -static void
> -__mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
> -		     size_t size, enum dma_data_direction dir,
> -		     unsigned long attrs)
> -{
> -	struct scif_hw_dev *scdev =3D dev_get_drvdata(dev);
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	mic_unmap_single(mdev, dma_addr, size);
> -}
> -
> -static int __mic_dma_map_sg(struct device *dev, struct scatterlist *sg,
> -			    int nents, enum dma_data_direction dir,
> -			    unsigned long attrs)
> -{
> -	struct scif_hw_dev *scdev =3D dev_get_drvdata(dev);
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -	struct scatterlist *s;
> -	int i, j, ret;
> -	dma_addr_t da;
> -
> -	ret =3D dma_map_sg(&mdev->pdev->dev, sg, nents, dir);
> -	if (ret <=3D 0)
> -		return 0;
> -
> -	for_each_sg(sg, s, nents, i) {
> -		da =3D mic_map(mdev, sg_dma_address(s) + s->offset, s-
> >length);
> -		if (!da)
> -			goto err;
> -		sg_dma_address(s) =3D da;
> -	}
> -	return nents;
> -err:
> -	for_each_sg(sg, s, i, j) {
> -		mic_unmap(mdev, sg_dma_address(s), s->length);
> -		sg_dma_address(s) =3D mic_to_dma_addr(mdev,
> sg_dma_address(s));
> -	}
> -	dma_unmap_sg(&mdev->pdev->dev, sg, nents, dir);
> -	return 0;
> -}
> -
> -static void __mic_dma_unmap_sg(struct device *dev,
> -			       struct scatterlist *sg, int nents,
> -			       enum dma_data_direction dir,
> -			       unsigned long attrs)
> -{
> -	struct scif_hw_dev *scdev =3D dev_get_drvdata(dev);
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -	struct scatterlist *s;
> -	dma_addr_t da;
> -	int i;
> -
> -	for_each_sg(sg, s, nents, i) {
> -		da =3D mic_to_dma_addr(mdev, sg_dma_address(s));
> -		mic_unmap(mdev, sg_dma_address(s), s->length);
> -		sg_dma_address(s) =3D da;
> -	}
> -	dma_unmap_sg(&mdev->pdev->dev, sg, nents, dir);
> -}
> -
> -static const struct dma_map_ops __mic_dma_ops =3D {
> -	.alloc =3D __mic_dma_alloc,
> -	.free =3D __mic_dma_free,
> -	.map_page =3D __mic_dma_map_page,
> -	.unmap_page =3D __mic_dma_unmap_page,
> -	.map_sg =3D __mic_dma_map_sg,
> -	.unmap_sg =3D __mic_dma_unmap_sg,
> -};
> -
> -static struct mic_irq *
> -___mic_request_irq(struct scif_hw_dev *scdev,
> -		   irqreturn_t (*func)(int irq, void *data),
> -				       const char *name,
> -				       void *data, int db)
> -{
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	return mic_request_threaded_irq(mdev, func, NULL, name, data,
> -					db, MIC_INTR_DB);
> -}
> -
> -static void
> -___mic_free_irq(struct scif_hw_dev *scdev,
> -		struct mic_irq *cookie, void *data)
> -{
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	mic_free_irq(mdev, cookie, data);
> -}
> -
> -static void ___mic_ack_interrupt(struct scif_hw_dev *scdev, int num)
> -{
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	mdev->ops->intr_workarounds(mdev);
> -}
> -
> -static int ___mic_next_db(struct scif_hw_dev *scdev)
> -{
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	return mic_next_db(mdev);
> -}
> -
> -static void ___mic_send_intr(struct scif_hw_dev *scdev, int db)
> -{
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	mdev->ops->send_intr(mdev, db);
> -}
> -
> -static void __iomem *___mic_ioremap(struct scif_hw_dev *scdev,
> -				    phys_addr_t pa, size_t len)
> -{
> -	struct mic_device *mdev =3D scdev_to_mdev(scdev);
> -
> -	return mdev->aper.va + pa;
> -}
> -
> -static void ___mic_iounmap(struct scif_hw_dev *scdev, void __iomem *va)
> -{
> -	/* nothing to do */
> -}
> -
> -static struct scif_hw_ops scif_hw_ops =3D {
> -	.request_irq =3D ___mic_request_irq,
> -	.free_irq =3D ___mic_free_irq,
> -	.ack_interrupt =3D ___mic_ack_interrupt,
> -	.next_db =3D ___mic_next_db,
> -	.send_intr =3D ___mic_send_intr,
> -	.remap =3D ___mic_ioremap,
> -	.unmap =3D ___mic_iounmap,
> -};
> -
> -static inline struct mic_device *mbdev_to_mdev(struct mbus_device
> *mbdev)
> -{
> -	return dev_get_drvdata(mbdev->dev.parent);
> -}
> -
> -static dma_addr_t
> -mic_dma_map_page(struct device *dev, struct page *page,
> -		 unsigned long offset, size_t size, enum dma_data_direction
> dir,
> -		 unsigned long attrs)
> -{
> -	void *va =3D phys_to_virt(page_to_phys(page)) + offset;
> -	struct mic_device *mdev =3D dev_get_drvdata(dev->parent);
> -
> -	return mic_map_single(mdev, va, size);
> -}
> -
> -static void
> -mic_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
> -		   size_t size, enum dma_data_direction dir,
> -		   unsigned long attrs)
> -{
> -	struct mic_device *mdev =3D dev_get_drvdata(dev->parent);
> -	mic_unmap_single(mdev, dma_addr, size);
> -}
> -
> -static const struct dma_map_ops mic_dma_ops =3D {
> -	.map_page =3D mic_dma_map_page,
> -	.unmap_page =3D mic_dma_unmap_page,
> -};
> -
> -static struct mic_irq *
> -_mic_request_threaded_irq(struct mbus_device *mbdev,
> -			  irq_handler_t handler, irq_handler_t thread_fn,
> -			  const char *name, void *data, int intr_src)
> -{
> -	return mic_request_threaded_irq(mbdev_to_mdev(mbdev), handler,
> -					thread_fn, name, data,
> -					intr_src, MIC_INTR_DMA);
> -}
> -
> -static void _mic_free_irq(struct mbus_device *mbdev,
> -			  struct mic_irq *cookie, void *data)
> -{
> -	mic_free_irq(mbdev_to_mdev(mbdev), cookie, data);
> -}
> -
> -static void _mic_ack_interrupt(struct mbus_device *mbdev, int num)
> -{
> -	struct mic_device *mdev =3D mbdev_to_mdev(mbdev);
> -	mdev->ops->intr_workarounds(mdev);
> -}
> -
> -static struct mbus_hw_ops mbus_hw_ops =3D {
> -	.request_threaded_irq =3D _mic_request_threaded_irq,
> -	.free_irq =3D _mic_free_irq,
> -	.ack_interrupt =3D _mic_ack_interrupt,
> -};
> -
> -/* Initialize the MIC bootparams */
> -void mic_bootparam_init(struct mic_device *mdev)
> -{
> -	struct mic_bootparam *bootparam =3D mdev->dp;
> -
> -	bootparam->magic =3D cpu_to_le32(MIC_MAGIC);
> -	bootparam->h2c_config_db =3D -1;
> -	bootparam->node_id =3D mdev->id + 1;
> -	bootparam->scif_host_dma_addr =3D 0x0;
> -	bootparam->scif_card_dma_addr =3D 0x0;
> -	bootparam->c2h_scif_db =3D -1;
> -	bootparam->h2c_scif_db =3D -1;
> -}
> -
> -static inline struct mic_device *cosmdev_to_mdev(struct cosm_device *cde=
v)
> -{
> -	return dev_get_drvdata(cdev->dev.parent);
> -}
> -
> -static void _mic_reset(struct cosm_device *cdev)
> -{
> -	struct mic_device *mdev =3D cosmdev_to_mdev(cdev);
> -
> -	mdev->ops->reset_fw_ready(mdev);
> -	mdev->ops->reset(mdev);
> -}
> -
> -static bool _mic_ready(struct cosm_device *cdev)
> -{
> -	struct mic_device *mdev =3D cosmdev_to_mdev(cdev);
> -
> -	return mdev->ops->is_fw_ready(mdev);
> -}
> -
> -/**
> - * mic_request_dma_chans - Request DMA channels
> - * @mdev: pointer to mic_device instance
> - *
> - * returns number of DMA channels acquired
> - */
> -static int mic_request_dma_chans(struct mic_device *mdev)
> -{
> -	dma_cap_mask_t mask;
> -	struct dma_chan *chan;
> -
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_MEMCPY, mask);
> -
> -	do {
> -		chan =3D dma_request_channel(mask, mdev->ops->dma_filter,
> -					   &mdev->pdev->dev);
> -		if (chan) {
> -			mdev->dma_ch[mdev->num_dma_ch++] =3D chan;
> -			if (mdev->num_dma_ch >=3D MIC_MAX_DMA_CHAN)
> -				break;
> -		}
> -	} while (chan);
> -	dev_info(&mdev->pdev->dev, "DMA channels # %d\n", mdev-
> >num_dma_ch);
> -	return mdev->num_dma_ch;
> -}
> -
> -/**
> - * mic_free_dma_chans - release DMA channels
> - * @mdev: pointer to mic_device instance
> - *
> - * returns none
> - */
> -static void mic_free_dma_chans(struct mic_device *mdev)
> -{
> -	int i =3D 0;
> -
> -	for (i =3D 0; i < mdev->num_dma_ch; i++) {
> -		dma_release_channel(mdev->dma_ch[i]);
> -		mdev->dma_ch[i] =3D NULL;
> -	}
> -	mdev->num_dma_ch =3D 0;
> -}
> -
> -/**
> - * _mic_start - Start the MIC.
> - * @cdev: pointer to cosm_device instance
> - * @id: MIC device id/index provided by COSM used in other drivers like =
SCIF
> - *
> - * This function prepares an MIC for boot and initiates boot.
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - *
> - * For all cosm_hw_ops the caller holds a mutex to ensure serialization.
> - */
> -static int _mic_start(struct cosm_device *cdev, int id)
> -{
> -	struct mic_device *mdev =3D cosmdev_to_mdev(cdev);
> -	int rc;
> -
> -	mic_bootparam_init(mdev);
> -	mdev->dma_mbdev =3D mbus_register_device(&mdev->pdev->dev,
> -					       MBUS_DEV_DMA_HOST,
> &mic_dma_ops,
> -					       &mbus_hw_ops, id, mdev-
> >mmio.va);
> -	if (IS_ERR(mdev->dma_mbdev)) {
> -		rc =3D PTR_ERR(mdev->dma_mbdev);
> -		goto unlock_ret;
> -	}
> -	if (!mic_request_dma_chans(mdev)) {
> -		rc =3D -ENODEV;
> -		goto dma_remove;
> -	}
> -	mdev->scdev =3D scif_register_device(&mdev->pdev->dev,
> MIC_SCIF_DEV,
> -					   &__mic_dma_ops, &scif_hw_ops,
> -					   id + 1, 0, &mdev->mmio,
> -					   &mdev->aper, mdev->dp, NULL,
> -					   mdev->dma_ch, mdev-
> >num_dma_ch,
> -					   true);
> -	if (IS_ERR(mdev->scdev)) {
> -		rc =3D PTR_ERR(mdev->scdev);
> -		goto dma_free;
> -	}
> -
> -	mdev->vpdev =3D vop_register_device(&mdev->pdev->dev,
> -					  VOP_DEV_TRNSP, &_mic_dma_ops,
> -					  &vop_hw_ops, id + 1, &mdev->aper,
> -					  mdev->dma_ch[0]);
> -	if (IS_ERR(mdev->vpdev)) {
> -		rc =3D PTR_ERR(mdev->vpdev);
> -		goto scif_remove;
> -	}
> -
> -	rc =3D mdev->ops->load_mic_fw(mdev, NULL);
> -	if (rc)
> -		goto vop_remove;
> -	mic_smpt_restore(mdev);
> -	mic_intr_restore(mdev);
> -	mdev->intr_ops->enable_interrupts(mdev);
> -	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev-
> >dp_dma_addr);
> -	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev-
> >dp_dma_addr >> 32);
> -	mdev->ops->send_firmware_intr(mdev);
> -	goto unlock_ret;
> -vop_remove:
> -	vop_unregister_device(mdev->vpdev);
> -scif_remove:
> -	scif_unregister_device(mdev->scdev);
> -dma_free:
> -	mic_free_dma_chans(mdev);
> -dma_remove:
> -	mbus_unregister_device(mdev->dma_mbdev);
> -unlock_ret:
> -	return rc;
> -}
> -
> -/**
> - * _mic_stop - Prepare the MIC for reset and trigger reset.
> - * @cdev: pointer to cosm_device instance
> - * @force: force a MIC to reset even if it is already offline.
> - *
> - * RETURNS: None.
> - */
> -static void _mic_stop(struct cosm_device *cdev, bool force)
> -{
> -	struct mic_device *mdev =3D cosmdev_to_mdev(cdev);
> -
> -	/*
> -	 * Since SCIF handles card shutdown and reset (using COSM), it will
> -	 * will be the first to be registered and the last to be
> -	 * unregistered.
> -	 */
> -	vop_unregister_device(mdev->vpdev);
> -	scif_unregister_device(mdev->scdev);
> -	mic_free_dma_chans(mdev);
> -	mbus_unregister_device(mdev->dma_mbdev);
> -	mic_bootparam_init(mdev);
> -}
> -
> -static ssize_t _mic_family(struct cosm_device *cdev, char *buf)
> -{
> -	struct mic_device *mdev =3D cosmdev_to_mdev(cdev);
> -	static const char *family[MIC_FAMILY_LAST] =3D { "x100", "Unknown" };
> -
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", family[mdev->family]);
> -}
> -
> -static ssize_t _mic_stepping(struct cosm_device *cdev, char *buf)
> -{
> -	struct mic_device *mdev =3D cosmdev_to_mdev(cdev);
> -	const char *string =3D "??";
> -
> -	switch (mdev->stepping) {
> -	case MIC_A0_STEP:
> -		string =3D "A0";
> -		break;
> -	case MIC_B0_STEP:
> -		string =3D "B0";
> -		break;
> -	case MIC_B1_STEP:
> -		string =3D "B1";
> -		break;
> -	case MIC_C0_STEP:
> -		string =3D "C0";
> -		break;
> -	default:
> -		break;
> -	}
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", string);
> -}
> -
> -static struct mic_mw *_mic_aper(struct cosm_device *cdev)
> -{
> -	struct mic_device *mdev =3D cosmdev_to_mdev(cdev);
> -
> -	return &mdev->aper;
> -}
> -
> -struct cosm_hw_ops cosm_hw_ops =3D {
> -	.reset =3D _mic_reset,
> -	.force_reset =3D _mic_reset,
> -	.post_reset =3D NULL,
> -	.ready =3D _mic_ready,
> -	.start =3D _mic_start,
> -	.stop =3D _mic_stop,
> -	.family =3D _mic_family,
> -	.stepping =3D _mic_stepping,
> -	.aper =3D _mic_aper,
> -};
> diff --git a/drivers/misc/mic/host/mic_debugfs.c
> b/drivers/misc/mic/host/mic_debugfs.c
> deleted file mode 100644
> index ffda740e20d5..000000000000
> --- a/drivers/misc/mic/host/mic_debugfs.c
> +++ /dev/null
> @@ -1,149 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#include <linux/debugfs.h>
> -#include <linux/pci.h>
> -#include <linux/seq_file.h>
> -
> -#include <linux/mic_common.h>
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -#include "mic_smpt.h"
> -
> -/* Debugfs parent dir */
> -static struct dentry *mic_dbg;
> -
> -static int mic_smpt_show(struct seq_file *s, void *pos)
> -{
> -	int i;
> -	struct mic_device *mdev =3D s->private;
> -	unsigned long flags;
> -
> -	seq_printf(s, "MIC %-2d |%-10s| %-14s %-10s\n",
> -		   mdev->id, "SMPT entry", "SW DMA addr", "RefCount");
> -	seq_puts(s,
> "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
> -
> -	if (mdev->smpt) {
> -		struct mic_smpt_info *smpt_info =3D mdev->smpt;
> -		spin_lock_irqsave(&smpt_info->smpt_lock, flags);
> -		for (i =3D 0; i < smpt_info->info.num_reg; i++) {
> -			seq_printf(s, "%9s|%-10d| %-#14llx %-10lld\n",
> -				   " ",  i, smpt_info->entry[i].dma_addr,
> -				   smpt_info->entry[i].ref_count);
> -		}
> -		spin_unlock_irqrestore(&smpt_info->smpt_lock, flags);
> -	}
> -	seq_puts(s,
> "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(mic_smpt);
> -
> -static int mic_post_code_show(struct seq_file *s, void *pos)
> -{
> -	struct mic_device *mdev =3D s->private;
> -	u32 reg =3D mdev->ops->get_postcode(mdev);
> -
> -	seq_printf(s, "%c%c", reg & 0xff, (reg >> 8) & 0xff);
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(mic_post_code);
> -
> -static int mic_msi_irq_info_show(struct seq_file *s, void *pos)
> -{
> -	struct mic_device *mdev  =3D s->private;
> -	int reg;
> -	int i, j;
> -	u16 entry;
> -	u16 vector;
> -	struct pci_dev *pdev =3D mdev->pdev;
> -
> -	if (pci_dev_msi_enabled(pdev)) {
> -		for (i =3D 0; i < mdev->irq_info.num_vectors; i++) {
> -			if (pdev->msix_enabled) {
> -				entry =3D mdev->irq_info.msix_entries[i].entry;
> -				vector =3D mdev-
> >irq_info.msix_entries[i].vector;
> -			} else {
> -				entry =3D 0;
> -				vector =3D pdev->irq;
> -			}
> -
> -			reg =3D mdev->intr_ops->read_msi_to_src_map(mdev,
> entry);
> -
> -			seq_printf(s, "%s %-10d %s %-10d
> MXAR[%d]: %08X\n",
> -				   "IRQ:", vector, "Entry:", entry, i, reg);
> -
> -			seq_printf(s, "%-10s", "offset:");
> -			for (j =3D (MIC_NUM_OFFSETS - 1); j >=3D 0; j--)
> -				seq_printf(s, "%4d ", j);
> -			seq_puts(s, "\n");
> -
> -
> -			seq_printf(s, "%-10s", "count:");
> -			for (j =3D (MIC_NUM_OFFSETS - 1); j >=3D 0; j--)
> -				seq_printf(s, "%4d ",
> -					   (mdev->irq_info.mic_msi_map[i] &
> -					   BIT(j)) ? 1 : 0);
> -			seq_puts(s, "\n\n");
> -		}
> -	} else {
> -		seq_puts(s, "MSI/MSIx interrupts not enabled\n");
> -	}
> -
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(mic_msi_irq_info);
> -
> -/*
> - * mic_create_debug_dir - Initialize MIC debugfs entries.
> - */
> -void mic_create_debug_dir(struct mic_device *mdev)
> -{
> -	char name[16];
> -
> -	if (!mic_dbg)
> -		return;
> -
> -	scnprintf(name, sizeof(name), "mic%d", mdev->id);
> -	mdev->dbg_dir =3D debugfs_create_dir(name, mic_dbg);
> -
> -	debugfs_create_file("smpt", 0444, mdev->dbg_dir, mdev,
> -			    &mic_smpt_fops);
> -
> -	debugfs_create_file("post_code", 0444, mdev->dbg_dir, mdev,
> -			    &mic_post_code_fops);
> -
> -	debugfs_create_file("msi_irq_info", 0444, mdev->dbg_dir, mdev,
> -			    &mic_msi_irq_info_fops);
> -}
> -
> -/*
> - * mic_delete_debug_dir - Uninitialize MIC debugfs entries.
> - */
> -void mic_delete_debug_dir(struct mic_device *mdev)
> -{
> -	debugfs_remove_recursive(mdev->dbg_dir);
> -}
> -
> -/*
> - * mic_init_debugfs - Initialize global debugfs entry.
> - */
> -void __init mic_init_debugfs(void)
> -{
> -	mic_dbg =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> -}
> -
> -/*
> - * mic_exit_debugfs - Uninitialize global debugfs entry
> - */
> -void mic_exit_debugfs(void)
> -{
> -	debugfs_remove(mic_dbg);
> -}
> diff --git a/drivers/misc/mic/host/mic_device.h
> b/drivers/misc/mic/host/mic_device.h
> deleted file mode 100644
> index 41bcd308ae59..000000000000
> --- a/drivers/misc/mic/host/mic_device.h
> +++ /dev/null
> @@ -1,157 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#ifndef _MIC_DEVICE_H_
> -#define _MIC_DEVICE_H_
> -
> -#include <linux/cdev.h>
> -#include <linux/idr.h>
> -#include <linux/notifier.h>
> -#include <linux/irqreturn.h>
> -#include <linux/dmaengine.h>
> -#include <linux/miscdevice.h>
> -#include <linux/mic_bus.h>
> -#include "../bus/scif_bus.h"
> -#include "../bus/vop_bus.h"
> -#include "../bus/cosm_bus.h"
> -#include "mic_intr.h"
> -
> -/**
> - * enum mic_stepping - MIC stepping ids.
> - */
> -enum mic_stepping {
> -	MIC_A0_STEP =3D 0x0,
> -	MIC_B0_STEP =3D 0x10,
> -	MIC_B1_STEP =3D 0x11,
> -	MIC_C0_STEP =3D 0x20,
> -};
> -
> -extern struct cosm_hw_ops cosm_hw_ops;
> -
> -/**
> - * struct mic_device -  MIC device information for each card.
> - *
> - * @mmio: MMIO bar information.
> - * @aper: Aperture bar information.
> - * @family: The MIC family to which this device belongs.
> - * @ops: MIC HW specific operations.
> - * @id: The unique device id for this MIC device.
> - * @stepping: Stepping ID.
> - * @pdev: Underlying PCI device.
> - * @mic_mutex: Mutex for synchronizing access to mic_device.
> - * @intr_ops: HW specific interrupt operations.
> - * @smpt_ops: Hardware specific SMPT operations.
> - * @smpt: MIC SMPT information.
> - * @intr_info: H/W specific interrupt information.
> - * @irq_info: The OS specific irq information
> - * @dbg_dir: debugfs directory of this MIC device.
> - * @bootaddr: MIC boot address.
> - * @dp: virtio device page
> - * @dp_dma_addr: virtio device page DMA address.
> - * @dma_mbdev: MIC BUS DMA device.
> - * @dma_ch - Array of DMA channels
> - * @num_dma_ch - Number of DMA channels available
> - * @scdev: SCIF device on the SCIF virtual bus.
> - * @vpdev: Virtio over PCIe device on the VOP virtual bus.
> - * @cosm_dev: COSM device
> - */
> -struct mic_device {
> -	struct mic_mw mmio;
> -	struct mic_mw aper;
> -	enum mic_hw_family family;
> -	struct mic_hw_ops *ops;
> -	int id;
> -	enum mic_stepping stepping;
> -	struct pci_dev *pdev;
> -	struct mutex mic_mutex;
> -	struct mic_hw_intr_ops *intr_ops;
> -	struct mic_smpt_ops *smpt_ops;
> -	struct mic_smpt_info *smpt;
> -	struct mic_intr_info *intr_info;
> -	struct mic_irq_info irq_info;
> -	struct dentry *dbg_dir;
> -	u32 bootaddr;
> -	void *dp;
> -	dma_addr_t dp_dma_addr;
> -	struct mbus_device *dma_mbdev;
> -	struct dma_chan *dma_ch[MIC_MAX_DMA_CHAN];
> -	int num_dma_ch;
> -	struct scif_hw_dev *scdev;
> -	struct vop_device *vpdev;
> -	struct cosm_device *cosm_dev;
> -};
> -
> -/**
> - * struct mic_hw_ops - MIC HW specific operations.
> - * @aper_bar: Aperture bar resource number.
> - * @mmio_bar: MMIO bar resource number.
> - * @read_spad: Read from scratch pad register.
> - * @write_spad: Write to scratch pad register.
> - * @send_intr: Send an interrupt for a particular doorbell on the card.
> - * @ack_interrupt: Hardware specific operations to ack the h/w on
> - * receipt of an interrupt.
> - * @intr_workarounds: Hardware specific workarounds needed after
> - * handling an interrupt.
> - * @reset: Reset the remote processor.
> - * @reset_fw_ready: Reset firmware ready field.
> - * @is_fw_ready: Check if firmware is ready for OS download.
> - * @send_firmware_intr: Send an interrupt to the card firmware.
> - * @load_mic_fw: Load firmware segments required to boot the card
> - * into card memory. This includes the kernel, command line, ramdisk etc=
.
> - * @get_postcode: Get post code status from firmware.
> - * @dma_filter: DMA filter function to be used.
> - */
> -struct mic_hw_ops {
> -	u8 aper_bar;
> -	u8 mmio_bar;
> -	u32 (*read_spad)(struct mic_device *mdev, unsigned int idx);
> -	void (*write_spad)(struct mic_device *mdev, unsigned int idx, u32
> val);
> -	void (*send_intr)(struct mic_device *mdev, int doorbell);
> -	u32 (*ack_interrupt)(struct mic_device *mdev);
> -	void (*intr_workarounds)(struct mic_device *mdev);
> -	void (*reset)(struct mic_device *mdev);
> -	void (*reset_fw_ready)(struct mic_device *mdev);
> -	bool (*is_fw_ready)(struct mic_device *mdev);
> -	void (*send_firmware_intr)(struct mic_device *mdev);
> -	int (*load_mic_fw)(struct mic_device *mdev, const char *buf);
> -	u32 (*get_postcode)(struct mic_device *mdev);
> -	bool (*dma_filter)(struct dma_chan *chan, void *param);
> -};
> -
> -/**
> - * mic_mmio_read - read from an MMIO register.
> - * @mw: MMIO register base virtual address.
> - * @offset: register offset.
> - *
> - * RETURNS: register value.
> - */
> -static inline u32 mic_mmio_read(struct mic_mw *mw, u32 offset)
> -{
> -	return ioread32(mw->va + offset);
> -}
> -
> -/**
> - * mic_mmio_write - write to an MMIO register.
> - * @mw: MMIO register base virtual address.
> - * @val: the data value to put into the register
> - * @offset: register offset.
> - *
> - * RETURNS: none.
> - */
> -static inline void
> -mic_mmio_write(struct mic_mw *mw, u32 val, u32 offset)
> -{
> -	iowrite32(val, mw->va + offset);
> -}
> -
> -void mic_bootparam_init(struct mic_device *mdev);
> -void mic_create_debug_dir(struct mic_device *dev);
> -void mic_delete_debug_dir(struct mic_device *dev);
> -void __init mic_init_debugfs(void);
> -void mic_exit_debugfs(void);
> -#endif
> diff --git a/drivers/misc/mic/host/mic_intr.c
> b/drivers/misc/mic/host/mic_intr.c
> deleted file mode 100644
> index 85b3221b5d40..000000000000
> --- a/drivers/misc/mic/host/mic_intr.c
> +++ /dev/null
> @@ -1,635 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#include <linux/pci.h>
> -#include <linux/interrupt.h>
> -
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -
> -static irqreturn_t mic_thread_fn(int irq, void *dev)
> -{
> -	struct mic_device *mdev =3D dev;
> -	struct mic_intr_info *intr_info =3D mdev->intr_info;
> -	struct mic_irq_info *irq_info =3D &mdev->irq_info;
> -	struct mic_intr_cb *intr_cb;
> -	struct pci_dev *pdev =3D mdev->pdev;
> -	int i;
> -
> -	spin_lock(&irq_info->mic_thread_lock);
> -	for (i =3D intr_info->intr_start_idx[MIC_INTR_DB];
> -			i < intr_info->intr_len[MIC_INTR_DB]; i++)
> -		if (test_and_clear_bit(i, &irq_info->mask)) {
> -			list_for_each_entry(intr_cb, &irq_info->cb_list[i],
> -					    list)
> -				if (intr_cb->thread_fn)
> -					intr_cb->thread_fn(pdev->irq,
> -							 intr_cb->data);
> -		}
> -	spin_unlock(&irq_info->mic_thread_lock);
> -	return IRQ_HANDLED;
> -}
> -/**
> - * mic_interrupt - Generic interrupt handler for
> - * MSI and INTx based interrupts.
> - * @irq:  interrupt to handle (unused)
> - * @dev: pointer to the mic_device instance
> - */
> -static irqreturn_t mic_interrupt(int irq, void *dev)
> -{
> -	struct mic_device *mdev =3D dev;
> -	struct mic_intr_info *intr_info =3D mdev->intr_info;
> -	struct mic_irq_info *irq_info =3D &mdev->irq_info;
> -	struct mic_intr_cb *intr_cb;
> -	struct pci_dev *pdev =3D mdev->pdev;
> -	u32 mask;
> -	int i;
> -
> -	mask =3D mdev->ops->ack_interrupt(mdev);
> -	if (!mask)
> -		return IRQ_NONE;
> -
> -	spin_lock(&irq_info->mic_intr_lock);
> -	for (i =3D intr_info->intr_start_idx[MIC_INTR_DB];
> -			i < intr_info->intr_len[MIC_INTR_DB]; i++)
> -		if (mask & BIT(i)) {
> -			list_for_each_entry(intr_cb, &irq_info->cb_list[i],
> -					    list)
> -				if (intr_cb->handler)
> -					intr_cb->handler(pdev->irq,
> -							 intr_cb->data);
> -			set_bit(i, &irq_info->mask);
> -		}
> -	spin_unlock(&irq_info->mic_intr_lock);
> -	return IRQ_WAKE_THREAD;
> -}
> -
> -/* Return the interrupt offset from the index. Index is 0 based. */
> -static u16 mic_map_src_to_offset(struct mic_device *mdev,
> -				 int intr_src, enum mic_intr_type type)
> -{
> -	if (type >=3D MIC_NUM_INTR_TYPES)
> -		return MIC_NUM_OFFSETS;
> -	if (intr_src >=3D mdev->intr_info->intr_len[type])
> -		return MIC_NUM_OFFSETS;
> -
> -	return mdev->intr_info->intr_start_idx[type] + intr_src;
> -}
> -
> -/* Return next available msix_entry. */
> -static struct msix_entry *mic_get_available_vector(struct mic_device *md=
ev)
> -{
> -	int i;
> -	struct mic_irq_info *info =3D &mdev->irq_info;
> -
> -	for (i =3D 0; i < info->num_vectors; i++)
> -		if (!info->mic_msi_map[i])
> -			return &info->msix_entries[i];
> -	return NULL;
> -}
> -
> -/**
> - * mic_register_intr_callback - Register a callback handler for the
> - * given source id.
> - *
> - * @mdev: pointer to the mic_device instance
> - * @idx: The source id to be registered.
> - * @handler: The function to be called when the source id receives
> - * the interrupt.
> - * @thread_fn: thread fn. corresponding to the handler
> - * @data: Private data of the requester.
> - * Return the callback structure that was registered or an
> - * appropriate error on failure.
> - */
> -static struct mic_intr_cb *mic_register_intr_callback(struct mic_device
> *mdev,
> -			u8 idx, irq_handler_t handler, irq_handler_t
> thread_fn,
> -			void *data)
> -{
> -	struct mic_intr_cb *intr_cb;
> -	unsigned long flags;
> -	int rc;
> -	intr_cb =3D kmalloc(sizeof(*intr_cb), GFP_KERNEL);
> -
> -	if (!intr_cb)
> -		return ERR_PTR(-ENOMEM);
> -
> -	intr_cb->handler =3D handler;
> -	intr_cb->thread_fn =3D thread_fn;
> -	intr_cb->data =3D data;
> -	intr_cb->cb_id =3D ida_simple_get(&mdev->irq_info.cb_ida,
> -		0, 0, GFP_KERNEL);
> -	if (intr_cb->cb_id < 0) {
> -		rc =3D intr_cb->cb_id;
> -		goto ida_fail;
> -	}
> -
> -	spin_lock(&mdev->irq_info.mic_thread_lock);
> -	spin_lock_irqsave(&mdev->irq_info.mic_intr_lock, flags);
> -	list_add_tail(&intr_cb->list, &mdev->irq_info.cb_list[idx]);
> -	spin_unlock_irqrestore(&mdev->irq_info.mic_intr_lock, flags);
> -	spin_unlock(&mdev->irq_info.mic_thread_lock);
> -
> -	return intr_cb;
> -ida_fail:
> -	kfree(intr_cb);
> -	return ERR_PTR(rc);
> -}
> -
> -/**
> - * mic_unregister_intr_callback - Unregister the callback handler
> - * identified by its callback id.
> - *
> - * @mdev: pointer to the mic_device instance
> - * @idx: The callback structure id to be unregistered.
> - * Return the source id that was unregistered or MIC_NUM_OFFSETS if no
> - * such callback handler was found.
> - */
> -static u8 mic_unregister_intr_callback(struct mic_device *mdev, u32 idx)
> -{
> -	struct list_head *pos, *tmp;
> -	struct mic_intr_cb *intr_cb;
> -	unsigned long flags;
> -	int i;
> -
> -	spin_lock(&mdev->irq_info.mic_thread_lock);
> -	spin_lock_irqsave(&mdev->irq_info.mic_intr_lock, flags);
> -	for (i =3D 0;  i < MIC_NUM_OFFSETS; i++) {
> -		list_for_each_safe(pos, tmp, &mdev->irq_info.cb_list[i]) {
> -			intr_cb =3D list_entry(pos, struct mic_intr_cb, list);
> -			if (intr_cb->cb_id =3D=3D idx) {
> -				list_del(pos);
> -				ida_simple_remove(&mdev->irq_info.cb_ida,
> -						  intr_cb->cb_id);
> -				kfree(intr_cb);
> -				spin_unlock_irqrestore(
> -					&mdev->irq_info.mic_intr_lock, flags);
> -				spin_unlock(&mdev-
> >irq_info.mic_thread_lock);
> -				return i;
> -			}
> -		}
> -	}
> -	spin_unlock_irqrestore(&mdev->irq_info.mic_intr_lock, flags);
> -	spin_unlock(&mdev->irq_info.mic_thread_lock);
> -	return MIC_NUM_OFFSETS;
> -}
> -
> -/**
> - * mic_setup_msix - Initializes MSIx interrupts.
> - *
> - * @mdev: pointer to mic_device instance
> - * @pdev: PCI device structure
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -static int mic_setup_msix(struct mic_device *mdev, struct pci_dev *pdev)
> -{
> -	int rc, i;
> -	int entry_size =3D sizeof(*mdev->irq_info.msix_entries);
> -
> -	mdev->irq_info.msix_entries =3D kmalloc_array(MIC_MIN_MSIX,
> -						    entry_size, GFP_KERNEL);
> -	if (!mdev->irq_info.msix_entries) {
> -		rc =3D -ENOMEM;
> -		goto err_nomem1;
> -	}
> -
> -	for (i =3D 0; i < MIC_MIN_MSIX; i++)
> -		mdev->irq_info.msix_entries[i].entry =3D i;
> -
> -	rc =3D pci_enable_msix_exact(pdev, mdev->irq_info.msix_entries,
> -				   MIC_MIN_MSIX);
> -	if (rc) {
> -		dev_dbg(&pdev->dev, "Error enabling MSIx. rc =3D %d\n", rc);
> -		goto err_enable_msix;
> -	}
> -
> -	mdev->irq_info.num_vectors =3D MIC_MIN_MSIX;
> -	mdev->irq_info.mic_msi_map =3D kzalloc((sizeof(u32) *
> -		mdev->irq_info.num_vectors), GFP_KERNEL);
> -
> -	if (!mdev->irq_info.mic_msi_map) {
> -		rc =3D -ENOMEM;
> -		goto err_nomem2;
> -	}
> -
> -	dev_dbg(&mdev->pdev->dev,
> -		"%d MSIx irqs setup\n", mdev->irq_info.num_vectors);
> -	return 0;
> -err_nomem2:
> -	pci_disable_msix(pdev);
> -err_enable_msix:
> -	kfree(mdev->irq_info.msix_entries);
> -err_nomem1:
> -	mdev->irq_info.num_vectors =3D 0;
> -	return rc;
> -}
> -
> -/**
> - * mic_setup_callbacks - Initialize data structures needed
> - * to handle callbacks.
> - *
> - * @mdev: pointer to mic_device instance
> - */
> -static int mic_setup_callbacks(struct mic_device *mdev)
> -{
> -	int i;
> -
> -	mdev->irq_info.cb_list =3D kmalloc_array(MIC_NUM_OFFSETS,
> -					       sizeof(*mdev->irq_info.cb_list),
> -					       GFP_KERNEL);
> -	if (!mdev->irq_info.cb_list)
> -		return -ENOMEM;
> -
> -	for (i =3D 0; i < MIC_NUM_OFFSETS; i++)
> -		INIT_LIST_HEAD(&mdev->irq_info.cb_list[i]);
> -	ida_init(&mdev->irq_info.cb_ida);
> -	spin_lock_init(&mdev->irq_info.mic_intr_lock);
> -	spin_lock_init(&mdev->irq_info.mic_thread_lock);
> -	return 0;
> -}
> -
> -/**
> - * mic_release_callbacks - Uninitialize data structures needed
> - * to handle callbacks.
> - *
> - * @mdev: pointer to mic_device instance
> - */
> -static void mic_release_callbacks(struct mic_device *mdev)
> -{
> -	unsigned long flags;
> -	struct list_head *pos, *tmp;
> -	struct mic_intr_cb *intr_cb;
> -	int i;
> -
> -	spin_lock(&mdev->irq_info.mic_thread_lock);
> -	spin_lock_irqsave(&mdev->irq_info.mic_intr_lock, flags);
> -	for (i =3D 0; i < MIC_NUM_OFFSETS; i++) {
> -		if (list_empty(&mdev->irq_info.cb_list[i]))
> -			break;
> -
> -		list_for_each_safe(pos, tmp, &mdev->irq_info.cb_list[i]) {
> -			intr_cb =3D list_entry(pos, struct mic_intr_cb, list);
> -			list_del(pos);
> -			ida_simple_remove(&mdev->irq_info.cb_ida,
> -					  intr_cb->cb_id);
> -			kfree(intr_cb);
> -		}
> -	}
> -	spin_unlock_irqrestore(&mdev->irq_info.mic_intr_lock, flags);
> -	spin_unlock(&mdev->irq_info.mic_thread_lock);
> -	ida_destroy(&mdev->irq_info.cb_ida);
> -	kfree(mdev->irq_info.cb_list);
> -}
> -
> -/**
> - * mic_setup_msi - Initializes MSI interrupts.
> - *
> - * @mdev: pointer to mic_device instance
> - * @pdev: PCI device structure
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -static int mic_setup_msi(struct mic_device *mdev, struct pci_dev *pdev)
> -{
> -	int rc;
> -
> -	rc =3D pci_enable_msi(pdev);
> -	if (rc) {
> -		dev_dbg(&pdev->dev, "Error enabling MSI. rc =3D %d\n", rc);
> -		return rc;
> -	}
> -
> -	mdev->irq_info.num_vectors =3D 1;
> -	mdev->irq_info.mic_msi_map =3D kzalloc((sizeof(u32) *
> -		mdev->irq_info.num_vectors), GFP_KERNEL);
> -
> -	if (!mdev->irq_info.mic_msi_map) {
> -		rc =3D -ENOMEM;
> -		goto err_nomem1;
> -	}
> -
> -	rc =3D mic_setup_callbacks(mdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "Error setting up callbacks\n");
> -		goto err_nomem2;
> -	}
> -
> -	rc =3D request_threaded_irq(pdev->irq, mic_interrupt, mic_thread_fn,
> -				  0, "mic-msi", mdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "Error allocating MSI interrupt\n");
> -		goto err_irq_req_fail;
> -	}
> -
> -	dev_dbg(&pdev->dev, "%d MSI irqs setup\n", mdev-
> >irq_info.num_vectors);
> -	return 0;
> -err_irq_req_fail:
> -	mic_release_callbacks(mdev);
> -err_nomem2:
> -	kfree(mdev->irq_info.mic_msi_map);
> -err_nomem1:
> -	pci_disable_msi(pdev);
> -	mdev->irq_info.num_vectors =3D 0;
> -	return rc;
> -}
> -
> -/**
> - * mic_setup_intx - Initializes legacy interrupts.
> - *
> - * @mdev: pointer to mic_device instance
> - * @pdev: PCI device structure
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -static int mic_setup_intx(struct mic_device *mdev, struct pci_dev *pdev)
> -{
> -	int rc;
> -
> -	/* Enable intx */
> -	pci_intx(pdev, 1);
> -	rc =3D mic_setup_callbacks(mdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "Error setting up callbacks\n");
> -		goto err_nomem;
> -	}
> -
> -	rc =3D request_threaded_irq(pdev->irq, mic_interrupt, mic_thread_fn,
> -				  IRQF_SHARED, "mic-intx", mdev);
> -	if (rc)
> -		goto err;
> -
> -	dev_dbg(&pdev->dev, "intx irq setup\n");
> -	return 0;
> -err:
> -	mic_release_callbacks(mdev);
> -err_nomem:
> -	return rc;
> -}
> -
> -/**
> - * mic_next_db - Retrieve the next doorbell interrupt source id.
> - * The id is picked sequentially from the available pool of
> - * doorlbell ids.
> - *
> - * @mdev: pointer to the mic_device instance.
> - *
> - * Returns the next doorbell interrupt source.
> - */
> -int mic_next_db(struct mic_device *mdev)
> -{
> -	int next_db;
> -
> -	next_db =3D mdev->irq_info.next_avail_src %
> -		mdev->intr_info->intr_len[MIC_INTR_DB];
> -	mdev->irq_info.next_avail_src++;
> -	return next_db;
> -}
> -
> -#define COOKIE_ID_SHIFT 16
> -#define GET_ENTRY(cookie) ((cookie) & 0xFFFF)
> -#define GET_OFFSET(cookie) ((cookie) >> COOKIE_ID_SHIFT)
> -#define MK_COOKIE(x, y) ((x) | (y) << COOKIE_ID_SHIFT)
> -
> -/**
> - * mic_request_threaded_irq - request an irq. mic_mutex needs
> - * to be held before calling this function.
> - *
> - * @mdev: pointer to mic_device instance
> - * @handler: The callback function that handles the interrupt.
> - * The function needs to call ack_interrupts
> - * (mdev->ops->ack_interrupt(mdev)) when handling the interrupts.
> - * @thread_fn: thread fn required by request_threaded_irq.
> - * @name: The ASCII name of the callee requesting the irq.
> - * @data: private data that is returned back when calling the
> - * function handler.
> - * @intr_src: The source id of the requester. Its the doorbell id
> - * for Doorbell interrupts and DMA channel id for DMA interrupts.
> - * @type: The type of interrupt. Values defined in mic_intr_type
> - *
> - * returns: The cookie that is transparent to the caller. Passed
> - * back when calling mic_free_irq. An appropriate error code
> - * is returned on failure. Caller needs to use IS_ERR(return_val)
> - * to check for failure and PTR_ERR(return_val) to obtained the
> - * error code.
> - *
> - */
> -struct mic_irq *
> -mic_request_threaded_irq(struct mic_device *mdev,
> -			 irq_handler_t handler, irq_handler_t thread_fn,
> -			 const char *name, void *data, int intr_src,
> -			 enum mic_intr_type type)
> -{
> -	u16 offset;
> -	int rc =3D 0;
> -	struct msix_entry *msix =3D NULL;
> -	unsigned long cookie =3D 0;
> -	u16 entry;
> -	struct mic_intr_cb *intr_cb;
> -	struct pci_dev *pdev =3D mdev->pdev;
> -
> -	offset =3D mic_map_src_to_offset(mdev, intr_src, type);
> -	if (offset >=3D MIC_NUM_OFFSETS) {
> -		dev_err(&mdev->pdev->dev,
> -			"Error mapping index %d to a valid source id.\n",
> -			intr_src);
> -		rc =3D -EINVAL;
> -		goto err;
> -	}
> -
> -	if (mdev->irq_info.num_vectors > 1) {
> -		msix =3D mic_get_available_vector(mdev);
> -		if (!msix) {
> -			dev_err(&mdev->pdev->dev,
> -				"No MSIx vectors available for use.\n");
> -			rc =3D -ENOSPC;
> -			goto err;
> -		}
> -
> -		rc =3D request_threaded_irq(msix->vector, handler, thread_fn,
> -					  0, name, data);
> -		if (rc) {
> -			dev_dbg(&mdev->pdev->dev,
> -				"request irq failed rc =3D %d\n", rc);
> -			goto err;
> -		}
> -		entry =3D msix->entry;
> -		mdev->irq_info.mic_msi_map[entry] |=3D BIT(offset);
> -		mdev->intr_ops->program_msi_to_src_map(mdev,
> -				entry, offset, true);
> -		cookie =3D MK_COOKIE(entry, offset);
> -		dev_dbg(&mdev->pdev->dev, "irq: %d assigned for
> src: %d\n",
> -			msix->vector, intr_src);
> -	} else {
> -		intr_cb =3D mic_register_intr_callback(mdev, offset, handler,
> -						     thread_fn, data);
> -		if (IS_ERR(intr_cb)) {
> -			dev_err(&mdev->pdev->dev,
> -				"No available callback entries for use\n");
> -			rc =3D PTR_ERR(intr_cb);
> -			goto err;
> -		}
> -
> -		entry =3D 0;
> -		if (pci_dev_msi_enabled(pdev)) {
> -			mdev->irq_info.mic_msi_map[entry] |=3D (1 << offset);
> -			mdev->intr_ops->program_msi_to_src_map(mdev,
> -				entry, offset, true);
> -		}
> -		cookie =3D MK_COOKIE(entry, intr_cb->cb_id);
> -		dev_dbg(&mdev->pdev->dev, "callback %d registered for
> src: %d\n",
> -			intr_cb->cb_id, intr_src);
> -	}
> -	return (struct mic_irq *)cookie;
> -err:
> -	return ERR_PTR(rc);
> -}
> -
> -/**
> - * mic_free_irq - free irq. mic_mutex
> - *  needs to be held before calling this function.
> - *
> - * @mdev: pointer to mic_device instance
> - * @cookie: cookie obtained during a successful call to
> mic_request_threaded_irq
> - * @data: private data specified by the calling function during the
> - * mic_request_threaded_irq
> - *
> - * returns: none.
> - */
> -void mic_free_irq(struct mic_device *mdev,
> -		  struct mic_irq *cookie, void *data)
> -{
> -	u32 offset;
> -	u32 entry;
> -	u8 src_id;
> -	unsigned int irq;
> -	struct pci_dev *pdev =3D mdev->pdev;
> -
> -	entry =3D GET_ENTRY((unsigned long)cookie);
> -	offset =3D GET_OFFSET((unsigned long)cookie);
> -	if (mdev->irq_info.num_vectors > 1) {
> -		if (entry >=3D mdev->irq_info.num_vectors) {
> -			dev_warn(&mdev->pdev->dev,
> -				 "entry %d should be < num_irq %d\n",
> -				entry, mdev->irq_info.num_vectors);
> -			return;
> -		}
> -		irq =3D mdev->irq_info.msix_entries[entry].vector;
> -		free_irq(irq, data);
> -		mdev->irq_info.mic_msi_map[entry] &=3D ~(BIT(offset));
> -		mdev->intr_ops->program_msi_to_src_map(mdev,
> -			entry, offset, false);
> -
> -		dev_dbg(&mdev->pdev->dev, "irq: %d freed\n", irq);
> -	} else {
> -		irq =3D pdev->irq;
> -		src_id =3D mic_unregister_intr_callback(mdev, offset);
> -		if (src_id >=3D MIC_NUM_OFFSETS) {
> -			dev_warn(&mdev->pdev->dev, "Error unregistering
> callback\n");
> -			return;
> -		}
> -		if (pci_dev_msi_enabled(pdev)) {
> -			mdev->irq_info.mic_msi_map[entry] &=3D
> ~(BIT(src_id));
> -			mdev->intr_ops->program_msi_to_src_map(mdev,
> -				entry, src_id, false);
> -		}
> -		dev_dbg(&mdev->pdev->dev, "callback %d unregistered for
> src: %d\n",
> -			offset, src_id);
> -	}
> -}
> -
> -/**
> - * mic_setup_interrupts - Initializes interrupts.
> - *
> - * @mdev: pointer to mic_device instance
> - * @pdev: PCI device structure
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -int mic_setup_interrupts(struct mic_device *mdev, struct pci_dev *pdev)
> -{
> -	int rc;
> -
> -	rc =3D mic_setup_msix(mdev, pdev);
> -	if (!rc)
> -		goto done;
> -
> -	rc =3D mic_setup_msi(mdev, pdev);
> -	if (!rc)
> -		goto done;
> -
> -	rc =3D mic_setup_intx(mdev, pdev);
> -	if (rc) {
> -		dev_err(&mdev->pdev->dev, "no usable interrupts\n");
> -		return rc;
> -	}
> -done:
> -	mdev->intr_ops->enable_interrupts(mdev);
> -	return 0;
> -}
> -
> -/**
> - * mic_free_interrupts - Frees interrupts setup by mic_setup_interrupts
> - *
> - * @mdev: pointer to mic_device instance
> - * @pdev: PCI device structure
> - *
> - * returns none.
> - */
> -void mic_free_interrupts(struct mic_device *mdev, struct pci_dev *pdev)
> -{
> -	int i;
> -
> -	mdev->intr_ops->disable_interrupts(mdev);
> -	if (mdev->irq_info.num_vectors > 1) {
> -		for (i =3D 0; i < mdev->irq_info.num_vectors; i++) {
> -			if (mdev->irq_info.mic_msi_map[i])
> -				dev_warn(&pdev->dev, "irq %d may still be in
> use.\n",
> -					 mdev-
> >irq_info.msix_entries[i].vector);
> -		}
> -		kfree(mdev->irq_info.mic_msi_map);
> -		kfree(mdev->irq_info.msix_entries);
> -		pci_disable_msix(pdev);
> -	} else {
> -		if (pci_dev_msi_enabled(pdev)) {
> -			free_irq(pdev->irq, mdev);
> -			kfree(mdev->irq_info.mic_msi_map);
> -			pci_disable_msi(pdev);
> -		} else {
> -			free_irq(pdev->irq, mdev);
> -		}
> -		mic_release_callbacks(mdev);
> -	}
> -}
> -
> -/**
> - * mic_intr_restore - Restore MIC interrupt registers.
> - *
> - * @mdev: pointer to mic_device instance.
> - *
> - * Restore the interrupt registers to values previously
> - * stored in the SW data structures. mic_mutex needs to
> - * be held before calling this function.
> - *
> - * returns None.
> - */
> -void mic_intr_restore(struct mic_device *mdev)
> -{
> -	int entry, offset;
> -	struct pci_dev *pdev =3D mdev->pdev;
> -
> -	if (!pci_dev_msi_enabled(pdev))
> -		return;
> -
> -	for (entry =3D 0; entry < mdev->irq_info.num_vectors; entry++) {
> -		for (offset =3D 0; offset < MIC_NUM_OFFSETS; offset++) {
> -			if (mdev->irq_info.mic_msi_map[entry] & BIT(offset))
> -				mdev->intr_ops-
> >program_msi_to_src_map(mdev,
> -					entry, offset, true);
> -		}
> -	}
> -}
> diff --git a/drivers/misc/mic/host/mic_intr.h
> b/drivers/misc/mic/host/mic_intr.h
> deleted file mode 100644
> index b14ba818006f..000000000000
> --- a/drivers/misc/mic/host/mic_intr.h
> +++ /dev/null
> @@ -1,137 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#ifndef _MIC_INTR_H_
> -#define _MIC_INTR_H_
> -
> -#include <linux/bitops.h>
> -#include <linux/interrupt.h>
> -/*
> - * The minimum number of msix vectors required for normal operation.
> - * 3 for virtio network, console and block devices.
> - * 1 for card shutdown notifications.
> - * 4 for host owned DMA channels.
> - * 1 for SCIF
> - */
> -#define MIC_MIN_MSIX 9
> -#define MIC_NUM_OFFSETS 32
> -
> -/**
> - * mic_intr_source - The type of source that will generate
> - * the interrupt.The number of types needs to be in sync with
> - * MIC_NUM_INTR_TYPES
> - *
> - * MIC_INTR_DB: The source is a doorbell
> - * MIC_INTR_DMA: The source is a DMA channel
> - * MIC_INTR_ERR: The source is an error interrupt e.g. SBOX ERR
> - * MIC_NUM_INTR_TYPES: Total number of interrupt sources.
> - */
> -enum mic_intr_type {
> -	MIC_INTR_DB =3D 0,
> -	MIC_INTR_DMA,
> -	MIC_INTR_ERR,
> -	MIC_NUM_INTR_TYPES
> -};
> -
> -/**
> - * struct mic_intr_info - Contains h/w specific interrupt sources
> - * information.
> - *
> - * @intr_start_idx: Contains the starting indexes of the
> - * interrupt types.
> - * @intr_len: Contains the length of the interrupt types.
> - */
> -struct mic_intr_info {
> -	u16 intr_start_idx[MIC_NUM_INTR_TYPES];
> -	u16 intr_len[MIC_NUM_INTR_TYPES];
> -};
> -
> -/**
> - * struct mic_irq_info - OS specific irq information
> - *
> - * @next_avail_src: next available doorbell that can be assigned.
> - * @msix_entries: msix entries allocated while setting up MSI-x
> - * @mic_msi_map: The MSI/MSI-x mapping information.
> - * @num_vectors: The number of MSI/MSI-x vectors that have been
> allocated.
> - * @cb_ida: callback ID allocator to track the callbacks registered.
> - * @mic_intr_lock: spinlock to protect the interrupt callback list.
> - * @mic_thread_lock: spinlock to protect the thread callback list.
> - *		   This lock is used to protect against thread_fn while
> - *		   mic_intr_lock is used to protect against interrupt handler.
> - * @cb_list: Array of callback lists one for each source.
> - * @mask: Mask used by the main thread fn to call the underlying thread =
fns.
> - */
> -struct mic_irq_info {
> -	int next_avail_src;
> -	struct msix_entry *msix_entries;
> -	u32 *mic_msi_map;
> -	u16 num_vectors;
> -	struct ida cb_ida;
> -	spinlock_t mic_intr_lock;
> -	spinlock_t mic_thread_lock;
> -	struct list_head *cb_list;
> -	unsigned long mask;
> -};
> -
> -/**
> - * struct mic_intr_cb - Interrupt callback structure.
> - *
> - * @handler: The callback function
> - * @thread_fn: The thread_fn.
> - * @data: Private data of the requester.
> - * @cb_id: The callback id. Identifies this callback.
> - * @list: list head pointing to the next callback structure.
> - */
> -struct mic_intr_cb {
> -	irq_handler_t handler;
> -	irq_handler_t thread_fn;
> -	void *data;
> -	int cb_id;
> -	struct list_head list;
> -};
> -
> -/**
> - * struct mic_irq - opaque pointer used as cookie
> - */
> -struct mic_irq;
> -
> -/* Forward declaration */
> -struct mic_device;
> -
> -/**
> - * struct mic_hw_intr_ops: MIC HW specific interrupt operations
> - * @intr_init: Initialize H/W specific interrupt information.
> - * @enable_interrupts: Enable interrupts from the hardware.
> - * @disable_interrupts: Disable interrupts from the hardware.
> - * @program_msi_to_src_map: Update MSI mapping registers with
> - * irq information.
> - * @read_msi_to_src_map: Read MSI mapping registers containing
> - * irq information.
> - */
> -struct mic_hw_intr_ops {
> -	void (*intr_init)(struct mic_device *mdev);
> -	void (*enable_interrupts)(struct mic_device *mdev);
> -	void (*disable_interrupts)(struct mic_device *mdev);
> -	void (*program_msi_to_src_map) (struct mic_device *mdev,
> -			int idx, int intr_src, bool set);
> -	u32 (*read_msi_to_src_map) (struct mic_device *mdev,
> -			int idx);
> -};
> -
> -int mic_next_db(struct mic_device *mdev);
> -struct mic_irq *
> -mic_request_threaded_irq(struct mic_device *mdev,
> -			 irq_handler_t handler, irq_handler_t thread_fn,
> -			 const char *name, void *data, int intr_src,
> -			 enum mic_intr_type type);
> -void mic_free_irq(struct mic_device *mdev,
> -		struct mic_irq *cookie, void *data);
> -int mic_setup_interrupts(struct mic_device *mdev, struct pci_dev *pdev);
> -void mic_free_interrupts(struct mic_device *mdev, struct pci_dev *pdev);
> -void mic_intr_restore(struct mic_device *mdev);
> -#endif
> diff --git a/drivers/misc/mic/host/mic_main.c
> b/drivers/misc/mic/host/mic_main.c
> deleted file mode 100644
> index ea4608527ea0..000000000000
> --- a/drivers/misc/mic/host/mic_main.c
> +++ /dev/null
> @@ -1,335 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#include <linux/fs.h>
> -#include <linux/module.h>
> -#include <linux/pci.h>
> -#include <linux/poll.h>
> -
> -#include <linux/mic_common.h>
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -#include "mic_x100.h"
> -#include "mic_smpt.h"
> -
> -static const char mic_driver_name[] =3D "mic";
> -
> -static const struct pci_device_id mic_pci_tbl[] =3D {
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2250)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2251)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2252)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2253)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2254)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2255)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2256)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2257)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2258)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_2259)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_225a)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_225b)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_225c)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_225d)},
> -	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, MIC_X100_PCI_DEVICE_225e)},
> -
> -	/* required last entry */
> -	{ 0, }
> -};
> -
> -MODULE_DEVICE_TABLE(pci, mic_pci_tbl);
> -
> -/* ID allocator for MIC devices */
> -static struct ida g_mic_ida;
> -
> -/* Initialize the device page */
> -static int mic_dp_init(struct mic_device *mdev)
> -{
> -	mdev->dp =3D kzalloc(MIC_DP_SIZE, GFP_KERNEL);
> -	if (!mdev->dp)
> -		return -ENOMEM;
> -
> -	mdev->dp_dma_addr =3D mic_map_single(mdev,
> -		mdev->dp, MIC_DP_SIZE);
> -	if (mic_map_error(mdev->dp_dma_addr)) {
> -		kfree(mdev->dp);
> -		dev_err(&mdev->pdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, -ENOMEM);
> -		return -ENOMEM;
> -	}
> -	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev-
> >dp_dma_addr);
> -	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev-
> >dp_dma_addr >> 32);
> -	return 0;
> -}
> -
> -/* Uninitialize the device page */
> -static void mic_dp_uninit(struct mic_device *mdev)
> -{
> -	mic_unmap_single(mdev, mdev->dp_dma_addr, MIC_DP_SIZE);
> -	kfree(mdev->dp);
> -}
> -
> -/**
> - * mic_ops_init: Initialize HW specific operation tables.
> - *
> - * @mdev: pointer to mic_device instance
> - *
> - * returns none.
> - */
> -static void mic_ops_init(struct mic_device *mdev)
> -{
> -	switch (mdev->family) {
> -	case MIC_FAMILY_X100:
> -		mdev->ops =3D &mic_x100_ops;
> -		mdev->intr_ops =3D &mic_x100_intr_ops;
> -		mdev->smpt_ops =3D &mic_x100_smpt_ops;
> -		break;
> -	default:
> -		break;
> -	}
> -}
> -
> -/**
> - * mic_get_family - Determine hardware family to which this MIC belongs.
> - *
> - * @pdev: The pci device structure
> - *
> - * returns family.
> - */
> -static enum mic_hw_family mic_get_family(struct pci_dev *pdev)
> -{
> -	enum mic_hw_family family;
> -
> -	switch (pdev->device) {
> -	case MIC_X100_PCI_DEVICE_2250:
> -	case MIC_X100_PCI_DEVICE_2251:
> -	case MIC_X100_PCI_DEVICE_2252:
> -	case MIC_X100_PCI_DEVICE_2253:
> -	case MIC_X100_PCI_DEVICE_2254:
> -	case MIC_X100_PCI_DEVICE_2255:
> -	case MIC_X100_PCI_DEVICE_2256:
> -	case MIC_X100_PCI_DEVICE_2257:
> -	case MIC_X100_PCI_DEVICE_2258:
> -	case MIC_X100_PCI_DEVICE_2259:
> -	case MIC_X100_PCI_DEVICE_225a:
> -	case MIC_X100_PCI_DEVICE_225b:
> -	case MIC_X100_PCI_DEVICE_225c:
> -	case MIC_X100_PCI_DEVICE_225d:
> -	case MIC_X100_PCI_DEVICE_225e:
> -		family =3D MIC_FAMILY_X100;
> -		break;
> -	default:
> -		family =3D MIC_FAMILY_UNKNOWN;
> -		break;
> -	}
> -	return family;
> -}
> -
> -/**
> - * mic_device_init - Allocates and initializes the MIC device structure
> - *
> - * @mdev: pointer to mic_device instance
> - * @pdev: The pci device structure
> - *
> - * returns none.
> - */
> -static void
> -mic_device_init(struct mic_device *mdev, struct pci_dev *pdev)
> -{
> -	mdev->pdev =3D pdev;
> -	mdev->family =3D mic_get_family(pdev);
> -	mdev->stepping =3D pdev->revision;
> -	mic_ops_init(mdev);
> -	mutex_init(&mdev->mic_mutex);
> -	mdev->irq_info.next_avail_src =3D 0;
> -}
> -
> -/**
> - * mic_probe - Device Initialization Routine
> - *
> - * @pdev: PCI device structure
> - * @ent: entry in mic_pci_tbl
> - *
> - * returns 0 on success, < 0 on failure.
> - */
> -static int mic_probe(struct pci_dev *pdev,
> -		     const struct pci_device_id *ent)
> -{
> -	int rc;
> -	struct mic_device *mdev;
> -
> -	mdev =3D kzalloc(sizeof(*mdev), GFP_KERNEL);
> -	if (!mdev) {
> -		rc =3D -ENOMEM;
> -		goto mdev_alloc_fail;
> -	}
> -	mdev->id =3D ida_simple_get(&g_mic_ida, 0, MIC_MAX_NUM_DEVS,
> GFP_KERNEL);
> -	if (mdev->id < 0) {
> -		rc =3D mdev->id;
> -		dev_err(&pdev->dev, "ida_simple_get failed rc %d\n", rc);
> -		goto ida_fail;
> -	}
> -
> -	mic_device_init(mdev, pdev);
> -
> -	rc =3D pci_enable_device(pdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "failed to enable pci device.\n");
> -		goto ida_remove;
> -	}
> -
> -	pci_set_master(pdev);
> -
> -	rc =3D pci_request_regions(pdev, mic_driver_name);
> -	if (rc) {
> -		dev_err(&pdev->dev, "failed to get pci regions.\n");
> -		goto disable_device;
> -	}
> -
> -	rc =3D pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (rc) {
> -		dev_err(&pdev->dev, "Cannot set DMA mask\n");
> -		goto release_regions;
> -	}
> -
> -	mdev->mmio.pa =3D pci_resource_start(pdev, mdev->ops->mmio_bar);
> -	mdev->mmio.len =3D pci_resource_len(pdev, mdev->ops->mmio_bar);
> -	mdev->mmio.va =3D pci_ioremap_bar(pdev, mdev->ops->mmio_bar);
> -	if (!mdev->mmio.va) {
> -		dev_err(&pdev->dev, "Cannot remap MMIO BAR\n");
> -		rc =3D -EIO;
> -		goto release_regions;
> -	}
> -
> -	mdev->aper.pa =3D pci_resource_start(pdev, mdev->ops->aper_bar);
> -	mdev->aper.len =3D pci_resource_len(pdev, mdev->ops->aper_bar);
> -	mdev->aper.va =3D ioremap_wc(mdev->aper.pa, mdev->aper.len);
> -	if (!mdev->aper.va) {
> -		dev_err(&pdev->dev, "Cannot remap Aperture BAR\n");
> -		rc =3D -EIO;
> -		goto unmap_mmio;
> -	}
> -
> -	mdev->intr_ops->intr_init(mdev);
> -	rc =3D mic_setup_interrupts(mdev, pdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "mic_setup_interrupts failed %d\n", rc);
> -		goto unmap_aper;
> -	}
> -	rc =3D mic_smpt_init(mdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "smpt_init failed %d\n", rc);
> -		goto free_interrupts;
> -	}
> -
> -	pci_set_drvdata(pdev, mdev);
> -
> -	rc =3D mic_dp_init(mdev);
> -	if (rc) {
> -		dev_err(&pdev->dev, "mic_dp_init failed rc %d\n", rc);
> -		goto smpt_uninit;
> -	}
> -	mic_bootparam_init(mdev);
> -	mic_create_debug_dir(mdev);
> -
> -	mdev->cosm_dev =3D cosm_register_device(&mdev->pdev->dev,
> &cosm_hw_ops);
> -	if (IS_ERR(mdev->cosm_dev)) {
> -		rc =3D PTR_ERR(mdev->cosm_dev);
> -		dev_err(&pdev->dev, "cosm_add_device failed rc %d\n", rc);
> -		goto cleanup_debug_dir;
> -	}
> -	return 0;
> -cleanup_debug_dir:
> -	mic_delete_debug_dir(mdev);
> -	mic_dp_uninit(mdev);
> -smpt_uninit:
> -	mic_smpt_uninit(mdev);
> -free_interrupts:
> -	mic_free_interrupts(mdev, pdev);
> -unmap_aper:
> -	iounmap(mdev->aper.va);
> -unmap_mmio:
> -	iounmap(mdev->mmio.va);
> -release_regions:
> -	pci_release_regions(pdev);
> -disable_device:
> -	pci_disable_device(pdev);
> -ida_remove:
> -	ida_simple_remove(&g_mic_ida, mdev->id);
> -ida_fail:
> -	kfree(mdev);
> -mdev_alloc_fail:
> -	dev_err(&pdev->dev, "Probe failed rc %d\n", rc);
> -	return rc;
> -}
> -
> -/**
> - * mic_remove - Device Removal Routine
> - * mic_remove is called by the PCI subsystem to alert the driver
> - * that it should release a PCI device.
> - *
> - * @pdev: PCI device structure
> - */
> -static void mic_remove(struct pci_dev *pdev)
> -{
> -	struct mic_device *mdev;
> -
> -	mdev =3D pci_get_drvdata(pdev);
> -	if (!mdev)
> -		return;
> -
> -	cosm_unregister_device(mdev->cosm_dev);
> -	mic_delete_debug_dir(mdev);
> -	mic_dp_uninit(mdev);
> -	mic_smpt_uninit(mdev);
> -	mic_free_interrupts(mdev, pdev);
> -	iounmap(mdev->aper.va);
> -	iounmap(mdev->mmio.va);
> -	pci_release_regions(pdev);
> -	pci_disable_device(pdev);
> -	ida_simple_remove(&g_mic_ida, mdev->id);
> -	kfree(mdev);
> -}
> -
> -static struct pci_driver mic_driver =3D {
> -	.name =3D mic_driver_name,
> -	.id_table =3D mic_pci_tbl,
> -	.probe =3D mic_probe,
> -	.remove =3D mic_remove
> -};
> -
> -static int __init mic_init(void)
> -{
> -	int ret;
> -
> -	request_module("mic_x100_dma");
> -	mic_init_debugfs();
> -	ida_init(&g_mic_ida);
> -	ret =3D pci_register_driver(&mic_driver);
> -	if (ret) {
> -		pr_err("pci_register_driver failed ret %d\n", ret);
> -		goto cleanup_debugfs;
> -	}
> -	return 0;
> -cleanup_debugfs:
> -	ida_destroy(&g_mic_ida);
> -	mic_exit_debugfs();
> -	return ret;
> -}
> -
> -static void __exit mic_exit(void)
> -{
> -	pci_unregister_driver(&mic_driver);
> -	ida_destroy(&g_mic_ida);
> -	mic_exit_debugfs();
> -}
> -
> -module_init(mic_init);
> -module_exit(mic_exit);
> -
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) MIC X100 Host driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/host/mic_smpt.c
> b/drivers/misc/mic/host/mic_smpt.c
> deleted file mode 100644
> index 50d1bebecd54..000000000000
> --- a/drivers/misc/mic/host/mic_smpt.c
> +++ /dev/null
> @@ -1,427 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#include <linux/pci.h>
> -
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -#include "mic_smpt.h"
> -
> -static inline u64 mic_system_page_mask(struct mic_device *mdev)
> -{
> -	return (1ULL << mdev->smpt->info.page_shift) - 1ULL;
> -}
> -
> -static inline u8 mic_sys_addr_to_smpt(struct mic_device *mdev,
> dma_addr_t pa)
> -{
> -	return (pa - mdev->smpt->info.base) >> mdev->smpt-
> >info.page_shift;
> -}
> -
> -static inline u64 mic_smpt_to_pa(struct mic_device *mdev, u8 index)
> -{
> -	return mdev->smpt->info.base + (index * mdev->smpt-
> >info.page_size);
> -}
> -
> -static inline u64 mic_smpt_offset(struct mic_device *mdev, dma_addr_t pa=
)
> -{
> -	return pa & mic_system_page_mask(mdev);
> -}
> -
> -static inline u64 mic_smpt_align_low(struct mic_device *mdev, dma_addr_t
> pa)
> -{
> -	return ALIGN(pa - mic_system_page_mask(mdev),
> -		mdev->smpt->info.page_size);
> -}
> -
> -static inline u64 mic_smpt_align_high(struct mic_device *mdev, dma_addr_=
t
> pa)
> -{
> -	return ALIGN(pa, mdev->smpt->info.page_size);
> -}
> -
> -/* Total Cumulative system memory accessible by MIC across all SMPT
> entries */
> -static inline u64 mic_max_system_memory(struct mic_device *mdev)
> -{
> -	return mdev->smpt->info.num_reg * mdev->smpt->info.page_size;
> -}
> -
> -/* Maximum system memory address accessible by MIC */
> -static inline u64 mic_max_system_addr(struct mic_device *mdev)
> -{
> -	return mdev->smpt->info.base + mic_max_system_memory(mdev) -
> 1ULL;
> -}
> -
> -/* Check if the DMA address is a MIC system memory address */
> -static inline bool
> -mic_is_system_addr(struct mic_device *mdev, dma_addr_t pa)
> -{
> -	return pa >=3D mdev->smpt->info.base && pa <=3D
> mic_max_system_addr(mdev);
> -}
> -
> -/* Populate an SMPT entry and update the reference counts. */
> -static void mic_add_smpt_entry(int spt, s64 *ref, u64 addr,
> -			       int entries, struct mic_device *mdev)
> -{
> -	struct mic_smpt_info *smpt_info =3D mdev->smpt;
> -	int i;
> -
> -	for (i =3D spt; i < spt + entries; i++,
> -		addr +=3D smpt_info->info.page_size) {
> -		if (!smpt_info->entry[i].ref_count &&
> -		    (smpt_info->entry[i].dma_addr !=3D addr)) {
> -			mdev->smpt_ops->set(mdev, addr, i);
> -			smpt_info->entry[i].dma_addr =3D addr;
> -		}
> -		smpt_info->entry[i].ref_count +=3D ref[i - spt];
> -	}
> -}
> -
> -/*
> - * Find an available MIC address in MIC SMPT address space
> - * for a given DMA address and size.
> - */
> -static dma_addr_t mic_smpt_op(struct mic_device *mdev, u64 dma_addr,
> -			      int entries, s64 *ref, size_t size)
> -{
> -	int spt;
> -	int ae =3D 0;
> -	int i;
> -	unsigned long flags;
> -	dma_addr_t mic_addr =3D 0;
> -	dma_addr_t addr =3D dma_addr;
> -	struct mic_smpt_info *smpt_info =3D mdev->smpt;
> -
> -	spin_lock_irqsave(&smpt_info->smpt_lock, flags);
> -
> -	/* find existing entries */
> -	for (i =3D 0; i < smpt_info->info.num_reg; i++) {
> -		if (smpt_info->entry[i].dma_addr =3D=3D addr) {
> -			ae++;
> -			addr +=3D smpt_info->info.page_size;
> -		} else if (ae) /* cannot find contiguous entries */
> -			goto not_found;
> -
> -		if (ae =3D=3D entries)
> -			goto found;
> -	}
> -
> -	/* find free entry */
> -	for (ae =3D 0, i =3D 0; i < smpt_info->info.num_reg; i++) {
> -		ae =3D (smpt_info->entry[i].ref_count =3D=3D 0) ? ae + 1 : 0;
> -		if (ae =3D=3D entries)
> -			goto found;
> -	}
> -
> -not_found:
> -	spin_unlock_irqrestore(&smpt_info->smpt_lock, flags);
> -	return mic_addr;
> -
> -found:
> -	spt =3D i - entries + 1;
> -	mic_addr =3D mic_smpt_to_pa(mdev, spt);
> -	mic_add_smpt_entry(spt, ref, dma_addr, entries, mdev);
> -	smpt_info->map_count++;
> -	smpt_info->ref_count +=3D (s64)size;
> -	spin_unlock_irqrestore(&smpt_info->smpt_lock, flags);
> -	return mic_addr;
> -}
> -
> -/*
> - * Returns number of smpt entries needed for dma_addr to dma_addr + size
> - * also returns the reference count array for each of those entries
> - * and the starting smpt address
> - */
> -static int mic_get_smpt_ref_count(struct mic_device *mdev, dma_addr_t
> dma_addr,
> -				  size_t size, s64 *ref,  u64 *smpt_start)
> -{
> -	u64 start =3D  dma_addr;
> -	u64 end =3D dma_addr + size;
> -	int i =3D 0;
> -
> -	while (start < end) {
> -		ref[i++] =3D min(mic_smpt_align_high(mdev, start + 1),
> -			end) - start;
> -		start =3D mic_smpt_align_high(mdev, start + 1);
> -	}
> -
> -	if (smpt_start)
> -		*smpt_start =3D mic_smpt_align_low(mdev, dma_addr);
> -
> -	return i;
> -}
> -
> -/*
> - * mic_to_dma_addr - Converts a MIC address to a DMA address.
> - *
> - * @mdev: pointer to mic_device instance.
> - * @mic_addr: MIC address.
> - *
> - * returns a DMA address.
> - */
> -dma_addr_t mic_to_dma_addr(struct mic_device *mdev, dma_addr_t
> mic_addr)
> -{
> -	struct mic_smpt_info *smpt_info =3D mdev->smpt;
> -	int spt;
> -	dma_addr_t dma_addr;
> -
> -	if (!mic_is_system_addr(mdev, mic_addr)) {
> -		dev_err(&mdev->pdev->dev,
> -			"mic_addr is invalid. mic_addr =3D 0x%llx\n", mic_addr);
> -		return -EINVAL;
> -	}
> -	spt =3D mic_sys_addr_to_smpt(mdev, mic_addr);
> -	dma_addr =3D smpt_info->entry[spt].dma_addr +
> -		mic_smpt_offset(mdev, mic_addr);
> -	return dma_addr;
> -}
> -
> -/**
> - * mic_map - Maps a DMA address to a MIC physical address.
> - *
> - * @mdev: pointer to mic_device instance.
> - * @dma_addr: DMA address.
> - * @size: Size of the region to be mapped.
> - *
> - * This API converts the DMA address provided to a DMA address
> understood
> - * by MIC. Caller should check for errors by calling mic_map_error(..).
> - *
> - * returns DMA address as required by MIC.
> - */
> -dma_addr_t mic_map(struct mic_device *mdev, dma_addr_t dma_addr,
> size_t size)
> -{
> -	dma_addr_t mic_addr =3D 0;
> -	int num_entries;
> -	s64 *ref;
> -	u64 smpt_start;
> -
> -	if (!size || size > mic_max_system_memory(mdev))
> -		return mic_addr;
> -
> -	ref =3D kmalloc_array(mdev->smpt->info.num_reg, sizeof(s64),
> GFP_ATOMIC);
> -	if (!ref)
> -		return mic_addr;
> -
> -	num_entries =3D mic_get_smpt_ref_count(mdev, dma_addr, size,
> -					     ref, &smpt_start);
> -
> -	/* Set the smpt table appropriately and get 16G aligned mic address
> */
> -	mic_addr =3D mic_smpt_op(mdev, smpt_start, num_entries, ref, size);
> -
> -	kfree(ref);
> -
> -	/*
> -	 * If mic_addr is zero then its an error case
> -	 * since mic_addr can never be zero.
> -	 * else generate mic_addr by adding the 16G offset in dma_addr
> -	 */
> -	if (!mic_addr && MIC_FAMILY_X100 =3D=3D mdev->family) {
> -		dev_err(&mdev->pdev->dev,
> -			"mic_map failed dma_addr 0x%llx size 0x%lx\n",
> -			dma_addr, size);
> -		return mic_addr;
> -	} else {
> -		return mic_addr + mic_smpt_offset(mdev, dma_addr);
> -	}
> -}
> -
> -/**
> - * mic_unmap - Unmaps a MIC physical address.
> - *
> - * @mdev: pointer to mic_device instance.
> - * @mic_addr: MIC physical address.
> - * @size: Size of the region to be unmapped.
> - *
> - * This API unmaps the mappings created by mic_map(..).
> - *
> - * returns None.
> - */
> -void mic_unmap(struct mic_device *mdev, dma_addr_t mic_addr, size_t
> size)
> -{
> -	struct mic_smpt_info *smpt_info =3D mdev->smpt;
> -	s64 *ref;
> -	int num_smpt;
> -	int spt;
> -	int i;
> -	unsigned long flags;
> -
> -	if (!size)
> -		return;
> -
> -	if (!mic_is_system_addr(mdev, mic_addr)) {
> -		dev_err(&mdev->pdev->dev,
> -			"invalid address: 0x%llx\n", mic_addr);
> -		return;
> -	}
> -
> -	spt =3D mic_sys_addr_to_smpt(mdev, mic_addr);
> -	ref =3D kmalloc_array(mdev->smpt->info.num_reg, sizeof(s64),
> GFP_ATOMIC);
> -	if (!ref)
> -		return;
> -
> -	/* Get number of smpt entries to be mapped, ref count array */
> -	num_smpt =3D mic_get_smpt_ref_count(mdev, mic_addr, size, ref,
> NULL);
> -
> -	spin_lock_irqsave(&smpt_info->smpt_lock, flags);
> -	smpt_info->unmap_count++;
> -	smpt_info->ref_count -=3D (s64)size;
> -
> -	for (i =3D spt; i < spt + num_smpt; i++) {
> -		smpt_info->entry[i].ref_count -=3D ref[i - spt];
> -		if (smpt_info->entry[i].ref_count < 0)
> -			dev_warn(&mdev->pdev->dev,
> -				 "ref count for entry %d is negative\n", i);
> -	}
> -	spin_unlock_irqrestore(&smpt_info->smpt_lock, flags);
> -	kfree(ref);
> -}
> -
> -/**
> - * mic_map_single - Maps a virtual address to a MIC physical address.
> - *
> - * @mdev: pointer to mic_device instance.
> - * @va: Kernel direct mapped virtual address.
> - * @size: Size of the region to be mapped.
> - *
> - * This API calls pci_map_single(..) for the direct mapped virtual addre=
ss
> - * and then converts the DMA address provided to a DMA address
> understood
> - * by MIC. Caller should check for errors by calling mic_map_error(..).
> - *
> - * returns DMA address as required by MIC.
> - */
> -dma_addr_t mic_map_single(struct mic_device *mdev, void *va, size_t size=
)
> -{
> -	dma_addr_t mic_addr =3D 0;
> -	struct pci_dev *pdev =3D mdev->pdev;
> -	dma_addr_t dma_addr =3D
> -		pci_map_single(pdev, va, size, PCI_DMA_BIDIRECTIONAL);
> -
> -	if (!pci_dma_mapping_error(pdev, dma_addr)) {
> -		mic_addr =3D mic_map(mdev, dma_addr, size);
> -		if (!mic_addr) {
> -			dev_err(&mdev->pdev->dev,
> -				"mic_map failed dma_addr 0x%llx size
> 0x%lx\n",
> -				dma_addr, size);
> -			pci_unmap_single(pdev, dma_addr,
> -					 size, PCI_DMA_BIDIRECTIONAL);
> -		}
> -	}
> -	return mic_addr;
> -}
> -
> -/**
> - * mic_unmap_single - Unmaps a MIC physical address.
> - *
> - * @mdev: pointer to mic_device instance.
> - * @mic_addr: MIC physical address.
> - * @size: Size of the region to be unmapped.
> - *
> - * This API unmaps the mappings created by mic_map_single(..).
> - *
> - * returns None.
> - */
> -void
> -mic_unmap_single(struct mic_device *mdev, dma_addr_t mic_addr, size_t
> size)
> -{
> -	struct pci_dev *pdev =3D mdev->pdev;
> -	dma_addr_t dma_addr =3D mic_to_dma_addr(mdev, mic_addr);
> -	mic_unmap(mdev, mic_addr, size);
> -	pci_unmap_single(pdev, dma_addr, size, PCI_DMA_BIDIRECTIONAL);
> -}
> -
> -/**
> - * mic_smpt_init - Initialize MIC System Memory Page Tables.
> - *
> - * @mdev: pointer to mic_device instance.
> - *
> - * returns 0 for success and -errno for error.
> - */
> -int mic_smpt_init(struct mic_device *mdev)
> -{
> -	int i, err =3D 0;
> -	dma_addr_t dma_addr;
> -	struct mic_smpt_info *smpt_info;
> -
> -	mdev->smpt =3D kmalloc(sizeof(*mdev->smpt), GFP_KERNEL);
> -	if (!mdev->smpt)
> -		return -ENOMEM;
> -
> -	smpt_info =3D mdev->smpt;
> -	mdev->smpt_ops->init(mdev);
> -	smpt_info->entry =3D kmalloc_array(smpt_info->info.num_reg,
> -					 sizeof(*smpt_info->entry),
> GFP_KERNEL);
> -	if (!smpt_info->entry) {
> -		err =3D -ENOMEM;
> -		goto free_smpt;
> -	}
> -	spin_lock_init(&smpt_info->smpt_lock);
> -	for (i =3D 0; i < smpt_info->info.num_reg; i++) {
> -		dma_addr =3D i * smpt_info->info.page_size;
> -		smpt_info->entry[i].dma_addr =3D dma_addr;
> -		smpt_info->entry[i].ref_count =3D 0;
> -		mdev->smpt_ops->set(mdev, dma_addr, i);
> -	}
> -	smpt_info->ref_count =3D 0;
> -	smpt_info->map_count =3D 0;
> -	smpt_info->unmap_count =3D 0;
> -	return 0;
> -free_smpt:
> -	kfree(smpt_info);
> -	return err;
> -}
> -
> -/**
> - * mic_smpt_uninit - UnInitialize MIC System Memory Page Tables.
> - *
> - * @mdev: pointer to mic_device instance.
> - *
> - * returns None.
> - */
> -void mic_smpt_uninit(struct mic_device *mdev)
> -{
> -	struct mic_smpt_info *smpt_info =3D mdev->smpt;
> -	int i;
> -
> -	dev_dbg(&mdev->pdev->dev,
> -		"nodeid %d SMPT ref count %lld map %lld unmap %lld\n",
> -		mdev->id, smpt_info->ref_count,
> -		smpt_info->map_count, smpt_info->unmap_count);
> -
> -	for (i =3D 0; i < smpt_info->info.num_reg; i++) {
> -		dev_dbg(&mdev->pdev->dev,
> -			"SMPT entry[%d] dma_addr =3D 0x%llx ref_count
> =3D %lld\n",
> -			i, smpt_info->entry[i].dma_addr,
> -			smpt_info->entry[i].ref_count);
> -		if (smpt_info->entry[i].ref_count)
> -			dev_warn(&mdev->pdev->dev,
> -				 "ref count for entry %d is not zero\n", i);
> -	}
> -	kfree(smpt_info->entry);
> -	kfree(smpt_info);
> -}
> -
> -/**
> - * mic_smpt_restore - Restore MIC System Memory Page Tables.
> - *
> - * @mdev: pointer to mic_device instance.
> - *
> - * Restore the SMPT registers to values previously stored in the
> - * SW data structures. Some MIC steppings lose register state
> - * across resets and this API should be called for performing
> - * a restore operation if required.
> - *
> - * returns None.
> - */
> -void mic_smpt_restore(struct mic_device *mdev)
> -{
> -	int i;
> -	dma_addr_t dma_addr;
> -
> -	for (i =3D 0; i < mdev->smpt->info.num_reg; i++) {
> -		dma_addr =3D mdev->smpt->entry[i].dma_addr;
> -		mdev->smpt_ops->set(mdev, dma_addr, i);
> -	}
> -}
> diff --git a/drivers/misc/mic/host/mic_smpt.h
> b/drivers/misc/mic/host/mic_smpt.h
> deleted file mode 100644
> index 3b1ec14a9d81..000000000000
> --- a/drivers/misc/mic/host/mic_smpt.h
> +++ /dev/null
> @@ -1,87 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#ifndef MIC_SMPT_H
> -#define MIC_SMPT_H
> -/**
> - * struct mic_smpt_ops - MIC HW specific SMPT operations.
> - * @init: Initialize hardware specific SMPT information in mic_smpt_hw_i=
nfo.
> - * @set: Set the value for a particular SMPT entry.
> - */
> -struct mic_smpt_ops {
> -	void (*init)(struct mic_device *mdev);
> -	void (*set)(struct mic_device *mdev, dma_addr_t dma_addr, u8
> index);
> -};
> -
> -/**
> - * struct mic_smpt - MIC SMPT entry information.
> - * @dma_addr: Base DMA address for this SMPT entry.
> - * @ref_count: Number of active mappings for this SMPT entry in bytes.
> - */
> -struct mic_smpt {
> -	dma_addr_t dma_addr;
> -	s64 ref_count;
> -};
> -
> -/**
> - * struct mic_smpt_hw_info - MIC SMPT hardware specific information.
> - * @num_reg: Number of SMPT registers.
> - * @page_shift: System memory page shift.
> - * @page_size: System memory page size.
> - * @base: System address base.
> - */
> -struct mic_smpt_hw_info {
> -	u8 num_reg;
> -	u8 page_shift;
> -	u64 page_size;
> -	u64 base;
> -};
> -
> -/**
> - * struct mic_smpt_info - MIC SMPT information.
> - * @entry: Array of SMPT entries.
> - * @smpt_lock: Spin lock protecting access to SMPT data structures.
> - * @info: Hardware specific SMPT information.
> - * @ref_count: Number of active SMPT mappings (for debug).
> - * @map_count: Number of SMPT mappings created (for debug).
> - * @unmap_count: Number of SMPT mappings destroyed (for debug).
> - */
> -struct mic_smpt_info {
> -	struct mic_smpt *entry;
> -	spinlock_t smpt_lock;
> -	struct mic_smpt_hw_info info;
> -	s64 ref_count;
> -	s64 map_count;
> -	s64 unmap_count;
> -};
> -
> -dma_addr_t mic_map_single(struct mic_device *mdev, void *va, size_t size=
);
> -void mic_unmap_single(struct mic_device *mdev,
> -	dma_addr_t mic_addr, size_t size);
> -dma_addr_t mic_map(struct mic_device *mdev,
> -	dma_addr_t dma_addr, size_t size);
> -void mic_unmap(struct mic_device *mdev, dma_addr_t mic_addr, size_t
> size);
> -dma_addr_t mic_to_dma_addr(struct mic_device *mdev, dma_addr_t
> mic_addr);
> -
> -/**
> - * mic_map_error - Check a MIC address for errors.
> - *
> - * @mdev: pointer to mic_device instance.
> - *
> - * returns Whether there was an error during mic_map..(..) APIs.
> - */
> -static inline bool mic_map_error(dma_addr_t mic_addr)
> -{
> -	return !mic_addr;
> -}
> -
> -int mic_smpt_init(struct mic_device *mdev);
> -void mic_smpt_uninit(struct mic_device *mdev);
> -void mic_smpt_restore(struct mic_device *mdev);
> -
> -#endif
> diff --git a/drivers/misc/mic/host/mic_x100.c
> b/drivers/misc/mic/host/mic_x100.c
> deleted file mode 100644
> index f5536c1ad607..000000000000
> --- a/drivers/misc/mic/host/mic_x100.c
> +++ /dev/null
> @@ -1,585 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#include <linux/fs.h>
> -#include <linux/pci.h>
> -#include <linux/sched.h>
> -#include <linux/firmware.h>
> -#include <linux/delay.h>
> -
> -#include "../common/mic_dev.h"
> -#include "mic_device.h"
> -#include "mic_x100.h"
> -#include "mic_smpt.h"
> -
> -static const u16 mic_x100_intr_init[] =3D {
> -		MIC_X100_DOORBELL_IDX_START,
> -		MIC_X100_DMA_IDX_START,
> -		MIC_X100_ERR_IDX_START,
> -		MIC_X100_NUM_DOORBELL,
> -		MIC_X100_NUM_DMA,
> -		MIC_X100_NUM_ERR,
> -};
> -
> -/**
> - * mic_x100_write_spad - write to the scratchpad register
> - * @mdev: pointer to mic_device instance
> - * @idx: index to the scratchpad register, 0 based
> - * @val: the data value to put into the register
> - *
> - * This function allows writing of a 32bit value to the indexed scratchp=
ad
> - * register.
> - *
> - * RETURNS: none.
> - */
> -static void
> -mic_x100_write_spad(struct mic_device *mdev, unsigned int idx, u32 val)
> -{
> -	dev_dbg(&mdev->pdev->dev, "Writing 0x%x to scratch pad
> index %d\n",
> -		val, idx);
> -	mic_mmio_write(&mdev->mmio, val,
> -		       MIC_X100_SBOX_BASE_ADDRESS +
> -		       MIC_X100_SBOX_SPAD0 + idx * 4);
> -}
> -
> -/**
> - * mic_x100_read_spad - read from the scratchpad register
> - * @mdev: pointer to mic_device instance
> - * @idx: index to scratchpad register, 0 based
> - *
> - * This function allows reading of the 32bit scratchpad register.
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -static u32
> -mic_x100_read_spad(struct mic_device *mdev, unsigned int idx)
> -{
> -	u32 val =3D mic_mmio_read(&mdev->mmio,
> -		MIC_X100_SBOX_BASE_ADDRESS +
> -		MIC_X100_SBOX_SPAD0 + idx * 4);
> -
> -	dev_dbg(&mdev->pdev->dev,
> -		"Reading 0x%x from scratch pad index %d\n", val, idx);
> -	return val;
> -}
> -
> -/**
> - * mic_x100_enable_interrupts - Enable interrupts.
> - * @mdev: pointer to mic_device instance
> - */
> -static void mic_x100_enable_interrupts(struct mic_device *mdev)
> -{
> -	u32 reg;
> -	struct mic_mw *mw =3D &mdev->mmio;
> -	u32 sice0 =3D MIC_X100_SBOX_BASE_ADDRESS +
> MIC_X100_SBOX_SICE0;
> -	u32 siac0 =3D MIC_X100_SBOX_BASE_ADDRESS +
> MIC_X100_SBOX_SIAC0;
> -
> -	reg =3D mic_mmio_read(mw, sice0);
> -	reg |=3D MIC_X100_SBOX_DBR_BITS(0xf) |
> MIC_X100_SBOX_DMA_BITS(0xff);
> -	mic_mmio_write(mw, reg, sice0);
> -
> -	/*
> -	 * Enable auto-clear when enabling interrupts. Applicable only for
> -	 * MSI-x. Legacy and MSI mode cannot have auto-clear enabled.
> -	 */
> -	if (mdev->irq_info.num_vectors > 1) {
> -		reg =3D mic_mmio_read(mw, siac0);
> -		reg |=3D MIC_X100_SBOX_DBR_BITS(0xf) |
> -			MIC_X100_SBOX_DMA_BITS(0xff);
> -		mic_mmio_write(mw, reg, siac0);
> -	}
> -}
> -
> -/**
> - * mic_x100_disable_interrupts - Disable interrupts.
> - * @mdev: pointer to mic_device instance
> - */
> -static void mic_x100_disable_interrupts(struct mic_device *mdev)
> -{
> -	u32 reg;
> -	struct mic_mw *mw =3D &mdev->mmio;
> -	u32 sice0 =3D MIC_X100_SBOX_BASE_ADDRESS +
> MIC_X100_SBOX_SICE0;
> -	u32 siac0 =3D MIC_X100_SBOX_BASE_ADDRESS +
> MIC_X100_SBOX_SIAC0;
> -	u32 sicc0 =3D MIC_X100_SBOX_BASE_ADDRESS +
> MIC_X100_SBOX_SICC0;
> -
> -	reg =3D mic_mmio_read(mw, sice0);
> -	mic_mmio_write(mw, reg, sicc0);
> -
> -	if (mdev->irq_info.num_vectors > 1) {
> -		reg =3D mic_mmio_read(mw, siac0);
> -		reg &=3D ~(MIC_X100_SBOX_DBR_BITS(0xf) |
> -			MIC_X100_SBOX_DMA_BITS(0xff));
> -		mic_mmio_write(mw, reg, siac0);
> -	}
> -}
> -
> -/**
> - * mic_x100_send_sbox_intr - Send an MIC_X100_SBOX interrupt to MIC.
> - * @mdev: pointer to mic_device instance
> - * @doorbell: doorbell number
> - */
> -static void mic_x100_send_sbox_intr(struct mic_device *mdev,
> -				    int doorbell)
> -{
> -	struct mic_mw *mw =3D &mdev->mmio;
> -	u64 apic_icr_offset =3D MIC_X100_SBOX_APICICR0 + doorbell * 8;
> -	u32 apicicr_low =3D mic_mmio_read(mw,
> MIC_X100_SBOX_BASE_ADDRESS +
> -					apic_icr_offset);
> -
> -	/* for MIC we need to make sure we "hit" the send_icr bit (13) */
> -	apicicr_low =3D (apicicr_low | (1 << 13));
> -
> -	/* Ensure that the interrupt is ordered w.r.t. previous stores. */
> -	wmb();
> -	mic_mmio_write(mw, apicicr_low,
> -		       MIC_X100_SBOX_BASE_ADDRESS + apic_icr_offset);
> -}
> -
> -/**
> - * mic_x100_send_rdmasr_intr - Send an RDMASR interrupt to MIC.
> - * @mdev: pointer to mic_device instance
> - * @doorbell: doorbell number
> - */
> -static void mic_x100_send_rdmasr_intr(struct mic_device *mdev,
> -				      int doorbell)
> -{
> -	int rdmasr_offset =3D MIC_X100_SBOX_RDMASR0 + (doorbell << 2);
> -	/* Ensure that the interrupt is ordered w.r.t. previous stores. */
> -	wmb();
> -	mic_mmio_write(&mdev->mmio, 0,
> -		       MIC_X100_SBOX_BASE_ADDRESS + rdmasr_offset);
> -}
> -
> -/**
> - * __mic_x100_send_intr - Send interrupt to MIC.
> - * @mdev: pointer to mic_device instance
> - * @doorbell: doorbell number.
> - */
> -static void mic_x100_send_intr(struct mic_device *mdev, int doorbell)
> -{
> -	int rdmasr_db;
> -	if (doorbell < MIC_X100_NUM_SBOX_IRQ) {
> -		mic_x100_send_sbox_intr(mdev, doorbell);
> -	} else {
> -		rdmasr_db =3D doorbell - MIC_X100_NUM_SBOX_IRQ;
> -		mic_x100_send_rdmasr_intr(mdev, rdmasr_db);
> -	}
> -}
> -
> -/**
> - * mic_x100_ack_interrupt - Read the interrupt sources register and
> - * clear it. This function will be called in the MSI/INTx case.
> - * @mdev: Pointer to mic_device instance.
> - *
> - * Returns: bitmask of interrupt sources triggered.
> - */
> -static u32 mic_x100_ack_interrupt(struct mic_device *mdev)
> -{
> -	u32 sicr0 =3D MIC_X100_SBOX_BASE_ADDRESS +
> MIC_X100_SBOX_SICR0;
> -	u32 reg =3D mic_mmio_read(&mdev->mmio, sicr0);
> -	mic_mmio_write(&mdev->mmio, reg, sicr0);
> -	return reg;
> -}
> -
> -/**
> - * mic_x100_intr_workarounds - These hardware specific workarounds are
> - * to be invoked everytime an interrupt is handled.
> - * @mdev: Pointer to mic_device instance.
> - *
> - * Returns: none
> - */
> -static void mic_x100_intr_workarounds(struct mic_device *mdev)
> -{
> -	struct mic_mw *mw =3D &mdev->mmio;
> -
> -	/* Clear pending bit array. */
> -	if (MIC_A0_STEP =3D=3D mdev->stepping)
> -		mic_mmio_write(mw, 1, MIC_X100_SBOX_BASE_ADDRESS +
> -			MIC_X100_SBOX_MSIXPBACR);
> -
> -	if (mdev->stepping >=3D MIC_B0_STEP)
> -		mdev->intr_ops->enable_interrupts(mdev);
> -}
> -
> -/**
> - * mic_x100_hw_intr_init - Initialize h/w specific interrupt
> - * information.
> - * @mdev: pointer to mic_device instance
> - */
> -static void mic_x100_hw_intr_init(struct mic_device *mdev)
> -{
> -	mdev->intr_info =3D (struct mic_intr_info *)mic_x100_intr_init;
> -}
> -
> -/**
> - * mic_x100_read_msi_to_src_map - read from the MSI mapping registers
> - * @mdev: pointer to mic_device instance
> - * @idx: index to the mapping register, 0 based
> - *
> - * This function allows reading of the 32bit MSI mapping register.
> - *
> - * RETURNS: The value in the register.
> - */
> -static u32
> -mic_x100_read_msi_to_src_map(struct mic_device *mdev, int idx)
> -{
> -	return mic_mmio_read(&mdev->mmio,
> -		MIC_X100_SBOX_BASE_ADDRESS +
> -		MIC_X100_SBOX_MXAR0 + idx * 4);
> -}
> -
> -/**
> - * mic_x100_program_msi_to_src_map - program the MSI mapping registers
> - * @mdev: pointer to mic_device instance
> - * @idx: index to the mapping register, 0 based
> - * @offset: The bit offset in the register that needs to be updated.
> - * @set: boolean specifying if the bit in the specified offset needs
> - * to be set or cleared.
> - *
> - * RETURNS: None.
> - */
> -static void
> -mic_x100_program_msi_to_src_map(struct mic_device *mdev,
> -				int idx, int offset, bool set)
> -{
> -	unsigned long reg;
> -	struct mic_mw *mw =3D &mdev->mmio;
> -	u32 mxar =3D MIC_X100_SBOX_BASE_ADDRESS +
> -		MIC_X100_SBOX_MXAR0 + idx * 4;
> -
> -	reg =3D mic_mmio_read(mw, mxar);
> -	if (set)
> -		__set_bit(offset, &reg);
> -	else
> -		__clear_bit(offset, &reg);
> -	mic_mmio_write(mw, reg, mxar);
> -}
> -
> -/*
> - * mic_x100_reset_fw_ready - Reset Firmware ready status field.
> - * @mdev: pointer to mic_device instance
> - */
> -static void mic_x100_reset_fw_ready(struct mic_device *mdev)
> -{
> -	mdev->ops->write_spad(mdev, MIC_X100_DOWNLOAD_INFO, 0);
> -}
> -
> -/*
> - * mic_x100_is_fw_ready - Check if firmware is ready.
> - * @mdev: pointer to mic_device instance
> - */
> -static bool mic_x100_is_fw_ready(struct mic_device *mdev)
> -{
> -	u32 scratch2 =3D mdev->ops->read_spad(mdev,
> MIC_X100_DOWNLOAD_INFO);
> -	return MIC_X100_SPAD2_DOWNLOAD_STATUS(scratch2) ? true :
> false;
> -}
> -
> -/**
> - * mic_x100_get_apic_id - Get bootstrap APIC ID.
> - * @mdev: pointer to mic_device instance
> - */
> -static u32 mic_x100_get_apic_id(struct mic_device *mdev)
> -{
> -	u32 scratch2 =3D 0;
> -
> -	scratch2 =3D mdev->ops->read_spad(mdev,
> MIC_X100_DOWNLOAD_INFO);
> -	return MIC_X100_SPAD2_APIC_ID(scratch2);
> -}
> -
> -/**
> - * mic_x100_send_firmware_intr - Send an interrupt to the firmware on MI=
C.
> - * @mdev: pointer to mic_device instance
> - */
> -static void mic_x100_send_firmware_intr(struct mic_device *mdev)
> -{
> -	u32 apicicr_low;
> -	u64 apic_icr_offset =3D MIC_X100_SBOX_APICICR7;
> -	int vector =3D MIC_X100_BSP_INTERRUPT_VECTOR;
> -	struct mic_mw *mw =3D &mdev->mmio;
> -
> -	/*
> -	 * For MIC we need to make sure we "hit"
> -	 * the send_icr bit (13).
> -	 */
> -	apicicr_low =3D (vector | (1 << 13));
> -
> -	mic_mmio_write(mw, mic_x100_get_apic_id(mdev),
> -		       MIC_X100_SBOX_BASE_ADDRESS + apic_icr_offset + 4);
> -
> -	/* Ensure that the interrupt is ordered w.r.t. previous stores. */
> -	wmb();
> -	mic_mmio_write(mw, apicicr_low,
> -		       MIC_X100_SBOX_BASE_ADDRESS + apic_icr_offset);
> -}
> -
> -/**
> - * mic_x100_hw_reset - Reset the MIC device.
> - * @mdev: pointer to mic_device instance
> - */
> -static void mic_x100_hw_reset(struct mic_device *mdev)
> -{
> -	u32 reset_reg;
> -	u32 rgcr =3D MIC_X100_SBOX_BASE_ADDRESS + MIC_X100_SBOX_RGCR;
> -	struct mic_mw *mw =3D &mdev->mmio;
> -
> -	/* Ensure that the reset is ordered w.r.t. previous loads and stores */
> -	mb();
> -	/* Trigger reset */
> -	reset_reg =3D mic_mmio_read(mw, rgcr);
> -	reset_reg |=3D 0x1;
> -	mic_mmio_write(mw, reset_reg, rgcr);
> -	/*
> -	 * It seems we really want to delay at least 1 second
> -	 * after touching reset to prevent a lot of problems.
> -	 */
> -	msleep(1000);
> -}
> -
> -/**
> - * mic_x100_load_command_line - Load command line to MIC.
> - * @mdev: pointer to mic_device instance
> - * @fw: the firmware image
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -static int
> -mic_x100_load_command_line(struct mic_device *mdev, const struct
> firmware *fw)
> -{
> -	u32 len =3D 0;
> -	u32 boot_mem;
> -	char *buf;
> -	void __iomem *cmd_line_va =3D mdev->aper.va + mdev->bootaddr +
> fw->size;
> -#define CMDLINE_SIZE 2048
> -
> -	boot_mem =3D mdev->aper.len >> 20;
> -	buf =3D kzalloc(CMDLINE_SIZE, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	len +=3D scnprintf(buf, CMDLINE_SIZE - len,
> -		" mem=3D%dM", boot_mem);
> -	if (mdev->cosm_dev->cmdline)
> -		scnprintf(buf + len, CMDLINE_SIZE - len, " %s",
> -			 mdev->cosm_dev->cmdline);
> -	memcpy_toio(cmd_line_va, buf, strlen(buf) + 1);
> -	kfree(buf);
> -	return 0;
> -}
> -
> -/**
> - * mic_x100_load_ramdisk - Load ramdisk to MIC.
> - * @mdev: pointer to mic_device instance
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -static int
> -mic_x100_load_ramdisk(struct mic_device *mdev)
> -{
> -	const struct firmware *fw;
> -	int rc;
> -	struct boot_params __iomem *bp =3D mdev->aper.va + mdev-
> >bootaddr;
> -
> -	rc =3D request_firmware(&fw, mdev->cosm_dev->ramdisk, &mdev-
> >pdev->dev);
> -	if (rc < 0) {
> -		dev_err(&mdev->pdev->dev,
> -			"ramdisk request_firmware failed: %d %s\n",
> -			rc, mdev->cosm_dev->ramdisk);
> -		goto error;
> -	}
> -	/*
> -	 * Typically the bootaddr for card OS is 64M
> -	 * so copy over the ramdisk @ 128M.
> -	 */
> -	memcpy_toio(mdev->aper.va + (mdev->bootaddr << 1), fw->data,
> fw->size);
> -	iowrite32(mdev->bootaddr << 1, &bp->hdr.ramdisk_image);
> -	iowrite32(fw->size, &bp->hdr.ramdisk_size);
> -	release_firmware(fw);
> -error:
> -	return rc;
> -}
> -
> -/**
> - * mic_x100_get_boot_addr - Get MIC boot address.
> - * @mdev: pointer to mic_device instance
> - *
> - * This function is called during firmware load to determine
> - * the address at which the OS should be downloaded in card
> - * memory i.e. GDDR.
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -static int
> -mic_x100_get_boot_addr(struct mic_device *mdev)
> -{
> -	u32 scratch2, boot_addr;
> -	int rc =3D 0;
> -
> -	scratch2 =3D mdev->ops->read_spad(mdev,
> MIC_X100_DOWNLOAD_INFO);
> -	boot_addr =3D MIC_X100_SPAD2_DOWNLOAD_ADDR(scratch2);
> -	dev_dbg(&mdev->pdev->dev, "%s %d boot_addr 0x%x\n",
> -		__func__, __LINE__, boot_addr);
> -	if (boot_addr > (1 << 31)) {
> -		dev_err(&mdev->pdev->dev,
> -			"incorrect bootaddr 0x%x\n",
> -			boot_addr);
> -		rc =3D -EINVAL;
> -		goto error;
> -	}
> -	mdev->bootaddr =3D boot_addr;
> -error:
> -	return rc;
> -}
> -
> -/**
> - * mic_x100_load_firmware - Load firmware to MIC.
> - * @mdev: pointer to mic_device instance
> - * @buf: buffer containing boot string including firmware/ramdisk path.
> - *
> - * RETURNS: An appropriate -ERRNO error value on error, or zero for
> success.
> - */
> -static int
> -mic_x100_load_firmware(struct mic_device *mdev, const char *buf)
> -{
> -	int rc;
> -	const struct firmware *fw;
> -
> -	rc =3D mic_x100_get_boot_addr(mdev);
> -	if (rc)
> -		return rc;
> -	/* load OS */
> -	rc =3D request_firmware(&fw, mdev->cosm_dev->firmware, &mdev-
> >pdev->dev);
> -	if (rc < 0) {
> -		dev_err(&mdev->pdev->dev,
> -			"ramdisk request_firmware failed: %d %s\n",
> -			rc, mdev->cosm_dev->firmware);
> -		return rc;
> -	}
> -	if (mdev->bootaddr > mdev->aper.len - fw->size) {
> -		rc =3D -EINVAL;
> -		dev_err(&mdev->pdev->dev, "%s %d rc %d bootaddr
> 0x%x\n",
> -			__func__, __LINE__, rc, mdev->bootaddr);
> -		goto error;
> -	}
> -	memcpy_toio(mdev->aper.va + mdev->bootaddr, fw->data, fw->size);
> -	mdev->ops->write_spad(mdev, MIC_X100_FW_SIZE, fw->size);
> -	if (!strcmp(mdev->cosm_dev->bootmode, "flash")) {
> -		rc =3D -EINVAL;
> -		dev_err(&mdev->pdev->dev, "%s %d rc %d\n",
> -			__func__, __LINE__, rc);
> -		goto error;
> -	}
> -	/* load command line */
> -	rc =3D mic_x100_load_command_line(mdev, fw);
> -	if (rc) {
> -		dev_err(&mdev->pdev->dev, "%s %d rc %d\n",
> -			__func__, __LINE__, rc);
> -		goto error;
> -	}
> -	release_firmware(fw);
> -	/* load ramdisk */
> -	if (mdev->cosm_dev->ramdisk)
> -		rc =3D mic_x100_load_ramdisk(mdev);
> -
> -	return rc;
> -
> -error:
> -	release_firmware(fw);
> -	return rc;
> -}
> -
> -/**
> - * mic_x100_get_postcode - Get postcode status from firmware.
> - * @mdev: pointer to mic_device instance
> - *
> - * RETURNS: postcode.
> - */
> -static u32 mic_x100_get_postcode(struct mic_device *mdev)
> -{
> -	return mic_mmio_read(&mdev->mmio, MIC_X100_POSTCODE);
> -}
> -
> -/**
> - * mic_x100_smpt_set - Update an SMPT entry with a DMA address.
> - * @mdev: pointer to mic_device instance
> - * @dma_addr: DMA address to use
> - * @index: entry to write to
> - *
> - * RETURNS: none.
> - */
> -static void
> -mic_x100_smpt_set(struct mic_device *mdev, dma_addr_t dma_addr, u8
> index)
> -{
> -#define SNOOP_ON	(0 << 0)
> -#define SNOOP_OFF	(1 << 0)
> -/*
> - * Sbox Smpt Reg Bits:
> - * Bits	31:2	Host address
> - * Bits	1	RSVD
> - * Bits	0	No snoop
> - */
> -#define BUILD_SMPT(NO_SNOOP, HOST_ADDR)  \
> -	(u32)(((HOST_ADDR) << 2) | ((NO_SNOOP) & 0x01))
> -
> -	uint32_t smpt_reg_val =3D BUILD_SMPT(SNOOP_ON,
> -			dma_addr >> mdev->smpt->info.page_shift);
> -	mic_mmio_write(&mdev->mmio, smpt_reg_val,
> -		       MIC_X100_SBOX_BASE_ADDRESS +
> -		       MIC_X100_SBOX_SMPT00 + (4 * index));
> -}
> -
> -/**
> - * mic_x100_smpt_hw_init - Initialize SMPT X100 specific fields.
> - * @mdev: pointer to mic_device instance
> - *
> - * RETURNS: none.
> - */
> -static void mic_x100_smpt_hw_init(struct mic_device *mdev)
> -{
> -	struct mic_smpt_hw_info *info =3D &mdev->smpt->info;
> -
> -	info->num_reg =3D 32;
> -	info->page_shift =3D 34;
> -	info->page_size =3D (1ULL << info->page_shift);
> -	info->base =3D 0x8000000000ULL;
> -}
> -
> -struct mic_smpt_ops mic_x100_smpt_ops =3D {
> -	.init =3D mic_x100_smpt_hw_init,
> -	.set =3D mic_x100_smpt_set,
> -};
> -
> -static bool mic_x100_dma_filter(struct dma_chan *chan, void *param)
> -{
> -	if (chan->device->dev->parent =3D=3D (struct device *)param)
> -		return true;
> -	return false;
> -}
> -
> -struct mic_hw_ops mic_x100_ops =3D {
> -	.aper_bar =3D MIC_X100_APER_BAR,
> -	.mmio_bar =3D MIC_X100_MMIO_BAR,
> -	.read_spad =3D mic_x100_read_spad,
> -	.write_spad =3D mic_x100_write_spad,
> -	.send_intr =3D mic_x100_send_intr,
> -	.ack_interrupt =3D mic_x100_ack_interrupt,
> -	.intr_workarounds =3D mic_x100_intr_workarounds,
> -	.reset =3D mic_x100_hw_reset,
> -	.reset_fw_ready =3D mic_x100_reset_fw_ready,
> -	.is_fw_ready =3D mic_x100_is_fw_ready,
> -	.send_firmware_intr =3D mic_x100_send_firmware_intr,
> -	.load_mic_fw =3D mic_x100_load_firmware,
> -	.get_postcode =3D mic_x100_get_postcode,
> -	.dma_filter =3D mic_x100_dma_filter,
> -};
> -
> -struct mic_hw_intr_ops mic_x100_intr_ops =3D {
> -	.intr_init =3D mic_x100_hw_intr_init,
> -	.enable_interrupts =3D mic_x100_enable_interrupts,
> -	.disable_interrupts =3D mic_x100_disable_interrupts,
> -	.program_msi_to_src_map =3D mic_x100_program_msi_to_src_map,
> -	.read_msi_to_src_map =3D mic_x100_read_msi_to_src_map,
> -};
> diff --git a/drivers/misc/mic/host/mic_x100.h
> b/drivers/misc/mic/host/mic_x100.h
> deleted file mode 100644
> index aebcaed6fa72..000000000000
> --- a/drivers/misc/mic/host/mic_x100.h
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC Host driver.
> - */
> -#ifndef _MIC_X100_HW_H_
> -#define _MIC_X100_HW_H_
> -
> -#define MIC_X100_PCI_DEVICE_2250 0x2250
> -#define MIC_X100_PCI_DEVICE_2251 0x2251
> -#define MIC_X100_PCI_DEVICE_2252 0x2252
> -#define MIC_X100_PCI_DEVICE_2253 0x2253
> -#define MIC_X100_PCI_DEVICE_2254 0x2254
> -#define MIC_X100_PCI_DEVICE_2255 0x2255
> -#define MIC_X100_PCI_DEVICE_2256 0x2256
> -#define MIC_X100_PCI_DEVICE_2257 0x2257
> -#define MIC_X100_PCI_DEVICE_2258 0x2258
> -#define MIC_X100_PCI_DEVICE_2259 0x2259
> -#define MIC_X100_PCI_DEVICE_225a 0x225a
> -#define MIC_X100_PCI_DEVICE_225b 0x225b
> -#define MIC_X100_PCI_DEVICE_225c 0x225c
> -#define MIC_X100_PCI_DEVICE_225d 0x225d
> -#define MIC_X100_PCI_DEVICE_225e 0x225e
> -
> -#define MIC_X100_APER_BAR 0
> -#define MIC_X100_MMIO_BAR 4
> -
> -#define MIC_X100_SBOX_BASE_ADDRESS 0x00010000
> -#define MIC_X100_SBOX_SPAD0 0x0000AB20
> -#define MIC_X100_SBOX_SICR0_DBR(x) ((x) & 0xf)
> -#define MIC_X100_SBOX_SICR0_DMA(x) (((x) >> 8) & 0xff)
> -#define MIC_X100_SBOX_SICE0_DBR(x) ((x) & 0xf)
> -#define MIC_X100_SBOX_DBR_BITS(x) ((x) & 0xf)
> -#define MIC_X100_SBOX_SICE0_DMA(x) (((x) >> 8) & 0xff)
> -#define MIC_X100_SBOX_DMA_BITS(x) (((x) & 0xff) << 8)
> -
> -#define MIC_X100_SBOX_APICICR0 0x0000A9D0
> -#define MIC_X100_SBOX_SICR0 0x00009004
> -#define MIC_X100_SBOX_SICE0 0x0000900C
> -#define MIC_X100_SBOX_SICC0 0x00009010
> -#define MIC_X100_SBOX_SIAC0 0x00009014
> -#define MIC_X100_SBOX_MSIXPBACR 0x00009084
> -#define MIC_X100_SBOX_MXAR0 0x00009044
> -#define MIC_X100_SBOX_SMPT00 0x00003100
> -#define MIC_X100_SBOX_RDMASR0 0x0000B180
> -
> -#define MIC_X100_DOORBELL_IDX_START 0
> -#define MIC_X100_NUM_DOORBELL 4
> -#define MIC_X100_DMA_IDX_START 8
> -#define MIC_X100_NUM_DMA 8
> -#define MIC_X100_ERR_IDX_START 30
> -#define MIC_X100_NUM_ERR 1
> -
> -#define MIC_X100_NUM_SBOX_IRQ 8
> -#define MIC_X100_NUM_RDMASR_IRQ 8
> -#define MIC_X100_RDMASR_IRQ_BASE 17
> -#define MIC_X100_SPAD2_DOWNLOAD_STATUS(x) ((x) & 0x1)
> -#define MIC_X100_SPAD2_APIC_ID(x)	(((x) >> 1) & 0x1ff)
> -#define MIC_X100_SPAD2_DOWNLOAD_ADDR(x) ((x) & 0xfffff000)
> -#define MIC_X100_SBOX_APICICR7 0x0000AA08
> -#define MIC_X100_SBOX_RGCR 0x00004010
> -#define MIC_X100_SBOX_SDBIC0 0x0000CC90
> -#define MIC_X100_DOWNLOAD_INFO 2
> -#define MIC_X100_FW_SIZE 5
> -#define MIC_X100_POSTCODE 0x242c
> -
> -/* Host->Card(bootstrap) Interrupt Vector */
> -#define MIC_X100_BSP_INTERRUPT_VECTOR 229
> -
> -extern struct mic_hw_ops mic_x100_ops;
> -extern struct mic_smpt_ops mic_x100_smpt_ops;
> -extern struct mic_hw_intr_ops mic_x100_intr_ops;
> -
> -#endif
> diff --git a/drivers/misc/mic/scif/Makefile b/drivers/misc/mic/scif/Makef=
ile
> deleted file mode 100644
> index ff372555d118..000000000000
> --- a/drivers/misc/mic/scif/Makefile
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile - SCIF driver.
> -# Copyright(c) 2014, Intel Corporation.
> -#
> -obj-$(CONFIG_SCIF) +=3D scif.o
> -scif-objs :=3D scif_main.o
> -scif-objs +=3D scif_peer_bus.o
> -scif-objs +=3D scif_ports.o
> -scif-objs +=3D scif_debugfs.o
> -scif-objs +=3D scif_fd.o
> -scif-objs +=3D scif_api.o
> -scif-objs +=3D scif_epd.o
> -scif-objs +=3D scif_rb.o
> -scif-objs +=3D scif_nodeqp.o
> -scif-objs +=3D scif_nm.o
> -scif-objs +=3D scif_dma.o
> -scif-objs +=3D scif_fence.o
> -scif-objs +=3D scif_mmap.o
> -scif-objs +=3D scif_rma.o
> -scif-objs +=3D scif_rma_list.o
> diff --git a/drivers/misc/mic/scif/scif_api.c b/drivers/misc/mic/scif/sci=
f_api.c
> deleted file mode 100644
> index 304d6c833712..000000000000
> --- a/drivers/misc/mic/scif/scif_api.c
> +++ /dev/null
> @@ -1,1485 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include <linux/scif.h>
> -#include "scif_main.h"
> -#include "scif_map.h"
> -
> -static const char * const scif_ep_states[] =3D {
> -	"Unbound",
> -	"Bound",
> -	"Listening",
> -	"Connected",
> -	"Connecting",
> -	"Mapping",
> -	"Closing",
> -	"Close Listening",
> -	"Disconnected",
> -	"Zombie"};
> -
> -enum conn_async_state {
> -	ASYNC_CONN_IDLE =3D 1,	/* ep setup for async connect */
> -	ASYNC_CONN_INPROGRESS,	/* async connect in progress */
> -	ASYNC_CONN_FLUSH_WORK	/* async work flush in progress  */
> -};
> -
> -/*
> - * File operations for anonymous inode file associated with a SCIF endpo=
int,
> - * used in kernel mode SCIF poll. Kernel mode SCIF poll calls portions o=
f the
> - * poll API in the kernel and these take in a struct file *. Since a str=
uct
> - * file is not available to kernel mode SCIF, it uses an anonymous file =
for
> - * this purpose.
> - */
> -const struct file_operations scif_anon_fops =3D {
> -	.owner =3D THIS_MODULE,
> -};
> -
> -scif_epd_t scif_open(void)
> -{
> -	struct scif_endpt *ep;
> -	int err;
> -
> -	might_sleep();
> -	ep =3D kzalloc(sizeof(*ep), GFP_KERNEL);
> -	if (!ep)
> -		goto err_ep_alloc;
> -
> -	ep->qp_info.qp =3D kzalloc(sizeof(*ep->qp_info.qp), GFP_KERNEL);
> -	if (!ep->qp_info.qp)
> -		goto err_qp_alloc;
> -
> -	err =3D scif_anon_inode_getfile(ep);
> -	if (err)
> -		goto err_anon_inode;
> -
> -	spin_lock_init(&ep->lock);
> -	mutex_init(&ep->sendlock);
> -	mutex_init(&ep->recvlock);
> -
> -	scif_rma_ep_init(ep);
> -	ep->state =3D SCIFEP_UNBOUND;
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI open: ep %p success\n", ep);
> -	return ep;
> -
> -err_anon_inode:
> -	kfree(ep->qp_info.qp);
> -err_qp_alloc:
> -	kfree(ep);
> -err_ep_alloc:
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(scif_open);
> -
> -/*
> - * scif_disconnect_ep - Disconnects the endpoint if found
> - * @epd: The end point returned from scif_open()
> - */
> -static struct scif_endpt *scif_disconnect_ep(struct scif_endpt *ep)
> -{
> -	struct scifmsg msg;
> -	struct scif_endpt *fep =3D NULL;
> -	struct scif_endpt *tmpep;
> -	struct list_head *pos, *tmpq;
> -	int err;
> -
> -	/*
> -	 * Wake up any threads blocked in send()/recv() before closing
> -	 * out the connection. Grabbing and releasing the send/recv lock
> -	 * will ensure that any blocked senders/receivers have exited for
> -	 * Ring 0 endpoints. It is a Ring 0 bug to call send/recv after
> -	 * close. Ring 3 endpoints are not affected since close will not
> -	 * be called while there are IOCTLs executing.
> -	 */
> -	wake_up_interruptible(&ep->sendwq);
> -	wake_up_interruptible(&ep->recvwq);
> -	mutex_lock(&ep->sendlock);
> -	mutex_unlock(&ep->sendlock);
> -	mutex_lock(&ep->recvlock);
> -	mutex_unlock(&ep->recvlock);
> -
> -	/* Remove from the connected list */
> -	mutex_lock(&scif_info.connlock);
> -	list_for_each_safe(pos, tmpq, &scif_info.connected) {
> -		tmpep =3D list_entry(pos, struct scif_endpt, list);
> -		if (tmpep =3D=3D ep) {
> -			list_del(pos);
> -			fep =3D tmpep;
> -			spin_lock(&ep->lock);
> -			break;
> -		}
> -	}
> -
> -	if (!fep) {
> -		/*
> -		 * The other side has completed the disconnect before
> -		 * the end point can be removed from the list. Therefore
> -		 * the ep lock is not locked, traverse the disconnected
> -		 * list to find the endpoint and release the conn lock.
> -		 */
> -		list_for_each_safe(pos, tmpq, &scif_info.disconnected) {
> -			tmpep =3D list_entry(pos, struct scif_endpt, list);
> -			if (tmpep =3D=3D ep) {
> -				list_del(pos);
> -				break;
> -			}
> -		}
> -		mutex_unlock(&scif_info.connlock);
> -		return NULL;
> -	}
> -
> -	init_completion(&ep->discon);
> -	msg.uop =3D SCIF_DISCNCT;
> -	msg.src =3D ep->port;
> -	msg.dst =3D ep->peer;
> -	msg.payload[0] =3D (u64)ep;
> -	msg.payload[1] =3D ep->remote_ep;
> -
> -	err =3D scif_nodeqp_send(ep->remote_dev, &msg);
> -	spin_unlock(&ep->lock);
> -	mutex_unlock(&scif_info.connlock);
> -
> -	if (!err)
> -		/* Wait for the remote node to respond with
> SCIF_DISCNT_ACK */
> -		wait_for_completion_timeout(&ep->discon,
> -					    SCIF_NODE_ALIVE_TIMEOUT);
> -	return ep;
> -}
> -
> -int scif_close(scif_epd_t epd)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct scif_endpt *tmpep;
> -	struct list_head *pos, *tmpq;
> -	enum scif_epd_state oldstate;
> -	bool flush_conn;
> -
> -	dev_dbg(scif_info.mdev.this_device, "SCIFAPI close: ep %p %s\n",
> -		ep, scif_ep_states[ep->state]);
> -	might_sleep();
> -	spin_lock(&ep->lock);
> -	flush_conn =3D (ep->conn_async_state =3D=3D ASYNC_CONN_INPROGRESS);
> -	spin_unlock(&ep->lock);
> -
> -	if (flush_conn)
> -		flush_work(&scif_info.conn_work);
> -
> -	spin_lock(&ep->lock);
> -	oldstate =3D ep->state;
> -
> -	ep->state =3D SCIFEP_CLOSING;
> -
> -	switch (oldstate) {
> -	case SCIFEP_ZOMBIE:
> -		dev_err(scif_info.mdev.this_device,
> -			"SCIFAPI close: zombie state unexpected\n");
> -		fallthrough;
> -	case SCIFEP_DISCONNECTED:
> -		spin_unlock(&ep->lock);
> -		scif_unregister_all_windows(epd);
> -		/* Remove from the disconnected list */
> -		mutex_lock(&scif_info.connlock);
> -		list_for_each_safe(pos, tmpq, &scif_info.disconnected) {
> -			tmpep =3D list_entry(pos, struct scif_endpt, list);
> -			if (tmpep =3D=3D ep) {
> -				list_del(pos);
> -				break;
> -			}
> -		}
> -		mutex_unlock(&scif_info.connlock);
> -		break;
> -	case SCIFEP_UNBOUND:
> -	case SCIFEP_BOUND:
> -	case SCIFEP_CONNECTING:
> -		spin_unlock(&ep->lock);
> -		break;
> -	case SCIFEP_MAPPING:
> -	case SCIFEP_CONNECTED:
> -	case SCIFEP_CLOSING:
> -	{
> -		spin_unlock(&ep->lock);
> -		scif_unregister_all_windows(epd);
> -		scif_disconnect_ep(ep);
> -		break;
> -	}
> -	case SCIFEP_LISTENING:
> -	case SCIFEP_CLLISTEN:
> -	{
> -		struct scif_conreq *conreq;
> -		struct scifmsg msg;
> -		struct scif_endpt *aep;
> -
> -		spin_unlock(&ep->lock);
> -		mutex_lock(&scif_info.eplock);
> -
> -		/* remove from listen list */
> -		list_for_each_safe(pos, tmpq, &scif_info.listen) {
> -			tmpep =3D list_entry(pos, struct scif_endpt, list);
> -			if (tmpep =3D=3D ep)
> -				list_del(pos);
> -		}
> -		/* Remove any dangling accepts */
> -		while (ep->acceptcnt) {
> -			aep =3D list_first_entry(&ep->li_accept,
> -					       struct scif_endpt, liacceptlist);
> -			list_del(&aep->liacceptlist);
> -			scif_put_port(aep->port.port);
> -			list_for_each_safe(pos, tmpq, &scif_info.uaccept) {
> -				tmpep =3D list_entry(pos, struct scif_endpt,
> -						   miacceptlist);
> -				if (tmpep =3D=3D aep) {
> -					list_del(pos);
> -					break;
> -				}
> -			}
> -			mutex_unlock(&scif_info.eplock);
> -			mutex_lock(&scif_info.connlock);
> -			list_for_each_safe(pos, tmpq, &scif_info.connected)
> {
> -				tmpep =3D list_entry(pos,
> -						   struct scif_endpt, list);
> -				if (tmpep =3D=3D aep) {
> -					list_del(pos);
> -					break;
> -				}
> -			}
> -			list_for_each_safe(pos, tmpq,
> &scif_info.disconnected) {
> -				tmpep =3D list_entry(pos,
> -						   struct scif_endpt, list);
> -				if (tmpep =3D=3D aep) {
> -					list_del(pos);
> -					break;
> -				}
> -			}
> -			mutex_unlock(&scif_info.connlock);
> -			scif_teardown_ep(aep);
> -			mutex_lock(&scif_info.eplock);
> -			scif_add_epd_to_zombie_list(aep,
> SCIF_EPLOCK_HELD);
> -			ep->acceptcnt--;
> -		}
> -
> -		spin_lock(&ep->lock);
> -		mutex_unlock(&scif_info.eplock);
> -
> -		/* Remove and reject any pending connection requests. */
> -		while (ep->conreqcnt) {
> -			conreq =3D list_first_entry(&ep->conlist,
> -						  struct scif_conreq, list);
> -			list_del(&conreq->list);
> -
> -			msg.uop =3D SCIF_CNCT_REJ;
> -			msg.dst.node =3D conreq->msg.src.node;
> -			msg.dst.port =3D conreq->msg.src.port;
> -			msg.payload[0] =3D conreq->msg.payload[0];
> -			msg.payload[1] =3D conreq->msg.payload[1];
> -			/*
> -			 * No Error Handling on purpose for
> scif_nodeqp_send().
> -			 * If the remote node is lost we still want free the
> -			 * connection requests on the self node.
> -			 */
> -			scif_nodeqp_send(&scif_dev[conreq->msg.src.node],
> -					 &msg);
> -			ep->conreqcnt--;
> -			kfree(conreq);
> -		}
> -
> -		spin_unlock(&ep->lock);
> -		/* If a kSCIF accept is waiting wake it up */
> -		wake_up_interruptible(&ep->conwq);
> -		break;
> -	}
> -	}
> -	scif_put_port(ep->port.port);
> -	scif_anon_inode_fput(ep);
> -	scif_teardown_ep(ep);
> -	scif_add_epd_to_zombie_list(ep, !SCIF_EPLOCK_HELD);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(scif_close);
> -
> -/**
> - * scif_flush() - Wakes up any blocking accepts. The endpoint will no lo=
nger
> - *			accept new connections.
> - * @epd: The end point returned from scif_open()
> - */
> -int __scif_flush(scif_epd_t epd)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -
> -	switch (ep->state) {
> -	case SCIFEP_LISTENING:
> -	{
> -		ep->state =3D SCIFEP_CLLISTEN;
> -
> -		/* If an accept is waiting wake it up */
> -		wake_up_interruptible(&ep->conwq);
> -		break;
> -	}
> -	default:
> -		break;
> -	}
> -	return 0;
> -}
> -
> -int scif_bind(scif_epd_t epd, u16 pn)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int ret =3D 0;
> -	int tmp;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI bind: ep %p %s requested port number %d\n",
> -		ep, scif_ep_states[ep->state], pn);
> -	if (pn) {
> -		/*
> -		 * Similar to IETF RFC 1700, SCIF ports below
> -		 * SCIF_ADMIN_PORT_END can only be bound by system (or
> root)
> -		 * processes or by processes executed by privileged users.
> -		 */
> -		if (pn < SCIF_ADMIN_PORT_END
> && !capable(CAP_SYS_ADMIN)) {
> -			ret =3D -EACCES;
> -			goto scif_bind_admin_exit;
> -		}
> -	}
> -
> -	spin_lock(&ep->lock);
> -	if (ep->state =3D=3D SCIFEP_BOUND) {
> -		ret =3D -EINVAL;
> -		goto scif_bind_exit;
> -	} else if (ep->state !=3D SCIFEP_UNBOUND) {
> -		ret =3D -EISCONN;
> -		goto scif_bind_exit;
> -	}
> -
> -	if (pn) {
> -		tmp =3D scif_rsrv_port(pn);
> -		if (tmp !=3D pn) {
> -			ret =3D -EINVAL;
> -			goto scif_bind_exit;
> -		}
> -	} else {
> -		ret =3D scif_get_new_port();
> -		if (ret < 0)
> -			goto scif_bind_exit;
> -		pn =3D ret;
> -	}
> -
> -	ep->state =3D SCIFEP_BOUND;
> -	ep->port.node =3D scif_info.nodeid;
> -	ep->port.port =3D pn;
> -	ep->conn_async_state =3D ASYNC_CONN_IDLE;
> -	ret =3D pn;
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI bind: bound to port number %d\n", pn);
> -scif_bind_exit:
> -	spin_unlock(&ep->lock);
> -scif_bind_admin_exit:
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(scif_bind);
> -
> -int scif_listen(scif_epd_t epd, int backlog)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI listen: ep %p %s\n", ep, scif_ep_states[ep->state]);
> -	spin_lock(&ep->lock);
> -	switch (ep->state) {
> -	case SCIFEP_ZOMBIE:
> -	case SCIFEP_CLOSING:
> -	case SCIFEP_CLLISTEN:
> -	case SCIFEP_UNBOUND:
> -	case SCIFEP_DISCONNECTED:
> -		spin_unlock(&ep->lock);
> -		return -EINVAL;
> -	case SCIFEP_LISTENING:
> -	case SCIFEP_CONNECTED:
> -	case SCIFEP_CONNECTING:
> -	case SCIFEP_MAPPING:
> -		spin_unlock(&ep->lock);
> -		return -EISCONN;
> -	case SCIFEP_BOUND:
> -		break;
> -	}
> -
> -	ep->state =3D SCIFEP_LISTENING;
> -	ep->backlog =3D backlog;
> -
> -	ep->conreqcnt =3D 0;
> -	ep->acceptcnt =3D 0;
> -	INIT_LIST_HEAD(&ep->conlist);
> -	init_waitqueue_head(&ep->conwq);
> -	INIT_LIST_HEAD(&ep->li_accept);
> -	spin_unlock(&ep->lock);
> -
> -	/*
> -	 * Listen status is complete so delete the qp information not needed
> -	 * on a listen before placing on the list of listening ep's
> -	 */
> -	scif_teardown_ep(ep);
> -	ep->qp_info.qp =3D NULL;
> -
> -	mutex_lock(&scif_info.eplock);
> -	list_add_tail(&ep->list, &scif_info.listen);
> -	mutex_unlock(&scif_info.eplock);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(scif_listen);
> -
> -/*
> -
> ****************************************************************
> ********
> - * SCIF connection flow:
> - *
> - * 1) A SCIF listening endpoint can call scif_accept(..) to wait for SCI=
F
> - *	connections via a SCIF_CNCT_REQ message
> - * 2) A SCIF endpoint can initiate a SCIF connection by calling
> - *	scif_connect(..) which calls scif_setup_qp_connect(..) which
> - *	allocates the local qp for the endpoint ring buffer and then sends
> - *	a SCIF_CNCT_REQ to the remote node and waits for a
> SCIF_CNCT_GNT or
> - *	a SCIF_CNCT_REJ message
> - * 3) The peer node handles a SCIF_CNCT_REQ via scif_cnctreq_resp(..)
> which
> - *	wakes up any threads blocked in step 1 or sends a SCIF_CNCT_REJ
> - *	message otherwise
> - * 4) A thread blocked waiting for incoming connections allocates its lo=
cal
> - *	endpoint QP and ring buffer following which it sends a
> SCIF_CNCT_GNT
> - *	and waits for a SCIF_CNCT_GNT(N)ACK. If the allocation fails then
> - *	the node sends a SCIF_CNCT_REJ message
> - * 5) Upon receipt of a SCIF_CNCT_GNT or a SCIF_CNCT_REJ message the
> - *	connecting endpoint is woken up as part of handling
> - *	scif_cnctgnt_resp(..) following which it maps the remote endpoints'
> - *	QP, updates its outbound QP and sends a SCIF_CNCT_GNTACK
> message on
> - *	success or a SCIF_CNCT_GNTNACK message on failure and completes
> - *	the scif_connect(..) API
> - * 6) Upon receipt of a SCIF_CNCT_GNT(N)ACK the accepting endpoint
> blocked
> - *	in step 4 is woken up and completes the scif_accept(..) API
> - * 7) The SCIF connection is now established between the two SCIF
> endpoints.
> - */
> -static int scif_conn_func(struct scif_endpt *ep)
> -{
> -	int err =3D 0;
> -	struct scifmsg msg;
> -	struct device *spdev;
> -
> -	err =3D scif_reserve_dma_chan(ep);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		ep->state =3D SCIFEP_BOUND;
> -		goto connect_error_simple;
> -	}
> -	/* Initiate the first part of the endpoint QP setup */
> -	err =3D scif_setup_qp_connect(ep->qp_info.qp, &ep-
> >qp_info.qp_offset,
> -				    SCIF_ENDPT_QP_SIZE, ep->remote_dev);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s err %d qp_offset 0x%llx\n",
> -			__func__, err, ep->qp_info.qp_offset);
> -		ep->state =3D SCIFEP_BOUND;
> -		goto connect_error_simple;
> -	}
> -
> -	spdev =3D scif_get_peer_dev(ep->remote_dev);
> -	if (IS_ERR(spdev)) {
> -		err =3D PTR_ERR(spdev);
> -		goto cleanup_qp;
> -	}
> -	/* Format connect message and send it */
> -	msg.src =3D ep->port;
> -	msg.dst =3D ep->conn_port;
> -	msg.uop =3D SCIF_CNCT_REQ;
> -	msg.payload[0] =3D (u64)ep;
> -	msg.payload[1] =3D ep->qp_info.qp_offset;
> -	err =3D _scif_nodeqp_send(ep->remote_dev, &msg);
> -	if (err)
> -		goto connect_error_dec;
> -	scif_put_peer_dev(spdev);
> -	/*
> -	 * Wait for the remote node to respond with SCIF_CNCT_GNT or
> -	 * SCIF_CNCT_REJ message.
> -	 */
> -	err =3D wait_event_timeout(ep->conwq, ep->state !=3D
> SCIFEP_CONNECTING,
> -				 SCIF_NODE_ALIVE_TIMEOUT);
> -	if (!err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d timeout\n", __func__, __LINE__);
> -		ep->state =3D SCIFEP_BOUND;
> -	}
> -	spdev =3D scif_get_peer_dev(ep->remote_dev);
> -	if (IS_ERR(spdev)) {
> -		err =3D PTR_ERR(spdev);
> -		goto cleanup_qp;
> -	}
> -	if (ep->state =3D=3D SCIFEP_MAPPING) {
> -		err =3D scif_setup_qp_connect_response(ep->remote_dev,
> -						     ep->qp_info.qp,
> -						     ep->qp_info.gnt_pld);
> -		/*
> -		 * If the resource to map the queue are not available then
> -		 * we need to tell the other side to terminate the accept
> -		 */
> -		if (err) {
> -			dev_err(&ep->remote_dev->sdev->dev,
> -				"%s %d err %d\n", __func__, __LINE__, err);
> -			msg.uop =3D SCIF_CNCT_GNTNACK;
> -			msg.payload[0] =3D ep->remote_ep;
> -			_scif_nodeqp_send(ep->remote_dev, &msg);
> -			ep->state =3D SCIFEP_BOUND;
> -			goto connect_error_dec;
> -		}
> -
> -		msg.uop =3D SCIF_CNCT_GNTACK;
> -		msg.payload[0] =3D ep->remote_ep;
> -		err =3D _scif_nodeqp_send(ep->remote_dev, &msg);
> -		if (err) {
> -			ep->state =3D SCIFEP_BOUND;
> -			goto connect_error_dec;
> -		}
> -		ep->state =3D SCIFEP_CONNECTED;
> -		mutex_lock(&scif_info.connlock);
> -		list_add_tail(&ep->list, &scif_info.connected);
> -		mutex_unlock(&scif_info.connlock);
> -		dev_dbg(&ep->remote_dev->sdev->dev,
> -			"SCIFAPI connect: ep %p connected\n", ep);
> -	} else if (ep->state =3D=3D SCIFEP_BOUND) {
> -		dev_dbg(&ep->remote_dev->sdev->dev,
> -			"SCIFAPI connect: ep %p connection refused\n", ep);
> -		err =3D -ECONNREFUSED;
> -		goto connect_error_dec;
> -	}
> -	scif_put_peer_dev(spdev);
> -	return err;
> -connect_error_dec:
> -	scif_put_peer_dev(spdev);
> -cleanup_qp:
> -	scif_cleanup_ep_qp(ep);
> -connect_error_simple:
> -	return err;
> -}
> -
> -/*
> - * scif_conn_handler:
> - *
> - * Workqueue handler for servicing non-blocking SCIF connect
> - *
> - */
> -void scif_conn_handler(struct work_struct *work)
> -{
> -	struct scif_endpt *ep;
> -
> -	do {
> -		ep =3D NULL;
> -		spin_lock(&scif_info.nb_connect_lock);
> -		if (!list_empty(&scif_info.nb_connect_list)) {
> -			ep =3D list_first_entry(&scif_info.nb_connect_list,
> -					      struct scif_endpt, conn_list);
> -			list_del(&ep->conn_list);
> -		}
> -		spin_unlock(&scif_info.nb_connect_lock);
> -		if (ep) {
> -			ep->conn_err =3D scif_conn_func(ep);
> -			wake_up_interruptible(&ep->conn_pend_wq);
> -		}
> -	} while (ep);
> -}
> -
> -int __scif_connect(scif_epd_t epd, struct scif_port_id *dst, bool non_bl=
ock)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int err =3D 0;
> -	struct scif_dev *remote_dev;
> -	struct device *spdev;
> -
> -	dev_dbg(scif_info.mdev.this_device, "SCIFAPI connect: ep %p %s\n",
> ep,
> -		scif_ep_states[ep->state]);
> -
> -	if (!scif_dev || dst->node > scif_info.maxid)
> -		return -ENODEV;
> -
> -	might_sleep();
> -
> -	remote_dev =3D &scif_dev[dst->node];
> -	spdev =3D scif_get_peer_dev(remote_dev);
> -	if (IS_ERR(spdev)) {
> -		err =3D PTR_ERR(spdev);
> -		return err;
> -	}
> -
> -	spin_lock(&ep->lock);
> -	switch (ep->state) {
> -	case SCIFEP_ZOMBIE:
> -	case SCIFEP_CLOSING:
> -		err =3D -EINVAL;
> -		break;
> -	case SCIFEP_DISCONNECTED:
> -		if (ep->conn_async_state =3D=3D ASYNC_CONN_INPROGRESS)
> -			ep->conn_async_state =3D ASYNC_CONN_FLUSH_WORK;
> -		else
> -			err =3D -EINVAL;
> -		break;
> -	case SCIFEP_LISTENING:
> -	case SCIFEP_CLLISTEN:
> -		err =3D -EOPNOTSUPP;
> -		break;
> -	case SCIFEP_CONNECTING:
> -	case SCIFEP_MAPPING:
> -		if (ep->conn_async_state =3D=3D ASYNC_CONN_INPROGRESS)
> -			err =3D -EINPROGRESS;
> -		else
> -			err =3D -EISCONN;
> -		break;
> -	case SCIFEP_CONNECTED:
> -		if (ep->conn_async_state =3D=3D ASYNC_CONN_INPROGRESS)
> -			ep->conn_async_state =3D ASYNC_CONN_FLUSH_WORK;
> -		else
> -			err =3D -EISCONN;
> -		break;
> -	case SCIFEP_UNBOUND:
> -		err =3D scif_get_new_port();
> -		if (err < 0)
> -			break;
> -		ep->port.port =3D err;
> -		ep->port.node =3D scif_info.nodeid;
> -		ep->conn_async_state =3D ASYNC_CONN_IDLE;
> -		fallthrough;
> -	case SCIFEP_BOUND:
> -		/*
> -		 * If a non-blocking connect has been already initiated
> -		 * (conn_async_state is either ASYNC_CONN_INPROGRESS or
> -		 * ASYNC_CONN_FLUSH_WORK), the end point could end up
> in
> -		 * SCIF_BOUND due an error in the connection process
> -		 * (e.g., connection refused) If conn_async_state is
> -		 * ASYNC_CONN_INPROGRESS - transition to
> ASYNC_CONN_FLUSH_WORK
> -		 * so that the error status can be collected. If the state is
> -		 * already ASYNC_CONN_FLUSH_WORK - then set the error to
> -		 * EINPROGRESS since some other thread is waiting to collect
> -		 * error status.
> -		 */
> -		if (ep->conn_async_state =3D=3D ASYNC_CONN_INPROGRESS) {
> -			ep->conn_async_state =3D ASYNC_CONN_FLUSH_WORK;
> -		} else if (ep->conn_async_state =3D=3D
> ASYNC_CONN_FLUSH_WORK) {
> -			err =3D -EINPROGRESS;
> -		} else {
> -			ep->conn_port =3D *dst;
> -			init_waitqueue_head(&ep->sendwq);
> -			init_waitqueue_head(&ep->recvwq);
> -			init_waitqueue_head(&ep->conwq);
> -			ep->conn_async_state =3D 0;
> -
> -			if (unlikely(non_block))
> -				ep->conn_async_state =3D
> ASYNC_CONN_INPROGRESS;
> -		}
> -		break;
> -	}
> -
> -	if (err || ep->conn_async_state =3D=3D ASYNC_CONN_FLUSH_WORK)
> -			goto connect_simple_unlock1;
> -
> -	ep->state =3D SCIFEP_CONNECTING;
> -	ep->remote_dev =3D &scif_dev[dst->node];
> -	ep->qp_info.qp->magic =3D SCIFEP_MAGIC;
> -	if (ep->conn_async_state =3D=3D ASYNC_CONN_INPROGRESS) {
> -		init_waitqueue_head(&ep->conn_pend_wq);
> -		spin_lock(&scif_info.nb_connect_lock);
> -		list_add_tail(&ep->conn_list, &scif_info.nb_connect_list);
> -		spin_unlock(&scif_info.nb_connect_lock);
> -		err =3D -EINPROGRESS;
> -		schedule_work(&scif_info.conn_work);
> -	}
> -connect_simple_unlock1:
> -	spin_unlock(&ep->lock);
> -	scif_put_peer_dev(spdev);
> -	if (err) {
> -		return err;
> -	} else if (ep->conn_async_state =3D=3D ASYNC_CONN_FLUSH_WORK) {
> -		flush_work(&scif_info.conn_work);
> -		err =3D ep->conn_err;
> -		spin_lock(&ep->lock);
> -		ep->conn_async_state =3D ASYNC_CONN_IDLE;
> -		spin_unlock(&ep->lock);
> -	} else {
> -		err =3D scif_conn_func(ep);
> -	}
> -	return err;
> -}
> -
> -int scif_connect(scif_epd_t epd, struct scif_port_id *dst)
> -{
> -	return __scif_connect(epd, dst, false);
> -}
> -EXPORT_SYMBOL_GPL(scif_connect);
> -
> -/*
> - * scif_accept() - Accept a connection request from the remote node
> - *
> - * The function accepts a connection request from the remote node.
> Successful
> - * complete is indicate by a new end point being created and passed back
> - * to the caller for future reference.
> - *
> - * Upon successful complete a zero will be returned and the peer
> information
> - * will be filled in.
> - *
> - * If the end point is not in the listening state -EINVAL will be return=
ed.
> - *
> - * If during the connection sequence resource allocation fails the -ENOM=
EM
> - * will be returned.
> - *
> - * If the function is called with the ASYNC flag set and no connection
> requests
> - * are pending it will return -EAGAIN.
> - *
> - * If the remote side is not sending any connection requests the caller =
may
> - * terminate this function with a signal.  If so a -EINTR will be return=
ed.
> - */
> -int scif_accept(scif_epd_t epd, struct scif_port_id *peer,
> -		scif_epd_t *newepd, int flags)
> -{
> -	struct scif_endpt *lep =3D (struct scif_endpt *)epd;
> -	struct scif_endpt *cep;
> -	struct scif_conreq *conreq;
> -	struct scifmsg msg;
> -	int err;
> -	struct device *spdev;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI accept: ep %p %s\n", lep, scif_ep_states[lep->state]);
> -
> -	if (flags & ~SCIF_ACCEPT_SYNC)
> -		return -EINVAL;
> -
> -	if (!peer || !newepd)
> -		return -EINVAL;
> -
> -	might_sleep();
> -	spin_lock(&lep->lock);
> -	if (lep->state !=3D SCIFEP_LISTENING) {
> -		spin_unlock(&lep->lock);
> -		return -EINVAL;
> -	}
> -
> -	if (!lep->conreqcnt && !(flags & SCIF_ACCEPT_SYNC)) {
> -		/* No connection request present and we do not want to
> wait */
> -		spin_unlock(&lep->lock);
> -		return -EAGAIN;
> -	}
> -
> -	lep->files =3D current->files;
> -retry_connection:
> -	spin_unlock(&lep->lock);
> -	/* Wait for the remote node to send us a SCIF_CNCT_REQ */
> -	err =3D wait_event_interruptible(lep->conwq,
> -				       (lep->conreqcnt ||
> -				       (lep->state !=3D SCIFEP_LISTENING)));
> -	if (err)
> -		return err;
> -
> -	if (lep->state !=3D SCIFEP_LISTENING)
> -		return -EINTR;
> -
> -	spin_lock(&lep->lock);
> -
> -	if (!lep->conreqcnt)
> -		goto retry_connection;
> -
> -	/* Get the first connect request off the list */
> -	conreq =3D list_first_entry(&lep->conlist, struct scif_conreq, list);
> -	list_del(&conreq->list);
> -	lep->conreqcnt--;
> -	spin_unlock(&lep->lock);
> -
> -	/* Fill in the peer information */
> -	peer->node =3D conreq->msg.src.node;
> -	peer->port =3D conreq->msg.src.port;
> -
> -	cep =3D kzalloc(sizeof(*cep), GFP_KERNEL);
> -	if (!cep) {
> -		err =3D -ENOMEM;
> -		goto scif_accept_error_epalloc;
> -	}
> -	spin_lock_init(&cep->lock);
> -	mutex_init(&cep->sendlock);
> -	mutex_init(&cep->recvlock);
> -	cep->state =3D SCIFEP_CONNECTING;
> -	cep->remote_dev =3D &scif_dev[peer->node];
> -	cep->remote_ep =3D conreq->msg.payload[0];
> -
> -	scif_rma_ep_init(cep);
> -
> -	err =3D scif_reserve_dma_chan(cep);
> -	if (err) {
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto scif_accept_error_qpalloc;
> -	}
> -
> -	cep->qp_info.qp =3D kzalloc(sizeof(*cep->qp_info.qp), GFP_KERNEL);
> -	if (!cep->qp_info.qp) {
> -		err =3D -ENOMEM;
> -		goto scif_accept_error_qpalloc;
> -	}
> -
> -	err =3D scif_anon_inode_getfile(cep);
> -	if (err)
> -		goto scif_accept_error_anon_inode;
> -
> -	cep->qp_info.qp->magic =3D SCIFEP_MAGIC;
> -	spdev =3D scif_get_peer_dev(cep->remote_dev);
> -	if (IS_ERR(spdev)) {
> -		err =3D PTR_ERR(spdev);
> -		goto scif_accept_error_map;
> -	}
> -	err =3D scif_setup_qp_accept(cep->qp_info.qp, &cep-
> >qp_info.qp_offset,
> -				   conreq->msg.payload[1],
> SCIF_ENDPT_QP_SIZE,
> -				   cep->remote_dev);
> -	if (err) {
> -		dev_dbg(&cep->remote_dev->sdev->dev,
> -			"SCIFAPI accept: ep %p new %p
> scif_setup_qp_accept %d qp_offset 0x%llx\n",
> -			lep, cep, err, cep->qp_info.qp_offset);
> -		scif_put_peer_dev(spdev);
> -		goto scif_accept_error_map;
> -	}
> -
> -	cep->port.node =3D lep->port.node;
> -	cep->port.port =3D lep->port.port;
> -	cep->peer.node =3D peer->node;
> -	cep->peer.port =3D peer->port;
> -	init_waitqueue_head(&cep->sendwq);
> -	init_waitqueue_head(&cep->recvwq);
> -	init_waitqueue_head(&cep->conwq);
> -
> -	msg.uop =3D SCIF_CNCT_GNT;
> -	msg.src =3D cep->port;
> -	msg.payload[0] =3D cep->remote_ep;
> -	msg.payload[1] =3D cep->qp_info.qp_offset;
> -	msg.payload[2] =3D (u64)cep;
> -
> -	err =3D _scif_nodeqp_send(cep->remote_dev, &msg);
> -	scif_put_peer_dev(spdev);
> -	if (err)
> -		goto scif_accept_error_map;
> -retry:
> -	/* Wait for the remote node to respond with SCIF_CNCT_GNT(N)ACK
> */
> -	err =3D wait_event_timeout(cep->conwq, cep->state !=3D
> SCIFEP_CONNECTING,
> -				 SCIF_NODE_ACCEPT_TIMEOUT);
> -	if (!err && scifdev_alive(cep))
> -		goto retry;
> -	err =3D !err ? -ENODEV : 0;
> -	if (err)
> -		goto scif_accept_error_map;
> -	kfree(conreq);
> -
> -	spin_lock(&cep->lock);
> -
> -	if (cep->state =3D=3D SCIFEP_CLOSING) {
> -		/*
> -		 * Remote failed to allocate resources and NAKed the grant.
> -		 * There is at this point nothing referencing the new end
> point.
> -		 */
> -		spin_unlock(&cep->lock);
> -		scif_teardown_ep(cep);
> -		kfree(cep);
> -
> -		/* If call with sync flag then go back and wait. */
> -		if (flags & SCIF_ACCEPT_SYNC) {
> -			spin_lock(&lep->lock);
> -			goto retry_connection;
> -		}
> -		return -EAGAIN;
> -	}
> -
> -	scif_get_port(cep->port.port);
> -	*newepd =3D (scif_epd_t)cep;
> -	spin_unlock(&cep->lock);
> -	return 0;
> -scif_accept_error_map:
> -	scif_anon_inode_fput(cep);
> -scif_accept_error_anon_inode:
> -	scif_teardown_ep(cep);
> -scif_accept_error_qpalloc:
> -	kfree(cep);
> -scif_accept_error_epalloc:
> -	msg.uop =3D SCIF_CNCT_REJ;
> -	msg.dst.node =3D conreq->msg.src.node;
> -	msg.dst.port =3D conreq->msg.src.port;
> -	msg.payload[0] =3D conreq->msg.payload[0];
> -	msg.payload[1] =3D conreq->msg.payload[1];
> -	scif_nodeqp_send(&scif_dev[conreq->msg.src.node], &msg);
> -	kfree(conreq);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_accept);
> -
> -/*
> - * scif_msg_param_check:
> - * @epd: The end point returned from scif_open()
> - * @len: Length to receive
> - * @flags: blocking or non blocking
> - *
> - * Validate parameters for messaging APIs scif_send(..)/scif_recv(..).
> - */
> -static inline int scif_msg_param_check(scif_epd_t epd, int len, int flag=
s)
> -{
> -	int ret =3D -EINVAL;
> -
> -	if (len < 0)
> -		goto err_ret;
> -	if (flags && (!(flags & SCIF_RECV_BLOCK)))
> -		goto err_ret;
> -	ret =3D 0;
> -err_ret:
> -	return ret;
> -}
> -
> -static int _scif_send(scif_epd_t epd, void *msg, int len, int flags)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct scifmsg notif_msg;
> -	int curr_xfer_len =3D 0, sent_len =3D 0, write_count;
> -	int ret =3D 0;
> -	struct scif_qp *qp =3D ep->qp_info.qp;
> -
> -	if (flags & SCIF_SEND_BLOCK)
> -		might_sleep();
> -
> -	spin_lock(&ep->lock);
> -	while (sent_len !=3D len && SCIFEP_CONNECTED =3D=3D ep->state) {
> -		write_count =3D scif_rb_space(&qp->outbound_q);
> -		if (write_count) {
> -			/* Best effort to send as much data as possible */
> -			curr_xfer_len =3D min(len - sent_len, write_count);
> -			ret =3D scif_rb_write(&qp->outbound_q, msg,
> -					    curr_xfer_len);
> -			if (ret < 0)
> -				break;
> -			/* Success. Update write pointer */
> -			scif_rb_commit(&qp->outbound_q);
> -			/*
> -			 * Send a notification to the peer about the
> -			 * produced data message.
> -			 */
> -			notif_msg.src =3D ep->port;
> -			notif_msg.uop =3D SCIF_CLIENT_SENT;
> -			notif_msg.payload[0] =3D ep->remote_ep;
> -			ret =3D _scif_nodeqp_send(ep->remote_dev,
> &notif_msg);
> -			if (ret)
> -				break;
> -			sent_len +=3D curr_xfer_len;
> -			msg =3D msg + curr_xfer_len;
> -			continue;
> -		}
> -		curr_xfer_len =3D min(len - sent_len, SCIF_ENDPT_QP_SIZE - 1);
> -		/* Not enough RB space. return for the Non Blocking case */
> -		if (!(flags & SCIF_SEND_BLOCK))
> -			break;
> -
> -		spin_unlock(&ep->lock);
> -		/* Wait for a SCIF_CLIENT_RCVD message in the Blocking case
> */
> -		ret =3D
> -		wait_event_interruptible(ep->sendwq,
> -					 (SCIFEP_CONNECTED !=3D ep->state) ||
> -					 (scif_rb_space(&qp-
> >outbound_q) >=3D
> -					 curr_xfer_len));
> -		spin_lock(&ep->lock);
> -		if (ret)
> -			break;
> -	}
> -	if (sent_len)
> -		ret =3D sent_len;
> -	else if (!ret && SCIFEP_CONNECTED !=3D ep->state)
> -		ret =3D SCIFEP_DISCONNECTED =3D=3D ep->state ?
> -			-ECONNRESET : -ENOTCONN;
> -	spin_unlock(&ep->lock);
> -	return ret;
> -}
> -
> -static int _scif_recv(scif_epd_t epd, void *msg, int len, int flags)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct scifmsg notif_msg;
> -	int curr_recv_len =3D 0, remaining_len =3D len, read_count;
> -	int ret =3D 0;
> -	struct scif_qp *qp =3D ep->qp_info.qp;
> -
> -	if (flags & SCIF_RECV_BLOCK)
> -		might_sleep();
> -	spin_lock(&ep->lock);
> -	while (remaining_len && (SCIFEP_CONNECTED =3D=3D ep->state ||
> -				 SCIFEP_DISCONNECTED =3D=3D ep->state)) {
> -		read_count =3D scif_rb_count(&qp->inbound_q,
> remaining_len);
> -		if (read_count) {
> -			/*
> -			 * Best effort to recv as much data as there
> -			 * are bytes to read in the RB particularly
> -			 * important for the Non Blocking case.
> -			 */
> -			curr_recv_len =3D min(remaining_len, read_count);
> -			scif_rb_get_next(&qp->inbound_q, msg,
> curr_recv_len);
> -			if (ep->state =3D=3D SCIFEP_CONNECTED) {
> -				/*
> -				 * Update the read pointer only if the
> endpoint
> -				 * is still connected else the read pointer
> -				 * might no longer exist since the peer has
> -				 * freed resources!
> -				 */
> -				scif_rb_update_read_ptr(&qp->inbound_q);
> -				/*
> -				 * Send a notification to the peer about the
> -				 * consumed data message only if the EP is in
> -				 * SCIFEP_CONNECTED state.
> -				 */
> -				notif_msg.src =3D ep->port;
> -				notif_msg.uop =3D SCIF_CLIENT_RCVD;
> -				notif_msg.payload[0] =3D ep->remote_ep;
> -				ret =3D _scif_nodeqp_send(ep->remote_dev,
> -							&notif_msg);
> -				if (ret)
> -					break;
> -			}
> -			remaining_len -=3D curr_recv_len;
> -			msg =3D msg + curr_recv_len;
> -			continue;
> -		}
> -		/*
> -		 * Bail out now if the EP is in SCIFEP_DISCONNECTED state
> else
> -		 * we will keep looping forever.
> -		 */
> -		if (ep->state =3D=3D SCIFEP_DISCONNECTED)
> -			break;
> -		/*
> -		 * Return in the Non Blocking case if there is no data
> -		 * to read in this iteration.
> -		 */
> -		if (!(flags & SCIF_RECV_BLOCK))
> -			break;
> -		curr_recv_len =3D min(remaining_len, SCIF_ENDPT_QP_SIZE - 1);
> -		spin_unlock(&ep->lock);
> -		/*
> -		 * Wait for a SCIF_CLIENT_SEND message in the blocking case
> -		 * or until other side disconnects.
> -		 */
> -		ret =3D
> -		wait_event_interruptible(ep->recvwq,
> -					 SCIFEP_CONNECTED !=3D ep->state ||
> -					 scif_rb_count(&qp->inbound_q,
> -						       curr_recv_len)
> -					 >=3D curr_recv_len);
> -		spin_lock(&ep->lock);
> -		if (ret)
> -			break;
> -	}
> -	if (len - remaining_len)
> -		ret =3D len - remaining_len;
> -	else if (!ret && ep->state !=3D SCIFEP_CONNECTED)
> -		ret =3D ep->state =3D=3D SCIFEP_DISCONNECTED ?
> -			-ECONNRESET : -ENOTCONN;
> -	spin_unlock(&ep->lock);
> -	return ret;
> -}
> -
> -/**
> - * scif_user_send() - Send data to connection queue
> - * @epd: The end point returned from scif_open()
> - * @msg: Address to place data
> - * @len: Length to receive
> - * @flags: blocking or non blocking
> - *
> - * This function is called from the driver IOCTL entry point
> - * only and is a wrapper for _scif_send().
> - */
> -int scif_user_send(scif_epd_t epd, void __user *msg, int len, int flags)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int err =3D 0;
> -	int sent_len =3D 0;
> -	char *tmp;
> -	int loop_len;
> -	int chunk_len =3D min(len, (1 << (MAX_ORDER + PAGE_SHIFT - 1)));
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI send (U): ep %p %s\n", ep, scif_ep_states[ep-
> >state]);
> -	if (!len)
> -		return 0;
> -
> -	err =3D scif_msg_param_check(epd, len, flags);
> -	if (err)
> -		goto send_err;
> -
> -	tmp =3D kmalloc(chunk_len, GFP_KERNEL);
> -	if (!tmp) {
> -		err =3D -ENOMEM;
> -		goto send_err;
> -	}
> -	/*
> -	 * Grabbing the lock before breaking up the transfer in
> -	 * multiple chunks is required to ensure that messages do
> -	 * not get fragmented and reordered.
> -	 */
> -	mutex_lock(&ep->sendlock);
> -	while (sent_len !=3D len) {
> -		loop_len =3D len - sent_len;
> -		loop_len =3D min(chunk_len, loop_len);
> -		if (copy_from_user(tmp, msg, loop_len)) {
> -			err =3D -EFAULT;
> -			goto send_free_err;
> -		}
> -		err =3D _scif_send(epd, tmp, loop_len, flags);
> -		if (err < 0)
> -			goto send_free_err;
> -		sent_len +=3D err;
> -		msg +=3D err;
> -		if (err !=3D loop_len)
> -			goto send_free_err;
> -	}
> -send_free_err:
> -	mutex_unlock(&ep->sendlock);
> -	kfree(tmp);
> -send_err:
> -	return err < 0 ? err : sent_len;
> -}
> -
> -/**
> - * scif_user_recv() - Receive data from connection queue
> - * @epd: The end point returned from scif_open()
> - * @msg: Address to place data
> - * @len: Length to receive
> - * @flags: blocking or non blocking
> - *
> - * This function is called from the driver IOCTL entry point
> - * only and is a wrapper for _scif_recv().
> - */
> -int scif_user_recv(scif_epd_t epd, void __user *msg, int len, int flags)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int err =3D 0;
> -	int recv_len =3D 0;
> -	char *tmp;
> -	int loop_len;
> -	int chunk_len =3D min(len, (1 << (MAX_ORDER + PAGE_SHIFT - 1)));
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI recv (U): ep %p %s\n", ep, scif_ep_states[ep->state]);
> -	if (!len)
> -		return 0;
> -
> -	err =3D scif_msg_param_check(epd, len, flags);
> -	if (err)
> -		goto recv_err;
> -
> -	tmp =3D kmalloc(chunk_len, GFP_KERNEL);
> -	if (!tmp) {
> -		err =3D -ENOMEM;
> -		goto recv_err;
> -	}
> -	/*
> -	 * Grabbing the lock before breaking up the transfer in
> -	 * multiple chunks is required to ensure that messages do
> -	 * not get fragmented and reordered.
> -	 */
> -	mutex_lock(&ep->recvlock);
> -	while (recv_len !=3D len) {
> -		loop_len =3D len - recv_len;
> -		loop_len =3D min(chunk_len, loop_len);
> -		err =3D _scif_recv(epd, tmp, loop_len, flags);
> -		if (err < 0)
> -			goto recv_free_err;
> -		if (copy_to_user(msg, tmp, err)) {
> -			err =3D -EFAULT;
> -			goto recv_free_err;
> -		}
> -		recv_len +=3D err;
> -		msg +=3D err;
> -		if (err !=3D loop_len)
> -			goto recv_free_err;
> -	}
> -recv_free_err:
> -	mutex_unlock(&ep->recvlock);
> -	kfree(tmp);
> -recv_err:
> -	return err < 0 ? err : recv_len;
> -}
> -
> -/**
> - * scif_send() - Send data to connection queue
> - * @epd: The end point returned from scif_open()
> - * @msg: Address to place data
> - * @len: Length to receive
> - * @flags: blocking or non blocking
> - *
> - * This function is called from the kernel mode only and is
> - * a wrapper for _scif_send().
> - */
> -int scif_send(scif_epd_t epd, void *msg, int len, int flags)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int ret;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI send (K): ep %p %s\n", ep, scif_ep_states[ep-
> >state]);
> -	if (!len)
> -		return 0;
> -
> -	ret =3D scif_msg_param_check(epd, len, flags);
> -	if (ret)
> -		return ret;
> -	if (!ep->remote_dev)
> -		return -ENOTCONN;
> -	/*
> -	 * Grab the mutex lock in the blocking case only
> -	 * to ensure messages do not get fragmented/reordered.
> -	 * The non blocking mode is protected using spin locks
> -	 * in _scif_send().
> -	 */
> -	if (flags & SCIF_SEND_BLOCK)
> -		mutex_lock(&ep->sendlock);
> -
> -	ret =3D _scif_send(epd, msg, len, flags);
> -
> -	if (flags & SCIF_SEND_BLOCK)
> -		mutex_unlock(&ep->sendlock);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(scif_send);
> -
> -/**
> - * scif_recv() - Receive data from connection queue
> - * @epd: The end point returned from scif_open()
> - * @msg: Address to place data
> - * @len: Length to receive
> - * @flags: blocking or non blocking
> - *
> - * This function is called from the kernel mode only and is
> - * a wrapper for _scif_recv().
> - */
> -int scif_recv(scif_epd_t epd, void *msg, int len, int flags)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int ret;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI recv (K): ep %p %s\n", ep, scif_ep_states[ep->state]);
> -	if (!len)
> -		return 0;
> -
> -	ret =3D scif_msg_param_check(epd, len, flags);
> -	if (ret)
> -		return ret;
> -	/*
> -	 * Grab the mutex lock in the blocking case only
> -	 * to ensure messages do not get fragmented/reordered.
> -	 * The non blocking mode is protected using spin locks
> -	 * in _scif_send().
> -	 */
> -	if (flags & SCIF_RECV_BLOCK)
> -		mutex_lock(&ep->recvlock);
> -
> -	ret =3D _scif_recv(epd, msg, len, flags);
> -
> -	if (flags & SCIF_RECV_BLOCK)
> -		mutex_unlock(&ep->recvlock);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(scif_recv);
> -
> -static inline void _scif_poll_wait(struct file *f, wait_queue_head_t *wq=
,
> -				   poll_table *p, struct scif_endpt *ep)
> -{
> -	/*
> -	 * Because poll_wait makes a GFP_KERNEL allocation, give up the lock
> -	 * and regrab it afterwards. Because the endpoint state might have
> -	 * changed while the lock was given up, the state must be checked
> -	 * again after re-acquiring the lock. The code in __scif_pollfd(..)
> -	 * does this.
> -	 */
> -	spin_unlock(&ep->lock);
> -	poll_wait(f, wq, p);
> -	spin_lock(&ep->lock);
> -}
> -
> -__poll_t
> -__scif_pollfd(struct file *f, poll_table *wait, struct scif_endpt *ep)
> -{
> -	__poll_t mask =3D 0;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI pollfd: ep %p %s\n", ep, scif_ep_states[ep->state]);
> -
> -	spin_lock(&ep->lock);
> -
> -	/* Endpoint is waiting for a non-blocking connect to complete */
> -	if (ep->conn_async_state =3D=3D ASYNC_CONN_INPROGRESS) {
> -		_scif_poll_wait(f, &ep->conn_pend_wq, wait, ep);
> -		if (ep->conn_async_state =3D=3D ASYNC_CONN_INPROGRESS) {
> -			if (ep->state =3D=3D SCIFEP_CONNECTED ||
> -			    ep->state =3D=3D SCIFEP_DISCONNECTED ||
> -			    ep->conn_err)
> -				mask |=3D EPOLLOUT;
> -			goto exit;
> -		}
> -	}
> -
> -	/* Endpoint is listening for incoming connection requests */
> -	if (ep->state =3D=3D SCIFEP_LISTENING) {
> -		_scif_poll_wait(f, &ep->conwq, wait, ep);
> -		if (ep->state =3D=3D SCIFEP_LISTENING) {
> -			if (ep->conreqcnt)
> -				mask |=3D EPOLLIN;
> -			goto exit;
> -		}
> -	}
> -
> -	/* Endpoint is connected or disconnected */
> -	if (ep->state =3D=3D SCIFEP_CONNECTED || ep->state =3D=3D
> SCIFEP_DISCONNECTED) {
> -		if (poll_requested_events(wait) & EPOLLIN)
> -			_scif_poll_wait(f, &ep->recvwq, wait, ep);
> -		if (poll_requested_events(wait) & EPOLLOUT)
> -			_scif_poll_wait(f, &ep->sendwq, wait, ep);
> -		if (ep->state =3D=3D SCIFEP_CONNECTED ||
> -		    ep->state =3D=3D SCIFEP_DISCONNECTED) {
> -			/* Data can be read without blocking */
> -			if (scif_rb_count(&ep->qp_info.qp->inbound_q, 1))
> -				mask |=3D EPOLLIN;
> -			/* Data can be written without blocking */
> -			if (scif_rb_space(&ep->qp_info.qp->outbound_q))
> -				mask |=3D EPOLLOUT;
> -			/* Return EPOLLHUP if endpoint is disconnected */
> -			if (ep->state =3D=3D SCIFEP_DISCONNECTED)
> -				mask |=3D EPOLLHUP;
> -			goto exit;
> -		}
> -	}
> -
> -	/* Return EPOLLERR if the endpoint is in none of the above states */
> -	mask |=3D EPOLLERR;
> -exit:
> -	spin_unlock(&ep->lock);
> -	return mask;
> -}
> -
> -/**
> - * scif_poll() - Kernel mode SCIF poll
> - * @ufds: Array of scif_pollepd structures containing the end points
> - *	  and events to poll on
> - * @nfds: Size of the ufds array
> - * @timeout_msecs: Timeout in msecs, -ve implies infinite timeout
> - *
> - * The code flow in this function is based on do_poll(..) in select.c
> - *
> - * Returns the number of endpoints which have pending events or 0 in
> - * the event of a timeout. If a signal is used for wake up, -EINTR is
> - * returned.
> - */
> -int
> -scif_poll(struct scif_pollepd *ufds, unsigned int nfds, long timeout_mse=
cs)
> -{
> -	struct poll_wqueues table;
> -	poll_table *pt;
> -	int i, count =3D 0, timed_out =3D timeout_msecs =3D=3D 0;
> -	__poll_t mask;
> -	u64 timeout =3D timeout_msecs < 0 ? MAX_SCHEDULE_TIMEOUT
> -		: msecs_to_jiffies(timeout_msecs);
> -
> -	poll_initwait(&table);
> -	pt =3D &table.pt;
> -	while (1) {
> -		for (i =3D 0; i < nfds; i++) {
> -			pt->_key =3D ufds[i].events | EPOLLERR | EPOLLHUP;
> -			mask =3D __scif_pollfd(ufds[i].epd->anon,
> -					     pt, ufds[i].epd);
> -			mask &=3D ufds[i].events | EPOLLERR | EPOLLHUP;
> -			if (mask) {
> -				count++;
> -				pt->_qproc =3D NULL;
> -			}
> -			ufds[i].revents =3D mask;
> -		}
> -		pt->_qproc =3D NULL;
> -		if (!count) {
> -			count =3D table.error;
> -			if (signal_pending(current))
> -				count =3D -EINTR;
> -		}
> -		if (count || timed_out)
> -			break;
> -
> -		if (!schedule_timeout_interruptible(timeout))
> -			timed_out =3D 1;
> -	}
> -	poll_freewait(&table);
> -	return count;
> -}
> -EXPORT_SYMBOL_GPL(scif_poll);
> -
> -int scif_get_node_ids(u16 *nodes, int len, u16 *self)
> -{
> -	int online =3D 0;
> -	int offset =3D 0;
> -	int node;
> -
> -	if (!scif_is_mgmt_node())
> -		scif_get_node_info();
> -
> -	*self =3D scif_info.nodeid;
> -	mutex_lock(&scif_info.conflock);
> -	len =3D min_t(int, len, scif_info.total);
> -	for (node =3D 0; node <=3D scif_info.maxid; node++) {
> -		if (_scifdev_alive(&scif_dev[node])) {
> -			online++;
> -			if (offset < len)
> -				nodes[offset++] =3D node;
> -		}
> -	}
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI get_node_ids total %d online %d filled in %d
> nodes\n",
> -		scif_info.total, online, offset);
> -	mutex_unlock(&scif_info.conflock);
> -
> -	return online;
> -}
> -EXPORT_SYMBOL_GPL(scif_get_node_ids);
> -
> -static int scif_add_client_dev(struct device *dev, struct subsys_interfa=
ce *si)
> -{
> -	struct scif_client *client =3D
> -		container_of(si, struct scif_client, si);
> -	struct scif_peer_dev *spdev =3D
> -		container_of(dev, struct scif_peer_dev, dev);
> -
> -	if (client->probe)
> -		client->probe(spdev);
> -	return 0;
> -}
> -
> -static void scif_remove_client_dev(struct device *dev,
> -				   struct subsys_interface *si)
> -{
> -	struct scif_client *client =3D
> -		container_of(si, struct scif_client, si);
> -	struct scif_peer_dev *spdev =3D
> -		container_of(dev, struct scif_peer_dev, dev);
> -
> -	if (client->remove)
> -		client->remove(spdev);
> -}
> -
> -void scif_client_unregister(struct scif_client *client)
> -{
> -	subsys_interface_unregister(&client->si);
> -}
> -EXPORT_SYMBOL_GPL(scif_client_unregister);
> -
> -int scif_client_register(struct scif_client *client)
> -{
> -	struct subsys_interface *si =3D &client->si;
> -
> -	si->name =3D client->name;
> -	si->subsys =3D &scif_peer_bus;
> -	si->add_dev =3D scif_add_client_dev;
> -	si->remove_dev =3D scif_remove_client_dev;
> -
> -	return subsys_interface_register(&client->si);
> -}
> -EXPORT_SYMBOL_GPL(scif_client_register);
> diff --git a/drivers/misc/mic/scif/scif_debugfs.c
> b/drivers/misc/mic/scif/scif_debugfs.c
> deleted file mode 100644
> index 8fe38e7ca6e6..000000000000
> --- a/drivers/misc/mic/scif/scif_debugfs.c
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include <linux/debugfs.h>
> -#include <linux/seq_file.h>
> -
> -#include "../common/mic_dev.h"
> -#include "scif_main.h"
> -
> -/* Debugfs parent dir */
> -static struct dentry *scif_dbg;
> -
> -static int scif_dev_show(struct seq_file *s, void *unused)
> -{
> -	int node;
> -
> -	seq_printf(s, "Total Nodes %d Self Node Id %d Maxid %d\n",
> -		   scif_info.total, scif_info.nodeid,
> -		   scif_info.maxid);
> -
> -	if (!scif_dev)
> -		return 0;
> -
> -	seq_printf(s, "%-16s\t%-16s\n", "node_id", "state");
> -
> -	for (node =3D 0; node <=3D scif_info.maxid; node++)
> -		seq_printf(s, "%-16d\t%-16s\n", scif_dev[node].node,
> -			   _scifdev_alive(&scif_dev[node]) ?
> -			   "Running" : "Offline");
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(scif_dev);
> -
> -static void scif_display_window(struct scif_window *window, struct seq_f=
ile
> *s)
> -{
> -	int j;
> -	struct scatterlist *sg;
> -	scif_pinned_pages_t pin =3D window->pinned_pages;
> -
> -	seq_printf(s, "window %p type %d temp %d offset 0x%llx ",
> -		   window, window->type, window->temp, window->offset);
> -	seq_printf(s, "nr_pages 0x%llx nr_contig_chunks 0x%x prot %d ",
> -		   window->nr_pages, window->nr_contig_chunks, window-
> >prot);
> -	seq_printf(s, "ref_count %d magic 0x%llx peer_window 0x%llx ",
> -		   window->ref_count, window->magic, window-
> >peer_window);
> -	seq_printf(s, "unreg_state 0x%x va_for_temp 0x%lx\n",
> -		   window->unreg_state, window->va_for_temp);
> -
> -	for (j =3D 0; j < window->nr_contig_chunks; j++)
> -		seq_printf(s, "page[%d] dma_addr 0x%llx num_pages
> 0x%llx\n", j,
> -			   window->dma_addr[j], window->num_pages[j]);
> -
> -	if (window->type =3D=3D SCIF_WINDOW_SELF && pin)
> -		for (j =3D 0; j < window->nr_pages; j++)
> -			seq_printf(s, "page[%d] =3D pinned_pages %p
> address %p\n",
> -				   j, pin->pages[j],
> -				   page_address(pin->pages[j]));
> -
> -	if (window->st)
> -		for_each_sg(window->st->sgl, sg, window->st->nents, j)
> -			seq_printf(s, "sg[%d] dma addr 0x%llx length
> 0x%x\n",
> -				   j, sg_dma_address(sg), sg_dma_len(sg));
> -}
> -
> -static void scif_display_all_windows(struct list_head *head, struct seq_=
file
> *s)
> -{
> -	struct list_head *item;
> -	struct scif_window *window;
> -
> -	list_for_each(item, head) {
> -		window =3D list_entry(item, struct scif_window, list);
> -		scif_display_window(window, s);
> -	}
> -}
> -
> -static int scif_rma_show(struct seq_file *s, void *unused)
> -{
> -	struct scif_endpt *ep;
> -	struct list_head *pos;
> -
> -	mutex_lock(&scif_info.connlock);
> -	list_for_each(pos, &scif_info.connected) {
> -		ep =3D list_entry(pos, struct scif_endpt, list);
> -		seq_printf(s, "ep %p self windows\n", ep);
> -		mutex_lock(&ep->rma_info.rma_lock);
> -		scif_display_all_windows(&ep->rma_info.reg_list, s);
> -		seq_printf(s, "ep %p remote windows\n", ep);
> -		scif_display_all_windows(&ep->rma_info.remote_reg_list, s);
> -		mutex_unlock(&ep->rma_info.rma_lock);
> -	}
> -	mutex_unlock(&scif_info.connlock);
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(scif_rma);
> -
> -void __init scif_init_debugfs(void)
> -{
> -	scif_dbg =3D debugfs_create_dir(KBUILD_MODNAME, NULL);
> -
> -	debugfs_create_file("scif_dev", 0444, scif_dbg, NULL,
> &scif_dev_fops);
> -	debugfs_create_file("scif_rma", 0444, scif_dbg, NULL,
> &scif_rma_fops);
> -	debugfs_create_u8("en_msg_log", 0666, scif_dbg,
> &scif_info.en_msg_log);
> -	debugfs_create_u8("p2p_enable", 0666, scif_dbg,
> &scif_info.p2p_enable);
> -}
> -
> -void scif_exit_debugfs(void)
> -{
> -	debugfs_remove_recursive(scif_dbg);
> -}
> diff --git a/drivers/misc/mic/scif/scif_dma.c
> b/drivers/misc/mic/scif/scif_dma.c
> deleted file mode 100644
> index 401b98e5ad79..000000000000
> --- a/drivers/misc/mic/scif/scif_dma.c
> +++ /dev/null
> @@ -1,1940 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include "scif_main.h"
> -#include "scif_map.h"
> -
> -/*
> - * struct scif_dma_comp_cb - SCIF DMA completion callback
> - *
> - * @dma_completion_func: DMA completion callback
> - * @cb_cookie: DMA completion callback cookie
> - * @temp_buf: Temporary buffer
> - * @temp_buf_to_free: Temporary buffer to be freed
> - * @is_cache: Is a kmem_cache allocated buffer
> - * @dst_offset: Destination registration offset
> - * @dst_window: Destination registration window
> - * @len: Length of the temp buffer
> - * @temp_phys: DMA address of the temp buffer
> - * @sdev: The SCIF device
> - * @header_padding: padding for cache line alignment
> - */
> -struct scif_dma_comp_cb {
> -	void (*dma_completion_func)(void *cookie);
> -	void *cb_cookie;
> -	u8 *temp_buf;
> -	u8 *temp_buf_to_free;
> -	bool is_cache;
> -	s64 dst_offset;
> -	struct scif_window *dst_window;
> -	size_t len;
> -	dma_addr_t temp_phys;
> -	struct scif_dev *sdev;
> -	int header_padding;
> -};
> -
> -/**
> - * struct scif_copy_work - Work for DMA copy
> - *
> - * @src_offset: Starting source offset
> - * @dst_offset: Starting destination offset
> - * @src_window: Starting src registered window
> - * @dst_window: Starting dst registered window
> - * @loopback: true if this is a loopback DMA transfer
> - * @len: Length of the transfer
> - * @comp_cb: DMA copy completion callback
> - * @remote_dev: The remote SCIF peer device
> - * @fence_type: polling or interrupt based
> - * @ordered: is this a tail byte ordered DMA transfer
> - */
> -struct scif_copy_work {
> -	s64 src_offset;
> -	s64 dst_offset;
> -	struct scif_window *src_window;
> -	struct scif_window *dst_window;
> -	int loopback;
> -	size_t len;
> -	struct scif_dma_comp_cb   *comp_cb;
> -	struct scif_dev	*remote_dev;
> -	int fence_type;
> -	bool ordered;
> -};
> -
> -/**
> - * scif_reserve_dma_chan:
> - * @ep: Endpoint Descriptor.
> - *
> - * This routine reserves a DMA channel for a particular
> - * endpoint. All DMA transfers for an endpoint are always
> - * programmed on the same DMA channel.
> - */
> -int scif_reserve_dma_chan(struct scif_endpt *ep)
> -{
> -	int err =3D 0;
> -	struct scif_dev *scifdev;
> -	struct scif_hw_dev *sdev;
> -	struct dma_chan *chan;
> -
> -	/* Loopback DMAs are not supported on the management node */
> -	if (!scif_info.nodeid && scifdev_self(ep->remote_dev))
> -		return 0;
> -	if (scif_info.nodeid)
> -		scifdev =3D &scif_dev[0];
> -	else
> -		scifdev =3D ep->remote_dev;
> -	sdev =3D scifdev->sdev;
> -	if (!sdev->num_dma_ch)
> -		return -ENODEV;
> -	chan =3D sdev->dma_ch[scifdev->dma_ch_idx];
> -	scifdev->dma_ch_idx =3D (scifdev->dma_ch_idx + 1) % sdev-
> >num_dma_ch;
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	ep->rma_info.dma_chan =3D chan;
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	return err;
> -}
> -
> -#ifdef CONFIG_MMU_NOTIFIER
> -/*
> - * scif_rma_destroy_tcw:
> - *
> - * This routine destroys temporary cached windows
> - */
> -static
> -void __scif_rma_destroy_tcw(struct scif_mmu_notif *mmn,
> -			    u64 start, u64 len)
> -{
> -	struct list_head *item, *tmp;
> -	struct scif_window *window;
> -	u64 start_va, end_va;
> -	u64 end =3D start + len;
> -
> -	if (end <=3D start)
> -		return;
> -
> -	list_for_each_safe(item, tmp, &mmn->tc_reg_list) {
> -		window =3D list_entry(item, struct scif_window, list);
> -		if (!len)
> -			break;
> -		start_va =3D window->va_for_temp;
> -		end_va =3D start_va + (window->nr_pages << PAGE_SHIFT);
> -		if (start < start_va && end <=3D start_va)
> -			break;
> -		if (start >=3D end_va)
> -			continue;
> -		__scif_rma_destroy_tcw_helper(window);
> -	}
> -}
> -
> -static void scif_rma_destroy_tcw(struct scif_mmu_notif *mmn, u64 start,
> u64 len)
> -{
> -	struct scif_endpt *ep =3D mmn->ep;
> -
> -	spin_lock(&ep->rma_info.tc_lock);
> -	__scif_rma_destroy_tcw(mmn, start, len);
> -	spin_unlock(&ep->rma_info.tc_lock);
> -}
> -
> -static void scif_rma_destroy_tcw_ep(struct scif_endpt *ep)
> -{
> -	struct list_head *item, *tmp;
> -	struct scif_mmu_notif *mmn;
> -
> -	list_for_each_safe(item, tmp, &ep->rma_info.mmn_list) {
> -		mmn =3D list_entry(item, struct scif_mmu_notif, list);
> -		scif_rma_destroy_tcw(mmn, 0, ULONG_MAX);
> -	}
> -}
> -
> -static void __scif_rma_destroy_tcw_ep(struct scif_endpt *ep)
> -{
> -	struct list_head *item, *tmp;
> -	struct scif_mmu_notif *mmn;
> -
> -	spin_lock(&ep->rma_info.tc_lock);
> -	list_for_each_safe(item, tmp, &ep->rma_info.mmn_list) {
> -		mmn =3D list_entry(item, struct scif_mmu_notif, list);
> -		__scif_rma_destroy_tcw(mmn, 0, ULONG_MAX);
> -	}
> -	spin_unlock(&ep->rma_info.tc_lock);
> -}
> -
> -static bool scif_rma_tc_can_cache(struct scif_endpt *ep, size_t cur_byte=
s)
> -{
> -	if ((cur_bytes >> PAGE_SHIFT) > scif_info.rma_tc_limit)
> -		return false;
> -	if ((atomic_read(&ep->rma_info.tcw_total_pages)
> -			+ (cur_bytes >> PAGE_SHIFT)) >
> -			scif_info.rma_tc_limit) {
> -		dev_info(scif_info.mdev.this_device,
> -			 "%s %d total=3D%d, current=3D%zu reached max\n",
> -			 __func__, __LINE__,
> -			 atomic_read(&ep->rma_info.tcw_total_pages),
> -			 (1 + (cur_bytes >> PAGE_SHIFT)));
> -		scif_rma_destroy_tcw_invalid();
> -		__scif_rma_destroy_tcw_ep(ep);
> -	}
> -	return true;
> -}
> -
> -static void scif_mmu_notifier_release(struct mmu_notifier *mn,
> -				      struct mm_struct *mm)
> -{
> -	struct scif_mmu_notif	*mmn;
> -
> -	mmn =3D container_of(mn, struct scif_mmu_notif, ep_mmu_notifier);
> -	scif_rma_destroy_tcw(mmn, 0, ULONG_MAX);
> -	schedule_work(&scif_info.misc_work);
> -}
> -
> -static int scif_mmu_notifier_invalidate_range_start(struct mmu_notifier
> *mn,
> -					const struct mmu_notifier_range
> *range)
> -{
> -	struct scif_mmu_notif	*mmn;
> -
> -	mmn =3D container_of(mn, struct scif_mmu_notif, ep_mmu_notifier);
> -	scif_rma_destroy_tcw(mmn, range->start, range->end - range->start);
> -
> -	return 0;
> -}
> -
> -static void scif_mmu_notifier_invalidate_range_end(struct mmu_notifier
> *mn,
> -			const struct mmu_notifier_range *range)
> -{
> -	/*
> -	 * Nothing to do here, everything needed was done in
> -	 * invalidate_range_start.
> -	 */
> -}
> -
> -static const struct mmu_notifier_ops scif_mmu_notifier_ops =3D {
> -	.release =3D scif_mmu_notifier_release,
> -	.clear_flush_young =3D NULL,
> -	.invalidate_range_start =3D scif_mmu_notifier_invalidate_range_start,
> -	.invalidate_range_end =3D scif_mmu_notifier_invalidate_range_end};
> -
> -static void scif_ep_unregister_mmu_notifier(struct scif_endpt *ep)
> -{
> -	struct scif_endpt_rma_info *rma =3D &ep->rma_info;
> -	struct scif_mmu_notif *mmn =3D NULL;
> -	struct list_head *item, *tmp;
> -
> -	mutex_lock(&ep->rma_info.mmn_lock);
> -	list_for_each_safe(item, tmp, &rma->mmn_list) {
> -		mmn =3D list_entry(item, struct scif_mmu_notif, list);
> -		mmu_notifier_unregister(&mmn->ep_mmu_notifier, mmn-
> >mm);
> -		list_del(item);
> -		kfree(mmn);
> -	}
> -	mutex_unlock(&ep->rma_info.mmn_lock);
> -}
> -
> -static void scif_init_mmu_notifier(struct scif_mmu_notif *mmn,
> -				   struct mm_struct *mm, struct scif_endpt
> *ep)
> -{
> -	mmn->ep =3D ep;
> -	mmn->mm =3D mm;
> -	mmn->ep_mmu_notifier.ops =3D &scif_mmu_notifier_ops;
> -	INIT_LIST_HEAD(&mmn->list);
> -	INIT_LIST_HEAD(&mmn->tc_reg_list);
> -}
> -
> -static struct scif_mmu_notif *
> -scif_find_mmu_notifier(struct mm_struct *mm, struct scif_endpt_rma_info
> *rma)
> -{
> -	struct scif_mmu_notif *mmn;
> -
> -	list_for_each_entry(mmn, &rma->mmn_list, list)
> -		if (mmn->mm =3D=3D mm)
> -			return mmn;
> -	return NULL;
> -}
> -
> -static struct scif_mmu_notif *
> -scif_add_mmu_notifier(struct mm_struct *mm, struct scif_endpt *ep)
> -{
> -	struct scif_mmu_notif *mmn
> -		 =3D kzalloc(sizeof(*mmn), GFP_KERNEL);
> -
> -	if (!mmn)
> -		return ERR_PTR(-ENOMEM);
> -
> -	scif_init_mmu_notifier(mmn, current->mm, ep);
> -	if (mmu_notifier_register(&mmn->ep_mmu_notifier, current->mm))
> {
> -		kfree(mmn);
> -		return ERR_PTR(-EBUSY);
> -	}
> -	list_add(&mmn->list, &ep->rma_info.mmn_list);
> -	return mmn;
> -}
> -
> -/*
> - * Called from the misc thread to destroy temporary cached windows and
> - * unregister the MMU notifier for the SCIF endpoint.
> - */
> -void scif_mmu_notif_handler(struct work_struct *work)
> -{
> -	struct list_head *pos, *tmpq;
> -	struct scif_endpt *ep;
> -restart:
> -	scif_rma_destroy_tcw_invalid();
> -	spin_lock(&scif_info.rmalock);
> -	list_for_each_safe(pos, tmpq, &scif_info.mmu_notif_cleanup) {
> -		ep =3D list_entry(pos, struct scif_endpt, mmu_list);
> -		list_del(&ep->mmu_list);
> -		spin_unlock(&scif_info.rmalock);
> -		scif_rma_destroy_tcw_ep(ep);
> -		scif_ep_unregister_mmu_notifier(ep);
> -		goto restart;
> -	}
> -	spin_unlock(&scif_info.rmalock);
> -}
> -
> -static bool scif_is_set_reg_cache(int flags)
> -{
> -	return !!(flags & SCIF_RMA_USECACHE);
> -}
> -#else
> -static struct scif_mmu_notif *
> -scif_find_mmu_notifier(struct mm_struct *mm,
> -		       struct scif_endpt_rma_info *rma)
> -{
> -	return NULL;
> -}
> -
> -static struct scif_mmu_notif *
> -scif_add_mmu_notifier(struct mm_struct *mm, struct scif_endpt *ep)
> -{
> -	return NULL;
> -}
> -
> -void scif_mmu_notif_handler(struct work_struct *work)
> -{
> -}
> -
> -static bool scif_is_set_reg_cache(int flags)
> -{
> -	return false;
> -}
> -
> -static bool scif_rma_tc_can_cache(struct scif_endpt *ep, size_t cur_byte=
s)
> -{
> -	return false;
> -}
> -#endif
> -
> -/**
> - * scif_register_temp:
> - * @epd: End Point Descriptor.
> - * @addr: virtual address to/from which to copy
> - * @len: length of range to copy
> - * @prot: read/write protection
> - * @out_offset: computed offset returned by reference.
> - * @out_window: allocated registered window returned by reference.
> - *
> - * Create a temporary registered window. The peer will not know about th=
is
> - * window. This API is used for scif_vreadfrom()/scif_vwriteto() API's.
> - */
> -static int
> -scif_register_temp(scif_epd_t epd, unsigned long addr, size_t len, int p=
rot,
> -		   off_t *out_offset, struct scif_window **out_window)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int err;
> -	scif_pinned_pages_t pinned_pages;
> -	size_t aligned_len;
> -
> -	aligned_len =3D ALIGN(len, PAGE_SIZE);
> -
> -	err =3D __scif_pin_pages((void *)(addr & PAGE_MASK),
> -			       aligned_len, &prot, 0, &pinned_pages);
> -	if (err)
> -		return err;
> -
> -	pinned_pages->prot =3D prot;
> -
> -	/* Compute the offset for this registration */
> -	err =3D scif_get_window_offset(ep, 0, 0,
> -				     aligned_len >> PAGE_SHIFT,
> -				     (s64 *)out_offset);
> -	if (err)
> -		goto error_unpin;
> -
> -	/* Allocate and prepare self registration window */
> -	*out_window =3D scif_create_window(ep, aligned_len >> PAGE_SHIFT,
> -					*out_offset, true);
> -	if (!*out_window) {
> -		scif_free_window_offset(ep, NULL, *out_offset);
> -		err =3D -ENOMEM;
> -		goto error_unpin;
> -	}
> -
> -	(*out_window)->pinned_pages =3D pinned_pages;
> -	(*out_window)->nr_pages =3D pinned_pages->nr_pages;
> -	(*out_window)->prot =3D pinned_pages->prot;
> -
> -	(*out_window)->va_for_temp =3D addr & PAGE_MASK;
> -	err =3D scif_map_window(ep->remote_dev, *out_window);
> -	if (err) {
> -		/* Something went wrong! Rollback */
> -		scif_destroy_window(ep, *out_window);
> -		*out_window =3D NULL;
> -	} else {
> -		*out_offset |=3D (addr - (*out_window)->va_for_temp);
> -	}
> -	return err;
> -error_unpin:
> -	if (err)
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -	scif_unpin_pages(pinned_pages);
> -	return err;
> -}
> -
> -#define SCIF_DMA_TO (3 * HZ)
> -
> -/*
> - * scif_sync_dma - Program a DMA without an interrupt descriptor
> - *
> - * @dev - The address of the pointer to the device instance used
> - * for DMA registration.
> - * @chan - DMA channel to be used.
> - * @sync_wait: Wait for DMA to complete?
> - *
> - * Return 0 on success and -errno on error.
> - */
> -static int scif_sync_dma(struct scif_hw_dev *sdev, struct dma_chan *chan=
,
> -			 bool sync_wait)
> -{
> -	int err =3D 0;
> -	struct dma_async_tx_descriptor *tx =3D NULL;
> -	enum dma_ctrl_flags flags =3D DMA_PREP_FENCE;
> -	dma_cookie_t cookie;
> -	struct dma_device *ddev;
> -
> -	if (!chan) {
> -		err =3D -EIO;
> -		dev_err(&sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		return err;
> -	}
> -	ddev =3D chan->device;
> -
> -	tx =3D ddev->device_prep_dma_memcpy(chan, 0, 0, 0, flags);
> -	if (!tx) {
> -		err =3D -ENOMEM;
> -		dev_err(&sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto release;
> -	}
> -	cookie =3D tx->tx_submit(tx);
> -
> -	if (dma_submit_error(cookie)) {
> -		err =3D -ENOMEM;
> -		dev_err(&sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto release;
> -	}
> -	if (!sync_wait) {
> -		dma_async_issue_pending(chan);
> -	} else {
> -		if (dma_sync_wait(chan, cookie) =3D=3D DMA_COMPLETE) {
> -			err =3D 0;
> -		} else {
> -			err =3D -EIO;
> -			dev_err(&sdev->dev, "%s %d err %d\n",
> -				__func__, __LINE__, err);
> -		}
> -	}
> -release:
> -	return err;
> -}
> -
> -static void scif_dma_callback(void *arg)
> -{
> -	struct completion *done =3D (struct completion *)arg;
> -
> -	complete(done);
> -}
> -
> -#define SCIF_DMA_SYNC_WAIT true
> -#define SCIF_DMA_POLL BIT(0)
> -#define SCIF_DMA_INTR BIT(1)
> -
> -/*
> - * scif_async_dma - Program a DMA with an interrupt descriptor
> - *
> - * @dev - The address of the pointer to the device instance used
> - * for DMA registration.
> - * @chan - DMA channel to be used.
> - * Return 0 on success and -errno on error.
> - */
> -static int scif_async_dma(struct scif_hw_dev *sdev, struct dma_chan *cha=
n)
> -{
> -	int err =3D 0;
> -	struct dma_device *ddev;
> -	struct dma_async_tx_descriptor *tx =3D NULL;
> -	enum dma_ctrl_flags flags =3D DMA_PREP_INTERRUPT |
> DMA_PREP_FENCE;
> -	DECLARE_COMPLETION_ONSTACK(done_wait);
> -	dma_cookie_t cookie;
> -	enum dma_status status;
> -
> -	if (!chan) {
> -		err =3D -EIO;
> -		dev_err(&sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		return err;
> -	}
> -	ddev =3D chan->device;
> -
> -	tx =3D ddev->device_prep_dma_memcpy(chan, 0, 0, 0, flags);
> -	if (!tx) {
> -		err =3D -ENOMEM;
> -		dev_err(&sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto release;
> -	}
> -	reinit_completion(&done_wait);
> -	tx->callback =3D scif_dma_callback;
> -	tx->callback_param =3D &done_wait;
> -	cookie =3D tx->tx_submit(tx);
> -
> -	if (dma_submit_error(cookie)) {
> -		err =3D -ENOMEM;
> -		dev_err(&sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto release;
> -	}
> -	dma_async_issue_pending(chan);
> -
> -	err =3D wait_for_completion_timeout(&done_wait, SCIF_DMA_TO);
> -	if (!err) {
> -		err =3D -EIO;
> -		dev_err(&sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto release;
> -	}
> -	err =3D 0;
> -	status =3D dma_async_is_tx_complete(chan, cookie, NULL, NULL);
> -	if (status !=3D DMA_COMPLETE) {
> -		err =3D -EIO;
> -		dev_err(&sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto release;
> -	}
> -release:
> -	return err;
> -}
> -
> -/*
> - * scif_drain_dma_poll - Drain all outstanding DMA operations for a
> particular
> - * DMA channel via polling.
> - *
> - * @sdev - The SCIF device
> - * @chan - DMA channel
> - * Return 0 on success and -errno on error.
> - */
> -static int scif_drain_dma_poll(struct scif_hw_dev *sdev, struct dma_chan
> *chan)
> -{
> -	if (!chan)
> -		return -EINVAL;
> -	return scif_sync_dma(sdev, chan, SCIF_DMA_SYNC_WAIT);
> -}
> -
> -/*
> - * scif_drain_dma_intr - Drain all outstanding DMA operations for a
> particular
> - * DMA channel via interrupt based blocking wait.
> - *
> - * @sdev - The SCIF device
> - * @chan - DMA channel
> - * Return 0 on success and -errno on error.
> - */
> -int scif_drain_dma_intr(struct scif_hw_dev *sdev, struct dma_chan *chan)
> -{
> -	if (!chan)
> -		return -EINVAL;
> -	return scif_async_dma(sdev, chan);
> -}
> -
> -/**
> - * scif_rma_destroy_windows:
> - *
> - * This routine destroys all windows queued for cleanup
> - */
> -void scif_rma_destroy_windows(void)
> -{
> -	struct list_head *item, *tmp;
> -	struct scif_window *window;
> -	struct scif_endpt *ep;
> -	struct dma_chan *chan;
> -
> -	might_sleep();
> -restart:
> -	spin_lock(&scif_info.rmalock);
> -	list_for_each_safe(item, tmp, &scif_info.rma) {
> -		window =3D list_entry(item, struct scif_window,
> -				    list);
> -		ep =3D (struct scif_endpt *)window->ep;
> -		chan =3D ep->rma_info.dma_chan;
> -
> -		list_del_init(&window->list);
> -		spin_unlock(&scif_info.rmalock);
> -		if (!chan || !scifdev_alive(ep) ||
> -		    !scif_drain_dma_intr(ep->remote_dev->sdev,
> -					 ep->rma_info.dma_chan))
> -			/* Remove window from global list */
> -			window->unreg_state =3D OP_COMPLETED;
> -		else
> -			dev_warn(&ep->remote_dev->sdev->dev,
> -				 "DMA engine hung?\n");
> -		if (window->unreg_state =3D=3D OP_COMPLETED) {
> -			if (window->type =3D=3D SCIF_WINDOW_SELF)
> -				scif_destroy_window(ep, window);
> -			else
> -				scif_destroy_remote_window(window);
> -			atomic_dec(&ep->rma_info.tw_refcount);
> -		}
> -		goto restart;
> -	}
> -	spin_unlock(&scif_info.rmalock);
> -}
> -
> -/**
> - * scif_rma_destroy_tcw:
> - *
> - * This routine destroys temporary cached registered windows
> - * which have been queued for cleanup.
> - */
> -void scif_rma_destroy_tcw_invalid(void)
> -{
> -	struct list_head *item, *tmp;
> -	struct scif_window *window;
> -	struct scif_endpt *ep;
> -	struct dma_chan *chan;
> -
> -	might_sleep();
> -restart:
> -	spin_lock(&scif_info.rmalock);
> -	list_for_each_safe(item, tmp, &scif_info.rma_tc) {
> -		window =3D list_entry(item, struct scif_window, list);
> -		ep =3D (struct scif_endpt *)window->ep;
> -		chan =3D ep->rma_info.dma_chan;
> -		list_del_init(&window->list);
> -		spin_unlock(&scif_info.rmalock);
> -		mutex_lock(&ep->rma_info.rma_lock);
> -		if (!chan || !scifdev_alive(ep) ||
> -		    !scif_drain_dma_intr(ep->remote_dev->sdev,
> -					 ep->rma_info.dma_chan)) {
> -			atomic_sub(window->nr_pages,
> -				   &ep->rma_info.tcw_total_pages);
> -			scif_destroy_window(ep, window);
> -			atomic_dec(&ep->rma_info.tcw_refcount);
> -		} else {
> -			dev_warn(&ep->remote_dev->sdev->dev,
> -				 "DMA engine hung?\n");
> -		}
> -		mutex_unlock(&ep->rma_info.rma_lock);
> -		goto restart;
> -	}
> -	spin_unlock(&scif_info.rmalock);
> -}
> -
> -static inline
> -void *_get_local_va(off_t off, struct scif_window *window, size_t len)
> -{
> -	int page_nr =3D (off - window->offset) >> PAGE_SHIFT;
> -	off_t page_off =3D off & ~PAGE_MASK;
> -	void *va =3D NULL;
> -
> -	if (window->type =3D=3D SCIF_WINDOW_SELF) {
> -		struct page **pages =3D window->pinned_pages->pages;
> -
> -		va =3D page_address(pages[page_nr]) + page_off;
> -	}
> -	return va;
> -}
> -
> -static inline
> -void *ioremap_remote(off_t off, struct scif_window *window,
> -		     size_t len, struct scif_dev *dev,
> -		     struct scif_window_iter *iter)
> -{
> -	dma_addr_t phys =3D scif_off_to_dma_addr(window, off, NULL, iter);
> -
> -	/*
> -	 * If the DMA address is not card relative then we need the DMA
> -	 * addresses to be an offset into the bar. The aperture base was
> already
> -	 * added so subtract it here since scif_ioremap is going to add it agai=
n
> -	 */
> -	if (!scifdev_self(dev) && window->type =3D=3D SCIF_WINDOW_PEER &&
> -	    dev->sdev->aper && !dev->sdev->card_rel_da)
> -		phys =3D phys - dev->sdev->aper->pa;
> -	return scif_ioremap(phys, len, dev);
> -}
> -
> -static inline void
> -iounmap_remote(void *virt, size_t size, struct scif_copy_work *work)
> -{
> -	scif_iounmap(virt, size, work->remote_dev);
> -}
> -
> -/*
> - * Takes care of ordering issue caused by
> - * 1. Hardware:  Only in the case of cpu copy from mgmt node to card
> - * because of WC memory.
> - * 2. Software: If memcpy reorders copy instructions for optimization.
> - * This could happen at both mgmt node and card.
> - */
> -static inline void
> -scif_ordered_memcpy_toio(char *dst, const char *src, size_t count)
> -{
> -	if (!count)
> -		return;
> -
> -	memcpy_toio((void __iomem __force *)dst, src, --count);
> -	/* Order the last byte with the previous stores */
> -	wmb();
> -	*(dst + count) =3D *(src + count);
> -}
> -
> -static inline void scif_unaligned_cpy_toio(char *dst, const char *src,
> -					   size_t count, bool ordered)
> -{
> -	if (ordered)
> -		scif_ordered_memcpy_toio(dst, src, count);
> -	else
> -		memcpy_toio((void __iomem __force *)dst, src, count);
> -}
> -
> -static inline
> -void scif_ordered_memcpy_fromio(char *dst, const char *src, size_t count=
)
> -{
> -	if (!count)
> -		return;
> -
> -	memcpy_fromio(dst, (void __iomem __force *)src, --count);
> -	/* Order the last byte with the previous loads */
> -	rmb();
> -	*(dst + count) =3D *(src + count);
> -}
> -
> -static inline void scif_unaligned_cpy_fromio(char *dst, const char *src,
> -					     size_t count, bool ordered)
> -{
> -	if (ordered)
> -		scif_ordered_memcpy_fromio(dst, src, count);
> -	else
> -		memcpy_fromio(dst, (void __iomem __force *)src, count);
> -}
> -
> -#define SCIF_RMA_ERROR_CODE (~(dma_addr_t)0x0)
> -
> -/*
> - * scif_off_to_dma_addr:
> - * Obtain the dma_addr given the window and the offset.
> - * @window: Registered window.
> - * @off: Window offset.
> - * @nr_bytes: Return the number of contiguous bytes till next DMA addr
> index.
> - * @index: Return the index of the dma_addr array found.
> - * @start_off: start offset of index of the dma addr array found.
> - * The nr_bytes provides the callee an estimate of the maximum possible
> - * DMA xfer possible while the index/start_off provide faster lookups
> - * for the next iteration.
> - */
> -dma_addr_t scif_off_to_dma_addr(struct scif_window *window, s64 off,
> -				size_t *nr_bytes, struct scif_window_iter
> *iter)
> -{
> -	int i, page_nr;
> -	s64 start, end;
> -	off_t page_off;
> -
> -	if (window->nr_pages =3D=3D window->nr_contig_chunks) {
> -		page_nr =3D (off - window->offset) >> PAGE_SHIFT;
> -		page_off =3D off & ~PAGE_MASK;
> -
> -		if (nr_bytes)
> -			*nr_bytes =3D PAGE_SIZE - page_off;
> -		return window->dma_addr[page_nr] | page_off;
> -	}
> -	if (iter) {
> -		i =3D iter->index;
> -		start =3D iter->offset;
> -	} else {
> -		i =3D  0;
> -		start =3D  window->offset;
> -	}
> -	for (; i < window->nr_contig_chunks; i++) {
> -		end =3D start + (window->num_pages[i] << PAGE_SHIFT);
> -		if (off >=3D start && off < end) {
> -			if (iter) {
> -				iter->index =3D i;
> -				iter->offset =3D start;
> -			}
> -			if (nr_bytes)
> -				*nr_bytes =3D end - off;
> -			return (window->dma_addr[i] + (off - start));
> -		}
> -		start +=3D (window->num_pages[i] << PAGE_SHIFT);
> -	}
> -	dev_err(scif_info.mdev.this_device,
> -		"%s %d BUG. Addr not found? window %p off 0x%llx\n",
> -		__func__, __LINE__, window, off);
> -	return SCIF_RMA_ERROR_CODE;
> -}
> -
> -/*
> - * Copy between rma window and temporary buffer
> - */
> -static void scif_rma_local_cpu_copy(s64 offset, struct scif_window *wind=
ow,
> -				    u8 *temp, size_t rem_len, bool to_temp)
> -{
> -	void *window_virt;
> -	size_t loop_len;
> -	int offset_in_page;
> -	s64 end_offset;
> -
> -	offset_in_page =3D offset & ~PAGE_MASK;
> -	loop_len =3D PAGE_SIZE - offset_in_page;
> -
> -	if (rem_len < loop_len)
> -		loop_len =3D rem_len;
> -
> -	window_virt =3D _get_local_va(offset, window, loop_len);
> -	if (!window_virt)
> -		return;
> -	if (to_temp)
> -		memcpy(temp, window_virt, loop_len);
> -	else
> -		memcpy(window_virt, temp, loop_len);
> -
> -	offset +=3D loop_len;
> -	temp +=3D loop_len;
> -	rem_len -=3D loop_len;
> -
> -	end_offset =3D window->offset +
> -		(window->nr_pages << PAGE_SHIFT);
> -	while (rem_len) {
> -		if (offset =3D=3D end_offset) {
> -			window =3D list_next_entry(window, list);
> -			end_offset =3D window->offset +
> -				(window->nr_pages << PAGE_SHIFT);
> -		}
> -		loop_len =3D min(PAGE_SIZE, rem_len);
> -		window_virt =3D _get_local_va(offset, window, loop_len);
> -		if (!window_virt)
> -			return;
> -		if (to_temp)
> -			memcpy(temp, window_virt, loop_len);
> -		else
> -			memcpy(window_virt, temp, loop_len);
> -		offset	+=3D loop_len;
> -		temp	+=3D loop_len;
> -		rem_len	-=3D loop_len;
> -	}
> -}
> -
> -/**
> - * scif_rma_completion_cb:
> - * @data: RMA cookie
> - *
> - * RMA interrupt completion callback.
> - */
> -static void scif_rma_completion_cb(void *data)
> -{
> -	struct scif_dma_comp_cb *comp_cb =3D data;
> -
> -	/* Free DMA Completion CB. */
> -	if (comp_cb->dst_window)
> -		scif_rma_local_cpu_copy(comp_cb->dst_offset,
> -					comp_cb->dst_window,
> -					comp_cb->temp_buf +
> -					comp_cb->header_padding,
> -					comp_cb->len, false);
> -	scif_unmap_single(comp_cb->temp_phys, comp_cb->sdev,
> -			  SCIF_KMEM_UNALIGNED_BUF_SIZE);
> -	if (comp_cb->is_cache)
> -		kmem_cache_free(unaligned_cache,
> -				comp_cb->temp_buf_to_free);
> -	else
> -		kfree(comp_cb->temp_buf_to_free);
> -}
> -
> -/* Copies between temporary buffer and offsets provided in work */
> -static int
> -scif_rma_list_dma_copy_unaligned(struct scif_copy_work *work,
> -				 u8 *temp, struct dma_chan *chan,
> -				 bool src_local)
> -{
> -	struct scif_dma_comp_cb *comp_cb =3D work->comp_cb;
> -	dma_addr_t window_dma_addr, temp_dma_addr;
> -	dma_addr_t temp_phys =3D comp_cb->temp_phys;
> -	size_t loop_len, nr_contig_bytes =3D 0, remaining_len =3D work->len;
> -	int offset_in_ca, ret =3D 0;
> -	s64 end_offset, offset;
> -	struct scif_window *window;
> -	void *window_virt_addr;
> -	size_t tail_len;
> -	struct dma_async_tx_descriptor *tx;
> -	struct dma_device *dev =3D chan->device;
> -	dma_cookie_t cookie;
> -
> -	if (src_local) {
> -		offset =3D work->dst_offset;
> -		window =3D work->dst_window;
> -	} else {
> -		offset =3D work->src_offset;
> -		window =3D work->src_window;
> -	}
> -
> -	offset_in_ca =3D offset & (L1_CACHE_BYTES - 1);
> -	if (offset_in_ca) {
> -		loop_len =3D L1_CACHE_BYTES - offset_in_ca;
> -		loop_len =3D min(loop_len, remaining_len);
> -		window_virt_addr =3D ioremap_remote(offset, window,
> -						  loop_len,
> -						  work->remote_dev,
> -						  NULL);
> -		if (!window_virt_addr)
> -			return -ENOMEM;
> -		if (src_local)
> -			scif_unaligned_cpy_toio(window_virt_addr, temp,
> -						loop_len,
> -						work->ordered &&
> -						!(remaining_len - loop_len));
> -		else
> -			scif_unaligned_cpy_fromio(temp, window_virt_addr,
> -						  loop_len, work->ordered
> &&
> -						  !(remaining_len - loop_len));
> -		iounmap_remote(window_virt_addr, loop_len, work);
> -
> -		offset +=3D loop_len;
> -		temp +=3D loop_len;
> -		temp_phys +=3D loop_len;
> -		remaining_len -=3D loop_len;
> -	}
> -
> -	offset_in_ca =3D offset & ~PAGE_MASK;
> -	end_offset =3D window->offset +
> -		(window->nr_pages << PAGE_SHIFT);
> -
> -	tail_len =3D remaining_len & (L1_CACHE_BYTES - 1);
> -	remaining_len -=3D tail_len;
> -	while (remaining_len) {
> -		if (offset =3D=3D end_offset) {
> -			window =3D list_next_entry(window, list);
> -			end_offset =3D window->offset +
> -				(window->nr_pages << PAGE_SHIFT);
> -		}
> -		if (scif_is_mgmt_node())
> -			temp_dma_addr =3D temp_phys;
> -		else
> -			/* Fix if we ever enable IOMMU on the card */
> -			temp_dma_addr =3D (dma_addr_t)virt_to_phys(temp);
> -		window_dma_addr =3D scif_off_to_dma_addr(window, offset,
> -						       &nr_contig_bytes,
> -						       NULL);
> -		loop_len =3D min(nr_contig_bytes, remaining_len);
> -		if (src_local) {
> -			if (work->ordered && !tail_len &&
> -			    !(remaining_len - loop_len) &&
> -			    loop_len !=3D L1_CACHE_BYTES) {
> -				/*
> -				 * Break up the last chunk of the transfer into
> -				 * two steps. if there is no tail to guarantee
> -				 * DMA ordering. SCIF_DMA_POLLING inserts
> -				 * a status update descriptor in step 1 which
> -				 * acts as a double sided synchronization
> fence
> -				 * for the DMA engine to ensure that the last
> -				 * cache line in step 2 is updated last.
> -				 */
> -				/* Step 1) DMA: Body Length -
> L1_CACHE_BYTES. */
> -				tx =3D
> -				dev->device_prep_dma_memcpy(chan,
> -							    window_dma_addr,
> -							    temp_dma_addr,
> -							    loop_len -
> -							    L1_CACHE_BYTES,
> -							    DMA_PREP_FENCE);
> -				if (!tx) {
> -					ret =3D -ENOMEM;
> -					goto err;
> -				}
> -				cookie =3D tx->tx_submit(tx);
> -				if (dma_submit_error(cookie)) {
> -					ret =3D -ENOMEM;
> -					goto err;
> -				}
> -				dma_async_issue_pending(chan);
> -				offset +=3D (loop_len - L1_CACHE_BYTES);
> -				temp_dma_addr +=3D (loop_len -
> L1_CACHE_BYTES);
> -				window_dma_addr +=3D (loop_len -
> L1_CACHE_BYTES);
> -				remaining_len -=3D (loop_len -
> L1_CACHE_BYTES);
> -				loop_len =3D remaining_len;
> -
> -				/* Step 2) DMA: L1_CACHE_BYTES */
> -				tx =3D
> -				dev->device_prep_dma_memcpy(chan,
> -							    window_dma_addr,
> -							    temp_dma_addr,
> -							    loop_len, 0);
> -				if (!tx) {
> -					ret =3D -ENOMEM;
> -					goto err;
> -				}
> -				cookie =3D tx->tx_submit(tx);
> -				if (dma_submit_error(cookie)) {
> -					ret =3D -ENOMEM;
> -					goto err;
> -				}
> -				dma_async_issue_pending(chan);
> -			} else {
> -				tx =3D
> -				dev->device_prep_dma_memcpy(chan,
> -							    window_dma_addr,
> -							    temp_dma_addr,
> -							    loop_len, 0);
> -				if (!tx) {
> -					ret =3D -ENOMEM;
> -					goto err;
> -				}
> -				cookie =3D tx->tx_submit(tx);
> -				if (dma_submit_error(cookie)) {
> -					ret =3D -ENOMEM;
> -					goto err;
> -				}
> -				dma_async_issue_pending(chan);
> -			}
> -		} else {
> -			tx =3D dev->device_prep_dma_memcpy(chan,
> temp_dma_addr,
> -					window_dma_addr, loop_len, 0);
> -			if (!tx) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			cookie =3D tx->tx_submit(tx);
> -			if (dma_submit_error(cookie)) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			dma_async_issue_pending(chan);
> -		}
> -		offset +=3D loop_len;
> -		temp +=3D loop_len;
> -		temp_phys +=3D loop_len;
> -		remaining_len -=3D loop_len;
> -		offset_in_ca =3D 0;
> -	}
> -	if (tail_len) {
> -		if (offset =3D=3D end_offset) {
> -			window =3D list_next_entry(window, list);
> -			end_offset =3D window->offset +
> -				(window->nr_pages << PAGE_SHIFT);
> -		}
> -		window_virt_addr =3D ioremap_remote(offset, window,
> tail_len,
> -						  work->remote_dev,
> -						  NULL);
> -		if (!window_virt_addr)
> -			return -ENOMEM;
> -		/*
> -		 * The CPU copy for the tail bytes must be initiated only once
> -		 * previous DMA transfers for this endpoint have completed
> -		 * to guarantee ordering.
> -		 */
> -		if (work->ordered) {
> -			struct scif_dev *rdev =3D work->remote_dev;
> -
> -			ret =3D scif_drain_dma_intr(rdev->sdev, chan);
> -			if (ret)
> -				return ret;
> -		}
> -		if (src_local)
> -			scif_unaligned_cpy_toio(window_virt_addr, temp,
> -						tail_len, work->ordered);
> -		else
> -			scif_unaligned_cpy_fromio(temp, window_virt_addr,
> -						  tail_len, work->ordered);
> -		iounmap_remote(window_virt_addr, tail_len, work);
> -	}
> -	tx =3D dev->device_prep_dma_memcpy(chan, 0, 0, 0,
> DMA_PREP_INTERRUPT);
> -	if (!tx) {
> -		ret =3D -ENOMEM;
> -		return ret;
> -	}
> -	tx->callback =3D &scif_rma_completion_cb;
> -	tx->callback_param =3D comp_cb;
> -	cookie =3D tx->tx_submit(tx);
> -
> -	if (dma_submit_error(cookie)) {
> -		ret =3D -ENOMEM;
> -		return ret;
> -	}
> -	dma_async_issue_pending(chan);
> -	return 0;
> -err:
> -	dev_err(scif_info.mdev.this_device,
> -		"%s %d Desc Prog Failed ret %d\n",
> -		__func__, __LINE__, ret);
> -	return ret;
> -}
> -
> -/*
> - * _scif_rma_list_dma_copy_aligned:
> - *
> - * Traverse all the windows and perform DMA copy.
> - */
> -static int _scif_rma_list_dma_copy_aligned(struct scif_copy_work *work,
> -					   struct dma_chan *chan)
> -{
> -	dma_addr_t src_dma_addr, dst_dma_addr;
> -	size_t loop_len, remaining_len, src_contig_bytes =3D 0;
> -	size_t dst_contig_bytes =3D 0;
> -	struct scif_window_iter src_win_iter;
> -	struct scif_window_iter dst_win_iter;
> -	s64 end_src_offset, end_dst_offset;
> -	struct scif_window *src_window =3D work->src_window;
> -	struct scif_window *dst_window =3D work->dst_window;
> -	s64 src_offset =3D work->src_offset, dst_offset =3D work->dst_offset;
> -	int ret =3D 0;
> -	struct dma_async_tx_descriptor *tx;
> -	struct dma_device *dev =3D chan->device;
> -	dma_cookie_t cookie;
> -
> -	remaining_len =3D work->len;
> -
> -	scif_init_window_iter(src_window, &src_win_iter);
> -	scif_init_window_iter(dst_window, &dst_win_iter);
> -	end_src_offset =3D src_window->offset +
> -		(src_window->nr_pages << PAGE_SHIFT);
> -	end_dst_offset =3D dst_window->offset +
> -		(dst_window->nr_pages << PAGE_SHIFT);
> -	while (remaining_len) {
> -		if (src_offset =3D=3D end_src_offset) {
> -			src_window =3D list_next_entry(src_window, list);
> -			end_src_offset =3D src_window->offset +
> -				(src_window->nr_pages << PAGE_SHIFT);
> -			scif_init_window_iter(src_window, &src_win_iter);
> -		}
> -		if (dst_offset =3D=3D end_dst_offset) {
> -			dst_window =3D list_next_entry(dst_window, list);
> -			end_dst_offset =3D dst_window->offset +
> -				(dst_window->nr_pages << PAGE_SHIFT);
> -			scif_init_window_iter(dst_window, &dst_win_iter);
> -		}
> -
> -		/* compute dma addresses for transfer */
> -		src_dma_addr =3D scif_off_to_dma_addr(src_window,
> src_offset,
> -						    &src_contig_bytes,
> -						    &src_win_iter);
> -		dst_dma_addr =3D scif_off_to_dma_addr(dst_window,
> dst_offset,
> -						    &dst_contig_bytes,
> -						    &dst_win_iter);
> -		loop_len =3D min(src_contig_bytes, dst_contig_bytes);
> -		loop_len =3D min(loop_len, remaining_len);
> -		if (work->ordered && !(remaining_len - loop_len)) {
> -			/*
> -			 * Break up the last chunk of the transfer into two
> -			 * steps to ensure that the last byte in step 2 is
> -			 * updated last.
> -			 */
> -			/* Step 1) DMA: Body Length - 1 */
> -			tx =3D dev->device_prep_dma_memcpy(chan,
> dst_dma_addr,
> -							 src_dma_addr,
> -							 loop_len - 1,
> -							 DMA_PREP_FENCE);
> -			if (!tx) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			cookie =3D tx->tx_submit(tx);
> -			if (dma_submit_error(cookie)) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			src_offset +=3D (loop_len - 1);
> -			dst_offset +=3D (loop_len - 1);
> -			src_dma_addr +=3D (loop_len - 1);
> -			dst_dma_addr +=3D (loop_len - 1);
> -			remaining_len -=3D (loop_len - 1);
> -			loop_len =3D remaining_len;
> -
> -			/* Step 2) DMA: 1 BYTES */
> -			tx =3D dev->device_prep_dma_memcpy(chan,
> dst_dma_addr,
> -					src_dma_addr, loop_len, 0);
> -			if (!tx) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			cookie =3D tx->tx_submit(tx);
> -			if (dma_submit_error(cookie)) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			dma_async_issue_pending(chan);
> -		} else {
> -			tx =3D dev->device_prep_dma_memcpy(chan,
> dst_dma_addr,
> -					src_dma_addr, loop_len, 0);
> -			if (!tx) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			cookie =3D tx->tx_submit(tx);
> -			if (dma_submit_error(cookie)) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -		}
> -		src_offset +=3D loop_len;
> -		dst_offset +=3D loop_len;
> -		remaining_len -=3D loop_len;
> -	}
> -	return ret;
> -err:
> -	dev_err(scif_info.mdev.this_device,
> -		"%s %d Desc Prog Failed ret %d\n",
> -		__func__, __LINE__, ret);
> -	return ret;
> -}
> -
> -/*
> - * scif_rma_list_dma_copy_aligned:
> - *
> - * Traverse all the windows and perform DMA copy.
> - */
> -static int scif_rma_list_dma_copy_aligned(struct scif_copy_work *work,
> -					  struct dma_chan *chan)
> -{
> -	dma_addr_t src_dma_addr, dst_dma_addr;
> -	size_t loop_len, remaining_len, tail_len, src_contig_bytes =3D 0;
> -	size_t dst_contig_bytes =3D 0;
> -	int src_cache_off;
> -	s64 end_src_offset, end_dst_offset;
> -	struct scif_window_iter src_win_iter;
> -	struct scif_window_iter dst_win_iter;
> -	void *src_virt, *dst_virt;
> -	struct scif_window *src_window =3D work->src_window;
> -	struct scif_window *dst_window =3D work->dst_window;
> -	s64 src_offset =3D work->src_offset, dst_offset =3D work->dst_offset;
> -	int ret =3D 0;
> -	struct dma_async_tx_descriptor *tx;
> -	struct dma_device *dev =3D chan->device;
> -	dma_cookie_t cookie;
> -
> -	remaining_len =3D work->len;
> -	scif_init_window_iter(src_window, &src_win_iter);
> -	scif_init_window_iter(dst_window, &dst_win_iter);
> -
> -	src_cache_off =3D src_offset & (L1_CACHE_BYTES - 1);
> -	if (src_cache_off !=3D 0) {
> -		/* Head */
> -		loop_len =3D L1_CACHE_BYTES - src_cache_off;
> -		loop_len =3D min(loop_len, remaining_len);
> -		src_dma_addr =3D __scif_off_to_dma_addr(src_window,
> src_offset);
> -		dst_dma_addr =3D __scif_off_to_dma_addr(dst_window,
> dst_offset);
> -		if (src_window->type =3D=3D SCIF_WINDOW_SELF)
> -			src_virt =3D _get_local_va(src_offset, src_window,
> -						 loop_len);
> -		else
> -			src_virt =3D ioremap_remote(src_offset, src_window,
> -						  loop_len,
> -						  work->remote_dev, NULL);
> -		if (!src_virt)
> -			return -ENOMEM;
> -		if (dst_window->type =3D=3D SCIF_WINDOW_SELF)
> -			dst_virt =3D _get_local_va(dst_offset, dst_window,
> -						 loop_len);
> -		else
> -			dst_virt =3D ioremap_remote(dst_offset, dst_window,
> -						  loop_len,
> -						  work->remote_dev, NULL);
> -		if (!dst_virt) {
> -			if (src_window->type !=3D SCIF_WINDOW_SELF)
> -				iounmap_remote(src_virt, loop_len, work);
> -			return -ENOMEM;
> -		}
> -		if (src_window->type =3D=3D SCIF_WINDOW_SELF)
> -			scif_unaligned_cpy_toio(dst_virt, src_virt, loop_len,
> -						remaining_len =3D=3D loop_len ?
> -						work->ordered : false);
> -		else
> -			scif_unaligned_cpy_fromio(dst_virt, src_virt,
> loop_len,
> -						  remaining_len =3D=3D loop_len ?
> -						  work->ordered : false);
> -		if (src_window->type !=3D SCIF_WINDOW_SELF)
> -			iounmap_remote(src_virt, loop_len, work);
> -		if (dst_window->type !=3D SCIF_WINDOW_SELF)
> -			iounmap_remote(dst_virt, loop_len, work);
> -		src_offset +=3D loop_len;
> -		dst_offset +=3D loop_len;
> -		remaining_len -=3D loop_len;
> -	}
> -
> -	end_src_offset =3D src_window->offset +
> -		(src_window->nr_pages << PAGE_SHIFT);
> -	end_dst_offset =3D dst_window->offset +
> -		(dst_window->nr_pages << PAGE_SHIFT);
> -	tail_len =3D remaining_len & (L1_CACHE_BYTES - 1);
> -	remaining_len -=3D tail_len;
> -	while (remaining_len) {
> -		if (src_offset =3D=3D end_src_offset) {
> -			src_window =3D list_next_entry(src_window, list);
> -			end_src_offset =3D src_window->offset +
> -				(src_window->nr_pages << PAGE_SHIFT);
> -			scif_init_window_iter(src_window, &src_win_iter);
> -		}
> -		if (dst_offset =3D=3D end_dst_offset) {
> -			dst_window =3D list_next_entry(dst_window, list);
> -			end_dst_offset =3D dst_window->offset +
> -				(dst_window->nr_pages << PAGE_SHIFT);
> -			scif_init_window_iter(dst_window, &dst_win_iter);
> -		}
> -
> -		/* compute dma addresses for transfer */
> -		src_dma_addr =3D scif_off_to_dma_addr(src_window,
> src_offset,
> -						    &src_contig_bytes,
> -						    &src_win_iter);
> -		dst_dma_addr =3D scif_off_to_dma_addr(dst_window,
> dst_offset,
> -						    &dst_contig_bytes,
> -						    &dst_win_iter);
> -		loop_len =3D min(src_contig_bytes, dst_contig_bytes);
> -		loop_len =3D min(loop_len, remaining_len);
> -		if (work->ordered && !tail_len &&
> -		    !(remaining_len - loop_len)) {
> -			/*
> -			 * Break up the last chunk of the transfer into two
> -			 * steps. if there is no tail to gurantee DMA ordering.
> -			 * Passing SCIF_DMA_POLLING inserts a status update
> -			 * descriptor in step 1 which acts as a double sided
> -			 * synchronization fence for the DMA engine to
> ensure
> -			 * that the last cache line in step 2 is updated last.
> -			 */
> -			/* Step 1) DMA: Body Length - L1_CACHE_BYTES. */
> -			tx =3D dev->device_prep_dma_memcpy(chan,
> dst_dma_addr,
> -							 src_dma_addr,
> -							 loop_len -
> -							 L1_CACHE_BYTES,
> -							 DMA_PREP_FENCE);
> -			if (!tx) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			cookie =3D tx->tx_submit(tx);
> -			if (dma_submit_error(cookie)) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			dma_async_issue_pending(chan);
> -			src_offset +=3D (loop_len - L1_CACHE_BYTES);
> -			dst_offset +=3D (loop_len - L1_CACHE_BYTES);
> -			src_dma_addr +=3D (loop_len - L1_CACHE_BYTES);
> -			dst_dma_addr +=3D (loop_len - L1_CACHE_BYTES);
> -			remaining_len -=3D (loop_len - L1_CACHE_BYTES);
> -			loop_len =3D remaining_len;
> -
> -			/* Step 2) DMA: L1_CACHE_BYTES */
> -			tx =3D dev->device_prep_dma_memcpy(chan,
> dst_dma_addr,
> -							 src_dma_addr,
> -							 loop_len, 0);
> -			if (!tx) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			cookie =3D tx->tx_submit(tx);
> -			if (dma_submit_error(cookie)) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			dma_async_issue_pending(chan);
> -		} else {
> -			tx =3D dev->device_prep_dma_memcpy(chan,
> dst_dma_addr,
> -							 src_dma_addr,
> -							 loop_len, 0);
> -			if (!tx) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			cookie =3D tx->tx_submit(tx);
> -			if (dma_submit_error(cookie)) {
> -				ret =3D -ENOMEM;
> -				goto err;
> -			}
> -			dma_async_issue_pending(chan);
> -		}
> -		src_offset +=3D loop_len;
> -		dst_offset +=3D loop_len;
> -		remaining_len -=3D loop_len;
> -	}
> -	remaining_len =3D tail_len;
> -	if (remaining_len) {
> -		loop_len =3D remaining_len;
> -		if (src_offset =3D=3D end_src_offset)
> -			src_window =3D list_next_entry(src_window, list);
> -		if (dst_offset =3D=3D end_dst_offset)
> -			dst_window =3D list_next_entry(dst_window, list);
> -
> -		src_dma_addr =3D __scif_off_to_dma_addr(src_window,
> src_offset);
> -		dst_dma_addr =3D __scif_off_to_dma_addr(dst_window,
> dst_offset);
> -		/*
> -		 * The CPU copy for the tail bytes must be initiated only once
> -		 * previous DMA transfers for this endpoint have completed
> to
> -		 * guarantee ordering.
> -		 */
> -		if (work->ordered) {
> -			struct scif_dev *rdev =3D work->remote_dev;
> -
> -			ret =3D scif_drain_dma_poll(rdev->sdev, chan);
> -			if (ret)
> -				return ret;
> -		}
> -		if (src_window->type =3D=3D SCIF_WINDOW_SELF)
> -			src_virt =3D _get_local_va(src_offset, src_window,
> -						 loop_len);
> -		else
> -			src_virt =3D ioremap_remote(src_offset, src_window,
> -						  loop_len,
> -						  work->remote_dev, NULL);
> -		if (!src_virt)
> -			return -ENOMEM;
> -
> -		if (dst_window->type =3D=3D SCIF_WINDOW_SELF)
> -			dst_virt =3D _get_local_va(dst_offset, dst_window,
> -						 loop_len);
> -		else
> -			dst_virt =3D ioremap_remote(dst_offset, dst_window,
> -						  loop_len,
> -						  work->remote_dev, NULL);
> -		if (!dst_virt) {
> -			if (src_window->type !=3D SCIF_WINDOW_SELF)
> -				iounmap_remote(src_virt, loop_len, work);
> -			return -ENOMEM;
> -		}
> -
> -		if (src_window->type =3D=3D SCIF_WINDOW_SELF)
> -			scif_unaligned_cpy_toio(dst_virt, src_virt, loop_len,
> -						work->ordered);
> -		else
> -			scif_unaligned_cpy_fromio(dst_virt, src_virt,
> -						  loop_len, work->ordered);
> -		if (src_window->type !=3D SCIF_WINDOW_SELF)
> -			iounmap_remote(src_virt, loop_len, work);
> -
> -		if (dst_window->type !=3D SCIF_WINDOW_SELF)
> -			iounmap_remote(dst_virt, loop_len, work);
> -		remaining_len -=3D loop_len;
> -	}
> -	return ret;
> -err:
> -	dev_err(scif_info.mdev.this_device,
> -		"%s %d Desc Prog Failed ret %d\n",
> -		__func__, __LINE__, ret);
> -	return ret;
> -}
> -
> -/*
> - * scif_rma_list_cpu_copy:
> - *
> - * Traverse all the windows and perform CPU copy.
> - */
> -static int scif_rma_list_cpu_copy(struct scif_copy_work *work)
> -{
> -	void *src_virt, *dst_virt;
> -	size_t loop_len, remaining_len;
> -	int src_page_off, dst_page_off;
> -	s64 src_offset =3D work->src_offset, dst_offset =3D work->dst_offset;
> -	struct scif_window *src_window =3D work->src_window;
> -	struct scif_window *dst_window =3D work->dst_window;
> -	s64 end_src_offset, end_dst_offset;
> -	int ret =3D 0;
> -	struct scif_window_iter src_win_iter;
> -	struct scif_window_iter dst_win_iter;
> -
> -	remaining_len =3D work->len;
> -
> -	scif_init_window_iter(src_window, &src_win_iter);
> -	scif_init_window_iter(dst_window, &dst_win_iter);
> -	while (remaining_len) {
> -		src_page_off =3D src_offset & ~PAGE_MASK;
> -		dst_page_off =3D dst_offset & ~PAGE_MASK;
> -		loop_len =3D min(PAGE_SIZE -
> -			       max(src_page_off, dst_page_off),
> -			       remaining_len);
> -
> -		if (src_window->type =3D=3D SCIF_WINDOW_SELF)
> -			src_virt =3D _get_local_va(src_offset, src_window,
> -						 loop_len);
> -		else
> -			src_virt =3D ioremap_remote(src_offset, src_window,
> -						  loop_len,
> -						  work->remote_dev,
> -						  &src_win_iter);
> -		if (!src_virt) {
> -			ret =3D -ENOMEM;
> -			goto error;
> -		}
> -
> -		if (dst_window->type =3D=3D SCIF_WINDOW_SELF)
> -			dst_virt =3D _get_local_va(dst_offset, dst_window,
> -						 loop_len);
> -		else
> -			dst_virt =3D ioremap_remote(dst_offset, dst_window,
> -						  loop_len,
> -						  work->remote_dev,
> -						  &dst_win_iter);
> -		if (!dst_virt) {
> -			if (src_window->type =3D=3D SCIF_WINDOW_PEER)
> -				iounmap_remote(src_virt, loop_len, work);
> -			ret =3D -ENOMEM;
> -			goto error;
> -		}
> -
> -		if (work->loopback) {
> -			memcpy(dst_virt, src_virt, loop_len);
> -		} else {
> -			if (src_window->type =3D=3D SCIF_WINDOW_SELF)
> -				memcpy_toio((void __iomem __force
> *)dst_virt,
> -					    src_virt, loop_len);
> -			else
> -				memcpy_fromio(dst_virt,
> -					      (void __iomem __force *)src_virt,
> -					      loop_len);
> -		}
> -		if (src_window->type =3D=3D SCIF_WINDOW_PEER)
> -			iounmap_remote(src_virt, loop_len, work);
> -
> -		if (dst_window->type =3D=3D SCIF_WINDOW_PEER)
> -			iounmap_remote(dst_virt, loop_len, work);
> -
> -		src_offset +=3D loop_len;
> -		dst_offset +=3D loop_len;
> -		remaining_len -=3D loop_len;
> -		if (remaining_len) {
> -			end_src_offset =3D src_window->offset +
> -				(src_window->nr_pages << PAGE_SHIFT);
> -			end_dst_offset =3D dst_window->offset +
> -				(dst_window->nr_pages << PAGE_SHIFT);
> -			if (src_offset =3D=3D end_src_offset) {
> -				src_window =3D list_next_entry(src_window,
> list);
> -				scif_init_window_iter(src_window,
> -						      &src_win_iter);
> -			}
> -			if (dst_offset =3D=3D end_dst_offset) {
> -				dst_window =3D list_next_entry(dst_window,
> list);
> -				scif_init_window_iter(dst_window,
> -						      &dst_win_iter);
> -			}
> -		}
> -	}
> -error:
> -	return ret;
> -}
> -
> -static int scif_rma_list_dma_copy_wrapper(struct scif_endpt *epd,
> -					  struct scif_copy_work *work,
> -					  struct dma_chan *chan, off_t loffset)
> -{
> -	int src_cache_off, dst_cache_off;
> -	s64 src_offset =3D work->src_offset, dst_offset =3D work->dst_offset;
> -	u8 *temp =3D NULL;
> -	bool src_local =3D true;
> -	struct scif_dma_comp_cb *comp_cb;
> -	int err;
> -
> -	if (is_dma_copy_aligned(chan->device, 1, 1, 1))
> -		return _scif_rma_list_dma_copy_aligned(work, chan);
> -
> -	src_cache_off =3D src_offset & (L1_CACHE_BYTES - 1);
> -	dst_cache_off =3D dst_offset & (L1_CACHE_BYTES - 1);
> -
> -	if (dst_cache_off =3D=3D src_cache_off)
> -		return scif_rma_list_dma_copy_aligned(work, chan);
> -
> -	if (work->loopback)
> -		return scif_rma_list_cpu_copy(work);
> -	src_local =3D work->src_window->type =3D=3D SCIF_WINDOW_SELF;
> -
> -	/* Allocate dma_completion cb */
> -	comp_cb =3D kzalloc(sizeof(*comp_cb), GFP_KERNEL);
> -	if (!comp_cb)
> -		goto error;
> -
> -	work->comp_cb =3D comp_cb;
> -	comp_cb->cb_cookie =3D comp_cb;
> -	comp_cb->dma_completion_func =3D &scif_rma_completion_cb;
> -
> -	if (work->len + (L1_CACHE_BYTES << 1) <
> SCIF_KMEM_UNALIGNED_BUF_SIZE) {
> -		comp_cb->is_cache =3D false;
> -		/* Allocate padding bytes to align to a cache line */
> -		temp =3D kmalloc(work->len + (L1_CACHE_BYTES << 1),
> -			       GFP_KERNEL);
> -		if (!temp)
> -			goto free_comp_cb;
> -		comp_cb->temp_buf_to_free =3D temp;
> -		/* kmalloc(..) does not guarantee cache line alignment */
> -		if (!IS_ALIGNED((u64)temp, L1_CACHE_BYTES))
> -			temp =3D PTR_ALIGN(temp, L1_CACHE_BYTES);
> -	} else {
> -		comp_cb->is_cache =3D true;
> -		temp =3D kmem_cache_alloc(unaligned_cache, GFP_KERNEL);
> -		if (!temp)
> -			goto free_comp_cb;
> -		comp_cb->temp_buf_to_free =3D temp;
> -	}
> -
> -	if (src_local) {
> -		temp +=3D dst_cache_off;
> -		scif_rma_local_cpu_copy(work->src_offset, work-
> >src_window,
> -					temp, work->len, true);
> -	} else {
> -		comp_cb->dst_window =3D work->dst_window;
> -		comp_cb->dst_offset =3D work->dst_offset;
> -		work->src_offset =3D work->src_offset - src_cache_off;
> -		comp_cb->len =3D work->len;
> -		work->len =3D ALIGN(work->len + src_cache_off,
> L1_CACHE_BYTES);
> -		comp_cb->header_padding =3D src_cache_off;
> -	}
> -	comp_cb->temp_buf =3D temp;
> -
> -	err =3D scif_map_single(&comp_cb->temp_phys, temp,
> -			      work->remote_dev,
> SCIF_KMEM_UNALIGNED_BUF_SIZE);
> -	if (err)
> -		goto free_temp_buf;
> -	comp_cb->sdev =3D work->remote_dev;
> -	if (scif_rma_list_dma_copy_unaligned(work, temp, chan, src_local) <
> 0)
> -		goto free_temp_buf;
> -	if (!src_local)
> -		work->fence_type =3D SCIF_DMA_INTR;
> -	return 0;
> -free_temp_buf:
> -	if (comp_cb->is_cache)
> -		kmem_cache_free(unaligned_cache, comp_cb-
> >temp_buf_to_free);
> -	else
> -		kfree(comp_cb->temp_buf_to_free);
> -free_comp_cb:
> -	kfree(comp_cb);
> -error:
> -	return -ENOMEM;
> -}
> -
> -/**
> - * scif_rma_copy:
> - * @epd: end point descriptor.
> - * @loffset: offset in local registered address space to/from which to c=
opy
> - * @addr: user virtual address to/from which to copy
> - * @len: length of range to copy
> - * @roffset: offset in remote registered address space to/from which to
> copy
> - * @flags: flags
> - * @dir: LOCAL->REMOTE or vice versa.
> - * @last_chunk: true if this is the last chunk of a larger transfer
> - *
> - * Validate parameters, check if src/dst registered ranges requested for=
 copy
> - * are valid and initiate either CPU or DMA copy.
> - */
> -static int scif_rma_copy(scif_epd_t epd, off_t loffset, unsigned long ad=
dr,
> -			 size_t len, off_t roffset, int flags,
> -			 enum scif_rma_dir dir, bool last_chunk)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct scif_rma_req remote_req;
> -	struct scif_rma_req req;
> -	struct scif_window *local_window =3D NULL;
> -	struct scif_window *remote_window =3D NULL;
> -	struct scif_copy_work copy_work;
> -	bool loopback;
> -	int err =3D 0;
> -	struct dma_chan *chan;
> -	struct scif_mmu_notif *mmn =3D NULL;
> -	bool cache =3D false;
> -	struct device *spdev;
> -
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -
> -	if (flags && !(flags & (SCIF_RMA_USECPU | SCIF_RMA_USECACHE |
> -				SCIF_RMA_SYNC | SCIF_RMA_ORDERED)))
> -		return -EINVAL;
> -
> -	loopback =3D scifdev_self(ep->remote_dev) ? true : false;
> -	copy_work.fence_type =3D ((flags & SCIF_RMA_SYNC) && last_chunk) ?
> -				SCIF_DMA_POLL : 0;
> -	copy_work.ordered =3D !!((flags & SCIF_RMA_ORDERED) &&
> last_chunk);
> -
> -	/* Use CPU for Mgmt node <-> Mgmt node copies */
> -	if (loopback && scif_is_mgmt_node()) {
> -		flags |=3D SCIF_RMA_USECPU;
> -		copy_work.fence_type =3D 0x0;
> -	}
> -
> -	cache =3D scif_is_set_reg_cache(flags);
> -
> -	remote_req.out_window =3D &remote_window;
> -	remote_req.offset =3D roffset;
> -	remote_req.nr_bytes =3D len;
> -	/*
> -	 * If transfer is from local to remote then the remote window
> -	 * must be writeable and vice versa.
> -	 */
> -	remote_req.prot =3D dir =3D=3D SCIF_LOCAL_TO_REMOTE ? VM_WRITE :
> VM_READ;
> -	remote_req.type =3D SCIF_WINDOW_PARTIAL;
> -	remote_req.head =3D &ep->rma_info.remote_reg_list;
> -
> -	spdev =3D scif_get_peer_dev(ep->remote_dev);
> -	if (IS_ERR(spdev)) {
> -		err =3D PTR_ERR(spdev);
> -		return err;
> -	}
> -
> -	if (addr && cache) {
> -		mutex_lock(&ep->rma_info.mmn_lock);
> -		mmn =3D scif_find_mmu_notifier(current->mm, &ep-
> >rma_info);
> -		if (!mmn)
> -			mmn =3D scif_add_mmu_notifier(current->mm, ep);
> -		mutex_unlock(&ep->rma_info.mmn_lock);
> -		if (IS_ERR(mmn)) {
> -			scif_put_peer_dev(spdev);
> -			return PTR_ERR(mmn);
> -		}
> -		cache =3D cache && !scif_rma_tc_can_cache(ep, len);
> -	}
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	if (addr) {
> -		req.out_window =3D &local_window;
> -		req.nr_bytes =3D ALIGN(len + (addr & ~PAGE_MASK),
> -				     PAGE_SIZE);
> -		req.va_for_temp =3D addr & PAGE_MASK;
> -		req.prot =3D (dir =3D=3D SCIF_LOCAL_TO_REMOTE ?
> -			    VM_READ : VM_WRITE | VM_READ);
> -		/* Does a valid local window exist? */
> -		if (mmn) {
> -			spin_lock(&ep->rma_info.tc_lock);
> -			req.head =3D &mmn->tc_reg_list;
> -			err =3D scif_query_tcw(ep, &req);
> -			spin_unlock(&ep->rma_info.tc_lock);
> -		}
> -		if (!mmn || err) {
> -			err =3D scif_register_temp(epd, req.va_for_temp,
> -						 req.nr_bytes, req.prot,
> -						 &loffset, &local_window);
> -			if (err) {
> -				mutex_unlock(&ep->rma_info.rma_lock);
> -				goto error;
> -			}
> -			if (!cache)
> -				goto skip_cache;
> -			atomic_inc(&ep->rma_info.tcw_refcount);
> -			atomic_add_return(local_window->nr_pages,
> -					  &ep->rma_info.tcw_total_pages);
> -			if (mmn) {
> -				spin_lock(&ep->rma_info.tc_lock);
> -				scif_insert_tcw(local_window,
> -						&mmn->tc_reg_list);
> -				spin_unlock(&ep->rma_info.tc_lock);
> -			}
> -		}
> -skip_cache:
> -		loffset =3D local_window->offset +
> -				(addr - local_window->va_for_temp);
> -	} else {
> -		req.out_window =3D &local_window;
> -		req.offset =3D loffset;
> -		/*
> -		 * If transfer is from local to remote then the self window
> -		 * must be readable and vice versa.
> -		 */
> -		req.prot =3D dir =3D=3D SCIF_LOCAL_TO_REMOTE ? VM_READ :
> VM_WRITE;
> -		req.nr_bytes =3D len;
> -		req.type =3D SCIF_WINDOW_PARTIAL;
> -		req.head =3D &ep->rma_info.reg_list;
> -		/* Does a valid local window exist? */
> -		err =3D scif_query_window(&req);
> -		if (err) {
> -			mutex_unlock(&ep->rma_info.rma_lock);
> -			goto error;
> -		}
> -	}
> -
> -	/* Does a valid remote window exist? */
> -	err =3D scif_query_window(&remote_req);
> -	if (err) {
> -		mutex_unlock(&ep->rma_info.rma_lock);
> -		goto error;
> -	}
> -
> -	/*
> -	 * Prepare copy_work for submitting work to the DMA kernel thread
> -	 * or CPU copy routine.
> -	 */
> -	copy_work.len =3D len;
> -	copy_work.loopback =3D loopback;
> -	copy_work.remote_dev =3D ep->remote_dev;
> -	if (dir =3D=3D SCIF_LOCAL_TO_REMOTE) {
> -		copy_work.src_offset =3D loffset;
> -		copy_work.src_window =3D local_window;
> -		copy_work.dst_offset =3D roffset;
> -		copy_work.dst_window =3D remote_window;
> -	} else {
> -		copy_work.src_offset =3D roffset;
> -		copy_work.src_window =3D remote_window;
> -		copy_work.dst_offset =3D loffset;
> -		copy_work.dst_window =3D local_window;
> -	}
> -
> -	if (flags & SCIF_RMA_USECPU) {
> -		scif_rma_list_cpu_copy(&copy_work);
> -	} else {
> -		chan =3D ep->rma_info.dma_chan;
> -		err =3D scif_rma_list_dma_copy_wrapper(epd, &copy_work,
> -						     chan, loffset);
> -	}
> -	if (addr && !cache)
> -		atomic_inc(&ep->rma_info.tw_refcount);
> -
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -
> -	if (last_chunk) {
> -		struct scif_dev *rdev =3D ep->remote_dev;
> -
> -		if (copy_work.fence_type =3D=3D SCIF_DMA_POLL)
> -			err =3D scif_drain_dma_poll(rdev->sdev,
> -						  ep->rma_info.dma_chan);
> -		else if (copy_work.fence_type =3D=3D SCIF_DMA_INTR)
> -			err =3D scif_drain_dma_intr(rdev->sdev,
> -						  ep->rma_info.dma_chan);
> -	}
> -
> -	if (addr && !cache)
> -		scif_queue_for_cleanup(local_window, &scif_info.rma);
> -	scif_put_peer_dev(spdev);
> -	return err;
> -error:
> -	if (err) {
> -		if (addr && local_window && !cache)
> -			scif_destroy_window(ep, local_window);
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d err %d len 0x%lx\n",
> -			__func__, __LINE__, err, len);
> -	}
> -	scif_put_peer_dev(spdev);
> -	return err;
> -}
> -
> -int scif_readfrom(scif_epd_t epd, off_t loffset, size_t len,
> -		  off_t roffset, int flags)
> -{
> -	int err;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI readfrom: ep %p loffset 0x%lx len 0x%lx offset 0x%lx
> flags 0x%x\n",
> -		epd, loffset, len, roffset, flags);
> -	if (scif_unaligned(loffset, roffset)) {
> -		while (len > SCIF_MAX_UNALIGNED_BUF_SIZE) {
> -			err =3D scif_rma_copy(epd, loffset, 0x0,
> -					    SCIF_MAX_UNALIGNED_BUF_SIZE,
> -					    roffset, flags,
> -					    SCIF_REMOTE_TO_LOCAL, false);
> -			if (err)
> -				goto readfrom_err;
> -			loffset +=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -			roffset +=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -			len -=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -		}
> -	}
> -	err =3D scif_rma_copy(epd, loffset, 0x0, len,
> -			    roffset, flags, SCIF_REMOTE_TO_LOCAL, true);
> -readfrom_err:
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_readfrom);
> -
> -int scif_writeto(scif_epd_t epd, off_t loffset, size_t len,
> -		 off_t roffset, int flags)
> -{
> -	int err;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI writeto: ep %p loffset 0x%lx len 0x%lx roffset 0x%lx
> flags 0x%x\n",
> -		epd, loffset, len, roffset, flags);
> -	if (scif_unaligned(loffset, roffset)) {
> -		while (len > SCIF_MAX_UNALIGNED_BUF_SIZE) {
> -			err =3D scif_rma_copy(epd, loffset, 0x0,
> -					    SCIF_MAX_UNALIGNED_BUF_SIZE,
> -					    roffset, flags,
> -					    SCIF_LOCAL_TO_REMOTE, false);
> -			if (err)
> -				goto writeto_err;
> -			loffset +=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -			roffset +=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -			len -=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -		}
> -	}
> -	err =3D scif_rma_copy(epd, loffset, 0x0, len,
> -			    roffset, flags, SCIF_LOCAL_TO_REMOTE, true);
> -writeto_err:
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_writeto);
> -
> -int scif_vreadfrom(scif_epd_t epd, void *addr, size_t len,
> -		   off_t roffset, int flags)
> -{
> -	int err;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI vreadfrom: ep %p addr %p len 0x%lx roffset 0x%lx
> flags 0x%x\n",
> -		epd, addr, len, roffset, flags);
> -	if (scif_unaligned((off_t __force)addr, roffset)) {
> -		if (len > SCIF_MAX_UNALIGNED_BUF_SIZE)
> -			flags &=3D ~SCIF_RMA_USECACHE;
> -
> -		while (len > SCIF_MAX_UNALIGNED_BUF_SIZE) {
> -			err =3D scif_rma_copy(epd, 0, (u64)addr,
> -					    SCIF_MAX_UNALIGNED_BUF_SIZE,
> -					    roffset, flags,
> -					    SCIF_REMOTE_TO_LOCAL, false);
> -			if (err)
> -				goto vreadfrom_err;
> -			addr +=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -			roffset +=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -			len -=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -		}
> -	}
> -	err =3D scif_rma_copy(epd, 0, (u64)addr, len,
> -			    roffset, flags, SCIF_REMOTE_TO_LOCAL, true);
> -vreadfrom_err:
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_vreadfrom);
> -
> -int scif_vwriteto(scif_epd_t epd, void *addr, size_t len,
> -		  off_t roffset, int flags)
> -{
> -	int err;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI vwriteto: ep %p addr %p len 0x%lx roffset 0x%lx
> flags 0x%x\n",
> -		epd, addr, len, roffset, flags);
> -	if (scif_unaligned((off_t __force)addr, roffset)) {
> -		if (len > SCIF_MAX_UNALIGNED_BUF_SIZE)
> -			flags &=3D ~SCIF_RMA_USECACHE;
> -
> -		while (len > SCIF_MAX_UNALIGNED_BUF_SIZE) {
> -			err =3D scif_rma_copy(epd, 0, (u64)addr,
> -					    SCIF_MAX_UNALIGNED_BUF_SIZE,
> -					    roffset, flags,
> -					    SCIF_LOCAL_TO_REMOTE, false);
> -			if (err)
> -				goto vwriteto_err;
> -			addr +=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -			roffset +=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -			len -=3D SCIF_MAX_UNALIGNED_BUF_SIZE;
> -		}
> -	}
> -	err =3D scif_rma_copy(epd, 0, (u64)addr, len,
> -			    roffset, flags, SCIF_LOCAL_TO_REMOTE, true);
> -vwriteto_err:
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_vwriteto);
> diff --git a/drivers/misc/mic/scif/scif_epd.c
> b/drivers/misc/mic/scif/scif_epd.c
> deleted file mode 100644
> index 426687f6696b..000000000000
> --- a/drivers/misc/mic/scif/scif_epd.c
> +++ /dev/null
> @@ -1,357 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include "scif_main.h"
> -#include "scif_map.h"
> -
> -void scif_cleanup_ep_qp(struct scif_endpt *ep)
> -{
> -	struct scif_qp *qp =3D ep->qp_info.qp;
> -
> -	if (qp->outbound_q.rb_base) {
> -		scif_iounmap((void *)qp->outbound_q.rb_base,
> -			     qp->outbound_q.size, ep->remote_dev);
> -		qp->outbound_q.rb_base =3D NULL;
> -	}
> -	if (qp->remote_qp) {
> -		scif_iounmap((void *)qp->remote_qp,
> -			     sizeof(struct scif_qp), ep->remote_dev);
> -		qp->remote_qp =3D NULL;
> -	}
> -	if (qp->local_qp) {
> -		scif_unmap_single(qp->local_qp, ep->remote_dev,
> -				  sizeof(struct scif_qp));
> -		qp->local_qp =3D 0x0;
> -	}
> -	if (qp->local_buf) {
> -		scif_unmap_single(qp->local_buf, ep->remote_dev,
> -				  SCIF_ENDPT_QP_SIZE);
> -		qp->local_buf =3D 0;
> -	}
> -}
> -
> -void scif_teardown_ep(void *endpt)
> -{
> -	struct scif_endpt *ep =3D endpt;
> -	struct scif_qp *qp =3D ep->qp_info.qp;
> -
> -	if (qp) {
> -		spin_lock(&ep->lock);
> -		scif_cleanup_ep_qp(ep);
> -		spin_unlock(&ep->lock);
> -		kfree(qp->inbound_q.rb_base);
> -		kfree(qp);
> -	}
> -}
> -
> -/*
> - * Enqueue the endpoint to the zombie list for cleanup.
> - * The endpoint should not be accessed once this API returns.
> - */
> -void scif_add_epd_to_zombie_list(struct scif_endpt *ep, bool eplock_held=
)
> -{
> -	if (!eplock_held)
> -		mutex_lock(&scif_info.eplock);
> -	spin_lock(&ep->lock);
> -	ep->state =3D SCIFEP_ZOMBIE;
> -	spin_unlock(&ep->lock);
> -	list_add_tail(&ep->list, &scif_info.zombie);
> -	scif_info.nr_zombies++;
> -	if (!eplock_held)
> -		mutex_unlock(&scif_info.eplock);
> -	schedule_work(&scif_info.misc_work);
> -}
> -
> -static struct scif_endpt *scif_find_listen_ep(u16 port)
> -{
> -	struct scif_endpt *ep =3D NULL;
> -	struct list_head *pos, *tmpq;
> -
> -	mutex_lock(&scif_info.eplock);
> -	list_for_each_safe(pos, tmpq, &scif_info.listen) {
> -		ep =3D list_entry(pos, struct scif_endpt, list);
> -		if (ep->port.port =3D=3D port) {
> -			mutex_unlock(&scif_info.eplock);
> -			return ep;
> -		}
> -	}
> -	mutex_unlock(&scif_info.eplock);
> -	return NULL;
> -}
> -
> -void scif_cleanup_zombie_epd(void)
> -{
> -	struct list_head *pos, *tmpq;
> -	struct scif_endpt *ep;
> -
> -	mutex_lock(&scif_info.eplock);
> -	list_for_each_safe(pos, tmpq, &scif_info.zombie) {
> -		ep =3D list_entry(pos, struct scif_endpt, list);
> -		if (scif_rma_ep_can_uninit(ep)) {
> -			list_del(pos);
> -			scif_info.nr_zombies--;
> -			put_iova_domain(&ep->rma_info.iovad);
> -			kfree(ep);
> -		}
> -	}
> -	mutex_unlock(&scif_info.eplock);
> -}
> -
> -/**
> - * scif_cnctreq() - Respond to SCIF_CNCT_REQ interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * This message is initiated by the remote node to request a connection
> - * to the local node.  This function looks for an end point in the
> - * listen state on the requested port id.
> - *
> - * If it finds a listening port it places the connect request on the
> - * listening end points queue and wakes up any pending accept calls.
> - *
> - * If it does not find a listening end point it sends a connection
> - * reject message to the remote node.
> - */
> -void scif_cnctreq(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D NULL;
> -	struct scif_conreq *conreq;
> -
> -	conreq =3D kmalloc(sizeof(*conreq), GFP_KERNEL);
> -	if (!conreq)
> -		/* Lack of resources so reject the request. */
> -		goto conreq_sendrej;
> -
> -	ep =3D scif_find_listen_ep(msg->dst.port);
> -	if (!ep)
> -		/*  Send reject due to no listening ports */
> -		goto conreq_sendrej_free;
> -	else
> -		spin_lock(&ep->lock);
> -
> -	if (ep->backlog <=3D ep->conreqcnt) {
> -		/*  Send reject due to too many pending requests */
> -		spin_unlock(&ep->lock);
> -		goto conreq_sendrej_free;
> -	}
> -
> -	conreq->msg =3D *msg;
> -	list_add_tail(&conreq->list, &ep->conlist);
> -	ep->conreqcnt++;
> -	wake_up_interruptible(&ep->conwq);
> -	spin_unlock(&ep->lock);
> -	return;
> -
> -conreq_sendrej_free:
> -	kfree(conreq);
> -conreq_sendrej:
> -	msg->uop =3D SCIF_CNCT_REJ;
> -	scif_nodeqp_send(&scif_dev[msg->src.node], msg);
> -}
> -
> -/**
> - * scif_cnctgnt() - Respond to SCIF_CNCT_GNT interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * An accept() on the remote node has occurred and sent this message
> - * to indicate success.  Place the end point in the MAPPING state and
> - * save the remote nodes memory information.  Then wake up the connect
> - * request so it can finish.
> - */
> -void scif_cnctgnt(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -
> -	spin_lock(&ep->lock);
> -	if (SCIFEP_CONNECTING =3D=3D ep->state) {
> -		ep->peer.node =3D msg->src.node;
> -		ep->peer.port =3D msg->src.port;
> -		ep->qp_info.gnt_pld =3D msg->payload[1];
> -		ep->remote_ep =3D msg->payload[2];
> -		ep->state =3D SCIFEP_MAPPING;
> -
> -		wake_up(&ep->conwq);
> -	}
> -	spin_unlock(&ep->lock);
> -}
> -
> -/**
> - * scif_cnctgnt_ack() - Respond to SCIF_CNCT_GNTACK interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * The remote connection request has finished mapping the local memory.
> - * Place the connection in the connected state and wake up the pending
> - * accept() call.
> - */
> -void scif_cnctgnt_ack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -
> -	mutex_lock(&scif_info.connlock);
> -	spin_lock(&ep->lock);
> -	/* New ep is now connected with all resources set. */
> -	ep->state =3D SCIFEP_CONNECTED;
> -	list_add_tail(&ep->list, &scif_info.connected);
> -	wake_up(&ep->conwq);
> -	spin_unlock(&ep->lock);
> -	mutex_unlock(&scif_info.connlock);
> -}
> -
> -/**
> - * scif_cnctgnt_nack() - Respond to SCIF_CNCT_GNTNACK interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * The remote connection request failed to map the local memory it was
> sent.
> - * Place the end point in the CLOSING state to indicate it and wake up
> - * the pending accept();
> - */
> -void scif_cnctgnt_nack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -
> -	spin_lock(&ep->lock);
> -	ep->state =3D SCIFEP_CLOSING;
> -	wake_up(&ep->conwq);
> -	spin_unlock(&ep->lock);
> -}
> -
> -/**
> - * scif_cnctrej() - Respond to SCIF_CNCT_REJ interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * The remote end has rejected the connection request.  Set the end
> - * point back to the bound state and wake up the pending connect().
> - */
> -void scif_cnctrej(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -
> -	spin_lock(&ep->lock);
> -	if (SCIFEP_CONNECTING =3D=3D ep->state) {
> -		ep->state =3D SCIFEP_BOUND;
> -		wake_up(&ep->conwq);
> -	}
> -	spin_unlock(&ep->lock);
> -}
> -
> -/**
> - * scif_discnct() - Respond to SCIF_DISCNCT interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * The remote node has indicated close() has been called on its end
> - * point.  Remove the local end point from the connected list, set its
> - * state to disconnected and ensure accesses to the remote node are
> - * shutdown.
> - *
> - * When all accesses to the remote end have completed then send a
> - * DISCNT_ACK to indicate it can remove its resources and complete
> - * the close routine.
> - */
> -void scif_discnct(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D NULL;
> -	struct scif_endpt *tmpep;
> -	struct list_head *pos, *tmpq;
> -
> -	mutex_lock(&scif_info.connlock);
> -	list_for_each_safe(pos, tmpq, &scif_info.connected) {
> -		tmpep =3D list_entry(pos, struct scif_endpt, list);
> -		/*
> -		 * The local ep may have sent a disconnect and and been
> closed
> -		 * due to a message response time out. It may have been
> -		 * allocated again and formed a new connection so we want
> to
> -		 * check if the remote ep matches
> -		 */
> -		if (((u64)tmpep =3D=3D msg->payload[1]) &&
> -		    ((u64)tmpep->remote_ep =3D=3D msg->payload[0])) {
> -			list_del(pos);
> -			ep =3D tmpep;
> -			spin_lock(&ep->lock);
> -			break;
> -		}
> -	}
> -
> -	/*
> -	 * If the terminated end is not found then this side started closing
> -	 * before the other side sent the disconnect.  If so the ep will no
> -	 * longer be on the connected list.  Regardless the other side
> -	 * needs to be acked to let it know close is complete.
> -	 */
> -	if (!ep) {
> -		mutex_unlock(&scif_info.connlock);
> -		goto discnct_ack;
> -	}
> -
> -	ep->state =3D SCIFEP_DISCONNECTED;
> -	list_add_tail(&ep->list, &scif_info.disconnected);
> -
> -	wake_up_interruptible(&ep->sendwq);
> -	wake_up_interruptible(&ep->recvwq);
> -	spin_unlock(&ep->lock);
> -	mutex_unlock(&scif_info.connlock);
> -
> -discnct_ack:
> -	msg->uop =3D SCIF_DISCNT_ACK;
> -	scif_nodeqp_send(&scif_dev[msg->src.node], msg);
> -}
> -
> -/**
> - * scif_discnct_ack() - Respond to SCIF_DISCNT_ACK interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Remote side has indicated it has not more references to local resourc=
es
> - */
> -void scif_discnt_ack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -
> -	spin_lock(&ep->lock);
> -	ep->state =3D SCIFEP_DISCONNECTED;
> -	spin_unlock(&ep->lock);
> -	complete(&ep->discon);
> -}
> -
> -/**
> - * scif_clientsend() - Respond to SCIF_CLIENT_SEND interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Remote side is confirming send or receive interrupt handling is compl=
ete.
> - */
> -void scif_clientsend(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -
> -	spin_lock(&ep->lock);
> -	if (SCIFEP_CONNECTED =3D=3D ep->state)
> -		wake_up_interruptible(&ep->recvwq);
> -	spin_unlock(&ep->lock);
> -}
> -
> -/**
> - * scif_clientrcvd() - Respond to SCIF_CLIENT_RCVD interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Remote side is confirming send or receive interrupt handling is compl=
ete.
> - */
> -void scif_clientrcvd(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -
> -	spin_lock(&ep->lock);
> -	if (SCIFEP_CONNECTED =3D=3D ep->state)
> -		wake_up_interruptible(&ep->sendwq);
> -	spin_unlock(&ep->lock);
> -}
> diff --git a/drivers/misc/mic/scif/scif_epd.h
> b/drivers/misc/mic/scif/scif_epd.h
> deleted file mode 100644
> index 0b9dfe1cc06c..000000000000
> --- a/drivers/misc/mic/scif/scif_epd.h
> +++ /dev/null
> @@ -1,200 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#ifndef SCIF_EPD_H
> -#define SCIF_EPD_H
> -
> -#include <linux/delay.h>
> -#include <linux/scif.h>
> -#include <linux/scif_ioctl.h>
> -
> -#define SCIF_EPLOCK_HELD true
> -
> -enum scif_epd_state {
> -	SCIFEP_UNBOUND,
> -	SCIFEP_BOUND,
> -	SCIFEP_LISTENING,
> -	SCIFEP_CONNECTED,
> -	SCIFEP_CONNECTING,
> -	SCIFEP_MAPPING,
> -	SCIFEP_CLOSING,
> -	SCIFEP_CLLISTEN,
> -	SCIFEP_DISCONNECTED,
> -	SCIFEP_ZOMBIE
> -};
> -
> -/*
> - * struct scif_conreq - Data structure added to the connection list.
> - *
> - * @msg: connection request message received
> - * @list: link to list of connection requests
> - */
> -struct scif_conreq {
> -	struct scifmsg msg;
> -	struct list_head list;
> -};
> -
> -/* Size of the RB for the Endpoint QP */
> -#define SCIF_ENDPT_QP_SIZE 0x1000
> -
> -/*
> - * scif_endpt_qp_info - SCIF endpoint queue pair
> - *
> - * @qp - Qpair for this endpoint
> - * @qp_offset - DMA address of the QP
> - * @gnt_pld - Payload in a SCIF_CNCT_GNT message containing the
> - * physical address of the remote_qp.
> - */
> -struct scif_endpt_qp_info {
> -	struct scif_qp *qp;
> -	dma_addr_t qp_offset;
> -	dma_addr_t gnt_pld;
> -};
> -
> -/*
> - * struct scif_endpt - The SCIF endpoint data structure
> - *
> - * @state: end point state
> - * @lock: lock synchronizing access to endpoint fields like state etc
> - * @port: self port information
> - * @peer: peer port information
> - * @backlog: maximum pending connection requests
> - * @qp_info: Endpoint QP information for SCIF messaging
> - * @remote_dev: scifdev used by this endpt to communicate with remote
> node.
> - * @remote_ep: remote endpoint
> - * @conreqcnt: Keep track of number of connection requests.
> - * @files: Open file information used to match the id passed in with
> - *         the flush routine.
> - * @conlist: list of connection requests
> - * @conwq: waitqueue for connection processing
> - * @discon: completion used during disconnection
> - * @sendwq: waitqueue used during sending messages
> - * @recvwq: waitqueue used during message receipt
> - * @sendlock: Synchronize ordering of messages sent
> - * @recvlock: Synchronize ordering of messages received
> - * @list: link to list of various endpoints like connected, listening et=
c
> - * @li_accept: pending ACCEPTREG
> - * @acceptcnt: pending ACCEPTREG cnt
> - * @liacceptlist: link to listen accept
> - * @miacceptlist: link to uaccept
> - * @listenep: associated listen ep
> - * @conn_work: Non blocking connect work
> - * @conn_port: Connection port
> - * @conn_err: Errors during connection
> - * @conn_async_state: Async connection
> - * @conn_pend_wq: Used by poll while waiting for incoming connections
> - * @conn_list: List of async connection requests
> - * @rma_info: Information for triggering SCIF RMA and DMA operations
> - * @mmu_list: link to list of MMU notifier cleanup work
> - * @anon: anonymous file for use in kernel mode scif poll
> - */
> -struct scif_endpt {
> -	enum scif_epd_state state;
> -	spinlock_t lock;
> -	struct scif_port_id port;
> -	struct scif_port_id peer;
> -	int backlog;
> -	struct scif_endpt_qp_info qp_info;
> -	struct scif_dev *remote_dev;
> -	u64 remote_ep;
> -	int conreqcnt;
> -	struct files_struct *files;
> -	struct list_head conlist;
> -	wait_queue_head_t conwq;
> -	struct completion discon;
> -	wait_queue_head_t sendwq;
> -	wait_queue_head_t recvwq;
> -	struct mutex sendlock;
> -	struct mutex recvlock;
> -	struct list_head list;
> -	struct list_head li_accept;
> -	int acceptcnt;
> -	struct list_head liacceptlist;
> -	struct list_head miacceptlist;
> -	struct scif_endpt *listenep;
> -	struct scif_port_id conn_port;
> -	int conn_err;
> -	int conn_async_state;
> -	wait_queue_head_t conn_pend_wq;
> -	struct list_head conn_list;
> -	struct scif_endpt_rma_info rma_info;
> -	struct list_head mmu_list;
> -	struct file *anon;
> -};
> -
> -static inline int scifdev_alive(struct scif_endpt *ep)
> -{
> -	return _scifdev_alive(ep->remote_dev);
> -}
> -
> -/*
> - * scif_verify_epd:
> - * ep: SCIF endpoint
> - *
> - * Checks several generic error conditions and returns the
> - * appropriate error.
> - */
> -static inline int scif_verify_epd(struct scif_endpt *ep)
> -{
> -	if (ep->state =3D=3D SCIFEP_DISCONNECTED)
> -		return -ECONNRESET;
> -
> -	if (ep->state !=3D SCIFEP_CONNECTED)
> -		return -ENOTCONN;
> -
> -	if (!scifdev_alive(ep))
> -		return -ENODEV;
> -
> -	return 0;
> -}
> -
> -static inline int scif_anon_inode_getfile(scif_epd_t epd)
> -{
> -	epd->anon =3D anon_inode_getfile("scif", &scif_anon_fops, NULL, 0);
> -
> -	return PTR_ERR_OR_ZERO(epd->anon);
> -}
> -
> -static inline void scif_anon_inode_fput(scif_epd_t epd)
> -{
> -	if (epd->anon) {
> -		fput(epd->anon);
> -		epd->anon =3D NULL;
> -	}
> -}
> -
> -void scif_cleanup_zombie_epd(void);
> -void scif_teardown_ep(void *endpt);
> -void scif_cleanup_ep_qp(struct scif_endpt *ep);
> -void scif_add_epd_to_zombie_list(struct scif_endpt *ep, bool eplock_held=
);
> -void scif_get_node_info(void);
> -void scif_send_acks(struct scif_dev *dev);
> -void scif_conn_handler(struct work_struct *work);
> -int scif_rsrv_port(u16 port);
> -void scif_get_port(u16 port);
> -int scif_get_new_port(void);
> -void scif_put_port(u16 port);
> -int scif_user_send(scif_epd_t epd, void __user *msg, int len, int flags)=
;
> -int scif_user_recv(scif_epd_t epd, void __user *msg, int len, int flags)=
;
> -void scif_cnctreq(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_cnctgnt(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_cnctgnt_ack(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_cnctgnt_nack(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_cnctrej(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_discnct(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_discnt_ack(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_clientsend(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_clientrcvd(struct scif_dev *scifdev, struct scifmsg *msg);
> -int __scif_connect(scif_epd_t epd, struct scif_port_id *dst, bool non_bl=
ock);
> -int __scif_flush(scif_epd_t epd);
> -int scif_mmap(struct vm_area_struct *vma, scif_epd_t epd);
> -__poll_t __scif_pollfd(struct file *f, poll_table *wait,
> -			   struct scif_endpt *ep);
> -int __scif_pin_pages(void *addr, size_t len, int *out_prot,
> -		     int map_flags, scif_pinned_pages_t *pages);
> -#endif /* SCIF_EPD_H */
> diff --git a/drivers/misc/mic/scif/scif_fd.c b/drivers/misc/mic/scif/scif=
_fd.c
> deleted file mode 100644
> index 3f08646cd78a..000000000000
> --- a/drivers/misc/mic/scif/scif_fd.c
> +++ /dev/null
> @@ -1,462 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include "scif_main.h"
> -
> -static int scif_fdopen(struct inode *inode, struct file *f)
> -{
> -	struct scif_endpt *priv =3D scif_open();
> -
> -	if (!priv)
> -		return -ENOMEM;
> -	f->private_data =3D priv;
> -	return 0;
> -}
> -
> -static int scif_fdclose(struct inode *inode, struct file *f)
> -{
> -	struct scif_endpt *priv =3D f->private_data;
> -
> -	return scif_close(priv);
> -}
> -
> -static int scif_fdmmap(struct file *f, struct vm_area_struct *vma)
> -{
> -	struct scif_endpt *priv =3D f->private_data;
> -
> -	return scif_mmap(vma, priv);
> -}
> -
> -static __poll_t scif_fdpoll(struct file *f, poll_table *wait)
> -{
> -	struct scif_endpt *priv =3D f->private_data;
> -
> -	return __scif_pollfd(f, wait, priv);
> -}
> -
> -static int scif_fdflush(struct file *f, fl_owner_t id)
> -{
> -	struct scif_endpt *ep =3D f->private_data;
> -
> -	spin_lock(&ep->lock);
> -	/*
> -	 * The listening endpoint stashes the open file information before
> -	 * waiting for incoming connections. The release callback would
> never be
> -	 * called if the application closed the endpoint, while waiting for
> -	 * incoming connections from a separate thread since the file
> descriptor
> -	 * reference count is bumped up in the accept IOCTL. Call the flush
> -	 * routine if the id matches the endpoint open file information so
> that
> -	 * the listening endpoint can be woken up and the fd released.
> -	 */
> -	if (ep->files =3D=3D id)
> -		__scif_flush(ep);
> -	spin_unlock(&ep->lock);
> -	return 0;
> -}
> -
> -static __always_inline void scif_err_debug(int err, const char *str)
> -{
> -	/*
> -	 * ENOTCONN is a common uninteresting error which is
> -	 * flooding debug messages to the console unnecessarily.
> -	 */
> -	if (err < 0 && err !=3D -ENOTCONN)
> -		dev_dbg(scif_info.mdev.this_device, "%s err %d\n", str, err);
> -}
> -
> -static long scif_fdioctl(struct file *f, unsigned int cmd, unsigned long=
 arg)
> -{
> -	struct scif_endpt *priv =3D f->private_data;
> -	void __user *argp =3D (void __user *)arg;
> -	int err =3D 0;
> -	struct scifioctl_msg request;
> -	bool non_block =3D false;
> -
> -	non_block =3D !!(f->f_flags & O_NONBLOCK);
> -
> -	switch (cmd) {
> -	case SCIF_BIND:
> -	{
> -		int pn;
> -
> -		if (copy_from_user(&pn, argp, sizeof(pn)))
> -			return -EFAULT;
> -
> -		pn =3D scif_bind(priv, pn);
> -		if (pn < 0)
> -			return pn;
> -
> -		if (copy_to_user(argp, &pn, sizeof(pn)))
> -			return -EFAULT;
> -
> -		return 0;
> -	}
> -	case SCIF_LISTEN:
> -		return scif_listen(priv, arg);
> -	case SCIF_CONNECT:
> -	{
> -		struct scifioctl_connect req;
> -		struct scif_endpt *ep =3D (struct scif_endpt *)priv;
> -
> -		if (copy_from_user(&req, argp, sizeof(req)))
> -			return -EFAULT;
> -
> -		err =3D __scif_connect(priv, &req.peer, non_block);
> -		if (err < 0)
> -			return err;
> -
> -		req.self.node =3D ep->port.node;
> -		req.self.port =3D ep->port.port;
> -
> -		if (copy_to_user(argp, &req, sizeof(req)))
> -			return -EFAULT;
> -
> -		return 0;
> -	}
> -	/*
> -	 * Accept is done in two halves.  The request ioctl does the basic
> -	 * functionality of accepting the request and returning the
> information
> -	 * about it including the internal ID of the end point.  The register
> -	 * is done with the internal ID on a new file descriptor opened by the
> -	 * requesting process.
> -	 */
> -	case SCIF_ACCEPTREQ:
> -	{
> -		struct scifioctl_accept request;
> -		scif_epd_t *ep =3D (scif_epd_t *)&request.endpt;
> -
> -		if (copy_from_user(&request, argp, sizeof(request)))
> -			return -EFAULT;
> -
> -		err =3D scif_accept(priv, &request.peer, ep, request.flags);
> -		if (err < 0)
> -			return err;
> -
> -		if (copy_to_user(argp, &request, sizeof(request))) {
> -			scif_close(*ep);
> -			return -EFAULT;
> -		}
> -		/*
> -		 * Add to the list of user mode eps where the second half
> -		 * of the accept is not yet completed.
> -		 */
> -		mutex_lock(&scif_info.eplock);
> -		list_add_tail(&((*ep)->miacceptlist), &scif_info.uaccept);
> -		list_add_tail(&((*ep)->liacceptlist), &priv->li_accept);
> -		(*ep)->listenep =3D priv;
> -		priv->acceptcnt++;
> -		mutex_unlock(&scif_info.eplock);
> -
> -		return 0;
> -	}
> -	case SCIF_ACCEPTREG:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scif_endpt *newep;
> -		struct scif_endpt *lisep;
> -		struct scif_endpt *fep =3D NULL;
> -		struct scif_endpt *tmpep;
> -		struct list_head *pos, *tmpq;
> -
> -		/* Finally replace the pointer to the accepted endpoint */
> -		if (copy_from_user(&newep, argp, sizeof(void *)))
> -			return -EFAULT;
> -
> -		/* Remove form the user accept queue */
> -		mutex_lock(&scif_info.eplock);
> -		list_for_each_safe(pos, tmpq, &scif_info.uaccept) {
> -			tmpep =3D list_entry(pos,
> -					   struct scif_endpt, miacceptlist);
> -			if (tmpep =3D=3D newep) {
> -				list_del(pos);
> -				fep =3D tmpep;
> -				break;
> -			}
> -		}
> -
> -		if (!fep) {
> -			mutex_unlock(&scif_info.eplock);
> -			return -ENOENT;
> -		}
> -
> -		lisep =3D newep->listenep;
> -		list_for_each_safe(pos, tmpq, &lisep->li_accept) {
> -			tmpep =3D list_entry(pos,
> -					   struct scif_endpt, liacceptlist);
> -			if (tmpep =3D=3D newep) {
> -				list_del(pos);
> -				lisep->acceptcnt--;
> -				break;
> -			}
> -		}
> -
> -		mutex_unlock(&scif_info.eplock);
> -
> -		/* Free the resources automatically created from the open.
> */
> -		scif_anon_inode_fput(priv);
> -		scif_teardown_ep(priv);
> -		scif_add_epd_to_zombie_list(priv, !SCIF_EPLOCK_HELD);
> -		f->private_data =3D newep;
> -		return 0;
> -	}
> -	case SCIF_SEND:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -
> -		if (copy_from_user(&request, argp,
> -				   sizeof(struct scifioctl_msg))) {
> -			err =3D -EFAULT;
> -			goto send_err;
> -		}
> -		err =3D scif_user_send(priv, (void __user *)request.msg,
> -				     request.len, request.flags);
> -		if (err < 0)
> -			goto send_err;
> -		if (copy_to_user(&
> -				 ((struct scifioctl_msg __user *)argp)-
> >out_len,
> -				 &err, sizeof(err))) {
> -			err =3D -EFAULT;
> -			goto send_err;
> -		}
> -		err =3D 0;
> -send_err:
> -		scif_err_debug(err, "scif_send");
> -		return err;
> -	}
> -	case SCIF_RECV:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -
> -		if (copy_from_user(&request, argp,
> -				   sizeof(struct scifioctl_msg))) {
> -			err =3D -EFAULT;
> -			goto recv_err;
> -		}
> -
> -		err =3D scif_user_recv(priv, (void __user *)request.msg,
> -				     request.len, request.flags);
> -		if (err < 0)
> -			goto recv_err;
> -
> -		if (copy_to_user(&
> -				 ((struct scifioctl_msg __user *)argp)-
> >out_len,
> -			&err, sizeof(err))) {
> -			err =3D -EFAULT;
> -			goto recv_err;
> -		}
> -		err =3D 0;
> -recv_err:
> -		scif_err_debug(err, "scif_recv");
> -		return err;
> -	}
> -	case SCIF_GET_NODEIDS:
> -	{
> -		struct scifioctl_node_ids node_ids;
> -		int entries;
> -		u16 *nodes;
> -		void __user *unodes, *uself;
> -		u16 self;
> -
> -		if (copy_from_user(&node_ids, argp, sizeof(node_ids))) {
> -			err =3D -EFAULT;
> -			goto getnodes_err2;
> -		}
> -
> -		entries =3D min_t(int, scif_info.maxid, node_ids.len);
> -		nodes =3D kmalloc_array(entries, sizeof(u16), GFP_KERNEL);
> -		if (entries && !nodes) {
> -			err =3D -ENOMEM;
> -			goto getnodes_err2;
> -		}
> -		node_ids.len =3D scif_get_node_ids(nodes, entries, &self);
> -
> -		unodes =3D (void __user *)node_ids.nodes;
> -		if (copy_to_user(unodes, nodes, sizeof(u16) * entries)) {
> -			err =3D -EFAULT;
> -			goto getnodes_err1;
> -		}
> -
> -		uself =3D (void __user *)node_ids.self;
> -		if (copy_to_user(uself, &self, sizeof(u16))) {
> -			err =3D -EFAULT;
> -			goto getnodes_err1;
> -		}
> -
> -		if (copy_to_user(argp, &node_ids, sizeof(node_ids))) {
> -			err =3D -EFAULT;
> -			goto getnodes_err1;
> -		}
> -getnodes_err1:
> -		kfree(nodes);
> -getnodes_err2:
> -		return err;
> -	}
> -	case SCIF_REG:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scifioctl_reg reg;
> -		off_t ret;
> -
> -		if (copy_from_user(&reg, argp, sizeof(reg))) {
> -			err =3D -EFAULT;
> -			goto reg_err;
> -		}
> -		if (reg.flags & SCIF_MAP_KERNEL) {
> -			err =3D -EINVAL;
> -			goto reg_err;
> -		}
> -		ret =3D scif_register(priv, (void *)reg.addr, reg.len,
> -				    reg.offset, reg.prot, reg.flags);
> -		if (ret < 0) {
> -			err =3D (int)ret;
> -			goto reg_err;
> -		}
> -
> -		if (copy_to_user(&((struct scifioctl_reg __user *)argp)
> -				 ->out_offset, &ret, sizeof(reg.out_offset))) {
> -			err =3D -EFAULT;
> -			goto reg_err;
> -		}
> -		err =3D 0;
> -reg_err:
> -		scif_err_debug(err, "scif_register");
> -		return err;
> -	}
> -	case SCIF_UNREG:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scifioctl_unreg unreg;
> -
> -		if (copy_from_user(&unreg, argp, sizeof(unreg))) {
> -			err =3D -EFAULT;
> -			goto unreg_err;
> -		}
> -		err =3D scif_unregister(priv, unreg.offset, unreg.len);
> -unreg_err:
> -		scif_err_debug(err, "scif_unregister");
> -		return err;
> -	}
> -	case SCIF_READFROM:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scifioctl_copy copy;
> -
> -		if (copy_from_user(&copy, argp, sizeof(copy))) {
> -			err =3D -EFAULT;
> -			goto readfrom_err;
> -		}
> -		err =3D scif_readfrom(priv, copy.loffset, copy.len, copy.roffset,
> -				    copy.flags);
> -readfrom_err:
> -		scif_err_debug(err, "scif_readfrom");
> -		return err;
> -	}
> -	case SCIF_WRITETO:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scifioctl_copy copy;
> -
> -		if (copy_from_user(&copy, argp, sizeof(copy))) {
> -			err =3D -EFAULT;
> -			goto writeto_err;
> -		}
> -		err =3D scif_writeto(priv, copy.loffset, copy.len, copy.roffset,
> -				   copy.flags);
> -writeto_err:
> -		scif_err_debug(err, "scif_writeto");
> -		return err;
> -	}
> -	case SCIF_VREADFROM:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scifioctl_copy copy;
> -
> -		if (copy_from_user(&copy, argp, sizeof(copy))) {
> -			err =3D -EFAULT;
> -			goto vreadfrom_err;
> -		}
> -		err =3D scif_vreadfrom(priv, (void __force *)copy.addr,
> copy.len,
> -				     copy.roffset, copy.flags);
> -vreadfrom_err:
> -		scif_err_debug(err, "scif_vreadfrom");
> -		return err;
> -	}
> -	case SCIF_VWRITETO:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scifioctl_copy copy;
> -
> -		if (copy_from_user(&copy, argp, sizeof(copy))) {
> -			err =3D -EFAULT;
> -			goto vwriteto_err;
> -		}
> -		err =3D scif_vwriteto(priv, (void __force *)copy.addr, copy.len,
> -				    copy.roffset, copy.flags);
> -vwriteto_err:
> -		scif_err_debug(err, "scif_vwriteto");
> -		return err;
> -	}
> -	case SCIF_FENCE_MARK:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scifioctl_fence_mark mark;
> -		int tmp_mark =3D 0;
> -
> -		if (copy_from_user(&mark, argp, sizeof(mark))) {
> -			err =3D -EFAULT;
> -			goto fence_mark_err;
> -		}
> -		err =3D scif_fence_mark(priv, mark.flags, &tmp_mark);
> -		if (err)
> -			goto fence_mark_err;
> -		if (copy_to_user((void __user *)mark.mark, &tmp_mark,
> -				 sizeof(tmp_mark))) {
> -			err =3D -EFAULT;
> -			goto fence_mark_err;
> -		}
> -fence_mark_err:
> -		scif_err_debug(err, "scif_fence_mark");
> -		return err;
> -	}
> -	case SCIF_FENCE_WAIT:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -
> -		err =3D scif_fence_wait(priv, arg);
> -		scif_err_debug(err, "scif_fence_wait");
> -		return err;
> -	}
> -	case SCIF_FENCE_SIGNAL:
> -	{
> -		struct scif_endpt *priv =3D f->private_data;
> -		struct scifioctl_fence_signal signal;
> -
> -		if (copy_from_user(&signal, argp, sizeof(signal))) {
> -			err =3D -EFAULT;
> -			goto fence_signal_err;
> -		}
> -
> -		err =3D scif_fence_signal(priv, signal.loff, signal.lval,
> -					signal.roff, signal.rval, signal.flags);
> -fence_signal_err:
> -		scif_err_debug(err, "scif_fence_signal");
> -		return err;
> -	}
> -	}
> -	return -EINVAL;
> -}
> -
> -const struct file_operations scif_fops =3D {
> -	.open =3D scif_fdopen,
> -	.release =3D scif_fdclose,
> -	.unlocked_ioctl =3D scif_fdioctl,
> -	.mmap =3D scif_fdmmap,
> -	.poll =3D scif_fdpoll,
> -	.flush =3D scif_fdflush,
> -	.owner =3D THIS_MODULE,
> -};
> diff --git a/drivers/misc/mic/scif/scif_fence.c
> b/drivers/misc/mic/scif/scif_fence.c
> deleted file mode 100644
> index 4fedf6183951..000000000000
> --- a/drivers/misc/mic/scif/scif_fence.c
> +++ /dev/null
> @@ -1,783 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -
> -#include "scif_main.h"
> -
> -/**
> - * scif_recv_mark: Handle SCIF_MARK request
> - * @scifdev:	SCIF device
> - * @msg:	Interrupt message
> - *
> - * The peer has requested a mark.
> - */
> -void scif_recv_mark(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -	int mark =3D 0;
> -	int err;
> -
> -	err =3D _scif_fence_mark(ep, &mark);
> -	if (err)
> -		msg->uop =3D SCIF_MARK_NACK;
> -	else
> -		msg->uop =3D SCIF_MARK_ACK;
> -	msg->payload[0] =3D ep->remote_ep;
> -	msg->payload[2] =3D mark;
> -	scif_nodeqp_send(ep->remote_dev, msg);
> -}
> -
> -/**
> - * scif_recv_mark_resp: Handle SCIF_MARK_(N)ACK messages.
> - * @scifdev:	SCIF device
> - * @msg:	Interrupt message
> - *
> - * The peer has responded to a SCIF_MARK message.
> - */
> -void scif_recv_mark_resp(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -	struct scif_fence_info *fence_req =3D
> -		(struct scif_fence_info *)msg->payload[1];
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	if (msg->uop =3D=3D SCIF_MARK_ACK) {
> -		fence_req->state =3D OP_COMPLETED;
> -		fence_req->dma_mark =3D (int)msg->payload[2];
> -	} else {
> -		fence_req->state =3D OP_FAILED;
> -	}
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	complete(&fence_req->comp);
> -}
> -
> -/**
> - * scif_recv_wait: Handle SCIF_WAIT request
> - * @scifdev:	SCIF device
> - * @msg:	Interrupt message
> - *
> - * The peer has requested waiting on a fence.
> - */
> -void scif_recv_wait(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -	struct scif_remote_fence_info *fence;
> -
> -	/*
> -	 * Allocate structure for remote fence information and
> -	 * send a NACK if the allocation failed. The peer will
> -	 * return ENOMEM upon receiving a NACK.
> -	 */
> -	fence =3D kmalloc(sizeof(*fence), GFP_KERNEL);
> -	if (!fence) {
> -		msg->payload[0] =3D ep->remote_ep;
> -		msg->uop =3D SCIF_WAIT_NACK;
> -		scif_nodeqp_send(ep->remote_dev, msg);
> -		return;
> -	}
> -
> -	/* Prepare the fence request */
> -	memcpy(&fence->msg, msg, sizeof(struct scifmsg));
> -	INIT_LIST_HEAD(&fence->list);
> -
> -	/* Insert to the global remote fence request list */
> -	mutex_lock(&scif_info.fencelock);
> -	atomic_inc(&ep->rma_info.fence_refcount);
> -	list_add_tail(&fence->list, &scif_info.fence);
> -	mutex_unlock(&scif_info.fencelock);
> -
> -	schedule_work(&scif_info.misc_work);
> -}
> -
> -/**
> - * scif_recv_wait_resp: Handle SCIF_WAIT_(N)ACK messages.
> - * @scifdev:	SCIF device
> - * @msg:	Interrupt message
> - *
> - * The peer has responded to a SCIF_WAIT message.
> - */
> -void scif_recv_wait_resp(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -	struct scif_fence_info *fence_req =3D
> -		(struct scif_fence_info *)msg->payload[1];
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	if (msg->uop =3D=3D SCIF_WAIT_ACK)
> -		fence_req->state =3D OP_COMPLETED;
> -	else
> -		fence_req->state =3D OP_FAILED;
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	complete(&fence_req->comp);
> -}
> -
> -/**
> - * scif_recv_sig_local: Handle SCIF_SIG_LOCAL request
> - * @scifdev:	SCIF device
> - * @msg:	Interrupt message
> - *
> - * The peer has requested a signal on a local offset.
> - */
> -void scif_recv_sig_local(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -	int err;
> -
> -	err =3D scif_prog_signal(ep, msg->payload[1], msg->payload[2],
> -			       SCIF_WINDOW_SELF);
> -	if (err)
> -		msg->uop =3D SCIF_SIG_NACK;
> -	else
> -		msg->uop =3D SCIF_SIG_ACK;
> -	msg->payload[0] =3D ep->remote_ep;
> -	scif_nodeqp_send(ep->remote_dev, msg);
> -}
> -
> -/**
> - * scif_recv_sig_remote: Handle SCIF_SIGNAL_REMOTE request
> - * @scifdev:	SCIF device
> - * @msg:	Interrupt message
> - *
> - * The peer has requested a signal on a remote offset.
> - */
> -void scif_recv_sig_remote(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -	int err;
> -
> -	err =3D scif_prog_signal(ep, msg->payload[1], msg->payload[2],
> -			       SCIF_WINDOW_PEER);
> -	if (err)
> -		msg->uop =3D SCIF_SIG_NACK;
> -	else
> -		msg->uop =3D SCIF_SIG_ACK;
> -	msg->payload[0] =3D ep->remote_ep;
> -	scif_nodeqp_send(ep->remote_dev, msg);
> -}
> -
> -/**
> - * scif_recv_sig_resp: Handle SCIF_SIG_(N)ACK messages.
> - * @scifdev:	SCIF device
> - * @msg:	Interrupt message
> - *
> - * The peer has responded to a signal request.
> - */
> -void scif_recv_sig_resp(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -	struct scif_fence_info *fence_req =3D
> -		(struct scif_fence_info *)msg->payload[3];
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	if (msg->uop =3D=3D SCIF_SIG_ACK)
> -		fence_req->state =3D OP_COMPLETED;
> -	else
> -		fence_req->state =3D OP_FAILED;
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	complete(&fence_req->comp);
> -}
> -
> -static inline void *scif_get_local_va(off_t off, struct scif_window *win=
dow)
> -{
> -	struct page **pages =3D window->pinned_pages->pages;
> -	int page_nr =3D (off - window->offset) >> PAGE_SHIFT;
> -	off_t page_off =3D off & ~PAGE_MASK;
> -
> -	return page_address(pages[page_nr]) + page_off;
> -}
> -
> -static void scif_prog_signal_cb(void *arg)
> -{
> -	struct scif_cb_arg *cb_arg =3D arg;
> -
> -	dma_pool_free(cb_arg->ep->remote_dev->signal_pool, cb_arg-
> >status,
> -		      cb_arg->src_dma_addr);
> -	kfree(cb_arg);
> -}
> -
> -static int _scif_prog_signal(scif_epd_t epd, dma_addr_t dst, u64 val)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct dma_chan *chan =3D ep->rma_info.dma_chan;
> -	struct dma_device *ddev =3D chan->device;
> -	bool x100 =3D !is_dma_copy_aligned(chan->device, 1, 1, 1);
> -	struct dma_async_tx_descriptor *tx;
> -	struct scif_status *status =3D NULL;
> -	struct scif_cb_arg *cb_arg =3D NULL;
> -	dma_addr_t src;
> -	dma_cookie_t cookie;
> -	int err;
> -
> -	tx =3D ddev->device_prep_dma_memcpy(chan, 0, 0, 0,
> DMA_PREP_FENCE);
> -	if (!tx) {
> -		err =3D -ENOMEM;
> -		dev_err(&ep->remote_dev->sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto alloc_fail;
> -	}
> -	cookie =3D tx->tx_submit(tx);
> -	if (dma_submit_error(cookie)) {
> -		err =3D (int)cookie;
> -		dev_err(&ep->remote_dev->sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto alloc_fail;
> -	}
> -	dma_async_issue_pending(chan);
> -	if (x100) {
> -		/*
> -		 * For X100 use the status descriptor to write the value to
> -		 * the destination.
> -		 */
> -		tx =3D ddev->device_prep_dma_imm_data(chan, dst, val, 0);
> -	} else {
> -		status =3D dma_pool_alloc(ep->remote_dev->signal_pool,
> GFP_KERNEL,
> -					&src);
> -		if (!status) {
> -			err =3D -ENOMEM;
> -			dev_err(&ep->remote_dev->sdev->dev, "%s %d
> err %d\n",
> -				__func__, __LINE__, err);
> -			goto alloc_fail;
> -		}
> -		status->val =3D val;
> -		status->src_dma_addr =3D src;
> -		status->ep =3D ep;
> -		src +=3D offsetof(struct scif_status, val);
> -		tx =3D ddev->device_prep_dma_memcpy(chan, dst, src,
> sizeof(val),
> -						  DMA_PREP_INTERRUPT);
> -	}
> -	if (!tx) {
> -		err =3D -ENOMEM;
> -		dev_err(&ep->remote_dev->sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto dma_fail;
> -	}
> -	if (!x100) {
> -		cb_arg =3D kmalloc(sizeof(*cb_arg), GFP_KERNEL);
> -		if (!cb_arg) {
> -			err =3D -ENOMEM;
> -			goto dma_fail;
> -		}
> -		cb_arg->src_dma_addr =3D src;
> -		cb_arg->status =3D status;
> -		cb_arg->ep =3D ep;
> -		tx->callback =3D scif_prog_signal_cb;
> -		tx->callback_param =3D cb_arg;
> -	}
> -	cookie =3D tx->tx_submit(tx);
> -	if (dma_submit_error(cookie)) {
> -		err =3D -EIO;
> -		dev_err(&ep->remote_dev->sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto dma_fail;
> -	}
> -	dma_async_issue_pending(chan);
> -	return 0;
> -dma_fail:
> -	if (!x100) {
> -		dma_pool_free(ep->remote_dev->signal_pool, status,
> -			      src - offsetof(struct scif_status, val));
> -		kfree(cb_arg);
> -	}
> -alloc_fail:
> -	return err;
> -}
> -
> -/**
> - * scif_prog_signal:
> - * @epd: Endpoint Descriptor
> - * @offset: registered address to write @val to
> - * @val: Value to be written at @offset
> - * @type: Type of the window.
> - *
> - * Arrange to write a value to the registered offset after ensuring that=
 the
> - * offset provided is indeed valid.
> - */
> -int scif_prog_signal(scif_epd_t epd, off_t offset, u64 val,
> -		     enum scif_window_type type)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct scif_window *window =3D NULL;
> -	struct scif_rma_req req;
> -	dma_addr_t dst_dma_addr;
> -	int err;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	req.out_window =3D &window;
> -	req.offset =3D offset;
> -	req.nr_bytes =3D sizeof(u64);
> -	req.prot =3D SCIF_PROT_WRITE;
> -	req.type =3D SCIF_WINDOW_SINGLE;
> -	if (type =3D=3D SCIF_WINDOW_SELF)
> -		req.head =3D &ep->rma_info.reg_list;
> -	else
> -		req.head =3D &ep->rma_info.remote_reg_list;
> -	/* Does a valid window exist? */
> -	err =3D scif_query_window(&req);
> -	if (err) {
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto unlock_ret;
> -	}
> -
> -	if (scif_is_mgmt_node() && scifdev_self(ep->remote_dev)) {
> -		u64 *dst_virt;
> -
> -		if (type =3D=3D SCIF_WINDOW_SELF)
> -			dst_virt =3D scif_get_local_va(offset, window);
> -		else
> -			dst_virt =3D
> -			scif_get_local_va(offset, (struct scif_window *)
> -					  window->peer_window);
> -		*dst_virt =3D val;
> -	} else {
> -		dst_dma_addr =3D __scif_off_to_dma_addr(window, offset);
> -		err =3D _scif_prog_signal(epd, dst_dma_addr, val);
> -	}
> -unlock_ret:
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	return err;
> -}
> -
> -static int _scif_fence_wait(scif_epd_t epd, int mark)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	dma_cookie_t cookie =3D mark & ~SCIF_REMOTE_FENCE;
> -	int err;
> -
> -	/* Wait for DMA callback in scif_fence_mark_cb(..) */
> -	err =3D wait_event_interruptible_timeout(ep->rma_info.markwq,
> -					       dma_async_is_tx_complete(
> -					       ep->rma_info.dma_chan,
> -					       cookie, NULL, NULL) =3D=3D
> -					       DMA_COMPLETE,
> -					       SCIF_NODE_ALIVE_TIMEOUT);
> -	if (!err)
> -		err =3D -ETIMEDOUT;
> -	else if (err > 0)
> -		err =3D 0;
> -	return err;
> -}
> -
> -/**
> - * scif_rma_handle_remote_fences:
> - *
> - * This routine services remote fence requests.
> - */
> -void scif_rma_handle_remote_fences(void)
> -{
> -	struct list_head *item, *tmp;
> -	struct scif_remote_fence_info *fence;
> -	struct scif_endpt *ep;
> -	int mark, err;
> -
> -	might_sleep();
> -	mutex_lock(&scif_info.fencelock);
> -	list_for_each_safe(item, tmp, &scif_info.fence) {
> -		fence =3D list_entry(item, struct scif_remote_fence_info,
> -				   list);
> -		/* Remove fence from global list */
> -		list_del(&fence->list);
> -
> -		/* Initiate the fence operation */
> -		ep =3D (struct scif_endpt *)fence->msg.payload[0];
> -		mark =3D fence->msg.payload[2];
> -		err =3D _scif_fence_wait(ep, mark);
> -		if (err)
> -			fence->msg.uop =3D SCIF_WAIT_NACK;
> -		else
> -			fence->msg.uop =3D SCIF_WAIT_ACK;
> -		fence->msg.payload[0] =3D ep->remote_ep;
> -		scif_nodeqp_send(ep->remote_dev, &fence->msg);
> -		kfree(fence);
> -		if (!atomic_sub_return(1, &ep->rma_info.fence_refcount))
> -			schedule_work(&scif_info.misc_work);
> -	}
> -	mutex_unlock(&scif_info.fencelock);
> -}
> -
> -static int _scif_send_fence(scif_epd_t epd, int uop, int mark, int *out_=
mark)
> -{
> -	int err;
> -	struct scifmsg msg;
> -	struct scif_fence_info *fence_req;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -
> -	fence_req =3D kmalloc(sizeof(*fence_req), GFP_KERNEL);
> -	if (!fence_req) {
> -		err =3D -ENOMEM;
> -		goto error;
> -	}
> -
> -	fence_req->state =3D OP_IN_PROGRESS;
> -	init_completion(&fence_req->comp);
> -
> -	msg.src =3D ep->port;
> -	msg.uop =3D uop;
> -	msg.payload[0] =3D ep->remote_ep;
> -	msg.payload[1] =3D (u64)fence_req;
> -	if (uop =3D=3D SCIF_WAIT)
> -		msg.payload[2] =3D mark;
> -	spin_lock(&ep->lock);
> -	if (ep->state =3D=3D SCIFEP_CONNECTED)
> -		err =3D scif_nodeqp_send(ep->remote_dev, &msg);
> -	else
> -		err =3D -ENOTCONN;
> -	spin_unlock(&ep->lock);
> -	if (err)
> -		goto error_free;
> -retry:
> -	/* Wait for a SCIF_WAIT_(N)ACK message */
> -	err =3D wait_for_completion_timeout(&fence_req->comp,
> -					  SCIF_NODE_ALIVE_TIMEOUT);
> -	if (!err && scifdev_alive(ep))
> -		goto retry;
> -	if (!err)
> -		err =3D -ENODEV;
> -	if (err > 0)
> -		err =3D 0;
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	if (err < 0) {
> -		if (fence_req->state =3D=3D OP_IN_PROGRESS)
> -			fence_req->state =3D OP_FAILED;
> -	}
> -	if (fence_req->state =3D=3D OP_FAILED && !err)
> -		err =3D -ENOMEM;
> -	if (uop =3D=3D SCIF_MARK && fence_req->state =3D=3D OP_COMPLETED)
> -		*out_mark =3D SCIF_REMOTE_FENCE | fence_req->dma_mark;
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -error_free:
> -	kfree(fence_req);
> -error:
> -	return err;
> -}
> -
> -/**
> - * scif_send_fence_mark:
> - * @epd: end point descriptor.
> - * @out_mark: Output DMA mark reported by peer.
> - *
> - * Send a remote fence mark request.
> - */
> -static int scif_send_fence_mark(scif_epd_t epd, int *out_mark)
> -{
> -	return _scif_send_fence(epd, SCIF_MARK, 0, out_mark);
> -}
> -
> -/**
> - * scif_send_fence_wait:
> - * @epd: end point descriptor.
> - * @mark: DMA mark to wait for.
> - *
> - * Send a remote fence wait request.
> - */
> -static int scif_send_fence_wait(scif_epd_t epd, int mark)
> -{
> -	return _scif_send_fence(epd, SCIF_WAIT, mark, NULL);
> -}
> -
> -static int _scif_send_fence_signal_wait(struct scif_endpt *ep,
> -					struct scif_fence_info *fence_req)
> -{
> -	int err;
> -
> -retry:
> -	/* Wait for a SCIF_SIG_(N)ACK message */
> -	err =3D wait_for_completion_timeout(&fence_req->comp,
> -					  SCIF_NODE_ALIVE_TIMEOUT);
> -	if (!err && scifdev_alive(ep))
> -		goto retry;
> -	if (!err)
> -		err =3D -ENODEV;
> -	if (err > 0)
> -		err =3D 0;
> -	if (err < 0) {
> -		mutex_lock(&ep->rma_info.rma_lock);
> -		if (fence_req->state =3D=3D OP_IN_PROGRESS)
> -			fence_req->state =3D OP_FAILED;
> -		mutex_unlock(&ep->rma_info.rma_lock);
> -	}
> -	if (fence_req->state =3D=3D OP_FAILED && !err)
> -		err =3D -ENXIO;
> -	return err;
> -}
> -
> -/**
> - * scif_send_fence_signal:
> - * @epd: endpoint descriptor
> - * @loff: local offset
> - * @lval: local value to write to loffset
> - * @roff: remote offset
> - * @rval: remote value to write to roffset
> - * @flags: flags
> - *
> - * Sends a remote fence signal request
> - */
> -static int scif_send_fence_signal(scif_epd_t epd, off_t roff, u64 rval,
> -				  off_t loff, u64 lval, int flags)
> -{
> -	int err =3D 0;
> -	struct scifmsg msg;
> -	struct scif_fence_info *fence_req;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -
> -	fence_req =3D kmalloc(sizeof(*fence_req), GFP_KERNEL);
> -	if (!fence_req) {
> -		err =3D -ENOMEM;
> -		goto error;
> -	}
> -
> -	fence_req->state =3D OP_IN_PROGRESS;
> -	init_completion(&fence_req->comp);
> -	msg.src =3D ep->port;
> -	if (flags & SCIF_SIGNAL_LOCAL) {
> -		msg.uop =3D SCIF_SIG_LOCAL;
> -		msg.payload[0] =3D ep->remote_ep;
> -		msg.payload[1] =3D roff;
> -		msg.payload[2] =3D rval;
> -		msg.payload[3] =3D (u64)fence_req;
> -		spin_lock(&ep->lock);
> -		if (ep->state =3D=3D SCIFEP_CONNECTED)
> -			err =3D scif_nodeqp_send(ep->remote_dev, &msg);
> -		else
> -			err =3D -ENOTCONN;
> -		spin_unlock(&ep->lock);
> -		if (err)
> -			goto error_free;
> -		err =3D _scif_send_fence_signal_wait(ep, fence_req);
> -		if (err)
> -			goto error_free;
> -	}
> -	fence_req->state =3D OP_IN_PROGRESS;
> -
> -	if (flags & SCIF_SIGNAL_REMOTE) {
> -		msg.uop =3D SCIF_SIG_REMOTE;
> -		msg.payload[0] =3D ep->remote_ep;
> -		msg.payload[1] =3D loff;
> -		msg.payload[2] =3D lval;
> -		msg.payload[3] =3D (u64)fence_req;
> -		spin_lock(&ep->lock);
> -		if (ep->state =3D=3D SCIFEP_CONNECTED)
> -			err =3D scif_nodeqp_send(ep->remote_dev, &msg);
> -		else
> -			err =3D -ENOTCONN;
> -		spin_unlock(&ep->lock);
> -		if (err)
> -			goto error_free;
> -		err =3D _scif_send_fence_signal_wait(ep, fence_req);
> -	}
> -error_free:
> -	kfree(fence_req);
> -error:
> -	return err;
> -}
> -
> -static void scif_fence_mark_cb(void *arg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)arg;
> -
> -	wake_up_interruptible(&ep->rma_info.markwq);
> -	atomic_dec(&ep->rma_info.fence_refcount);
> -}
> -
> -/**
> - * _scif_fence_mark:
> - * @epd: endpoint descriptor
> - * @mark: DMA mark to set-up
> - *
> - * Set up a mark for this endpoint and return the value of the mark.
> - */
> -int _scif_fence_mark(scif_epd_t epd, int *mark)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct dma_chan *chan =3D ep->rma_info.dma_chan;
> -	struct dma_device *ddev =3D chan->device;
> -	struct dma_async_tx_descriptor *tx;
> -	dma_cookie_t cookie;
> -	int err;
> -
> -	tx =3D ddev->device_prep_dma_memcpy(chan, 0, 0, 0,
> DMA_PREP_FENCE);
> -	if (!tx) {
> -		err =3D -ENOMEM;
> -		dev_err(&ep->remote_dev->sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		return err;
> -	}
> -	cookie =3D tx->tx_submit(tx);
> -	if (dma_submit_error(cookie)) {
> -		err =3D (int)cookie;
> -		dev_err(&ep->remote_dev->sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		return err;
> -	}
> -	dma_async_issue_pending(chan);
> -	tx =3D ddev->device_prep_dma_interrupt(chan,
> DMA_PREP_INTERRUPT);
> -	if (!tx) {
> -		err =3D -ENOMEM;
> -		dev_err(&ep->remote_dev->sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		return err;
> -	}
> -	tx->callback =3D scif_fence_mark_cb;
> -	tx->callback_param =3D ep;
> -	*mark =3D cookie =3D tx->tx_submit(tx);
> -	if (dma_submit_error(cookie)) {
> -		err =3D (int)cookie;
> -		dev_err(&ep->remote_dev->sdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		return err;
> -	}
> -	atomic_inc(&ep->rma_info.fence_refcount);
> -	dma_async_issue_pending(chan);
> -	return 0;
> -}
> -
> -#define SCIF_LOOPB_MAGIC_MARK 0xdead
> -
> -int scif_fence_mark(scif_epd_t epd, int flags, int *mark)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int err =3D 0;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI fence_mark: ep %p flags 0x%x mark 0x%x\n",
> -		ep, flags, *mark);
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -
> -	/* Invalid flags? */
> -	if (flags & ~(SCIF_FENCE_INIT_SELF | SCIF_FENCE_INIT_PEER))
> -		return -EINVAL;
> -
> -	/* At least one of init self or peer RMA should be set */
> -	if (!(flags & (SCIF_FENCE_INIT_SELF | SCIF_FENCE_INIT_PEER)))
> -		return -EINVAL;
> -
> -	/* Exactly one of init self or peer RMA should be set but not both */
> -	if ((flags & SCIF_FENCE_INIT_SELF) && (flags &
> SCIF_FENCE_INIT_PEER))
> -		return -EINVAL;
> -
> -	/*
> -	 * Management node loopback does not need to use DMA.
> -	 * Return a valid mark to be symmetric.
> -	 */
> -	if (scifdev_self(ep->remote_dev) && scif_is_mgmt_node()) {
> -		*mark =3D SCIF_LOOPB_MAGIC_MARK;
> -		return 0;
> -	}
> -
> -	if (flags & SCIF_FENCE_INIT_SELF)
> -		err =3D _scif_fence_mark(epd, mark);
> -	else
> -		err =3D scif_send_fence_mark(ep, mark);
> -
> -	if (err)
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI fence_mark: ep %p flags 0x%x mark 0x%x err %d\n",
> -		ep, flags, *mark, err);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_fence_mark);
> -
> -int scif_fence_wait(scif_epd_t epd, int mark)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int err =3D 0;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI fence_wait: ep %p mark 0x%x\n",
> -		ep, mark);
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -	/*
> -	 * Management node loopback does not need to use DMA.
> -	 * The only valid mark provided is 0 so simply
> -	 * return success if the mark is valid.
> -	 */
> -	if (scifdev_self(ep->remote_dev) && scif_is_mgmt_node()) {
> -		if (mark =3D=3D SCIF_LOOPB_MAGIC_MARK)
> -			return 0;
> -		else
> -			return -EINVAL;
> -	}
> -	if (mark & SCIF_REMOTE_FENCE)
> -		err =3D scif_send_fence_wait(epd, mark);
> -	else
> -		err =3D _scif_fence_wait(epd, mark);
> -	if (err < 0)
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_fence_wait);
> -
> -int scif_fence_signal(scif_epd_t epd, off_t loff, u64 lval,
> -		      off_t roff, u64 rval, int flags)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	int err =3D 0;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI fence_signal: ep %p loff 0x%lx lval 0x%llx roff 0x%lx
> rval 0x%llx flags 0x%x\n",
> -		ep, loff, lval, roff, rval, flags);
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -
> -	/* Invalid flags? */
> -	if (flags & ~(SCIF_FENCE_INIT_SELF | SCIF_FENCE_INIT_PEER |
> -			SCIF_SIGNAL_LOCAL | SCIF_SIGNAL_REMOTE))
> -		return -EINVAL;
> -
> -	/* At least one of init self or peer RMA should be set */
> -	if (!(flags & (SCIF_FENCE_INIT_SELF | SCIF_FENCE_INIT_PEER)))
> -		return -EINVAL;
> -
> -	/* Exactly one of init self or peer RMA should be set but not both */
> -	if ((flags & SCIF_FENCE_INIT_SELF) && (flags &
> SCIF_FENCE_INIT_PEER))
> -		return -EINVAL;
> -
> -	/* At least one of SCIF_SIGNAL_LOCAL or SCIF_SIGNAL_REMOTE
> required */
> -	if (!(flags & (SCIF_SIGNAL_LOCAL | SCIF_SIGNAL_REMOTE)))
> -		return -EINVAL;
> -
> -	/* Only Dword offsets allowed */
> -	if ((flags & SCIF_SIGNAL_LOCAL) && (loff & (sizeof(u32) - 1)))
> -		return -EINVAL;
> -
> -	/* Only Dword aligned offsets allowed */
> -	if ((flags & SCIF_SIGNAL_REMOTE) && (roff & (sizeof(u32) - 1)))
> -		return -EINVAL;
> -
> -	if (flags & SCIF_FENCE_INIT_PEER) {
> -		err =3D scif_send_fence_signal(epd, roff, rval, loff,
> -					     lval, flags);
> -	} else {
> -		/* Local Signal in Local RAS */
> -		if (flags & SCIF_SIGNAL_LOCAL) {
> -			err =3D scif_prog_signal(epd, loff, lval,
> -					       SCIF_WINDOW_SELF);
> -			if (err)
> -				goto error_ret;
> -		}
> -
> -		/* Signal in Remote RAS */
> -		if (flags & SCIF_SIGNAL_REMOTE)
> -			err =3D scif_prog_signal(epd, roff,
> -					       rval, SCIF_WINDOW_PEER);
> -	}
> -error_ret:
> -	if (err)
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_fence_signal);
> diff --git a/drivers/misc/mic/scif/scif_main.c
> b/drivers/misc/mic/scif/scif_main.c
> deleted file mode 100644
> index e2278bf9f11d..000000000000
> --- a/drivers/misc/mic/scif/scif_main.c
> +++ /dev/null
> @@ -1,351 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include <linux/module.h>
> -#include <linux/idr.h>
> -
> -#include <linux/mic_common.h>
> -#include "../common/mic_dev.h"
> -#include "../bus/scif_bus.h"
> -#include "scif_peer_bus.h"
> -#include "scif_main.h"
> -#include "scif_map.h"
> -
> -struct scif_info scif_info =3D {
> -	.mdev =3D {
> -		.minor =3D MISC_DYNAMIC_MINOR,
> -		.name =3D "scif",
> -		.fops =3D &scif_fops,
> -	}
> -};
> -
> -struct scif_dev *scif_dev;
> -struct kmem_cache *unaligned_cache;
> -static atomic_t g_loopb_cnt;
> -
> -/* Runs in the context of intr_wq */
> -static void scif_intr_bh_handler(struct work_struct *work)
> -{
> -	struct scif_dev *scifdev =3D
> -			container_of(work, struct scif_dev, intr_bh);
> -
> -	if (scifdev_self(scifdev))
> -		scif_loopb_msg_handler(scifdev, scifdev->qpairs);
> -	else
> -		scif_nodeqp_intrhandler(scifdev, scifdev->qpairs);
> -}
> -
> -int scif_setup_intr_wq(struct scif_dev *scifdev)
> -{
> -	if (!scifdev->intr_wq) {
> -		snprintf(scifdev->intr_wqname, sizeof(scifdev-
> >intr_wqname),
> -			 "SCIF INTR %d", scifdev->node);
> -		scifdev->intr_wq =3D
> -			alloc_ordered_workqueue(scifdev->intr_wqname, 0);
> -		if (!scifdev->intr_wq)
> -			return -ENOMEM;
> -		INIT_WORK(&scifdev->intr_bh, scif_intr_bh_handler);
> -	}
> -	return 0;
> -}
> -
> -void scif_destroy_intr_wq(struct scif_dev *scifdev)
> -{
> -	if (scifdev->intr_wq) {
> -		destroy_workqueue(scifdev->intr_wq);
> -		scifdev->intr_wq =3D NULL;
> -	}
> -}
> -
> -irqreturn_t scif_intr_handler(int irq, void *data)
> -{
> -	struct scif_dev *scifdev =3D data;
> -	struct scif_hw_dev *sdev =3D scifdev->sdev;
> -
> -	sdev->hw_ops->ack_interrupt(sdev, scifdev->db);
> -	queue_work(scifdev->intr_wq, &scifdev->intr_bh);
> -	return IRQ_HANDLED;
> -}
> -
> -static void scif_qp_setup_handler(struct work_struct *work)
> -{
> -	struct scif_dev *scifdev =3D container_of(work, struct scif_dev,
> -						qp_dwork.work);
> -	struct scif_hw_dev *sdev =3D scifdev->sdev;
> -	dma_addr_t da =3D 0;
> -	int err;
> -
> -	if (scif_is_mgmt_node()) {
> -		struct mic_bootparam *bp =3D sdev->dp;
> -
> -		da =3D bp->scif_card_dma_addr;
> -		scifdev->rdb =3D bp->h2c_scif_db;
> -	} else {
> -		struct mic_bootparam __iomem *bp =3D sdev->rdp;
> -
> -		da =3D readq(&bp->scif_host_dma_addr);
> -		scifdev->rdb =3D ioread8(&bp->c2h_scif_db);
> -	}
> -	if (da) {
> -		err =3D scif_qp_response(da, scifdev);
> -		if (err)
> -			dev_err(&scifdev->sdev->dev,
> -				"scif_qp_response err %d\n", err);
> -	} else {
> -		schedule_delayed_work(&scifdev->qp_dwork,
> -				      msecs_to_jiffies(1000));
> -	}
> -}
> -
> -static int scif_setup_scifdev(void)
> -{
> -	/* We support a maximum of 129 SCIF nodes including the mgmt
> node */
> -#define MAX_SCIF_NODES 129
> -	int i;
> -	u8 num_nodes =3D MAX_SCIF_NODES;
> -
> -	scif_dev =3D kcalloc(num_nodes, sizeof(*scif_dev), GFP_KERNEL);
> -	if (!scif_dev)
> -		return -ENOMEM;
> -	for (i =3D 0; i < num_nodes; i++) {
> -		struct scif_dev *scifdev =3D &scif_dev[i];
> -
> -		scifdev->node =3D i;
> -		scifdev->exit =3D OP_IDLE;
> -		init_waitqueue_head(&scifdev->disconn_wq);
> -		mutex_init(&scifdev->lock);
> -		INIT_WORK(&scifdev->peer_add_work,
> scif_add_peer_device);
> -		INIT_DELAYED_WORK(&scifdev->p2p_dwork,
> -				  scif_poll_qp_state);
> -		INIT_DELAYED_WORK(&scifdev->qp_dwork,
> -				  scif_qp_setup_handler);
> -		INIT_LIST_HEAD(&scifdev->p2p);
> -		RCU_INIT_POINTER(scifdev->spdev, NULL);
> -	}
> -	return 0;
> -}
> -
> -static void scif_destroy_scifdev(void)
> -{
> -	kfree(scif_dev);
> -	scif_dev =3D NULL;
> -}
> -
> -static int scif_probe(struct scif_hw_dev *sdev)
> -{
> -	struct scif_dev *scifdev =3D &scif_dev[sdev->dnode];
> -	int rc;
> -
> -	dev_set_drvdata(&sdev->dev, sdev);
> -	scifdev->sdev =3D sdev;
> -
> -	if (1 =3D=3D atomic_add_return(1, &g_loopb_cnt)) {
> -		struct scif_dev *loopb_dev =3D &scif_dev[sdev->snode];
> -
> -		loopb_dev->sdev =3D sdev;
> -		rc =3D scif_setup_loopback_qp(loopb_dev);
> -		if (rc)
> -			goto exit;
> -	}
> -
> -	rc =3D scif_setup_intr_wq(scifdev);
> -	if (rc)
> -		goto destroy_loopb;
> -	rc =3D scif_setup_qp(scifdev);
> -	if (rc)
> -		goto destroy_intr;
> -	scifdev->db =3D sdev->hw_ops->next_db(sdev);
> -	scifdev->cookie =3D sdev->hw_ops->request_irq(sdev, scif_intr_handler,
> -						    "SCIF_INTR", scifdev,
> -						    scifdev->db);
> -	if (IS_ERR(scifdev->cookie)) {
> -		rc =3D PTR_ERR(scifdev->cookie);
> -		goto free_qp;
> -	}
> -	if (scif_is_mgmt_node()) {
> -		struct mic_bootparam *bp =3D sdev->dp;
> -
> -		bp->c2h_scif_db =3D scifdev->db;
> -		bp->scif_host_dma_addr =3D scifdev->qp_dma_addr;
> -	} else {
> -		struct mic_bootparam __iomem *bp =3D sdev->rdp;
> -
> -		iowrite8(scifdev->db, &bp->h2c_scif_db);
> -		writeq(scifdev->qp_dma_addr, &bp->scif_card_dma_addr);
> -	}
> -	schedule_delayed_work(&scifdev->qp_dwork,
> -			      msecs_to_jiffies(1000));
> -	return rc;
> -free_qp:
> -	scif_free_qp(scifdev);
> -destroy_intr:
> -	scif_destroy_intr_wq(scifdev);
> -destroy_loopb:
> -	if (atomic_dec_and_test(&g_loopb_cnt))
> -		scif_destroy_loopback_qp(&scif_dev[sdev->snode]);
> -exit:
> -	return rc;
> -}
> -
> -void scif_stop(struct scif_dev *scifdev)
> -{
> -	struct scif_dev *dev;
> -	int i;
> -
> -	for (i =3D scif_info.maxid; i >=3D 0; i--) {
> -		dev =3D &scif_dev[i];
> -		if (scifdev_self(dev))
> -			continue;
> -		scif_handle_remove_node(i);
> -	}
> -}
> -
> -static void scif_remove(struct scif_hw_dev *sdev)
> -{
> -	struct scif_dev *scifdev =3D &scif_dev[sdev->dnode];
> -
> -	if (scif_is_mgmt_node()) {
> -		struct mic_bootparam *bp =3D sdev->dp;
> -
> -		bp->c2h_scif_db =3D -1;
> -		bp->scif_host_dma_addr =3D 0x0;
> -	} else {
> -		struct mic_bootparam __iomem *bp =3D sdev->rdp;
> -
> -		iowrite8(-1, &bp->h2c_scif_db);
> -		writeq(0x0, &bp->scif_card_dma_addr);
> -	}
> -	if (scif_is_mgmt_node()) {
> -		scif_disconnect_node(scifdev->node, true);
> -	} else {
> -		scif_info.card_initiated_exit =3D true;
> -		scif_stop(scifdev);
> -	}
> -	if (atomic_dec_and_test(&g_loopb_cnt))
> -		scif_destroy_loopback_qp(&scif_dev[sdev->snode]);
> -	if (scifdev->cookie) {
> -		sdev->hw_ops->free_irq(sdev, scifdev->cookie, scifdev);
> -		scifdev->cookie =3D NULL;
> -	}
> -	scif_destroy_intr_wq(scifdev);
> -	cancel_delayed_work(&scifdev->qp_dwork);
> -	scif_free_qp(scifdev);
> -	scifdev->rdb =3D -1;
> -	scifdev->sdev =3D NULL;
> -}
> -
> -static struct scif_hw_dev_id id_table[] =3D {
> -	{ MIC_SCIF_DEV, SCIF_DEV_ANY_ID },
> -	{ 0 },
> -};
> -
> -static struct scif_driver scif_driver =3D {
> -	.driver.name =3D	KBUILD_MODNAME,
> -	.driver.owner =3D	THIS_MODULE,
> -	.id_table =3D id_table,
> -	.probe =3D scif_probe,
> -	.remove =3D scif_remove,
> -};
> -
> -static int _scif_init(void)
> -{
> -	int rc;
> -
> -	mutex_init(&scif_info.eplock);
> -	spin_lock_init(&scif_info.rmalock);
> -	spin_lock_init(&scif_info.nb_connect_lock);
> -	spin_lock_init(&scif_info.port_lock);
> -	mutex_init(&scif_info.conflock);
> -	mutex_init(&scif_info.connlock);
> -	mutex_init(&scif_info.fencelock);
> -	INIT_LIST_HEAD(&scif_info.uaccept);
> -	INIT_LIST_HEAD(&scif_info.listen);
> -	INIT_LIST_HEAD(&scif_info.zombie);
> -	INIT_LIST_HEAD(&scif_info.connected);
> -	INIT_LIST_HEAD(&scif_info.disconnected);
> -	INIT_LIST_HEAD(&scif_info.rma);
> -	INIT_LIST_HEAD(&scif_info.rma_tc);
> -	INIT_LIST_HEAD(&scif_info.mmu_notif_cleanup);
> -	INIT_LIST_HEAD(&scif_info.fence);
> -	INIT_LIST_HEAD(&scif_info.nb_connect_list);
> -	init_waitqueue_head(&scif_info.exitwq);
> -	scif_info.rma_tc_limit =3D SCIF_RMA_TEMP_CACHE_LIMIT;
> -	scif_info.en_msg_log =3D 0;
> -	scif_info.p2p_enable =3D 1;
> -	rc =3D scif_setup_scifdev();
> -	if (rc)
> -		goto error;
> -	unaligned_cache =3D kmem_cache_create("Unaligned_DMA",
> -					    SCIF_KMEM_UNALIGNED_BUF_SIZE,
> -					    0, SLAB_HWCACHE_ALIGN, NULL);
> -	if (!unaligned_cache) {
> -		rc =3D -ENOMEM;
> -		goto free_sdev;
> -	}
> -	INIT_WORK(&scif_info.misc_work, scif_misc_handler);
> -	INIT_WORK(&scif_info.mmu_notif_work, scif_mmu_notif_handler);
> -	INIT_WORK(&scif_info.conn_work, scif_conn_handler);
> -	idr_init(&scif_ports);
> -	return 0;
> -free_sdev:
> -	scif_destroy_scifdev();
> -error:
> -	return rc;
> -}
> -
> -static void _scif_exit(void)
> -{
> -	idr_destroy(&scif_ports);
> -	kmem_cache_destroy(unaligned_cache);
> -	scif_destroy_scifdev();
> -}
> -
> -static int __init scif_init(void)
> -{
> -	struct miscdevice *mdev =3D &scif_info.mdev;
> -	int rc;
> -
> -	_scif_init();
> -	iova_cache_get();
> -	rc =3D scif_peer_bus_init();
> -	if (rc)
> -		goto exit;
> -	rc =3D scif_register_driver(&scif_driver);
> -	if (rc)
> -		goto peer_bus_exit;
> -	rc =3D misc_register(mdev);
> -	if (rc)
> -		goto unreg_scif;
> -	scif_init_debugfs();
> -	return 0;
> -unreg_scif:
> -	scif_unregister_driver(&scif_driver);
> -peer_bus_exit:
> -	scif_peer_bus_exit();
> -exit:
> -	_scif_exit();
> -	return rc;
> -}
> -
> -static void __exit scif_exit(void)
> -{
> -	scif_exit_debugfs();
> -	misc_deregister(&scif_info.mdev);
> -	scif_unregister_driver(&scif_driver);
> -	scif_peer_bus_exit();
> -	iova_cache_put();
> -	_scif_exit();
> -}
> -
> -module_init(scif_init);
> -module_exit(scif_exit);
> -
> -MODULE_DEVICE_TABLE(scif, id_table);
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) SCIF driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/scif/scif_main.h
> b/drivers/misc/mic/scif/scif_main.h
> deleted file mode 100644
> index bb3ab97d5b35..000000000000
> --- a/drivers/misc/mic/scif/scif_main.h
> +++ /dev/null
> @@ -1,274 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#ifndef SCIF_MAIN_H
> -#define SCIF_MAIN_H
> -
> -#include <linux/sched/signal.h>
> -#include <linux/pci.h>
> -#include <linux/miscdevice.h>
> -#include <linux/dmaengine.h>
> -#include <linux/iova.h>
> -#include <linux/anon_inodes.h>
> -#include <linux/file.h>
> -#include <linux/vmalloc.h>
> -#include <linux/scif.h>
> -#include "../common/mic_dev.h"
> -
> -#define SCIF_MGMT_NODE 0
> -#define SCIF_DEFAULT_WATCHDOG_TO 30
> -#define SCIF_NODE_ACCEPT_TIMEOUT (3 * HZ)
> -#define SCIF_NODE_ALIVE_TIMEOUT (SCIF_DEFAULT_WATCHDOG_TO * HZ)
> -#define SCIF_RMA_TEMP_CACHE_LIMIT 0x20000
> -
> -/*
> - * Generic state used for certain node QP message exchanges
> - * like Unregister, Alloc etc.
> - */
> -enum scif_msg_state {
> -	OP_IDLE =3D 1,
> -	OP_IN_PROGRESS,
> -	OP_COMPLETED,
> -	OP_FAILED
> -};
> -
> -/*
> - * struct scif_info - Global SCIF information
> - *
> - * @nodeid: Node ID this node is to others
> - * @maxid: Max known node ID
> - * @total: Total number of SCIF nodes
> - * @nr_zombies: number of zombie endpoints
> - * @eplock: Lock to synchronize listening, zombie endpoint lists
> - * @connlock: Lock to synchronize connected and disconnected lists
> - * @nb_connect_lock: Synchronize non blocking connect operations
> - * @port_lock: Synchronize access to SCIF ports
> - * @uaccept: List of user acceptreq waiting for acceptreg
> - * @listen: List of listening end points
> - * @zombie: List of zombie end points with pending RMA's
> - * @connected: List of end points in connected state
> - * @disconnected: List of end points in disconnected state
> - * @nb_connect_list: List for non blocking connections
> - * @misc_work: miscellaneous SCIF tasks
> - * @conflock: Lock to synchronize SCIF node configuration changes
> - * @en_msg_log: Enable debug message logging
> - * @p2p_enable: Enable P2P SCIF network
> - * @mdev: The MISC device
> - * @conn_work: Work for workqueue handling all connections
> - * @exitwq: Wait queue for waiting for an EXIT node QP message response
> - * @loopb_dev: Dummy SCIF device used for loopback
> - * @loopb_wq: Workqueue used for handling loopback messages
> - * @loopb_wqname[16]: Name of loopback workqueue
> - * @loopb_work: Used for submitting work to loopb_wq
> - * @loopb_recv_q: List of messages received on the loopb_wq
> - * @card_initiated_exit: set when the card has initiated the exit
> - * @rmalock: Synchronize access to RMA operations
> - * @fencelock: Synchronize access to list of remote fences requested.
> - * @rma: List of temporary registered windows to be destroyed.
> - * @rma_tc: List of temporary registered & cached Windows to be destroye=
d
> - * @fence: List of remote fence requests
> - * @mmu_notif_work: Work for registration caching MMU notifier
> workqueue
> - * @mmu_notif_cleanup: List of temporary cached windows for reg cache
> - * @rma_tc_limit: RMA temporary cache limit
> - */
> -struct scif_info {
> -	u8 nodeid;
> -	u8 maxid;
> -	u8 total;
> -	u32 nr_zombies;
> -	struct mutex eplock;
> -	struct mutex connlock;
> -	spinlock_t nb_connect_lock;
> -	spinlock_t port_lock;
> -	struct list_head uaccept;
> -	struct list_head listen;
> -	struct list_head zombie;
> -	struct list_head connected;
> -	struct list_head disconnected;
> -	struct list_head nb_connect_list;
> -	struct work_struct misc_work;
> -	struct mutex conflock;
> -	u8 en_msg_log;
> -	u8 p2p_enable;
> -	struct miscdevice mdev;
> -	struct work_struct conn_work;
> -	wait_queue_head_t exitwq;
> -	struct scif_dev *loopb_dev;
> -	struct workqueue_struct *loopb_wq;
> -	char loopb_wqname[16];
> -	struct work_struct loopb_work;
> -	struct list_head loopb_recv_q;
> -	bool card_initiated_exit;
> -	spinlock_t rmalock;
> -	struct mutex fencelock;
> -	struct list_head rma;
> -	struct list_head rma_tc;
> -	struct list_head fence;
> -	struct work_struct mmu_notif_work;
> -	struct list_head mmu_notif_cleanup;
> -	unsigned long rma_tc_limit;
> -};
> -
> -/*
> - * struct scif_p2p_info - SCIF mapping information used for P2P
> - *
> - * @ppi_peer_id - SCIF peer node id
> - * @ppi_sg - Scatter list for bar information (One for mmio and one for =
aper)
> - * @sg_nentries - Number of entries in the scatterlist
> - * @ppi_da: DMA address for MMIO and APER bars
> - * @ppi_len: Length of MMIO and APER bars
> - * @ppi_list: Link in list of mapping information
> - */
> -struct scif_p2p_info {
> -	u8 ppi_peer_id;
> -	struct scatterlist *ppi_sg[2];
> -	u64 sg_nentries[2];
> -	dma_addr_t ppi_da[2];
> -	u64 ppi_len[2];
> -#define SCIF_PPI_MMIO 0
> -#define SCIF_PPI_APER 1
> -	struct list_head ppi_list;
> -};
> -
> -/*
> - * struct scif_dev - SCIF remote device specific fields
> - *
> - * @node: Node id
> - * @p2p: List of P2P mapping information
> - * @qpairs: The node queue pair for exchanging control messages
> - * @intr_wq: Workqueue for handling Node QP messages
> - * @intr_wqname: Name of node QP workqueue for handling interrupts
> - * @intr_bh: Used for submitting work to intr_wq
> - * @lock: Lock used for synchronizing access to the scif device
> - * @sdev: SCIF hardware device on the SCIF hardware bus
> - * @db: doorbell the peer will trigger to generate an interrupt on self
> - * @rdb: Doorbell to trigger on the peer to generate an interrupt on the=
 peer
> - * @cookie: Cookie received while registering the interrupt handler
> - * @peer_add_work: Work for handling device_add for peer devices
> - * @p2p_dwork: Delayed work to enable polling for P2P state
> - * @qp_dwork: Delayed work for enabling polling for remote QP
> information
> - * @p2p_retry: Number of times to retry polling of P2P state
> - * @base_addr: P2P aperture bar base address
> - * @mic_mw mmio: The peer MMIO information used for P2P
> - * @spdev: SCIF peer device on the SCIF peer bus
> - * @node_remove_ack_pending: True if a node_remove_ack is pending
> - * @exit_ack_pending: true if an exit_ack is pending
> - * @disconn_wq: Used while waiting for a node remove response
> - * @disconn_rescnt: Keeps track of number of node remove requests sent
> - * @exit: Status of exit message
> - * @qp_dma_addr: Queue pair DMA address passed to the peer
> - * @dma_ch_idx: Round robin index for DMA channels
> - * @signal_pool: DMA pool used for scheduling scif_fence_signal DMA's
> -*/
> -struct scif_dev {
> -	u8 node;
> -	struct list_head p2p;
> -	struct scif_qp *qpairs;
> -	struct workqueue_struct *intr_wq;
> -	char intr_wqname[16];
> -	struct work_struct intr_bh;
> -	struct mutex lock;
> -	struct scif_hw_dev *sdev;
> -	int db;
> -	int rdb;
> -	struct mic_irq *cookie;
> -	struct work_struct peer_add_work;
> -	struct delayed_work p2p_dwork;
> -	struct delayed_work qp_dwork;
> -	int p2p_retry;
> -	dma_addr_t base_addr;
> -	struct mic_mw mmio;
> -	struct scif_peer_dev __rcu *spdev;
> -	bool node_remove_ack_pending;
> -	bool exit_ack_pending;
> -	wait_queue_head_t disconn_wq;
> -	atomic_t disconn_rescnt;
> -	enum scif_msg_state exit;
> -	dma_addr_t qp_dma_addr;
> -	int dma_ch_idx;
> -	struct dma_pool *signal_pool;
> -};
> -
> -extern bool scif_reg_cache_enable;
> -extern bool scif_ulimit_check;
> -extern struct scif_info scif_info;
> -extern struct idr scif_ports;
> -extern struct bus_type scif_peer_bus;
> -extern struct scif_dev *scif_dev;
> -extern const struct file_operations scif_fops;
> -extern const struct file_operations scif_anon_fops;
> -
> -/* Size of the RB for the Node QP */
> -#define SCIF_NODE_QP_SIZE 0x10000
> -
> -#include "scif_nodeqp.h"
> -#include "scif_rma.h"
> -#include "scif_rma_list.h"
> -
> -/*
> - * scifdev_self:
> - * @dev: The remote SCIF Device
> - *
> - * Returns true if the SCIF Device passed is the self aka Loopback SCIF =
device.
> - */
> -static inline int scifdev_self(struct scif_dev *dev)
> -{
> -	return dev->node =3D=3D scif_info.nodeid;
> -}
> -
> -static inline bool scif_is_mgmt_node(void)
> -{
> -	return !scif_info.nodeid;
> -}
> -
> -/*
> - * scifdev_is_p2p:
> - * @dev: The remote SCIF Device
> - *
> - * Returns true if the SCIF Device is a MIC Peer to Peer SCIF device.
> - */
> -static inline bool scifdev_is_p2p(struct scif_dev *dev)
> -{
> -	if (scif_is_mgmt_node())
> -		return false;
> -	else
> -		return dev !=3D &scif_dev[SCIF_MGMT_NODE] &&
> -			!scifdev_self(dev);
> -}
> -
> -/*
> - * scifdev_alive:
> - * @scifdev: The remote SCIF Device
> - *
> - * Returns true if the remote SCIF Device is running or sleeping for
> - * this endpoint.
> - */
> -static inline int _scifdev_alive(struct scif_dev *scifdev)
> -{
> -	struct scif_peer_dev *spdev;
> -
> -	rcu_read_lock();
> -	spdev =3D rcu_dereference(scifdev->spdev);
> -	rcu_read_unlock();
> -	return !!spdev;
> -}
> -
> -#include "scif_epd.h"
> -
> -void __init scif_init_debugfs(void);
> -void scif_exit_debugfs(void);
> -int scif_setup_intr_wq(struct scif_dev *scifdev);
> -void scif_destroy_intr_wq(struct scif_dev *scifdev);
> -void scif_cleanup_scifdev(struct scif_dev *dev);
> -void scif_handle_remove_node(int node);
> -void scif_disconnect_node(u32 node_id, bool mgmt_initiated);
> -void scif_free_qp(struct scif_dev *dev);
> -void scif_misc_handler(struct work_struct *work);
> -void scif_stop(struct scif_dev *scifdev);
> -irqreturn_t scif_intr_handler(int irq, void *data);
> -#endif /* SCIF_MAIN_H */
> diff --git a/drivers/misc/mic/scif/scif_map.h
> b/drivers/misc/mic/scif/scif_map.h
> deleted file mode 100644
> index 96b760819bfc..000000000000
> --- a/drivers/misc/mic/scif/scif_map.h
> +++ /dev/null
> @@ -1,127 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#ifndef SCIF_MAP_H
> -#define SCIF_MAP_H
> -
> -#include "../bus/scif_bus.h"
> -
> -static __always_inline void *
> -scif_alloc_coherent(dma_addr_t *dma_handle,
> -		    struct scif_dev *scifdev, size_t size,
> -		    gfp_t gfp)
> -{
> -	void *va;
> -
> -	if (scifdev_self(scifdev)) {
> -		va =3D kmalloc(size, gfp);
> -		if (va)
> -			*dma_handle =3D virt_to_phys(va);
> -	} else {
> -		va =3D dma_alloc_coherent(&scifdev->sdev->dev,
> -					size, dma_handle, gfp);
> -		if (va && scifdev_is_p2p(scifdev))
> -			*dma_handle =3D *dma_handle + scifdev->base_addr;
> -	}
> -	return va;
> -}
> -
> -static __always_inline void
> -scif_free_coherent(void *va, dma_addr_t local,
> -		   struct scif_dev *scifdev, size_t size)
> -{
> -	if (scifdev_self(scifdev)) {
> -		kfree(va);
> -	} else {
> -		if (scifdev_is_p2p(scifdev) && local > scifdev->base_addr)
> -			local =3D local - scifdev->base_addr;
> -		dma_free_coherent(&scifdev->sdev->dev,
> -				  size, va, local);
> -	}
> -}
> -
> -static __always_inline int
> -scif_map_single(dma_addr_t *dma_handle,
> -		void *local, struct scif_dev *scifdev, size_t size)
> -{
> -	int err =3D 0;
> -
> -	if (scifdev_self(scifdev)) {
> -		*dma_handle =3D virt_to_phys((local));
> -	} else {
> -		*dma_handle =3D dma_map_single(&scifdev->sdev->dev,
> -					     local, size, DMA_BIDIRECTIONAL);
> -		if (dma_mapping_error(&scifdev->sdev->dev, *dma_handle))
> -			err =3D -ENOMEM;
> -		else if (scifdev_is_p2p(scifdev))
> -			*dma_handle =3D *dma_handle + scifdev->base_addr;
> -	}
> -	if (err)
> -		*dma_handle =3D 0;
> -	return err;
> -}
> -
> -static __always_inline void
> -scif_unmap_single(dma_addr_t local, struct scif_dev *scifdev,
> -		  size_t size)
> -{
> -	if (!scifdev_self(scifdev)) {
> -		if (scifdev_is_p2p(scifdev))
> -			local =3D local - scifdev->base_addr;
> -		dma_unmap_single(&scifdev->sdev->dev, local,
> -				 size, DMA_BIDIRECTIONAL);
> -	}
> -}
> -
> -static __always_inline void *
> -scif_ioremap(dma_addr_t phys, size_t size, struct scif_dev *scifdev)
> -{
> -	void *out_virt;
> -	struct scif_hw_dev *sdev =3D scifdev->sdev;
> -
> -	if (scifdev_self(scifdev))
> -		out_virt =3D phys_to_virt(phys);
> -	else
> -		out_virt =3D (void __force *)
> -			   sdev->hw_ops->remap(sdev, phys, size);
> -	return out_virt;
> -}
> -
> -static __always_inline void
> -scif_iounmap(void *virt, size_t len, struct scif_dev *scifdev)
> -{
> -	if (!scifdev_self(scifdev)) {
> -		struct scif_hw_dev *sdev =3D scifdev->sdev;
> -
> -		sdev->hw_ops->unmap(sdev, (void __force __iomem *)virt);
> -	}
> -}
> -
> -static __always_inline int
> -scif_map_page(dma_addr_t *dma_handle, struct page *page,
> -	      struct scif_dev *scifdev)
> -{
> -	int err =3D 0;
> -
> -	if (scifdev_self(scifdev)) {
> -		*dma_handle =3D page_to_phys(page);
> -	} else {
> -		struct scif_hw_dev *sdev =3D scifdev->sdev;
> -		*dma_handle =3D dma_map_page(&sdev->dev,
> -					   page, 0x0, PAGE_SIZE,
> -					   DMA_BIDIRECTIONAL);
> -		if (dma_mapping_error(&sdev->dev, *dma_handle))
> -			err =3D -ENOMEM;
> -		else if (scifdev_is_p2p(scifdev))
> -			*dma_handle =3D *dma_handle + scifdev->base_addr;
> -	}
> -	if (err)
> -		*dma_handle =3D 0;
> -	return err;
> -}
> -#endif  /* SCIF_MAP_H */
> diff --git a/drivers/misc/mic/scif/scif_mmap.c
> b/drivers/misc/mic/scif/scif_mmap.c
> deleted file mode 100644
> index a151d416f39c..000000000000
> --- a/drivers/misc/mic/scif/scif_mmap.c
> +++ /dev/null
> @@ -1,690 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include "scif_main.h"
> -
> -/*
> - * struct scif_vma_info - Information about a remote memory mapping
> - *			  created via scif_mmap(..)
> - * @vma: VM area struct
> - * @list: link to list of active vmas
> - */
> -struct scif_vma_info {
> -	struct vm_area_struct *vma;
> -	struct list_head list;
> -};
> -
> -void scif_recv_munmap(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_rma_req req;
> -	struct scif_window *window =3D NULL;
> -	struct scif_window *recv_window =3D
> -		(struct scif_window *)msg->payload[0];
> -	struct scif_endpt *ep;
> -
> -	ep =3D (struct scif_endpt *)recv_window->ep;
> -	req.out_window =3D &window;
> -	req.offset =3D recv_window->offset;
> -	req.prot =3D recv_window->prot;
> -	req.nr_bytes =3D recv_window->nr_pages << PAGE_SHIFT;
> -	req.type =3D SCIF_WINDOW_FULL;
> -	req.head =3D &ep->rma_info.reg_list;
> -	msg->payload[0] =3D ep->remote_ep;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	/* Does a valid window exist? */
> -	if (scif_query_window(&req)) {
> -		dev_err(&scifdev->sdev->dev,
> -			"%s %d -ENXIO\n", __func__, __LINE__);
> -		msg->uop =3D SCIF_UNREGISTER_ACK;
> -		goto error;
> -	}
> -
> -	scif_put_window(window, window->nr_pages);
> -
> -	if (!window->ref_count) {
> -		atomic_inc(&ep->rma_info.tw_refcount);
> -		ep->rma_info.async_list_del =3D 1;
> -		list_del_init(&window->list);
> -		scif_free_window_offset(ep, window, window->offset);
> -	}
> -error:
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	if (window && !window->ref_count)
> -		scif_queue_for_cleanup(window, &scif_info.rma);
> -}
> -
> -/*
> - * Remove valid remote memory mappings created via scif_mmap(..) from
> the
> - * process address space since the remote node is lost
> - */
> -static void __scif_zap_mmaps(struct scif_endpt *ep)
> -{
> -	struct list_head *item;
> -	struct scif_vma_info *info;
> -	struct vm_area_struct *vma;
> -	unsigned long size;
> -
> -	spin_lock(&ep->lock);
> -	list_for_each(item, &ep->rma_info.vma_list) {
> -		info =3D list_entry(item, struct scif_vma_info, list);
> -		vma =3D info->vma;
> -		size =3D vma->vm_end - vma->vm_start;
> -		zap_vma_ptes(vma, vma->vm_start, size);
> -		dev_dbg(scif_info.mdev.this_device,
> -			"%s ep %p zap vma %p size 0x%lx\n",
> -			__func__, ep, info->vma, size);
> -	}
> -	spin_unlock(&ep->lock);
> -}
> -
> -/*
> - * Traverse the list of endpoints for a particular remote node and
> - * zap valid remote memory mappings since the remote node is lost
> - */
> -static void _scif_zap_mmaps(int node, struct list_head *head)
> -{
> -	struct scif_endpt *ep;
> -	struct list_head *item;
> -
> -	mutex_lock(&scif_info.connlock);
> -	list_for_each(item, head) {
> -		ep =3D list_entry(item, struct scif_endpt, list);
> -		if (ep->remote_dev->node =3D=3D node)
> -			__scif_zap_mmaps(ep);
> -	}
> -	mutex_unlock(&scif_info.connlock);
> -}
> -
> -/*
> - * Wrapper for removing remote memory mappings for a particular node.
> This API
> - * is called by peer nodes as part of handling a lost node.
> - */
> -void scif_zap_mmaps(int node)
> -{
> -	_scif_zap_mmaps(node, &scif_info.connected);
> -	_scif_zap_mmaps(node, &scif_info.disconnected);
> -}
> -
> -/*
> - * This API is only called while handling a lost node:
> - * a) Remote node is dead.
> - * b) Remote memory mappings have been zapped
> - * So we can traverse the remote_reg_list without any locks. Since
> - * the window has not yet been unregistered we can drop the ref count
> - * and queue it to the cleanup thread.
> - */
> -static void __scif_cleanup_rma_for_zombies(struct scif_endpt *ep)
> -{
> -	struct list_head *pos, *tmp;
> -	struct scif_window *window;
> -
> -	list_for_each_safe(pos, tmp, &ep->rma_info.remote_reg_list) {
> -		window =3D list_entry(pos, struct scif_window, list);
> -		if (window->ref_count)
> -			scif_put_window(window, window->nr_pages);
> -		else
> -			dev_err(scif_info.mdev.this_device,
> -				"%s %d unexpected\n",
> -				__func__, __LINE__);
> -		if (!window->ref_count) {
> -			atomic_inc(&ep->rma_info.tw_refcount);
> -			list_del_init(&window->list);
> -			scif_queue_for_cleanup(window, &scif_info.rma);
> -		}
> -	}
> -}
> -
> -/* Cleanup remote registration lists for zombie endpoints */
> -void scif_cleanup_rma_for_zombies(int node)
> -{
> -	struct scif_endpt *ep;
> -	struct list_head *item;
> -
> -	mutex_lock(&scif_info.eplock);
> -	list_for_each(item, &scif_info.zombie) {
> -		ep =3D list_entry(item, struct scif_endpt, list);
> -		if (ep->remote_dev && ep->remote_dev->node =3D=3D node)
> -			__scif_cleanup_rma_for_zombies(ep);
> -	}
> -	mutex_unlock(&scif_info.eplock);
> -	flush_work(&scif_info.misc_work);
> -}
> -
> -/* Insert the VMA into the per endpoint VMA list */
> -static int scif_insert_vma(struct scif_endpt *ep, struct vm_area_struct =
*vma)
> -{
> -	struct scif_vma_info *info;
> -	int err =3D 0;
> -
> -	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
> -	if (!info) {
> -		err =3D -ENOMEM;
> -		goto done;
> -	}
> -	info->vma =3D vma;
> -	spin_lock(&ep->lock);
> -	list_add_tail(&info->list, &ep->rma_info.vma_list);
> -	spin_unlock(&ep->lock);
> -done:
> -	return err;
> -}
> -
> -/* Delete the VMA from the per endpoint VMA list */
> -static void scif_delete_vma(struct scif_endpt *ep, struct vm_area_struct
> *vma)
> -{
> -	struct list_head *item;
> -	struct scif_vma_info *info;
> -
> -	spin_lock(&ep->lock);
> -	list_for_each(item, &ep->rma_info.vma_list) {
> -		info =3D list_entry(item, struct scif_vma_info, list);
> -		if (info->vma =3D=3D vma) {
> -			list_del(&info->list);
> -			kfree(info);
> -			break;
> -		}
> -	}
> -	spin_unlock(&ep->lock);
> -}
> -
> -static phys_addr_t scif_get_phys(phys_addr_t phys, struct scif_endpt *ep=
)
> -{
> -	struct scif_dev *scifdev =3D (struct scif_dev *)ep->remote_dev;
> -	struct scif_hw_dev *sdev =3D scifdev->sdev;
> -	phys_addr_t out_phys, apt_base =3D 0;
> -
> -	/*
> -	 * If the DMA address is card relative then we need to add the
> -	 * aperture base for mmap to work correctly
> -	 */
> -	if (!scifdev_self(scifdev) && sdev->aper && sdev->card_rel_da)
> -		apt_base =3D sdev->aper->pa;
> -	out_phys =3D apt_base + phys;
> -	return out_phys;
> -}
> -
> -int scif_get_pages(scif_epd_t epd, off_t offset, size_t len,
> -		   struct scif_range **pages)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct scif_rma_req req;
> -	struct scif_window *window =3D NULL;
> -	int nr_pages, err, i;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI get_pinned_pages: ep %p offset 0x%lx len 0x%lx\n",
> -		ep, offset, len);
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -
> -	if (!len || (offset < 0) ||
> -	    (offset + len < offset) ||
> -	    (ALIGN(offset, PAGE_SIZE) !=3D offset) ||
> -	    (ALIGN(len, PAGE_SIZE) !=3D len))
> -		return -EINVAL;
> -
> -	nr_pages =3D len >> PAGE_SHIFT;
> -
> -	req.out_window =3D &window;
> -	req.offset =3D offset;
> -	req.prot =3D 0;
> -	req.nr_bytes =3D len;
> -	req.type =3D SCIF_WINDOW_SINGLE;
> -	req.head =3D &ep->rma_info.remote_reg_list;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	/* Does a valid window exist? */
> -	err =3D scif_query_window(&req);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto error;
> -	}
> -
> -	/* Allocate scif_range */
> -	*pages =3D kzalloc(sizeof(**pages), GFP_KERNEL);
> -	if (!*pages) {
> -		err =3D -ENOMEM;
> -		goto error;
> -	}
> -
> -	/* Allocate phys addr array */
> -	(*pages)->phys_addr =3D scif_zalloc(nr_pages * sizeof(dma_addr_t));
> -	if (!((*pages)->phys_addr)) {
> -		err =3D -ENOMEM;
> -		goto error;
> -	}
> -
> -	if (scif_is_mgmt_node() && !scifdev_self(ep->remote_dev)) {
> -		/* Allocate virtual address array */
> -		((*pages)->va =3D scif_zalloc(nr_pages * sizeof(void *)));
> -		if (!(*pages)->va) {
> -			err =3D -ENOMEM;
> -			goto error;
> -		}
> -	}
> -	/* Populate the values */
> -	(*pages)->cookie =3D window;
> -	(*pages)->nr_pages =3D nr_pages;
> -	(*pages)->prot_flags =3D window->prot;
> -
> -	for (i =3D 0; i < nr_pages; i++) {
> -		(*pages)->phys_addr[i] =3D
> -			__scif_off_to_dma_addr(window, offset +
> -					       (i * PAGE_SIZE));
> -		(*pages)->phys_addr[i] =3D scif_get_phys((*pages)-
> >phys_addr[i],
> -							ep);
> -		if (scif_is_mgmt_node() && !scifdev_self(ep->remote_dev))
> -			(*pages)->va[i] =3D
> -				ep->remote_dev->sdev->aper->va +
> -				(*pages)->phys_addr[i] -
> -				ep->remote_dev->sdev->aper->pa;
> -	}
> -
> -	scif_get_window(window, nr_pages);
> -error:
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	if (err) {
> -		if (*pages) {
> -			scif_free((*pages)->phys_addr,
> -				  nr_pages * sizeof(dma_addr_t));
> -			scif_free((*pages)->va,
> -				  nr_pages * sizeof(void *));
> -			kfree(*pages);
> -			*pages =3D NULL;
> -		}
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -	}
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_get_pages);
> -
> -int scif_put_pages(struct scif_range *pages)
> -{
> -	struct scif_endpt *ep;
> -	struct scif_window *window;
> -	struct scifmsg msg;
> -
> -	if (!pages || !pages->cookie)
> -		return -EINVAL;
> -
> -	window =3D pages->cookie;
> -
> -	if (!window || window->magic !=3D SCIFEP_MAGIC)
> -		return -EINVAL;
> -
> -	ep =3D (struct scif_endpt *)window->ep;
> -	/*
> -	 * If the state is SCIFEP_CONNECTED or SCIFEP_DISCONNECTED then
> the
> -	 * callee should be allowed to release references to the pages,
> -	 * else the endpoint was not connected in the first place,
> -	 * hence the ENOTCONN.
> -	 */
> -	if (ep->state !=3D SCIFEP_CONNECTED && ep->state !=3D
> SCIFEP_DISCONNECTED)
> -		return -ENOTCONN;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -
> -	scif_put_window(window, pages->nr_pages);
> -
> -	/* Initiate window destruction if ref count is zero */
> -	if (!window->ref_count) {
> -		list_del(&window->list);
> -		mutex_unlock(&ep->rma_info.rma_lock);
> -		scif_drain_dma_intr(ep->remote_dev->sdev,
> -				    ep->rma_info.dma_chan);
> -		/* Inform the peer about this window being destroyed. */
> -		msg.uop =3D SCIF_MUNMAP;
> -		msg.src =3D ep->port;
> -		msg.payload[0] =3D window->peer_window;
> -		/* No error handling for notification messages */
> -		scif_nodeqp_send(ep->remote_dev, &msg);
> -		/* Destroy this window from the peer's registered AS */
> -		scif_destroy_remote_window(window);
> -	} else {
> -		mutex_unlock(&ep->rma_info.rma_lock);
> -	}
> -
> -	scif_free(pages->phys_addr, pages->nr_pages * sizeof(dma_addr_t));
> -	scif_free(pages->va, pages->nr_pages * sizeof(void *));
> -	kfree(pages);
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(scif_put_pages);
> -
> -/*
> - * scif_rma_list_mmap:
> - *
> - * Traverse the remote registration list starting from start_window:
> - * 1) Create VtoP mappings via remap_pfn_range(..)
> - * 2) Once step 1) and 2) complete successfully then traverse the range =
of
> - *    windows again and bump the reference count.
> - * RMA lock must be held.
> - */
> -static int scif_rma_list_mmap(struct scif_window *start_window, s64 offs=
et,
> -			      int nr_pages, struct vm_area_struct *vma)
> -{
> -	s64 end_offset, loop_offset =3D offset;
> -	struct scif_window *window =3D start_window;
> -	int loop_nr_pages, nr_pages_left =3D nr_pages;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)start_window->ep;
> -	struct list_head *head =3D &ep->rma_info.remote_reg_list;
> -	int i, err =3D 0;
> -	dma_addr_t phys_addr;
> -	struct scif_window_iter src_win_iter;
> -	size_t contig_bytes =3D 0;
> -
> -	might_sleep();
> -	list_for_each_entry_from(window, head, list) {
> -		end_offset =3D window->offset +
> -			(window->nr_pages << PAGE_SHIFT);
> -		loop_nr_pages =3D min_t(int,
> -				      (end_offset - loop_offset) >> PAGE_SHIFT,
> -				      nr_pages_left);
> -		scif_init_window_iter(window, &src_win_iter);
> -		for (i =3D 0; i < loop_nr_pages; i++) {
> -			phys_addr =3D scif_off_to_dma_addr(window,
> loop_offset,
> -							 &contig_bytes,
> -							 &src_win_iter);
> -			phys_addr =3D scif_get_phys(phys_addr, ep);
> -			err =3D remap_pfn_range(vma,
> -					      vma->vm_start +
> -					      loop_offset - offset,
> -					      phys_addr >> PAGE_SHIFT,
> -					      PAGE_SIZE,
> -					      vma->vm_page_prot);
> -			if (err)
> -				goto error;
> -			loop_offset +=3D PAGE_SIZE;
> -		}
> -		nr_pages_left -=3D loop_nr_pages;
> -		if (!nr_pages_left)
> -			break;
> -	}
> -	/*
> -	 * No more failures expected. Bump up the ref count for all
> -	 * the windows. Another traversal from start_window required
> -	 * for handling errors encountered across windows during
> -	 * remap_pfn_range(..).
> -	 */
> -	loop_offset =3D offset;
> -	nr_pages_left =3D nr_pages;
> -	window =3D start_window;
> -	head =3D &ep->rma_info.remote_reg_list;
> -	list_for_each_entry_from(window, head, list) {
> -		end_offset =3D window->offset +
> -			(window->nr_pages << PAGE_SHIFT);
> -		loop_nr_pages =3D min_t(int,
> -				      (end_offset - loop_offset) >> PAGE_SHIFT,
> -				      nr_pages_left);
> -		scif_get_window(window, loop_nr_pages);
> -		nr_pages_left -=3D loop_nr_pages;
> -		loop_offset +=3D (loop_nr_pages << PAGE_SHIFT);
> -		if (!nr_pages_left)
> -			break;
> -	}
> -error:
> -	if (err)
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -	return err;
> -}
> -
> -/*
> - * scif_rma_list_munmap:
> - *
> - * Traverse the remote registration list starting from window:
> - * 1) Decrement ref count.
> - * 2) If the ref count drops to zero then send a SCIF_MUNMAP message to
> peer.
> - * RMA lock must be held.
> - */
> -static void scif_rma_list_munmap(struct scif_window *start_window,
> -				 s64 offset, int nr_pages)
> -{
> -	struct scifmsg msg;
> -	s64 loop_offset =3D offset, end_offset;
> -	int loop_nr_pages, nr_pages_left =3D nr_pages;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)start_window->ep;
> -	struct list_head *head =3D &ep->rma_info.remote_reg_list;
> -	struct scif_window *window =3D start_window, *_window;
> -
> -	msg.uop =3D SCIF_MUNMAP;
> -	msg.src =3D ep->port;
> -	loop_offset =3D offset;
> -	nr_pages_left =3D nr_pages;
> -	list_for_each_entry_safe_from(window, _window, head, list) {
> -		end_offset =3D window->offset +
> -			(window->nr_pages << PAGE_SHIFT);
> -		loop_nr_pages =3D min_t(int,
> -				      (end_offset - loop_offset) >> PAGE_SHIFT,
> -				      nr_pages_left);
> -		scif_put_window(window, loop_nr_pages);
> -		if (!window->ref_count) {
> -			struct scif_dev *rdev =3D ep->remote_dev;
> -
> -			scif_drain_dma_intr(rdev->sdev,
> -					    ep->rma_info.dma_chan);
> -			/* Inform the peer about this munmap */
> -			msg.payload[0] =3D window->peer_window;
> -			/* No error handling for Notification messages. */
> -			scif_nodeqp_send(ep->remote_dev, &msg);
> -			list_del(&window->list);
> -			/* Destroy this window from the peer's registered AS
> */
> -			scif_destroy_remote_window(window);
> -		}
> -		nr_pages_left -=3D loop_nr_pages;
> -		loop_offset +=3D (loop_nr_pages << PAGE_SHIFT);
> -		if (!nr_pages_left)
> -			break;
> -	}
> -}
> -
> -/*
> - * The private data field of each VMA used to mmap a remote window
> - * points to an instance of struct vma_pvt
> - */
> -struct vma_pvt {
> -	struct scif_endpt *ep;	/* End point for remote window */
> -	s64 offset;		/* offset within remote window */
> -	bool valid_offset;	/* offset is valid only if the original
> -				 * mmap request was for a single page
> -				 * else the offset within the vma is
> -				 * the correct offset
> -				 */
> -	struct kref ref;
> -};
> -
> -static void vma_pvt_release(struct kref *ref)
> -{
> -	struct vma_pvt *vmapvt =3D container_of(ref, struct vma_pvt, ref);
> -
> -	kfree(vmapvt);
> -}
> -
> -/**
> - * scif_vma_open - VMA open driver callback
> - * @vma: VMM memory area.
> - * The open method is called by the kernel to allow the subsystem
> implementing
> - * the VMA to initialize the area. This method is invoked any time a new
> - * reference to the VMA is made (when a process forks, for example).
> - * The one exception happens when the VMA is first created by mmap;
> - * in this case, the driver's mmap method is called instead.
> - * This function is also invoked when an existing VMA is split by the ke=
rnel
> - * due to a call to munmap on a subset of the VMA resulting in two VMAs.
> - * The kernel invokes this function only on one of the two VMAs.
> - */
> -static void scif_vma_open(struct vm_area_struct *vma)
> -{
> -	struct vma_pvt *vmapvt =3D vma->vm_private_data;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI vma open: vma_start 0x%lx vma_end 0x%lx\n",
> -		vma->vm_start, vma->vm_end);
> -	scif_insert_vma(vmapvt->ep, vma);
> -	kref_get(&vmapvt->ref);
> -}
> -
> -/**
> - * scif_munmap - VMA close driver callback.
> - * @vma: VMM memory area.
> - * When an area is destroyed, the kernel calls its close operation.
> - * Note that there's no usage count associated with VMA's; the area
> - * is opened and closed exactly once by each process that uses it.
> - */
> -static void scif_munmap(struct vm_area_struct *vma)
> -{
> -	struct scif_endpt *ep;
> -	struct vma_pvt *vmapvt =3D vma->vm_private_data;
> -	int nr_pages =3D vma_pages(vma);
> -	s64 offset;
> -	struct scif_rma_req req;
> -	struct scif_window *window =3D NULL;
> -	int err;
> -
> -	might_sleep();
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI munmap: vma_start 0x%lx vma_end 0x%lx\n",
> -		vma->vm_start, vma->vm_end);
> -	ep =3D vmapvt->ep;
> -	offset =3D vmapvt->valid_offset ? vmapvt->offset :
> -		(vma->vm_pgoff) << PAGE_SHIFT;
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI munmap: ep %p nr_pages 0x%x offset 0x%llx\n",
> -		ep, nr_pages, offset);
> -	req.out_window =3D &window;
> -	req.offset =3D offset;
> -	req.nr_bytes =3D vma->vm_end - vma->vm_start;
> -	req.prot =3D vma->vm_flags & (VM_READ | VM_WRITE);
> -	req.type =3D SCIF_WINDOW_PARTIAL;
> -	req.head =3D &ep->rma_info.remote_reg_list;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -
> -	err =3D scif_query_window(&req);
> -	if (err)
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -	else
> -		scif_rma_list_munmap(window, offset, nr_pages);
> -
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	/*
> -	 * The kernel probably zeroes these out but we still want
> -	 * to clean up our own mess just in case.
> -	 */
> -	vma->vm_ops =3D NULL;
> -	vma->vm_private_data =3D NULL;
> -	kref_put(&vmapvt->ref, vma_pvt_release);
> -	scif_delete_vma(ep, vma);
> -}
> -
> -static const struct vm_operations_struct scif_vm_ops =3D {
> -	.open =3D scif_vma_open,
> -	.close =3D scif_munmap,
> -};
> -
> -/**
> - * scif_mmap - Map pages in virtual address space to a remote window.
> - * @vma: VMM memory area.
> - * @epd: endpoint descriptor
> - *
> - * Return: Upon successful completion, scif_mmap() returns zero
> - * else an apt error is returned as documented in scif.h
> - */
> -int scif_mmap(struct vm_area_struct *vma, scif_epd_t epd)
> -{
> -	struct scif_rma_req req;
> -	struct scif_window *window =3D NULL;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	s64 start_offset =3D vma->vm_pgoff << PAGE_SHIFT;
> -	int nr_pages =3D vma_pages(vma);
> -	int err;
> -	struct vma_pvt *vmapvt;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI mmap: ep %p start_offset 0x%llx nr_pages 0x%x\n",
> -		ep, start_offset, nr_pages);
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -
> -	might_sleep();
> -
> -	err =3D scif_insert_vma(ep, vma);
> -	if (err)
> -		return err;
> -
> -	vmapvt =3D kzalloc(sizeof(*vmapvt), GFP_KERNEL);
> -	if (!vmapvt) {
> -		scif_delete_vma(ep, vma);
> -		return -ENOMEM;
> -	}
> -
> -	vmapvt->ep =3D ep;
> -	kref_init(&vmapvt->ref);
> -
> -	req.out_window =3D &window;
> -	req.offset =3D start_offset;
> -	req.nr_bytes =3D vma->vm_end - vma->vm_start;
> -	req.prot =3D vma->vm_flags & (VM_READ | VM_WRITE);
> -	req.type =3D SCIF_WINDOW_PARTIAL;
> -	req.head =3D &ep->rma_info.remote_reg_list;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	/* Does a valid window exist? */
> -	err =3D scif_query_window(&req);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto error_unlock;
> -	}
> -
> -	/* Default prot for loopback */
> -	if (!scifdev_self(ep->remote_dev))
> -		vma->vm_page_prot =3D pgprot_writecombine(vma-
> >vm_page_prot);
> -
> -	/*
> -	 * VM_DONTCOPY - Do not copy this vma on fork
> -	 * VM_DONTEXPAND - Cannot expand with mremap()
> -	 * VM_RESERVED - Count as reserved_vm like IO
> -	 * VM_PFNMAP - Page-ranges managed without "struct page"
> -	 * VM_IO - Memory mapped I/O or similar
> -	 *
> -	 * We do not want to copy this VMA automatically on a fork(),
> -	 * expand this VMA due to mremap() or swap out these pages since
> -	 * the VMA is actually backed by physical pages in the remote
> -	 * node's physical memory and not via a struct page.
> -	 */
> -	vma->vm_flags |=3D VM_DONTCOPY | VM_DONTEXPAND |
> VM_DONTDUMP;
> -
> -	if (!scifdev_self(ep->remote_dev))
> -		vma->vm_flags |=3D VM_IO | VM_PFNMAP;
> -
> -	/* Map this range of windows */
> -	err =3D scif_rma_list_mmap(window, start_offset, nr_pages, vma);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto error_unlock;
> -	}
> -	/* Set up the driver call back */
> -	vma->vm_ops =3D &scif_vm_ops;
> -	vma->vm_private_data =3D vmapvt;
> -error_unlock:
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	if (err) {
> -		kfree(vmapvt);
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		scif_delete_vma(ep, vma);
> -	}
> -	return err;
> -}
> diff --git a/drivers/misc/mic/scif/scif_nm.c b/drivers/misc/mic/scif/scif=
_nm.c
> deleted file mode 100644
> index c4d9422082b7..000000000000
> --- a/drivers/misc/mic/scif/scif_nm.c
> +++ /dev/null
> @@ -1,229 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include "scif_peer_bus.h"
> -
> -#include "scif_main.h"
> -#include "scif_map.h"
> -
> -/**
> - * scif_invalidate_ep() - Set state for all connected endpoints
> - * to disconnected and wake up all send/recv waitqueues
> - *
> - * @node: Node to invalidate
> - */
> -static void scif_invalidate_ep(int node)
> -{
> -	struct scif_endpt *ep;
> -	struct list_head *pos, *tmpq;
> -
> -	flush_work(&scif_info.conn_work);
> -	mutex_lock(&scif_info.connlock);
> -	list_for_each_safe(pos, tmpq, &scif_info.disconnected) {
> -		ep =3D list_entry(pos, struct scif_endpt, list);
> -		if (ep->remote_dev->node =3D=3D node) {
> -			scif_unmap_all_windows(ep);
> -			spin_lock(&ep->lock);
> -			scif_cleanup_ep_qp(ep);
> -			spin_unlock(&ep->lock);
> -		}
> -	}
> -	list_for_each_safe(pos, tmpq, &scif_info.connected) {
> -		ep =3D list_entry(pos, struct scif_endpt, list);
> -		if (ep->remote_dev->node =3D=3D node) {
> -			list_del(pos);
> -			spin_lock(&ep->lock);
> -			ep->state =3D SCIFEP_DISCONNECTED;
> -			list_add_tail(&ep->list, &scif_info.disconnected);
> -			scif_cleanup_ep_qp(ep);
> -			wake_up_interruptible(&ep->sendwq);
> -			wake_up_interruptible(&ep->recvwq);
> -			spin_unlock(&ep->lock);
> -			scif_unmap_all_windows(ep);
> -		}
> -	}
> -	mutex_unlock(&scif_info.connlock);
> -}
> -
> -void scif_free_qp(struct scif_dev *scifdev)
> -{
> -	struct scif_qp *qp =3D scifdev->qpairs;
> -
> -	if (!qp)
> -		return;
> -	scif_unmap_single(qp->local_buf, scifdev, qp->inbound_q.size);
> -	kfree(qp->inbound_q.rb_base);
> -	scif_unmap_single(qp->local_qp, scifdev, sizeof(struct scif_qp));
> -	kfree(scifdev->qpairs);
> -	scifdev->qpairs =3D NULL;
> -}
> -
> -static void scif_cleanup_qp(struct scif_dev *dev)
> -{
> -	struct scif_qp *qp =3D &dev->qpairs[0];
> -
> -	if (!qp)
> -		return;
> -	scif_iounmap((void *)qp->remote_qp, sizeof(struct scif_qp), dev);
> -	scif_iounmap((void *)qp->outbound_q.rb_base,
> -		     sizeof(struct scif_qp), dev);
> -	qp->remote_qp =3D NULL;
> -	qp->local_write =3D 0;
> -	qp->inbound_q.current_write_offset =3D 0;
> -	qp->inbound_q.current_read_offset =3D 0;
> -	if (scifdev_is_p2p(dev))
> -		scif_free_qp(dev);
> -}
> -
> -void scif_send_acks(struct scif_dev *dev)
> -{
> -	struct scifmsg msg;
> -
> -	if (dev->node_remove_ack_pending) {
> -		msg.uop =3D SCIF_NODE_REMOVE_ACK;
> -		msg.src.node =3D scif_info.nodeid;
> -		msg.dst.node =3D SCIF_MGMT_NODE;
> -		msg.payload[0] =3D dev->node;
> -		scif_nodeqp_send(&scif_dev[SCIF_MGMT_NODE], &msg);
> -		dev->node_remove_ack_pending =3D false;
> -	}
> -	if (dev->exit_ack_pending) {
> -		msg.uop =3D SCIF_EXIT_ACK;
> -		msg.src.node =3D scif_info.nodeid;
> -		msg.dst.node =3D dev->node;
> -		scif_nodeqp_send(dev, &msg);
> -		dev->exit_ack_pending =3D false;
> -	}
> -}
> -
> -/**
> - * scif_cleanup_scifdev - Uninitialize SCIF data structures for remote
> - *                        SCIF device.
> - * @dev: Remote SCIF device.
> - */
> -void scif_cleanup_scifdev(struct scif_dev *dev)
> -{
> -	struct scif_hw_dev *sdev =3D dev->sdev;
> -
> -	if (!dev->sdev)
> -		return;
> -	if (scifdev_is_p2p(dev)) {
> -		if (dev->cookie) {
> -			sdev->hw_ops->free_irq(sdev, dev->cookie, dev);
> -			dev->cookie =3D NULL;
> -		}
> -		scif_destroy_intr_wq(dev);
> -	}
> -	flush_work(&scif_info.misc_work);
> -	scif_destroy_p2p(dev);
> -	scif_invalidate_ep(dev->node);
> -	scif_zap_mmaps(dev->node);
> -	scif_cleanup_rma_for_zombies(dev->node);
> -	flush_work(&scif_info.misc_work);
> -	scif_send_acks(dev);
> -	if (!dev->node && scif_info.card_initiated_exit) {
> -		/*
> -		 * Send an SCIF_EXIT message which is the last message from
> MIC
> -		 * to the Host and wait for a SCIF_EXIT_ACK
> -		 */
> -		scif_send_exit(dev);
> -		scif_info.card_initiated_exit =3D false;
> -	}
> -	scif_cleanup_qp(dev);
> -}
> -
> -/**
> - * scif_remove_node
> - *
> - * @node: Node to remove
> - */
> -void scif_handle_remove_node(int node)
> -{
> -	struct scif_dev *scifdev =3D &scif_dev[node];
> -
> -	if (scif_peer_unregister_device(scifdev))
> -		scif_send_acks(scifdev);
> -}
> -
> -static int scif_send_rmnode_msg(int node, int remove_node)
> -{
> -	struct scifmsg notif_msg;
> -	struct scif_dev *dev =3D &scif_dev[node];
> -
> -	notif_msg.uop =3D SCIF_NODE_REMOVE;
> -	notif_msg.src.node =3D scif_info.nodeid;
> -	notif_msg.dst.node =3D node;
> -	notif_msg.payload[0] =3D remove_node;
> -	return scif_nodeqp_send(dev, &notif_msg);
> -}
> -
> -/**
> - * scif_node_disconnect
> - *
> - * @node_id: source node id [in]
> - * @mgmt_initiated: Disconnection initiated from the mgmt node
> - *
> - * Disconnect a node from the scif network.
> - */
> -void scif_disconnect_node(u32 node_id, bool mgmt_initiated)
> -{
> -	int ret;
> -	int msg_cnt =3D 0;
> -	u32 i =3D 0;
> -	struct scif_dev *scifdev =3D &scif_dev[node_id];
> -
> -	if (!node_id)
> -		return;
> -
> -	atomic_set(&scifdev->disconn_rescnt, 0);
> -
> -	/* Destroy p2p network */
> -	for (i =3D 1; i <=3D scif_info.maxid; i++) {
> -		if (i =3D=3D node_id)
> -			continue;
> -		ret =3D scif_send_rmnode_msg(i, node_id);
> -		if (!ret)
> -			msg_cnt++;
> -	}
> -	/* Wait for the remote nodes to respond with
> SCIF_NODE_REMOVE_ACK */
> -	ret =3D wait_event_timeout(scifdev->disconn_wq,
> -				 (atomic_read(&scifdev->disconn_rescnt)
> -				 =3D=3D msg_cnt), SCIF_NODE_ALIVE_TIMEOUT);
> -	/* Tell the card to clean up */
> -	if (mgmt_initiated && _scifdev_alive(scifdev))
> -		/*
> -		 * Send an SCIF_EXIT message which is the last message from
> Host
> -		 * to the MIC and wait for a SCIF_EXIT_ACK
> -		 */
> -		scif_send_exit(scifdev);
> -	atomic_set(&scifdev->disconn_rescnt, 0);
> -	/* Tell the mgmt node to clean up */
> -	ret =3D scif_send_rmnode_msg(SCIF_MGMT_NODE, node_id);
> -	if (!ret)
> -		/* Wait for mgmt node to respond with
> SCIF_NODE_REMOVE_ACK */
> -		wait_event_timeout(scifdev->disconn_wq,
> -				   (atomic_read(&scifdev->disconn_rescnt) =3D=3D
> 1),
> -				   SCIF_NODE_ALIVE_TIMEOUT);
> -}
> -
> -void scif_get_node_info(void)
> -{
> -	struct scifmsg msg;
> -	DECLARE_COMPLETION_ONSTACK(node_info);
> -
> -	msg.uop =3D SCIF_GET_NODE_INFO;
> -	msg.src.node =3D scif_info.nodeid;
> -	msg.dst.node =3D SCIF_MGMT_NODE;
> -	msg.payload[3] =3D (u64)&node_info;
> -
> -	if ((scif_nodeqp_send(&scif_dev[SCIF_MGMT_NODE], &msg)))
> -		return;
> -
> -	/* Wait for a response with SCIF_GET_NODE_INFO */
> -	wait_for_completion(&node_info);
> -}
> diff --git a/drivers/misc/mic/scif/scif_nodeqp.c
> b/drivers/misc/mic/scif/scif_nodeqp.c
> deleted file mode 100644
> index 384ce08fa98a..000000000000
> --- a/drivers/misc/mic/scif/scif_nodeqp.c
> +++ /dev/null
> @@ -1,1349 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include "../bus/scif_bus.h"
> -#include "scif_peer_bus.h"
> -#include "scif_main.h"
> -#include "scif_nodeqp.h"
> -#include "scif_map.h"
> -
> -/*
> -
> ****************************************************************
> ********
> - * SCIF node Queue Pair (QP) setup flow:
> - *
> - * 1) SCIF driver gets probed with a scif_hw_dev via the scif_hw_bus
> - * 2) scif_setup_qp(..) allocates the local qp and calls
> - *	scif_setup_qp_connect(..) which allocates and maps the local
> - *	buffer for the inbound QP
> - * 3) The local node updates the device page with the DMA address of the
> QP
> - * 4) A delayed work is scheduled (qp_dwork) which periodically reads if
> - *	the peer node has updated its QP DMA address
> - * 5) Once a valid non zero address is found in the QP DMA address field
> - *	in the device page, the local node maps the remote node's QP,
> - *	updates its outbound QP and sends a SCIF_INIT message to the peer
> - * 6) The SCIF_INIT message is received by the peer node QP interrupt
> bottom
> - *	half handler by calling scif_init(..)
> - * 7) scif_init(..) registers a new SCIF peer node by calling
> - *	scif_peer_register_device(..) which signifies the addition of a new
> - *	SCIF node
> - * 8) On the mgmt node, P2P network setup/teardown is initiated if all t=
he
> - *	remote nodes are online via scif_p2p_setup(..)
> - * 9) For P2P setup, the host maps the remote nodes' aperture and memory
> - *	bars and sends a SCIF_NODE_ADD message to both nodes
> - * 10) As part of scif_nodeadd, both nodes set up their local inbound
> - *	QPs and send a SCIF_NODE_ADD_ACK to the mgmt node
> - * 11) As part of scif_node_add_ack(..) the mgmt node forwards the
> - *	SCIF_NODE_ADD_ACK to the remote nodes
> - * 12) As part of scif_node_add_ack(..) the remote nodes update their
> - *	outbound QPs, make sure they can access memory on the remote
> node
> - *	and then add a new SCIF peer node by calling
> - *	scif_peer_register_device(..) which signifies the addition of a new
> - *	SCIF node.
> - * 13) The SCIF network is now established across all nodes.
> - *
> -
> ****************************************************************
> ********
> - * SCIF node QP teardown flow (initiated by non mgmt node):
> - *
> - * 1) SCIF driver gets a remove callback with a scif_hw_dev via the
> scif_hw_bus
> - * 2) The device page QP DMA address field is updated with 0x0
> - * 3) A non mgmt node now cleans up all local data structures and sends =
a
> - *	SCIF_EXIT message to the peer and waits for a SCIF_EXIT_ACK
> - * 4) As part of scif_exit(..) handling scif_disconnect_node(..) is call=
ed
> - * 5) scif_disconnect_node(..) sends a SCIF_NODE_REMOVE message to all
> the
> - *	peers and waits for a SCIF_NODE_REMOVE_ACK
> - * 6) As part of scif_node_remove(..) a remote node unregisters the peer
> - *	node from the SCIF network and sends a SCIF_NODE_REMOVE_ACK
> - * 7) When the mgmt node has received all the SCIF_NODE_REMOVE_ACKs
> - *	it sends itself a node remove message whose handling cleans up local
> - *	data structures and unregisters the peer node from the SCIF network
> - * 8) The mgmt node sends a SCIF_EXIT_ACK
> - * 9) Upon receipt of the SCIF_EXIT_ACK the node initiating the teardown
> - *	completes the SCIF remove routine
> - * 10) The SCIF network is now torn down for the node initiating the
> - *	teardown sequence
> - *
> -
> ****************************************************************
> ********
> - * SCIF node QP teardown flow (initiated by mgmt node):
> - *
> - * 1) SCIF driver gets a remove callback with a scif_hw_dev via the
> scif_hw_bus
> - * 2) The device page QP DMA address field is updated with 0x0
> - * 3) The mgmt node calls scif_disconnect_node(..)
> - * 4) scif_disconnect_node(..) sends a SCIF_NODE_REMOVE message to all
> the peers
> - *	and waits for a SCIF_NODE_REMOVE_ACK
> - * 5) As part of scif_node_remove(..) a remote node unregisters the peer
> - *	node from the SCIF network and sends a SCIF_NODE_REMOVE_ACK
> - * 6) When the mgmt node has received all the SCIF_NODE_REMOVE_ACKs
> - *	it unregisters the peer node from the SCIF network
> - * 7) The mgmt node sends a SCIF_EXIT message and waits for a
> SCIF_EXIT_ACK.
> - * 8) A non mgmt node upon receipt of a SCIF_EXIT message calls scif_sto=
p(..)
> - *	which would clean up local data structures for all SCIF nodes and
> - *	then send a SCIF_EXIT_ACK back to the mgmt node
> - * 9) Upon receipt of the SCIF_EXIT_ACK the the mgmt node sends itself a
> node
> - *	remove message whose handling cleans up local data structures and
> - *	destroys any P2P mappings.
> - * 10) The SCIF hardware device for which a remove callback was received=
 is
> now
> - *	disconnected from the SCIF network.
> - */
> -/*
> - * Initializes "local" data structures for the QP. Allocates the QP
> - * ring buffer (rb) and initializes the "in bound" queue.
> - */
> -int scif_setup_qp_connect(struct scif_qp *qp, dma_addr_t *qp_offset,
> -			  int local_size, struct scif_dev *scifdev)
> -{
> -	void *local_q =3D qp->inbound_q.rb_base;
> -	int err =3D 0;
> -	u32 tmp_rd =3D 0;
> -
> -	spin_lock_init(&qp->send_lock);
> -	spin_lock_init(&qp->recv_lock);
> -
> -	/* Allocate rb only if not already allocated */
> -	if (!local_q) {
> -		local_q =3D kzalloc(local_size, GFP_KERNEL);
> -		if (!local_q) {
> -			err =3D -ENOMEM;
> -			return err;
> -		}
> -	}
> -
> -	err =3D scif_map_single(&qp->local_buf, local_q, scifdev, local_size);
> -	if (err)
> -		goto kfree;
> -	/*
> -	 * To setup the inbound_q, the buffer lives locally, the read pointer
> -	 * is remote and the write pointer is local.
> -	 */
> -	scif_rb_init(&qp->inbound_q,
> -		     &tmp_rd,
> -		     &qp->local_write,
> -		     local_q, get_count_order(local_size));
> -	/*
> -	 * The read pointer is NULL initially and it is unsafe to use the ring
> -	 * buffer til this changes!
> -	 */
> -	qp->inbound_q.read_ptr =3D NULL;
> -	err =3D scif_map_single(qp_offset, qp,
> -			      scifdev, sizeof(struct scif_qp));
> -	if (err)
> -		goto unmap;
> -	qp->local_qp =3D *qp_offset;
> -	return err;
> -unmap:
> -	scif_unmap_single(qp->local_buf, scifdev, local_size);
> -	qp->local_buf =3D 0;
> -kfree:
> -	kfree(local_q);
> -	return err;
> -}
> -
> -/* When the other side has already done it's allocation, this is called =
*/
> -int scif_setup_qp_accept(struct scif_qp *qp, dma_addr_t *qp_offset,
> -			 dma_addr_t phys, int local_size,
> -			 struct scif_dev *scifdev)
> -{
> -	void *local_q;
> -	void *remote_q;
> -	struct scif_qp *remote_qp;
> -	int remote_size;
> -	int err =3D 0;
> -
> -	spin_lock_init(&qp->send_lock);
> -	spin_lock_init(&qp->recv_lock);
> -	/* Start by figuring out where we need to point */
> -	remote_qp =3D scif_ioremap(phys, sizeof(struct scif_qp), scifdev);
> -	if (!remote_qp)
> -		return -EIO;
> -	qp->remote_qp =3D remote_qp;
> -	if (qp->remote_qp->magic !=3D SCIFEP_MAGIC) {
> -		err =3D -EIO;
> -		goto iounmap;
> -	}
> -	qp->remote_buf =3D remote_qp->local_buf;
> -	remote_size =3D qp->remote_qp->inbound_q.size;
> -	remote_q =3D scif_ioremap(qp->remote_buf, remote_size, scifdev);
> -	if (!remote_q) {
> -		err =3D -EIO;
> -		goto iounmap;
> -	}
> -	qp->remote_qp->local_write =3D 0;
> -	/*
> -	 * To setup the outbound_q, the buffer lives in remote memory,
> -	 * the read pointer is local, the write pointer is remote
> -	 */
> -	scif_rb_init(&qp->outbound_q,
> -		     &qp->local_read,
> -		     &qp->remote_qp->local_write,
> -		     remote_q,
> -		     get_count_order(remote_size));
> -	local_q =3D kzalloc(local_size, GFP_KERNEL);
> -	if (!local_q) {
> -		err =3D -ENOMEM;
> -		goto iounmap_1;
> -	}
> -	err =3D scif_map_single(&qp->local_buf, local_q, scifdev, local_size);
> -	if (err)
> -		goto kfree;
> -	qp->remote_qp->local_read =3D 0;
> -	/*
> -	 * To setup the inbound_q, the buffer lives locally, the read pointer
> -	 * is remote and the write pointer is local
> -	 */
> -	scif_rb_init(&qp->inbound_q,
> -		     &qp->remote_qp->local_read,
> -		     &qp->local_write,
> -		     local_q, get_count_order(local_size));
> -	err =3D scif_map_single(qp_offset, qp, scifdev,
> -			      sizeof(struct scif_qp));
> -	if (err)
> -		goto unmap;
> -	qp->local_qp =3D *qp_offset;
> -	return err;
> -unmap:
> -	scif_unmap_single(qp->local_buf, scifdev, local_size);
> -	qp->local_buf =3D 0;
> -kfree:
> -	kfree(local_q);
> -iounmap_1:
> -	scif_iounmap(remote_q, remote_size, scifdev);
> -	qp->outbound_q.rb_base =3D NULL;
> -iounmap:
> -	scif_iounmap(qp->remote_qp, sizeof(struct scif_qp), scifdev);
> -	qp->remote_qp =3D NULL;
> -	return err;
> -}
> -
> -int scif_setup_qp_connect_response(struct scif_dev *scifdev,
> -				   struct scif_qp *qp, u64 payload)
> -{
> -	int err =3D 0;
> -	void *r_buf;
> -	int remote_size;
> -	phys_addr_t tmp_phys;
> -
> -	qp->remote_qp =3D scif_ioremap(payload, sizeof(struct scif_qp),
> scifdev);
> -
> -	if (!qp->remote_qp) {
> -		err =3D -ENOMEM;
> -		goto error;
> -	}
> -
> -	if (qp->remote_qp->magic !=3D SCIFEP_MAGIC) {
> -		dev_err(&scifdev->sdev->dev,
> -			"SCIFEP_MAGIC mismatch between self %d
> remote %d\n",
> -			scif_dev[scif_info.nodeid].node, scifdev->node);
> -		err =3D -ENODEV;
> -		goto error;
> -	}
> -
> -	tmp_phys =3D qp->remote_qp->local_buf;
> -	remote_size =3D qp->remote_qp->inbound_q.size;
> -	r_buf =3D scif_ioremap(tmp_phys, remote_size, scifdev);
> -
> -	if (!r_buf)
> -		return -EIO;
> -
> -	qp->local_read =3D 0;
> -	scif_rb_init(&qp->outbound_q,
> -		     &qp->local_read,
> -		     &qp->remote_qp->local_write,
> -		     r_buf,
> -		     get_count_order(remote_size));
> -	/*
> -	 * Because the node QP may already be processing an INIT message,
> set
> -	 * the read pointer so the cached read offset isn't lost
> -	 */
> -	qp->remote_qp->local_read =3D qp->inbound_q.current_read_offset;
> -	/*
> -	 * resetup the inbound_q now that we know where the
> -	 * inbound_read really is.
> -	 */
> -	scif_rb_init(&qp->inbound_q,
> -		     &qp->remote_qp->local_read,
> -		     &qp->local_write,
> -		     qp->inbound_q.rb_base,
> -		     get_count_order(qp->inbound_q.size));
> -error:
> -	return err;
> -}
> -
> -static __always_inline void
> -scif_send_msg_intr(struct scif_dev *scifdev)
> -{
> -	struct scif_hw_dev *sdev =3D scifdev->sdev;
> -
> -	if (scifdev_is_p2p(scifdev))
> -		sdev->hw_ops->send_p2p_intr(sdev, scifdev->rdb, &scifdev-
> >mmio);
> -	else
> -		sdev->hw_ops->send_intr(sdev, scifdev->rdb);
> -}
> -
> -int scif_qp_response(phys_addr_t phys, struct scif_dev *scifdev)
> -{
> -	int err =3D 0;
> -	struct scifmsg msg;
> -
> -	err =3D scif_setup_qp_connect_response(scifdev, scifdev->qpairs, phys);
> -	if (!err) {
> -		/*
> -		 * Now that everything is setup and mapped, we're ready
> -		 * to tell the peer about our queue's location
> -		 */
> -		msg.uop =3D SCIF_INIT;
> -		msg.dst.node =3D scifdev->node;
> -		err =3D scif_nodeqp_send(scifdev, &msg);
> -	}
> -	return err;
> -}
> -
> -void scif_send_exit(struct scif_dev *scifdev)
> -{
> -	struct scifmsg msg;
> -	int ret;
> -
> -	scifdev->exit =3D OP_IN_PROGRESS;
> -	msg.uop =3D SCIF_EXIT;
> -	msg.src.node =3D scif_info.nodeid;
> -	msg.dst.node =3D scifdev->node;
> -	ret =3D scif_nodeqp_send(scifdev, &msg);
> -	if (ret)
> -		goto done;
> -	/* Wait for a SCIF_EXIT_ACK message */
> -	wait_event_timeout(scif_info.exitwq, scifdev->exit =3D=3D
> OP_COMPLETED,
> -			   SCIF_NODE_ALIVE_TIMEOUT);
> -done:
> -	scifdev->exit =3D OP_IDLE;
> -}
> -
> -int scif_setup_qp(struct scif_dev *scifdev)
> -{
> -	int err =3D 0;
> -	int local_size;
> -	struct scif_qp *qp;
> -
> -	local_size =3D SCIF_NODE_QP_SIZE;
> -
> -	qp =3D kzalloc(sizeof(*qp), GFP_KERNEL);
> -	if (!qp) {
> -		err =3D -ENOMEM;
> -		return err;
> -	}
> -	qp->magic =3D SCIFEP_MAGIC;
> -	scifdev->qpairs =3D qp;
> -	err =3D scif_setup_qp_connect(qp, &scifdev->qp_dma_addr,
> -				    local_size, scifdev);
> -	if (err)
> -		goto free_qp;
> -	/*
> -	 * We're as setup as we can be. The inbound_q is setup, w/o a usable
> -	 * outbound q.  When we get a message, the read_ptr will be
> updated,
> -	 * and we will pull the message.
> -	 */
> -	return err;
> -free_qp:
> -	kfree(scifdev->qpairs);
> -	scifdev->qpairs =3D NULL;
> -	return err;
> -}
> -
> -static void scif_p2p_freesg(struct scatterlist *sg)
> -{
> -	kfree(sg);
> -}
> -
> -static struct scatterlist *
> -scif_p2p_setsg(phys_addr_t pa, int page_size, int page_cnt)
> -{
> -	struct scatterlist *sg;
> -	struct page *page;
> -	int i;
> -
> -	sg =3D kmalloc_array(page_cnt, sizeof(struct scatterlist), GFP_KERNEL);
> -	if (!sg)
> -		return NULL;
> -	sg_init_table(sg, page_cnt);
> -	for (i =3D 0; i < page_cnt; i++) {
> -		page =3D pfn_to_page(pa >> PAGE_SHIFT);
> -		sg_set_page(&sg[i], page, page_size, 0);
> -		pa +=3D page_size;
> -	}
> -	return sg;
> -}
> -
> -/* Init p2p mappings required to access peerdev from scifdev */
> -static struct scif_p2p_info *
> -scif_init_p2p_info(struct scif_dev *scifdev, struct scif_dev *peerdev)
> -{
> -	struct scif_p2p_info *p2p;
> -	int num_mmio_pages, num_aper_pages, sg_page_shift, err,
> num_aper_chunks;
> -	struct scif_hw_dev *psdev =3D peerdev->sdev;
> -	struct scif_hw_dev *sdev =3D scifdev->sdev;
> -
> -	num_mmio_pages =3D psdev->mmio->len >> PAGE_SHIFT;
> -	num_aper_pages =3D psdev->aper->len >> PAGE_SHIFT;
> -
> -	p2p =3D kzalloc(sizeof(*p2p), GFP_KERNEL);
> -	if (!p2p)
> -		return NULL;
> -	p2p->ppi_sg[SCIF_PPI_MMIO] =3D scif_p2p_setsg(psdev->mmio->pa,
> -						    PAGE_SIZE,
> num_mmio_pages);
> -	if (!p2p->ppi_sg[SCIF_PPI_MMIO])
> -		goto free_p2p;
> -	p2p->sg_nentries[SCIF_PPI_MMIO] =3D num_mmio_pages;
> -	sg_page_shift =3D get_order(min(psdev->aper->len, (u64)(1 << 30)));
> -	num_aper_chunks =3D num_aper_pages >> (sg_page_shift -
> PAGE_SHIFT);
> -	p2p->ppi_sg[SCIF_PPI_APER] =3D scif_p2p_setsg(psdev->aper->pa,
> -						    1 << sg_page_shift,
> -						    num_aper_chunks);
> -	p2p->sg_nentries[SCIF_PPI_APER] =3D num_aper_chunks;
> -	err =3D dma_map_sg(&sdev->dev, p2p->ppi_sg[SCIF_PPI_MMIO],
> -			 num_mmio_pages, PCI_DMA_BIDIRECTIONAL);
> -	if (err !=3D num_mmio_pages)
> -		goto scif_p2p_free;
> -	err =3D dma_map_sg(&sdev->dev, p2p->ppi_sg[SCIF_PPI_APER],
> -			 num_aper_chunks, PCI_DMA_BIDIRECTIONAL);
> -	if (err !=3D num_aper_chunks)
> -		goto dma_unmap;
> -	p2p->ppi_da[SCIF_PPI_MMIO] =3D sg_dma_address(p2p-
> >ppi_sg[SCIF_PPI_MMIO]);
> -	p2p->ppi_da[SCIF_PPI_APER] =3D sg_dma_address(p2p-
> >ppi_sg[SCIF_PPI_APER]);
> -	p2p->ppi_len[SCIF_PPI_MMIO] =3D num_mmio_pages;
> -	p2p->ppi_len[SCIF_PPI_APER] =3D num_aper_pages;
> -	p2p->ppi_peer_id =3D peerdev->node;
> -	return p2p;
> -dma_unmap:
> -	dma_unmap_sg(&sdev->dev, p2p->ppi_sg[SCIF_PPI_MMIO],
> -		     p2p->sg_nentries[SCIF_PPI_MMIO], DMA_BIDIRECTIONAL);
> -scif_p2p_free:
> -	scif_p2p_freesg(p2p->ppi_sg[SCIF_PPI_MMIO]);
> -	scif_p2p_freesg(p2p->ppi_sg[SCIF_PPI_APER]);
> -free_p2p:
> -	kfree(p2p);
> -	return NULL;
> -}
> -
> -/* Uninitialize and release resources from a p2p mapping */
> -static void scif_deinit_p2p_info(struct scif_dev *scifdev,
> -				 struct scif_p2p_info *p2p)
> -{
> -	struct scif_hw_dev *sdev =3D scifdev->sdev;
> -
> -	dma_unmap_sg(&sdev->dev, p2p->ppi_sg[SCIF_PPI_MMIO],
> -		     p2p->sg_nentries[SCIF_PPI_MMIO], DMA_BIDIRECTIONAL);
> -	dma_unmap_sg(&sdev->dev, p2p->ppi_sg[SCIF_PPI_APER],
> -		     p2p->sg_nentries[SCIF_PPI_APER], DMA_BIDIRECTIONAL);
> -	scif_p2p_freesg(p2p->ppi_sg[SCIF_PPI_MMIO]);
> -	scif_p2p_freesg(p2p->ppi_sg[SCIF_PPI_APER]);
> -	kfree(p2p);
> -}
> -
> -/**
> - * scif_node_connect: Respond to SCIF_NODE_CONNECT interrupt message
> - * @scifdev: SCIF device
> - * @dst: Destination node
> - *
> - * Connect the src and dst node by setting up the p2p connection
> - * between them. Management node here acts like a proxy.
> - */
> -static void scif_node_connect(struct scif_dev *scifdev, int dst)
> -{
> -	struct scif_dev *dev_j =3D scifdev;
> -	struct scif_dev *dev_i =3D NULL;
> -	struct scif_p2p_info *p2p_ij =3D NULL;    /* bus addr for j from i */
> -	struct scif_p2p_info *p2p_ji =3D NULL;    /* bus addr for i from j */
> -	struct scif_p2p_info *p2p;
> -	struct list_head *pos, *tmp;
> -	struct scifmsg msg;
> -	int err;
> -	u64 tmppayload;
> -
> -	if (dst < 1 || dst > scif_info.maxid)
> -		return;
> -
> -	dev_i =3D &scif_dev[dst];
> -
> -	if (!_scifdev_alive(dev_i))
> -		return;
> -	/*
> -	 * If the p2p connection is already setup or in the process of setting
> -	 * up then just ignore this request. The requested node will get
> -	 * informed by SCIF_NODE_ADD_ACK or SCIF_NODE_ADD_NACK
> -	 */
> -	if (!list_empty(&dev_i->p2p)) {
> -		list_for_each_safe(pos, tmp, &dev_i->p2p) {
> -			p2p =3D list_entry(pos, struct scif_p2p_info, ppi_list);
> -			if (p2p->ppi_peer_id =3D=3D dev_j->node)
> -				return;
> -		}
> -	}
> -	p2p_ij =3D scif_init_p2p_info(dev_i, dev_j);
> -	if (!p2p_ij)
> -		return;
> -	p2p_ji =3D scif_init_p2p_info(dev_j, dev_i);
> -	if (!p2p_ji) {
> -		scif_deinit_p2p_info(dev_i, p2p_ij);
> -		return;
> -	}
> -	list_add_tail(&p2p_ij->ppi_list, &dev_i->p2p);
> -	list_add_tail(&p2p_ji->ppi_list, &dev_j->p2p);
> -
> -	/*
> -	 * Send a SCIF_NODE_ADD to dev_i, pass it its bus address
> -	 * as seen from dev_j
> -	 */
> -	msg.uop =3D SCIF_NODE_ADD;
> -	msg.src.node =3D dev_j->node;
> -	msg.dst.node =3D dev_i->node;
> -
> -	msg.payload[0] =3D p2p_ji->ppi_da[SCIF_PPI_APER];
> -	msg.payload[1] =3D p2p_ij->ppi_da[SCIF_PPI_MMIO];
> -	msg.payload[2] =3D p2p_ij->ppi_da[SCIF_PPI_APER];
> -	msg.payload[3] =3D p2p_ij->ppi_len[SCIF_PPI_APER] << PAGE_SHIFT;
> -
> -	err =3D scif_nodeqp_send(dev_i,  &msg);
> -	if (err) {
> -		dev_err(&scifdev->sdev->dev,
> -			"%s %d error %d\n", __func__, __LINE__, err);
> -		return;
> -	}
> -
> -	/* Same as above but to dev_j */
> -	msg.uop =3D SCIF_NODE_ADD;
> -	msg.src.node =3D dev_i->node;
> -	msg.dst.node =3D dev_j->node;
> -
> -	tmppayload =3D msg.payload[0];
> -	msg.payload[0] =3D msg.payload[2];
> -	msg.payload[2] =3D tmppayload;
> -	msg.payload[1] =3D p2p_ji->ppi_da[SCIF_PPI_MMIO];
> -	msg.payload[3] =3D p2p_ji->ppi_len[SCIF_PPI_APER] << PAGE_SHIFT;
> -
> -	scif_nodeqp_send(dev_j, &msg);
> -}
> -
> -static void scif_p2p_setup(void)
> -{
> -	int i, j;
> -
> -	if (!scif_info.p2p_enable)
> -		return;
> -
> -	for (i =3D 1; i <=3D scif_info.maxid; i++)
> -		if (!_scifdev_alive(&scif_dev[i]))
> -			return;
> -
> -	for (i =3D 1; i <=3D scif_info.maxid; i++) {
> -		for (j =3D 1; j <=3D scif_info.maxid; j++) {
> -			struct scif_dev *scifdev =3D &scif_dev[i];
> -
> -			if (i =3D=3D j)
> -				continue;
> -			scif_node_connect(scifdev, j);
> -		}
> -	}
> -}
> -
> -static char *message_types[] =3D {"BAD",
> -				"INIT",
> -				"EXIT",
> -				"SCIF_EXIT_ACK",
> -				"SCIF_NODE_ADD",
> -				"SCIF_NODE_ADD_ACK",
> -				"SCIF_NODE_ADD_NACK",
> -				"REMOVE_NODE",
> -				"REMOVE_NODE_ACK",
> -				"CNCT_REQ",
> -				"CNCT_GNT",
> -				"CNCT_GNTACK",
> -				"CNCT_GNTNACK",
> -				"CNCT_REJ",
> -				"DISCNCT",
> -				"DISCNT_ACK",
> -				"CLIENT_SENT",
> -				"CLIENT_RCVD",
> -				"SCIF_GET_NODE_INFO",
> -				"REGISTER",
> -				"REGISTER_ACK",
> -				"REGISTER_NACK",
> -				"UNREGISTER",
> -				"UNREGISTER_ACK",
> -				"UNREGISTER_NACK",
> -				"ALLOC_REQ",
> -				"ALLOC_GNT",
> -				"ALLOC_REJ",
> -				"FREE_PHYS",
> -				"FREE_VIRT",
> -				"MUNMAP",
> -				"MARK",
> -				"MARK_ACK",
> -				"MARK_NACK",
> -				"WAIT",
> -				"WAIT_ACK",
> -				"WAIT_NACK",
> -				"SIGNAL_LOCAL",
> -				"SIGNAL_REMOTE",
> -				"SIG_ACK",
> -				"SIG_NACK"};
> -
> -static void
> -scif_display_message(struct scif_dev *scifdev, struct scifmsg *msg,
> -		     const char *label)
> -{
> -	if (!scif_info.en_msg_log)
> -		return;
> -	if (msg->uop > SCIF_MAX_MSG) {
> -		dev_err(&scifdev->sdev->dev,
> -			"%s: unknown msg type %d\n", label, msg->uop);
> -		return;
> -	}
> -	dev_info(&scifdev->sdev->dev,
> -		 "%s: msg type %s, src %d:%d, dest %d:%d payload
> 0x%llx:0x%llx:0x%llx:0x%llx\n",
> -		 label, message_types[msg->uop], msg->src.node, msg-
> >src.port,
> -		 msg->dst.node, msg->dst.port, msg->payload[0], msg-
> >payload[1],
> -		 msg->payload[2], msg->payload[3]);
> -}
> -
> -int _scif_nodeqp_send(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_qp *qp =3D scifdev->qpairs;
> -	int err =3D -ENOMEM, loop_cnt =3D 0;
> -
> -	scif_display_message(scifdev, msg, "Sent");
> -	if (!qp) {
> -		err =3D -EINVAL;
> -		goto error;
> -	}
> -	spin_lock(&qp->send_lock);
> -
> -	while ((err =3D scif_rb_write(&qp->outbound_q,
> -				    msg, sizeof(struct scifmsg)))) {
> -		mdelay(1);
> -#define SCIF_NODEQP_SEND_TO_MSEC (3 * 1000)
> -		if (loop_cnt++ > (SCIF_NODEQP_SEND_TO_MSEC)) {
> -			err =3D -ENODEV;
> -			break;
> -		}
> -	}
> -	if (!err)
> -		scif_rb_commit(&qp->outbound_q);
> -	spin_unlock(&qp->send_lock);
> -	if (!err) {
> -		if (scifdev_self(scifdev))
> -			/*
> -			 * For loopback we need to emulate an interrupt by
> -			 * queuing work for the queue handling real node
> -			 * Qp interrupts.
> -			 */
> -			queue_work(scifdev->intr_wq, &scifdev->intr_bh);
> -		else
> -			scif_send_msg_intr(scifdev);
> -	}
> -error:
> -	if (err)
> -		dev_dbg(&scifdev->sdev->dev,
> -			"%s %d error %d uop %d\n",
> -			 __func__, __LINE__, err, msg->uop);
> -	return err;
> -}
> -
> -/**
> - * scif_nodeqp_send - Send a message on the node queue pair
> - * @scifdev: Scif Device.
> - * @msg: The message to be sent.
> - */
> -int scif_nodeqp_send(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	int err;
> -	struct device *spdev =3D NULL;
> -
> -	if (msg->uop > SCIF_EXIT_ACK) {
> -		/* Don't send messages once the exit flow has begun */
> -		if (OP_IDLE !=3D scifdev->exit)
> -			return -ENODEV;
> -		spdev =3D scif_get_peer_dev(scifdev);
> -		if (IS_ERR(spdev)) {
> -			err =3D PTR_ERR(spdev);
> -			return err;
> -		}
> -	}
> -	err =3D _scif_nodeqp_send(scifdev, msg);
> -	if (msg->uop > SCIF_EXIT_ACK)
> -		scif_put_peer_dev(spdev);
> -	return err;
> -}
> -
> -/*
> - * scif_misc_handler:
> - *
> - * Work queue handler for servicing miscellaneous SCIF tasks.
> - * Examples include:
> - * 1) Remote fence requests.
> - * 2) Destruction of temporary registered windows
> - *    created during scif_vreadfrom()/scif_vwriteto().
> - * 3) Cleanup of zombie endpoints.
> - */
> -void scif_misc_handler(struct work_struct *work)
> -{
> -	scif_rma_handle_remote_fences();
> -	scif_rma_destroy_windows();
> -	scif_rma_destroy_tcw_invalid();
> -	scif_cleanup_zombie_epd();
> -}
> -
> -/**
> - * scif_init() - Respond to SCIF_INIT interrupt message
> - * @scifdev:    Remote SCIF device node
> - * @msg:        Interrupt message
> - */
> -static __always_inline void
> -scif_init(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	/*
> -	 * Allow the thread waiting for device page updates for the peer QP
> DMA
> -	 * address to complete initializing the inbound_q.
> -	 */
> -	flush_delayed_work(&scifdev->qp_dwork);
> -
> -	scif_peer_register_device(scifdev);
> -
> -	if (scif_is_mgmt_node()) {
> -		mutex_lock(&scif_info.conflock);
> -		scif_p2p_setup();
> -		mutex_unlock(&scif_info.conflock);
> -	}
> -}
> -
> -/**
> - * scif_exit() - Respond to SCIF_EXIT interrupt message
> - * @scifdev:    Remote SCIF device node
> - * @unused:     Interrupt message (unused)
> - *
> - * This function stops the SCIF interface for the node which sent
> - * the SCIF_EXIT message and starts waiting for that node to
> - * resetup the queue pair again.
> - */
> -static __always_inline void
> -scif_exit(struct scif_dev *scifdev, struct scifmsg *unused)
> -{
> -	scifdev->exit_ack_pending =3D true;
> -	if (scif_is_mgmt_node())
> -		scif_disconnect_node(scifdev->node, false);
> -	else
> -		scif_stop(scifdev);
> -	schedule_delayed_work(&scifdev->qp_dwork,
> -			      msecs_to_jiffies(1000));
> -}
> -
> -/**
> - * scif_exitack() - Respond to SCIF_EXIT_ACK interrupt message
> - * @scifdev:    Remote SCIF device node
> - * @unused:     Interrupt message (unused)
> - *
> - */
> -static __always_inline void
> -scif_exit_ack(struct scif_dev *scifdev, struct scifmsg *unused)
> -{
> -	scifdev->exit =3D OP_COMPLETED;
> -	wake_up(&scif_info.exitwq);
> -}
> -
> -/**
> - * scif_node_add() - Respond to SCIF_NODE_ADD interrupt message
> - * @scifdev:    Remote SCIF device node
> - * @msg:        Interrupt message
> - *
> - * When the mgmt node driver has finished initializing a MIC node queue
> pair it
> - * marks the node as online. It then looks for all currently online MIC =
cards
> - * and send a SCIF_NODE_ADD message to identify the ID of the new card
> for
> - * peer to peer initialization
> - *
> - * The local node allocates its incoming queue and sends its address in =
the
> - * SCIF_NODE_ADD_ACK message back to the mgmt node, the mgmt node
> "reflects"
> - * this message to the new node
> - */
> -static __always_inline void
> -scif_node_add(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_dev *newdev;
> -	dma_addr_t qp_offset;
> -	int qp_connect;
> -	struct scif_hw_dev *sdev;
> -
> -	dev_dbg(&scifdev->sdev->dev,
> -		"Scifdev %d:%d received NODE_ADD msg for node %d\n",
> -		scifdev->node, msg->dst.node, msg->src.node);
> -	dev_dbg(&scifdev->sdev->dev,
> -		"Remote address for this node's aperture %llx\n",
> -		msg->payload[0]);
> -	newdev =3D &scif_dev[msg->src.node];
> -	newdev->node =3D msg->src.node;
> -	newdev->sdev =3D scif_dev[SCIF_MGMT_NODE].sdev;
> -	sdev =3D newdev->sdev;
> -
> -	if (scif_setup_intr_wq(newdev)) {
> -		dev_err(&scifdev->sdev->dev,
> -			"failed to setup interrupts for %d\n", msg->src.node);
> -		goto interrupt_setup_error;
> -	}
> -	newdev->mmio.va =3D ioremap(msg->payload[1], sdev->mmio->len);
> -	if (!newdev->mmio.va) {
> -		dev_err(&scifdev->sdev->dev,
> -			"failed to map mmio for %d\n", msg->src.node);
> -		goto mmio_map_error;
> -	}
> -	newdev->qpairs =3D kzalloc(sizeof(*newdev->qpairs), GFP_KERNEL);
> -	if (!newdev->qpairs)
> -		goto qp_alloc_error;
> -	/*
> -	 * Set the base address of the remote node's memory since it gets
> -	 * added to qp_offset
> -	 */
> -	newdev->base_addr =3D msg->payload[0];
> -
> -	qp_connect =3D scif_setup_qp_connect(newdev->qpairs, &qp_offset,
> -					   SCIF_NODE_QP_SIZE, newdev);
> -	if (qp_connect) {
> -		dev_err(&scifdev->sdev->dev,
> -			"failed to setup qp_connect %d\n", qp_connect);
> -		goto qp_connect_error;
> -	}
> -
> -	newdev->db =3D sdev->hw_ops->next_db(sdev);
> -	newdev->cookie =3D sdev->hw_ops->request_irq(sdev,
> scif_intr_handler,
> -						   "SCIF_INTR", newdev,
> -						   newdev->db);
> -	if (IS_ERR(newdev->cookie))
> -		goto qp_connect_error;
> -	newdev->qpairs->magic =3D SCIFEP_MAGIC;
> -	newdev->qpairs->qp_state =3D SCIF_QP_OFFLINE;
> -
> -	msg->uop =3D SCIF_NODE_ADD_ACK;
> -	msg->dst.node =3D msg->src.node;
> -	msg->src.node =3D scif_info.nodeid;
> -	msg->payload[0] =3D qp_offset;
> -	msg->payload[2] =3D newdev->db;
> -	scif_nodeqp_send(&scif_dev[SCIF_MGMT_NODE], msg);
> -	return;
> -qp_connect_error:
> -	kfree(newdev->qpairs);
> -	newdev->qpairs =3D NULL;
> -qp_alloc_error:
> -	iounmap(newdev->mmio.va);
> -	newdev->mmio.va =3D NULL;
> -mmio_map_error:
> -interrupt_setup_error:
> -	dev_err(&scifdev->sdev->dev,
> -		"node add failed for node %d\n", msg->src.node);
> -	msg->uop =3D SCIF_NODE_ADD_NACK;
> -	msg->dst.node =3D msg->src.node;
> -	msg->src.node =3D scif_info.nodeid;
> -	scif_nodeqp_send(&scif_dev[SCIF_MGMT_NODE], msg);
> -}
> -
> -void scif_poll_qp_state(struct work_struct *work)
> -{
> -#define SCIF_NODE_QP_RETRY 100
> -#define SCIF_NODE_QP_TIMEOUT 100
> -	struct scif_dev *peerdev =3D container_of(work, struct scif_dev,
> -							p2p_dwork.work);
> -	struct scif_qp *qp =3D &peerdev->qpairs[0];
> -
> -	if (qp->qp_state !=3D SCIF_QP_ONLINE ||
> -	    qp->remote_qp->qp_state !=3D SCIF_QP_ONLINE) {
> -		if (peerdev->p2p_retry++ =3D=3D SCIF_NODE_QP_RETRY) {
> -			dev_err(&peerdev->sdev->dev,
> -				"Warning: QP check timeout with state %d\n",
> -				qp->qp_state);
> -			goto timeout;
> -		}
> -		schedule_delayed_work(&peerdev->p2p_dwork,
> -
> msecs_to_jiffies(SCIF_NODE_QP_TIMEOUT));
> -		return;
> -	}
> -	return;
> -timeout:
> -	dev_err(&peerdev->sdev->dev,
> -		"%s %d remote node %d offline,  state =3D 0x%x\n",
> -		__func__, __LINE__, peerdev->node, qp->qp_state);
> -	qp->remote_qp->qp_state =3D SCIF_QP_OFFLINE;
> -	scif_peer_unregister_device(peerdev);
> -	scif_cleanup_scifdev(peerdev);
> -}
> -
> -/**
> - * scif_node_add_ack() - Respond to SCIF_NODE_ADD_ACK interrupt
> message
> - * @scifdev:    Remote SCIF device node
> - * @msg:        Interrupt message
> - *
> - * After a MIC node receives the SCIF_NODE_ADD_ACK message it send this
> - * message to the mgmt node to confirm the sequence is finished.
> - *
> - */
> -static __always_inline void
> -scif_node_add_ack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_dev *peerdev;
> -	struct scif_qp *qp;
> -	struct scif_dev *dst_dev =3D &scif_dev[msg->dst.node];
> -
> -	dev_dbg(&scifdev->sdev->dev,
> -		"Scifdev %d received SCIF_NODE_ADD_ACK msg src %d
> dst %d\n",
> -		scifdev->node, msg->src.node, msg->dst.node);
> -	dev_dbg(&scifdev->sdev->dev,
> -		"payload %llx %llx %llx %llx\n", msg->payload[0],
> -		msg->payload[1], msg->payload[2], msg->payload[3]);
> -	if (scif_is_mgmt_node()) {
> -		/*
> -		 * the lock serializes with scif_qp_response_ack. The mgmt
> node
> -		 * is forwarding the NODE_ADD_ACK message from src to dst
> we
> -		 * need to make sure that the dst has already received a
> -		 * NODE_ADD for src and setup its end of the qp to dst
> -		 */
> -		mutex_lock(&scif_info.conflock);
> -		msg->payload[1] =3D scif_info.maxid;
> -		scif_nodeqp_send(dst_dev, msg);
> -		mutex_unlock(&scif_info.conflock);
> -		return;
> -	}
> -	peerdev =3D &scif_dev[msg->src.node];
> -	peerdev->sdev =3D scif_dev[SCIF_MGMT_NODE].sdev;
> -	peerdev->node =3D msg->src.node;
> -
> -	qp =3D &peerdev->qpairs[0];
> -
> -	if ((scif_setup_qp_connect_response(peerdev, &peerdev->qpairs[0],
> -					    msg->payload[0])))
> -		goto local_error;
> -	peerdev->rdb =3D msg->payload[2];
> -	qp->remote_qp->qp_state =3D SCIF_QP_ONLINE;
> -
> -	scif_peer_register_device(peerdev);
> -
> -	schedule_delayed_work(&peerdev->p2p_dwork, 0);
> -	return;
> -local_error:
> -	scif_cleanup_scifdev(peerdev);
> -}
> -
> -/**
> - * scif_node_add_nack: Respond to SCIF_NODE_ADD_NACK interrupt
> message
> - * @scifdev:    Remote SCIF device node
> - * @msg:        Interrupt message
> - *
> - * SCIF_NODE_ADD failed, so inform the waiting wq.
> - */
> -static __always_inline void
> -scif_node_add_nack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	if (scif_is_mgmt_node()) {
> -		struct scif_dev *dst_dev =3D &scif_dev[msg->dst.node];
> -
> -		dev_dbg(&scifdev->sdev->dev,
> -			"SCIF_NODE_ADD_NACK received from %d\n",
> scifdev->node);
> -		scif_nodeqp_send(dst_dev, msg);
> -	}
> -}
> -
> -/**
> - * scif_node_remove: Handle SCIF_NODE_REMOVE message
> - * @scifdev:    Remote SCIF device node
> - * @msg: Interrupt message
> - *
> - * Handle node removal.
> - */
> -static __always_inline void
> -scif_node_remove(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	int node =3D msg->payload[0];
> -	struct scif_dev *scdev =3D &scif_dev[node];
> -
> -	scdev->node_remove_ack_pending =3D true;
> -	scif_handle_remove_node(node);
> -}
> -
> -/**
> - * scif_node_remove_ack: Handle SCIF_NODE_REMOVE_ACK message
> - * @scifdev:    Remote SCIF device node
> - * @msg: Interrupt message
> - *
> - * The peer has acked a SCIF_NODE_REMOVE message.
> - */
> -static __always_inline void
> -scif_node_remove_ack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_dev *sdev =3D &scif_dev[msg->payload[0]];
> -
> -	atomic_inc(&sdev->disconn_rescnt);
> -	wake_up(&sdev->disconn_wq);
> -}
> -
> -/**
> - * scif_get_node_info: Respond to SCIF_GET_NODE_INFO interrupt message
> - * @scifdev:    Remote SCIF device node
> - * @msg:        Interrupt message
> - *
> - * Retrieve node info i.e maxid and total from the mgmt node.
> - */
> -static __always_inline void
> -scif_get_node_info_resp(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	if (scif_is_mgmt_node()) {
> -		swap(msg->dst.node, msg->src.node);
> -		mutex_lock(&scif_info.conflock);
> -		msg->payload[1] =3D scif_info.maxid;
> -		msg->payload[2] =3D scif_info.total;
> -		mutex_unlock(&scif_info.conflock);
> -		scif_nodeqp_send(scifdev, msg);
> -	} else {
> -		struct completion *node_info =3D
> -			(struct completion *)msg->payload[3];
> -
> -		mutex_lock(&scif_info.conflock);
> -		scif_info.maxid =3D msg->payload[1];
> -		scif_info.total =3D msg->payload[2];
> -		complete_all(node_info);
> -		mutex_unlock(&scif_info.conflock);
> -	}
> -}
> -
> -static void
> -scif_msg_unknown(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	/* Bogus Node Qp Message? */
> -	dev_err(&scifdev->sdev->dev,
> -		"Unknown message 0x%xn scifdev->node 0x%x\n",
> -		msg->uop, scifdev->node);
> -}
> -
> -static void (*scif_intr_func[SCIF_MAX_MSG + 1])
> -	    (struct scif_dev *, struct scifmsg *msg) =3D {
> -	scif_msg_unknown,	/* Error */
> -	scif_init,		/* SCIF_INIT */
> -	scif_exit,		/* SCIF_EXIT */
> -	scif_exit_ack,		/* SCIF_EXIT_ACK */
> -	scif_node_add,		/* SCIF_NODE_ADD */
> -	scif_node_add_ack,	/* SCIF_NODE_ADD_ACK */
> -	scif_node_add_nack,	/* SCIF_NODE_ADD_NACK */
> -	scif_node_remove,	/* SCIF_NODE_REMOVE */
> -	scif_node_remove_ack,	/* SCIF_NODE_REMOVE_ACK */
> -	scif_cnctreq,		/* SCIF_CNCT_REQ */
> -	scif_cnctgnt,		/* SCIF_CNCT_GNT */
> -	scif_cnctgnt_ack,	/* SCIF_CNCT_GNTACK */
> -	scif_cnctgnt_nack,	/* SCIF_CNCT_GNTNACK */
> -	scif_cnctrej,		/* SCIF_CNCT_REJ */
> -	scif_discnct,		/* SCIF_DISCNCT */
> -	scif_discnt_ack,	/* SCIF_DISCNT_ACK */
> -	scif_clientsend,	/* SCIF_CLIENT_SENT */
> -	scif_clientrcvd,	/* SCIF_CLIENT_RCVD */
> -	scif_get_node_info_resp,/* SCIF_GET_NODE_INFO */
> -	scif_recv_reg,		/* SCIF_REGISTER */
> -	scif_recv_reg_ack,	/* SCIF_REGISTER_ACK */
> -	scif_recv_reg_nack,	/* SCIF_REGISTER_NACK */
> -	scif_recv_unreg,	/* SCIF_UNREGISTER */
> -	scif_recv_unreg_ack,	/* SCIF_UNREGISTER_ACK */
> -	scif_recv_unreg_nack,	/* SCIF_UNREGISTER_NACK */
> -	scif_alloc_req,		/* SCIF_ALLOC_REQ */
> -	scif_alloc_gnt_rej,	/* SCIF_ALLOC_GNT */
> -	scif_alloc_gnt_rej,	/* SCIF_ALLOC_REJ */
> -	scif_free_virt,		/* SCIF_FREE_VIRT */
> -	scif_recv_munmap,	/* SCIF_MUNMAP */
> -	scif_recv_mark,		/* SCIF_MARK */
> -	scif_recv_mark_resp,	/* SCIF_MARK_ACK */
> -	scif_recv_mark_resp,	/* SCIF_MARK_NACK */
> -	scif_recv_wait,		/* SCIF_WAIT */
> -	scif_recv_wait_resp,	/* SCIF_WAIT_ACK */
> -	scif_recv_wait_resp,	/* SCIF_WAIT_NACK */
> -	scif_recv_sig_local,	/* SCIF_SIG_LOCAL */
> -	scif_recv_sig_remote,	/* SCIF_SIG_REMOTE */
> -	scif_recv_sig_resp,	/* SCIF_SIG_ACK */
> -	scif_recv_sig_resp,	/* SCIF_SIG_NACK */
> -};
> -
> -static int scif_max_msg_id =3D SCIF_MAX_MSG;
> -/**
> - * scif_nodeqp_msg_handler() - Common handler for node messages
> - * @scifdev: Remote device to respond to
> - * @qp: Remote memory pointer
> - * @msg: The message to be handled.
> - *
> - * This routine calls the appropriate routine to handle a Node Qp
> - * message receipt
> - */
> -static void
> -scif_nodeqp_msg_handler(struct scif_dev *scifdev,
> -			struct scif_qp *qp, struct scifmsg *msg)
> -{
> -	scif_display_message(scifdev, msg, "Rcvd");
> -
> -	if (msg->uop > (u32)scif_max_msg_id) {
> -		/* Bogus Node Qp Message? */
> -		dev_err(&scifdev->sdev->dev,
> -			"Unknown message 0x%xn scifdev->node 0x%x\n",
> -			msg->uop, scifdev->node);
> -		return;
> -	}
> -
> -	scif_intr_func[msg->uop](scifdev, msg);
> -}
> -
> -/**
> - * scif_nodeqp_intrhandler() - Interrupt handler for node messages
> - * @scifdev:    Remote device to respond to
> - * @qp:         Remote memory pointer
> - *
> - * This routine is triggered by the interrupt mechanism.  It reads
> - * messages from the node queue RB and calls the Node QP Message
> handling
> - * routine.
> - */
> -void scif_nodeqp_intrhandler(struct scif_dev *scifdev, struct scif_qp *q=
p)
> -{
> -	struct scifmsg msg;
> -	int read_size;
> -
> -	do {
> -		read_size =3D scif_rb_get_next(&qp->inbound_q, &msg,
> sizeof(msg));
> -		if (!read_size)
> -			break;
> -		scif_nodeqp_msg_handler(scifdev, qp, &msg);
> -		/*
> -		 * The node queue pair is unmapped so skip the read pointer
> -		 * update after receipt of a SCIF_EXIT_ACK
> -		 */
> -		if (SCIF_EXIT_ACK =3D=3D msg.uop)
> -			break;
> -		scif_rb_update_read_ptr(&qp->inbound_q);
> -	} while (1);
> -}
> -
> -/**
> - * scif_loopb_wq_handler - Loopback Workqueue Handler.
> - * @unused: loop back work (unused)
> - *
> - * This work queue routine is invoked by the loopback work queue handler=
.
> - * It grabs the recv lock, dequeues any available messages from the head
> - * of the loopback message list, calls the node QP message handler,
> - * waits for it to return, then frees up this message and dequeues more
> - * elements of the list if available.
> - */
> -static void scif_loopb_wq_handler(struct work_struct *unused)
> -{
> -	struct scif_dev *scifdev =3D scif_info.loopb_dev;
> -	struct scif_qp *qp =3D scifdev->qpairs;
> -	struct scif_loopb_msg *msg;
> -
> -	do {
> -		msg =3D NULL;
> -		spin_lock(&qp->recv_lock);
> -		if (!list_empty(&scif_info.loopb_recv_q)) {
> -			msg =3D list_first_entry(&scif_info.loopb_recv_q,
> -					       struct scif_loopb_msg,
> -					       list);
> -			list_del(&msg->list);
> -		}
> -		spin_unlock(&qp->recv_lock);
> -
> -		if (msg) {
> -			scif_nodeqp_msg_handler(scifdev, qp, &msg->msg);
> -			kfree(msg);
> -		}
> -	} while (msg);
> -}
> -
> -/**
> - * scif_loopb_msg_handler() - Workqueue handler for loopback messages.
> - * @scifdev: SCIF device
> - * @qp: Queue pair.
> - *
> - * This work queue routine is triggered when a loopback message is recei=
ved.
> - *
> - * We need special handling for receiving Node Qp messages on a loopback
> SCIF
> - * device via two workqueues for receiving messages.
> - *
> - * The reason we need the extra workqueue which is not required with
> *normal*
> - * non-loopback SCIF devices is the potential classic deadlock described
> below:
> - *
> - * Thread A tries to send a message on a loopback SCIF device and blocks
> since
> - * there is no space in the RB while it has the send_lock held or anothe=
r
> - * lock called lock X for example.
> - *
> - * Thread B: The Loopback Node QP message receive workqueue receives
> the message
> - * and tries to send a message (eg an ACK) to the loopback SCIF device. =
It
> tries
> - * to grab the send lock again or lock X and deadlocks with Thread A. Th=
e RB
> - * cannot be drained any further due to this classic deadlock.
> - *
> - * In order to avoid deadlocks as mentioned above we have an extra level=
 of
> - * indirection achieved by having two workqueues.
> - * 1) The first workqueue whose handler is scif_loopb_msg_handler reads
> - * messages from the Node QP RB, adds them to a list and queues work for
> the
> - * second workqueue.
> - *
> - * 2) The second workqueue whose handler is scif_loopb_wq_handler
> dequeues
> - * messages from the list, handles them, frees up the memory and
> dequeues
> - * more elements from the list if possible.
> - */
> -int
> -scif_loopb_msg_handler(struct scif_dev *scifdev, struct scif_qp *qp)
> -{
> -	int read_size;
> -	struct scif_loopb_msg *msg;
> -
> -	do {
> -		msg =3D kmalloc(sizeof(*msg), GFP_KERNEL);
> -		if (!msg)
> -			return -ENOMEM;
> -		read_size =3D scif_rb_get_next(&qp->inbound_q, &msg->msg,
> -					     sizeof(struct scifmsg));
> -		if (read_size !=3D sizeof(struct scifmsg)) {
> -			kfree(msg);
> -			scif_rb_update_read_ptr(&qp->inbound_q);
> -			break;
> -		}
> -		spin_lock(&qp->recv_lock);
> -		list_add_tail(&msg->list, &scif_info.loopb_recv_q);
> -		spin_unlock(&qp->recv_lock);
> -		queue_work(scif_info.loopb_wq, &scif_info.loopb_work);
> -		scif_rb_update_read_ptr(&qp->inbound_q);
> -	} while (read_size =3D=3D sizeof(struct scifmsg));
> -	return read_size;
> -}
> -
> -/**
> - * scif_setup_loopback_qp - One time setup work for Loopback Node Qp.
> - * @scifdev: SCIF device
> - *
> - * Sets up the required loopback workqueues, queue pairs and ring buffer=
s
> - */
> -int scif_setup_loopback_qp(struct scif_dev *scifdev)
> -{
> -	int err =3D 0;
> -	void *local_q;
> -	struct scif_qp *qp;
> -
> -	err =3D scif_setup_intr_wq(scifdev);
> -	if (err)
> -		goto exit;
> -	INIT_LIST_HEAD(&scif_info.loopb_recv_q);
> -	snprintf(scif_info.loopb_wqname, sizeof(scif_info.loopb_wqname),
> -		 "SCIF LOOPB %d", scifdev->node);
> -	scif_info.loopb_wq =3D
> -		alloc_ordered_workqueue(scif_info.loopb_wqname, 0);
> -	if (!scif_info.loopb_wq) {
> -		err =3D -ENOMEM;
> -		goto destroy_intr;
> -	}
> -	INIT_WORK(&scif_info.loopb_work, scif_loopb_wq_handler);
> -	/* Allocate Self Qpair */
> -	scifdev->qpairs =3D kzalloc(sizeof(*scifdev->qpairs), GFP_KERNEL);
> -	if (!scifdev->qpairs) {
> -		err =3D -ENOMEM;
> -		goto destroy_loopb_wq;
> -	}
> -
> -	qp =3D scifdev->qpairs;
> -	qp->magic =3D SCIFEP_MAGIC;
> -	spin_lock_init(&qp->send_lock);
> -	spin_lock_init(&qp->recv_lock);
> -
> -	local_q =3D kzalloc(SCIF_NODE_QP_SIZE, GFP_KERNEL);
> -	if (!local_q) {
> -		err =3D -ENOMEM;
> -		goto free_qpairs;
> -	}
> -	/*
> -	 * For loopback the inbound_q and outbound_q are essentially the
> same
> -	 * since the Node sends a message on the loopback interface to the
> -	 * outbound_q which is then received on the inbound_q.
> -	 */
> -	scif_rb_init(&qp->outbound_q,
> -		     &qp->local_read,
> -		     &qp->local_write,
> -		     local_q, get_count_order(SCIF_NODE_QP_SIZE));
> -
> -	scif_rb_init(&qp->inbound_q,
> -		     &qp->local_read,
> -		     &qp->local_write,
> -		     local_q, get_count_order(SCIF_NODE_QP_SIZE));
> -	scif_info.nodeid =3D scifdev->node;
> -
> -	scif_peer_register_device(scifdev);
> -
> -	scif_info.loopb_dev =3D scifdev;
> -	return err;
> -free_qpairs:
> -	kfree(scifdev->qpairs);
> -destroy_loopb_wq:
> -	destroy_workqueue(scif_info.loopb_wq);
> -destroy_intr:
> -	scif_destroy_intr_wq(scifdev);
> -exit:
> -	return err;
> -}
> -
> -/**
> - * scif_destroy_loopback_qp - One time uninit work for Loopback Node Qp
> - * @scifdev: SCIF device
> - *
> - * Destroys the workqueues and frees up the Ring Buffer and Queue Pair
> memory.
> - */
> -int scif_destroy_loopback_qp(struct scif_dev *scifdev)
> -{
> -	scif_peer_unregister_device(scifdev);
> -	destroy_workqueue(scif_info.loopb_wq);
> -	scif_destroy_intr_wq(scifdev);
> -	kfree(scifdev->qpairs->outbound_q.rb_base);
> -	kfree(scifdev->qpairs);
> -	scifdev->sdev =3D NULL;
> -	scif_info.loopb_dev =3D NULL;
> -	return 0;
> -}
> -
> -void scif_destroy_p2p(struct scif_dev *scifdev)
> -{
> -	struct scif_dev *peer_dev;
> -	struct scif_p2p_info *p2p;
> -	struct list_head *pos, *tmp;
> -	int bd;
> -
> -	mutex_lock(&scif_info.conflock);
> -	/* Free P2P mappings in the given node for all its peer nodes */
> -	list_for_each_safe(pos, tmp, &scifdev->p2p) {
> -		p2p =3D list_entry(pos, struct scif_p2p_info, ppi_list);
> -		dma_unmap_sg(&scifdev->sdev->dev, p2p-
> >ppi_sg[SCIF_PPI_MMIO],
> -			     p2p->sg_nentries[SCIF_PPI_MMIO],
> -			     DMA_BIDIRECTIONAL);
> -		dma_unmap_sg(&scifdev->sdev->dev, p2p-
> >ppi_sg[SCIF_PPI_APER],
> -			     p2p->sg_nentries[SCIF_PPI_APER],
> -			     DMA_BIDIRECTIONAL);
> -		scif_p2p_freesg(p2p->ppi_sg[SCIF_PPI_MMIO]);
> -		scif_p2p_freesg(p2p->ppi_sg[SCIF_PPI_APER]);
> -		list_del(pos);
> -		kfree(p2p);
> -	}
> -
> -	/* Free P2P mapping created in the peer nodes for the given node */
> -	for (bd =3D SCIF_MGMT_NODE + 1; bd <=3D scif_info.maxid; bd++) {
> -		peer_dev =3D &scif_dev[bd];
> -		list_for_each_safe(pos, tmp, &peer_dev->p2p) {
> -			p2p =3D list_entry(pos, struct scif_p2p_info, ppi_list);
> -			if (p2p->ppi_peer_id =3D=3D scifdev->node) {
> -				dma_unmap_sg(&peer_dev->sdev->dev,
> -					     p2p->ppi_sg[SCIF_PPI_MMIO],
> -					     p2p->sg_nentries[SCIF_PPI_MMIO],
> -					     DMA_BIDIRECTIONAL);
> -				dma_unmap_sg(&peer_dev->sdev->dev,
> -					     p2p->ppi_sg[SCIF_PPI_APER],
> -					     p2p->sg_nentries[SCIF_PPI_APER],
> -					     DMA_BIDIRECTIONAL);
> -				scif_p2p_freesg(p2p-
> >ppi_sg[SCIF_PPI_MMIO]);
> -				scif_p2p_freesg(p2p-
> >ppi_sg[SCIF_PPI_APER]);
> -				list_del(pos);
> -				kfree(p2p);
> -			}
> -		}
> -	}
> -	mutex_unlock(&scif_info.conflock);
> -}
> diff --git a/drivers/misc/mic/scif/scif_nodeqp.h
> b/drivers/misc/mic/scif/scif_nodeqp.h
> deleted file mode 100644
> index 95896273138e..000000000000
> --- a/drivers/misc/mic/scif/scif_nodeqp.h
> +++ /dev/null
> @@ -1,221 +0,0 @@
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - * redistributing this file, you may do so under either license.
> - *
> - * GPL LICENSE SUMMARY
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * BSD LICENSE
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - * * Redistributions of source code must retain the above copyright
> - *   notice, this list of conditions and the following disclaimer.
> - * * Redistributions in binary form must reproduce the above copyright
> - *   notice, this list of conditions and the following disclaimer in
> - *   the documentation and/or other materials provided with the
> - *   distribution.
> - * * Neither the name of Intel Corporation nor the names of its
> - *   contributors may be used to endorse or promote products derived
> - *   from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
> THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> DAMAGE.
> - *
> - * Intel SCIF driver.
> - *
> - */
> -#ifndef SCIF_NODEQP
> -#define SCIF_NODEQP
> -
> -#include "scif_rb.h"
> -#include "scif_peer_bus.h"
> -
> -#define SCIF_INIT 1  /* First message sent to the peer node for discover=
y */
> -#define SCIF_EXIT 2  /* Last message from the peer informing intent to e=
xit
> */
> -#define SCIF_EXIT_ACK 3 /* Response to SCIF_EXIT message */
> -#define SCIF_NODE_ADD 4  /* Tell Online nodes a new node exits */
> -#define SCIF_NODE_ADD_ACK 5  /* Confirm to mgmt node sequence is
> finished */
> -#define SCIF_NODE_ADD_NACK 6 /* SCIF_NODE_ADD failed */
> -#define SCIF_NODE_REMOVE 7 /* Request to deactivate a SCIF node */
> -#define SCIF_NODE_REMOVE_ACK 8 /* Response to a SCIF_NODE_REMOVE
> message */
> -#define SCIF_CNCT_REQ 9  /* Phys addr of Request connection to a port */
> -#define SCIF_CNCT_GNT 10  /* Phys addr of new Grant connection request
> */
> -#define SCIF_CNCT_GNTACK 11  /* Error type Reject a connection request *=
/
> -#define SCIF_CNCT_GNTNACK 12  /* Error type Reject a connection request
> */
> -#define SCIF_CNCT_REJ 13  /* Error type Reject a connection request */
> -#define SCIF_DISCNCT 14 /* Notify peer that connection is being terminat=
ed
> */
> -#define SCIF_DISCNT_ACK 15 /* Notify peer that connection is being
> terminated */
> -#define SCIF_CLIENT_SENT 16 /* Notify the peer that data has been writte=
n
> */
> -#define SCIF_CLIENT_RCVD 17 /* Notify the peer that data has been read *=
/
> -#define SCIF_GET_NODE_INFO 18 /* Get current node mask from the mgmt
> node*/
> -#define SCIF_REGISTER 19 /* Tell peer about a new registered window */
> -#define SCIF_REGISTER_ACK 20 /* Notify peer about unregistration success
> */
> -#define SCIF_REGISTER_NACK 21 /* Notify peer about registration success =
*/
> -#define SCIF_UNREGISTER 22 /* Tell peer about unregistering a window */
> -#define SCIF_UNREGISTER_ACK 23 /* Notify peer about registration failure
> */
> -#define SCIF_UNREGISTER_NACK 24 /* Notify peer about unregistration
> failure */
> -#define SCIF_ALLOC_REQ 25 /* Request a mapped buffer */
> -#define SCIF_ALLOC_GNT 26 /* Notify peer about allocation success */
> -#define SCIF_ALLOC_REJ 27 /* Notify peer about allocation failure */
> -#define SCIF_FREE_VIRT 28 /* Free previously allocated virtual memory */
> -#define SCIF_MUNMAP 29 /* Acknowledgment for a SCIF_MMAP request */
> -#define SCIF_MARK 30 /* SCIF Remote Fence Mark Request */
> -#define SCIF_MARK_ACK 31 /* SCIF Remote Fence Mark Success */
> -#define SCIF_MARK_NACK 32 /* SCIF Remote Fence Mark Failure */
> -#define SCIF_WAIT 33 /* SCIF Remote Fence Wait Request */
> -#define SCIF_WAIT_ACK 34 /* SCIF Remote Fence Wait Success */
> -#define SCIF_WAIT_NACK 35 /* SCIF Remote Fence Wait Failure */
> -#define SCIF_SIG_LOCAL 36 /* SCIF Remote Fence Local Signal Request */
> -#define SCIF_SIG_REMOTE 37 /* SCIF Remote Fence Remote Signal Request
> */
> -#define SCIF_SIG_ACK 38 /* SCIF Remote Fence Remote Signal Success */
> -#define SCIF_SIG_NACK 39 /* SCIF Remote Fence Remote Signal Failure */
> -#define SCIF_MAX_MSG SCIF_SIG_NACK
> -
> -/*
> - * struct scifmsg - Node QP message format
> - *
> - * @src: Source information
> - * @dst: Destination information
> - * @uop: The message opcode
> - * @payload: Unique payload format for each message
> - */
> -struct scifmsg {
> -	struct scif_port_id src;
> -	struct scif_port_id dst;
> -	u32 uop;
> -	u64 payload[4];
> -} __packed;
> -
> -/*
> - * struct scif_allocmsg - Used with SCIF_ALLOC_REQ to request
> - * the remote note to allocate memory
> - *
> - * phys_addr: Physical address of the buffer
> - * vaddr: Virtual address of the buffer
> - * size: Size of the buffer
> - * state: Current state
> - * allocwq: wait queue for status
> - */
> -struct scif_allocmsg {
> -	dma_addr_t phys_addr;
> -	unsigned long vaddr;
> -	size_t size;
> -	enum scif_msg_state state;
> -	wait_queue_head_t allocwq;
> -};
> -
> -/*
> - * struct scif_qp - Node Queue Pair
> - *
> - * Interesting structure -- a little difficult because we can only
> - * write across the PCIe, so any r/w pointer we need to read is
> - * local. We only need to read the read pointer on the inbound_q
> - * and read the write pointer in the outbound_q
> - *
> - * @magic: Magic value to ensure the peer sees the QP correctly
> - * @outbound_q: The outbound ring buffer for sending messages
> - * @inbound_q: The inbound ring buffer for receiving messages
> - * @local_write: Local write index
> - * @local_read: Local read index
> - * @remote_qp: The remote queue pair
> - * @local_buf: DMA address of local ring buffer
> - * @local_qp: DMA address of the local queue pair data structure
> - * @remote_buf: DMA address of remote ring buffer
> - * @qp_state: QP state i.e. online or offline used for P2P
> - * @send_lock: synchronize access to outbound queue
> - * @recv_lock: Synchronize access to inbound queue
> - */
> -struct scif_qp {
> -	u64 magic;
> -#define SCIFEP_MAGIC 0x5c1f000000005c1fULL
> -	struct scif_rb outbound_q;
> -	struct scif_rb inbound_q;
> -
> -	u32 local_write __aligned(64);
> -	u32 local_read __aligned(64);
> -	struct scif_qp *remote_qp;
> -	dma_addr_t local_buf;
> -	dma_addr_t local_qp;
> -	dma_addr_t remote_buf;
> -	u32 qp_state;
> -#define SCIF_QP_OFFLINE 0xdead
> -#define SCIF_QP_ONLINE 0xc0de
> -	spinlock_t send_lock;
> -	spinlock_t recv_lock;
> -};
> -
> -/*
> - * struct scif_loopb_msg - An element in the loopback Node QP message li=
st.
> - *
> - * @msg - The SCIF node QP message
> - * @list - link in the list of messages
> - */
> -struct scif_loopb_msg {
> -	struct scifmsg msg;
> -	struct list_head list;
> -};
> -
> -int scif_nodeqp_send(struct scif_dev *scifdev, struct scifmsg *msg);
> -int _scif_nodeqp_send(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_nodeqp_intrhandler(struct scif_dev *scifdev, struct scif_qp *q=
p);
> -int scif_loopb_msg_handler(struct scif_dev *scifdev, struct scif_qp *qp)=
;
> -int scif_setup_qp(struct scif_dev *scifdev);
> -int scif_qp_response(phys_addr_t phys, struct scif_dev *dev);
> -int scif_setup_qp_connect(struct scif_qp *qp, dma_addr_t *qp_offset,
> -			  int local_size, struct scif_dev *scifdev);
> -int scif_setup_qp_accept(struct scif_qp *qp, dma_addr_t *qp_offset,
> -			 dma_addr_t phys, int local_size,
> -			 struct scif_dev *scifdev);
> -int scif_setup_qp_connect_response(struct scif_dev *scifdev,
> -				   struct scif_qp *qp, u64 payload);
> -int scif_setup_loopback_qp(struct scif_dev *scifdev);
> -int scif_destroy_loopback_qp(struct scif_dev *scifdev);
> -void scif_poll_qp_state(struct work_struct *work);
> -void scif_destroy_p2p(struct scif_dev *scifdev);
> -void scif_send_exit(struct scif_dev *scifdev);
> -static inline struct device *scif_get_peer_dev(struct scif_dev *scifdev)
> -{
> -	struct scif_peer_dev *spdev;
> -	struct device *spdev_ret;
> -
> -	rcu_read_lock();
> -	spdev =3D rcu_dereference(scifdev->spdev);
> -	if (spdev)
> -		spdev_ret =3D get_device(&spdev->dev);
> -	else
> -		spdev_ret =3D ERR_PTR(-ENODEV);
> -	rcu_read_unlock();
> -	return spdev_ret;
> -}
> -
> -static inline void scif_put_peer_dev(struct device *dev)
> -{
> -	put_device(dev);
> -}
> -#endif  /* SCIF_NODEQP */
> diff --git a/drivers/misc/mic/scif/scif_peer_bus.c
> b/drivers/misc/mic/scif/scif_peer_bus.c
> deleted file mode 100644
> index 6d608308bb60..000000000000
> --- a/drivers/misc/mic/scif/scif_peer_bus.c
> +++ /dev/null
> @@ -1,175 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include "scif_main.h"
> -#include "../bus/scif_bus.h"
> -#include "scif_peer_bus.h"
> -
> -static inline struct scif_peer_dev *
> -dev_to_scif_peer(struct device *dev)
> -{
> -	return container_of(dev, struct scif_peer_dev, dev);
> -}
> -
> -struct bus_type scif_peer_bus =3D {
> -	.name  =3D "scif_peer_bus",
> -};
> -
> -static void scif_peer_release_dev(struct device *d)
> -{
> -	struct scif_peer_dev *sdev =3D dev_to_scif_peer(d);
> -	struct scif_dev *scifdev =3D &scif_dev[sdev->dnode];
> -
> -	scif_cleanup_scifdev(scifdev);
> -	kfree(sdev);
> -}
> -
> -static int scif_peer_initialize_device(struct scif_dev *scifdev)
> -{
> -	struct scif_peer_dev *spdev;
> -	int ret;
> -
> -	spdev =3D kzalloc(sizeof(*spdev), GFP_KERNEL);
> -	if (!spdev) {
> -		ret =3D -ENOMEM;
> -		goto err;
> -	}
> -
> -	spdev->dev.parent =3D scifdev->sdev->dev.parent;
> -	spdev->dev.release =3D scif_peer_release_dev;
> -	spdev->dnode =3D scifdev->node;
> -	spdev->dev.bus =3D &scif_peer_bus;
> -	dev_set_name(&spdev->dev, "scif_peer-dev%u", spdev->dnode);
> -
> -	device_initialize(&spdev->dev);
> -	get_device(&spdev->dev);
> -	rcu_assign_pointer(scifdev->spdev, spdev);
> -
> -	mutex_lock(&scif_info.conflock);
> -	scif_info.total++;
> -	scif_info.maxid =3D max_t(u32, spdev->dnode, scif_info.maxid);
> -	mutex_unlock(&scif_info.conflock);
> -	return 0;
> -err:
> -	dev_err(&scifdev->sdev->dev,
> -		"dnode %d: initialize_device rc %d\n", scifdev->node, ret);
> -	return ret;
> -}
> -
> -static int scif_peer_add_device(struct scif_dev *scifdev)
> -{
> -	struct scif_peer_dev *spdev =3D rcu_dereference(scifdev->spdev);
> -	char pool_name[16];
> -	int ret;
> -
> -	ret =3D device_add(&spdev->dev);
> -	put_device(&spdev->dev);
> -	if (ret) {
> -		dev_err(&scifdev->sdev->dev,
> -			"dnode %d: peer device_add failed\n", scifdev-
> >node);
> -		goto put_spdev;
> -	}
> -
> -	scnprintf(pool_name, sizeof(pool_name), "scif-%d", spdev->dnode);
> -	scifdev->signal_pool =3D dmam_pool_create(pool_name, &scifdev-
> >sdev->dev,
> -						sizeof(struct scif_status), 1,
> -						0);
> -	if (!scifdev->signal_pool) {
> -		dev_err(&scifdev->sdev->dev,
> -			"dnode %d: dmam_pool_create failed\n", scifdev-
> >node);
> -		ret =3D -ENOMEM;
> -		goto del_spdev;
> -	}
> -	dev_dbg(&spdev->dev, "Added peer dnode %d\n", spdev->dnode);
> -	return 0;
> -del_spdev:
> -	device_del(&spdev->dev);
> -put_spdev:
> -	RCU_INIT_POINTER(scifdev->spdev, NULL);
> -	synchronize_rcu();
> -	put_device(&spdev->dev);
> -
> -	mutex_lock(&scif_info.conflock);
> -	scif_info.total--;
> -	mutex_unlock(&scif_info.conflock);
> -	return ret;
> -}
> -
> -void scif_add_peer_device(struct work_struct *work)
> -{
> -	struct scif_dev *scifdev =3D container_of(work, struct scif_dev,
> -						peer_add_work);
> -
> -	scif_peer_add_device(scifdev);
> -}
> -
> -/*
> - * Peer device registration is split into a device_initialize and a devi=
ce_add.
> - * The reason for doing this is as follows: First, peer device registrat=
ion
> - * itself cannot be done in the message processing thread and must be
> delegated
> - * to another workqueue, otherwise if SCIF client probe, called during p=
eer
> - * device registration, calls scif_connect(..), it will block the messag=
e
> - * processing thread causing a deadlock. Next, device_initialize is done=
 in the
> - * "top-half" message processing thread and device_add in the "bottom-
> half"
> - * workqueue. If this is not done, SCIF_CNCT_REQ message processing
> executing
> - * concurrently with SCIF_INIT message processing is unable to get a
> reference
> - * on the peer device, thereby failing the connect request.
> - */
> -void scif_peer_register_device(struct scif_dev *scifdev)
> -{
> -	int ret;
> -
> -	mutex_lock(&scifdev->lock);
> -	ret =3D scif_peer_initialize_device(scifdev);
> -	if (ret)
> -		goto exit;
> -	schedule_work(&scifdev->peer_add_work);
> -exit:
> -	mutex_unlock(&scifdev->lock);
> -}
> -
> -int scif_peer_unregister_device(struct scif_dev *scifdev)
> -{
> -	struct scif_peer_dev *spdev;
> -
> -	mutex_lock(&scifdev->lock);
> -	/* Flush work to ensure device register is complete */
> -	flush_work(&scifdev->peer_add_work);
> -
> -	/*
> -	 * Continue holding scifdev->lock since theoretically
> unregister_device
> -	 * can be called simultaneously from multiple threads
> -	 */
> -	spdev =3D rcu_dereference(scifdev->spdev);
> -	if (!spdev) {
> -		mutex_unlock(&scifdev->lock);
> -		return -ENODEV;
> -	}
> -
> -	RCU_INIT_POINTER(scifdev->spdev, NULL);
> -	synchronize_rcu();
> -	mutex_unlock(&scifdev->lock);
> -
> -	dev_dbg(&spdev->dev, "Removing peer dnode %d\n", spdev-
> >dnode);
> -	device_unregister(&spdev->dev);
> -
> -	mutex_lock(&scif_info.conflock);
> -	scif_info.total--;
> -	mutex_unlock(&scif_info.conflock);
> -	return 0;
> -}
> -
> -int scif_peer_bus_init(void)
> -{
> -	return bus_register(&scif_peer_bus);
> -}
> -
> -void scif_peer_bus_exit(void)
> -{
> -	bus_unregister(&scif_peer_bus);
> -}
> diff --git a/drivers/misc/mic/scif/scif_peer_bus.h
> b/drivers/misc/mic/scif/scif_peer_bus.h
> deleted file mode 100644
> index 2ea4c51c18c1..000000000000
> --- a/drivers/misc/mic/scif/scif_peer_bus.h
> +++ /dev/null
> @@ -1,23 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#ifndef _SCIF_PEER_BUS_H_
> -#define _SCIF_PEER_BUS_H_
> -
> -#include <linux/device.h>
> -#include <linux/mic_common.h>
> -#include <linux/scif.h>
> -
> -struct scif_dev;
> -
> -void scif_add_peer_device(struct work_struct *work);
> -void scif_peer_register_device(struct scif_dev *sdev);
> -int scif_peer_unregister_device(struct scif_dev *scifdev);
> -int scif_peer_bus_init(void);
> -void scif_peer_bus_exit(void);
> -#endif /* _SCIF_PEER_BUS_H */
> diff --git a/drivers/misc/mic/scif/scif_ports.c
> b/drivers/misc/mic/scif/scif_ports.c
> deleted file mode 100644
> index 4bdb5ef9a139..000000000000
> --- a/drivers/misc/mic/scif/scif_ports.c
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include <linux/idr.h>
> -
> -#include "scif_main.h"
> -
> -#define SCIF_PORT_COUNT	0x10000	/* Ports available */
> -
> -struct idr scif_ports;
> -
> -/**
> - * struct scif_port - SCIF port information
> - *
> - * @ref_cnt:  Reference count since there can be multiple endpoints
> - *	      created via scif_accept(..) simultaneously using a port.
> - */
> -struct scif_port {
> -	int ref_cnt;
> -};
> -
> -/**
> - * __scif_get_port - Reserve a specified port # for SCIF and add it
> - * to the global list.
> - * @start: lowest port # to be reserved (inclusive).
> - * @end:   highest port # to be reserved (exclusive).
> - *
> - * @return : Allocated SCIF port #, or -ENOSPC if port unavailable.
> - *		On memory allocation failure, returns -ENOMEM.
> - */
> -static int __scif_get_port(int start, int end)
> -{
> -	int id;
> -	struct scif_port *port =3D kzalloc(sizeof(*port), GFP_ATOMIC);
> -
> -	if (!port)
> -		return -ENOMEM;
> -	spin_lock(&scif_info.port_lock);
> -	id =3D idr_alloc(&scif_ports, port, start, end, GFP_ATOMIC);
> -	if (id >=3D 0)
> -		port->ref_cnt++;
> -	spin_unlock(&scif_info.port_lock);
> -	return id;
> -}
> -
> -/**
> - * scif_rsrv_port - Reserve a specified port # for SCIF.
> - * @port : port # to be reserved.
> - *
> - * @return : Allocated SCIF port #, or -ENOSPC if port unavailable.
> - *		On memory allocation failure, returns -ENOMEM.
> - */
> -int scif_rsrv_port(u16 port)
> -{
> -	return __scif_get_port(port, port + 1);
> -}
> -
> -/**
> - * scif_get_new_port - Get and reserve any port # for SCIF in the range
> - *			SCIF_PORT_RSVD + 1 to SCIF_PORT_COUNT - 1.
> - *
> - * @return : Allocated SCIF port #, or -ENOSPC if no ports available.
> - *		On memory allocation failure, returns -ENOMEM.
> - */
> -int scif_get_new_port(void)
> -{
> -	return __scif_get_port(SCIF_PORT_RSVD + 1, SCIF_PORT_COUNT);
> -}
> -
> -/**
> - * scif_get_port - Increment the reference count for a SCIF port
> - * @id : SCIF port
> - *
> - * @return : None
> - */
> -void scif_get_port(u16 id)
> -{
> -	struct scif_port *port;
> -
> -	if (!id)
> -		return;
> -	spin_lock(&scif_info.port_lock);
> -	port =3D idr_find(&scif_ports, id);
> -	if (port)
> -		port->ref_cnt++;
> -	spin_unlock(&scif_info.port_lock);
> -}
> -
> -/**
> - * scif_put_port - Release a reserved SCIF port
> - * @id : SCIF port to be released.
> - *
> - * @return : None
> - */
> -void scif_put_port(u16 id)
> -{
> -	struct scif_port *port;
> -
> -	if (!id)
> -		return;
> -	spin_lock(&scif_info.port_lock);
> -	port =3D idr_find(&scif_ports, id);
> -	if (port) {
> -		port->ref_cnt--;
> -		if (!port->ref_cnt) {
> -			idr_remove(&scif_ports, id);
> -			kfree(port);
> -		}
> -	}
> -	spin_unlock(&scif_info.port_lock);
> -}
> diff --git a/drivers/misc/mic/scif/scif_rb.c b/drivers/misc/mic/scif/scif=
_rb.c
> deleted file mode 100644
> index e425882ae06d..000000000000
> --- a/drivers/misc/mic/scif/scif_rb.c
> +++ /dev/null
> @@ -1,240 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include <linux/circ_buf.h>
> -#include <linux/types.h>
> -#include <linux/io.h>
> -#include <linux/errno.h>
> -
> -#include "scif_rb.h"
> -
> -#define scif_rb_ring_cnt(head, tail, size) CIRC_CNT(head, tail, size)
> -#define scif_rb_ring_space(head, tail, size) CIRC_SPACE(head, tail, size=
)
> -
> -/**
> - * scif_rb_init - Initializes the ring buffer
> - * @rb: ring buffer
> - * @read_ptr: A pointer to the read offset
> - * @write_ptr: A pointer to the write offset
> - * @rb_base: A pointer to the base of the ring buffer
> - * @size: The size of the ring buffer in powers of two
> - */
> -void scif_rb_init(struct scif_rb *rb, u32 *read_ptr, u32 *write_ptr,
> -		  void *rb_base, u8 size)
> -{
> -	rb->rb_base =3D rb_base;
> -	rb->size =3D (1 << size);
> -	rb->read_ptr =3D read_ptr;
> -	rb->write_ptr =3D write_ptr;
> -	rb->current_read_offset =3D *read_ptr;
> -	rb->current_write_offset =3D *write_ptr;
> -}
> -
> -/* Copies a message to the ring buffer -- handles the wrap around case *=
/
> -static void memcpy_torb(struct scif_rb *rb, void *header,
> -			void *msg, u32 size)
> -{
> -	u32 size1, size2;
> -
> -	if (header + size >=3D rb->rb_base + rb->size) {
> -		/* Need to call two copies if it wraps around */
> -		size1 =3D (u32)(rb->rb_base + rb->size - header);
> -		size2 =3D size - size1;
> -		memcpy_toio((void __iomem __force *)header, msg, size1);
> -		memcpy_toio((void __iomem __force *)rb->rb_base,
> -			    msg + size1, size2);
> -	} else {
> -		memcpy_toio((void __iomem __force *)header, msg, size);
> -	}
> -}
> -
> -/* Copies a message from the ring buffer -- handles the wrap around case=
 */
> -static void memcpy_fromrb(struct scif_rb *rb, void *header,
> -			  void *msg, u32 size)
> -{
> -	u32 size1, size2;
> -
> -	if (header + size >=3D rb->rb_base + rb->size) {
> -		/* Need to call two copies if it wraps around */
> -		size1 =3D (u32)(rb->rb_base + rb->size - header);
> -		size2 =3D size - size1;
> -		memcpy_fromio(msg, (void __iomem __force *)header,
> size1);
> -		memcpy_fromio(msg + size1,
> -			      (void __iomem __force *)rb->rb_base, size2);
> -	} else {
> -		memcpy_fromio(msg, (void __iomem __force *)header, size);
> -	}
> -}
> -
> -/**
> - * scif_rb_space - Query space available for writing to the RB
> - * @rb: ring buffer
> - *
> - * Return: size available for writing to RB in bytes.
> - */
> -u32 scif_rb_space(struct scif_rb *rb)
> -{
> -	rb->current_read_offset =3D *rb->read_ptr;
> -	/*
> -	 * Update from the HW read pointer only once the peer has exposed
> the
> -	 * new empty slot. This barrier is paired with the memory barrier
> -	 * scif_rb_update_read_ptr()
> -	 */
> -	mb();
> -	return scif_rb_ring_space(rb->current_write_offset,
> -				  rb->current_read_offset, rb->size);
> -}
> -
> -/**
> - * scif_rb_write - Write a message to the RB
> - * @rb: ring buffer
> - * @msg: buffer to send the message.  Must be at least size bytes long
> - * @size: the size (in bytes) to be copied to the RB
> - *
> - * This API does not block if there isn't enough space in the RB.
> - * Returns: 0 on success or -ENOMEM on failure
> - */
> -int scif_rb_write(struct scif_rb *rb, void *msg, u32 size)
> -{
> -	void *header;
> -
> -	if (scif_rb_space(rb) < size)
> -		return -ENOMEM;
> -	header =3D rb->rb_base + rb->current_write_offset;
> -	memcpy_torb(rb, header, msg, size);
> -	/*
> -	 * Wait until scif_rb_commit(). Update the local ring
> -	 * buffer data, not the shared data until commit.
> -	 */
> -	rb->current_write_offset =3D
> -		(rb->current_write_offset + size) & (rb->size - 1);
> -	return 0;
> -}
> -
> -/**
> - * scif_rb_commit - To submit the message to let the peer fetch it
> - * @rb: ring buffer
> - */
> -void scif_rb_commit(struct scif_rb *rb)
> -{
> -	/*
> -	 * We must ensure ordering between the all the data committed
> -	 * previously before we expose the new message to the peer by
> -	 * updating the write_ptr. This write barrier is paired with
> -	 * the read barrier in scif_rb_count(..)
> -	 */
> -	wmb();
> -	WRITE_ONCE(*rb->write_ptr, rb->current_write_offset);
> -#ifdef CONFIG_INTEL_MIC_CARD
> -	/*
> -	 * X100 Si bug: For the case where a Core is performing an EXT_WR
> -	 * followed by a Doorbell Write, the Core must perform two EXT_WR
> to the
> -	 * same address with the same data before it does the Doorbell
> Write.
> -	 * This way, if ordering is violated for the Interrupt Message, it will
> -	 * fall just behind the first Posted associated with the first EXT_WR.
> -	 */
> -	WRITE_ONCE(*rb->write_ptr, rb->current_write_offset);
> -#endif
> -}
> -
> -/**
> - * scif_rb_get - To get next message from the ring buffer
> - * @rb: ring buffer
> - * @size: Number of bytes to be read
> - *
> - * Return: NULL if no bytes to be read from the ring buffer, otherwise t=
he
> - *	pointer to the next byte
> - */
> -static void *scif_rb_get(struct scif_rb *rb, u32 size)
> -{
> -	void *header =3D NULL;
> -
> -	if (scif_rb_count(rb, size) >=3D size)
> -		header =3D rb->rb_base + rb->current_read_offset;
> -	return header;
> -}
> -
> -/*
> - * scif_rb_get_next - Read from ring buffer.
> - * @rb: ring buffer
> - * @msg: buffer to hold the message.  Must be at least size bytes long
> - * @size: Number of bytes to be read
> - *
> - * Return: number of bytes read if available bytes are >=3D size, otherw=
ise
> - * returns zero.
> - */
> -u32 scif_rb_get_next(struct scif_rb *rb, void *msg, u32 size)
> -{
> -	void *header =3D NULL;
> -	int read_size =3D 0;
> -
> -	header =3D scif_rb_get(rb, size);
> -	if (header) {
> -		u32 next_cmd_offset =3D
> -			(rb->current_read_offset + size) & (rb->size - 1);
> -
> -		read_size =3D size;
> -		rb->current_read_offset =3D next_cmd_offset;
> -		memcpy_fromrb(rb, header, msg, size);
> -	}
> -	return read_size;
> -}
> -
> -/**
> - * scif_rb_update_read_ptr
> - * @rb: ring buffer
> - */
> -void scif_rb_update_read_ptr(struct scif_rb *rb)
> -{
> -	u32 new_offset;
> -
> -	new_offset =3D rb->current_read_offset;
> -	/*
> -	 * We must ensure ordering between the all the data committed or
> read
> -	 * previously before we expose the empty slot to the peer by
> updating
> -	 * the read_ptr. This barrier is paired with the memory barrier in
> -	 * scif_rb_space(..)
> -	 */
> -	mb();
> -	WRITE_ONCE(*rb->read_ptr, new_offset);
> -#ifdef CONFIG_INTEL_MIC_CARD
> -	/*
> -	 * X100 Si Bug: For the case where a Core is performing an EXT_WR
> -	 * followed by a Doorbell Write, the Core must perform two EXT_WR
> to the
> -	 * same address with the same data before it does the Doorbell
> Write.
> -	 * This way, if ordering is violated for the Interrupt Message, it will
> -	 * fall just behind the first Posted associated with the first EXT_WR.
> -	 */
> -	WRITE_ONCE(*rb->read_ptr, new_offset);
> -#endif
> -}
> -
> -/**
> - * scif_rb_count
> - * @rb: ring buffer
> - * @size: Number of bytes expected to be read
> - *
> - * Return: number of bytes that can be read from the RB
> - */
> -u32 scif_rb_count(struct scif_rb *rb, u32 size)
> -{
> -	if (scif_rb_ring_cnt(rb->current_write_offset,
> -			     rb->current_read_offset,
> -			     rb->size) < size) {
> -		rb->current_write_offset =3D *rb->write_ptr;
> -		/*
> -		 * Update from the HW write pointer if empty only once the
> peer
> -		 * has exposed the new message. This read barrier is paired
> -		 * with the write barrier in scif_rb_commit(..)
> -		 */
> -		smp_rmb();
> -	}
> -	return scif_rb_ring_cnt(rb->current_write_offset,
> -				rb->current_read_offset,
> -				rb->size);
> -}
> diff --git a/drivers/misc/mic/scif/scif_rb.h b/drivers/misc/mic/scif/scif=
_rb.h
> deleted file mode 100644
> index 166dffe3093d..000000000000
> --- a/drivers/misc/mic/scif/scif_rb.h
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - * redistributing this file, you may do so under either license.
> - *
> - * GPL LICENSE SUMMARY
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * BSD LICENSE
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - * * Redistributions of source code must retain the above copyright
> - *   notice, this list of conditions and the following disclaimer.
> - * * Redistributions in binary form must reproduce the above copyright
> - *   notice, this list of conditions and the following disclaimer in
> - *   the documentation and/or other materials provided with the
> - *   distribution.
> - * * Neither the name of Intel Corporation nor the names of its
> - *   contributors may be used to endorse or promote products derived
> - *   from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
> THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> DAMAGE.
> - *
> - * Intel SCIF driver.
> - */
> -#ifndef SCIF_RB_H
> -#define SCIF_RB_H
> -/*
> - * This file describes a general purpose, byte based ring buffer. Writer=
s to
> the
> - * ring buffer need to synchronize using a lock. The same is true for re=
aders,
> - * although in practice, the ring buffer has a single reader. It is lock=
less
> - * between producer and consumer so it can handle being used across the
> PCIe
> - * bus. The ring buffer ensures that there are no reads across the PCIe =
bus
> for
> - * performance reasons. Two of these are used to form a single bidirecti=
onal
> - * queue-pair across PCIe.
> - */
> -/*
> - * struct scif_rb - SCIF Ring Buffer
> - *
> - * @rb_base: The base of the memory used for storing RB messages
> - * @read_ptr: Pointer to the read offset
> - * @write_ptr: Pointer to the write offset
> - * @size: Size of the memory in rb_base
> - * @current_read_offset: Cached read offset for performance
> - * @current_write_offset: Cached write offset for performance
> - */
> -struct scif_rb {
> -	void *rb_base;
> -	u32 *read_ptr;
> -	u32 *write_ptr;
> -	u32 size;
> -	u32 current_read_offset;
> -	u32 current_write_offset;
> -};
> -
> -/* methods used by both */
> -void scif_rb_init(struct scif_rb *rb, u32 *read_ptr, u32 *write_ptr,
> -		  void *rb_base, u8 size);
> -/* writer only methods */
> -/* write a new command, then scif_rb_commit() */
> -int scif_rb_write(struct scif_rb *rb, void *msg, u32 size);
> -/* after write(), then scif_rb_commit() */
> -void scif_rb_commit(struct scif_rb *rb);
> -/* query space available for writing to a RB. */
> -u32 scif_rb_space(struct scif_rb *rb);
> -
> -/* reader only methods */
> -/* read a new message from the ring buffer of size bytes */
> -u32 scif_rb_get_next(struct scif_rb *rb, void *msg, u32 size);
> -/* update the read pointer so that the space can be reused */
> -void scif_rb_update_read_ptr(struct scif_rb *rb);
> -/* count the number of bytes that can be read */
> -u32 scif_rb_count(struct scif_rb *rb, u32 size);
> -#endif
> diff --git a/drivers/misc/mic/scif/scif_rma.c
> b/drivers/misc/mic/scif/scif_rma.c
> deleted file mode 100644
> index 18fb9d8b8a4b..000000000000
> --- a/drivers/misc/mic/scif/scif_rma.c
> +++ /dev/null
> @@ -1,1760 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include <linux/intel-iommu.h>
> -#include <linux/pagemap.h>
> -#include <linux/sched/mm.h>
> -#include <linux/sched/signal.h>
> -
> -#include "scif_main.h"
> -#include "scif_map.h"
> -
> -/* Used to skip ulimit checks for registrations with SCIF_MAP_KERNEL fla=
g */
> -#define SCIF_MAP_ULIMIT 0x40
> -
> -bool scif_ulimit_check =3D 1;
> -
> -/**
> - * scif_rma_ep_init:
> - * @ep: end point
> - *
> - * Initialize RMA per EP data structures.
> - */
> -void scif_rma_ep_init(struct scif_endpt *ep)
> -{
> -	struct scif_endpt_rma_info *rma =3D &ep->rma_info;
> -
> -	mutex_init(&rma->rma_lock);
> -	init_iova_domain(&rma->iovad, PAGE_SIZE, SCIF_IOVA_START_PFN);
> -	spin_lock_init(&rma->tc_lock);
> -	mutex_init(&rma->mmn_lock);
> -	INIT_LIST_HEAD(&rma->reg_list);
> -	INIT_LIST_HEAD(&rma->remote_reg_list);
> -	atomic_set(&rma->tw_refcount, 0);
> -	atomic_set(&rma->tcw_refcount, 0);
> -	atomic_set(&rma->tcw_total_pages, 0);
> -	atomic_set(&rma->fence_refcount, 0);
> -
> -	rma->async_list_del =3D 0;
> -	rma->dma_chan =3D NULL;
> -	INIT_LIST_HEAD(&rma->mmn_list);
> -	INIT_LIST_HEAD(&rma->vma_list);
> -	init_waitqueue_head(&rma->markwq);
> -}
> -
> -/**
> - * scif_rma_ep_can_uninit:
> - * @ep: end point
> - *
> - * Returns 1 if an endpoint can be uninitialized and 0 otherwise.
> - */
> -int scif_rma_ep_can_uninit(struct scif_endpt *ep)
> -{
> -	int ret =3D 0;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	/* Destroy RMA Info only if both lists are empty */
> -	if (list_empty(&ep->rma_info.reg_list) &&
> -	    list_empty(&ep->rma_info.remote_reg_list) &&
> -	    list_empty(&ep->rma_info.mmn_list) &&
> -	    !atomic_read(&ep->rma_info.tw_refcount) &&
> -	    !atomic_read(&ep->rma_info.tcw_refcount) &&
> -	    !atomic_read(&ep->rma_info.fence_refcount))
> -		ret =3D 1;
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	return ret;
> -}
> -
> -/**
> - * scif_create_pinned_pages:
> - * @nr_pages: number of pages in window
> - * @prot: read/write protection
> - *
> - * Allocate and prepare a set of pinned pages.
> - */
> -static struct scif_pinned_pages *
> -scif_create_pinned_pages(int nr_pages, int prot)
> -{
> -	struct scif_pinned_pages *pin;
> -
> -	might_sleep();
> -	pin =3D scif_zalloc(sizeof(*pin));
> -	if (!pin)
> -		goto error;
> -
> -	pin->pages =3D scif_zalloc(nr_pages * sizeof(*pin->pages));
> -	if (!pin->pages)
> -		goto error_free_pinned_pages;
> -
> -	pin->prot =3D prot;
> -	pin->magic =3D SCIFEP_MAGIC;
> -	return pin;
> -
> -error_free_pinned_pages:
> -	scif_free(pin, sizeof(*pin));
> -error:
> -	return NULL;
> -}
> -
> -/**
> - * scif_destroy_pinned_pages:
> - * @pin: A set of pinned pages.
> - *
> - * Deallocate resources for pinned pages.
> - */
> -static int scif_destroy_pinned_pages(struct scif_pinned_pages *pin)
> -{
> -	int j;
> -	int writeable =3D pin->prot & SCIF_PROT_WRITE;
> -	int kernel =3D SCIF_MAP_KERNEL & pin->map_flags;
> -
> -	if (kernel) {
> -		for (j =3D 0; j < pin->nr_pages; j++) {
> -			if (pin->pages[j] && !kernel) {
> -				if (writeable)
> -					set_page_dirty_lock(pin->pages[j]);
> -				put_page(pin->pages[j]);
> -			}
> -		}
> -	} else
> -		unpin_user_pages_dirty_lock(pin->pages, pin->nr_pages,
> -					    writeable);
> -	scif_free(pin->pages,
> -		  pin->nr_pages * sizeof(*pin->pages));
> -	scif_free(pin, sizeof(*pin));
> -	return 0;
> -}
> -
> -/*
> - * scif_create_window:
> - * @ep: end point
> - * @nr_pages: number of pages
> - * @offset: registration offset
> - * @temp: true if a temporary window is being created
> - *
> - * Allocate and prepare a self registration window.
> - */
> -struct scif_window *scif_create_window(struct scif_endpt *ep, int nr_pag=
es,
> -				       s64 offset, bool temp)
> -{
> -	struct scif_window *window;
> -
> -	might_sleep();
> -	window =3D scif_zalloc(sizeof(*window));
> -	if (!window)
> -		goto error;
> -
> -	window->dma_addr =3D scif_zalloc(nr_pages * sizeof(*window-
> >dma_addr));
> -	if (!window->dma_addr)
> -		goto error_free_window;
> -
> -	window->num_pages =3D scif_zalloc(nr_pages * sizeof(*window-
> >num_pages));
> -	if (!window->num_pages)
> -		goto error_free_window;
> -
> -	window->offset =3D offset;
> -	window->ep =3D (u64)ep;
> -	window->magic =3D SCIFEP_MAGIC;
> -	window->reg_state =3D OP_IDLE;
> -	init_waitqueue_head(&window->regwq);
> -	window->unreg_state =3D OP_IDLE;
> -	init_waitqueue_head(&window->unregwq);
> -	INIT_LIST_HEAD(&window->list);
> -	window->type =3D SCIF_WINDOW_SELF;
> -	window->temp =3D temp;
> -	return window;
> -
> -error_free_window:
> -	scif_free(window->dma_addr,
> -		  nr_pages * sizeof(*window->dma_addr));
> -	scif_free(window, sizeof(*window));
> -error:
> -	return NULL;
> -}
> -
> -/**
> - * scif_destroy_incomplete_window:
> - * @ep: end point
> - * @window: registration window
> - *
> - * Deallocate resources for self window.
> - */
> -static void scif_destroy_incomplete_window(struct scif_endpt *ep,
> -					   struct scif_window *window)
> -{
> -	int err;
> -	int nr_pages =3D window->nr_pages;
> -	struct scif_allocmsg *alloc =3D &window->alloc_handle;
> -	struct scifmsg msg;
> -
> -retry:
> -	/* Wait for a SCIF_ALLOC_GNT/REJ message */
> -	err =3D wait_event_timeout(alloc->allocwq,
> -				 alloc->state !=3D OP_IN_PROGRESS,
> -				 SCIF_NODE_ALIVE_TIMEOUT);
> -	if (!err && scifdev_alive(ep))
> -		goto retry;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	if (alloc->state =3D=3D OP_COMPLETED) {
> -		msg.uop =3D SCIF_FREE_VIRT;
> -		msg.src =3D ep->port;
> -		msg.payload[0] =3D ep->remote_ep;
> -		msg.payload[1] =3D window->alloc_handle.vaddr;
> -		msg.payload[2] =3D (u64)window;
> -		msg.payload[3] =3D SCIF_REGISTER;
> -		_scif_nodeqp_send(ep->remote_dev, &msg);
> -	}
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -
> -	scif_free_window_offset(ep, window, window->offset);
> -	scif_free(window->dma_addr, nr_pages * sizeof(*window-
> >dma_addr));
> -	scif_free(window->num_pages, nr_pages * sizeof(*window-
> >num_pages));
> -	scif_free(window, sizeof(*window));
> -}
> -
> -/**
> - * scif_unmap_window:
> - * @remote_dev: SCIF remote device
> - * @window: registration window
> - *
> - * Delete any DMA mappings created for a registered self window
> - */
> -void scif_unmap_window(struct scif_dev *remote_dev, struct scif_window
> *window)
> -{
> -	int j;
> -
> -	if (scif_is_iommu_enabled() && !scifdev_self(remote_dev)) {
> -		if (window->st) {
> -			dma_unmap_sg(&remote_dev->sdev->dev,
> -				     window->st->sgl, window->st->nents,
> -				     DMA_BIDIRECTIONAL);
> -			sg_free_table(window->st);
> -			kfree(window->st);
> -			window->st =3D NULL;
> -		}
> -	} else {
> -		for (j =3D 0; j < window->nr_contig_chunks; j++) {
> -			if (window->dma_addr[j]) {
> -				scif_unmap_single(window->dma_addr[j],
> -						  remote_dev,
> -						  window->num_pages[j] <<
> -						  PAGE_SHIFT);
> -				window->dma_addr[j] =3D 0x0;
> -			}
> -		}
> -	}
> -}
> -
> -static inline struct mm_struct *__scif_acquire_mm(void)
> -{
> -	if (scif_ulimit_check)
> -		return get_task_mm(current);
> -	return NULL;
> -}
> -
> -static inline void __scif_release_mm(struct mm_struct *mm)
> -{
> -	if (mm)
> -		mmput(mm);
> -}
> -
> -static inline int
> -__scif_dec_pinned_vm_lock(struct mm_struct *mm,
> -			  int nr_pages)
> -{
> -	if (!mm || !nr_pages || !scif_ulimit_check)
> -		return 0;
> -
> -	atomic64_sub(nr_pages, &mm->pinned_vm);
> -	return 0;
> -}
> -
> -static inline int __scif_check_inc_pinned_vm(struct mm_struct *mm,
> -					     int nr_pages)
> -{
> -	unsigned long locked, lock_limit;
> -
> -	if (!mm || !nr_pages || !scif_ulimit_check)
> -		return 0;
> -
> -	lock_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> -	locked =3D atomic64_add_return(nr_pages, &mm->pinned_vm);
> -
> -	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
> -		atomic64_sub(nr_pages, &mm->pinned_vm);
> -		dev_err(scif_info.mdev.this_device,
> -			"locked(%lu) > lock_limit(%lu)\n",
> -			locked, lock_limit);
> -		return -ENOMEM;
> -	}
> -	return 0;
> -}
> -
> -/**
> - * scif_destroy_window:
> - * @ep: end point
> - * @window: registration window
> - *
> - * Deallocate resources for self window.
> - */
> -int scif_destroy_window(struct scif_endpt *ep, struct scif_window *windo=
w)
> -{
> -	int j;
> -	struct scif_pinned_pages *pinned_pages =3D window->pinned_pages;
> -	int nr_pages =3D window->nr_pages;
> -
> -	might_sleep();
> -	if (!window->temp && window->mm) {
> -		__scif_dec_pinned_vm_lock(window->mm, window-
> >nr_pages);
> -		__scif_release_mm(window->mm);
> -		window->mm =3D NULL;
> -	}
> -
> -	scif_free_window_offset(ep, window, window->offset);
> -	scif_unmap_window(ep->remote_dev, window);
> -	/*
> -	 * Decrement references for this set of pinned pages from
> -	 * this window.
> -	 */
> -	j =3D atomic_sub_return(1, &pinned_pages->ref_count);
> -	if (j < 0)
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d incorrect ref count %d\n",
> -			__func__, __LINE__, j);
> -	/*
> -	 * If the ref count for pinned_pages is zero then someone
> -	 * has already called scif_unpin_pages() for it and we should
> -	 * destroy the page cache.
> -	 */
> -	if (!j)
> -		scif_destroy_pinned_pages(window->pinned_pages);
> -	scif_free(window->dma_addr, nr_pages * sizeof(*window-
> >dma_addr));
> -	scif_free(window->num_pages, nr_pages * sizeof(*window-
> >num_pages));
> -	window->magic =3D 0;
> -	scif_free(window, sizeof(*window));
> -	return 0;
> -}
> -
> -/**
> - * scif_create_remote_lookup:
> - * @remote_dev: SCIF remote device
> - * @window: remote window
> - *
> - * Allocate and prepare lookup entries for the remote
> - * end to copy over the physical addresses.
> - * Returns 0 on success and appropriate errno on failure.
> - */
> -static int scif_create_remote_lookup(struct scif_dev *remote_dev,
> -				     struct scif_window *window)
> -{
> -	int i, j, err =3D 0;
> -	int nr_pages =3D window->nr_pages;
> -	bool vmalloc_dma_phys, vmalloc_num_pages;
> -
> -	might_sleep();
> -	/* Map window */
> -	err =3D scif_map_single(&window->mapped_offset,
> -			      window, remote_dev, sizeof(*window));
> -	if (err)
> -		goto error_window;
> -
> -	/* Compute the number of lookup entries. 21 =3D=3D 2MB Shift */
> -	window->nr_lookup =3D ALIGN(nr_pages * PAGE_SIZE,
> -					((2) * 1024 * 1024)) >> 21;
> -
> -	window->dma_addr_lookup.lookup =3D
> -		scif_alloc_coherent(&window->dma_addr_lookup.offset,
> -				    remote_dev, window->nr_lookup *
> -				    sizeof(*window-
> >dma_addr_lookup.lookup),
> -				    GFP_KERNEL | __GFP_ZERO);
> -	if (!window->dma_addr_lookup.lookup) {
> -		err =3D -ENOMEM;
> -		goto error_window;
> -	}
> -
> -	window->num_pages_lookup.lookup =3D
> -		scif_alloc_coherent(&window->num_pages_lookup.offset,
> -				    remote_dev, window->nr_lookup *
> -				    sizeof(*window-
> >num_pages_lookup.lookup),
> -				    GFP_KERNEL | __GFP_ZERO);
> -	if (!window->num_pages_lookup.lookup) {
> -		err =3D -ENOMEM;
> -		goto error_window;
> -	}
> -
> -	vmalloc_dma_phys =3D is_vmalloc_addr(&window->dma_addr[0]);
> -	vmalloc_num_pages =3D is_vmalloc_addr(&window->num_pages[0]);
> -
> -	/* Now map each of the pages containing physical addresses */
> -	for (i =3D 0, j =3D 0; i < nr_pages; i +=3D SCIF_NR_ADDR_IN_PAGE, j++) =
{
> -		err =3D scif_map_page(&window->dma_addr_lookup.lookup[j],
> -				    vmalloc_dma_phys ?
> -				    vmalloc_to_page(&window->dma_addr[i]) :
> -				    virt_to_page(&window->dma_addr[i]),
> -				    remote_dev);
> -		if (err)
> -			goto error_window;
> -		err =3D scif_map_page(&window-
> >num_pages_lookup.lookup[j],
> -				    vmalloc_num_pages ?
> -				    vmalloc_to_page(&window-
> >num_pages[i]) :
> -				    virt_to_page(&window->num_pages[i]),
> -				    remote_dev);
> -		if (err)
> -			goto error_window;
> -	}
> -	return 0;
> -error_window:
> -	return err;
> -}
> -
> -/**
> - * scif_destroy_remote_lookup:
> - * @remote_dev: SCIF remote device
> - * @window: remote window
> - *
> - * Destroy lookup entries used for the remote
> - * end to copy over the physical addresses.
> - */
> -static void scif_destroy_remote_lookup(struct scif_dev *remote_dev,
> -				       struct scif_window *window)
> -{
> -	int i, j;
> -
> -	if (window->nr_lookup) {
> -		struct scif_rma_lookup *lup =3D &window->dma_addr_lookup;
> -		struct scif_rma_lookup *npup =3D &window-
> >num_pages_lookup;
> -
> -		for (i =3D 0, j =3D 0; i < window->nr_pages;
> -			i +=3D SCIF_NR_ADDR_IN_PAGE, j++) {
> -			if (lup->lookup && lup->lookup[j])
> -				scif_unmap_single(lup->lookup[j],
> -						  remote_dev,
> -						  PAGE_SIZE);
> -			if (npup->lookup && npup->lookup[j])
> -				scif_unmap_single(npup->lookup[j],
> -						  remote_dev,
> -						  PAGE_SIZE);
> -		}
> -		if (lup->lookup)
> -			scif_free_coherent(lup->lookup, lup->offset,
> -					   remote_dev, window->nr_lookup *
> -					   sizeof(*lup->lookup));
> -		if (npup->lookup)
> -			scif_free_coherent(npup->lookup, npup->offset,
> -					   remote_dev, window->nr_lookup *
> -					   sizeof(*npup->lookup));
> -		if (window->mapped_offset)
> -			scif_unmap_single(window->mapped_offset,
> -					  remote_dev, sizeof(*window));
> -		window->nr_lookup =3D 0;
> -	}
> -}
> -
> -/**
> - * scif_create_remote_window:
> - * @scifdev:  SCIF device
> - * @nr_pages: number of pages in window
> - *
> - * Allocate and prepare a remote registration window.
> - */
> -static struct scif_window *
> -scif_create_remote_window(struct scif_dev *scifdev, int nr_pages)
> -{
> -	struct scif_window *window;
> -
> -	might_sleep();
> -	window =3D scif_zalloc(sizeof(*window));
> -	if (!window)
> -		goto error_ret;
> -
> -	window->magic =3D SCIFEP_MAGIC;
> -	window->nr_pages =3D nr_pages;
> -
> -	window->dma_addr =3D scif_zalloc(nr_pages * sizeof(*window-
> >dma_addr));
> -	if (!window->dma_addr)
> -		goto error_window;
> -
> -	window->num_pages =3D scif_zalloc(nr_pages *
> -					sizeof(*window->num_pages));
> -	if (!window->num_pages)
> -		goto error_window;
> -
> -	if (scif_create_remote_lookup(scifdev, window))
> -		goto error_window;
> -
> -	window->type =3D SCIF_WINDOW_PEER;
> -	window->unreg_state =3D OP_IDLE;
> -	INIT_LIST_HEAD(&window->list);
> -	return window;
> -error_window:
> -	scif_destroy_remote_window(window);
> -error_ret:
> -	return NULL;
> -}
> -
> -/**
> - * scif_destroy_remote_window:
> - * @window: remote registration window
> - *
> - * Deallocate resources for remote window.
> - */
> -void
> -scif_destroy_remote_window(struct scif_window *window)
> -{
> -	scif_free(window->dma_addr, window->nr_pages *
> -		  sizeof(*window->dma_addr));
> -	scif_free(window->num_pages, window->nr_pages *
> -		  sizeof(*window->num_pages));
> -	window->magic =3D 0;
> -	scif_free(window, sizeof(*window));
> -}
> -
> -/**
> - * scif_iommu_map: create DMA mappings if the IOMMU is enabled
> - * @remote_dev: SCIF remote device
> - * @window: remote registration window
> - *
> - * Map the physical pages using dma_map_sg(..) and then detect the
> number
> - * of contiguous DMA mappings allocated
> - */
> -static int scif_iommu_map(struct scif_dev *remote_dev,
> -			  struct scif_window *window)
> -{
> -	struct scatterlist *sg;
> -	int i, err;
> -	scif_pinned_pages_t pin =3D window->pinned_pages;
> -
> -	window->st =3D kzalloc(sizeof(*window->st), GFP_KERNEL);
> -	if (!window->st)
> -		return -ENOMEM;
> -
> -	err =3D sg_alloc_table(window->st, window->nr_pages, GFP_KERNEL);
> -	if (err)
> -		return err;
> -
> -	for_each_sg(window->st->sgl, sg, window->st->nents, i)
> -		sg_set_page(sg, pin->pages[i], PAGE_SIZE, 0x0);
> -
> -	err =3D dma_map_sg(&remote_dev->sdev->dev, window->st->sgl,
> -			 window->st->nents, DMA_BIDIRECTIONAL);
> -	if (!err)
> -		return -ENOMEM;
> -	/* Detect contiguous ranges of DMA mappings */
> -	sg =3D window->st->sgl;
> -	for (i =3D 0; sg; i++) {
> -		dma_addr_t last_da;
> -
> -		window->dma_addr[i] =3D sg_dma_address(sg);
> -		window->num_pages[i] =3D sg_dma_len(sg) >> PAGE_SHIFT;
> -		last_da =3D sg_dma_address(sg) + sg_dma_len(sg);
> -		while ((sg =3D sg_next(sg)) && sg_dma_address(sg) =3D=3D last_da)
> {
> -			window->num_pages[i] +=3D
> -				(sg_dma_len(sg) >> PAGE_SHIFT);
> -			last_da =3D window->dma_addr[i] +
> -				sg_dma_len(sg);
> -		}
> -		window->nr_contig_chunks++;
> -	}
> -	return 0;
> -}
> -
> -/**
> - * scif_map_window:
> - * @remote_dev: SCIF remote device
> - * @window: self registration window
> - *
> - * Map pages of a window into the aperture/PCI.
> - * Also determine addresses required for DMA.
> - */
> -int
> -scif_map_window(struct scif_dev *remote_dev, struct scif_window
> *window)
> -{
> -	int i, j, k, err =3D 0, nr_contig_pages;
> -	scif_pinned_pages_t pin;
> -	phys_addr_t phys_prev, phys_curr;
> -
> -	might_sleep();
> -
> -	pin =3D window->pinned_pages;
> -
> -	if (intel_iommu_enabled && !scifdev_self(remote_dev))
> -		return scif_iommu_map(remote_dev, window);
> -
> -	for (i =3D 0, j =3D 0; i < window->nr_pages; i +=3D nr_contig_pages, j+=
+) {
> -		phys_prev =3D page_to_phys(pin->pages[i]);
> -		nr_contig_pages =3D 1;
> -
> -		/* Detect physically contiguous chunks */
> -		for (k =3D i + 1; k < window->nr_pages; k++) {
> -			phys_curr =3D page_to_phys(pin->pages[k]);
> -			if (phys_curr !=3D (phys_prev + PAGE_SIZE))
> -				break;
> -			phys_prev =3D phys_curr;
> -			nr_contig_pages++;
> -		}
> -		window->num_pages[j] =3D nr_contig_pages;
> -		window->nr_contig_chunks++;
> -		if (scif_is_mgmt_node()) {
> -			/*
> -			 * Management node has to deal with SMPT on X100
> and
> -			 * hence the DMA mapping is required
> -			 */
> -			err =3D scif_map_single(&window->dma_addr[j],
> -					      phys_to_virt(page_to_phys(
> -							   pin->pages[i])),
> -					      remote_dev,
> -					      nr_contig_pages << PAGE_SHIFT);
> -			if (err)
> -				return err;
> -		} else {
> -			window->dma_addr[j] =3D page_to_phys(pin->pages[i]);
> -		}
> -	}
> -	return err;
> -}
> -
> -/**
> - * scif_send_scif_unregister:
> - * @ep: end point
> - * @window: self registration window
> - *
> - * Send a SCIF_UNREGISTER message.
> - */
> -static int scif_send_scif_unregister(struct scif_endpt *ep,
> -				     struct scif_window *window)
> -{
> -	struct scifmsg msg;
> -
> -	msg.uop =3D SCIF_UNREGISTER;
> -	msg.src =3D ep->port;
> -	msg.payload[0] =3D window->alloc_handle.vaddr;
> -	msg.payload[1] =3D (u64)window;
> -	return scif_nodeqp_send(ep->remote_dev, &msg);
> -}
> -
> -/**
> - * scif_unregister_window:
> - * @window: self registration window
> - *
> - * Send an unregistration request and wait for a response.
> - */
> -int scif_unregister_window(struct scif_window *window)
> -{
> -	int err =3D 0;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)window->ep;
> -	bool send_msg =3D false;
> -
> -	might_sleep();
> -	switch (window->unreg_state) {
> -	case OP_IDLE:
> -	{
> -		window->unreg_state =3D OP_IN_PROGRESS;
> -		send_msg =3D true;
> -	}
> -		fallthrough;
> -	case OP_IN_PROGRESS:
> -	{
> -		scif_get_window(window, 1);
> -		mutex_unlock(&ep->rma_info.rma_lock);
> -		if (send_msg) {
> -			err =3D scif_send_scif_unregister(ep, window);
> -			if (err) {
> -				window->unreg_state =3D OP_COMPLETED;
> -				goto done;
> -			}
> -		} else {
> -			/* Return ENXIO since unregistration is in progress */
> -			mutex_lock(&ep->rma_info.rma_lock);
> -			return -ENXIO;
> -		}
> -retry:
> -		/* Wait for a SCIF_UNREGISTER_(N)ACK message */
> -		err =3D wait_event_timeout(window->unregwq,
> -					 window->unreg_state !=3D
> OP_IN_PROGRESS,
> -					 SCIF_NODE_ALIVE_TIMEOUT);
> -		if (!err && scifdev_alive(ep))
> -			goto retry;
> -		if (!err) {
> -			err =3D -ENODEV;
> -			window->unreg_state =3D OP_COMPLETED;
> -			dev_err(scif_info.mdev.this_device,
> -				"%s %d err %d\n", __func__, __LINE__, err);
> -		}
> -		if (err > 0)
> -			err =3D 0;
> -done:
> -		mutex_lock(&ep->rma_info.rma_lock);
> -		scif_put_window(window, 1);
> -		break;
> -	}
> -	case OP_FAILED:
> -	{
> -		if (!scifdev_alive(ep)) {
> -			err =3D -ENODEV;
> -			window->unreg_state =3D OP_COMPLETED;
> -		}
> -		break;
> -	}
> -	case OP_COMPLETED:
> -		break;
> -	default:
> -		err =3D -ENODEV;
> -	}
> -
> -	if (window->unreg_state =3D=3D OP_COMPLETED && window->ref_count)
> -		scif_put_window(window, window->nr_pages);
> -
> -	if (!window->ref_count) {
> -		atomic_inc(&ep->rma_info.tw_refcount);
> -		list_del_init(&window->list);
> -		scif_free_window_offset(ep, window, window->offset);
> -		mutex_unlock(&ep->rma_info.rma_lock);
> -		if ((!!(window->pinned_pages->map_flags &
> SCIF_MAP_KERNEL)) &&
> -		    scifdev_alive(ep)) {
> -			scif_drain_dma_intr(ep->remote_dev->sdev,
> -					    ep->rma_info.dma_chan);
> -		} else {
> -			if (!__scif_dec_pinned_vm_lock(window->mm,
> -						       window->nr_pages)) {
> -				__scif_release_mm(window->mm);
> -				window->mm =3D NULL;
> -			}
> -		}
> -		scif_queue_for_cleanup(window, &scif_info.rma);
> -		mutex_lock(&ep->rma_info.rma_lock);
> -	}
> -	return err;
> -}
> -
> -/**
> - * scif_send_alloc_request:
> - * @ep: end point
> - * @window: self registration window
> - *
> - * Send a remote window allocation request
> - */
> -static int scif_send_alloc_request(struct scif_endpt *ep,
> -				   struct scif_window *window)
> -{
> -	struct scifmsg msg;
> -	struct scif_allocmsg *alloc =3D &window->alloc_handle;
> -
> -	/* Set up the Alloc Handle */
> -	alloc->state =3D OP_IN_PROGRESS;
> -	init_waitqueue_head(&alloc->allocwq);
> -
> -	/* Send out an allocation request */
> -	msg.uop =3D SCIF_ALLOC_REQ;
> -	msg.payload[1] =3D window->nr_pages;
> -	msg.payload[2] =3D (u64)&window->alloc_handle;
> -	return _scif_nodeqp_send(ep->remote_dev, &msg);
> -}
> -
> -/**
> - * scif_prep_remote_window:
> - * @ep: end point
> - * @window: self registration window
> - *
> - * Send a remote window allocation request, wait for an allocation respo=
nse,
> - * and prepares the remote window by copying over the page lists
> - */
> -static int scif_prep_remote_window(struct scif_endpt *ep,
> -				   struct scif_window *window)
> -{
> -	struct scifmsg msg;
> -	struct scif_window *remote_window;
> -	struct scif_allocmsg *alloc =3D &window->alloc_handle;
> -	dma_addr_t *dma_phys_lookup, *tmp, *num_pages_lookup, *tmp1;
> -	int i =3D 0, j =3D 0;
> -	int nr_contig_chunks, loop_nr_contig_chunks;
> -	int remaining_nr_contig_chunks, nr_lookup;
> -	int err, map_err;
> -
> -	map_err =3D scif_map_window(ep->remote_dev, window);
> -	if (map_err)
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d map_err %d\n", __func__, __LINE__,
> map_err);
> -	remaining_nr_contig_chunks =3D window->nr_contig_chunks;
> -	nr_contig_chunks =3D window->nr_contig_chunks;
> -retry:
> -	/* Wait for a SCIF_ALLOC_GNT/REJ message */
> -	err =3D wait_event_timeout(alloc->allocwq,
> -				 alloc->state !=3D OP_IN_PROGRESS,
> -				 SCIF_NODE_ALIVE_TIMEOUT);
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	/* Synchronize with the thread waking up allocwq */
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	if (!err && scifdev_alive(ep))
> -		goto retry;
> -
> -	if (!err)
> -		err =3D -ENODEV;
> -
> -	if (err > 0)
> -		err =3D 0;
> -	else
> -		return err;
> -
> -	/* Bail out. The remote end rejected this request */
> -	if (alloc->state =3D=3D OP_FAILED)
> -		return -ENOMEM;
> -
> -	if (map_err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, map_err);
> -		msg.uop =3D SCIF_FREE_VIRT;
> -		msg.src =3D ep->port;
> -		msg.payload[0] =3D ep->remote_ep;
> -		msg.payload[1] =3D window->alloc_handle.vaddr;
> -		msg.payload[2] =3D (u64)window;
> -		msg.payload[3] =3D SCIF_REGISTER;
> -		spin_lock(&ep->lock);
> -		if (ep->state =3D=3D SCIFEP_CONNECTED)
> -			err =3D _scif_nodeqp_send(ep->remote_dev, &msg);
> -		else
> -			err =3D -ENOTCONN;
> -		spin_unlock(&ep->lock);
> -		return err;
> -	}
> -
> -	remote_window =3D scif_ioremap(alloc->phys_addr, sizeof(*window),
> -				     ep->remote_dev);
> -
> -	/* Compute the number of lookup entries. 21 =3D=3D 2MB Shift */
> -	nr_lookup =3D ALIGN(nr_contig_chunks, SCIF_NR_ADDR_IN_PAGE)
> -			  >> ilog2(SCIF_NR_ADDR_IN_PAGE);
> -
> -	dma_phys_lookup =3D
> -		scif_ioremap(remote_window->dma_addr_lookup.offset,
> -			     nr_lookup *
> -			     sizeof(*remote_window-
> >dma_addr_lookup.lookup),
> -			     ep->remote_dev);
> -	num_pages_lookup =3D
> -		scif_ioremap(remote_window->num_pages_lookup.offset,
> -			     nr_lookup *
> -			     sizeof(*remote_window-
> >num_pages_lookup.lookup),
> -			     ep->remote_dev);
> -
> -	while (remaining_nr_contig_chunks) {
> -		loop_nr_contig_chunks =3D min_t(int,
> remaining_nr_contig_chunks,
> -					      (int)SCIF_NR_ADDR_IN_PAGE);
> -		/* #1/2 - Copy  physical addresses over to the remote side */
> -
> -		/* #2/2 - Copy DMA addresses (addresses that are fed into
> the
> -		 * DMA engine) We transfer bus addresses which are then
> -		 * converted into a MIC physical address on the remote
> -		 * side if it is a MIC, if the remote node is a mgmt node we
> -		 * transfer the MIC physical address
> -		 */
> -		tmp =3D scif_ioremap(dma_phys_lookup[j],
> -				   loop_nr_contig_chunks *
> -				   sizeof(*window->dma_addr),
> -				   ep->remote_dev);
> -		tmp1 =3D scif_ioremap(num_pages_lookup[j],
> -				    loop_nr_contig_chunks *
> -				    sizeof(*window->num_pages),
> -				    ep->remote_dev);
> -		if (scif_is_mgmt_node()) {
> -			memcpy_toio((void __force __iomem *)tmp,
> -				    &window->dma_addr[i],
> loop_nr_contig_chunks
> -				    * sizeof(*window->dma_addr));
> -			memcpy_toio((void __force __iomem *)tmp1,
> -				    &window->num_pages[i],
> loop_nr_contig_chunks
> -				    * sizeof(*window->num_pages));
> -		} else {
> -			if (scifdev_is_p2p(ep->remote_dev)) {
> -				/*
> -				 * add remote node's base address for this
> node
> -				 * to convert it into a MIC address
> -				 */
> -				int m;
> -				dma_addr_t dma_addr;
> -
> -				for (m =3D 0; m < loop_nr_contig_chunks; m++)
> {
> -					dma_addr =3D window->dma_addr[i +
> m] +
> -						ep->remote_dev->base_addr;
> -					writeq(dma_addr,
> -					       (void __force __iomem
> *)&tmp[m]);
> -				}
> -				memcpy_toio((void __force __iomem *)tmp1,
> -					    &window->num_pages[i],
> -					    loop_nr_contig_chunks
> -					    * sizeof(*window->num_pages));
> -			} else {
> -				/* Mgmt node or loopback - transfer DMA
> -				 * addresses as is, this is the same as a
> -				 * MIC physical address (we use the
> dma_addr
> -				 * and not the phys_addr array since the
> -				 * phys_addr is only setup if there is a mmap()
> -				 * request from the mgmt node)
> -				 */
> -				memcpy_toio((void __force __iomem *)tmp,
> -					    &window->dma_addr[i],
> -					    loop_nr_contig_chunks *
> -					    sizeof(*window->dma_addr));
> -				memcpy_toio((void __force __iomem *)tmp1,
> -					    &window->num_pages[i],
> -					    loop_nr_contig_chunks *
> -					    sizeof(*window->num_pages));
> -			}
> -		}
> -		remaining_nr_contig_chunks -=3D loop_nr_contig_chunks;
> -		i +=3D loop_nr_contig_chunks;
> -		j++;
> -		scif_iounmap(tmp, loop_nr_contig_chunks *
> -			     sizeof(*window->dma_addr), ep->remote_dev);
> -		scif_iounmap(tmp1, loop_nr_contig_chunks *
> -			     sizeof(*window->num_pages), ep->remote_dev);
> -	}
> -
> -	/* Prepare the remote window for the peer */
> -	remote_window->peer_window =3D (u64)window;
> -	remote_window->offset =3D window->offset;
> -	remote_window->prot =3D window->prot;
> -	remote_window->nr_contig_chunks =3D nr_contig_chunks;
> -	remote_window->ep =3D ep->remote_ep;
> -	scif_iounmap(num_pages_lookup,
> -		     nr_lookup *
> -		     sizeof(*remote_window->num_pages_lookup.lookup),
> -		     ep->remote_dev);
> -	scif_iounmap(dma_phys_lookup,
> -		     nr_lookup *
> -		     sizeof(*remote_window->dma_addr_lookup.lookup),
> -		     ep->remote_dev);
> -	scif_iounmap(remote_window, sizeof(*remote_window), ep-
> >remote_dev);
> -	window->peer_window =3D alloc->vaddr;
> -	return err;
> -}
> -
> -/**
> - * scif_send_scif_register:
> - * @ep: end point
> - * @window: self registration window
> - *
> - * Send a SCIF_REGISTER message if EP is connected and wait for a
> - * SCIF_REGISTER_(N)ACK message else send a SCIF_FREE_VIRT
> - * message so that the peer can free its remote window allocated earlier=
.
> - */
> -static int scif_send_scif_register(struct scif_endpt *ep,
> -				   struct scif_window *window)
> -{
> -	int err =3D 0;
> -	struct scifmsg msg;
> -
> -	msg.src =3D ep->port;
> -	msg.payload[0] =3D ep->remote_ep;
> -	msg.payload[1] =3D window->alloc_handle.vaddr;
> -	msg.payload[2] =3D (u64)window;
> -	spin_lock(&ep->lock);
> -	if (ep->state =3D=3D SCIFEP_CONNECTED) {
> -		msg.uop =3D SCIF_REGISTER;
> -		window->reg_state =3D OP_IN_PROGRESS;
> -		err =3D _scif_nodeqp_send(ep->remote_dev, &msg);
> -		spin_unlock(&ep->lock);
> -		if (!err) {
> -retry:
> -			/* Wait for a SCIF_REGISTER_(N)ACK message */
> -			err =3D wait_event_timeout(window->regwq,
> -						 window->reg_state !=3D
> -						 OP_IN_PROGRESS,
> -
> SCIF_NODE_ALIVE_TIMEOUT);
> -			if (!err && scifdev_alive(ep))
> -				goto retry;
> -			err =3D !err ? -ENODEV : 0;
> -			if (window->reg_state =3D=3D OP_FAILED)
> -				err =3D -ENOTCONN;
> -		}
> -	} else {
> -		msg.uop =3D SCIF_FREE_VIRT;
> -		msg.payload[3] =3D SCIF_REGISTER;
> -		err =3D _scif_nodeqp_send(ep->remote_dev, &msg);
> -		spin_unlock(&ep->lock);
> -		if (!err)
> -			err =3D -ENOTCONN;
> -	}
> -	return err;
> -}
> -
> -/**
> - * scif_get_window_offset:
> - * @ep: end point descriptor
> - * @flags: flags
> - * @offset: offset hint
> - * @num_pages: number of pages
> - * @out_offset: computed offset returned by reference.
> - *
> - * Compute/Claim a new offset for this EP.
> - */
> -int scif_get_window_offset(struct scif_endpt *ep, int flags, s64 offset,
> -			   int num_pages, s64 *out_offset)
> -{
> -	s64 page_index;
> -	struct iova *iova_ptr;
> -	int err =3D 0;
> -
> -	if (flags & SCIF_MAP_FIXED) {
> -		page_index =3D SCIF_IOVA_PFN(offset);
> -		iova_ptr =3D reserve_iova(&ep->rma_info.iovad, page_index,
> -					page_index + num_pages - 1);
> -		if (!iova_ptr)
> -			err =3D -EADDRINUSE;
> -	} else {
> -		iova_ptr =3D alloc_iova(&ep->rma_info.iovad, num_pages,
> -				      SCIF_DMA_63BIT_PFN - 1, 0);
> -		if (!iova_ptr)
> -			err =3D -ENOMEM;
> -	}
> -	if (!err)
> -		*out_offset =3D (iova_ptr->pfn_lo) << PAGE_SHIFT;
> -	return err;
> -}
> -
> -/**
> - * scif_free_window_offset:
> - * @ep: end point descriptor
> - * @window: registration window
> - * @offset: Offset to be freed
> - *
> - * Free offset for this EP. The callee is supposed to grab
> - * the RMA mutex before calling this API.
> - */
> -void scif_free_window_offset(struct scif_endpt *ep,
> -			     struct scif_window *window, s64 offset)
> -{
> -	if ((window && !window->offset_freed) || !window) {
> -		free_iova(&ep->rma_info.iovad, offset >> PAGE_SHIFT);
> -		if (window)
> -			window->offset_freed =3D true;
> -	}
> -}
> -
> -/**
> - * scif_alloc_req: Respond to SCIF_ALLOC_REQ interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Remote side is requesting a memory allocation.
> - */
> -void scif_alloc_req(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	int err;
> -	struct scif_window *window =3D NULL;
> -	int nr_pages =3D msg->payload[1];
> -
> -	window =3D scif_create_remote_window(scifdev, nr_pages);
> -	if (!window) {
> -		err =3D -ENOMEM;
> -		goto error;
> -	}
> -
> -	/* The peer's allocation request is granted */
> -	msg->uop =3D SCIF_ALLOC_GNT;
> -	msg->payload[0] =3D (u64)window;
> -	msg->payload[1] =3D window->mapped_offset;
> -	err =3D scif_nodeqp_send(scifdev, msg);
> -	if (err)
> -		scif_destroy_remote_window(window);
> -	return;
> -error:
> -	/* The peer's allocation request is rejected */
> -	dev_err(&scifdev->sdev->dev,
> -		"%s %d error %d alloc_ptr %p nr_pages 0x%x\n",
> -		__func__, __LINE__, err, window, nr_pages);
> -	msg->uop =3D SCIF_ALLOC_REJ;
> -	scif_nodeqp_send(scifdev, msg);
> -}
> -
> -/**
> - * scif_alloc_gnt_rej: Respond to SCIF_ALLOC_GNT/REJ interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Remote side responded to a memory allocation.
> - */
> -void scif_alloc_gnt_rej(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_allocmsg *handle =3D (struct scif_allocmsg *)msg-
> >payload[2];
> -	struct scif_window *window =3D container_of(handle, struct
> scif_window,
> -						  alloc_handle);
> -	struct scif_endpt *ep =3D (struct scif_endpt *)window->ep;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	handle->vaddr =3D msg->payload[0];
> -	handle->phys_addr =3D msg->payload[1];
> -	if (msg->uop =3D=3D SCIF_ALLOC_GNT)
> -		handle->state =3D OP_COMPLETED;
> -	else
> -		handle->state =3D OP_FAILED;
> -	wake_up(&handle->allocwq);
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -}
> -
> -/**
> - * scif_free_virt: Respond to SCIF_FREE_VIRT interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Free up memory kmalloc'd earlier.
> - */
> -void scif_free_virt(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_window *window =3D (struct scif_window *)msg-
> >payload[1];
> -
> -	scif_destroy_remote_window(window);
> -}
> -
> -static void
> -scif_fixup_aper_base(struct scif_dev *dev, struct scif_window *window)
> -{
> -	int j;
> -	struct scif_hw_dev *sdev =3D dev->sdev;
> -	phys_addr_t apt_base =3D 0;
> -
> -	/*
> -	 * Add the aperture base if the DMA address is not card relative
> -	 * since the DMA addresses need to be an offset into the bar
> -	 */
> -	if (!scifdev_self(dev) && window->type =3D=3D SCIF_WINDOW_PEER &&
> -	    sdev->aper && !sdev->card_rel_da)
> -		apt_base =3D sdev->aper->pa;
> -	else
> -		return;
> -
> -	for (j =3D 0; j < window->nr_contig_chunks; j++) {
> -		if (window->num_pages[j])
> -			window->dma_addr[j] +=3D apt_base;
> -		else
> -			break;
> -	}
> -}
> -
> -/**
> - * scif_recv_reg: Respond to SCIF_REGISTER interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Update remote window list with a new registered window.
> - */
> -void scif_recv_reg(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)msg->payload[0];
> -	struct scif_window *window =3D
> -		(struct scif_window *)msg->payload[1];
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	spin_lock(&ep->lock);
> -	if (ep->state =3D=3D SCIFEP_CONNECTED) {
> -		msg->uop =3D SCIF_REGISTER_ACK;
> -		scif_nodeqp_send(ep->remote_dev, msg);
> -		scif_fixup_aper_base(ep->remote_dev, window);
> -		/* No further failures expected. Insert new window */
> -		scif_insert_window(window, &ep-
> >rma_info.remote_reg_list);
> -	} else {
> -		msg->uop =3D SCIF_REGISTER_NACK;
> -		scif_nodeqp_send(ep->remote_dev, msg);
> -	}
> -	spin_unlock(&ep->lock);
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	/* free up any lookup resources now that page lists are transferred
> */
> -	scif_destroy_remote_lookup(ep->remote_dev, window);
> -	/*
> -	 * We could not insert the window but we need to
> -	 * destroy the window.
> -	 */
> -	if (msg->uop =3D=3D SCIF_REGISTER_NACK)
> -		scif_destroy_remote_window(window);
> -}
> -
> -/**
> - * scif_recv_unreg: Respond to SCIF_UNREGISTER interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Remove window from remote registration list;
> - */
> -void scif_recv_unreg(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_rma_req req;
> -	struct scif_window *window =3D NULL;
> -	struct scif_window *recv_window =3D
> -		(struct scif_window *)msg->payload[0];
> -	struct scif_endpt *ep;
> -	int del_window =3D 0;
> -
> -	ep =3D (struct scif_endpt *)recv_window->ep;
> -	req.out_window =3D &window;
> -	req.offset =3D recv_window->offset;
> -	req.prot =3D 0;
> -	req.nr_bytes =3D recv_window->nr_pages << PAGE_SHIFT;
> -	req.type =3D SCIF_WINDOW_FULL;
> -	req.head =3D &ep->rma_info.remote_reg_list;
> -	msg->payload[0] =3D ep->remote_ep;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	/* Does a valid window exist? */
> -	if (scif_query_window(&req)) {
> -		dev_err(&scifdev->sdev->dev,
> -			"%s %d -ENXIO\n", __func__, __LINE__);
> -		msg->uop =3D SCIF_UNREGISTER_ACK;
> -		goto error;
> -	}
> -	if (window) {
> -		if (window->ref_count)
> -			scif_put_window(window, window->nr_pages);
> -		else
> -			dev_err(&scifdev->sdev->dev,
> -				"%s %d ref count should be +ve\n",
> -				__func__, __LINE__);
> -		window->unreg_state =3D OP_COMPLETED;
> -		if (!window->ref_count) {
> -			msg->uop =3D SCIF_UNREGISTER_ACK;
> -			atomic_inc(&ep->rma_info.tw_refcount);
> -			ep->rma_info.async_list_del =3D 1;
> -			list_del_init(&window->list);
> -			del_window =3D 1;
> -		} else {
> -			/* NACK! There are valid references to this window
> */
> -			msg->uop =3D SCIF_UNREGISTER_NACK;
> -		}
> -	} else {
> -		/* The window did not make its way to the list at all. ACK */
> -		msg->uop =3D SCIF_UNREGISTER_ACK;
> -		scif_destroy_remote_window(recv_window);
> -	}
> -error:
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	if (del_window)
> -		scif_drain_dma_intr(ep->remote_dev->sdev,
> -				    ep->rma_info.dma_chan);
> -	scif_nodeqp_send(ep->remote_dev, msg);
> -	if (del_window)
> -		scif_queue_for_cleanup(window, &scif_info.rma);
> -}
> -
> -/**
> - * scif_recv_reg_ack: Respond to SCIF_REGISTER_ACK interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Wake up the window waiting to complete registration.
> - */
> -void scif_recv_reg_ack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_window *window =3D
> -		(struct scif_window *)msg->payload[2];
> -	struct scif_endpt *ep =3D (struct scif_endpt *)window->ep;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	window->reg_state =3D OP_COMPLETED;
> -	wake_up(&window->regwq);
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -}
> -
> -/**
> - * scif_recv_reg_nack: Respond to SCIF_REGISTER_NACK interrupt message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Wake up the window waiting to inform it that registration
> - * cannot be completed.
> - */
> -void scif_recv_reg_nack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_window *window =3D
> -		(struct scif_window *)msg->payload[2];
> -	struct scif_endpt *ep =3D (struct scif_endpt *)window->ep;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	window->reg_state =3D OP_FAILED;
> -	wake_up(&window->regwq);
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -}
> -
> -/**
> - * scif_recv_unreg_ack: Respond to SCIF_UNREGISTER_ACK interrupt
> message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Wake up the window waiting to complete unregistration.
> - */
> -void scif_recv_unreg_ack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_window *window =3D
> -		(struct scif_window *)msg->payload[1];
> -	struct scif_endpt *ep =3D (struct scif_endpt *)window->ep;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	window->unreg_state =3D OP_COMPLETED;
> -	wake_up(&window->unregwq);
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -}
> -
> -/**
> - * scif_recv_unreg_nack: Respond to SCIF_UNREGISTER_NACK interrupt
> message
> - * @scifdev:    SCIF device
> - * @msg:        Interrupt message
> - *
> - * Wake up the window waiting to inform it that unregistration
> - * cannot be completed immediately.
> - */
> -void scif_recv_unreg_nack(struct scif_dev *scifdev, struct scifmsg *msg)
> -{
> -	struct scif_window *window =3D
> -		(struct scif_window *)msg->payload[1];
> -	struct scif_endpt *ep =3D (struct scif_endpt *)window->ep;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	window->unreg_state =3D OP_FAILED;
> -	wake_up(&window->unregwq);
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -}
> -
> -int __scif_pin_pages(void *addr, size_t len, int *out_prot,
> -		     int map_flags, scif_pinned_pages_t *pages)
> -{
> -	struct scif_pinned_pages *pinned_pages;
> -	int nr_pages, err =3D 0, i;
> -	bool vmalloc_addr =3D false;
> -	bool try_upgrade =3D false;
> -	int prot =3D *out_prot;
> -	int ulimit =3D 0;
> -	struct mm_struct *mm =3D NULL;
> -
> -	/* Unsupported flags */
> -	if (map_flags & ~(SCIF_MAP_KERNEL | SCIF_MAP_ULIMIT))
> -		return -EINVAL;
> -	ulimit =3D !!(map_flags & SCIF_MAP_ULIMIT);
> -
> -	/* Unsupported protection requested */
> -	if (prot & ~(SCIF_PROT_READ | SCIF_PROT_WRITE))
> -		return -EINVAL;
> -
> -	/* addr/len must be page aligned. len should be non zero */
> -	if (!len ||
> -	    (ALIGN((u64)addr, PAGE_SIZE) !=3D (u64)addr) ||
> -	    (ALIGN((u64)len, PAGE_SIZE) !=3D (u64)len))
> -		return -EINVAL;
> -
> -	might_sleep();
> -
> -	nr_pages =3D len >> PAGE_SHIFT;
> -
> -	/* Allocate a set of pinned pages */
> -	pinned_pages =3D scif_create_pinned_pages(nr_pages, prot);
> -	if (!pinned_pages)
> -		return -ENOMEM;
> -
> -	if (map_flags & SCIF_MAP_KERNEL) {
> -		if (is_vmalloc_addr(addr))
> -			vmalloc_addr =3D true;
> -
> -		for (i =3D 0; i < nr_pages; i++) {
> -			if (vmalloc_addr)
> -				pinned_pages->pages[i] =3D
> -					vmalloc_to_page(addr + (i *
> PAGE_SIZE));
> -			else
> -				pinned_pages->pages[i] =3D
> -					virt_to_page(addr + (i * PAGE_SIZE));
> -		}
> -		pinned_pages->nr_pages =3D nr_pages;
> -		pinned_pages->map_flags =3D SCIF_MAP_KERNEL;
> -	} else {
> -		/*
> -		 * SCIF supports registration caching. If a registration has
> -		 * been requested with read only permissions, then we try
> -		 * to pin the pages with RW permissions so that a subsequent
> -		 * transfer with RW permission can hit the cache instead of
> -		 * invalidating it. If the upgrade fails with RW then we
> -		 * revert back to R permission and retry
> -		 */
> -		if (prot =3D=3D SCIF_PROT_READ)
> -			try_upgrade =3D true;
> -		prot |=3D SCIF_PROT_WRITE;
> -retry:
> -		mm =3D current->mm;
> -		if (ulimit) {
> -			err =3D __scif_check_inc_pinned_vm(mm, nr_pages);
> -			if (err) {
> -				pinned_pages->nr_pages =3D 0;
> -				goto error_unmap;
> -			}
> -		}
> -
> -		pinned_pages->nr_pages =3D pin_user_pages_fast(
> -				(u64)addr,
> -				nr_pages,
> -				(prot & SCIF_PROT_WRITE) ? FOLL_WRITE : 0,
> -				pinned_pages->pages);
> -		if (nr_pages !=3D pinned_pages->nr_pages) {
> -			if (pinned_pages->nr_pages < 0)
> -				pinned_pages->nr_pages =3D 0;
> -			if (try_upgrade) {
> -				if (ulimit)
> -					__scif_dec_pinned_vm_lock(mm,
> nr_pages);
> -				/* Roll back any pinned pages */
> -				unpin_user_pages(pinned_pages->pages,
> -						 pinned_pages->nr_pages);
> -				prot &=3D ~SCIF_PROT_WRITE;
> -				try_upgrade =3D false;
> -				goto retry;
> -			}
> -		}
> -		pinned_pages->map_flags =3D 0;
> -	}
> -
> -	if (pinned_pages->nr_pages < nr_pages) {
> -		err =3D -EFAULT;
> -		goto dec_pinned;
> -	}
> -
> -	*out_prot =3D prot;
> -	atomic_set(&pinned_pages->ref_count, 1);
> -	*pages =3D pinned_pages;
> -	return err;
> -dec_pinned:
> -	if (ulimit)
> -		__scif_dec_pinned_vm_lock(mm, nr_pages);
> -	/* Something went wrong! Rollback */
> -error_unmap:
> -	scif_destroy_pinned_pages(pinned_pages);
> -	*pages =3D NULL;
> -	dev_dbg(scif_info.mdev.this_device,
> -		"%s %d err %d len 0x%lx\n", __func__, __LINE__, err, len);
> -	return err;
> -}
> -
> -int scif_pin_pages(void *addr, size_t len, int prot,
> -		   int map_flags, scif_pinned_pages_t *pages)
> -{
> -	return __scif_pin_pages(addr, len, &prot, map_flags, pages);
> -}
> -EXPORT_SYMBOL_GPL(scif_pin_pages);
> -
> -int scif_unpin_pages(scif_pinned_pages_t pinned_pages)
> -{
> -	int err =3D 0, ret;
> -
> -	if (!pinned_pages || SCIFEP_MAGIC !=3D pinned_pages->magic)
> -		return -EINVAL;
> -
> -	ret =3D atomic_sub_return(1, &pinned_pages->ref_count);
> -	if (ret < 0) {
> -		dev_err(scif_info.mdev.this_device,
> -			"%s %d scif_unpin_pages called without pinning?
> rc %d\n",
> -			__func__, __LINE__, ret);
> -		return -EINVAL;
> -	}
> -	/*
> -	 * Destroy the window if the ref count for this set of pinned
> -	 * pages has dropped to zero. If it is positive then there is
> -	 * a valid registered window which is backed by these pages and
> -	 * it will be destroyed once all such windows are unregistered.
> -	 */
> -	if (!ret)
> -		err =3D scif_destroy_pinned_pages(pinned_pages);
> -
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_unpin_pages);
> -
> -static inline void
> -scif_insert_local_window(struct scif_window *window, struct scif_endpt
> *ep)
> -{
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	scif_insert_window(window, &ep->rma_info.reg_list);
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -}
> -
> -off_t scif_register_pinned_pages(scif_epd_t epd,
> -				 scif_pinned_pages_t pinned_pages,
> -				 off_t offset, int map_flags)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	s64 computed_offset;
> -	struct scif_window *window;
> -	int err;
> -	size_t len;
> -	struct device *spdev;
> -
> -	/* Unsupported flags */
> -	if (map_flags & ~SCIF_MAP_FIXED)
> -		return -EINVAL;
> -
> -	len =3D pinned_pages->nr_pages << PAGE_SHIFT;
> -
> -	/*
> -	 * Offset is not page aligned/negative or offset+len
> -	 * wraps around with SCIF_MAP_FIXED.
> -	 */
> -	if ((map_flags & SCIF_MAP_FIXED) &&
> -	    ((ALIGN(offset, PAGE_SIZE) !=3D offset) ||
> -	    (offset < 0) ||
> -	    (len > LONG_MAX - offset)))
> -		return -EINVAL;
> -
> -	might_sleep();
> -
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -	/*
> -	 * It is an error to pass pinned_pages to scif_register_pinned_pages()
> -	 * after calling scif_unpin_pages().
> -	 */
> -	if (!atomic_add_unless(&pinned_pages->ref_count, 1, 0))
> -		return -EINVAL;
> -
> -	/* Compute the offset for this registration */
> -	err =3D scif_get_window_offset(ep, map_flags, offset,
> -				     len, &computed_offset);
> -	if (err) {
> -		atomic_sub(1, &pinned_pages->ref_count);
> -		return err;
> -	}
> -
> -	/* Allocate and prepare self registration window */
> -	window =3D scif_create_window(ep, pinned_pages->nr_pages,
> -				    computed_offset, false);
> -	if (!window) {
> -		atomic_sub(1, &pinned_pages->ref_count);
> -		scif_free_window_offset(ep, NULL, computed_offset);
> -		return -ENOMEM;
> -	}
> -
> -	window->pinned_pages =3D pinned_pages;
> -	window->nr_pages =3D pinned_pages->nr_pages;
> -	window->prot =3D pinned_pages->prot;
> -
> -	spdev =3D scif_get_peer_dev(ep->remote_dev);
> -	if (IS_ERR(spdev)) {
> -		err =3D PTR_ERR(spdev);
> -		scif_destroy_window(ep, window);
> -		return err;
> -	}
> -	err =3D scif_send_alloc_request(ep, window);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto error_unmap;
> -	}
> -
> -	/* Prepare the remote registration window */
> -	err =3D scif_prep_remote_window(ep, window);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto error_unmap;
> -	}
> -
> -	/* Tell the peer about the new window */
> -	err =3D scif_send_scif_register(ep, window);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto error_unmap;
> -	}
> -
> -	scif_put_peer_dev(spdev);
> -	/* No further failures expected. Insert new window */
> -	scif_insert_local_window(window, ep);
> -	return computed_offset;
> -error_unmap:
> -	scif_destroy_window(ep, window);
> -	scif_put_peer_dev(spdev);
> -	dev_err(&ep->remote_dev->sdev->dev,
> -		"%s %d err %d\n", __func__, __LINE__, err);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_register_pinned_pages);
> -
> -off_t scif_register(scif_epd_t epd, void *addr, size_t len, off_t offset=
,
> -		    int prot, int map_flags)
> -{
> -	scif_pinned_pages_t pinned_pages;
> -	off_t err;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	s64 computed_offset;
> -	struct scif_window *window;
> -	struct mm_struct *mm =3D NULL;
> -	struct device *spdev;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI register: ep %p addr %p len 0x%lx offset 0x%lx prot
> 0x%x map_flags 0x%x\n",
> -		epd, addr, len, offset, prot, map_flags);
> -	/* Unsupported flags */
> -	if (map_flags & ~(SCIF_MAP_FIXED | SCIF_MAP_KERNEL))
> -		return -EINVAL;
> -
> -	/*
> -	 * Offset is not page aligned/negative or offset+len
> -	 * wraps around with SCIF_MAP_FIXED.
> -	 */
> -	if ((map_flags & SCIF_MAP_FIXED) &&
> -	    ((ALIGN(offset, PAGE_SIZE) !=3D offset) ||
> -	    (offset < 0) ||
> -	    (len > LONG_MAX - offset)))
> -		return -EINVAL;
> -
> -	/* Unsupported protection requested */
> -	if (prot & ~(SCIF_PROT_READ | SCIF_PROT_WRITE))
> -		return -EINVAL;
> -
> -	/* addr/len must be page aligned. len should be non zero */
> -	if (!len || (ALIGN((u64)addr, PAGE_SIZE) !=3D (u64)addr) ||
> -	    (ALIGN(len, PAGE_SIZE) !=3D len))
> -		return -EINVAL;
> -
> -	might_sleep();
> -
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -
> -	/* Compute the offset for this registration */
> -	err =3D scif_get_window_offset(ep, map_flags, offset,
> -				     len >> PAGE_SHIFT, &computed_offset);
> -	if (err)
> -		return err;
> -
> -	spdev =3D scif_get_peer_dev(ep->remote_dev);
> -	if (IS_ERR(spdev)) {
> -		err =3D PTR_ERR(spdev);
> -		scif_free_window_offset(ep, NULL, computed_offset);
> -		return err;
> -	}
> -	/* Allocate and prepare self registration window */
> -	window =3D scif_create_window(ep, len >> PAGE_SHIFT,
> -				    computed_offset, false);
> -	if (!window) {
> -		scif_free_window_offset(ep, NULL, computed_offset);
> -		scif_put_peer_dev(spdev);
> -		return -ENOMEM;
> -	}
> -
> -	window->nr_pages =3D len >> PAGE_SHIFT;
> -
> -	err =3D scif_send_alloc_request(ep, window);
> -	if (err) {
> -		scif_destroy_incomplete_window(ep, window);
> -		scif_put_peer_dev(spdev);
> -		return err;
> -	}
> -
> -	if (!(map_flags & SCIF_MAP_KERNEL)) {
> -		mm =3D __scif_acquire_mm();
> -		map_flags |=3D SCIF_MAP_ULIMIT;
> -	}
> -	/* Pin down the pages */
> -	err =3D __scif_pin_pages(addr, len, &prot,
> -			       map_flags & (SCIF_MAP_KERNEL |
> SCIF_MAP_ULIMIT),
> -			       &pinned_pages);
> -	if (err) {
> -		scif_destroy_incomplete_window(ep, window);
> -		__scif_release_mm(mm);
> -		goto error;
> -	}
> -
> -	window->pinned_pages =3D pinned_pages;
> -	window->prot =3D pinned_pages->prot;
> -	window->mm =3D mm;
> -
> -	/* Prepare the remote registration window */
> -	err =3D scif_prep_remote_window(ep, window);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %ld\n", __func__, __LINE__, err);
> -		goto error_unmap;
> -	}
> -
> -	/* Tell the peer about the new window */
> -	err =3D scif_send_scif_register(ep, window);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %ld\n", __func__, __LINE__, err);
> -		goto error_unmap;
> -	}
> -
> -	scif_put_peer_dev(spdev);
> -	/* No further failures expected. Insert new window */
> -	scif_insert_local_window(window, ep);
> -	dev_dbg(&ep->remote_dev->sdev->dev,
> -		"SCIFAPI register: ep %p addr %p len 0x%lx computed_offset
> 0x%llx\n",
> -		epd, addr, len, computed_offset);
> -	return computed_offset;
> -error_unmap:
> -	scif_destroy_window(ep, window);
> -error:
> -	scif_put_peer_dev(spdev);
> -	dev_err(&ep->remote_dev->sdev->dev,
> -		"%s %d err %ld\n", __func__, __LINE__, err);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_register);
> -
> -int
> -scif_unregister(scif_epd_t epd, off_t offset, size_t len)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct scif_window *window =3D NULL;
> -	struct scif_rma_req req;
> -	int nr_pages, err;
> -	struct device *spdev;
> -
> -	dev_dbg(scif_info.mdev.this_device,
> -		"SCIFAPI unregister: ep %p offset 0x%lx len 0x%lx\n",
> -		ep, offset, len);
> -	/* len must be page aligned. len should be non zero */
> -	if (!len ||
> -	    (ALIGN((u64)len, PAGE_SIZE) !=3D (u64)len))
> -		return -EINVAL;
> -
> -	/* Offset is not page aligned or offset+len wraps around */
> -	if ((ALIGN(offset, PAGE_SIZE) !=3D offset) ||
> -	    (offset < 0) ||
> -	    (len > LONG_MAX - offset))
> -		return -EINVAL;
> -
> -	err =3D scif_verify_epd(ep);
> -	if (err)
> -		return err;
> -
> -	might_sleep();
> -	nr_pages =3D len >> PAGE_SHIFT;
> -
> -	req.out_window =3D &window;
> -	req.offset =3D offset;
> -	req.prot =3D 0;
> -	req.nr_bytes =3D len;
> -	req.type =3D SCIF_WINDOW_FULL;
> -	req.head =3D &ep->rma_info.reg_list;
> -
> -	spdev =3D scif_get_peer_dev(ep->remote_dev);
> -	if (IS_ERR(spdev)) {
> -		err =3D PTR_ERR(spdev);
> -		return err;
> -	}
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	/* Does a valid window exist? */
> -	err =3D scif_query_window(&req);
> -	if (err) {
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -		goto error;
> -	}
> -	/* Unregister all the windows in this range */
> -	err =3D scif_rma_list_unregister(window, offset, nr_pages);
> -	if (err)
> -		dev_err(&ep->remote_dev->sdev->dev,
> -			"%s %d err %d\n", __func__, __LINE__, err);
> -error:
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	scif_put_peer_dev(spdev);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(scif_unregister);
> diff --git a/drivers/misc/mic/scif/scif_rma.h
> b/drivers/misc/mic/scif/scif_rma.h
> deleted file mode 100644
> index 964dd0fc3657..000000000000
> --- a/drivers/misc/mic/scif/scif_rma.h
> +++ /dev/null
> @@ -1,477 +0,0 @@
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - * redistributing this file, you may do so under either license.
> - *
> - * GPL LICENSE SUMMARY
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * BSD LICENSE
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - * * Redistributions of source code must retain the above copyright
> - *   notice, this list of conditions and the following disclaimer.
> - * * Redistributions in binary form must reproduce the above copyright
> - *   notice, this list of conditions and the following disclaimer in
> - *   the documentation and/or other materials provided with the
> - *   distribution.
> - * * Neither the name of Intel Corporation nor the names of its
> - *   contributors may be used to endorse or promote products derived
> - *   from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
> THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> DAMAGE.
> - *
> - * Intel SCIF driver.
> - *
> - */
> -#ifndef SCIF_RMA_H
> -#define SCIF_RMA_H
> -
> -#include <linux/intel-iommu.h>
> -#include <linux/mmu_notifier.h>
> -
> -#include "../bus/scif_bus.h"
> -
> -/* If this bit is set then the mark is a remote fence mark */
> -#define SCIF_REMOTE_FENCE_BIT          31
> -/* Magic value used to indicate a remote fence request */
> -#define SCIF_REMOTE_FENCE BIT_ULL(SCIF_REMOTE_FENCE_BIT)
> -
> -#define SCIF_MAX_UNALIGNED_BUF_SIZE (1024 * 1024ULL)
> -#define SCIF_KMEM_UNALIGNED_BUF_SIZE
> (SCIF_MAX_UNALIGNED_BUF_SIZE + \
> -				      (L1_CACHE_BYTES << 1))
> -
> -#define SCIF_IOVA_START_PFN		(1)
> -#define SCIF_IOVA_PFN(addr) ((addr) >> PAGE_SHIFT)
> -#define SCIF_DMA_64BIT_PFN SCIF_IOVA_PFN(DMA_BIT_MASK(64))
> -#define SCIF_DMA_63BIT_PFN SCIF_IOVA_PFN(DMA_BIT_MASK(63))
> -
> -/*
> - * struct scif_endpt_rma_info - Per Endpoint Remote Memory Access
> Information
> - *
> - * @reg_list: List of registration windows for self
> - * @remote_reg_list: List of registration windows for peer
> - * @iovad: Offset generator
> - * @rma_lock: Synchronizes access to self/remote list and also protects =
the
> - *	      window from being destroyed while RMAs are in progress.
> - * @tc_lock: Synchronizes access to temporary cached windows list
> - *	     for SCIF Registration Caching.
> - * @mmn_lock: Synchronizes access to the list of MMU notifiers registere=
d
> - * @tw_refcount: Keeps track of number of outstanding temporary
> registered
> - *		 windows created by scif_vreadfrom/scif_vwriteto which
> have
> - *		 not been destroyed.
> - * @tcw_refcount: Same as tw_refcount but for temporary cached windows
> - * @tcw_total_pages: Same as tcw_refcount but in terms of pages pinned
> - * @mmn_list: MMU notifier so that we can destroy the windows when
> required
> - * @fence_refcount: Keeps track of number of outstanding remote fence
> - *		    requests which have been received by the peer.
> - * @dma_chan: DMA channel used for all DMA transfers for this endpoint.
> - * @async_list_del: Detect asynchronous list entry deletion
> - * @vma_list: List of vmas with remote memory mappings
> - * @markwq: Wait queue used for scif_fence_mark/scif_fence_wait
> -*/
> -struct scif_endpt_rma_info {
> -	struct list_head reg_list;
> -	struct list_head remote_reg_list;
> -	struct iova_domain iovad;
> -	struct mutex rma_lock;
> -	spinlock_t tc_lock;
> -	struct mutex mmn_lock;
> -	atomic_t tw_refcount;
> -	atomic_t tcw_refcount;
> -	atomic_t tcw_total_pages;
> -	struct list_head mmn_list;
> -	atomic_t fence_refcount;
> -	struct dma_chan	*dma_chan;
> -	int async_list_del;
> -	struct list_head vma_list;
> -	wait_queue_head_t markwq;
> -};
> -
> -/*
> - * struct scif_fence_info - used for tracking fence requests
> - *
> - * @state: State of this transfer
> - * @wq: Fences wait on this queue
> - * @dma_mark: Used for storing the DMA mark
> - */
> -struct scif_fence_info {
> -	enum scif_msg_state state;
> -	struct completion comp;
> -	int dma_mark;
> -};
> -
> -/*
> - * struct scif_remote_fence_info - used for tracking remote fence reques=
ts
> - *
> - * @msg: List of SCIF node QP fence messages
> - * @list: Link to list of remote fence requests
> - */
> -struct scif_remote_fence_info {
> -	struct scifmsg msg;
> -	struct list_head list;
> -};
> -
> -/*
> - * Specifies whether an RMA operation can span across partial windows, a
> single
> - * window or multiple contiguous windows. Mmaps can span across partial
> windows.
> - * Unregistration can span across complete windows. scif_get_pages() can
> span a
> - * single window. A window can also be of type self or peer.
> - */
> -enum scif_window_type {
> -	SCIF_WINDOW_PARTIAL,
> -	SCIF_WINDOW_SINGLE,
> -	SCIF_WINDOW_FULL,
> -	SCIF_WINDOW_SELF,
> -	SCIF_WINDOW_PEER
> -};
> -
> -/* The number of physical addresses that can be stored in a PAGE. */
> -#define SCIF_NR_ADDR_IN_PAGE   (0x1000 >> 3)
> -
> -/*
> - * struct scif_rma_lookup - RMA lookup data structure for page list tran=
sfers
> - *
> - * Store an array of lookup offsets. Each offset in this array maps
> - * one 4K page containing 512 physical addresses i.e. 2MB. 512 such
> - * offsets in a 4K page will correspond to 1GB of registered address spa=
ce.
> -
> - * @lookup: Array of offsets
> - * @offset: DMA offset of lookup array
> - */
> -struct scif_rma_lookup {
> -	dma_addr_t *lookup;
> -	dma_addr_t offset;
> -};
> -
> -/*
> - * struct scif_pinned_pages - A set of pinned pages obtained with
> - * scif_pin_pages() which could be part of multiple registered
> - * windows across different end points.
> - *
> - * @nr_pages: Number of pages which is defined as a s64 instead of an in=
t
> - * to avoid sign extension with buffers >=3D 2GB
> - * @prot: read/write protections
> - * @map_flags: Flags specified during the pin operation
> - * @ref_count: Reference count bumped in terms of number of pages
> - * @magic: A magic value
> - * @pages: Array of pointers to struct pages populated with
> get_user_pages(..)
> - */
> -struct scif_pinned_pages {
> -	s64 nr_pages;
> -	int prot;
> -	int map_flags;
> -	atomic_t ref_count;
> -	u64 magic;
> -	struct page **pages;
> -};
> -
> -/*
> - * struct scif_status - Stores DMA status update information
> - *
> - * @src_dma_addr: Source buffer DMA address
> - * @val: src location for value to be written to the destination
> - * @ep: SCIF endpoint
> - */
> -struct scif_status {
> -	dma_addr_t src_dma_addr;
> -	u64 val;
> -	struct scif_endpt *ep;
> -};
> -
> -/*
> - * struct scif_cb_arg - Stores the argument of the callback func
> - *
> - * @src_dma_addr: Source buffer DMA address
> - * @status: DMA status
> - * @ep: SCIF endpoint
> - */
> -struct scif_cb_arg {
> -	dma_addr_t src_dma_addr;
> -	struct scif_status *status;
> -	struct scif_endpt *ep;
> -};
> -
> -/*
> - * struct scif_window - Registration Window for Self and Remote
> - *
> - * @nr_pages: Number of pages which is defined as a s64 instead of an in=
t
> - * to avoid sign extension with buffers >=3D 2GB
> - * @nr_contig_chunks: Number of contiguous physical chunks
> - * @prot: read/write protections
> - * @ref_count: reference count in terms of number of pages
> - * @magic: Cookie to detect corruption
> - * @offset: registered offset
> - * @va_for_temp: va address that this window represents
> - * @dma_mark: Used to determine if all DMAs against the window are done
> - * @ep: Pointer to EP. Useful for passing EP around with messages to
> -	avoid expensive list traversals.
> - * @list: link to list of windows for the endpoint
> - * @type: self or peer window
> - * @peer_window: Pointer to peer window. Useful for sending messages to
> peer
> - *		 without requiring an extra list traversal
> - * @unreg_state: unregistration state
> - * @offset_freed: True if the offset has been freed
> - * @temp: True for temporary windows created via
> scif_vreadfrom/scif_vwriteto
> - * @mm: memory descriptor for the task_struct which initiated the RMA
> - * @st: scatter gather table for DMA mappings with IOMMU enabled
> - * @pinned_pages: The set of pinned_pages backing this window
> - * @alloc_handle: Handle for sending ALLOC_REQ
> - * @regwq: Wait Queue for an registration (N)ACK
> - * @reg_state: Registration state
> - * @unregwq: Wait Queue for an unregistration (N)ACK
> - * @dma_addr_lookup: Lookup for physical addresses used for DMA
> - * @nr_lookup: Number of entries in lookup
> - * @mapped_offset: Offset used to map the window by the peer
> - * @dma_addr: Array of physical addresses used for Mgmt node & MIC
> initiated DMA
> - * @num_pages: Array specifying number of pages for each physical addres=
s
> - */
> -struct scif_window {
> -	s64 nr_pages;
> -	int nr_contig_chunks;
> -	int prot;
> -	int ref_count;
> -	u64 magic;
> -	s64 offset;
> -	unsigned long va_for_temp;
> -	int dma_mark;
> -	u64 ep;
> -	struct list_head list;
> -	enum scif_window_type type;
> -	u64 peer_window;
> -	enum scif_msg_state unreg_state;
> -	bool offset_freed;
> -	bool temp;
> -	struct mm_struct *mm;
> -	struct sg_table *st;
> -	union {
> -		struct {
> -			struct scif_pinned_pages *pinned_pages;
> -			struct scif_allocmsg alloc_handle;
> -			wait_queue_head_t regwq;
> -			enum scif_msg_state reg_state;
> -			wait_queue_head_t unregwq;
> -		};
> -		struct {
> -			struct scif_rma_lookup dma_addr_lookup;
> -			struct scif_rma_lookup num_pages_lookup;
> -			int nr_lookup;
> -			dma_addr_t mapped_offset;
> -		};
> -	};
> -	dma_addr_t *dma_addr;
> -	u64 *num_pages;
> -} __packed;
> -
> -/*
> - * scif_mmu_notif - SCIF mmu notifier information
> - *
> - * @mmu_notifier ep_mmu_notifier: MMU notifier operations
> - * @tc_reg_list: List of temp registration windows for self
> - * @mm: memory descriptor for the task_struct which initiated the RMA
> - * @ep: SCIF endpoint
> - * @list: link to list of MMU notifier information
> - */
> -struct scif_mmu_notif {
> -#ifdef CONFIG_MMU_NOTIFIER
> -	struct mmu_notifier ep_mmu_notifier;
> -#endif
> -	struct list_head tc_reg_list;
> -	struct mm_struct *mm;
> -	struct scif_endpt *ep;
> -	struct list_head list;
> -};
> -
> -enum scif_rma_dir {
> -	SCIF_LOCAL_TO_REMOTE,
> -	SCIF_REMOTE_TO_LOCAL
> -};
> -
> -extern struct kmem_cache *unaligned_cache;
> -/* Initialize RMA for this EP */
> -void scif_rma_ep_init(struct scif_endpt *ep);
> -/* Check if epd can be uninitialized */
> -int scif_rma_ep_can_uninit(struct scif_endpt *ep);
> -/* Obtain a new offset. Callee must grab RMA lock */
> -int scif_get_window_offset(struct scif_endpt *ep, int flags,
> -			   s64 offset, int nr_pages, s64 *out_offset);
> -/* Free offset. Callee must grab RMA lock */
> -void scif_free_window_offset(struct scif_endpt *ep,
> -			     struct scif_window *window, s64 offset);
> -/* Create self registration window */
> -struct scif_window *scif_create_window(struct scif_endpt *ep, int nr_pag=
es,
> -				       s64 offset, bool temp);
> -/* Destroy self registration window.*/
> -int scif_destroy_window(struct scif_endpt *ep, struct scif_window
> *window);
> -void scif_unmap_window(struct scif_dev *remote_dev, struct scif_window
> *window);
> -/* Map pages of self window to Aperture/PCI */
> -int scif_map_window(struct scif_dev *remote_dev,
> -		    struct scif_window *window);
> -/* Unregister a self window */
> -int scif_unregister_window(struct scif_window *window);
> -/* Destroy remote registration window */
> -void
> -scif_destroy_remote_window(struct scif_window *window);
> -/* remove valid remote memory mappings from process address space */
> -void scif_zap_mmaps(int node);
> -/* Query if any applications have remote memory mappings */
> -bool scif_rma_do_apps_have_mmaps(int node);
> -/* Cleanup remote registration lists for zombie endpoints */
> -void scif_cleanup_rma_for_zombies(int node);
> -/* Reserve a DMA channel for a particular endpoint */
> -int scif_reserve_dma_chan(struct scif_endpt *ep);
> -/* Setup a DMA mark for an endpoint */
> -int _scif_fence_mark(scif_epd_t epd, int *mark);
> -int scif_prog_signal(scif_epd_t epd, off_t offset, u64 val,
> -		     enum scif_window_type type);
> -void scif_alloc_req(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_alloc_gnt_rej(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_free_virt(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_reg(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_unreg(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_reg_ack(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_reg_nack(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_unreg_ack(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_unreg_nack(struct scif_dev *scifdev, struct scifmsg *msg)=
;
> -void scif_recv_munmap(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_mark(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_mark_resp(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_wait(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_wait_resp(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_sig_local(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_recv_sig_remote(struct scif_dev *scifdev, struct scifmsg *msg)=
;
> -void scif_recv_sig_resp(struct scif_dev *scifdev, struct scifmsg *msg);
> -void scif_mmu_notif_handler(struct work_struct *work);
> -void scif_rma_handle_remote_fences(void);
> -void scif_rma_destroy_windows(void);
> -void scif_rma_destroy_tcw_invalid(void);
> -int scif_drain_dma_intr(struct scif_hw_dev *sdev, struct dma_chan *chan)=
;
> -
> -struct scif_window_iter {
> -	s64 offset;
> -	int index;
> -};
> -
> -static inline void
> -scif_init_window_iter(struct scif_window *window, struct scif_window_ite=
r
> *iter)
> -{
> -	iter->offset =3D window->offset;
> -	iter->index =3D 0;
> -}
> -
> -dma_addr_t scif_off_to_dma_addr(struct scif_window *window, s64 off,
> -				size_t *nr_bytes,
> -				struct scif_window_iter *iter);
> -static inline
> -dma_addr_t __scif_off_to_dma_addr(struct scif_window *window, s64 off)
> -{
> -	return scif_off_to_dma_addr(window, off, NULL, NULL);
> -}
> -
> -static inline bool scif_unaligned(off_t src_offset, off_t dst_offset)
> -{
> -	src_offset =3D src_offset & (L1_CACHE_BYTES - 1);
> -	dst_offset =3D dst_offset & (L1_CACHE_BYTES - 1);
> -	return !(src_offset =3D=3D dst_offset);
> -}
> -
> -/*
> - * scif_zalloc:
> - * @size: Size of the allocation request.
> - *
> - * Helper API which attempts to allocate zeroed pages via
> - * __get_free_pages(..) first and then falls back on
> - * vzalloc(..) if that fails.
> - */
> -static inline void *scif_zalloc(size_t size)
> -{
> -	void *ret =3D NULL;
> -	size_t align =3D ALIGN(size, PAGE_SIZE);
> -
> -	if (align && get_order(align) < MAX_ORDER)
> -		ret =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					       get_order(align));
> -	return ret ? ret : vzalloc(align);
> -}
> -
> -/*
> - * scif_free:
> - * @addr: Address to be freed.
> - * @size: Size of the allocation.
> - * Helper API which frees memory allocated via scif_zalloc().
> - */
> -static inline void scif_free(void *addr, size_t size)
> -{
> -	size_t align =3D ALIGN(size, PAGE_SIZE);
> -
> -	if (is_vmalloc_addr(addr))
> -		vfree(addr);
> -	else
> -		free_pages((unsigned long)addr, get_order(align));
> -}
> -
> -static inline void scif_get_window(struct scif_window *window, int nr_pa=
ges)
> -{
> -	window->ref_count +=3D nr_pages;
> -}
> -
> -static inline void scif_put_window(struct scif_window *window, int
> nr_pages)
> -{
> -	window->ref_count -=3D nr_pages;
> -}
> -
> -static inline void scif_set_window_ref(struct scif_window *window, int
> nr_pages)
> -{
> -	window->ref_count =3D nr_pages;
> -}
> -
> -static inline void
> -scif_queue_for_cleanup(struct scif_window *window, struct list_head *lis=
t)
> -{
> -	spin_lock(&scif_info.rmalock);
> -	list_add_tail(&window->list, list);
> -	spin_unlock(&scif_info.rmalock);
> -	schedule_work(&scif_info.misc_work);
> -}
> -
> -static inline void __scif_rma_destroy_tcw_helper(struct scif_window
> *window)
> -{
> -	list_del_init(&window->list);
> -	scif_queue_for_cleanup(window, &scif_info.rma_tc);
> -}
> -
> -static inline bool scif_is_iommu_enabled(void)
> -{
> -#ifdef CONFIG_INTEL_IOMMU
> -	return intel_iommu_enabled;
> -#else
> -	return false;
> -#endif
> -}
> -#endif /* SCIF_RMA_H */
> diff --git a/drivers/misc/mic/scif/scif_rma_list.c
> b/drivers/misc/mic/scif/scif_rma_list.c
> deleted file mode 100644
> index ef923ba134c8..000000000000
> --- a/drivers/misc/mic/scif/scif_rma_list.c
> +++ /dev/null
> @@ -1,282 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#include "scif_main.h"
> -#include <linux/mmu_notifier.h>
> -#include <linux/highmem.h>
> -
> -/*
> - * scif_insert_tcw:
> - *
> - * Insert a temp window to the temp registration list sorted by va_for_t=
emp.
> - * RMA lock must be held.
> - */
> -void scif_insert_tcw(struct scif_window *window, struct list_head *head)
> -{
> -	struct scif_window *curr =3D NULL;
> -	struct scif_window *prev =3D list_entry(head, struct scif_window, list)=
;
> -	struct list_head *item;
> -
> -	INIT_LIST_HEAD(&window->list);
> -	/* Compare with tail and if the entry is new tail add it to the end */
> -	if (!list_empty(head)) {
> -		curr =3D list_entry(head->prev, struct scif_window, list);
> -		if (curr->va_for_temp < window->va_for_temp) {
> -			list_add_tail(&window->list, head);
> -			return;
> -		}
> -	}
> -	list_for_each(item, head) {
> -		curr =3D list_entry(item, struct scif_window, list);
> -		if (curr->va_for_temp > window->va_for_temp)
> -			break;
> -		prev =3D curr;
> -	}
> -	list_add(&window->list, &prev->list);
> -}
> -
> -/*
> - * scif_insert_window:
> - *
> - * Insert a window to the self registration list sorted by offset.
> - * RMA lock must be held.
> - */
> -void scif_insert_window(struct scif_window *window, struct list_head
> *head)
> -{
> -	struct scif_window *curr =3D NULL, *prev =3D NULL;
> -	struct list_head *item;
> -
> -	INIT_LIST_HEAD(&window->list);
> -	list_for_each(item, head) {
> -		curr =3D list_entry(item, struct scif_window, list);
> -		if (curr->offset > window->offset)
> -			break;
> -		prev =3D curr;
> -	}
> -	if (!prev)
> -		list_add(&window->list, head);
> -	else
> -		list_add(&window->list, &prev->list);
> -	scif_set_window_ref(window, window->nr_pages);
> -}
> -
> -/*
> - * scif_query_tcw:
> - *
> - * Query the temp cached registration list of ep for an overlapping wind=
ow
> - * in case of permission mismatch, destroy the previous window. if
> permissions
> - * match and overlap is partial, destroy the window but return the new
> range
> - * RMA lock must be held.
> - */
> -int scif_query_tcw(struct scif_endpt *ep, struct scif_rma_req *req)
> -{
> -	struct list_head *item, *temp, *head =3D req->head;
> -	struct scif_window *window;
> -	u64 start_va_window, start_va_req =3D req->va_for_temp;
> -	u64 end_va_window, end_va_req =3D start_va_req + req->nr_bytes;
> -
> -	if (!req->nr_bytes)
> -		return -EINVAL;
> -	/*
> -	 * Avoid traversing the entire list to find out that there
> -	 * is no entry that matches
> -	 */
> -	if (!list_empty(head)) {
> -		window =3D list_last_entry(head, struct scif_window, list);
> -		end_va_window =3D window->va_for_temp +
> -			(window->nr_pages << PAGE_SHIFT);
> -		if (start_va_req > end_va_window)
> -			return -ENXIO;
> -	}
> -	list_for_each_safe(item, temp, head) {
> -		window =3D list_entry(item, struct scif_window, list);
> -		start_va_window =3D window->va_for_temp;
> -		end_va_window =3D window->va_for_temp +
> -			(window->nr_pages << PAGE_SHIFT);
> -		if (start_va_req < start_va_window &&
> -		    end_va_req < start_va_window)
> -			break;
> -		if (start_va_req >=3D end_va_window)
> -			continue;
> -		if ((window->prot & req->prot) =3D=3D req->prot) {
> -			if (start_va_req >=3D start_va_window &&
> -			    end_va_req <=3D end_va_window) {
> -				*req->out_window =3D window;
> -				return 0;
> -			}
> -			/* expand window */
> -			if (start_va_req < start_va_window) {
> -				req->nr_bytes +=3D
> -					start_va_window - start_va_req;
> -				req->va_for_temp =3D start_va_window;
> -			}
> -			if (end_va_req >=3D end_va_window)
> -				req->nr_bytes +=3D end_va_window -
> end_va_req;
> -		}
> -		/* Destroy the old window to create a new one */
> -		__scif_rma_destroy_tcw_helper(window);
> -		break;
> -	}
> -	return -ENXIO;
> -}
> -
> -/*
> - * scif_query_window:
> - *
> - * Query the registration list and check if a valid contiguous
> - * range of windows exist.
> - * RMA lock must be held.
> - */
> -int scif_query_window(struct scif_rma_req *req)
> -{
> -	struct list_head *item;
> -	struct scif_window *window;
> -	s64 end_offset, offset =3D req->offset;
> -	u64 tmp_min, nr_bytes_left =3D req->nr_bytes;
> -
> -	if (!req->nr_bytes)
> -		return -EINVAL;
> -
> -	list_for_each(item, req->head) {
> -		window =3D list_entry(item, struct scif_window, list);
> -		end_offset =3D window->offset +
> -			(window->nr_pages << PAGE_SHIFT);
> -		if (offset < window->offset)
> -			/* Offset not found! */
> -			return -ENXIO;
> -		if (offset >=3D end_offset)
> -			continue;
> -		/* Check read/write protections. */
> -		if ((window->prot & req->prot) !=3D req->prot)
> -			return -EPERM;
> -		if (nr_bytes_left =3D=3D req->nr_bytes)
> -			/* Store the first window */
> -			*req->out_window =3D window;
> -		tmp_min =3D min((u64)end_offset - offset, nr_bytes_left);
> -		nr_bytes_left -=3D tmp_min;
> -		offset +=3D tmp_min;
> -		/*
> -		 * Range requested encompasses
> -		 * multiple windows contiguously.
> -		 */
> -		if (!nr_bytes_left) {
> -			/* Done for partial window */
> -			if (req->type =3D=3D SCIF_WINDOW_PARTIAL ||
> -			    req->type =3D=3D SCIF_WINDOW_SINGLE)
> -				return 0;
> -			/* Extra logic for full windows */
> -			if (offset =3D=3D end_offset)
> -				/* Spanning multiple whole windows */
> -				return 0;
> -				/* Not spanning multiple whole windows */
> -			return -ENXIO;
> -		}
> -		if (req->type =3D=3D SCIF_WINDOW_SINGLE)
> -			break;
> -	}
> -	dev_err(scif_info.mdev.this_device,
> -		"%s %d ENXIO\n", __func__, __LINE__);
> -	return -ENXIO;
> -}
> -
> -/*
> - * scif_rma_list_unregister:
> - *
> - * Traverse the self registration list starting from window:
> - * 1) Call scif_unregister_window(..)
> - * RMA lock must be held.
> - */
> -int scif_rma_list_unregister(struct scif_window *window,
> -			     s64 offset, int nr_pages)
> -{
> -	struct scif_endpt *ep =3D (struct scif_endpt *)window->ep;
> -	struct list_head *head =3D &ep->rma_info.reg_list;
> -	s64 end_offset;
> -	int err =3D 0;
> -	int loop_nr_pages;
> -	struct scif_window *_window;
> -
> -	list_for_each_entry_safe_from(window, _window, head, list) {
> -		end_offset =3D window->offset + (window->nr_pages <<
> PAGE_SHIFT);
> -		loop_nr_pages =3D min((int)((end_offset - offset) >>
> PAGE_SHIFT),
> -				    nr_pages);
> -		err =3D scif_unregister_window(window);
> -		if (err)
> -			return err;
> -		nr_pages -=3D loop_nr_pages;
> -		offset +=3D (loop_nr_pages << PAGE_SHIFT);
> -		if (!nr_pages)
> -			break;
> -	}
> -	return 0;
> -}
> -
> -/*
> - * scif_unmap_all_window:
> - *
> - * Traverse all the windows in the self registration list and:
> - * 1) Delete any DMA mappings created
> - */
> -void scif_unmap_all_windows(scif_epd_t epd)
> -{
> -	struct list_head *item, *tmp;
> -	struct scif_window *window;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct list_head *head =3D &ep->rma_info.reg_list;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -	list_for_each_safe(item, tmp, head) {
> -		window =3D list_entry(item, struct scif_window, list);
> -		scif_unmap_window(ep->remote_dev, window);
> -	}
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -}
> -
> -/*
> - * scif_unregister_all_window:
> - *
> - * Traverse all the windows in the self registration list and:
> - * 1) Call scif_unregister_window(..)
> - * RMA lock must be held.
> - */
> -int scif_unregister_all_windows(scif_epd_t epd)
> -{
> -	struct list_head *item, *tmp;
> -	struct scif_window *window;
> -	struct scif_endpt *ep =3D (struct scif_endpt *)epd;
> -	struct list_head *head =3D &ep->rma_info.reg_list;
> -	int err =3D 0;
> -
> -	mutex_lock(&ep->rma_info.rma_lock);
> -retry:
> -	item =3D NULL;
> -	tmp =3D NULL;
> -	list_for_each_safe(item, tmp, head) {
> -		window =3D list_entry(item, struct scif_window, list);
> -		ep->rma_info.async_list_del =3D 0;
> -		err =3D scif_unregister_window(window);
> -		if (err)
> -			dev_err(scif_info.mdev.this_device,
> -				"%s %d err %d\n",
> -				__func__, __LINE__, err);
> -		/*
> -		 * Need to restart list traversal if there has been
> -		 * an asynchronous list entry deletion.
> -		 */
> -		if (READ_ONCE(ep->rma_info.async_list_del))
> -			goto retry;
> -	}
> -	mutex_unlock(&ep->rma_info.rma_lock);
> -	if (!list_empty(&ep->rma_info.mmn_list)) {
> -		spin_lock(&scif_info.rmalock);
> -		list_add_tail(&ep->mmu_list, &scif_info.mmu_notif_cleanup);
> -		spin_unlock(&scif_info.rmalock);
> -		schedule_work(&scif_info.mmu_notif_work);
> -	}
> -	return err;
> -}
> diff --git a/drivers/misc/mic/scif/scif_rma_list.h
> b/drivers/misc/mic/scif/scif_rma_list.h
> deleted file mode 100644
> index 0f8e0ed65614..000000000000
> --- a/drivers/misc/mic/scif/scif_rma_list.h
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2015 Intel Corporation.
> - *
> - * Intel SCIF driver.
> - */
> -#ifndef SCIF_RMA_LIST_H
> -#define SCIF_RMA_LIST_H
> -
> -/*
> - * struct scif_rma_req - Self Registration list RMA Request query
> - *
> - * @out_window - Returns the window if found
> - * @offset: Starting offset
> - * @nr_bytes: number of bytes
> - * @prot: protection requested i.e. read or write or both
> - * @type: Specify single, partial or multiple windows
> - * @head: Head of list on which to search
> - * @va_for_temp: VA for searching temporary cached windows
> - */
> -struct scif_rma_req {
> -	struct scif_window **out_window;
> -	union {
> -		s64 offset;
> -		unsigned long va_for_temp;
> -	};
> -	size_t nr_bytes;
> -	int prot;
> -	enum scif_window_type type;
> -	struct list_head *head;
> -};
> -
> -/* Insert */
> -void scif_insert_window(struct scif_window *window, struct list_head
> *head);
> -void scif_insert_tcw(struct scif_window *window,
> -		     struct list_head *head);
> -/* Query */
> -int scif_query_window(struct scif_rma_req *request);
> -int scif_query_tcw(struct scif_endpt *ep, struct scif_rma_req *request);
> -/* Called from close to unregister all self windows */
> -int scif_unregister_all_windows(scif_epd_t epd);
> -void scif_unmap_all_windows(scif_epd_t epd);
> -/* Traverse list and unregister */
> -int scif_rma_list_unregister(struct scif_window *window, s64 offset,
> -			     int nr_pages);
> -#endif /* SCIF_RMA_LIST_H */
> diff --git a/drivers/misc/mic/vop/Makefile b/drivers/misc/mic/vop/Makefil=
e
> deleted file mode 100644
> index 51b9b0022786..000000000000
> --- a/drivers/misc/mic/vop/Makefile
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Makefile - Intel MIC Linux driver.
> -# Copyright(c) 2016, Intel Corporation.
> -#
> -obj-$(CONFIG_VOP) :=3D vop.o
> -
> -vop-objs +=3D vop_main.o
> -vop-objs +=3D vop_debugfs.o
> -vop-objs +=3D vop_vringh.o
> diff --git a/drivers/misc/mic/vop/vop_debugfs.c
> b/drivers/misc/mic/vop/vop_debugfs.c
> deleted file mode 100644
> index 9d4f175f4dd1..000000000000
> --- a/drivers/misc/mic/vop/vop_debugfs.c
> +++ /dev/null
> @@ -1,184 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2016 Intel Corporation.
> - *
> - * Intel Virtio Over PCIe (VOP) driver.
> - */
> -#include <linux/debugfs.h>
> -#include <linux/seq_file.h>
> -
> -#include "vop_main.h"
> -
> -static int vop_dp_show(struct seq_file *s, void *pos)
> -{
> -	struct mic_device_desc *d;
> -	struct mic_device_ctrl *dc;
> -	struct mic_vqconfig *vqconfig;
> -	__u32 *features;
> -	__u8 *config;
> -	struct vop_info *vi =3D s->private;
> -	struct vop_device *vpdev =3D vi->vpdev;
> -	struct mic_bootparam *bootparam =3D vpdev->hw_ops-
> >get_dp(vpdev);
> -	int j, k;
> -
> -	seq_printf(s, "Bootparam: magic 0x%x\n",
> -		   bootparam->magic);
> -	seq_printf(s, "Bootparam: h2c_config_db %d\n",
> -		   bootparam->h2c_config_db);
> -	seq_printf(s, "Bootparam: node_id %d\n",
> -		   bootparam->node_id);
> -	seq_printf(s, "Bootparam: c2h_scif_db %d\n",
> -		   bootparam->c2h_scif_db);
> -	seq_printf(s, "Bootparam: h2c_scif_db %d\n",
> -		   bootparam->h2c_scif_db);
> -	seq_printf(s, "Bootparam: scif_host_dma_addr 0x%llx\n",
> -		   bootparam->scif_host_dma_addr);
> -	seq_printf(s, "Bootparam: scif_card_dma_addr 0x%llx\n",
> -		   bootparam->scif_card_dma_addr);
> -
> -	for (j =3D sizeof(*bootparam);
> -		j < MIC_DP_SIZE; j +=3D mic_total_desc_size(d)) {
> -		d =3D (void *)bootparam + j;
> -		dc =3D (void *)d + mic_aligned_desc_size(d);
> -
> -		/* end of list */
> -		if (d->type =3D=3D 0)
> -			break;
> -
> -		if (d->type =3D=3D -1)
> -			continue;
> -
> -		seq_printf(s, "Type %d ", d->type);
> -		seq_printf(s, "Num VQ %d ", d->num_vq);
> -		seq_printf(s, "Feature Len %d\n", d->feature_len);
> -		seq_printf(s, "Config Len %d ", d->config_len);
> -		seq_printf(s, "Shutdown Status %d\n", d->status);
> -
> -		for (k =3D 0; k < d->num_vq; k++) {
> -			vqconfig =3D mic_vq_config(d) + k;
> -			seq_printf(s, "vqconfig[%d]: ", k);
> -			seq_printf(s, "address 0x%llx ",
> -				   vqconfig->address);
> -			seq_printf(s, "num %d ", vqconfig->num);
> -			seq_printf(s, "used address 0x%llx\n",
> -				   vqconfig->used_address);
> -		}
> -
> -		features =3D (__u32 *)mic_vq_features(d);
> -		seq_printf(s, "Features: Host 0x%x ", features[0]);
> -		seq_printf(s, "Guest 0x%x\n", features[1]);
> -
> -		config =3D mic_vq_configspace(d);
> -		for (k =3D 0; k < d->config_len; k++)
> -			seq_printf(s, "config[%d]=3D%d\n", k, config[k]);
> -
> -		seq_puts(s, "Device control:\n");
> -		seq_printf(s, "Config Change %d ", dc->config_change);
> -		seq_printf(s, "Vdev reset %d\n", dc->vdev_reset);
> -		seq_printf(s, "Guest Ack %d ", dc->guest_ack);
> -		seq_printf(s, "Host ack %d\n", dc->host_ack);
> -		seq_printf(s, "Used address updated %d ",
> -			   dc->used_address_updated);
> -		seq_printf(s, "Vdev 0x%llx\n", dc->vdev);
> -		seq_printf(s, "c2h doorbell %d ", dc->c2h_vdev_db);
> -		seq_printf(s, "h2c doorbell %d\n", dc->h2c_vdev_db);
> -	}
> -	schedule_work(&vi->hotplug_work);
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(vop_dp);
> -
> -static int vop_vdev_info_show(struct seq_file *s, void *unused)
> -{
> -	struct vop_info *vi =3D s->private;
> -	struct list_head *pos, *tmp;
> -	struct vop_vdev *vdev;
> -	int i, j;
> -
> -	mutex_lock(&vi->vop_mutex);
> -	list_for_each_safe(pos, tmp, &vi->vdev_list) {
> -		vdev =3D list_entry(pos, struct vop_vdev, list);
> -		seq_printf(s, "VDEV type %d state %s in %ld out %ld
> in_dma %ld out_dma %ld\n",
> -			   vdev->virtio_id,
> -			   vop_vdevup(vdev) ? "UP" : "DOWN",
> -			   vdev->in_bytes,
> -			   vdev->out_bytes,
> -			   vdev->in_bytes_dma,
> -			   vdev->out_bytes_dma);
> -		for (i =3D 0; i < MIC_MAX_VRINGS; i++) {
> -			struct vring_desc *desc;
> -			struct vring_avail *avail;
> -			struct vring_used *used;
> -			struct vop_vringh *vvr =3D &vdev->vvr[i];
> -			struct vringh *vrh =3D &vvr->vrh;
> -			int num =3D vrh->vring.num;
> -
> -			if (!num)
> -				continue;
> -			desc =3D vrh->vring.desc;
> -			seq_printf(s, "vring i %d avail_idx %d",
> -				   i, vvr->vring.info->avail_idx & (num - 1));
> -			seq_printf(s, " vring i %d avail_idx %d\n",
> -				   i, vvr->vring.info->avail_idx);
> -			seq_printf(s, "vrh i %d weak_barriers %d",
> -				   i, vrh->weak_barriers);
> -			seq_printf(s, " last_avail_idx %d last_used_idx %d",
> -				   vrh->last_avail_idx, vrh->last_used_idx);
> -			seq_printf(s, " completed %d\n", vrh->completed);
> -			for (j =3D 0; j < num; j++) {
> -				seq_printf(s, "desc[%d] addr 0x%llx len %d",
> -					   j, desc->addr, desc->len);
> -				seq_printf(s, " flags 0x%x next %d\n",
> -					   desc->flags, desc->next);
> -				desc++;
> -			}
> -			avail =3D vrh->vring.avail;
> -			seq_printf(s, "avail flags 0x%x idx %d\n",
> -				   vringh16_to_cpu(vrh, avail->flags),
> -				   vringh16_to_cpu(vrh,
> -						   avail->idx) & (num - 1));
> -			seq_printf(s, "avail flags 0x%x idx %d\n",
> -				   vringh16_to_cpu(vrh, avail->flags),
> -				   vringh16_to_cpu(vrh, avail->idx));
> -			for (j =3D 0; j < num; j++)
> -				seq_printf(s, "avail ring[%d] %d\n",
> -					   j, avail->ring[j]);
> -			used =3D vrh->vring.used;
> -			seq_printf(s, "used flags 0x%x idx %d\n",
> -				   vringh16_to_cpu(vrh, used->flags),
> -				   vringh16_to_cpu(vrh, used->idx) & (num -
> 1));
> -			seq_printf(s, "used flags 0x%x idx %d\n",
> -				   vringh16_to_cpu(vrh, used->flags),
> -				   vringh16_to_cpu(vrh, used->idx));
> -			for (j =3D 0; j < num; j++)
> -				seq_printf(s, "used ring[%d] id %d len %d\n",
> -					   j, vringh32_to_cpu(vrh,
> -							      used->ring[j].id),
> -					   vringh32_to_cpu(vrh,
> -							   used->ring[j].len));
> -		}
> -	}
> -	mutex_unlock(&vi->vop_mutex);
> -
> -	return 0;
> -}
> -
> -DEFINE_SHOW_ATTRIBUTE(vop_vdev_info);
> -
> -void vop_init_debugfs(struct vop_info *vi)
> -{
> -	char name[16];
> -
> -	snprintf(name, sizeof(name), "%s%d", KBUILD_MODNAME, vi-
> >vpdev->dnode);
> -	vi->dbg =3D debugfs_create_dir(name, NULL);
> -	debugfs_create_file("dp", 0444, vi->dbg, vi, &vop_dp_fops);
> -	debugfs_create_file("vdev_info", 0444, vi->dbg, vi,
> &vop_vdev_info_fops);
> -}
> -
> -void vop_exit_debugfs(struct vop_info *vi)
> -{
> -	debugfs_remove_recursive(vi->dbg);
> -}
> diff --git a/drivers/misc/mic/vop/vop_main.c
> b/drivers/misc/mic/vop/vop_main.c
> deleted file mode 100644
> index 714b94f42d38..000000000000
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ /dev/null
> @@ -1,784 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2016 Intel Corporation.
> - *
> - * Adapted from:
> - *
> - * virtio for kvm on s390
> - *
> - * Copyright IBM Corp. 2008
> - *
> - *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
> - *
> - * Intel Virtio Over PCIe (VOP) driver.
> - */
> -#include <linux/delay.h>
> -#include <linux/module.h>
> -#include <linux/sched.h>
> -#include <linux/dma-mapping.h>
> -#include <linux/io-64-nonatomic-lo-hi.h>
> -
> -#include "vop_main.h"
> -
> -#define VOP_MAX_VRINGS 4
> -
> -/*
> - * _vop_vdev - Allocated per virtio device instance injected by the peer=
.
> - *
> - * @vdev: Virtio device
> - * @desc: Virtio device page descriptor
> - * @dc: Virtio device control
> - * @vpdev: VOP device which is the parent for this virtio device
> - * @vr: Buffer for accessing the VRING
> - * @used_virt: Virtual address of used ring
> - * @used: DMA address of used ring
> - * @used_size: Size of the used buffer
> - * @reset_done: Track whether VOP reset is complete
> - * @virtio_cookie: Cookie returned upon requesting a interrupt
> - * @c2h_vdev_db: The doorbell used by the guest to interrupt the host
> - * @h2c_vdev_db: The doorbell used by the host to interrupt the guest
> - * @dnode: The destination node
> - */
> -struct _vop_vdev {
> -	struct virtio_device vdev;
> -	struct mic_device_desc __iomem *desc;
> -	struct mic_device_ctrl __iomem *dc;
> -	struct vop_device *vpdev;
> -	void __iomem *vr[VOP_MAX_VRINGS];
> -	void *used_virt[VOP_MAX_VRINGS];
> -	dma_addr_t used[VOP_MAX_VRINGS];
> -	int used_size[VOP_MAX_VRINGS];
> -	struct completion reset_done;
> -	struct mic_irq *virtio_cookie;
> -	int c2h_vdev_db;
> -	int h2c_vdev_db;
> -	int dnode;
> -};
> -
> -#define to_vopvdev(vd) container_of(vd, struct _vop_vdev, vdev)
> -
> -#define _vop_aligned_desc_size(d) __mic_align(_vop_desc_size(d), 8)
> -
> -/* Helper API to obtain the parent of the virtio device */
> -static inline struct device *_vop_dev(struct _vop_vdev *vdev)
> -{
> -	return vdev->vdev.dev.parent;
> -}
> -
> -static inline unsigned _vop_desc_size(struct mic_device_desc __iomem
> *desc)
> -{
> -	return sizeof(*desc)
> -		+ ioread8(&desc->num_vq) * sizeof(struct mic_vqconfig)
> -		+ ioread8(&desc->feature_len) * 2
> -		+ ioread8(&desc->config_len);
> -}
> -
> -static inline struct mic_vqconfig __iomem *
> -_vop_vq_config(struct mic_device_desc __iomem *desc)
> -{
> -	return (struct mic_vqconfig __iomem *)(desc + 1);
> -}
> -
> -static inline u8 __iomem *
> -_vop_vq_features(struct mic_device_desc __iomem *desc)
> -{
> -	return (u8 __iomem *)(_vop_vq_config(desc) + ioread8(&desc-
> >num_vq));
> -}
> -
> -static inline u8 __iomem *
> -_vop_vq_configspace(struct mic_device_desc __iomem *desc)
> -{
> -	return _vop_vq_features(desc) + ioread8(&desc->feature_len) * 2;
> -}
> -
> -static inline unsigned
> -_vop_total_desc_size(struct mic_device_desc __iomem *desc)
> -{
> -	return _vop_aligned_desc_size(desc) + sizeof(struct mic_device_ctrl);
> -}
> -
> -/* This gets the device's feature bits. */
> -static u64 vop_get_features(struct virtio_device *vdev)
> -{
> -	unsigned int i, bits;
> -	u64 features =3D 0;
> -	struct mic_device_desc __iomem *desc =3D to_vopvdev(vdev)->desc;
> -	u8 __iomem *in_features =3D _vop_vq_features(desc);
> -	int feature_len =3D ioread8(&desc->feature_len);
> -
> -	bits =3D min_t(unsigned, feature_len, sizeof(vdev->features)) * 8;
> -	for (i =3D 0; i < bits; i++)
> -		if (ioread8(&in_features[i / 8]) & (BIT(i % 8)))
> -			features |=3D BIT_ULL(i);
> -
> -	return features;
> -}
> -
> -static void vop_transport_features(struct virtio_device *vdev)
> -{
> -	/*
> -	 * Packed ring isn't enabled on virtio_vop for now,
> -	 * because virtio_vop uses vring_new_virtqueue() which
> -	 * creates virtio rings on preallocated memory.
> -	 */
> -	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
> -	__virtio_set_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
> -}
> -
> -static int vop_finalize_features(struct virtio_device *vdev)
> -{
> -	unsigned int i, bits;
> -	struct mic_device_desc __iomem *desc =3D to_vopvdev(vdev)->desc;
> -	u8 feature_len =3D ioread8(&desc->feature_len);
> -	/* Second half of bitmap is features we accept. */
> -	u8 __iomem *out_features =3D
> -		_vop_vq_features(desc) + feature_len;
> -
> -	/* Give virtio_ring a chance to accept features. */
> -	vring_transport_features(vdev);
> -
> -	/* Give virtio_vop a chance to accept features. */
> -	vop_transport_features(vdev);
> -
> -	memset_io(out_features, 0, feature_len);
> -	bits =3D min_t(unsigned, feature_len,
> -		     sizeof(vdev->features)) * 8;
> -	for (i =3D 0; i < bits; i++) {
> -		if (__virtio_test_bit(vdev, i))
> -			iowrite8(ioread8(&out_features[i / 8]) | (1 << (i % 8)),
> -				 &out_features[i / 8]);
> -	}
> -	return 0;
> -}
> -
> -/*
> - * Reading and writing elements in config space
> - */
> -static void vop_get(struct virtio_device *vdev, unsigned int offset,
> -		    void *buf, unsigned len)
> -{
> -	struct mic_device_desc __iomem *desc =3D to_vopvdev(vdev)->desc;
> -
> -	if (offset + len > ioread8(&desc->config_len))
> -		return;
> -	memcpy_fromio(buf, _vop_vq_configspace(desc) + offset, len);
> -}
> -
> -static void vop_set(struct virtio_device *vdev, unsigned int offset,
> -		    const void *buf, unsigned len)
> -{
> -	struct mic_device_desc __iomem *desc =3D to_vopvdev(vdev)->desc;
> -
> -	if (offset + len > ioread8(&desc->config_len))
> -		return;
> -	memcpy_toio(_vop_vq_configspace(desc) + offset, buf, len);
> -}
> -
> -/*
> - * The operations to get and set the status word just access the status
> - * field of the device descriptor. set_status also interrupts the host
> - * to tell about status changes.
> - */
> -static u8 vop_get_status(struct virtio_device *vdev)
> -{
> -	return ioread8(&to_vopvdev(vdev)->desc->status);
> -}
> -
> -static void vop_set_status(struct virtio_device *dev, u8 status)
> -{
> -	struct _vop_vdev *vdev =3D to_vopvdev(dev);
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -
> -	if (!status)
> -		return;
> -	iowrite8(status, &vdev->desc->status);
> -	vpdev->hw_ops->send_intr(vpdev, vdev->c2h_vdev_db);
> -}
> -
> -/* Inform host on a virtio device reset and wait for ack from host */
> -static void vop_reset_inform_host(struct virtio_device *dev)
> -{
> -	struct _vop_vdev *vdev =3D to_vopvdev(dev);
> -	struct mic_device_ctrl __iomem *dc =3D vdev->dc;
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	int retry;
> -
> -	iowrite8(0, &dc->host_ack);
> -	iowrite8(1, &dc->vdev_reset);
> -	vpdev->hw_ops->send_intr(vpdev, vdev->c2h_vdev_db);
> -
> -	/* Wait till host completes all card accesses and acks the reset */
> -	for (retry =3D 100; retry--;) {
> -		if (ioread8(&dc->host_ack))
> -			break;
> -		msleep(100);
> -	}
> -
> -	dev_dbg(_vop_dev(vdev), "%s: retry: %d\n", __func__, retry);
> -
> -	/* Reset status to 0 in case we timed out */
> -	iowrite8(0, &vdev->desc->status);
> -}
> -
> -static void vop_reset(struct virtio_device *dev)
> -{
> -	struct _vop_vdev *vdev =3D to_vopvdev(dev);
> -
> -	dev_dbg(_vop_dev(vdev), "%s: virtio id %d\n",
> -		__func__, dev->id.device);
> -
> -	vop_reset_inform_host(dev);
> -	complete_all(&vdev->reset_done);
> -}
> -
> -/*
> - * The virtio_ring code calls this API when it wants to notify the Host.
> - */
> -static bool vop_notify(struct virtqueue *vq)
> -{
> -	struct _vop_vdev *vdev =3D vq->priv;
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -
> -	vpdev->hw_ops->send_intr(vpdev, vdev->c2h_vdev_db);
> -	return true;
> -}
> -
> -static void vop_del_vq(struct virtqueue *vq, int n)
> -{
> -	struct _vop_vdev *vdev =3D to_vopvdev(vq->vdev);
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -
> -	dma_unmap_single(&vpdev->dev, vdev->used[n],
> -			 vdev->used_size[n], DMA_BIDIRECTIONAL);
> -	free_pages((unsigned long)vdev->used_virt[n],
> -		   get_order(vdev->used_size[n]));
> -	vring_del_virtqueue(vq);
> -	vpdev->hw_ops->unmap(vpdev, vdev->vr[n]);
> -	vdev->vr[n] =3D NULL;
> -}
> -
> -static void vop_del_vqs(struct virtio_device *dev)
> -{
> -	struct _vop_vdev *vdev =3D to_vopvdev(dev);
> -	struct virtqueue *vq, *n;
> -	int idx =3D 0;
> -
> -	dev_dbg(_vop_dev(vdev), "%s\n", __func__);
> -
> -	list_for_each_entry_safe(vq, n, &dev->vqs, list)
> -		vop_del_vq(vq, idx++);
> -}
> -
> -static struct virtqueue *vop_new_virtqueue(unsigned int index,
> -				      unsigned int num,
> -				      struct virtio_device *vdev,
> -				      bool context,
> -				      void *pages,
> -				      bool (*notify)(struct virtqueue *vq),
> -				      void (*callback)(struct virtqueue *vq),
> -				      const char *name,
> -				      void *used)
> -{
> -	bool weak_barriers =3D false;
> -	struct vring vring;
> -
> -	vring_init(&vring, num, pages, MIC_VIRTIO_RING_ALIGN);
> -	vring.used =3D used;
> -
> -	return __vring_new_virtqueue(index, vring, vdev, weak_barriers,
> context,
> -				     notify, callback, name);
> -}
> -
> -/*
> - * This routine will assign vring's allocated in host/io memory. Code in
> - * virtio_ring.c however continues to access this io memory as if it wer=
e local
> - * memory without io accessors.
> - */
> -static struct virtqueue *vop_find_vq(struct virtio_device *dev,
> -				     unsigned index,
> -				     void (*callback)(struct virtqueue *vq),
> -				     const char *name, bool ctx)
> -{
> -	struct _vop_vdev *vdev =3D to_vopvdev(dev);
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	struct mic_vqconfig __iomem *vqconfig;
> -	struct mic_vqconfig config;
> -	struct virtqueue *vq;
> -	void __iomem *va;
> -	struct _mic_vring_info __iomem *info;
> -	void *used;
> -	int vr_size, _vr_size, err, magic;
> -	u8 type =3D ioread8(&vdev->desc->type);
> -
> -	if (index >=3D ioread8(&vdev->desc->num_vq))
> -		return ERR_PTR(-ENOENT);
> -
> -	if (!name)
> -		return ERR_PTR(-ENOENT);
> -
> -	/* First assign the vring's allocated in host memory */
> -	vqconfig =3D _vop_vq_config(vdev->desc) + index;
> -	memcpy_fromio(&config, vqconfig, sizeof(config));
> -	_vr_size =3D round_up(vring_size(le16_to_cpu(config.num),
> MIC_VIRTIO_RING_ALIGN), 4);
> -	vr_size =3D PAGE_ALIGN(_vr_size + sizeof(struct _mic_vring_info));
> -	va =3D vpdev->hw_ops->remap(vpdev, le64_to_cpu(config.address),
> vr_size);
> -	if (!va)
> -		return ERR_PTR(-ENOMEM);
> -	vdev->vr[index] =3D va;
> -	memset_io(va, 0x0, _vr_size);
> -
> -	info =3D va + _vr_size;
> -	magic =3D ioread32(&info->magic);
> -
> -	if (WARN(magic !=3D MIC_MAGIC + type + index, "magic mismatch")) {
> -		err =3D -EIO;
> -		goto unmap;
> -	}
> -
> -	vdev->used_size[index] =3D PAGE_ALIGN(sizeof(__u16) * 3 +
> -					     sizeof(struct vring_used_elem) *
> -					     le16_to_cpu(config.num));
> -	used =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					get_order(vdev->used_size[index]));
> -	vdev->used_virt[index] =3D used;
> -	if (!used) {
> -		err =3D -ENOMEM;
> -		dev_err(_vop_dev(vdev), "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto unmap;
> -	}
> -
> -	vq =3D vop_new_virtqueue(index, le16_to_cpu(config.num), dev, ctx,
> -			       (void __force *)va, vop_notify, callback,
> -			       name, used);
> -	if (!vq) {
> -		err =3D -ENOMEM;
> -		goto free_used;
> -	}
> -
> -	vdev->used[index] =3D dma_map_single(&vpdev->dev, used,
> -					    vdev->used_size[index],
> -					    DMA_BIDIRECTIONAL);
> -	if (dma_mapping_error(&vpdev->dev, vdev->used[index])) {
> -		err =3D -ENOMEM;
> -		dev_err(_vop_dev(vdev), "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto del_vq;
> -	}
> -	writeq(vdev->used[index], &vqconfig->used_address);
> -
> -	vq->priv =3D vdev;
> -	return vq;
> -del_vq:
> -	vring_del_virtqueue(vq);
> -free_used:
> -	free_pages((unsigned long)used,
> -		   get_order(vdev->used_size[index]));
> -unmap:
> -	vpdev->hw_ops->unmap(vpdev, vdev->vr[index]);
> -	return ERR_PTR(err);
> -}
> -
> -static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
> -			struct virtqueue *vqs[],
> -			vq_callback_t *callbacks[],
> -			const char * const names[], const bool *ctx,
> -			struct irq_affinity *desc)
> -{
> -	struct _vop_vdev *vdev =3D to_vopvdev(dev);
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	struct mic_device_ctrl __iomem *dc =3D vdev->dc;
> -	int i, err, retry, queue_idx =3D 0;
> -
> -	/* We must have this many virtqueues. */
> -	if (nvqs > ioread8(&vdev->desc->num_vq))
> -		return -ENOENT;
> -
> -	for (i =3D 0; i < nvqs; ++i) {
> -		if (!names[i]) {
> -			vqs[i] =3D NULL;
> -			continue;
> -		}
> -
> -		dev_dbg(_vop_dev(vdev), "%s: %d: %s\n",
> -			__func__, i, names[i]);
> -		vqs[i] =3D vop_find_vq(dev, queue_idx++, callbacks[i], names[i],
> -				     ctx ? ctx[i] : false);
> -		if (IS_ERR(vqs[i])) {
> -			err =3D PTR_ERR(vqs[i]);
> -			goto error;
> -		}
> -	}
> -
> -	iowrite8(1, &dc->used_address_updated);
> -	/*
> -	 * Send an interrupt to the host to inform it that used
> -	 * rings have been re-assigned.
> -	 */
> -	vpdev->hw_ops->send_intr(vpdev, vdev->c2h_vdev_db);
> -	for (retry =3D 100; --retry;) {
> -		if (!ioread8(&dc->used_address_updated))
> -			break;
> -		msleep(100);
> -	}
> -
> -	dev_dbg(_vop_dev(vdev), "%s: retry: %d\n", __func__, retry);
> -	if (!retry) {
> -		err =3D -ENODEV;
> -		goto error;
> -	}
> -
> -	return 0;
> -error:
> -	vop_del_vqs(dev);
> -	return err;
> -}
> -
> -/*
> - * The config ops structure as defined by virtio config
> - */
> -static const struct virtio_config_ops vop_vq_config_ops =3D {
> -	.get_features =3D vop_get_features,
> -	.finalize_features =3D vop_finalize_features,
> -	.get =3D vop_get,
> -	.set =3D vop_set,
> -	.get_status =3D vop_get_status,
> -	.set_status =3D vop_set_status,
> -	.reset =3D vop_reset,
> -	.find_vqs =3D vop_find_vqs,
> -	.del_vqs =3D vop_del_vqs,
> -};
> -
> -static irqreturn_t vop_virtio_intr_handler(int irq, void *data)
> -{
> -	struct _vop_vdev *vdev =3D data;
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	struct virtqueue *vq;
> -
> -	vpdev->hw_ops->ack_interrupt(vpdev, vdev->h2c_vdev_db);
> -	list_for_each_entry(vq, &vdev->vdev.vqs, list)
> -		vring_interrupt(0, vq);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static void vop_virtio_release_dev(struct device *_d)
> -{
> -	struct virtio_device *vdev =3D
> -			container_of(_d, struct virtio_device, dev);
> -	struct _vop_vdev *vop_vdev =3D
> -			container_of(vdev, struct _vop_vdev, vdev);
> -
> -	kfree(vop_vdev);
> -}
> -
> -/*
> - * adds a new device and register it with virtio
> - * appropriate drivers are loaded by the device model
> - */
> -static int _vop_add_device(struct mic_device_desc __iomem *d,
> -			   unsigned int offset, struct vop_device *vpdev,
> -			   int dnode)
> -{
> -	struct _vop_vdev *vdev, *reg_dev =3D NULL;
> -	int ret;
> -	u8 type =3D ioread8(&d->type);
> -
> -	vdev =3D kzalloc(sizeof(*vdev), GFP_KERNEL);
> -	if (!vdev)
> -		return -ENOMEM;
> -
> -	vdev->vpdev =3D vpdev;
> -	vdev->vdev.dev.parent =3D &vpdev->dev;
> -	vdev->vdev.dev.release =3D vop_virtio_release_dev;
> -	vdev->vdev.id.device =3D type;
> -	vdev->vdev.config =3D &vop_vq_config_ops;
> -	vdev->desc =3D d;
> -	vdev->dc =3D (void __iomem *)d + _vop_aligned_desc_size(d);
> -	vdev->dnode =3D dnode;
> -	vdev->vdev.priv =3D (void *)(unsigned long)dnode;
> -	init_completion(&vdev->reset_done);
> -
> -	vdev->h2c_vdev_db =3D vpdev->hw_ops->next_db(vpdev);
> -	vdev->virtio_cookie =3D vpdev->hw_ops->request_irq(vpdev,
> -			vop_virtio_intr_handler, "virtio intr",
> -			vdev, vdev->h2c_vdev_db);
> -	if (IS_ERR(vdev->virtio_cookie)) {
> -		ret =3D PTR_ERR(vdev->virtio_cookie);
> -		goto kfree;
> -	}
> -	iowrite8((u8)vdev->h2c_vdev_db, &vdev->dc->h2c_vdev_db);
> -	vdev->c2h_vdev_db =3D ioread8(&vdev->dc->c2h_vdev_db);
> -
> -	ret =3D register_virtio_device(&vdev->vdev);
> -	reg_dev =3D vdev;
> -	if (ret) {
> -		dev_err(_vop_dev(vdev),
> -			"Failed to register vop device %u type %u\n",
> -			offset, type);
> -		goto free_irq;
> -	}
> -	writeq((unsigned long)vdev, &vdev->dc->vdev);
> -	dev_dbg(_vop_dev(vdev), "%s: registered vop device %u type %u
> vdev %p\n",
> -		__func__, offset, type, vdev);
> -
> -	return 0;
> -
> -free_irq:
> -	vpdev->hw_ops->free_irq(vpdev, vdev->virtio_cookie, vdev);
> -kfree:
> -	if (reg_dev)
> -		put_device(&vdev->vdev.dev);
> -	else
> -		kfree(vdev);
> -	return ret;
> -}
> -
> -/*
> - * match for a vop device with a specific desc pointer
> - */
> -static int vop_match_desc(struct device *dev, void *data)
> -{
> -	struct virtio_device *_dev =3D dev_to_virtio(dev);
> -	struct _vop_vdev *vdev =3D to_vopvdev(_dev);
> -
> -	return vdev->desc =3D=3D (void __iomem *)data;
> -}
> -
> -static struct _vop_vdev *vop_dc_to_vdev(struct mic_device_ctrl __iomem
> *dc)
> -{
> -	return (struct _vop_vdev *)(unsigned long)readq(&dc->vdev);
> -}
> -
> -static void _vop_handle_config_change(struct mic_device_desc __iomem *d,
> -				      unsigned int offset,
> -				      struct vop_device *vpdev)
> -{
> -	struct mic_device_ctrl __iomem *dc
> -		=3D (void __iomem *)d + _vop_aligned_desc_size(d);
> -	struct _vop_vdev *vdev =3D vop_dc_to_vdev(dc);
> -
> -	if (ioread8(&dc->config_change) !=3D
> MIC_VIRTIO_PARAM_CONFIG_CHANGED)
> -		return;
> -
> -	dev_dbg(&vpdev->dev, "%s %d\n", __func__, __LINE__);
> -	virtio_config_changed(&vdev->vdev);
> -	iowrite8(1, &dc->guest_ack);
> -}
> -
> -/*
> - * removes a virtio device if a hot remove event has been
> - * requested by the host.
> - */
> -static int _vop_remove_device(struct mic_device_desc __iomem *d,
> -			      unsigned int offset, struct vop_device *vpdev)
> -{
> -	struct mic_device_ctrl __iomem *dc
> -		=3D (void __iomem *)d + _vop_aligned_desc_size(d);
> -	struct _vop_vdev *vdev =3D vop_dc_to_vdev(dc);
> -	u8 status;
> -	int ret =3D -1;
> -
> -	if (ioread8(&dc->config_change) =3D=3D
> MIC_VIRTIO_PARAM_DEV_REMOVE) {
> -		struct device *dev =3D get_device(&vdev->vdev.dev);
> -
> -		dev_dbg(&vpdev->dev,
> -			"%s %d config_change %d type %d vdev %p\n",
> -			__func__, __LINE__,
> -			ioread8(&dc->config_change), ioread8(&d->type),
> vdev);
> -		status =3D ioread8(&d->status);
> -		reinit_completion(&vdev->reset_done);
> -		unregister_virtio_device(&vdev->vdev);
> -		vpdev->hw_ops->free_irq(vpdev, vdev->virtio_cookie, vdev);
> -		iowrite8(-1, &dc->h2c_vdev_db);
> -		if (status & VIRTIO_CONFIG_S_DRIVER_OK)
> -			wait_for_completion(&vdev->reset_done);
> -		put_device(dev);
> -		iowrite8(1, &dc->guest_ack);
> -		dev_dbg(&vpdev->dev, "%s %d guest_ack %d\n",
> -			__func__, __LINE__, ioread8(&dc->guest_ack));
> -		iowrite8(-1, &d->type);
> -		ret =3D 0;
> -	}
> -	return ret;
> -}
> -
> -#define REMOVE_DEVICES true
> -
> -static void _vop_scan_devices(void __iomem *dp, struct vop_device *vpdev=
,
> -			      bool remove, int dnode)
> -{
> -	s8 type;
> -	unsigned int i;
> -	struct mic_device_desc __iomem *d;
> -	struct mic_device_ctrl __iomem *dc;
> -	struct device *dev;
> -
> -	for (i =3D sizeof(struct mic_bootparam);
> -			i < MIC_DP_SIZE; i +=3D _vop_total_desc_size(d)) {
> -		d =3D dp + i;
> -		dc =3D (void __iomem *)d + _vop_aligned_desc_size(d);
> -		/*
> -		 * This read barrier is paired with the corresponding write
> -		 * barrier on the host which is inserted before adding or
> -		 * removing a virtio device descriptor, by updating the type.
> -		 */
> -		rmb();
> -		type =3D ioread8(&d->type);
> -
> -		/* end of list */
> -		if (type =3D=3D 0)
> -			break;
> -
> -		if (type =3D=3D -1)
> -			continue;
> -
> -		/* device already exists */
> -		dev =3D device_find_child(&vpdev->dev, (void __force *)d,
> -					vop_match_desc);
> -		if (dev) {
> -			if (remove)
> -				iowrite8(MIC_VIRTIO_PARAM_DEV_REMOVE,
> -					 &dc->config_change);
> -			put_device(dev);
> -			_vop_handle_config_change(d, i, vpdev);
> -			_vop_remove_device(d, i, vpdev);
> -			if (remove) {
> -				iowrite8(0, &dc->config_change);
> -				iowrite8(0, &dc->guest_ack);
> -			}
> -			continue;
> -		}
> -
> -		/* new device */
> -		dev_dbg(&vpdev->dev, "%s %d Adding new virtio
> device %p\n",
> -			__func__, __LINE__, d);
> -		if (!remove)
> -			_vop_add_device(d, i, vpdev, dnode);
> -	}
> -}
> -
> -static void vop_scan_devices(struct vop_info *vi,
> -			     struct vop_device *vpdev, bool remove)
> -{
> -	void __iomem *dp =3D vpdev->hw_ops->get_remote_dp(vpdev);
> -
> -	if (!dp)
> -		return;
> -	mutex_lock(&vi->vop_mutex);
> -	_vop_scan_devices(dp, vpdev, remove, vpdev->dnode);
> -	mutex_unlock(&vi->vop_mutex);
> -}
> -
> -/*
> - * vop_hotplug_device tries to find changes in the device page.
> - */
> -static void vop_hotplug_devices(struct work_struct *work)
> -{
> -	struct vop_info *vi =3D container_of(work, struct vop_info,
> -					     hotplug_work);
> -
> -	vop_scan_devices(vi, vi->vpdev, !REMOVE_DEVICES);
> -}
> -
> -/*
> - * Interrupt handler for hot plug/config changes etc.
> - */
> -static irqreturn_t vop_extint_handler(int irq, void *data)
> -{
> -	struct vop_info *vi =3D data;
> -	struct mic_bootparam __iomem *bp;
> -	struct vop_device *vpdev =3D vi->vpdev;
> -
> -	bp =3D vpdev->hw_ops->get_remote_dp(vpdev);
> -	dev_dbg(&vpdev->dev, "%s %d hotplug work\n",
> -		__func__, __LINE__);
> -	vpdev->hw_ops->ack_interrupt(vpdev, ioread8(&bp-
> >h2c_config_db));
> -	schedule_work(&vi->hotplug_work);
> -	return IRQ_HANDLED;
> -}
> -
> -static int vop_driver_probe(struct vop_device *vpdev)
> -{
> -	struct vop_info *vi;
> -	int rc;
> -
> -	vi =3D kzalloc(sizeof(*vi), GFP_KERNEL);
> -	if (!vi) {
> -		rc =3D -ENOMEM;
> -		goto exit;
> -	}
> -	dev_set_drvdata(&vpdev->dev, vi);
> -	vi->vpdev =3D vpdev;
> -
> -	mutex_init(&vi->vop_mutex);
> -	INIT_WORK(&vi->hotplug_work, vop_hotplug_devices);
> -	if (vpdev->dnode) {
> -		rc =3D vop_host_init(vi);
> -		if (rc < 0)
> -			goto free;
> -	} else {
> -		struct mic_bootparam __iomem *bootparam;
> -
> -		vop_scan_devices(vi, vpdev, !REMOVE_DEVICES);
> -
> -		vi->h2c_config_db =3D vpdev->hw_ops->next_db(vpdev);
> -		vi->cookie =3D vpdev->hw_ops->request_irq(vpdev,
> -							vop_extint_handler,
> -							"virtio_config_intr",
> -							vi, vi->h2c_config_db);
> -		if (IS_ERR(vi->cookie)) {
> -			rc =3D PTR_ERR(vi->cookie);
> -			goto free;
> -		}
> -		bootparam =3D vpdev->hw_ops->get_remote_dp(vpdev);
> -		iowrite8(vi->h2c_config_db, &bootparam->h2c_config_db);
> -	}
> -	vop_init_debugfs(vi);
> -	return 0;
> -free:
> -	kfree(vi);
> -exit:
> -	return rc;
> -}
> -
> -static void vop_driver_remove(struct vop_device *vpdev)
> -{
> -	struct vop_info *vi =3D dev_get_drvdata(&vpdev->dev);
> -
> -	if (vpdev->dnode) {
> -		vop_host_uninit(vi);
> -	} else {
> -		struct mic_bootparam __iomem *bootparam =3D
> -			vpdev->hw_ops->get_remote_dp(vpdev);
> -		if (bootparam)
> -			iowrite8(-1, &bootparam->h2c_config_db);
> -		vpdev->hw_ops->free_irq(vpdev, vi->cookie, vi);
> -		flush_work(&vi->hotplug_work);
> -		vop_scan_devices(vi, vpdev, REMOVE_DEVICES);
> -	}
> -	vop_exit_debugfs(vi);
> -	kfree(vi);
> -}
> -
> -static const struct vop_device_id id_table[] =3D {
> -	{ VOP_DEV_TRNSP, VOP_DEV_ANY_ID },
> -	{ 0 },
> -};
> -
> -static struct vop_driver vop_driver =3D {
> -	.driver.name =3D	KBUILD_MODNAME,
> -	.driver.owner =3D	THIS_MODULE,
> -	.id_table =3D id_table,
> -	.probe =3D vop_driver_probe,
> -	.remove =3D vop_driver_remove,
> -};
> -
> -module_vop_driver(vop_driver);
> -
> -MODULE_DEVICE_TABLE(mbus, id_table);
> -MODULE_AUTHOR("Intel Corporation");
> -MODULE_DESCRIPTION("Intel(R) Virtio Over PCIe (VOP) driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mic/vop/vop_main.h
> b/drivers/misc/mic/vop/vop_main.h
> deleted file mode 100644
> index 2451d9218137..000000000000
> --- a/drivers/misc/mic/vop/vop_main.h
> +++ /dev/null
> @@ -1,158 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2016 Intel Corporation.
> - *
> - * Intel Virtio Over PCIe (VOP) driver.
> - */
> -#ifndef _VOP_MAIN_H_
> -#define _VOP_MAIN_H_
> -
> -#include <linux/vringh.h>
> -#include <linux/virtio_config.h>
> -#include <linux/virtio.h>
> -#include <linux/miscdevice.h>
> -
> -#include <linux/mic_common.h>
> -#include "../common/mic_dev.h"
> -
> -#include "../bus/vop_bus.h"
> -
> -/*
> - * Note on endianness.
> - * 1. Host can be both BE or LE
> - * 2. Guest/card is LE. Host uses le_to_cpu to access desc/avail
> - *    rings and ioreadXX/iowriteXX to access used ring.
> - * 3. Device page exposed by host to guest contains LE values. Guest
> - *    accesses these using ioreadXX/iowriteXX etc. This way in general w=
e
> - *    obey the virtio spec according to which guest works with native
> - *    endianness and host is aware of guest endianness and does all
> - *    required endianness conversion.
> - * 4. Data provided from user space to guest (in ADD_DEVICE and
> - *    CONFIG_CHANGE ioctl's) is not interpreted by the driver and should=
 be
> - *    in guest endianness.
> - */
> -
> -/*
> - * vop_info - Allocated per invocation of VOP probe
> - *
> - * @vpdev: VOP device
> - * @hotplug_work: Handle virtio device creation, deletion and configurat=
ion
> - * @cookie: Cookie received upon requesting a virtio configuration inter=
rupt
> - * @h2c_config_db: The doorbell used by the peer to indicate a config
> change
> - * @vdev_list: List of "active" virtio devices injected in the peer node
> - * @vop_mutex: Synchronize access to the device page as well as serializ=
e
> - *             creation/deletion of virtio devices on the peer node
> - * @dp: Peer device page information
> - * @dbg: Debugfs entry
> - * @dma_ch: The DMA channel used by this transport for data transfers.
> - * @name: Name for this transport used in misc device creation.
> - * @miscdev: The misc device registered.
> - */
> -struct vop_info {
> -	struct vop_device *vpdev;
> -	struct work_struct hotplug_work;
> -	struct mic_irq *cookie;
> -	int h2c_config_db;
> -	struct list_head vdev_list;
> -	struct mutex vop_mutex;
> -	void __iomem *dp;
> -	struct dentry *dbg;
> -	struct dma_chan *dma_ch;
> -	char name[16];
> -	struct miscdevice miscdev;
> -};
> -
> -/**
> - * struct vop_vringh - Virtio ring host information.
> - *
> - * @vring: The VOP vring used for setting up user space mappings.
> - * @vrh: The host VRINGH used for accessing the card vrings.
> - * @riov: The VRINGH read kernel IOV.
> - * @wiov: The VRINGH write kernel IOV.
> - * @head: The VRINGH head index address passed to
> vringh_getdesc_kern(..).
> - * @vr_mutex: Mutex for synchronizing access to the VRING.
> - * @buf: Temporary kernel buffer used to copy in/out data
> - * from/to the card via DMA.
> - * @buf_da: dma address of buf.
> - * @vdev: Back pointer to VOP virtio device for vringh_notify(..).
> - */
> -struct vop_vringh {
> -	struct mic_vring vring;
> -	struct vringh vrh;
> -	struct vringh_kiov riov;
> -	struct vringh_kiov wiov;
> -	u16 head;
> -	struct mutex vr_mutex;
> -	void *buf;
> -	dma_addr_t buf_da;
> -	struct vop_vdev *vdev;
> -};
> -
> -/**
> - * struct vop_vdev - Host information for a card Virtio device.
> - *
> - * @virtio_id - Virtio device id.
> - * @waitq - Waitqueue to allow ring3 apps to poll.
> - * @vpdev - pointer to VOP bus device.
> - * @poll_wake - Used for waking up threads blocked in poll.
> - * @out_bytes - Debug stats for number of bytes copied from host to card=
.
> - * @in_bytes - Debug stats for number of bytes copied from card to host.
> - * @out_bytes_dma - Debug stats for number of bytes copied from host to
> card
> - * using DMA.
> - * @in_bytes_dma - Debug stats for number of bytes copied from card to
> host
> - * using DMA.
> - * @tx_len_unaligned - Debug stats for number of bytes copied to the car=
d
> where
> - * the transfer length did not have the required DMA alignment.
> - * @tx_dst_unaligned - Debug stats for number of bytes copied where the
> - * destination address on the card did not have the required DMA alignme=
nt.
> - * @vvr - Store per VRING data structures.
> - * @virtio_bh_work - Work struct used to schedule virtio bottom half
> handling.
> - * @dd - Virtio device descriptor.
> - * @dc - Virtio device control fields.
> - * @list - List of Virtio devices.
> - * @virtio_db - The doorbell used by the card to interrupt the host.
> - * @virtio_cookie - The cookie returned while requesting interrupts.
> - * @vi: Transport information.
> - * @vdev_mutex: Mutex synchronizing virtio device injection,
> - *              removal and data transfers.
> - * @destroy: Track if a virtio device is being destroyed.
> - * @deleted: The virtio device has been deleted.
> - */
> -struct vop_vdev {
> -	int virtio_id;
> -	wait_queue_head_t waitq;
> -	struct vop_device *vpdev;
> -	int poll_wake;
> -	unsigned long out_bytes;
> -	unsigned long in_bytes;
> -	unsigned long out_bytes_dma;
> -	unsigned long in_bytes_dma;
> -	unsigned long tx_len_unaligned;
> -	unsigned long tx_dst_unaligned;
> -	unsigned long rx_dst_unaligned;
> -	struct vop_vringh vvr[MIC_MAX_VRINGS];
> -	struct work_struct virtio_bh_work;
> -	struct mic_device_desc *dd;
> -	struct mic_device_ctrl *dc;
> -	struct list_head list;
> -	int virtio_db;
> -	struct mic_irq *virtio_cookie;
> -	struct vop_info *vi;
> -	struct mutex vdev_mutex;
> -	struct completion destroy;
> -	bool deleted;
> -};
> -
> -/* Helper API to check if a virtio device is running */
> -static inline bool vop_vdevup(struct vop_vdev *vdev)
> -{
> -	return !!vdev->dd->status;
> -}
> -
> -void vop_init_debugfs(struct vop_info *vi);
> -void vop_exit_debugfs(struct vop_info *vi);
> -int vop_host_init(struct vop_info *vi);
> -void vop_host_uninit(struct vop_info *vi);
> -#endif
> diff --git a/drivers/misc/mic/vop/vop_vringh.c
> b/drivers/misc/mic/vop/vop_vringh.c
> deleted file mode 100644
> index 7014ffe88632..000000000000
> --- a/drivers/misc/mic/vop/vop_vringh.c
> +++ /dev/null
> @@ -1,1166 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2016 Intel Corporation.
> - *
> - * Intel Virtio Over PCIe (VOP) driver.
> - */
> -#include <linux/sched.h>
> -#include <linux/poll.h>
> -#include <linux/dma-mapping.h>
> -
> -#include <linux/mic_common.h>
> -#include "../common/mic_dev.h"
> -
> -#include <linux/mic_ioctl.h>
> -#include "vop_main.h"
> -
> -/* Helper API to obtain the VOP PCIe device */
> -static inline struct device *vop_dev(struct vop_vdev *vdev)
> -{
> -	return vdev->vpdev->dev.parent;
> -}
> -
> -/* Helper API to check if a virtio device is initialized */
> -static inline int vop_vdev_inited(struct vop_vdev *vdev)
> -{
> -	if (!vdev)
> -		return -EINVAL;
> -	/* Device has not been created yet */
> -	if (!vdev->dd || !vdev->dd->type) {
> -		dev_err(vop_dev(vdev), "%s %d err %d\n",
> -			__func__, __LINE__, -EINVAL);
> -		return -EINVAL;
> -	}
> -	/* Device has been removed/deleted */
> -	if (vdev->dd->type =3D=3D -1) {
> -		dev_dbg(vop_dev(vdev), "%s %d err %d\n",
> -			__func__, __LINE__, -ENODEV);
> -		return -ENODEV;
> -	}
> -	return 0;
> -}
> -
> -static void _vop_notify(struct vringh *vrh)
> -{
> -	struct vop_vringh *vvrh =3D container_of(vrh, struct vop_vringh, vrh);
> -	struct vop_vdev *vdev =3D vvrh->vdev;
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	s8 db =3D vdev->dc->h2c_vdev_db;
> -
> -	if (db !=3D -1)
> -		vpdev->hw_ops->send_intr(vpdev, db);
> -}
> -
> -static void vop_virtio_init_post(struct vop_vdev *vdev)
> -{
> -	struct mic_vqconfig *vqconfig =3D mic_vq_config(vdev->dd);
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	int i, used_size;
> -
> -	for (i =3D 0; i < vdev->dd->num_vq; i++) {
> -		used_size =3D PAGE_ALIGN(sizeof(u16) * 3 +
> -				sizeof(struct vring_used_elem) *
> -				le16_to_cpu(vqconfig->num));
> -		if (!le64_to_cpu(vqconfig[i].used_address)) {
> -			dev_warn(vop_dev(vdev), "used_address zero??\n");
> -			continue;
> -		}
> -		vdev->vvr[i].vrh.vring.used =3D
> -			(void __force *)vpdev->hw_ops->remap(
> -			vpdev,
> -			le64_to_cpu(vqconfig[i].used_address),
> -			used_size);
> -	}
> -
> -	vdev->dc->used_address_updated =3D 0;
> -
> -	dev_info(vop_dev(vdev), "%s: device type %d LINKUP\n",
> -		 __func__, vdev->virtio_id);
> -}
> -
> -static inline void vop_virtio_device_reset(struct vop_vdev *vdev)
> -{
> -	int i;
> -
> -	dev_dbg(vop_dev(vdev), "%s: status %d device type %d RESET\n",
> -		__func__, vdev->dd->status, vdev->virtio_id);
> -
> -	for (i =3D 0; i < vdev->dd->num_vq; i++)
> -		/*
> -		 * Avoid lockdep false positive. The + 1 is for the vop
> -		 * mutex which is held in the reset devices code path.
> -		 */
> -		mutex_lock_nested(&vdev->vvr[i].vr_mutex, i + 1);
> -
> -	/* 0 status means "reset" */
> -	vdev->dd->status =3D 0;
> -	vdev->dc->vdev_reset =3D 0;
> -	vdev->dc->host_ack =3D 1;
> -
> -	for (i =3D 0; i < vdev->dd->num_vq; i++) {
> -		struct vringh *vrh =3D &vdev->vvr[i].vrh;
> -
> -		vdev->vvr[i].vring.info->avail_idx =3D 0;
> -		vrh->completed =3D 0;
> -		vrh->last_avail_idx =3D 0;
> -		vrh->last_used_idx =3D 0;
> -	}
> -
> -	for (i =3D 0; i < vdev->dd->num_vq; i++)
> -		mutex_unlock(&vdev->vvr[i].vr_mutex);
> -}
> -
> -static void vop_virtio_reset_devices(struct vop_info *vi)
> -{
> -	struct list_head *pos, *tmp;
> -	struct vop_vdev *vdev;
> -
> -	list_for_each_safe(pos, tmp, &vi->vdev_list) {
> -		vdev =3D list_entry(pos, struct vop_vdev, list);
> -		vop_virtio_device_reset(vdev);
> -		vdev->poll_wake =3D 1;
> -		wake_up(&vdev->waitq);
> -	}
> -}
> -
> -static void vop_bh_handler(struct work_struct *work)
> -{
> -	struct vop_vdev *vdev =3D container_of(work, struct vop_vdev,
> -			virtio_bh_work);
> -
> -	if (vdev->dc->used_address_updated)
> -		vop_virtio_init_post(vdev);
> -
> -	if (vdev->dc->vdev_reset)
> -		vop_virtio_device_reset(vdev);
> -
> -	vdev->poll_wake =3D 1;
> -	wake_up(&vdev->waitq);
> -}
> -
> -static irqreturn_t _vop_virtio_intr_handler(int irq, void *data)
> -{
> -	struct vop_vdev *vdev =3D data;
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -
> -	vpdev->hw_ops->ack_interrupt(vpdev, vdev->virtio_db);
> -	schedule_work(&vdev->virtio_bh_work);
> -	return IRQ_HANDLED;
> -}
> -
> -static int vop_virtio_config_change(struct vop_vdev *vdev, void *argp)
> -{
> -	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wake);
> -	int ret =3D 0, retry, i;
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	struct vop_info *vi =3D dev_get_drvdata(&vpdev->dev);
> -	struct mic_bootparam *bootparam =3D vpdev->hw_ops-
> >get_dp(vpdev);
> -	s8 db =3D bootparam->h2c_config_db;
> -
> -	mutex_lock(&vi->vop_mutex);
> -	for (i =3D 0; i < vdev->dd->num_vq; i++)
> -		mutex_lock_nested(&vdev->vvr[i].vr_mutex, i + 1);
> -
> -	if (db =3D=3D -1 || vdev->dd->type =3D=3D -1) {
> -		ret =3D -EIO;
> -		goto exit;
> -	}
> -
> -	memcpy(mic_vq_configspace(vdev->dd), argp, vdev->dd-
> >config_len);
> -	vdev->dc->config_change =3D MIC_VIRTIO_PARAM_CONFIG_CHANGED;
> -	vpdev->hw_ops->send_intr(vpdev, db);
> -
> -	for (retry =3D 100; retry--;) {
> -		ret =3D wait_event_timeout(wake, vdev->dc->guest_ack,
> -					 msecs_to_jiffies(100));
> -		if (ret)
> -			break;
> -	}
> -
> -	dev_dbg(vop_dev(vdev),
> -		"%s %d retry: %d\n", __func__, __LINE__, retry);
> -	vdev->dc->config_change =3D 0;
> -	vdev->dc->guest_ack =3D 0;
> -exit:
> -	for (i =3D 0; i < vdev->dd->num_vq; i++)
> -		mutex_unlock(&vdev->vvr[i].vr_mutex);
> -	mutex_unlock(&vi->vop_mutex);
> -	return ret;
> -}
> -
> -static int vop_copy_dp_entry(struct vop_vdev *vdev,
> -			     struct mic_device_desc *argp, __u8 *type,
> -			     struct mic_device_desc **devpage)
> -{
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	struct mic_device_desc *devp;
> -	struct mic_vqconfig *vqconfig;
> -	int ret =3D 0, i;
> -	bool slot_found =3D false;
> -
> -	vqconfig =3D mic_vq_config(argp);
> -	for (i =3D 0; i < argp->num_vq; i++) {
> -		if (le16_to_cpu(vqconfig[i].num) >
> MIC_MAX_VRING_ENTRIES) {
> -			ret =3D  -EINVAL;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			goto exit;
> -		}
> -	}
> -
> -	/* Find the first free device page entry */
> -	for (i =3D sizeof(struct mic_bootparam);
> -		i < MIC_DP_SIZE - mic_total_desc_size(argp);
> -		i +=3D mic_total_desc_size(devp)) {
> -		devp =3D vpdev->hw_ops->get_dp(vpdev) + i;
> -		if (devp->type =3D=3D 0 || devp->type =3D=3D -1) {
> -			slot_found =3D true;
> -			break;
> -		}
> -	}
> -	if (!slot_found) {
> -		ret =3D  -EINVAL;
> -		dev_err(vop_dev(vdev), "%s %d err %d\n",
> -			__func__, __LINE__, ret);
> -		goto exit;
> -	}
> -	/*
> -	 * Save off the type before doing the memcpy. Type will be set in the
> -	 * end after completing all initialization for the new device.
> -	 */
> -	*type =3D argp->type;
> -	argp->type =3D 0;
> -	memcpy(devp, argp, mic_desc_size(argp));
> -
> -	*devpage =3D devp;
> -exit:
> -	return ret;
> -}
> -
> -static void vop_init_device_ctrl(struct vop_vdev *vdev,
> -				 struct mic_device_desc *devpage)
> -{
> -	struct mic_device_ctrl *dc;
> -
> -	dc =3D (void *)devpage + mic_aligned_desc_size(devpage);
> -
> -	dc->config_change =3D 0;
> -	dc->guest_ack =3D 0;
> -	dc->vdev_reset =3D 0;
> -	dc->host_ack =3D 0;
> -	dc->used_address_updated =3D 0;
> -	dc->c2h_vdev_db =3D -1;
> -	dc->h2c_vdev_db =3D -1;
> -	vdev->dc =3D dc;
> -}
> -
> -static int vop_virtio_add_device(struct vop_vdev *vdev,
> -				 struct mic_device_desc *argp)
> -{
> -	struct vop_info *vi =3D vdev->vi;
> -	struct vop_device *vpdev =3D vi->vpdev;
> -	struct mic_device_desc *dd =3D NULL;
> -	struct mic_vqconfig *vqconfig;
> -	int vr_size, i, j, ret;
> -	u8 type =3D 0;
> -	s8 db =3D -1;
> -	char irqname[16];
> -	struct mic_bootparam *bootparam;
> -	u16 num;
> -	dma_addr_t vr_addr;
> -
> -	bootparam =3D vpdev->hw_ops->get_dp(vpdev);
> -	init_waitqueue_head(&vdev->waitq);
> -	INIT_LIST_HEAD(&vdev->list);
> -	vdev->vpdev =3D vpdev;
> -
> -	ret =3D vop_copy_dp_entry(vdev, argp, &type, &dd);
> -	if (ret) {
> -		dev_err(vop_dev(vdev), "%s %d err %d\n",
> -			__func__, __LINE__, ret);
> -		return ret;
> -	}
> -
> -	vop_init_device_ctrl(vdev, dd);
> -
> -	vdev->dd =3D dd;
> -	vdev->virtio_id =3D type;
> -	vqconfig =3D mic_vq_config(dd);
> -	INIT_WORK(&vdev->virtio_bh_work, vop_bh_handler);
> -
> -	for (i =3D 0; i < dd->num_vq; i++) {
> -		struct vop_vringh *vvr =3D &vdev->vvr[i];
> -		struct mic_vring *vr =3D &vdev->vvr[i].vring;
> -
> -		num =3D le16_to_cpu(vqconfig[i].num);
> -		mutex_init(&vvr->vr_mutex);
> -		vr_size =3D PAGE_ALIGN(round_up(vring_size(num,
> MIC_VIRTIO_RING_ALIGN), 4) +
> -			sizeof(struct _mic_vring_info));
> -		vr->va =3D (void *)
> -			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> -					 get_order(vr_size));
> -		if (!vr->va) {
> -			ret =3D -ENOMEM;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			goto err;
> -		}
> -		vr->len =3D vr_size;
> -		vr->info =3D vr->va + round_up(vring_size(num,
> MIC_VIRTIO_RING_ALIGN), 4);
> -		vr->info->magic =3D cpu_to_le32(MIC_MAGIC + vdev->virtio_id
> + i);
> -		vr_addr =3D dma_map_single(&vpdev->dev, vr->va, vr_size,
> -					 DMA_BIDIRECTIONAL);
> -		if (dma_mapping_error(&vpdev->dev, vr_addr)) {
> -			free_pages((unsigned long)vr->va,
> get_order(vr_size));
> -			ret =3D -ENOMEM;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			goto err;
> -		}
> -		vqconfig[i].address =3D cpu_to_le64(vr_addr);
> -
> -		vring_init(&vr->vr, num, vr->va, MIC_VIRTIO_RING_ALIGN);
> -		ret =3D vringh_init_kern(&vvr->vrh,
> -				       *(u32 *)mic_vq_features(vdev->dd),
> -				       num, false, vr->vr.desc, vr->vr.avail,
> -				       vr->vr.used);
> -		if (ret) {
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			goto err;
> -		}
> -		vringh_kiov_init(&vvr->riov, NULL, 0);
> -		vringh_kiov_init(&vvr->wiov, NULL, 0);
> -		vvr->head =3D USHRT_MAX;
> -		vvr->vdev =3D vdev;
> -		vvr->vrh.notify =3D _vop_notify;
> -		dev_dbg(&vpdev->dev,
> -			"%s %d index %d va %p info %p vr_size 0x%x\n",
> -			__func__, __LINE__, i, vr->va, vr->info, vr_size);
> -		vvr->buf =3D (void *)__get_free_pages(GFP_KERNEL,
> -					get_order(VOP_INT_DMA_BUF_SIZE));
> -		vvr->buf_da =3D dma_map_single(&vpdev->dev,
> -					  vvr->buf, VOP_INT_DMA_BUF_SIZE,
> -					  DMA_BIDIRECTIONAL);
> -	}
> -
> -	snprintf(irqname, sizeof(irqname), "vop%dvirtio%d", vpdev->index,
> -		 vdev->virtio_id);
> -	vdev->virtio_db =3D vpdev->hw_ops->next_db(vpdev);
> -	vdev->virtio_cookie =3D vpdev->hw_ops->request_irq(vpdev,
> -			_vop_virtio_intr_handler, irqname, vdev,
> -			vdev->virtio_db);
> -	if (IS_ERR(vdev->virtio_cookie)) {
> -		ret =3D PTR_ERR(vdev->virtio_cookie);
> -		dev_dbg(&vpdev->dev, "request irq failed\n");
> -		goto err;
> -	}
> -
> -	vdev->dc->c2h_vdev_db =3D vdev->virtio_db;
> -
> -	/*
> -	 * Order the type update with previous stores. This write barrier
> -	 * is paired with the corresponding read barrier before the uncached
> -	 * system memory read of the type, on the card while scanning the
> -	 * device page.
> -	 */
> -	smp_wmb();
> -	dd->type =3D type;
> -	argp->type =3D type;
> -
> -	if (bootparam) {
> -		db =3D bootparam->h2c_config_db;
> -		if (db !=3D -1)
> -			vpdev->hw_ops->send_intr(vpdev, db);
> -	}
> -	dev_dbg(&vpdev->dev, "Added virtio id %d db %d\n", dd->type, db);
> -	return 0;
> -err:
> -	vqconfig =3D mic_vq_config(dd);
> -	for (j =3D 0; j < i; j++) {
> -		struct vop_vringh *vvr =3D &vdev->vvr[j];
> -
> -		dma_unmap_single(&vpdev->dev,
> le64_to_cpu(vqconfig[j].address),
> -				 vvr->vring.len, DMA_BIDIRECTIONAL);
> -		free_pages((unsigned long)vvr->vring.va,
> -			   get_order(vvr->vring.len));
> -	}
> -	return ret;
> -}
> -
> -static void vop_dev_remove(struct vop_info *pvi, struct mic_device_ctrl
> *devp,
> -			   struct vop_device *vpdev)
> -{
> -	struct mic_bootparam *bootparam =3D vpdev->hw_ops-
> >get_dp(vpdev);
> -	s8 db;
> -	int ret, retry;
> -	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wake);
> -
> -	devp->config_change =3D MIC_VIRTIO_PARAM_DEV_REMOVE;
> -	db =3D bootparam->h2c_config_db;
> -	if (db !=3D -1)
> -		vpdev->hw_ops->send_intr(vpdev, db);
> -	else
> -		goto done;
> -	for (retry =3D 15; retry--;) {
> -		ret =3D wait_event_timeout(wake, devp->guest_ack,
> -					 msecs_to_jiffies(1000));
> -		if (ret)
> -			break;
> -	}
> -done:
> -	devp->config_change =3D 0;
> -	devp->guest_ack =3D 0;
> -}
> -
> -static void vop_virtio_del_device(struct vop_vdev *vdev)
> -{
> -	struct vop_info *vi =3D vdev->vi;
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	int i;
> -	struct mic_vqconfig *vqconfig;
> -	struct mic_bootparam *bootparam =3D vpdev->hw_ops-
> >get_dp(vpdev);
> -
> -	if (!bootparam)
> -		goto skip_hot_remove;
> -	vop_dev_remove(vi, vdev->dc, vpdev);
> -skip_hot_remove:
> -	vpdev->hw_ops->free_irq(vpdev, vdev->virtio_cookie, vdev);
> -	flush_work(&vdev->virtio_bh_work);
> -	vqconfig =3D mic_vq_config(vdev->dd);
> -	for (i =3D 0; i < vdev->dd->num_vq; i++) {
> -		struct vop_vringh *vvr =3D &vdev->vvr[i];
> -
> -		dma_unmap_single(&vpdev->dev,
> -				 vvr->buf_da, VOP_INT_DMA_BUF_SIZE,
> -				 DMA_BIDIRECTIONAL);
> -		free_pages((unsigned long)vvr->buf,
> -			   get_order(VOP_INT_DMA_BUF_SIZE));
> -		vringh_kiov_cleanup(&vvr->riov);
> -		vringh_kiov_cleanup(&vvr->wiov);
> -		dma_unmap_single(&vpdev->dev,
> le64_to_cpu(vqconfig[i].address),
> -				 vvr->vring.len, DMA_BIDIRECTIONAL);
> -		free_pages((unsigned long)vvr->vring.va,
> -			   get_order(vvr->vring.len));
> -	}
> -	/*
> -	 * Order the type update with previous stores. This write barrier
> -	 * is paired with the corresponding read barrier before the uncached
> -	 * system memory read of the type, on the card while scanning the
> -	 * device page.
> -	 */
> -	smp_wmb();
> -	vdev->dd->type =3D -1;
> -}
> -
> -/*
> - * vop_sync_dma - Wrapper for synchronous DMAs.
> - *
> - * @dev - The address of the pointer to the device instance used
> - * for DMA registration.
> - * @dst - destination DMA address.
> - * @src - source DMA address.
> - * @len - size of the transfer.
> - *
> - * Return DMA_SUCCESS on success
> - */
> -static int vop_sync_dma(struct vop_vdev *vdev, dma_addr_t dst,
> dma_addr_t src,
> -			size_t len)
> -{
> -	int err =3D 0;
> -	struct dma_device *ddev;
> -	struct dma_async_tx_descriptor *tx;
> -	struct vop_info *vi =3D dev_get_drvdata(&vdev->vpdev->dev);
> -	struct dma_chan *vop_ch =3D vi->dma_ch;
> -
> -	if (!vop_ch) {
> -		err =3D -EBUSY;
> -		goto error;
> -	}
> -	ddev =3D vop_ch->device;
> -	tx =3D ddev->device_prep_dma_memcpy(vop_ch, dst, src, len,
> -		DMA_PREP_FENCE);
> -	if (!tx) {
> -		err =3D -ENOMEM;
> -		goto error;
> -	} else {
> -		dma_cookie_t cookie;
> -
> -		cookie =3D tx->tx_submit(tx);
> -		if (dma_submit_error(cookie)) {
> -			err =3D -ENOMEM;
> -			goto error;
> -		}
> -		dma_async_issue_pending(vop_ch);
> -		err =3D dma_sync_wait(vop_ch, cookie);
> -	}
> -error:
> -	if (err)
> -		dev_err(&vi->vpdev->dev, "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -	return err;
> -}
> -
> -#define VOP_USE_DMA true
> -
> -/*
> - * Initiates the copies across the PCIe bus from card memory to a user
> - * space buffer. When transfers are done using DMA, source/destination
> - * addresses and transfer length must follow the alignment requirements =
of
> - * the MIC DMA engine.
> - */
> -static int vop_virtio_copy_to_user(struct vop_vdev *vdev, void __user *u=
buf,
> -				   size_t len, u64 daddr, size_t dlen,
> -				   int vr_idx)
> -{
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	void __iomem *dbuf =3D vpdev->hw_ops->remap(vpdev, daddr, len);
> -	struct vop_vringh *vvr =3D &vdev->vvr[vr_idx];
> -	struct vop_info *vi =3D dev_get_drvdata(&vpdev->dev);
> -	size_t dma_alignment;
> -	bool x200;
> -	size_t dma_offset, partlen;
> -	int err;
> -
> -	if (!VOP_USE_DMA || !vi->dma_ch) {
> -		if (copy_to_user(ubuf, (void __force *)dbuf, len)) {
> -			err =3D -EFAULT;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, err);
> -			goto err;
> -		}
> -		vdev->in_bytes +=3D len;
> -		err =3D 0;
> -		goto err;
> -	}
> -
> -	dma_alignment =3D 1 << vi->dma_ch->device->copy_align;
> -	x200 =3D is_dma_copy_aligned(vi->dma_ch->device, 1, 1, 1);
> -
> -	dma_offset =3D daddr - round_down(daddr, dma_alignment);
> -	daddr -=3D dma_offset;
> -	len +=3D dma_offset;
> -	/*
> -	 * X100 uses DMA addresses as seen by the card so adding
> -	 * the aperture base is not required for DMA. However x200
> -	 * requires DMA addresses to be an offset into the bar so
> -	 * add the aperture base for x200.
> -	 */
> -	if (x200)
> -		daddr +=3D vpdev->aper->pa;
> -	while (len) {
> -		partlen =3D min_t(size_t, len, VOP_INT_DMA_BUF_SIZE);
> -		err =3D vop_sync_dma(vdev, vvr->buf_da, daddr,
> -				   ALIGN(partlen, dma_alignment));
> -		if (err) {
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, err);
> -			goto err;
> -		}
> -		if (copy_to_user(ubuf, vvr->buf + dma_offset,
> -				 partlen - dma_offset)) {
> -			err =3D -EFAULT;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, err);
> -			goto err;
> -		}
> -		daddr +=3D partlen;
> -		ubuf +=3D partlen;
> -		dbuf +=3D partlen;
> -		vdev->in_bytes_dma +=3D partlen;
> -		vdev->in_bytes +=3D partlen;
> -		len -=3D partlen;
> -		dma_offset =3D 0;
> -	}
> -	err =3D 0;
> -err:
> -	vpdev->hw_ops->unmap(vpdev, dbuf);
> -	dev_dbg(vop_dev(vdev),
> -		"%s: ubuf %p dbuf %p len 0x%zx vr_idx 0x%x\n",
> -		__func__, ubuf, dbuf, len, vr_idx);
> -	return err;
> -}
> -
> -/*
> - * Initiates copies across the PCIe bus from a user space buffer to card
> - * memory. When transfers are done using DMA, source/destination
> addresses
> - * and transfer length must follow the alignment requirements of the MIC
> - * DMA engine.
> - */
> -static int vop_virtio_copy_from_user(struct vop_vdev *vdev, void __user
> *ubuf,
> -				     size_t len, u64 daddr, size_t dlen,
> -				     int vr_idx)
> -{
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	void __iomem *dbuf =3D vpdev->hw_ops->remap(vpdev, daddr, len);
> -	struct vop_vringh *vvr =3D &vdev->vvr[vr_idx];
> -	struct vop_info *vi =3D dev_get_drvdata(&vdev->vpdev->dev);
> -	size_t dma_alignment;
> -	bool x200;
> -	size_t partlen;
> -	bool dma =3D VOP_USE_DMA && vi->dma_ch;
> -	int err =3D 0;
> -	size_t offset =3D 0;
> -
> -	if (dma) {
> -		dma_alignment =3D 1 << vi->dma_ch->device->copy_align;
> -		x200 =3D is_dma_copy_aligned(vi->dma_ch->device, 1, 1, 1);
> -
> -		if (daddr & (dma_alignment - 1)) {
> -			vdev->tx_dst_unaligned +=3D len;
> -			dma =3D false;
> -		} else if (ALIGN(len, dma_alignment) > dlen) {
> -			vdev->tx_len_unaligned +=3D len;
> -			dma =3D false;
> -		}
> -	}
> -
> -	if (!dma)
> -		goto memcpy;
> -
> -	/*
> -	 * X100 uses DMA addresses as seen by the card so adding
> -	 * the aperture base is not required for DMA. However x200
> -	 * requires DMA addresses to be an offset into the bar so
> -	 * add the aperture base for x200.
> -	 */
> -	if (x200)
> -		daddr +=3D vpdev->aper->pa;
> -	while (len) {
> -		partlen =3D min_t(size_t, len, VOP_INT_DMA_BUF_SIZE);
> -
> -		if (copy_from_user(vvr->buf, ubuf, partlen)) {
> -			err =3D -EFAULT;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, err);
> -			goto err;
> -		}
> -		err =3D vop_sync_dma(vdev, daddr, vvr->buf_da,
> -				   ALIGN(partlen, dma_alignment));
> -		if (err) {
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, err);
> -			goto err;
> -		}
> -		daddr +=3D partlen;
> -		ubuf +=3D partlen;
> -		dbuf +=3D partlen;
> -		vdev->out_bytes_dma +=3D partlen;
> -		vdev->out_bytes +=3D partlen;
> -		len -=3D partlen;
> -	}
> -memcpy:
> -	/*
> -	 * We are copying to IO below and should ideally use something
> -	 * like copy_from_user_toio(..) if it existed.
> -	 */
> -	while (len) {
> -		partlen =3D min_t(size_t, len, VOP_INT_DMA_BUF_SIZE);
> -
> -		if (copy_from_user(vvr->buf, ubuf + offset, partlen)) {
> -			err =3D -EFAULT;
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, err);
> -			goto err;
> -		}
> -		memcpy_toio(dbuf + offset, vvr->buf, partlen);
> -		offset +=3D partlen;
> -		vdev->out_bytes +=3D partlen;
> -		len -=3D partlen;
> -	}
> -	err =3D 0;
> -err:
> -	vpdev->hw_ops->unmap(vpdev, dbuf);
> -	dev_dbg(vop_dev(vdev),
> -		"%s: ubuf %p dbuf %p len 0x%zx vr_idx 0x%x\n",
> -		__func__, ubuf, dbuf, len, vr_idx);
> -	return err;
> -}
> -
> -#define MIC_VRINGH_READ true
> -
> -/* Determine the total number of bytes consumed in a VRINGH KIOV */
> -static inline u32 vop_vringh_iov_consumed(struct vringh_kiov *iov)
> -{
> -	int i;
> -	u32 total =3D iov->consumed;
> -
> -	for (i =3D 0; i < iov->i; i++)
> -		total +=3D iov->iov[i].iov_len;
> -	return total;
> -}
> -
> -/*
> - * Traverse the VRINGH KIOV and issue the APIs to trigger the copies.
> - * This API is heavily based on the vringh_iov_xfer(..) implementation
> - * in vringh.c. The reason we cannot reuse vringh_iov_pull_kern(..)
> - * and vringh_iov_push_kern(..) directly is because there is no
> - * way to override the VRINGH xfer(..) routines as of v3.10.
> - */
> -static int vop_vringh_copy(struct vop_vdev *vdev, struct vringh_kiov *io=
v,
> -			   void __user *ubuf, size_t len, bool read, int vr_idx,
> -			   size_t *out_len)
> -{
> -	int ret =3D 0;
> -	size_t partlen, tot_len =3D 0;
> -
> -	while (len && iov->i < iov->used) {
> -		struct kvec *kiov =3D &iov->iov[iov->i];
> -		unsigned long daddr =3D (unsigned long)kiov->iov_base;
> -
> -		partlen =3D min(kiov->iov_len, len);
> -		if (read)
> -			ret =3D vop_virtio_copy_to_user(vdev, ubuf, partlen,
> -						      daddr,
> -						      kiov->iov_len,
> -						      vr_idx);
> -		else
> -			ret =3D vop_virtio_copy_from_user(vdev, ubuf, partlen,
> -							daddr,
> -							kiov->iov_len,
> -							vr_idx);
> -		if (ret) {
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			break;
> -		}
> -		len -=3D partlen;
> -		ubuf +=3D partlen;
> -		tot_len +=3D partlen;
> -		iov->consumed +=3D partlen;
> -		kiov->iov_len -=3D partlen;
> -		kiov->iov_base +=3D partlen;
> -		if (!kiov->iov_len) {
> -			/* Fix up old iov element then increment. */
> -			kiov->iov_len =3D iov->consumed;
> -			kiov->iov_base -=3D iov->consumed;
> -
> -			iov->consumed =3D 0;
> -			iov->i++;
> -		}
> -	}
> -	*out_len =3D tot_len;
> -	return ret;
> -}
> -
> -/*
> - * Use the standard VRINGH infrastructure in the kernel to fetch new
> - * descriptors, initiate the copies and update the used ring.
> - */
> -static int _vop_virtio_copy(struct vop_vdev *vdev, struct mic_copy_desc
> *copy)
> -{
> -	int ret =3D 0;
> -	u32 iovcnt =3D copy->iovcnt;
> -	struct iovec iov;
> -	struct iovec __user *u_iov =3D copy->iov;
> -	void __user *ubuf =3D NULL;
> -	struct vop_vringh *vvr =3D &vdev->vvr[copy->vr_idx];
> -	struct vringh_kiov *riov =3D &vvr->riov;
> -	struct vringh_kiov *wiov =3D &vvr->wiov;
> -	struct vringh *vrh =3D &vvr->vrh;
> -	u16 *head =3D &vvr->head;
> -	struct mic_vring *vr =3D &vvr->vring;
> -	size_t len =3D 0, out_len;
> -
> -	copy->out_len =3D 0;
> -	/* Fetch a new IOVEC if all previous elements have been processed
> */
> -	if (riov->i =3D=3D riov->used && wiov->i =3D=3D wiov->used) {
> -		ret =3D vringh_getdesc_kern(vrh, riov, wiov,
> -					  head, GFP_KERNEL);
> -		/* Check if there are available descriptors */
> -		if (ret <=3D 0)
> -			return ret;
> -	}
> -	while (iovcnt) {
> -		if (!len) {
> -			/* Copy over a new iovec from user space. */
> -			ret =3D copy_from_user(&iov, u_iov, sizeof(*u_iov));
> -			if (ret) {
> -				ret =3D -EINVAL;
> -				dev_err(vop_dev(vdev), "%s %d err %d\n",
> -					__func__, __LINE__, ret);
> -				break;
> -			}
> -			len =3D iov.iov_len;
> -			ubuf =3D iov.iov_base;
> -		}
> -		/* Issue all the read descriptors first */
> -		ret =3D vop_vringh_copy(vdev, riov, ubuf, len,
> -				      MIC_VRINGH_READ, copy->vr_idx,
> &out_len);
> -		if (ret) {
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			break;
> -		}
> -		len -=3D out_len;
> -		ubuf +=3D out_len;
> -		copy->out_len +=3D out_len;
> -		/* Issue the write descriptors next */
> -		ret =3D vop_vringh_copy(vdev, wiov, ubuf, len,
> -				      !MIC_VRINGH_READ, copy->vr_idx,
> &out_len);
> -		if (ret) {
> -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> -				__func__, __LINE__, ret);
> -			break;
> -		}
> -		len -=3D out_len;
> -		ubuf +=3D out_len;
> -		copy->out_len +=3D out_len;
> -		if (!len) {
> -			/* One user space iovec is now completed */
> -			iovcnt--;
> -			u_iov++;
> -		}
> -		/* Exit loop if all elements in KIOVs have been processed. */
> -		if (riov->i =3D=3D riov->used && wiov->i =3D=3D wiov->used)
> -			break;
> -	}
> -	/*
> -	 * Update the used ring if a descriptor was available and some data
> was
> -	 * copied in/out and the user asked for a used ring update.
> -	 */
> -	if (*head !=3D USHRT_MAX && copy->out_len && copy->update_used)
> {
> -		u32 total =3D 0;
> -
> -		/* Determine the total data consumed */
> -		total +=3D vop_vringh_iov_consumed(riov);
> -		total +=3D vop_vringh_iov_consumed(wiov);
> -		vringh_complete_kern(vrh, *head, total);
> -		*head =3D USHRT_MAX;
> -		if (vringh_need_notify_kern(vrh) > 0)
> -			vringh_notify(vrh);
> -		vringh_kiov_cleanup(riov);
> -		vringh_kiov_cleanup(wiov);
> -		/* Update avail idx for user space */
> -		vr->info->avail_idx =3D vrh->last_avail_idx;
> -	}
> -	return ret;
> -}
> -
> -static inline int vop_verify_copy_args(struct vop_vdev *vdev,
> -				       struct mic_copy_desc *copy)
> -{
> -	if (!vdev || copy->vr_idx >=3D vdev->dd->num_vq)
> -		return -EINVAL;
> -	return 0;
> -}
> -
> -/* Copy a specified number of virtio descriptors in a chain */
> -static int vop_virtio_copy_desc(struct vop_vdev *vdev,
> -				struct mic_copy_desc *copy)
> -{
> -	int err;
> -	struct vop_vringh *vvr;
> -
> -	err =3D vop_verify_copy_args(vdev, copy);
> -	if (err)
> -		return err;
> -
> -	vvr =3D &vdev->vvr[copy->vr_idx];
> -	mutex_lock(&vvr->vr_mutex);
> -	if (!vop_vdevup(vdev)) {
> -		err =3D -ENODEV;
> -		dev_err(vop_dev(vdev), "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -		goto err;
> -	}
> -	err =3D _vop_virtio_copy(vdev, copy);
> -	if (err) {
> -		dev_err(vop_dev(vdev), "%s %d err %d\n",
> -			__func__, __LINE__, err);
> -	}
> -err:
> -	mutex_unlock(&vvr->vr_mutex);
> -	return err;
> -}
> -
> -static int vop_open(struct inode *inode, struct file *f)
> -{
> -	struct vop_vdev *vdev;
> -	struct vop_info *vi =3D container_of(f->private_data,
> -		struct vop_info, miscdev);
> -
> -	vdev =3D kzalloc(sizeof(*vdev), GFP_KERNEL);
> -	if (!vdev)
> -		return -ENOMEM;
> -	vdev->vi =3D vi;
> -	mutex_init(&vdev->vdev_mutex);
> -	f->private_data =3D vdev;
> -	init_completion(&vdev->destroy);
> -	complete(&vdev->destroy);
> -	return 0;
> -}
> -
> -static int vop_release(struct inode *inode, struct file *f)
> -{
> -	struct vop_vdev *vdev =3D f->private_data, *vdev_tmp;
> -	struct vop_info *vi =3D vdev->vi;
> -	struct list_head *pos, *tmp;
> -	bool found =3D false;
> -
> -	mutex_lock(&vdev->vdev_mutex);
> -	if (vdev->deleted)
> -		goto unlock;
> -	mutex_lock(&vi->vop_mutex);
> -	list_for_each_safe(pos, tmp, &vi->vdev_list) {
> -		vdev_tmp =3D list_entry(pos, struct vop_vdev, list);
> -		if (vdev =3D=3D vdev_tmp) {
> -			vop_virtio_del_device(vdev);
> -			list_del(pos);
> -			found =3D true;
> -			break;
> -		}
> -	}
> -	mutex_unlock(&vi->vop_mutex);
> -unlock:
> -	mutex_unlock(&vdev->vdev_mutex);
> -	if (!found)
> -		wait_for_completion(&vdev->destroy);
> -	f->private_data =3D NULL;
> -	kfree(vdev);
> -	return 0;
> -}
> -
> -static long vop_ioctl(struct file *f, unsigned int cmd, unsigned long ar=
g)
> -{
> -	struct vop_vdev *vdev =3D f->private_data;
> -	struct vop_info *vi =3D vdev->vi;
> -	void __user *argp =3D (void __user *)arg;
> -	int ret;
> -
> -	switch (cmd) {
> -	case MIC_VIRTIO_ADD_DEVICE:
> -	{
> -		struct mic_device_desc dd, *dd_config;
> -
> -		if (copy_from_user(&dd, argp, sizeof(dd)))
> -			return -EFAULT;
> -
> -		if (mic_aligned_desc_size(&dd) > MIC_MAX_DESC_BLK_SIZE
> ||
> -		    dd.num_vq > MIC_MAX_VRINGS)
> -			return -EINVAL;
> -
> -		dd_config =3D memdup_user(argp, mic_desc_size(&dd));
> -		if (IS_ERR(dd_config))
> -			return PTR_ERR(dd_config);
> -
> -		/* Ensure desc has not changed between the two reads */
> -		if (memcmp(&dd, dd_config, sizeof(dd))) {
> -			ret =3D -EINVAL;
> -			goto free_ret;
> -		}
> -		mutex_lock(&vdev->vdev_mutex);
> -		mutex_lock(&vi->vop_mutex);
> -		ret =3D vop_virtio_add_device(vdev, dd_config);
> -		if (ret)
> -			goto unlock_ret;
> -		list_add_tail(&vdev->list, &vi->vdev_list);
> -unlock_ret:
> -		mutex_unlock(&vi->vop_mutex);
> -		mutex_unlock(&vdev->vdev_mutex);
> -free_ret:
> -		kfree(dd_config);
> -		return ret;
> -	}
> -	case MIC_VIRTIO_COPY_DESC:
> -	{
> -		struct mic_copy_desc copy;
> -
> -		mutex_lock(&vdev->vdev_mutex);
> -		ret =3D vop_vdev_inited(vdev);
> -		if (ret)
> -			goto _unlock_ret;
> -
> -		if (copy_from_user(&copy, argp, sizeof(copy))) {
> -			ret =3D -EFAULT;
> -			goto _unlock_ret;
> -		}
> -
> -		ret =3D vop_virtio_copy_desc(vdev, &copy);
> -		if (ret < 0)
> -			goto _unlock_ret;
> -		if (copy_to_user(
> -			&((struct mic_copy_desc __user *)argp)->out_len,
> -			&copy.out_len, sizeof(copy.out_len)))
> -			ret =3D -EFAULT;
> -_unlock_ret:
> -		mutex_unlock(&vdev->vdev_mutex);
> -		return ret;
> -	}
> -	case MIC_VIRTIO_CONFIG_CHANGE:
> -	{
> -		void *buf;
> -
> -		mutex_lock(&vdev->vdev_mutex);
> -		ret =3D vop_vdev_inited(vdev);
> -		if (ret)
> -			goto __unlock_ret;
> -		buf =3D memdup_user(argp, vdev->dd->config_len);
> -		if (IS_ERR(buf)) {
> -			ret =3D PTR_ERR(buf);
> -			goto __unlock_ret;
> -		}
> -		ret =3D vop_virtio_config_change(vdev, buf);
> -		kfree(buf);
> -__unlock_ret:
> -		mutex_unlock(&vdev->vdev_mutex);
> -		return ret;
> -	}
> -	default:
> -		return -ENOIOCTLCMD;
> -	};
> -	return 0;
> -}
> -
> -/*
> - * We return EPOLLIN | EPOLLOUT from poll when new buffers are
> enqueued, and
> - * not when previously enqueued buffers may be available. This means tha=
t
> - * in the card->host (TX) path, when userspace is unblocked by poll it
> - * must drain all available descriptors or it can stall.
> - */
> -static __poll_t vop_poll(struct file *f, poll_table *wait)
> -{
> -	struct vop_vdev *vdev =3D f->private_data;
> -	__poll_t mask =3D 0;
> -
> -	mutex_lock(&vdev->vdev_mutex);
> -	if (vop_vdev_inited(vdev)) {
> -		mask =3D EPOLLERR;
> -		goto done;
> -	}
> -	poll_wait(f, &vdev->waitq, wait);
> -	if (vop_vdev_inited(vdev)) {
> -		mask =3D EPOLLERR;
> -	} else if (vdev->poll_wake) {
> -		vdev->poll_wake =3D 0;
> -		mask =3D EPOLLIN | EPOLLOUT;
> -	}
> -done:
> -	mutex_unlock(&vdev->vdev_mutex);
> -	return mask;
> -}
> -
> -static inline int
> -vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
> -		 unsigned long *size, unsigned long *pa)
> -{
> -	struct vop_device *vpdev =3D vdev->vpdev;
> -	unsigned long start =3D MIC_DP_SIZE;
> -	int i;
> -
> -	/*
> -	 * MMAP interface is as follows:
> -	 * offset				region
> -	 * 0x0					virtio device_page
> -	 * 0x1000				first vring
> -	 * 0x1000 + size of 1st vring		second vring
> -	 * ....
> -	 */
> -	if (!offset) {
> -		*pa =3D virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
> -		*size =3D MIC_DP_SIZE;
> -		return 0;
> -	}
> -
> -	for (i =3D 0; i < vdev->dd->num_vq; i++) {
> -		struct vop_vringh *vvr =3D &vdev->vvr[i];
> -
> -		if (offset =3D=3D start) {
> -			*pa =3D virt_to_phys(vvr->vring.va);
> -			*size =3D vvr->vring.len;
> -			return 0;
> -		}
> -		start +=3D vvr->vring.len;
> -	}
> -	return -1;
> -}
> -
> -/*
> - * Maps the device page and virtio rings to user space for readonly acce=
ss.
> - */
> -static int vop_mmap(struct file *f, struct vm_area_struct *vma)
> -{
> -	struct vop_vdev *vdev =3D f->private_data;
> -	unsigned long offset =3D vma->vm_pgoff << PAGE_SHIFT;
> -	unsigned long pa, size =3D vma->vm_end - vma->vm_start, size_rem =3D
> size;
> -	int i, err;
> -
> -	err =3D vop_vdev_inited(vdev);
> -	if (err)
> -		goto ret;
> -	if (vma->vm_flags & VM_WRITE) {
> -		err =3D -EACCES;
> -		goto ret;
> -	}
> -	while (size_rem) {
> -		i =3D vop_query_offset(vdev, offset, &size, &pa);
> -		if (i < 0) {
> -			err =3D -EINVAL;
> -			goto ret;
> -		}
> -		err =3D remap_pfn_range(vma, vma->vm_start + offset,
> -				      pa >> PAGE_SHIFT, size,
> -				      vma->vm_page_prot);
> -		if (err)
> -			goto ret;
> -		size_rem -=3D size;
> -		offset +=3D size;
> -	}
> -ret:
> -	return err;
> -}
> -
> -static const struct file_operations vop_fops =3D {
> -	.open =3D vop_open,
> -	.release =3D vop_release,
> -	.unlocked_ioctl =3D vop_ioctl,
> -	.poll =3D vop_poll,
> -	.mmap =3D vop_mmap,
> -	.owner =3D THIS_MODULE,
> -};
> -
> -int vop_host_init(struct vop_info *vi)
> -{
> -	int rc;
> -	struct miscdevice *mdev;
> -	struct vop_device *vpdev =3D vi->vpdev;
> -
> -	INIT_LIST_HEAD(&vi->vdev_list);
> -	vi->dma_ch =3D vpdev->dma_ch;
> -	mdev =3D &vi->miscdev;
> -	mdev->minor =3D MISC_DYNAMIC_MINOR;
> -	snprintf(vi->name, sizeof(vi->name), "vop_virtio%d", vpdev->index);
> -	mdev->name =3D vi->name;
> -	mdev->fops =3D &vop_fops;
> -	mdev->parent =3D &vpdev->dev;
> -
> -	rc =3D misc_register(mdev);
> -	if (rc)
> -		dev_err(&vpdev->dev, "%s failed rc %d\n", __func__, rc);
> -	return rc;
> -}
> -
> -void vop_host_uninit(struct vop_info *vi)
> -{
> -	struct list_head *pos, *tmp;
> -	struct vop_vdev *vdev;
> -
> -	mutex_lock(&vi->vop_mutex);
> -	vop_virtio_reset_devices(vi);
> -	list_for_each_safe(pos, tmp, &vi->vdev_list) {
> -		vdev =3D list_entry(pos, struct vop_vdev, list);
> -		list_del(pos);
> -		reinit_completion(&vdev->destroy);
> -		mutex_unlock(&vi->vop_mutex);
> -		mutex_lock(&vdev->vdev_mutex);
> -		vop_virtio_del_device(vdev);
> -		vdev->deleted =3D true;
> -		mutex_unlock(&vdev->vdev_mutex);
> -		complete(&vdev->destroy);
> -		mutex_lock(&vi->vop_mutex);
> -	}
> -	mutex_unlock(&vi->vop_mutex);
> -	misc_deregister(&vi->miscdev);
> -}
> diff --git a/include/linux/mic_bus.h b/include/linux/mic_bus.h
> deleted file mode 100644
> index e99c789424e0..000000000000
> --- a/include/linux/mic_bus.h
> +++ /dev/null
> @@ -1,100 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Intel MIC Bus driver.
> - *
> - * This implementation is very similar to the virtio bus driver
> - * implementation @ include/linux/virtio.h.
> - */
> -#ifndef _MIC_BUS_H_
> -#define _MIC_BUS_H_
> -/*
> - * Everything a mbus driver needs to work with any particular mbus
> - * implementation.
> - */
> -#include <linux/interrupt.h>
> -#include <linux/dma-mapping.h>
> -
> -struct mbus_device_id {
> -	__u32 device;
> -	__u32 vendor;
> -};
> -
> -#define MBUS_DEV_DMA_HOST 2
> -#define MBUS_DEV_DMA_MIC 3
> -#define MBUS_DEV_ANY_ID 0xffffffff
> -
> -/**
> - * mbus_device - representation of a device using mbus
> - * @mmio_va: virtual address of mmio space
> - * @hw_ops: the hardware ops supported by this device.
> - * @id: the device type identification (used to match it with a driver).
> - * @dev: underlying device.
> - * be used to communicate with.
> - * @index: unique position on the mbus bus
> - */
> -struct mbus_device {
> -	void __iomem *mmio_va;
> -	struct mbus_hw_ops *hw_ops;
> -	struct mbus_device_id id;
> -	struct device dev;
> -	int index;
> -};
> -
> -/**
> - * mbus_driver - operations for a mbus I/O driver
> - * @driver: underlying device driver (populate name and owner).
> - * @id_table: the ids serviced by this driver.
> - * @probe: the function to call when a device is found.  Returns 0 or -e=
rrno.
> - * @remove: the function to call when a device is removed.
> - */
> -struct mbus_driver {
> -	struct device_driver driver;
> -	const struct mbus_device_id *id_table;
> -	int (*probe)(struct mbus_device *dev);
> -	void (*scan)(struct mbus_device *dev);
> -	void (*remove)(struct mbus_device *dev);
> -};
> -
> -/**
> - * struct mic_irq - opaque pointer used as cookie
> - */
> -struct mic_irq;
> -
> -/**
> - * mbus_hw_ops - Hardware operations for accessing a MIC device on the
> MIC bus.
> - */
> -struct mbus_hw_ops {
> -	struct mic_irq* (*request_threaded_irq)(struct mbus_device *mbdev,
> -						irq_handler_t handler,
> -						irq_handler_t thread_fn,
> -						const char *name, void *data,
> -						int intr_src);
> -	void (*free_irq)(struct mbus_device *mbdev,
> -			 struct mic_irq *cookie, void *data);
> -	void (*ack_interrupt)(struct mbus_device *mbdev, int num);
> -};
> -
> -struct mbus_device *
> -mbus_register_device(struct device *pdev, int id, const struct
> dma_map_ops *dma_ops,
> -		     struct mbus_hw_ops *hw_ops, int index,
> -		     void __iomem *mmio_va);
> -void mbus_unregister_device(struct mbus_device *mbdev);
> -
> -int mbus_register_driver(struct mbus_driver *drv);
> -void mbus_unregister_driver(struct mbus_driver *drv);
> -
> -static inline struct mbus_device *dev_to_mbus(struct device *_dev)
> -{
> -	return container_of(_dev, struct mbus_device, dev);
> -}
> -
> -static inline struct mbus_driver *drv_to_mbus(struct device_driver *drv)
> -{
> -	return container_of(drv, struct mbus_driver, driver);
> -}
> -
> -#endif /* _MIC_BUS_H */
> diff --git a/include/linux/scif.h b/include/linux/scif.h
> deleted file mode 100644
> index 329e695b8fe5..000000000000
> --- a/include/linux/scif.h
> +++ /dev/null
> @@ -1,1339 +0,0 @@
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - * redistributing this file, you may do so under either license.
> - *
> - * GPL LICENSE SUMMARY
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * BSD LICENSE
> - *
> - * Copyright(c) 2014 Intel Corporation.
> - *
> - * Redistribution and use in source and binary forms, with or without
> - * modification, are permitted provided that the following conditions
> - * are met:
> - *
> - * * Redistributions of source code must retain the above copyright
> - *   notice, this list of conditions and the following disclaimer.
> - * * Redistributions in binary form must reproduce the above copyright
> - *   notice, this list of conditions and the following disclaimer in
> - *   the documentation and/or other materials provided with the
> - *   distribution.
> - * * Neither the name of Intel Corporation nor the names of its
> - *   contributors may be used to endorse or promote products derived
> - *   from this software without specific prior written permission.
> - *
> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
> CONTRIBUTORS
> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT
> NOT
> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
> FITNESS FOR
> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
> COPYRIGHT
> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
> INCIDENTAL,
> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
> NOT
> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
> OF USE,
> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> ON ANY
> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
> TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
> THE USE
> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
> DAMAGE.
> - *
> - * Intel SCIF driver.
> - *
> - */
> -#ifndef __SCIF_H__
> -#define __SCIF_H__
> -
> -#include <linux/types.h>
> -#include <linux/poll.h>
> -#include <linux/device.h>
> -#include <linux/scif_ioctl.h>
> -
> -#define SCIF_ACCEPT_SYNC	1
> -#define SCIF_SEND_BLOCK		1
> -#define SCIF_RECV_BLOCK		1
> -
> -enum {
> -	SCIF_PROT_READ =3D (1 << 0),
> -	SCIF_PROT_WRITE =3D (1 << 1)
> -};
> -
> -enum {
> -	SCIF_MAP_FIXED =3D 0x10,
> -	SCIF_MAP_KERNEL	=3D 0x20,
> -};
> -
> -enum {
> -	SCIF_FENCE_INIT_SELF =3D (1 << 0),
> -	SCIF_FENCE_INIT_PEER =3D (1 << 1),
> -	SCIF_SIGNAL_LOCAL =3D (1 << 4),
> -	SCIF_SIGNAL_REMOTE =3D (1 << 5)
> -};
> -
> -enum {
> -	SCIF_RMA_USECPU =3D (1 << 0),
> -	SCIF_RMA_USECACHE =3D (1 << 1),
> -	SCIF_RMA_SYNC =3D (1 << 2),
> -	SCIF_RMA_ORDERED =3D (1 << 3)
> -};
> -
> -/* End of SCIF Admin Reserved Ports */
> -#define SCIF_ADMIN_PORT_END	1024
> -
> -/* End of SCIF Reserved Ports */
> -#define SCIF_PORT_RSVD		1088
> -
> -typedef struct scif_endpt *scif_epd_t;
> -typedef struct scif_pinned_pages *scif_pinned_pages_t;
> -
> -/**
> - * struct scif_range - SCIF registered range used in kernel mode
> - * @cookie: cookie used internally by SCIF
> - * @nr_pages: number of pages of PAGE_SIZE
> - * @prot_flags: R/W protection
> - * @phys_addr: Array of bus addresses
> - * @va: Array of kernel virtual addresses backed by the pages in the
> phys_addr
> - *	array. The va is populated only when called on the host for a remote
> - *	SCIF connection on MIC. This is required to support the use case of
> DMA
> - *	between MIC and another device which is not a SCIF node e.g., an IB
> or
> - *	ethernet NIC.
> - */
> -struct scif_range {
> -	void *cookie;
> -	int nr_pages;
> -	int prot_flags;
> -	dma_addr_t *phys_addr;
> -	void __iomem **va;
> -};
> -
> -/**
> - * struct scif_pollepd - SCIF endpoint to be monitored via scif_poll
> - * @epd: SCIF endpoint
> - * @events: requested events
> - * @revents: returned events
> - */
> -struct scif_pollepd {
> -	scif_epd_t epd;
> -	__poll_t events;
> -	__poll_t revents;
> -};
> -
> -/**
> - * scif_peer_dev - representation of a peer SCIF device
> - *
> - * Peer devices show up as PCIe devices for the mgmt node but not the ca=
rds.
> - * The mgmt node discovers all the cards on the PCIe bus and informs the
> other
> - * cards about their peers. Upon notification of a peer a node adds a pe=
er
> - * device to the peer bus to maintain symmetry in the way devices are
> - * discovered across all nodes in the SCIF network.
> - *
> - * @dev: underlying device
> - * @dnode - The destination node which this device will communicate with=
.
> - */
> -struct scif_peer_dev {
> -	struct device dev;
> -	u8 dnode;
> -};
> -
> -/**
> - * scif_client - representation of a SCIF client
> - * @name: client name
> - * @probe - client method called when a peer device is registered
> - * @remove - client method called when a peer device is unregistered
> - * @si - subsys_interface used internally for implementing SCIF clients
> - */
> -struct scif_client {
> -	const char *name;
> -	void (*probe)(struct scif_peer_dev *spdev);
> -	void (*remove)(struct scif_peer_dev *spdev);
> -	struct subsys_interface si;
> -};
> -
> -#define SCIF_OPEN_FAILED ((scif_epd_t)-1)
> -#define SCIF_REGISTER_FAILED ((off_t)-1)
> -#define SCIF_MMAP_FAILED ((void *)-1)
> -
> -/**
> - * scif_open() - Create an endpoint
> - *
> - * Return:
> - * Upon successful completion, scif_open() returns an endpoint descripto=
r
> to
> - * be used in subsequent SCIF functions calls to refer to that endpoint;
> - * otherwise in user mode SCIF_OPEN_FAILED (that is ((scif_epd_t)-1)) is
> - * returned and errno is set to indicate the error; in kernel mode a NUL=
L
> - * scif_epd_t is returned.
> - *
> - * Errors:
> - * ENOMEM - Insufficient kernel memory was available
> - */
> -scif_epd_t scif_open(void);
> -
> -/**
> - * scif_bind() - Bind an endpoint to a port
> - * @epd:	endpoint descriptor
> - * @pn:		port number
> - *
> - * scif_bind() binds endpoint epd to port pn, where pn is a port number =
on
> the
> - * local node. If pn is zero, a port number greater than or equal to
> - * SCIF_PORT_RSVD is assigned and returned. Each endpoint may be bound
> to
> - * exactly one local port. Ports less than 1024 when requested can only =
be
> bound
> - * by system (or root) processes or by processes executed by privileged
> users.
> - *
> - * Return:
> - * Upon successful completion, scif_bind() returns the port number to wh=
ich
> epd
> - * is bound; otherwise in user mode -1 is returned and errno is set to
> - * indicate the error; in kernel mode the negative of one of the followi=
ng
> - * errors is returned.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * EINVAL - the endpoint or the port is already bound
> - * EISCONN - The endpoint is already connected
> - * ENOSPC - No port number available for assignment
> - * EACCES - The port requested is protected and the user is not the
> superuser
> - */
> -int scif_bind(scif_epd_t epd, u16 pn);
> -
> -/**
> - * scif_listen() - Listen for connections on an endpoint
> - * @epd:	endpoint descriptor
> - * @backlog:	maximum pending connection requests
> - *
> - * scif_listen() marks the endpoint epd as a listening endpoint - that i=
s, as
> - * an endpoint that will be used to accept incoming connection requests.
> Once
> - * so marked, the endpoint is said to be in the listening state and may =
not be
> - * used as the endpoint of a connection.
> - *
> - * The endpoint, epd, must have been bound to a port.
> - *
> - * The backlog argument defines the maximum length to which the queue of
> - * pending connections for epd may grow. If a connection request arrives
> when
> - * the queue is full, the client may receive an error with an indication=
 that
> - * the connection was refused.
> - *
> - * Return:
> - * Upon successful completion, scif_listen() returns 0; otherwise in use=
r
> mode
> - * -1 is returned and errno is set to indicate the error; in kernel mode=
 the
> - * negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * EINVAL - the endpoint is not bound to a port
> - * EISCONN - The endpoint is already connected or listening
> - */
> -int scif_listen(scif_epd_t epd, int backlog);
> -
> -/**
> - * scif_connect() - Initiate a connection on a port
> - * @epd:	endpoint descriptor
> - * @dst:	global id of port to which to connect
> - *
> - * The scif_connect() function requests the connection of endpoint epd t=
o
> remote
> - * port dst. If the connection is successful, a peer endpoint, bound to =
dst, is
> - * created on node dst.node. On successful return, the connection is
> complete.
> - *
> - * If the endpoint epd has not already been bound to a port, scif_connec=
t()
> - * will bind it to an unused local port.
> - *
> - * A connection is terminated when an endpoint of the connection is clos=
ed,
> - * either explicitly by scif_close(), or when a process that owns one of=
 the
> - * endpoints of the connection is terminated.
> - *
> - * In user space, scif_connect() supports an asynchronous connection mod=
e
> - * if the application has set the O_NONBLOCK flag on the endpoint via th=
e
> - * fcntl() system call. Setting this flag will result in the calling pro=
cess
> - * not to wait during scif_connect().
> - *
> - * Return:
> - * Upon successful completion, scif_connect() returns the port ID to whi=
ch
> the
> - * endpoint, epd, is bound; otherwise in user mode -1 is returned and er=
rno
> is
> - * set to indicate the error; in kernel mode the negative of one of the
> - * following errors is returned.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNREFUSED - The destination was not listening for connections or
> refused
> - * the connection request
> - * EINVAL - dst.port is not a valid port ID
> - * EISCONN - The endpoint is already connected
> - * ENOMEM - No buffer space is available
> - * ENODEV - The destination node does not exist, or the node is lost or
> existed,
> - * but is not currently in the network since it may have crashed
> - * ENOSPC - No port number available for assignment
> - * EOPNOTSUPP - The endpoint is listening and cannot be connected
> - */
> -int scif_connect(scif_epd_t epd, struct scif_port_id *dst);
> -
> -/**
> - * scif_accept() - Accept a connection on an endpoint
> - * @epd:	endpoint descriptor
> - * @peer:	global id of port to which connected
> - * @newepd:	new connected endpoint descriptor
> - * @flags:	flags
> - *
> - * The scif_accept() call extracts the first connection request from the=
 queue
> - * of pending connections for the port on which epd is listening. scif_a=
ccept()
> - * creates a new endpoint, bound to the same port as epd, and allocates =
a
> new
> - * SCIF endpoint descriptor, returned in newepd, for the endpoint. The n=
ew
> - * endpoint is connected to the endpoint through which the connection wa=
s
> - * requested. epd is unaffected by this call, and remains in the listeni=
ng
> - * state.
> - *
> - * On successful return, peer holds the global port identifier (node id =
and
> - * local port number) of the port which requested the connection.
> - *
> - * A connection is terminated when an endpoint of the connection is clos=
ed,
> - * either explicitly by scif_close(), or when a process that owns one of=
 the
> - * endpoints of the connection is terminated.
> - *
> - * The number of connections that can (subsequently) be accepted on epd =
is
> only
> - * limited by system resources (memory).
> - *
> - * The flags argument is formed by OR'ing together zero or more of the
> - * following values.
> - * SCIF_ACCEPT_SYNC - block until a connection request is presented. If
> - *			SCIF_ACCEPT_SYNC is not in flags, and no pending
> - *			connections are present on the queue, scif_accept()
> - *			fails with an EAGAIN error
> - *
> - * In user mode, the select() and poll() functions can be used to determ=
ine
> - * when there is a connection request. In kernel mode, the scif_poll()
> - * function may be used for this purpose. A readable event will be deliv=
ered
> - * when a connection is requested.
> - *
> - * Return:
> - * Upon successful completion, scif_accept() returns 0; otherwise in use=
r
> mode
> - * -1 is returned and errno is set to indicate the error; in kernel mode=
 the
> - *	negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EAGAIN - SCIF_ACCEPT_SYNC is not set and no connections are present t=
o
> be
> - * accepted or SCIF_ACCEPT_SYNC is not set and remote node failed to
> complete
> - * its connection request
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * EINTR - Interrupted function
> - * EINVAL - epd is not a listening endpoint, or flags is invalid, or pee=
r is
> - * NULL, or newepd is NULL
> - * ENODEV - The requesting node is lost or existed, but is not currently=
 in the
> - * network since it may have crashed
> - * ENOMEM - Not enough space
> - * ENOENT - Secondary part of epd registration failed
> - */
> -int scif_accept(scif_epd_t epd, struct scif_port_id *peer, scif_epd_t
> -		*newepd, int flags);
> -
> -/**
> - * scif_close() - Close an endpoint
> - * @epd:	endpoint descriptor
> - *
> - * scif_close() closes an endpoint and performs necessary teardown of
> - * facilities associated with that endpoint.
> - *
> - * If epd is a listening endpoint then it will no longer accept connecti=
on
> - * requests on the port to which it is bound. Any pending connection
> requests
> - * are rejected.
> - *
> - * If epd is a connected endpoint, then its peer endpoint is also closed=
.
> RMAs
> - * which are in-process through epd or its peer endpoint will complete
> before
> - * scif_close() returns. Registered windows of the local and peer endpoi=
nts
> are
> - * released as if scif_unregister() was called against each window.
> - *
> - * Closing a SCIF endpoint does not affect local registered memory mappe=
d
> by
> - * a SCIF endpoint on a remote node. The local memory remains mapped by
> the peer
> - * SCIF endpoint explicitly removed by calling munmap(..) by the peer.
> - *
> - * If the peer endpoint's receive queue is not empty at the time that ep=
d is
> - * closed, then the peer endpoint can be passed as the endpoint paramete=
r
> to
> - * scif_recv() until the receive queue is empty.
> - *
> - * epd is freed and may no longer be accessed.
> - *
> - * Return:
> - * Upon successful completion, scif_close() returns 0; otherwise in user
> mode
> - * -1 is returned and errno is set to indicate the error; in kernel mode=
 the
> - * negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - */
> -int scif_close(scif_epd_t epd);
> -
> -/**
> - * scif_send() - Send a message
> - * @epd:	endpoint descriptor
> - * @msg:	message buffer address
> - * @len:	message length
> - * @flags:	blocking mode flags
> - *
> - * scif_send() sends data to the peer of endpoint epd. Up to len bytes o=
f
> data
> - * are copied from memory starting at address msg. On successful executi=
on
> the
> - * return value of scif_send() is the number of bytes that were sent, an=
d is
> - * zero if no bytes were sent because len was zero. scif_send() may be c=
alled
> - * only when the endpoint is in a connected state.
> - *
> - * If a scif_send() call is non-blocking, then it sends only those bytes=
 which
> - * can be sent without waiting, up to a maximum of len bytes.
> - *
> - * If a scif_send() call is blocking, then it normally returns after sen=
ding
> - * all len bytes. If a blocking call is interrupted or the connection is
> - * reset, the call is considered successful if some bytes were sent or l=
en is
> - * zero, otherwise the call is considered unsuccessful.
> - *
> - * In user mode, the select() and poll() functions can be used to determ=
ine
> - * when the send queue is not full. In kernel mode, the scif_poll() func=
tion
> - * may be used for this purpose.
> - *
> - * It is recommended that scif_send()/scif_recv() only be used for short
> - * control-type message communication between SCIF endpoints. The SCIF
> RMA
> - * APIs are expected to provide better performance for transfer sizes of
> - * 1024 bytes or longer for the current MIC hardware and software
> - * implementation.
> - *
> - * scif_send() will block until the entire message is sent if SCIF_SEND_=
BLOCK
> - * is passed as the flags argument.
> - *
> - * Return:
> - * Upon successful completion, scif_send() returns the number of bytes s=
ent;
> - * otherwise in user mode -1 is returned and errno is set to indicate th=
e
> - * error; in kernel mode the negative of one of the following errors is
> - * returned.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - flags is invalid, or len is negative
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOMEM - Not enough space
> - * ENOTCONN - The endpoint is not connected
> - */
> -int scif_send(scif_epd_t epd, void *msg, int len, int flags);
> -
> -/**
> - * scif_recv() - Receive a message
> - * @epd:	endpoint descriptor
> - * @msg:	message buffer address
> - * @len:	message buffer length
> - * @flags:	blocking mode flags
> - *
> - * scif_recv() receives data from the peer of endpoint epd. Up to len by=
tes of
> - * data are copied to memory starting at address msg. On successful
> execution
> - * the return value of scif_recv() is the number of bytes that were rece=
ived,
> - * and is zero if no bytes were received because len was zero. scif_recv=
()
> may
> - * be called only when the endpoint is in a connected state.
> - *
> - * If a scif_recv() call is non-blocking, then it receives only those by=
tes
> - * which can be received without waiting, up to a maximum of len bytes.
> - *
> - * If a scif_recv() call is blocking, then it normally returns after rec=
eiving
> - * all len bytes. If the blocking call was interrupted due to a disconne=
ction,
> - * subsequent calls to scif_recv() will copy all bytes received upto the=
 point
> - * of disconnection.
> - *
> - * In user mode, the select() and poll() functions can be used to determ=
ine
> - * when data is available to be received. In kernel mode, the scif_poll(=
)
> - * function may be used for this purpose.
> - *
> - * It is recommended that scif_send()/scif_recv() only be used for short
> - * control-type message communication between SCIF endpoints. The SCIF
> RMA
> - * APIs are expected to provide better performance for transfer sizes of
> - * 1024 bytes or longer for the current MIC hardware and software
> - * implementation.
> - *
> - * scif_recv() will block until the entire message is received if
> - * SCIF_RECV_BLOCK is passed as the flags argument.
> - *
> - * Return:
> - * Upon successful completion, scif_recv() returns the number of bytes
> - * received; otherwise in user mode -1 is returned and errno is set to
> - * indicate the error; in kernel mode the negative of one of the followi=
ng
> - * errors is returned.
> - *
> - * Errors:
> - * EAGAIN - The destination node is returning from a low power state
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - flags is invalid, or len is negative
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOMEM - Not enough space
> - * ENOTCONN - The endpoint is not connected
> - */
> -int scif_recv(scif_epd_t epd, void *msg, int len, int flags);
> -
> -/**
> - * scif_register() - Mark a memory region for remote access.
> - * @epd:		endpoint descriptor
> - * @addr:		starting virtual address
> - * @len:		length of range
> - * @offset:		offset of window
> - * @prot_flags:		read/write protection flags
> - * @map_flags:		mapping flags
> - *
> - * The scif_register() function opens a window, a range of whole pages o=
f
> the
> - * registered address space of the endpoint epd, starting at offset po a=
nd
> - * continuing for len bytes. The value of po, further described below, i=
s a
> - * function of the parameters offset and len, and the value of map_flags=
.
> Each
> - * page of the window represents the physical memory page which backs
> the
> - * corresponding page of the range of virtual address pages starting at =
addr
> - * and continuing for len bytes. addr and len are constrained to be mult=
iples
> - * of the page size. A successful scif_register() call returns po.
> - *
> - * When SCIF_MAP_FIXED is set in the map_flags argument, po will be offs=
et
> - * exactly, and offset is constrained to be a multiple of the page size.=
 The
> - * mapping established by scif_register() will not replace any existing
> - * registration; an error is returned if any page within the range [offs=
et,
> - * offset + len - 1] intersects an existing window.
> - *
> - * When SCIF_MAP_FIXED is not set, the implementation uses offset in an
> - * implementation-defined manner to arrive at po. The po value so chosen
> will
> - * be an area of the registered address space that the implementation
> deems
> - * suitable for a mapping of len bytes. An offset value of 0 is interpre=
ted as
> - * granting the implementation complete freedom in selecting po, subject=
 to
> - * constraints described below. A non-zero value of offset is taken to b=
e a
> - * suggestion of an offset near which the mapping should be placed. When
> the
> - * implementation selects a value for po, it does not replace any extant
> - * window. In all cases, po will be a multiple of the page size.
> - *
> - * The physical pages which are so represented by a window are available
> for
> - * access in calls to mmap(), scif_readfrom(), scif_writeto(),
> - * scif_vreadfrom(), and scif_vwriteto(). While a window is registered, =
the
> - * physical pages represented by the window will not be reused by the
> memory
> - * subsystem for any other purpose. Note that the same physical page may
> be
> - * represented by multiple windows.
> - *
> - * Subsequent operations which change the memory pages to which virtual
> - * addresses are mapped (such as mmap(), munmap()) have no effect on
> - * existing window.
> - *
> - * If the process will fork(), it is recommended that the registered
> - * virtual address range be marked with MADV_DONTFORK. Doing so will
> prevent
> - * problems due to copy-on-write semantics.
> - *
> - * The prot_flags argument is formed by OR'ing together one or more of t=
he
> - * following values.
> - * SCIF_PROT_READ - allow read operations from the window
> - * SCIF_PROT_WRITE - allow write operations to the window
> - *
> - * Return:
> - * Upon successful completion, scif_register() returns the offset at whi=
ch the
> - * mapping was placed (po); otherwise in user mode SCIF_REGISTER_FAILED
> (that
> - * is (off_t *)-1) is returned and errno is set to indicate the error; i=
n
> - * kernel mode the negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EADDRINUSE - SCIF_MAP_FIXED is set in map_flags, and pages in the
> range
> - * [offset, offset + len -1] are already registered
> - * EAGAIN - The mapping could not be performed due to lack of resources
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - map_flags is invalid, or prot_flags is invalid, or SCIF_MAP_=
FIXED
> is
> - * set in flags, and offset is not a multiple of the page size, or addr =
is not a
> - * multiple of the page size, or len is not a multiple of the page size,=
 or is
> - * 0, or offset is negative
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOMEM - Not enough space
> - * ENOTCONN -The endpoint is not connected
> - */
> -off_t scif_register(scif_epd_t epd, void *addr, size_t len, off_t offset=
,
> -		    int prot_flags, int map_flags);
> -
> -/**
> - * scif_unregister() - Mark a memory region for remote access.
> - * @epd:	endpoint descriptor
> - * @offset:	start of range to unregister
> - * @len:	length of range to unregister
> - *
> - * The scif_unregister() function closes those previously registered win=
dows
> - * which are entirely within the range [offset, offset + len - 1]. It is=
 an
> - * error to specify a range which intersects only a subrange of a window=
.
> - *
> - * On a successful return, pages within the window may no longer be
> specified
> - * in calls to mmap(), scif_readfrom(), scif_writeto(), scif_vreadfrom()=
,
> - * scif_vwriteto(), scif_get_pages, and scif_fence_signal(). The window,
> - * however, continues to exist until all previous references against it =
are
> - * removed. A window is referenced if there is a mapping to it created b=
y
> - * mmap(), or if scif_get_pages() was called against the window
> - * (and the pages have not been returned via scif_put_pages()). A window=
 is
> - * also referenced while an RMA, in which some range of the window is a
> source
> - * or destination, is in progress. Finally a window is referenced while =
some
> - * offset in that window was specified to scif_fence_signal(), and the R=
MAs
> - * marked by that call to scif_fence_signal() have not completed. While =
a
> - * window is in this state, its registered address space pages are not
> - * available for use in a new registered window.
> - *
> - * When all such references to the window have been removed, its
> references to
> - * all the physical pages which it represents are removed. Similarly, th=
e
> - * registered address space pages of the window become available for
> - * registration in a new window.
> - *
> - * Return:
> - * Upon successful completion, scif_unregister() returns 0; otherwise in=
 user
> - * mode -1 is returned and errno is set to indicate the error; in kernel=
 mode
> - * the negative of one of the following errors is returned. In the event=
 of an
> - * error, no windows are unregistered.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - the range [offset, offset + len - 1] intersects a subrange o=
f a
> - * window, or offset is negative
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENXIO - Offsets in the range [offset, offset + len - 1] are invalid f=
or the
> - * registered address space of epd
> - */
> -int scif_unregister(scif_epd_t epd, off_t offset, size_t len);
> -
> -/**
> - * scif_readfrom() - Copy from a remote address space
> - * @epd:	endpoint descriptor
> - * @loffset:	offset in local registered address space to
> - *		which to copy
> - * @len:	length of range to copy
> - * @roffset:	offset in remote registered address space
> - *		from which to copy
> - * @rma_flags:	transfer mode flags
> - *
> - * scif_readfrom() copies len bytes from the remote registered address
> space of
> - * the peer of endpoint epd, starting at the offset roffset to the local
> - * registered address space of epd, starting at the offset loffset.
> - *
> - * Each of the specified ranges [loffset, loffset + len - 1] and [roffse=
t,
> - * roffset + len - 1] must be within some registered window or windows o=
f
> the
> - * local and remote nodes. A range may intersect multiple registered
> windows,
> - * but only if those windows are contiguous in the registered address sp=
ace.
> - *
> - * If rma_flags includes SCIF_RMA_USECPU, then the data is copied using
> - * programmed read/writes. Otherwise the data is copied using DMA. If
> rma_-
> - * flags includes SCIF_RMA_SYNC, then scif_readfrom() will return after =
the
> - * transfer is complete. Otherwise, the transfer may be performed
> asynchron-
> - * ously. The order in which any two asynchronous RMA operations
> complete
> - * is non-deterministic. The synchronization functions, scif_fence_mark(=
)/
> - * scif_fence_wait() and scif_fence_signal(), can be used to synchronize=
 to
> - * the completion of asynchronous RMA operations on the same endpoint.
> - *
> - * The DMA transfer of individual bytes is not guaranteed to complete in
> - * address order. If rma_flags includes SCIF_RMA_ORDERED, then the last
> - * cacheline or partial cacheline of the source range will become visibl=
e on
> - * the destination node after all other transferred data in the source
> - * range has become visible on the destination node.
> - *
> - * The optimal DMA performance will likely be realized if both
> - * loffset and roffset are cacheline aligned (are a multiple of 64). Low=
er
> - * performance will likely be realized if loffset and roffset are not
> - * cacheline aligned but are separated by some multiple of 64. The lowes=
t
> level
> - * of performance is likely if loffset and roffset are not separated by =
a
> - * multiple of 64.
> - *
> - * The rma_flags argument is formed by ORing together zero or more of th=
e
> - * following values.
> - * SCIF_RMA_USECPU - perform the transfer using the CPU, otherwise use
> the DMA
> - *	engine.
> - * SCIF_RMA_SYNC - perform the transfer synchronously, returning after t=
he
> - *		transfer has completed. Passing this flag results in the
> - *		current implementation busy waiting and consuming CPU
> cycles
> - *		while the DMA transfer is in progress for best performance
> by
> - *		avoiding the interrupt latency.
> - * SCIF_RMA_ORDERED - ensure that the last cacheline or partial cachelin=
e
> of
> - *		the source range becomes visible on the destination node
> - *		after all other transferred data in the source range has
> - *		become visible on the destination
> - *
> - * Return:
> - * Upon successful completion, scif_readfrom() returns 0; otherwise in u=
ser
> - * mode -1 is returned and errno is set to indicate the error; in kernel=
 mode
> - * the negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EACCES - Attempt to write to a read-only range
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - rma_flags is invalid
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENXIO - The range [loffset, loffset + len - 1] is invalid for the reg=
istered
> - * address space of epd, or, The range [roffset, roffset + len - 1] is i=
nvalid
> - * for the registered address space of the peer of epd, or loffset or ro=
ffset
> - * is negative
> - */
> -int scif_readfrom(scif_epd_t epd, off_t loffset, size_t len, off_t
> -		  roffset, int rma_flags);
> -
> -/**
> - * scif_writeto() - Copy to a remote address space
> - * @epd:	endpoint descriptor
> - * @loffset:	offset in local registered address space
> - *		from which to copy
> - * @len:	length of range to copy
> - * @roffset:	offset in remote registered address space to
> - *		which to copy
> - * @rma_flags:	transfer mode flags
> - *
> - * scif_writeto() copies len bytes from the local registered address spa=
ce of
> - * epd, starting at the offset loffset to the remote registered address =
space
> - * of the peer of endpoint epd, starting at the offset roffset.
> - *
> - * Each of the specified ranges [loffset, loffset + len - 1] and [roffse=
t,
> - * roffset + len - 1] must be within some registered window or windows o=
f
> the
> - * local and remote nodes. A range may intersect multiple registered
> windows,
> - * but only if those windows are contiguous in the registered address sp=
ace.
> - *
> - * If rma_flags includes SCIF_RMA_USECPU, then the data is copied using
> - * programmed read/writes. Otherwise the data is copied using DMA. If
> rma_-
> - * flags includes SCIF_RMA_SYNC, then scif_writeto() will return after t=
he
> - * transfer is complete. Otherwise, the transfer may be performed
> asynchron-
> - * ously. The order in which any two asynchronous RMA operations
> complete
> - * is non-deterministic. The synchronization functions, scif_fence_mark(=
)/
> - * scif_fence_wait() and scif_fence_signal(), can be used to synchronize=
 to
> - * the completion of asynchronous RMA operations on the same endpoint.
> - *
> - * The DMA transfer of individual bytes is not guaranteed to complete in
> - * address order. If rma_flags includes SCIF_RMA_ORDERED, then the last
> - * cacheline or partial cacheline of the source range will become visibl=
e on
> - * the destination node after all other transferred data in the source
> - * range has become visible on the destination node.
> - *
> - * The optimal DMA performance will likely be realized if both
> - * loffset and roffset are cacheline aligned (are a multiple of 64). Low=
er
> - * performance will likely be realized if loffset and roffset are not ca=
cheline
> - * aligned but are separated by some multiple of 64. The lowest level of
> - * performance is likely if loffset and roffset are not separated by a m=
ultiple
> - * of 64.
> - *
> - * The rma_flags argument is formed by ORing together zero or more of th=
e
> - * following values.
> - * SCIF_RMA_USECPU - perform the transfer using the CPU, otherwise use
> the DMA
> - *			engine.
> - * SCIF_RMA_SYNC - perform the transfer synchronously, returning after t=
he
> - *		transfer has completed. Passing this flag results in the
> - *		current implementation busy waiting and consuming CPU
> cycles
> - *		while the DMA transfer is in progress for best performance
> by
> - *		avoiding the interrupt latency.
> - * SCIF_RMA_ORDERED - ensure that the last cacheline or partial cachelin=
e
> of
> - *		the source range becomes visible on the destination node
> - *		after all other transferred data in the source range has
> - *		become visible on the destination
> - *
> - * Return:
> - * Upon successful completion, scif_readfrom() returns 0; otherwise in u=
ser
> - * mode -1 is returned and errno is set to indicate the error; in kernel=
 mode
> - * the negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EACCES - Attempt to write to a read-only range
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - rma_flags is invalid
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENXIO - The range [loffset, loffset + len - 1] is invalid for the reg=
istered
> - * address space of epd, or, The range [roffset , roffset + len -1] is i=
nvalid
> - * for the registered address space of the peer of epd, or loffset or ro=
ffset
> - * is negative
> - */
> -int scif_writeto(scif_epd_t epd, off_t loffset, size_t len, off_t
> -		 roffset, int rma_flags);
> -
> -/**
> - * scif_vreadfrom() - Copy from a remote address space
> - * @epd:	endpoint descriptor
> - * @addr:	address to which to copy
> - * @len:	length of range to copy
> - * @roffset:	offset in remote registered address space
> - *		from which to copy
> - * @rma_flags:	transfer mode flags
> - *
> - * scif_vreadfrom() copies len bytes from the remote registered address
> - * space of the peer of endpoint epd, starting at the offset roffset, to=
 local
> - * memory, starting at addr.
> - *
> - * The specified range [roffset, roffset + len - 1] must be within some
> - * registered window or windows of the remote nodes. The range may
> - * intersect multiple registered windows, but only if those windows are
> - * contiguous in the registered address space.
> - *
> - * If rma_flags includes SCIF_RMA_USECPU, then the data is copied using
> - * programmed read/writes. Otherwise the data is copied using DMA. If
> rma_-
> - * flags includes SCIF_RMA_SYNC, then scif_vreadfrom() will return after=
 the
> - * transfer is complete. Otherwise, the transfer may be performed
> asynchron-
> - * ously. The order in which any two asynchronous RMA operations
> complete
> - * is non-deterministic. The synchronization functions, scif_fence_mark(=
)/
> - * scif_fence_wait() and scif_fence_signal(), can be used to synchronize=
 to
> - * the completion of asynchronous RMA operations on the same endpoint.
> - *
> - * The DMA transfer of individual bytes is not guaranteed to complete in
> - * address order. If rma_flags includes SCIF_RMA_ORDERED, then the last
> - * cacheline or partial cacheline of the source range will become visibl=
e on
> - * the destination node after all other transferred data in the source
> - * range has become visible on the destination node.
> - *
> - * If rma_flags includes SCIF_RMA_USECACHE, then the physical pages whic=
h
> back
> - * the specified local memory range may be remain in a pinned state even
> after
> - * the specified transfer completes. This may reduce overhead if some or=
 all
> of
> - * the same virtual address range is referenced in a subsequent call of
> - * scif_vreadfrom() or scif_vwriteto().
> - *
> - * The optimal DMA performance will likely be realized if both
> - * addr and roffset are cacheline aligned (are a multiple of 64). Lower
> - * performance will likely be realized if addr and roffset are not
> - * cacheline aligned but are separated by some multiple of 64. The lowes=
t
> level
> - * of performance is likely if addr and roffset are not separated by a
> - * multiple of 64.
> - *
> - * The rma_flags argument is formed by ORing together zero or more of th=
e
> - * following values.
> - * SCIF_RMA_USECPU - perform the transfer using the CPU, otherwise use
> the DMA
> - *	engine.
> - * SCIF_RMA_USECACHE - enable registration caching
> - * SCIF_RMA_SYNC - perform the transfer synchronously, returning after t=
he
> - *		transfer has completed. Passing this flag results in the
> - *		current implementation busy waiting and consuming CPU
> cycles
> - *		while the DMA transfer is in progress for best performance
> by
> - *		avoiding the interrupt latency.
> - * SCIF_RMA_ORDERED - ensure that the last cacheline or partial cachelin=
e
> of
> - *	the source range becomes visible on the destination node
> - *	after all other transferred data in the source range has
> - *	become visible on the destination
> - *
> - * Return:
> - * Upon successful completion, scif_vreadfrom() returns 0; otherwise in =
user
> - * mode -1 is returned and errno is set to indicate the error; in kernel=
 mode
> - * the negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EACCES - Attempt to write to a read-only range
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - rma_flags is invalid
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENXIO - Offsets in the range [roffset, roffset + len - 1] are invalid=
 for the
> - * registered address space of epd
> - */
> -int scif_vreadfrom(scif_epd_t epd, void *addr, size_t len, off_t roffset=
,
> -		   int rma_flags);
> -
> -/**
> - * scif_vwriteto() - Copy to a remote address space
> - * @epd:	endpoint descriptor
> - * @addr:	address from which to copy
> - * @len:	length of range to copy
> - * @roffset:	offset in remote registered address space to
> - *		which to copy
> - * @rma_flags:	transfer mode flags
> - *
> - * scif_vwriteto() copies len bytes from the local memory, starting at a=
ddr, to
> - * the remote registered address space of the peer of endpoint epd, star=
ting
> at
> - * the offset roffset.
> - *
> - * The specified range [roffset, roffset + len - 1] must be within some
> - * registered window or windows of the remote nodes. The range may
> intersect
> - * multiple registered windows, but only if those windows are contiguous=
 in
> the
> - * registered address space.
> - *
> - * If rma_flags includes SCIF_RMA_USECPU, then the data is copied using
> - * programmed read/writes. Otherwise the data is copied using DMA. If
> rma_-
> - * flags includes SCIF_RMA_SYNC, then scif_vwriteto() will return after =
the
> - * transfer is complete. Otherwise, the transfer may be performed
> asynchron-
> - * ously. The order in which any two asynchronous RMA operations
> complete
> - * is non-deterministic. The synchronization functions, scif_fence_mark(=
)/
> - * scif_fence_wait() and scif_fence_signal(), can be used to synchronize=
 to
> - * the completion of asynchronous RMA operations on the same endpoint.
> - *
> - * The DMA transfer of individual bytes is not guaranteed to complete in
> - * address order. If rma_flags includes SCIF_RMA_ORDERED, then the last
> - * cacheline or partial cacheline of the source range will become visibl=
e on
> - * the destination node after all other transferred data in the source
> - * range has become visible on the destination node.
> - *
> - * If rma_flags includes SCIF_RMA_USECACHE, then the physical pages whic=
h
> back
> - * the specified local memory range may be remain in a pinned state even
> after
> - * the specified transfer completes. This may reduce overhead if some or=
 all
> of
> - * the same virtual address range is referenced in a subsequent call of
> - * scif_vreadfrom() or scif_vwriteto().
> - *
> - * The optimal DMA performance will likely be realized if both
> - * addr and offset are cacheline aligned (are a multiple of 64). Lower
> - * performance will likely be realized if addr and offset are not cachel=
ine
> - * aligned but are separated by some multiple of 64. The lowest level of
> - * performance is likely if addr and offset are not separated by a multi=
ple of
> - * 64.
> - *
> - * The rma_flags argument is formed by ORing together zero or more of th=
e
> - * following values.
> - * SCIF_RMA_USECPU - perform the transfer using the CPU, otherwise use
> the DMA
> - *	engine.
> - * SCIF_RMA_USECACHE - allow registration caching
> - * SCIF_RMA_SYNC - perform the transfer synchronously, returning after t=
he
> - *		transfer has completed. Passing this flag results in the
> - *		current implementation busy waiting and consuming CPU
> cycles
> - *		while the DMA transfer is in progress for best performance
> by
> - *		avoiding the interrupt latency.
> - * SCIF_RMA_ORDERED - ensure that the last cacheline or partial cachelin=
e
> of
> - *		the source range becomes visible on the destination node
> - *		after all other transferred data in the source range has
> - *		become visible on the destination
> - *
> - * Return:
> - * Upon successful completion, scif_vwriteto() returns 0; otherwise in u=
ser
> - * mode -1 is returned and errno is set to indicate the error; in kernel=
 mode
> - * the negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EACCES - Attempt to write to a read-only range
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - rma_flags is invalid
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENXIO - Offsets in the range [roffset, roffset + len - 1] are invalid=
 for the
> - * registered address space of epd
> - */
> -int scif_vwriteto(scif_epd_t epd, void *addr, size_t len, off_t roffset,
> -		  int rma_flags);
> -
> -/**
> - * scif_fence_mark() - Mark previously issued RMAs
> - * @epd:	endpoint descriptor
> - * @flags:	control flags
> - * @mark:	marked value returned as output.
> - *
> - * scif_fence_mark() returns after marking the current set of all
> uncompleted
> - * RMAs initiated through the endpoint epd or the current set of all
> - * uncompleted RMAs initiated through the peer of endpoint epd. The RMAs
> are
> - * marked with a value returned at mark. The application may subsequentl=
y
> call
> - * scif_fence_wait(), passing the value returned at mark, to await compl=
etion
> - * of all RMAs so marked.
> - *
> - * The flags argument has exactly one of the following values.
> - * SCIF_FENCE_INIT_SELF - RMA operations initiated through endpoint
> - *	epd are marked
> - * SCIF_FENCE_INIT_PEER - RMA operations initiated through the peer
> - *	of endpoint epd are marked
> - *
> - * Return:
> - * Upon successful completion, scif_fence_mark() returns 0; otherwise in
> user
> - * mode -1 is returned and errno is set to indicate the error; in kernel=
 mode
> - * the negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - flags is invalid
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENOMEM - Insufficient kernel memory was available
> - */
> -int scif_fence_mark(scif_epd_t epd, int flags, int *mark);
> -
> -/**
> - * scif_fence_wait() - Wait for completion of marked RMAs
> - * @epd:	endpoint descriptor
> - * @mark:	mark request
> - *
> - * scif_fence_wait() returns after all RMAs marked with mark have
> completed.
> - * The value passed in mark must have been obtained in a previous call t=
o
> - * scif_fence_mark().
> - *
> - * Return:
> - * Upon successful completion, scif_fence_wait() returns 0; otherwise in
> user
> - * mode -1 is returned and errno is set to indicate the error; in kernel=
 mode
> - * the negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENOMEM - Insufficient kernel memory was available
> - */
> -int scif_fence_wait(scif_epd_t epd, int mark);
> -
> -/**
> - * scif_fence_signal() - Request a memory update on completion of RMAs
> - * @epd:	endpoint descriptor
> - * @loff:	local offset
> - * @lval:	local value to write to loffset
> - * @roff:	remote offset
> - * @rval:	remote value to write to roffset
> - * @flags:	flags
> - *
> - * scif_fence_signal() returns after marking the current set of all
> uncompleted
> - * RMAs initiated through the endpoint epd or marking the current set of=
 all
> - * uncompleted RMAs initiated through the peer of endpoint epd.
> - *
> - * If flags includes SCIF_SIGNAL_LOCAL, then on completion of the RMAs i=
n
> the
> - * marked set, lval is written to memory at the address corresponding to
> offset
> - * loff in the local registered address space of epd. loff must be withi=
n a
> - * registered window. If flags includes SCIF_SIGNAL_REMOTE, then on
> completion
> - * of the RMAs in the marked set, rval is written to memory at the addre=
ss
> - * corresponding to offset roff in the remote registered address space o=
f epd.
> - * roff must be within a remote registered window of the peer of epd. No=
te
> - * that any specified offset must be DWORD (4 byte / 32 bit) aligned.
> - *
> - * The flags argument is formed by OR'ing together the following.
> - * Exactly one of the following values.
> - * SCIF_FENCE_INIT_SELF - RMA operations initiated through endpoint
> - *	epd are marked
> - * SCIF_FENCE_INIT_PEER - RMA operations initiated through the peer
> - *	of endpoint epd are marked
> - * One or more of the following values.
> - * SCIF_SIGNAL_LOCAL - On completion of the marked set of RMAs, write
> lval to
> - *	memory at the address corresponding to offset loff in the local
> - *	registered address space of epd.
> - * SCIF_SIGNAL_REMOTE - On completion of the marked set of RMAs, write
> rval to
> - *	memory at the address corresponding to offset roff in the remote
> - *	registered address space of epd.
> - *
> - * Return:
> - * Upon successful completion, scif_fence_signal() returns 0; otherwise =
in
> - * user mode -1 is returned and errno is set to indicate the error; in k=
ernel
> - * mode the negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EBADF, ENOTTY - epd is not a valid endpoint descriptor
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - flags is invalid, or loff or roff are not DWORD aligned
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENXIO - loff is invalid for the registered address of epd, or roff is=
 invalid
> - * for the registered address space, of the peer of epd
> - */
> -int scif_fence_signal(scif_epd_t epd, off_t loff, u64 lval, off_t roff,
> -		      u64 rval, int flags);
> -
> -/**
> - * scif_get_node_ids() - Return information about online nodes
> - * @nodes:	array in which to return online node IDs
> - * @len:	number of entries in the nodes array
> - * @self:	address to place the node ID of the local node
> - *
> - * scif_get_node_ids() fills in the nodes array with up to len node IDs =
of the
> - * nodes in the SCIF network. If there is not enough space in nodes, as
> - * indicated by the len parameter, only len node IDs are returned in nod=
es.
> The
> - * return value of scif_get_node_ids() is the total number of nodes curr=
ently
> in
> - * the SCIF network. By checking the return value against the len parame=
ter,
> - * the user may determine if enough space for nodes was allocated.
> - *
> - * The node ID of the local node is returned at self.
> - *
> - * Return:
> - * Upon successful completion, scif_get_node_ids() returns the actual
> number of
> - * online nodes in the SCIF network including 'self'; otherwise in user =
mode
> - * -1 is returned and errno is set to indicate the error; in kernel mode=
 no
> - * errors are returned.
> - */
> -int scif_get_node_ids(u16 *nodes, int len, u16 *self);
> -
> -/**
> - * scif_pin_pages() - Pin a set of pages
> - * @addr:		Virtual address of range to pin
> - * @len:		Length of range to pin
> - * @prot_flags:		Page protection flags
> - * @map_flags:		Page classification flags
> - * @pinned_pages:	Handle to pinned pages
> - *
> - * scif_pin_pages() pins (locks in physical memory) the physical pages w=
hich
> - * back the range of virtual address pages starting at addr and continui=
ng for
> - * len bytes. addr and len are constrained to be multiples of the page s=
ize. A
> - * successful scif_pin_pages() call returns a handle to pinned_pages whi=
ch
> may
> - * be used in subsequent calls to scif_register_pinned_pages().
> - *
> - * The pages will remain pinned as long as there is a reference against =
the
> - * scif_pinned_pages_t value returned by scif_pin_pages() and until
> - * scif_unpin_pages() is called, passing the scif_pinned_pages_t value. =
A
> - * reference is added to a scif_pinned_pages_t value each time a window =
is
> - * created by calling scif_register_pinned_pages() and passing the
> - * scif_pinned_pages_t value. A reference is removed from a
> - * scif_pinned_pages_t value each time such a window is deleted.
> - *
> - * Subsequent operations which change the memory pages to which virtual
> - * addresses are mapped (such as mmap(), munmap()) have no effect on
> the
> - * scif_pinned_pages_t value or windows created against it.
> - *
> - * If the process will fork(), it is recommended that the registered
> - * virtual address range be marked with MADV_DONTFORK. Doing so will
> prevent
> - * problems due to copy-on-write semantics.
> - *
> - * The prot_flags argument is formed by OR'ing together one or more of t=
he
> - * following values.
> - * SCIF_PROT_READ - allow read operations against the pages
> - * SCIF_PROT_WRITE - allow write operations against the pages
> - * The map_flags argument can be set as SCIF_MAP_KERNEL to interpret
> addr as a
> - * kernel space address. By default, addr is interpreted as a user space
> - * address.
> - *
> - * Return:
> - * Upon successful completion, scif_pin_pages() returns 0; otherwise the
> - * negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EINVAL - prot_flags is invalid, map_flags is invalid, or offset is ne=
gative
> - * ENOMEM - Not enough space
> - */
> -int scif_pin_pages(void *addr, size_t len, int prot_flags, int map_flags=
,
> -		   scif_pinned_pages_t *pinned_pages);
> -
> -/**
> - * scif_unpin_pages() - Unpin a set of pages
> - * @pinned_pages:	Handle to pinned pages to be unpinned
> - *
> - * scif_unpin_pages() prevents scif_register_pinned_pages() from registe=
ring
> new
> - * windows against pinned_pages. The physical pages represented by
> pinned_pages
> - * will remain pinned until all windows previously registered against
> - * pinned_pages are deleted (the window is scif_unregister()'d and all
> - * references to the window are removed (see scif_unregister()).
> - *
> - * pinned_pages must have been obtain from a previous call to
> scif_pin_pages().
> - * After calling scif_unpin_pages(), it is an error to pass pinned_pages=
 to
> - * scif_register_pinned_pages().
> - *
> - * Return:
> - * Upon successful completion, scif_unpin_pages() returns 0; otherwise t=
he
> - * negative of one of the following errors is returned.
> - *
> - * Errors:
> - * EINVAL - pinned_pages is not valid
> - */
> -int scif_unpin_pages(scif_pinned_pages_t pinned_pages);
> -
> -/**
> - * scif_register_pinned_pages() - Mark a memory region for remote access=
.
> - * @epd:		endpoint descriptor
> - * @pinned_pages:	Handle to pinned pages
> - * @offset:		Registered address space offset
> - * @map_flags:		Flags which control where pages are mapped
> - *
> - * The scif_register_pinned_pages() function opens a window, a range of
> whole
> - * pages of the registered address space of the endpoint epd, starting a=
t
> - * offset po. The value of po, further described below, is a function of=
 the
> - * parameters offset and pinned_pages, and the value of map_flags. Each
> page of
> - * the window represents a corresponding physical memory page of the
> range
> - * represented by pinned_pages; the length of the window is the same as
> the
> - * length of range represented by pinned_pages. A successful
> - * scif_register_pinned_pages() call returns po as the return value.
> - *
> - * When SCIF_MAP_FIXED is set in the map_flags argument, po will be offs=
et
> - * exactly, and offset is constrained to be a multiple of the page size.=
 The
> - * mapping established by scif_register_pinned_pages() will not replace =
any
> - * existing registration; an error is returned if any page of the new wi=
ndow
> - * would intersect an existing window.
> - *
> - * When SCIF_MAP_FIXED is not set, the implementation uses offset in an
> - * implementation-defined manner to arrive at po. The po so chosen will =
be
> an
> - * area of the registered address space that the implementation deems
> suitable
> - * for a mapping of the required size. An offset value of 0 is interpret=
ed as
> - * granting the implementation complete freedom in selecting po, subject=
 to
> - * constraints described below. A non-zero value of offset is taken to b=
e a
> - * suggestion of an offset near which the mapping should be placed. When
> the
> - * implementation selects a value for po, it does not replace any extant
> - * window. In all cases, po will be a multiple of the page size.
> - *
> - * The physical pages which are so represented by a window are available
> for
> - * access in calls to scif_get_pages(), scif_readfrom(), scif_writeto(),
> - * scif_vreadfrom(), and scif_vwriteto(). While a window is registered, =
the
> - * physical pages represented by the window will not be reused by the
> memory
> - * subsystem for any other purpose. Note that the same physical page may
> be
> - * represented by multiple windows.
> - *
> - * Windows created by scif_register_pinned_pages() are unregistered by
> - * scif_unregister().
> - *
> - * The map_flags argument can be set to SCIF_MAP_FIXED which interprets
> a
> - * fixed offset.
> - *
> - * Return:
> - * Upon successful completion, scif_register_pinned_pages() returns the
> offset
> - * at which the mapping was placed (po); otherwise the negative of one o=
f
> the
> - * following errors is returned.
> - *
> - * Errors:
> - * EADDRINUSE - SCIF_MAP_FIXED is set in map_flags and pages in the new
> window
> - * would intersect an existing window
> - * EAGAIN - The mapping could not be performed due to lack of resources
> - * ECONNRESET - Connection reset by peer
> - * EINVAL - map_flags is invalid, or SCIF_MAP_FIXED is set in map_flags,=
 and
> - * offset is not a multiple of the page size, or offset is negative
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOMEM - Not enough space
> - * ENOTCONN - The endpoint is not connected
> - */
> -off_t scif_register_pinned_pages(scif_epd_t epd,
> -				 scif_pinned_pages_t pinned_pages,
> -				 off_t offset, int map_flags);
> -
> -/**
> - * scif_get_pages() - Add references to remote registered pages
> - * @epd:	endpoint descriptor
> - * @offset:	remote registered offset
> - * @len:	length of range of pages
> - * @pages:	returned scif_range structure
> - *
> - * scif_get_pages() returns the addresses of the physical pages represen=
ted
> by
> - * those pages of the registered address space of the peer of epd, start=
ing at
> - * offset and continuing for len bytes. offset and len are constrained t=
o be
> - * multiples of the page size.
> - *
> - * All of the pages in the specified range [offset, offset + len - 1] mu=
st be
> - * within a single window of the registered address space of the peer of=
 epd.
> - *
> - * The addresses are returned as a virtually contiguous array pointed to=
 by
> the
> - * phys_addr component of the scif_range structure whose address is
> returned in
> - * pages. The nr_pages component of scif_range is the length of the arra=
y.
> The
> - * prot_flags component of scif_range holds the protection flag value pa=
ssed
> - * when the pages were registered.
> - *
> - * Each physical page whose address is returned by scif_get_pages() rema=
ins
> - * available and will not be released for reuse until the scif_range str=
ucture
> - * is returned in a call to scif_put_pages(). The scif_range structure r=
eturned
> - * by scif_get_pages() must be unmodified.
> - *
> - * It is an error to call scif_close() on an endpoint on which a scif_ra=
nge
> - * structure of that endpoint has not been returned to scif_put_pages().
> - *
> - * Return:
> - * Upon successful completion, scif_get_pages() returns 0; otherwise the
> - * negative of one of the following errors is returned.
> - * Errors:
> - * ECONNRESET - Connection reset by peer.
> - * EINVAL - offset is not a multiple of the page size, or offset is nega=
tive, or
> - * len is not a multiple of the page size
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - * ENXIO - Offsets in the range [offset, offset + len - 1] are invalid
> - * for the registered address space of the peer epd
> - */
> -int scif_get_pages(scif_epd_t epd, off_t offset, size_t len,
> -		   struct scif_range **pages);
> -
> -/**
> - * scif_put_pages() - Remove references from remote registered pages
> - * @pages:	pages to be returned
> - *
> - * scif_put_pages() releases a scif_range structure previously obtained =
by
> - * calling scif_get_pages(). The physical pages represented by pages may
> - * be reused when the window which represented those pages is
> unregistered.
> - * Therefore, those pages must not be accessed after calling
> scif_put_pages().
> - *
> - * Return:
> - * Upon successful completion, scif_put_pages() returns 0; otherwise the
> - * negative of one of the following errors is returned.
> - * Errors:
> - * EINVAL - pages does not point to a valid scif_range structure, or
> - * the scif_range structure pointed to by pages was already returned
> - * ENODEV - The remote node is lost or existed, but is not currently in =
the
> - * network since it may have crashed
> - * ENOTCONN - The endpoint is not connected
> - */
> -int scif_put_pages(struct scif_range *pages);
> -
> -/**
> - * scif_poll() - Wait for some event on an endpoint
> - * @epds:	Array of endpoint descriptors
> - * @nepds:	Length of epds
> - * @timeout:	Upper limit on time for which scif_poll() will block
> - *
> - * scif_poll() waits for one of a set of endpoints to become ready to pe=
rform
> - * an I/O operation.
> - *
> - * The epds argument specifies the endpoint descriptors to be examined a=
nd
> the
> - * events of interest for each endpoint descriptor. epds is a pointer to=
 an
> - * array with one member for each open endpoint descriptor of interest.
> - *
> - * The number of items in the epds array is specified in nepds. The epd =
field
> - * of scif_pollepd is an endpoint descriptor of an open endpoint. The fi=
eld
> - * events is a bitmask specifying the events which the application is
> - * interested in. The field revents is an output parameter, filled by th=
e
> - * kernel with the events that actually occurred. The bits returned in r=
events
> - * can include any of those specified in events, or one of the values
> EPOLLERR,
> - * EPOLLHUP, or EPOLLNVAL. (These three bits are meaningless in the even=
ts
> - * field, and will be set in the revents field whenever the correspondin=
g
> - * condition is true.)
> - *
> - * If none of the events requested (and no error) has occurred for any o=
f the
> - * endpoint descriptors, then scif_poll() blocks until one of the events=
 occurs.
> - *
> - * The timeout argument specifies an upper limit on the time for which
> - * scif_poll() will block, in milliseconds. Specifying a negative value =
in
> - * timeout means an infinite timeout.
> - *
> - * The following bits may be set in events and returned in revents.
> - * EPOLLIN - Data may be received without blocking. For a connected
> - * endpoint, this means that scif_recv() may be called without blocking.=
 For a
> - * listening endpoint, this means that scif_accept() may be called witho=
ut
> - * blocking.
> - * EPOLLOUT - Data may be sent without blocking. For a connected endpoin=
t,
> this
> - * means that scif_send() may be called without blocking. EPOLLOUT may
> also be
> - * used to block waiting for a non-blocking connect to complete. This bi=
t
> value
> - * has no meaning for a listening endpoint and is ignored if specified.
> - *
> - * The following bits are only returned in revents, and are ignored if s=
et in
> - * events.
> - * EPOLLERR - An error occurred on the endpoint
> - * EPOLLHUP - The connection to the peer endpoint was disconnected
> - * EPOLLNVAL - The specified endpoint descriptor is invalid.
> - *
> - * Return:
> - * Upon successful completion, scif_poll() returns a non-negative value.=
 A
> - * positive value indicates the total number of endpoint descriptors tha=
t
> have
> - * been selected (that is, endpoint descriptors for which the revents me=
mber
> is
> - * non-zero). A value of 0 indicates that the call timed out and no endp=
oint
> - * descriptors have been selected. Otherwise in user mode -1 is returned
> and
> - * errno is set to indicate the error; in kernel mode the negative of on=
e of
> - * the following errors is returned.
> - *
> - * Errors:
> - * EINTR - A signal occurred before any requested event
> - * EINVAL - The nepds argument is greater than {OPEN_MAX}
> - * ENOMEM - There was no space to allocate file descriptor tables
> - */
> -int scif_poll(struct scif_pollepd *epds, unsigned int nepds, long timeou=
t);
> -
> -/**
> - * scif_client_register() - Register a SCIF client
> - * @client:	client to be registered
> - *
> - * scif_client_register() registers a SCIF client. The probe() method
> - * of the client is called when SCIF peer devices come online and the
> - * remove() method is called when the peer devices disappear.
> - *
> - * Return:
> - * Upon successful completion, scif_client_register() returns a non-nega=
tive
> - * value. Otherwise the return value is the same as
> subsys_interface_register()
> - * in the kernel.
> - */
> -int scif_client_register(struct scif_client *client);
> -
> -/**
> - * scif_client_unregister() - Unregister a SCIF client
> - * @client:	client to be unregistered
> - *
> - * scif_client_unregister() unregisters a SCIF client.
> - *
> - * Return:
> - * None
> - */
> -void scif_client_unregister(struct scif_client *client);
> -
> -#endif /* __SCIF_H__ */
> diff --git a/include/uapi/linux/mic_common.h
> b/include/uapi/linux/mic_common.h
> deleted file mode 100644
> index 504e523f702c..000000000000
> --- a/include/uapi/linux/mic_common.h
> +++ /dev/null
> @@ -1,235 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, version 2, as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * General Public License for more details.
> - *
> - * The full GNU General Public License is included in this distribution =
in
> - * the file called "COPYING".
> - *
> - * Intel MIC driver.
> - *
> - */
> -#ifndef __MIC_COMMON_H_
> -#define __MIC_COMMON_H_
> -
> -#include <linux/virtio_ring.h>
> -
> -#define __mic_align(a, x) (((a) + (x) - 1) & ~((x) - 1))
> -
> -/**
> - * struct mic_device_desc: Virtio device information shared between the
> - * virtio driver and userspace backend
> - *
> - * @type: Device type: console/network/disk etc.  Type 0/-1 terminates.
> - * @num_vq: Number of virtqueues.
> - * @feature_len: Number of bytes of feature bits.  Multiply by 2: one fo=
r
> -   host features and one for guest acknowledgements.
> - * @config_len: Number of bytes of the config array after virtqueues.
> - * @status: A status byte, written by the Guest.
> - * @config: Start of the following variable length config.
> - */
> -struct mic_device_desc {
> -	__s8 type;
> -	__u8 num_vq;
> -	__u8 feature_len;
> -	__u8 config_len;
> -	__u8 status;
> -	__le64 config[0];
> -} __attribute__ ((aligned(8)));
> -
> -/**
> - * struct mic_device_ctrl: Per virtio device information in the device p=
age
> - * used internally by the host and card side drivers.
> - *
> - * @vdev: Used for storing MIC vdev information by the guest.
> - * @config_change: Set to 1 by host when a config change is requested.
> - * @vdev_reset: Set to 1 by guest to indicate virtio device has been res=
et.
> - * @guest_ack: Set to 1 by guest to ack a command.
> - * @host_ack: Set to 1 by host to ack a command.
> - * @used_address_updated: Set to 1 by guest when the used address
> should be
> - * updated.
> - * @c2h_vdev_db: The doorbell number to be used by guest. Set by host.
> - * @h2c_vdev_db: The doorbell number to be used by host. Set by guest.
> - */
> -struct mic_device_ctrl {
> -	__le64 vdev;
> -	__u8 config_change;
> -	__u8 vdev_reset;
> -	__u8 guest_ack;
> -	__u8 host_ack;
> -	__u8 used_address_updated;
> -	__s8 c2h_vdev_db;
> -	__s8 h2c_vdev_db;
> -} __attribute__ ((aligned(8)));
> -
> -/**
> - * struct mic_bootparam: Virtio device independent information in device
> page
> - *
> - * @magic: A magic value used by the card to ensure it can see the host
> - * @h2c_config_db: Host to Card Virtio config doorbell set by card
> - * @node_id: Unique id of the node
> - * @h2c_scif_db - Host to card SCIF doorbell set by card
> - * @c2h_scif_db - Card to host SCIF doorbell set by host
> - * @scif_host_dma_addr - SCIF host queue pair DMA address
> - * @scif_card_dma_addr - SCIF card queue pair DMA address
> - */
> -struct mic_bootparam {
> -	__le32 magic;
> -	__s8 h2c_config_db;
> -	__u8 node_id;
> -	__u8 h2c_scif_db;
> -	__u8 c2h_scif_db;
> -	__u64 scif_host_dma_addr;
> -	__u64 scif_card_dma_addr;
> -} __attribute__ ((aligned(8)));
> -
> -/**
> - * struct mic_device_page: High level representation of the device page
> - *
> - * @bootparam: The bootparam structure is used for sharing information
> and
> - * status updates between MIC host and card drivers.
> - * @desc: Array of MIC virtio device descriptors.
> - */
> -struct mic_device_page {
> -	struct mic_bootparam bootparam;
> -	struct mic_device_desc desc[0];
> -};
> -/**
> - * struct mic_vqconfig: This is how we expect the device configuration f=
ield
> - * for a virtqueue to be laid out in config space.
> - *
> - * @address: Guest/MIC physical address of the virtio ring
> - * (avail and desc rings)
> - * @used_address: Guest/MIC physical address of the used ring
> - * @num: The number of entries in the virtio_ring
> - */
> -struct mic_vqconfig {
> -	__le64 address;
> -	__le64 used_address;
> -	__le16 num;
> -} __attribute__ ((aligned(8)));
> -
> -/*
> - * The alignment to use between consumer and producer parts of vring.
> - * This is pagesize for historical reasons.
> - */
> -#define MIC_VIRTIO_RING_ALIGN		4096
> -
> -#define MIC_MAX_VRINGS			4
> -#define MIC_VRING_ENTRIES		128
> -
> -/*
> - * Max vring entries (power of 2) to ensure desc and avail rings
> - * fit in a single page
> - */
> -#define MIC_MAX_VRING_ENTRIES		128
> -
> -/**
> - * Max size of the desc block in bytes: includes:
> - *	- struct mic_device_desc
> - *	- struct mic_vqconfig (num_vq of these)
> - *	- host and guest features
> - *	- virtio device config space
> - */
> -#define MIC_MAX_DESC_BLK_SIZE		256
> -
> -/**
> - * struct _mic_vring_info - Host vring info exposed to userspace backend
> - * for the avail index and magic for the card.
> - *
> - * @avail_idx: host avail idx
> - * @magic: A magic debug cookie.
> - */
> -struct _mic_vring_info {
> -	__u16 avail_idx;
> -	__le32 magic;
> -};
> -
> -/**
> - * struct mic_vring - Vring information.
> - *
> - * @vr: The virtio ring.
> - * @info: Host vring information exposed to the userspace backend for th=
e
> - * avail index and magic for the card.
> - * @va: The va for the buffer allocated for vr and info.
> - * @len: The length of the buffer required for allocating vr and info.
> - */
> -struct mic_vring {
> -	struct vring vr;
> -	struct _mic_vring_info *info;
> -	void *va;
> -	int len;
> -};
> -
> -#define mic_aligned_desc_size(d) __mic_align(mic_desc_size(d), 8)
> -
> -#ifndef INTEL_MIC_CARD
> -static inline unsigned mic_desc_size(const struct mic_device_desc *desc)
> -{
> -	return sizeof(*desc) + desc->num_vq * sizeof(struct mic_vqconfig)
> -		+ desc->feature_len * 2 + desc->config_len;
> -}
> -
> -static inline struct mic_vqconfig *
> -mic_vq_config(const struct mic_device_desc *desc)
> -{
> -	return (struct mic_vqconfig *)(desc + 1);
> -}
> -
> -static inline __u8 *mic_vq_features(const struct mic_device_desc *desc)
> -{
> -	return (__u8 *)(mic_vq_config(desc) + desc->num_vq);
> -}
> -
> -static inline __u8 *mic_vq_configspace(const struct mic_device_desc *des=
c)
> -{
> -	return mic_vq_features(desc) + desc->feature_len * 2;
> -}
> -static inline unsigned mic_total_desc_size(struct mic_device_desc *desc)
> -{
> -	return mic_aligned_desc_size(desc) + sizeof(struct mic_device_ctrl);
> -}
> -#endif
> -
> -/* Device page size */
> -#define MIC_DP_SIZE 4096
> -
> -#define MIC_MAGIC 0xc0ffee00
> -
> -/**
> - * enum mic_states - MIC states.
> - */
> -enum mic_states {
> -	MIC_READY =3D 0,
> -	MIC_BOOTING,
> -	MIC_ONLINE,
> -	MIC_SHUTTING_DOWN,
> -	MIC_RESETTING,
> -	MIC_RESET_FAILED,
> -	MIC_LAST
> -};
> -
> -/**
> - * enum mic_status - MIC status reported by card after
> - * a host or card initiated shutdown or a card crash.
> - */
> -enum mic_status {
> -	MIC_NOP =3D 0,
> -	MIC_CRASHED,
> -	MIC_HALTED,
> -	MIC_POWER_OFF,
> -	MIC_RESTART,
> -	MIC_STATUS_LAST
> -};
> -
> -#endif
> diff --git a/include/uapi/linux/mic_ioctl.h b/include/uapi/linux/mic_ioct=
l.h
> deleted file mode 100644
> index 687b9cd9d3e2..000000000000
> --- a/include/uapi/linux/mic_ioctl.h
> +++ /dev/null
> @@ -1,77 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, version 2, as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * General Public License for more details.
> - *
> - * The full GNU General Public License is included in this distribution =
in
> - * the file called "COPYING".
> - *
> - * Intel MIC Host driver.
> - *
> - */
> -#ifndef _MIC_IOCTL_H_
> -#define _MIC_IOCTL_H_
> -
> -#include <linux/types.h>
> -
> -/*
> - * mic_copy - MIC virtio descriptor copy.
> - *
> - * @iov: An array of IOVEC structures containing user space buffers.
> - * @iovcnt: Number of IOVEC structures in iov.
> - * @vr_idx: The vring index.
> - * @update_used: A non zero value results in used index being updated.
> - * @out_len: The aggregate of the total length written to or read from
> - *	the virtio device.
> - */
> -struct mic_copy_desc {
> -#ifdef __KERNEL__
> -	struct iovec __user *iov;
> -#else
> -	struct iovec *iov;
> -#endif
> -	__u32 iovcnt;
> -	__u8 vr_idx;
> -	__u8 update_used;
> -	__u32 out_len;
> -};
> -
> -/*
> - * Add a new virtio device
> - * The (struct mic_device_desc *) pointer points to a device page entry
> - *	for the virtio device consisting of:
> - *	- struct mic_device_desc
> - *	- struct mic_vqconfig (num_vq of these)
> - *	- host and guest features
> - *	- virtio device config space
> - * The total size referenced by the pointer should equal the size return=
ed
> - * by desc_size() in mic_common.h
> - */
> -#define MIC_VIRTIO_ADD_DEVICE _IOWR('s', 1, struct mic_device_desc *)
> -
> -/*
> - * Copy the number of entries in the iovec and update the used index
> - * if requested by the user.
> - */
> -#define MIC_VIRTIO_COPY_DESC	_IOWR('s', 2, struct mic_copy_desc *)
> -
> -/*
> - * Notify virtio device of a config change
> - * The (__u8 *) pointer points to config space values for the device
> - * as they should be written into the device page. The total size
> - * referenced by the pointer should equal the config_len field of struct
> - * mic_device_desc.
> - */
> -#define MIC_VIRTIO_CONFIG_CHANGE _IOWR('s', 5, __u8 *)
> -
> -#endif
> diff --git a/samples/mic/mpssd/.gitignore b/samples/mic/mpssd/.gitignore
> deleted file mode 100644
> index aa03f1eb37a0..000000000000
> --- a/samples/mic/mpssd/.gitignore
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -mpssd
> diff --git a/samples/mic/mpssd/Makefile b/samples/mic/mpssd/Makefile
> deleted file mode 100644
> index a7a6e0c70424..000000000000
> --- a/samples/mic/mpssd/Makefile
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -ifndef CROSS_COMPILE
> -uname_M :=3D $(shell uname -m 2>/dev/null || echo not)
> -ARCH ?=3D $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> -
> -ifeq ($(ARCH),x86)
> -
> -PROGS :=3D mpssd
> -CC =3D $(CROSS_COMPILE)gcc
> -CFLAGS :=3D -I../../../usr/include -I../../../tools/include
> -
> -ifdef DEBUG
> -CFLAGS +=3D -DDEBUG=3D$(DEBUG)
> -endif
> -
> -all: $(PROGS)
> -mpssd: mpssd.c sysfs.c
> -	$(CC) $(CFLAGS) mpssd.c sysfs.c -o mpssd -lpthread
> -
> -install:
> -	install mpssd /usr/sbin/mpssd
> -	install micctrl /usr/sbin/micctrl
> -
> -clean:
> -	rm -fr $(PROGS)
> -
> -endif
> -endif
> diff --git a/samples/mic/mpssd/micctrl b/samples/mic/mpssd/micctrl
> deleted file mode 100755
> index 030a60b04046..000000000000
> --- a/samples/mic/mpssd/micctrl
> +++ /dev/null
> @@ -1,162 +0,0 @@
> -#!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0-only
> -# Intel MIC Platform Software Stack (MPSS)
> -#
> -# Copyright(c) 2013 Intel Corporation.
> -#
> -# Intel MIC User Space Tools.
> -#
> -# micctrl - Controls MIC boot/start/stop.
> -#
> -# chkconfig: 2345 95 05
> -# description: start MPSS stack processing.
> -#
> -### BEGIN INIT INFO
> -# Provides: micctrl
> -### END INIT INFO
> -
> -# Source function library.
> -. /etc/init.d/functions
> -
> -sysfs=3D"/sys/class/mic"
> -
> -_status()
> -{
> -	f=3D$sysfs/$1
> -	echo -e $1 state: "`cat $f/state`" shutdown_status: "`cat
> $f/shutdown_status`"
> -}
> -
> -status()
> -{
> -	if [ "`echo $1 | head -c3`" =3D=3D "mic" ]; then
> -		_status $1
> -		return $?
> -	fi
> -	for f in $sysfs/*
> -	do
> -		_status `basename $f`
> -		RETVAL=3D$?
> -		[ $RETVAL -ne 0 ] && return $RETVAL
> -	done
> -	return 0
> -}
> -
> -_reset()
> -{
> -	f=3D$sysfs/$1
> -	echo reset > $f/state
> -}
> -
> -reset()
> -{
> -	if [ "`echo $1 | head -c3`" =3D=3D "mic" ]; then
> -		_reset $1
> -		return $?
> -	fi
> -	for f in $sysfs/*
> -	do
> -		_reset `basename $f`
> -		RETVAL=3D$?
> -		[ $RETVAL -ne 0 ] && return $RETVAL
> -	done
> -	return 0
> -}
> -
> -_boot()
> -{
> -	f=3D$sysfs/$1
> -	echo "linux" > $f/bootmode
> -	echo "mic/uos.img" > $f/firmware
> -	echo "mic/$1.image" > $f/ramdisk
> -	echo "boot" > $f/state
> -}
> -
> -boot()
> -{
> -	if [ "`echo $1 | head -c3`" =3D=3D "mic" ]; then
> -		_boot $1
> -		return $?
> -	fi
> -	for f in $sysfs/*
> -	do
> -		_boot `basename $f`
> -		RETVAL=3D$?
> -		[ $RETVAL -ne 0 ] && return $RETVAL
> -	done
> -	return 0
> -}
> -
> -_shutdown()
> -{
> -	f=3D$sysfs/$1
> -	echo shutdown > $f/state
> -}
> -
> -shutdown()
> -{
> -	if [ "`echo $1 | head -c3`" =3D=3D "mic" ]; then
> -		_shutdown $1
> -		return $?
> -	fi
> -	for f in $sysfs/*
> -	do
> -		_shutdown `basename $f`
> -		RETVAL=3D$?
> -		[ $RETVAL -ne 0 ] && return $RETVAL
> -	done
> -	return 0
> -}
> -
> -_wait()
> -{
> -	f=3D$sysfs/$1
> -	while [ "`cat $f/state`" !=3D "offline" -a "`cat $f/state`" !=3D "onlin=
e" ]
> -	do
> -		sleep 1
> -		echo -e "Waiting for $1 to go offline"
> -	done
> -}
> -
> -wait()
> -{
> -	if [ "`echo $1 | head -c3`" =3D=3D "mic" ]; then
> -		_wait $1
> -		return $?
> -	fi
> -	# Wait for the cards to go offline
> -	for f in $sysfs/*
> -	do
> -		_wait `basename $f`
> -		RETVAL=3D$?
> -		[ $RETVAL -ne 0 ] && return $RETVAL
> -	done
> -	return 0
> -}
> -
> -if [ ! -d "$sysfs" ]; then
> -	echo -e $"Module unloaded "
> -	exit 3
> -fi
> -
> -case $1 in
> -	-s)
> -		status $2
> -		;;
> -	-r)
> -		reset $2
> -		;;
> -	-b)
> -		boot $2
> -		;;
> -	-S)
> -		shutdown $2
> -		;;
> -	-w)
> -		wait $2
> -		;;
> -	*)
> -		echo $"Usage: $0 {-s (status) |-r (reset) |-b (boot) |-S
> (shutdown) |-w (wait)}"
> -		exit 2
> -esac
> -
> -exit $?
> diff --git a/samples/mic/mpssd/mpss b/samples/mic/mpssd/mpss
> deleted file mode 100755
> index 248ac7313c71..000000000000
> --- a/samples/mic/mpssd/mpss
> +++ /dev/null
> @@ -1,189 +0,0 @@
> -#!/bin/bash
> -# SPDX-License-Identifier: GPL-2.0-only
> -# Intel MIC Platform Software Stack (MPSS)
> -#
> -# Copyright(c) 2013 Intel Corporation.
> -#
> -# Intel MIC User Space Tools.
> -#
> -# mpss	Start mpssd.
> -#
> -# chkconfig: 2345 95 05
> -# description: start MPSS stack processing.
> -#
> -### BEGIN INIT INFO
> -# Provides: mpss
> -# Required-Start:
> -# Required-Stop:
> -# Short-Description: MPSS stack control
> -# Description: MPSS stack control
> -### END INIT INFO
> -
> -# Source function library.
> -. /etc/init.d/functions
> -
> -exec=3D/usr/sbin/mpssd
> -sysfs=3D"/sys/class/mic"
> -mic_modules=3D"mic_host mic_x100_dma scif vop"
> -
> -start()
> -{
> -	[ -x $exec ] || exit 5
> -
> -	if [ "`ps -e | awk '{print $4}' | grep mpssd | head -1`" =3D "mpssd" ];
> then
> -		echo -e $"MPSSD already running! "
> -		success
> -		echo
> -		return 0
> -	fi
> -
> -	echo -e $"Starting MPSS Stack"
> -	echo -e $"Loading MIC drivers:" $mic_modules
> -
> -	modprobe -a $mic_modules
> -	RETVAL=3D$?
> -	if [ $RETVAL -ne 0 ]; then
> -		failure
> -		echo
> -		return $RETVAL
> -	fi
> -
> -	# Start the daemon
> -	echo -n $"Starting MPSSD "
> -	$exec
> -	RETVAL=3D$?
> -	if [ $RETVAL -ne 0 ]; then
> -		failure
> -		echo
> -		return $RETVAL
> -	fi
> -	success
> -	echo
> -
> -	sleep 5
> -
> -	# Boot the cards
> -	micctrl -b
> -
> -	# Wait till ping works
> -	for f in $sysfs/*
> -	do
> -		count=3D100
> -		ipaddr=3D`cat $f/cmdline`
> -		ipaddr=3D${ipaddr#*address,}
> -		ipaddr=3D`echo $ipaddr | cut -d, -f1 | cut -d\; -f1`
> -		while [ $count -ge 0 ]
> -		do
> -			echo -e "Pinging "`basename $f`" "
> -			ping -c 1 $ipaddr &> /dev/null
> -			RETVAL=3D$?
> -			if [ $RETVAL -eq 0 ]; then
> -				success
> -				break
> -			fi
> -			sleep 1
> -			count=3D`expr $count - 1`
> -		done
> -		[ $RETVAL -ne 0 ] && failure || success
> -		echo
> -	done
> -	return $RETVAL
> -}
> -
> -stop()
> -{
> -	echo -e $"Shutting down MPSS Stack: "
> -
> -	# Bail out if module is unloaded
> -	if [ ! -d "$sysfs" ]; then
> -		echo -n $"Module unloaded "
> -		success
> -		echo
> -		return 0
> -	fi
> -
> -	# Shut down the cards.
> -	micctrl -S
> -
> -	# Wait for the cards to go offline
> -	for f in $sysfs/*
> -	do
> -		while [ "`cat $f/state`" !=3D "ready" ]
> -		do
> -			sleep 1
> -			echo -e "Waiting for "`basename $f`" to become
> ready"
> -		done
> -	done
> -
> -	# Display the status of the cards
> -	micctrl -s
> -
> -	# Kill MPSSD now
> -	echo -n $"Killing MPSSD"
> -	killall -9 mpssd 2>/dev/null
> -	RETVAL=3D$?
> -	[ $RETVAL -ne 0 ] && failure || success
> -	echo
> -	return $RETVAL
> -}
> -
> -restart()
> -{
> -	stop
> -	sleep 5
> -	start
> -}
> -
> -status()
> -{
> -	micctrl -s
> -	if [ "`ps -e | awk '{print $4}' | grep mpssd | head -n 1`" =3D "mpssd" =
];
> then
> -		echo "mpssd is running"
> -	else
> -		echo "mpssd is stopped"
> -	fi
> -	return 0
> -}
> -
> -unload()
> -{
> -	if [ ! -d "$sysfs" ]; then
> -		echo -n $"No MIC_HOST Module: "
> -		success
> -		echo
> -		return
> -	fi
> -
> -	stop
> -
> -	sleep 5
> -	echo -n $"Removing MIC drivers:" $mic_modules
> -	modprobe -r $mic_modules
> -	RETVAL=3D$?
> -	[ $RETVAL -ne 0 ] && failure || success
> -	echo
> -	return $RETVAL
> -}
> -
> -case $1 in
> -	start)
> -		start
> -		;;
> -	stop)
> -		stop
> -		;;
> -	restart)
> -		restart
> -		;;
> -	status)
> -		status
> -		;;
> -	unload)
> -		unload
> -		;;
> -	*)
> -		echo $"Usage: $0 {start|stop|restart|status|unload}"
> -		exit 2
> -esac
> -
> -exit $?
> diff --git a/samples/mic/mpssd/mpssd.c b/samples/mic/mpssd/mpssd.c
> deleted file mode 100644
> index c03a05d498f0..000000000000
> --- a/samples/mic/mpssd/mpssd.c
> +++ /dev/null
> @@ -1,1815 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC User Space Tools.
> - */
> -
> -#define _GNU_SOURCE
> -
> -#include <stdlib.h>
> -#include <fcntl.h>
> -#include <getopt.h>
> -#include <assert.h>
> -#include <unistd.h>
> -#include <stdbool.h>
> -#include <signal.h>
> -#include <poll.h>
> -#include <features.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/mman.h>
> -#include <sys/socket.h>
> -#include <linux/virtio_ring.h>
> -#include <linux/virtio_net.h>
> -#include <linux/virtio_console.h>
> -#include <linux/virtio_blk.h>
> -#include <linux/version.h>
> -#include "mpssd.h"
> -#include <linux/mic_ioctl.h>
> -#include <linux/mic_common.h>
> -#include <tools/endian.h>
> -
> -static void *init_mic(void *arg);
> -
> -static FILE *logfp;
> -static struct mic_info mic_list;
> -
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -
> -#define min_t(type, x, y) ({				\
> -		type __min1 =3D (x);                      \
> -		type __min2 =3D (y);                      \
> -		__min1 < __min2 ? __min1 : __min2; })
> -
> -/* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_DOWN(addr, size)  ((addr)&(~((size)-1)))
> -#define _ALIGN_UP(addr, size)    _ALIGN_DOWN(addr + size - 1, size)
> -
> -/* align addr on a size boundary - adjust address up if needed */
> -#define _ALIGN(addr, size)     _ALIGN_UP(addr, size)
> -
> -/* to align the pointer to the (next) page boundary */
> -#define PAGE_ALIGN(addr)        _ALIGN(addr, PAGE_SIZE)
> -
> -#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> -
> -#define GSO_ENABLED		1
> -#define MAX_GSO_SIZE		(64 * 1024)
> -#define ETH_H_LEN		14
> -#define MAX_NET_PKT_SIZE	(_ALIGN_UP(MAX_GSO_SIZE + ETH_H_LEN,
> 64))
> -#define MIC_DEVICE_PAGE_END	0x1000
> -
> -#ifndef VIRTIO_NET_HDR_F_DATA_VALID
> -#define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
> -#endif
> -
> -static struct {
> -	struct mic_device_desc dd;
> -	struct mic_vqconfig vqconfig[2];
> -	__u32 host_features, guest_acknowledgements;
> -	struct virtio_console_config cons_config;
> -} virtcons_dev_page =3D {
> -	.dd =3D {
> -		.type =3D VIRTIO_ID_CONSOLE,
> -		.num_vq =3D ARRAY_SIZE(virtcons_dev_page.vqconfig),
> -		.feature_len =3D sizeof(virtcons_dev_page.host_features),
> -		.config_len =3D sizeof(virtcons_dev_page.cons_config),
> -	},
> -	.vqconfig[0] =3D {
> -		.num =3D htole16(MIC_VRING_ENTRIES),
> -	},
> -	.vqconfig[1] =3D {
> -		.num =3D htole16(MIC_VRING_ENTRIES),
> -	},
> -};
> -
> -static struct {
> -	struct mic_device_desc dd;
> -	struct mic_vqconfig vqconfig[2];
> -	__u32 host_features, guest_acknowledgements;
> -	struct virtio_net_config net_config;
> -} virtnet_dev_page =3D {
> -	.dd =3D {
> -		.type =3D VIRTIO_ID_NET,
> -		.num_vq =3D ARRAY_SIZE(virtnet_dev_page.vqconfig),
> -		.feature_len =3D sizeof(virtnet_dev_page.host_features),
> -		.config_len =3D sizeof(virtnet_dev_page.net_config),
> -	},
> -	.vqconfig[0] =3D {
> -		.num =3D htole16(MIC_VRING_ENTRIES),
> -	},
> -	.vqconfig[1] =3D {
> -		.num =3D htole16(MIC_VRING_ENTRIES),
> -	},
> -#if GSO_ENABLED
> -	.host_features =3D htole32(
> -		1 << VIRTIO_NET_F_CSUM |
> -		1 << VIRTIO_NET_F_GSO |
> -		1 << VIRTIO_NET_F_GUEST_TSO4 |
> -		1 << VIRTIO_NET_F_GUEST_TSO6 |
> -		1 << VIRTIO_NET_F_GUEST_ECN),
> -#else
> -		.host_features =3D 0,
> -#endif
> -};
> -
> -static const char *mic_config_dir =3D "/etc/mpss";
> -static const char *virtblk_backend =3D "VIRTBLK_BACKEND";
> -static struct {
> -	struct mic_device_desc dd;
> -	struct mic_vqconfig vqconfig[1];
> -	__u32 host_features, guest_acknowledgements;
> -	struct virtio_blk_config blk_config;
> -} virtblk_dev_page =3D {
> -	.dd =3D {
> -		.type =3D VIRTIO_ID_BLOCK,
> -		.num_vq =3D ARRAY_SIZE(virtblk_dev_page.vqconfig),
> -		.feature_len =3D sizeof(virtblk_dev_page.host_features),
> -		.config_len =3D sizeof(virtblk_dev_page.blk_config),
> -	},
> -	.vqconfig[0] =3D {
> -		.num =3D htole16(MIC_VRING_ENTRIES),
> -	},
> -	.host_features =3D
> -		htole32(1<<VIRTIO_BLK_F_SEG_MAX),
> -	.blk_config =3D {
> -		.seg_max =3D htole32(MIC_VRING_ENTRIES - 2),
> -		.capacity =3D htole64(0),
> -	 }
> -};
> -
> -static char *myname;
> -
> -static int
> -tap_configure(struct mic_info *mic, char *dev)
> -{
> -	pid_t pid;
> -	char *ifargv[7];
> -	char ipaddr[IFNAMSIZ];
> -	int ret =3D 0;
> -
> -	pid =3D fork();
> -	if (pid =3D=3D 0) {
> -		ifargv[0] =3D "ip";
> -		ifargv[1] =3D "link";
> -		ifargv[2] =3D "set";
> -		ifargv[3] =3D dev;
> -		ifargv[4] =3D "up";
> -		ifargv[5] =3D NULL;
> -		mpsslog("Configuring %s\n", dev);
> -		ret =3D execvp("ip", ifargv);
> -		if (ret < 0) {
> -			mpsslog("%s execvp failed errno %s\n",
> -				mic->name, strerror(errno));
> -			return ret;
> -		}
> -	}
> -	if (pid < 0) {
> -		mpsslog("%s fork failed errno %s\n",
> -			mic->name, strerror(errno));
> -		return ret;
> -	}
> -
> -	ret =3D waitpid(pid, NULL, 0);
> -	if (ret < 0) {
> -		mpsslog("%s waitpid failed errno %s\n",
> -			mic->name, strerror(errno));
> -		return ret;
> -	}
> -
> -	snprintf(ipaddr, IFNAMSIZ, "172.31.%d.254/24", mic->id + 1);
> -
> -	pid =3D fork();
> -	if (pid =3D=3D 0) {
> -		ifargv[0] =3D "ip";
> -		ifargv[1] =3D "addr";
> -		ifargv[2] =3D "add";
> -		ifargv[3] =3D ipaddr;
> -		ifargv[4] =3D "dev";
> -		ifargv[5] =3D dev;
> -		ifargv[6] =3D NULL;
> -		mpsslog("Configuring %s ipaddr %s\n", dev, ipaddr);
> -		ret =3D execvp("ip", ifargv);
> -		if (ret < 0) {
> -			mpsslog("%s execvp failed errno %s\n",
> -				mic->name, strerror(errno));
> -			return ret;
> -		}
> -	}
> -	if (pid < 0) {
> -		mpsslog("%s fork failed errno %s\n",
> -			mic->name, strerror(errno));
> -		return ret;
> -	}
> -
> -	ret =3D waitpid(pid, NULL, 0);
> -	if (ret < 0) {
> -		mpsslog("%s waitpid failed errno %s\n",
> -			mic->name, strerror(errno));
> -		return ret;
> -	}
> -	mpsslog("MIC name %s %s %d DONE!\n",
> -		mic->name, __func__, __LINE__);
> -	return 0;
> -}
> -
> -static int tun_alloc(struct mic_info *mic, char *dev)
> -{
> -	struct ifreq ifr;
> -	int fd, err;
> -#if GSO_ENABLED
> -	unsigned offload;
> -#endif
> -	fd =3D open("/dev/net/tun", O_RDWR);
> -	if (fd < 0) {
> -		mpsslog("Could not open /dev/net/tun %s\n",
> strerror(errno));
> -		goto done;
> -	}
> -
> -	memset(&ifr, 0, sizeof(ifr));
> -
> -	ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
> -	if (*dev)
> -		strncpy(ifr.ifr_name, dev, IFNAMSIZ);
> -
> -	err =3D ioctl(fd, TUNSETIFF, (void *)&ifr);
> -	if (err < 0) {
> -		mpsslog("%s %s %d TUNSETIFF failed %s\n",
> -			mic->name, __func__, __LINE__, strerror(errno));
> -		close(fd);
> -		return err;
> -	}
> -#if GSO_ENABLED
> -	offload =3D TUN_F_CSUM | TUN_F_TSO4 | TUN_F_TSO6 |
> TUN_F_TSO_ECN;
> -
> -	err =3D ioctl(fd, TUNSETOFFLOAD, offload);
> -	if (err < 0) {
> -		mpsslog("%s %s %d TUNSETOFFLOAD failed %s\n",
> -			mic->name, __func__, __LINE__, strerror(errno));
> -		close(fd);
> -		return err;
> -	}
> -#endif
> -	strcpy(dev, ifr.ifr_name);
> -	mpsslog("Created TAP %s\n", dev);
> -done:
> -	return fd;
> -}
> -
> -#define NET_FD_VIRTIO_NET 0
> -#define NET_FD_TUN 1
> -#define MAX_NET_FD 2
> -
> -static void set_dp(struct mic_info *mic, int type, void *dp)
> -{
> -	switch (type) {
> -	case VIRTIO_ID_CONSOLE:
> -		mic->mic_console.console_dp =3D dp;
> -		return;
> -	case VIRTIO_ID_NET:
> -		mic->mic_net.net_dp =3D dp;
> -		return;
> -	case VIRTIO_ID_BLOCK:
> -		mic->mic_virtblk.block_dp =3D dp;
> -		return;
> -	}
> -	mpsslog("%s %s %d not found\n", mic->name, __func__, type);
> -	assert(0);
> -}
> -
> -static void *get_dp(struct mic_info *mic, int type)
> -{
> -	switch (type) {
> -	case VIRTIO_ID_CONSOLE:
> -		return mic->mic_console.console_dp;
> -	case VIRTIO_ID_NET:
> -		return mic->mic_net.net_dp;
> -	case VIRTIO_ID_BLOCK:
> -		return mic->mic_virtblk.block_dp;
> -	}
> -	mpsslog("%s %s %d not found\n", mic->name, __func__, type);
> -	assert(0);
> -	return NULL;
> -}
> -
> -static struct mic_device_desc *get_device_desc(struct mic_info *mic, int
> type)
> -{
> -	struct mic_device_desc *d;
> -	int i;
> -	void *dp =3D get_dp(mic, type);
> -
> -	for (i =3D sizeof(struct mic_bootparam); i < PAGE_SIZE;
> -		i +=3D mic_total_desc_size(d)) {
> -		d =3D dp + i;
> -
> -		/* End of list */
> -		if (d->type =3D=3D 0)
> -			break;
> -
> -		if (d->type =3D=3D -1)
> -			continue;
> -
> -		mpsslog("%s %s d-> type %d d %p\n",
> -			mic->name, __func__, d->type, d);
> -
> -		if (d->type =3D=3D (__u8)type)
> -			return d;
> -	}
> -	mpsslog("%s %s %d not found\n", mic->name, __func__, type);
> -	return NULL;
> -}
> -
> -/* See comments in vhost.c for explanation of next_desc() */
> -static unsigned next_desc(struct vring_desc *desc)
> -{
> -	unsigned int next;
> -
> -	if (!(le16toh(desc->flags) & VRING_DESC_F_NEXT))
> -		return -1U;
> -	next =3D le16toh(desc->next);
> -	return next;
> -}
> -
> -/* Sum up all the IOVEC length */
> -static ssize_t
> -sum_iovec_len(struct mic_copy_desc *copy)
> -{
> -	ssize_t sum =3D 0;
> -	unsigned int i;
> -
> -	for (i =3D 0; i < copy->iovcnt; i++)
> -		sum +=3D copy->iov[i].iov_len;
> -	return sum;
> -}
> -
> -static inline void verify_out_len(struct mic_info *mic,
> -	struct mic_copy_desc *copy)
> -{
> -	if (copy->out_len !=3D sum_iovec_len(copy)) {
> -		mpsslog("%s %s %d BUG copy->out_len 0x%x len 0x%zx\n",
> -			mic->name, __func__, __LINE__,
> -			copy->out_len, sum_iovec_len(copy));
> -		assert(copy->out_len =3D=3D sum_iovec_len(copy));
> -	}
> -}
> -
> -/* Display an iovec */
> -static void
> -disp_iovec(struct mic_info *mic, struct mic_copy_desc *copy,
> -	   const char *s, int line)
> -{
> -	unsigned int i;
> -
> -	for (i =3D 0; i < copy->iovcnt; i++)
> -		mpsslog("%s %s %d copy->iov[%d] addr %p len 0x%zx\n",
> -			mic->name, s, line, i,
> -			copy->iov[i].iov_base, copy->iov[i].iov_len);
> -}
> -
> -static inline __u16 read_avail_idx(struct mic_vring *vr)
> -{
> -	return READ_ONCE(vr->info->avail_idx);
> -}
> -
> -static inline void txrx_prepare(int type, bool tx, struct mic_vring *vr,
> -				struct mic_copy_desc *copy, ssize_t len)
> -{
> -	copy->vr_idx =3D tx ? 0 : 1;
> -	copy->update_used =3D true;
> -	if (type =3D=3D VIRTIO_ID_NET)
> -		copy->iov[1].iov_len =3D len - sizeof(struct virtio_net_hdr);
> -	else
> -		copy->iov[0].iov_len =3D len;
> -}
> -
> -/* Central API which triggers the copies */
> -static int
> -mic_virtio_copy(struct mic_info *mic, int fd,
> -		struct mic_vring *vr, struct mic_copy_desc *copy)
> -{
> -	int ret;
> -
> -	ret =3D ioctl(fd, MIC_VIRTIO_COPY_DESC, copy);
> -	if (ret) {
> -		mpsslog("%s %s %d errno %s ret %d\n",
> -			mic->name, __func__, __LINE__,
> -			strerror(errno), ret);
> -	}
> -	return ret;
> -}
> -
> -static inline unsigned _vring_size(unsigned int num, unsigned long align=
)
> -{
> -	return _ALIGN_UP(((sizeof(struct vring_desc) * num + sizeof(__u16) *
> (3 + num)
> -				+ align - 1) & ~(align - 1))
> -		+ sizeof(__u16) * 3 + sizeof(struct vring_used_elem) * num,
> 4);
> -}
> -
> -/*
> - * This initialization routine requires at least one
> - * vring i.e. vr0. vr1 is optional.
> - */
> -static void *
> -init_vr(struct mic_info *mic, int fd, int type,
> -	struct mic_vring *vr0, struct mic_vring *vr1, int num_vq)
> -{
> -	int vr_size;
> -	char *va;
> -
> -	vr_size =3D PAGE_ALIGN(_vring_size(MIC_VRING_ENTRIES,
> -					 MIC_VIRTIO_RING_ALIGN) +
> -			     sizeof(struct _mic_vring_info));
> -	va =3D mmap(NULL, MIC_DEVICE_PAGE_END + vr_size * num_vq,
> -		PROT_READ, MAP_SHARED, fd, 0);
> -	if (MAP_FAILED =3D=3D va) {
> -		mpsslog("%s %s %d mmap failed errno %s\n",
> -			mic->name, __func__, __LINE__,
> -			strerror(errno));
> -		goto done;
> -	}
> -	set_dp(mic, type, va);
> -	vr0->va =3D (struct mic_vring *)&va[MIC_DEVICE_PAGE_END];
> -	vr0->info =3D vr0->va +
> -		_vring_size(MIC_VRING_ENTRIES, MIC_VIRTIO_RING_ALIGN);
> -	vring_init(&vr0->vr,
> -		   MIC_VRING_ENTRIES, vr0->va, MIC_VIRTIO_RING_ALIGN);
> -	mpsslog("%s %s vr0 %p vr0->info %p vr_size 0x%x vring 0x%x ",
> -		__func__, mic->name, vr0->va, vr0->info, vr_size,
> -		_vring_size(MIC_VRING_ENTRIES, MIC_VIRTIO_RING_ALIGN));
> -	mpsslog("magic 0x%x expected 0x%x\n",
> -		le32toh(vr0->info->magic), MIC_MAGIC + type);
> -	assert(le32toh(vr0->info->magic) =3D=3D MIC_MAGIC + type);
> -	if (vr1) {
> -		vr1->va =3D (struct mic_vring *)
> -			&va[MIC_DEVICE_PAGE_END + vr_size];
> -		vr1->info =3D vr1->va + _vring_size(MIC_VRING_ENTRIES,
> -			MIC_VIRTIO_RING_ALIGN);
> -		vring_init(&vr1->vr,
> -			   MIC_VRING_ENTRIES, vr1->va,
> MIC_VIRTIO_RING_ALIGN);
> -		mpsslog("%s %s vr1 %p vr1->info %p vr_size 0x%x vring 0x%x
> ",
> -			__func__, mic->name, vr1->va, vr1->info, vr_size,
> -			_vring_size(MIC_VRING_ENTRIES,
> MIC_VIRTIO_RING_ALIGN));
> -		mpsslog("magic 0x%x expected 0x%x\n",
> -			le32toh(vr1->info->magic), MIC_MAGIC + type + 1);
> -		assert(le32toh(vr1->info->magic) =3D=3D MIC_MAGIC + type + 1);
> -	}
> -done:
> -	return va;
> -}
> -
> -static int
> -wait_for_card_driver(struct mic_info *mic, int fd, int type)
> -{
> -	struct pollfd pollfd;
> -	int err;
> -	struct mic_device_desc *desc =3D get_device_desc(mic, type);
> -	__u8 prev_status;
> -
> -	if (!desc)
> -		return -ENODEV;
> -	prev_status =3D desc->status;
> -	pollfd.fd =3D fd;
> -	mpsslog("%s %s Waiting .... desc-> type %d status 0x%x\n",
> -		mic->name, __func__, type, desc->status);
> -
> -	while (1) {
> -		pollfd.events =3D POLLIN;
> -		pollfd.revents =3D 0;
> -		err =3D poll(&pollfd, 1, -1);
> -		if (err < 0) {
> -			mpsslog("%s %s poll failed %s\n",
> -				mic->name, __func__, strerror(errno));
> -			continue;
> -		}
> -
> -		if (pollfd.revents) {
> -			if (desc->status !=3D prev_status) {
> -				mpsslog("%s %s Waiting... desc-> type %d "
> -					"status 0x%x\n",
> -					mic->name, __func__, type,
> -					desc->status);
> -				prev_status =3D desc->status;
> -			}
> -			if (desc->status & VIRTIO_CONFIG_S_DRIVER_OK) {
> -				mpsslog("%s %s poll.revents %d\n",
> -					mic->name, __func__, pollfd.revents);
> -				mpsslog("%s %s desc-> type %d status
> 0x%x\n",
> -					mic->name, __func__, type,
> -					desc->status);
> -				break;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
> -/* Spin till we have some descriptors */
> -static void
> -spin_for_descriptors(struct mic_info *mic, struct mic_vring *vr)
> -{
> -	__u16 avail_idx =3D read_avail_idx(vr);
> -
> -	while (avail_idx =3D=3D le16toh(READ_ONCE(vr->vr.avail->idx))) {
> -#ifdef DEBUG
> -		mpsslog("%s %s waiting for desc avail %d info_avail %d\n",
> -			mic->name, __func__,
> -			le16toh(vr->vr.avail->idx), vr->info->avail_idx);
> -#endif
> -		sched_yield();
> -	}
> -}
> -
> -static void *
> -virtio_net(void *arg)
> -{
> -	static __u8 vnet_hdr[2][sizeof(struct virtio_net_hdr)];
> -	static __u8 vnet_buf[2][MAX_NET_PKT_SIZE] __attribute__
> ((aligned(64)));
> -	struct iovec vnet_iov[2][2] =3D {
> -		{ { .iov_base =3D vnet_hdr[0], .iov_len =3D sizeof(vnet_hdr[0]) },
> -		  { .iov_base =3D vnet_buf[0], .iov_len =3D sizeof(vnet_buf[0]) } },
> -		{ { .iov_base =3D vnet_hdr[1], .iov_len =3D sizeof(vnet_hdr[1]) },
> -		  { .iov_base =3D vnet_buf[1], .iov_len =3D sizeof(vnet_buf[1]) } },
> -	};
> -	struct iovec *iov0 =3D vnet_iov[0], *iov1 =3D vnet_iov[1];
> -	struct mic_info *mic =3D (struct mic_info *)arg;
> -	char if_name[IFNAMSIZ];
> -	struct pollfd net_poll[MAX_NET_FD];
> -	struct mic_vring tx_vr, rx_vr;
> -	struct mic_copy_desc copy;
> -	struct mic_device_desc *desc;
> -	int err;
> -
> -	snprintf(if_name, IFNAMSIZ, "mic%d", mic->id);
> -	mic->mic_net.tap_fd =3D tun_alloc(mic, if_name);
> -	if (mic->mic_net.tap_fd < 0)
> -		goto done;
> -
> -	if (tap_configure(mic, if_name))
> -		goto done;
> -	mpsslog("MIC name %s id %d\n", mic->name, mic->id);
> -
> -	net_poll[NET_FD_VIRTIO_NET].fd =3D mic->mic_net.virtio_net_fd;
> -	net_poll[NET_FD_VIRTIO_NET].events =3D POLLIN;
> -	net_poll[NET_FD_TUN].fd =3D mic->mic_net.tap_fd;
> -	net_poll[NET_FD_TUN].events =3D POLLIN;
> -
> -	if (MAP_FAILED =3D=3D init_vr(mic, mic->mic_net.virtio_net_fd,
> -				  VIRTIO_ID_NET, &tx_vr, &rx_vr,
> -		virtnet_dev_page.dd.num_vq)) {
> -		mpsslog("%s init_vr failed %s\n",
> -			mic->name, strerror(errno));
> -		goto done;
> -	}
> -
> -	copy.iovcnt =3D 2;
> -	desc =3D get_device_desc(mic, VIRTIO_ID_NET);
> -
> -	while (1) {
> -		ssize_t len;
> -
> -		net_poll[NET_FD_VIRTIO_NET].revents =3D 0;
> -		net_poll[NET_FD_TUN].revents =3D 0;
> -
> -		/* Start polling for data from tap and virtio net */
> -		err =3D poll(net_poll, 2, -1);
> -		if (err < 0) {
> -			mpsslog("%s poll failed %s\n",
> -				__func__, strerror(errno));
> -			continue;
> -		}
> -		if (!(desc->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> -			err =3D wait_for_card_driver(mic,
> -						   mic->mic_net.virtio_net_fd,
> -						   VIRTIO_ID_NET);
> -			if (err) {
> -				mpsslog("%s %s %d Exiting...\n",
> -					mic->name, __func__, __LINE__);
> -				break;
> -			}
> -		}
> -		/*
> -		 * Check if there is data to be read from TUN and write to
> -		 * virtio net fd if there is.
> -		 */
> -		if (net_poll[NET_FD_TUN].revents & POLLIN) {
> -			copy.iov =3D iov0;
> -			len =3D readv(net_poll[NET_FD_TUN].fd,
> -				copy.iov, copy.iovcnt);
> -			if (len > 0) {
> -				struct virtio_net_hdr *hdr
> -					=3D (struct virtio_net_hdr *)vnet_hdr[0];
> -
> -				/* Disable checksums on the card since we
> are on
> -				   a reliable PCIe link */
> -				hdr->flags |=3D
> VIRTIO_NET_HDR_F_DATA_VALID;
> -#ifdef DEBUG
> -				mpsslog("%s %s %d hdr->flags 0x%x ", mic-
> >name,
> -					__func__, __LINE__, hdr->flags);
> -				mpsslog("copy.out_len %d hdr->gso_type
> 0x%x\n",
> -					copy.out_len, hdr->gso_type);
> -#endif
> -#ifdef DEBUG
> -				disp_iovec(mic, &copy, __func__, __LINE__);
> -				mpsslog("%s %s %d read from tap 0x%lx\n",
> -					mic->name, __func__, __LINE__,
> -					len);
> -#endif
> -				spin_for_descriptors(mic, &tx_vr);
> -				txrx_prepare(VIRTIO_ID_NET, 1, &tx_vr,
> &copy,
> -					     len);
> -
> -				err =3D mic_virtio_copy(mic,
> -					mic->mic_net.virtio_net_fd, &tx_vr,
> -					&copy);
> -				if (err < 0) {
> -					mpsslog("%s %s %d
> mic_virtio_copy %s\n",
> -						mic->name, __func__,
> __LINE__,
> -						strerror(errno));
> -				}
> -				if (!err)
> -					verify_out_len(mic, &copy);
> -#ifdef DEBUG
> -				disp_iovec(mic, &copy, __func__, __LINE__);
> -				mpsslog("%s %s %d wrote to net 0x%lx\n",
> -					mic->name, __func__, __LINE__,
> -					sum_iovec_len(&copy));
> -#endif
> -				/* Reinitialize IOV for next run */
> -				iov0[1].iov_len =3D MAX_NET_PKT_SIZE;
> -			} else if (len < 0) {
> -				disp_iovec(mic, &copy, __func__, __LINE__);
> -				mpsslog("%s %s %d read failed %s ", mic-
> >name,
> -					__func__, __LINE__, strerror(errno));
> -				mpsslog("cnt %d sum %zd\n",
> -					copy.iovcnt, sum_iovec_len(&copy));
> -			}
> -		}
> -
> -		/*
> -		 * Check if there is data to be read from virtio net and
> -		 * write to TUN if there is.
> -		 */
> -		if (net_poll[NET_FD_VIRTIO_NET].revents & POLLIN) {
> -			while (rx_vr.info->avail_idx !=3D
> -				le16toh(rx_vr.vr.avail->idx)) {
> -				copy.iov =3D iov1;
> -				txrx_prepare(VIRTIO_ID_NET, 0, &rx_vr,
> &copy,
> -					     MAX_NET_PKT_SIZE
> -					+ sizeof(struct virtio_net_hdr));
> -
> -				err =3D mic_virtio_copy(mic,
> -					mic->mic_net.virtio_net_fd, &rx_vr,
> -					&copy);
> -				if (!err) {
> -#ifdef DEBUG
> -					struct virtio_net_hdr *hdr
> -						=3D (struct virtio_net_hdr *)
> -							vnet_hdr[1];
> -
> -					mpsslog("%s %s %d hdr->flags 0x%x,
> ",
> -						mic->name, __func__,
> __LINE__,
> -						hdr->flags);
> -					mpsslog("out_len %d gso_type
> 0x%x\n",
> -						copy.out_len,
> -						hdr->gso_type);
> -#endif
> -					/* Set the correct output iov_len */
> -					iov1[1].iov_len =3D copy.out_len -
> -						sizeof(struct virtio_net_hdr);
> -					verify_out_len(mic, &copy);
> -#ifdef DEBUG
> -					disp_iovec(mic, &copy, __func__,
> -						   __LINE__);
> -					mpsslog("%s %s %d ",
> -						mic->name, __func__,
> __LINE__);
> -					mpsslog("read from net 0x%lx\n",
> -						sum_iovec_len(&copy));
> -#endif
> -					len =3D
> writev(net_poll[NET_FD_TUN].fd,
> -						copy.iov, copy.iovcnt);
> -					if (len !=3D sum_iovec_len(&copy)) {
> -						mpsslog("Tun write failed %s
> ",
> -							strerror(errno));
> -						mpsslog("len 0x%zx ", len);
> -						mpsslog("read_len 0x%zx\n",
> -
> 	sum_iovec_len(&copy));
> -					} else {
> -#ifdef DEBUG
> -						disp_iovec(mic, &copy,
> __func__,
> -							   __LINE__);
> -						mpsslog("%s %s %d ",
> -							mic->name, __func__,
> -							__LINE__);
> -						mpsslog("wrote to tap
> 0x%lx\n",
> -							len);
> -#endif
> -					}
> -				} else {
> -					mpsslog("%s %s %d
> mic_virtio_copy %s\n",
> -						mic->name, __func__,
> __LINE__,
> -						strerror(errno));
> -					break;
> -				}
> -			}
> -		}
> -		if (net_poll[NET_FD_VIRTIO_NET].revents & POLLERR)
> -			mpsslog("%s: %s: POLLERR\n", __func__, mic->name);
> -	}
> -done:
> -	pthread_exit(NULL);
> -}
> -
> -/* virtio_console */
> -#define VIRTIO_CONSOLE_FD 0
> -#define MONITOR_FD (VIRTIO_CONSOLE_FD + 1)
> -#define MAX_CONSOLE_FD (MONITOR_FD + 1)  /* must be the last one + 1
> */
> -#define MAX_BUFFER_SIZE PAGE_SIZE
> -
> -static void *
> -virtio_console(void *arg)
> -{
> -	static __u8 vcons_buf[2][PAGE_SIZE];
> -	struct iovec vcons_iov[2] =3D {
> -		{ .iov_base =3D vcons_buf[0], .iov_len =3D sizeof(vcons_buf[0]) },
> -		{ .iov_base =3D vcons_buf[1], .iov_len =3D sizeof(vcons_buf[1]) },
> -	};
> -	struct iovec *iov0 =3D &vcons_iov[0], *iov1 =3D &vcons_iov[1];
> -	struct mic_info *mic =3D (struct mic_info *)arg;
> -	int err;
> -	struct pollfd console_poll[MAX_CONSOLE_FD];
> -	int pty_fd;
> -	char *pts_name;
> -	ssize_t len;
> -	struct mic_vring tx_vr, rx_vr;
> -	struct mic_copy_desc copy;
> -	struct mic_device_desc *desc;
> -
> -	pty_fd =3D posix_openpt(O_RDWR);
> -	if (pty_fd < 0) {
> -		mpsslog("can't open a pseudoterminal master device: %s\n",
> -			strerror(errno));
> -		goto _return;
> -	}
> -	pts_name =3D ptsname(pty_fd);
> -	if (pts_name =3D=3D NULL) {
> -		mpsslog("can't get pts name\n");
> -		goto _close_pty;
> -	}
> -	printf("%s console message goes to %s\n", mic->name, pts_name);
> -	mpsslog("%s console message goes to %s\n", mic->name, pts_name);
> -	err =3D grantpt(pty_fd);
> -	if (err < 0) {
> -		mpsslog("can't grant access: %s %s\n",
> -			pts_name, strerror(errno));
> -		goto _close_pty;
> -	}
> -	err =3D unlockpt(pty_fd);
> -	if (err < 0) {
> -		mpsslog("can't unlock a pseudoterminal: %s %s\n",
> -			pts_name, strerror(errno));
> -		goto _close_pty;
> -	}
> -	console_poll[MONITOR_FD].fd =3D pty_fd;
> -	console_poll[MONITOR_FD].events =3D POLLIN;
> -
> -	console_poll[VIRTIO_CONSOLE_FD].fd =3D mic-
> >mic_console.virtio_console_fd;
> -	console_poll[VIRTIO_CONSOLE_FD].events =3D POLLIN;
> -
> -	if (MAP_FAILED =3D=3D init_vr(mic, mic->mic_console.virtio_console_fd,
> -				  VIRTIO_ID_CONSOLE, &tx_vr, &rx_vr,
> -		virtcons_dev_page.dd.num_vq)) {
> -		mpsslog("%s init_vr failed %s\n",
> -			mic->name, strerror(errno));
> -		goto _close_pty;
> -	}
> -
> -	copy.iovcnt =3D 1;
> -	desc =3D get_device_desc(mic, VIRTIO_ID_CONSOLE);
> -
> -	for (;;) {
> -		console_poll[MONITOR_FD].revents =3D 0;
> -		console_poll[VIRTIO_CONSOLE_FD].revents =3D 0;
> -		err =3D poll(console_poll, MAX_CONSOLE_FD, -1);
> -		if (err < 0) {
> -			mpsslog("%s %d: poll failed: %s\n", __func__,
> __LINE__,
> -				strerror(errno));
> -			continue;
> -		}
> -		if (!(desc->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
> -			err =3D wait_for_card_driver(mic,
> -					mic->mic_console.virtio_console_fd,
> -					VIRTIO_ID_CONSOLE);
> -			if (err) {
> -				mpsslog("%s %s %d Exiting...\n",
> -					mic->name, __func__, __LINE__);
> -				break;
> -			}
> -		}
> -
> -		if (console_poll[MONITOR_FD].revents & POLLIN) {
> -			copy.iov =3D iov0;
> -			len =3D readv(pty_fd, copy.iov, copy.iovcnt);
> -			if (len > 0) {
> -#ifdef DEBUG
> -				disp_iovec(mic, &copy, __func__, __LINE__);
> -				mpsslog("%s %s %d read from tap 0x%lx\n",
> -					mic->name, __func__, __LINE__,
> -					len);
> -#endif
> -				spin_for_descriptors(mic, &tx_vr);
> -				txrx_prepare(VIRTIO_ID_CONSOLE, 1, &tx_vr,
> -					     &copy, len);
> -
> -				err =3D mic_virtio_copy(mic,
> -					mic->mic_console.virtio_console_fd,
> -					&tx_vr, &copy);
> -				if (err < 0) {
> -					mpsslog("%s %s %d
> mic_virtio_copy %s\n",
> -						mic->name, __func__,
> __LINE__,
> -						strerror(errno));
> -				}
> -				if (!err)
> -					verify_out_len(mic, &copy);
> -#ifdef DEBUG
> -				disp_iovec(mic, &copy, __func__, __LINE__);
> -				mpsslog("%s %s %d wrote to net 0x%lx\n",
> -					mic->name, __func__, __LINE__,
> -					sum_iovec_len(&copy));
> -#endif
> -				/* Reinitialize IOV for next run */
> -				iov0->iov_len =3D PAGE_SIZE;
> -			} else if (len < 0) {
> -				disp_iovec(mic, &copy, __func__, __LINE__);
> -				mpsslog("%s %s %d read failed %s ",
> -					mic->name, __func__, __LINE__,
> -					strerror(errno));
> -				mpsslog("cnt %d sum %zd\n",
> -					copy.iovcnt, sum_iovec_len(&copy));
> -			}
> -		}
> -
> -		if (console_poll[VIRTIO_CONSOLE_FD].revents & POLLIN) {
> -			while (rx_vr.info->avail_idx !=3D
> -				le16toh(rx_vr.vr.avail->idx)) {
> -				copy.iov =3D iov1;
> -				txrx_prepare(VIRTIO_ID_CONSOLE, 0, &rx_vr,
> -					     &copy, PAGE_SIZE);
> -
> -				err =3D mic_virtio_copy(mic,
> -					mic->mic_console.virtio_console_fd,
> -					&rx_vr, &copy);
> -				if (!err) {
> -					/* Set the correct output iov_len */
> -					iov1->iov_len =3D copy.out_len;
> -					verify_out_len(mic, &copy);
> -#ifdef DEBUG
> -					disp_iovec(mic, &copy, __func__,
> -						   __LINE__);
> -					mpsslog("%s %s %d ",
> -						mic->name, __func__,
> __LINE__);
> -					mpsslog("read from net 0x%lx\n",
> -						sum_iovec_len(&copy));
> -#endif
> -					len =3D writev(pty_fd,
> -						copy.iov, copy.iovcnt);
> -					if (len !=3D sum_iovec_len(&copy)) {
> -						mpsslog("Tun write failed %s
> ",
> -							strerror(errno));
> -						mpsslog("len 0x%zx ", len);
> -						mpsslog("read_len 0x%zx\n",
> -
> 	sum_iovec_len(&copy));
> -					} else {
> -#ifdef DEBUG
> -						disp_iovec(mic, &copy,
> __func__,
> -							   __LINE__);
> -						mpsslog("%s %s %d ",
> -							mic->name, __func__,
> -							__LINE__);
> -						mpsslog("wrote to tap
> 0x%lx\n",
> -							len);
> -#endif
> -					}
> -				} else {
> -					mpsslog("%s %s %d
> mic_virtio_copy %s\n",
> -						mic->name, __func__,
> __LINE__,
> -						strerror(errno));
> -					break;
> -				}
> -			}
> -		}
> -		if (console_poll[NET_FD_VIRTIO_NET].revents & POLLERR)
> -			mpsslog("%s: %s: POLLERR\n", __func__, mic->name);
> -	}
> -_close_pty:
> -	close(pty_fd);
> -_return:
> -	pthread_exit(NULL);
> -}
> -
> -static void
> -add_virtio_device(struct mic_info *mic, struct mic_device_desc *dd)
> -{
> -	char path[PATH_MAX];
> -	int fd, err;
> -
> -	snprintf(path, PATH_MAX, "/dev/vop_virtio%d", mic->id);
> -	fd =3D open(path, O_RDWR);
> -	if (fd < 0) {
> -		mpsslog("Could not open %s %s\n", path, strerror(errno));
> -		return;
> -	}
> -
> -	err =3D ioctl(fd, MIC_VIRTIO_ADD_DEVICE, dd);
> -	if (err < 0) {
> -		mpsslog("Could not add %d %s\n", dd->type, strerror(errno));
> -		close(fd);
> -		return;
> -	}
> -	switch (dd->type) {
> -	case VIRTIO_ID_NET:
> -		mic->mic_net.virtio_net_fd =3D fd;
> -		mpsslog("Added VIRTIO_ID_NET for %s\n", mic->name);
> -		break;
> -	case VIRTIO_ID_CONSOLE:
> -		mic->mic_console.virtio_console_fd =3D fd;
> -		mpsslog("Added VIRTIO_ID_CONSOLE for %s\n", mic->name);
> -		break;
> -	case VIRTIO_ID_BLOCK:
> -		mic->mic_virtblk.virtio_block_fd =3D fd;
> -		mpsslog("Added VIRTIO_ID_BLOCK for %s\n", mic->name);
> -		break;
> -	}
> -}
> -
> -static bool
> -set_backend_file(struct mic_info *mic)
> -{
> -	FILE *config;
> -	char buff[PATH_MAX], *line, *evv, *p;
> -
> -	snprintf(buff, PATH_MAX, "%s/mpssd%03d.conf", mic_config_dir,
> mic->id);
> -	config =3D fopen(buff, "r");
> -	if (config =3D=3D NULL)
> -		return false;
> -	do {  /* look for "virtblk_backend=3DXXXX" */
> -		line =3D fgets(buff, PATH_MAX, config);
> -		if (line =3D=3D NULL)
> -			break;
> -		if (*line =3D=3D '#')
> -			continue;
> -		p =3D strchr(line, '\n');
> -		if (p)
> -			*p =3D '\0';
> -	} while (strncmp(line, virtblk_backend, strlen(virtblk_backend)) !=3D 0=
);
> -	fclose(config);
> -	if (line =3D=3D NULL)
> -		return false;
> -	evv =3D strchr(line, '=3D');
> -	if (evv =3D=3D NULL)
> -		return false;
> -	mic->mic_virtblk.backend_file =3D malloc(strlen(evv) + 1);
> -	if (mic->mic_virtblk.backend_file =3D=3D NULL) {
> -		mpsslog("%s %d can't allocate memory\n", mic->name, mic-
> >id);
> -		return false;
> -	}
> -	strcpy(mic->mic_virtblk.backend_file, evv + 1);
> -	return true;
> -}
> -
> -#define SECTOR_SIZE 512
> -static bool
> -set_backend_size(struct mic_info *mic)
> -{
> -	mic->mic_virtblk.backend_size =3D lseek(mic->mic_virtblk.backend, 0,
> -		SEEK_END);
> -	if (mic->mic_virtblk.backend_size < 0) {
> -		mpsslog("%s: can't seek: %s\n",
> -			mic->name, mic->mic_virtblk.backend_file);
> -		return false;
> -	}
> -	virtblk_dev_page.blk_config.capacity =3D
> -		mic->mic_virtblk.backend_size / SECTOR_SIZE;
> -	if ((mic->mic_virtblk.backend_size % SECTOR_SIZE) !=3D 0)
> -		virtblk_dev_page.blk_config.capacity++;
> -
> -	virtblk_dev_page.blk_config.capacity =3D
> -		htole64(virtblk_dev_page.blk_config.capacity);
> -
> -	return true;
> -}
> -
> -static bool
> -open_backend(struct mic_info *mic)
> -{
> -	if (!set_backend_file(mic))
> -		goto _error_exit;
> -	mic->mic_virtblk.backend =3D open(mic->mic_virtblk.backend_file,
> O_RDWR);
> -	if (mic->mic_virtblk.backend < 0) {
> -		mpsslog("%s: can't open: %s\n", mic->name,
> -			mic->mic_virtblk.backend_file);
> -		goto _error_free;
> -	}
> -	if (!set_backend_size(mic))
> -		goto _error_close;
> -	mic->mic_virtblk.backend_addr =3D mmap(NULL,
> -		mic->mic_virtblk.backend_size,
> -		PROT_READ|PROT_WRITE, MAP_SHARED,
> -		mic->mic_virtblk.backend, 0L);
> -	if (mic->mic_virtblk.backend_addr =3D=3D MAP_FAILED) {
> -		mpsslog("%s: can't map: %s %s\n",
> -			mic->name, mic->mic_virtblk.backend_file,
> -			strerror(errno));
> -		goto _error_close;
> -	}
> -	return true;
> -
> - _error_close:
> -	close(mic->mic_virtblk.backend);
> - _error_free:
> -	free(mic->mic_virtblk.backend_file);
> - _error_exit:
> -	return false;
> -}
> -
> -static void
> -close_backend(struct mic_info *mic)
> -{
> -	munmap(mic->mic_virtblk.backend_addr, mic-
> >mic_virtblk.backend_size);
> -	close(mic->mic_virtblk.backend);
> -	free(mic->mic_virtblk.backend_file);
> -}
> -
> -static bool
> -start_virtblk(struct mic_info *mic, struct mic_vring *vring)
> -{
> -	if (((unsigned long)&virtblk_dev_page.blk_config % 8) !=3D 0) {
> -		mpsslog("%s: blk_config is not 8 byte aligned.\n",
> -			mic->name);
> -		return false;
> -	}
> -	add_virtio_device(mic, &virtblk_dev_page.dd);
> -	if (MAP_FAILED =3D=3D init_vr(mic, mic->mic_virtblk.virtio_block_fd,
> -				  VIRTIO_ID_BLOCK, vring, NULL,
> -				  virtblk_dev_page.dd.num_vq)) {
> -		mpsslog("%s init_vr failed %s\n",
> -			mic->name, strerror(errno));
> -		return false;
> -	}
> -	return true;
> -}
> -
> -static void
> -stop_virtblk(struct mic_info *mic)
> -{
> -	int vr_size, ret;
> -
> -	vr_size =3D PAGE_ALIGN(_vring_size(MIC_VRING_ENTRIES,
> -					 MIC_VIRTIO_RING_ALIGN) +
> -			     sizeof(struct _mic_vring_info));
> -	ret =3D munmap(mic->mic_virtblk.block_dp,
> -		MIC_DEVICE_PAGE_END + vr_size *
> virtblk_dev_page.dd.num_vq);
> -	if (ret < 0)
> -		mpsslog("%s munmap errno %d\n", mic->name, errno);
> -	close(mic->mic_virtblk.virtio_block_fd);
> -}
> -
> -static __u8
> -header_error_check(struct vring_desc *desc)
> -{
> -	if (le32toh(desc->len) !=3D sizeof(struct virtio_blk_outhdr)) {
> -		mpsslog("%s() %d: length is not sizeof(virtio_blk_outhd)\n",
> -			__func__, __LINE__);
> -		return -EIO;
> -	}
> -	if (!(le16toh(desc->flags) & VRING_DESC_F_NEXT)) {
> -		mpsslog("%s() %d: alone\n",
> -			__func__, __LINE__);
> -		return -EIO;
> -	}
> -	if (le16toh(desc->flags) & VRING_DESC_F_WRITE) {
> -		mpsslog("%s() %d: not read\n",
> -			__func__, __LINE__);
> -		return -EIO;
> -	}
> -	return 0;
> -}
> -
> -static int
> -read_header(int fd, struct virtio_blk_outhdr *hdr, __u32 desc_idx)
> -{
> -	struct iovec iovec;
> -	struct mic_copy_desc copy;
> -
> -	iovec.iov_len =3D sizeof(*hdr);
> -	iovec.iov_base =3D hdr;
> -	copy.iov =3D &iovec;
> -	copy.iovcnt =3D 1;
> -	copy.vr_idx =3D 0;  /* only one vring on virtio_block */
> -	copy.update_used =3D false;  /* do not update used index */
> -	return ioctl(fd, MIC_VIRTIO_COPY_DESC, &copy);
> -}
> -
> -static int
> -transfer_blocks(int fd, struct iovec *iovec, __u32 iovcnt)
> -{
> -	struct mic_copy_desc copy;
> -
> -	copy.iov =3D iovec;
> -	copy.iovcnt =3D iovcnt;
> -	copy.vr_idx =3D 0;  /* only one vring on virtio_block */
> -	copy.update_used =3D false;  /* do not update used index */
> -	return ioctl(fd, MIC_VIRTIO_COPY_DESC, &copy);
> -}
> -
> -static __u8
> -status_error_check(struct vring_desc *desc)
> -{
> -	if (le32toh(desc->len) !=3D sizeof(__u8)) {
> -		mpsslog("%s() %d: length is not sizeof(status)\n",
> -			__func__, __LINE__);
> -		return -EIO;
> -	}
> -	return 0;
> -}
> -
> -static int
> -write_status(int fd, __u8 *status)
> -{
> -	struct iovec iovec;
> -	struct mic_copy_desc copy;
> -
> -	iovec.iov_base =3D status;
> -	iovec.iov_len =3D sizeof(*status);
> -	copy.iov =3D &iovec;
> -	copy.iovcnt =3D 1;
> -	copy.vr_idx =3D 0;  /* only one vring on virtio_block */
> -	copy.update_used =3D true; /* Update used index */
> -	return ioctl(fd, MIC_VIRTIO_COPY_DESC, &copy);
> -}
> -
> -#ifndef VIRTIO_BLK_T_GET_ID
> -#define VIRTIO_BLK_T_GET_ID    8
> -#endif
> -
> -static void *
> -virtio_block(void *arg)
> -{
> -	struct mic_info *mic =3D (struct mic_info *)arg;
> -	int ret;
> -	struct pollfd block_poll;
> -	struct mic_vring vring;
> -	__u16 avail_idx;
> -	__u32 desc_idx;
> -	struct vring_desc *desc;
> -	struct iovec *iovec, *piov;
> -	__u8 status;
> -	__u32 buffer_desc_idx;
> -	struct virtio_blk_outhdr hdr;
> -	void *fos;
> -
> -	for (;;) {  /* forever */
> -		if (!open_backend(mic)) { /* No virtblk */
> -			for (mic->mic_virtblk.signaled =3D 0;
> -				!mic->mic_virtblk.signaled;)
> -				sleep(1);
> -			continue;
> -		}
> -
> -		/* backend file is specified. */
> -		if (!start_virtblk(mic, &vring))
> -			goto _close_backend;
> -		iovec =3D malloc(sizeof(*iovec) *
> -			le32toh(virtblk_dev_page.blk_config.seg_max));
> -		if (!iovec) {
> -			mpsslog("%s: can't alloc iovec: %s\n",
> -				mic->name, strerror(ENOMEM));
> -			goto _stop_virtblk;
> -		}
> -
> -		block_poll.fd =3D mic->mic_virtblk.virtio_block_fd;
> -		block_poll.events =3D POLLIN;
> -		for (mic->mic_virtblk.signaled =3D 0;
> -		     !mic->mic_virtblk.signaled;) {
> -			block_poll.revents =3D 0;
> -					/* timeout in 1 sec to see signaled */
> -			ret =3D poll(&block_poll, 1, 1000);
> -			if (ret < 0) {
> -				mpsslog("%s %d: poll failed: %s\n",
> -					__func__, __LINE__,
> -					strerror(errno));
> -				continue;
> -			}
> -
> -			if (!(block_poll.revents & POLLIN)) {
> -#ifdef DEBUG
> -				mpsslog("%s %d: block_poll.revents=3D0x%x\n",
> -					__func__, __LINE__,
> block_poll.revents);
> -#endif
> -				continue;
> -			}
> -
> -			/* POLLIN */
> -			while (vring.info->avail_idx !=3D
> -				le16toh(vring.vr.avail->idx)) {
> -				/* read header element */
> -				avail_idx =3D
> -					vring.info->avail_idx &
> -					(vring.vr.num - 1);
> -				desc_idx =3D le16toh(
> -					vring.vr.avail->ring[avail_idx]);
> -				desc =3D &vring.vr.desc[desc_idx];
> -#ifdef DEBUG
> -				mpsslog("%s() %d: avail_idx=3D%d ",
> -					__func__, __LINE__,
> -					vring.info->avail_idx);
> -				mpsslog("vring.vr.num=3D%d desc=3D%p\n",
> -					vring.vr.num, desc);
> -#endif
> -				status =3D header_error_check(desc);
> -				ret =3D read_header(
> -					mic->mic_virtblk.virtio_block_fd,
> -					&hdr, desc_idx);
> -				if (ret < 0) {
> -					mpsslog("%s() %d %s: ret=3D%d %s\n",
> -						__func__, __LINE__,
> -						mic->name, ret,
> -						strerror(errno));
> -					break;
> -				}
> -				/* buffer element */
> -				piov =3D iovec;
> -				status =3D 0;
> -				fos =3D mic->mic_virtblk.backend_addr +
> -					(hdr.sector * SECTOR_SIZE);
> -				buffer_desc_idx =3D next_desc(desc);
> -				desc_idx =3D buffer_desc_idx;
> -				for (desc =3D &vring.vr.desc[buffer_desc_idx];
> -				     desc->flags & VRING_DESC_F_NEXT;
> -				     desc_idx =3D next_desc(desc),
> -					     desc =3D &vring.vr.desc[desc_idx]) {
> -					piov->iov_len =3D desc->len;
> -					piov->iov_base =3D fos;
> -					piov++;
> -					fos +=3D desc->len;
> -				}
> -				/* Returning NULLs for VIRTIO_BLK_T_GET_ID.
> */
> -				if (hdr.type & ~(VIRTIO_BLK_T_OUT |
> -					VIRTIO_BLK_T_GET_ID)) {
> -					/*
> -					  VIRTIO_BLK_T_IN - does not do
> -					  anything. Probably for documenting.
> -					  VIRTIO_BLK_T_SCSI_CMD - for
> -					  virtio_scsi.
> -					  VIRTIO_BLK_T_FLUSH - turned off in
> -					  config space.
> -					  VIRTIO_BLK_T_BARRIER - defined
> but not
> -					  used in anywhere.
> -					*/
> -					mpsslog("%s() %d: type %x ",
> -						__func__, __LINE__,
> -						hdr.type);
> -					mpsslog("is not supported\n");
> -					status =3D -ENOTSUP;
> -
> -				} else {
> -					ret =3D transfer_blocks(
> -					mic->mic_virtblk.virtio_block_fd,
> -						iovec,
> -						piov - iovec);
> -					if (ret < 0 &&
> -					    status !=3D 0)
> -						status =3D ret;
> -				}
> -				/* write status and update used pointer */
> -				if (status !=3D 0)
> -					status =3D status_error_check(desc);
> -				ret =3D write_status(
> -					mic->mic_virtblk.virtio_block_fd,
> -					&status);
> -#ifdef DEBUG
> -				mpsslog("%s() %d: write status=3D%d on
> desc=3D%p\n",
> -					__func__, __LINE__,
> -					status, desc);
> -#endif
> -			}
> -		}
> -		free(iovec);
> -_stop_virtblk:
> -		stop_virtblk(mic);
> -_close_backend:
> -		close_backend(mic);
> -	}  /* forever */
> -
> -	pthread_exit(NULL);
> -}
> -
> -static void
> -reset(struct mic_info *mic)
> -{
> -#define RESET_TIMEOUT 120
> -	int i =3D RESET_TIMEOUT;
> -	setsysfs(mic->name, "state", "reset");
> -	while (i) {
> -		char *state;
> -		state =3D readsysfs(mic->name, "state");
> -		if (!state)
> -			goto retry;
> -		mpsslog("%s: %s %d state %s\n",
> -			mic->name, __func__, __LINE__, state);
> -
> -		if (!strcmp(state, "ready")) {
> -			free(state);
> -			break;
> -		}
> -		free(state);
> -retry:
> -		sleep(1);
> -		i--;
> -	}
> -}
> -
> -static int
> -get_mic_shutdown_status(struct mic_info *mic, char *shutdown_status)
> -{
> -	if (!strcmp(shutdown_status, "nop"))
> -		return MIC_NOP;
> -	if (!strcmp(shutdown_status, "crashed"))
> -		return MIC_CRASHED;
> -	if (!strcmp(shutdown_status, "halted"))
> -		return MIC_HALTED;
> -	if (!strcmp(shutdown_status, "poweroff"))
> -		return MIC_POWER_OFF;
> -	if (!strcmp(shutdown_status, "restart"))
> -		return MIC_RESTART;
> -	mpsslog("%s: BUG invalid status %s\n", mic->name,
> shutdown_status);
> -	/* Invalid state */
> -	assert(0);
> -};
> -
> -static int get_mic_state(struct mic_info *mic)
> -{
> -	char *state =3D NULL;
> -	enum mic_states mic_state;
> -
> -	while (!state) {
> -		state =3D readsysfs(mic->name, "state");
> -		sleep(1);
> -	}
> -	mpsslog("%s: %s %d state %s\n",
> -		mic->name, __func__, __LINE__, state);
> -
> -	if (!strcmp(state, "ready")) {
> -		mic_state =3D MIC_READY;
> -	} else if (!strcmp(state, "booting")) {
> -		mic_state =3D MIC_BOOTING;
> -	} else if (!strcmp(state, "online")) {
> -		mic_state =3D MIC_ONLINE;
> -	} else if (!strcmp(state, "shutting_down")) {
> -		mic_state =3D MIC_SHUTTING_DOWN;
> -	} else if (!strcmp(state, "reset_failed")) {
> -		mic_state =3D MIC_RESET_FAILED;
> -	} else if (!strcmp(state, "resetting")) {
> -		mic_state =3D MIC_RESETTING;
> -	} else {
> -		mpsslog("%s: BUG invalid state %s\n", mic->name, state);
> -		assert(0);
> -	}
> -
> -	free(state);
> -	return mic_state;
> -};
> -
> -static void mic_handle_shutdown(struct mic_info *mic)
> -{
> -#define SHUTDOWN_TIMEOUT 60
> -	int i =3D SHUTDOWN_TIMEOUT;
> -	char *shutdown_status;
> -	while (i) {
> -		shutdown_status =3D readsysfs(mic->name,
> "shutdown_status");
> -		if (!shutdown_status) {
> -			sleep(1);
> -			continue;
> -		}
> -		mpsslog("%s: %s %d shutdown_status %s\n",
> -			mic->name, __func__, __LINE__, shutdown_status);
> -		switch (get_mic_shutdown_status(mic, shutdown_status)) {
> -		case MIC_RESTART:
> -			mic->restart =3D 1;
> -		case MIC_HALTED:
> -		case MIC_POWER_OFF:
> -		case MIC_CRASHED:
> -			free(shutdown_status);
> -			goto reset;
> -		default:
> -			break;
> -		}
> -		free(shutdown_status);
> -		sleep(1);
> -		i--;
> -	}
> -reset:
> -	if (!i)
> -		mpsslog("%s: %s %d timing out waiting for
> shutdown_status %s\n",
> -			mic->name, __func__, __LINE__, shutdown_status);
> -	reset(mic);
> -}
> -
> -static int open_state_fd(struct mic_info *mic)
> -{
> -	char pathname[PATH_MAX];
> -	int fd;
> -
> -	snprintf(pathname, PATH_MAX - 1, "%s/%s/%s",
> -		 MICSYSFSDIR, mic->name, "state");
> -
> -	fd =3D open(pathname, O_RDONLY);
> -	if (fd < 0)
> -		mpsslog("%s: opening file %s failed %s\n",
> -			mic->name, pathname, strerror(errno));
> -	return fd;
> -}
> -
> -static int block_till_state_change(int fd, struct mic_info *mic)
> -{
> -	struct pollfd ufds[1];
> -	char value[PAGE_SIZE];
> -	int ret;
> -
> -	ufds[0].fd =3D fd;
> -	ufds[0].events =3D POLLERR | POLLPRI;
> -	ret =3D poll(ufds, 1, -1);
> -	if (ret < 0) {
> -		mpsslog("%s: %s %d poll failed %s\n",
> -			mic->name, __func__, __LINE__, strerror(errno));
> -		return ret;
> -	}
> -
> -	ret =3D lseek(fd, 0, SEEK_SET);
> -	if (ret < 0) {
> -		mpsslog("%s: %s %d Failed to seek to 0: %s\n",
> -			mic->name, __func__, __LINE__, strerror(errno));
> -		return ret;
> -	}
> -
> -	ret =3D read(fd, value, sizeof(value));
> -	if (ret < 0) {
> -		mpsslog("%s: %s %d Failed to read sysfs entry: %s\n",
> -			mic->name, __func__, __LINE__, strerror(errno));
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static void *
> -mic_config(void *arg)
> -{
> -	struct mic_info *mic =3D (struct mic_info *)arg;
> -	int fd, ret, stat =3D 0;
> -
> -	fd =3D open_state_fd(mic);
> -	if (fd < 0) {
> -		mpsslog("%s: %s %d open state fd failed %s\n",
> -			mic->name, __func__, __LINE__, strerror(errno));
> -		goto exit;
> -	}
> -
> -	do {
> -		ret =3D block_till_state_change(fd, mic);
> -		if (ret < 0) {
> -			mpsslog("%s: %s %d block_till_state_change
> error %s\n",
> -				mic->name, __func__, __LINE__,
> strerror(errno));
> -			goto close_exit;
> -		}
> -
> -		switch (get_mic_state(mic)) {
> -		case MIC_SHUTTING_DOWN:
> -			mic_handle_shutdown(mic);
> -			break;
> -		case MIC_READY:
> -		case MIC_RESET_FAILED:
> -			ret =3D kill(mic->pid, SIGTERM);
> -			mpsslog("%s: %s %d kill pid %d ret %d\n",
> -				mic->name, __func__, __LINE__,
> -				mic->pid, ret);
> -			if (!ret) {
> -				ret =3D waitpid(mic->pid, &stat,
> -					      WIFSIGNALED(stat));
> -				mpsslog("%s: %s %d waitpid ret %d
> pid %d\n",
> -					mic->name, __func__, __LINE__,
> -					ret, mic->pid);
> -			}
> -			if (mic->boot_on_resume) {
> -				setsysfs(mic->name, "state", "boot");
> -				mic->boot_on_resume =3D 0;
> -			}
> -			goto close_exit;
> -		default:
> -			break;
> -		}
> -	} while (1);
> -
> -close_exit:
> -	close(fd);
> -exit:
> -	init_mic(mic);
> -	pthread_exit(NULL);
> -}
> -
> -static void
> -set_cmdline(struct mic_info *mic)
> -{
> -	char buffer[PATH_MAX];
> -	int len;
> -
> -	len =3D snprintf(buffer, PATH_MAX,
> -		"clocksource=3Dtsc highres=3Doff nohz=3Doff ");
> -	len +=3D snprintf(buffer + len, PATH_MAX - len,
> -		"cpufreq_on;corec6_off;pc3_off;pc6_off ");
> -	len +=3D snprintf(buffer + len, PATH_MAX - len,
> -		"ifcfg=3Dstatic;address,172.31.%d.1;netmask,255.255.255.0",
> -		mic->id + 1);
> -
> -	setsysfs(mic->name, "cmdline", buffer);
> -	mpsslog("%s: Command line: \"%s\"\n", mic->name, buffer);
> -	snprintf(buffer, PATH_MAX, "172.31.%d.1", mic->id + 1);
> -	mpsslog("%s: IPADDR: \"%s\"\n", mic->name, buffer);
> -}
> -
> -static void
> -set_log_buf_info(struct mic_info *mic)
> -{
> -	int fd;
> -	off_t len;
> -	char system_map[] =3D "/lib/firmware/mic/System.map";
> -	char *map, *temp, log_buf[17] =3D {'\0'};
> -
> -	fd =3D open(system_map, O_RDONLY);
> -	if (fd < 0) {
> -		mpsslog("%s: Opening System.map failed: %d\n",
> -			mic->name, errno);
> -		return;
> -	}
> -	len =3D lseek(fd, 0, SEEK_END);
> -	if (len < 0) {
> -		mpsslog("%s: Reading System.map size failed: %d\n",
> -			mic->name, errno);
> -		close(fd);
> -		return;
> -	}
> -	map =3D mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, 0);
> -	if (map =3D=3D MAP_FAILED) {
> -		mpsslog("%s: mmap of System.map failed: %d\n",
> -			mic->name, errno);
> -		close(fd);
> -		return;
> -	}
> -	temp =3D strstr(map, "__log_buf");
> -	if (!temp) {
> -		mpsslog("%s: __log_buf not found: %d\n", mic->name,
> errno);
> -		munmap(map, len);
> -		close(fd);
> -		return;
> -	}
> -	strncpy(log_buf, temp - 19, 16);
> -	setsysfs(mic->name, "log_buf_addr", log_buf);
> -	mpsslog("%s: log_buf_addr: %s\n", mic->name, log_buf);
> -	temp =3D strstr(map, "log_buf_len");
> -	if (!temp) {
> -		mpsslog("%s: log_buf_len not found: %d\n", mic->name,
> errno);
> -		munmap(map, len);
> -		close(fd);
> -		return;
> -	}
> -	strncpy(log_buf, temp - 19, 16);
> -	setsysfs(mic->name, "log_buf_len", log_buf);
> -	mpsslog("%s: log_buf_len: %s\n", mic->name, log_buf);
> -	munmap(map, len);
> -	close(fd);
> -}
> -
> -static void
> -change_virtblk_backend(int x, siginfo_t *siginfo, void *p)
> -{
> -	struct mic_info *mic;
> -
> -	for (mic =3D mic_list.next; mic !=3D NULL; mic =3D mic->next)
> -		mic->mic_virtblk.signaled =3D 1/* true */;
> -}
> -
> -static void
> -set_mic_boot_params(struct mic_info *mic)
> -{
> -	set_log_buf_info(mic);
> -	set_cmdline(mic);
> -}
> -
> -static void *
> -init_mic(void *arg)
> -{
> -	struct mic_info *mic =3D (struct mic_info *)arg;
> -	struct sigaction ignore =3D {
> -		.sa_flags =3D 0,
> -		.sa_handler =3D SIG_IGN
> -	};
> -	struct sigaction act =3D {
> -		.sa_flags =3D SA_SIGINFO,
> -		.sa_sigaction =3D change_virtblk_backend,
> -	};
> -	char buffer[PATH_MAX];
> -	int err, fd;
> -
> -	/*
> -	 * Currently, one virtio block device is supported for each MIC card
> -	 * at a time. Any user (or test) can send a SIGUSR1 to the MIC
> daemon.
> -	 * The signal informs the virtio block backend about a change in the
> -	 * configuration file which specifies the virtio backend file name on
> -	 * the host. Virtio block backend then re-reads the configuration file
> -	 * and switches to the new block device. This signalling mechanism
> may
> -	 * not be required once multiple virtio block devices are supported by
> -	 * the MIC daemon.
> -	 */
> -	sigaction(SIGUSR1, &ignore, NULL);
> -retry:
> -	fd =3D open_state_fd(mic);
> -	if (fd < 0) {
> -		mpsslog("%s: %s %d open state fd failed %s\n",
> -			mic->name, __func__, __LINE__, strerror(errno));
> -		sleep(2);
> -		goto retry;
> -	}
> -
> -	if (mic->restart) {
> -		snprintf(buffer, PATH_MAX, "boot");
> -		setsysfs(mic->name, "state", buffer);
> -		mpsslog("%s restarting mic %d\n",
> -			mic->name, mic->restart);
> -		mic->restart =3D 0;
> -	}
> -
> -	while (1) {
> -		while (block_till_state_change(fd, mic)) {
> -			mpsslog("%s: %s %d block_till_state_change
> error %s\n",
> -				mic->name, __func__, __LINE__,
> strerror(errno));
> -			sleep(2);
> -			continue;
> -		}
> -
> -		if (get_mic_state(mic) =3D=3D MIC_BOOTING)
> -			break;
> -	}
> -
> -	mic->pid =3D fork();
> -	switch (mic->pid) {
> -	case 0:
> -		add_virtio_device(mic, &virtcons_dev_page.dd);
> -		add_virtio_device(mic, &virtnet_dev_page.dd);
> -		err =3D pthread_create(&mic->mic_console.console_thread,
> NULL,
> -			virtio_console, mic);
> -		if (err)
> -			mpsslog("%s virtcons pthread_create failed %s\n",
> -				mic->name, strerror(err));
> -		err =3D pthread_create(&mic->mic_net.net_thread, NULL,
> -			virtio_net, mic);
> -		if (err)
> -			mpsslog("%s virtnet pthread_create failed %s\n",
> -				mic->name, strerror(err));
> -		err =3D pthread_create(&mic->mic_virtblk.block_thread, NULL,
> -			virtio_block, mic);
> -		if (err)
> -			mpsslog("%s virtblk pthread_create failed %s\n",
> -				mic->name, strerror(err));
> -		sigemptyset(&act.sa_mask);
> -		err =3D sigaction(SIGUSR1, &act, NULL);
> -		if (err)
> -			mpsslog("%s sigaction SIGUSR1 failed %s\n",
> -				mic->name, strerror(errno));
> -		while (1)
> -			sleep(60);
> -	case -1:
> -		mpsslog("fork failed MIC name %s id %d errno %d\n",
> -			mic->name, mic->id, errno);
> -		break;
> -	default:
> -		err =3D pthread_create(&mic->config_thread, NULL,
> -				     mic_config, mic);
> -		if (err)
> -			mpsslog("%s mic_config pthread_create failed %s\n",
> -				mic->name, strerror(err));
> -	}
> -
> -	return NULL;
> -}
> -
> -static void
> -start_daemon(void)
> -{
> -	struct mic_info *mic;
> -	int err;
> -
> -	for (mic =3D mic_list.next; mic; mic =3D mic->next) {
> -		set_mic_boot_params(mic);
> -		err =3D pthread_create(&mic->init_thread, NULL, init_mic, mic);
> -		if (err)
> -			mpsslog("%s init_mic pthread_create failed %s\n",
> -				mic->name, strerror(err));
> -	}
> -
> -	while (1)
> -		sleep(60);
> -}
> -
> -static int
> -init_mic_list(void)
> -{
> -	struct mic_info *mic =3D &mic_list;
> -	struct dirent *file;
> -	DIR *dp;
> -	int cnt =3D 0;
> -
> -	dp =3D opendir(MICSYSFSDIR);
> -	if (!dp)
> -		return 0;
> -
> -	while ((file =3D readdir(dp)) !=3D NULL) {
> -		if (!strncmp(file->d_name, "mic", 3)) {
> -			mic->next =3D calloc(1, sizeof(struct mic_info));
> -			if (mic->next) {
> -				mic =3D mic->next;
> -				mic->id =3D atoi(&file->d_name[3]);
> -				mic->name =3D malloc(strlen(file->d_name) +
> 16);
> -				if (mic->name)
> -					strcpy(mic->name, file->d_name);
> -				mpsslog("MIC name %s id %d\n", mic->name,
> -					mic->id);
> -				cnt++;
> -			}
> -		}
> -	}
> -
> -	closedir(dp);
> -	return cnt;
> -}
> -
> -void
> -mpsslog(char *format, ...)
> -{
> -	va_list args;
> -	char buffer[4096];
> -	char ts[52], *ts1;
> -	time_t t;
> -
> -	if (logfp =3D=3D NULL)
> -		return;
> -
> -	va_start(args, format);
> -	vsprintf(buffer, format, args);
> -	va_end(args);
> -
> -	time(&t);
> -	ts1 =3D ctime_r(&t, ts);
> -	ts1[strlen(ts1) - 1] =3D '\0';
> -	fprintf(logfp, "%s: %s", ts1, buffer);
> -
> -	fflush(logfp);
> -}
> -
> -int
> -main(int argc, char *argv[])
> -{
> -	int cnt;
> -	pid_t pid;
> -
> -	myname =3D argv[0];
> -
> -	logfp =3D fopen(LOGFILE_NAME, "a+");
> -	if (!logfp) {
> -		fprintf(stderr, "cannot open logfile '%s'\n", LOGFILE_NAME);
> -		exit(1);
> -	}
> -	pid =3D fork();
> -	switch (pid) {
> -	case 0:
> -		break;
> -	case -1:
> -		exit(2);
> -	default:
> -		exit(0);
> -	}
> -
> -	mpsslog("MIC Daemon start\n");
> -
> -	cnt =3D init_mic_list();
> -	if (cnt =3D=3D 0) {
> -		mpsslog("MIC module not loaded\n");
> -		exit(3);
> -	}
> -	mpsslog("MIC found %d devices\n", cnt);
> -
> -	start_daemon();
> -
> -	exit(0);
> -}
> diff --git a/samples/mic/mpssd/mpssd.h b/samples/mic/mpssd/mpssd.h
> deleted file mode 100644
> index 5f98bdafe653..000000000000
> --- a/samples/mic/mpssd/mpssd.h
> +++ /dev/null
> @@ -1,89 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC User Space Tools.
> - */
> -#ifndef _MPSSD_H_
> -#define _MPSSD_H_
> -
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <dirent.h>
> -#include <libgen.h>
> -#include <pthread.h>
> -#include <stdarg.h>
> -#include <time.h>
> -#include <errno.h>
> -#include <sys/dir.h>
> -#include <sys/ioctl.h>
> -#include <sys/poll.h>
> -#include <sys/types.h>
> -#include <sys/socket.h>
> -#include <sys/stat.h>
> -#include <sys/mman.h>
> -#include <sys/utsname.h>
> -#include <sys/wait.h>
> -#include <netinet/in.h>
> -#include <arpa/inet.h>
> -#include <netdb.h>
> -#include <signal.h>
> -#include <limits.h>
> -#include <syslog.h>
> -#include <getopt.h>
> -#include <net/if.h>
> -#include <linux/if_tun.h>
> -#include <linux/virtio_ids.h>
> -
> -#define MICSYSFSDIR "/sys/class/mic"
> -#define LOGFILE_NAME "/var/log/mpssd"
> -#define PAGE_SIZE 4096
> -
> -struct mic_console_info {
> -	pthread_t       console_thread;
> -	int		virtio_console_fd;
> -	void		*console_dp;
> -};
> -
> -struct mic_net_info {
> -	pthread_t       net_thread;
> -	int		virtio_net_fd;
> -	int		tap_fd;
> -	void		*net_dp;
> -};
> -
> -struct mic_virtblk_info {
> -	pthread_t       block_thread;
> -	int		virtio_block_fd;
> -	void		*block_dp;
> -	volatile sig_atomic_t	signaled;
> -	char		*backend_file;
> -	int		backend;
> -	void		*backend_addr;
> -	long		backend_size;
> -};
> -
> -struct mic_info {
> -	int		id;
> -	char		*name;
> -	pthread_t       config_thread;
> -	pthread_t       init_thread;
> -	pid_t		pid;
> -	struct mic_console_info	mic_console;
> -	struct mic_net_info	mic_net;
> -	struct mic_virtblk_info	mic_virtblk;
> -	int		restart;
> -	int		boot_on_resume;
> -	struct mic_info *next;
> -};
> -
> -__attribute__((format(printf, 1, 2)))
> -void mpsslog(char *format, ...);
> -char *readsysfs(char *dir, char *entry);
> -int setsysfs(char *dir, char *entry, char *value);
> -#endif
> diff --git a/samples/mic/mpssd/sysfs.c b/samples/mic/mpssd/sysfs.c
> deleted file mode 100644
> index 3fb08eb7ed9d..000000000000
> --- a/samples/mic/mpssd/sysfs.c
> +++ /dev/null
> @@ -1,91 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Intel MIC Platform Software Stack (MPSS)
> - *
> - * Copyright(c) 2013 Intel Corporation.
> - *
> - * Intel MIC User Space Tools.
> - */
> -
> -#include "mpssd.h"
> -
> -#define PAGE_SIZE 4096
> -
> -char *
> -readsysfs(char *dir, char *entry)
> -{
> -	char filename[PATH_MAX];
> -	char value[PAGE_SIZE];
> -	char *string =3D NULL;
> -	int fd;
> -	int len;
> -
> -	if (dir =3D=3D NULL)
> -		snprintf(filename, PATH_MAX, "%s/%s", MICSYSFSDIR, entry);
> -	else
> -		snprintf(filename, PATH_MAX,
> -			 "%s/%s/%s", MICSYSFSDIR, dir, entry);
> -
> -	fd =3D open(filename, O_RDONLY);
> -	if (fd < 0) {
> -		mpsslog("Failed to open sysfs entry '%s': %s\n",
> -			filename, strerror(errno));
> -		return NULL;
> -	}
> -
> -	len =3D read(fd, value, sizeof(value));
> -	if (len < 0) {
> -		mpsslog("Failed to read sysfs entry '%s': %s\n",
> -			filename, strerror(errno));
> -		goto readsys_ret;
> -	}
> -	if (len =3D=3D 0)
> -		goto readsys_ret;
> -
> -	value[len - 1] =3D '\0';
> -
> -	string =3D malloc(strlen(value) + 1);
> -	if (string)
> -		strcpy(string, value);
> -
> -readsys_ret:
> -	close(fd);
> -	return string;
> -}
> -
> -int
> -setsysfs(char *dir, char *entry, char *value)
> -{
> -	char filename[PATH_MAX];
> -	char *oldvalue;
> -	int fd, ret =3D 0;
> -
> -	if (dir =3D=3D NULL)
> -		snprintf(filename, PATH_MAX, "%s/%s", MICSYSFSDIR, entry);
> -	else
> -		snprintf(filename, PATH_MAX, "%s/%s/%s",
> -			 MICSYSFSDIR, dir, entry);
> -
> -	oldvalue =3D readsysfs(dir, entry);
> -
> -	fd =3D open(filename, O_RDWR);
> -	if (fd < 0) {
> -		ret =3D errno;
> -		mpsslog("Failed to open sysfs entry '%s': %s\n",
> -			filename, strerror(errno));
> -		goto done;
> -	}
> -
> -	if (!oldvalue || strcmp(value, oldvalue)) {
> -		if (write(fd, value, strlen(value)) < 0) {
> -			ret =3D errno;
> -			mpsslog("Failed to write new sysfs entry '%s': %s\n",
> -				filename, strerror(errno));
> -		}
> -	}
> -	close(fd);
> -done:
> -	if (oldvalue)
> -		free(oldvalue);
> -	return ret;
> -}
> --
> 2.28.0

