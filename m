Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7C2E0C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgLVPVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:21:05 -0500
Received: from mail-eopbgr700088.outbound.protection.outlook.com ([40.107.70.88]:5345
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbgLVPVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:21:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFpHuqDn6AQRNn2QlENioJrLYXpdm5VdbfzviXJo8Elrv/lNCxMNhRdGINGT91kmnAbg3keDi4GJ/4Wo7euH7a6ATwSlOJh4XCXki57szFjBIaFDNDN760UkD8iIlSoAgN/IMnosBinIZTl92irBbZAGtGX/6cI7dRLESsqbT5n/O89R8D+fps37KtavF31OlgEWVcgu6gkLyEC7mDXTVWnpnSy1bGB/BtrtNjSBdzEbfY+JRBekp7gfa6/pYX352JTSMCpXv4TgSYeW8Y18tA7nrqRB/PDTz4lJXAKlNkcuTKu5Ed83ajZB7N6y6yE+mwcoCDL8acto7TkUs+SWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyRRtmmzbWSNY8j1wB+fjcZrbd4pnGouhNOKmI5/St0=;
 b=SYjlrOV+twvcocBjLzFzvfEzuRcBcnht1zYroAPlw/xkwTRbHG/mnJhjE6eX9XqUTKSSRD//N85XSy/uMrgLBjknr5DMRjUakMgOeruGhnYg9J3Mvul7qZ9czuTPyrSAXfhUogGjeUGzqIrYqd+3EsXPZvGhTRisEqXxv87Zurm+7c4uei4XGWQUhbG/r3CF5hb/GjbyGTeKb7q8JKmXf1Iz2xjFjYA6f4RdNYnrItDCUhJoS2hzHW2sWoX01vFneGUmxk7hS4EPhVHcDqOsWcQ7lFFAJugVxVdouwRk1c7E1hdNAgHypAaPUd0S4dQW7xXHN64tL2/xptqIcKCP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyRRtmmzbWSNY8j1wB+fjcZrbd4pnGouhNOKmI5/St0=;
 b=NQB/r31G2T+Ema7UekXq2Pg5t1rTGHJMBommVfPKIoz1lK24KEuavp0iN0qCyd+RaHQDQN2sfSg0HoIW+YcQuD8U1p54FuTId0ZLIZDC7BTHl3Q2leS95fLUEe8ljY1/0gYeKdmWSWFZmg52S2OAIuXnmN/hBCbQ6eT+JY4doaM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4584.namprd12.prod.outlook.com (2603:10b6:208:24e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Tue, 22 Dec
 2020 15:20:15 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%4]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 15:20:15 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Alexander Monakov <amonakov@ispras.ru>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: amd-pmc s2idle driver issues
Thread-Topic: amd-pmc s2idle driver issues
Thread-Index: AQHW1xTQl60Nyywz90OztdBJHGRZvKoDKnNAgAAJj4CAAAlawA==
Date:   Tue, 22 Dec 2020 15:20:15 +0000
Message-ID: <MN2PR12MB4488CC1657EAEAB16886A200F7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <alpine.LNX.2.20.13.2012202341520.6949@monopod.intra.ispras.ru>
  <MN2PR12MB448821DBD2DAA296FAE29A7AF7DF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <alpine.LNX.2.20.13.2012221720290.10565@monopod.intra.ispras.ru>
In-Reply-To: <alpine.LNX.2.20.13.2012221720290.10565@monopod.intra.ispras.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-22T15:20:08Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=dbafa946-4ff6-45e4-a1f8-00005d17d23a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-12-22T15:20:02Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9ae034d0-cc4c-46c5-a08e-0000848201b2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-22T15:20:12Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 3994bca6-7fde-4812-9d7c-0000dcb0d8c1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: ispras.ru; dkim=none (message not signed)
 header.d=none;ispras.ru; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3bcb46b-81ed-4900-e64c-08d8a68d1569
x-ms-traffictypediagnostic: MN2PR12MB4584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4584E17EF0D311FEB7F1AF59F7DF0@MN2PR12MB4584.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vttr9gtGjyruLqfI0YOIgZTAMcrJAtWopK1eWmQJYOfjd70q6ASVqav3DvYzjn5yHgmHrP3vwQDWTxfUFYBtFXhbaNtGPLV32UMA4029M0dY0EcT+homUgMYVfbpVfN1pQP8M09TlaXtSWNKrCehRcWQQedmJsostxyyqTVxGw2aWZzm5/CDXNTvE49VfOLoziSGGoTKkDyuLFeNuDqr6e+DO/SzvTKKmqrc/xU7lUi3TGjN4AalNXzdnl8HUCIil5XlAEJK4/J9wazbRlIQvYALkR3LNjFJq3MgghS8aGt4dSdM06E3QU+Jvr14d0DqadMmetd4VOT7Z+yOqI+1f1W11OYnphC1t5n6YPMqpTQybSLeurLDaXsSpT1Y8OPRY5xz9nr5VccGTctAs+kuSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6506007)(76116006)(53546011)(66556008)(478600001)(66476007)(7696005)(54906003)(55016002)(64756008)(5660300002)(8936002)(26005)(66446008)(8676002)(86362001)(2906002)(9686003)(66946007)(52536014)(316002)(71200400001)(33656002)(83380400001)(6916009)(4326008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tmVhD/WeVBYi8zLzjA30FwQRrcRaPqKTuZHI+UeUPi4Cu4IqnxhkLRNO2BIP?=
 =?us-ascii?Q?v0nQqT3EWTlYguykksLwPQmiXCj7OZ9ylyL0MwKaugsoJbbCtzzuL0nEPZ7I?=
 =?us-ascii?Q?rmuBkUoy2PfLkctQFwYisS6qNn5QmHc/J/JEpAxwFYHq6psLxMayNiWK1MIB?=
 =?us-ascii?Q?F/+I4xJdwN+FV6EGYxanfDeYI087BL7zliq9YGgdocVwg/DW1DEysF5rpjxZ?=
 =?us-ascii?Q?fQuh46LF2Qv8Ytp2JY3CJqcinjNhgxiTV2BPb7BtGfTbJBh5f7Smmh6zYYvc?=
 =?us-ascii?Q?6LXXY2QQ6pswJi7FZqQ5yEuo+OpYEDMNDpaEAhoBqKFN8DF/YCBI1PK505RZ?=
 =?us-ascii?Q?9bTQMhkYe+9Y8PIUOIfuCriRj8X+T2Htn+jCUkWUXkqALFwjra0e20YIq/i7?=
 =?us-ascii?Q?smrPzIa49JHVmjuR5nqcJjmjmdnyQBj11Si6OoYWS8Yyxa7tJmw62KfrMcYE?=
 =?us-ascii?Q?cQcTKck9e+8BDYsVmvxh9jnrssl4lBYBX6Ozv2wfxDSc3SiRnnGESaa/Z28T?=
 =?us-ascii?Q?5zuuqXjzt3KaAv5on4dyDCewO1GWZV9zQSMow8dXhGFFOyzFYFaXukC2psNa?=
 =?us-ascii?Q?pnYDH6zYpzv1gJg/l5zfCtbWPW1zWAD9UEp8osOyzkhHUVRKrBwlFp9UF71l?=
 =?us-ascii?Q?4BWPJAQHHP1XF8IxTsAFemECK7yc3Q+hJeNf4MoWUQ1kaNNY05fmPBfSRe6R?=
 =?us-ascii?Q?u0gfamJB78M99oL1kp8r31leJdwMY49rJ75QKYqw0k8eOpzGf7Bx0VMzATxY?=
 =?us-ascii?Q?+fN/McOxix0CDixUwPuRjz4Y/75t9L2/mH4LkF+mvYky/K5+3qVIbjTwLIl2?=
 =?us-ascii?Q?+1AC/Xvjgqm0qv7nJUEVgi23WyV/OkNuSJKVLHmcV7HahEALigBwKbMtDh+k?=
 =?us-ascii?Q?wOThP/1S9LYWcK8REt9fJ1zsSROAF3I7+GVqTTO/LQk07LPJD2sbJ/liY7b3?=
 =?us-ascii?Q?XRMoD+5KdOP6u+CpnA1hSQqg7YM5hQPqAjrkHuPz4FA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3bcb46b-81ed-4900-e64c-08d8a68d1569
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 15:20:15.0994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nCBGli95K1vHZt3FhMsouR4IPAS90Dn5+rhH2nAMJ/85qyjqEoNufUV+g2kNW0ZOkKXqBKCVQxP4nXawDUg/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4584
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Alexander Monakov <amonakov@ispras.ru>
> Sent: Tuesday, December 22, 2020 9:45 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: platform-driver-x86@vger.kernel.org; S-k, Shyam-sundar <Shyam-
> sundar.S-k@amd.com>; Hans de Goede <hdegoede@redhat.com>; linux-
> kernel@vger.kernel.org
> Subject: RE: amd-pmc s2idle driver issues
>=20
> On Tue, 22 Dec 2020, Deucher, Alexander wrote:
>=20
> > > I've tried the "platform/x86: amd-pmc: Add AMD platform support for
> > > S2Idle"
> > > patch on my Acer Swift SF314-42 laptop (Renoir SoC, Ryzen 4500U CPU)
> > > and hit the following issues:
> > >
> > > 1. The driver doesn't bind to any device. It has the following bindin=
g table:
> > >
> > > +static const struct acpi_device_id amd_pmc_acpi_ids[] =3D {
> > > +	{"AMDI0005", 0},
> > > +	{"AMD0004", 0},
> > > +	{ }
> > > +};
> > >
> > > This laptop has "AMD0005" instead. Adding it to the list allows the
> > > driver to successfully probe.
> > >
> > > 2. The debugfs interface does not seem to be very helpful. It shows
> > >
> > > SMU FW Info: ffffffff
> > >
> > > It's not very informative. The code seems to be fetching SMU version
> > > from mmio, so I guess the file should be saying "FW version" rather
> > > than "FW Info", and then, I think version number is not supposed to b=
e "-
> 1".
> > >
> >
> > Does your platform support modern standby?  You may have to select
> > between legacy S3 and modern standby in the sbios.
>=20
> Yes. Out-of-the-box it's a "modern standby" laptop. There's a "hidden"
> bios menu with extra settings that apparently allows to select legacy S3.
> I did not change it, so I'm testing the "modern" mode.
>=20
> Note that this driver fetches SMU version from MMIO, which looks odd to
> me:
> elsewhere (i.e. in the amdgpu driver) SMU version is retrieved by issuing=
 the
> corresponding SMU command, as far as I can tell.

There are multiple interfaces to the SMU. It's shared by the entire SoC on =
APUs.

Alex
