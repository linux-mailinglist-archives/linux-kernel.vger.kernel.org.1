Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991ED2D4F79
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgLJAd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:33:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59802 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726092AbgLJAd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:33:27 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BA0Qm0n012879;
        Wed, 9 Dec 2020 16:32:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nJclgvpvoVt5roFk+2xzfwWryrCXNUo/4uNcHujeYp8=;
 b=hlOg4uNf5wBGrK0Od9ChoyMRKaUnlz0dtuaGGuojLbHdfepS9T3fHTlNXN2L2LuxOSfV
 Q4N5DObhSxM0XuP1ijhK67Kv141n4iSxXAK2Pql40Nl3LEvxSsTFyVUTxeSLjuOPIPmy
 qE/YvaTzkZA/e0JJkj5M3w8A5Bfv3DLOXYY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35afx8a990-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Dec 2020 16:32:36 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 16:32:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bf3Uom8nRskbRdEkY9977Ca2VJnBxM/EBdDQuxxCd4kJKYKZY9IL4bQO9PBD9SrrtIokV8uPF4fmaIgF5C3MPSSyJTu9JhS9tnUobLNNTIG0uxxyUWrAaT4PlVZ1A7ZcFkvAbp4yDR3wQd8ZLTfHRMo+ZLrRZzhYT4ObcPfmbhCnb2GwUn5rK88keQkAG9c9gOwVBH4gTzuwNt8LnTOFdT8I51hSzdk53pxA1FpqNv2VLdWAC5Br2Y7r7Qg+vDXOxJji5pIOfuLKvXu5XbvYB3Rn77x1KtA6IBqrp29ifd4merX4frUtvl/i3K0QvhZxcs/zTEonC+P+8YgEUC3PXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJclgvpvoVt5roFk+2xzfwWryrCXNUo/4uNcHujeYp8=;
 b=A9BdYjkASz4Fw7nJdO4adCWicvp9x8iyAnUId5AI3ZpM/MoUl5M50ecOCPDyHVIEGyZm2G1rRD08vMgYvaH4hT1ddaGjqC6fBwG27dOQvWCFJWXwW3xuNAFgcCaySRNMxAt3kRrdhwiURuUtI2vYxkfpA7OnqwuK0REPvkGz3wmR457i/cqfHldcINcyVcKDUAVnbm2yOZjZCk59WKK/gYtjSYL2Z2k+G/mGegqFhD8hBH7ceqxU/hCBKmdb+8hnTDSFGoRyjzHwhtsijAjK1YBwKWFjXPwpBsldN+2DbXOGswJAoWLM+b3FdFwrBm6dNdBBmBb9B3RNlzmMhe4Nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJclgvpvoVt5roFk+2xzfwWryrCXNUo/4uNcHujeYp8=;
 b=YR5/q3uG+s1Fl61OtDUqMDE/ojztYoKs4NJHBVydk51VFDWAQB+0Y9BvMYOWYzymzrBnJfZc3Auj/HIbGQPcrxTK09vJK7f+bfj5sWy9BDZRLt+5Uc3v1KQvJgr27/KUH/ADTpT+LWKzyq4Bzw0Hjq3y3/3yUt/GYn4GMEV8Eus=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4247.namprd15.prod.outlook.com (2603:10b6:a03:102::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Thu, 10 Dec
 2020 00:32:32 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 00:32:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v3 0/2] Introduce perf-stat -b for BPF programs
Thread-Topic: [PATCH v3 0/2] Introduce perf-stat -b for BPF programs
Thread-Index: AQHWzY5X7fYeXQ1n+0S4TM83rrVmUKnvCIOAgABjCYCAABE7gA==
Date:   Thu, 10 Dec 2020 00:32:32 +0000
Message-ID: <EBB4ECDC-C3CA-4474-A093-3A1FE41B29EF@fb.com>
References: <20201208181646.3044417-1-songliubraving@fb.com>
 <20201209173623.GA185686@kernel.org>
 <DDA97AA1-E60E-4075-8569-73C65270E43B@fb.com>
In-Reply-To: <DDA97AA1-E60E-4075-8569-73C65270E43B@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:d023]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 516a9edc-e3e2-4846-d3e5-08d89ca3153f
x-ms-traffictypediagnostic: BYAPR15MB4247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB42477520A7F3DE95B9D76816B3CB0@BYAPR15MB4247.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9OEV7aBII3RAexIQB6+v5XyfEJbV+o8fnvX0veO6aesNCXbCHhxpBYnRtjgJxTV26dQ1qA4PaV1540AW8iGfxgvlUyQ+1DBnZl3Q7kXOp93JnaefABfjGbmdCwCh4ee/YxpI36uQ95kY51UnfWstiT5IyVSRKSXi5OTz4yfnjcX2zqJxW+RCR8Vl07xepu3JhPZnupEseSJXx27NwWmlhB7ZOO9ZQqKjpQEj7I8XhapOOVM4ATpxEwRUwYzZPtbdUsw3woZhd0db/D7tEQ/kLe0vCnsoehrpzG/mJLLdvkyRsFUnNWZsdusceFDqLawDRF/VYHwsF7BMApHcPdQaVYONq6JagLWODjA0s8z1Kx4jJCSRHN9+/JnSzIXUkgj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(76116006)(8676002)(5660300002)(8936002)(508600001)(66446008)(66476007)(66946007)(6916009)(66556008)(64756008)(4326008)(6486002)(86362001)(4744005)(53546011)(6506007)(33656002)(186003)(6512007)(54906003)(2906002)(2616005)(36756003)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?x1hZAthwxcrhUZ/+cJ7pcY/LbCMBuTnhbbQe6SKiZ9LpPCPSxI6zkAfYrJBs?=
 =?us-ascii?Q?yOLOs7cFc3D+L0mYkJZNtX5XWJygNr3YdaEdyJc9fKu47klbxwlEdCgdWKRZ?=
 =?us-ascii?Q?LLuGIrVz2jiBw7sXm3ksAfwdmYw9f9yVcIOVokPhtDHaHLIqcLzyuZVH+jkf?=
 =?us-ascii?Q?RZYqfXg9HENVYDqYl/uF3RTUtD9as7t6dw+tven/6xMXw/FmWKIySXC7SQCV?=
 =?us-ascii?Q?a7TZWRAXYzaNeaiLhShMDBBqpLw3PyOJGbQ6jddklSVIYvqXpH3UO6I35HvX?=
 =?us-ascii?Q?VGELYU1xUDh49sWRjGjixyT1z/DfTPigtjg4wUy39fK6ie54nSjqTzmLx9X0?=
 =?us-ascii?Q?Q4D2sRXuuBVVbrZBDw0VU1yTjfdPy/dDxFTuQ7vKFq2ybtw3QzVCMItLN+IY?=
 =?us-ascii?Q?c+5PiNSOjUytlvXvHGnlVZKp2bXcsVJsxEllPJ4kgpuXXfmjbGDVNlEZH23S?=
 =?us-ascii?Q?/oO8vDrRBEtouSzcm7nuyvusGKJKsTf2wbr9FLgBF+nEt2J2si6b6zDW9/QA?=
 =?us-ascii?Q?eLl94RVe/tY0qs1MaXbqkoikAlMwrHXVn+SE4JOp0iGqKHOXUrq8EmEXkJDz?=
 =?us-ascii?Q?DoTobjrqPT3WXMNwPFO7eFIXFq0O82B5iGxGSNG30ZnfMz7Rr+VQHhiadLMc?=
 =?us-ascii?Q?HRfwASitN0cm7jg6zUGICok8dcIWjBp8lykCiDQrD9W4xc98VkLT626hklgk?=
 =?us-ascii?Q?TFKTDaia4J2ZQI7AwO1lXF9RK0NOnIlD8tiaGEdjwS1btPNmUMI7GIbtz0ES?=
 =?us-ascii?Q?TY1gNUexDR2fe3a8oL2fw/L+QvPvzcMYv36HchHJs9MsNr+zNU6nJWfyEqQP?=
 =?us-ascii?Q?fxiH22oTSUO6WK2Q8IQcBPoj1r2TvlGvfbZFs7vUFEQW9XdMjTfACb1lqoaV?=
 =?us-ascii?Q?ykzcqOK2eMhTX3+6iVtrf8S+2TA4chuyqDYonXjSDmExQv+Cr6rqfFkYBlA5?=
 =?us-ascii?Q?Ih76YQDXcSwB4uuIG4L9UwjE7JsqdUJwFI1NQqR8DVglqBaDBD2qGMfLg/d/?=
 =?us-ascii?Q?9gwhzxv2kVvApdjMqd9DCGF2w/tHj1cNIqBWWpTbTmTJYw0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7207D2BBA1D8644EBCB8028598970158@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516a9edc-e3e2-4846-d3e5-08d89ca3153f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 00:32:32.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CMTW7D9XnGkoCf9U90CkQgduo1HfCTxdTd+5nkEr2/Lcchxqih24BqkA7BG0htno1FbGdK88iV9dJMAA1sjSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4247
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_19:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2020, at 3:30 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Dec 9, 2020, at 9:36 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>>=20
>> Em Tue, Dec 08, 2020 at 10:16:44AM -0800, Song Liu escreveu:
>>> This set introduces perf-stat -b option to count events for BPF program=
s.
>>> This is similar to bpftool-prog-profile. But perf-stat makes it much mo=
re
>>> flexible.
>>>=20
>>> Changes v2 =3D> v3:
>>> 1. Small fixes in Makefile.perf and bpf_counter.c (Jiri)
>>> 2. Rebased on top of bpf-next. This is because 1/2 conflicts with some
>>>    patches in bpftool/Makefile.
>>=20
>> Can't you split that up so that I can process the perf part and the
>> bpftool goes via the bpf-next tree?
>=20
> Actually, I can make it conflict-less, so we can route everything togethe=
r.
> I also put the change to bpftool/Makefile in a separate patch in v4.=20

Well, it is a little tricky. bpf-next renamed the bootstrap version binary,=
=20
from bpftool-bootstrap to bootstrap/bpftool. So we will need a follow up=20
patch after the two merge.=20

Song

