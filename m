Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580A5288AD9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388338AbgJIO3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:29:00 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:15390 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728934AbgJIO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:29:00 -0400
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 10:28:59 EDT
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099E8DEk010040;
        Fri, 9 Oct 2020 14:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=PcKXwpWP8DjhxSUKGLe0MI7lpSEzjy78bf63EyFM3pc=;
 b=Y4iuR0gBKIawcRFi3TYvCyVKczaajfk3W/3I15jpDmrCBEVQrjAEe8c4+RCd8zkXxnEu
 wquHYcM85YPbeQOKox8B/abETiEdlq3VHaW9NzyH0erKKWgL7N+xP0cxIvfDBp8a/3Lr
 1RgtIQc9WvEGaHjSVnxFBN+9j+SZZqvfZ2DX26dnPSn7N2LlP+57DEep12SWOQeLlQOc
 FpghNnos84/NS3bHeD64jC3oic0CNv9lfGxaLKXY7Zxzc39vT1KKibvBSJVVallNSIfm
 vq6lMMglWDoYDakjhcLNfCbKuZfgwTuhNvyYVMJ2V23osHLoSr3yRSOER9SZAakxBG9K qw== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 342pvjh619-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 14:11:07 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g9t5009.houston.hpe.com (Postfix) with ESMTPS id D1E5658;
        Fri,  9 Oct 2020 14:11:05 +0000 (UTC)
Received: from G9W8669.americas.hpqcorp.net (16.220.49.28) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 9 Oct 2020 14:11:05 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8669.americas.hpqcorp.net (2002:10dc:311c::10dc:311c) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 9 Oct 2020 14:11:05 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Fri, 9 Oct 2020 14:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFWlvyFYoo4LoRDvJOlJ48m1yvzhNtE9ZQ/fyzX5CcDTejUigmY8v37AOzpwfdXzgqCH/O7uj77WknxeN/ZMEycV1yNLqczL2X1Eg+0mc44S3uD2FggxPyHIpgecMFzuIHJ7vCB8bIYWDrvFGxZWUIlNOu+9JyShlNcHAdojwTymcruNxxtgknWYtkNukqrcdmNdgUbNN9p1BB2Q/b0Os2z5GanGNRRVOMp3gKKnnzr5QfzRWTHr6C+GZrZT2+tUXaWsZqOJqA/kMMJS75wPjjiIiHFiCPITg3e0UtuB1wcjFqpkr79yLPSnJwLUAyafJgJ6RdrOkcKOYflPCfejVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcKXwpWP8DjhxSUKGLe0MI7lpSEzjy78bf63EyFM3pc=;
 b=AWOAumyQ0jUWHCjMMeodhGIJqvRaTmTyifoPWQnibuz0hjoOWhijTT7gcvxbOYptqLviZEyN+O7bHijpazC/945IPp9tox2a5Tp90Nb6UIGWwb1zLmhGcWstfV7A44TXzlY5KH5PHAr+a316XMya99fzwejE1YQUZfoTrMiz9sKlEwJw3s7Sl7sFF8TRt9LWrIWHIer+7RfH8lXTt+acdxqXC3tfKwYRuUz9nnVWV3AmyLA1PZD7WArCoLIKf6Z5NEbZ9tu9RZqRXgmLkyJkiPQ0gEHnhhC+6GmGnwrXFFQ2oK+ZKEib/jKQNeX3ZVIzvmRvHEpBCeGExyJA975cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760e::14) by DF4PR8401MB0682.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:760b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Fri, 9 Oct
 2020 14:11:04 +0000
Received: from DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1c5f:7a1e:9244:f08]) by DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1c5f:7a1e:9244:f08%9]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 14:11:04 +0000
From:   "Meyer, Kyle" <kyle.meyer@hpe.com>
To:     "alexander.antonov@linux.intel.com" 
        <alexander.antonov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake
 Server
Thread-Topic: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake
 Server
Thread-Index: AQHWlYE8WxPO4bs5eE+etvuI0+CzGKmPXWOi
Date:   Fri, 9 Oct 2020 14:11:03 +0000
Message-ID: <DF4PR8401MB1035CE7DBCCD58B531748BC69B080@DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM>
References: <20200928102133.61041-1-alexander.antonov@linux.intel.com>
In-Reply-To: <20200928102133.61041-1-alexander.antonov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [24.183.125.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2933b377-5af8-4e50-0c1f-08d86c5d2893
x-ms-traffictypediagnostic: DF4PR8401MB0682:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DF4PR8401MB06827A7657C330E16AE49E7A9B080@DF4PR8401MB0682.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:174;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cugQ63fp+TuWaBiWt/EXFxGl36hoRoPLItED9RPeOZHvvEKFy6m2TIsUdAqslLYuyMetBeVye/Dt2WNQUvz0KDtCSlkPgrnL4+AhgPgu0NBzOxZpIWvODhLRqzIEaJe6TRAxFfQHNZGeoDDAsqO7d4C0+yTqnL4lASjKljTrw8ziA/QmMV6vOyGWmFo6uZ7Yj5mWeTOaWfq9GsMyR+xeiKKaflzH9pwydP0TlMbZ46iFftNdsZEC9Q5O+si3pSRUEaG5f61bXvqY/FA/vVLNpmefU8cxjK7cOVFnvmRc5zCbteHTPmsVIkXu7qacoHD8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(33656002)(7416002)(66556008)(64756008)(66476007)(66946007)(66446008)(478600001)(83380400001)(8936002)(86362001)(54906003)(52536014)(6506007)(7696005)(53546011)(110136005)(186003)(55016002)(2906002)(4326008)(76116006)(91956017)(316002)(9686003)(8676002)(71200400001)(26005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cQU90D5uTFve38w0ejoOO3Za9e0xi6EGWWvl3iAVnu6Rtu/rHCuEuhyfPirfZDhxk3x1gVUCpKqCsy4C5DiFwbTEuAAhf0L3UnnwYDscVWByhTIOJBZSWUMggqNEgzejJPLTWdqMX2fLBT/lpc6B7XYN3mahwThu8BXr3qUxE2vgCOiqd8fzLvssa0iXPgBspFturOx+zT/cqHMEc7BqGd6tgTDMxb224NIy8bOK9Q2VMnBz61mO3/1Sw+fJWSNFhp5NsUnzOmiXH8eR4nRPjcC9o0YXyXJ58+SZ+F3hx/w8XTG9C8WavgtZCKrhYIXFuuw2f4kMpKTl6FaxoqSTIDUoleyFkBfiPTEQJ1GSIH0gZ++0MaVdtX3AydQLW226R7q8l4aRBMEc8Z6HLY7+/5tPSBGzHEYK9CxEqBeFcaYG5TvJKk81lIWwPw+GUrzVMoy1PA65vSOznDsVAziIr2UOVNcnDmoyMI346WN7ioft2eYm7BsuTMWvL/tXoS8JD3QazbDaFWRf3k6H9KTAIkUtY3WwHy7Cz11HEWn6vehuOXTiiCA83DW14AFtNvWF1/Anx64Bk6w1Zy6rpYy5XDkNUX45pXKIsEf4jh4fRkfKWt1IjjXhWL0wnmA/YGIAGUarfAc5GDXNv4Ma1tVo7w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DF4PR8401MB1035.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2933b377-5af8-4e50-0c1f-08d86c5d2893
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 14:11:03.9150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3WgNQV6GMZIhBcOi+GE6aoeseEHXmHtWOpvf38uSCQjz9PjWvi27WPFeros9O86cNHZrcJ3OqZo2dBJND3sTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR8401MB0682
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010090103
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander,

Do you plan on supporting multiple segment platforms?

Thanks,
Kyle Meyer

________________________________________
From: alexander.antonov@linux.intel.com <alexander.antonov@linux.intel.com>
Sent: Monday, September 28, 2020 5:21 AM
To: peterz@infradead.org; linux-kernel@vger.kernel.org; x86@kernel.org
Cc: alexander.shishkin@linux.intel.com; kan.liang@linux.intel.com; alexey.b=
udankov@linux.intel.com; ak@linux.intel.com; acme@kernel.org; mingo@redhat.=
com; alexander.antonov@linux.intel.com; Meyer, Kyle; Anderson, Russ
Subject: [PATCH] perf/x86/intel/uncore: Fix for iio mapping on Skylake Serv=
er

From: Alexander Antonov <alexander.antonov@linux.intel.com>

Introduced early attributes /sys/devices/uncore_iio_<pmu_idx>/die* are
initialized by skx_iio_set_mapping(), however, for example, for multiple
segment platforms skx_iio_get_topology() returns -EPERM before a list of
attributes in skx_iio_mapping_group will have been initialized.
As a result the list is being NULL. Thus the warning
"sysfs: (bin_)attrs not set by subsystem for group: uncore_iio_*/" appears
and uncore_iio pmus are not available in sysfs. Clear IIO attr_update
to properly handle the cases when topology information cannot be
retrieved.

Fixes: bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to IIO P=
MON mapping")
Reported-by: Kyle Meyer <kyle.meyer@hpe.com>
Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Alexei Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/u=
ncore_snbep.c
index 62e88ad919ff..ccfa1d6b6aa0 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3749,7 +3749,9 @@ static int skx_iio_set_mapping(struct intel_uncore_ty=
pe *type)

        ret =3D skx_iio_get_topology(type);
        if (ret)
-               return ret;
+               goto clear_attr_update;
+
+       ret =3D -ENOMEM;

        /* One more for NULL. */
        attrs =3D kcalloc((uncore_max_dies() + 1), sizeof(*attrs), GFP_KERN=
EL);
@@ -3781,8 +3783,9 @@ static int skx_iio_set_mapping(struct intel_uncore_ty=
pe *type)
        kfree(eas);
        kfree(attrs);
        kfree(type->topology);
+clear_attr_update:
        type->attr_update =3D NULL;
-       return -ENOMEM;
+       return ret;
 }

 static void skx_iio_cleanup_mapping(struct intel_uncore_type *type)

base-commit: a1b8638ba1320e6684aa98233c15255eb803fac7
--
2.19.1

