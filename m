Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815EB2D31F6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731001AbgLHSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:17:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33812 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbgLHSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:17:17 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B8IE6FX023078;
        Tue, 8 Dec 2020 10:16:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=enorVUHw1aIjLOBnCtDNZ8FrUK7CzYy0v6oWeXGR3D0=;
 b=Wh1eK8Us1+VHdS9h3blQM6SXMD58tul3Po0foS26auUjpxqRSrk9HBCoodG9y1+KeSbI
 AEaliQtfQLO84upuCtt8dOy7BY7pyGgTVLd3VEvcAcqgOkTTQilgM1Nejte2MkVky2Uj
 b6gEBj+9PqtgBra3t/qfT/QD6pGPIEG4XG8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 358u5b0rhg-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Dec 2020 10:16:28 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 10:16:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDLZrLEIvuBfpLizOcLizMkLd+yOBmD1t6PyDlVkZNdSk123Trk96GZXARxZ8QttvuS7BjrAHgkKKKhLiL9FJRukl9YwHGIgxzLt8MIyxD6KrVuqWZIpiXYgZOqqkpbZiL5IZjh7J4k7GeZr/yqzQPzlJNzz0lolZn2W57VwyZX0FuirCiROWRN0q/FnXM2eDu8lt6SM+99Mn7454vPCV8qMJLBRB9NIZJEmuPwvTXya+ewhn118pytS9nj0LvVY7ZA7ctxlNNeVxlCs+ABa5/yDkk8ag/qBgYN5E7u47zWTkyWSh6iMHVX7PMZt+EDo4tK21VId0lmIOH/8ftdXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enorVUHw1aIjLOBnCtDNZ8FrUK7CzYy0v6oWeXGR3D0=;
 b=Q7XDtGlxXQi1kwgz8iZdjoAFM/GhgcepoM0tocxyKbNfH/CFiERwz/in/DQ9O+hAsNZI8OPp4bZsCc5cvKp3363mC0wUYfu42xq0uewRg3l4Q58Rxtw8PMcFuKxqUzjN3r7WmM00oYDLoAZrk2pjEmoJJ6WsSB7jY28zp6+SAn5l+svEyk7+WQoFeZIS6BbkBazvebutSxG11MEMQcht5nHC7MJvJSDtI+R6Z+ZT2VYdZWkH87eO8IWKuIcaEGqTCY68VMsA9iTmeauUfCsqUcHAZJDMUgnKbJneedfR6OZiy9deMWWwv46PyNOgvSvztCFmVw4ayALmkftM/EahYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enorVUHw1aIjLOBnCtDNZ8FrUK7CzYy0v6oWeXGR3D0=;
 b=e1TVH6y4Tun1uC9Xq5AupMWOfMY4sXl22ZP9lNTxwDKjQnfQ3kNnfchOpbL25erkKOd60uThZFJoLEwnZje7jm/XkwZ4tiK7R64zKivliyR9VmlZ4sqFbZyH3VXnwN6fh8dX2jcNDcmtC8a2s9Qixu889msHIJ6zhby0JYKdLss=
Received: from BN8PR15MB2995.namprd15.prod.outlook.com (2603:10b6:408:8a::16)
 by BN6PR15MB1345.namprd15.prod.outlook.com (2603:10b6:404:c4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 18:16:25 +0000
Received: from BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::d5a7:a3a2:3289:d612]) by BN8PR15MB2995.namprd15.prod.outlook.com
 ([fe80::d5a7:a3a2:3289:d612%5]) with mapi id 15.20.3632.022; Tue, 8 Dec 2020
 18:16:25 +0000
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
Subject: Re: [PATCH v2 2/2] perf-stat: enable counting events for BPF programs
Thread-Topic: [PATCH v2 2/2] perf-stat: enable counting events for BPF
 programs
Thread-Index: AQHWygSVjVbTDtrVVUefy9NNfYjezqnsNoyAgAA6pYCAAJOBgIAAg6mA
Date:   Tue, 8 Dec 2020 18:16:25 +0000
Message-ID: <B7C5D63B-17FC-45F0-85A2-BC0DACAE66D6@fb.com>
References: <20201204061310.3196812-1-songliubraving@fb.com>
 <20201204061310.3196812-3-songliubraving@fb.com>
 <20201207220703.GA4116109@krava>
 <C94864E9-CE05-4AEA-A986-731BFC0C95FF@fb.com>
 <20201208102453.GA4135722@krava>
In-Reply-To: <20201208102453.GA4135722@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:d023]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc54f3b1-5d88-4940-d3b7-08d89ba55fca
x-ms-traffictypediagnostic: BN6PR15MB1345:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR15MB1345BAF96FB6A028F8320E73B3CD0@BN6PR15MB1345.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m68vdjhUsXo9ZH0YHnf/KfKn7oAaRf2fDJDU9/7HE8yKmDmgUxOSSBAlNBk0uzRAeHnmEU6FVGndJbArQ+nBThRDuwvSrrN1LEnbkvU/m+ZkWTv0hGtwLHO1CCTcmlTH93uuY6fvdN9ziaCeT9pjEgKvGSftUFSHrem8L/sbe5isa4c0ba7cTgCmYwf7nt8GVQDfUN3lXU8KXg05GniU6Cxjdsu9iY4/BVASBKAcmpCZMCXp2mLw+phoM8++zNwmBgP1pnkB7CZi/44zrRtL64+Qpl5rFM3ukRyIsGshXdxpUJWdv/JTDD26BgX1RLYOAf/SmeSPSdq+P8yCsFktbCNGfW/hJjO5BD9Qu3zyEDzRYekKvPDAAXfLIzXvOromoA+OCETMzIYvnEGtiHIQag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB2995.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(76116006)(71200400001)(36756003)(6506007)(4326008)(6486002)(83380400001)(33656002)(8936002)(186003)(66946007)(54906003)(2616005)(66556008)(66476007)(6512007)(508600001)(86362001)(66446008)(91956017)(53546011)(64756008)(2906002)(6916009)(5660300002)(8676002)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?veUgYqoLp24yV30D1oJvCUUOwxQNK9i/ceqdDPefhU3wfBmLBXXIFvHD7AwR?=
 =?us-ascii?Q?+ukoK0L37gPDKiYaEw9PCQfo6K5I93386fDx5YbhK/YDFXqP8/1BYl1FLO8n?=
 =?us-ascii?Q?o0ZgT++6DEPUy0fubwUekpaARoOCo1PqQA32nrIvLiMla2D5pswgNnVuvtpn?=
 =?us-ascii?Q?z39DyR8SX1VnHv24j6hsXJeBInGvSzP9b4RW1IvlroXHKNxnodUWckRqMEcZ?=
 =?us-ascii?Q?cC4RymZAsLKZ1fS+iOcsbaKeihOgI0tpeE3+WEPDO2O/Ev2j3fa4bRoApPQz?=
 =?us-ascii?Q?oDUNH9NeGLKK57i2CiA7LqxqR7hIubnruDu4XQU9kVkEbcx0BNyIYlD+CcyG?=
 =?us-ascii?Q?46i9dRybNr5ZXVIRJCbRJxH3a9FIvVPPxgVMDK/QCdU0OMKhUXsVmsy+QuPA?=
 =?us-ascii?Q?rX939fZgXx7ko3IAWN8mz8C51JThHp9oN+f+6lC2Gl8dv5lSmwhUVML5z1Lg?=
 =?us-ascii?Q?Tt28GbM7hxJ5Onxm49+PYL9hJFeQa6cBUkHoWplctkcmDd8fgTiPQg1VfITN?=
 =?us-ascii?Q?i8brm38hHd8k9/LD/aPOi1AHkPT3Co1mIci7pn3YDR7OTFlav6mj4ukT8D2B?=
 =?us-ascii?Q?HjISa3uqIVF9eIoFMuGas2u6T3V3JgQ/WpkX6AKr0LNSaxAF87NOrgXSEuhD?=
 =?us-ascii?Q?u5Fks70rvz9oTLFMIrVfZPx52Dj638C3zKEcYwCu2wzTgBvft6w0EIgEbZvl?=
 =?us-ascii?Q?ecYpeFlS8mK3cfk4VXI+7h61vG19NdagLbWG1s+r+XJSqS3hikgVOQ4bLDzm?=
 =?us-ascii?Q?I2nbOtuEXtP5BzRxWS2VOKHtqwz/7P9VLoHBpDafe99MhFo9FQJFmAoVGdQb?=
 =?us-ascii?Q?CwjhbSmJtp5WCOd8A7Cg3qkdAn8oseG82Wy6jrWw8l6OeeeuGNh8G7JKho0X?=
 =?us-ascii?Q?QVP7edNRm7Z9/IKtGMnbLORweB3wCH3kCV63WVIA7Sg+hGGsF2xZZNqx9aCe?=
 =?us-ascii?Q?EYv6wfV6qe2Hltfn+yFFcUcHeQZJoxWalgeQsC68hA3QMvE6hQgvrpQACdUU?=
 =?us-ascii?Q?SHtbfe8tUJBjbwVCli/NKl1WYyEwzDSn6lcCeauUyuapz5I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22CB18C5213CFC4EBC13C692B0189AE4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB2995.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc54f3b1-5d88-4940-d3b7-08d89ba55fca
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 18:16:25.0623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P9OHPIGMMvnrmIPLCsCv1YhC8NLxVVeiBwUR4smD/RyrFCXNvMoBN+BurJxfII7jQ5p8LNOzqktUWQq/+gvW2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1345
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_14:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 8, 2020, at 2:24 AM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> On Tue, Dec 08, 2020 at 01:36:57AM +0000, Song Liu wrote:
>=20
> SNIP
>=20
>>>=20
>>> I'm still getting
>>>=20
>>> [root@dell-r440-01 perf]# ./perf stat -b 38
>>> libbpf: elf: skipping unrecognized data section(9) .eh_frame
>>> libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh=
_frame
>>> libbpf: XXX is not found in vmlinux BTF
>>> libbpf: failed to load object 'bpf_prog_profiler_bpf'
>>> libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
>>> ...
>>>=20
>>> with id 38 being:
>>>=20
>>> 38: tracepoint  name sys_enter  tag 03418b72a610af75  gpl
>>>       loaded_at 2020-12-07T22:54:05+0100  uid 0
>>>       xlated 272B  jited 153B  memlock 4096B  map_ids 1
>>>=20
>>> how is this supposed to work when there's XXX in the
>>> program's section? libbpf is trying to find XXX in
>>> kernel BTF and fails of course
>>=20
>> I think this is because this program doesn't have BTF. The actual failed
>> function was bpf_program__set_attach_target(). So the error message abov=
e
>> should be "Failed to _open_ bpf skeleton". I will fix the error messages=
.=20
>=20
> ah right, it's bpftrace program, so there's no BTF loaded for the program
> I'll check if there's a way to add it, it'd be shame not to have this
> feature for bpftrace programs
>=20
> there's no way around it, right? we need btf id of the program to attach
> fentry/fexit to it

Yes, we do need BTF here (in bpf_program__set_attach_target).=20
>=20
> I think we need to fail the function if there's error detected,
> and also check on the prog_name and fail if it's not found
>=20
> plus change all those pr_debug to pr_err in bpf_program_profiler_load_one

I fixed these in the next version.=20

Thanks,
Song


