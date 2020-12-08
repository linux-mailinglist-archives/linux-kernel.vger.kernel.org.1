Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F492D1FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgLHBAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:00:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgLHBAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:00:33 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B80w1f4012233;
        Mon, 7 Dec 2020 16:59:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=L9keGiduf2iYgWRnm6s+/ORYswgXvXUrOmQRIyjDH84=;
 b=pdUir7fT883ZMakdctAUsr6LgpJIc7LivIl8EkgKIyzfEQOoer+BBFFI96hgV4O0Our0
 xsapz/fwa9XehBDBo+xvLHJXAai8Ht4DUu7tOVJEQJNxwxxqbpo0MNIu3ZBATj6gRtIe
 MO1Nukr1j5Pcka7wiDgQHXSLPkXcMJ2tD2c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 358u5atsrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 16:59:38 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 16:59:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IK59tZLNNrUk7uq8/2lwfEqS6vDkI8HwJB5GMS5IxSZNLcqPCPLVSGq7uppsnRf11OLFzRNqVGEzHFbUFQpUwFU1SgW1pTntCBBA4Eyjka+VhWZfe5mtmD/qL6zrCXaQ2HnPe50eX4uf+8EZx/qUy60W2bNykn14ifvAYrTzJI3HmBKvuFvsBRhU3mh+E2OgpkvaDbf8fnbGMFNeTsGBr6/3cr//R3IDavXxKPrkGxgvqnP+/8uH5h4a+51HqRzLdH41AzcbadFHQL3ngZlV7GFs5aICkmSwiZeptdt7ka8EbOSdwPriUAerFVlV2bWOxsgyB/nbSWtVJzrm/5HJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9keGiduf2iYgWRnm6s+/ORYswgXvXUrOmQRIyjDH84=;
 b=GIEUZ2/JE+GFoVKvXOHRkGvdZWdA03Z/bS8/c75oDl+0XCXTILoC14LMQ93bLM/sogdCdW4/KF4wdTIDjYH4AzjdmonDorEaMIBF/KFX4vUtHhBRtIAxdoBavHZiD1opjmF//ij+L+c/B8D5FNoyqv9WGzQKm0vsZ6ZrK5xdqJZwOJM9atICj1wwBpnmvxTfTGKM1tG96rolc8YcVhnfPgweJ1IYLEKBZTHdCzlcR1lWBmeu0hg9IF0pZqcaxWBWb4dFDyLqz4RGy3WhUyekzTwq3V5xxqBbgVcD1LDnhXtDAPYnWEESSn7dXk+yxP+gtO7m6rb7M1cZVMUEATl+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9keGiduf2iYgWRnm6s+/ORYswgXvXUrOmQRIyjDH84=;
 b=KBc1UZWWhs92h6HdGtrmV/UZjMZtiJPpXRHpTl4XGnTdrGgEmhYiHZ8waenc610Dl2FauwmF1nQnOSEb/TUqw6DeakXHdYXwhnXc3Kz53gfOZlXhkBIky3vXgp6Zo8XvEZ6hXCNQvy57FBlyWkbOkU5aclkED+2H98gwBYYpo/0=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB3415.namprd15.prod.outlook.com (2603:10b6:a03:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 00:59:32 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 00:59:32 +0000
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
Subject: Re: [PATCH v2 1/2] perf: support build BPF skeletons with perf
Thread-Topic: [PATCH v2 1/2] perf: support build BPF skeletons with perf
Thread-Index: AQHWygSXdCY4tUoeyE6IevXiClBC5KnsGhIAgABMqoA=
Date:   Tue, 8 Dec 2020 00:59:32 +0000
Message-ID: <CE62CAE6-791D-4A96-A5AF-C981F89938E5@fb.com>
References: <20201204061310.3196812-1-songliubraving@fb.com>
 <20201204061310.3196812-2-songliubraving@fb.com>
 <20201207202508.GA4105119@krava>
In-Reply-To: <20201207202508.GA4105119@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:e2ec]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ae93977-3991-4167-1aff-08d89b148638
x-ms-traffictypediagnostic: BYAPR15MB3415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB341543A873C21A21FE20C4F3B3CD0@BYAPR15MB3415.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eaCd6XQyNMnV9j1IiyWLrEFkyqV8VW27qeEF0QCtevj69u8TdIctWjvF70iiWOr4JlmZ8UEn5gUgasrV1LFqLrPvyZ7qBnYJvPvk1dkfhOkQICfKioq+/3fGOKb2vawPkbznZX3Y6GOV6obcsnmNCMYb/xEiRe0wEnX1OkcYfysWJ3Zc20t2/NuKzKcVCIria45zRzVZGkGogmdxU6Sdv7obED9/U3vWUjTqp1WzdkRzqNT8PRFsOPAAFcnJI6UhqDjLOb38GUdoExpFZQkQuP6Z2hRlqcgYHqbkP5G+spdftZzRNzJm9ZHLnaB6pPGIpGg4Vpgf/ey/SnGW+PGL+nq//gCoLdDsTWGQL05ekEgfiRb/WgErbmsnGzut6pxt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(39860400002)(346002)(366004)(396003)(36756003)(6916009)(66476007)(76116006)(6512007)(186003)(33656002)(66446008)(91956017)(66946007)(64756008)(53546011)(54906003)(86362001)(8936002)(316002)(4326008)(71200400001)(2616005)(5660300002)(6506007)(6486002)(478600001)(8676002)(66556008)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0eR6u809OlXCseBmxRrJV22RBOoc3to83w1wQVG4r3qSmPtkF07PVUSFb9bI?=
 =?us-ascii?Q?2hmharZ3jkrmyVbF3M/LhS+kx5Ng0+V5hQK+FnNCgKilO2T6uDPomzz8QfZW?=
 =?us-ascii?Q?dp6stWxKlDhmE6UipMFmRMcby21y+m3ke6J32NVJ7rE+HaeWqvTUzKykm8Ma?=
 =?us-ascii?Q?nODQvVowOLinny5n24vuf9Pvs9d7jixeKD9HfiH+GSX0WJGWfuBUMZscGuxM?=
 =?us-ascii?Q?JoTPuups4iHi6I0nMoEbz5mywG76e9fZrQkB/ehBSTq3b+AwVWvxGLvSewTI?=
 =?us-ascii?Q?E+q7hGJH+XedR++ht7A2tXO5TEfXJoWgEjf3HaXWJD8Z7yuP5bn4cmYTvKTP?=
 =?us-ascii?Q?QA7T8UAErrzI6yZxs3fOV3em5T2equW4SchMmk+Rl6zFwfoecyUwShNlMhiy?=
 =?us-ascii?Q?XH/UVpIm7565ze45BPtfbXVD9vWucZ1nuYqeHd85i7huDx1IqGpDtmcvBsqN?=
 =?us-ascii?Q?j6jHI78OkLOzvkMEy7uAhVQu4HIy7YP7zwVFr35NUlinq7KsWX+RpaVW7DEO?=
 =?us-ascii?Q?vYvzvSqqUZ58ugmFQ3hMbhdoWbvw/dfORW+2lkEuWxitUQTvjM77WCaNyNXn?=
 =?us-ascii?Q?//Fpq0wxvGsnk3PyemQjCEqQQmJdN66HDJZKjw9poRKbM9eN4ephtKsJJ5Je?=
 =?us-ascii?Q?b25HKZ70M1S5gF7GuqQnffdqvudWk8nCAFpDLtl6OWf7ci/yDgN34cgOoLkH?=
 =?us-ascii?Q?yHBDWNZ6bqnA2nPpGhc/Q5Wm8ySksgo8vIPSUBP9dSllcegSEh3SfkO6nWm4?=
 =?us-ascii?Q?k+YhStKsHNkdaqWF5ga7OR7CaONGFhVRZEj/MmhJ+9t9ghjx9pFYwYuiHbuo?=
 =?us-ascii?Q?UpWQG3zEtyUi8ym4fns1EMjHqLwV3JrTMNI71zquqYL39bw9OudiOyO6eQnN?=
 =?us-ascii?Q?w3ZDhJQvE5QX3AJjFUUFyHVlFPr1Bl0ZiCbU+LcXuoWPWtPYSayhxcdSw8ZK?=
 =?us-ascii?Q?vlWguI72+z+h/mI9KJciguUpOEc71Y4AAzLyI5nQbTzhhCsvkyYKMfCIvIno?=
 =?us-ascii?Q?8uVaclWXwov2jZXuqxacInN6LFHpRagdL1GA9Ci6tD3w1tQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A92718770E681141B0C6F99C71CBCD65@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae93977-3991-4167-1aff-08d89b148638
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 00:59:32.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YhAb8UGQZ2DdAMpDeVkHiKGhv407oBB7T/UGGd+Yz61uDnuyjcPQdlziXKsieN1jBq0+EtQw/iSupHxwyNIsUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3415
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_19:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 7, 2020, at 12:25 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Thu, Dec 03, 2020 at 10:13:09PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
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
>> @@ -1008,7 +1013,42 @@ config-clean:
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
>> +LIBBPF_SRC :=3D $(abspath ../lib/bpf)
>> +BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/..
>=20
> it looks good, but I still need to add following includes to compile
> for bpf_helper* headers

Thanks! I fixed this in the next version.=20

Song

>=20
> jirka
>=20
>=20
> ---
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index fb7de412152b..1f2fe339be85 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1020,7 +1020,7 @@ SKELETONS :=3D $(SKEL_OUT)/bpf_prog_profiler.skel.h
> ifdef BUILD_BPF_SKEL
> BPFTOOL :=3D $(SKEL_TMP_OUT)/bpftool-bootstrap
> LIBBPF_SRC :=3D $(abspath ../lib/bpf)
> -BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/..
> +BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(BPF_PATH) -I$(LIBBPF_SRC)/..
>=20
> $(SKEL_TMP_OUT):
> 	$(Q)$(MKDIR) -p $@
>=20

