Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA92D4ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgLIXb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:31:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728840AbgLIXbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:31:51 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B9NLTGR001703;
        Wed, 9 Dec 2020 15:30:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=M0gi1IJDagYzFGT/diMVomYOJP+wneE8LC067pucZ8E=;
 b=WEotQmvvM9hM+BgZe+V8VH10Khi2OZDPmauKa9yLOmhotZrvj/4RT7I0WFCxglF3UqY4
 Nm7lHYGQW8T4uTC5RB+JUjuMFzP4yI0wRxVlLQlEFSOx8qFbxPn0KK0HnK9lw9ax6JHZ
 XPDG+in7N0/noDfjltTze8UYaEsC0T7+whc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35b3erhy9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Dec 2020 15:30:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 15:30:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWuAU6dwli2hETsTJT526iYBpMh9JBHx84Y4JeEzK0rZZB4gpNYzyeG4HWDXVGmYD+xdLY8PFrhmlm42wGLJ3b4+DBDuSuLzlgpq469DkhAOC8BdXkL+wQjOoMxFTuvwfl0y5RfV33jzNEW1IHzUGmGTsheUwRkoidBkn6aQl5yWQSN99w2bzoYB8UOaS4AQAYnpV9IuwhQl8OIItjqSpcIz7DV33gqSwJSeZWH4ChF2G2xx2JQO9s0NhZJ1x4QWlV0aI5544CvawEK3vn+o1b7wGGEzqN9bmjqsErm84cw1MCdrKEr3pIlCkPs8JoGvn3oqLhaKPcbWEor/OwlJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0gi1IJDagYzFGT/diMVomYOJP+wneE8LC067pucZ8E=;
 b=FhkteULUvfblSuFJbslbseGecN5gSfpDYRupUYoXxUHjKEjpO4UUSfYydYFWBuYqdke4Y1lJpSaQHEFvVmJ4B2maFr+/JW8uqBr9rZBYFKWo+PybHts7ikV1uGihfyYtIGd4JeDruCiTx75E5ckmIoL01aevnTRco+Pugu3BnIcw8FcmmzlEEnjFW1Xl2pY1UE/ZKsVaPRTwbLI/9KNqhSiq40w1uQC5+Bfq07E4B1KElZtGqxaszaKmq8jsV0sNmKVbCmH0oIc1Vd30zBv9d+Ck/Q3Nv3FobpN+hzLtIdPEne+MT4e7kYJurji2GbKgGpx48CYCG2a86CvKTOOVHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0gi1IJDagYzFGT/diMVomYOJP+wneE8LC067pucZ8E=;
 b=ic3I9DB++UQ94jUIXgRJ7fs1evFpn3DI1D1m8WU7+Kx4gMLpn2wuU4YUbspRqLnd8NYecTYrPn/D8Oow4FtzZ+TlqEx8p0DaYW5a8V+VWtcDkHLlIcI28jsmgxcgOlattKVwODL7kgUbIiBcHbGu3Cj3c95IZ8kgEoT48wjcz7E=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4201.namprd15.prod.outlook.com (2603:10b6:a03:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 23:30:52 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 23:30:52 +0000
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
Thread-Index: AQHWzY5X7fYeXQ1n+0S4TM83rrVmUKnvCIOAgABjCYA=
Date:   Wed, 9 Dec 2020 23:30:52 +0000
Message-ID: <DDA97AA1-E60E-4075-8569-73C65270E43B@fb.com>
References: <20201208181646.3044417-1-songliubraving@fb.com>
 <20201209173623.GA185686@kernel.org>
In-Reply-To: <20201209173623.GA185686@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:d023]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a202d464-a317-4b5d-676b-08d89c9a77eb
x-ms-traffictypediagnostic: SJ0PR15MB4201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB420122CF3AF789C20346FCC8B3CC0@SJ0PR15MB4201.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yFWMxCjCku20PoXrHJwiRmaBPFHdUxVa4XZKIfaaYlYa8eZvj5ZKklIXBu54yeA808zqZxA4lPXABMBDhlHPA3NPIJuVH3qMsye0Sj8CN1zXwMN4NGkltNfZyXZ3VoO5DNVX2lK5+euUqYfPcQOlZkEbROzX2RbZXp9G1ngE5HoTeO7WKY2VXDXTZftSKf3yrmVkOpdZWkT3t0oN5W7nvf55uKRNW9RjTo0bLwC0+nx4prWtr4hHMH29nBPX0Qy+VBc37/aw7jJPwRPEm5GCAYTMWeeYzNnxe7nD4GbQ4K2uIMVoxo2H8cEfVW+Jk/Zt3xsWLhcENoeaQ61tzJ5zNoLxFFwjltETjm1JQEysaXYDl8X3GzdUlFT+YD+Ze5Zj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(53546011)(86362001)(76116006)(6506007)(6486002)(54906003)(6916009)(6512007)(8936002)(8676002)(66446008)(4326008)(4744005)(2616005)(508600001)(186003)(71200400001)(66946007)(64756008)(66556008)(5660300002)(36756003)(33656002)(2906002)(66476007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hFC9xl79XnAa9Q6UsNVHn7xFjQjT/65ZXJ6dZongV2Vt1Au/jghh2XvpWsAE?=
 =?us-ascii?Q?L/313fEJOpaPEheDDcXCUxHS0AwyzbOV6BgzrD22yvrToUlOH4mEZW9xadt0?=
 =?us-ascii?Q?WeH5srKWTsC/NFhKi+gSjv8q4zbarjPruFi1XzygjlWhAgIBHCbhe3FJxaZS?=
 =?us-ascii?Q?7xuSFj/1wwo4pfqyjyOLdHLWhCDW19KsGNMYywsS6AKijuC+A6jAm3wjh31M?=
 =?us-ascii?Q?E/MiIdIoNU/1Zg1yBOOrfQVJ18c/1w2l4rjFM+bzp/sKVq9xBf/H4Zzy9x0t?=
 =?us-ascii?Q?OP0ZR2bQGvX/y8JeRR7hS3nq3nG8sIwFjrhk09i/7l+M/ZgIt22kfay44LOe?=
 =?us-ascii?Q?5Ew/76c/rTUp5+mhmLR0yyy5i+os5DLdSaBQ/HQ7sY7XrnpMjcHUMggu5wML?=
 =?us-ascii?Q?6duzApfl0gZ5rFkVvYA5Rpoqx1SJzJ4JNtSpac6OEnyrqoIw1UsS3mkYJh1t?=
 =?us-ascii?Q?pL6Cf7D7WFO/2HDLV6GqjRAN85VGJbyp4Vuran5Jhf8bk02ToRg/TEo7uwfb?=
 =?us-ascii?Q?cOKerGUCIoqRtQOkew54Tw5m8do83jtAdoRlTW+dJXa5YHeO7onkpOM24iVz?=
 =?us-ascii?Q?ZD/tWFCqNGwh3nVlUAPhSUj3AHiLNzJ717bxcsgyaK3RF0DJxjB8P91p7fv2?=
 =?us-ascii?Q?zgY21IsJHLagBLSPMdb8eX4ajop7DNuzsxDK61bkMrKWcxCsoQfFAChVO44Q?=
 =?us-ascii?Q?MsCerWhgP0W7AouPvmbNExxgoCZVUGS56DvC99wS9inqQtNiOTBLmPWH7Yjl?=
 =?us-ascii?Q?Gxd3HxfI8vTSfj0/fxBhBT4xdirBTrJZGt2nQauWP+GY46LjtsZaHhdfCvrf?=
 =?us-ascii?Q?yfZ8EWtnec2ACPjAmgZqGxP6m9X+7sl9dE/nNPkkp3qotXm5pz4aEhafve9d?=
 =?us-ascii?Q?MZZrBklFIcQZJuD1QKvxf40GlwmrAwskbY8GQvmmBeST6cAlBneWVMjrx7lV?=
 =?us-ascii?Q?4qhPQoMj9AwHujyMChvgm9C9/6BsDvAH4a9K0F3FAU7vSDP4X253UOE892ft?=
 =?us-ascii?Q?FWoO43K5NYvAmvbwAVkFal0Lpox/+y9U6/1oT7Ka+jLV+JQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <894D72ADB99B1F4896D42460D2AF0FB1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a202d464-a317-4b5d-676b-08d89c9a77eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 23:30:52.2168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W91ZEPNFpBYg3L9RLMCe28KO/JveDj8tIvysS23w84NhVssYHjfCYRBv0493SIPYW1EjEdR+A72q+hd4eFdlAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4201
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_19:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2020, at 9:36 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
> Em Tue, Dec 08, 2020 at 10:16:44AM -0800, Song Liu escreveu:
>> This set introduces perf-stat -b option to count events for BPF programs=
.
>> This is similar to bpftool-prog-profile. But perf-stat makes it much mor=
e
>> flexible.
>>=20
>> Changes v2 =3D> v3:
>>  1. Small fixes in Makefile.perf and bpf_counter.c (Jiri)
>>  2. Rebased on top of bpf-next. This is because 1/2 conflicts with some
>>     patches in bpftool/Makefile.
>=20
> Can't you split that up so that I can process the perf part and the
> bpftool goes via the bpf-next tree?

Actually, I can make it conflict-less, so we can route everything together.
I also put the change to bpftool/Makefile in a separate patch in v4.=20

Thanks,
Song

