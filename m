Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5092E0D81
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 17:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgLVQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 11:45:51 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:18176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727201AbgLVQpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 11:45:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFHKQ+zuIB9UO8LqRN8cdSqpHZ87klET6gcsNywrrfcbHYBD6vnUXsZl9t4rD+IlzY/HK/ZVtTU3cubZ1jGrzKNv1hVCSslOL4BwbL0OjELGO6Z8H0/JY6E+Zhu+rOdaD2qB5ZU6tUdr/QR0TMEgoKfQ0suBcI4izPOnzkfKoXIENzLtI2XmUIwNcKfQjaKUVvWLLN/8GGBoF+R+hk4XxL3srVzb1/mPvhxfUvNmoLUdxBDdkt5AJuh9ZL46TakmI2nqVy5CKy2nkkBfHHHHlQKsVG21zF3G/Zcq67a/Ah2NSwQUJueK7hyTkJMr939scvIm0tENJVhereQrrCQllQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVErv/2WC3keLdSMTu3AJu+WyF2MfteHtPqpl6BJKeY=;
 b=mXTJHiYRe04hPZl2F0dirXRDJXViUgi8iKqP9VoPoX0BuRaHqYz16DiM6iuWdxp73G30OLsj68sVc8KvhNxS3VJL3lJ1NA7YaIG7Nmgus1NRlcTEbZyINk+MRdznUO1OFmniIEDHfoINOLqLc+LjK2P89GwWhrILIbnj6vIbqBiYZDSwUg0AY8lngoOxqW1xQ/fI7yInHFlMaIrJ04uFLi7QENWoS6oLyH5+N8HpOUeb3/nAhJzHULZaNZ4M22fd6M9SOY1TWUZW9FJxbhAfVbNVP4hSq3d6IUeRpbaUtzxmsTiUGxWn7uXyYM8OyeunsUm5GdzwEncTVcJeorJrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVErv/2WC3keLdSMTu3AJu+WyF2MfteHtPqpl6BJKeY=;
 b=hl6+KAXx9rPA0EiaTbCmxcI5JoCDOOMhzzpZMjWQhv+IrZI3N+txC0loT36CBcBMNDCnEYnKiM2PGDm5qDDWkQaLChEMdjlgXDEEJ3gfvn9rwBOlBbPuo7veV1Wt9EvqLHn++4bWysZcJuZG11bte+2Wzuin2wzveovUwmVdoZA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Tue, 22 Dec
 2020 16:44:56 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%4]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 16:44:56 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Alexander Monakov <amonakov@ispras.ru>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: amd-pmc s2idle driver issues
Thread-Topic: amd-pmc s2idle driver issues
Thread-Index: AQHW1xTQl60Nyywz90OztdBJHGRZvKoDKnNAgAAJj4CAAAlawIAACraAgAAL+yA=
Date:   Tue, 22 Dec 2020 16:44:56 +0000
Message-ID: <MN2PR12MB44884E97C8F01FA474C74F72F7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <alpine.LNX.2.20.13.2012202341520.6949@monopod.intra.ispras.ru>
  <MN2PR12MB448821DBD2DAA296FAE29A7AF7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <alpine.LNX.2.20.13.2012221720290.10565@monopod.intra.ispras.ru>
  <MN2PR12MB4488CC1657EAEAB16886A200F7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <alpine.LNX.2.20.13.2012221834180.10565@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2012221834180.10565@monopod.intra.ispras.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-22T16:44:50Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6286432e-22e3-4fd2-9852-00005b747b7f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-22T16:44:46Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: b22546ca-c625-4254-9fff-0000767c5ed6
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-22T16:44:52Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f2d62204-4e31-4104-9b77-0000fa18d80d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: ispras.ru; dkim=none (message not signed)
 header.d=none;ispras.ru; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27cabe7a-6791-4534-2155-08d8a698e9ef
x-ms-traffictypediagnostic: MN2PR12MB4453:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB44538D1D9F34490FC1F92389F7DF0@MN2PR12MB4453.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhvFueeKY3J0KSD3U9Wr5kcjfmfspwGSTG86aFfwCSqKbOL0QrbDthzLQ36pEZekwWH2B9kvOvnXew5cjFUMHbxxN8zeOh0efn7iFpgTbLLtvBEBV8sfXofBagS361g7BOQmpLcN4K8CJ8BP0/Pbk0uCroJ3T0Jtqtl5VUsRqBa09p3YYW9WQWUK/YkxB1QokUntL9ID75rzgkG3XsmMJyfZzQf+kgHedsxcgidGuzQcvKxgQqV/bNYM+z3gLZcStfd+0o80ayFUnzRY41qmhKijENjZsVKYHqJkznTNVnwwXzuzR/gZXVOlNUpLmIDYkMs7pzIfZ1tyOw4r4lYqs1u1B4sR7VywDl/Op7vrsbXvGrE03VdXWYAjSenZztTH1qbXw8vrE2oVX4LImdHn5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(5660300002)(26005)(33656002)(8936002)(71200400001)(66946007)(478600001)(186003)(52536014)(86362001)(6506007)(316002)(54906003)(4326008)(76116006)(64756008)(6916009)(53546011)(83380400001)(8676002)(7696005)(66446008)(55016002)(2906002)(9686003)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1tY6zcRbYB6xXo+jSzjupbgRWD+7Pxz97M6xX1GFowzc8H3Y0M8VdGu+Wx+p?=
 =?us-ascii?Q?SMemaFAS2BguWdn/RhKFXOZx1U1EqRTjgsGhFVIYfb2icxWTxFi7zgkN+lbH?=
 =?us-ascii?Q?fiR1EQBsOFbObtA05fqubNersshHmpot9Oyi435u1cSgFlO1cBnC+yBKu9yT?=
 =?us-ascii?Q?E2EmhYcBEULk9ry+cUteVJepc6Sf0Id86MUEu4y6v7qFDw6NgoxA3iiXZ6V8?=
 =?us-ascii?Q?UUh+vZklhyQa+koMYYL9+K65leNXygknoy7ZKmj4ABR3glGwki3yXDAjExDZ?=
 =?us-ascii?Q?rVpffbU0DyDVxniQIl5AHSdwn4gFTNHJLQNBxNMp4RghPVXj99l9ThwsJ/Iz?=
 =?us-ascii?Q?wd5Mkz4w6UJSfF8LMftT2VtQLWogFA9531tpIk5r4liWayI34F6SwZtBP5Lh?=
 =?us-ascii?Q?l8p4r9daG3a2sPFRfY2Qqp/ANUB1obHGVcdkXWhkUtZ8N2QImd4ApNd8NjWk?=
 =?us-ascii?Q?OCJk1v1ADGkTDytpXOw8saSvWBj3G4W3sqpcPnUoT4xXv3GITMqCjR/t3w5G?=
 =?us-ascii?Q?9zUsS7q89YI+kZwsPeu66VJb7edr8FhmQv8ungQW6hRuzJRxUBzVKJ9zOJop?=
 =?us-ascii?Q?YPM9UFivSvSkK/UEI0Hou8T0KtJmftZYxauaOc8J/bz93mJD0B87yRN7SfAd?=
 =?us-ascii?Q?scAoTCPjI22S53fRr6kTSGdrsrfGYGkoq4sABdSsaGqq11a34apT7UBiwL6K?=
 =?us-ascii?Q?OrkCTnyDNIYMMG7F9FLzzpETCvNpe7bpwVdkgJwqY+GpKsByfxYMf7dsYXCB?=
 =?us-ascii?Q?LmEimdHIF0wXwPZdnWwhD3XhIyb1Tuf2zw3hymDDejkqp7dEYwbi8UqzOffl?=
 =?us-ascii?Q?IVCMh8Lt2ZKr7h/CcDROjrhQUipefkB0GEbyDO0LKjMdj5gEEBjb18VsUlAE?=
 =?us-ascii?Q?W+q4a7e5quYu0eg9dQXpyDkyecVaJxikFQsfm9k/E3RiFIDtiq1Zf4T60KIO?=
 =?us-ascii?Q?LuTtJKAJ66g32RIYeSYN6xQ5UThErzBNnwGHhN3tDwY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cabe7a-6791-4534-2155-08d8a698e9ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 16:44:56.2250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LulMEVSyA/Za21UdeFe9ZQGL2MoLsIBB9sHW4AqSy/Kk4HfPRmW3DvU8A/SlDJq6HnyaK/skxjQ5BPYlZtR1hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Alexander Monakov <amonakov@ispras.ru>
> Sent: Tuesday, December 22, 2020 10:57 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: platform-driver-x86@vger.kernel.org; S-k, Shyam-sundar <Shyam-
> sundar.S-k@amd.com>; Hans de Goede <hdegoede@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: RE: amd-pmc s2idle driver issues
>=20
> On Tue, 22 Dec 2020, Deucher, Alexander wrote:
>=20
> > > Yes. Out-of-the-box it's a "modern standby" laptop. There's a "hidden=
"
> > > bios menu with extra settings that apparently allows to select legacy=
 S3.
> > > I did not change it, so I'm testing the "modern" mode.
> > >
> > > Note that this driver fetches SMU version from MMIO, which looks odd
> > > to
> > > me:
> > > elsewhere (i.e. in the amdgpu driver) SMU version is retrieved by
> > > issuing the corresponding SMU command, as far as I can tell.
> >
> > There are multiple interfaces to the SMU. It's shared by the entire
> > SoC on APUs.
>=20
> Just pointing that out because evidently this interface does not work on =
this
> laptop, producing all-ones instead of something resembling a version
> number.
>=20
> Which APU generations does this driver support? If it does not support
> Renoir
> (yet?) it should be documented in the Kconfig text. Is Renoir support rel=
ated
> to missing AMD0005 ACPI id binding, and borked version number info?

The current code supports both Raven/Picasso and Renoir parts. At least som=
e Renoir parts are supported as that is what we are mainly testing now.  I'=
m not sure why some boards have AMDI0005 vs AMD0005. We'll have to check wi=
th the sbios or windows teams.

Alex
