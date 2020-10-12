Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCB428EB59
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 05:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbgJODBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 23:01:03 -0400
Received: from mx0a-0039f301.pphosted.com ([148.163.133.242]:15528 "EHLO
        mx0a-0039f301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgJODBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:01:02 -0400
X-Greylist: delayed 11681 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 23:01:02 EDT
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09C9Mnp7026605;
        Mon, 12 Oct 2020 09:26:44 GMT
Received: from eur03-db5-obe.outbound.protection.outlook.com (mail-db5eur03lp2051.outbound.protection.outlook.com [104.47.10.51])
        by mx0a-0039f301.pphosted.com with ESMTP id 344kttg56j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 09:26:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezM5CFoeIo7MT8dzh7OhJfYgnaKmiLtohz+odDGbVhNQCpUzNWo/38FNakSh9xy6cUGOMGiuhbt3tqWqRJLOLuQCQfea77DtX9jzWikqxkKBSqYXIqR7oZD4j/ER8J0mGYeBpKHYLVomwl3RL9pG4tQnoi/fSdjBjG7fh26D/aEdfpf+bkltw03z6bdFeom4TCp3AVkVjLeIaNzTp91vHtqUD2dQdOeKon1nc11Q6Gfc/vE92Rce/eigpc0G2zlWkSYQ32OJuW5pkk6cF3jKNQ34YNn4Oo25FrWlNVAHdsxr8mPehaCYXnAKFN1nLtLiA1lW6MTKT/F7iJ8KxVRm6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQJcm3oiO3dzkXtJJe50gEgnrd2XJsFr0nBHWL06l6Q=;
 b=NLX+EWRhaP9vkOYtvoZGsC1uBMcBjGx7tOcNYlrRTboygEjfZKnIs98ZsKMAuz/5nAeryJvceQBy4uHJyf+kLO6uWRpTtxu998x89jXtZyzfqgWDUeAE9C+LjFhImkNXH+IQ4B48IJcsrjzQ8yFH67brZzhnd0LWxfbU8OArsuP6PVyqBovuW9EroSRQ7yPpm9EtfEsOk7ubikIgy1GYYUXT+OA1dUlM+XX4CYd2UojC9vyEn4uZNV8T9lici+5xii1axxBqYFscdLrfVYJGq5IrjhZvc1FifR95hIZ/citFp+AkBtsB5NQ7YRy0mf8aWgMMU0eIoCC+ULpyT/bivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQJcm3oiO3dzkXtJJe50gEgnrd2XJsFr0nBHWL06l6Q=;
 b=528zBvJAoLoaxZaygRp9Ynjgx7+cJHXvlmEb1RmDBF9sLmlpdOAQsc3lm5P2l8Ex3OXf9MdkMRqf8LvgU6qI/cGo1xi8urPT7W8aFO9JfxUr5UQnZz5CaC3IK74+5pWEQwIkXD1Jq+nvEA/OQcuUkuEkwz+6pv1/MF6Eeg1HUSkeZWKdMM+unIg1dgVeGHuTNGB+wEEw0WC8Fv+LUHGZwCTxk0b0nBgr/vrSVYd/aL5/8akgpaTqFY01WTJK3QMkUCGb1X4rATHDGtNCXF05ABbrbSjJ0wT3rDjk6MYFH38fjktETn8EO0ii3EuF/cOrVs5AFWKXazMV19LBBBqF2Q==
Received: from VI1PR03MB6400.eurprd03.prod.outlook.com (2603:10a6:800:17e::20)
 by VI1PR03MB6239.eurprd03.prod.outlook.com (2603:10a6:800:140::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 09:26:42 +0000
Received: from VI1PR03MB6400.eurprd03.prod.outlook.com
 ([fe80::71d4:858b:cc47:7da0]) by VI1PR03MB6400.eurprd03.prod.outlook.com
 ([fe80::71d4:858b:cc47:7da0%4]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 09:26:41 +0000
From:   Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
CC:     "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [PATCH] optee: remove address tag in check_mem_type()
Thread-Topic: [PATCH] optee: remove address tag in check_mem_type()
Thread-Index: AQHWoHnLmMBjWnaqfkeJ/6WMB4Ss4A==
Date:   Mon, 12 Oct 2020 09:26:41 +0000
Message-ID: <20201012092603.630703-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=epam.com;
x-originating-ip: [85.223.209.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5e2890f-cfcb-4d6c-8c4f-08d86e90edef
x-ms-traffictypediagnostic: VI1PR03MB6239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR03MB62396A016DE78131AFD9D9CCE6070@VI1PR03MB6239.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bu/GqHcupeOy0pFT2Wlq/5OHJXq7iIXH+G09fGVjArja+WzwoJeKSxfpqu4bonzmpCCMbMGqaHrI3XCV7LYkFNGx+X8gPO+025w6H5yPxhLpC4y88mxVC+5W6GjyppOu+7mVuHMuNpL2ISpDvSzSlGpvBhq0GklAzHuqhUnWQKi6l/KH5aBcaDEaELJJjdFy8QB88PE3jhN+6EU8d/pO4XJWn+mA/ueX0np5aVfUABnIN5E+1Ao2nuIvgv104Ecsn3Um3SG2Hgz0epjZ99QMnKpq6N+XvIsccrbr2D1j0qsmC3ySHl7RQ5Vb68VzhbcS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB6400.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(8936002)(6512007)(2616005)(36756003)(186003)(1076003)(107886003)(4744005)(6916009)(6506007)(71200400001)(55236004)(2906002)(86362001)(478600001)(76116006)(66556008)(66446008)(66946007)(6486002)(5660300002)(316002)(8676002)(91956017)(26005)(54906003)(4326008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EBy9QT/D9NqKVdjSc8gGUbKvQauEL9J5Jfw5KPm/YW0Wxb2DV6pdch7ZhVGiI+/rbSIokT2lbvX2BnEi9qYmefh6ZkhKL1UsKmd4/2GqTuAdrbBi2D652/jbbcDeHoqXJcRtIJc13CF+i10gL39ktLJf7Q1QrSKSJk2KorPvPpbM4k1UzKAanQfNCZ6E65z1YfE2nyY6Ob0x71vex6xQeST3tLZJPV8oihsl5mbDNvlLEKih6Tv5YsY4xJYmTmUsghXAyrh3ZKQMF+kW2ZjaOb23NsBxv1Qc3npeAUaMsSom1AZ5hLeo7U4gzfDz02fE5KHOsOzowTFTaZryzvj8+HFPzvCEEN4hfISae3aDyX8HKHzKom/miB9PGTcIS1cX4CnMUIkm3XMb7Glzwpn1+s5SWYYAtOv8rQ8kevImsguhOErZwSY6V5h005zkYCPUX4YChnpvL82Z1VctoE1Mrf4lseGQTfSaw0yPMXeOYJJpgpqkATNMKzc7xmvjXxXWxo3ZAExlvB2eyc6UKt9+x20B6r18DCK0Wl5Gr8GTU/4EbXbPgDSbrsfQyCxtsTHzW4/mAPu3fZJCFGYveyeAszr9sXATTNTTNjYLWc2EkVI/sVD76uurVNH+5jndcbUPvTOpFpBHonWXL8TUE0/BFQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB6400.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e2890f-cfcb-4d6c-8c4f-08d86e90edef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 09:26:41.7587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iglidLMcbvRkUNw5iiK2KgEYZZRvLlo56XyX3WkMSYCDRVordXpAegfGoC3Zcbc8fOdqWo5LyTTKh/nFMHsuIa0mg9SmeP9CGpA6rsqVO3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6239
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-12_03:2020-10-12,2020-10-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=781 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010120079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before passing 'start' to find_vma() we need to remove
tags from it to get sane results.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---
 drivers/tee/optee/call.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index a5afbe6dee68..61420395137b 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -562,6 +562,8 @@ static int check_mem_type(unsigned long start, size_t n=
um_pages)
 	struct mm_struct *mm =3D current->mm;
 	int rc;
=20
+	start =3D untagged_addr(start);
+
 	down_read(&mm->mmap_sem);
 	rc =3D __check_mem_type(find_vma(mm, start),
 			      start + num_pages * PAGE_SIZE);
--=20
2.27.0
