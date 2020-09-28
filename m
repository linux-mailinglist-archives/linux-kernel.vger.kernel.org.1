Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99EB27A592
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 04:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgI1Cu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 22:50:27 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83]:37424 "EHLO
        esa6.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726461AbgI1Cu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 22:50:27 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 22:50:25 EDT
IronPort-SDR: +D7Hnh0IgXzlwn2vvsWCEvmOP/cYgLU6EmcwEugAp1z81dCOJSJSkzrtX294Br9VwVc/mSMcLi
 2rEPI5Vy+qps3J9BRRdXpn+ozd04ZQw2gLIe+ZXhhp/9knjohQkTJBzrdmoOEtRlSAnp0PglAP
 WwEtDVoCIl+OvrjCC9KYaWcxjuDsrIUT+6rwTmrOJ3wJvTyjG91gSmL2FHjuYXv0IkXlZa0gFq
 il4s3NgtjDMFKKAslqjAhBgCY6UmcMf+iyBySis3bCMeP6l74Zdhg7GfDSMGXw9nCsPb/tOsGf
 loI=
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="18842918"
X-IronPort-AV: E=Sophos;i="5.77,312,1596466800"; 
   d="scan'208";a="18842918"
Received: from mail-ty1jpn01lp2050.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.50])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 11:43:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIiPooCRDK2li6DPdD0dEO2J7ic8iIlpg6ueYNRbL5zCGxl/+TnNrRFBX19TZWTaMK5un5cQYHyfFhaM03pQAD6DySEanHQnnyUxu6ZOmVRDzAkO+SFtH2ptrabDlNOVXde/Y8mugmv+bu2O0QJN6xdYZ2qTnzh3ESkJu8xf8vriEDSwZofzSncoBZ/8KazoYFPU/bkW3sNRBwhNE/bRw8+6fORS/fVyDKBDwNQYZxtapjdfoJ+r/OEOQFBFqSNPDJWqh/dDSNc+e9mVXWcTmtUafW8T373gutmErmTGzCqOOaGNPBAvgMf2gUXdgGjaFq+JTb1lYVDVmpnAz9699A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoAePcd2oxfBqJSjZZu2z0AWGJOprfaGNHcXtrTvzIM=;
 b=GUO3ID9xQn5u7M2Y/CNhqASCYDQHoGEH5yPdT1S8166jZdnq71Nvv/Xnnzmi+BuxRdj7Q674Pt8Bjh6capycENOcPZ1bjXf5+zoNHCqX055Wlqu+pt09i70A1xS21iqopQEKMZacXRH5FiIQHRVTwbzR3wjLs7Ron7rpsqmY6ngNpxyE4kie3CTdDKwchY/i/IWhUG3G8QdjGSby5dGEuj8SC2zPj3+GVD8iTZtzVADx5EagMMeE+dr3eaiAS9VhbD4uSyT5800f/TjR6JXExoT42pbOVZtXiXs0OrXP28RuXHpVEX2GgCjWClCKv6OVUqVO4m1Jicg8/C3mjxeQ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoAePcd2oxfBqJSjZZu2z0AWGJOprfaGNHcXtrTvzIM=;
 b=LrDusU+LNNTr5imxZd2jt0J/nIcad3jvPbkimpBeXjv9ry3v0coU0I4yU0FNL8KYnZ7LO1Rb3Rm0OLWGRFW5MIXQ7XpNT3Tizuq3q7Oyetzua4WgkxAnUcwMpqG7uPxu0V0tdcDtN/7tEKX48jQ9bOz4CrSnoTwYYFZGaEKKlYE=
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com (2603:1096:604:58::11)
 by OSAPR01MB3492.jpnprd01.prod.outlook.com (2603:1096:604:57::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 02:43:10 +0000
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::b5c4:75d0:68ff:e400]) by OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::b5c4:75d0:68ff:e400%6]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 02:43:10 +0000
From:   "ito-yuichi@fujitsu.com" <ito-yuichi@fujitsu.com>
To:     "ito-yuichi@fujitsu.com" <ito-yuichi@fujitsu.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Thread-Topic: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Thread-Index: AQHWki1OzvWvE6qquUyffKCpvoCHGKl9XDZA
Date:   Mon, 28 Sep 2020 02:43:10 +0000
Message-ID: <OSAPR01MB42279E9BFA43419F49231ECE8F350@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
In-Reply-To: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8ff0d11-3cc4-4a1c-59aa-08d863583d1a
x-ms-traffictypediagnostic: OSAPR01MB3492:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSAPR01MB3492D68405BFFE28973A3A148F350@OSAPR01MB3492.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OxXaOr61r833KaoEV2Z+yxd8PNythkclRLXZ80arDEEOJkAbccDSsozNnlolPH6AfoSIdUzFd+clLVlpq7RGdHewmB3hKmzIkKBI4O7p3Pb+IjkZQtn0+N+e56PL1wD+p2LQtXpg7q0OJVWQcj0vHjW4Ue12Lu6zY0vNM9VPXcH/c1wPQ2Lb/avNN9AnjM/Pg4oNhPlLYU8pnO0EU2p3hPLIckSO/IfHl7uNxmNjiNhRmOcycJxvMJmDD920dYeEO9ZidGeJbfpmvgD+sjs2rFUynTULzkEm11ALVV99oT6lZk663rE3O4vBnfeWBpSl9hO/dpZ2GBteTaff/piZOOCANNLPCgKp64GCNjwp6PmFy+OjGAezU4YlHQzd2y1tPJmGBLl+bDr4J7xbwx4rxH5eFoddIvLLbyIBXbfrOR6KEWeFdZ+OTg72M+hpbp6KSHW+8+/7Ci4aVSRke2+4/wGPWky3ELVdy37SzsUufTxfyhQtIHrZ3QvBgVwoK4jM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4227.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(54906003)(110136005)(86362001)(478600001)(53546011)(6506007)(8936002)(7696005)(85182001)(966005)(26005)(8676002)(186003)(52536014)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(5660300002)(316002)(71200400001)(33656002)(4326008)(55016002)(83380400001)(2906002)(9686003)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XeWGKUiJsnARrOPQJcXivtvfmoulr3lRRPtrjxAn43q5uEB3rUpPDFilS+/R2Mf4WcdGbLP3BLEdsQj1glbYlgc9SuWYMl374f9NCmf92prn3WK8SSvNTgilVbrnLphmL3755wE9XSHFkzpmQMiOXS2Sv2yToRPx+ujp62jtPVS8jzlLzwmX7u29HlX9xLm/e4uiblL5iyDMp1MtZheewaqvyLfl2q8hll9JNcNm0/3tHqkWNg2wn4pJbraj8MEPTorVKUEv5RUt++V0OMrPD0zIjxc+Pac2MWm60aUtpyInm3IWXrt9BpU3iUr+EhwTq0w3pXUJM4+jxDOKoQpWz4oVSeADmhvztMqexpFLwCeTUHw4bg/NVMNNcrDUF6LPiL2yqRhRq4CF61e5xSsOx8/4TJIbm42LIG7d5sD9qsegoWbsu3ICx+hrlV8QK331des9UFDytxm+x0QCOe2Z7mPjZWr552YtWhqjskHLjL7tWkLIJ9NCbzsVhQTsZWd23POMYUaKcyOa9sbRELBzj3UKu2f77vFufkO1rQog2mc6Fi6rpNxFMwVo4Wat4Chx6PbDrO8rXOdi5lCveZ32xYDwXgYqBTrQf+dJXkwbWV0sYbSZBh48CrKBEknr7j87dc2V5Vng/tu+sUkTZj/6Rw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4227.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ff0d11-3cc4-4a1c-59aa-08d863583d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 02:43:10.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: As85vt5EyUILmEaRQlzk/GvRkoJVpC4sAYIpwO+UCZ3jGKZ+iY64XWwQi8H4sFaRvgnUGReBjaOV62mZsS1CsTt+XshOVP2PQ8pYRy4lJVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3492
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Sumit

I would appreciate if you have any advice on this patch.

Yuichi Ito

> -----Original Message-----
> From: Yuichi Ito <ito-yuichi@fujitsu.com>
> Sent: Thursday, September 24, 2020 1:43 PM
> To: maz@kernel.org; sumit.garg@linaro.org; tglx@linutronix.de;
> jason@lakedaemon.net; catalin.marinas@arm.com; will@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; I=
to,
> Yuichi/=1B$B0KF#=1B(B =1B$BM-0l=1B(B <ito-yuichi@fujitsu.com>
> Subject: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be
> pseudo-NMI
>=20
> Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
>=20
> This patchset enables IPI_CPU_CRASH_STOP IPI to be pseudo-NMI.
> This allows kdump to collect system information even when the CPU is in a
> HARDLOCKUP state.
>=20
> Only IPI_CPU_CRASH_STOP uses NMI and the other IPIs remain normal
> IRQs.
>=20
> The patch has been tested on ThunderX.
>=20
> This patch assumes Marc's latest IPIs patch-set. [1] It also uses some of
> Sumit's IPI patch set for NMI.[2]
>=20
> [1]
> https://lore.kernel.org/linux-arm-kernel/20200901144324.1071694-1-maz@ke
> rnel.org/
> [2]
> https://lore.kernel.org/linux-arm-kernel/1599830924-13990-3-git-send-emai=
l
> -sumit.garg@linaro.org/
>=20
> $ echo 1 > /proc/sys/kernel/panic_on_rcu_stal
> $ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
>    : kernel panics and crash kernel boot
>    : makedumpfile saves the system state at HARDLOCKUP in vmcore.
>=20
> crash utility:
> crash> bt
>   PID: 3213   TASK: fffffd001adc5940  CPU: 8   COMMAND: "bash"
>   #0 [fffffe0022fefcf0] lkdtm_HARDLOCKUP at fffffe0010888ab4
>   #1 [fffffe0022fefd10] lkdtm_do_action at fffffe00108882bc
>   #2 [fffffe0022fefd20] direct_entry at fffffe0010888720
>   #3 [fffffe0022fefd70] full_proxy_write at fffffe001058cfe4
>   #4 [fffffe0022fefdb0] vfs_write at fffffe00104a4c2c
>   #5 [fffffe0022fefdf0] ksys_write at fffffe00104a4f0c
>   #6 [fffffe0022fefe40] __arm64_sys_write at fffffe00104a4fbc
>   #7 [fffffe0022fefe50] el0_svc_common.constprop.0 at fffffe0010159e38
>   #8 [fffffe0022fefe80] do_el0_svc at fffffe0010159fa0
>   #9 [fffffe0022fefe90] el0_svc at fffffe00101481d0
>   #10 [fffffe0022fefea0] el0_sync_handler at fffffe00101484b4
>   #11 [fffffe0022fefff0] el0_sync at fffffe0010142b7c
>=20
>=20
> Sumit Garg (1):
>   irqchip/gic-v3: Enable support for SGIs to act as NMIs
>=20
> Yuichi Ito (1):
>   Register IPI_CPU_CRASH_STOP IPI as pseudo-NMI
>=20
>  arch/arm64/kernel/smp.c      | 39
> ++++++++++++++++++++++++++++--------
>  drivers/irqchip/irq-gic-v3.c | 13 ++++++++++--
>  2 files changed, 42 insertions(+), 10 deletions(-)
>=20
> --
> 2.25.1

