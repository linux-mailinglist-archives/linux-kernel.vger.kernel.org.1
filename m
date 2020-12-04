Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36422CE6F6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgLDEO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:14:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58066 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbgLDEO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:14:28 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B44B2Mb005830;
        Thu, 3 Dec 2020 20:13:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b5Kh1W7lIVIiiAQMC4KWyw/p7rQkDbJRd+HWcWV6lno=;
 b=aFiMd4yaRuvOrn9WW6g6YAQiLSQFjEUfGW8cHzS/4wQo8EB5D75w+N4LrChEVKxsfXjA
 hg8sOrUP1NWAnqvDON8fnl1In+jXr1W77g17pSpkpxi4IwG5omu6jAjFH6tw2KoehR4/
 Wnfl3UuiAu2WS584Z5kVfFOrQGJv4bxfsVE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 356xfqxhnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 20:13:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 20:13:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4jlAeRfwomxdb2s8pnkDKJIAQVJTNlm2nAGNvNVA72YGYdTLtTzl+wvd34aE7QWfAPZXv8YO+185KC35JhpBVIfboSvEfN2aHNVkbCiRNrtzngz0yqSivhS+79yZMzp0fr5MiprzletgF6Xe1rvVsPgnJNKoBOcQnzPmMOeXcwp1q/KDkKxP49g+JqwUaxa77P/fRMkVOHMDhZs4M+S2amuLV7sL3FCypIRLpyGM3NusDGQpCPeSr98mDrxX7bS+eGL0PvhfhlAU5fMIOgWBeThPTzzzi/J2vk6+gAmgh6SrK4KVrJioSFegE/HLn8s8tHskIminr5+B/YI/ialsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5Kh1W7lIVIiiAQMC4KWyw/p7rQkDbJRd+HWcWV6lno=;
 b=FzPW5+to9jxpS+D+tJ7wSVw+GPTZzIecF0AJx6geolpdRobkyZfXyn30YUS1LLDQtB2eiCRnZAkkl+mjR1tn4E8aL7esONJKL8rrLKMj1IXavALWf77VrVb9zWZw7I+puK0kqi6GjBVPYB5lHTzP2tg5lg5p9XVx9vdOHHA6dTAlX58G7WD/GqOEWUZJsT9ZCLAr6o7wVjUgsO8+K/JWLIsWkbFJvynQH0QJ6VsPOluF5Eoeq2TFiVtobH+4u5eDejxs/vHUK9s8CuYP0MUyCPpGnf4SRavS4B7Nh95l3/iS30RO7z0jNcACHGIpbbod9u2vZo/tFHfZHGHw3ow/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5Kh1W7lIVIiiAQMC4KWyw/p7rQkDbJRd+HWcWV6lno=;
 b=ktL0RS5mMQ2mvUNAhDesbGeroGLdA8Z/xM2RigYKcd0LFWzGZKVMro2vbXvHqGYLeNEKmqtevAKoSugrfMll1jslpvKDDAdCuEzZBaqX3TX57U8wFm+jAqV47BbDZ3dhurlm3CnrPFZfoJXF5y16XW53lsyjrlvAgVeZfU9aWEI=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3206.namprd15.prod.outlook.com (2603:10b6:a03:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 04:13:12 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3611.034; Fri, 4 Dec 2020
 04:13:11 +0000
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
Subject: Re: [PATCH v1 1/2] perf: support build BPF skeletons with perf
Thread-Topic: [PATCH v1 1/2] perf: support build BPF skeletons with perf
Thread-Index: AQHWyI7WcdyO/2a7l0yjm+vqbp3x6qnmB9cAgABOmYA=
Date:   Fri, 4 Dec 2020 04:13:11 +0000
Message-ID: <9CC9D831-40A9-47E0-873A-99D9D19773DD@fb.com>
References: <20201202093709.3374099-1-songliubraving@fb.com>
 <20201202093709.3374099-2-songliubraving@fb.com>
 <20201203233152.GF3613628@krava>
In-Reply-To: <20201203233152.GF3613628@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:2c22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 956d4a1a-b55a-465e-cd80-08d8980aea01
x-ms-traffictypediagnostic: BYAPR15MB3206:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3206428CF9F3576785EE3F8CB3F10@BYAPR15MB3206.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNT25PYcUhyEM9GsNBuF74PKnMWac0GGcFuyQGnCAVJu+w69lt+Vft85+8iX1U8ZBMPOAm9zL2O3ju6CwCIQwEyu5M4yq9DAM1wrnXRMzqp4XpSHRFmA11pESaX0UwYfgUjRAIZjXy6HBClI+NbQ+P1jOqSTvMC8treOI+3WdY1Mio4o6wBNqnMOlI/+AuyHjrtS9X7vGWB1fZLgDmlsYyjLkc6G6D8s16fb/oSboMWB0Tr2zE+KcQj0uXjfyq1eHZHwhtT80Hty8GKZuCgNXKCeXCoNugUAUF8gIOg8XSpAEjwh+9cJ46MwKEINAmR3a8IQCxE1o9+aqhwaJLvN/noblIez6RUXHnCeNo6iBF6I3bC7owXgtz1ftvSZaXtw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(39860400002)(396003)(136003)(366004)(76116006)(66946007)(2616005)(6506007)(53546011)(36756003)(6916009)(64756008)(66446008)(66556008)(4326008)(86362001)(2906002)(5660300002)(66476007)(8676002)(478600001)(6486002)(8936002)(71200400001)(83380400001)(54906003)(33656002)(316002)(91956017)(6512007)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HMaE3TN3GzlR0/q1EzWZeWyK1IQevDFJreKmB3LhGN49axdYqjGpK7e32K+w?=
 =?us-ascii?Q?3ajtxM5GzgCPp7MXQi6GMmmH7i3absKt1YiwUPYFbdtYFBperEJRDc8NI75c?=
 =?us-ascii?Q?rvs2XP6J9IQuvDFSrl/zFlJ+tn7qTAJrQJ0mhinut0g/NNCu9MBEMNSb2fa2?=
 =?us-ascii?Q?7YQMqwFl+Qn5GKGUju+yTXQI2S3FO9LjvAAN2UO4vWPXGh2crS16PL1jDUMi?=
 =?us-ascii?Q?M3ugB0Vl8xUtQsNr5QEsJPGPXzGfXXf2xvIcPK8g5bzVhD0Cxd1Wih4uWtLx?=
 =?us-ascii?Q?UcKRXdR5ziW69Ck5MpNG8yFhHRJSDyj6WecUNjD26sup6T2UzxLZt8KCjBWd?=
 =?us-ascii?Q?CPtn+NMdPodSoaBsWZZ4t+KyNAIueW3JTu8RNTrzLmHpMHppMKFWoXIerKQu?=
 =?us-ascii?Q?gmJFok/hJc2R6wWknnguFDMWc3BW6YCE01YPI7PIeudbcPXJGRSootOFtePK?=
 =?us-ascii?Q?+bSBNFCr+ahvEz3oVUlM8XRS/pwA5da5MQWBu01cad/it+uK/3J2o8Y/yXyl?=
 =?us-ascii?Q?tRL4fsIYC/XpPeMRs7VqSgfEjaMVmW85K55jYjcQjAIxPHFZA3N1PZP0tojd?=
 =?us-ascii?Q?SelUJ7CDF1H4aiVr5HZmZzCYbb3OpVF1YvngTkoJzgdfxdSr3OndaOgvWia8?=
 =?us-ascii?Q?y1pc2QuZXrQikkikhSPJ3dzsUPTwncBxUsFZ0WVK0wbKRydAUNKf8MCuyBu+?=
 =?us-ascii?Q?y2h7tF0nNrtvKTGxkxiWiVWYvbTpLC3dcggGDEYwT9I+uNVghIUAwKyv3GRg?=
 =?us-ascii?Q?2HJRlr82r6WGcn/I7xj7lq8qEATZ7B5yuI04JlyrFAMfFoi1zfw3XSC7yfG3?=
 =?us-ascii?Q?Fb8SDF3eohyyBvMJqIXKQDpv40nPL7B02i0kM1gctcPsPl49kdSgKEfpbEwn?=
 =?us-ascii?Q?3LWGHuO54q1XEdGYLoVZSYqpiBfNd3kW3IhgYH700MEqi7ElaXO4Oa7/hHOY?=
 =?us-ascii?Q?YpQEOgx5DzySzB1bu3+Fw/WeUa0gGyJLS1jy5wCbO1nYxvGFGn0kYIJBdhjI?=
 =?us-ascii?Q?3SR0Ms5Avuny9crwRaTramxQDtCjF8SlNhHaej1lTjLFy2Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BDEE8889A4E018488BF58DE7E03FCABD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956d4a1a-b55a-465e-cd80-08d8980aea01
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 04:13:11.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fB/M55Rc23iS/y5A3/Zop8q0CXd9tg9DK6yayDhqzr+OD4lkTKQknvotr6EPBpPATzsK+6n0SAca1SJZb0WInA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3206
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-03,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040022
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 3, 2020, at 3:31 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Dec 02, 2020 at 01:37:08AM -0800, Song Liu wrote:
>> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
>> by far the easiest way to write BPF tools. Enable building BPF skeletons
>> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
>> be added for different use cases.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
[...]
>> index 97cbfb31b7625..4eeeabbaa2947 100644
>> --- a/tools/build/Makefile.feature
>> +++ b/tools/build/Makefile.feature
>> @@ -99,7 +99,9 @@ FEATURE_TESTS_EXTRA :=3D                  \
>>          clang                          \
>>          libbpf                         \
>>          libpfm4                        \
>> -         libdebuginfod
>> +         libdebuginfod			\
>> +	 clang-bpf-co-re
>=20
> do not use tabs in here

Will fix.=20

>=20
>> +
>>=20
>> FEATURE_TESTS ?=3D $(FEATURE_TESTS_BASIC)
>>=20
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index ce8516e4de34f..c8ff82b4fc1b2 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -621,6 +621,16 @@ ifndef NO_LIBBPF
>>   endif
>> endif
>>=20
>> +$(call feature_check,clang-bpf-co-re)
>> +ifeq ($(feature-clang-bpf-co-re), 0)
>> +  undefine BUILD_BPF_SKEL
>=20
> we compile with 'make BUILD_BPF_SKEL=3D1' so we should fail here
> with the standard 'please install..' message we use

Yeah, that makes sense. Will fix it in the next version.=20

>=20
>> +endif
>> +
>> +ifdef BUILD_BPF_SKEL
>> +    $(call detected,CONFIG_PERF_BPF_SKEL)
>> +    CFLAGS +=3D -DBUILD_BPF_SKEL
>> +endif
>> +
>> dwarf-post-unwind :=3D 1
>> dwarf-post-unwind-text :=3D BUG
>>=20
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index 7ce3f2e8b9c74..f46f0cd012b2d 100644
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
>> @@ -178,6 +180,8 @@ LD +=3D $(EXTRA_LDFLAGS)
>> HOSTCC  ?=3D gcc
>> HOSTLD  ?=3D ld
>> HOSTAR  ?=3D ar
>> +CLANG ?=3D clang
>=20
> please keep the indent with other ?=3D when possible

Will fix.=20
>=20
>> +LLVM_STRIP ?=3D llvm-strip
>>=20
>> PKG_CONFIG =3D $(CROSS_COMPILE)pkg-config
>> LLVM_CONFIG ?=3D llvm-config
>> @@ -735,7 +739,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-=
cmds.h archheaders $(drm_ioc
>> 	$(x86_arch_prctl_code_array) \
>> 	$(rename_flags_array) \
>> 	$(arch_errno_name_array) \
>> -	$(sync_file_range_arrays)
>> +	$(sync_file_range_arrays) \
>> +	bpf-skel
>>=20
>> $(OUTPUT)%.o: %.c prepare FORCE
>> 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(build-dir)=
 $@
>> @@ -1008,7 +1013,44 @@ config-clean:
>> python-clean:
>> 	$(python-clean)
>>=20
>> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUB=
CMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
>> +SKEL_OUT :=3D $(abspath util/bpf_skel)
>> +SKEL_TMP_OUT :=3D $(abspath util/bpf_skel/.tmp)
>=20
> hum, actualy we use $(OUTPUT) and if it's not defined we build
> directly in the tree, this should follow the same

Good catch! I tested with OUTPUT in earlier version, missed it=20
later on. Will fix it in the next version.=20

>> +SKELETONS :=3D $(SKEL_OUT)/dummy.skel.h
>> +
>> +ifdef BUILD_BPF_SKEL
>> +BPFTOOL :=3D $(SKEL_TMP_OUT)/bpftool-bootstrap
>> +LIBBPF_SRC :=3D $(abspath ../lib/bpf)
>> +BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/..
>> +submake_extras :=3D feature_display=3D0
>=20
> there's no need for the variable, is there?
> also why do we want to hide it?

I guess no need to hide it. I copied this pattern from bpftool.=20
Let me remove it in v2.=20

Thanks,
Song=
