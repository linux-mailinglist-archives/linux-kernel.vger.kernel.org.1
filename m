Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2759F2CB072
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgLAWtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:49:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26760 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgLAWtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:49:03 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1Mic1J021867;
        Tue, 1 Dec 2020 14:48:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=s2UjOdJwQm8G6Dw0kWKbpu2hd67wWs85oL/exutNJh8=;
 b=VB67/JBaoHxbQmdik3gH3r61zrU+ju+0XItvoauPc2GKn+ekFmSv2+d6Ou335X/FMZfx
 /n+x9mFB5MiMCKAuKGejnBBGsmT+YzVsr9Fvbnu0PNxVH016jiVJOOF3qdCDozMkH7DS
 2zHd96W9ohiJGb89CtC0TSN5BryivT8K7/Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3547psqgyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Dec 2020 14:48:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 14:48:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0X1C9Acse6oiZozLNhPuPuqI45P2g5J19aieTJafBX7lYG1bCgXzeq8bv+8HbMHyUOMxg9APNyIwNPuL/AVZeLTyk1SdI4k5j1FBxcqbeI7p/1NtoIyjMFHDB002YrmO38I0uwIaHIYlGrbJ+UJLl9U431LFQAT+wG2PpGsd622pJo5V/GiCE5OivLQW7CqG9JNbQpra349usGSMcHeAZYPc5CoLRZJo9ajLGDGZgfss1saBz+brHsqOnPcEOySLbEj+nFZ2m7Fi+HSVgu3ZYxiN5CQkzKcui6SH0GVv5W7gdtlc9XZs7z509KK/mXm3pS7IW1pZn38RtNve0Avkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2UjOdJwQm8G6Dw0kWKbpu2hd67wWs85oL/exutNJh8=;
 b=oI+ZWMWzGuqWs77XPc6rnL8r9KX62t23Zh7IPuTQT5GxNWE1A4lUjFQo7fAnG8xzNHnXFnHOHpom9x5aUGpt0iOi9kJuSfH7xrzAWYJUVWealOKjTE2a+jhZ4R4MzSfYdgTvYwNyqRhalztxdTVJxvu8lrZozzu08jDUOs6p2TQR40yNJ8+Lpaq94gUGDknEL4Yl0+OiAvNktUkWNo176JLf91lBQFe8YIKeREgSuuXdEpd38ZccA+Rpa6rVguCMUBm3iRLeteJId8ePO8i47n52Jt6Okf+ZRkEcbXBTLRgb/q/gULijtfEUOnXZUO8bJIL+TOHQRuN5CSiGjCKzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2UjOdJwQm8G6Dw0kWKbpu2hd67wWs85oL/exutNJh8=;
 b=eeyjT8IUtSbXOPQask1yXJ1wty3XJmorCyKfEPwxHBiEz8c0BNpgmIeQMcSbZIFpV8CLlTEc+80OrORI/4kaTrAtj8mCXT1y5q8spMd0n5YbQXTaOss37LiSPaA8Q/6qGmZcFAkeG6VWSTaBxQ46ea9g+ONxjkABTbZb1q5Bh6M=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2821.namprd15.prod.outlook.com (2603:10b6:a03:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Tue, 1 Dec
 2020 22:47:59 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3611.022; Tue, 1 Dec 2020
 22:47:59 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC v2 1/2] perf: support build BPF skeletons with perf
Thread-Topic: [RFC v2 1/2] perf: support build BPF skeletons with perf
Thread-Index: AQHWx7TS7ookfbdCr0+QRdfs21NVyaniuO2AgAAfsAA=
Date:   Tue, 1 Dec 2020 22:47:59 +0000
Message-ID: <709375F7-A386-415B-926E-0A19783D09A5@fb.com>
References: <20201201073647.753079-1-songliubraving@fb.com>
 <20201201073647.753079-2-songliubraving@fb.com>
 <20201201205433.GE3169083@krava>
In-Reply-To: <20201201205433.GE3169083@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:438f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a4e2c70-d67b-4b4f-5280-08d8964b26ec
x-ms-traffictypediagnostic: BYAPR15MB2821:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB28214D77AF8698D83D432641B3F40@BYAPR15MB2821.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SH5wAxrds4FM1DBpq3UPaEdiF2+XOS5V15SIXjGnQNxM4ZG/d8iROuKqpBLZcyqyzLzYJposvzKu+phoYEdsMloWn8cHrZYQrEUCOhovmBdqE0joKTGBiunamwd5j2aBUmMZxXAYQ5eSKiUFQ66LOmXYY3DvvfTYpBKKAYdXgm0TQf0Jx3MS8dENsnWluHHhP0V5DSIO9FUyGSZY3GCTJTxEo6MAP71mXkjd9M/CFZh2pLoKzaUEzbFguQnt6MezP0QcF61kk+X6r6o0K2QgEk7hdZLmgORs4pZKr1ZMHRPhZ69MNynJXTFu+NBAetwK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(346002)(376002)(6512007)(86362001)(2906002)(91956017)(478600001)(71200400001)(4326008)(76116006)(5660300002)(33656002)(6486002)(2616005)(8676002)(83380400001)(66556008)(66476007)(8936002)(64756008)(66946007)(66446008)(54906003)(6506007)(53546011)(186003)(316002)(36756003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?7XGGXHujpy4GGFCMyHdAVaYQO/NQPqRmuLFtVoHSlYPSK6lTp4HXZVXebeQJ?=
 =?us-ascii?Q?NAiW88T7a6x+OlwFqbTSPy6HXptIR41iFoltRiRp0wIfHh3DctgVX1cAMkLf?=
 =?us-ascii?Q?9iZ2TuA/lsePm8xsG8ACvtVi9rjLCR1uKnHNugfn4UqXpyEme3IjlrtQVRCq?=
 =?us-ascii?Q?r52bf3m743RG9SY2BbXiepmvZaaNEv1ohx4mSZJD8a+GwiwyoCvdeTWwlQsA?=
 =?us-ascii?Q?RY2EtXIl7OOls4xniGGHXdPAy+idCoCVRHjWvIwGC4y0ipF7gPZx9ljgYcdd?=
 =?us-ascii?Q?Js3ONF3+N5YkS3UXIiZpNbYS+0IRsbgKt95dmiR5TF5EXCbpd/AuEoJnRjSI?=
 =?us-ascii?Q?/ScezXK/7NBgmm9cpcZpGFhtYCcURcgIH/6W9wg8AjPG2VdpCcKabkU6tUjG?=
 =?us-ascii?Q?CKzYlI4iKszkY0V8RYJPV6EzmnPOlTFrEGKXUDFNvYNd7cfnrYxRlNxw1o5C?=
 =?us-ascii?Q?Mmrcx3ZXv4GoigondcT8MHkrZbT13nHIxN27qsOVZglpa7xA4YGGJUCHoJCW?=
 =?us-ascii?Q?5yVCrDkV15p7dmzv8Qiw1G7nj5TrLwBojfk7EzvCa47TDsjj7Sv59G+sfW+V?=
 =?us-ascii?Q?qOMJ9l5FXuo6vnz1T099tiVxbCyiXsjOO2JXNEAC/0KYj+B4Gy6m2av/LsCs?=
 =?us-ascii?Q?u6VjvIdcKlGYru5TbH/+HImALPqC5AiPguUSHwFLdHJmRaz4UeLWGXyZR1kG?=
 =?us-ascii?Q?rz5g7gOKj/UKLPZqfMMbg8eQyJpSnUgdg1YWgRGv428RfffYL4OhgBmvtFKA?=
 =?us-ascii?Q?bhUseXUag+d9Gt4XS8rLoDEVabO4it+qBntNNpLdsC0ZSmqHFd5tUiJ2iMhF?=
 =?us-ascii?Q?fN0Jwir3mTxjmKOi5ZxPpqbqQYeZNAP4CSaMXoFFBMCX47NFXxUuoinWkkSS?=
 =?us-ascii?Q?SPGnYwGYpOy9Yd4EiJg21bMa8B+/w83A4U3/IWogBmnXOyJBIzunGKy8aJTW?=
 =?us-ascii?Q?J3AP7OvAAoFoAXfwD5fcKyQpU7BewMY809X6R0E2mOEBG4SB4Zd94dnN1es7?=
 =?us-ascii?Q?4d1rio1DDIEzjOPGatc6sDbkipsCRqmOKnwB43g97LFs480=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <001CBEA62D6AD242A049C82407E4D894@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4e2c70-d67b-4b4f-5280-08d8964b26ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 22:47:59.1571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oW+wXjRIsqYqsTbvIi73xLtBvnmSCYfUJgwSTC7vBRJ/AOghri0RjadkX1YHI3JURddaj2twcBR9aS83qaUW9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2821
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_11:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 1, 2020, at 12:54 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Nov 30, 2020 at 11:36:46PM -0800, Song Liu wrote:
>> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
>> by far the easiest way to write BPF tools. Enable building BPF skeletons
>> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
>> be added for different use cases.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/bpf/bpftool/Makefile           |  2 ++
>> tools/build/Makefile.feature         |  3 +-
>> tools/perf/Makefile.config           |  9 +++++
>> tools/perf/Makefile.perf             | 52 ++++++++++++++++++++++++++--
>> tools/perf/util/bpf_skel/.gitignore  |  3 ++
>> tools/perf/util/bpf_skel/dummy.bpf.c | 19 ++++++++++
>> tools/scripts/Makefile.include       |  1 +
>> 7 files changed, 86 insertions(+), 3 deletions(-)
>> create mode 100644 tools/perf/util/bpf_skel/.gitignore
>> create mode 100644 tools/perf/util/bpf_skel/dummy.bpf.c
>>=20
>> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
>> index f60e6ad3a1dff..a01407ec78dc5 100644
>> --- a/tools/bpf/bpftool/Makefile
>> +++ b/tools/bpf/bpftool/Makefile
>> @@ -120,6 +120,8 @@ endif
>>=20
>> BPFTOOL_BOOTSTRAP :=3D $(if $(OUTPUT),$(OUTPUT)bpftool-bootstrap,./bpfto=
ol-bootstrap)
>>=20
>> +bootstrap: $(BPFTOOL_BOOTSTRAP)
>> +
>> BOOTSTRAP_OBJS =3D $(addprefix $(OUTPUT),main.o common.o json_writer.o g=
en.o btf.o)
>> OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
>>=20
>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>> index 97cbfb31b7625..95a58b5564218 100644
>> --- a/tools/build/Makefile.feature
>> +++ b/tools/build/Makefile.feature
>> @@ -70,7 +70,8 @@ FEATURE_TESTS_BASIC :=3D                  \
>>         libaio				\
>>         libzstd				\
>>         disassembler-four-args		\
>> -        file-handle
>> +        file-handle			\
>> +        clang-bpf-co-re
>=20
> this needs to go under FEATURE_TESTS_EXTRA and you need to call
> $(call feature_check,clang-bpf-co-re) before checking on $(feature-clang-=
bpf-co-re)
>=20
> otherwise the test-all will mark it as detected even if it's not
>=20
>>=20
>> # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>> # of all feature tests
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index ce8516e4de34f..cb0cf06e0bb43 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -621,6 +621,15 @@ ifndef NO_LIBBPF
>>   endif
>> endif
>>=20
>> +ifeq ($(feature-clang-bpf-co-re), 0)
>> +  BUILD_BPF_SKEL :=3D 0
>> +endif
>> +
>> +ifeq ($(BUILD_BPF_SKEL), 1)
>> +  $(call detected,CONFIG_PERF_BPF_SKEL)
>> +  CFLAGS +=3D -DBUILD_BPF_SKEL
>> +endif
>> +
>> dwarf-post-unwind :=3D 1
>> dwarf-post-unwind-text :=3D BUG
>>=20
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index 7ce3f2e8b9c74..37b7ffe1db27c 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -126,6 +126,8 @@ include ../scripts/utilities.mak
>> #
>> # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
>> #
>> +# Define BUILD_BPF_SKEL to enable BPF skeletons
>> +#
>>=20
>> # As per kernel Makefile, avoid funny character set dependencies
>> unexport LC_ALL
>> @@ -735,7 +737,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-=
cmds.h archheaders $(drm_ioc
>> 	$(x86_arch_prctl_code_array) \
>> 	$(rename_flags_array) \
>> 	$(arch_errno_name_array) \
>> -	$(sync_file_range_arrays)
>> +	$(sync_file_range_arrays) \
>> +	bpf-skel
>=20
> I think the 'prepare' target is misused already with other stuff,
> there's generated bpf_counter.c dependency on util/bpf_skel/bpf_prog_prof=
iler.skel.h
> in util/.bpf_counter.o.cmd, that should triger the build no?

This doesn't work for me. Once bpf-skel is removed from "prepare", we hit
compilation error before util/.bpf_counter.o.cmd is generated.=20

>=20
> we have few other dependencies like that for flex/bison generation
> perhaps we could follow also that=20
>=20
>>=20
>> $(OUTPUT)%.o: %.c prepare FORCE
>> 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(build-dir)=
 $@
>> @@ -1008,7 +1011,52 @@ config-clean:
>> python-clean:
>> 	$(python-clean)
>>=20
>> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUB=
CMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
>> +SKEL_OUT :=3D $(abspath util/bpf_skel)
>> +SKEL_TMP_OUT :=3D $(abspath util/bpf_skel/.tmp)
>> +SKELETONS :=3D $(SKEL_OUT)/dummy.skel.h
>> +
>> +ifdef BUILD_BPF_SKEL
>> +CLANG ?=3D clang
>> +LLVM_STRIP ?=3D llvm-strip
>=20
> please move this up where we have similar setup like HOSTCC and others
>=20
>> +BPFTOOL_CFLAGS :=3D $(filter-out -D_GNU_SOURCE,$(CFLAGS))
>> +BPFTOOL :=3D $(SKEL_TMP_OUT)/bpftool-bootstrap
>> +LIBBPF_SRC :=3D $(abspath ../lib/bpf)
>> +BPFOBJ :=3D $(SKEL_TMP_OUT)/libbpf.a
>=20
> we already build libbpf.a, chekc 'LIBBPF =3D $(BPF_PATH)libbpf.a' above

Yeah, this works! Thanks!

>=20
>> +BPF_INCLUDE :=3D $(SKEL_TMP_OUT)
>> +submake_extras :=3D feature_display=3D0
>> +
>> +$(SKEL_TMP_OUT):
>> +	$(Q)$(MKDIR) -p $@
>> +
>> +$(BPFTOOL): | $(SKEL_TMP_OUT)
>> +	CFLAGS=3D $(MAKE) $(submake_extras) -C ../bpf/bpftool \
>> +		OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
>> +
>> +$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(BPFOBJ) | $(SKEL_TMP_O=
UT)
>> +	$(call QUIET_CLANG, $@)
>> +	$(Q)$(CLANG) -g -O2 -target bpf	-c $(filter util/bpf_skel/%.bpf.c,$^) =
-o $@ && \
>> +	$(LLVM_STRIP) -g $@
>> +
>> +$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
>> +	$(call QUIET_GENSKEL, $@)
>=20
> is there a reason to use call in here? you could define QUIET_GENSKEL
> to use $@ and use it the same way as we use the rest of QUIET_* stuf
> in Makefile.perf

I am not following here. $(CALL QUIET_xx) was used for QUIET_CLEAN and=20
QUIET_INSTALL in Makefile.perf. What is the preferred pattern here?

>=20
>> new file mode 100644
>> index 0000000000000..5263e9e6c5d83
>> --- /dev/null
>> +++ b/tools/perf/util/bpf_skel/.gitignore
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +.tmp
>> +*.skel.h
>> \ No newline at end of file
>> diff --git a/tools/perf/util/bpf_skel/dummy.bpf.c b/tools/perf/util/bpf_=
skel/dummy.bpf.c
>> new file mode 100644
>> index 0000000000000..492a43a851deb
>> --- /dev/null
>> +++ b/tools/perf/util/bpf_skel/dummy.bpf.c
>=20
> hum, what's the reason for dummy skeleton? it just adds
> time to compilation no?

It is mostly to test 1/2 of the set works fine. I guess we can remove=20
it in 2/2?

Thanks,
Song=
