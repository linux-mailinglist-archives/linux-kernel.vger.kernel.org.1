Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7E2E728B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgL2RPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 12:15:11 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgL2RPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 12:15:10 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0BTH9299013503;
        Tue, 29 Dec 2020 09:14:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=a0Pwkx5DMYp8Z1niHQ/XantggowRMM3soqsZ7B5n4yM=;
 b=n2BdArJ+61YYiKuiUK+BRjvcocPCHLa3EZ9b3ofkfDLeqjQACwTiMghjLWbKlarlNXkl
 7AZADFQbPihape8b3UGfTc6xCHaRdb/gBK+SX/Hd1Nqo8tW7IiSIrUCiOPgZwYhvoDjY
 lBu31gCfwg0qk/hV7Y5knPRsdmxMNv6f++Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 35p1j62k45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 09:14:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 09:14:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro0XZh54ScCk6ACoQLxwcgnYUSRKQEctTYfMGMsW9y4kw2N4Dg7xlDogXkLco5fFB53RT3yawm+DfbzDN3qhHpD7qWfYSXbOPqbTRZc0h3LXbiBUiIwNPHX9jTkesttjxa4VCLoDudbUCyVMsB8o//+JQdhD9EXih72rO/aAhK34Ccl0LSRGaEjRrtkGiSPAZtCl/p/lY+4LXPXw0a8AenJ63hsxNi6jYV6Zn4GqF22lWsIR23wtfpyVv6Q+thUP9bgZ0zIViAJZxKeU0HeP7uknKv6FNuk2onHOfm+j0pgK6QYd2EOJOgsoZXYHbMadzfXeezA7o+A91wH/WNDFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0Pwkx5DMYp8Z1niHQ/XantggowRMM3soqsZ7B5n4yM=;
 b=iA793hCq4K2b4bAkKA8CqSBcXplE038hBrD36BYGGpYOdvMhbnlCwKacM6YJb17QGILD/Sdws8EANxXqNFhLFGrJk1Xg0ozz4oP4Jnil+lJMCIHGLjbcPN625F4QLffY6ykIgocTYe4sm3ZMAe5JHdiqf48BSH8g/Hdbk+udn6ED0Pud/9ct52Ce/EMPl5uv6IhYB8UCdndy0zetXltJLU67l/U5Hz/fANahEnQIRILUEgYpyqBAoBSkey4yQZJu3z9n0TlYhMNmeUgDkhlJkzJ3mmQcwb7moinXcInMb6h13rwzo89MFUE7MlOCa5vulAeNrcgqs6mbCv1GpM/odg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0Pwkx5DMYp8Z1niHQ/XantggowRMM3soqsZ7B5n4yM=;
 b=g0p9ZBc2MSDxmV1iCFSUsb0z3QuI9vY60ngHN6cRE0W3B8UtwfS4dyVmEyzT92hhUCabDKc8eL4StKNmR0qn9D0pkzSKzG7qtRuThBaAARC2/otuCx+4Z3T4CRYbIpNgyhSP00WI099CjKtFFInEjqCZDTt5k5kccBXvPKj5vfc=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2455.namprd15.prod.outlook.com (2603:10b6:a02:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 17:14:12 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 17:14:12 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v6 2/4] perf: support build BPF skeletons with perf
Thread-Topic: [PATCH v6 2/4] perf: support build BPF skeletons with perf
Thread-Index: AQHW3UCte2IZwxEAGUuEynMQFyV2oaoNpmmAgABQIQCAAFsBgA==
Date:   Tue, 29 Dec 2020 17:14:12 +0000
Message-ID: <7219C2C5-48F1-44A3-9787-FBD39CC58514@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-3-songliubraving@fb.com>
 <CAM9d7chjWMFNeQMBftu725cTbCRauUJinQSqy9E9itv=AJXvyA@mail.gmail.com>
 <20201229114828.GG521329@kernel.org>
In-Reply-To: <20201229114828.GG521329@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7414]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f8c7110-d63f-444c-ec22-08d8ac1d29c4
x-ms-traffictypediagnostic: BYAPR15MB2455:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2455D086CAA1FF30E979CE90B3D80@BYAPR15MB2455.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eis7vQG464EWAR777zCQdJr5TZ1wxlTKZSdeXTEit+sapWvwJEYAMZJdp9bHVg3BVSxmSUarEOOFo7s7BAUPf+/KXeQ7qyqW0OeO42mS0GwKiHfA2ydYtUxG9W0Vw/cWYZXCEKH6HYlTnTPuiRNI+N4yKYXBaKGe1wACO1wwcxHCGN2txY4D9kmE5AQ0miAzVC4NNB5g1QaTRx/yOkYNmQN5fDLJvGKX3gKfraPSmunVLAFm2oY+wmGPY7ZTeHuJhJ0+mpDzIO/5kKRbUFaPOHNAjRIu/dpliqvKRqChU2iz9a3xYZV/hsG6CXVK4D/4Anu7o452ei6Aw7YY/ROfccxkZjcfiuY0MYrtE2jmmzHoTcrdI77q0fawOXNx3jItXz47gtsXLaMvugm33ChuJAqlx2SOfMeSXnjpI/7Au/G9wKLfky84vT1tWErdXe6kHeVMY4i9BdpturhtdYNUcx7DXGeOIFEoNcDo4vNu2D8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(39860400002)(366004)(396003)(6512007)(53546011)(4326008)(186003)(66446008)(316002)(66476007)(91956017)(64756008)(8936002)(33656002)(6506007)(6486002)(2616005)(86362001)(76116006)(8676002)(6916009)(66946007)(36756003)(71200400001)(5660300002)(54906003)(478600001)(2906002)(66556008)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?i28imnIOUBik7Ez/R3VmKsoSeb5hChVwVFNpODuoCvtQ3hWXcPmTC9maS8jg?=
 =?us-ascii?Q?IBUuEaY7a7LpwAKYwGFn/4PvbziZYDsEUjguGHmUEjLWMB63gzZcRWWBAQmq?=
 =?us-ascii?Q?8QbTev9KTUQ+nVY0TZPxsj+oWX3ZKRq0Mh3pTXZG6158BwohXlTkcxl7NVA8?=
 =?us-ascii?Q?0J2ab0Gmzsw+WWp5MgwCLdCLSJ0+n9n8v8TbHqMe1h/AgCG3qpP3ElO+9toI?=
 =?us-ascii?Q?a/KkSXfhanm4hGJLjji+/Kh5V5v4Ql8DrEfx2n+Hzzm2PEre14N47m+9mpzs?=
 =?us-ascii?Q?GKSSzTij1xR2y2WmCNZQ+lrSBrgzpfR9lssNIAMsQhgz7HvmRKcgJakh9VRQ?=
 =?us-ascii?Q?RKPoeq59uGvmKX8EcwOtSjKhbECPkJ6hH3Dkp//R3ZP5UvRi0E+5rBSAUZvT?=
 =?us-ascii?Q?zlzFAuUyvzDyubbkjRIyLVhFI7q9eH09uj3/g+nzRsIkiBPMjWqLnVjwR/wQ?=
 =?us-ascii?Q?DpwcCsCq6X8ypkiFkxbPYLRzLpXCcpGUoQxPcTgR4IOX801JfZsOu25VKjVG?=
 =?us-ascii?Q?Ac9yemNEcAPmmbEW+WU5qzXGptfWQgIeYX0oue1m9ebilDqDvS64TS/cFEjG?=
 =?us-ascii?Q?fDRoAhxkSvQAcDMQ9SZKPfXZFSe208wCVNX3gT/yUSe9CHv97s2PG7GPbRx1?=
 =?us-ascii?Q?jQV+x/G2LXOhMZ+1WU3jgR2YkiJ8rWgv+iNsPGMljlBn1mDCafLxHG7u7cmL?=
 =?us-ascii?Q?EldxKsedUeJi3xUsX09r73SBtdRUkTfMXriiCFeoIJIGBmAmDEbOKwSJ06ua?=
 =?us-ascii?Q?DTIdTaszIHi0gpKg1GQvHbEMb4RYw8CSWk5X3du71941NvcMR/0BBEY3bHq5?=
 =?us-ascii?Q?qhdaXvO8+3AhYYrbv9nbMnziHoyCn+YjsQ08QnMQjMnQfDU3OZc7tEpqr15R?=
 =?us-ascii?Q?ASg9CXGZd4I0EqeGnmfqha50hSgzNX7q94MUkaloPwwe5wfjFbubVoMqL+yx?=
 =?us-ascii?Q?vHjnNJnmZmuZnnSMoZ60EVHUSVtxEQ9R9P2cpOjxA1E9rqIv5gbHjOhOWR8u?=
 =?us-ascii?Q?uSGly/O3bHFq84JcZpx4f3k6aoDNKzGXufhp/kIMLj8asE8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <01BCDEC001CCB1428290699B1D4AE548@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8c7110-d63f-444c-ec22-08d8ac1d29c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 17:14:12.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IiVS7S/xuJleEOCbXmyIEnqbY4pYVQBj30L6bhKn4bEDerPEAoqxtRP8xneQRCBNccXPneP7Ixw1PFdbffI0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_13:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 29, 2020, at 3:48 AM, Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>=20
> Em Tue, Dec 29, 2020 at 04:01:41PM +0900, Namhyung Kim escreveu:
>> On Tue, Dec 29, 2020 at 2:41 AM Song Liu <songliubraving@fb.com> wrote:
>>> BPF programs are useful in perf to profile BPF programs. BPF skeleton i=
s
>=20
>> I'm having difficulties understanding the first sentence - looks like a
>> recursion. :)  So do you want to use two (or more) BPF programs?
>=20
> Yeah, we use perf to perf perf, so we need to use bpf with perf to perf
> bpf :-)
>=20
> Look at tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c, the BPF
> skeleton used to create the in-kernel scaffold to profile BPF programs.
>=20
> It uses two BPF programs (fentry/XXX and fexit/XXX) and some a
> PERF_EVENT_ARRAY map and an array to diff counters read at exit from
> counters read at exit of the profiled BPF programs and then accumulate
> those diffs in another PERCPU_ARRAY.
>=20
> This all ends up composing a "BPF PMU" that is what the userspace perf
> tooling will read (from "accum_readings" BPF map)  and 'perf stat' will
> consume as if reading from an "old style perf counter" :-)
>=20
> Song, did I get it right? :-)

Thanks Arnaldo! I don't think anyone can explain it better. :-)

Song

[...]

