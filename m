Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E3D2D4ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgLIXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:33:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9996 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730584AbgLIXdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:33:03 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 0B9NMx2G003756;
        Wed, 9 Dec 2020 15:32:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=W0jXxsZYygxRNlobj5t++d9N2GxLbdeH9qUTQsvY+eA=;
 b=Jnahzt5N9/O2ofF2/jAwCLnkR+d1raMHBDgwUrNL0aDaNRI4OvR2W/D6GXdZ0ZqtJJlj
 3iXUB8urhueAo67MZbhuOJxSos9mdjJ23ukDPPa3dB9t/HqoZbI+nr5bPz9lE6jTOyMV
 JI8A7prVjG9rFHxi0mBGGqHLtcyr/7Jx27w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 35arhdeadv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Dec 2020 15:32:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Dec 2020 15:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OldVbFROx+YYlCONiso4anhmOenpKh2M08fNjUzh41Y9TXub65oF9HcXz3OeSsVPhdxRbmD7UKLyPYGa1LAOvf9guJd6I8xkhfvy5An4NEF+8goPJRybd80m6YgW4scIcZ9c5LB83rOju9WiFC7CMp10TeZfiY/S2243yWEBN7zGCzMqUnyHn48bE9MAAwQG5g+CjHwdLu/ftHvYxvRo3REeBxE5q+vDJw3l5fdcwTKMOxqooEymEvMVh9hKxrAs/izMeErdNbwWfQVs4kliFNrbT3/AXNmkV+UHk9dX52Z1ec1T9U6tZRJoqTRudwPubKBpnxL17/eM+cqR/Bwulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0jXxsZYygxRNlobj5t++d9N2GxLbdeH9qUTQsvY+eA=;
 b=gPg/y0AmvfuMqKpYv+PaiQAZURRuzYmeg5Pb260tbq4JRqU3KkEIIYohCFiGwKjq9B5s/gCTRU4YGb0qt7mGsJoP03vbk5V9G7FSUzfbmgj2F/SOuXVRczMcXRCJLJ/Ydud4UOou6MqWgzIQNslvwiKhnU83kwTviJZrxI57jDt00GTIfxnmYqwAv0wYsRLmIUuj6H+Mewmgj6wregwjLWcjrcXG0eSOh19kXZBDGS83s66Z/lfayoJHp+HCu0VYIyAyAzLVXUGSZmJBIp1i/AyHFZEpK1b1yfxN2k9jI7o+c7IM+svZyfgV5b4OwXzFqBHVBDBCnh2dr05vGwjA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0jXxsZYygxRNlobj5t++d9N2GxLbdeH9qUTQsvY+eA=;
 b=H9KttSWL7F9LkGEYsq/b1lizihRbmd4Phb+/uVAMG+dmhm3YCudt1yh/+GBTdEJTmLkJTFiwLjZgFucilNnw3LoEnIKmX4OKccgtbBeyM/BJ90Y2TVXna0yD8e4nFRqkHbKxb9FX+1za96FFVIEHHUjz+cmiyNBBScVqP2jdZrk=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3620.namprd15.prod.outlook.com (2603:10b6:a03:1f8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Wed, 9 Dec
 2020 23:32:07 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 23:32:07 +0000
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
Subject: Re: [PATCH v3 1/2] perf: support build BPF skeletons with perf
Thread-Topic: [PATCH v3 1/2] perf: support build BPF skeletons with perf
Thread-Index: AQHWzY5SmjZYeZ+hNE2TBHo9RBzswanu/3GAgABsdQA=
Date:   Wed, 9 Dec 2020 23:32:07 +0000
Message-ID: <1F517361-8651-4EA5-ADBD-B8368E969C5B@fb.com>
References: <20201208181646.3044417-1-songliubraving@fb.com>
 <20201208181646.3044417-2-songliubraving@fb.com>
 <20201209170355.GE69683@krava>
In-Reply-To: <20201209170355.GE69683@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:d023]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fbddf8d-6348-4ebb-69ff-08d89c9aa4a0
x-ms-traffictypediagnostic: BY5PR15MB3620:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB362030F49BE6AC26187D14F4B3CC0@BY5PR15MB3620.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oPD+1u8GLjjmwaa2orElziDF+S9gkSYsV0l4pYqsVvjCtVm4VAGv8Hguvjl6UGxptWBgUPa0Ea3AqexLGiw2F6G8pBUR8nmru3jxITUVYfFBIxXsTWlAjOVMR6tuIKRWVW33Wghle7xXZMgsYk6/ALUrU6gBjEiBiBpVnSOdW9w9pYMObhbHey7zoHuKrYWNDMDqgczQLgTUpd1IPK8iq1Lvepl5hL5ArU7Q1ay3u61zJrMEWJLSDGWxY2HIhXuUDuRCHL6seZ7IbSah8ImPWtW9bH0E2q1iNSFvqw+FoLvi2zUy6ijI+HgZDa7vkO8Imtw6hiQ32Vbctzv6CCivKf3eUIZKJYKJecoQ0GodnkVEu6W4+EebXhL+ncXsPF6a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(8676002)(53546011)(4326008)(186003)(8936002)(2906002)(6506007)(76116006)(66476007)(6512007)(66946007)(2616005)(64756008)(6916009)(508600001)(6486002)(66446008)(4744005)(83380400001)(71200400001)(5660300002)(33656002)(66556008)(54906003)(86362001)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fWvsGXcWpGRoW85NVZJ/MgP4AMNOx2Zlf9Xa7MCMNU6b8t4pzMZoiXoDUKQM?=
 =?us-ascii?Q?IaJdbRu+zLT7o5u/PAcyH9YqCdzXxsiXylA0E5DGeNWgwoicMpOpJYPk0HAH?=
 =?us-ascii?Q?SsHWATs8ns16mCgbndCmLc3ZCkOtPd/lywaj5w58Es5H3Vto+hpkvRJPKslv?=
 =?us-ascii?Q?yxG56SgYAUMqe96wDwGVK8uxPYpJ5RWmkcnRz/aMUpxWaeFGISxDvxBvb4r7?=
 =?us-ascii?Q?TJg/XTAJQlWitj+yYyfaXzHFM2oUDmb6N28Y34KGUDtJ6+i7HukO5u/Tjmmb?=
 =?us-ascii?Q?NaDa8wvU9zyX9dUx7zQM7I0r6MM+DA6d8KMwaeWzO/LiAZSK3T/LrNBYP9sD?=
 =?us-ascii?Q?p8NudCAM558SJsRqMvMJAWjnyB2jXWMV/dUtsJqocmrpYTVcZLsAvu4gv4Bt?=
 =?us-ascii?Q?mlocuOs+OOPmleJbNReyOkjiKyoKBTOEDaP/47CYEWmd/KoCO/pybUXGPpRO?=
 =?us-ascii?Q?Q0pK0HOfLhfKMSzb9gb9+jWT/ElUFmT9LEX4RcLlK/ItGtjkS/q0/lXwBsDH?=
 =?us-ascii?Q?oiWMQSs9ybRG65HyQa9iEBOjSdnWPEimtMPfDTmlEt64lUf1VgTsh8rkR2Gi?=
 =?us-ascii?Q?XdxmXKvGGEofyhr9h/U1igbExKo6KVoyWCM4yMWsBczg4tqSpAYypmp1fOLl?=
 =?us-ascii?Q?DXW7fl4yTHl3St2vftUhQNQtJj9J6WwOHf/ZL6K4l19f4js4Hax+J6KA/mZI?=
 =?us-ascii?Q?YCrFFaXUcss72ML88VdBP0Ijxxx0O4q71dONX3/QpIN4mMdaoZSiUFQN7Ef1?=
 =?us-ascii?Q?1EiWr1ioT0JLei6HBCGbLcLZBbtJRbx2NzIRmmIPRI6a/t1pLIGJpYRfZ3HX?=
 =?us-ascii?Q?U9H3OAxTLON2zSHSsBdPF2tJKYQd/Vh1rxca86fBV/L7THK5Y5kuzQojpumK?=
 =?us-ascii?Q?iDLn/u+GLqqse3zJdDyD+fp9PHuTWXFFX1iX/JSwxICwpC1cZk0xDz9M3AK5?=
 =?us-ascii?Q?xt6wYXzAERQvFUpwUYqf+9ucX/JFcEwhaAEvuXR2e81DOQXr15w4UdzNQ9gR?=
 =?us-ascii?Q?ynwKKzEGU5LPWKlW8XA5b9lK41CFA290oFrl/arxYgNNKMo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F840FFAB0C979E44AD77BBA3582C10F1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbddf8d-6348-4ebb-69ff-08d89c9aa4a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 23:32:07.2528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8TiwOqzl8A3DACx+HcHMl48Bw/9nsMMlNFQ159S0onk6SXEXJjwv/nM4eNKWHSWLY3xFB5mwVS5QUMyg4Vz+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3620
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_19:2020-12-09,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090161
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2020, at 9:03 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Dec 08, 2020 at 10:16:45AM -0800, Song Liu wrote:
>> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
>> by far the easiest way to write BPF tools. Enable building BPF skeletons
>> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
>> be added for different use cases.
>>=20
>> Signed-off-by: Song Liu <songliubraving@fb.com>
>=20
> one nit below, but other than that:
>=20
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks!

[...]

>>=20
>> +ifdef BUILD_BPF_SKEL
>> +  $(call feature_check,clang-bpf-co-re)
>> +  ifeq ($(feature-clang-bpf-co-re), 0)
>> +    dummy :=3D $(error Error: clang too old. Please install recent clan=
g)
>> +  endif
>> +  $(call detected,CONFIG_PERF_BPF_SKEL)
>> +  CFLAGS +=3D -DBUILD_BPF_SKEL
>=20
> sorry I did not notice before, but we use HAVE_* name style for these C m=
acros=20
>=20
> HAVE_BPF_SKEL should fit

I will fix this in v4.=20

