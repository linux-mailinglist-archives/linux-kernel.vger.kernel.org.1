Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321862C352C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 01:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKXX7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:59:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4340 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726889AbgKXX7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:59:19 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AONt06T001597;
        Tue, 24 Nov 2020 15:59:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=cPu3aPVwhPxP/bxaklgO3WilIDjyAxt3A5ugSU1ljhI=;
 b=V3GMJcRBKxxdyUnk3TnpVKqfZtbAbhzBc02XyL673oXY9jUT10LYfFkJ6AR/Wwir1nWa
 IUGhMgQ1kDVucrFQBBzZbvO6HfewBFCKlyfr+KoS5xil0dR014kV/R8fa2h2bbMPmQho
 26miNIbR+H1MYXvlfyn+AHhkNF9zeXMPvyM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3516xbsc8h-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 15:59:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 15:59:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhBwf+sQ1Bq2reOYqSBDbaaJQIyYnLIo4s32Ena9ehnrUU8lqBGfMfW5vRTu4ZCZ1F9f0MAp4XKBvJLA7vetlXw5fa9E0Cfgqf6VUpdje8KlVjm/E1KcHc9iJFesgOTRobnQCGKTJrN3LprSJ92+i32+6BF43/wRfVYxCb0q7matmo5g1bJw/er0VjO/60v3fNQJ5VG1vuuni/m564iwj2by+qZctxwCm6FtrL2BI9fKrz4xtUY1POkxbt2K8dUMgu2/+cq+N54+SgBZUFAELJAJDmS5hpHFOB1xKfTJnPCFrG0gC7RK518NYERFNmqOl52LN/s9OHf+xMRJVLukOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPu3aPVwhPxP/bxaklgO3WilIDjyAxt3A5ugSU1ljhI=;
 b=AGrjdzga/wWCp2/exe04R/8MSfKH32RGyyS2R+j0aLHvEJI88YUz93wOl9PwSa6DzmH0VS4E4FedCGWXLCN7WpqXJWXkNQFHaFL3qujInPJDEaKj06RFKXvznMOHjVhRHXF31l8Otzdv73kcVi0bxnqfcdynHXGoTPsqSTZT7KvgS38LP+XZvtkn+yeQxfVPAPndkodt6U9bXy44yqyKE+wD2FFRMVJex784hIK/5D8oeIxKziuFJ6K1QgOfOxQoSJq0zKsAv8ggBhVhqtxhY3DfHTY+5LzYSCvrfQlYTeK8j322MYxmAy6F0yzVd/HzJbZpmOywpoOpxFcTcsyX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPu3aPVwhPxP/bxaklgO3WilIDjyAxt3A5ugSU1ljhI=;
 b=e5KYR5W1rjgHXcJSiHUpOu+uiXXyWlTJPcbtsBgHvecv0V448jhTzNyoOQ9EL+lIejEsSPh12EMpsL7ntcR+3sFbm1CwZ82w+oHnwaVE4z6wwfelTlQmT6ee1q1sW/t3uTZyraZ07ElYCnyHzQdUzfNlcQll8Wtb8I0s7lQS48Q=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 23:59:02 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 23:59:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 1/2] perf: support build BPF skeletons with perf
Thread-Topic: [RFC 1/2] perf: support build BPF skeletons with perf
Thread-Index: AQHWvi+b1vCwOQIg40KNUQdgLO76QanXufaAgABFOoA=
Date:   Tue, 24 Nov 2020 23:59:02 +0000
Message-ID: <05654745-9D53-4D75-BE8E-1B59D7942D3C@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
 <20201124195115.GC2164284@krava>
In-Reply-To: <20201124195115.GC2164284@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f2e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60d57016-957a-4ede-09fa-08d890d4eafa
x-ms-traffictypediagnostic: BYAPR15MB2566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB25668CEFC6F963AED68B6DB9B3FB0@BYAPR15MB2566.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vgFL8n27TKpucqqj95sunVpPXrW9doPgAKo026+hOnicOzMlfxvAyS003ZsbPHkYZXXQ2HdI8yzevUj2YHpo1R33/gVrhhHk7yQgqegMRIr4r/PXWyDPh/UuChUfbHN2dWutXaR6SLeZTABMRWp4q1upu0DeBdYJt+e+uiBbcrPKb3qCqfL0LTeTDfYWltqLtEM+BaZNnOAGXQQB1U9OtppsNCfnb0TdFUJ3QUZCHOC6sseD8NN50/XxyqeDPJhztcVxlgdlun4MWcif5mKdvFhiOkGpMVuodzVg6WJ0X7GhKXDX+XefFZ2m/uov8FXB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(498600001)(2616005)(33656002)(2906002)(64756008)(6916009)(66476007)(8936002)(91956017)(66446008)(76116006)(66556008)(6486002)(66946007)(8676002)(71200400001)(36756003)(86362001)(5660300002)(6512007)(186003)(4326008)(6506007)(53546011)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YCzPsDHoiMCzpPkd62Qgj1pju4f6sw19BTZNpZCJNPTuGOudqFoDmzE7QsCu?=
 =?us-ascii?Q?eGhTjecyL6g4i6M6wQvNEixEcywD0sCEJhOVAlOtEO+w4uMUy66nEm4VDgoY?=
 =?us-ascii?Q?A6SsIhTSHXe/WekmRROAYx/Fqy50cWZ8rxt62EVjFIfkE4tuilYP3gkdDIqM?=
 =?us-ascii?Q?QP3nLY4hBOBBYN2RBpF5iSSzSqZql1kzrWIdKKB16jihKPMxnOYQOwVkpL9W?=
 =?us-ascii?Q?sU7xYVGDAl7K4s72+d3v9nrrbPJKIXWYeIwX8cZZvYXblyR59zgdDU72e9yC?=
 =?us-ascii?Q?naWWfnQTICLyylk959QafHAlhAkxxgDRvEjBPuR8egDIcCPtJzm2tDshSpn4?=
 =?us-ascii?Q?2ry20/dgE0ZpkdBxz23rYEdmWbDCr93ICUbuFSzi0X3I3+p7nwxhpw5etuBm?=
 =?us-ascii?Q?mPzdqwLsrVqbbNwScY8DpMlp1as31ph5e0lNbyhZt2zJ40YiGUZYllWJTmVX?=
 =?us-ascii?Q?Kdu6DxzSTjSmBa044qHTKmt57bozrFvb7H3QhOzqWLgkDR0ls5vKQW4pKpT1?=
 =?us-ascii?Q?Lq1gaB4enDtqYsGXcAnEQxKuw2A7TV/uYN2BR8XiIdAVFJ988KjL6KRGayZz?=
 =?us-ascii?Q?42Dj90V6WboiLj2NeSOfqSN1wyWCdXzlG+iP87QGbmwlDYjJXiKbYGJ1Do3A?=
 =?us-ascii?Q?M5HZRhZ9ycvu0BnVRY08czvXSEKSuGHUSqLW0/1Fsqon60FKIi+xBYN63ost?=
 =?us-ascii?Q?VDqCyq1TtZD79OcajmniapJdyailR0GriT3D9sXMgBlJrH9+s0GgckXOpgsY?=
 =?us-ascii?Q?Br5ogn9dbAi5Bn1zeg5KoNAt/x5q+7GcwZFQP4q6szsmx29wFbARv+wYD/RI?=
 =?us-ascii?Q?d4PPc/La2Fal09ajZM1p/ciyQmckypdgBvZS1QR/lh6zfdcwyt5Ffm/dRS80?=
 =?us-ascii?Q?OInvJVhyEANnK2uQZ1Xl8b43biYJGB7nOMZouFHhEXqjWovCwAD1NOMyd5Xt?=
 =?us-ascii?Q?hQQpcnmZbK+2sHnRAJnn8rrsYWraLiaLuGsUdF9U4FlW/atJtVuBU5P8lzUb?=
 =?us-ascii?Q?++ml3hsTK+OmUgSYwHgUc8zoIw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BDBC2AE895CEDF4B9B81E843B9745CB7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d57016-957a-4ede-09fa-08d890d4eafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 23:59:02.1587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O2qKGeTOlGQUs0Uf1F5WPiC81ieeeVDFvuJFe5n92jnqgYOF1SgnF5Z9KS/BV4w6T6vGJ/d1mU50hO3PyvIsBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2566
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 24, 2020, at 11:51 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:
>=20
> SNIP
>=20
>> +
>> +$(TMP_OUTPUT):
>> +	$(call msg,MKDIR,$@)
>> +	$(Q)mkdir -p $(TMP_OUTPUT)
>> +
>> +$(TMP_OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(TMP_OUTPUT) $(BPFTOOL)
>> +	$(call msg,GEN,$@)
>> +	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
>> +		echo "Couldn't find kernel BTF; set VMLINUX_BTF to"	       \
>> +			"specify its location." >&2;			       \
>> +		exit 1;\
>> +	fi
>> +	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
>> +
>> +$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(=
TMP_OUTPUT)
>> +	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
>> +		    OUTPUT=3D$(abspath $(dir $@))/ $(abspath $@)
>> +
>> +$(DEFAULT_BPFTOOL): | $(TMP_OUTPUT)
>> +	$(Q)$(MAKE) $(submake_extras) -C ../../../bpf/bpftool		      \
>> +		    prefix=3D OUTPUT=3D$(TMP_OUTPUT)/ DESTDIR=3D$(TMP_OUTPUT) install
>=20
> could we build just the bootstrap version of bpftool?
> should be enough for skeleton and vmlinux.h dump, no?
>=20

Yeah, that should work. I thought about it, but didn't try that hard.=20

Song

