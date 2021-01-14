Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1232F657B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbhANQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:10:27 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:19212 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbhANQK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:10:26 -0500
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EG8AiN009827;
        Thu, 14 Jan 2021 16:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=nbTSe2TPew7yYRQRa73fby2BSBCCEXeRRh0nfroLVm4=;
 b=IzG58anymel4U8D0YcqFf04JItZzD3Rbcb3hmljwjvdQZA5xAdITJ/YLzJNbUoKlvmha
 /ZFCdr9cmykUvVXSsbinCCzzd5FZTkZgP1/kJS+TP/4ejuk4cTgwnEoz+eZbN1GOICBQ
 dK5K2Pl3GSTL9x93lHu8RVzMgoRWmQHZwT8pvXvdyQ+4P9eW8VaNpJltKBR9z9uZxe8A
 jBdDKMdwHnqSoKFxohs/0QB899kSJwHucioeFa4J+I5N62kJ26Wy69AblBOdjoBkesFs
 4c/2YxOnjsY85f+wRUOsCBGiXAVnlkBTT2looMcwuyQ1FNp29Ev42YV1i8hygYE+wbuC HA== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 361fvrapn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 16:09:30 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id C2DB3C4;
        Thu, 14 Jan 2021 16:09:29 +0000 (UTC)
Received: from G9W8672.americas.hpqcorp.net (16.220.49.31) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 Jan 2021 16:09:29 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8672.americas.hpqcorp.net (2002:10dc:311f::10dc:311f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Thu, 14 Jan 2021 16:09:28 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Thu, 14 Jan 2021 16:09:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRCdrjxJwAI/mBwbNjLZckgtYlk2HrafMJpmWjfmTa0Bi8ibKFXYgwiiLRqDcl/rcYfzKeUy0XE5tPCP+HWXboddOusRD3dLI5ZQlsdhKS6NgMiU+v4PUBBjulKTHnRllmGr62F0fUb3PUdMX5JyeUqSdUlIxuOQepXoRuJBhZrf9e/2vhNCs/yAyb4p0h1STmSCH3Rz34EkM7Qdwo90gV35jpDG1SAUbBfOFVF0H8Mm/MbU7ZETXg1csY4gPrOgifUADt8wEKLyWFkVEHrtSXTdfB3ine3Yk/9rkgDdbf2NUQbcPnmO+JUtIWT+l+oncBw9s5NSzqYg5qFXYejLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbTSe2TPew7yYRQRa73fby2BSBCCEXeRRh0nfroLVm4=;
 b=Uq4E8oFz0g9h3duxyGAbeCHsD6SZc/2bbkiyf9ZlvCoTwPKw6y9g2P2CNtb8ijAO5jJddQ8tfGpAbzeBJ6Eh4AH/6vX6cXGU1sssEJDMeWeYcHvvM3VvQ1AE1vkInpe7u2UjE/mRdkZX1I/5Ma7chF4MZel6/VMFe7yYgO50XS6obxZc1k3BBKcSLVruAsSEtuWbBnT5Jnlmy+CcvZuvinGHXuz74J5DBs44RrbNbiQ8EXrWT8ALu/H4UIiqAdCHTJ1LIay9edXtN79xKHbD81PVqCjJvbzJGAg1L5gsxcbVRzSQSNg4NEnGqvUU3mouihDPluKY2vrGdIF0jcdZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:742b::18) by AT5PR8401MB0770.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7423::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 16:09:26 +0000
Received: from AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5050:a788:3fd6:f2cf]) by AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::5050:a788:3fd6:f2cf%11]) with mapi id 15.20.3742.012; Thu, 14 Jan
 2021 16:09:26 +0000
From:   "Ernst, Justin" <justin.ernst@hpe.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@suse.de>,
        "Cezary Rojewski" <cezary.rojewski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Travis, Mike" <mike.travis@hpe.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/10] ABI: sysfs-firmware-sgi_uv
Thread-Topic: [PATCH 04/10] ABI: sysfs-firmware-sgi_uv
Thread-Index: AQHW6kprtbExhvpb20yqDp4UIy1lYKonRpJQ
Date:   Thu, 14 Jan 2021 16:09:26 +0000
Message-ID: <AT5PR8401MB1300C8F431AF7BA93617272287A80@AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
 <452854f2dd0625b9fee33b9f5e29343d6149781e.1610610444.git.mchehab+huawei@kernel.org>
In-Reply-To: <452854f2dd0625b9fee33b9f5e29343d6149781e.1610610444.git.mchehab+huawei@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [165.225.61.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4497206a-287d-4464-8b95-08d8b8a6c43e
x-ms-traffictypediagnostic: AT5PR8401MB0770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AT5PR8401MB07709B9BFE5592EE7C8F854487A80@AT5PR8401MB0770.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WiYcf5ANWmucQ39u9FJsuwlLw7sNEVXE+SBPsvLKY+bBhv78JU+yx29XIOAhpGFBsVD5YRteS2N5nvH565YR+5IzBN3SPFiGJhtAHUDyxtfcA89xCQJZVKfF83OCHKDAIo1gSYh9iGXGvihUYy+GV70AENJi0O3hD3zrT0cV5aEydmEAPeFGpIuLQd08WD+Ghb8n/c0Y+v5e/2TYUs9f0t5GEBETH9TLNhMU63P1PyPMSNI2WEEEQCOtrZcVGWTQ1RIl66Hi8W9GcmFxRe5yHgqdSnBLFtZVBHyOzsQ0NVbhWT7P/5uqxba0VZuWydV3SgwBIlQ+Hv/AmQsZsoTcWWS0nwaNsGbrCMPjgWlJ4XdyWSCEYuiAykT2iapsCZN1szN7xEL1nIBBeLVXvlrVOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39860400002)(366004)(346002)(2906002)(53546011)(55236004)(66556008)(83380400001)(76116006)(86362001)(64756008)(8676002)(8936002)(6506007)(478600001)(4326008)(26005)(33656002)(71200400001)(9686003)(55016002)(110136005)(66946007)(54906003)(66476007)(5660300002)(186003)(7696005)(316002)(52536014)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?raD4ySSxyzrRs9+u6lG0GI4ZabNp7Pqxm5+HqiLm+QHf0cAewuxqH3GpMqaP?=
 =?us-ascii?Q?db2hcH2NfwhFmcniN+URRTCd48Y0a7MbeeAhZAZuMPQUrNx6r9H+j3vy+/P3?=
 =?us-ascii?Q?IZmeEn32/UcXTMKKWudA71SQSgsSjGo+ex73ioKmDXheMeOlc+VjAxL458sR?=
 =?us-ascii?Q?PxO9Uyl5+xDIZbA7yf+lCUqVJheaNUfyumO1PzBNHfTY+2O8hTtj//zRNC4i?=
 =?us-ascii?Q?p4SkXqwu/lsmDsWbelpaZqjMrLk/uVN3Lyt/hz21f6M54pOCVeCA/mxyrGma?=
 =?us-ascii?Q?gsZlxWIJs068xNn2TK9hQUSnZD818YzbWig5eFI2zAJiuouLQSkwNrSbIcy/?=
 =?us-ascii?Q?hO2kcS0zH4DUjoEJ0qPx0WZzhZlM32wqpR/mPxQETTevYe9h6XUK9CYqB6I7?=
 =?us-ascii?Q?A0b9pNiSXM+ZyfCCqH2t8m+wOaLxz+lWI+1bRCrgKmlqaoDshFk284SJrkcZ?=
 =?us-ascii?Q?F6bl7PQC8F/VJpu0fTa+aSMTrrnE9Eh/Oo9/80qYVDkJt1hvuj/wblK8olz8?=
 =?us-ascii?Q?/pXGr/MvdnIq70uC45NwLCJZS+3g6q8C63PRGXcujyMwiBmerzeihvmGpB8n?=
 =?us-ascii?Q?QEiY0lFZrJei+5vpLz1+Pc6JqLpgVIgIvBrTZSIypCmMhLuddK4lj+MkLevP?=
 =?us-ascii?Q?i2aN2sBaxbljeaheU174VYEVS2icPJz/jeItrRRtA/4Ub4DqzNqtuh1uPILa?=
 =?us-ascii?Q?W85E75FnKSPL5Il4CkEzdM9XDIpX1ZBvBdDpo6PRASHPL11V96Oq1SU90Nsy?=
 =?us-ascii?Q?7LZTUqPtFQfMs/2DfohRQ3G6pyx6fIPHfvW0/QuIsnZm3ttgZFaf1Jm2SJpD?=
 =?us-ascii?Q?fYdjU9ARcz69pp5oC4enCgCg2zyyjrOmi1MJu0+mm8yIDLif8oeAKguUnDbA?=
 =?us-ascii?Q?gp/r5+Ny15olBY17HJPJsVlp7gE9o7rBW4L3pz0KOg1TH8gTmFAqDEu8KQ7e?=
 =?us-ascii?Q?dr5V9fxRmcxICkYhZUcWdRli8k+qCaZIaFvlPx62CtE=3D?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AT5PR8401MB1300.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4497206a-287d-4464-8b95-08d8b8a6c43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 16:09:26.7711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJxBwT2i6A10oeUDU3/UmZjgCUMzz424QgOZrJXt8TvJ+7laJJ+N3Ggs56GKmVXhdC86Dg7oRm6AMICTcxsyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB0770
X-OriginatorOrg: hpe.com
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_05:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1011 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101140091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mauro Carvalho Chehab [mailto:mchehab@kernel.org] On Behalf Of Maur=
o Carvalho Chehab
> Sent: Thursday, January 14, 2021 1:54 AM
> Subject: [PATCH 04/10] ABI: sysfs-firmware-sgi_uv
>=20
> Add a missing blank line required to identify a literal block,
> fixing this warning:
>=20
> 	.../Documentation/ABI/testing/sysfs-firmware-sgi_uv:2: WARNING: Unexpect=
ed indentation.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks for finding and fixing this. I was able to replicate the warning and=
 confirm the fix.

Reviewed-by: Justin Ernst <justin.ernst@hpe.com>

> ---
>  Documentation/ABI/testing/sysfs-firmware-sgi_uv | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-firmware-sgi_uv b/Documentat=
ion/ABI/testing/sysfs-
> firmware-sgi_uv
> index 637c668cbe45..b0f79a1d14b3 100644
> --- a/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> +++ b/Documentation/ABI/testing/sysfs-firmware-sgi_uv
> @@ -39,6 +39,7 @@ Description:
>=20
>  		The uv_type entry contains the hub revision number.
>  		This value can be used to identify the UV system version::
> +
>  			"0.*" =3D Hubless UV ('*' is subtype)
>=20
>  			"3.0" =3D UV2
> --
> 2.29.2

