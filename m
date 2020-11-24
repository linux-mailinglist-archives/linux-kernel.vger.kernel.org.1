Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DF52C3501
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKXXxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:53:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17954 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgKXXw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:52:59 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AONmCBG024418;
        Tue, 24 Nov 2020 15:52:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=b77sg3goBdcCODoZtlaiPVbYYLWdJwoyqdT0YCLUm0w=;
 b=qj9sqHCMyWPvKVC3ENFCkXVj9L3B0QtnP23GPyZSAGBCH37bu+Y/c5sMvIIuG8R6uodU
 1qqrHss4ou/xFr+NHTD4USigod0jPBTRyI61a4KANeQ08HLOfP2JLzw/HMWh0/IA9K4u
 NRXWMA7KKMjFwXPGKBKhWbZp9HcWwcCUxks= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 34yx1t2hc9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 15:52:47 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 15:52:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zgh3poxWdBs5uvjNjGaaKGj2FyFKwBTxFogXG2I1/5BdRnflMA/+7rYQ6pmymxHpXJXbionIgkg7AZRhlASMDY4gffiL4KtCC0GT+J2sb7NvU2ecClXYa0TOjrUGGz4QDxrxH7QA62hzvmfyKvSpWlaIxtfv/m1bc3dHjjQSwc84cVg9m2ks0EwIngzDM2LlNrkUz3vZmR8LIgeV+7ih4RFgS7qPE8AbqrgCVXibcg3LA3HNew3W1aXPKvIgtydRtGPkr31FOldJ4Vy69BdJNXDCVRo/6BYKmrr3oC1oR2lCIH1iAjVcIW3zR2CXvrMkxiDE4Kc/8rH+xgrADGcl/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b77sg3goBdcCODoZtlaiPVbYYLWdJwoyqdT0YCLUm0w=;
 b=RJfnuTyJqiSvs3GoAPGi9BIbRAiRyYgGzVI4S/DJIdviobfdzxhL80KHi3EI4GE+bvZDg2PEjJfCeEozTEmPiMYPbC75qinyREGAON+0sFtyhmMhfewxovlhKYHmv44ucOPqfiBPK02tNvADlpfgDNu6iXHD1CypdkTL2i4hyT4diFxDMWJBKQjZGayiQvTjHDaoDW8QfTYihptTdYaLCUm3tY+WsZM/nMm4vg+9MQtpbKllIgON56W2TRgbeupkfx+NMPIem/4QS3rITy8eHL5ta5YBQmdaDuYrMqGS6xgu81FqvTb60b0GCNX6nXG544pnUcNR/jNcuWXaJpzVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b77sg3goBdcCODoZtlaiPVbYYLWdJwoyqdT0YCLUm0w=;
 b=FT3liisROSe/i5s0E5wJKG6bvEfCjt+U4wzyWjKmX6TQ0zMIdZ9rdfLIAjKNHZm/dDxP9T1H55rJGBaIn0IcoCM/9FJ2cbIXd938jg6fXPmGLTqHebm23tpIjZ0Dw63/nTDKayz/6rLIt4Wf9LN1TIBvZT3aFRJoJDqSA7XdeXw=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 23:52:43 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 23:52:43 +0000
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
Thread-Index: AQHWvi+b1vCwOQIg40KNUQdgLO76QanU0+mAgAMphIA=
Date:   Tue, 24 Nov 2020 23:52:43 +0000
Message-ID: <F035411D-BC52-4A65-97FE-D53120E06689@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-2-songliubraving@fb.com>
 <20201122233521.GD1902740@krava>
In-Reply-To: <20201122233521.GD1902740@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f2e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 382abaf0-96e6-41f6-ecbc-08d890d40927
x-ms-traffictypediagnostic: BYAPR15MB2566:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB256678C308C17A36708D3F1DB3FB0@BYAPR15MB2566.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TyDpA7XJuzy923mz5pzUo/CHNllj15iZj2Pkf6TumEn66V/PHe7Iz4m5jwwjpUNVHRtomIdFIXenfQmZLUQdJTlXjnbAD229KJ/5lFL6OhdeUpMPq1bPc6Y2GzlpxUaQTWjrPAn4J0n1IPI6uePwg+6tnKR0XAMPmckNZzeK5yHeGtjw8b/MUJaJVzhWwuPiiEYSgD9JrqjjJVDggI8bCQOEtkYtphto6YvDehQVIrreAZ/bxeafbw22xCd6PavWuIWa4EB72wKftDK3uX/AcrlXmHIgcq8MmvLeVgJJV7NgLw89u8a0LJwWrjC3Xahk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6512007)(5660300002)(36756003)(86362001)(6506007)(53546011)(54906003)(4326008)(66476007)(2616005)(33656002)(498600001)(8936002)(71200400001)(8676002)(66946007)(66446008)(76116006)(6486002)(66556008)(64756008)(2906002)(6916009)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TDrVydKPfDxnjxDG2PLwFO/PLwOARksdTww5l8ykhICaq9mRISGJ73gviBPh?=
 =?us-ascii?Q?vI3ONWPEEpjN8eqC87rS8ngDqOnfLywMrI0tQg3yjnkCbkeqtlEmcmrt/sBc?=
 =?us-ascii?Q?oorM21r5Z4kSd5BqwBcohdbuHNbHn+2Qoxm+dDZaZoUnBaSzqJw8ZuFSQ4jg?=
 =?us-ascii?Q?WdRZcixND2Ef2+wyBY9dYstJbU1hkagSw3coviE8DblpQ9uF48kjHnsqp9pz?=
 =?us-ascii?Q?sgpKewcG7u+N3rCvmn2sY7H8I22E/EBFa4tnhBsdDaXbxvlVdxvDKeceJgt/?=
 =?us-ascii?Q?+IfwiE456dsEsnXzjv+ci2CDwA1YPWIR9fFyk704ad1H/q5sjEzPMSVwXCGV?=
 =?us-ascii?Q?PYFoOLfMe3NHon/0qfJhxZBML32qfRMFucKBuR6h5IAeKOCfqVg61mXW4obP?=
 =?us-ascii?Q?HYhpxHMwaToaH4ovCARimoyJW08Pix3duXE1j3TdNoyju1vPNnMO7rXHUWSy?=
 =?us-ascii?Q?6HEGq8e6W1pS4Aq35hMVawJW28BkLiCRvQSsBeWSV8YqId6Ly//rGYpXmpwh?=
 =?us-ascii?Q?R3UYL5pb5OI/SUIHlLGhAJxKGFDyerEh6Z28dUweuhDEAU+uDRSEtcgBv5C0?=
 =?us-ascii?Q?M3Bk0fj0p/tv6g2o7J8wupLa4iJsQkSN+sQ2luVxzp5zIdGPem4q3cFDPadF?=
 =?us-ascii?Q?isw+Pu37b6BQM22FzBwW0JGINcuzQWZH5hut1kBQ5WkemPpefzopQhVlPM5b?=
 =?us-ascii?Q?NC76r21AadI7cR3BF058KQTkL+IEkgvPHYcIpDpnTTToucLr7qNx9TTeh5rp?=
 =?us-ascii?Q?GrkWf4lal/Uic5qArmO+w2nWKmKvV5J97WQCc4X13Krxk3egu44BT+833pRS?=
 =?us-ascii?Q?M8J70pcj5oT6Lu5oJKUBsL1Qounw4ZrMstRjv9l7dq9U7fk2LURRdgSAZsRO?=
 =?us-ascii?Q?ZXSqfGsX3ED8ypngG5HSMBmlOi295ok2xFZ3YAvnvDquoAqn4sqdN6jITGMj?=
 =?us-ascii?Q?uK84aU1uchtCPxEmuHqcM9XxVIgyXwt8LfwNf337eRe3uMsvJ9q14HjHF6JJ?=
 =?us-ascii?Q?zLs2x4UghIP1Oa5/3sBR5oNMvYGusKSWdUIi8yOScTIwy+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F28D30FC0330374F876EF6650B647BD5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382abaf0-96e6-41f6-ecbc-08d890d40927
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 23:52:43.3243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptyBlo/dE9y/LDpN7R4YUSyRyFd236ffPwy7fmFZ80XCsYOFfu7DZNfQa5P35Ng/g/kxbcLIB291s5/FvjnR4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2566
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=928 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011240139
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 22, 2020, at 3:35 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Wed, Nov 18, 2020 at 08:50:45PM -0800, Song Liu wrote:
>> BPF programs are useful in perf to profile BPF programs. BPF skeleton is
>> by far the easiest way to write BPF tools. Enable building BPF skeletons
>> in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
>> be added for different use cases.
>=20
> I was just in a place adding bpf program to perf as well,
> so this will save me some time ;-) thanks!

I'd love to learn about your plan. Maybe we have some similar ideas,=20
and could collaborate on them.=20

Thanks,
Song

