Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C92EC0F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbhAFQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:18:30 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43526 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727421AbhAFQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:18:29 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106Fp5Sj029721;
        Wed, 6 Jan 2021 08:17:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0220; bh=aG28e0As/VhYNSZMomqF8PoT4TJg7+e2YThgj5ngCWI=;
 b=J0BgT6Ds8dzymS3d6xCNZ6yHjeRb2SjAzzqt6O+IHDi4rx2G4HtDKn3XhvVzNWjrpw0C
 qN5fa7MgClLQbySLNBUTsNwKsRYSDQqp45m3Tr2O+4CQcHntbpnFsaggTD06hHdrxXvv
 z1Vq96u+bpP0TsbVeRjdUQY5oP+AzwMmCPHUzOkB8gsdrSjBGv5HvKhgBlERizRe3Szo
 5L4GREcpHq4597Vh7PJSDcahO44tXHlZlAy7ULHOxYml1TLE2pytGG99zokzcUvAKu4R
 sZvo2S4+KiDUCngM4SzKc0m6ONe7I7KYfs9klMpKvIpNJ9zX/3fWcs1bxV5WvcfAXf42 DQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 35ts7rssvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 08:17:45 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Jan
 2021 08:17:43 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Jan
 2021 08:17:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 6 Jan 2021 08:17:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSrZC2XsfvrV7//s6u0IPiirYKYVusSdGta2GO32vDWnUl9h8qn8fh3NpSUoZk07Cu4bTmB34p0CiJn5vXAVGXH5JrSFhEWfGgqw5ND/cIyiV/BNY2Fq7bRbJJ22kNevjPBTIAQaQrCS0vqx8SaS8gptLu9Cpc9VF9qRdZuAY5kFG35FjUdv/Bs9FkTMeYwXNosWHkkZZnkG+K/XI53qsEd8aViUvrLx/2G11tjLgQf1QV341tL1ycxud/Mmj+1mvbC5k+Hh5cP7EJfv3vQ5hC6BBSp3YGs27GKRSxW9McsiPUFGV1HOJSCIX0JNZDSfpYrmzivTlxloBv7rwMx7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG28e0As/VhYNSZMomqF8PoT4TJg7+e2YThgj5ngCWI=;
 b=U+GkJv1bYPMZ42Wm6p0Ym++R+gxVWMUMxFdcD0IlrsIHllsMrWCyYrWTsDb7rjFY0PrFRES4aaSkevr6UV39ObqkNdIy/49HxwkRwH520BHu5IU6LPV3XnOZwBVrdnoGz5wyWpEYZPtp15rRgNZjP6TJyT0p0RoxWwVdzVjr+PkRzopm03qowswIe0TYFdz2oePLyNM4Is/Svcu4+OMfWAakl+X2eipVG9VJYWrAjnWEIij5fiXYFbBhXizS/O+y3/sERse4T6uukZJ8ZwgdazpEF6Bt+um1a3mg0Wj26RI8tw/I3awNbOokHalrY5cpsV84DJ0YwkkaXctt11TH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aG28e0As/VhYNSZMomqF8PoT4TJg7+e2YThgj5ngCWI=;
 b=lg64x04eYWmze3ztLYzg3+651/UobSSmuKVTuVxndOikXrTptjHgpGlAPwZReOZeYE7I9Bm4FkyJgCELyeAUtiZ3CoOH/KHnp8yVK3xt9QksQc1/jd3VKIlkgxszdCle3V1nZ67s3VmoOd5wsDL6FFBrBtnf5qFCoPzDQ3uqGdE=
Received: from MWHPR18MB1520.namprd18.prod.outlook.com (2603:10b6:300:cf::10)
 by MW3PR18MB3611.namprd18.prod.outlook.com (2603:10b6:303:58::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 16:17:41 +0000
Received: from MWHPR18MB1520.namprd18.prod.outlook.com
 ([fe80::15a1:3a30:1fcf:20eb]) by MWHPR18MB1520.namprd18.prod.outlook.com
 ([fe80::15a1:3a30:1fcf:20eb%2]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 16:17:41 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     "ankur.a.arora@oracle.com" <ankur.a.arora@oracle.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sunil Kovvuri Goutham" <sgoutham@marvell.com>
Subject: vfio-pci: protect remap_pfn_range() from simultaneous calls 
Thread-Topic: vfio-pci: protect remap_pfn_range() from simultaneous calls 
Thread-Index: AdbkRnC96D9dwqxzR0eR3ijlJSqy4g==
Date:   Wed, 6 Jan 2021 16:17:41 +0000
Message-ID: <MWHPR18MB152034C6BAE8CC6D503DDEBEE3D09@MWHPR18MB1520.namprd18.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [122.182.227.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca73a783-d8f4-42c8-b8d0-08d8b25e9793
x-ms-traffictypediagnostic: MW3PR18MB3611:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR18MB3611DAFD6614649EB9675DF0E3D09@MW3PR18MB3611.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1tu4aAfQl5xLO9nJtOy5yVW/aUEP5NBi+yP9k6qHdYcDhmrXGFVbZrd3e98UezmcFAIv9UNOzEGcTeGspEUCi3FX0KXk5i7O4hjArYneidhjRdvuiBNbotzTQ9MBZbO4euAg7NzLc70TpV7i0vgojgUYZXFx7PXiWRN3vzjsC2iGjh6IH+O9e8qZ5+3h/O5GX/OpFBiQw1RRHQxprFRPtLhCWJTlM08Pk/GnxrSSKxf8UR0MD4t6TyF+jmeGP+EaCV9MiwB64RGBXuoNwQRnklILIdwlvY677xCMD8TyloXObptv9cVm7NZCj/xDV+tJnxpYQZRrPD64Qc0gh4OZuhGQWVPSFfhEvZgfipGpAvQvHYFWIfHRVCundOu36tIUwZSokOIR5JZ/3uPRQkkVhV9HUDmmWiyAy+55DgI6jcTBusKIQ0O0dGOUn8X+UBcerWeKhAubCjp0SsXE7e+fdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR18MB1520.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(8676002)(7696005)(5660300002)(9686003)(55016002)(107886003)(52536014)(8936002)(2906002)(4326008)(76116006)(6506007)(4743002)(966005)(110136005)(316002)(83380400001)(54906003)(478600001)(33656002)(71200400001)(26005)(64756008)(66476007)(86362001)(66446008)(66556008)(66946007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?iZ9XO2dwkdvATZAqp18fKFfTJu7f/eFvp2R1urbaXpTRy0IEuuE+1NxXpRKh?=
 =?us-ascii?Q?/lIPvWlVMuKKQRIqdvXjYby13Rh6Lig6UnpVb0IJuhwCvWpYON837UT5Xguw?=
 =?us-ascii?Q?SZEq4N3lmVxJRMPndkPs9WqbLXbbUS+FzCAQc/FWKPepuULF1kEltCk0nz6w?=
 =?us-ascii?Q?R/p7wXutxavyAtQOQ0dSqYl1N1d/1tfE+k8Ilo3zUbzpowdwEebzUmQvbfex?=
 =?us-ascii?Q?d8ZTOuB429EBZDSJWS9eLMbKk/whhpHD3dGxf+3oXp2lPwilFCwKN5eQsizM?=
 =?us-ascii?Q?n13NEJC6Bz4ync2uc+PaJo07kMSuUNORVEtf5fnvWC7D06d1DIXnHEAM/7ud?=
 =?us-ascii?Q?apQqhKH2dJ0yWX5EK/Tu6G1aqi0rKZd7tMFUwf1i430lDPIxxvXQDxyR5vyv?=
 =?us-ascii?Q?Zpp6Es5Zl3hT9tfUHYfuwN28X6XllVvR2JTrQjseuAKWuoR0WHYH3SXFklcW?=
 =?us-ascii?Q?ZU779i/ieMbxYJElc+pZOPIeDR6oE9pXCKwLX5bF/sTxNf4qSdC2YegqwzIG?=
 =?us-ascii?Q?ZshDE9hs+kBIdcKsZUwzHhAsbhbWdjdYTTERnsFhwlFIzUHQBQTPiP6IjoxI?=
 =?us-ascii?Q?cYohVaaGDGF/CfJUOg+n4LTlYWA4CwbmduWb3hDcegKNBxj32QYSY6hEquiO?=
 =?us-ascii?Q?chXdQjADTxe1eHiwDoJ+Xps7IkjyppXTa9pOCQDS9rkmwBvlMCQ3PY0dYOER?=
 =?us-ascii?Q?YYYyLM6jCehK3DVZkKlUmZaW4l291dauJS+2I1vbjbpOo/p2D4AXmIM1QAjP?=
 =?us-ascii?Q?cLSV9LWiKSfKZyvB4DuvkH/u58MBe46DGzS7G6eiJT5oIX6SXO40Tfir52P9?=
 =?us-ascii?Q?PuodeGHj/lb+jtDTxK0vP1v28KtTDjsz81aaF+bfB/0d4o7zPw6xCniQ9kXX?=
 =?us-ascii?Q?bQhArK2yJksLSfC7YTI5vXxYTlvo2OOIG1uXkA6dEUxw4g2hUsI6kxtQRqCS?=
 =?us-ascii?Q?o7SufofhItr/upD6iZacfl3E5SSIPm6Kb5DV5nWfKsg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR18MB1520.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca73a783-d8f4-42c8-b8d0-08d8b25e9793
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 16:17:41.0646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNKBtvBA/Z+6i9rj+uw9nfHhbyQnKa2TOJslu2ya8D7jy3k3/kIKJ2wF44LXEDsVz64cLHomJUAg0N7Oj7CrUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3611
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_09:2021-01-06,2021-01-06 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ankur,

We are observing below BUG_ON() with latest kernel=20

   [10011.321645] ------------[ cut here ]------------
   [10011.322262] kernel BUG at mm/memory.c:1816!
   [10011.323793] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
   [10011.326108] CPU: 2 PID: 1147 Comm: odp_l2fwd Not tainted 5.4.74-05938=
-gb9598e49fe61 #15
   [10011.328272] Hardware name: Marvell CN106XX board (DT)
   [10011.330328] pstate: 80400009 (Nzcv daif +PAN -UAO)
   [10011.332402] pc : remap_pfn_range+0x1a4/0x260
   [10011.334383] lr : remap_pfn_range+0x14c/0x260
   [10011.335911] sp : ffff8000156afc10
   [10011.337360] x29: ffff8000156afc10 x28: ffffffdffa240000=20
   [10011.339671] x27: ffff00014a241000 x26: 0000002182000000=20
   [10011.341984] x25: ffff0001489fbe00 x24: 0000002182040000 =20
   [10011.344279] x23: 0000002182040000 x22: 0068000000000fc3=20
   [10011.346539] x21: 0000002182040000 x20: ffff000149d70860=20
   [10011.348846] x19: 0000000000000041 x18: 0000000000000000=20
   [10011.351064] x17: 0000000000000000 x16: 0000000000000000=20
   [10011.353304] x15: 0000000000000000 x14: 0000000000000000=20
   [10011.355519] x13: 0000000000000000 x12: 0000000000000000=20
   [10011.357812] x11: 0000000000000000 x10: ffffffdfffe00000=20
   [10011.360136] x9 : 0000000000000000 x8 : 0000000000000000=20
   [10011.362414] x7 : 0000000000000000 x6 : 0000042182000000=20
   [10011.364773] x5 : 0001000000000000 x4 : 0000000000000000=20
   [10011.367103] x3 : ffffffe000328928 x2 : 016800017c240fc3=20
   [10011.369462] x1 : 0000000000000000 x0 : ffffffe000328928=20
   [10011.371694] Call trace:
   [10011.373510]  remap_pfn_range+0x1a4/0x260
   [10011.375386]  vfio_pci_mmap_fault+0x9c/0x114
   [10011.377346]  __do_fault+0x38/0x100
   [10011.379253]  __handle_mm_fault+0x81c/0xce4
   [10011.381247]  handle_mm_fault+0xb4/0x17c
   [10011.383220]  do_page_fault+0x110/0x430
   [10011.385188]  do_translation_fault+0x80/0x90
   [10011.387069]  do_mem_abort+0x3c/0xa0
   [10011.388852]  el0_da+0x20/0x24
   [10011.391239] Code: eb1a02ff 54000080 f9400362 b4fffe42 (d4210000)=20
   [10011.393306] ---[ end trace ae8b75b32426d53c ]---
   [10011.395140] note: odp_l2fwd[1147] exited with preempt_count 2

This is observed after patch "vfio-pci: Fault mmaps to enable vma tracking"=
 where actual mapping delayed on page fault.
When address of same page accessed by multiple threads at/around same time =
by threads running on different cores causes page fault for same page on mu=
ltiple cores at same time. One of the fault hander creates mapping while se=
cond hander find that page-table mapping already exists and leads to above =
kernel BUG_ON().

While article  https://lwn.net/Articles/828536/ suggest that you have alrea=
dy faced and fixed this issue
       "- vfio-pci: protect remap_pfn_range() from simultaneous calls (Anku=
r  Arora) [Orabug: 31663628] {CVE-2020-12888} {CVE-2020-12888}"

But I do not see any patch submitted or under review in upstream, hopefully=
 I did not missed some discussion. Please let us know in case you already s=
ubmitted or planning to submit fix or someone else fixed same.

Thanks
-Bharat
