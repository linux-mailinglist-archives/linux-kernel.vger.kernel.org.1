Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B52E69C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgL1ReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:34:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42230 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727742AbgL1ReW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:34:22 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BSHUYSM006039;
        Mon, 28 Dec 2020 09:33:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=NBLIhDdbPp8sXKZ8oxNXJXAETMYLyv11im2EeLL22Pg=;
 b=j9vpcdyltfYtYFdahh945zDIPQm8bl9z18gBQDzfrORyYwcTNTwRBlVNxm49FGG6825g
 93MQNkFKBEiZ4mWjHEd3HGt/SwaX8b3bd4z9KSAkbx5ffj465fSPnS8MbJvWRficxQ6m
 GU7ENITQgxywtINIFplsqd/s/3lU/3dohso= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 35p1j5xqfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Dec 2020 09:33:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Dec 2020 09:33:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOaoUhmhgXL3AtAEWNLIT8Vrf5UtPxivSyLErb48xE4T33hi1NSJlSboY4AyHnBX3mlkwDRQePst7+xVErBrP7aHzyU/NsYXX7fxRCnxM1w+iJqscSpOjtLVNAmioG77kHftiXBUYs7b0bXIBeyqSXJVdThpU64q2q3KSwLGiDEAj6UkdercIrOlYARf1lxeaJUxoV2dkfYSrBuF+5fViTj02QDWsLGQ25pdSIerV19oJoc4+znYPrY0ArPuaqihtqz2QZrvUF+n5nASRKkcx4Uo0khbYDO4o8xl54Zf4iI7OqGjIfB6sX1ZFgkd+AbXn8QcfIxPMBvSzrlNnAnt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBLIhDdbPp8sXKZ8oxNXJXAETMYLyv11im2EeLL22Pg=;
 b=EgHl7kxAEM0cc3dnxxb2px5qjpcy2Zal6+QMFxWd97HIQw7XxelWIuXSOQO5OYqTUFBWJ2ieol+EMDZEeJM6YnZ+fjl0WD15RHPRKvPicWrFkOEFPhlRPHxYhVixwZyUaJ2tyqUfkFbrYhCzdVj75HF9KootDijfQfK5R3wS1DIyeMjH92WY/BhbOi8ox3MfGkA7yGrB7N1AStq+KKoB2RPftj7ELwURwogMOHusZ417ZFkE63qfiLanIAY9++mqu4yQpdLfR/bEz4nx68Mo6wfZkzsuQLivZ4QM9iOFK6Ef1VVZ4FcoMAcZ3v4f2NlKdqBhLlihBjV/oJDgxAEuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBLIhDdbPp8sXKZ8oxNXJXAETMYLyv11im2EeLL22Pg=;
 b=XJdrSQyo82hD1Cc7bE4sdMowi9FEQDCCCiEJc9aJNuOexLtZ96tdY0cRtSzs7YGWdetP7VAJ40uD3e7TC5ipmSFyegWFF4EqifhLgjce/EWg3Mnd96QhknAucobumy4cBzcbf0qS8bJJQIx0K6biMtHhfPOiZ68AMc83h+Ji754=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4085.namprd15.prod.outlook.com (2603:10b6:a02:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Mon, 28 Dec
 2020 17:33:10 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Mon, 28 Dec 2020
 17:33:10 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH v5 2/4] perf: support build BPF skeletons with perf
Thread-Topic: [PATCH v5 2/4] perf: support build BPF skeletons with perf
Thread-Index: AQHW0w4gocGH8+RVBEmmSv8gZAB4YqoMi3EAgABNeAA=
Date:   Mon, 28 Dec 2020 17:33:10 +0000
Message-ID: <91431F35-1C62-42C6-9CB8-E7BF7BC32BB0@fb.com>
References: <20201215181412.1730974-1-songliubraving@fb.com>
 <20201215181412.1730974-3-songliubraving@fb.com>
 <20201228125554.GC450923@krava>
In-Reply-To: <20201228125554.GC450923@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:c6cf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52e151ce-4fa1-4d4d-8b79-08d8ab56a5ba
x-ms-traffictypediagnostic: BYAPR15MB4085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB4085DE120763F12E3C2725C5B3D90@BYAPR15MB4085.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5LTlOnh+WC5Glk875AVihkxTQa5vsdnTyttwPgyH7fvp293/auvGUdCs5qmDJDyqNdNHUrGE6WGGuviCbfT62mDt/zGN76JYvjPOhZknsRNb1v2f5v/oBGD6QYCiHDqrl/dgs4YnRx4rPCgHX6Y0+dphs7HK387udi8JwATxjcoUgTfj183mE1q/zO7lbVArQIO31B4iNoSH0JFi6EDwKWOnhgH3uZpiHIdMxsJjSYsmaJc0JrB//iibQcPe85O0X6I5FT0IcK2azjqnzRadYme//dL8MgDlFs2uE5mStgCzVG6SWhqLo3IR6omwIXAomvZHOdKCSulLa2ybPK/Qq0/g1VtgzrAP2mZ8sZlaAKTakoB2DVmSAqN96wnvucdKuSGYVq1ERZJZM6OAguLky4VlOyxMiqmcsW102sXiMTdc5J1TAp1l/4ZgsDQ/f953
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(71200400001)(478600001)(66946007)(76116006)(6512007)(64756008)(66556008)(8676002)(186003)(66446008)(33656002)(86362001)(36756003)(5660300002)(66476007)(8936002)(2616005)(53546011)(54906003)(6506007)(2906002)(4326008)(316002)(6916009)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dksvDC2LFIEXhQOlPsccfobVb4zKy3WJZjKHWBoNszsJGmEspGC8sjw97Ocl?=
 =?us-ascii?Q?9Zp4Ystgv/WTlWuCIVah9nKxEuHJiLDaJE4oFSNF94lTf2lNApVRPKwd6e7M?=
 =?us-ascii?Q?UYNrigKmGEEpE2Jm6tIg5JtW26jDlX5e+8mtYXSEzwSn11gWIy2V4jFa+Hm0?=
 =?us-ascii?Q?yhVmTMLoUM1vZNbpNKqUpbBCdm+OEraEbzDzdvTKHtW+sZwoIcPJCmZ+RhTu?=
 =?us-ascii?Q?Khn9lfn29Psr+SaGF030I0UV0jl8E6iOgBHx7PA9bVj21XFqG3BN59fZuq0/?=
 =?us-ascii?Q?ocQbt+K5D5DD/5so/YYXU4GmYSLqLsTfjfK8UV5OcYWkNGgoVZj4ge+B0unK?=
 =?us-ascii?Q?yQuao98Lu62VNmGk8d987U1flHX3v6QcPwuytX7Nihwg/33DgiueMOl9p1ai?=
 =?us-ascii?Q?GW4h1De4WQaxcPBWQijVS1gL+OytIJshROc3O52HUfpmUa/okgD3ZGmX9tbR?=
 =?us-ascii?Q?Cn7jXIkOZNA8xwrmGIJ2cQ6HvFVhzgXW0Nk77wTLgpjdDb0iJrCDgTZlYQnZ?=
 =?us-ascii?Q?419vfT7uxJVeDC1YzHLQ8d9cnA5J3AIVtk4cWIwTfkZYUA4Vx5dq4xHtd59x?=
 =?us-ascii?Q?gB9RQiuxFkCL76DCa8CgdvcTIVpdh+ibcWmr7uUEcts6G4YvyA1a5fQb6xaC?=
 =?us-ascii?Q?Qmlz5JgJJ9RqODbMLfVgVCijALG9GLBBg3SeykiP0kRuggJmX0UXgfgiwhTu?=
 =?us-ascii?Q?gr+muiFe8sPU3G0X1vVed/kudY0qGigF46aCiJ7vsOLO0aZC3VajF/sX3306?=
 =?us-ascii?Q?c7BVs0AgVpBuMBUkgFWhlgjTJSGbtEyefCawo7+/DSL3B4ztVZ1l9awinan1?=
 =?us-ascii?Q?Z/lmRP8cwngYWWlCRKrkcrK6gUYSiwBV035aF52VmrtgODIVRY51HjGbbqC/?=
 =?us-ascii?Q?wFNEA/hD+WhfA683DTQoXF11mXuf0zyFDVPzUJtzPqkDE6HXFrbg17VEiRTf?=
 =?us-ascii?Q?WvDWA/+11rGuHDknBfdpFwOniLlmotmNnMcehb410vNg97x/gKlgxLJ5jelv?=
 =?us-ascii?Q?ySlxx6GEcmVwDYhSMTBRG4vOOWYl/CakB3CaAUMYV8QNrAk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9AC042D69F885A4F918842B83E8E769A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e151ce-4fa1-4d4d-8b79-08d8ab56a5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2020 17:33:10.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWGg5IlhsdWs/DunOswmDgLVrlDmbl8PUA2VEI8j/J2GmqmEds+OMlVlh4oC+gaDP47L21pRO717DtO5B64bNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4085
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_17:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 28, 2020, at 4:55 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Dec 15, 2020 at 10:14:10AM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> HOSTCC  ?=3D gcc
>> HOSTLD  ?=3D ld
>> HOSTAR  ?=3D ar
>> +CLANG   ?=3D clang
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
>> @@ -1008,7 +1013,43 @@ config-clean:
>> python-clean:
>> 	$(python-clean)
>>=20
>> -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUB=
CMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
>> +SKEL_OUT :=3D $(abspath $(OUTPUT)util/bpf_skel)
>> +SKEL_TMP_OUT :=3D $(abspath $(SKEL_OUT)/.tmp)
>> +SKELETONS :=3D
>> +
>> +ifdef BUILD_BPF_SKEL
>> +BPFTOOL :=3D $(SKEL_TMP_OUT)/bpftool-bootstrap
>=20
> I think this needs to be:
>=20
>  BPFTOOL :=3D $(SKEL_TMP_OUT)/bootstrap/bpftool
>=20
> otherwise it won't compile for me

Yeah, we need the new name. When I sent v5, the patch that renamed the boot=
strap=20
bpftool was in bpf-next, but not in Arnaldo's perf/core.=20

I will send v6 with this change included.=20

Thanks,
Song=
