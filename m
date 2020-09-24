Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0227765F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIXQPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:15:09 -0400
Received: from mail-dm6nam11on2122.outbound.protection.outlook.com ([40.107.223.122]:23681
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbgIXQPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2dmAp6+xOOW6jUUIdRFCzsCJs/uLpVA4lPdu+UqCQGsM8/zqpsouGqJ5kY7AGvxT75KfS9/E9UNzXSBWf9CGD9HhR97+W4nJsVFR037PfcHYXe4fmetZGsfUNloJAbOraBWVW2ySkEQr5sQp4vwHvP+c4N6EHkAcg+bUGk41R8xiCS+fQFLR5wbyOEiVkVksRQNj58h80tqzgOl/ox8w6xECXQfpCjlAxa0ztEBbNFApnQMtjkbVlARpqEq1dGB5uauvmgMYRlo0e9GssJ/qjyI8t/N1LXkRsGy1VWbkEAASYf4VGmZP1SxKfpOOlc+Tbwz3lbDI/YN6ARP9i4A5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEO2RktgJe+zmYpk68YYJqTd4vkL+eRbpFTZnFrxcVQ=;
 b=Zs1zl9nBWe+3pbYmUoOWQlM4E92fOuadS9HwAuDjltlgO1W1FqnjT813h1zOzhM9cHFNJRQSvAfzArcBmQURiEXGutinxKERxWqmZcswPXMU98SosiMzdwSiJWEGMvtkRI3IGTcwHT1TsnQJ8F/hG4VdZ5DylYfIei/PM8AOZvQFqzGV3ShDYL2aw3iadt0p2j3SsS0yY2T7RGPvffejJpqHg7tz66Dm8m6I2rfmHfvJPRKaIblA85vJNLG6hnPKBMavIHVnMOJNiHjgYaI9tQeHyMXFuFwPKbf5MJsrDxNMXGdHCOcC9bepdXUJdXljTGSHfBT2rqIakORLw1wD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEO2RktgJe+zmYpk68YYJqTd4vkL+eRbpFTZnFrxcVQ=;
 b=BfcEQbw8o5Zdfp3+esSjjyaCGWKx42QhJpbdp1W1n1AZjgwvPPIXet+cKi64OGUlzK9BSoTlqCKSI705feDnMmTK7x5m7MKn33+jnJHtQVNWkb8zihoNayUN1D27KAIFCrCXn8WQGkKKKiCkm5O2MvIhvFz/JKviiAGLdsARlWs=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR2101MB0811.namprd21.prod.outlook.com (2603:10b6:301:7b::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.1; Thu, 24 Sep
 2020 16:15:03 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%4]) with mapi id 15.20.3412.016; Thu, 24 Sep 2020
 16:15:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dave Young <dyoung@redhat.com>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH] Only allow to set crash_kexec_post_notifiers on boot time
Thread-Topic: [PATCH] Only allow to set crash_kexec_post_notifiers on boot
 time
Thread-Index: AQHWjWt1j9ACvI5nEEKX++S5B3a5m6lvIiCAgARrsQCAAGirnIABlVCAgADbToCAAZcR8A==
Date:   Thu, 24 Sep 2020 16:15:03 +0000
Message-ID: <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
 <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
 <20200921201811.GB3437@char.us.oracle.com>
 <87v9g6fuub.fsf@x220.int.ebiederm.org>
 <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
 <20200923154825.GC7635@char.us.oracle.com>
In-Reply-To: <20200923154825.GC7635@char.us.oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-24T16:15:01Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a21cd3c5-c4ca-4397-9988-29081e0b2680;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75db945e-6021-4266-321e-08d860a4fe72
x-ms-traffictypediagnostic: MWHPR2101MB0811:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB08115F96E743C944AFEB6835D7390@MWHPR2101MB0811.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6GBSm6iVhe8uUi+4iAbsM/Dj1BbWVexpjwQcehC5qx7ucQhRSOwP0fhR1XG2ug55F7Tb96SrkFcBITG6khGfjf0r1NCIUzO8mubIzLITdWgrvGvCmuKPijxwaDKYY/Vcxi2pN4sXZlsKESwTDQFInLDRdYnbwt+PN1pueMFWVoPYUoKVzi+lKDTtl6gT+pEO//gArVvSoj/wC6p7FIPhGml2kZ7flP0z9JZ7nEnX+uQXJzrfE1JdcnqNKOABO1CX/9Wu5ScYoXCpWHhzFwnfF+vQQxaftOAMxJFJb5e9JCPBerJKu0Z82JwJkpUIxBmFg8dQGgtaW+yT9l89BqYs4As6QrbetZg2jFK/99uL+Fstv5yKpSM7JPyHLPyKMS87WaNc9ASk1XLAHPu+P1JgH88q39klHo0uuWR6nUh/lTCUc1x/sS30Jo6HE+nCEhpFmBYEOO6Eh9XzIgaWZbGU+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(82950400001)(316002)(66556008)(186003)(76116006)(33656002)(55016002)(66446008)(26005)(966005)(8936002)(64756008)(7696005)(66476007)(6506007)(4326008)(8990500004)(110136005)(82960400001)(9686003)(71200400001)(52536014)(5660300002)(7416002)(2906002)(66946007)(86362001)(83380400001)(54906003)(10290500003)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5RXbR3nCfcsqLyDfEOoXoHZizK+QjpJznMWrIT2Wd36TDmYdjTLbomz8jrqvMnnoEtMxI7DemXyPHH87VzDqiOENAIec5WOqwR/X4uwaUi5WMLsf02wm3DP54vTrPXHER2dozyLPVZNXSOHZ1Su/mqBhCVpcHJs075G2/UhbVbHNwMuKDWnOrfAksCZxjIey2JNgSma4W+bOzrwV9fa2aE4AD+xP2l+pNGbHKoKDSj9S4MyTxgzcwco7EHqrKdarGQxzBk0gpVgBwXt2YAptSvs4CbH0cc6f35E7/60m7ui7IvtNhwGnUdtGXxkjDhQFFlyv2dYvP2Q/E0+LpCQ7zgFGlyyTmNhN6AzSWZ9Y/EeN4ToXYPn0+ycMaKGuI4tfUv9uxQsTXKoej2mlLYmqzIVuFwQy9D/NZfGMXGawtEL7l63J2zhsyBOXKALDvnX3Tzcn4DHXIxme1vCrVX7xfEQUbR726FYeJ1S8x+mPrbdgY1uM/WLH7iAGcb/d2iz+kKlSBDvxlqz+4T2iDB1qUb8oLDnUPouAn6BYCmA/QDSZUoY9G8AUerVIwy6ztkpDtjJ8zb3GCqpUtQRI2ehjbJ/5L7ec4JjakLjqt3NzS9LgZzA1fwYWbOG82ojfeL0oixWW/JK6jXiBezl826Femg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75db945e-6021-4266-321e-08d860a4fe72
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 16:15:03.1485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAgX2JtlU0jL5S0rZUr+a1tfYMB9ozRN1Iu3KadiBUyf5MlGlvIsXjE1K0oWOZ4DW9xohZq49YQp11gbvwP6OSkgFQcFIBd4UbmYinMcaXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0811
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> Sent: Wednesday, Septe=
mber 23, 2020 8:48 AM
>=20
> On Wed, Sep 23, 2020 at 10:43:29AM +0800, Dave Young wrote:
> > + more people who may care about this param
>=20
> Paarty time!!
>=20
> (See below, didn't snip any comments)
> > On 09/21/20 at 08:45pm, Eric W. Biederman wrote:
> > > Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> writes:
> > >
> > > > On Fri, Sep 18, 2020 at 05:47:43PM -0700, Andrew Morton wrote:
> > > >> On Fri, 18 Sep 2020 11:25:46 +0800 Dave Young <dyoung@redhat.com> =
wrote:
> > > >>
> > > >> > crash_kexec_post_notifiers enables running various panic notifie=
r
> > > >> > before kdump kernel booting. This increases risks of kdump failu=
re.
> > > >> > It is well documented in kernel-parameters.txt. We do not sugges=
t
> > > >> > people to enable it together with kdump unless he/she is really =
sure.
> > > >> > This is also not suggested to be enabled by default when users a=
re
> > > >> > not aware in distributions.
> > > >> >
> > > >> > But unfortunately it is enabled by default in systemd, see below
> > > >> > discussions in a systemd report, we can not convince systemd to =
change
> > > >> > it:
> > > >> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Fsyst
> emd%2Fsystemd%2Fissues%2F16661&amp;data=3D02%7C01%7Cmikelley%40microsoft.=
com%
> 7C3631bae06f7147c0f92908d85fd7f2b2%7C72f988bf86f141af91ab2d7cd011db47%7C1=
%7C0%
> 7C637364728378052956&amp;sdata=3D9CUpPUxcKLLggbJ1bjubBjbFUAhPVeZhIc4yss8w=
AiU%3
> D&amp;reserved=3D0
> > > >> >
> > > >> > Actually we have got reports about kdump kernel hangs in both s3=
90x
> > > >> > and powerpcle cases caused by the systemd change,  also some x86=
 cases
> > > >> > could also be caused by the same (although that is in Hyper-V co=
de
> > > >> > instead of systemd, that need to be addressed separately).
> > > >
> > > > Perhaps it may be better to fix the issus on s390x and PowerPC as w=
ell?
> > > >
> > > >> >
> > > >> > Thus to avoid the auto enablement here just disable the param wr=
itable
> > > >> > permission in sysfs.
> > > >> >
> > > >>
> > > >> Well.  I don't think this is at all a desirable way of resolving a
> > > >> disagreement with the systemd developers
> > > >>
> > > >> At the above github address I'm seeing "ryncsn added a commit to
> > > >> ryncsn/systemd that referenced this issue 9 days ago", "pstore: do=
n't
> > > >> enable crash_kexec_post_notifiers by default".  So didn't that add=
ress
> > > >> the issue?
> > > >
> > > > It does in systemd, but there is a strong interest in making this o=
n
> > > > by default.
> > >
> > > There is also a strong interest in removing this code entirely from t=
he
> > > kernel.
> >
> > Added Hyper-V people and people who created the param, it is below
> > commit, I also want to remove it if possible, let's see how people
> > think, but the least way should be to disable the auto setting in both =
systemd
> > and kernel:

Hyper-V uses a notifier to inform the host system that a Linux VM has
panic'ed.  Informing the host is particularly important in a public cloud
such as Azure so that the cloud software can alert the customer, and can
track cloud-wide reliability statistics.   Whether a kdump is taken is cont=
rolled
entirely by the customer and how he configures the VM, and we want
the host to be informed either way.

Michael

> >
> >     commit f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45
> >     Author: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> >     Date:   Fri Jun 6 14:37:07 2014 -0700
> >
> >         kernel/panic.c: add "crash_kexec_post_notifiers" option for kdu=
mp after
> panic_notifers
> >
> >         Add a "crash_kexec_post_notifiers" boot option to run kdump aft=
er
> >         running panic_notifiers and dump kmsg.  This can help rare situ=
ations
> >         where kdump fails because of unstable crashed kernel or hardwar=
e failure
> >         (memory corruption on critical data/code), or the 2nd kernel is=
 already
> >         broken by the 1st kernel (it's a broken behavior, but who can g=
uarantee
> >         that the "crashed" kernel works correctly?).
> >
> >         Usage: add "crash_kexec_post_notifiers" to kernel boot option.
> >
> >         Note that this actually increases risks of the failure of kdump=
.  This
> >         option should be set only if you worry about the rare case of k=
dump
> >         failure rather than increasing the chance of success.
>=20
>=20
> If this is such risky knob that leads to bugs where folks are backing awa=
y
> from with disgust in their faces - then perhaps the only way to go about
> this is - limit the exposure to known working situations on firmware
> that we can control?
>=20
> That is enable only a subset of post notifiers which determine if they
> are OK running if the conditions are blessed?
>=20
> I think that would satisfy the conditions where you have to to deal with =
unsavory
> bugs that end up on your plate - and aren't fun because there is no
> way to fixing it -  but at the same time allowing multiple ways to save t=
he crash?
>=20
> Please don't take away something that is quite useful in the field. Can w=
e
> hammer out something that will remove your pain points?
> >
> > >
> > > This failure is a case in point.
> > >
> > > I think I am at my I told you so point.  This is what all of the test=
ing
> > > over all the years has said.  Leaving functionality to the peculiarit=
ies
> > > of firmware when you don't have to, and can actually control what is
> > > going on doesn't work.
> > >
> > > Eric
> > >
> > >
> >
> > Thanks
> > Dave
> >
