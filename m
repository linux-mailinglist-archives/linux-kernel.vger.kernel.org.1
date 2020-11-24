Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F222C34C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389250AbgKXXn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:43:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32436 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730951AbgKXXn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:43:56 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AONfEc5012207;
        Tue, 24 Nov 2020 15:43:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hm4BzKQDawDyHbaWQHmnHFjniYO2BiuWZBCiIYU6lMA=;
 b=rB8BhZBZsd1EWhH3a50uYtvwe97DjXn6qqGYiizqb9nq1+74BC2xcKTbHSnnWqym+jyG
 gcFtvHrLj4r/Ui52N3NdpZkbdIajWeAI3qLClo7upCj1n5+xg5ebxSO2V7Mxqly0YN9X
 xz1FZOCAdZDzsDNRcDmz6fly2ElBM5Pb5bQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3516xbsasv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 15:43:45 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 15:43:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBwtx6pwfhMdowKWC6BA1T4LrK2ErU8+2hy1Ufo0+4wJS6J9xdcLgBknBSbSq0N7c4NYtU4QmsqAM9qxK9owPOsHrC5tvClpEwNzmhWmYrB7afLEGORWv7BEffIYKv0V8H+mWwRqj1KvOHhNktRe0GdlC/8tBqBMdFQfmOeqEMYe1Nv7DQupZphZbBcn/bBEuU0cxndjefJ4Iuv05dlsrYFfQpHcQ9iOy+RdReGwDLscOT7/AQbBHK+1LA4ULxW2qbluunxbFAYOLXAQKKhMLy9AZT4sUH8djCY/hOnczNmihIVxtAQRW+9edo3TO6UVNTkYiREJ/kwC0w1LKz5C6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm4BzKQDawDyHbaWQHmnHFjniYO2BiuWZBCiIYU6lMA=;
 b=B3m6YOumUjWwxa35aksR3y5nC0wHoyICEOuFvngsBBeLt8v+6jmW9RrmFhDK7jJKwtgP85e6UTp1SpnEVQxyoV8kVTNfycTV74zzG6uAVqLTql9AXHu4EoiUAalXHL+/1/HqU/myj5N8BtEXtIrmqYwAF6kQkcNJsX+M/SBXnN4d4GG77EErkHL7Or9PTwzBkOtd28Y6uhrBWdsycnEmos739OVPctAvnhIkAKCcYO7DHbb2lky8xpF3Bw1U75KN3C6DpxZrz3GNRdncs8jIgrqrXbGzINvmE2sXCmQqfrLyZuj5O5Vx6J198GUz2y6zDhjaFKAco38Xbs5hXoa7eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm4BzKQDawDyHbaWQHmnHFjniYO2BiuWZBCiIYU6lMA=;
 b=gP56WS+6I/f2XkhbUz+8WnKquc8/7ACrjseVOeApD0G3yy4DvYvhFdoVsWz4GVlzUgAdPHJhA9Fohdc82MFOgJgReCoDggjyEWjOSK7LM3phH2UjYchBiBlp3cn26BS7IQ80qiUJHac/vM10VQ3LWG9C2vn4XYWlkeV+FfMae24=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2456.namprd15.prod.outlook.com (2603:10b6:a02:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 23:43:40 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 23:43:40 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 2/2] perf-stat: enable counting events for BPF programs
Thread-Topic: [RFC 2/2] perf-stat: enable counting events for BPF programs
Thread-Index: AQHWvi+l7AybrLX1mkWxO3oxzMTbKKnXue4AgABA94A=
Date:   Tue, 24 Nov 2020 23:43:40 +0000
Message-ID: <3331CA57-F1EE-4C66-8E79-E5A7DA91F880@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-3-songliubraving@fb.com>
 <20201124195108.GB2164284@krava>
In-Reply-To: <20201124195108.GB2164284@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f2e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98e35e95-3be4-4be7-0fe4-08d890d2c567
x-ms-traffictypediagnostic: BYAPR15MB2456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB24560C8CFEF48A50BAC5ABB1B3FB0@BYAPR15MB2456.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R5huP+7LXwfPFdrPfcV1Q02fofzEMqg2eL+pdfh8PqVP/TIbpcXbjRLgo9rwv6NVZ/BoNWoMuhze6/vIUNNFQpUtXVZbfYxPvs5Lqiikak8vAI8k+Sg19f38cI+uuTkpM8Y0x/QpKTSWwJi9wsVx7+h1gDjqPnkRxVGMBTsrSeEGK6yZcU6h6qjkrxyl/svrXlLePnN++DemCngeDIaiTv+dEnoc5ALkh7NrJr0xG6YhqGcvdEyc07LvbQXNYItv7JIeKYDzizFFew2JFSZgdkfPUa/QFL65MidU1pYSUcuyaLsd45DSX/Oll3lEAJkpgOmNqbgtOHiOY783nPLAXnm0swrMlTPVcsGeR4JcPc3f5cn1PBK7vNZUzPyFAIlv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(71200400001)(36756003)(4326008)(8936002)(498600001)(186003)(6916009)(54906003)(8676002)(6486002)(2906002)(6512007)(53546011)(33656002)(66446008)(6506007)(66556008)(64756008)(83380400001)(76116006)(66946007)(5660300002)(86362001)(66476007)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hfmnd9W/Guh9veQ4fuHthE4yALHYaMDGCcm5xRQMeXwOzmnxyYjOhxUk044q?=
 =?us-ascii?Q?f240tVmdpgkeZYUilATVrhLaHe/z9/q3pqhjm83kg9KdkXGdWOqNk+AtnT5b?=
 =?us-ascii?Q?5mZyGklwkLyFIyVngzuEfwJXaAkP1fQq4iowdowzAGK7X0CtHUW2I/L0zsts?=
 =?us-ascii?Q?TDhh43jH3/XsiHT/ws5Ps66HW9DBtKOzGORS3+XRmzMqpW3UIP3hnr/fgpNw?=
 =?us-ascii?Q?599w7rHWm8mTX3PmWCaDOdNYnNGmQQv1pMkbp5ZQlo2WBptUtzviNr4KG0z9?=
 =?us-ascii?Q?D5IefoUEhG6kO3uBD7wZaGCITff3llIli25T0zGQpt2/47iEG1TTuSwhTJvb?=
 =?us-ascii?Q?aGhgfHj0e41ODKPa62Uxq9h2H17p3Ytr2mxrJ+t2kA5n1JY/kBXdlLBTVJh1?=
 =?us-ascii?Q?dqM2o0p/Jxl7WpT5vlruNn0jXpqRPWlRUEMd8uCfVuMCLlNTeI6iuhkfK8lR?=
 =?us-ascii?Q?DT6/Nj7IC3pNKoPmzXA3smG3NYXcmV9gITjXX2ybMpCiqOg5VRm75pv7JZKl?=
 =?us-ascii?Q?KMiK5NP0WXBGU1UfGy/PvFiBOaOiEZGDPUGocX7owuaqYQEi8t0NnxVm46pb?=
 =?us-ascii?Q?yOsHybaCh2OKZSLVYCMPZbLP5XCATXYY2YRi0QeNzcCwUfem1qI3RObaI3EJ?=
 =?us-ascii?Q?PK9fRIPb2TzPdD/3jSpk0wluvwk/2PtzVFZ9S5RvP+M+9O1ZVpOTN1UZShxE?=
 =?us-ascii?Q?PHw7PQ1mrGtZWH6wHs2yWOYmEeV9NOkazHNB+hRY44B5kRMfcBtmhAheXehs?=
 =?us-ascii?Q?bCy82Wl81wu1AomnQZzy6Rf7cmrAqSA+Ti4/+hozvbA8dH/v+xuRHEeRpg17?=
 =?us-ascii?Q?41UsVVrJ1G+GLXJaByI/OA4WKDO95/0QwwapAPVEevJ/O3cjcJsHPdTg9Cvf?=
 =?us-ascii?Q?xSLemEFSQ9xfdiDH6cVcpuc9XtYFJGqQQgPTYVKBOBRLSH247tJ9fL5vALV3?=
 =?us-ascii?Q?DUbPShjuFzkLv/CTvaSKNMx2tNIlqLC6x9FTwvZxdEmuz7mUT86r83rI2FjL?=
 =?us-ascii?Q?TwsdrFSPwj4b/VESLR5fZdaBLWu473ko2SFbVtwmF6+H16s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37740AB61CFEA5428A0276517A7D7AB3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e35e95-3be4-4be7-0fe4-08d890d2c567
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 23:43:40.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaK0G+NLF3X4oZo0aJeEJCslNH+ynH/MeqrV504nXcXtHtheXMYMvj3P0S5RLgbHdW2fZxymK5N+iGVKOaZmiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2456
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2020, at 11:51 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Nov 18, 2020 at 08:50:46PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +static int bpf_program_profiler__install_pe(struct evsel *evsel, int cp=
u,
>> +					    int fd)
>> +{
>> +	struct bpf_prog_profiler_bpf *skel =3D evsel->bpf_counter.skel;
>> +
>> +	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
>> +				   &cpu, &fd, BPF_ANY);
>> +}
>> +
>> +struct bpf_counter_ops bpf_program_profiler_ops =3D {
>> +	.load       =3D bpf_program_profiler__load,
>> +	.enable	    =3D bpf_program_profiler__enable,
>> +	.read       =3D bpf_program_profiler__read,
>> +	.destroy    =3D bpf_program_profiler__destroy,
>> +	.install_pe =3D bpf_program_profiler__install_pe,
>> +};
>=20
> hum, what's the point of this ops? you plan some other ops?
> we could just define stat callbacks right?

I do have other ideas using BPF program to aggregate perf event=20
counts. This ops provides common interface for different BPF=20
extensions to evsel.=20

>=20
>> +SEC("fentry/XXX")
>> +int BPF_PROG(fentry_XXX)
>> +{
>> +	u32 key =3D bpf_get_smp_processor_id();
>> +	struct bpf_perf_event_value reading;
>> +	struct bpf_perf_event_value *ptr;
>> +	u32 zero =3D 0;
>> +	long err;
>> +
>> +	/* look up before reading, to reduce error */
>> +	ptr =3D bpf_map_lookup_elem(&fentry_readings, &zero);
>> +	if (!ptr)
>> +		return 0;
>> +
>> +	err =3D bpf_perf_event_read_value(&events, key, &reading,
>> +					sizeof(reading));
>> +	if (err)
>> +		return 0;
>> +
>> +	*ptr =3D reading;
>> +	return 0;
>> +}
>=20
> so currently it's one extra bpf program for each event,
> but it seems bad for multiple events stat.. could we
> just have one program that would read and process all events?

Multiple fentry programs should not be too expensive. Current design
extends evsel, so it is a cleaner implementation. We can evaluate the=20
difference of these two designs by comparing this with=20
"bpftool prog profile".

Thanks,
Song



