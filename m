Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2592150B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 03:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGFBCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 21:02:17 -0400
Received: from mga04.intel.com ([192.55.52.120]:12781 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgGFBCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:02:16 -0400
IronPort-SDR: bGNtauTk0f6WF3wBBT4Y2xmdtGU9ue4lv+nq1R7lIloHGOIrfDXySO6FjcPeShsE2QTIU4a9Kp
 ItDbFrYe78NQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="144847064"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="144847064"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 18:02:14 -0700
IronPort-SDR: 7uAY7Uu1oFCfebGhvmbVfr9qHkd6jYvGfWIZwxPB8yVy30vlZPqqeBM0qxuEK+MhWGxRmCB4Xx
 Fz5WwGHT76Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="305108210"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2020 18:02:13 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 18:02:13 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 18:02:12 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 18:02:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 5 Jul 2020 18:02:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgcRzgvxUrP3tOwtVoSiON6FOo9IBYLNaKqgqQhsWd6CWh0BEDqa96mSygYNm+pDnrSNMKFnoI6NnQl3iy5/17w7ybqLdpmGmneCjMpl3hMgegE+wIB6+MmiGtn9b7jVnGesWQ8w7eYNmXdsc9UrTJ8Jde61DQ/v5bRTskFExEf5gQPEQ9KL8GXbE6dmiskpPm7WjoyDaXm1SqOCpNcy7u/6h4W4nmku3M7u6i0bQwxGAkW4tPCLNNaBsfvXk1gG3MBNjYOdaju2tDOSfNFwDdNPAdBwwwPS+fETGFzsTiQNt8VCnW5yWqRh/Pw+zbuhtVc+vdwSuEX4U+uLYBW6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rkIis7FUtpsDUIZY9FXZcEMuf+sZjhyYYEawKTPvu8=;
 b=jmpWIvvRAQYFz3+5UVcxrq9AN6NITLkLOqsF0qmrvi6f3G2Csyiv9tczowu6YCMT4/nCwLNZ9qm4xXIYsqMNFwqWinXR9GqTNrqmYXBVeY5UnoHAJ9gyyp1pBRd9iBUr6UJQi1AW1cdVFyhTDUvbfEy79RZyV8GFSmJIFg0xWfKEQ+c9cjPcRlV1qwo9+r2SVM691owHrBtgdLJp3NcAcxvkNSSdUKdZEQcL1kxtjUzk/uKTGWeM06VB6N7NPXTAZaJTOiqCDUBODq9bMPcKeIaGTGR7EdnmBlx17maTtWGDJZjkZHF1k7Im8fvMuxVrh7+MaogI+Df7S0uFNECB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rkIis7FUtpsDUIZY9FXZcEMuf+sZjhyYYEawKTPvu8=;
 b=Kz93ZYieVvWirtFp6QB1nZjCcVsXg9CVkANBwOxM6lS/7rdfcwjc9jtOSzSy/4DrLB2R74PJPG0Gk3FoJiUwdBm9aVCKUUeM1fCctRQIlm4nkDmk3o1KZ+Mroxt/JFfLr6eH9HIA0P5N3NW3WDAvzAYROjqlsqia2QwUWBaGp/Y=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1871.namprd11.prod.outlook.com (2603:10b6:300:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 01:02:10 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 01:02:10 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] iommu/vt-d: Refactor device_to_iommu() helper
Thread-Topic: [PATCH v2 1/4] iommu/vt-d: Refactor device_to_iommu() helper
Thread-Index: AQHWUyysp3HLdd4MhUi/PlpkgbqfZ6j5u6IA
Date:   Mon, 6 Jul 2020 01:02:10 +0000
Message-ID: <MWHPR11MB1645048FDB164069D2D970038C690@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
 <20200706002535.9381-2-baolu.lu@linux.intel.com>
In-Reply-To: <20200706002535.9381-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a57ab12-4cc7-45d7-7b79-08d821483653
x-ms-traffictypediagnostic: MWHPR11MB1871:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1871DF20A7FAFD9D7BBE872C8C690@MWHPR11MB1871.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gGcKNBBt9xskmdDvZodIEYPRd9RbG7ysu5wjehsWMYQG0/On3XGMzM0/O+1FvHtzaE5LLDFwyXAb8W8PaVWyepxfoS1Mmead105cFvMWq6IRPS8ALnqIlBff/O3HtLP7b9ikK9HYnghuYhOmSt6YlOCgvmfCnTjjwb446DLQKj8TIaztZjk/RSQ0N9YC1FFY+7qfrV6bNw59w9B4PnDRwfTgAhG31EEk5iHstcuTPCotDjyn7SFJ0XbsvPNawJTJnzhALU+Tx0O8/Sy2zW+Cw3316UidCx709gr9wmUM+nVwwTQ/XCTJD9tTkweHpLb8MISi/s9iWg4uO1Q+dlGlLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(52536014)(6506007)(7696005)(66446008)(64756008)(66556008)(110136005)(8676002)(5660300002)(66946007)(66476007)(4326008)(54906003)(76116006)(86362001)(316002)(26005)(478600001)(9686003)(71200400001)(186003)(8936002)(55016002)(83380400001)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MA+938yfIcGquUJSMTMjepcOVxV1mF9XwfhsdPrOT9Fv87+p3UkUEpavpWuZVHVtwLSBYsL6/SBzT8Au7DcqDIhbZ1mmbR8LPgshAT3SiV2yiteinzgy9IP7NLelFXkfwy2kZTTUSZOrVq4vghjk/PLL8OI3+L7tEeAdiDqZjGj6cY0Ma/M2eNLQ1J3eLvwiv2qfjNQ8A9VG/YW7ZpnNzK2PevG5o25btpxcRxyd/6toResg6/h382LzYpiVCAmDsM7BGPJpaCE9sg9N+fol6jtldoJIPdXlzBNzDTfDi2kNCuzipjs3z9qxUaZS3FKGK15Ml69J7hjH2WowV6pcN15mGdBMSkpbd1+Ek6fBC3ytZAif1c/lQ9y2Fyg2JyeqThlA034gR6l6qRVkl7h9MQ7BFnnoHgWoPBRYI75Jklp9BGxPHVgGjCFC3H0E6qXJAySlI1zlzjx7cqFsxOTHaoldXuTMeB+Im6mhI4EvJU/Npejiv69iaug4z9cTSV0I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a57ab12-4cc7-45d7-7b79-08d821483653
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 01:02:10.3988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heBDTJdFPVJquaP9RsebX8ASWWH3VXEzEuXK6ZPRvqZwpYRI2WcuxiCN1vQp5jQygpszeddgydK8fS+6NV9xag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1871
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, July 6, 2020 8:26 AM
>=20
> It is refactored in two ways:
>=20
> - Make it global so that it could be used in other files.
>=20
> - Make bus/devfn optional so that callers could ignore these two returned
> values when they only want to get the coresponding iommu pointer.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 55 +++++++++++--------------------------
>  drivers/iommu/intel/svm.c   |  8 +++---
>  include/linux/intel-iommu.h |  3 +-
>  3 files changed, 21 insertions(+), 45 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d759e7234e98..de17952ed133 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -778,16 +778,16 @@ is_downstream_to_pci_bridge(struct device *dev,
> struct device *bridge)
>  	return false;
>  }
>=20
> -static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, =
u8
> *devfn)
> +struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8
> *devfn)
>  {
>  	struct dmar_drhd_unit *drhd =3D NULL;
> +	struct pci_dev *pdev =3D NULL;
>  	struct intel_iommu *iommu;
>  	struct device *tmp;
> -	struct pci_dev *pdev =3D NULL;
>  	u16 segment =3D 0;
>  	int i;
>=20
> -	if (iommu_dummy(dev))
> +	if (!dev || iommu_dummy(dev))
>  		return NULL;
>=20
>  	if (dev_is_pci(dev)) {
> @@ -818,8 +818,10 @@ static struct intel_iommu *device_to_iommu(struct
> device *dev, u8 *bus, u8 *devf
>  				if (pdev && pdev->is_virtfn)
>  					goto got_pdev;
>=20
> -				*bus =3D drhd->devices[i].bus;
> -				*devfn =3D drhd->devices[i].devfn;
> +				if (bus && devfn) {
> +					*bus =3D drhd->devices[i].bus;
> +					*devfn =3D drhd->devices[i].devfn;
> +				}
>  				goto out;
>  			}
>=20
> @@ -829,8 +831,10 @@ static struct intel_iommu *device_to_iommu(struct
> device *dev, u8 *bus, u8 *devf
>=20
>  		if (pdev && drhd->include_all) {
>  		got_pdev:
> -			*bus =3D pdev->bus->number;
> -			*devfn =3D pdev->devfn;
> +			if (bus && devfn) {
> +				*bus =3D pdev->bus->number;
> +				*devfn =3D pdev->devfn;
> +			}
>  			goto out;
>  		}
>  	}
> @@ -5146,11 +5150,10 @@ static int aux_domain_add_dev(struct
> dmar_domain *domain,
>  			      struct device *dev)
>  {
>  	int ret;
> -	u8 bus, devfn;
>  	unsigned long flags;
>  	struct intel_iommu *iommu;
>=20
> -	iommu =3D device_to_iommu(dev, &bus, &devfn);
> +	iommu =3D device_to_iommu(dev, NULL, NULL);
>  	if (!iommu)
>  		return -ENODEV;
>=20
> @@ -5236,9 +5239,8 @@ static int prepare_domain_attach_device(struct
> iommu_domain *domain,
>  	struct dmar_domain *dmar_domain =3D to_dmar_domain(domain);
>  	struct intel_iommu *iommu;
>  	int addr_width;
> -	u8 bus, devfn;
>=20
> -	iommu =3D device_to_iommu(dev, &bus, &devfn);
> +	iommu =3D device_to_iommu(dev, NULL, NULL);
>  	if (!iommu)
>  		return -ENODEV;
>=20
> @@ -5658,9 +5660,8 @@ static bool intel_iommu_capable(enum
> iommu_cap cap)
>  static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>  {
>  	struct intel_iommu *iommu;
> -	u8 bus, devfn;
>=20
> -	iommu =3D device_to_iommu(dev, &bus, &devfn);
> +	iommu =3D device_to_iommu(dev, NULL, NULL);
>  	if (!iommu)
>  		return ERR_PTR(-ENODEV);
>=20
> @@ -5673,9 +5674,8 @@ static struct iommu_device
> *intel_iommu_probe_device(struct device *dev)
>  static void intel_iommu_release_device(struct device *dev)
>  {
>  	struct intel_iommu *iommu;
> -	u8 bus, devfn;
>=20
> -	iommu =3D device_to_iommu(dev, &bus, &devfn);
> +	iommu =3D device_to_iommu(dev, NULL, NULL);
>  	if (!iommu)
>  		return;
>=20
> @@ -5825,37 +5825,14 @@ static struct iommu_group
> *intel_iommu_device_group(struct device *dev)
>  	return generic_device_group(dev);
>  }
>=20
> -#ifdef CONFIG_INTEL_IOMMU_SVM
> -struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)
> -{
> -	struct intel_iommu *iommu;
> -	u8 bus, devfn;
> -
> -	if (iommu_dummy(dev)) {
> -		dev_warn(dev,
> -			 "No IOMMU translation for device; cannot enable
> SVM\n");
> -		return NULL;
> -	}
> -
> -	iommu =3D device_to_iommu(dev, &bus, &devfn);
> -	if ((!iommu)) {
> -		dev_err(dev, "No IOMMU for device; cannot enable SVM\n");
> -		return NULL;
> -	}
> -
> -	return iommu;
> -}
> -#endif /* CONFIG_INTEL_IOMMU_SVM */
> -
>  static int intel_iommu_enable_auxd(struct device *dev)
>  {
>  	struct device_domain_info *info;
>  	struct intel_iommu *iommu;
>  	unsigned long flags;
> -	u8 bus, devfn;
>  	int ret;
>=20
> -	iommu =3D device_to_iommu(dev, &bus, &devfn);
> +	iommu =3D device_to_iommu(dev, NULL, NULL);
>  	if (!iommu || dmar_disabled)
>  		return -EINVAL;
>=20
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 6c87c807a0ab..25dd74f27252 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -231,7 +231,7 @@ static LIST_HEAD(global_svm_list);
>  int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device
> *dev,
>  			  struct iommu_gpasid_bind_data *data)
>  {
> -	struct intel_iommu *iommu =3D intel_svm_device_to_iommu(dev);
> +	struct intel_iommu *iommu =3D device_to_iommu(dev, NULL, NULL);
>  	struct dmar_domain *dmar_domain;
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm;
> @@ -373,7 +373,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain, struct device *dev,
>=20
>  int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>  {
> -	struct intel_iommu *iommu =3D intel_svm_device_to_iommu(dev);
> +	struct intel_iommu *iommu =3D device_to_iommu(dev, NULL, NULL);
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm;
>  	int ret =3D -EINVAL;
> @@ -430,7 +430,7 @@ static int
>  intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops=
,
>  		  struct mm_struct *mm, struct intel_svm_dev **sd)
>  {
> -	struct intel_iommu *iommu =3D intel_svm_device_to_iommu(dev);
> +	struct intel_iommu *iommu =3D device_to_iommu(dev, NULL, NULL);
>  	struct device_domain_info *info;
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm =3D NULL;
> @@ -608,7 +608,7 @@ static int intel_svm_unbind_mm(struct device *dev,
> int pasid)
>  	struct intel_svm *svm;
>  	int ret =3D -EINVAL;
>=20
> -	iommu =3D intel_svm_device_to_iommu(dev);
> +	iommu =3D device_to_iommu(dev, NULL, NULL);
>  	if (!iommu)
>  		goto out;
>=20
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 3e8fa1c7a1e6..fc2cfc3db6e1 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -728,6 +728,7 @@ void iommu_flush_write_buffer(struct intel_iommu
> *iommu);
>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device
> *dev);
>  struct dmar_domain *find_domain(struct device *dev);
>  struct device_domain_info *get_domain_info(struct device *dev);
> +struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8
> *devfn);
>=20
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  extern void intel_svm_check(struct intel_iommu *iommu);
> @@ -766,8 +767,6 @@ struct intel_svm {
>  	struct list_head devs;
>  	struct list_head list;
>  };
> -
> -extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev)=
;
>  #else
>  static inline void intel_svm_check(struct intel_iommu *iommu) {}
>  #endif
> --
> 2.17.1

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
