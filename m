Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5282E72CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgL2Rr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 12:47:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13474 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726256AbgL2Rr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 12:47:28 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTHdKPt025915;
        Tue, 29 Dec 2020 09:46:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2D4Gi6eC5AO/GpA5Ek/AGF6MUb7GrsYki9Bzje7elug=;
 b=h5EEw927+pxuSQcfgGO/4H+zJEnR+QCJtcRtSt1aY48ce7zPscEZ3KN2J3Df8n9UZWwm
 C4Gk8cNx5b5XqsRoDl59M8zypCgQ3SyfPB4gzHmq/nzmdCzWEpqOxLPXWZPLmO4QTqta
 IH1I/p60CxZfG1zKdaV8FFSnjq2hhO3ybqk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35p3jutfw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 09:46:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 09:46:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ene6jcTIkxZaW2xGaPLxER2soeAUfcwJQ1bMLfzinTDN6L1U3uu6KmYQXZOulgbS6e15jodh7kUwgUDYU7ut7BSrJhumnkF0hQ1k7YPFA1y6ZZZCdEhuZ9rIP9GX+GZpD14ZAX40wPtGZDzlryWvlv7PKfNr5DmuZogi5Az0KS6Wg/0fvwBRtTT1ukGfuuKc3OJhxdYB/Pt8HlMLAdyCSBjtHRij41zDht85ULGPA+ubMDeleC1W1+WnxrMw+LF7p+Lh1M/i3pUEf7Kk7KaF1cGobzUZ/5kzCxXjyFybp9Qc0Qf3By9EvOYRt2hOF/5pczZE0GP3Zq1MWS5aAUb/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D4Gi6eC5AO/GpA5Ek/AGF6MUb7GrsYki9Bzje7elug=;
 b=InjsC0fEv97yyB9TRSh9eKB97aETDm2jD4qyA2HX+0cz+HNQm4HZs+YipdwFS0IvsGNx4X82VWhFfYsx3OZ62OijzD3mUxOLvwK/lqa0NSEFYHFioThq9YYXLpDbyk9ioWIzT8NnQndG+oOvw4VwYStFQuf8L7TGM03tBNTJIyQfvscY8EeReiUwKAbAEXvyOLq2mgAGurscbtRK7hyHAblwUtgpAWerbE+7s1DoT+g60QlqHXHduK7RsqvtxYMYZ1AMw3BFS+8/MPQwpVNjzZH+r9XXavbebZP5VzgcUc7/vLSrODaac8RcvmjHe+9hCyU9C+jKCDbfpROKoH4lbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2D4Gi6eC5AO/GpA5Ek/AGF6MUb7GrsYki9Bzje7elug=;
 b=Qd0eG/N8lpQ0B7hOzgi6kIMvvr8cDni7RWPvMQd5EsUmNn/T5ZW8sb/Eon+O53aS7LcyJ9eJohYTOEKZZXCistJdQn+eer3kj9QT802PVptWplmKjl28PF+sXcvmo8kmu/AQSteibi98b4ZTw5WCFdMkfRbAg6UsFjGvd0bKshw=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 17:46:18 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 17:46:18 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v6 3/4] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHW3UCo6hW/vcfUc06GxX5agiqE96oNrCiAgACuXAA=
Date:   Tue, 29 Dec 2020 17:46:18 +0000
Message-ID: <B5D51BCD-C9FA-458D-B8C9-345BC2AD16E6@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <CAM9d7ciBsQqp2C5jWnitaK1Lttrq46NMcTLwE70oaqm82T88+Q@mail.gmail.com>
In-Reply-To: <CAM9d7ciBsQqp2C5jWnitaK1Lttrq46NMcTLwE70oaqm82T88+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7414]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3fc646d-3a5f-49bf-e616-08d8ac21a5b9
x-ms-traffictypediagnostic: BYAPR15MB4119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB41191B02C38D911F78AEAAEBB3D80@BYAPR15MB4119.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RTi5E+6K4as7sr0O7PrSt8aEmUqsNY4RwjlxY6LRTr8PItGObQc5SdzlGSCilHF+YwNdSpbUyNtb5n/lIqPPV6wx0fhEOK/LtrTXpRj03kaiZS7339uQQT7U2qmtqFGeNI07lmtZRnpCP/mTGSBhlY8paHg1NijGqGdgGSibgX+1wTktvMabCzE27I7N+oQQz6tn0PXd9wD7fA94QPrZGc5nTyKZqximiRAv/KN737i0zfmYcPzD5S85KCyTjPqpcWA/dk9M6mLtrKEMTm4HSH7AA4iOU2FGOpjyr1RwasloNqKRHXa9z74qoMhvdTQTJlZDfV00JtMEZO9txe1ncvmATsbU0yPlQOGQ4QdFLegobAn/Hnf08ZLd7UINqQpdJM3oXDgnq646QS8edL2u+xqZ/78aW+HEX0ZjqLPpsWiWDMSbapXb3vX+FPioUoda
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(39860400002)(376002)(186003)(66556008)(71200400001)(36756003)(5660300002)(66446008)(76116006)(2906002)(66476007)(316002)(64756008)(4326008)(91956017)(6506007)(53546011)(8936002)(86362001)(478600001)(6512007)(2616005)(54906003)(8676002)(6486002)(33656002)(30864003)(6916009)(83380400001)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1337G+nqtX6s5vHJkQizNW/GSnPI9Ew4jGFKylUyiYy3x0Eoe0wpiZjG7v8+?=
 =?us-ascii?Q?fCCxCW04gN6ckOFV+qbPro8om3yOEWbrnr9nS0rHkMRd5o9B0e3vxuZ/mse4?=
 =?us-ascii?Q?YPZtVWSXHMWVCNZ6cNG5pACY/wzxvqgtRgEqn2UHfaXsbN6cCazXLAj2hy1+?=
 =?us-ascii?Q?p2mkJgHcI2ZRQFRiFExjQmALyklQr6dPg4srCmUI6TQeRZK3Dcar4FpXTtoY?=
 =?us-ascii?Q?03YdLBicLPvQl69LZIk5o6UPr04k6PTnvIGJEG3FEmjyvGaPPSJQ870Z69kX?=
 =?us-ascii?Q?Z4XxPAwA3AIcTbzHSX18tJFca5EJRUPTi0QZUvR2ItfYHCbVs94gENDd3E6o?=
 =?us-ascii?Q?BL+4zdxMGydT699m97z3ULHUV4QsznSVgETzCcxtSaEeqdWElz2jduk5vQhu?=
 =?us-ascii?Q?MApRWsrdz04HNTkTYSc/CTvi/XqP1MuzP/hsNLbtn7SgHEO3RNc3KrVXXKnm?=
 =?us-ascii?Q?UYs1hAYYvcTKzVzuJdrf+30xhE2LvKlEZj4nGyXE3NJ5EetP9FolneU8E5YU?=
 =?us-ascii?Q?03JlF5VXZa8KhQeZGZ0CIQDgJOrth1orMM/nMClccqr23DSsBGNr0qGIvae8?=
 =?us-ascii?Q?f05dO/gqo2gAi8yyn55PX+G88JJgI75aXCMvyGwCF0NM5QjSFvlehq1ziWC9?=
 =?us-ascii?Q?bw5MGc2IC1DPYsyP4+QxreBrayOgySh9Jx9onvH0NxHgRBvPZt/cvT56N2mE?=
 =?us-ascii?Q?xTFhQJAUJirBpJ+WfAZO6WTjYydeMrDMD/FZOu1V/yrMdlqMCD27Gh4nLf+n?=
 =?us-ascii?Q?NjzzR7LenBH4nG9Cn9NqDnXf5xuliwIZ/2+T7KeLTkIiZzuITvSS4mBUV1zZ?=
 =?us-ascii?Q?6BKw/iGcwU3xSdZs6Tim//4Dvy0iZmeOuzjXFNp7WZQAGvtxgn0gJ/zq1jej?=
 =?us-ascii?Q?qgHnX66hwxn+yvSjJ/6dvQ1P600xxv2xjMww1X61GDH4C/lCPjkFG6Qob9XI?=
 =?us-ascii?Q?fICTeZXo1kM9fX6EMnU3aaSQdpEjeQ/R4yrJYWQloFN1Lek2Rqs/OnWLCnUg?=
 =?us-ascii?Q?6aI19OJOKHyJup+94f8GGVi5RvwnAPQEMmmOnXmVmuk/WFE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B93B495A424CB44BA365F682BD2632F6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fc646d-3a5f-49bf-e616-08d8ac21a5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 17:46:18.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7O8MvWk1qxq/ih17Yz3H3pVFPByE1NTWn2ig8Y6Eq7xOJTPnQNwndggEJVbo0iuf0EIb1pKhAl4C4vPewTN4Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_13:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 28, 2020, at 11:22 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Tue, Dec 29, 2020 at 2:41 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
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
>> ---
>> tools/perf/Makefile.perf                      |   2 +-
>> tools/perf/builtin-stat.c                     |  77 ++++-
>> tools/perf/util/Build                         |   1 +
>> tools/perf/util/bpf_counter.c                 | 296 ++++++++++++++++++
>> tools/perf/util/bpf_counter.h                 |  72 +++++
>> .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
>> tools/perf/util/evsel.c                       |   9 +
>> tools/perf/util/evsel.h                       |   6 +
>> tools/perf/util/stat-display.c                |   4 +-
>> tools/perf/util/stat.c                        |   2 +-
>> tools/perf/util/target.c                      |  34 +-
>> tools/perf/util/target.h                      |  10 +
>> 12 files changed, 588 insertions(+), 18 deletions(-)
>> create mode 100644 tools/perf/util/bpf_counter.c
>> create mode 100644 tools/perf/util/bpf_counter.h
>> create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
>>=20
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index d182a2dbb9bbd..8c4e039c3b813 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -1015,7 +1015,7 @@ python-clean:
>>=20
>> SKEL_OUT :=3D $(abspath $(OUTPUT)util/bpf_skel)
>> SKEL_TMP_OUT :=3D $(abspath $(SKEL_OUT)/.tmp)
>> -SKELETONS :=3D
>> +SKELETONS :=3D $(SKEL_OUT)/bpf_prog_profiler.skel.h
>>=20
>> ifdef BUILD_BPF_SKEL
>> BPFTOOL :=3D $(SKEL_TMP_OUT)/bootstrap/bpftool
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 8cc24967bc273..09bffb3fbcdd4 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -67,6 +67,7 @@
>> #include "util/top.h"
>> #include "util/affinity.h"
>> #include "util/pfm.h"
>> +#include "util/bpf_counter.h"
>> #include "asm/bug.h"
>>=20
>> #include <linux/time64.h>
>> @@ -409,12 +410,31 @@ static int read_affinity_counters(struct timespec =
*rs)
>>        return 0;
>> }
>>=20
>> +static int read_bpf_map_counters(void)
>> +{
>> +       struct evsel *counter;
>> +       int err;
>> +
>> +       evlist__for_each_entry(evsel_list, counter) {
>> +               err =3D bpf_counter__read(counter);
>> +               if (err)
>> +                       return err;
>> +       }
>> +       return 0;
>> +}
>> +
>> static void read_counters(struct timespec *rs)
>> {
>>        struct evsel *counter;
>> +       int err;
>>=20
>> -       if (!stat_config.stop_read_counter && (read_affinity_counters(rs=
) < 0))
>> -               return;
>> +       if (!stat_config.stop_read_counter) {
>> +               err =3D read_bpf_map_counters();
>> +               if (err =3D=3D -EAGAIN)
>> +                       err =3D read_affinity_counters(rs);
>=20
> Instead of checking the error code, can we do something like
>=20
>  if (target__has_bpf(target))
>      read_bpf_map_counters();
>=20
> ?

Yeah, we can do that.=20

>=20
>> +               if (err < 0)
>> +                       return;
>> +       }
>>=20
>>        evlist__for_each_entry(evsel_list, counter) {
>>                if (counter->err)
>> @@ -496,11 +516,20 @@ static bool handle_interval(unsigned int interval,=
 int *times)
>>        return false;
>> }
>>=20
>> -static void enable_counters(void)
>> +static int enable_counters(void)
>> {
>> +       struct evsel *evsel;
>> +       int err;
>> +
>> +       evlist__for_each_entry(evsel_list, evsel) {
>> +               err =3D bpf_counter__enable(evsel);
>> +               if (err)
>> +                       return err;
>=20
> Ditto.

For this one, we still need to check the return value, as bpf_counter__enab=
le()
may fail. We can add a global check to skip the loop.=20

>=20
>> +       }
>> +

[...]

>> +
>> +#include "bpf_skel/bpf_prog_profiler.skel.h"
>> +
>> +static inline void *u64_to_ptr(__u64 ptr)
>> +{
>> +       return (void *)(unsigned long)ptr;
>> +}
>> +
>> +static void set_max_rlimit(void)
>> +{
>> +       struct rlimit rinf =3D { RLIM_INFINITY, RLIM_INFINITY };
>> +
>> +       setrlimit(RLIMIT_MEMLOCK, &rinf);
>> +}
>=20
> This looks scary..

I guess this is OK as we requires root rights for -b?

>=20

[...]
>> +       if (!counter) {
>> +               close(prog_fd);
>> +               return -1;
>> +       }
>> +
>> +       skel =3D bpf_prog_profiler_bpf__open();
>> +       if (!skel) {
>> +               pr_err("Failed to open bpf skeleton\n");
>> +               goto err_out;
>> +       }
>> +       skel->rodata->num_cpu =3D evsel__nr_cpus(evsel);
>> +
>> +       bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
>> +       bpf_map__resize(skel->maps.fentry_readings, 1);
>> +       bpf_map__resize(skel->maps.accum_readings, 1);
>> +
>> +       prog_name =3D bpf_target_prog_name(prog_fd);
>> +       if (!prog_name) {
>> +               pr_err("Failed to get program name for bpf prog %u. Does=
 it have BTF?\n", prog_id);
>> +               goto err_out;
>> +       }
>> +
>> +       bpf_object__for_each_program(prog, skel->obj) {
>> +               err =3D bpf_program__set_attach_target(prog, prog_fd, pr=
og_name);
>> +               if (err) {
>> +                       pr_err("bpf_program__set_attach_target failed.\n=
"
>> +                              "Does bpf prog %u have BTF?\n", prog_id);
>> +                       goto err_out;
>> +               }
>> +       }
>> +       set_max_rlimit();
>> +       err =3D bpf_prog_profiler_bpf__load(skel);
>> +       if (err) {
>> +               pr_err("bpf_prog_profiler_bpf__load failed\n");
>> +               goto err_out;
>> +       }
>> +
>> +       counter->skel =3D skel;
>> +       list_add(&counter->list, &evsel->bpf_counter_list);
>> +       close(prog_fd);
>> +       return 0;
>> +err_out:
>> +       free(counter);
>> +       close(prog_fd);
>=20
> I don't know how the 'skel' part is managed, is it safe to leave?

Good catch! We do have bpf_program_profiler__destroy() in bpf_program_profi=
ler__load().
But I should have counter->skel =3D skel in err path. Will fix.=20

>=20
>=20
>> +       return -1;
>> +}
>> +
>> +static int bpf_program_profiler__load(struct evsel *evsel, struct targe=
t *target)
>> +{
>> +       char *bpf_str, *bpf_str_, *tok, *saveptr =3D NULL, *p;
>> +       u32 prog_id;
>> +       int ret;
>> +
>> +       bpf_str_ =3D bpf_str =3D strdup(target->bpf_str);
>> +       if (!bpf_str)
>> +               return -1;
>> +
>> +       while ((tok =3D strtok_r(bpf_str, ",", &saveptr)) !=3D NULL) {
>> +               prog_id =3D strtoul(tok, &p, 10);
>> +               if (prog_id =3D=3D 0 || prog_id =3D=3D UINT_MAX ||
>> +                   (*p !=3D '\0' && *p !=3D ',')) {
>> +                       pr_err("Failed to parse bpf prog ids %s\n",
>> +                              target->bpf_str);
>> +                       return -1;
>> +               }
>> +
>> +               ret =3D bpf_program_profiler_load_one(evsel, prog_id);
>> +               if (ret) {
>> +                       bpf_program_profiler__destroy(evsel);
>> +                       free(bpf_str_);
>> +                       return -1;
>> +               }
>> +               bpf_str =3D NULL;
>> +       }
>> +       free(bpf_str_);
>> +       return 0;
>> +}
>> +
>> +static int bpf_program_profiler__enable(struct evsel *evsel)
>> +{
>> +       struct bpf_counter *counter;
>> +       int ret;
>> +
>> +       list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
>> +               ret =3D bpf_prog_profiler_bpf__attach(counter->skel);
>> +               if (ret) {
>> +                       bpf_program_profiler__destroy(evsel);
>> +                       return ret;
>> +               }
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int bpf_program_profiler__read(struct evsel *evsel)
>> +{
>> +       int num_cpu =3D evsel__nr_cpus(evsel);
>> +       struct bpf_perf_event_value values[num_cpu];
>> +       struct bpf_counter *counter;
>> +       int reading_map_fd;
>> +       __u32 key =3D 0;
>> +       int err, cpu;
>> +
>> +       if (list_empty(&evsel->bpf_counter_list))
>> +               return -EAGAIN;
>> +
>> +       for (cpu =3D 0; cpu < num_cpu; cpu++) {
>> +               perf_counts(evsel->counts, cpu, 0)->val =3D 0;
>> +               perf_counts(evsel->counts, cpu, 0)->ena =3D 0;
>> +               perf_counts(evsel->counts, cpu, 0)->run =3D 0;
>> +       }
>=20
> Hmm.. not sure it's correct to reset counters here.

Yeah, we need to reset the user space values here. Otherwise, the later agg=
regation
would give wrong number.=20

>=20
>=20
>> +       list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
>> +               struct bpf_prog_profiler_bpf *skel =3D counter->skel;
>> +
>> +               reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings=
);
>> +
>> +               err =3D bpf_map_lookup_elem(reading_map_fd, &key, values=
);
>> +               if (err) {
>> +                       fprintf(stderr, "failed to read value\n");
>> +                       return err;
>> +               }
>> +
>> +               for (cpu =3D 0; cpu < num_cpu; cpu++) {
>> +                       perf_counts(evsel->counts, cpu, 0)->val +=3D val=
ues[cpu].counter;
>> +                       perf_counts(evsel->counts, cpu, 0)->ena +=3D val=
ues[cpu].enabled;
>> +                       perf_counts(evsel->counts, cpu, 0)->run +=3D val=
ues[cpu].running;
>> +               }
>> +       }
>=20
> So this just aggregates all the counters in BPF programs, right?

Yes.=20

>=20
>=20
>> +       return 0;
>> +}
>> +
>> +static int bpf_program_profiler__install_pe(struct evsel *evsel, int cp=
u,
>> +                                           int fd)
>> +{
>> +       struct bpf_prog_profiler_bpf *skel;
>> +       struct bpf_counter *counter;
>> +       int ret;
>> +
>> +       list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
>> +               skel =3D counter->skel;
>> +               ret =3D bpf_map_update_elem(bpf_map__fd(skel->maps.event=
s),
>> +                                         &cpu, &fd, BPF_ANY);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +       return 0;
>> +}
>> +
>> +struct bpf_counter_ops bpf_program_profiler_ops =3D {
>> +       .load       =3D bpf_program_profiler__load,
>> +       .enable     =3D bpf_program_profiler__enable,
>> +       .read       =3D bpf_program_profiler__read,
>> +       .destroy    =3D bpf_program_profiler__destroy,
>> +       .install_pe =3D bpf_program_profiler__install_pe,
>=20
> What is 'pe'?

pe here means perf_event.=20

>=20
> Btw, do you think other kinds of bpf programs are added later?
> It seems 'perf stat -b' is somewhat coupled with this profiler ops.
> Will it be possible to run other ops in a same evsel?

It will be possible to add other ops. I have some idea of using BPF program=
s in
other perf scenarios.=20

To clarify, I think each instance of evsel should only have one ops attache=
d.=20
And each session of perf-stat should only use one kind of ops.=20

>=20
>>=20

[...]

>> +static inline bool target__has_bpf(struct target *target)
>> +{
>> +       return target->bpf_str;
>> +}
>> +
>> static inline bool target__none(struct target *target)
>> {
>>        return !target__has_task(target) && !target__has_cpu(target);
>=20
> Shouldn't it have && !target__has_bpf() too?

Will fix.=20

Thanks,
Song

