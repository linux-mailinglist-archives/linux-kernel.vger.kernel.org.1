Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA026DA85
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgIQLlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:41:49 -0400
Received: from mail-eopbgr1320040.outbound.protection.outlook.com ([40.107.132.40]:41502
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbgIQLj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:39:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGrfLrCTtomS7iStH37Xi5ujf8SAM7cOSE4QXNsEBfmTUquJ9XokrVk2MM6n+3WvJuYAlpxNkhy7ThBCc8Ule/rsfaQ4//ms/ZKjDsPk5i1SAbjOVtVbRo8MwVZ1K6Vrnwi4BQRqDXXXGRbAt04TdkEfEMz428G3RaaEly6U1ifJwr348rS4pFDd9Xb5KvDlyVSMRU0MwfxahZy3ORnq310zN/OwgsjquiNoqVen9d0WXWFyLzE6IHnkfxkj0S8NdieXSL/k9l8Tv6X4qaIzNV0bDXlkVp75n6BJB7agO/w1GOnxpSTN3jrI+hbz3/+9lfxyqmET9384fUc0g316HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0T52J/kVodwbSJrJFG0VLBZ/iTHwGyr6zuRyTowRDE=;
 b=m5lx1SrrAWMlwBkuCDXPyvN4smyUcEQlqR6LCinQNFBLpBVqPPlAJQTl7HHAwoxQ1qLRUralEUWHy0mHYkHh8F0puxZpJluXrTZIQfkejaUDCSIVdrgxLPHcQ5zqOteCkBfD/GuPQ/9Jj3PFXTEJJn16OQuH68/mDVWItAe67OObHbZYB0/uv3ByGQkKBbQyLsiUaqBJdknvTmu7nvRiDFbbntAsZqjcdJavbRyFOBfmo+lk11i1Axa9UjgS23AWrlwezfJ78ngzXh8JsizpJIpIhXhcufpUjVmNeCNGmkraCMQFk1yvcEaynm3IMPm6iEv4lzr3pXWlNgoRRY4BaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0T52J/kVodwbSJrJFG0VLBZ/iTHwGyr6zuRyTowRDE=;
 b=WmRgp7CvVBPIiBpI6BgOrGJjqnuVRLHnvoyWQPZz6bDvq8OqpXveFwp9L2EmEE6lCGKazS2EDVjmJzQifv50PH4a6jwBBrJVan7jH1PoaARdqMOlcwqbg7H5YELhCSO38NvJxDc1ASmT0/apiI107pL/oJbJld4o6zMc7B1hsS4=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB4490.jpnprd01.prod.outlook.com (2603:1096:404:117::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 11:39:21 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 11:39:21 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aris@ruivo.org" <aris@ruivo.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v4 0/7] HWpoison: further fixes and cleanups
Thread-Topic: [PATCH v4 0/7] HWpoison: further fixes and cleanups
Thread-Index: AQHWjMx2j/0L2wEy/UuRZxbicfqQp6lstMQA
Date:   Thu, 17 Sep 2020 11:39:21 +0000
Message-ID: <20200917113920.GA19898@hori.linux.bs1.fc.nec.co.jp>
References: <20200917081049.27428-1-osalvador@suse.de>
In-Reply-To: <20200917081049.27428-1-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d63c3c08-e1f1-4150-297f-08d85afe51bf
x-ms-traffictypediagnostic: TY2PR01MB4490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB449007C340BFA173C3FAF24EE73E0@TY2PR01MB4490.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S8krH80rL2YCPOqEG1uRm97etAlIL5DAF3euT/Xmvuw5764QkJ5PqYAd4MnexIZBltVFUP4S5a1dEB2eZ0eVNQ1io9r/p8PzK2y/mq6eV35di1f7ktqqBxaHsYV+Xq1cgV9uJfiFXybzsB8WpkVwVXjCihkrPTHas5JK8KAf/iMWLXMbNlCkzmAIvf01+9UrMPoFTPo3OBnswGH88qvKh0msWyBoZQDFsZs3J8Fq2Rg6P7igj454swprAHiflGUht4HaNTGOVtK7cqsb2O1FGu8PCYoCdmZx5jrcum89AGDia64iOXovriFFtkW1+gm+s4SzdYLwBMAeRMjXwqpF7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(86362001)(55236004)(186003)(6506007)(4326008)(54906003)(6916009)(5660300002)(26005)(316002)(478600001)(6512007)(9686003)(83380400001)(66946007)(76116006)(8676002)(66476007)(71200400001)(66446008)(66556008)(8936002)(6486002)(64756008)(85182001)(1076003)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZKyIFYkilbKTTXf/0gbUbP8DAj8LEVPASRkE49sawubJISMNrdVW660B3R88fwjVkRfq5Q6OC8iQ1+jLx1OCPFYQHKLwkRCx6sFi9zr/OPQQQotBOgh+d/2JodNPuZAs5J0TWjNMzkanShqou+syNaUJEv6HrocU7CIEBXprrHU6lvDn2tqDlu/Wy/seKTPv23BzAdNrCB8OojM7T9z9aH+Zdj2Bpjxs9tqeuthdcRqq4kDpY4LfGSPMP9cjvOVo5oWO4RuPN21uCSV98Jux+JrcRmi2+2FI35IlLhZCPFTSgJbrn4gibqXXI736E5pgRvxSldlK69OZZVHsbK7TEj/F4eiPhznxrSCbEnC6R3xRQsBPYC25fbAbJaM0PNGAM3qocDb2hrc3Ge7cf7sFLChVgqD4IS/X9hELX1Db2yKjn0sXa5ahriV4SA2cN/0vi+4+N/qxGIPzS9OMJPhHX3nol6ZlaC6wMcNy7dYu9tvwrh7xSQJyPVM1gqmcahqWSkX5EMFJQef/EiePeZF4Aoe0SNYL5TCxOx/4oDJ4ACc+oXzvm0856c4Cnb1v0dHg7lsocqqq0/eZxMEFW17kY4TXumkxUrkqcazIfGBb56sKGagYUCcEdLpX127QKwneMR+H3K4KQkaSnXbE2J2mUA==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <132BBC895341A1489F9E28FDF6653339@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63c3c08-e1f1-4150-297f-08d85afe51bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 11:39:21.2021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIJ/je5MoKhyHdAQgNCFcZr2B13HoD/jhEadVjhuGAVL3nN7E/m0i/ITsjV5EZhG//XtAgmeEVUsVmQTLx9a0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4490
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:10:42AM +0200, Oscar Salvador wrote:
> This patchset includes some fixups (patch#1,patch#2 and patch#3)
> and some cleanups (patch#4-7).
>=20
> Patch#1 is a fix to take off HWPoison pages off a buddy freelist since
> it can lead us to having HWPoison pages back in the game without no one
> noticing it.
> So fix it (we did that already for soft_offline_page [1]).
>=20
> Patch#2 is fixing a rebasing problem that made the call
> to page_handle_poison from _soft_offline_page set the
> wrong value for hugepage_or_freepage. [2]
>=20
> Patch#3 is not really a fixup, but tries to re-handle a page
> in case it was allocated under us.

Thanks for the update.
This patchset triggers the following BUG_ON() with Aristeu's workload:

    [ 1010.400900] Soft offlining pfn 0xbff8c at process virtual address 0x=
7fe6c99c8000
    [ 1010.402931] page:00000000f5670686 refcount:1 mapcount:-128 mapping:0=
000000000000000 index:0x1 pfn:0xbff89
    [ 1010.405604] flags: 0xfffe000800000(hwpoison)
    [ 1010.406755] raw: 000fffe000800000 ffffcddf029ab848 ffffcddf02ff9448 =
0000000000000000
    [ 1010.408824] raw: 0000000000000001 0000000000000000 00000001ffffff7f =
0000000000000000
    [ 1010.410877] page dumped because: VM_BUG_ON_PAGE(page_count(buddy) !=
=3D 0)
    [ 1010.412673] ------------[ cut here ]------------
    [ 1010.413930] kernel BUG at mm/page_alloc.c:800!
    [ 1010.415143] invalid opcode: 0000 [#1] SMP PTI
    [ 1010.416320] CPU: 3 PID: 1340 Comm: kworker/3:0 Not tainted 5.9.0-rc2=
-mm1-v5.9-rc2-200917-1952-00212-gf1a0765b04cb+ #33
    [ 1010.419101] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01=
/2014
    [ 1010.422645] Workqueue: mm_percpu_wq drain_local_pages_wq
    [ 1010.424075] RIP: 0010:__free_one_page+0x552/0x580
    [ 1010.425344] Code: 48 c7 c6 90 6c 0f 84 4c 89 e7 e8 69 7e fd ff 0f 0b=
 0f 1f 44 00 00 e9 e5 fc ff ff 48 c7 c6 c8 f3 11 84 4c 89 f7 e8 4e 7e fd ff=
 <0f> 0b 83 fb 08 0f 86 cb fc ff ff 48 83 c4 20 5b 5d 41 5c 41 5d 41
    [ 1010.430231] RSP: 0018:ffffaa96c171fda0 EFLAGS: 00010082
    [ 1010.431651] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000027
    [ 1010.433598] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8dc=
8bbd18d08
    [ 1010.435627] RBP: 00000000000bff88 R08: ffff8dc8bbd18d00 R09: 6573756=
163656220
    [ 1010.437544] R10: 6163656220646570 R11: 6d75642065676170 R12: ffffcdd=
f02ffe200
    [ 1010.439376] R13: 00000000000bff89 R14: ffffcddf02ffe240 R15: ffff8dc=
7bffd5680
    [ 1010.441271] FS:  0000000000000000(0000) GS:ffff8dc8bbd00000(0000) kn=
lGS:0000000000000000
    [ 1010.443349] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [ 1010.444892] CR2: 00007f6b69f92000 CR3: 0000000139c4a000 CR4: 0000000=
0001506e0
    [ 1010.446746] Call Trace:
    [ 1010.447424]  free_pcppages_bulk+0x1d4/0x2c0
    [ 1010.448553]  drain_pages_zone+0x42/0x50
    [ 1010.449585]  drain_local_pages_wq+0xe/0x10
    [ 1010.450702]  process_one_work+0x1b0/0x360
    [ 1010.451769]  worker_thread+0x50/0x3a0
    [ 1010.452940]  ? process_one_work+0x360/0x360
    [ 1010.454072]  kthread+0xfe/0x140
    [ 1010.454989]  ? kthread_park+0x90/0x90
    [ 1010.455970]  ret_from_fork+0x22/0x30

This message seems to show that the pages to be moved to buddy have refcoun=
t.
Could you review how changes in v3 -> v4 make it?

Here's my reproducer.

    [build1:~]$ cat test_ksm_madv_soft.c
    #include <stdio.h>
    #include <string.h>
    #include <sys/mman.h>
    #include <unistd.h>
    #include <sys/types.h>
    #include <errno.h>
    #include <stdlib.h>
   =20
    #define MADV_SOFT_OFFLINE 101
   =20
    #define err(x) perror(x),exit(EXIT_FAILURE)
   =20
    int main() {
            int ret;
            int size =3D 100000*0x1000;
   =20
            char *p1 =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVA=
TE | MAP_ANONYMOUS, -1, 0);
            printf("p1 %p\n", p1);
            char *p2 =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVA=
TE | MAP_ANONYMOUS, -1, 0);
            printf("p2 %p\n", p2);
   =20
            ret =3D madvise(p1, size, MADV_MERGEABLE);
            printf("madvise(p1) %d\n", ret);
            ret =3D madvise(p2, size, MADV_MERGEABLE);
            printf("madvise(p2) %d\n", ret);
   =20
            printf("writing p1 ... ");
            memset(p1, 'a', size);
            printf("done\n");
            printf("writing p2 ... ");
            memset(p2, 'a', size);
            printf("done\n");
   =20
            usleep(10000000);
            printf("soft offline\n");
            ret =3D madvise(p1, size, MADV_SOFT_OFFLINE);
            printf("soft offline returns %d\n", ret);
            if (ret)
                    err("madvise");
   =20
            madvise(p1, size, MADV_UNMERGEABLE);
            madvise(p2, size, MADV_UNMERGEABLE);
   =20
            printf("OK\n");
    }
   =20
    [build1:~/upstream/mm_regression/lib]$ cat tmp_run_ksm_madv.sh
   =20
    rm test_ksm_madv_soft 2> /dev/null
    gcc -o test_ksm_madv_soft test_ksm_madv_soft.c || exit 1
   =20
    echo 0 > /sys/kernel/mm/ksm/sleep_millisecs
    echo 100000 > /sys/kernel/mm/ksm/pages_to_scan
    echo 100000 > /sys/kernel/mm/ksm/max_page_sharing
    echo 2 > /sys/kernel/mm/ksm/run
    echo 1 > /sys/kernel/mm/ksm/run
   =20
    ./test_ksm_madv_soft

Thanks,
Naoya Horiguchi=
