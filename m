Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B6E2EF073
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbhAHKJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:09:43 -0500
Received: from mail-eopbgr1410051.outbound.protection.outlook.com ([40.107.141.51]:8717
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725984AbhAHKJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:09:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqU8j+LxzszipSGMjp74XVPMNtgAvbNaZzBWOqd51IkassznWnc6b5FvUoPMtH/ykHV3qCflb0t+sWQtDpOGXvNo+XMnD7kHCQZ3x+xI79PRXUikBf0dZCT8MMh8h8YZNJVBtTi7rzoIy9U9oQb1HpwnzluUHluaPYGV+wTxtH4SZ9E/qrYpDeUkkmob02lo9zZ72SvDaflHMePG6JAs2jtBxxZ/pKEnDicfgY/gFDR9FrjoIFJLFOmPozl3/99Sfr3YDR9+PzTFa0lmDwwMnj/eGSXyIZtzJpxyWAyV8yDwJR8vFPJqG6hKwDzDShA00tCkZDizs/Bljym9Y+gdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJoGHTfnmSmRc4kTw9HsIS7wZ+nVZCK/8AVuTLdvTJM=;
 b=Oa02JuNWeRPPqcJ/sNmFXXNbCnWk7KOVMF/+TA00SvC8jYPxxEdvHPQI3l4BB5aGEjAV0gWIRFJqNen0mKuVUC8Ocz/ohGUJdn+lzLGDVzdTR6xstLWjlRRhUPKkGfiyzGn2RU+onNz09IzO/mkmXOhREqWcV9Ldec0dwQQRxvRYpeDJ42K+63MVfap/zcf/3Im1UYhm1eb985gNwLDQBWJ4xU+S65AGWB9krS3ZudhALQoFE1q7S2gbiAxNfjTzebzR0AkMTrJJQh61bDJBDto1RlyV5KF6FoF89texEpNyW92BsBlVfl7r8Aq6EWlSHqwfiYHsalCWYXuJ3ttSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJoGHTfnmSmRc4kTw9HsIS7wZ+nVZCK/8AVuTLdvTJM=;
 b=cangjXpB2FZBxJG9dc1v5oz4l2M5qN3ijZrVlRTVoFoQSvLihK2G9Q+QmlqMagWAfcie4iPNwoduFQkedZhnEzVbbG6OX4bYhumzY/kVvFfVA5h169dTN7ROtaGEfs3dNFcX21zbNgXJQvim5jcL6RkunQ0yqc/tbqtAnKLq+Dc=
Received: from OSBPR01MB1991.jpnprd01.prod.outlook.com (2603:1096:603:22::23)
 by OSBPR01MB2583.jpnprd01.prod.outlook.com (2603:1096:604:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 10:07:07 +0000
Received: from OSBPR01MB1991.jpnprd01.prod.outlook.com
 ([fe80::8057:244d:52da:7604]) by OSBPR01MB1991.jpnprd01.prod.outlook.com
 ([fe80::8057:244d:52da:7604%7]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 10:07:07 +0000
From:   =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?= 
        <k-hagio-ab@nec.com>
To:     Baoquan He <bhe@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "lijiang@redhat.com" <lijiang@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: RE: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Thread-Topic: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Thread-Index: AQHWlxP9iSN4NUmqe0mVMLoYv/8qc6odr7YAgABrXgA=
Date:   Fri, 8 Jan 2021 10:07:07 +0000
Message-ID: <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
In-Reply-To: <20210108033248.GA4959@MiWiFi-R3L-srv>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcbcb92e-4fbc-433a-d390-08d8b3bd2808
x-ms-traffictypediagnostic: OSBPR01MB2583:
x-microsoft-antispam-prvs: <OSBPR01MB258356E0002DF8A3D717F9C4DDAE0@OSBPR01MB2583.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KW72s9T8WoAsmebvNBLx5TTOd0w3NDIvSsyZJkpjJ+LpgvtNLEIhdNrvQ61l8LSoL/wep7slIM2dT+FRf9iap9PAr/n3EzqZN8ko0Aqb12Yg6WxIMcNLCFN95V3IExYeebxV9CItLzrYtHWTiZtYhW8CnQyVRnKxKGcmxDSJIzqopJc8VfsDyZTLSssKe6s8yyS1InjRqPb3UnsoEWSNVL1RyZ4eePl6C+NOUW5M/pUcHUVAwXkeIejeHSv0+CybcH+JZwcWy8BgT3Co9zt79UhgfdM9jLNy4wIPfvVfQ2dTgBk+WoX0dI2OPYNoJKyOSjXm5kfCZT0fk/LYabUQosP/xsoXKTLZKQM9zDd5OGD6Wy+BF1tSMSvypRt1eR4ZzwhnmmCybdZRlhfr1WL9BSiNGuXViz1MIavC10to8m9MdncSbhRcOcJA2vZ/wODPtsH1jREm4LPcZZVklFFsyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB1991.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(55236004)(316002)(26005)(8936002)(71200400001)(5660300002)(86362001)(6506007)(83380400001)(85182001)(186003)(55016002)(9686003)(7696005)(66476007)(4326008)(33656002)(110136005)(966005)(64756008)(76116006)(7416002)(8676002)(66556008)(54906003)(2906002)(52536014)(478600001)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?UDBZTXZZKzNzVmdpNkppLzZlUWVnUEQ4TjN6ZzNVT0hYZXE0Q0s5cFZH?=
 =?iso-2022-jp?B?YmNvRGhIZEVqNWlqcXRhQUl3d3U2Mm5yWWlVVHQxdlY2aC8wTExhRzVB?=
 =?iso-2022-jp?B?YjZjK1llM2w1TElnemNlY2JRZG9hdUlsY0dDL1JWMEJmVXhRbmpEOEhD?=
 =?iso-2022-jp?B?b1hlWEtUUEZtNlQ0emE3VmNibnlHNFhvSTlxdCticE9aTmZyYnFGd0xm?=
 =?iso-2022-jp?B?V0l4ZHdxOTMrV3g5dkJ2Zm9EMWtOdHpMUDUwRDdNc2JMMldSUzc5dEk5?=
 =?iso-2022-jp?B?WkZvUXlMTmR1aFo4Y0Q3SjAzTElpcGFweWNEbE5ja3RzaXRtbklua0xN?=
 =?iso-2022-jp?B?MXJoRElPSnFuNzArUFM0aVQzVFpsUFBpbStadEtjc0JpdW43L1NNanhz?=
 =?iso-2022-jp?B?clpBWGM4RWE4Wmp6TzJPbmRvMllkakFkd3dsRzFHRDhYd05lZWJOMGIx?=
 =?iso-2022-jp?B?WURWN0JZcFVMN2RlbEVuMEpMZ2ZLODlJcTN6eUZGdmExVWdtbE55NUJE?=
 =?iso-2022-jp?B?SmZaOFdheU1tS3krcnBrRnk5Uk1MR3VTdzFuUTZZeDYxK3ZuZGhLalkx?=
 =?iso-2022-jp?B?U2RCa2p2R28ydlNxdzcxMkt0NUpoYWhKRWZhWlVuYTBaOG8wMWNKN20v?=
 =?iso-2022-jp?B?QWtTUnBLdENIdkRmNHhudFcrK1QzZ2pnS0s3U0U4T0dVNm9PS0ZuODll?=
 =?iso-2022-jp?B?L0taanJhbFlobHJwK2JOVkQxYkJnT1R0b2FIUkZrS2tQYVN6am9EY3Nk?=
 =?iso-2022-jp?B?ajhFRG10Z3pNMHFhb3lmS2c3YVJoM2FzdWpuVENKem9DekE5WnRNN3ox?=
 =?iso-2022-jp?B?aVU2bUVDSHo1VmlOM2NsQnM0YTZnSmZrZ0NQUmMyV1hKYmhNWC9ySnp5?=
 =?iso-2022-jp?B?TS9NbTB1TVpZMTZJUnpKbjdvcXN1ZjVGWE50Zk1JWE1TWld4aUVjVE5U?=
 =?iso-2022-jp?B?Z3NlTE9FRTgxMGdMOXpTbUVadFZyc2hZcWs5YTdrazMyZk5XUTJxWW5K?=
 =?iso-2022-jp?B?T1dCNi9aTDdaVTFjaWsvY2xRamJCUGFtd256YW9PTlZVd2JOU3BPQkZk?=
 =?iso-2022-jp?B?dDVKbXl2TGJVMlBDZjE3QXVKU1plZjhIUyt0QW5adzN2aktyQmV3SW53?=
 =?iso-2022-jp?B?MTJyWDliajFGY3pDdXZVc2o3dzY0d202bjY4Z0RISUhmQUdWUjJwRlp0?=
 =?iso-2022-jp?B?MVRHU3hZRmZGQ1p2RHR6dDRLUDJCMG1wMkF2ZmZXdWRManMvQUM3N2dj?=
 =?iso-2022-jp?B?dHB5NjNVeWNqaG85U3FidUFKU1lScmtIaHN1Rm1zejQraE54eHpubEVv?=
 =?iso-2022-jp?B?N1hkWG0vOWNFem1hYVNtR3cvR1Nkb2l0MFc5dSszemJXNXZ3V0N4MHRH?=
 =?iso-2022-jp?B?aHg4eGFOU1hmY1d6ZHY0Z1FjRDNuYmRmTnQ2QUZaRU14MmpJdz0=?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1991.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbcb92e-4fbc-433a-d390-08d8b3bd2808
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 10:07:07.3933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWwib+T0ZJiaujAEiU4/QEI67JDPIZEFJm2ao6J3DCFuNEi9CQMNALGy3jO+dfbBrtOXlZXEPad1ld9RG1f+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2583
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

-----Original Message-----
> On 09/30/20 at 12:23pm, Alexander Egorenkov wrote:
> > The offset of the field 'init_uts_ns.name' has changed
> > since commit 9a56493f6942 ("uts: Use generic ns_common::count").
>=20
> This patch is merged into 5.11-rc1, but we met the makedumpfile failure
> of kdump test case in 5.10.0 kernel. Should affect 5.9 too since
> commit 9a56493f6942 is merged into 5.9-rc2.

Hmm, commit 9a56493f6942 should have been merged into 5.11-rc1
together with commit ca4a9241cc5e.

Does your makedumpfile have the following patch?
https://github.com/makedumpfile/makedumpfile/commit/54aec3878b3f91341e6bc73=
5eda158cca5c54ec9

or am I missing something?

Thanks,
Kazu

>=20
> Below tag and CC should have been added into patch when posted.
>=20
> Fixes: commit 9a56493f6942 ("uts: Use generic ns_common::count")
> Cc: <stable@vger.kernel.org>
>=20
> Hi Greg,
>=20
> Do we still have chance to make it added into stable?
>=20
> Thanks
> Baoquan
>=20
> >
> > Link: https://lore.kernel.org/r/159644978167.604812.1773586504374412107=
.stgit@localhost.localdomain
> >
> > Make the offset of the field 'uts_namespace.name' available
> > in VMCOREINFO because tools like 'crash-utility' and
> > 'makedumpfile' must be able to read it from crash dumps.
> >
> > Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> > ---
> >
> > v2 -> v3:
> >  * Added documentation to vmcoreinfo.rst
> >  * Use the short form of the commit reference
> >
> > v1 -> v2:
> >  * Improved commit message
> >  * Added link to the discussion of the uts namespace changes
> >
> >  Documentation/admin-guide/kdump/vmcoreinfo.rst | 6 ++++++
> >  kernel/crash_core.c                            | 1 +
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > index e44a6c01f336..3861a25faae1 100644
> > --- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > +++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
> > @@ -39,6 +39,12 @@ call.
> >  User-space tools can get the kernel name, host name, kernel release
> >  number, kernel version, architecture name and OS type from it.
> >
> > +(uts_namespace, name)
> > +---------------------
> > +
> > +Offset of the name's member. Crash Utility and Makedumpfile get
> > +the start address of the init_uts_ns.name from this.
> > +
> >  node_online_map
> >  ---------------
> >
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index 106e4500fd53..173fdc261882 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_init(void)
> >  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> >
> >  	VMCOREINFO_SYMBOL(init_uts_ns);
> > +	VMCOREINFO_OFFSET(uts_namespace, name);
> >  	VMCOREINFO_SYMBOL(node_online_map);
> >  #ifdef CONFIG_MMU
> >  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> > --
> > 2.26.2
> >
>=20
>=20
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
