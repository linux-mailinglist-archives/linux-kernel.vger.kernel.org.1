Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0142150F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 03:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgGFBgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 21:36:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:43812 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbgGFBgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:36:50 -0400
IronPort-SDR: iFecDkcQcgry5CsRpUdJwSoAZJ/U7+ghZwWkCmW7d88yGX+ZLEDsX4cgLkyrkDuEskSfao2xnF
 K9uBcZJVk83A==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="126938973"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="126938973"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 18:36:49 -0700
IronPort-SDR: 4zaeZWl+fXqkzsCuIuIocKSif9kNl+bHgI0JmqiYc6BebzL7MObjH4MWqMFaMEC6/6SjcZSQ9e
 9ACv9MWha+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="305113729"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2020 18:36:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 18:36:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 18:36:48 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 18:36:48 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.55) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 5 Jul 2020 18:36:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L19zyeewwAOvSSbF4eBjljtRsHWpTxgHOS6mEsfab+klU3N5CcFvxvm2Ub09ME1LtmfUHvPQLHL2tbPL1JA8ahMBvaI0RKuysjjBUrlP7Yy2G/+1QVU+zgYRIuXHGN9CsnsWeb8+gpHe3XJ9YOegaYGCemkAUS4GF+fMEwv9s5b+8CW+nU/xhB9LooNvXr4QYfom6qUUVP5yhu73HLOadzRDH74gSjb0ud8pqpH7orfkj+irdr89W+8KcDuG9wxOEMnHc9zzHIAgb98+/Jbfms//hgdwDH7onmydXI8TpiGuUQCnHpiklRYgsfCLqqGUzDfQbwAW8toVGwSS3984Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgpJs7x95qm+bGDEntqu7WbG8ObHkmiv6VY5x6LbHlw=;
 b=T8jd6PtdViu4Zn09okIxMMYcv9hqcQ8bsn0C/7HCwOa3Donm/daKdFJU8CwOsRay2fJ1vMwl1Wy4X/hoSEEXlWjvR7Fo7LDUeAVLC0vGQLxl2ESm8hLESKtRj7xX99WSRSJHVulVPFSSTeDzaBU/7LELu/jE82DaWp8sPhCajApvg3Mb2zAW5lMvi/LbITPbyo3kdfUGqyVGBiMb4zXxfBSYBg7jEL3xo4CyHWDJv3QCxioBvq2yRS3Ht3IPzTeKxMi1hBZpreiWXozXWtlzEbgeg2tnOdG/J9TP+TxuzTL8wSQuLTMLnsSJ/M/QSjZ3GacK90ufL3hG+5ylltnXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgpJs7x95qm+bGDEntqu7WbG8ObHkmiv6VY5x6LbHlw=;
 b=f8LdJeBcLARy1yJWAAe1+IPpCaVbveSiTTpY3PfxVCE9s4mgSAmfWsy0Bn+DkqiyS185cTpnGrlnqYEzBmH1MdFhBw6+L9qNSyGImJl6IXk29QqNGIyVxkjKBJWHkCdcIk1KwNrUytJvhFhRFrZseeBO0IDc8NTFm7UIrRscWYo=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1293.namprd11.prod.outlook.com (2603:10b6:300:1e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 01:36:47 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 01:36:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] iommu/vt-d: Report page request faults for guest
 SVA
Thread-Topic: [PATCH v2 3/4] iommu/vt-d: Report page request faults for guest
 SVA
Thread-Index: AQHWUyyukChEQzBHHE2t9ZcjAFLs+aj5vlKwgAAGe0A=
Date:   Mon, 6 Jul 2020 01:36:46 +0000
Message-ID: <MWHPR11MB16450BBD1FBDBD251A34F9F28C690@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
 <20200706002535.9381-4-baolu.lu@linux.intel.com> 
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
x-ms-office365-filtering-correlation-id: ada49e1c-28a6-4f62-2aa8-08d8214d0bf6
x-ms-traffictypediagnostic: MWHPR11MB1293:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1293A1B43BA2F8F5DED541048C690@MWHPR11MB1293.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mqh9wQn5tJARDFPdXyyJIXNwVdEVcrAeOMjp4hUgH/1ObjSKFWoyQmt06QsiA1Qdet+YRdau+0/atahoNerSTGJ66SN6l7ifmPaZZAb0z1dRD/9B6oOf0pMIEbBOfguEuVF03GsVkvxpgzINNjtt7kf+6XWG1nYMe109qlMFDYSpKebViZ9DPJcyPqQooeRBti7y0jU8mgczbcfX/OOCKwPa3o7OW8U1Wu3Prq3St4MrD/Vr0PZMi2OC21oiUGfasLPOB/xkDwoCeTw14L73UqzOsCtRB/TPxIE9zHYa5z190l1dhXHc2AHBqeEvEKzjoURkefWi7ye789RCgU7kQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(478600001)(316002)(54906003)(110136005)(9686003)(86362001)(8676002)(26005)(33656002)(52536014)(83380400001)(6506007)(5660300002)(2906002)(66476007)(66446008)(66556008)(64756008)(55016002)(66946007)(71200400001)(4326008)(8936002)(186003)(7696005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dOHFoy54nT1Dnc4nkKqU41Kkp9zqaQY7M90oZRSE/O1NSyeoqYeUwKsnu2cCldrA75HF88phOxiTBeegO+h79b5IP4RvDzmksRJ1h2qobeyP7s/1cB3RFsjDg2aNMepwLmqjEc2sAce0rx6rUrUVXNy1YUhJ6AgUmGY6+b91fqPE1ATQ67/EqThhVUbf/pJfbbUpl0FVQ+kXjTLZUMKu8fIZz06v0/ftLC1kclkiG2GWpddaeZtw9iMBbMQjsBo/nyVrLDZgc40f7PP7VfCh7h7/uXCGHN4Y7FYpjNug13a/U4cdF/Osrs/hXdXjWrvkeAP9wPA50cPI2Ntic6/JEMedgYWfP2xykyY5gdMlsEaPjnoUBZrkGe4KIdDc+LInxB2QS60xZv9Y1zhFra0pQQPFbCYOrV4ybBvv1yQnhHgYuweo4lzkZjgwntQTnSob9cu9RN1XtovEz1Y0ER/mG6jEfRivGaKXNVqFwok+NrwMQLUg+opEhgGqVQu+EMwo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada49e1c-28a6-4f62-2aa8-08d8214d0bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 01:36:46.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uH19KRw4/gpXStX4upKXWNZWVkYjzsKiDMMpELu5yPyefVo01mV2L7aJKPVJL4yv1aW81G5SDpFv/BmHsM8mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1293
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Tian, Kevin
> Sent: Monday, July 6, 2020 9:30 AM
>=20
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Monday, July 6, 2020 8:26 AM
> >
> > A pasid might be bound to a page table from a VM guest via the iommu
> > ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
> > on the physical IOMMU, we need to inject the page fault request into
> > the guest. After the guest completes handling the page fault, a page
> > response need to be sent back via the iommu ops.page_response().
> >
> > This adds support to report a page request fault. Any external module
> > which is interested in handling this fault should regiester a notifier
> > callback.
>=20
> be specific on which notifier to be registered...
>=20
> >
> > Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/intel/svm.c | 99 ++++++++++++++++++++++++++++++++-----
> --
> >  1 file changed, 81 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index c23167877b2b..08c58c2b1a06 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -815,6 +815,57 @@ static void intel_svm_drain_prq(struct device *dev=
,
> > int pasid)
> >  	}
> >  }
> >
> > +static int prq_to_iommu_prot(struct page_req_dsc *req)
> > +{
> > +	int prot =3D 0;
> > +
> > +	if (req->rd_req)
> > +		prot |=3D IOMMU_FAULT_PERM_READ;
> > +	if (req->wr_req)
> > +		prot |=3D IOMMU_FAULT_PERM_WRITE;
> > +	if (req->exe_req)
> > +		prot |=3D IOMMU_FAULT_PERM_EXEC;
> > +	if (req->pm_req)
> > +		prot |=3D IOMMU_FAULT_PERM_PRIV;
> > +
> > +	return prot;
> > +}
> > +
> > +static int
> > +intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
> > +{
> > +	struct iommu_fault_event event;
> > +	u8 bus, devfn;
> > +
> > +	memset(&event, 0, sizeof(struct iommu_fault_event));
> > +	bus =3D PCI_BUS_NUM(desc->rid);
> > +	devfn =3D desc->rid & 0xff;
>=20
> not required.
>=20
> > +
> > +	/* Fill in event data for device specific processing */
> > +	event.fault.type =3D IOMMU_FAULT_PAGE_REQ;
> > +	event.fault.prm.addr =3D desc->addr;
> > +	event.fault.prm.pasid =3D desc->pasid;
> > +	event.fault.prm.grpid =3D desc->prg_index;
> > +	event.fault.prm.perm =3D prq_to_iommu_prot(desc);
> > +
> > +	/*
> > +	 * Set last page in group bit if private data is present,
> > +	 * page response is required as it does for LPIG.
> > +	 */
>=20
> move to priv_data_present check?
>=20
> > +	if (desc->lpig)
> > +		event.fault.prm.flags |=3D
> > IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> > +	if (desc->pasid_present)
> > +		event.fault.prm.flags |=3D
> > IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> > +	if (desc->priv_data_present) {
> > +		event.fault.prm.flags |=3D
> > IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;

btw earlier comment is more about the behavior of the fault
handler (e.g. the guest), but not about why we need convert
to last_page prm flag. Let's make it clear that doing so is=20
because iommu_report_device_fault doesn't understand this
vt-d specific requirement thus we set last_page as a workaround.

Thanks
Kevin

> > +		event.fault.prm.flags |=3D
> > IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
> > +		memcpy(event.fault.prm.private_data, desc->priv_data,
> > +		       sizeof(desc->priv_data));
> > +	}
> > +
> > +	return iommu_report_device_fault(dev, &event);
> > +}
> > +
> >  static irqreturn_t prq_event_thread(int irq, void *d)
> >  {
> >  	struct intel_iommu *iommu =3D d;
> > @@ -828,7 +879,7 @@ static irqreturn_t prq_event_thread(int irq, void *=
d)
> >  	tail =3D dmar_readq(iommu->reg + DMAR_PQT_REG) &
> > PRQ_RING_MASK;
> >  	head =3D dmar_readq(iommu->reg + DMAR_PQH_REG) &
> > PRQ_RING_MASK;
> >  	while (head !=3D tail) {
> > -		struct intel_svm_dev *sdev;
> > +		struct intel_svm_dev *sdev =3D NULL;
>=20
> move to outside of the loop, otherwise later check always hit "if (!sdev)=
"
>=20
> >  		struct vm_area_struct *vma;
> >  		struct page_req_dsc *req;
> >  		struct qi_desc resp;
> > @@ -864,6 +915,20 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
> >  			}
> >  		}
> >
> > +		if (!sdev || sdev->sid !=3D req->rid) {
> > +			struct intel_svm_dev *t;
> > +
> > +			sdev =3D NULL;
> > +			rcu_read_lock();
> > +			list_for_each_entry_rcu(t, &svm->devs, list) {
> > +				if (t->sid =3D=3D req->rid) {
> > +					sdev =3D t;
> > +					break;
> > +				}
> > +			}
> > +			rcu_read_unlock();
> > +		}
> > +
> >  		result =3D QI_RESP_INVALID;
> >  		/* Since we're using init_mm.pgd directly, we should never
> > take
> >  		 * any faults on kernel addresses. */
> > @@ -874,6 +939,17 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
> >  		if (!is_canonical_address(address))
> >  			goto bad_req;
> >
> > +		/*
> > +		 * If prq is to be handled outside iommu driver via receiver of
> > +		 * the fault notifiers, we skip the page response here.
> > +		 */
> > +		if (svm->flags & SVM_FLAG_GUEST_MODE) {
> > +			if (sdev && !intel_svm_prq_report(sdev->dev, req))
> > +				goto prq_advance;
> > +			else
> > +				goto bad_req;
> > +		}
> > +
> >  		/* If the mm is already defunct, don't handle faults. */
> >  		if (!mmget_not_zero(svm->mm))
> >  			goto bad_req;
> > @@ -892,24 +968,10 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
> >  			goto invalid;
> >
> >  		result =3D QI_RESP_SUCCESS;
> > -	invalid:
> > +invalid:
> >  		mmap_read_unlock(svm->mm);
> >  		mmput(svm->mm);
> > -	bad_req:
> > -		/* Accounting for major/minor faults? */
> > -		rcu_read_lock();
> > -		list_for_each_entry_rcu(sdev, &svm->devs, list) {
> > -			if (sdev->sid =3D=3D req->rid)
> > -				break;
> > -		}
> > -		/* Other devices can go away, but the drivers are not
> > permitted
> > -		 * to unbind while any page faults might be in flight. So it's
> > -		 * OK to drop the 'lock' here now we have it. */
>=20
> should we keep and move this comment to earlier sdev lookup? and
> regarding to guest unbind, ae we preventing the fault owner (outside
> of iommu driver) to unbind against in-flight fault request?
>=20
> > -		rcu_read_unlock();
> > -
> > -		if (WARN_ON(&sdev->list =3D=3D &svm->devs))
> > -			sdev =3D NULL;
>=20
> similarly should we keep the WARN_ON check here?
>=20
> > -
> > +bad_req:
> >  		if (sdev && sdev->ops && sdev->ops->fault_cb) {
> >  			int rwxp =3D (req->rd_req << 3) | (req->wr_req << 2) |
> >  				(req->exe_req << 1) | (req->pm_req);
> > @@ -920,7 +982,7 @@ static irqreturn_t prq_event_thread(int irq, void *=
d)
> >  		   and these can be NULL. Do not use them below this point!
> > */
> >  		sdev =3D NULL;
> >  		svm =3D NULL;
> > -	no_pasid:
> > +no_pasid:
> >  		if (req->lpig || req->priv_data_present) {
> >  			/*
> >  			 * Per VT-d spec. v3.0 ch7.7, system software must
> > @@ -945,6 +1007,7 @@ static irqreturn_t prq_event_thread(int irq, void
> *d)
> >  			resp.qw3 =3D 0;
> >  			qi_submit_sync(iommu, &resp, 1, 0);
> >  		}
> > +prq_advance:
> >  		head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
> >  	}
> >
> > --
> > 2.17.1
>=20
> Thanks
> Kevin
