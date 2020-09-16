Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B026C687
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgIPRxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:53:07 -0400
Received: from mail-eopbgr1400044.outbound.protection.outlook.com ([40.107.140.44]:19232
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727622AbgIPRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0UJMyxehOD66PAkj8Ww9o3OEttrnQn8h38iaeXcx0k1dD8G3GZlbcCKMyHuqCYTmqHatesNauY5vIkb+S1ftKvqfwHPENpYUOC//q3duer19BgMnFFyQ2Drc6yKz9tIOAel5O6IuAnIp3W/8jkUWajng2JMwgR8B3s3350OrGCn5JNX6XGwRO2EixsdHxL9fS9XNMBv7IyPVE03iDYvGaudPNIOo9tLqQreTRra+lrPBxSF2auZb+1+daRuAf2FYN4ehO1+gom7tHWiEcWhds93sm0elm6JGRXs74ZhypmeCjPZZ0PkYnjXsqfjL9hE2UvWBjpYyWJiRBmRYNFH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB/Eeis1gr6WKcwLga2J2mCD5I2LJE45S4FzEKjECUI=;
 b=NwoY0CW3/Jxj99knk5FapiZXwERF8Zo/0AeYJxGYOXCg8etUA5lcDapDQVaWB9ieXiWUVXmhoUpSqsRXjeeZ9Wqvt5PUVeGNNgUrr19MxYigstWA7qkH2JBFL8LfSWrQ7Y97zMCZOBvs+nIX7fP3Eg8iG4aKAMBG9EKKL9XV2LAZiC4zbkIkOOIYWQ6cquF2WBosBq4iEji/lVwfBD1IKY1xPUd875E2d6fJAikEM6UKoDHo0db1L/CqWb5QW9sJwNjJmtTKsSrw8Y9i4dYwWUXMkHAzQieAX2YK2O07gx0ktAsvSWqB7SEBPrIBeryKp11ob62oFvORZ2dLd0PPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB/Eeis1gr6WKcwLga2J2mCD5I2LJE45S4FzEKjECUI=;
 b=imlr7+xnfPdDhsqhJsh2U8M2/PlhKawyd3slAufnLweH8fEisuoKuszo0XWiCPfbvGujA+MATlbaKwQ2s0ELkz5xfkLDhWwcJPRpXJvK7J4SXAnZx44r9Ku79eGJQnGe66NOGD1hNFDg5Kh3YwtbzQC3jvgEqH/hhosn4BlCc7A=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB4766.jpnprd01.prod.outlook.com (2603:1096:404:121::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 13:42:15 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 13:42:15 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Aristeu Rozanski <aris@ruivo.org>,
        Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Thread-Topic: [PATCH v3 0/5] HWpoison: further fixes and cleanups
Thread-Index: AQHWioASOS4BIdKZp02dPkadmQVT+qlqN5kAgAERxoA=
Date:   Wed, 16 Sep 2020 13:42:15 +0000
Message-ID: <20200916134215.GA30407@hori.linux.bs1.fc.nec.co.jp>
References: <20200914101559.17103-1-osalvador@suse.de>
 <20200915212222.GA18315@cathedrallabs.org>
In-Reply-To: <20200915212222.GA18315@cathedrallabs.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ruivo.org; dkim=none (message not signed)
 header.d=none;ruivo.org; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ca54f40-7164-4b1f-4fb2-08d85a4652fa
x-ms-traffictypediagnostic: TYAPR01MB4766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB4766D2CBF51351D97346F040E7210@TYAPR01MB4766.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OpuTvTLD0Ea0Nk2ksiSt006Jzjl2yBxhof1ciyQLB8/SdOF2lavUMcGo/0JhMMcAuchvPjmvMLjaUiht9VHBamVBRrJjdpNh3Q+HqINAuuFaNOtC5JaI1ZTcfiw2PBDuNIBFqb9xk9Mwwk/LztHqUmvsqYQ8FNZw9Rvwn6sjqmbeoc4bdaSAnvDebpigKSspFZ4OgXGN/F7lNmEDpZHU7RogJWdu7Ee+KOYTkafTYooi1MyAV/fP7jHp9SX8oj8t8MZ6jYzzJgBY4/hGphTKlbpzcxmDCKg6d+4kHWSkAKSgu5IL3LIBXzO5FjDipSd5eKiZ2jdJCNab2ZqXRxNeaAcf4GY0t4D7zZVdg5O8oj284aWsJKNM1+4CvvC9eyg1C74i9jIK5aDiGE+6Pw0BDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(71200400001)(8676002)(2906002)(186003)(26005)(33656002)(6512007)(9686003)(5660300002)(85182001)(8936002)(316002)(83380400001)(55236004)(6506007)(6486002)(966005)(86362001)(478600001)(4326008)(64756008)(76116006)(110136005)(66556008)(66476007)(54906003)(1076003)(66446008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: r/C7J1N+2Vaii3/d1gUajcor4mCXdO/DaMIHLQTBVpxO4Yb9NgPDcC10/JdejaukTIV+mNeciHMfy80prhmsvhRv9hJvuavlKDYLfujxSB7YsyP2E1F7HeQUCyhCjvtb+ZB7E3zn+J/RU19nGqATESg0ev6LYOQnSwFFxYFQt3dCHVq9Wjve78XaMLReGtpsqnJq8eFcQrKRw3dnu47GHSFPB9WmaqJGxSdFTX0JFbXM4RqGCSYGaucAI8fW7O1s9yVx88H7Q84Ir3ObVTgzo2Rflde8T9b+Ds0ktJ8/Guw7uYiorxSNaNJIX2q39Zdg8ntRdSXLFkKChLwFDvYJjuoNY6b0RlER07/ikzgH7ex/6mNXEmOTOyL+2JJZY8XlC6EGWZtvR3H17Iijuu1lnIzgSTrtpVeNCU+5g7y9ErJL0sPKQ2TS/eYDBTvaP5q0xyq+XQLmMxRu7rUAC/+7tlI036qdvoQTedQ1zifTfj1Rbofa7WSGdKegJX02GZ5RAV3SKEtXLE1Sp9n49FyViP/5DD79CLnXXeBo1fXO7Pdc2UZJVrJ/HNZwwPMURXhY0IYGgibutga5aiZ2XAUvXQPQSXkbN+rRbG647EObl//VLbu6Fqdle49EY+2+aNlYWyj2MRXh7KExeXVPcGW/Ag==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <32DC52BA5F0AE043838FFB17157C4154@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca54f40-7164-4b1f-4fb2-08d85a4652fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 13:42:15.8502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmlBNMMaFybitvickbNTaZP5hs3AykdBRmkTOaUO345upzLeaP5BTuGEqpzZ8s3Jj7z1TqwxEQJ8IK0NLQKhRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 05:22:22PM -0400, Aristeu Rozanski wrote:
> Hi Oscar, Naoya,
>=20
> On Mon, Sep 14, 2020 at 12:15:54PM +0200, Oscar Salvador wrote:
> > The important bit of this patchset is patch#1, which is a fix to take o=
ff
> > HWPoison pages off a buddy freelist since it can lead us to having HWPo=
ison
> > pages back in the game without no one noticing it.
> > So fix it (we did that already for soft_offline_page [1]).
> >=20
> > The other patches are clean-ups and not that important, so if anything,
> > consider patch#1 for inclusion.
> >=20
> > [1] https://patchwork.kernel.org/cover/11704083/
>=20
> I found something strange with your and Naoya's hwpoison rework. We have =
a
> customer with a testcase that basically does:
>=20
> 	p1 =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYM=
OUS, -1, 0);
> 	p2 =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYM=
OUS, -1, 0);
>=20
> 	madvise(p1, size, MADV_MERGEABLE);
> 	madvise(p2, size, MADV_MERGEABLE);
>=20
> 	memset(p1, 'a', size);
> 	memset(p2, 'a', size);
>=20
> 	madvise(p1, size, MADV_SOFT_OFFLINE);
>=20
> 	madvise(p1, size, MADV_UNMERGEABLE);
> 	madvise(p2, size, MADV_UNMERGEABLE);
>=20
>=20
> where size is about 200,000 pages. It works on a x86_64 box (with and wit=
hout the
> hwpoison rework). On ppc64 boxes (tested 3 different ones with at least 2=
50GB memory)
> it fails to take a page off the buddy list (page_handle_poison()/take_pag=
e_off_buddy())
> (madvise MADV_SOFT_OFFLINE returns -EBUSY). Without the hwpoison rework t=
he test passes.

I reproduced the similar -EBUSY with small average x86 VM, where it seems t=
o me
a race between page_take_off_buddy() and page allocation.  Oscar's debug pa=
tch
shows the following kernel messages:

    [  627.357009] Soft offlining pfn 0x235018 at process virtual address 0=
x7fd112140000
    [  627.358747] __get_any_page: 0x235018 free buddy page
    [  627.359875] page:00000000038b52c9 refcount:0 mapcount:-128 mapping:0=
000000000000000 index:0x1 pfn:0x235018
    [  627.362002] flags: 0x57ffe000000000()
    [  627.362841] raw: 0057ffe000000000 fffff84648d12688 ffff955abffd1dd0 =
0000000000000000
    [  627.364555] raw: 0000000000000001 0000000000000000 00000000ffffff7f =
0000000000000000
    [  627.366258] page dumped because: page_handle_poison
    [  627.367357] page->mem_cgroup:ffff9559b6912000
    [  627.368342] page_handle_poison: hugepage_or_freepage failed\xb8n
    [  627.368344] soft_offline_free_page: page_handle_poison -EBUSY
    [  627.370901] page:00000000038b52c9 refcount:6 mapcount:3 mapping:0000=
00001226bf89 index:0x2710 pfn:0x235018
    [  627.373048] aops:ext4_da_aops ino:c63f3 dentry name:"system.journal"
    [  627.374526] flags: 0x57ffe00000201c(uptodate|dirty|lru|private)
    [  627.375865] raw: 0057ffe00000201c fffff84648d300c8 ffff955ab8c3f020 =
ffff955aba5f4ee0
    [  627.377586] raw: 0000000000002710 ffff9559b811fc98 0000000500000002 =
ffff9559b6912000
    [  627.379308] page dumped because: soft_offline_free_page
    [  627.380480] page->mem_cgroup:ffff9559b6912000

    CPU 0                                CPU 1

    get_any_page // returns 0 (free buddy path)
      soft_offline_free_page
                                         the page is allocated
        page_handle_poison -> fail
          return -EBUSY

I'm still not sure why this issue is invisible before rework patch,
but setting migrate type to MIGRATE_ISOLATE during offlining could affect
the behavior sensitively.

Thanks,
Naoya Horiguchi=
