Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCAF2EC9F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 06:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbhAGFW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 00:22:56 -0500
Received: from mga11.intel.com ([192.55.52.93]:48069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbhAGFWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 00:22:55 -0500
IronPort-SDR: uGN78KvF2oTFFyxCtNW+hVH5s2/xIYqyki9Zpf/0WsWZrJI/U3vvrNwX6/GrxWXSycjD1LbTCU
 Rn+fqgs+BzWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="173866851"
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="173866851"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 21:22:14 -0800
IronPort-SDR: 484JdtrWg7/9LfLwo++OWx2uefge4NPOcfO+hhOqhcgPHqzDFec8DUul/RImo3sVuvph7hZ/jH
 Vq7BRF4gf4Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="398495961"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2021 21:22:14 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Jan 2021 21:22:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Jan 2021 21:22:14 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 6 Jan 2021 21:22:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pleufl4oge+DgCfaATFivDd53Gf8GJs6ADeFJE2nETHSmIfv4UqtEodgnlM7dVrDfhgPaLO80cJjMxQ3XoYy6kUazYlQOUZ53+R1RQAKJTNDUmtE4z+Ml8rKkvj3Fitq8tIQWV06QGvl0d0g2Mp7e5PIzzNz/jeqwvE/+nzsFZzMLsBDqByJl5EXXQzCob13ueNCMWFUU7MOiXojylIyh6lyvh797j/id4Siy37gPr+pRKhZTp+/hHEZyY3YnRxXphdWKTYXQmrcqWmPmKFMEq+Q96DjBeLp3ogSLWxI4dmBbfrxX4yBaoKA37W9oEo3GSrE6h80qeMoNQBkx5aPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7VI2/V3eXm+4fR8rWvnfFDefjfQMtUXKox0aJVTKOk=;
 b=OyBXORBcdYrfVsUKYCNoe0XJvMAYPQko9OZRttKInT+LJsMMoXUO7pS6sLN300UkBQSvdzMQBPbKQtVVzmpwKNjf6EZ5bonNBwyQlKwIVGZc52MMIzLNJWktIervIzp4CkZ04RioUHMlRGFX3fcF/bZJMJ3JHNY1RZeAeSnRHTigua00PpaNIbJuBkbL9jQi+J8LgO2aTrCjy9BNNs5fTYuKVGRIsCdw9ooqeDUtLLDVQHEiAu5DPT/gvoDlq0ieAzESSc4kp6XkjG9DYIjOceF1xyRUF/ESzLyoigtBWn94pK9GWwId/l+oApNiZZSiWg+5HAagVBmwqeRSb+aVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7VI2/V3eXm+4fR8rWvnfFDefjfQMtUXKox0aJVTKOk=;
 b=itDYPU99t96cEg3iq+uWXQK7EQxG29AgBgqQq7Nzye6ERx+hBYOfK4iPk6kLXF0wTtQDhP07mniDEf/YYgV/iwA02/SASgSEHUJg/VKAGc5F2mENTx5f5YM52kVSSes7AngrJqpu81d7KRGiISh8Js6eAr+PDhAGvv6WQzTxhoY=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1994.namprd11.prod.outlook.com (2603:10b6:3:e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.21; Thu, 7 Jan 2021 05:22:12 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 05:22:12 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Will Deacon <will@kernel.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Topic: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Index: AQHW3ZLDHAgDEwjOUE+qCmcDR/T80qoNwakAgArQO+CAAMIFgIACWuLQ
Date:   Thu, 7 Jan 2021 05:22:12 +0000
Message-ID: <DM5PR11MB1435DA1E9AEE9F25AB06ED9AC3AF0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-4-yi.l.liu@intel.com>
 <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
 <DM5PR11MB1435E814408F19A947263C07C3D10@DM5PR11MB1435.namprd11.prod.outlook.com>
 <20210105172348.GA12032@willie-the-truck>
In-Reply-To: <20210105172348.GA12032@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.213]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85795429-b157-49ba-22be-08d8b2cc3044
x-ms-traffictypediagnostic: DM5PR11MB1994:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1994B8EBD6E83E50F6044286C3AF0@DM5PR11MB1994.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GbKzSLyTKlvU3183Bumf20oFGQfC0MB3rpq1igxAinIGjkCekWHheV9Uf1hX1sX78iOyEaz2cfRlfC6D/bAJw/UdBjOOFqf8NYwYar/s3MdzrZjElkMVjMAPaf3YHf1ABQ136wdjTOKXsEHVdpoaQ3/GC+8hpZ30+NxUtTXFKFyeiaGY6+NdEdxiycPOcKEchJXvusBCNyC7lTh8EHTrazC5rUMCAvtZCCq0dZ12EN3NlNut8W+qV6bVomMqQofRLKeuyr8oajmbHifOaE7x9Q0eNDSwn2n+1V/j04utgQb9U/9XZhfr7H+YLxoiXbkWIYaqzXLiH8ZUmeDYSywdmSpyL/rVZx++9WKb923lO+V/worYvd3IELwxqR6HdOYPuJmSgZ39nlHP3Abf6I5mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(6916009)(478600001)(7696005)(5660300002)(316002)(52536014)(8676002)(66946007)(76116006)(33656002)(55016002)(26005)(186003)(2906002)(9686003)(64756008)(66446008)(6506007)(86362001)(66476007)(66556008)(54906003)(4326008)(71200400001)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FulxTxAPTQROtzkZJiTW9dk7Z9m2p/T+1hfT7gChCeiUz5JfcA2/FaoFtNTE?=
 =?us-ascii?Q?B6vR5sTcxjpV/hLZ97lc2ieVB8SLsNDR8aGhdHKFy3pYgWRlaY9pTa7JaQN2?=
 =?us-ascii?Q?1O54XU/mK9NpRWSE1CprGge5f4ZYG4LDZ6vv1L0MdVJUSv3BB45kX6wqXj0v?=
 =?us-ascii?Q?mM6S31b4cUhyqG61g5mgKqf4mIehDKa5hasjDeuN6PSixot2jz+AiDzHbOb1?=
 =?us-ascii?Q?OBVi5oq+8bUPPWkIaYzAQF8FUt5NygGU89+I0DKOpkd32NKYB6UzU0NRJfvP?=
 =?us-ascii?Q?7JdzCKb+YiVxCYtyAIQPowREuK2MVdVNYU6bheBIcoTCoomRtj6U/yuNmEir?=
 =?us-ascii?Q?qlYMKDvVKteh0Mo4j6c6pZcOzcddhx7PGkN2UbWgZuvPQMG9BjeN3EchJbDd?=
 =?us-ascii?Q?3yNxR25UC4pO2zItBCs+I2TB6Ld4L9rvcYUkU9LGkoxhvDAHNGZ+2gXDgOeV?=
 =?us-ascii?Q?U1fr7KUvWTjVPWuk3eCBFBilmi7lVOAp4cU8TRGzkKsboDrjBqe20a0MsEpc?=
 =?us-ascii?Q?1K/McssygLci9POtRvG/EM2ZpM1U0M8ybqQiUzAgUnjj0VUgAsfi0d8+x5Ts?=
 =?us-ascii?Q?IWGELtIpBPxZu+cy0G+DzD03VR2l0kOeIllNyCLx9FtNUQTAigczrXZNj2ST?=
 =?us-ascii?Q?RZNXV/D6/v8K8fSBwEAT9ZoAQdPc+/7qBGhaRVZh2x8pBZsaU8MNXr2ap/zU?=
 =?us-ascii?Q?N4ha9Yfu3/J5zSFwAcy/k3GpJpKIRCmBVqXs28ahD4oSRJfKbn5nR2Gf1ouZ?=
 =?us-ascii?Q?Lf8f0Pxy/sKAO8gZg+irmDyS2T+X/hdnAnpaxUemffnX6zZ4omXQCH9XDZ6o?=
 =?us-ascii?Q?/IPt5nJTAvd5yqfYx/1WO+eV1lSqLyPVs1lHNLdjC+2ooeEJxHZNjHeiixNg?=
 =?us-ascii?Q?Vc7wxXFuwBzXyvkyeUtU6Ke4UHKUAlcw2EvsA+1U1MKgJm+v7DsmJIVMT8Mf?=
 =?us-ascii?Q?fcnWzlfAOXkLrBRMzwNzSQLyeZxZ/32fW+ZYBj4hmu16LGLGhxgUB+hrLW9a?=
 =?us-ascii?Q?By+h?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85795429-b157-49ba-22be-08d8b2cc3044
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 05:22:12.5209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8XA2A1JntITjLW58xkJ9ATJOlqRHIbZ70/xJ7uEDE1HQdQIWTnt6ggL0bQgUTxGd+8Ir0Zp5MsVUfxuuK+lMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1994
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> From: Will Deacon <will@kernel.org>
> Sent: Wednesday, January 6, 2021 1:24 AM
>=20
> On Tue, Jan 05, 2021 at 05:50:22AM +0000, Liu, Yi L wrote:
> > > > +static void __iommu_flush_dev_iotlb(struct device_domain_info
> *info,
> > > > +				    u64 addr, unsigned int mask)
> > > > +{
> > > > +	u16 sid, qdep;
> > > > +
> > > > +	if (!info || !info->ats_enabled)
> > > > +		return;
> > > > +
> > > > +	sid =3D info->bus << 8 | info->devfn;
> > > > +	qdep =3D info->ats_qdep;
> > > > +	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> > > > +			   qdep, addr, mask);
> > > > +}
> > > > +
> > > >   static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
> > > >   				  u64 addr, unsigned mask)
> > > >   {
> > > > -	u16 sid, qdep;
> > > >   	unsigned long flags;
> > > >   	struct device_domain_info *info;
> > > > +	struct subdev_domain_info *sinfo;
> > > >
> > > >   	if (!domain->has_iotlb_device)
> > > >   		return;
> > > >
> > > >   	spin_lock_irqsave(&device_domain_lock, flags);
> > > > -	list_for_each_entry(info, &domain->devices, link) {
> > > > -		if (!info->ats_enabled)
> > > > -			continue;
> > > > +	list_for_each_entry(info, &domain->devices, link)
> > > > +		__iommu_flush_dev_iotlb(info, addr, mask);
> > > >
> > > > -		sid =3D info->bus << 8 | info->devfn;
> > > > -		qdep =3D info->ats_qdep;
> > > > -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> > > > -				qdep, addr, mask);
> > > > +	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> > > > +		__iommu_flush_dev_iotlb(get_domain_info(sinfo->pdev),
> > > > +					addr, mask);
> > > >   	}
> > >
> > > Nit:
> > > 	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> > > 		info =3D get_domain_info(sinfo->pdev);
> > > 		__iommu_flush_dev_iotlb(info, addr, mask);
> > > 	}
> >
> > you are right. this should be better.
>=20
> Please can you post a v4, with Lu's acks and the issue reported by Dan fi=
xed
> too?

sure, will send out later.

Regards,
Yi Liu

> Thanks,
>=20
> Will
