Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7272FC2E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbhASV5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:57:55 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbhASVzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:55:49 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10JLh99l016747;
        Tue, 19 Jan 2021 13:54:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=QfCP3QQ8fvJftwrGJURRHBokkEvyO9fGWqAdo+1Yy+k=;
 b=PswqMnF1xQmQNdT6mGLm2nwkGCSvF/tEpdCsTKGO+zzDTmeFkWJYcMOKkCbcOD4YVzS+
 au+aGoGRuXCDViunZ5MlfR4CnP7WXrpKeTMdNDhxEjTO+622zsMBN3FjtWua7UMV6iVi
 Xz4wRzF1e+LCcpIHI7warrg8wGqHNRkkd+A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 364h3bkr63-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Jan 2021 13:54:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 19 Jan 2021 13:54:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFXO5bqBNTt+gAX+XuHNWpYiJAf1LrNnFz2SxGPpDsxLh4OKGot53Uiq+N2eSNS5H1JfAid7J9we4eVVdwSq3yNOtU7OpPTjc19W29a+wCyameUhxDQAUaFQ1pbRwUYmZ3PersxUOiRlQilThIPCtelwlAxBx06/zLhIZ0cf94iQw/Ao4ncdXW/ToAzHu31cQbJ+ORKpJkhCSfTMNjwNGnLFLJ4aBw5prxdBNwsABZT/FzhQ4eWKodHQbLEThDiKJBYTiCYYltNyjYKcn5U/rX84C5gWEo6texJPiTFmKzWTXE7pg+5n4CnsquaBuJyMT1+1fELOW8KC6pnZbgbNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfCP3QQ8fvJftwrGJURRHBokkEvyO9fGWqAdo+1Yy+k=;
 b=dSqE7D+YG04n32dtuzXaAHw+LMdC2bmTtP4xlgXaAacyVY9ajG7uSUfR2+JZHibiS+GKnyRUFry6+nrIFy9RvNfrQL+2lSjnKZ5zMMDsQKlRM4hzZh2IH2/papJCO+OgyPxp0TmZ0O4AK8agfo+zLXTNkAZZuT7cIW7dUnhotH83arbt6QWRUS237b/nuJt+UoHre5a2LTS/QeLSVH3oQ8FdO39ABItp6GoCboZ0tIL6Eme3lYYkiXWx1nkFYP14Xjp5PZfOPaFr/N+UOID/nra+Sagr7anjte5OAcQbyz2RP+5iHSTQ2IAoSE2Pnm0UMbRrYL/+S6K10gWvM4DPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfCP3QQ8fvJftwrGJURRHBokkEvyO9fGWqAdo+1Yy+k=;
 b=Z/uwkuKQxUonfV2d4jLh21fJdQUWiflWqa6KYxDvJ+X1tOdPoMOLwBJvM0m/vsGLhRnJzUT//JQKIi+mV1XgpQrIpJniUaWWnPzF/SWfjgN5crSuY4avo3bkKE0cW5gJiJB4ZaODFr8UUrxHX4pvDoJzlW88eD3JRIrCe8UXdAE=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2952.namprd15.prod.outlook.com (2603:10b6:a03:f9::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Tue, 19 Jan
 2021 21:54:50 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.010; Tue, 19 Jan 2021
 21:54:50 +0000
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
Subject: Re: [PATCH v7 3/3] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v7 3/3] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHW3iuRYm1YXRRzOkq8jjAuk5Kmsqot5piAgABWngCAAOYQgIAAAxqAgAAeVYCAAFpfAA==
Date:   Tue, 19 Jan 2021 21:54:50 +0000
Message-ID: <417ABE57-E527-4944-BE16-35AB92D071E9@fb.com>
References: <20201229214214.3413833-1-songliubraving@fb.com>
 <20201229214214.3413833-4-songliubraving@fb.com>
 <20210118193817.GG12699@kernel.org>
 <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
 <20210119143143.GJ12699@kernel.org> <20210119144249.GK12699@kernel.org>
 <20210119163123.GM12699@kernel.org>
In-Reply-To: <20210119163123.GM12699@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ad14]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89f8d7a6-8ff3-4359-3971-08d8bcc4d8ad
x-ms-traffictypediagnostic: BYAPR15MB2952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB29520A8205BEC05CB898E727B3A30@BYAPR15MB2952.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhG+MNCX6q2ulI70W+hkiLVcc6PXWzRstObsJpecdzzug5FzmAo/sZLkNnTuitPswP3iBUI7p0PgbRQkmO7CvIkNO6hHH4zo59bU7H5S+TURovoXs4z8Si8136ad5CHCDqog4OkpiE4znJJuGkZde/0c5hi83RKwJe/CV6IeNO3M3K/uCidGw2OLPwzOaoox6Fthn2oHpyF1h7ZvAmX6we6OiUY4FU5h6HHJCv9kefdDesgrymFoDEDNaj1SWmx3rYQZkFBOM0CPCWW4m6f4j0DfzoJnbfbHhtQ4l8EGeWuLk69ASMSek17zmoyxxlvPYc0/O5ZXndYjCyWLdNz+Q7heohiZNy59B7xxSsvfA4GJcQXkuyFcZ0AN419yVpLF0JiLPIILkCcqtM0mgCcW3tHdlxjPk/O69Z1q5SKMXOE/os+a36Vqlo5/oac0Db53
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39860400002)(366004)(346002)(54906003)(5660300002)(71200400001)(8676002)(186003)(4326008)(316002)(6486002)(53546011)(6512007)(86362001)(478600001)(6506007)(2616005)(83380400001)(2906002)(8936002)(6916009)(36756003)(66446008)(76116006)(33656002)(64756008)(66946007)(66556008)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?W7plbRDv/Kh56uEYNCQTArqFSlZBTUKeqd3zj/ssUnDkTPZxSFo2z+dMsoZX?=
 =?us-ascii?Q?7/OVWtXmTSHDDTeDUFia2rZY7CLTa2L1XwnWNoF6EGEe5GU/fz5BBIfuTS2J?=
 =?us-ascii?Q?uJq3VowRXYt1L1DuXL7NA0p1oqTGHhRTBLRBrssUagXnGvj3rA26GWPSlFCj?=
 =?us-ascii?Q?uNeINxu049pv9Kx+pv75Bz/nLqMNSy8UPe1fpnFMzIXGZHZeWxKcjWqjNgxV?=
 =?us-ascii?Q?2Sc9k/wF//wlcHd5KJF4ANCNFEdmZmi8p2k0GsD9rhZrQr8sNCwI7NM6A209?=
 =?us-ascii?Q?gru3C2/Sm9CfOYNquFjk8j16LKFx4levAGC2T+0jix52gaCKEnBIAdBK9FRo?=
 =?us-ascii?Q?9e2KNaiYGpJ5prgloVIcxH77r6SJ1BFJVGUA+YSDIOyxB7+GZXsYQaw2snXE?=
 =?us-ascii?Q?x/sAvUwP2P8tYoUMq0BEGeWqHOcJ+F/AYiAc2m92glZncFtO5KhS5PcDCeBi?=
 =?us-ascii?Q?R4FjMbd9owG88mCL6QbTzwcqT6lRPglS8sl+7ghKiWet80kcwh3sJEcck0uR?=
 =?us-ascii?Q?FWX35s/9EJTXwUM5SvHZCya4+sqz/EAWEz2LheRkap6hjs2BjrDbD6EA2gMG?=
 =?us-ascii?Q?LLpkg8iRZNIlQOxFoE9H97o0x2LDmFmGJoQvBZkMBAAST63omS2c6k/NDRYS?=
 =?us-ascii?Q?c6TTY68VWaBgSOEYiDmdWexoB8Ai+i4kErOBaB5EsHz59/V4F382l4/R6MAG?=
 =?us-ascii?Q?W5A2y0PwVA9TU/W50D8fa14/dJW5QjixDMnO8TYDDk4o3UjpvNFGN0NeWfAa?=
 =?us-ascii?Q?UfiYH6iIjCei+ATlO4Aii+diLKSDuNVDt1HLxLbvW7H7SnGMlG4O9eqQ2KtV?=
 =?us-ascii?Q?ZdPApVO9aoJL6JR9TENHPWmDiiIHNEV2Bm/Y6GtxAt+ediKcDRWjgUfsN5An?=
 =?us-ascii?Q?hzNMdL5wxCnQ+7yy6YV/pHZlNTx471FjId75sJ/0EPaVA0M89ldvPJHVf9f0?=
 =?us-ascii?Q?2FaIOeS6E1cbKfeT70s8B989rvFUbHmpG0VizkRMXrpMkvGEDzWxJedgTlPc?=
 =?us-ascii?Q?KihmvziGeS3pJm/NclDeusBUQ7k06WlN8vPJ3H6g6Dj8O9jkkJhPhBbvEvz4?=
 =?us-ascii?Q?WU9VxAw6LaLnrI+2azoDe7siVVwx6eTmG5MDu2RL6HcwEqPzj4c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <053F96DABC8B10499CB79C75C357BFED@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f8d7a6-8ff3-4359-3971-08d8bcc4d8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 21:54:50.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QHsQyada/YKJuNquUjcsVkoCIK1NfHInbukyOobxW5QMWAoIKggJKrjYEimdyFWecU62daEHkzBwdjAg1sNj2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2952
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-19_12:2021-01-18,2021-01-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 19, 2021, at 8:31 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Tue, Jan 19, 2021 at 11:42:49AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
>> Em Tue, Jan 19, 2021 at 11:31:44AM -0300, Arnaldo Carvalho de Melo escre=
veu:
>>> Em Tue, Jan 19, 2021 at 12:48:19AM +0000, Song Liu escreveu:
>>>>> On Jan 18, 2021, at 11:38 AM, Arnaldo Carvalho de Melo <acme@kernel.o=
rg> wrote:
>>>> We are looking at two issues:
>>>> 1. Cannot recursively attach;
>>>> 2. prog FD 3 doesn't have valid btf.=20
>>=20
>>>> #1 was caused by the verifier disallowing attaching fentry/fexit progr=
am=20
>>>> to program with type BPF_PROG_TYPE_TRACING (in bpf_check_attach_target=
).=20
>>>> This constraint was added when we only had fentry/fexit in the TRACING
>>>> type. We have extended the TRACING type to many other use cases, like=
=20
>>>> "tp_btf/", "fmod_ret" and "iter/". Therefore, it is good time to revis=
it=20
>>>> this constraint. I will work on this.=20
>>=20
>>>> For #2, we require the target program to have BTF. I guess we won't re=
move
>>>> this requirement.
>>=20
>>>> While I work on improving #1, could you please test with some kprobe=20
>>>> programs? For example, we can use fileslower.py from bcc.=20
>>=20
>>> Sure, and please consider improving the error messages to state what yo=
u
>>> described above.
>>=20
>> Terminal 1:
>>=20
>> [root@five perf]# perf trace -e 5sec.c
>> ^C
>> [root@five perf]# cat 5sec.c
>> #include <bpf.h>
>>=20
>> #define NSEC_PER_SEC	1000000000L
>>=20
>> int probe(hrtimer_nanosleep, rqtp)(void *ctx, int err, long long sec)
>> {
>> 	return sec / NSEC_PER_SEC =3D=3D 5;
>> }
>>=20
>> license(GPL);
>> [root@five perf]# perf trace -e 5sec.c/max-stack=3D16/
>>     0.000 sleep/3739435 perf_bpf_probe:hrtimer_nanosleep(__probe_ip: -17=
43337312, rqtp: 5000000000)
>>                                       hrtimer_nanosleep ([kernel.kallsym=
s])
>>                                       common_nsleep ([kernel.kallsyms])
>>                                       __x64_sys_clock_nanosleep ([kernel=
.kallsyms])
>>                                       do_syscall_64 ([kernel.kallsyms])
>>                                       entry_SYSCALL_64_after_hwframe ([k=
ernel.kallsyms])
>>                                       __clock_nanosleep_2 (/usr/lib64/li=
bc-2.32.so)
>>=20
>>=20
>> Terminal 2:
>>=20
>> [root@five ~]# perf stat -e cycles -b 180 -I 1000
>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
>> perf: util/bpf_counter.c:227: bpf_program_profiler__read: Assertion `ske=
l !=3D NULL' failed.
>> Aborted (core dumped)
>=20
> Out to lunch, will continue later, but this may help you figure this out
> till then :)
>=20
> Starting program: /root/bin/perf stat -e cycles -b 244 -I 1000
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib64/libthread_db.so.1".
>=20
> Breakpoint 1, bpf_program_profiler_load_one (evsel=3D0xce02c0, prog_id=3D=
244) at util/bpf_counter.c:96
> 96	{
> (gdb) n
> 104		prog_fd =3D bpf_prog_get_fd_by_id(prog_id);
> (gdb)=20
> 105		if (prog_fd < 0) {
> (gdb)=20
> 109		counter =3D bpf_counter_alloc();
> (gdb)=20
> 110		if (!counter) {
> (gdb) n
> 115		skel =3D bpf_prog_profiler_bpf__open();
> (gdb) p counter
> $9 =3D (struct bpf_counter *) 0xce09e0
> (gdb) p *counter
> $10 =3D {skel =3D 0x0, list =3D {next =3D 0xce09e8, prev =3D 0xce09e8}}
> (gdb) p *counter
> $11 =3D {skel =3D 0x0, list =3D {next =3D 0xce09e8, prev =3D 0xce09e8}}
> (gdb) n
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> 116		if (!skel) {
> (gdb)=20
> 121		skel->rodata->num_cpu =3D evsel__nr_cpus(evsel);
> (gdb)=20
> 123		bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
> (gdb)=20
> 124		bpf_map__resize(skel->maps.fentry_readings, 1);
> (gdb)=20
> 125		bpf_map__resize(skel->maps.accum_readings, 1);
> (gdb)=20
> 127		prog_name =3D bpf_target_prog_name(prog_fd);
> (gdb)=20
> 128		if (!prog_name) {
> (gdb)=20
> 133		bpf_object__for_each_program(prog, skel->obj) {
> (gdb)=20
> 134			err =3D bpf_program__set_attach_target(prog, prog_fd, prog_name);
> (gdb)=20
> 135			if (err) {
> (gdb)=20
> 133		bpf_object__for_each_program(prog, skel->obj) {
> (gdb) p evsel
> $12 =3D (struct evsel *) 0xce02c0
> (gdb) p evsel->name
> $13 =3D 0xce04e0 "cycles"
> (gdb) n
> 134			err =3D bpf_program__set_attach_target(prog, prog_fd, prog_name);
> (gdb)=20
> 135			if (err) {
> (gdb)=20
> 133		bpf_object__for_each_program(prog, skel->obj) {
> (gdb)=20
> 141		set_max_rlimit();
> (gdb)=20
> 142		err =3D bpf_prog_profiler_bpf__load(skel);
> (gdb)=20
> 143		if (err) {
> (gdb)=20
> 148		assert(skel !=3D NULL);
> (gdb)=20
> 149		counter->skel =3D skel;
> (gdb)=20
> 150		list_add(&counter->list, &evsel->bpf_counter_list);
> (gdb) c
> Continuing.
>=20
> Breakpoint 4, bpf_program_profiler__install_pe (evsel=3D0xce02c0, cpu=3D0=
, fd=3D3) at util/bpf_counter.c:247
> 247	{
> (gdb) n
> 252		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> (gdb)=20
> 253			skel =3D counter->skel;
> (gdb) watch counter->skel
> Hardware watchpoint 6: counter->skel
> (gdb) p counter->skel
> $14 =3D (void *) 0xce0a00
> (gdb) n
> 254			assert(skel !=3D NULL);
> (gdb) p skel
> $15 =3D (struct bpf_prog_profiler_bpf *) 0xce0a00
> (gdb) c
> Continuing.
>=20
> Hardware watchpoint 6: counter->skel
>=20
> Old value =3D (void *) 0xce0a00
> New value =3D (void *) 0x0
> 0x00000000005cf45e in bpf_program_profiler__install_pe (evsel=3D0xce02c0,=
 cpu=3D0, fd=3D3) at util/bpf_counter.c:252
> 252		list_for_each_entry(counter, &evsel->bpf_counter_list, list) {

So it was the list operation that set counter->skel to NULL? I am really co=
nfused...

Song

> (gdb) info b
> Num     Type           Disp Enb Address            What
> 1       breakpoint     keep y   0x00000000005ceb44 in bpf_program_profile=
r_load_one at util/bpf_counter.c:96
> 	breakpoint already hit 1 time
> 2       breakpoint     keep y   0x00000000005cef2e in bpf_program_profile=
r__enable at util/bpf_counter.c:192
> 3       breakpoint     keep y   0x00000000005cf00a in bpf_program_profile=
r__read at util/bpf_counter.c:208
> 4       breakpoint     keep y   0x00000000005cf3ba in bpf_program_profile=
r__install_pe at util/bpf_counter.c:247
> 	breakpoint already hit 1 time
> 5       breakpoint     keep y   0x00000000005ce8d4 in bpf_program_profile=
r__destroy at util/bpf_counter.c:47
> 6       hw watchpoint  keep y                      counter->skel
> 	breakpoint already hit 1 time
> (gdb) p evsel
> $16 =3D (struct evsel *) 0xce02c0
> (gdb) bt
> #0  0x00000000005cf45e in bpf_program_profiler__install_pe (evsel=3D0xce0=
2c0, cpu=3D0, fd=3D3) at util/bpf_counter.c:252
> #1  0x00000000005cf4f3 in bpf_counter__install_pe (evsel=3D0xce02c0, cpu=
=3D0, fd=3D3) at util/bpf_counter.c:276
> #2  0x00000000004f3ef1 in evsel__open_cpu (evsel=3D0xce02c0, cpus=3D0xce0=
500, threads=3D0xce75c0, start_cpu=3D0, end_cpu=3D1) at util/evsel.c:1792
> #3  0x00000000004f4aa7 in evsel__open_per_cpu (evsel=3D0xce02c0, cpus=3D0=
xce0500, cpu=3D0) at util/evsel.c:1996
> #4  0x000000000057f6f2 in create_perf_stat_counter (evsel=3D0xce02c0, con=
fig=3D0xa97860 <stat_config>, target=3D0xa97660 <target>, cpu=3D0) at util/=
stat.c:568
> #5  0x0000000000435d96 in __run_perf_stat (argc=3D0, argv=3D0x7fffffffdb6=
0, run_idx=3D0) at builtin-stat.c:790
> #6  0x00000000004367e3 in run_perf_stat (argc=3D0, argv=3D0x7fffffffdb60,=
 run_idx=3D0) at builtin-stat.c:1001
> #7  0x0000000000439e35 in cmd_stat (argc=3D0, argv=3D0x7fffffffdb60) at b=
uiltin-stat.c:2415
> #8  0x00000000004cf058 in run_builtin (p=3D0xaabe00 <commands+288>, argc=
=3D7, argv=3D0x7fffffffdb60) at perf.c:312
> #9  0x00000000004cf2c5 in handle_internal_command (argc=3D7, argv=3D0x7ff=
fffffdb60) at perf.c:364
> #10 0x00000000004cf40c in run_argv (argcp=3D0x7fffffffd9ac, argv=3D0x7fff=
ffffd9a0) at perf.c:408
> #11 0x00000000004cf7d8 in main (argc=3D7, argv=3D0x7fffffffdb60) at perf.=
c:538
> (gdb) n
> 261		return 0;
>=20

