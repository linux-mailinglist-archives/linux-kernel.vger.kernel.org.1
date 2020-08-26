Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621BD253130
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 16:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHZOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 10:24:22 -0400
Received: from mail-co1nam11on2087.outbound.protection.outlook.com ([40.107.220.87]:20031
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbgHZOXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:23:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKT0DuWZVJrDwwD9ijG10RxLvR2CZTaAeivrM5k2YuAMB+A2axr0UHUvIhvD9jvYWN5TAA4msc31yijqyR5csOM2qY6BUL+zRlXaWlIfxhAlRg749mYU+mqgYgbQq7h/tUUyiCNKxlkCVObpfdhYz5hefSN/IQ2WAjg1lmGVqR5gRv9lxDKw8QZrnHt60PtbdrwT/QWtgPsXsMrvAjv1bYZJNi/rSPOPePQn+unNX9EqZDXuVSC2JJmrZNV7SKc4paetcH5kul6N3X03LHlGEdH5BNm3ATLdM7b2i6Z8oQhQYMq5ZEFMXocis+uwrciuHmr1Z4PYc+92qN5v7lOT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvsxsrD4+yaAfXt5bAJ1kJPuHeH79aRd6vAdtW4y5Qo=;
 b=ES6YiiUss7s1OME4enetq1xdtnsdVxo6WH8pTeudxUpHzF9H0dil/aameBJqL18p1srgTLasYIsGJDUFI3MyxGcZDQLdD7BFyngZfvWj5k+ByPLHciZU+hy4wrxU2fMUQKtG1VW9Wub5Zw/VQLMCrcQzldDdqHvbAFVtZvkENZMxwD8Nn8x8QJe1XphUUmRJInFSoZLXHiaNOXpTYFUxWH1ZOslAUjWQtiTYhV3qzWpgrP1uawz6PjHXNSpc7NvEv/uXlRW/hg2KgrAU7EPocoQ2D+G5KZe4ILU9m9qUGIRcByWzeKYOYmqw0A0vYl+Mx2Xsvmmg4hFZD8LqQkcBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvsxsrD4+yaAfXt5bAJ1kJPuHeH79aRd6vAdtW4y5Qo=;
 b=DEUlJ33l3IJNEizPTTB9cxs6sharKUySquuLDTBELI/vbNGcUmdLwQtTKH2T3hNrgMh7OlAfpMoSbhgj6ySqT5vdltPrPsijluP4Nj149d4pZwdsfWoT996OZF5LjTOOnmwvgkvr7MrbRKcxjRzKpUcrqQyUS+K2Gwb84kKo4/w=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Wed, 26 Aug
 2020 14:23:44 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::889d:3c2f:a794:67fb%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 14:23:44 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
CC:     "jroedel@suse.de" <jroedel@suse.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/amd: Do not force direct mapping when SME is
 active
Thread-Topic: [PATCH 1/2] iommu/amd: Do not force direct mapping when SME is
 active
Thread-Index: AQHWegTsBj7N+qef/0+36KKtrMBTq6lKc7sQ
Date:   Wed, 26 Aug 2020 14:23:44 +0000
Message-ID: <MN2PR12MB44887D5839767CFF49C24696F7540@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20200824105415.21000-1-joro@8bytes.org>
 <20200824105415.21000-2-joro@8bytes.org>
In-Reply-To: <20200824105415.21000-2-joro@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-26T14:20:54Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0ef889e4-247e-4615-9728-0000bae6c8b2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-26T14:23:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 08e3a570-2169-4890-9234-00006685c9d7
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.10.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c78fe514-f17a-40ff-10f3-08d849cba3d2
x-ms-traffictypediagnostic: MN2PR12MB4472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4472D42FF78461C44CA4A922F7540@MN2PR12MB4472.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xU+cMJwtd3vDeJ2EPliN6gbHPlGOdaZG3zvOLVjG4jQYeF0u4MQplIz4OJnq0rZCe1IEbsFIHh1FQ/fTgTEkLkwhEoHehB2FCOlmnh73iwJ19amei08C9iwadM/KhZzMcYyhigOlHBUf6lqoF5zcamFP/qGwCocnsaqLndw4HGtyxULlb0eKXzoQIa6KhUvs2WPpRIbKvBZM439AroicLvb89W6iBBHraFW0GHPpcLEdf0pTZnSZ8gnDm1JFjMVQH7lNHPwiMASOuwMXQz2KFKy+tNUXTQVjfk8kG/Ym0HTUHZJPIbk2Kn3AeZFH3CKCTwIv0+2YoACIZOyf6TC9DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(478600001)(55016002)(2906002)(6506007)(26005)(53546011)(6636002)(52536014)(76116006)(8936002)(316002)(71200400001)(86362001)(66946007)(33656002)(66446008)(54906003)(66476007)(110136005)(64756008)(83380400001)(8676002)(66556008)(5660300002)(4326008)(7696005)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UqghtZlKRi5ySrRS30Lb31rtGr6AaB5IUHHPFAaP4Aj7nHf2CTxTwzV3yktpUAO8brhPOsCHD4P7LAEDoCr6IJbkrUbezQVPBMjmAJrlAzHahOgxT0M6f4uwlrT78c4f1c8JEKYaOu8iG1yXJXFqLE7txJx/6/PoB+cEwM5wv+nOWUDKof52SX+EFpqOdACz48WmJJE3ZIh++z1RMVkLPzbTKMk9hDTaVVn6g28/vOBYAdS7kf+CZyyViqiH4UiUjPq/hujV1u1B7PkhMokMcVO5XhGeICqVZyz5YRDRh/2prAulGBplV2ylEAFD0tRr7VCvX2AxToouPo87pSXAML7aQ9pv1o6IM7vnMofjdw2QQ2hcZPCN0iMPOvLF0/plN22yPpA8hGPgs2GxledTjnvlMGZkf93/fIkzulf+HvTzzM1Knx8UX0V4YRBi2++WfvKlmcW0NZ7nPpKw2qNeI1dng9O8YUPaj/5Nb2Dk40QdveLv2Hw7xGXOvxHk1pGzel5/l3uWr3osQOVVqaybI+PR7XKmJj+iE1wXViiacRFw5ANuMPewWbnjLxZ5As78SEuTWyfLGSceWVGe5mctkgammvCkjiOWSRV2TtVvbOYoLZGrhbaUQp+mlTc7W8mP0Jb4QM8a3W0Ie0+i6/h8mg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c78fe514-f17a-40ff-10f3-08d849cba3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 14:23:44.7551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdhocXPeA7wM8mdLWj+2ZEKi9uzwCkS5WCekyW1NMMzkrzkATJVUuHHNuDKatV2wo26mJAq6ahGXd+S6zTbEKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

+ Felix, Christian

> -----Original Message-----
> From: Joerg Roedel <joro@8bytes.org>
> Sent: Monday, August 24, 2020 6:54 AM
> To: iommu@lists.linux-foundation.org
> Cc: Joerg Roedel <joro@8bytes.org>; jroedel@suse.de; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] iommu/amd: Do not force direct mapping when SME is
> active
>=20
> From: Joerg Roedel <jroedel@suse.de>
>=20
> Do not force devices supporting IOMMUv2 to be direct mapped when
> memory encryption is active. This might cause them to be unusable because
> their DMA mask does not include the encryption bit.
>=20
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/amd/iommu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ba9f3dbc5b94..77e4268e41cf 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2659,7 +2659,12 @@ static int amd_iommu_def_domain_type(struct
> device *dev)
>  	if (!dev_data)
>  		return 0;
>=20
> -	if (dev_data->iommu_v2)
> +	/*
> +	 * Do not identity map IOMMUv2 capable devices when memory
> encryption is
> +	 * active, because some of those devices (AMD GPUs) don't have the
> +	 * encryption bit in their DMA-mask and require remapping.
> +	 */

I think on the integrated GPUs in APUs I'd prefer to have the identity mapp=
ing over SME, but I guess this is fine because you have to explicitly enabl=
e SME and if you do that you know what you are getting into.

Alex

> +	if (!mem_encrypt_active() && dev_data->iommu_v2)
>  		return IOMMU_DOMAIN_IDENTITY;
>=20
>  	return 0;
> --
> 2.28.0
