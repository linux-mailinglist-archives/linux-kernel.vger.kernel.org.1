Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC92E74E7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL2VmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:42:01 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63644 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726158AbgL2VmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:42:01 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTLT8kX005872;
        Tue, 29 Dec 2020 13:41:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DEXJ4+wBK7OmwZ6WuvELDDvTTgJEDk9uh5IPB6iRLnM=;
 b=C+a393W7gVmCLPB2M3upChM8z/LznOpM0y6PEJ8NL40IpD29R+waQaz5VzWz1+/Jhd9g
 ikFMPRsxLUizHQTW9af0JosST6DU26lTxrszGx2SVJhRHdtmYK/vrPbFsXnjKKZZ4g0S
 2bCOGzAitaTvbth3LJruLcSTmtZ+IHkCcK0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35p3juu8kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 13:41:01 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 13:41:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5OTWs5DPCP/aUW26JlkoLKEYIcKsFJYr3MG3a/OrzWQLwwQHzqymsRohJbbDmfkUOIrDfM/neMg8fWSIYX/aAbqY4ukNmMt//fSx/lFtA4ziSOxoKdvYX5QluYA0zdtvqn1ym03KAV7urzYFGNTtTOqxg4/6u+Z/3PPI3O98QTMKfD7S72bQaH+H+6Ql5dc0vFhiGtBcFWtldKQZnamIpNCqjnbCYR0/0w7bNzDuLWh5XO4kcHbrTAtyOAJGjzKsqjZ6pbp4YY6EVedFR/XCuzyLIfOHdruEAnALYO7JFKzuwpm+NtuuW9YedwhdMQcCiIATy9+eXWtlNu4NAXxFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEXJ4+wBK7OmwZ6WuvELDDvTTgJEDk9uh5IPB6iRLnM=;
 b=BdoyJ17eJgSqMoAKrghYqOyqbEL1B0gYBh5ZUa+dKeUjd4LDYAcRK1dYM/y3sSwYokTYdhUWRyc8u8VjryZ3U1M97qrr4nk1xDNtlelY5ob8zrZfwaltLBQLoxIQ1lFuRHeW4K5UjlVN4Bt3jKAEi57kgYQLTGSyscfExAfFWnmj+T9iFLwRBgdZlhfcYXgWFaws+GxN3AQA5i68e1OB7V0EgVVpx/PlUZ9PWgtAVUkFkZa++dEwVHR1wQKmMlDv8aQPDp47tHBj/Iszghn7Q92lJqC+TaPgIMxdho2/V7pNX5id4MmSfm68nosUG5bDYoyc2C4n1CKib2wWqMiuQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEXJ4+wBK7OmwZ6WuvELDDvTTgJEDk9uh5IPB6iRLnM=;
 b=ichtDKflZ5VQKtySc9Tuf5sOnJtQocFIypNjlyB9Sz1Wp04QYL3P3dOrDUuoHMI8Q58RukySFZG5xWRkhC8H8DILVZc4IhzCAKLdjL2ErwkkJrpDIX9PH7xQ6UM09S+TkzU0nKveOiFQfZRz55cDhNCue4XzIw2YLpcruLxNctE=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2887.namprd15.prod.outlook.com (2603:10b6:a03:f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 21:40:56 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 21:40:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v6 3/4] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHW3UCo6hW/vcfUc06GxX5agiqE96oM8OOAgAA7EgCAAQROAIAAOeYAgAABu4CAAAZXgIAAAiEAgAABZICAAAJ/gIAAI9KA
Date:   Tue, 29 Dec 2020 21:40:55 +0000
Message-ID: <83C9733B-9F8A-4C28-AA53-487FFCDDB4B4@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <20201228201159.GF521329@kernel.org>
 <6CB86649-9A1B-4585-8E1F-611F25935041@fb.com>
 <20201229151504.GI521329@kernel.org>
 <3E293E73-ECB7-48E0-8A6E-337988218299@fb.com>
 <20201229184829.GK521329@kernel.org>
 <9BDC4556-E802-4152-91E1-1A4696F62AAE@fb.com>
 <20201229191848.GL521329@kernel.org> <20201229192347.GM521329@kernel.org>
 <20201229193243.GN521329@kernel.org>
In-Reply-To: <20201229193243.GN521329@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7414]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5001983d-c86c-45e0-d035-08d8ac426cbe
x-ms-traffictypediagnostic: BYAPR15MB2887:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28871A102893CAAE7CBDC2DBB3D80@BYAPR15MB2887.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3hUZy2yBii8cZl8yPlPQH5LmHDiuGvl4eiVuVM7a0z8ZahhRuRrPEE+jkDRJiVHa+qwxTZkgqv0zt4eYFnwcutHbSKg4ZKAAs9jc5uPYr4Z9GrkEdLy0xrkNVkKYT0IwR6RxXS1XST1B55P1+VbQC14Bk8+4bLQB9Y1qlQ+ZcJ7fJtvlvnMnV5G9ekGNk62bZ48EH/mOd3qkyU7oMdLJ+phxZvLRE2EgnhgKa4z2YOEb0/XIZ10ClfgUhouu5Wi9MiPqE0GmH3aLsQMfaZEwa8OWBcUB15cwtrCrJjXiUDxdwjB9aGNMtUL/lGaHWJ/deitir2T9rqzuGtYdLRFTMsoaEfgksi32MjAHbHa6d/i9EHBxKyJQM/xCm3ZpkrX8JzyGlVE4H8uth125EVyEhwLH2Xgig4tYjgVZVTGQqKWNdRx9qVCEYw2w3e+w4lFx9wjIQzYF+/r29dhQv57LESHPg/Hu/k0mxhYFp41yido=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(39860400002)(376002)(66446008)(6512007)(53546011)(54906003)(8676002)(83380400001)(2906002)(64756008)(66946007)(66476007)(76116006)(6486002)(316002)(33656002)(4326008)(8936002)(66556008)(6916009)(71200400001)(2616005)(30864003)(36756003)(186003)(5660300002)(6506007)(478600001)(86362001)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Kie/6nfEQ9dwOWDaZ0x1C+1nfNvWcDiGEyWzBuwswm84x7TpJxe7pkfBwR/C?=
 =?us-ascii?Q?b2euPTA1WRjL/8kB+Vfad1Smww52VwZajj4y9zyTw1JH32PU2yqJCR3eutjK?=
 =?us-ascii?Q?l1HhdwDXJgDWsVCuA6gjRFK0zxT5eMq6n6UhP+bEiXW1dFqT3xrlJUY6GdLs?=
 =?us-ascii?Q?PkiKjsjRJlMfsxcR6qAjglH0BkKEBPZ2sgCCbXfwHfe9qlAKCRxnbt9251M/?=
 =?us-ascii?Q?ghygrLfkYn3QwhlAYurXUzGUIhUgHIi63SoSDUwJKHxupoYvFPti3C22ZlvJ?=
 =?us-ascii?Q?gp8GRXs5FWcd1i8y+up6H6VE8PKKFfLjtaEmFiY4wEPP1zqd2/am2ToGIIkQ?=
 =?us-ascii?Q?HtPqR/QhxZY9Da6Zvnaqz4ZdxGvkZykmYhZFCv6g/wVcVC4kCkRYv8gzX2Vg?=
 =?us-ascii?Q?bHJw2LctPIvOf3fBk9ObqayVhU0k0PF928pfilTa9gREOxglN5VkoRCdbe3r?=
 =?us-ascii?Q?fhMzODJ/9yzDUdUlQ10wezNIuTxsUbmu7AeBwXXcL97TBWJ7Vg2vnoXiVEpd?=
 =?us-ascii?Q?O64Wf/N9Jc2nWR4xNXVU+b3z0/WN0Ux5t+v6MvHdiPgloQHrSecdXJdO7vc9?=
 =?us-ascii?Q?zY9iEyOgPND9dUbZ4CmIpZATfeJP4KqYGx2piSH29wtEzgcVrkthOOjMtjQZ?=
 =?us-ascii?Q?7yhBEqD1Cke8Xy3lz6Wi2RmBhmAL4ZFaB+tzA5Epl2zqP8ZkcgjgW1O6nECE?=
 =?us-ascii?Q?hsTBv8wKy1CDgzmCEohIIHVaYkGupeVi1DSD7ydPUI9tU6En8nzkMKV1gC+m?=
 =?us-ascii?Q?gid9ZXUeKrxfN5punWsAUMwqkL7pw/WDvDMEYHd6E8MjDkxhOgV8lehDqKMx?=
 =?us-ascii?Q?f2YPGv9/lbKkgATkdJyoW/DYj95If5gDARB79ddxV4Puc/bCMBc+IwtgXP66?=
 =?us-ascii?Q?iJRQVhRkuU+n93YX1SUqHq6uwAtvyTA/yr95G5QbSaGzWOYJd+gJJVgQKKQm?=
 =?us-ascii?Q?3/U2NQuRVwxC+6xbSAHtxJc+kwS7ad6JV0zezS+LdfxppITByZJ5MNgE5m/z?=
 =?us-ascii?Q?qOnVaWwPVKExkzShRvfK+gL6BCmtQlCHGMg6BDKcDXQRAfM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79E2F0F82387AA4AB8A4A6CE88793DE5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5001983d-c86c-45e0-d035-08d8ac426cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 21:40:56.1810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKjHiiBirI/kTPp9sjOq4TrXQqVoaNNb/Hh4fQWQE7ZhrntAGsXNTv5BjnvNgz3XuN2NwOkOx/FD54TyKcrQeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_16:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 29, 2020, at 11:32 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Tue, Dec 29, 2020 at 04:23:47PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Tue, Dec 29, 2020 at 04:18:48PM -0300, Arnaldo Carvalho de Melo escre=
veu:
>>> Em Tue, Dec 29, 2020 at 07:11:12PM +0000, Song Liu escreveu:
>>>>> On Dec 29, 2020, at 10:48 AM, Arnaldo Carvalho de Melo <acme@kernel.o=
rg> wrote:
>>>>> I'll check this one to get a patch that at least moves the needle her=
e,
>>>>> i.e. probably we can leave supporting bpf counters in the python bind=
ing
>>>>> for a later step.
>>=20
>>>> Thanks Arnaldo!
>>=20
>>>> Currently, I have:
>>>> 1. Fixed issues highlighted by Namhyung;
>>>> 2. Merged 3/4 and 4/4;
>>>> 3. NOT found segfault;
>>>> 4. NOT fixed python import perf.=20
>=20
> For 3, now with a kprobe:
>=20
> [root@five ~]# bpftool prog | grep hrtimer -A10
> 99: kprobe  name hrtimer_nanosle  tag 0e77bacaf4555f83  gpl
> 	loaded_at 2020-12-29T16:25:34-0300  uid 0
> 	xlated 80B  jited 49B  memlock 4096B
> 	btf_id 253
> [root@five ~]# perf stat -I 1000 -b 99
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> Segmentation fault (core dumped)
> [root@five ~]#
>=20
> (gdb) run stat -I 1000 -b 99
> Starting program: /root/bin/perf stat -I 1000 -b 99
> Missing separate debuginfos, use: dnf debuginfo-install glibc-2.32-2.fc33=
.x86_64
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x000000000056559b in bpf_program_profiler__read (evsel=3D0xc39770) at ut=
il/bpf_counter.c:217
> 217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-=
4.fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod-clien=
t-0.182-1.fc33.x86_64 elfutils-libelf-0.182-1.fc33.x86_64 elfutils-libs-0.1=
82-1.fc33.x86_64 keyutils-libs-1.6-5.fc33.x86_64 krb5-libs-1.18.2-29.fc33.x=
86_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_64 libca=
p-2.26-8.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libcurl-7.71.1-8.fc33.=
x86_64 libgcc-10.2.1-9.fc33.x86_64 libidn2-2.3.0-4.fc33.x86_64 libnghttp2-1=
.41.0-3.fc33.x86_64 libpsl-0.21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86_6=
4 libssh-0.9.5-1.fc33.x86_64 libunistring-0.9.10-9.fc33.x86_64 libunwind-1.=
4.0-4.fc33.x86_64 libuuid-2.36-3.fc33.x86_64 libxcrypt-4.4.17-1.fc33.x86_64=
 libzstd-1.4.5-5.fc33.x86_64 numactl-libs-2.0.14-1.fc33.x86_64 openldap-2.4=
.50-5.fc33.x86_64 openssl-libs-1.1.1i-1.fc33.x86_64 pcre-8.44-2.fc33.x86_64=
 pcre2-10.36-1.fc33.x86_64 perl-libs-5.32.0-464.fc33.x86_64 popt-1.18-2.fc3=
3.x86_64 python3-libs-3.9.1-1.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 xz-libs=
-5.2.5-3.fc33.x86_64
> (gdb) bt
> #0  0x000000000056559b in bpf_program_profiler__read (evsel=3D0xc39770) a=
t util/bpf_counter.c:217
> #1  0x0000000000000000 in ?? ()
> (gdb) p skel->maps.accum_readings
> Cannot access memory at address 0x20
> (gdb) p skel
> $1 =3D (struct bpf_prog_profiler_bpf *) 0x0
> (gdb) list -10
> 202		int reading_map_fd;
> 203		__u32 key =3D 0;
> 204		int err, cpu;
> 205
> 206		if (list_empty(&evsel->bpf_counter_list))
> 207			return -EAGAIN;
> 208
> 209		for (cpu =3D 0; cpu < num_cpu; cpu++) {
> 210			perf_counts(evsel->counts, cpu, 0)->val =3D 0;
> 211			perf_counts(evsel->counts, cpu, 0)->ena =3D 0;
> (gdb)
> 212			perf_counts(evsel->counts, cpu, 0)->run =3D 0;
> 213		}
> 214		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> 215			struct bpf_prog_profiler_bpf *skel =3D counter->skel;
> 216
> 217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
> 218
> 219			err =3D bpf_map_lookup_elem(reading_map_fd, &key, values);
> 220			if (err) {
> 221				fprintf(stderr, "failed to read value\n");
> (gdb) p counter->skel
> $2 =3D (void *) 0x0
> (gdb) p perf_evsel__name(counter)
> No symbol "perf_evsel__name" in current context.
> (gdb) p evsel__name(counter)
> $3 =3D 0xc77420 "unknown attr type: 13078424"
> (gdb) p evsel->type
> There is no member named type.
> (gdb) p evsel->core.
> attr         cpus         fd           id           ids          node    =
     nr_members   own_cpus     sample_id    system_wide  threads
> (gdb) p evsel->core.attr.type
> $4 =3D 1
> (gdb) p evsel->core.attr.config
> $5 =3D 0
> (gdb) p evsel->evlist
> $6 =3D (struct evlist *) 0xc3cfd0
> (gdb) p evsel->evlist->core.nr_entries
> $7 =3D 10
> (gdb)
>=20
>=20
> 10 entries, the default for 'perf stat'
>=20
>=20
> With just one event:
>=20
> (gdb) run stat -e cycles -I 1000 -b 99
> Starting program: /root/bin/perf stat -e cycles -I 1000 -b 99
> Missing separate debuginfos, use: dnf debuginfo-install glibc-2.32-2.fc33=
.x86_64
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x000000000056559b in bpf_program_profiler__read (evsel=3D0xc392c0) at ut=
il/bpf_counter.c:217
> 217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
> Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-=
4.fc33.x86_64 cyrus-sasl-lib-2.1.27-6.fc33.x86_64 elfutils-debuginfod-clien=
t-0.182-1.fc33.x86_64 elfutils-libelf-0.182-1.fc33.x86_64 elfutils-libs-0.1=
82-1.fc33.x86_64 keyutils-libs-1.6-5.fc33.x86_64 krb5-libs-1.18.2-29.fc33.x=
86_64 libbabeltrace-1.5.8-3.fc33.x86_64 libbrotli-1.0.9-3.fc33.x86_64 libca=
p-2.26-8.fc33.x86_64 libcom_err-1.45.6-4.fc33.x86_64 libcurl-7.71.1-8.fc33.=
x86_64 libgcc-10.2.1-9.fc33.x86_64 libidn2-2.3.0-4.fc33.x86_64 libnghttp2-1=
.41.0-3.fc33.x86_64 libpsl-0.21.1-2.fc33.x86_64 libselinux-3.1-2.fc33.x86_6=
4 libssh-0.9.5-1.fc33.x86_64 libunistring-0.9.10-9.fc33.x86_64 libunwind-1.=
4.0-4.fc33.x86_64 libuuid-2.36-3.fc33.x86_64 libxcrypt-4.4.17-1.fc33.x86_64=
 libzstd-1.4.5-5.fc33.x86_64 numactl-libs-2.0.14-1.fc33.x86_64 openldap-2.4=
.50-5.fc33.x86_64 openssl-libs-1.1.1i-1.fc33.x86_64 pcre-8.44-2.fc33.x86_64=
 pcre2-10.36-1.fc33.x86_64 perl-libs-5.32.0-464.fc33.x86_64 popt-1.18-2.fc3=
3.x86_64 python3-libs-3.9.1-1.fc33.x86_64 slang-2.3.2-8.fc33.x86_64 xz-libs=
-5.2.5-3.fc33.x86_64
> (gdb) bt
> #0  0x000000000056559b in bpf_program_profiler__read (evsel=3D0xc392c0) a=
t util/bpf_counter.c:217
> #1  0x0000000000000000 in ?? ()
> (gdb) p evsel->name
> $1 =3D 0xc37960 "cycles"
> (gdb) p evsel->bpf_counter_
> bpf_counter_list  bpf_counter_ops
> (gdb) p evsel->bpf_counter_ops
> $2 =3D (struct bpf_counter_ops *) 0xa08ec0 <bpf_program_profiler_ops>
> (gdb) p evsel->bpf_counter_
> bpf_counter_list  bpf_counter_ops
> (gdb) p evsel->bpf_counter_list
> $3 =3D {next =3D 0xc36e18, prev =3D 0xc36e18}
> (gdb) p evsel->s
> sample_size        side_band          stats              supported       =
   synth_sample_type
> (gdb) list -5
> 207			return -EAGAIN;
> 208
> 209		for (cpu =3D 0; cpu < num_cpu; cpu++) {
> 210			perf_counts(evsel->counts, cpu, 0)->val =3D 0;
> 211			perf_counts(evsel->counts, cpu, 0)->ena =3D 0;
> 212			perf_counts(evsel->counts, cpu, 0)->run =3D 0;
> 213		}
> 214		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> 215			struct bpf_prog_profiler_bpf *skel =3D counter->skel;
> 216
> (gdb)
> 217			reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
> 218
> 219			err =3D bpf_map_lookup_elem(reading_map_fd, &key, values);
> 220			if (err) {
> 221				fprintf(stderr, "failed to read value\n");
> 222				return err;
> 223			}
> 224
> 225			for (cpu =3D 0; cpu < num_cpu; cpu++) {
> 226				perf_counts(evsel->counts, cpu, 0)->val +=3D values[cpu].counter;
> (gdb) p counter->skel
> $4 =3D (void *) 0x0
> (gdb)
>=20
> skel is NULL?!

So it is skel =3D=3D NULL. In v7 (coming soon), I fixed some issues in the=
=20
allocate/free of skel, and added some assert(). Let's see how that goes..

Thanks,
Song

>=20
> I ran out of time, have to go errands now. will bbl.
>=20
> - Arnaldo
>=20
>>>> I don't have good ideas with 3 and 4... Shall I send current code as v=
7?
>>=20
>>> For 4, please fold the patch below into the relevant patch, we don't
>>> need bpf_counter.h included in util/evsel.h, you even added a forward
>>> declaration for that 'struct bpf_counter_ops'.
>>=20
>>> And in general we should refrain from adding extra includes to header
>>> files, .h-ell is not good.
>>>=20
>>> Then we provide a stub for that bpf_counter__destroy() so that
>>> util/evsel.o when linked into the perf python biding find it there,
>>> links ok.
>>=20
>> Ok, one more stub is needed, I wasn't building all the time with=20
>>=20
>>  $ make BUILD_BPF_SKEL=3D1
>>=20
>> Ditch the previous patch please, use the one below instead:
>>=20
>> - Arnaldo
>>=20
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 40e3946cd7518113..8226b1fefa8cf2a3 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -10,7 +10,6 @@
>> #include <internal/evsel.h>
>> #include <perf/evsel.h>
>> #include "symbol_conf.h"
>> -#include "bpf_counter.h"
>> #include <internal/cpumap.h>
>>=20
>> struct bpf_object;
>> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
>> index cc5ade85a33fc999..278abecb5bdfc0d2 100644
>> --- a/tools/perf/util/python.c
>> +++ b/tools/perf/util/python.c
>> @@ -79,6 +79,27 @@ int metricgroup__copy_metric_events(struct evlist *ev=
list, struct cgroup *cgrp,
>> 	return 0;
>> }
>>=20
>> +/*
>> + * XXX: All these evsel destructors need some better mechanism, like a =
linked
>> + * list of destructors registered when the relevant code indeed is used=
 instead
>> + * of having more and more calls in perf_evsel__delete(). -- acme
>> + *
>> + * For now, add some more:
>> + *
>> + * Not to drag the BPF bandwagon...
>> + */
>> +void bpf_counter__destroy(struct evsel *evsel);
>> +int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
>> +
>> +void bpf_counter__destroy(struct evsel *evsel __maybe_unused)
>> +{
>> +}
>> +
>> +int bpf_counter__install_pe(struct evsel *evsel __maybe_unused, int cpu=
 __maybe_unused, int fd __maybe_unused)
>> +{
>> +	return 0;
>> +}
>> +
>> /*
>>  * Support debug printing even though util/debug.c is not linked.  That =
means
>>  * implementing 'verbose' and 'eprintf'.
>=20
> --=20
>=20
> - Arnaldo

