Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF221E601
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 04:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGNC7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 22:59:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:40688 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGNC7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:59:05 -0400
IronPort-SDR: NZULj4ZryFiortUTrSU+Odu5lnePuk2HNqFk6Ww2W4f00q45bW9NcSu7birFC+v5lllh0CuJHP
 XRlaFPaE9rDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="146805366"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="146805366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 19:45:58 -0700
IronPort-SDR: B4BB3/y1pJdIWfpO/l19R5WTrk4BzDVtv0OyaOQxj2TBAUxea+jxzvzrTrlmmYzy9IfpxsO5sm
 cgK3Xi3/2sDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; 
   d="scan'208";a="485711915"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2020 19:45:53 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jul 2020 19:45:53 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jul 2020 19:45:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 13 Jul 2020 19:45:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyDPKAuvooVH12ErYjcGR9h23flmDoKgb7MYJKQJkEBZ49LSoKjCJGqAq2ErG9fRWDaH2eikVqnkVb89r2OVmHBDHJw5d55QKgj3YX8cKRonIPNRWNTsVQ3/tjL5i8yTB0mMi4X8G10lvntQJ4+GbtBS9AkvYpjZDKViPMvCIjvI9u3MoCXMhtYYrw+4qrcnXd0wJ73YqAQl5v59KMf9qJB1eOtbAmaDQE6nPvGpuDxohdNbNhIswrHJB4bQP1vHp623je98SGRpvUzZd66nJ4fGsecT4J44oKvg2AZFlwkB4h0WKCMqAvNHcH4w3phtPa8F9t+0is5Uc6MlEX1YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK5qIXzgy4ETjytRMvuGKbTPZCboyQ8voy4C9dIBbxg=;
 b=EAxWFXehQYyC+/J6PjnDRLDpnkDtrwSs2/nKTNS2fCN8m9IjxEao4e2HeJ8q3Zr038dBsQ43CcP+B9RgcGklTQvSX/6KiTidau0YAs/zgFkCTNcNSdhvkiQKfIJfRghfAzn/78yKjp+hailQeAQEzBFAQSodvu8mwPnWSJd74d65DcJo5VEItBzzs5PTohFknGTtpzk+T2h8DyvDGJX6rUzzgUtjvoxGc3ZSSbZ5KGGvDvo6IedTArDGqiLAI08cUDnyGy94zzpMqCFCeIjVAw7oNQDzN+Dpj0hjdspBqlP2a/b3xHR24nMbuQ0PhkVsAiY0MmH2zctUScsrYzbGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK5qIXzgy4ETjytRMvuGKbTPZCboyQ8voy4C9dIBbxg=;
 b=gNWLqDaXNXdXhU23JCtxRS9eKk+rrxgrW26pkLheGj2A8PbSoK04Cv0vdZsre+RAyaY/d/xfnZ9x5O/IIILPhUF85HErCtVfPtXRQgUz9/cMEn/wNtNkz6uvV6CUehWE5tD+jzsu3IKKqsvJXpyYk3JRE3PUoncKImg8RhHzMQU=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4329.namprd11.prod.outlook.com (2603:10b6:5:201::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Tue, 14 Jul 2020 02:45:49 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3174.025; Tue, 14 Jul
 2020 02:45:49 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v6 01/12] iommu: Change type of pasid to u32
Thread-Topic: [PATCH v6 01/12] iommu: Change type of pasid to u32
Thread-Index: AQHWWXA1h1KpvcyzpkmsBfdm/bKRN6kGXnQQ
Date:   Tue, 14 Jul 2020 02:45:49 +0000
Message-ID: <DM5PR11MB1435D67E0CE9D8D4C1D7F675C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-2-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-2-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.229.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e806121-cc36-4c9d-14f9-08d827a00480
x-ms-traffictypediagnostic: DM6PR11MB4329:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB43291C3B97F812ED6E090D8DC3610@DM6PR11MB4329.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 29pqe5nuFylopfF+WQ2PfVvu1M+IAah5QP54LeAPDqWPWS+YQ4NfflK/lG3r3uxW/1vmsVhl9KvfL3t+2b/v5cNSETFrSmaaS6jpj1ICRrqZjzouX6JC3s+My8iuh+XkiEM0jU/L7BRAWkgfVjpCmpjDcBjRN6w0wbszpa55exXuGDtiyNj7yakp/cn/2Q9mpPFsa6on+ArOuca2grnfT5oMm60zrTU+c5/GWw72gFLeYjeQWVhvUTvPwhF7q3nR4Zo+fQDkb7ZrcOEdJip8wa2xM/WDcBXrCzRWwJ5XcpH7njNOMnXZRFEB0JOVlEPj5Ni84zyxYhqZx2N6VRnMBZSX9m1p3Iud0TM3TY1aAZOD7PlvhycQjKHlve/Z7Oar1GyJrdnagITuRDW+1OIpFja8ao8+hDh9VoS3gvrXNqm5OK71+560VT0COXfRkew0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(71200400001)(2906002)(66946007)(66446008)(64756008)(66556008)(66476007)(83380400001)(7416002)(5660300002)(76116006)(6636002)(86362001)(30864003)(4326008)(7696005)(33656002)(316002)(110136005)(54906003)(966005)(478600001)(8936002)(52536014)(8676002)(186003)(6506007)(55016002)(9686003)(26005)(921003)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Comgu/uW0egw9cn6aUqd6ZZvQ9HgfOGLfDy7snaJTR5AmZAt+DdJ1OcmT2n6/IcU0BbLN/0UIRDWbvyIEFfbvQLdmsvzs2+nXFjX0EtraxMtFrDQX6/tH1/M4xL5MYg7K3YZvpRKc+aF764F13QKMElQ6NPOHRtI1HLTMhxjs4DiZfqaCQeHilpmUJpqYqp7Uz57rAyeGeRhxSojnPaGl8MA2MIPNZKKxPK0ZOG5upcsDLlOZyf18jFOY/uKRJ3HCaoE3v9zemGCEM0t4TL6i4KhH7CaChN5cRQ7wbfXINTHnl0FDiFdYAKvnzrb8OdOmofAGNlksv0FDXHInDYTC6Lr4dEZI0Zoz3WmYdqWmB+HmMZ7IMbyHObZt+hEAfM9jpti9SaD8eOFLuZr4bCx2b3BKFIg/9iHTE3YqbSlNBcAOkyPRSzBxi37gwCfYsgEvOZ3vgZUc7+7HsXgegtfREzxCDLgymYXv6Qm0i4wuw7yzY93JByGm63NKmmqqbub
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e806121-cc36-4c9d-14f9-08d827a00480
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 02:45:49.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aGVR8qV6lukZ2ld9e7guA3eiA2+CTLKNAggkcM8KMYfywN7Dh3mI9SVeCROQQbyd41aCbVGvkSyrXxaPQMHBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4329
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Tuesday, July 14, 2020 7:48 AM
>=20
> PASID is defined as a few different types in iommu including "int",
> "u32", and "unsigned int". To be consistent and to match with uapi
> definitions, define PASID and its variations (e.g. max PASID) as "u32".
> "u32" is also shorter and a little more explicit than "unsigned int".
>=20
> No PASID type change in uapi although it defines PASID as __u64 in
> some places.

just out of curious, why not using ioasid_t? In Linux kernel, PASID is
managed by ioasid.

Regards,
Yi Liu

> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
> v6:
> - Change return type to u32 for kfd_pasid_alloc() (Felix)
>=20
> v5:
> - Reviewed by Lu Baolu
>=20
> v4:
> - Change PASID type from "unsigned int" to "u32" (Christoph)
>=20
> v2:
> - Create this new patch to define PASID as "unsigned int" consistently in
>   iommu (Thomas)
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  4 +--
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  8 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  8 ++---
>  .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c       |  2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h       |  2 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  7 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  8 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_events.h       |  4 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_iommu.c        |  6 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_pasid.c        |  4 +--
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         | 20 ++++++------
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  2 +-
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 +-
>  drivers/iommu/amd/amd_iommu.h                 | 10 +++---
>  drivers/iommu/amd/iommu.c                     | 31 ++++++++++---------
>  drivers/iommu/amd/iommu_v2.c                  | 20 ++++++------
>  drivers/iommu/intel/dmar.c                    |  7 +++--
>  drivers/iommu/intel/intel-pasid.h             | 24 +++++++-------
>  drivers/iommu/intel/iommu.c                   |  4 +--
>  drivers/iommu/intel/pasid.c                   | 31 +++++++++----------
>  drivers/iommu/intel/svm.c                     | 12 +++----
>  drivers/iommu/iommu.c                         |  2 +-
>  drivers/misc/uacce/uacce.c                    |  2 +-
>  include/linux/amd-iommu.h                     |  8 ++---
>  include/linux/intel-iommu.h                   | 12 +++----
>  include/linux/intel-svm.h                     |  2 +-
>  include/linux/iommu.h                         | 10 +++---
>  include/linux/uacce.h                         |  2 +-
>  38 files changed, 141 insertions(+), 141 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index ffe149aafc39..dfef5a7e0f5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -207,11 +207,11 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct
> kgd_dev *dst, struct kgd_dev *s
>  	})
>=20
>  /* GPUVM API */
> -int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, unsigned =
int
> pasid,
> +int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid=
,
>  					void **vm, void **process_info,
>  					struct dma_fence **ef);
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
> -					struct file *filp, unsigned int pasid,
> +					struct file *filp, u32 pasid,
>  					void **vm, void **process_info,
>  					struct dma_fence **ef);
>  void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index bf927f432506..ee531c3988d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -105,7 +105,7 @@ static void kgd_program_sh_mem_settings(struct kgd_de=
v
> *kgd, uint32_t vmid,
>  	unlock_srbm(kgd);
>  }
>=20
> -static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int =
pasid,
> +static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid)
>  {
>  	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 744366c7ee85..4d41317b9292 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -139,7 +139,7 @@ static void kgd_program_sh_mem_settings(struct kgd_de=
v
> *kgd, uint32_t vmid,
>  	unlock_srbm(kgd);
>  }
>=20
> -static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int =
pasid,
> +static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid)
>  {
>  	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index feab4cc6e836..35917d4b50f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -96,7 +96,7 @@ static void kgd_program_sh_mem_settings(struct kgd_dev
> *kgd, uint32_t vmid,
>  	unlock_srbm(kgd);
>  }
>=20
> -static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int =
pasid,
> +static int kgd_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid)
>  {
>  	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index c7fd0c47b254..b4b88e4da4de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -110,7 +110,7 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_de=
v
> *kgd, uint32_t vmid,
>  	unlock_srbm(kgd);
>  }
>=20
> -int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int =
pasid,
> +int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid)
>  {
>  	struct amdgpu_device *adev =3D get_amdgpu_device(kgd);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index aedf67d57449..ff2bc72e6646 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -26,7 +26,7 @@ void kgd_gfx_v9_program_sh_mem_settings(struct kgd_dev
> *kgd, uint32_t vmid,
>  		uint32_t sh_mem_config,
>  		uint32_t sh_mem_ape1_base, uint32_t sh_mem_ape1_limit,
>  		uint32_t sh_mem_bases);
> -int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, unsigned int =
pasid,
> +int kgd_gfx_v9_set_pasid_vmid_mapping(struct kgd_dev *kgd, u32 pasid,
>  		unsigned int vmid);
>  int kgd_gfx_v9_init_interrupts(struct kgd_dev *kgd, uint32_t pipe_id);
>  int kgd_gfx_v9_hqd_load(struct kgd_dev *kgd, void *mqd, uint32_t pipe_id=
,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b91b5171270f..9d06366320bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -994,7 +994,7 @@ static int init_kfd_vm(struct amdgpu_vm *vm, void
> **process_info,
>  	return ret;
>  }
>=20
> -int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, unsigned =
int
> pasid,
> +int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, u32 pasid=
,
>  					  void **vm, void **process_info,
>  					  struct dma_fence **ef)
>  {
> @@ -1030,7 +1030,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct
> kgd_dev *kgd, unsigned int pasi
>  }
>=20
>  int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
> -					   struct file *filp, unsigned int pasid,
> +					   struct file *filp, u32 pasid,
>  					   void **vm, void **process_info,
>  					   struct dma_fence **ef)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index fe92dcd94d4a..3f697e9010d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -43,7 +43,7 @@ static DEFINE_IDA(amdgpu_pasid_ida);
>  /* Helper to free pasid from a fence callback */
>  struct amdgpu_pasid_cb {
>  	struct dma_fence_cb cb;
> -	unsigned int pasid;
> +	u32 pasid;
>  };
>=20
>  /**
> @@ -79,7 +79,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>   * amdgpu_pasid_free - Free a PASID
>   * @pasid: PASID to free
>   */
> -void amdgpu_pasid_free(unsigned int pasid)
> +void amdgpu_pasid_free(u32 pasid)
>  {
>  	trace_amdgpu_pasid_freed(pasid);
>  	ida_simple_remove(&amdgpu_pasid_ida, pasid);
> @@ -105,7 +105,7 @@ static void amdgpu_pasid_free_cb(struct dma_fence *fe=
nce,
>   * Free the pasid only after all the fences in resv are signaled.
>   */
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
> -			       unsigned int pasid)
> +			       u32 pasid)
>  {
>  	struct dma_fence *fence, **fences;
>  	struct amdgpu_pasid_cb *cb;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> index 8e58325bbca2..0c3b4fa1f936 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h
> @@ -71,9 +71,9 @@ struct amdgpu_vmid_mgr {
>  };
>=20
>  int amdgpu_pasid_alloc(unsigned int bits);
> -void amdgpu_pasid_free(unsigned int pasid);
> +void amdgpu_pasid_free(u32 pasid);
>  void amdgpu_pasid_free_delayed(struct dma_resv *resv,
> -			       unsigned int pasid);
> +			       u32 pasid);
>=20
>  bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
>  			       struct amdgpu_vmid *id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index d7e17e34fee1..8503cce467eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1062,7 +1062,7 @@ void amdgpu_driver_postclose_kms(struct drm_device
> *dev,
>  	struct amdgpu_fpriv *fpriv =3D file_priv->driver_priv;
>  	struct amdgpu_bo_list *list;
>  	struct amdgpu_bo *pd;
> -	unsigned int pasid;
> +	u32 pasid;
>  	int handle;
>=20
>  	if (!fpriv)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 7417754e9141..ada2534dd8d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2783,7 +2783,7 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long
> timeout)
>   * 0 for success, error for failure.
>   */
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int vm_context, unsigned int pasid)
> +		   int vm_context, u32 pasid)
>  {
>  	struct amdgpu_bo_param bp;
>  	struct amdgpu_bo *root;
> @@ -2954,7 +2954,7 @@ static int amdgpu_vm_check_clean_reserved(struct
> amdgpu_device *adev,
>   * 0 for success, -errno for errors.
>   */
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm
> *vm,
> -			   unsigned int pasid)
> +			   u32 pasid)
>  {
>  	bool pte_support_ats =3D (adev->asic_type =3D=3D CHIP_RAVEN);
>  	int r;
> @@ -3252,7 +3252,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *d=
ata,
> struct drm_file *filp)
>   * @pasid: PASID identifier for VM
>   * @task_info: task_info to fill.
>   */
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pa=
sid,
> +void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>  			 struct amdgpu_task_info *task_info)
>  {
>  	struct amdgpu_vm *vm;
> @@ -3296,7 +3296,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * Try to gracefully handle a VM fault. Return true if the fault was han=
dled and
>   * shouldn't be reported any more.
>   */
> -bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pas=
id,
> +bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  			    uint64_t addr)
>  {
>  	struct amdgpu_bo *root;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index c8e68d7890bf..c2f23b071f14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -371,8 +371,8 @@ void amdgpu_vm_manager_fini(struct amdgpu_device
> *adev);
>=20
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int vm_context, unsigned int pasid);
> -int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm
> *vm, unsigned int pasid);
> +		   int vm_context, u32 pasid);
> +int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm
> *vm, u32 pasid);
>  void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct
> amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
> @@ -429,9 +429,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring
> *ring,
>  				  struct amdgpu_job *job);
>  void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>=20
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pa=
sid,
> +void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>  			     struct amdgpu_task_info *task_info);
> -bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pas=
id,
> +bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>  			    uint64_t addr);
>=20
>  void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> index 9f59ba93cfe0..c2fd30045ad5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> +++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
> @@ -90,7 +90,7 @@ static void cik_event_interrupt_wq(struct kfd_dev *dev,
>  			(const struct cik_ih_ring_entry *)ih_ring_entry;
>  	uint32_t context_id =3D ihre->data & 0xfffffff;
>  	unsigned int vmid  =3D (ihre->ring_id & 0x0000ff00) >> 8;
> -	unsigned int pasid =3D (ihre->ring_id & 0xffff0000) >> 16;
> +	u32 pasid =3D (ihre->ring_id & 0xffff0000) >> 16;
>=20
>  	if (pasid =3D=3D 0)
>  		return;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> index 27bcc5b472f6..b258a3dae767 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
> @@ -45,7 +45,7 @@ static void dbgdev_address_watch_disable_nodiq(struct
> kfd_dev *dev)
>  }
>=20
>  static int dbgdev_diq_submit_ib(struct kfd_dbgdev *dbgdev,
> -				unsigned int pasid, uint64_t vmid0_address,
> +				u32 pasid, uint64_t vmid0_address,
>  				uint32_t *packet_buff, size_t size_in_bytes)
>  {
>  	struct pm4__release_mem *rm_packet;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
> index a04a1fe1d0d9..f9c6df1fdc5c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgmgr.h
> @@ -275,7 +275,7 @@ struct kfd_dbgdev {
>  };
>=20
>  struct kfd_dbgmgr {
> -	unsigned int pasid;
> +	u32 pasid;
>  	struct kfd_dev *dev;
>  	struct kfd_dbgdev *dbgdev;
>  };
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e9c4867abeff..9571a6e5de4c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -40,7 +40,7 @@
>  #define CIK_HPD_EOP_BYTES (1U << CIK_HPD_EOP_BYTES_LOG2)
>=20
>  static int set_pasid_vmid_mapping(struct device_queue_manager *dqm,
> -					unsigned int pasid, unsigned int vmid);
> +				  u32 pasid, unsigned int vmid);
>=20
>  static int execute_queues_cpsch(struct device_queue_manager *dqm,
>  				enum kfd_unmap_queues_filter filter,
> @@ -909,7 +909,7 @@ static int unregister_process(struct device_queue_man=
ager
> *dqm,
>  }
>=20
>  static int
> -set_pasid_vmid_mapping(struct device_queue_manager *dqm, unsigned int pa=
sid,
> +set_pasid_vmid_mapping(struct device_queue_manager *dqm, u32 pasid,
>  			unsigned int vmid)
>  {
>  	return dqm->dev->kfd2kgd->set_pasid_vmid_mapping(
> @@ -1925,8 +1925,7 @@ void device_queue_manager_uninit(struct
> device_queue_manager *dqm)
>  	kfree(dqm);
>  }
>=20
> -int kfd_process_vm_fault(struct device_queue_manager *dqm,
> -			 unsigned int pasid)
> +int kfd_process_vm_fault(struct device_queue_manager *dqm, u32 pasid)
>  {
>  	struct kfd_process_device *pdd;
>  	struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index a9583b95fcc1..ba2c2ce0c55a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -460,7 +460,7 @@ static void set_event_from_interrupt(struct kfd_proce=
ss *p,
>  	}
>  }
>=20
> -void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
> +void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>  				uint32_t valid_id_bits)
>  {
>  	struct kfd_event *ev =3D NULL;
> @@ -872,7 +872,7 @@ static void lookup_events_by_type_and_signal(struct
> kfd_process *p,
>  }
>=20
>  #ifdef KFD_SUPPORT_IOMMU_V2
> -void kfd_signal_iommu_event(struct kfd_dev *dev, unsigned int pasid,
> +void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
>  		unsigned long address, bool is_write_requested,
>  		bool is_execute_requested)
>  {
> @@ -950,7 +950,7 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, unsi=
gned
> int pasid,
>  }
>  #endif /* KFD_SUPPORT_IOMMU_V2 */
>=20
> -void kfd_signal_hw_exception_event(unsigned int pasid)
> +void kfd_signal_hw_exception_event(u32 pasid)
>  {
>  	/*
>  	 * Because we are called from arbitrary context (workqueue) as opposed
> @@ -971,7 +971,7 @@ void kfd_signal_hw_exception_event(unsigned int pasid=
)
>  	kfd_unref_process(p);
>  }
>=20
> -void kfd_signal_vm_fault_event(struct kfd_dev *dev, unsigned int pasid,
> +void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
>  				struct kfd_vm_fault_info *info)
>  {
>  	struct kfd_event *ev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> index c7ac6c73af86..c8fe5dbdad55 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> @@ -79,7 +79,7 @@ struct kfd_event {
>  #define KFD_EVENT_TYPE_DEBUG 5
>  #define KFD_EVENT_TYPE_MEMORY 8
>=20
> -extern void kfd_signal_event_interrupt(unsigned int pasid, uint32_t part=
ial_id,
> -					uint32_t valid_id_bits);
> +extern void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
> +				       uint32_t valid_id_bits);
>=20
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> index 7c8786b9eb0a..e8ef3886688b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
> @@ -139,7 +139,7 @@ void kfd_iommu_unbind_process(struct kfd_process *p)
>  }
>=20
>  /* Callback for process shutdown invoked by the IOMMU driver */
> -static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, int pasi=
d)
> +static void iommu_pasid_shutdown_callback(struct pci_dev *pdev, u32 pasi=
d)
>  {
>  	struct kfd_dev *dev =3D kfd_device_by_pci_dev(pdev);
>  	struct kfd_process *p;
> @@ -185,8 +185,8 @@ static void iommu_pasid_shutdown_callback(struct pci_=
dev
> *pdev, int pasid)
>  }
>=20
>  /* This function called by IOMMU driver on PPR failure */
> -static int iommu_invalid_ppr_cb(struct pci_dev *pdev, int pasid,
> -		unsigned long address, u16 flags)
> +static int iommu_invalid_ppr_cb(struct pci_dev *pdev, u32 pasid,
> +				unsigned long address, u16 flags)
>  {
>  	struct kfd_dev *dev;
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> index 33b08ff00b50..c19a2e6fd7c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
> @@ -51,7 +51,7 @@ unsigned int kfd_get_pasid_limit(void)
>  	return 1U << pasid_bits;
>  }
>=20
> -unsigned int kfd_pasid_alloc(void)
> +u32 kfd_pasid_alloc(void)
>  {
>  	int r;
>=20
> @@ -77,7 +77,7 @@ unsigned int kfd_pasid_alloc(void)
>  	return r > 0 ? r : 0;
>  }
>=20
> -void kfd_pasid_free(unsigned int pasid)
> +void kfd_pasid_free(u32 pasid)
>  {
>  	if (kfd2kgd)
>  		amdgpu_pasid_free(pasid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index fee60921fccf..09db037bb48f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -715,7 +715,7 @@ struct kfd_process {
>  	/* We want to receive a notification when the mm_struct is destroyed */
>  	struct mmu_notifier mmu_notifier;
>=20
> -	uint16_t pasid;
> +	u32 pasid;
>  	unsigned int doorbell_index;
>=20
>  	/*
> @@ -790,7 +790,7 @@ int kfd_process_create_wq(void);
>  void kfd_process_destroy_wq(void);
>  struct kfd_process *kfd_create_process(struct file *filep);
>  struct kfd_process *kfd_get_process(const struct task_struct *);
> -struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid);
> +struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
>  struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)=
;
>  void kfd_unref_process(struct kfd_process *p);
>  int kfd_process_evict_queues(struct kfd_process *p);
> @@ -831,8 +831,8 @@ int kfd_pasid_init(void);
>  void kfd_pasid_exit(void);
>  bool kfd_set_pasid_limit(unsigned int new_limit);
>  unsigned int kfd_get_pasid_limit(void);
> -unsigned int kfd_pasid_alloc(void);
> -void kfd_pasid_free(unsigned int pasid);
> +u32 kfd_pasid_alloc(void);
> +void kfd_pasid_free(u32 pasid);
>=20
>  /* Doorbells */
>  size_t kfd_doorbell_process_slice(struct kfd_dev *kfd);
> @@ -917,7 +917,7 @@ void device_queue_manager_uninit(struct
> device_queue_manager *dqm);
>  struct kernel_queue *kernel_queue_init(struct kfd_dev *dev,
>  					enum kfd_queue_type type);
>  void kernel_queue_uninit(struct kernel_queue *kq, bool hanging);
> -int kfd_process_vm_fault(struct device_queue_manager *dqm, unsigned int =
pasid);
> +int kfd_process_vm_fault(struct device_queue_manager *dqm, u32 pasid);
>=20
>  /* Process Queue Manager */
>  struct process_queue_node {
> @@ -1039,12 +1039,12 @@ int kfd_wait_on_events(struct kfd_process *p,
>  		       uint32_t num_events, void __user *data,
>  		       bool all, uint32_t user_timeout_ms,
>  		       uint32_t *wait_result);
> -void kfd_signal_event_interrupt(unsigned int pasid, uint32_t partial_id,
> +void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>  				uint32_t valid_id_bits);
>  void kfd_signal_iommu_event(struct kfd_dev *dev,
> -		unsigned int pasid, unsigned long address,
> -		bool is_write_requested, bool is_execute_requested);
> -void kfd_signal_hw_exception_event(unsigned int pasid);
> +			    u32 pasid, unsigned long address,
> +			    bool is_write_requested, bool is_execute_requested);
> +void kfd_signal_hw_exception_event(u32 pasid);
>  int kfd_set_event(struct kfd_process *p, uint32_t event_id);
>  int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
>  int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
> @@ -1055,7 +1055,7 @@ int kfd_event_create(struct file *devkfd, struct
> kfd_process *p,
>  		     uint64_t *event_page_offset, uint32_t *event_slot_index);
>  int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
>=20
> -void kfd_signal_vm_fault_event(struct kfd_dev *dev, unsigned int pasid,
> +void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
>  				struct kfd_vm_fault_info *info);
>=20
>  void kfd_signal_reset_event(struct kfd_dev *dev);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 0e0c42e9f6a3..7567647e976d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1087,7 +1087,7 @@ void kfd_process_device_remove_obj_handle(struct
> kfd_process_device *pdd,
>  }
>=20
>  /* This increments the process->ref counter. */
> -struct kfd_process *kfd_lookup_process_by_pasid(unsigned int pasid)
> +struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
>  {
>  	struct kfd_process *p, *ret_p =3D NULL;
>  	unsigned int temp;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index a3c238c39ef5..301de493377a 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -226,7 +226,7 @@ struct kfd2kgd_calls {
>  			uint32_t sh_mem_config,	uint32_t
> sh_mem_ape1_base,
>  			uint32_t sh_mem_ape1_limit, uint32_t sh_mem_bases);
>=20
> -	int (*set_pasid_vmid_mapping)(struct kgd_dev *kgd, unsigned int pasid,
> +	int (*set_pasid_vmid_mapping)(struct kgd_dev *kgd, u32 pasid,
>  					unsigned int vmid);
>=20
>  	int (*init_interrupts)(struct kgd_dev *kgd, uint32_t pipe_id);
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.=
h
> index f892992c8744..1fae58dd3c25 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -45,12 +45,12 @@ extern int amd_iommu_register_ppr_notifier(struct
> notifier_block *nb);
>  extern int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
>  extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
>  extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasi=
ds);
> -extern int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
> +extern int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
>  				u64 address);
> -extern int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid);
> -extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid=
,
> +extern int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
> +extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid=
,
>  				     unsigned long cr3);
> -extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pas=
id);
> +extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32
> pasid);
>  extern struct iommu_domain *amd_iommu_get_v2_domain(struct pci_dev *pdev=
);
>=20
>  #ifdef CONFIG_IRQ_REMAP
> @@ -66,7 +66,7 @@ static inline int amd_iommu_create_irq_domain(struct
> amd_iommu *iommu)
>  #define PPR_INVALID			0x1
>  #define PPR_FAILURE			0xf
>=20
> -extern int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
> +extern int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
>  				  int status, int tag);
>=20
>  static inline bool is_rd890_iommu(struct pci_dev *pdev)
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 74cca1757172..8398a38af719 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -502,10 +502,11 @@ static void amd_iommu_report_page_fault(u16 devid,
> u16 domain_id,
>  static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>  {
>  	struct device *dev =3D iommu->iommu.dev;
> -	int type, devid, pasid, flags, tag;
> +	int type, devid, flags, tag;
>  	volatile u32 *event =3D __evt;
>  	int count =3D 0;
>  	u64 address;
> +	u32 pasid;
>=20
>  retry:
>  	type    =3D (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
> @@ -898,7 +899,7 @@ static void build_inv_iotlb_pages(struct iommu_cmd *c=
md,
> u16 devid, int qdep,
>  		cmd->data[2] |=3D CMD_INV_IOMMU_PAGES_SIZE_MASK;
>  }
>=20
> -static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, int =
pasid,
> +static void build_inv_iommu_pasid(struct iommu_cmd *cmd, u16 domid, u32 =
pasid,
>  				  u64 address, bool size)
>  {
>  	memset(cmd, 0, sizeof(*cmd));
> @@ -916,7 +917,7 @@ static void build_inv_iommu_pasid(struct iommu_cmd *c=
md,
> u16 domid, int pasid,
>  	CMD_SET_TYPE(cmd, CMD_INV_IOMMU_PAGES);
>  }
>=20
> -static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, int =
pasid,
> +static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 =
pasid,
>  				  int qdep, u64 address, bool size)
>  {
>  	memset(cmd, 0, sizeof(*cmd));
> @@ -936,7 +937,7 @@ static void build_inv_iotlb_pasid(struct iommu_cmd *c=
md,
> u16 devid, int pasid,
>  	CMD_SET_TYPE(cmd, CMD_INV_IOTLB_PAGES);
>  }
>=20
> -static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, int pas=
id,
> +static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, u32 pas=
id,
>  			       int status, int tag, bool gn)
>  {
>  	memset(cmd, 0, sizeof(*cmd));
> @@ -2772,7 +2773,7 @@ int amd_iommu_domain_enable_v2(struct
> iommu_domain *dom, int pasids)
>  }
>  EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
>=20
> -static int __flush_pasid(struct protection_domain *domain, int pasid,
> +static int __flush_pasid(struct protection_domain *domain, u32 pasid,
>  			 u64 address, bool size)
>  {
>  	struct iommu_dev_data *dev_data;
> @@ -2833,13 +2834,13 @@ static int __flush_pasid(struct protection_domain
> *domain, int pasid,
>  	return ret;
>  }
>=20
> -static int __amd_iommu_flush_page(struct protection_domain *domain, int =
pasid,
> +static int __amd_iommu_flush_page(struct protection_domain *domain, u32 =
pasid,
>  				  u64 address)
>  {
>  	return __flush_pasid(domain, pasid, address, false);
>  }
>=20
> -int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
> +int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
>  			 u64 address)
>  {
>  	struct protection_domain *domain =3D to_pdomain(dom);
> @@ -2854,13 +2855,13 @@ int amd_iommu_flush_page(struct iommu_domain
> *dom, int pasid,
>  }
>  EXPORT_SYMBOL(amd_iommu_flush_page);
>=20
> -static int __amd_iommu_flush_tlb(struct protection_domain *domain, int p=
asid)
> +static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 p=
asid)
>  {
>  	return __flush_pasid(domain, pasid,
> CMD_INV_IOMMU_ALL_PAGES_ADDRESS,
>  			     true);
>  }
>=20
> -int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid)
> +int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
>  {
>  	struct protection_domain *domain =3D to_pdomain(dom);
>  	unsigned long flags;
> @@ -2874,7 +2875,7 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom,
> int pasid)
>  }
>  EXPORT_SYMBOL(amd_iommu_flush_tlb);
>=20
> -static u64 *__get_gcr3_pte(u64 *root, int level, int pasid, bool alloc)
> +static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
>  {
>  	int index;
>  	u64 *pte;
> @@ -2906,7 +2907,7 @@ static u64 *__get_gcr3_pte(u64 *root, int level, in=
t pasid,
> bool alloc)
>  	return pte;
>  }
>=20
> -static int __set_gcr3(struct protection_domain *domain, int pasid,
> +static int __set_gcr3(struct protection_domain *domain, u32 pasid,
>  		      unsigned long cr3)
>  {
>  	struct domain_pgtable pgtable;
> @@ -2925,7 +2926,7 @@ static int __set_gcr3(struct protection_domain *dom=
ain,
> int pasid,
>  	return __amd_iommu_flush_tlb(domain, pasid);
>  }
>=20
> -static int __clear_gcr3(struct protection_domain *domain, int pasid)
> +static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
>  {
>  	struct domain_pgtable pgtable;
>  	u64 *pte;
> @@ -2943,7 +2944,7 @@ static int __clear_gcr3(struct protection_domain *d=
omain,
> int pasid)
>  	return __amd_iommu_flush_tlb(domain, pasid);
>  }
>=20
> -int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
> +int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
>  			      unsigned long cr3)
>  {
>  	struct protection_domain *domain =3D to_pdomain(dom);
> @@ -2958,7 +2959,7 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain
> *dom, int pasid,
>  }
>  EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
>=20
> -int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, int pasid)
> +int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
>  {
>  	struct protection_domain *domain =3D to_pdomain(dom);
>  	unsigned long flags;
> @@ -2972,7 +2973,7 @@ int amd_iommu_domain_clear_gcr3(struct
> iommu_domain *dom, int pasid)
>  }
>  EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
>=20
> -int amd_iommu_complete_ppr(struct pci_dev *pdev, int pasid,
> +int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
>  			   int status, int tag)
>  {
>  	struct iommu_dev_data *dev_data;
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index e4b025c5637c..a769985ff26e 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -40,7 +40,7 @@ struct pasid_state {
>  	struct mmu_notifier mn;                 /* mmu_notifier handle */
>  	struct pri_queue pri[PRI_QUEUE_SIZE];	/* PRI tag states */
>  	struct device_state *device_state;	/* Link to our device_state */
> -	int pasid;				/* PASID index */
> +	u32 pasid;				/* PASID index */
>  	bool invalid;				/* Used during setup and
>  						   teardown of the pasid */
>  	spinlock_t lock;			/* Protect pri_queues and
> @@ -70,7 +70,7 @@ struct fault {
>  	struct mm_struct *mm;
>  	u64 address;
>  	u16 devid;
> -	u16 pasid;
> +	u32 pasid;
>  	u16 tag;
>  	u16 finish;
>  	u16 flags;
> @@ -150,7 +150,7 @@ static void put_device_state(struct device_state *dev=
_state)
>=20
>  /* Must be called under dev_state->lock */
>  static struct pasid_state **__get_pasid_state_ptr(struct device_state *d=
ev_state,
> -						  int pasid, bool alloc)
> +						  u32 pasid, bool alloc)
>  {
>  	struct pasid_state **root, **ptr;
>  	int level, index;
> @@ -184,7 +184,7 @@ static struct pasid_state **__get_pasid_state_ptr(str=
uct
> device_state *dev_state
>=20
>  static int set_pasid_state(struct device_state *dev_state,
>  			   struct pasid_state *pasid_state,
> -			   int pasid)
> +			   u32 pasid)
>  {
>  	struct pasid_state **ptr;
>  	unsigned long flags;
> @@ -211,7 +211,7 @@ static int set_pasid_state(struct device_state *dev_s=
tate,
>  	return ret;
>  }
>=20
> -static void clear_pasid_state(struct device_state *dev_state, int pasid)
> +static void clear_pasid_state(struct device_state *dev_state, u32 pasid)
>  {
>  	struct pasid_state **ptr;
>  	unsigned long flags;
> @@ -229,7 +229,7 @@ static void clear_pasid_state(struct device_state *de=
v_state,
> int pasid)
>  }
>=20
>  static struct pasid_state *get_pasid_state(struct device_state *dev_stat=
e,
> -					   int pasid)
> +					   u32 pasid)
>  {
>  	struct pasid_state **ptr, *ret =3D NULL;
>  	unsigned long flags;
> @@ -594,7 +594,7 @@ static struct notifier_block ppr_nb =3D {
>  	.notifier_call =3D ppr_notifier,
>  };
>=20
> -int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
> +int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
>  			 struct task_struct *task)
>  {
>  	struct pasid_state *pasid_state;
> @@ -615,7 +615,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pa=
sid,
>  		return -EINVAL;
>=20
>  	ret =3D -EINVAL;
> -	if (pasid < 0 || pasid >=3D dev_state->max_pasids)
> +	if (pasid >=3D dev_state->max_pasids)
>  		goto out;
>=20
>  	ret =3D -ENOMEM;
> @@ -679,7 +679,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, int pa=
sid,
>  }
>  EXPORT_SYMBOL(amd_iommu_bind_pasid);
>=20
> -void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid)
> +void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid)
>  {
>  	struct pasid_state *pasid_state;
>  	struct device_state *dev_state;
> @@ -695,7 +695,7 @@ void amd_iommu_unbind_pasid(struct pci_dev *pdev, int
> pasid)
>  	if (dev_state =3D=3D NULL)
>  		return;
>=20
> -	if (pasid < 0 || pasid >=3D dev_state->max_pasids)
> +	if (pasid >=3D dev_state->max_pasids)
>  		goto out;
>=20
>  	pasid_state =3D get_pasid_state(dev_state, pasid);
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 683b812c5c47..2b75a1561377 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1466,7 +1466,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *i=
ommu,
> u16 sid, u16 pfsid,
>  }
>=20
>  void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
> -			  u64 granu, int pasid)
> +			  u64 granu, u32 pasid)
>  {
>  	struct qi_desc desc =3D {.qw1 =3D 0, .qw2 =3D 0, .qw3 =3D 0};
>=20
> @@ -1780,7 +1780,7 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
>  }
>=20
>  static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
> -		u8 fault_reason, int pasid, u16 source_id,
> +		u8 fault_reason, u32 pasid, u16 source_id,
>  		unsigned long long addr)
>  {
>  	const char *reason;
> @@ -1830,7 +1830,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  		u8 fault_reason;
>  		u16 source_id;
>  		u64 guest_addr;
> -		int type, pasid;
> +		u32 pasid;
> +		int type;
>  		u32 data;
>  		bool pasid_present;
>=20
> diff --git a/drivers/iommu/intel/intel-pasid.h b/drivers/iommu/intel/inte=
l-pasid.h
> index c5318d40e0fa..bb5137183145 100644
> --- a/drivers/iommu/intel/intel-pasid.h
> +++ b/drivers/iommu/intel/intel-pasid.h
> @@ -72,7 +72,7 @@ struct pasid_entry {
>  struct pasid_table {
>  	void			*table;		/* pasid table pointer */
>  	int			order;		/* page order of pasid table */
> -	int			max_pasid;	/* max pasid */
> +	u32			max_pasid;	/* max pasid */
>  	struct list_head	dev;		/* device list */
>  };
>=20
> @@ -98,31 +98,31 @@ static inline bool pasid_pte_is_present(struct pasid_=
entry
> *pte)
>  	return READ_ONCE(pte->val[0]) & PASID_PTE_PRESENT;
>  }
>=20
> -extern u32 intel_pasid_max_id;
> +extern unsigned int intel_pasid_max_id;
>  int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
> -void intel_pasid_free_id(int pasid);
> -void *intel_pasid_lookup_id(int pasid);
> +void intel_pasid_free_id(u32 pasid);
> +void *intel_pasid_lookup_id(u32 pasid);
>  int intel_pasid_alloc_table(struct device *dev);
>  void intel_pasid_free_table(struct device *dev);
>  struct pasid_table *intel_pasid_get_table(struct device *dev);
>  int intel_pasid_get_dev_max_id(struct device *dev);
> -struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)=
;
> +struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)=
;
>  int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>  				  struct device *dev, pgd_t *pgd,
> -				  int pasid, u16 did, int flags);
> +				  u32 pasid, u16 did, int flags);
>  int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
> -				   struct device *dev, int pasid);
> +				   struct device *dev, u32 pasid);
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
> -				   struct device *dev, int pasid);
> +				   struct device *dev, u32 pasid);
>  int intel_pasid_setup_nested(struct intel_iommu *iommu,
> -			     struct device *dev, pgd_t *pgd, int pasid,
> +			     struct device *dev, pgd_t *pgd, u32 pasid,
>  			     struct iommu_gpasid_bind_data_vtd *pasid_data,
>  			     struct dmar_domain *domain, int addr_width);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
> -				 struct device *dev, int pasid,
> +				 struct device *dev, u32 pasid,
>  				 bool fault_ignore);
> -int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
> -void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
> +void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d759e7234e98..7d2dbc327c62 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2475,7 +2475,7 @@ dmar_search_domain_by_dev_info(int segment, int bus=
,
> int devfn)
>  static int domain_setup_first_level(struct intel_iommu *iommu,
>  				    struct dmar_domain *domain,
>  				    struct device *dev,
> -				    int pasid)
> +				    u32 pasid)
>  {
>  	int flags =3D PASID_FLAG_SUPERVISOR_MODE;
>  	struct dma_pte *pgd =3D domain->pgd;
> @@ -5155,7 +5155,7 @@ static int aux_domain_add_dev(struct dmar_domain
> *domain,
>  		return -ENODEV;
>=20
>  	if (domain->default_pasid <=3D 0) {
> -		int pasid;
> +		u32 pasid;
>=20
>  		/* No private data needed for the default pasid */
>  		pasid =3D ioasid_alloc(NULL, PASID_MIN,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index c81f0f17c6ba..d8637c020281 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -27,7 +27,7 @@
>  static DEFINE_SPINLOCK(pasid_lock);
>  u32 intel_pasid_max_id =3D PASID_MAX;
>=20
> -int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid)
>  {
>  	unsigned long flags;
>  	u8 status_code;
> @@ -58,7 +58,7 @@ int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigne=
d int
> *pasid)
>  	return ret;
>  }
>=20
> -void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> +void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid)
>  {
>  	unsigned long flags;
>  	u8 status_code;
> @@ -146,7 +146,7 @@ int intel_pasid_alloc_table(struct device *dev)
>  	struct pasid_table *pasid_table;
>  	struct pasid_table_opaque data;
>  	struct page *pages;
> -	int max_pasid =3D 0;
> +	u32 max_pasid =3D 0;
>  	int ret, order;
>  	int size;
>=20
> @@ -168,7 +168,7 @@ int intel_pasid_alloc_table(struct device *dev)
>  	INIT_LIST_HEAD(&pasid_table->dev);
>=20
>  	if (info->pasid_supported)
> -		max_pasid =3D min_t(int, pci_max_pasids(to_pci_dev(dev)),
> +		max_pasid =3D min_t(u32, pci_max_pasids(to_pci_dev(dev)),
>  				  intel_pasid_max_id);
>=20
>  	size =3D max_pasid >> (PASID_PDE_SHIFT - 3);
> @@ -242,7 +242,7 @@ int intel_pasid_get_dev_max_id(struct device *dev)
>  	return info->pasid_table->max_pasid;
>  }
>=20
> -struct pasid_entry *intel_pasid_get_entry(struct device *dev, int pasid)
> +struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
>  {
>  	struct device_domain_info *info;
>  	struct pasid_table *pasid_table;
> @@ -251,8 +251,7 @@ struct pasid_entry *intel_pasid_get_entry(struct devi=
ce *dev,
> int pasid)
>  	int dir_index, index;
>=20
>  	pasid_table =3D intel_pasid_get_table(dev);
> -	if (WARN_ON(!pasid_table || pasid < 0 ||
> -		    pasid >=3D intel_pasid_get_dev_max_id(dev)))
> +	if (WARN_ON(!pasid_table || pasid >=3D intel_pasid_get_dev_max_id(dev))=
)
>  		return NULL;
>=20
>  	dir =3D pasid_table->table;
> @@ -305,7 +304,7 @@ static inline void pasid_clear_entry_with_fpd(struct
> pasid_entry *pe)
>  }
>=20
>  static void
> -intel_pasid_clear_entry(struct device *dev, int pasid, bool fault_ignore=
)
> +intel_pasid_clear_entry(struct device *dev, u32 pasid, bool fault_ignore=
)
>  {
>  	struct pasid_entry *pe;
>=20
> @@ -444,7 +443,7 @@ pasid_set_eafe(struct pasid_entry *pe)
>=20
>  static void
>  pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
> -				    u16 did, int pasid)
> +				    u16 did, u32 pasid)
>  {
>  	struct qi_desc desc;
>=20
> @@ -473,7 +472,7 @@ iotlb_invalidation_with_pasid(struct intel_iommu *iom=
mu,
> u16 did, u32 pasid)
>=20
>  static void
>  devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
> -			       struct device *dev, int pasid)
> +			       struct device *dev, u32 pasid)
>  {
>  	struct device_domain_info *info;
>  	u16 sid, qdep, pfsid;
> @@ -490,7 +489,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *io=
mmu,
>  }
>=20
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct devic=
e *dev,
> -				 int pasid, bool fault_ignore)
> +				 u32 pasid, bool fault_ignore)
>  {
>  	struct pasid_entry *pte;
>  	u16 did;
> @@ -515,7 +514,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu
> *iommu, struct device *dev,
>=20
>  static void pasid_flush_caches(struct intel_iommu *iommu,
>  				struct pasid_entry *pte,
> -				int pasid, u16 did)
> +			       u32 pasid, u16 did)
>  {
>  	if (!ecap_coherent(iommu->ecap))
>  		clflush_cache_range(pte, sizeof(*pte));
> @@ -534,7 +533,7 @@ static void pasid_flush_caches(struct intel_iommu *io=
mmu,
>   */
>  int intel_pasid_setup_first_level(struct intel_iommu *iommu,
>  				  struct device *dev, pgd_t *pgd,
> -				  int pasid, u16 did, int flags)
> +				  u32 pasid, u16 did, int flags)
>  {
>  	struct pasid_entry *pte;
>=20
> @@ -607,7 +606,7 @@ static inline int iommu_skip_agaw(struct dmar_domain
> *domain,
>   */
>  int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
> -				   struct device *dev, int pasid)
> +				   struct device *dev, u32 pasid)
>  {
>  	struct pasid_entry *pte;
>  	struct dma_pte *pgd;
> @@ -665,7 +664,7 @@ int intel_pasid_setup_second_level(struct intel_iommu
> *iommu,
>   */
>  int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>  				   struct dmar_domain *domain,
> -				   struct device *dev, int pasid)
> +				   struct device *dev, u32 pasid)
>  {
>  	u16 did =3D FLPT_DEFAULT_DID;
>  	struct pasid_entry *pte;
> @@ -751,7 +750,7 @@ intel_pasid_setup_bind_data(struct intel_iommu *iommu=
,
> struct pasid_entry *pte,
>   * @addr_width: Address width of the first level (guest)
>   */
>  int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *d=
ev,
> -			     pgd_t *gpgd, int pasid,
> +			     pgd_t *gpgd, u32 pasid,
>  			     struct iommu_gpasid_bind_data_vtd *pasid_data,
>  			     struct dmar_domain *domain, int addr_width)
>  {
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 6c87c807a0ab..778089d198eb 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -23,7 +23,7 @@
>  #include "intel-pasid.h"
>=20
>  static irqreturn_t prq_event_thread(int irq, void *d);
> -static void intel_svm_drain_prq(struct device *dev, int pasid);
> +static void intel_svm_drain_prq(struct device *dev, u32 pasid);
>=20
>  #define PRQ_ORDER 0
>=20
> @@ -371,7 +371,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain=
,
> struct device *dev,
>  	return ret;
>  }
>=20
> -int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> +int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
>  {
>  	struct intel_iommu *iommu =3D intel_svm_device_to_iommu(dev);
>  	struct intel_svm_dev *sdev;
> @@ -601,7 +601,7 @@ intel_svm_bind_mm(struct device *dev, int flags, stru=
ct
> svm_dev_ops *ops,
>  }
>=20
>  /* Caller must hold pasid_mutex */
> -static int intel_svm_unbind_mm(struct device *dev, int pasid)
> +static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>  {
>  	struct intel_svm_dev *sdev;
>  	struct intel_iommu *iommu;
> @@ -728,7 +728,7 @@ static bool is_canonical_address(u64 addr)
>   * described in VT-d spec CH7.10 to drain all page requests and page
>   * responses pending in the hardware.
>   */
> -static void intel_svm_drain_prq(struct device *dev, int pasid)
> +static void intel_svm_drain_prq(struct device *dev, u32 pasid)
>  {
>  	struct device_domain_info *info;
>  	struct dmar_domain *domain;
> @@ -988,10 +988,10 @@ void intel_svm_unbind(struct iommu_sva *sva)
>  	mutex_unlock(&pasid_mutex);
>  }
>=20
> -int intel_svm_get_pasid(struct iommu_sva *sva)
> +u32 intel_svm_get_pasid(struct iommu_sva *sva)
>  {
>  	struct intel_svm_dev *sdev;
> -	int pasid;
> +	u32 pasid;
>=20
>  	mutex_lock(&pasid_mutex);
>  	sdev =3D to_intel_svm_dev(sva);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d43120eb1dc5..56dbabdd7f5f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2828,7 +2828,7 @@ void iommu_sva_unbind_device(struct iommu_sva
> *handle)
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
>=20
> -int iommu_sva_get_pasid(struct iommu_sva *handle)
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  {
>  	const struct iommu_ops *ops =3D handle->dev->bus->iommu_ops;
>=20
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 107028e77ca3..5cc6ebccba65 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -92,7 +92,7 @@ static long uacce_fops_compat_ioctl(struct file *filep,
>=20
>  static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_que=
ue *q)
>  {
> -	int pasid;
> +	u32 pasid;
>  	struct iommu_sva *handle;
>=20
>  	if (!(uacce->flags & UACCE_DEV_SVA))
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index 21e950e4ab62..450717299928 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -76,7 +76,7 @@ extern void amd_iommu_free_device(struct pci_dev *pdev)=
;
>   *
>   * The function returns 0 on success or a negative value on error.
>   */
> -extern int amd_iommu_bind_pasid(struct pci_dev *pdev, int pasid,
> +extern int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
>  				struct task_struct *task);
>=20
>  /**
> @@ -88,7 +88,7 @@ extern int amd_iommu_bind_pasid(struct pci_dev *pdev, i=
nt
> pasid,
>   * When this function returns the device is no longer using the PASID
>   * and the PASID is no longer bound to its task.
>   */
> -extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, int pasid);
> +extern void amd_iommu_unbind_pasid(struct pci_dev *pdev, u32 pasid);
>=20
>  /**
>   * amd_iommu_set_invalid_ppr_cb() - Register a call-back for failed
> @@ -114,7 +114,7 @@ extern void amd_iommu_unbind_pasid(struct pci_dev *pd=
ev,
> int pasid);
>  #define AMD_IOMMU_INV_PRI_RSP_FAIL	2
>=20
>  typedef int (*amd_iommu_invalid_ppr_cb)(struct pci_dev *pdev,
> -					int pasid,
> +					u32 pasid,
>  					unsigned long address,
>  					u16);
>=20
> @@ -166,7 +166,7 @@ extern int amd_iommu_device_info(struct pci_dev *pdev=
,
>   * @cb: The call-back function
>   */
>=20
> -typedef void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, int pasid=
);
> +typedef void (*amd_iommu_invalidate_ctx)(struct pci_dev *pdev, u32 pasid=
);
>=20
>  extern int amd_iommu_set_invalidate_ctx_cb(struct pci_dev *pdev,
>  					   amd_iommu_invalidate_ctx cb);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 3e8fa1c7a1e6..643951e28dd4 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -550,7 +550,7 @@ struct dmar_domain {
>  					   2 =3D=3D 1GiB, 3 =3D=3D 512GiB, 4 =3D=3D 1TiB */
>  	u64		max_addr;	/* maximum mapped address */
>=20
> -	int		default_pasid;	/*
> +	u32		default_pasid;	/*
>  					 * The default pasid used for non-SVM
>  					 * traffic on mediated devices.
>  					 */
> @@ -707,7 +707,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iom=
mu,
> u16 sid, u16 pfsid,
>  			      u32 pasid, u16 qdep, u64 addr,
>  			      unsigned int size_order, u64 granu);
>  void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
> -			  int pasid);
> +			  u32 pasid);
>=20
>  int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>  		   unsigned int count, unsigned long options);
> @@ -735,11 +735,11 @@ extern int intel_svm_enable_prq(struct intel_iommu
> *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>  int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *de=
v,
>  			  struct iommu_gpasid_bind_data *data);
> -int intel_svm_unbind_gpasid(struct device *dev, int pasid);
> +int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
>  struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *m=
m,
>  				 void *drvdata);
>  void intel_svm_unbind(struct iommu_sva *handle);
> -int intel_svm_get_pasid(struct iommu_sva *handle);
> +u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  struct svm_dev_ops;
>=20
>  struct intel_svm_dev {
> @@ -748,7 +748,7 @@ struct intel_svm_dev {
>  	struct device *dev;
>  	struct svm_dev_ops *ops;
>  	struct iommu_sva sva;
> -	int pasid;
> +	u32 pasid;
>  	int users;
>  	u16 did;
>  	u16 dev_iotlb:1;
> @@ -761,7 +761,7 @@ struct intel_svm {
>=20
>  	struct intel_iommu *iommu;
>  	int flags;
> -	int pasid;
> +	u32 pasid;
>  	int gpasid; /* In case that guest PASID is different from host PASID */
>  	struct list_head devs;
>  	struct list_head list;
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index c9e7e601950d..39d368a810b8 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -11,7 +11,7 @@
>  struct device;
>=20
>  struct svm_dev_ops {
> -	void (*fault_cb)(struct device *dev, int pasid, u64 address,
> +	void (*fault_cb)(struct device *dev, u32 pasid, u64 address,
>  			 void *private, int rwxp, int response);
>  };
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5f0b7859d2eb..9188ec5b39c5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -292,7 +292,7 @@ struct iommu_ops {
>  	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
>  				      void *drvdata);
>  	void (*sva_unbind)(struct iommu_sva *handle);
> -	int (*sva_get_pasid)(struct iommu_sva *handle);
> +	u32 (*sva_get_pasid)(struct iommu_sva *handle);
>=20
>  	int (*page_response)(struct device *dev,
>  			     struct iommu_fault_event *evt,
> @@ -302,7 +302,7 @@ struct iommu_ops {
>  	int (*sva_bind_gpasid)(struct iommu_domain *domain,
>  			struct device *dev, struct iommu_gpasid_bind_data *data);
>=20
> -	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
> +	int (*sva_unbind_gpasid)(struct device *dev, u32 pasid);
>=20
>  	int (*def_domain_type)(struct device *dev);
>=20
> @@ -656,7 +656,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device
> *dev,
>  					struct mm_struct *mm,
>  					void *drvdata);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
> -int iommu_sva_get_pasid(struct iommu_sva *handle);
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>=20
>  #else /* CONFIG_IOMMU_API */
>=20
> @@ -1049,7 +1049,7 @@ static inline void iommu_sva_unbind_device(struct
> iommu_sva *handle)
>  {
>  }
>=20
> -static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
> +static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  {
>  	return IOMMU_PASID_INVALID;
>  }
> @@ -1068,7 +1068,7 @@ static inline int iommu_sva_bind_gpasid(struct
> iommu_domain *domain,
>  }
>=20
>  static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -					   struct device *dev, int pasid)
> +					   struct device *dev, u32 pasid)
>  {
>  	return -ENODEV;
>  }
> diff --git a/include/linux/uacce.h b/include/linux/uacce.h
> index 454c2f6672d7..48e319f40275 100644
> --- a/include/linux/uacce.h
> +++ b/include/linux/uacce.h
> @@ -81,7 +81,7 @@ struct uacce_queue {
>  	struct list_head list;
>  	struct uacce_qfile_region *qfrs[UACCE_MAX_REGION];
>  	enum uacce_q_state state;
> -	int pasid;
> +	u32 pasid;
>  	struct iommu_sva *handle;
>  };
>=20
> --
> 2.19.1
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
