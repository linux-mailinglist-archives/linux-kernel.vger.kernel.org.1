Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22B2D4F3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgLJAQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:16:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgLJAQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:16:11 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BA08V5a010658;
        Wed, 9 Dec 2020 16:15:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Vj+aMDxWbZjRt4BDCADzHGENE35Yd8RXlbTMgO8BAXU=;
 b=Wjw5YUIgQHKW6V3FDmTtUhq0MQWaU+YV9V+5Cao74Nby48m1ftAm2vAeXHQJ6C9NYE+f
 gvqz1TQKcOOya/zmdzmaPdzgnfRl+2jl3xfT9kEN+Br0b1XnDCxzwMDGe8e1ztWYTxxC
 G53HSyAgQOqiL1Q9tS9P7vod++oxvl99BNo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35aj8vs0kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Dec 2020 16:15:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 16:15:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIEpk0tFkf+XZMJHQUVwRSMJSN2mFuFUsOO95PXKg3LMCnHvNiHc9naUB/cSaYdumv9DdYV7FSg/PgLyvmOjL79pNMRM/IHY4uRYy9MHjpOSpImqLWWWVYRmmr+sA8puZjIfAJthxQP4FvPbaMBxyPHg48/A4h1TvTVWHXoNqEQfdNKutZzzLhzykXAE1hkAvb0AMUvMU32rq2hRU0s2bRXg/z8ArnL5a1YqXiZny50p7lUBrcycTfanTd4vKDDCx2JTsnhCmSCkSPfIZd7b5/gmWGtvrPlcGuU/NQYcatoqnIjda9+qeBTeMFYCDIZ5CNEKHZGwy5QSDsZOXkF+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj+aMDxWbZjRt4BDCADzHGENE35Yd8RXlbTMgO8BAXU=;
 b=LcrSfr8dX9Q+GlF982cddRhoEAlJ1QBP636RDfjdeV888q1sR1b5pcWyWFAGy9shKHRa09h8pJATo2S883yz5v/KWjcXB+T4EGvXXL3SOOMrR/EzA1Zq3x73+iNGz+iBCwS6DiSZ0f+sNMD6oAvvJfGHO8B+tw9yd03sd83u5PxkO2l9MMfud/qL6XFugdcb07RnWTi8XpvvJPHM4T+S2Po3jcTtJZKBKRxZPUBeknrNeUT19v7RQGUi4VufhpgEa/eM6Hdbjd0aVwVDiQiC6tgMCBWApNCTfLkKSaP8dIu46n4IxY0oAmLT534QoVFRCxf7B8oRe89YulG7dNc1/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj+aMDxWbZjRt4BDCADzHGENE35Yd8RXlbTMgO8BAXU=;
 b=WVki3DZlg1i4OkGTDS7hyqQx9LIQ5ePytlb3mw42EgJESVPsyZg/IMxrp6/HN9Aka3Qm5fuwP9LVNQHirPMvBbMBMD2+fT/7ZHDpDuc7CoGlM8qD7z50BRuMY3iKKhlAPjXBnwVQxnihhB05x5CLJJIB4CaD+ly8MMTr7CLhtk8=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2326.namprd15.prod.outlook.com (2603:10b6:a02:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Thu, 10 Dec
 2020 00:15:17 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 00:15:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 2/2] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v3 2/2] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHWzY50u5geQWnq6EWxXIjQAdTvw6nu/2gAgAB4jIA=
Date:   Thu, 10 Dec 2020 00:15:16 +0000
Message-ID: <FE4D28BB-E0D8-4F33-A6F5-F3FD4D1A3F25@fb.com>
References: <20201208181646.3044417-1-songliubraving@fb.com>
 <20201208181646.3044417-3-songliubraving@fb.com>
 <20201209170348.GD69683@krava>
In-Reply-To: <20201209170348.GD69683@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:d023]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff57146c-f723-4bd4-a8b8-08d89ca0ac23
x-ms-traffictypediagnostic: BYAPR15MB2326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2326CDC554AD6C93E254D203B3CB0@BYAPR15MB2326.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R7pDCxjRQNKF3wbdAX/p7iiGLQfsjtZWyl2zwIc1YgHclGI21UsupHLKMASXbx/e5BwjRzXOCCTA4f2VrjfBimB0BIokqxBF6a9XFPPhJA++RiubAWZzZpqLEaqvWsyshEe7M2wLwqG+xQ3C0HZED44kc1cnQBPxUoRhzWcP3mK1/3FZmCqpd3ZJg1rfMLGn/fEcKRJ6IO7C56py4HMjirLcbQI7yrJeEUzrgto+9johYuebxBfvda680ThluUNJYk0LDZvH9ZQLSHaIf04uGzirLOfUwHxPT+eKiD4Edi8SaUgKn5mvhRGcxrNGOqq5sa3ONPF1ayuGrk92ETjpDLnjPQrYaXhpY0OSu+AwqrhF/Yq/I3xnkYOVilhrrNJK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(71200400001)(86362001)(66476007)(66556008)(5660300002)(66946007)(54906003)(76116006)(8936002)(508600001)(6486002)(33656002)(36756003)(4326008)(6916009)(83380400001)(186003)(64756008)(66446008)(6506007)(8676002)(53546011)(2906002)(6512007)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+3oIb1TFcCEUVB5j611HwncPCDG0MX5rKL/37BixOirBKevIh6ZqwrCowHJG?=
 =?us-ascii?Q?ZoIjtSguJu1qUKtmK1WxF3iOaW7WLhFUWTxtuJzb9s1hvZJbZAlkYJH7Bx/w?=
 =?us-ascii?Q?J/IFwAj2UNBConuEWrCV5I/o/aUrlZwHXYE1R8DfJQ7WkmndSKTjbXE1YbqG?=
 =?us-ascii?Q?sqQ6pqEaOz+3ekFLptTjUPWHDMlw29dNsaFRrQzjQxzGvGwUlb3+QeShIA+d?=
 =?us-ascii?Q?fQBx7Q0AxL4eIE/ZihaAzm3JvFfJWIlK3TI5dBWAIg9m7qCPneGpSZRm/VSl?=
 =?us-ascii?Q?HV5hn+ErwdwvRPUgk4XmbmJmQvOVZTlVzvKybFbnqSZlexBUA7fl2EzLElnH?=
 =?us-ascii?Q?MdulBbq9KizRv4sBvx4EHUWl/4z1ZhNw+/a+wvzG01OGRzzoa4RtSOQncH6V?=
 =?us-ascii?Q?5e429UPXaAJd3UL5H0c8e3hPv3/x2X6pSd2Ity2Gw0dAio23KkVWOv0AZRMC?=
 =?us-ascii?Q?fOKQFqgeWc9uvOb6s989fszM9Ph2c7GfqDwOclwx0fV6LBIxRCXUeHtWzsj7?=
 =?us-ascii?Q?mVcNDRgMEL3TPz4r/gdXSGnOIpd00Yav76LNWg1h7RYUyt2V3N6YvYx9NAul?=
 =?us-ascii?Q?doMl/ZflyBfsIufRnb35vLmMniGAe0oCfMjxE1SSUSr1aBzwdMde8MbwEgcO?=
 =?us-ascii?Q?H1nXwJTRpFlDUjjteO+QMZ9yBiloNBKLPaWxiqNOWRtDznWZMxuX+xL9ICq3?=
 =?us-ascii?Q?7nDo2qKl1glLqIqTTjScfrUdHg//Ei/dHddapAXzKTBjEiGRpOLPrrPP6sBZ?=
 =?us-ascii?Q?K04WZ3U3+7eztPKpvu6O78DnXFeL6Hux1q0Z6iLIpVlobkA++9/5bEntwZTd?=
 =?us-ascii?Q?tirMbvNq2gOk5UCYzwf6zrG1M+mIxsCsmYpnxlailwkeaGglm03lJTVaVF6h?=
 =?us-ascii?Q?iflStS3QWahV9MEgsqmHS3hCqV/h1zpceNfWpaOSxYrCiT38Re2fmUNhxyys?=
 =?us-ascii?Q?L8I8+6lKnY1YIEFMUSIILXSlKpI2CSdWeUTA1Io2IrvRfGMUpGnEf0aDb8WC?=
 =?us-ascii?Q?0qlWcStQDn9NAs1/240r8HkyS8p/WQTNXoniMY7CUNSBtT0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C7ADCE6A0F6C84786EACF940DEC8F5F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff57146c-f723-4bd4-a8b8-08d89ca0ac23
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 00:15:16.8494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2OaXQKCLoHnIjcJCpDQt3MGeIt94BqiHMXYO7y2Kj+EQT+PKT3pI9x/FhyFGFEzRcWj7c0q83/aCF1Vn6eG0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2326
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_19:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090167
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2020, at 9:03 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Dec 08, 2020 at 10:16:46AM -0800, Song Liu wrote:
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
>>=20
>> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
>> programs (monitor-progs) to the target BPF program (target-prog). The
>> monitor-progs read perf_event before and after the target-prog, and
>> aggregate the difference in a BPF map. Then the user space reads data
>> from these maps.
>>=20
>> A new struct bpf_counter is introduced to provide common interface that
>> uses BPF programs/maps to count perf events.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>=20
> I'm getting this at the end of the compilation:
>=20
>  LINK     perf
> rm /home/jolsa/linux-perf/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler=
.bpf.o
>=20
> I guess we can keep it or make it silent somehow

I also noticed this, but haven't figured out how to silent it. I guess=20
we can fix it out later.

>=20
>> ---
>> tools/perf/Makefile.perf                      |   2 +-
>> tools/perf/builtin-stat.c                     |  77 ++++-
>> tools/perf/util/Build                         |   1 +
>> tools/perf/util/bpf_counter.c                 | 297 ++++++++++++++++++
>> tools/perf/util/bpf_counter.h                 |  73 +++++
>> .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
>> tools/perf/util/evsel.c                       |  11 +
>> tools/perf/util/evsel.h                       |   6 +
>> tools/perf/util/stat-display.c                |   4 +-
>> tools/perf/util/target.c                      |  34 +-
>> tools/perf/util/target.h                      |  10 +
>> 11 files changed, 591 insertions(+), 17 deletions(-)
>> create mode 100644 tools/perf/util/bpf_counter.c
>> create mode 100644 tools/perf/util/bpf_counter.h
>> create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
>=20
> we need man page update, would be great with some example

How about we do this in a follow up patch?

>=20
> SNIP
>=20
>> -	int status =3D -EINVAL, run_idx;
>> +	int status =3D -EINVAL, run_idx, err;
>> 	const char *mode;
>> 	FILE *output =3D stderr;
>> 	unsigned int interval, timeout;
>> 	const char * const stat_subcommands[] =3D { "record", "report" };
>> +	char errbuf[BUFSIZ];
>>=20
>> 	setlocale(LC_ALL, "");
>>=20
>> @@ -2169,6 +2213,12 @@ int cmd_stat(int argc, const char **argv)
>> 	} else if (big_num_opt =3D=3D 0) /* User passed --no-big-num */
>> 		stat_config.big_num =3D false;
>>=20
>> +	err =3D target__validate(&target);
>> +	if (err) {
>> +		target__strerror(&target, err, errbuf, BUFSIZ);
>> +		pr_warning("%s\n", errbuf);
>> +	}
>> +
>=20
> is there a reason for this to move before setup_system_wide?
>=20
> I don't think it's a big deal, but just curious if that's intentional

Yes, this is intentional. It is to fix "BPF switch overriding CPU"=20
cases. Without moving target_validate(), we got

# perf stat -e cycles,instructions -b 59 -C 0
BPF switch overriding CPU
Error:
The sys_perf_event_open() syscall returned with 9 (Bad file descriptor) for=
 event (cycles).
/bin/dmesg | grep -i perf may provide additional information.

>=20
> SNIP
>=20
>> +
>> +int bpf_counter__enable(struct evsel *evsel)
>> +{
>> +	if (list_empty(&evsel->bpf_counter_list))
>> +		return 0;
>> +	return evsel->bpf_counter_ops->enable(evsel);
>> +}
>> +
>> +int bpf_counter__read(struct evsel *evsel)
>> +{
>> +	if (list_empty(&evsel->bpf_counter_list))
>> +		return -EAGAIN;
>> +	return evsel->bpf_counter_ops->read(evsel);
>> +}
>> +
>> +int bpf_counter__destroy(struct evsel *evsel)
>> +{
>=20
> this could return void

Fixed in v4.=20

>=20
> SNIP
>=20
>> @@ -247,6 +252,7 @@ void evsel__init(struct evsel *evsel,
>> 	evsel->bpf_obj	   =3D NULL;
>> 	evsel->bpf_fd	   =3D -1;
>> 	INIT_LIST_HEAD(&evsel->config_terms);
>> +	INIT_LIST_HEAD(&evsel->bpf_counter_list);
>> 	perf_evsel__object.init(evsel);
>> 	evsel->sample_size =3D __evsel__sample_size(attr->sample_type);
>> 	evsel__calc_id_pos(evsel);
>> @@ -1365,6 +1371,7 @@ void evsel__exit(struct evsel *evsel)
>> {
>> 	assert(list_empty(&evsel->core.node));
>> 	assert(evsel->evlist =3D=3D NULL);
>> +	bpf_counter__destroy(evsel);
>> 	evsel__free_counts(evsel);
>> 	perf_evsel__free_fd(&evsel->core);
>> 	perf_evsel__free_id(&evsel->core);
>> @@ -1770,6 +1777,8 @@ static int evsel__open_cpu(struct evsel *evsel, st=
ruct perf_cpu_map *cpus,
>> 		evsel->core.attr.sample_id_all =3D 0;
>>=20
>> 	display_attr(&evsel->core.attr);
>> +	if (!list_empty(&evsel->bpf_counter_list))
>> +		evsel->core.attr.inherit =3D 0;
>=20
> I think this should go to evsel__config where we set all attr bits

evsel__config() is not called by perf-stat. I moved the logic to=20
create_perf_stat_counter() instead.=20

Thanks,
Song=
