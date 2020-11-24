Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483052C34F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgKXXvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:51:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49894 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbgKXXvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:51:44 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AONmWen032382;
        Tue, 24 Nov 2020 15:51:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=IQgEP8ekxa3k2r0kgX8aD30A+VXkd3IdaNAyK2oKOQA=;
 b=UEs8PGL/oWrzF4jfVAUvGsR3wjlV0rm/r1Kd7/omXpsAa2le7MQGC0vZCWkDuzzI8Gpi
 m9puZ2cdpdm+eZaXFQ9ljq4Jo9k3CjKvuqYUv4nys3ajnJVSm3sWl1suh8hLO1Pp9HYZ
 XKqtm1oScAWFDE3MbunBXKYxjpripcz/3zc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34ywv0tjv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 15:51:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 15:51:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7OZP+GgLkf23IuNbwArA3DfLooDs29D42ljYa2a0+5k8l3o2H5XMS4NvfO3bfAmDh7K91wCMzxOH4v8PnTdMmIk5HS63Vvvm7n9cUBxZDVv70sVScJ5wQGuEpcIVizWgw9BnxZViN+u41T2v6zvtVk5mznKZC+QZQkg/2+tyOeX5JwEohPGtW22KJ7DV+q9xsF2TbdOnjmjaaT7+IizYEpzLKpa0xmGzNxtz/+xeQRkpuL7eTIsePnIay4JC1Y0HIXu1mmHA31mi4QPQSkXtLIKQAXCxTu+mKolrAo04LgNpul8p25vaFXIIzg0a3kKL9WExaD3/LLW4WVswOKqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQgEP8ekxa3k2r0kgX8aD30A+VXkd3IdaNAyK2oKOQA=;
 b=euYLcPM4ZCqMz1FMk1z8uG6EGwjenMdXP4XXmZkeBKSNNJX8aNd+CS6SczWuelrpT5Eqc+uwjffyextiDyhWphv3eL7iaCGdCKhI0u2f/u7JS3VACp2VEuq5GWiGQSJrUoYLV9RGPuM3+MsZy77uQA9MV/fI3hpLGHPQgRbTWOQlRobdX3QjkDzffe7plKMLxNfru/5mdxnoeMR/8BKUbECZ7fUK7FJBl2PvPGQzcjvoHMj5Rl6jwFs77G8Uf/dcoT/rGRaPOSyhAbn1cjcuM9ypfz5AQgmtpDnvn6+49XqYptD7tOh5ny7At5B5hED+/b2xZb7CwJR3HsPyzBCyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQgEP8ekxa3k2r0kgX8aD30A+VXkd3IdaNAyK2oKOQA=;
 b=AqK3yP4gIA1DHPK7dDROzk25Y9S3H3/2dGKe05BI+2Q0SZVXAe+qeUfneRxmwyIrVTZ4pYt4pnYCdLzsce+p4HrvEfxuOGVaZQ1RUJIwFdJ+RkOlDZOTjJjER24PAUZoR7ZFVezIORwz4LOOg5qbaej48xsdkebdzCP+9LYxolU=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 23:51:21 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 23:51:21 +0000
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
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Thread-Topic: [RFC 1/2] perf: support build BPF skeletons with perf
Thread-Index: AQHWvi+b1vCwOQIg40KNUQdgLO76QanU0woAgAMqAYA=
Date:   Tue, 24 Nov 2020 23:51:21 +0000
Message-ID: <E615D7DE-06E4-4903-B47D-40336EB1F184@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
 <20201122233214.GC1902740@krava>
In-Reply-To: <20201122233214.GC1902740@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f2e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19a34b35-9ace-4d8c-c3b5-08d890d3d876
x-ms-traffictypediagnostic: BYAPR15MB2566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB256668E6C62FC592F7A6C4EFB3FB0@BYAPR15MB2566.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHWcQgHBZNnXi9JR7DcZNAEjqw4tcljbtu0jOlAYELSvieObbLmL6YMuS9ghmYSWayEvtrEte4nVIP0wnytBbfW93j/MuNFWO3slqSGd+K2zQd3q6zZiv/b6v5xMHeTxrR1R4XRlUVlAyOxfMihi7PT6prz85nbx80Orhr0fyjKSjmyAzzUHpNqMpDQ/cywbO0RJWdEySv3lzaMQvDeHFS0n1Mhqqq1UCe+gwb5I8KuTsspPQQJIUOnzyG8vsJ8CM+i/tWF3myRM0udnt3cpYlLKr+tMC7o/AR8caBHZUZVML9ql62C4GhInVTGamaQwknV9FHZrunTvWVNrEaQeGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(186003)(6512007)(5660300002)(36756003)(86362001)(6506007)(53546011)(54906003)(4326008)(66476007)(2616005)(33656002)(498600001)(8936002)(71200400001)(8676002)(66946007)(66446008)(76116006)(6486002)(66556008)(64756008)(2906002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?g8TjcIqE+YBzBd/2mVWx0JLlSvOHgT7FjmO4XQkMlkt+m/NXVJ+YF8JEt8eu?=
 =?us-ascii?Q?qIFz3ChuCKrquthm0EZk21Lbh5bnvWs2ZK2H8RQ3B94qeTDqjeoSWScVrEaB?=
 =?us-ascii?Q?wza5D1dtEiYaCL038OaMCK3kqMP1QIP9Q2XY/3gh1Lcq7GEV6iVKT7JF+K9H?=
 =?us-ascii?Q?zQr2gTJb23Z2khSGfeqBtd9qadP2jOl2uRAyT1Qq8VWol0JmpCl4Kg8fOyHk?=
 =?us-ascii?Q?lIyBva5K+0IylYOzPfYPnAVKu3YzXWG9zH+eQiGiuNpCYYOfOhpTeMhoF14H?=
 =?us-ascii?Q?ALU3lJ800loeV72U+aTo9+FPVuLPalrZzYycij5j5Q7qwW8RA6A218VRJWeD?=
 =?us-ascii?Q?9gjFscSIY4eqAGR7Uv5avNOI1fWneZ1lHKMAjK7Pp+WTDplXKNw/2j+hRWUb?=
 =?us-ascii?Q?OsJ+LdXiuqZl4K2i2wVa5xK2Z2Nt2xGYcdaatATIgPb5n/ZHIpX/A49Op5WZ?=
 =?us-ascii?Q?W7jNBAu2RaN91IklxmNzWTLS4/11SxC6MZRNG6sQJiqUCwHtdwnKU6hHom68?=
 =?us-ascii?Q?db+ubZLLs9W8KMM8Kw8MnLmFw9AYl31d12xd66rp5nNb4JAVSx6YdlJDiu5F?=
 =?us-ascii?Q?lsFa/NJ8qbogwMvugUpDlznpFwiBpQidWXJuOaJV7BUx6EQj2FyPMWziK4TW?=
 =?us-ascii?Q?FaOLoOMc/dSs7A8K3HKx6PGAx7qJoSNGYmF4mIw2tJ7/ClIwdU1blegwtm5K?=
 =?us-ascii?Q?QmHX3lwPmit0ddCKnGeVbfDFKIL4kralXGB71VM633pQFg9nhaEgrxUIotzz?=
 =?us-ascii?Q?XSTlCBvBIoxD9w6ICxbKYLkgrpSpHXekh3ob1FHIj5KP6aac+MrgqBW0Gi70?=
 =?us-ascii?Q?Y8UttKFH3zifeiWdD1IVGnD+jL9D2vptbKcwnUgzYXxh7lu1UbmPaLze2dqO?=
 =?us-ascii?Q?8Qc5/WKNnm9a1eSDRQ+4cuJGgYaC1YVVKodqdE0N4Ylx8UJSv8YvVGIwk39K?=
 =?us-ascii?Q?3V4n2bxxoIriUpC4Qkt1SAOOpmAsYimdnojaPN62hVGcyVUMD6Y6ci4ig7yB?=
 =?us-ascii?Q?6gJJBxDH0lW6ndiev4qsdJsxL93/xzS3bj9cTD3820SK7lU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3994FF6FF46B940B3535F7E09F1E444@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a34b35-9ace-4d8c-c3b5-08d890d3d876
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 23:51:21.5657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hz5X0EK+6UE4gN1P26/ZVMxLSHnlQhJGwk6B6nSCfGu8wNbRTMev14oOCb+HDMb0Qz3NQAZdYmVoVUbIuiGqDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2566
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 22, 2020, at 3:32 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_s=
kel/.gitignore
>> new file mode 100644
>> index 0000000000000..5263e9e6c5d83
>> --- /dev/null
>> +++ b/tools/perf/util/bpf_skel/.gitignore
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +.tmp
>> +*.skel.h
>> \ No newline at end of file
>> diff --git a/tools/perf/util/bpf_skel/Makefile b/tools/perf/util/bpf_ske=
l/Makefile
>> new file mode 100644
>> index 0000000000000..853bece088f4b
>> --- /dev/null
>> +++ b/tools/perf/util/bpf_skel/Makefile
>> @@ -0,0 +1,71 @@
>> +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>> +SKEL_OUTPUT :=3D $(abspath .)
>> +TMP_OUTPUT :=3D $(abspath .tmp)
>> +CLANG ?=3D clang
>> +LLC ?=3D llc
>> +LLVM_STRIP ?=3D llvm-strip
>> +DEFAULT_BPFTOOL :=3D $(TMP_OUTPUT)/sbin/bpftool
>> +BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
>> +LIBBPF_SRC :=3D $(abspath ../../../lib/bpf)
>> +BPFOBJ :=3D $(TMP_OUTPUT)/libbpf.a
>> +BPF_INCLUDE :=3D $(TMP_OUTPUT)
>> +INCLUDES :=3D -I$(TMP_OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../../lib=
)        \
>> +       -I$(abspath ../../../include/uapi)
>> +CFLAGS :=3D -g -Wall
>> +
>> +# Try to detect best kernel BTF source
>> +KERNEL_REL :=3D $(shell uname -r)
>> +VMLINUX_BTF_PATHS :=3D /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_R=
EL)
>> +VMLINUX_BTF_PATH :=3D $(or $(VMLINUX_BTF),$(firstword			       \
>> +					  $(wildcard $(VMLINUX_BTF_PATHS))))
>> +ifeq ($(V),1)
>> +Q =3D
>> +msg =3D
>> +else
>> +Q =3D @
>> +msg =3D @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3=
))";
>> +MAKEFLAGS +=3D --no-print-directory
>> +submake_extras :=3D feature_display=3D0
>> +endif
>=20
> some of the above should already be defined in the base Makefile.perf
> we should use that, I think it'd fit better in the Makefile.perf itself

Let me try that. OTOH, I think Makefile.perf is a little too big (1k+ lines=
)..

Thanks,
Song=
