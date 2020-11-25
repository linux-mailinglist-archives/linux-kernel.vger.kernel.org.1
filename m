Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB72C352E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKYACn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 19:02:43 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:27576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727070AbgKYACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 19:02:42 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AONsAEq001306;
        Tue, 24 Nov 2020 16:02:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=u2v+H37WLTeXqShfLLjF9Lpkgxfu+ndJrX8ONZGEMag=;
 b=am59O7pl+syDH5Hx/hBhIJKQnlsK+yuWHMAFjtFn9dMYfpMkwvjinvaveOOkl5F4vpY2
 9h+RESO6dxHL9SLEu+UjiOhoiohJhsb5e0rnUnEYZatplsWLBwyr45TfAgYhKLGh6gyB
 q84mTm800S35uSc5TSktwRcLDhdQGJbbmxc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 34yx1t2j8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 16:02:25 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 16:02:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5f9u2xG2QuCakofA+p4IlmBUchXaaz1SQc1Gq9+eVXGubc5jkq1Wt8kcGLAEEd+207jGgzeQ1Yro7LPvYKRlZRfOO0VXgAHVE82nDYzMvwsTtsiSd9LBnw/IqNjJUejGmvu2ZeyH3VJ9EJH1z/0riKqnBwCDXrp0lnRGMX64UGyNOS2al8zu0Fg58InDagjRT6L4BYyj9YAH8Bazwr4JiwqPFKimwAtcpXcLZaQ2fR8hA5nwHYcpakVPL81T8yol5KeUMVhC/F7BB1A+W4wPbHJw3PInkQsldouWLmZvFNULhcvrWPeX9w+d2xCRJ3ASV8XUHKjdShDa0iYRPMM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2v+H37WLTeXqShfLLjF9Lpkgxfu+ndJrX8ONZGEMag=;
 b=K1BNTTivGCnDDsan43RVSX0xbY7g4O436Rjma4sy3Pk9C/Bi4D+pD5JdgC4RNxDauAfvEJGlGNzLqeys+DmVEUGBKb7+oYBHzquQtLrc8TQxm7NcgBPeTACeY74+5ZIqVy5RY2x3q6HnQHvSlCUvPOIsaW7FnTCQjbzgTYWlaodkjaChNUj3heovfKyEmqRhrnIDMsg8+dpFGYkbITN79qCHlhPWH3IXj3pkT0GMGZ4CvTo9MjEHJuzgavmDXib/H+hotosR8fntTdiNR7nayXXkJKb9IoJhxTw6UzT+A++Ua4d1w/GWS27r1pe3XIgeAzq7MpWBQfdxl9lzsTFrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2v+H37WLTeXqShfLLjF9Lpkgxfu+ndJrX8ONZGEMag=;
 b=UmQWIZUgq4DPA7wSOzrYQiugV+9APaqXvRgedG8Fehkz1Pnq4uoZR1a6hNDzHyCE/0NJcjCQYer0g6fkVhv05ETw+gCTItS7z8NGNTFNg1TvYwc5c5qXm1x46RXguFstu0zHbxsfdK+gTh2uDc4Br8UwwTWz8C91PStbX6kCgZ8=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3570.namprd15.prod.outlook.com (2603:10b6:a03:1f9::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Wed, 25 Nov
 2020 00:02:14 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 00:02:14 +0000
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
Subject: Re: [RFC 2/2] perf-stat: enable counting events for BPF programs
Thread-Topic: [RFC 2/2] perf-stat: enable counting events for BPF programs
Thread-Index: AQHWvi+l7AybrLX1mkWxO3oxzMTbKKnXue4AgABA94CAAAUwgA==
Date:   Wed, 25 Nov 2020 00:02:13 +0000
Message-ID: <AA26382B-BF8C-4768-A9C5-0E7476197447@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-3-songliubraving@fb.com>
 <20201124195108.GB2164284@krava>
 <3331CA57-F1EE-4C66-8E79-E5A7DA91F880@fb.com>
In-Reply-To: <3331CA57-F1EE-4C66-8E79-E5A7DA91F880@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f2e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b8c6618-2bf6-4820-2028-08d890d55d49
x-ms-traffictypediagnostic: BY5PR15MB3570:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB35706615232A876534165046B3FA0@BY5PR15MB3570.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAnP0FEaPOWmOybLWmfvgZlVimPVHXRI2tGaKYyIV9Inz92IJBbdfvXyhomJ2Cj3i4g2VADNkWRZSoO+B2b6UwnKp34fs+B2PIUgWOSnaKcNRN6pkNh3HM/umvnYeKIeeb62NLbg4BAYDTAVhsCtt7SHFxF6uYq1bybnqqmYLaW13Gygls9Qny68MFplMS9LJzwJlTKdIkLSmXWbQQtAht9/zUZGYz7XT177p2ZretVUQzkW7HvRGHJuqt4XtQCBWGjgOVOppr0RQJBAf/5/R4JARYMASYnA4gEyhu2fv20Tg7O8RpNzO2Q2UqZiXQ5xHJ68rMDbxXvE1QthHqwejS1Yuxh1GAWMnbawB/uzkJWOtGZw55UhFNhMF36Bblp6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(8936002)(6916009)(53546011)(8676002)(498600001)(83380400001)(66946007)(86362001)(66476007)(4326008)(2906002)(66556008)(36756003)(6512007)(54906003)(33656002)(6486002)(71200400001)(5660300002)(2616005)(64756008)(76116006)(186003)(66446008)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?k+bJESuxFRob+9CpQkYjhDJoheb0gdIk4QN3V67dPxRI6CDtlaGd+yzH1Dhm?=
 =?us-ascii?Q?Q7WqqBOCPVi4VZuml2IaM6Q+TxdOdqPENNeH4eOjW9s9G4CvkJJwR1jayDoC?=
 =?us-ascii?Q?XcWX+QXkPm92/jUhi2S1kq3Lxm4Q4uiNJDbYC888NP/AT6HEfsh7ln+J3XxY?=
 =?us-ascii?Q?N4kO9b0mZzfpQRgUtKP4pXX9UbApvq1LgPQj6uCJnt8T1lLRBn1ZuZGM0Asi?=
 =?us-ascii?Q?KFpYPsKsxFdQEXHkJwOhN6WoX8j5DXM9UMWRR7qjyLhy5nSuqXts+NNxaweP?=
 =?us-ascii?Q?uRVCkt8yHmiqjxdXpTtcCya9AMEsBkIjqPaykCI8/jL7KclpYBo6y2bu+s+m?=
 =?us-ascii?Q?eecaVWAuvG29SsrmJJAsOa+O1EplxxPC10wHATD9WhIwpqN7yaoKEvoVRWIB?=
 =?us-ascii?Q?hwG6yYGCrlp/5dIj+BTC0IQTKkF+BclnyaUzOIJYH2maG+Bkh2rf20xsnXbG?=
 =?us-ascii?Q?pU/cZ6XuERkcIhsHMTR1loAZzc6PQmgpEBXRf8XL0BsMLEqxLveASCAqnoci?=
 =?us-ascii?Q?mvFMkOi4lfpzpOq0g7UV04D2xiJvuFYtgpb84x2wK0Q/svuCQcjJcP6O5AZk?=
 =?us-ascii?Q?XTDI/8IWsgmRoht4i7sklnE9UyWEBtUKg/kqFTJY+gpfepkLd2zfnKQh97XO?=
 =?us-ascii?Q?ViwqJgpG1iVrFGdel15rQ79Gqu0wAkueyaGjTGs0kAOHiD8tbPR2eIlHyOqV?=
 =?us-ascii?Q?btehxr3R2FGc/mYWafjHfhnW/c9CKc4s11rJRtxR7mXsMm7xwCP5ux+IHzKQ?=
 =?us-ascii?Q?+8GInthsOXQjCiBDdgWDamm/61f4rhwfrfy84A8++HoRH0AMX8H9WxASxF7s?=
 =?us-ascii?Q?tblZS6/S1tU71eA5akVRPara71ofSFXw3FzzyHrpUT76q8b8scvbfPRlQ4Em?=
 =?us-ascii?Q?t+HS1sBYUaGnVqYRULDM6Ubk4Li0uN1e8BaDtOh9mv8B0TWo/WDZqxJt8nTp?=
 =?us-ascii?Q?oZLCXV0hNWnvop6ZT7X0AzUViSRbsn2wUBI2jsBn4yqsYes0MMYgUEyZpNEb?=
 =?us-ascii?Q?u1Q2M6xyzkudteKDeUb1gJCk8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F5F2BEE3ADA3B4A9227B7A2814366F3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8c6618-2bf6-4820-2028-08d890d55d49
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 00:02:13.8753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVB172rrnHppZuuDVizBpk/L1l4Ax7av/LAYdPdmbqJA6VZI+0L3+//Yrj74CSfhAK3eBVgaW7GCHlwhgzLwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3570
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011240140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2020, at 3:43 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Nov 24, 2020, at 11:51 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>>=20
>> On Wed, Nov 18, 2020 at 08:50:46PM -0800, Song Liu wrote:
>>=20
>> SNIP
>>=20
>>> +static int bpf_program_profiler__install_pe(struct evsel *evsel, int c=
pu,
>>> +					    int fd)
>>> +{
>>> +	struct bpf_prog_profiler_bpf *skel =3D evsel->bpf_counter.skel;
>>> +
>>> +	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
>>> +				   &cpu, &fd, BPF_ANY);
>>> +}
>>> +
>>> +struct bpf_counter_ops bpf_program_profiler_ops =3D {
>>> +	.load       =3D bpf_program_profiler__load,
>>> +	.enable	    =3D bpf_program_profiler__enable,
>>> +	.read       =3D bpf_program_profiler__read,
>>> +	.destroy    =3D bpf_program_profiler__destroy,
>>> +	.install_pe =3D bpf_program_profiler__install_pe,
>>> +};
>>=20
>> hum, what's the point of this ops? you plan some other ops?
>> we could just define stat callbacks right?

Which callbacks do you mean here? I would like to try that as
well.=20

Thanks,
Song

>=20
> I do have other ideas using BPF program to aggregate perf event=20
> counts. This ops provides common interface for different BPF=20
> extensions to evsel.=20
>=20
>>=20
>>> +SEC("fentry/XXX")
>>> +int BPF_PROG(fentry_XXX)
>>> +{
>>> +	u32 key =3D bpf_get_smp_processor_id();
>>> +	struct bpf_perf_event_value reading;
>>> +	struct bpf_perf_event_value *ptr;
>>> +	u32 zero =3D 0;
>>> +	long err;
>>> +
>>> +	/* look up before reading, to reduce error */
>>> +	ptr =3D bpf_map_lookup_elem(&fentry_readings, &zero);
>>> +	if (!ptr)
>>> +		return 0;
>>> +
>>> +	err =3D bpf_perf_event_read_value(&events, key, &reading,
>>> +					sizeof(reading));
>>> +	if (err)
>>> +		return 0;
>>> +
>>> +	*ptr =3D reading;
>>> +	return 0;
>>> +}
>>=20
>> so currently it's one extra bpf program for each event,
>> but it seems bad for multiple events stat.. could we
>> just have one program that would read and process all events?
>=20
> Multiple fentry programs should not be too expensive. Current design
> extends evsel, so it is a cleaner implementation. We can evaluate the=20
> difference of these two designs by comparing this with=20
> "bpftool prog profile".
>=20
> Thanks,
> Song

