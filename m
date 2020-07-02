Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AAB21297C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgGBQat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 12:30:49 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:13403
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbgGBQas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:30:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQBEkblqroD1XXFXcwKy4YyPVi+QO/FHBKYDQHvwJfoA2Um5znKSC7UXYRTkcCLeNrK+PrKOwCVtySEqLZFT4JCVZI5U032zB2LzmoFabGI4ZT2kP+NUZSHE6FFRXlV2VBBrweFlO0fwNme9jSNLtVtiq6HaKu50wVsVNISnhpT4v7DR8iywcH5oiy8iySxwAhFVzmokORMJsaQZX0QdNLXbDUifS/iGJSxES2GH41+jTvZb/HUhr71TDrDcPJAXXH0CQXLqk3Fu/d4FKQ/G3uSlbrBNGWshEmZT+AZJvFqAQvjtLz7UdbWaM8Twyc/7yBSHLQKtppfGhhgFK0d6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cil52EFTTwv0/zYTChIp5zXC4T/s8NuzjCfQeqiTBY=;
 b=b6llHUW80arch6zDRfQxR92FtzKoAsckyEUNZUfuprkElKiC1VeeGLcbSZJ6ighW4MucJcpJMLy0YzjgeLRkbSBnnzWg5Dqpc4T1jTFR25mIOzcJmbgE2gf8jM5K+LGUrAZY3OnTqcCKPWEaDMODVs2aANWeMH31w9YSJ1Ihz8VwMmY71RPH9ccNBXfO7JkCHm2xb16OAmDjy22VMS5WfRCmXi5DUwxCgD6aLOyencgxhn7k2BydfjrZdbnJnqGwfPoGl7pP9nYB7HtDVP/6BHB60LNIg+vfX0YiGX4lA+7aMVtTYLA0EFZPz9DDjuRZ7IEwsVGbwAhkLbw/GBzuLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cil52EFTTwv0/zYTChIp5zXC4T/s8NuzjCfQeqiTBY=;
 b=loyfcdstXasUTQFb4kFI7f6XbjfHcFHTZ7K8iUSb5mAjw2o9F2/AciE9K6YDuEjVNNYpSvew2do7+/+s9vpJi+qkqV2Cp4RxZ8+x4MUtONxZZWClHJ+5HRbascDPEaFYs8ojF4L9H9qDrb1ZrFKpUDiVVFohkNnQKkRXMHGF3WA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2466.namprd12.prod.outlook.com (2603:10b6:207:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 16:30:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::313c:e4d2:7dd2:2d72%5]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 16:30:44 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joerg Roedel <jroedel@suse.de>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [BUG] "Pre-boot DMA Protection" makes AMDGPU stop working
Thread-Topic: [BUG] "Pre-boot DMA Protection" makes AMDGPU stop working
Thread-Index: AQHWUGjxeTZverwQ6kmRoYr5I/0L+qj0epvw
Date:   Thu, 2 Jul 2020 16:30:44 +0000
Message-ID: <MN2PR12MB448836EAEA1ECA6E821B8371F76D0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <546DB0FA-FDEB-4FD1-93CD-AA5474B5F0DD@canonical.com>
In-Reply-To: <546DB0FA-FDEB-4FD1-93CD-AA5474B5F0DD@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-02T16:30:31Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e9fd7d3d-5e4d-4a0b-8491-00004b81c784;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-02T16:30:16Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b7da02f8-d16a-4cfa-a54d-00003fc8024b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-02T16:30:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 7cdad949-d3b4-458a-bae0-00002d62403b
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc033e6a-607f-4b38-20e4-08d81ea544d4
x-ms-traffictypediagnostic: BL0PR12MB2466:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB24664589C282D0807F158EABF76D0@BL0PR12MB2466.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOB/BbU0ZeXXoaru/uCxSBQVX6NUWSPzeYl7Z1Ig0CePc4W5TLwqIHXaD0AEpmqLQCKZIQTda3n9iP3LJJ/vKLyWKvAqzuSsbcR1vdk4F9+1qgGagBXpjs3QNmJo3F+EbcRJsMg/PetaeYxhPa90ZSv0JtFRJGA+hLaw7pzTX5ppEecMCU0nt4KGwd10ddCU/PEAc6Cy8iP+57SLtZvHtAq7rhSNmFWU4ti6O33K4EGzybjELcupAgxY6RSGRBN7Py4CtTkValhLJPPysbAWnTsl6b+S8DRWBVQkMk4Ly+hVgPGSUzVO0qeap735rg01rJYHjz15i72k60U+z1YkKy7xZZyJmNdFWvGgMgMjcSOSqMKU2XYI8jsR6o+lU32wBZh4bU9FE53CmKtrz9bGeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(83380400001)(26005)(186003)(6636002)(4326008)(53546011)(6506007)(8676002)(7696005)(9686003)(83080400001)(5660300002)(55016002)(66556008)(66476007)(64756008)(76116006)(66946007)(66446008)(86362001)(45080400002)(52536014)(8936002)(966005)(33656002)(316002)(478600001)(54906003)(110136005)(2906002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8Ej4LWy3J6yhALO9XKKYOY4NWTuhSXdzcEjb3ZbHBNLFQQD9iC4B45q1FQlvmK4qcNpPcTpjsduZa8dPgj29caHe/jgwDE6bRv/il7zCSJ2TEkIcxGQyqOhe3bVdEQ4EkDf4YFGk4kMnHrSZh8oHDT7vuTqgTkkdgb/WxzSdkd7B8LPffg+pN6VRpvQ1MY405wTVD4DglP/0/ZzCOeyzaGNRwA2ORJzhP7uVITUIUaI1sqplt/Azufu4H+CyqylmLd/DUNydMBcHkdD9SB+RjB7TCu4mMOAapvMNChmIw9sYuUuUapMt4bn3SI4ZlffFW8PIZSpiQCGiUP5TlBOe9hoSU0dZVZaGN9YEK6EHjKW9dobJesSKw4DLoU6iQiRRW1BLXj6rUf+0haiQx+DtN9Y3A4Xzf1a5jF9dfZ+BtBBfELjDoViXhr84Mhu+BvrROZfKNuFwLq4Y6kGLQsCjJpfrsxnim9TFvZVaLxd7n/s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc033e6a-607f-4b38-20e4-08d81ea544d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 16:30:44.4810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9X5oBgo1tl/NJzdCBXVkKoF3LvZpaLU+tsWat2mED92ogjtXcy+NBaDZsJGYWbLmi2g8mn9K2GhJ0MCYCqJohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Thursday, July 2, 2020 8:04 AM
> To: Joerg Roedel <jroedel@suse.de>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>;
> iommu@lists.linux-foundation.org; open list <linux-kernel@vger.kernel.org=
>
> Subject: [BUG] "Pre-boot DMA Protection" makes AMDGPU stop working
>=20
> Hi,
>=20
> A more detailed bug report can be found at [1].
>=20
> I have a AMD Renoir system that can't enter graphical session because the=
re
> are many IOMMU splat.
>=20
> Alex suggested to disable "Pre-boot DMA Protection", I can confirm once i=
t's
> disabled, AMDGPU starts working with IOMMU enabled.
> So raise the issue here because I have no knowledge on how to reset the
> IOMMU.

+ Suravee

This is part of MS's Secure Core initiative.  We are investigating how to p=
roperly handle this properly on Linux.  Stay tuned.

Alex

>=20
> [1]
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2F-
> %2Fissues%2F1204&amp;data=3D02%7C01%7Calexander.deucher%40amd.com
> %7C60746a6fecf04a5e570908d81e8011c6%7C3dd8961fe4884e608e11a82d994
> e183d%7C0%7C0%7C637292882713301680&amp;sdata=3Dr6cj19Vc8N0%2FSmsb
> CAJva%2BabMD2b5r2lvPLIxZSacoY%3D&amp;reserved=3D0
>=20
> Kai-Heng
