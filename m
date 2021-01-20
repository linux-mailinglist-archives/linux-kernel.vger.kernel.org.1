Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F5B2FD5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391724AbhATQqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:46:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53778 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391658AbhATQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:41:48 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10KGZkwM014246;
        Wed, 20 Jan 2021 08:40:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=k2LF97/X/kWI6KvYhF//ZtP0vU2NMxeXIkXcNBub9CE=;
 b=IPhPsk7FbW/9V+uVYvvCcxfEpXSbfpjddIJx2JBlh3PuEYM/yT/rYpkjsX8SlamUCYdU
 VO3WmSGBn6nXz6HGl+a64PoODuG+O2YXEkbeGM+Uk43n9zbZs/WestOoOKdIcUyJmPHd
 wZYy9i0K3qpEXbxvJ9wcpC50TIdOIQDqm58= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3668qxvg39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 Jan 2021 08:40:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 08:40:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA2DpEmCHiSfNhZTjVxkLK5UgWj7s3jS7b5etySaH0ExBVb53siJKM7FQw2Auq2+Wx2P6rLHIPMvwI4NSuacPBYhHmNrME2TefLz585cga4axyq7+3Ev+iabePVFyRF9tZVOJg8uwkR+VBNMkDnb51a4S6hMbqD59b1NLy2qgBOSL2IjNH6U8a2zjBhWzXxSim5O6X/LPnX2jYp/jIS35Bql5vGlwWdmdHtXjLUR6RyEVPzlnha221dT6OsAsYH0K5GluY7pTkuXO2NOXwZk0Zhd4SNmJv8KVmEqmUv2whHzntDVauyLofiObQ4u5spgB9u8Ro9MmYkcyZzlEjk2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2LF97/X/kWI6KvYhF//ZtP0vU2NMxeXIkXcNBub9CE=;
 b=GKWMAsq71zcsdvxiTOpqwgqc1k88Oz3ysOXyb1SwXbhAdPmXvcTRnhK50lSIjU3c4AhclZOgtpTPu2ew4U4lcJJ/MxapShez3gG2SQ5bvASzXvuGGVnbqD3y/YSOGzHSQW1qhw4M5GcchQrLdl73PclUbKhPHoubB5H9nQsIDkWOHGva+31PHknkWRJdTNvG0G8i0zCExpf+OgJROtq5EmWk8K2/7lkfHRzo+wX1pstlDK3dfwVvwIwRYr4CBcryRi1rSsCCeM7u4bjoCUGiAJyPySIHx6uy4oCFwlRX5uMqWQa0V+ly5eL3/jfY3/WOE7r9JhXXxRxA2Ka8J75ybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2LF97/X/kWI6KvYhF//ZtP0vU2NMxeXIkXcNBub9CE=;
 b=C+16eunAkwXap7f2XAatyC6CkCierMv0b3f0XXTUlPVv7abu6tgOUSlVM4MlBoW0TdkKeDofHfkwJbAYaKLLFK6cSUBmjOxcrO9Zb9EmwMC1YPUfyrL3/D2rQ4h40sSssmVSc5JbrGPhdrTmYLrrLxx14LPOuX+B1XHzbqyjVtE=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB4291.namprd15.prod.outlook.com (2603:10b6:a03:1fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 16:40:46 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 16:40:46 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: FIX Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF
 programs
Thread-Topic: FIX Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHW3iuRYm1YXRRzOkq8jjAuk5Kmsqot5piAgABWngCAAOYQgIAAAxqAgAAeVYCAAFpfAIAACeyAgADsroCAAAbAgIAADZSAgAAsyoCAAALdAA==
Date:   Wed, 20 Jan 2021 16:40:46 +0000
Message-ID: <498F663D-B3D5-4339-B076-B8D24FFD8B9A@fb.com>
References: <20210118193817.GG12699@kernel.org>
 <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
 <20210119143143.GJ12699@kernel.org> <20210119144249.GK12699@kernel.org>
 <20210119163123.GM12699@kernel.org>
 <417ABE57-E527-4944-BE16-35AB92D071E9@fb.com>
 <20210119223021.GO12699@kernel.org> <20210120123727.GR12699@kernel.org>
 <20210120130137.GS12699@kernel.org> <20210120135013.GT12699@kernel.org>
 <20210120163031.GU12699@kernel.org>
In-Reply-To: <20210120163031.GU12699@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ad14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63f89e0f-be06-4d6e-0f72-08d8bd622333
x-ms-traffictypediagnostic: BY5PR15MB4291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB4291A81B7358A1DB3757B31CB3A20@BY5PR15MB4291.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BuH7cYPvyiebFKUqM0TOH74vh+WLadHPb3d+nOduAYypugziu1dcXwwRKQ15ki4PnJC+RnPplcUD18J0AnbAU1RYrJN7DQu+gW9H39P0luyErmmbsdTJTkTiIZF6EZ8XsLsYSkGCfkQavQfkDUMjv5CcoHupsLuoTkekPle1uM6OySZcSTZG7e8Gp60XVJscK2pJZQVyUI28J+hGOgiJzGNNw4D4DwjtUoI1rFZzTQhwbDj3eA2u0nWvSkEyamhm2BSaNaakHxNMmOgk7ugm2y/IV3UF/wJQ2bAELtPXcY3yPveUKh8gvHHxCnMJaP5y0/6BsXz6FLEkmjNv8+RrOLdPgX6IOnRrJ2sTyhBwQgweOq8fmGBWJZCAZ/gJLh2ROVu0PKp0oUEUkGwnWMJa8b27taucWs+nSJ2WoVmPQWFsu5RpwyIQjdQXtJFwTvCp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(396003)(39860400002)(86362001)(5660300002)(76116006)(91956017)(36756003)(53546011)(316002)(54906003)(64756008)(6506007)(2616005)(6486002)(8936002)(186003)(33656002)(6512007)(4326008)(8676002)(6916009)(478600001)(83380400001)(66476007)(71200400001)(2906002)(66446008)(66556008)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EZIDSBH3O5Eb5tQBKVb1ZDJwykLFT1NGqWezaSdEVdGvnJTgcCIKgZFn1r6D?=
 =?us-ascii?Q?yELMDxQ9Yhvtmr9FbUb4tNIs7rTDpblcsnXR8/fhEEC1mphJ5KP4AP3PP7JV?=
 =?us-ascii?Q?CcZcC9uEwJA69quUzay6GwX/aqpM9+xVtKLrdhTR6MR/NoIqqMxUo/Wl1ZCu?=
 =?us-ascii?Q?1lT4RYW6PS9ZpSQ8CtpyNooV12217SPz7rIZkT8Jk9WXCgWXr0rm4TYzh1PO?=
 =?us-ascii?Q?j82bi5Ps7wqhCMr2ol0133arDh9y7m8lWKa37ycaBg/2m+iuo9lWoPAvDlrC?=
 =?us-ascii?Q?xgIq11ih4tdqq4raOJxHvkZi14nCzv2ILmW/JW376KnNTDo95cnjkbfxLBVa?=
 =?us-ascii?Q?RA5OqfUaNnmA4tUnshr8/biVqrY6399mKHzITSnTBwAupLhZbnDCJFTS7lrT?=
 =?us-ascii?Q?6GdMQJGsfnzCSwRLgW/BACeLcjpC/DrLqMyLQyoLTjqPgzr3t5s6KeAsTe4K?=
 =?us-ascii?Q?DkLQu0n/iyoQSkYT2A9OT2jv0Uwt03gWn2Yo0X+Ei2eKz3tFwWrz/GY1Idca?=
 =?us-ascii?Q?2kaNy2XLvla7AF3s32ULJSeOD6Tx7lhH2AOhKiaiInCcWN+J122Ew8Hx+M9D?=
 =?us-ascii?Q?xDAw9P47nD/we9I5bvc4QJ7sC34Hh/XqfkkAsNYWUPdIapeSBfWi7pyCFU/q?=
 =?us-ascii?Q?pHuiId1IN7ph9WubcThNnQ2R9OqY6T8uW4Vp4cf7yMXjxy/HJH9RuyOjFOiy?=
 =?us-ascii?Q?2dVcACe/w7W0aCq3ex8wiEnNszwWaTyXNAYyMBedcx3zgHbhBt2snczsJDCr?=
 =?us-ascii?Q?KMahFUy/X5RQ4oYnOyjwS1OFXkuNhNZQgPd7MFrywCl7699AKV05/akbySnt?=
 =?us-ascii?Q?L3wcnthr5RGX33hL3QYZ38fX6PD4HdaO0xvazNwtjW+g+enYhFHetI+Ds7Yb?=
 =?us-ascii?Q?ig0ONMtGgFbGFotGo2e6fCdzMLVvCgmYoJNoP6TEEarAPWTtjyJ83G++Ca2D?=
 =?us-ascii?Q?y9Wai6HEOSCjMbZfR8yIWDQmPrf3lbyMUgkUqq/MbgYuwEIAZ8f4fOLc4Bzd?=
 =?us-ascii?Q?L6FtTTPw2rZW1UPKeBUjmcfJyL6Rg16GStBzj0k22y2UxAuhhNDm83nyqFiz?=
 =?us-ascii?Q?MR2DVt0/btTk7A3s5Q7Kadt8UvOq87M+3+KOHval/piHFmOyDDg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90C8467B31B7DE459997AE423FC14C39@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f89e0f-be06-4d6e-0f72-08d8bd622333
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 16:40:46.6879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vP9Lby0aFmt+T9hnN9jvsteAxKMwZIHWSOQCqOm8K2/rUiTi0akC1aja6O62jaqynhhkPQlM8XmXh+X7UC17MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB4291
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_10:2021-01-20,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200097
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2021, at 8:30 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Wed, Jan 20, 2021 at 10:50:13AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> So sizeof(struct bpf_perf_event_value) =3D=3D 24 and it is a per-cpu arr=
ay, the
>> machine has 24 cpus, why is the kernel thinking it has more and end up z=
eroing
>> entries after the 24 cores? Some percpu map subtlety (or obvious thing ;=
-\) I'm
>> missing?
>>=20
>> Checking lookups into per cpu maps in sample code now...
>=20
> (gdb) run stat -b 244 -I 1000 -e cycles
> Starting program: /root/bin/perf stat -b 244 -I 1000 -e cycles
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
>=20
> Breakpoint 1, bpf_program_profiler__read (evsel=3D0xce02c0) at util/bpf_c=
ounter.c:217
> 217		if (list_empty(&evsel->bpf_counter_list))
> (gdb) p num_
> num_cpu              num_groups           num_leaps            num_print_=
iv         num_stmts            num_transitions      num_warnings_issued
> num_cpu_bpf          num_ifs              num_print_interval   num_srcfil=
es         num_to_str           num_types
> (gdb) p num_cpu
> $1 =3D 24
> (gdb) p num_cpu_bpf
> $2 =3D 32
> (gdb)
>=20
> Humm, why?
>=20
> But then libbpf and the sample/bpf/ code use it this way:
>=20
>=20
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.=
c
> index 8c977f038f497fc1..7dd3d57aba4f620c 100644
> --- a/tools/perf/util/bpf_counter.c
> +++ b/tools/perf/util/bpf_counter.c
> @@ -207,7 +207,8 @@ static int bpf_program_profiler__enable(struct evsel =
*evsel)
> static int bpf_program_profiler__read(struct evsel *evsel)
> {
> 	int num_cpu =3D evsel__nr_cpus(evsel);
> -	struct bpf_perf_event_value values[num_cpu];
> +	int num_cpu_bpf =3D libbpf_num_possible_cpus();
> +	struct bpf_perf_event_value values[num_cpu > num_cpu_bpf ? num_cpu : nu=
m_cpu_bpf];
> 	struct bpf_counter *counter;
> 	int reading_map_fd;
> 	__u32 key =3D 0;
>=20
> -------------------------------------------------------------
>=20
> [root@five ~]# cat /sys/devices/system/cpu/possible
> 0-31
> [root@five ~]#
>=20
> I bet that in your test systems evsel__nr_cpus(evsel) matches
> /sys/devices/system/cpu/possible and thus you don't see the problem.

Thanks Arnaldo!

Yes, my system have same online and possible CPUs.=20

Since possible_cpu >=3D online_cpu, maybe we can use num_cpu_bpf in=20
bpf_program_profiler__read() without he extra check?=20

Song

[...]=
