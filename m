Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0447B2D2037
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgLHBhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:37:54 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13012 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726620AbgLHBhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:37:54 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B81a2Oe030561;
        Mon, 7 Dec 2020 17:37:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OQOMdmEeqhUNCcN9BPnBprcz4uHL7u1YytJrhBicy+Y=;
 b=CJw+bLaLrF90Ns4JVc7TGMFE6GxWkSeW3al2gjeCLOcJATMMS322wDzPHtM4BxoXLfsO
 1bi0MPmNAodXdDWqjVLbc1Lh1fHT5s/0VGIFoQkyfSBacdPKE3kArotbw5oOFyrdnHJQ
 1oP38tO9+4AXzYKhtjvteaIC9FBsz5x7z34= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 358ud9k01s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 17:37:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 17:37:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFSD7sV6k04/4J/WXOOxh48JZ1c5FRx7ucpCP2o1aqurHfwcYwdnR6ULdFQKwOMDCRFEE7cRpx6YJX52SCOOeSL6z1BraacjVsjIyzqK2mphg4YBA/nT3RbLiX2FGLGX0NwQP9VpiBWL/6mh/GC8zXb5IUZkcP4WGxfmKjbAAE2K6o1jbKsY4E/jTZzbgl34CmH0CcD1J5lj/jEkgxLn08NQw/TJ6TMm+ycsGOilbw6FZ+BQX3nwSk9+vYXNFfBvty4CuAK2rRvslbr8mfqcbDYUql1a/T+557XOEBIfJbGuJ3cFvVMSKMzTLNvDWwF0HhnhY7CvL1sPazjIhImx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQOMdmEeqhUNCcN9BPnBprcz4uHL7u1YytJrhBicy+Y=;
 b=D6GVWrGA52GZVK6rk/PniIdPstIU+nI2dXCxFSP/KY4dxTkTV7tRF4+a5iTjMdcXgqppbJEuVWtBUTAtGHJbtBVvMo35aFTv3TPjgHzwSIxKCVJVJo7GSeDFQk6KJp1sNnIKiPer3DHcZQ5a9fLby4YFb3WGegWpMehfOYKGrBoA+8dNR/sWWVkvqbgxRctUdJ/MwLLwnUzgupMQeD7teF5C9qLfNMWn0yZ/Ky8yVg6Bsv3Wu+AJqEOs2ReYIxpq0qoif4f/IAkOnuzUWhAIfzQriDl85yioBEp36JexIiPCBtqqOFAhhQQ/3qon0dsGGvn/xOVBTtcxQa3/Vhc54w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQOMdmEeqhUNCcN9BPnBprcz4uHL7u1YytJrhBicy+Y=;
 b=i4qSj4SBvu046xlpAQG4YGIpAq5Xa7gdpn1ip79DyN4hq9jVnUoAudEg/o5MCEYgpxC8A5tPJyqYFNwLCX1lVrUF2RK1OTdS+Fjn+PCc/nJ2xjbmFTwsemriToHDbhVwE8ohW5kGJ/U80VXW++2nBEpIH9g2MxBrTHGAS3D0qPI=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2888.namprd15.prod.outlook.com (2603:10b6:a03:b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Tue, 8 Dec
 2020 01:36:57 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 01:36:57 +0000
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
Subject: Re: [PATCH v2 2/2] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v2 2/2] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHWygSVjVbTDtrVVUefy9NNfYjezqnsNoyAgAA6pYA=
Date:   Tue, 8 Dec 2020 01:36:57 +0000
Message-ID: <C94864E9-CE05-4AEA-A986-731BFC0C95FF@fb.com>
References: <20201204061310.3196812-1-songliubraving@fb.com>
 <20201204061310.3196812-3-songliubraving@fb.com>
 <20201207220703.GA4116109@krava>
In-Reply-To: <20201207220703.GA4116109@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:e2ec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bcef7c5-4850-41b3-966a-08d89b19c075
x-ms-traffictypediagnostic: BYAPR15MB2888:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2888304BA07F5F724D22B3D2B3CD0@BYAPR15MB2888.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nQjkJdGcMAExt8O8AtMtFioIdxUEsjemBuF1Ay5gdh9q/ATVTEuYf7Egd1MKs/abVJwUYDVm5/iAIKiFcP5Qdl9JyS/qnP/7+rVaywKIZg3hAZZuaTlijnXhX9dIwC0xa+9WtXL4F0Lsc/NvUTP0lCjDDNzO0446DwBhZnlgUSmOBvO5VPQKwS0VhPcNoSzqiA6ZDeKTRSyoIbCSCsTGSnSjVT4Px9exhcsOEljZ1GF7g1okGiz+iNI9yp3Dhr9nOG/NAciHvyKLbxhhUiJGK3r80WAgtEeKLiICiOA8CJQYqY2uWG88k+KEbCx45d3cEJGKLk/+sQp6DbwAMPRemxgRJlUutlRmRkzHfs93VI6kvCpVLOBGS+yWc3QXfs8sR4SPMUflfMN2rE4h0Aw86g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(6486002)(4326008)(6506007)(64756008)(8936002)(2616005)(8676002)(5660300002)(2906002)(316002)(53546011)(6916009)(86362001)(6512007)(36756003)(91956017)(83380400001)(33656002)(66946007)(186003)(71200400001)(66476007)(478600001)(76116006)(54906003)(66446008)(66556008)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YIxTUVwJXTTAV0pnaVNUl/qb2hHXo82xzrjxANkTAg8DAtCe9b5wydR0x1os?=
 =?us-ascii?Q?mLubrHNa/XhH+xRAxQZVPfhhQrvVyAA6BlEkmva4+8s/Z7PzR7rxialF5MwD?=
 =?us-ascii?Q?JBUWu44w5O2nLoYHEq4v/QWKWy+ooJ6Fs2tYAFXJhP+44srb53i8QRIhqyrF?=
 =?us-ascii?Q?d1P0doVth3WGFBQAKCzrmlnXKO6RZNzdrdVB6J6J+HqL3gMpGyN5E+XViIRy?=
 =?us-ascii?Q?/V3I5Lg60U8vu+y8C/zFPeAaYxT8LQKCsIzWjO2hrW7up0gzSVzZRXIzZ7KY?=
 =?us-ascii?Q?vpd6Aq+gPOkmW5k98mEedm0fkb1ASwSW4W8Xm4MAwt4q/Sn9UkaLUSrEorz0?=
 =?us-ascii?Q?poyFT61HA3OK++oRXz89X3b0q9nHmEwwLjtYwBkApkogaGlKmaOZM+NVzC8K?=
 =?us-ascii?Q?inxMgwNmAOJSOTkiOuUv0ipqAveZZ5X9xPEaJWcPrXXlkWZefKsNMCoojSrf?=
 =?us-ascii?Q?3qKgtk9yDHrHdWrKRZkLJTR0rvzbR+v0/HvwKED4bUnjDmBP7GBBvk4isM7t?=
 =?us-ascii?Q?4QGTqeMr0WrVK90qYVAw0yqPfxV2HLtcdQMwWWggx54y4u0ThzZ7v/IAOLpc?=
 =?us-ascii?Q?ADBWRDnQTM7A6jANrGUg7OYFt7UaOvAGJRND5Tisn2QNalvbMVbRFQ0msNko?=
 =?us-ascii?Q?NYAnTOVW7n191uba+kCP0D/wQoHfmdpG5KEO8dw87/NooqJ61G21JfoXpzvi?=
 =?us-ascii?Q?j5uHfFt0xoVzRq7hlXMQ0IgZq01LhzQDoye4Dc3il0yQj+e1dOn9CsVaDvRN?=
 =?us-ascii?Q?tobrzzTM0+RQFaS28LAKgiviZfZfzLnNuG+9crbWkbhhAuRP8vpqxtPHeNe9?=
 =?us-ascii?Q?iSaWSZ2zS4zN5rZLRhvI/MiUrSEj+zyX1N/qKLweO5WlM59Npbi26YTtR55s?=
 =?us-ascii?Q?wvLg3LIpkxzXVjCJSVKvtKVB1krJnoHTYEe5UKc8xiZ/s9W/3ve/BqE+hvm+?=
 =?us-ascii?Q?I6xBr4MDVprgDopusA6FZKYkfNkUCvhtqpaRiNyteORyJj9a3YyP1XL9D36q?=
 =?us-ascii?Q?zCOwyuhKkaH6n+3fcT8ed7m58FatfqASHBAwJHNlBUgs/yI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB77A651BA72B54B8DA260440F3D83B6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcef7c5-4850-41b3-966a-08d89b19c075
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 01:36:57.6805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ToYmz/nVa9/BTx5mKgMDCoK5fhckXLCxpm81IKOlEVUu0UDPvTmQ4p+7xIr1dsD5SN0zF15Ignc5XwzepS8E5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2888
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012080007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 7, 2020, at 2:07 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Dec 03, 2020 at 10:13:10PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +#include "bpf_skel/bpf_prog_profiler.skel.h"
>> +
>> +static inline void *u64_to_ptr(__u64 ptr)
>> +{
>> +	return (void *)(unsigned long)ptr;
>> +}
>> +
>> +static void set_max_rlimit(void)
>> +{
>> +	struct rlimit rinf =3D { RLIM_INFINITY, RLIM_INFINITY };
>> +
>> +	setrlimit(RLIMIT_MEMLOCK, &rinf);
>> +}
>> +
>> +static inline struct bpf_counter *bpf_counter_alloc(void)
>=20
> why is this inlined?

We don't need the inline here. I will remove it in the next version.=20

>=20
> SNIP
>=20
>> +static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_=
id)
>> +{
>> +	struct bpf_prog_profiler_bpf *skel;
>> +	struct bpf_counter *counter;
>> +	struct bpf_program *prog;
>> +	char *prog_name;
>> +	int prog_fd;
>> +	int err;
>> +
>> +	prog_fd =3D bpf_prog_get_fd_by_id(prog_id);
>> +	if (prog_fd < 0) {
>> +		pr_debug("Failed to open fd for bpf prog %u\n", prog_id);
>> +		return -1;
>> +	}
>> +	counter =3D bpf_counter_alloc();
>> +	if (!counter)
>> +		return -1;
>> +
>> +	skel =3D bpf_prog_profiler_bpf__open();
>> +	if (!skel) {
>> +		pr_debug("Failed to load bpf skeleton\n");
>=20
> I'm still getting
>=20
> [root@dell-r440-01 perf]# ./perf stat -b 38
> libbpf: elf: skipping unrecognized data section(9) .eh_frame
> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_f=
rame
> libbpf: XXX is not found in vmlinux BTF
> libbpf: failed to load object 'bpf_prog_profiler_bpf'
> libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> ...
>=20
> with id 38 being:
>=20
> 38: tracepoint  name sys_enter  tag 03418b72a610af75  gpl
>        loaded_at 2020-12-07T22:54:05+0100  uid 0
>        xlated 272B  jited 153B  memlock 4096B  map_ids 1
>=20
> how is this supposed to work when there's XXX in the
> program's section? libbpf is trying to find XXX in
> kernel BTF and fails of course

I think this is because this program doesn't have BTF. The actual failed
function was bpf_program__set_attach_target(). So the error message above
should be "Failed to _open_ bpf skeleton". I will fix the error messages.=20

>=20
>=20
>> +		free(counter);
>> +		return -1;
>> +	}
>> +	skel->rodata->num_cpu =3D evsel__nr_cpus(evsel);
>> +
>> +	bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
>> +	bpf_map__resize(skel->maps.fentry_readings, 1);
>> +	bpf_map__resize(skel->maps.accum_readings, 1);
>> +
>=20
> SNIP
>=20
>> +static int bpf_program_profiler__read(struct evsel *evsel)
>> +{
>> +	int num_cpu =3D evsel__nr_cpus(evsel);
>> +	struct bpf_perf_event_value values[num_cpu];
>> +	struct bpf_counter *counter;
>> +	int reading_map_fd;
>> +	__u32 key =3D 0;
>> +	int err, cpu;
>> +
>> +	if (list_empty(&evsel->bpf_counter_list))
>> +		return -EAGAIN;
>> +
>> +	for (cpu =3D 0; cpu < num_cpu; cpu++) {
>> +		perf_counts(evsel->counts, cpu, 0)->val =3D 0;
>> +		perf_counts(evsel->counts, cpu, 0)->ena =3D 0;
>> +		perf_counts(evsel->counts, cpu, 0)->run =3D 0;
>> +	}
>> +	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
>> +		struct bpf_prog_profiler_bpf *skel =3D counter->skel;
>> +
>> +		reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
>> +
>> +		err =3D bpf_map_lookup_elem(reading_map_fd, &key, values);
>> +		if (err) {
>> +			fprintf(stderr, "failed to read value\n");
>> +			return err;
>> +		}
>> +
>> +		for (cpu =3D 0; cpu < num_cpu; cpu++) {
>> +			perf_counts(evsel->counts, cpu, 0)->val +=3D values[cpu].counter;
>> +			perf_counts(evsel->counts, cpu, 0)->ena +=3D values[cpu].enabled;
>> +			perf_counts(evsel->counts, cpu, 0)->run +=3D values[cpu].running;
>> +		}
>=20
> so we sum everything up for all provided bpf IDs,
> should we count/display them separately?

I think that's the default behavior with --pid x,y,z or --cpu a,b,c.=20
Do we need to separate them?

>=20
> SNIP
>=20
>> +SEC("fentry/XXX")
>> +int BPF_PROG(fentry_XXX)
>> +{
>> +	__u32 key =3D bpf_get_smp_processor_id();
>> +	struct bpf_perf_event_value reading;
>> +	struct bpf_perf_event_value *ptr;
>> +	__u32 zero =3D 0;
>> +	long err;
>> +
>> +	/* look up before reading, to reduce error */
>> +	ptr =3D bpf_map_lookup_elem(&fentry_readings, &zero);
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	err =3D bpf_perf_event_read_value(&events, key, &reading,
>> +					sizeof(reading));
>=20
> can't we read directly to ptr in here?

Yes, we can! Thanks for catching this.=20

>=20
> SNIP
>=20
>> 	/* THREAD and SYSTEM/CPU are mutually exclusive */
>> 	if (target->per_thread && (target->system_wide || target->cpu_list)) {
>> 		target->per_thread =3D false;
>> @@ -109,6 +137,10 @@ static const char *target__error_str[] =3D {
>> 	"PID/TID switch overriding SYSTEM",
>> 	"UID switch overriding SYSTEM",
>> 	"SYSTEM/CPU switch overriding PER-THREAD",
>> +	"BPF switch overriding CPU",
>> +	"BPF switch overriding PID/TID",
>> +	"BPF switch overriding UID",
>> +	"BPF switch overriding THREAD",
>> 	"Invalid User: %s",
>> 	"Problems obtaining information for user %s",
>> };
>> @@ -134,7 +166,7 @@ int target__strerror(struct target *target, int errn=
um,
>>=20
>> 	switch (errnum) {
>> 	case TARGET_ERRNO__PID_OVERRIDE_CPU ...
>> -	     TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD:
>=20
> hum, this should stay, no?

We need this to show the warning like:

~/perf stat -e cycles,instructions -b 245561 -C 0
BPF switch overriding CPU
...

Thanks,
Song

