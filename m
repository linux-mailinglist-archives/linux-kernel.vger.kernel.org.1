Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D0F2E72E0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgL2SAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:00:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31492 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726240AbgL2SAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:00:08 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTHswYr013843;
        Tue, 29 Dec 2020 09:59:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=RrvfvK7iVCEIjmr89x1C52LtSsn6KZHCt6O49NwijH8=;
 b=ipCZS+ZpeYDiELGtsGeOAs1AGcrG8zsvdPrXFB7AJNAbrRHEQT6rlijWDE5tGtRSrFRu
 a2jPZhnC0ydWNPIFkcc7Y8q/ctJydM3y805YxWbn08rjYebQ/FrQP8X+UIv7ZOUUbJbX
 LDcPPzbU3LzX6fBoj7/adyX0R7lSckpIBtU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35pp3vrbtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 09:59:17 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 09:59:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVSu7ZKIfGVCG0PZ17ht/REGXyFiC18F4hc05Tr9/CyOIajpPzrg6Lrm80TvmN3n25q8lPIcglDC5HNv2j00sbJgUxOZAGycGk30OCBVdYb0JDBfmMnYk3hOnE8zQACgo4HXAKcFT93EctV9i5NIm4VDuoEP0rZYXlTvnmIvhoMo1Y5QtviXgPDQOaE4pgtFynOf5y+d/45bwjGoqEv/O9sug876RM44Ag9TSCA0XML3HdHWOUHbqpGCaD9Glem7GRqZPeyhmbUHnTVV7qIxw08DE9RFD6eLDX4uByFQ1Oj9DsJnk8BHJ32oiOCiABIVpcR+wWWR3aVN3UP9KPSFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrvfvK7iVCEIjmr89x1C52LtSsn6KZHCt6O49NwijH8=;
 b=VSx98T5tfT8mzOyZkNnqL5emsCxPzJrG1sgE+ifjvyiScJeKDLwbUKyX6vPSXoZa889XK/88ERKostJx2gFUM32xGHuYPP1wKqNTjqC6m8rc5LZGIwJSyL0mJhL9ZcNUqFEHk3hkKnt8HD7BhrixLH+cjZqDTMA+DxQWYFyA+YW1ZSx2QH7dvPE/sX7WcI9ZZJBIEnhuKkZ26C6R+oh2rm6CfRizh8GxA/q6w16QO8T2Zs6YlqEmbzpA3rirhDyqvXDblrOAIEBeB5wCBVksXtDiHgnIdUxFRjID0hJrE6V3ALaljg4z8pXdrfXCYsPw+FmbPvXmCxWc+TflnmBpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrvfvK7iVCEIjmr89x1C52LtSsn6KZHCt6O49NwijH8=;
 b=IZ9D8wdhezCb5LH5kuwUTppZ3y5VPgtru+ios7hvkF18OnOHFM24pZV+6gC/YzKM6YxHAcnS4lwrh0D8c1/7f6sPgsfn2+p88peTC29zQI/YCHPhdn/yWq57jNKGyKVrevw3yxqktyP9+TyHXehHD6BYCUBOX5ZJdeTy+uNwofo=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4120.namprd15.prod.outlook.com (2603:10b6:a02:c4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 17:59:15 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::2c:f12b:82e9:105c%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 17:59:14 +0000
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
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v6 3/4] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHW3UCo6hW/vcfUc06GxX5agiqE96oNrCiAgACuXACAAAOdAA==
Date:   Tue, 29 Dec 2020 17:59:14 +0000
Message-ID: <0D527E3F-7390-4D54-8E6B-FCCD09BA8901@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
 <20201228174054.907740-4-songliubraving@fb.com>
 <CAM9d7ciBsQqp2C5jWnitaK1Lttrq46NMcTLwE70oaqm82T88+Q@mail.gmail.com>
 <B5D51BCD-C9FA-458D-B8C9-345BC2AD16E6@fb.com>
In-Reply-To: <B5D51BCD-C9FA-458D-B8C9-345BC2AD16E6@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:7414]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fa6f22f-c479-4069-b7f4-08d8ac23745e
x-ms-traffictypediagnostic: BYAPR15MB4120:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB412053153C84B9CCBBE99536B3D80@BYAPR15MB4120.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3UZtv0Vnguv4ojs5l8GoZ8WDe1zaDZ3BYwcRjxBEaaFk2VO7TpQl7XA/H5SyFF26gyeennXGqAB6qO62mn/tYJ8fZ0Ur56/dmQxhbXDMzkdpLW4r8kK1UKDcZC43aiih8XbN4VywlaOrZ/ctqGsUsE2I8ZXyjxXZ0hQB0ulIYWfu7Fwz1U8ercxwnRGgdI7EiFzSWTw0E7Rq9XdK0EOgDF3yamqbt3VEDHIASTDOQcmHmq7VymBVjZh5ts1i0kya46dHgj897xXb8CGFBE9GI/93zg3MhIsuUzgnKCrC/m4nfucTYjhl4hT6K8X2Mi5MOwTEoEb8r4pmWYjtOOnXSurZquQQCUewqmgXLGIP79xYHBrg2mdmVpEtEX2kLlcnQtoZkHKXByPJKkKV0GVt30pVNBxVu19Kb2jm/l7HM7QzAblX+/8hwtZ0cRnpBxV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(376002)(346002)(396003)(33656002)(6512007)(2906002)(71200400001)(6486002)(86362001)(6506007)(53546011)(83380400001)(66476007)(64756008)(8936002)(2616005)(8676002)(5660300002)(54906003)(66446008)(91956017)(316002)(66556008)(6916009)(36756003)(478600001)(76116006)(186003)(66946007)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uY/OvtgFHKfrAd5VovqzEoKyvtmykTY5+SOFmB+nv6SUS4lQAIsgnSkRNkax?=
 =?us-ascii?Q?TF1BwQCcoeYZBMljHaLdxzQcB9++bh5okrSuKDDfpQTYT+tnmXtn3CE+IWSN?=
 =?us-ascii?Q?TuKfg4pW0rSCnmpZf69vOvQuRn3VkpLrBpavdH4J/TvPMIHENIGY8ZhXjGFZ?=
 =?us-ascii?Q?Y2aoHTuJFTziwkJcQG5xlEZ6DZvKSP7sXjVGHzZCxIrART0D3jvy5gW9cXbP?=
 =?us-ascii?Q?eGt+HqIh6hIpkG3qyqcjosL90zteaFnhYjgJdZSJEDvD9SENW3Oo4hk7TGGC?=
 =?us-ascii?Q?ZHpr4gL5g8ZWCSxxNY3FmMNZ8Q3jOZsHK301fQKQZS7vaepH5+7QEBK+J1in?=
 =?us-ascii?Q?Ykl9aB7WLBozPduMaHVqZ0gxJ3HY0TJdLrs5YXX/vZNQtFyAMCyUaze3MCTf?=
 =?us-ascii?Q?QEYNt7/FZ3KfnlFbRIOoizCldIzVTNi7aALGwCSjHlYc4yZq337mv4YCe2Vk?=
 =?us-ascii?Q?FmKyWCYwS6cEahYBajeVvgNx8tn4oXgsbCycx9RHstzbq8RAJ6PUtgnGAbuE?=
 =?us-ascii?Q?jJ5OR0W0ERCdbU/Nua9bfPM9TrAmlqDZuqNgd8BaQEekkhpAS0p3SGTN1hSd?=
 =?us-ascii?Q?VK68qYgv5UT+PV3YyQk2uszfNWu5G8JNuSAM8dbSMDsOgBl6dATEv70AZw20?=
 =?us-ascii?Q?SrC796bcxJX0/ekjg2i2MT3VtGpWFBF2dV+Pj21CPu/oOlcf+WXQkR8YRBQA?=
 =?us-ascii?Q?Dx4C6pifQ/LZBLm7pLBkbNKTQACdJ+IUKLnbXyMopsyix74D3n6scxa7KUP0?=
 =?us-ascii?Q?++kMgyY7Tlsm2zAvNsP2Zwb9s2gPOwWqW09qUcO9iCiw4z0qS7C/ZQ/pFqJv?=
 =?us-ascii?Q?hYJn9SFbqF9AqBfK1ROpaepr/Es/cCsDNvh8AtbCRjpGBy7zeKzgF6iysCcB?=
 =?us-ascii?Q?ovalwXz/9BqI7c73rr3tLIf4OhjyC4Upz8e7C9ibRuHHrhR+TDd1HF3EeU76?=
 =?us-ascii?Q?mL/rBWccijBT3hvSEca1dnhX7fC8xoYAjoypNUrTiqG1hLy1EghxThZrmsLI?=
 =?us-ascii?Q?stXvArKNVIfEWK27Ss8NKO6YANTCFOb6vNopjPhaKLDgkXI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B32630DB6C6E1459D7C44B7592CA59A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa6f22f-c479-4069-b7f4-08d8ac23745e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 17:59:14.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQnAkMBYMWP3BcjLE2YekzgdZpdnn3Q1+ay6Jl0NglAs5rLMaPC8cp2Na+kAOdHHeELcgYWrLUye5Q6xPs/rAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4120
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_13:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012290115
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 29, 2020, at 9:46 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>>>=20

[...]

>=20
> [...]
>=20
>>> +static inline bool target__has_bpf(struct target *target)
>>> +{
>>> +       return target->bpf_str;
>>> +}
>>> +
>>> static inline bool target__none(struct target *target)
>>> {
>>>       return !target__has_task(target) && !target__has_cpu(target);
>>=20
>> Shouldn't it have && !target__has_bpf() too?

Actually, we don't need target__has_bpf() here. As -b requires setting up c=
ounters
system wide (in setup_system_wide()). If we add target__has_bpf() here, we =
will
need something like below, which I think it not necessary.=20

diff --git i/tools/perf/builtin-stat.c w/tools/perf/builtin-stat.c
index 09bffb3fbcdd4..853cec040191b 100644
--- i/tools/perf/builtin-stat.c
+++ w/tools/perf/builtin-stat.c
@@ -2081,7 +2081,7 @@ static void setup_system_wide(int forks)
         *   - there is workload specified but all requested
         *     events are system wide events
         */
-       if (!target__none(&target))
+       if (!target__none(&target) && !target__has_bpf(&target))
                return;

        if (!forks)
diff --git i/tools/perf/util/target.h w/tools/perf/util/target.h
index f132c6c2eef81..295fb11f4daff 100644
--- i/tools/perf/util/target.h
+++ w/tools/perf/util/target.h
@@ -71,7 +71,8 @@ static inline bool target__has_bpf(struct target *target)

 static inline bool target__none(struct target *target)
 {
-       return !target__has_task(target) && !target__has_cpu(target);
+       return !target__has_task(target) && !target__has_cpu(target) &&
+               !target__has_bpf(target);
 }

 static inline bool target__has_per_thread(struct target *target)


