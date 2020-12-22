Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6522A2E0B94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgLVORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:17:09 -0500
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:12801
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727028AbgLVORI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:17:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqmFEYvm7jsvjfo3MoI2PGekmcQIQ+H64D3fSPP7BKufy2ZfQw7Io5o19UqeBhffqsTZf18CwbP02xFgomtpArEVvDqXZQFjUW/yBGDtolOfZhb35nm1PjiAcX/9p+55vq052Woz6Wtbs22zm0ACYAXVFJLkvqb6idg1QsnxmQglxOaiFqCfwxLoFXGhfbmfV9HWWDTjFS5nRjzOylKLwyqWeYq0H3j9jViAG0hw2Xj/v4lIpT/X28JfuZutDUekuyDlAYaYWZLqjFbJUE3Zrejl/TjjUhEqOHCyCUdWW5l+kiL5l8SlhLmsr76BIkycr4xou/MdAHZ4uZXQALGMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgO+vpOOWfKalwpYaV2dRG30RCFgIam2CBWuk/2mDTM=;
 b=MOm52QCPOhGDS5dJvd068a8TbnRWmNFzfwI/5Xfx+CjWBeMD+pOyVcKCNNirb1+QVkMX8YyqxIWcgCXnNs+vpV1Qf8poSR9jb8uH5df6qVLmAHT1mX2zckWFlcKbGO/fhfCqFZli+0Uak+2xwlZsLFPRd2vw3LxVwhVQcM8kBsNM0AghiE+pqQsryVaNydZZTFfVfsUXXpolEdjF9hAqv/UujUY1u8Tjxol3VgRUs4gzgBw383/vu+XOlUSxn8Oxd1AKVDEVNAkA6XMrSNCsH/BKkxOw72vLRvmbijqyBLLic3Q8RSXQa3ytgNaHJs8NjzoPPX3GG9f/BbB/jh3KYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgO+vpOOWfKalwpYaV2dRG30RCFgIam2CBWuk/2mDTM=;
 b=xitinb5d78y664FxiOlAD3UlF9cvkb+gslwsGmqJ2msCzutDuasDusjQPoPKv2Gen271dtSvaxd0TlAStGWw9k1xG+ffgr7KFT31qIpELzrgfoCeXnpIX666DHiZ8c5YaYeI1ngN7ulQTql2lP7LcXsW3m1d5hRYsPqxC/juz4o=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4990.namprd12.prod.outlook.com (2603:10b6:208:fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Tue, 22 Dec
 2020 14:16:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%4]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 14:16:15 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Alexander Monakov <amonakov@ispras.ru>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: amd-pmc s2idle driver issues
Thread-Topic: amd-pmc s2idle driver issues
Thread-Index: AQHW1xTQl60Nyywz90OztdBJHGRZvKoDKnNA
Date:   Tue, 22 Dec 2020 14:16:14 +0000
Message-ID: <MN2PR12MB448821DBD2DAA296FAE29A7AF7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <alpine.LNX.2.20.13.2012202341520.6949@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2012202341520.6949@monopod.intra.ispras.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-22T14:16:07Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=66e405a6-7087-4033-8b91-00009d6b0546;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-22T14:15:59Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: c4fb2547-ac87-4006-b06a-0000e0aee946
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-22T14:16:08Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 1e657a0a-bce3-49bf-abba-000092a5b331
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: ispras.ru; dkim=none (message not signed)
 header.d=none;ispras.ru; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00a561c6-602f-47f0-0b7e-08d8a6842477
x-ms-traffictypediagnostic: MN2PR12MB4990:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB499002595C93999C4426CDD8F7DF0@MN2PR12MB4990.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vVbuLoeyd9+aAvtB66ReQz58M73us7NXWJ43pq6RnnFLGxplkB4MHi9WXAfLYVrY+vm4TjyDTHh0inL2Lpv9gMb3zQ8e96lfrsSQ2hWoL42nDhK3UlTNZvc4clbiLxF4aZSFGNeZHwZGLw5y67Q65QOZTlxfN5ZXR5I/TmFyXU2Ob2uUb5+GpdUdc9oGc7IdCw97fHVZk6RJ9Fo73qzyrylXu+lWtFattDwl5++qHcyl8NSgHMZSegk69M2J0pRVOpw8Q1zaTxquDb9JmGNKtDO/P61dS+z5PHqGq0bRdxDkVtnVP1VQk98l2A4bviZLLAy38zqP95Ml7kA4pt0GuJDSk/z85+1HC37Qfx5MuchTuwG2bAiEnFLcgCdIgp4m9EuIs+Ej3yBE+Xx+GBCwGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(64756008)(71200400001)(66446008)(54906003)(86362001)(66476007)(186003)(76116006)(83380400001)(5660300002)(66556008)(6506007)(53546011)(110136005)(8676002)(66946007)(26005)(52536014)(478600001)(4326008)(55016002)(9686003)(33656002)(2906002)(7696005)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GVcwwV9Fmqmxm9zefniI1jalBMpG+sNPeu2Jpn8gCk+Sf9QE8qJ1xdO0XB4t?=
 =?us-ascii?Q?aQCgEGR1wBVM8+7i13OZasTtmFlpxXXtSiTgpJHydi8WJlSpZKGkesiL23u4?=
 =?us-ascii?Q?7Ca0B298gmiTYSdZWL5pqfSgA77JMK5VZdr0tBPtpnWJP9an4hkXnH2yubJh?=
 =?us-ascii?Q?Yr1EJ6QYoinvoL1AnZ48G1avmLEQEMxWv2C0IyoMKjauBde3MoWLUHFqigOW?=
 =?us-ascii?Q?lKNoRiu6OwMc4L5AKWDaD0ts5EZsQPvnGq2EhVx51nGT94wLBftjzUQSAQcf?=
 =?us-ascii?Q?WAQl4FAsxRdm4Q0VSATzt/F+DaMy//qpILovyB+x3PqwjT0qCfVymyWTPhTA?=
 =?us-ascii?Q?FZgGne4PAeail0gKaDk9A4jNKwYxkr+wnQY0Cni8C/Y5+NLEduuG7th8zzZQ?=
 =?us-ascii?Q?KwFzPWgfXIXgXDQFkGpC3fcq6T9S996uomC7GYG78L52v68bcsR17i+RZIZO?=
 =?us-ascii?Q?AsRduH60qcM1QkSCX9M9AGbLjrpZxZ+FZwXZmXpRg3Ex+x6eSwcRWCI1tSuH?=
 =?us-ascii?Q?NwVBPITkaNRGnX0ciBLr5iPdbW1xkXk0JhatgdnNzQrBxuCLykQGdydY2g7O?=
 =?us-ascii?Q?omGIMW2p3+Hf/bpwAIOj1JyeOl5mjlbS/iuJDQ8Llz8Bh1lVv6o7SF71M2YE?=
 =?us-ascii?Q?zhdXwlpmXGz9duXcCJmNuUNNoxlrIUm1qRy7pygQxHLfOBk1mmXdjyzS5f7x?=
 =?us-ascii?Q?CSeZLft5PK9oYGeU5ObbzqKOaxvICBzrzTl7RHSL5yeI7VWEsTskdYJsHWXr?=
 =?us-ascii?Q?WHyEKbBXY1lTb5uuzyTesMy/HaUdJitjth1bnvF22OesepxbwTFABLsAMbBk?=
 =?us-ascii?Q?AOv4Kq1HCviQZ4VGaXkdH/aLHOGCkXuuls9T5OnDga4IPVp3ToUZe1LYee6p?=
 =?us-ascii?Q?tmQ4b7fFHaQ3etQeBo/k+RCo3/OLtU4elZBo+vWjJSnCkYG2rJKwB6m89Vdj?=
 =?us-ascii?Q?FPgX3eagXCviub3ScRHpaE+ZmfyMkHVMAVXKCWjGtAk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a561c6-602f-47f0-0b7e-08d8a6842477
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 14:16:15.0003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kDV+or0j3KUr46vDUvDD2e11L5Kevwp2j6jlDaZI0diFYgl/3j+53RF0sNssJTl37jH11sL6aVeR3PB1dBnAbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4990
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Alexander Monakov <amonakov@ispras.ru>
> Sent: Sunday, December 20, 2020 4:12 PM
> To: platform-driver-x86@vger.kernel.org
> Cc: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; Hans de Goede
> <hdegoede@redhat.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org
> Subject: amd-pmc s2idle driver issues
>=20
> Hi folks,
>=20
> I've tried the "platform/x86: amd-pmc: Add AMD platform support for
> S2Idle"
> patch on my Acer Swift SF314-42 laptop (Renoir SoC, Ryzen 4500U CPU) and
> hit the following issues:
>=20
> 1. The driver doesn't bind to any device. It has the following binding ta=
ble:
>=20
> +static const struct acpi_device_id amd_pmc_acpi_ids[] =3D {
> +	{"AMDI0005", 0},
> +	{"AMD0004", 0},
> +	{ }
> +};
>=20
> This laptop has "AMD0005" instead. Adding it to the list allows the drive=
r to
> successfully probe.
>=20
> 2. The debugfs interface does not seem to be very helpful. It shows
>=20
> SMU FW Info: ffffffff
>=20
> It's not very informative. The code seems to be fetching SMU version from
> mmio, so I guess the file should be saying "FW version" rather than "FW
> Info", and then, I think version number is not supposed to be "-1".
>=20

Does your platform support modern standby?  You may have to select between =
legacy S3 and modern standby in the sbios.

>=20
> (and I'm afraid I cannot use the driver, as there seems to be an issue wi=
th
> GPU resume: sometimes the screen is frozen or black after resume, so I
> need to reboot the laptop :( )

We are still working through various platform specific sbios issues on some=
 renoir platforms.  We'll be sending out the appropriate quirks to handle t=
hem once we've sorted them all out.

Alex
