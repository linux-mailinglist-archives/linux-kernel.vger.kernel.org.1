Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075A92FAE31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 01:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbhASAtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 19:49:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1816 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732610AbhASAtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 19:49:17 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10J0UquE017389;
        Mon, 18 Jan 2021 16:48:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=gXSZmwC426I7dE4L03Jj8jtt3k+hzLQzm6xgtTuSwIE=;
 b=ZtNK0lF8055RYAnFdjg8mqxZ+2ELJCfEU5O3adDO7UF+iCxcNpWWSaCXDLaJkAcgiyAI
 xJyVhkXyO+2VS4ifxxXbWiavpKFqbQT1IMiP0nV+nX8MwdPvKlIa0bQ4qQqzct0+su48
 Z8FM+u/dTm5MPKMvRZCpYQCMIOh7+bl8KZI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 364h9e6j53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 18 Jan 2021 16:48:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 18 Jan 2021 16:48:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhBXnr0dP2PlH8xejcqX8PicnAryEsyrObvJRgZ92ONScGB0ciXdNgsgcNPOWUr0uHNsaydn6hInWTWjOze2ZPUqVczHxgmHh4G+vH2qF9ahD8/eJnArwtFbQbOmFHwRdNpwCNw7olz5xpj6pLKRUdTS1eWzd6vnobvH3xyXeJRA0NG6l5T94MorZLaUhfrznz11KNiG5xKHGJmF9SqcgH6fS8En0gsugXxA0awc6Aa2Lnr9vXzuRz1dsLxsAKczoA2ZxYdxBo5RB69v1KkmcmdwIcdbHGk0dia75/r39MHkSIZ7OKoPlCqXla1WX3fKHek5iWiRo53XnuQcfegKxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXSZmwC426I7dE4L03Jj8jtt3k+hzLQzm6xgtTuSwIE=;
 b=gqtsHiny3YAcvNfzeTJojJFWNdrf+NgOOlscEE9ECd8iLLZ96I3GKN0QNVwpr7q82WrJ0l1nFAITAvgM6fVUt6M28FT5AW/phP+3X5dYLarOUVhUSLy2R86IPjKQqORBerqcbBIrlzWhtUAM2NjBk9rfe/MYCgXylaFwM/Dv3R8gPjq7JzbGlqpAfehiVDpNyo8A4BnFxmE4NzthwqhGpyWdB3AtqQuiGABVQ2RtKIMZ0nGRTQ2kgs+GR8gOHuNvv99Y+EudT9RR/h5banyB10rgspTw/A5CO8IhdN8lxQkNxxostoNJSYaAvuNe6+YOmAaPlnwSzRmn+PdAqAFm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXSZmwC426I7dE4L03Jj8jtt3k+hzLQzm6xgtTuSwIE=;
 b=d7g6jWhcN62jVMfcj83kJi8n1xbol0GIDyazHsmODA0ye9PYS5ABbaRj7XOjpJ7zHnjv7s6ydCudXeeXZeLLhvehHBEdFpjibrqnLXtRi5cPK0/aRCxfjSrLma4MmKcLBpZ3xkRPn4gzCgIicDv6vVE+gzImqld4eQM3uZK9A3I=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2262.namprd15.prod.outlook.com (2603:10b6:a02:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Tue, 19 Jan
 2021 00:48:20 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.010; Tue, 19 Jan 2021
 00:48:20 +0000
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
Thread-Index: AQHW3iuRYm1YXRRzOkq8jjAuk5Kmsqot5piAgABWngA=
Date:   Tue, 19 Jan 2021 00:48:19 +0000
Message-ID: <379919CC-594F-40C5-A10E-97E048F73AE2@fb.com>
References: <20201229214214.3413833-1-songliubraving@fb.com>
 <20201229214214.3413833-4-songliubraving@fb.com>
 <20210118193817.GG12699@kernel.org>
In-Reply-To: <20210118193817.GG12699@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f569]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37ce5c8b-fb31-4f8d-08d1-08d8bc13eabe
x-ms-traffictypediagnostic: BYAPR15MB2262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB226204CD6FA207ECEC36D298B3A30@BYAPR15MB2262.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MzgTMOhG2eQ+Qgl7+HLZqwr73ZOrOnUXGaXIWRshgBAnpCTZSkGXZHZJmOg29G/c/LBI6esbLmaH0SOzqhxkzQS61N/xnGQ7dBjfbU3ITnI9WaaRZqpFELiqIiKxgGEJsHaxkNRdWiwnDJuhBJrQW1axsfMT4vYFslmQiLz8s3nJYw5Ssl25fOyM/JDD4nouZOzguDM3nlD88zxtiEa8UvzPUKrqTU8YZZbHW20tpgPqurcq0IR+n6uV4QeNTMoUtK2QEhj2a4Lo9ejPJdqflCCSNqmkcy3qYfa5sLx0iwQNh+/9D83XWerJoPHyB2L0QXN+KRvIOVbFofg9vtqFc0+kvXXgcyaN3HF2kprSarj2NTTLLyEsE54QNK/XZIRqImW4d/oV5d+PDFp5+1N7DqiRuiYuRC/OsmcJFSmnSUOOjrXStXdbQK838mTd6n+VsqzS9pUiMvRzUUXZNBdE1J5J7M2bThHvN0sbZSh81Ao=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(6506007)(316002)(478600001)(4326008)(5660300002)(91956017)(33656002)(66946007)(53546011)(64756008)(54906003)(66446008)(8676002)(66476007)(83380400001)(86362001)(186003)(6512007)(2906002)(6916009)(6486002)(66556008)(76116006)(36756003)(71200400001)(8936002)(2616005)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?v0BBVNDgBYX1MkED45RLKE6Lpvx0ukqAK3vOt9rrK5SFym3APbSUIfbyC8/4?=
 =?us-ascii?Q?usy60TbWdsgjTgiwM2o3XwhKKBK0ji4FV9UtwDngelDI/CE+6RaMUY+swu77?=
 =?us-ascii?Q?q9huvwSsOSX6JryzEJnYFPvRcVHS6uwD2TC9Hr4FXmO/S7lduLmgjbXNt7Gr?=
 =?us-ascii?Q?OSrmn8iMRFlDd851zZKk5ApZwwIkSx865eIVp57LZV1QqeKDCOANDbZF0Ghq?=
 =?us-ascii?Q?/XNMAVp3Q1GVeQrCbB0+X2OandOoVU9oFEszPoa/HmDHXuSoIPAj98MhzAyS?=
 =?us-ascii?Q?GF90bXbtQHpPouDlGcUfAa+AyubpGTeGv7F/N1oik8r82hq3HDgrdwGYNXMj?=
 =?us-ascii?Q?ZSGSFvX/Pdg5x6p2TK7LclbcGHT3lnNnaVjrpl+2Kcddv5tneffy1IFg5eR/?=
 =?us-ascii?Q?BGDYsq3Nbj/Vkds1DMPtsWHECAwyc7M13SG6SEaAFvhsZyqrp/VdM0mfHONs?=
 =?us-ascii?Q?OcdKkGdD4EQbxLOQRCTy4MXng1i4KOvKBG55Ejfmhn6bdUDIXypZjpUTsRB3?=
 =?us-ascii?Q?VGGzQNlZKPzDUQgURetyXTwkbJ8pUWN9kDiUNKEGxNMC/w1D0IxbzyxxD6Kd?=
 =?us-ascii?Q?QMvtbr++JVRMXKEWiDNP3juKMV9VLP0WKCUH1Z3nvvarDxORSoIoXM3GMttJ?=
 =?us-ascii?Q?8dypx4NPTSCX5nQmUCRZrV1x8MIbq6jJkwZEmIbdbw+S52HHfpxfjE9edtuO?=
 =?us-ascii?Q?2wJc7yTTXNs9wlGP+Lera5BZGGGflxDvJ3xw3VLuQnCpGHZGTcUcTUAAFfV7?=
 =?us-ascii?Q?HsFTII9rbX2xdvxFKHfTbgZ8zQ3Wlei5t7ZIgNYxODh+swy9NlSzcVCB04Ku?=
 =?us-ascii?Q?hF2EzCtvG6ji7SH9GqQSX5Z1rMRdwwVb6gMLkWmIJleTVx/EGyfTAIUoog18?=
 =?us-ascii?Q?JXKSg/8BoD/BdShIa31JvmjzB/7qh9fuQweMzj+YNtrG0r3x3Dsx3IC6ws7N?=
 =?us-ascii?Q?3Tk1hnSNML3QVcrG6HqhjR9NzMMZI+N9xDZUzBGR78aHNqh4mjA4iSg7Y//M?=
 =?us-ascii?Q?IG90du799cKm819wPKsvmXOF7seZ6s0q8EDbtOoC22jppT3ujpP1+hYPQZiy?=
 =?us-ascii?Q?6qWZxEkver5r3JuT51znvKwQzCbBoFlcTYUGpfSmJDhguE0uKYo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FF4F4FC7CBD4944BAF4041FEADDAE747@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ce5c8b-fb31-4f8d-08d1-08d8bc13eabe
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 00:48:20.0548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4z3OhfF/S66gP1nSob8PUeKobmV7N6o0TMaX2M2Au+fHgbOjEgzcV3qLGw0J0YT36PPIbNadHS9Z/5ORUrTzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-18_15:2021-01-18,2021-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

> On Jan 18, 2021, at 11:38 AM, Arnaldo Carvalho de Melo <acme@kernel.org> =
wrote:
>=20
> Em Tue, Dec 29, 2020 at 01:42:14PM -0800, Song Liu escreveu:
>> Introduce perf-stat -b option, which counts events for BPF programs, lik=
e:
>>=20
>> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>>     1.487903822            115,200      ref-cycles
>>     1.487903822             86,012      cycles
>>     2.489147029             80,560      ref-cycles
>>     2.489147029             73,784      cycles
>>     3.490341825             60,720      ref-cycles
>>     3.490341825             37,797      cycles
>>     4.491540887             37,120      ref-cycles
>>     4.491540887             31,963      cycles
>>=20
>> The example above counts cycles and ref-cycles of BPF program of id 254.
>> This is similar to bpftool-prog-profile command, but more flexible.
>=20
> So trying to get back to this after vacation:
>=20
> [root@five ~]# perf stat -vvv -e cycles -b 103
> Control descriptor is not initialized
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: load bpf program failed: Invalid argument
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> Cannot recursively attach
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
>=20
> libbpf: -- END LOG --
> libbpf: failed to load program 'fentry_XXX'
> libbpf: failed to load object 'bpf_prog_profiler_bpf'
> libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -4007
> bpf_prog_profiler_bpf__load failed
> [root@five ~]#
>=20
> [root@five perf]# tools/bpf/runqslower/.output/
> bpftool/    libbpf/     runqslower
> [root@five perf]# tools/bpf/runqslower/.output/runqslower
> libbpf: elf: skipping unrecognized data section(10) .eh_frame
> libbpf: elf: skipping relo section(17) .rel.eh_frame for section(10) .eh_=
frame
> Tracing run queue latency higher than 10000 us
> TIME     COMM             PID           LAT(us)
>=20
> [root@five ~]# bpftool prog
> 6: tracing  name dump_bpf_map  tag e54c922dfa54f65f  gpl
> 	loaded_at 2021-01-15T11:14:38-0300  uid 0
> 	xlated 256B  jited 154B  memlock 4096B  map_ids 3
> 	btf_id 6
> 8: tracing  name dump_bpf_prog  tag 4cb5558b902ee92e  gpl
> 	loaded_at 2021-01-15T11:14:38-0300  uid 0
> 	xlated 520B  jited 301B  memlock 4096B  map_ids 3
> 	btf_id 6
> 80: cgroup_device  tag 8b9c33f36f812014  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 744B  jited 447B  memlock 4096B
> 81: cgroup_skb  tag 6deef7357e7b4530  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 64B  jited 54B  memlock 4096B
> 82: cgroup_skb  tag 6deef7357e7b4530  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 64B  jited 54B  memlock 4096B
> 83: cgroup_device  tag ee0e253c78993a24  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 416B  jited 255B  memlock 4096B
> 84: cgroup_device  tag e3dbd137be8d6168  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 504B  jited 309B  memlock 4096B
> 85: cgroup_skb  tag 6deef7357e7b4530  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 64B  jited 54B  memlock 4096B
> 86: cgroup_skb  tag 6deef7357e7b4530  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 64B  jited 54B  memlock 4096B
> 87: cgroup_device  tag c8b47a902f1cc68b  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 464B  jited 288B  memlock 4096B
> 88: cgroup_device  tag 0ecd07b7b633809f  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 496B  jited 307B  memlock 4096B
> 89: cgroup_skb  tag 6deef7357e7b4530  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 64B  jited 54B  memlock 4096B
> 90: cgroup_skb  tag 6deef7357e7b4530  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 64B  jited 54B  memlock 4096B
> 91: cgroup_skb  tag 6deef7357e7b4530  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 64B  jited 54B  memlock 4096B
> 92: cgroup_skb  tag 6deef7357e7b4530  gpl
> 	loaded_at 2021-01-17T18:35:22-0300  uid 0
> 	xlated 64B  jited 54B  memlock 4096B
> 100: tracing  name handle__sched_w  tag 00ba1f1d332f5a57  gpl
> 	loaded_at 2021-01-18T16:34:00-0300  uid 0
> 	xlated 152B  jited 93B  memlock 4096B  map_ids 11,9
> 	btf_id 248
> 102: tracing  name handle__sched_w  tag 00ba1f1d332f5a57  gpl
> 	loaded_at 2021-01-18T16:34:00-0300  uid 0
> 	xlated 152B  jited 93B  memlock 4096B  map_ids 11,9
> 	btf_id 248
> 103: tracing  name handle__sched_s  tag a4ac42153fd49be2  gpl
> 	loaded_at 2021-01-18T16:34:00-0300  uid 0
> 	xlated 560B  jited 332B  memlock 4096B  map_ids 11,9,10
> 	btf_id 248
> [root@five ~]# perf stat -vvv -e cycles -b 92
> Control descriptor is not initialized
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> prog FD 3 doesn't have valid btf
> Failed to get program name for bpf prog 92. Does it have BTF?
> [root@five ~]# perf stat -vvv -e cycles -b 103
> Control descriptor is not initialized
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: load bpf program failed: Invalid argument
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> Cannot recursively attach
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
>=20
> libbpf: -- END LOG --
> libbpf: failed to load program 'fentry_XXX'
> libbpf: failed to load object 'bpf_prog_profiler_bpf'
> libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -4007
> bpf_prog_profiler_bpf__load failed
> [root@five ~]# perf stat -vvv -e cycles -b 102
> Control descriptor is not initialized
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: load bpf program failed: Invalid argument
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> Cannot recursively attach
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
>=20
> libbpf: -- END LOG --
> libbpf: failed to load program 'fentry_XXX'
> libbpf: failed to load object 'bpf_prog_profiler_bpf'
> libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -4007
> bpf_prog_profiler_bpf__load failed
> [root@five ~]#
> [root@five ~]# perf stat -vvv -e cycles -b 6
> Control descriptor is not initialized
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: load bpf program failed: Invalid argument
> libbpf: -- BEGIN DUMP LOG ---
> libbpf:
> Cannot recursively attach
> processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 pe=
ak_states 0 mark_read 0
>=20
> libbpf: -- END LOG --
> libbpf: failed to load program 'fentry_XXX'
> libbpf: failed to load object 'bpf_prog_profiler_bpf'
> libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -4007
> bpf_prog_profiler_bpf__load failed
> [root@five ~]#
>=20
> So no more segfaults, but still something to look at, I'm pushing my
> local perf/core to tmp.perf/core, please take a look.
>=20
> - Arnaldo

We are looking at two issues:
1. Cannot recursively attach;
2. prog FD 3 doesn't have valid btf.=20

#1 was caused by the verifier disallowing attaching fentry/fexit program=20
to program with type BPF_PROG_TYPE_TRACING (in bpf_check_attach_target).=20
This constraint was added when we only had fentry/fexit in the TRACING
type. We have extended the TRACING type to many other use cases, like=20
"tp_btf/", "fmod_ret" and "iter/". Therefore, it is good time to revisit=20
this constraint. I will work on this.=20

For #2, we require the target program to have BTF. I guess we won't remove
this requirement.

While I work on improving #1, could you please test with some kprobe=20
programs? For example, we can use fileslower.py from bcc.=20

Thanks,
Song

[...]

