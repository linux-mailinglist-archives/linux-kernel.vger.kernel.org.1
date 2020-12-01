Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7B52CAD93
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgLAUoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:44:46 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgLAUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:44:46 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1KcdvI031239;
        Tue, 1 Dec 2020 12:43:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=R1BPDchuLUy1K8ZU16aa6PTT9NITj0lm+bekH7baMwM=;
 b=Id1N8NXVIoAnAddttyX+j1IuSSQsUw0C1aNKrElhCoReah0ZYzslAH804Z0JI6WmqPlu
 sM1FnhQHiSVn59px5jgGPbnCvBNolh+aZ3Y24PDT3EtqucVaBpNeTpMaO8t9o4P3o+QX
 iZrM+jiI80WN6T95cSkpXMTXzLKgaSeu3Yo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3547pspq1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Dec 2020 12:43:52 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 1 Dec 2020 12:43:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4+6W+gj741axBp+i02nLiUa0+SRwzUkxWY0LC7DeUqtvueB0hUaiDzy4NsowU5mihhMShCd03Ph0eoHnb8SYLzfv8xOKlS46KCj8p4BwFQ7XVnQwbwuslRqsGFwIAHvGUTbRZvRTMfsf9wUmDUA4fd0K1yKZHr3xLTkrY8wTozR6g9o2S3sFunvmDEtHdOlaSjxEwMF4tRIeBAjkKSQnBW+Rb2xfW56cJyEhLiXzRHdCo/gaYdvbCDg9WQbQ2vb1OUffTOdmu2LZayptD+LmEERNs+pHG8X3NCGRLz+r6kne8SWUWEucKYDTienYjgnvaFScy9XNUUYTBM8UCIp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1BPDchuLUy1K8ZU16aa6PTT9NITj0lm+bekH7baMwM=;
 b=WFC6AGhgCM2ulxrrS0fdJZoBOSpiD6mqAhF6VOelUoUDblCxWfAhYfHKyfXlnq6fz4T9hPwm1VdJ3o6Rqy8ei/q47VnlXIzPKHSq2XUwxfWsf4l867/MPu1CzWEdBYM+7GCax52p8EsI4GXK74ew2Xy4rkwGsvsU3Qtv17DjHsln2RhhO2FRSv4eevSe4em4HymK77rqUwfHRnswDseP1UVEa6oUhZmkVgjf/8GKt2wYbT37ncARafE+AJ9F2oZHcWjxw4lefgD59IFIXIsKNdZ8aqVO4rKxkmlEu/5rpbmIavjuIZMPpI3GYtbisomIUsRWNsVThmu6PyrT7lj7sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1BPDchuLUy1K8ZU16aa6PTT9NITj0lm+bekH7baMwM=;
 b=KSL7Ik0RjYDSU6+ZClHE2fCSmy3xyp2aeZwQ+S00qAIeW8RTvPzEgo/S4XhgazLVbehS92pLHMBEM7sVYIuS3yhsSmF20nJ/OwVIILCbg9FuYxOjP/TdOPW23YAWJXpnYplw8YIH13HljVnpxFAjglGm2HKCqLB09onoyqDfHUY=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2773.namprd15.prod.outlook.com (2603:10b6:a03:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 1 Dec
 2020 20:43:50 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3611.022; Tue, 1 Dec 2020
 20:43:50 +0000
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
Subject: Re: [RFC v2 0/2] Introduce perf-stat -b for BPF programs
Thread-Topic: [RFC v2 0/2] Introduce perf-stat -b for BPF programs
Thread-Index: AQHWx7S/FR2wDHKdC0yuuC4wObs7JqnirmgAgAAHg4A=
Date:   Tue, 1 Dec 2020 20:43:50 +0000
Message-ID: <2E0DA3EB-BFE7-4439-9142-DA98825B4159@fb.com>
References: <20201201073647.753079-1-songliubraving@fb.com>
 <20201201201654.GD3169083@krava>
In-Reply-To: <20201201201654.GD3169083@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:438f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 837fc6fc-6c48-40fd-6281-08d89639ceeb
x-ms-traffictypediagnostic: BYAPR15MB2773:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB27737F778EFB66DBB9E64F95B3F40@BYAPR15MB2773.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6mYRoxUlBXLQrbDNAYbx8V6aEC+78jER0TfvZuK5fuTE/94qj3ro/4waLIJlDCb5tOca6m0S1LCYbTJlaqb4YRyrt/nu+wGnO31SF3FpZQ++0Wi06o2ImjcEQxtsnnBGXhETcqEeFJGHxq+QBPn5FY7iLWJKgcir4iQX4MBcG7Ioytru78mMgax/lWKzjF1Ly25fmifoy7j1hBysmVLII9kFCQJtchDTQrPS7zJgBi+AjqiZlvMxN3KBOfAY8+OZi703+WLbFc6sIahTboDGJt0XSSvhF0gQGcGlcW6QKqDmJVg8EUe3xTqxFF34Xc/iGP5TW7du6rEOYxCdrFXFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(39860400002)(396003)(376002)(316002)(6486002)(8676002)(8936002)(54906003)(71200400001)(6916009)(83380400001)(6512007)(2906002)(66556008)(478600001)(33656002)(86362001)(76116006)(4326008)(36756003)(66446008)(2616005)(91956017)(66946007)(186003)(66476007)(64756008)(53546011)(5660300002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m4VRh4gFjvhQJW9oASLpIH9A5uSZ+qOsWPcqj9UTTNEv4m0Q6yWcmRSBlBiR?=
 =?us-ascii?Q?3pHYQITRioa2m6/JyqllIt4954Cl//OY3ChXsgqR2KDRwLDJx+7HQjGleU+I?=
 =?us-ascii?Q?v8OWNCjRO2Z+elMmMxLCwcYr4HEHEBVgxpdy4DI0P7m+sP3v/t390x18sp4Q?=
 =?us-ascii?Q?43hWnXReKd375eXKRAktJOvB4bkqg0maAsAdfN/x1741OYud8QdJlQRlThJ1?=
 =?us-ascii?Q?AsNOVcDCQLLaIi+W5ysM4SbhncrXhOG1wXRODmH7sudCgehxElbleLea+Y6+?=
 =?us-ascii?Q?pNYc39QXaLrqc1p9vMMx2ljdwb7krxIPYNvKeIF2Q1nUT3NdteRmIhK3xrl6?=
 =?us-ascii?Q?GZGXod6Inm+iHbQcRvJZiLvLkWQA4adkPvD9xcJRhSzbEzyzrcN5LGv+xusy?=
 =?us-ascii?Q?SbHY18LwVbVzUJKmYai5ZiE9v+v0DNtCwk1x8kIGAsyvt6dIG3bJjCYuwEfI?=
 =?us-ascii?Q?Z/BIPwATe044JGxBRnJ8DWbdyl4PDrHsqHTMBXhEGjGFc/+8epFJ6BUGmexl?=
 =?us-ascii?Q?geCyeFromwvGOrJbx+8aYqir0dzNsD7wrMGuUOeGY+loNH2N7uZMWiuYGnfQ?=
 =?us-ascii?Q?8YFQYsrWl0PxAQAlrY8GtvTov3mGw/KUIFYDjiMzcVHLjj2fWjalwVqZoxfF?=
 =?us-ascii?Q?cx0BpV6FkMYMsMCTDd+daFociB/5hWzUfN9LjJ8Oz82R7EDr5EoCT9W+7ctd?=
 =?us-ascii?Q?6BVqcn/Pfc4wUPvrxwGpCV1W4T1PazTvoozkxAmgXGbTeyx1VlhuVCRExxuY?=
 =?us-ascii?Q?Y5jL784AmqPnA+H5Z2SlSfVoS32sor7kkpFQ1iw/f8V8Lh0VAXhOzMdKbZsZ?=
 =?us-ascii?Q?zjYLVNbpRwHwF3R5yFVYCbgyW3vnM6B+VJvXygwmvahd5AB6gYJACYLqzZlg?=
 =?us-ascii?Q?09aGFSYXabY+VaJzHnZ+/3GQ32f1280rCnvM1FFVJ19qA0lF5CGI+k80F2B5?=
 =?us-ascii?Q?j202kECBcq+o4fUBAYAqnIiR0MTvLQv04NeRO+bhMx9Jiaj81FohUtXT2A9D?=
 =?us-ascii?Q?AJAM617IiYgrlY5YrRJ01xl524W+YcPN4vDCSd7dDLTt3lg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B4B2C7FDA19A094EBD5661CB3731F8E4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837fc6fc-6c48-40fd-6281-08d89639ceeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 20:43:50.0880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilA0K28wj8soA9m/2Or1SLU9oIZxkmVVYMHYEUa26EHTSlzu0Ju0Nw2zFW6ZiJ2atoiSbjaSdZoTb5GtERDoJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2773
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_09:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 1, 2020, at 12:16 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Mon, Nov 30, 2020 at 11:36:45PM -0800, Song Liu wrote:
>> This set introduces perf-stat -b option to count events for BPF programs=
.
>> This is similar to bpftool-prog-profile. But perf-stat makes it much mor=
e
>> flexible.
>>=20
>> Sending as RFC because I haven't addressed some known limitations:
>>  1. Only counting events for one BPF program at a time.
>>  2. Need extra logic in target__validate().
>=20
> hi,
> I'm getting this eror:
>=20
> 	  CLANG    /home/jolsa/linux-perf/tools/perf/util/bpf_skel/.tmp/dummy.bp=
f.o
> 	util/bpf_skel/dummy.bpf.c:4:10: fatal error: 'bpf/bpf_helpers.h' file no=
t found
> 	#include <bpf/bpf_helpers.h>
> 		 ^~~~~~~~~~~~~~~~~~~
> 	1 error generated.
>=20
> I added change below to fix it, but not sure it's the best fix
>=20
> jirka

The fix looks great to me. I will fold it in.=20

Thanks!
Song

>=20
>=20
> ---
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d926f0c35ed4..c8f012132d19 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1022,7 +1022,7 @@ BPFTOOL_CFLAGS :=3D $(filter-out -D_GNU_SOURCE,$(CF=
LAGS))
> BPFTOOL :=3D $(SKEL_TMP_OUT)/bpftool-bootstrap
> LIBBPF_SRC :=3D $(abspath ../lib/bpf)
> BPFOBJ :=3D $(SKEL_TMP_OUT)/libbpf.a
> -BPF_INCLUDE :=3D $(SKEL_TMP_OUT)
> +BPF_INCLUDE :=3D -I$(LIBBPF_SRC)/..
> submake_extras :=3D feature_display=3D0
>=20
> $(SKEL_TMP_OUT):
> @@ -1034,7 +1034,7 @@ $(BPFTOOL): | $(SKEL_TMP_OUT)
>=20
> $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(BPFOBJ) | $(SKEL_TMP_OUT=
)
> 	$(call QUIET_CLANG, $@)
> -	$(Q)$(CLANG) -g -O2 -target bpf	-c $(filter util/bpf_skel/%.bpf.c,$^) -=
o $@ && \
> +	$(Q)$(CLANG) -g -O2 -target bpf	$(BPF_INCLUDE) -c $(filter util/bpf_ske=
l/%.bpf.c,$^) -o $@ && \
> 	$(LLVM_STRIP) -g $@
>=20
> $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
>=20

