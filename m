Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A02CE098
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgLCVYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:24:49 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63592 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbgLCVYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:24:49 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3L9d8q028035;
        Thu, 3 Dec 2020 13:23:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DDOhaZvekshC2owTdlmUySxPvMSnHCPEdFjj42VcxHk=;
 b=axX69/2ItMrE6b+orMpuECNKE2WrfdDFEnhkhh/tnKaLKeLwasIn6zYwyYB6lxe4dC8J
 v9XS3Mku4Mxt7zeKItzxoRXlUXj8wQojKDIMhzdpA0G5xdoQPAMuX3EA42ZYaVnZA91o
 x3jdCeAO+n/Bbw1rFswn1BxTVGyXKjHqg8o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 356ajcmb8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 13:23:56 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 13:23:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLfZmmoSewC9KQfSlaZpW3cAxNn4HEnKLq0nBe1mDOIbxg2SbAkyUee2C0NA0ulx8vWdkuP28P/72nEaxtNVlp5ywoKuW8/V+1wqnD+u8SY+melptKsjLiZ4ocOFpsLtdQXth4R5necWbA7+/BY9Qv3M1wYCbY33T6tdayqM/iv8aHJ7hWX0+iaBZ9SpuGPcPglvzoiaqQV+CevAN19tJaOPtx0xSBUEYrlEFKjuAuifb0Uo2VEO0Mhe1/tBdgAxUi0ZnwMhQxSaFq7GPbnszyLgTOotrLMpRqW/D/VfOYIsfoBnDSwe28udewPEfe0KJ62oFfgdV4ZSlEau6sWA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDOhaZvekshC2owTdlmUySxPvMSnHCPEdFjj42VcxHk=;
 b=YiSb3fheE0x4wxeBgfMa+nZEf7QFXO0NKW2kmfXAM9PVM7BxpwHximgJjTnUEbnIIa53khYoi4bwg26WIfiF0cn/Z1xhRpWQGa0CdmCvX22rOnlhS68guvBANUCUPgfHjJNmJMsmu3nJQOCjYkZS+FWL1BdUiOpDkIG6Q84tR6cVFP7Biid2WgTcSse0gFyUnUtsO6Ip+MJlkPCF5iqNyTtMQTDDAepO70xs/unhbPiHpTqEvQLiNhVBjdNdsMn5uSAcOMSOaHmHMlcMZYVUYAQH8wz6/gIYWNWOZOoBr4xqsKg3Vc9QoGjiJnR4xQDzhemUpitQuUvxybowhrDshQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDOhaZvekshC2owTdlmUySxPvMSnHCPEdFjj42VcxHk=;
 b=XkaSJzUkvi0W9TMhYums/cGWyK+vKGLZla4aATtd59LuSAUBOTmU44ArldNpZManB/FkhpKH3D+7sUXIhpYfJsjx4cr9FqDCySLyB0xguxtB9FQiHFFNMOqDPuwYXs0VRVwKwv9HeKPeQa68kFjeikm7HGn31Jbio65bOAgxIS0=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2455.namprd15.prod.outlook.com (2603:10b6:a02:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Thu, 3 Dec
 2020 21:23:53 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3611.034; Thu, 3 Dec 2020
 21:23:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 02/25] bpf: Add size arg to build_id_parse function
Thread-Topic: [PATCH 02/25] bpf: Add size arg to build_id_parse function
Thread-Index: AQHWxBW1sPsiV0KShkyrtdr/WYFXPKnl7QWA
Date:   Thu, 3 Dec 2020 21:23:52 +0000
Message-ID: <EFD4A5C8-19AB-460A-B784-001F3809F71A@fb.com>
References: <20201126170026.2619053-1-jolsa@kernel.org>
 <20201126170026.2619053-3-jolsa@kernel.org>
In-Reply-To: <20201126170026.2619053-3-jolsa@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:438f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fe3bd8e-870d-4d95-5f06-08d897d1bbe3
x-ms-traffictypediagnostic: BYAPR15MB2455:
x-microsoft-antispam-prvs: <BYAPR15MB245572643350ACC5197DDEEAB3F20@BYAPR15MB2455.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjUNWmUZRHuRrmjJ+lwfvXG10Wsc6tLDwJ20pV+wUmOhJq5Dt8EeXyMISpfxgoo801xP0pos6rfvsmobacF8qggMKo8kjtUFzzvRkTo0cT0fRRxIFzkybOabiGCYAs/tiOwEgmHpko/xJVwLA+sRvgIJ412fJSgW4FmkNixaPaYJ9T2Lm/am36ccM9gyeVdCenH4sY+iPEI6O2U/Cm8r0dBlPCpE3CM9oqe20gaCWHpiqOa6eymxdE1pKUgR0FrXkpJAgPxIii1xiE66x/0niyoYC2b5c19b0QChsJ5D52RrxrUMaZM1idbE+HKVQrUGUjt2plvMmxARUi+gLFysHDN2KsfmxlEcG1nl6/h/X1L/bWENhPxo4pS9iDzzglkq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(376002)(346002)(66946007)(86362001)(6486002)(2616005)(7416002)(54906003)(478600001)(8676002)(186003)(36756003)(83380400001)(316002)(53546011)(6916009)(6506007)(64756008)(5660300002)(66446008)(66556008)(6512007)(66476007)(4326008)(71200400001)(91956017)(2906002)(76116006)(33656002)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?b00LNUD42TP0WZHycdftvvqqav6uzNFY9HGZByUavqNfGqWeNAHXFolMh1fq?=
 =?us-ascii?Q?RyKhxZcEu6JTX7+8voUMcNXYIzJIV4EA+R7WpMDD9A2bqU6umBl3du4txDfK?=
 =?us-ascii?Q?4bSizclILtaCxogJiYp73go4Md3luV1sfSAwchmd0Dh5tZQQUqYrp1Ux3PjB?=
 =?us-ascii?Q?p6WNud/+9sTFVefTJ0YeWji8fTl28dsRQI3pVAiXOG0osL3Chc0VTKNoA+GL?=
 =?us-ascii?Q?0Dx9/QhWbokL0JiIsbQ/PKAheIwlyPP0CnVVC6rJJnP26hYva2ZFist6Dqls?=
 =?us-ascii?Q?qMM84b9Zv5y2p3Jg6YvEozG9tDrRJzdLo73MSwLiiGYaDZ4IGp3k2PuLv8HB?=
 =?us-ascii?Q?VDYCvWQybNGMFc+wVaemwUD9yAPHFh6ZDiuFH3e+VMU1UR9J6OKLljKhEVVZ?=
 =?us-ascii?Q?X5ahJUIjb4EgPxiPIyY1Z0d24i1VOxO6crvOwUFBuLBABuHBYXJ1FiGRhdql?=
 =?us-ascii?Q?CL/UnxT+u2uBxQxruzDkOW3a5j3dqPNikErvHuuTlBcmWOUzcKVQB3+Z4/2v?=
 =?us-ascii?Q?ebT+ks9iwtn+qiL+7zvD+GRTPumWjYwv6BoWqmPtWVqfqvC8n617zC1hCiLy?=
 =?us-ascii?Q?pZeIbWw0lP1DZT8ozY3ZpTNUyLyPvhApQHBZsB1m/0I6a6Xq5BxSaYjxFcdw?=
 =?us-ascii?Q?Xyxc8yYEEIYZimOI53DuXKSIwWSUBEYaZxt5Y72EqbuwUdtqse1Be2wkAmi6?=
 =?us-ascii?Q?TGdMoGjDheMpmJpjk8EEKQJclkRWIfhIF6rVyKbhgLl1KQJj1tpSrKF3ctqc?=
 =?us-ascii?Q?PKr+vMD+eF5HOo9WhyDRPQNNIVV/dkj4XY3pBO6sdo5sfn/pvVwzXh4gzXNI?=
 =?us-ascii?Q?dOJFZkbkBkcV+lF3+7WbTybAXmmwvQ4veSjUNfMgrcvYEusDeUnnDiiTYFLX?=
 =?us-ascii?Q?4ivAjwatzYHRG8tMCiMfxT36x6C8KbGR2oc8XxOoqqBL48pYiukDqFIR6+NZ?=
 =?us-ascii?Q?bfjUbFgCf1lOnM7Ff2FlQN9+5kVzo9rRDstm7PUcsxyxN9S5anuQM4MXOC7P?=
 =?us-ascii?Q?Nt/tg7+BqY28hWIDDmmIq5iaKAMMYbgxLC94KAjKZ4BUTUg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <12EE284FCD6666409B3D86D4934A12F7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe3bd8e-870d-4d95-5f06-08d897d1bbe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 21:23:52.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QGd/3jW90sXiUym1jWDSmk43zas/+PcXT5AofcAbsPy4p95cTLutGfp+9e9eof0NGePtQr7Qra4wZqaW8VQsBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2455
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_12:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 26, 2020, at 9:00 AM, Jiri Olsa <jolsa@kernel.org> wrote:
>=20
> It's possible to have other build id types (other than default SHA1).
> Currently there's also ld support for MD5 build id.
>=20
> Adding size argument to build_id_parse function, that returns (if defined=
)
> size of the parsed build id, so we can recognize the build id type.
>=20
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Sorry for the late response. The patch looks good to me.=20

Acked-by: Song Liu <songliubraving@fb.com>

with one nitpick below.=20

> ---
> include/linux/buildid.h |  3 ++-
> kernel/bpf/stackmap.c   |  2 +-
> lib/buildid.c           | 29 +++++++++++++++++++++--------
> 3 files changed, 24 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/linux/buildid.h b/include/linux/buildid.h
> index 3be5b49719f1..72639d433873 100644
> --- a/include/linux/buildid.h
> +++ b/include/linux/buildid.h
> @@ -6,6 +6,7 @@
>=20
> #define BUILD_ID_SIZE 20

Since we are handling build-id with different sizes, how about we=20
rename this as BUILD_ID_SIZE_MAX or BUILD_ID_SIZE_DEFAULT?=20

>=20
> -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> +		   __u32 *size);
>=20
> #endif
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 7df08f8af5a1..a05fac2cbb05 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -199,7 +199,7 @@ static void stack_map_get_build_id_offset(struct bpf_=
stack_build_id *id_offs,
>=20
> 	for (i =3D 0; i < trace_nr; i++) {
> 		vma =3D find_vma(current->mm, ips[i]);
> -		if (!vma || build_id_parse(vma, id_offs[i].build_id)) {
> +		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
> 			/* per entry fall back to ips */
> 			id_offs[i].status =3D BPF_STACK_BUILD_ID_IP;
> 			id_offs[i].ip =3D ips[i];
> diff --git a/lib/buildid.c b/lib/buildid.c
> index e8d5feb7ef20..dbe1b7e247f3 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -12,6 +12,7 @@
>  */
> static inline int parse_build_id(void *page_addr,
> 				 unsigned char *build_id,
> +				 __u32 *size,
> 				 void *note_start,
> 				 Elf32_Word note_size)
> {
> @@ -38,6 +39,8 @@ static inline int parse_build_id(void *page_addr,
> 			       nhdr->n_descsz);
> 			memset(build_id + nhdr->n_descsz, 0,
> 			       BUILD_ID_SIZE - nhdr->n_descsz);
> +			if (size)
> +				*size =3D nhdr->n_descsz;
> 			return 0;
> 		}
> 		new_offs =3D note_offs + sizeof(Elf32_Nhdr) +
> @@ -50,7 +53,8 @@ static inline int parse_build_id(void *page_addr,
> }
>=20
> /* Parse build ID from 32-bit ELF */
> -static int get_build_id_32(void *page_addr, unsigned char *build_id)
> +static int get_build_id_32(void *page_addr, unsigned char *build_id,
> +			   __u32 *size)
> {
> 	Elf32_Ehdr *ehdr =3D (Elf32_Ehdr *)page_addr;
> 	Elf32_Phdr *phdr;
> @@ -65,7 +69,7 @@ static int get_build_id_32(void *page_addr, unsigned ch=
ar *build_id)
>=20
> 	for (i =3D 0; i < ehdr->e_phnum; ++i) {
> 		if (phdr[i].p_type =3D=3D PT_NOTE &&
> -		    !parse_build_id(page_addr, build_id,
> +		    !parse_build_id(page_addr, build_id, size,
> 				    page_addr + phdr[i].p_offset,
> 				    phdr[i].p_filesz))
> 			return 0;
> @@ -74,7 +78,8 @@ static int get_build_id_32(void *page_addr, unsigned ch=
ar *build_id)
> }
>=20
> /* Parse build ID from 64-bit ELF */
> -static int get_build_id_64(void *page_addr, unsigned char *build_id)
> +static int get_build_id_64(void *page_addr, unsigned char *build_id,
> +			   __u32 *size)
> {
> 	Elf64_Ehdr *ehdr =3D (Elf64_Ehdr *)page_addr;
> 	Elf64_Phdr *phdr;
> @@ -89,7 +94,7 @@ static int get_build_id_64(void *page_addr, unsigned ch=
ar *build_id)
>=20
> 	for (i =3D 0; i < ehdr->e_phnum; ++i) {
> 		if (phdr[i].p_type =3D=3D PT_NOTE &&
> -		    !parse_build_id(page_addr, build_id,
> +		    !parse_build_id(page_addr, build_id, size,
> 				    page_addr + phdr[i].p_offset,
> 				    phdr[i].p_filesz))
> 			return 0;
> @@ -97,8 +102,16 @@ static int get_build_id_64(void *page_addr, unsigned =
char *build_id)
> 	return -EINVAL;
> }
>=20
> -/* Parse build ID of ELF file mapped to vma */
> -int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id)
> +/*
> + * Parse build ID of ELF file mapped to vma
> + * @vma:      vma object
> + * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
> + * @size:     returns actual build id size in case of success
> + *
> + * Returns 0 on success, otherwise error (< 0).
> + */
> +int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
> +		   __u32 *size)
> {
> 	Elf32_Ehdr *ehdr;
> 	struct page *page;
> @@ -126,9 +139,9 @@ int build_id_parse(struct vm_area_struct *vma, unsign=
ed char *build_id)
> 		goto out;
>=20
> 	if (ehdr->e_ident[EI_CLASS] =3D=3D ELFCLASS32)
> -		ret =3D get_build_id_32(page_addr, build_id);
> +		ret =3D get_build_id_32(page_addr, build_id, size);
> 	else if (ehdr->e_ident[EI_CLASS] =3D=3D ELFCLASS64)
> -		ret =3D get_build_id_64(page_addr, build_id);
> +		ret =3D get_build_id_64(page_addr, build_id, size);
> out:
> 	kunmap_atomic(page_addr);
> 	put_page(page);
> --=20
> 2.26.2
>=20

