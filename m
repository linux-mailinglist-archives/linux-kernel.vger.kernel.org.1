Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F102C34F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389721AbgKXXrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:47:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32928 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389690AbgKXXr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:47:29 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AONcgHK003469;
        Tue, 24 Nov 2020 15:47:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=fJZ8M/LXsXCAFPkPknlBDHzNL97t/i5ICn0KH0VhSjE=;
 b=Djw3A4sXmbTN/jYYWQS3MwKHzB+YTHgi7QKdDWDUyuElwjg6JaFpGsmdcSl7UJK1FjGB
 L2tGQBqHumGxwET6gVwNFFVKGLgkTuEQUhPnqbLZfJvuYoVPmTUU5LT+HTb+ATuGlSPq
 EyX7c+RDIMyPEzehM+PDz5gDVMar7KNHCOc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34ykkr485a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 15:47:13 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 15:47:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YniBoBtYBJSfJ8lQQImsp19wgPbwSsqFp99FuveToQ5PwgFQJeXQ/zf1b6HHTG3v+1urut6r3X9m5MCp5KvYtfePay6IU5RROluFJzm3QopWaUqLTbwLY4wv09z4PO5+/0BX/3gVadp//j+dg/2Txm3m2FYG/QKQZhxR3A2r3n433Uz1iFRoc34snZzN0xuU+HcQPiOeJEoIvYeq0SnVPec/HtSFxI4dVa/Kido9USlEvqCZkzqmV1TkXa1aKQa+CxfEqqFiQwfQsXQ7e/ak3hOf7rCT34c3RZbo7bmX/fSoJgNfsLBTqt/3Co2eu66qjORw8JqkMuoNawUKszJJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJZ8M/LXsXCAFPkPknlBDHzNL97t/i5ICn0KH0VhSjE=;
 b=ArE0IfIZYaCDWRpInxSAtMli3B5NGXEJMbnplpxo+SSv13wq7gtNhGNFwG/lTQrizYs14niyN7GIQrXBT56eXZrzYlPz5NsGhB2FbfqIkTvjyct+22hMmhuJjZlTZ+V6PQvaCV0HoS2KeA0bO9hB/jYcyIr3c4jQlr6osh9lVMDJhgmus1z/ZLamhX1BxWqNs2aPRAaTwsz81EkuM+AohZSanWCW2AE/xoFTP/e0Y1h+xW21qWeTQtSc6mvpGKx/y0xrJscDDygGqm63Xd+i8YzD6Um0qDrf6mDG88cG5ak2pylu1xdCYsD68RVW4Wjjy4rquKQ2Fv/BoEzE13Qkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJZ8M/LXsXCAFPkPknlBDHzNL97t/i5ICn0KH0VhSjE=;
 b=S83dwiS9iv8/H4Vehk3OicuIqlZJC+dv9cOArE1iaRVEinrSe+9Rk7e+UfcpajH0UdNiQFB8x4XFmqrQQuurDjUp/eRNP/Ibv7YnWuM9z6RAc5hEqI2hLSUdzGJjwCQ44yl6yfX6PneX3uKHC7kGegOFD/IhyLY7fuN2hqZvm2Y=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2246.namprd15.prod.outlook.com (2603:10b6:a02:8d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 23:47:05 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 23:47:05 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Thread-Topic: [RFC 1/2] perf: support build BPF skeletons with perf
Thread-Index: AQHWvi+b1vCwOQIg40KNUQdgLO76QanU0cYAgAMqFIA=
Date:   Tue, 24 Nov 2020 23:47:05 +0000
Message-ID: <0E8E3EDE-5BF4-4D34-A728-2AA935B29050@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
 <20201122232742.GB1902740@krava>
In-Reply-To: <20201122232742.GB1902740@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f2e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aaae122c-437f-431b-16bc-08d890d33fd1
x-ms-traffictypediagnostic: BYAPR15MB2246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB22469E911DE09D14BBBA1280B3FB0@BYAPR15MB2246.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1j64KWg3x/01DfJ9WFJJdKasgM7ULoUPPIRqXxUPrWNsRn2uNzOO1Xd5fA6HUFZwmRTTSa1xUukjZWsKTh4VoiYOm9CQACghoJwlF/AbX2ZkdFY/otktzC2K+M4BglmsncbthjayXyn38/3xHnNv+1T8txofpBKUoLOUhbvuYIMX19fx9UStMCNkP0Qb8U8lKbUaEeuGto3v7gU6LW9CgIpBgYKzWqpMiRHHXAyCZBv2L9WqePPaVDN0ehtPXXQNth2SACzEtVHyLCha51haSwn+Sp1AnF3rgVqkJ057vBgz3S25TtEsKFzV945303CYg2dYYx3EtlqhfZvpE3LGWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(8676002)(6506007)(36756003)(6486002)(53546011)(86362001)(498600001)(8936002)(4326008)(6512007)(54906003)(66476007)(66446008)(5660300002)(83380400001)(64756008)(66556008)(2906002)(33656002)(66946007)(6916009)(76116006)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6y/EVBtEDFpLl1Uc1M1M05mrwe6HhZ07iM6SLY3OBCwLYCFCfNCuWNggqM8n?=
 =?us-ascii?Q?2rNtOWmHIHfzovufWvDVwRMwWLgTTV9mblfEh2w7z2NF3XMr6gS+QfGOTCHg?=
 =?us-ascii?Q?qItsoBWH+3xyoePuHVczjsqoVtRBOn+lxHoutX7IIF8YDFkcck/tQJIdG8pm?=
 =?us-ascii?Q?bOuEiBZqmDFYjiG8+fnUZ+KMxZxgBMEeas7199GuJ+l+uHYK2LKhPxl8Yda/?=
 =?us-ascii?Q?cwHZV0yig5EZTFy8fPs3j7KY4Z/CobNLUrAseq6kfbQNyx3KvZ5ghaqQu96l?=
 =?us-ascii?Q?cRbxOE072Z7n00SnudueDJMefXBjz+O4QVD0YwU7Yx91TrKSr7YlnNVCflCE?=
 =?us-ascii?Q?/bqXjj77l3hbKFqmG7nCfluyWhq9X+TFjBx8SBg/Lg70y/L25XrnQlA4Di4Z?=
 =?us-ascii?Q?ZNYtVg1oDKB1AKpEhYklLBGatmTn2PxOolQKVHcQ5+LVhRQbnTo7jpuzTF8F?=
 =?us-ascii?Q?UweZ99b/uy7FwBaAfUteoaNM/anPxlBErNbYnmCn1ZIXZX1L49pM3W9t/0Q3?=
 =?us-ascii?Q?pVirgf0fQyG8FcLwJqXcu1nxp6ovC1N6ML3XDf8nXwm/Vz5iehbzApSR2imN?=
 =?us-ascii?Q?ZNIxxrSwP2KgHXuXsB1hauT5BTjqYOy9b8RsQ9j5WEmuHtuPuCOX0CmxaVEK?=
 =?us-ascii?Q?On+ZAvSn42oEApsWkQmuWXRMiSnDMsEUSuLl0XyaR7/cLdgl1trRht7xdlaa?=
 =?us-ascii?Q?SdG2D8erMzlQrkVCw5cD8FAr86XgSjgajIfkvx7X4ptyeUHUtG1tjBdxb/Lm?=
 =?us-ascii?Q?Ewa6S8Qj4JG/Z6TnC+/K7U5hfb5k3qYTIe46BvI132fNQb5hOYyiERSm4Aw8?=
 =?us-ascii?Q?qOPkQ7wlxlpZirrYZgdviyAl1C7tyT2/fLlG3XMsjAgTnOdjJS70R1xD41qJ?=
 =?us-ascii?Q?hM7wNK2OyG8YDgi2rVxOiQKfbRBFE3DGF0R8KerhKc/5OqAa4whONvHz5H8H?=
 =?us-ascii?Q?uiOSqouOecf4eAPPDd5VP3zLkTHslHifdCErf9GtiuEVD31BEyCsoK98NRaO?=
 =?us-ascii?Q?MNPmRdyGAfGWfPev6X5kYQOmSiPWP7hseXl+su6Mi/SI++c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4852A1EDD96202419CB8B1EA15EA5C90@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaae122c-437f-431b-16bc-08d890d33fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 23:47:05.5312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4i8Qh1elN54UGCpax7RByY6Nm2uPgSSm/JWiSmwdC26RPp8hQcAu4GdGummzhsRHpjGfMIIpMfVZN68dc70TZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2246
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 22, 2020, at 3:27 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>> # of all feature tests
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index ce8516e4de34f..1c2c0f4badd85 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -619,6 +619,13 @@ ifndef NO_LIBBPF
>>     msg :=3D $(warning BPF API too old. Please install recent kernel hea=
ders. BPF support in 'perf record' is disabled.)
>>     NO_LIBBPF :=3D 1
>>   endif
>> +
>> +  ifndef NO_BPF_SKEL
>> +    ifeq ($(feature-clang-bpf-co-re), 1)
>> +      BUILD_BPF_SKEL :=3D 1
>> +      $(call detected,CONFIG_PERF_BPF_SKEL)
>> +    endif
>> +  endif
>> endif
>>=20
>> dwarf-post-unwind :=3D 1
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index 7ce3f2e8b9c74..9a9fc71e2ffa4 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -126,6 +126,8 @@ include ../scripts/utilities.mak
>> #
>> # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
>> #
>> +# Define NO_BPF_SKEL if you do not want build BPF skeletons
>=20
> we will need to make this the other way round and disable it
> by default before we figure out al lthe dependencies,
> my build's failing on:
>=20
> 	[jolsa@krava perf]$ make JOBS=3D1
> 	  BUILD:   Doing 'make -j1' parallel build
> 	  CC       /home/jolsa/kernel/linux-perf/tools/perf/util/bpf_skel/.tmp/p=
rog.o
> 	  CLANG    /home/jolsa/kernel/linux-perf/tools/perf/util/bpf_skel/.tmp/p=
id_iter.bpf.o
> 	In file included from skeleton/pid_iter.bpf.c:4:
> 	In file included from /home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_he=
lpers.h:11:
> 	/home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_helper_defs.h:3560:57: w=
arning: declaration of 'struct bpf_redir_neigh' will not be visible outside=
 of this function [-Wvisibility]
> 	static long (*bpf_redirect_neigh)(__u32 ifindex, struct bpf_redir_neigh =
*params, int plen, __u64 flags) =3D (void *) 152;
> 								^
> 	skeleton/pid_iter.bpf.c:35:48: error: no member named 'id' in 'struct bp=
f_link'
> 			return BPF_CORE_READ((struct bpf_link *)ent, id);
> 			       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> 	/home/jolsa/kernel/linux-perf/tools/lib/bpf/bpf_core_read.h:339:18: note=
: expanded from macro 'BPF_CORE_READ'
> 			___type((src), a, ##__VA_ARGS__) __r;                       \
> 	...

I guess this was caused by older vmlinux.h. Could you please try build=20
vmlinux first?=20

Thanks,
Song=
