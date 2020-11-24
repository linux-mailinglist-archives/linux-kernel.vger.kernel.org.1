Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053F32C34B2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388918AbgKXXcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:32:06 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46464 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388294AbgKXXcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:32:05 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AONK98m014974;
        Tue, 24 Nov 2020 15:31:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=hWHzGfhdd8OoKAcyTkCmcUQybPT1ww01VOPi/66B/0Q=;
 b=JpTObaw8fparfqATWb7KuGaPwZrkhHroN9rylZuSlX45Rfe3g4MuBKv+JU5ZXAL3sJrW
 XOeNVQ1Yio4lyiVa7+wbEgdWHHO1l0x/HilccTvcafpNewHwZ5A1SEl3h1KckrV1EtBT
 OvtT8aL77KcWMSmZbC/E3qF1g6NiF/iMqfg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34yk9044vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 15:31:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 15:31:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bna2q0Zg3/o9XwArheehO9z2mwQVvMNwv2IoYCVjVhiV5taP6xbUMGoXGP7ZNNX1EjF619H1ONrFiROaL8a+UbycfFpxUU7vddgfiiYFLN/eCdjpNiwkgjh4QsYkaSKERn+J3rvt8nbvVZdyr1l3cxM+2welV4I2dRzN/FPFGTv1MxyukkP4REnM45wKCsIueB8cm764gpd7EjK6kT4hVuQRnI/BK72lJVCeWNVuiVGFd+xMAY4ugHPWjp6Kygbz5jzSEuAEpS4BIpjFQ2JSfGX3ihhsJrdX675O5UhHnA1qfScGVvWgCCVKDSK6bQ1tLAmfVqmjVK/jEyw0/fb8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWHzGfhdd8OoKAcyTkCmcUQybPT1ww01VOPi/66B/0Q=;
 b=dIjNCOYK0QjrGsNfr9BTcW3Gh0MjKDQJjDfTwhab2wEFrMqEI6RW7SRUfAiP0COJd5JfKVmrppreS9AMf2rfUMkGz33TUyqUbl3xlA79cL7s/DFFkrhgaHS9CKak+SONt8yfUdTuMwh4Yig1lZ3rwSPB1I3WSveOt/mS4D7Fe4XGadE9OjV9n2oadq9HTYP4FsoAQqw+9w5Q3yvOh5b2t4MAOY45SdxZfanqj2dc9uZrTYz6AXWkU+2gyjTuPOxjHG8d6s+yD9ll8hARF8oN7JQkp9obDMHT1lTK+hygTmlstUH+IwgwjShNKbMjG5RBRq/Cj7+5OVkVnI7QepkdWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWHzGfhdd8OoKAcyTkCmcUQybPT1ww01VOPi/66B/0Q=;
 b=D0RLg7KNk69C9rvJ7CD7x+uJ2JL3i1ua9elp4LZU8icRD91AbNuw6qisGCQWgn//fcCW3o6NQH0NM71vA3Zr3aZj2KPJQSIfExqzL+fzk25FJrseJB+fHlajUOqRrxzgStNyAbBDBQwKTlRQmjjnbDHGDPjtN5+P99h8nJ2sMX0=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2776.namprd15.prod.outlook.com (2603:10b6:a03:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 23:31:49 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 23:31:49 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [RFC 2/2] perf-stat: enable counting events for BPF programs
Thread-Topic: [RFC 2/2] perf-stat: enable counting events for BPF programs
Thread-Index: AQHWvi+l7AybrLX1mkWxO3oxzMTbKKnWaamAgAGN64A=
Date:   Tue, 24 Nov 2020 23:31:49 +0000
Message-ID: <86F842B0-BF89-4418-BA2E-F93E50726A81@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
 <20201119045046.1491106-3-songliubraving@fb.com>
 <20201123234735.GB2088148@krava>
In-Reply-To: <20201123234735.GB2088148@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f2e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbcde9c8-1c78-4aed-97fd-08d890d11dbe
x-ms-traffictypediagnostic: BYAPR15MB2776:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB27769FE867DF0C1D685B092FB3FB0@BYAPR15MB2776.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1gqbASzsLw8kx7N/f00mdYsF8wBra3yXAF2PrxFRG2/RxJGf6ie5gLLd7fmugFZpj7u074lC8zcZErTxikVsiCgcEhcWfKBC7eahv8ci4y8TF1LVfyZto8rYxWrh4wESkzIn6T5KUFSbgFfQ7zMyhTGa6BSmDmp40KlfdvKTIhkcqscSA6RR4CD4AUzFbfSJ0Fe4nEAd2u9+Y8Mv2MWTU+wrt39eHSMn5naEurqd8MWgRaLjgJK7qt8sj6vzF2QRhkoeB3L01ksNQNEx7UcpJUmPH/rLRr/UjpB/t7ukJIfMzFgH7oHnhFCdMph0BtI8m2oMmd5UZ/CrxPMs6IaAPG6Afl7Ueir76rCPYqBtEGWv2EJOPCrapdZq0pBioXoc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(498600001)(6916009)(8676002)(33656002)(5660300002)(8936002)(6486002)(66946007)(66556008)(66446008)(66476007)(64756008)(4326008)(36756003)(86362001)(6506007)(2616005)(186003)(53546011)(2906002)(71200400001)(54906003)(76116006)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?uOaX/bizEAOieTWXZLkgJ9TaMgFsFouOn1aYPmb4y7g0eI+ZXkE5Q81C+rM1?=
 =?us-ascii?Q?i9NSpJb7p6a0BoG1Z4ryhoyUPzNDG9JHjx/CI25l28A/cfJoL3LELa+Qe2Mk?=
 =?us-ascii?Q?JqoT9od7zEyiPXIMN/5U+rc4V7bSjBaCPfzjZwLkJONhJ+Xk6HMknNdqyNdJ?=
 =?us-ascii?Q?Bk79iZYZZ90kTdblZu2Pf497WraCUT0kU0VeP6LtXCHOp9cTvIC5+k2vHtv7?=
 =?us-ascii?Q?/nnsiecFunh3oJXf2bC44ym87OW0rOTaLgkJ8v2IrLtjyysvf8OeUJKEOc/Y?=
 =?us-ascii?Q?3ZJaE25s8vqvOG9UpdF/OEJUbk+E5mh8kjLNkYMTWm2kqSNM0RiawIEspwbz?=
 =?us-ascii?Q?yxFpv1xRtZg/+H1uKnYW7Lwll4T+gNbdh/RY80TR9FsJb3U4hqswdbo3wZlP?=
 =?us-ascii?Q?U+v7CfEzxyUO4zaj5YHpmQ1v3mChaaXMbODl9J0NTwIhI0gNoZDiI5lPJE/O?=
 =?us-ascii?Q?OJh3pwfAq/xRZP590UuteNFYSVbWzMuw8ZUYckcJGy77+NJyqcIcSOpF3YWk?=
 =?us-ascii?Q?tq3HH1iOxvvzX3W0wO9WVScmFSNxH2/HAcQMIuOCkSLiuCqrOmg1oJsfVBjr?=
 =?us-ascii?Q?mIu+mEJG6WzEkkApJ7SjiZqHuvPCQDVXxMRdPNn2/1KwT+vROPecP90OqMv7?=
 =?us-ascii?Q?3zhLrpVtxX7EtaHY2wX7K6+NJKG+9sf7Ggl3AawGWuqqaeKDeLnnTOJXaxI2?=
 =?us-ascii?Q?9F3JM1QkM3H5kywoVUzusOzMxCMZ9kQO958re7q5OPdTfHeDLAeiq47RBc0U?=
 =?us-ascii?Q?bOVKZ+q/QdQNP1IV8HxQaeN+Q0twgJOELY5bHuXaL6tZM+hhdgDqhks/AgLW?=
 =?us-ascii?Q?xRzBSN71U58vctZEu3yoVFA0j4BIIJSeqIQ5T7MnwrMVHpOVnqHplzmwB/gX?=
 =?us-ascii?Q?hQI75+Ptjr53IcQKvUOBAxFqMWg/VdhOc5WgQdtMFisJzjRiTX+Bo1V8JbRX?=
 =?us-ascii?Q?GYHRxkhjRR9LVWARy8KIIhlFVwNUr1e/1E89W9ZvXNusaqiUJAr4xV5x0IB6?=
 =?us-ascii?Q?7jVW69++NEl8wR0qnT1HQqLKGLEyOisEAFYXA49MvJrzxqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6AA983C82462EF4C88FC627E4A1C2283@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcde9c8-1c78-4aed-97fd-08d890d11dbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 23:31:49.3220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iZ74NHQ09ij3MPPYiqrd4Q4ScATZ9MbGZ63sLs9eGhVoCtCXQmAhXgrqT/cKUF/0CZOlivOfiYB85f35aD+V7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2776
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_11:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 23, 2020, at 3:47 PM, Jiri Olsa <jolsa@redhat.com> wrote:

[...]

>=20
> I still need to review this deeply, but so far I'm getting this error:
>=20
> 	# ./perf stat -b 40
> 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
> 	libbpf: XXX is not found in vmlinux BTF
> 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
> 	libbpf: XXX is not found in vmlinux BTF
> 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
> 	libbpf: XXX is not found in vmlinux BTF
> 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
> 	libbpf: XXX is not found in vmlinux BTF
> 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
> 	libbpf: XXX is not found in vmlinux BTF
> 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
> 	libbpf: XXX is not found in vmlinux BTF
> 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
> 	libbpf: XXX is not found in vmlinux BTF
> 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> 	libbpf: elf: skipping unrecognized data section(9) .eh_frame
> 	libbpf: elf: skipping relo section(15) .rel.eh_frame for section(9) .eh_=
frame
> 	libbpf: XXX is not found in vmlinux BTF
> 	libbpf: failed to load object 'bpf_prog_profiler_bpf'
> 	libbpf: failed to load BPF skeleton 'bpf_prog_profiler_bpf': -2
> 	libbpf: Can't get the 0th fd from program fentry_XXX: only -1 instances
> 	libbpf: prog 'fentry_XXX': can't attach before loaded
> 	libbpf: failed to auto-attach program 'fentry_XXX': -22

I cannot reproduce this. Is 40 a valid BPF program ID? Could you please sha=
re=20
more information about it with "bpftool prog show id 40"?

Thanks,
Song=
