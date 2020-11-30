Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA98A2C8C92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgK3SUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:20:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49754 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727182AbgK3SUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:20:46 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUI9Vnu030975;
        Mon, 30 Nov 2020 10:19:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=2MvStMLYNnVY1p7D1PBCSjrcX3OubUzQWbhYgROAz5c=;
 b=pSfkaRWZOfA0DQ0S4/Z8ctZRBLlQoPav7PLDg+Zo918c6V9r3HwIfBkXNcL/nqT9hqRO
 pfFMiBp+yx1GOGE8k4gGZTWOM2ZTT/2l9t1FjCc2sn7lBDLnz+px3+l8u0Pj3dErI19M
 YB0oEF3I/Fv9YjETU0CNUSC6nkF+0nL90Dg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 354c7qdmj2-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 10:19:39 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 10:19:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJnXBZFAhf97Gtryc01t3i1G48TxiUDpnkCi9YzXyd8MGBMb2NknfI+oQQ5CZ7h4CwwzZIgBuYlPHuU23M/lV/2O1MY9GniP2cDaK3jN0sM62kwVN2b8wEDOGaby/DWgka0wAY6PWTZsRfinzTvJCGvxCn/1ujBLfziPENAiviDwrV3dzfC6qOQ3W37eX/OFxSYmKYkvJNwe658XPaN7rC/1R+x74lp8QwbYmn/2I8zS2hha84rnS12yQjWsov+LfGZ1X1ywG6nFynZCbxMU9+Z+dO9yyDEQBoMwcVAHleZsBE1MnU1J0nFlsNqYUH5oumyb9WJ5Helj4DVaGX7WaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bboNcCIP8l9KoPpYMuClyG7i50VdS0D5s4fV+y2Mxy8=;
 b=Kaq7Vfh50MnH3u7vGA40FsHlr0daxGJTz/ETuIJ2lEOhwA7xlJsYpFbwAzpx+rYCMV7YkGuayTjiS/LOLFlz9P9SUnKknjjGX7X3zNiI43NbeJwaxwdGf6vgB+XUvf918Fwu9DQNoPAZYRxUnWsYleqhnbFQvrbqf84sYAEY5LVFREkMUjtnChM00pdCNXd+T0zykewpWKGMuqRFyTuFH4+BxYVmBv++8hTdHmWWeJwE0x1ZdJE3AQi647VXXlh+VomIWrnfKmXE90W2WPAGOJxqLGxnf85mamRIOEw+VmwJ2Ia8ErfNnPAptXGic2RbbSgyUb/vx6boTGM0KgXl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bboNcCIP8l9KoPpYMuClyG7i50VdS0D5s4fV+y2Mxy8=;
 b=AQnVeAn9lfhGFZPlK0f5RDgPvkb6UFd52MCi9NpeukNQV+hE7PkeVU9C+UZw/Va0ElizgiTsZuvv3vlEZBj8kx/SUUVnx4WBR8i9jfXNd4PQ1YftNmTuKftuxk7FICLf7jhCfmYQqIjTF8ELIlI0T+rZTTLBBRBzrzzEETvlQwA=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2695.namprd15.prod.outlook.com (2603:10b6:a03:150::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Mon, 30 Nov
 2020 18:19:34 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::17e:aa61:eb50:290c%7]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 18:19:34 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Gao Xiang <hsiangkao@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        Yann Collet <yann.collet.73@gmail.com>,
        "Miao Xie" <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v2] lib/lz4: explicitly support in-place decompression
Thread-Topic: [PATCH v2] lib/lz4: explicitly support in-place decompression
Thread-Index: AQHWwHzK+6cDY3DPb02eZaHBCrUOYanhCbsA
Date:   Mon, 30 Nov 2020 18:19:34 +0000
Message-ID: <73E0BBBC-434D-4877-8E43-F995F8F4FE25@fb.com>
References: <20201121191024.2631523-1-hsiangkao@redhat.com>
 <20201122030749.2698994-1-hsiangkao@redhat.com>
In-Reply-To: <20201122030749.2698994-1-hsiangkao@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02612cd3-6820-43bf-d904-08d8955c7d5c
x-ms-traffictypediagnostic: BYAPR15MB2695:
x-microsoft-antispam-prvs: <BYAPR15MB26958553563DA17393A4B22EABF50@BYAPR15MB2695.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5EEeVEyIniBSeqIbAVHMOhweWsXhRnDpIgzHGO4cIKAQxjwsik79+jSj9cThsbbQmrIY5wivJSvE9T6tORf4AaTSdlfjD6WcvnjsFj7idZnzrRlglcBwwUf3j9c5nnTR6Cc/xJK+OK+ozqyAr2Kw/8FfIjy87YPDQ20D1lzNGjzdbiEdipI58IzF/2HXk8Xj+zK8cSOiwXQK+zAvmzALOQnB/5+MJ/Dh0CGfYwr4R4C4JaLbIe5pvwNpjOaxYcGmO0Xr+JIDN1MfDyqaqY4ermQ5Ts2zCyGCQOKKgDRNQGnM2/Ui97bbHTIUV6jCjbgHeWAbO5+GGx2lyH15dtIKDJiQYSDOnBIhjoLOBXg4B2fWsXLWHX227uWcyDpcYfxHOQj1iOGkkJOe1cBTY6gczw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(136003)(346002)(396003)(366004)(186003)(76116006)(26005)(316002)(66946007)(6486002)(71200400001)(2906002)(4326008)(8936002)(86362001)(83380400001)(478600001)(53546011)(966005)(6506007)(2616005)(8676002)(54906003)(66446008)(6512007)(66476007)(36756003)(5660300002)(6916009)(33656002)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n6x2iV22U1449WOTLxjikLXYtOucbui71n9BkJ9s5MPsh+XEZOjTKDPYZVlm?=
 =?us-ascii?Q?9/fQRyedKirTFdtoYeHIVcoflhUV6zsg/OJOnrP5V/nfqTfi+okmeMmOc5G3?=
 =?us-ascii?Q?1/TcZy8+YqZ7itA9VuTtK8E3ZJa8SjFguEZb0tRI/Miw31RVrvg6iwsLdAbv?=
 =?us-ascii?Q?iYODCeNSLehYderZ3zeiQ3YUScC9c/K/4RNiUpoeNZAf8WgKf5UEQEcWh5hC?=
 =?us-ascii?Q?Ryhj9+B1UQL03E1DZInETnr+199UtAtjW3SshiTBxnvfho+cWZM6spcaLYvF?=
 =?us-ascii?Q?4cD9Oqp8WniOLbgU8gtIWD6I0VZRLwfeSkv1ZeqZfIcIKAmjNxdFRUgHIRk6?=
 =?us-ascii?Q?SpXOH5PwusbO4hUBp2bwzHoc+5Q/Ebc5Ngh+549F3XFQwaQXtaOSqPev2zQn?=
 =?us-ascii?Q?PG4tmFka2/cL1PE98DcqUuipxtvcAe0S3RUD4UMADjcpNOE/GXaRfrED0M7C?=
 =?us-ascii?Q?Tq4QbhFD0nQJzqltw50/01bStx/YVe5VBCMTLcejCcG2kTpusvMzTXE1lVPo?=
 =?us-ascii?Q?rxhQFOwLE8RI1QA6ybJU9f2m1631ua+Uu2zcWowM9qlvHSi9ZkLexMZfHpl3?=
 =?us-ascii?Q?0Un+QpUqDeTk+C2kxKR47MqlCNNF34axA96bbbQ8V3TglpkwTUl6Auo8AY9y?=
 =?us-ascii?Q?3FNb31s2Pq9ZLmiMFXgmLd5mudHSrFROSoiuwDdyrtssGjB3dbGFq5Bk76VU?=
 =?us-ascii?Q?mGhO5lYpXvMtyV3LnBtbwOJ2+qR0XsMkvHpVEy0B8Q4CYl0kZLV7Q3cCRST3?=
 =?us-ascii?Q?ATdkM3czqhO02pZC0C1h/nezmWlo2qxGpIGC2OImBxTrdineMzYh3AMZOCZn?=
 =?us-ascii?Q?Z+A+j83CEBiD9Xw6j1QM1Vvc/6DpW+MrYOQexLFHiXr33TLhbBxIt5Sj2mcm?=
 =?us-ascii?Q?d75tHt7ov1/5UPsCOOS1QVUyEaLXmgzQKjz/OTegRCGEQRDKAPopQU/VBijz?=
 =?us-ascii?Q?aDfHdAuDk4QWFJi94b3YNALo0yNUfUhBV6SNdhkYlaVeGrFjihENX98uFWA5?=
 =?us-ascii?Q?dLyV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <015E2DE441B12D4EBE9695B0DEE0D951@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02612cd3-6820-43bf-d904-08d8955c7d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 18:19:34.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ge7/HDcC2BxGjocbZqIgrNZSenYVa85aytCEdeXztqHcCLkw9DIdenVCBwHlpazU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_06:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2020, at 7:07 PM, Gao Xiang <hsiangkao@redhat.com> wrote:
>=20
> LZ4 final literal copy could be overlapped when doing
> in-place decompression, so it's unsafe to just use memcpy()
> on an optimized memcpy approach but memmove() instead.
>=20
> Upstream LZ4 has updated this years ago [1] (and the impact
> is non-sensible [2] plus only a few bytes remain), this commit
> just synchronizes LZ4 upstream code to the kernel side as well.
>=20
> It can be observed as EROFS in-place decompression failure
> on specific files when X86_FEATURE_ERMS is unsupported,
> memcpy() optimization of commit 59daa706fbec ("x86, mem:
> Optimize memcpy by avoiding memory false dependece") will
> be enabled then.
>=20
> Currently most modern x86-CPUs support ERMS, these CPUs just
> use "rep movsb" approach so no problem at all. However, it can
> still be verified with forcely disabling ERMS feature...
>=20
> arch/x86/lib/memcpy_64.S:
>        ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
> -                     "jmp memcpy_erms", X86_FEATURE_ERMS
> +                     "jmp memcpy_orig", X86_FEATURE_ERMS
>=20
> We didn't observe any strange on arm64/arm/x86 platform before
> since most memcpy() would behave in an increasing address order
> ("copy upwards" [3]) and it's the correct order of in-place
> decompression but it really needs an update to memmove() for sure
> considering it's an undefined behavior according to the standard
> and some unique optimization already exists in the kernel.
>=20
> [1] https://github.com/lz4/lz4/commit/33cb8518ac385835cc17be9a770b27b40cd=
0e15b
> [2] https://github.com/lz4/lz4/pull/717#issuecomment-497818921
> [3] https://sourceware.org/bugzilla/show_bug.cgi?id=3D12518=20
> Cc: Yann Collet <yann.collet.73@gmail.com>
> Cc: Nick Terrell <terrelln@fb.com>
> Cc: Miao Xie <miaoxie@huawei.com>
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: Li Guifu <bluce.liguifu@huawei.com>
> Cc: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
> ---
> changes since v1:
> - refine commit message;
> - Cc more people.
>=20
> Hi Andrew,
>=20
> Could you kindly consider picking this patch up, although
> the impact is EROFS but it touchs in-kernel lz4 library
> anyway...
>=20
> Thanks,
> Gao Xiang
>=20
> lib/lz4/lz4_decompress.c | 6 +++++-
> lib/lz4/lz4defs.h        | 1 +
> 2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
> index 00cb0d0b73e1..8a7724a6ce2f 100644
> --- a/lib/lz4/lz4_decompress.c
> +++ b/lib/lz4/lz4_decompress.c
> @@ -263,7 +263,11 @@ static FORCE_INLINE int LZ4_decompress_generic(
> 				}
> 			}
>=20
> -			LZ4_memcpy(op, ip, length);
> +			/*
> +			 * supports overlapping memory regions; only matters
> +			 * for in-place decompression scenarios
> +			 */
> +			LZ4_memmove(op, ip, length);
> 			ip +=3D length;
> 			op +=3D length;
>=20
> diff --git a/lib/lz4/lz4defs.h b/lib/lz4/lz4defs.h
> index c91dd96ef629..673bd206aa98 100644
> --- a/lib/lz4/lz4defs.h
> +++ b/lib/lz4/lz4defs.h
> @@ -146,6 +146,7 @@ static FORCE_INLINE void LZ4_writeLE16(void *memPtr, =
U16 value)
>  * environments. This is needed when decompressing the Linux Kernel, for =
example.
>  */
> #define LZ4_memcpy(dst, src, size) __builtin_memcpy(dst, src, size)
> +#define LZ4_memmove(dst, src, size) __builtin_memmove(dst, src, size)
>=20
> static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
> {
> --=20
> 2.18.4
>=20

Looks good to me! You can add:

Reviewed-by: Nick Terrell <terrelln@fb.com>

