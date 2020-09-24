Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29C927770B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgIXQnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:43:08 -0400
Received: from mail-bn7nam10on2100.outbound.protection.outlook.com ([40.107.92.100]:56609
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726645AbgIXQnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:43:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHNolpqStZeAmdJ3A0vIjygPryEJU4fyxRreBs14x/mYsTsfE1CPCOIOpNnKTLk25Pfb6YogXtpfkQvk6RyTuG2XoryySobFNSP1FhGwyRko80Rexz1NFHoRYt223lxzhfLBhfCqTc1DVlC9viEkIjXDyoWg8WmMvaHQ7BlnSfzQl6vm6+pjVzI2M6+7BdeoJ5hvUea5h6lBnutGsv0DwEoaP9tIDSTcU4LWXqMr2xHcLkQeUpdX9yT3LG9RFZQCAAteDFAhbLLfa2lJe8PXnFa33bpc71LVt4aBaMuExj8nq/NxpKRoyuJ1QswW19l2rm/7qiJ5yFJIvZY6t7L9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPShxtyh7cEfiboVtkmpnfrr4gAkAyKPJBupR7c2NgM=;
 b=OZ4tvcAYiQUgEKuwW/k5owVFCZQc5UkKr0WIpoMW8H6uc5f8CQgDDNUpv6uwHD6Q8eSdM4rBDphTwU0Wp/rjNHuHm/38mdfIT0nlK6TegzlyZT+lWIT0tAmY6KkFRG/+bTmjhgJkYW6wpp7H+Pl8wetd/iBI8r6PhunJk+XFdqrRMiXypJwohhtH67Av8MFgOPZFKpVW6Bu/IxTtItLHENExIon9ZXYGnTfATnAbrFQND8M7Yjh5XT1QPiyvuizoaj+MMOroYI5FovDGvHX2MLfSfstB9MvRAoziaEkY478D8wEUy3hbElH3C4jimmKz81znau2GWzzd8f8Cj+11EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPShxtyh7cEfiboVtkmpnfrr4gAkAyKPJBupR7c2NgM=;
 b=iZkv5VuiSIxWKr/iA7Vg4jhr21bcIyJ3t+lH1x4ckXjSAiTkcpBPnIp4cP0StYA6AcNtX4ZxngKx3eBKPVkcqJf46v3Sxmom66xH6dQWIc8tNUKyZi5FM74DFLisDjkMpPVUHeUao+DTaKWdDtJiTy9/86C0vh9m46IN67N/m3w=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MWHPR21MB0144.namprd21.prod.outlook.com (2603:10b6:300:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.1; Thu, 24 Sep
 2020 16:43:03 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::d00b:3909:23b:83f1%4]) with mapi id 15.20.3412.016; Thu, 24 Sep 2020
 16:43:03 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Dave Young <dyoung@redhat.com>,
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
Thread-Index: AQHWjWt1j9ACvI5nEEKX++S5B3a5m6lvIiCAgARrsQCAAGirnIABlVCAgADbToCAAZcR8IAABdcsgAAARZA=
Date:   Thu, 24 Sep 2020 16:43:03 +0000
Message-ID: <MW2PR2101MB1052ED1C8953135A58276F04D7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200918032546.GA4180@dhcp-128-65.nay.redhat.com>
        <20200918174743.0994c59f058451948837dcb6@linux-foundation.org>
        <20200921201811.GB3437@char.us.oracle.com>
        <87v9g6fuub.fsf@x220.int.ebiederm.org>
        <20200923024329.GB3642@dhcp-128-65.nay.redhat.com>
        <20200923154825.GC7635@char.us.oracle.com>
        <MW2PR2101MB10521373DD95F5AF014254DDD7390@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <874knndtvo.fsf@x220.int.ebiederm.org>
In-Reply-To: <874knndtvo.fsf@x220.int.ebiederm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-24T16:43:01Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ddc6a247-4359-4955-8272-cbd192be8f04;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: xmission.com; dkim=none (message not signed)
 header.d=none;xmission.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5b1fb6c0-1445-4271-8141-08d860a8e7fe
x-ms-traffictypediagnostic: MWHPR21MB0144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB01440A141BA61BCEA0A56AE8D7390@MWHPR21MB0144.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHPWKbqIaK3AJPaBXSf2wprIB6mpYx7fzXm2K9qsXzmJmg1CWx7aVnX4m9JykMr0HQvvxGtCoTFWOwpP1pDmxax+XEGBee732c8AtOsnYlS/f9H18TNhsHAVlDPosJIG7NadYAFtWGsvcC8K8agez8ohNK00rZpogQ4Wv8nhnLQpuIPfJ3aMQyJp5mpJDOurTXn8QMpakpAxaw3s70BpFX+x/tnet+eeSdHyvXmGLXD35VazgglOzQ/0qYWJ+oa8KOhBwp1vCt4mr58xwfKq5hROA8hhT+s+/Aw955Pmaqqb3W6w+z8KCLJ6pH0f1R+0LZoAZnk4w3jHRY/lk110i0Udwew8dzvXftBt/hUBa3Gjsru8tPyoPDDObMJJZBaa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(186003)(6506007)(8676002)(6916009)(76116006)(5660300002)(26005)(478600001)(82950400001)(82960400001)(54906003)(86362001)(316002)(66946007)(71200400001)(10290500003)(66556008)(8936002)(7696005)(66446008)(83380400001)(7416002)(33656002)(8990500004)(52536014)(4326008)(2906002)(55016002)(9686003)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yN7KmLBf8Iyr6eHZTLVjXyAa5agnbVDL/BL3S4VE/GG09Ehlaa2AcdvaQ5ET1VpkLoTQqbWN011KDJ3j4OCOAAR0O1KQdhTqDwIFEHijdgABsr4S8GwtAaW6N+iJiJeZhl67jaDnfiQJKltMSNCPQ3xaBMJtHOvo71xz7OrRMhgPFDQSJxKOgUHVvbU5B3qH1MiqLf8GGE9pZP3MuRuevRby4Ir+IlFNt6iK75HZZBFdharH15UFOzjbxlbdY3NiZlbiWlS2/25YlpCp8MW+0OCsVLuqXwcwDeGcBioX+1vH6YdsJp+CefLanxGrgxJA9tcqsxTz3RltGaSecLkZ9eyHTc0aeAKOLDpsCBwUXrNm28yfn+9j4M/vWLHd/Rkg+MvuKqXYCMvhLYPsfEvT1ImXyRHE2Sh+qnEWdxAjUe30toJJ4HSY6IJTNpXX+zy4esINKE83I9L0SeFvEkN4lPFfFhFhqqLvzehkDYftjcsPdfpNe6DHMu/kk5xyKP2ZbyOWQF/u4q0ecOX32ZtFG+Q3ATin4s62YqMFuF9UV26/C1DSS+5jv6DKXoWamJCqw7UWpQW/uM0jcxl597S1xcbTNRWpT+kCnYZLUve4eDoSnKZg39pKoHPeVKVKqW52jkEN8KBvQd/nsbssM8sRQQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1fb6c0-1445-4271-8141-08d860a8e7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 16:43:03.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMRhWzvN/AKHYNqs+SVYhrhWqK6MFgfZd+jt+hwYdH27oF4R3lKFBcbzkNVWm+98+cRu7AhFl90qd9fNafMy7Zgh3Vfp4JxwNvMDP5nnI+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric W. Biederman <ebiederm@xmission.com> Sent: Thursday, September 2=
4, 2020 9:26 AM
>=20
> Michael Kelley <mikelley@microsoft.com> writes:
>=20
> >> >
> >> > Added Hyper-V people and people who created the param, it is below
> >> > commit, I also want to remove it if possible, let's see how people
> >> > think, but the least way should be to disable the auto setting in bo=
th systemd
> >> > and kernel:
> >
> > Hyper-V uses a notifier to inform the host system that a Linux VM has
> > panic'ed.  Informing the host is particularly important in a public clo=
ud
> > such as Azure so that the cloud software can alert the customer, and ca=
n
> > track cloud-wide reliability statistics.   Whether a kdump is taken is =
controlled
> > entirely by the customer and how he configures the VM, and we want
> > the host to be informed either way.
>=20
> Why?
>=20
> Why does the host care?
> Especially if the VM continues executing into a kdump kernel?

The host itself doesn't care.  But the host is a convenient out-of-band
channel for recording that a panic has occurred and to collect basic data
about the panic.  This out-of-band channel is then used to notify the end
customer that his VM has panic'ed.  Sure, the customer should be running
his own monitoring software, but customers don't always do what they
should.  Equally important, the out-of-band channel allows the cloud
infrastructure software to notice trends, such as that the rate of Linux
panics has increased, and that perhaps there is a cloud problem that
should be investigated.

>=20
> Further like I have mentioned everytime something like this has come up
> a call on the kexec on panic code path should be a direct call (That can
> be audited) not something hidden in a notifier call chain (which can not)=
.
>=20

The use case I describe has no particular requirement that it be
implemented via the notifier call chain.  If there's a better way to run
some out-of-band notification code on all Linux panics regardless of
whether a kdump is taken, we're open to such an alternative.

Michael
