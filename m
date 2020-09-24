Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F8D276FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgIXL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIXL1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:27:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4A0C0613CE;
        Thu, 24 Sep 2020 04:27:30 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so3160226wmi.1;
        Thu, 24 Sep 2020 04:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tLMDNFt9TJF/ZryOzL1ilHgxO48Y454udYyrZfWfvtQ=;
        b=KE9bXRFAViekuZoQZduiZKVxdWJdrkIl2nLqMZo98FdrI2wiDLcGMDaJ4mPks0qBOl
         MMZGVnsc5FWJkREASoSaaYGas7QORH0Y4IMjXqUJZ9qMnmY/dYGtJ11e5xbrcCG4a2lC
         QO5ulEPD55sfnzYwi5M1/ChtdiZdWlVdLsDcr/QsyTrcT+5OqWPdVymYV/39Vd9iGXxT
         B7UHReiElDB66vlbn0XCRg8J3wws7U9E2uoIcpk3rx4YRx4IxirinXjeePIeawmAw6GD
         g+MN3djt+ctElTBdm2Oidz9ASuhLPBgM1AmCdSw/x1oa78MFUnbONXDQIjAsY/LNeN6z
         ypog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLMDNFt9TJF/ZryOzL1ilHgxO48Y454udYyrZfWfvtQ=;
        b=bIaMIS6io8ziZwExpDR+7kv0Icho1QAHJfUZnh+ZmAEAsd+BC2fjMKySQugTDfpbFR
         V3UTiyNqxVz8NNSNmf303pSnbGHEnbX4DEqkAlxrHKmp61MwnN5ZttpcaBiHOPjwX2yR
         weNL53En/aze2HxPKTJoH5D0WD+BH8SG0NpHjpWzBtTLzGbhVvOCjLvW2F/qvZHDB/6v
         6Orvllwl6dcJKcikYaYHjSgpy8kCWBQ/evqsW+q2lo7dgPVDfKn63wz8ScH/7V5fG598
         rIRdFEK63gFWOLxw6x8cBqzqqATOpRBOFbUM1ZbsZBt3Zl1X5ScgMH9nZUFp908OzfmY
         5c7w==
X-Gm-Message-State: AOAM530z4rJNi+IJTaw/H/c3bfXHeZxacbbwbE8N3qouRk+KS1lAGscd
        dsN+ToxIoJ07tejkjxvTcug=
X-Google-Smtp-Source: ABdhPJzzr875MyIIlAKjUsDN40VPniPu1+Ti6Bzsj+dgGRxzdCtL/zGiHjqFXhZtmTarjQZLVFj8Hw==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr4311728wmg.117.1600946849132;
        Thu, 24 Sep 2020 04:27:29 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id t124sm3381875wmg.31.2020.09.24.04.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 04:27:27 -0700 (PDT)
Date:   Thu, 24 Sep 2020 13:27:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20200924112725.GA2486709@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus>
 <20200915123648.GA3496938@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <20200915123648.GA3496938@ulmo>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrote:
> On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> > On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >=20
> > > Reserved memory regions can be marked as "active" if hardware is
> > > expected to access the regions during boot and before the operating
> > > system can take control. One example where this is useful is for the
> > > operating system to infer whether the region needs to be identity-
> > > mapped through an IOMMU.
> >=20
> > I like simple solutions, but this hardly seems adequate to solve the=20
> > problem of passing IOMMU setup from bootloader/firmware to the OS. Like=
=20
> > what is the IOVA that's supposed to be used if identity mapping is not=
=20
> > used?
>=20
> The assumption here is that if the region is not active there is no need
> for the IOVA to be specified because the kernel will allocate memory and
> assign any IOVA of its choosing.
>=20
> Also, note that this is not meant as a way of passing IOMMU setup from
> the bootloader or firmware to the OS. The purpose of this is to specify
> that some region of memory is actively being accessed during boot. The
> particular case that I'm looking at is where the bootloader set up a
> splash screen and keeps it on during boot. The bootloader has not set up
> an IOMMU mapping and the identity mapping serves as a way of keeping the
> accesses by the display hardware working during the transitional period
> after the IOMMU translations have been enabled by the kernel but before
> the kernel display driver has had a chance to set up its own IOMMU
> mappings.
>=20
> > If you know enough about the regions to assume identity mapping, then=
=20
> > can't you know if active or not?
>=20
> We could alternatively add some property that describes the region as
> requiring an identity mapping. But note that we can't make any
> assumptions here about the usage of these regions because the IOMMU
> driver simply has no way of knowing what they are being used for.
>=20
> Some additional information is required in device tree for the IOMMU
> driver to be able to make that decision.

Rob, can you provide any hints on exactly how you want to move this
forward? I don't know in what direction you'd like to proceed.

Thierry

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9sgpsACgkQ3SOs138+
s6HU/BAAsp4ztlRhFpoZxRRVHt3XKaVuNsn3yxThPMn67Xbk9U6QwWaY+ssNTMuZ
7oM3m4GgdUJ7vl1eoDNg7levtLHtMnhdXeEFSvBqkmPcxoPxSpll3mlMZk00uOX9
ZKx9+fMOIhZj3vlnfAquU9uhOMAOivIEDZhLYQ8ic2Yr8kA2utHOpTNI61XOOVRh
SphmnAYnJOkhvHehAIDc8M1qZH0ZQYUeJONEBRNK/wihFbiHeLnYY0FE0b5vxQpj
rKzDGsGcd0tZc+s6PmT1v2OQru3rA6MWl6FGKwI0UzUouZG+dLQybLWBeY4mNCP/
L6QjVVZa8oeQ5M+JIcEiIDbRrB4X/2M7is/539AwJ2IhBoIRZpr5LCbeVK/b//O7
m0Tw1kV4ibrXzVLD0YKB0Ls4KF1gztmLrZcfUy5/qqP0TdzZWfwxmbW/M0PTSRG8
oPK5W0TViRW9rn1B3RibGFUKdCXdassKFZWYWO5/FCEP4ijOrhsVbLHrMrkwBzBU
YsAaqJDWCbl+xmHwT/2E/wWtCpjsuGmbscAfJ6lhKwQJcTfPsnIV0G9luXZxMoYu
nFuWN2RBDnARwPqr6jubxe8evniLQSCE7PUZ2VdJYOlMt+3DEzrpx2JVdd/UysTa
tP5K57t2OyxVjIEgcdBrxAYL0Uf/tgNMGk5LqNd8ZYyr7EHdFgM=
=xZhX
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
