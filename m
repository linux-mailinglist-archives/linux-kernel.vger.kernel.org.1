Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F4D2E7279
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 18:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgL2RAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 12:00:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44216 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbgL2RAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 12:00:04 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTGt7Ok019863;
        Tue, 29 Dec 2020 08:59:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4nNgcDPZyhbU8Pn8ynFgC7WEINJ+yW/FQVEQspoKSCk=;
 b=W1lpbHYoICdkDHwDbkVwS3DrFJWkLriie2o2HLfdg4LcR98FeFALJHIRiorxRPcLg6td
 Yt6gCYluqXa1skfL4Fpu9iF6S9MKov1vr+15fcZCrhO/viaTKC4v7OR8TFHisijftF7M
 42e1JWzgnJwshL2rpNnxuTpsDgwtanq/Cxg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35p3jutaq0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 08:59:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 08:59:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDJ9kgtLwh2ZR43Zx1xFQLtr9V7tvdEs7Mvpy2DZzb2V/KNfbEeetSDeR2IZytwrnPg5vIS167TbogPrQqn51YTKLZvCwbYb8owMWcVbZXlBKuKEbhiUxzU80lTrQzTILyhEVZQKe9U+Uqp7+upj/DNYUaqEHXvIUIyO6u2LTwNbjfScxLWfGU20ZQacyA9Q6JVSvHhMq8RinyliiAQgf6zePfdeK7zSEfhs+qlP7VhqljLc2mInJoH235Gf/erIWyAGWk8Fbb1yWiG9F+08uekPYTUGWeSbW7jRyHF29c/MyPAxTwpNLNA5mJUVka5zGvMbpPiwgcwNNj+x6711tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nNgcDPZyhbU8Pn8ynFgC7WEINJ+yW/FQVEQspoKSCk=;
 b=I2DlRXjVZd6wOwkp7QYdJ45iNFRgOfv1WD83KgqLV1XxdyH6RW/FAd/qpowVlNUwxDqKS9Y3eDhEvqzc0VCFr9SY6VPYceA++cZ8BnCpet+t0cDrz9X5C1zQqJd+QpLIvNCrZAgEX/vx9wK0jTX3dgKFXDCrF3zks0YvGDH4vCA//4cftrYSuLQ9tjIzhq7OYmGPhJnxJ8NFNohhzt5rWxB7IoJ7IDd/IrM866Kka05KwYEwhM/xF83gL89m2K2j1Dj5BQXapDe1ry0ctlFXO7AxeY7hGua+2DbfbadaxRNk5bPEb99lN8R7/h0ZCmwebIULw+uQmn1vFGb+YpzHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nNgcDPZyhbU8Pn8ynFgC7WEINJ+yW/FQVEQspoKSCk=;
 b=CayMeYrcjNsMYgBHTS76inWzeWZH5zyIBBd7EjlfuXHXNZ1ZrTdRMIKJRpO0VMxbDfWabGBO/3CcDHyOdjyb61lM0PVWgsPMYY7D0+KSM63mDswedq3fF59iebVef2HlvWeHZ3T2zOXLzdqSvekB7jHu1q97nJlp/0PpbbZ+XhE=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2950.namprd15.prod.outlook.com (2603:10b6:a03:f6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.29; Tue, 29 Dec
 2020 16:59:00 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 16:59:00 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH v6 4/4] perf-stat: add documentation for -b option
Thread-Topic: [PATCH v6 4/4] perf-stat: add documentation for -b option
Thread-Index: AQHW3UClMrEXECir+ESI2Ux8tEpG96oNrOWAgACgZ4A=
Date:   Tue, 29 Dec 2020 16:59:00 +0000
Message-ID: <84A7363C-5944-43CB-8902-3EAA5BBA1495@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-5-songliubraving@fb.com>
 <CAM9d7chxLKqjhB3CoxPV8Oz9y6fzZBTZ-YhtEWc1dzf9s-iB3A@mail.gmail.com>
In-Reply-To: <CAM9d7chxLKqjhB3CoxPV8Oz9y6fzZBTZ-YhtEWc1dzf9s-iB3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7414]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fca554fd-100b-41e8-7b9c-08d8ac1b09fe
x-ms-traffictypediagnostic: BYAPR15MB2950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB29501DE3AF7D06D6D23362E3B3D80@BYAPR15MB2950.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfOqi671jsHaSPtxgA0Mexnl+hrriSeIzFfQ4CmvUlFvfVgnNT7bvL/Sd0jrOmG/Bl4k8MFeQIXWuy19b5/6LqwD3XyHYuA6ZiUXgH65g8vpYxyloGAdHCQ4dN+aBOCsWPaeQXq49hpVkq1qlcGrWcjSG/KFLnMdKFO3+FjnadB2PQ7b2MsZtYNxA/OeIkUPMI2Al52QpunzjHOLVkxYyZOmN2TOnAogJLzMCU2Tt6rY6yCSztxSi57o6aSbvW0bwtfM+ceiStN2ES7ejbMmC3tNXbXirbO8dkx4/vwFIly8QPPSEGxF/pJWcVdepjt/LloczP9WpEtwTEUrjbvX7OLbr9xrblnk9/e4tLoXvRYDQZugqT9DkDh84spsZT4y1GoD/mWEsDI3JRy40F3F44fi+d4NEFCBtCUikaTj2QtSTnIrhxc1odRG3vNvUWdZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39860400002)(346002)(136003)(478600001)(86362001)(8676002)(71200400001)(186003)(8936002)(6486002)(36756003)(33656002)(64756008)(91956017)(5660300002)(66556008)(316002)(76116006)(2906002)(54906003)(4326008)(6512007)(53546011)(66476007)(4744005)(66446008)(66946007)(6506007)(6916009)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cq5fBx0rN1o6+c3i+wjbEphAzIaknF24iuBEQ0KaNUshSTdL714igi1yncNZ?=
 =?us-ascii?Q?c5To3LteYFZVMrz1nqz5SAnEdIB+7Rra4tQH0XvNtbJd8zI0hqdUdSvpAPgx?=
 =?us-ascii?Q?Ozw4WyG2tmyDy24nSSq2qJj24eFArJGWqnCVX3cYrT7wD6mMELyj4xi1E6sl?=
 =?us-ascii?Q?DAPtImnQcUacmeSOJKRptfRL0Z8j3JwJY0/0fPAb3GmR9vkXoKgzIicgNliU?=
 =?us-ascii?Q?HU/XFCyTNBl4roHzuGyEx7xC21+gCDqKCF6bHPGd8fuSTgE/La6v506h/Bh/?=
 =?us-ascii?Q?u96+jZh0XojYz2XLHWL8Mf3sawIT5eyP9wkG78A6SH+x4koNz56/fiBzbqyE?=
 =?us-ascii?Q?7e+dEKNZgxyLbwoozEGvgVtPxWyxWWzNNINxcc4zaOX5+KSNPWM6CCqnrtHu?=
 =?us-ascii?Q?EDIm3RR9vCS5EQg1O4rx3TqxCz04VgWd7x3DP8w8gFVNSs+dMU9shImYvCLr?=
 =?us-ascii?Q?zBp3ksDer8MHM8xKrcI0xX3h9HFeCUx2/3gjb41uKYUE5BSEuf3GTtZPQWOk?=
 =?us-ascii?Q?+uSLcYKYqAB07p3leIjJiqvgFqOsX/WTwGXlyQ+4RDHi0M/ySJLDL9v/p7J9?=
 =?us-ascii?Q?oiAGD4/f7/ApxaD241LvSo+yluJ8EPqACLBN71M7WgkqCqmfeboyGDHGodmc?=
 =?us-ascii?Q?c2IR58B0iLJgjYqOEK3zQZcA6wlD6si20pvHqnv1WHqWuZ2zQSwudnv4JC0N?=
 =?us-ascii?Q?FMpbgGEWaDTpvQX/4AbMr3uFIJ7x7rvZtpg+XDIOCnmTsMz6+O+MzyO9PF/z?=
 =?us-ascii?Q?KdcfhBONDJt51sH8wij5I4edP802boXZGW90JZMtS8Ed6Dr3XK+UupjnSLQ3?=
 =?us-ascii?Q?hGpWlorPr0aZJCiDaVoH8UjM9Axfbwd2LCCgesx2TIWZiYq1iTchks+2TjjP?=
 =?us-ascii?Q?jSaHlaF5drWEePs28PCitTLXFXwYR1bn3/RSTOzZgVxYRGzIAiV7xmn+zL/+?=
 =?us-ascii?Q?FHn65yP+YSGvGPoPkcMZnv2ZFh2xTU8k955n48xhMoFvoev6r0xJf1t3fYaW?=
 =?us-ascii?Q?kgFN5wklk2vMqXyOFXn2e6f+8sks1v9gfszmVOZ3SrGfsBo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57BAFCF6D15046438750223E2CBA38A8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca554fd-100b-41e8-7b9c-08d8ac1b09fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 16:59:00.3553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dpbrw0YDntnqz2m5mtH29+9uYXfM5HkTkeOHTp/yVgr/IJ0GL8qrgUQGQyGbUw0AfRlYnLUWqCHmi0X/QgDbcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2950
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_13:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012290107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 28, 2020, at 11:24 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> On Tue, Dec 29, 2020 at 2:41 AM Song Liu <songliubraving@fb.com> wrote:
>>=20
>> Add documentation to perf-stat -b option, which stats event for BPF
>> programs.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>> ---
>> tools/perf/Documentation/perf-stat.txt | 14 ++++++++++++++
>> 1 file changed, 14 insertions(+)
>>=20
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documen=
tation/perf-stat.txt
>> index 5d4a673d7621a..15b9a646e853d 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -75,6 +75,20 @@ report::
>> --tid=3D<tid>::
>>         stat events on existing thread id (comma separated list)
>>=20
>> +-b::
>> +--bpf-prog::
>> +        stat events on existing bpf program id (comma separated list),
>> +        requiring root righs. For example:
>=20
> Typo: rights
>=20
> It'd be nice if it can show how we can get the id.

Thanks for the review! I fill fix these in the next version.=20

Song

