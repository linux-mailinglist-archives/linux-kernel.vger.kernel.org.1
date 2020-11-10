Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CC2ADFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732839AbgKJTdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbgKJTdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:33:14 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C856C0613D1;
        Tue, 10 Nov 2020 11:33:14 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so4316063wme.1;
        Tue, 10 Nov 2020 11:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5mMVQMlAu/av9/BrtsRhGFbb3lLOqH9OnWPD2qStzFE=;
        b=bG8rarOe+fIadMkmq88JbIQRCyaAQwg/ZL4t/ZmDMnvQcARZdR/PLrPaxmgUmRaq3N
         tYdIwoOgsX3edTExlQdUzUi7OZz++ePMJXY3HBnIp1N/cyy/HgVkuUzIpGcRwQ/ROM5P
         OrAvxwG729nxrXk7oaBkISLjbz3RwufurLsuTF5qJ3K2hVHf5KuYcSZ91bHufCFV0f4R
         kNbez7y0WhYVO2b/5J3w1yCNyukUiB4DbpqAY2WSVgi7fbMhx5h82wpvoU0JvwZG6C77
         5CqAKIbS71SmPkfrtXxhcWVuu4bKxkftjrzrLxkPxRLzDiwAjsrk9HcFxqwDMvSlUu2Z
         PZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mMVQMlAu/av9/BrtsRhGFbb3lLOqH9OnWPD2qStzFE=;
        b=PDiKssPHZEeDdS/EP51gpLxcb9Na60V75y2w5vtxJWtNxfNwVN1G3EczbDzCOvDHKW
         5x8DB8A4x93gfyxypmyvCRv7oDgd7NNUA2QDqYTb+/AFxEyHQ092eavQnPCNgzypk2zg
         YUHi0ZF9QwCfQdRKHCSmIbQTzGn8NZXjnwwDAkeBJGqQYrCLo8k15ZNG0qQwE1kXUexR
         gqMO6BGaP3p28DWCeEqwGiWtnLFI4sRu5J/CN5jUh0yhyc3lIH2pUBJMn01uHEzH8+ME
         jFKYWW3uFpVuR+FC756QXNk8SiF8fKabCT10ZArlOEm1vWeKQTafLjOj1+3NSlC8v4+K
         oOtg==
X-Gm-Message-State: AOAM531BaHGOvxRBVV5PxOpiJbhZHqRbolHltzU3XdpnWzPAEI4Q2KHZ
        beDyKyGE/B8Qn5t+3L1XtWk=
X-Google-Smtp-Source: ABdhPJw8jRGgBClN8UTnXmSnwJiFZ4TrYZIrC9+vZDi0VZDkM9In93jw/P2bqEsSvo0aLZsQfEb4HA==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr746440wmh.46.1605036792714;
        Tue, 10 Nov 2020 11:33:12 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id s13sm417213wrv.43.2020.11.10.11.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:33:11 -0800 (PST)
Date:   Tue, 10 Nov 2020 20:33:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20201110193309.GB2303484@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus>
 <20200915123648.GA3496938@ulmo>
 <20200924112725.GA2486709@ulmo>
 <20201105164312.GD485884@ulmo>
 <483cd043-980e-81fb-cccb-385206a699df@arm.com>
 <20201106152548.GA767203@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <20201106152548.GA767203@ulmo>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 04:25:48PM +0100, Thierry Reding wrote:
> On Thu, Nov 05, 2020 at 05:47:21PM +0000, Robin Murphy wrote:
> > On 2020-11-05 16:43, Thierry Reding wrote:
> > > On Thu, Sep 24, 2020 at 01:27:25PM +0200, Thierry Reding wrote:
> > > > On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrote:
> > > > > On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> > > > > > On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > >=20
> > > > > > > Reserved memory regions can be marked as "active" if hardware=
 is
> > > > > > > expected to access the regions during boot and before the ope=
rating
> > > > > > > system can take control. One example where this is useful is =
for the
> > > > > > > operating system to infer whether the region needs to be iden=
tity-
> > > > > > > mapped through an IOMMU.
> > > > > >=20
> > > > > > I like simple solutions, but this hardly seems adequate to solv=
e the
> > > > > > problem of passing IOMMU setup from bootloader/firmware to the =
OS. Like
> > > > > > what is the IOVA that's supposed to be used if identity mapping=
 is not
> > > > > > used?
> > > > >=20
> > > > > The assumption here is that if the region is not active there is =
no need
> > > > > for the IOVA to be specified because the kernel will allocate mem=
ory and
> > > > > assign any IOVA of its choosing.
> > > > >=20
> > > > > Also, note that this is not meant as a way of passing IOMMU setup=
 from
> > > > > the bootloader or firmware to the OS. The purpose of this is to s=
pecify
> > > > > that some region of memory is actively being accessed during boot=
=2E The
> > > > > particular case that I'm looking at is where the bootloader set u=
p a
> > > > > splash screen and keeps it on during boot. The bootloader has not=
 set up
> > > > > an IOMMU mapping and the identity mapping serves as a way of keep=
ing the
> > > > > accesses by the display hardware working during the transitional =
period
> > > > > after the IOMMU translations have been enabled by the kernel but =
before
> > > > > the kernel display driver has had a chance to set up its own IOMMU
> > > > > mappings.
> > > > >=20
> > > > > > If you know enough about the regions to assume identity mapping=
, then
> > > > > > can't you know if active or not?
> > > > >=20
> > > > > We could alternatively add some property that describes the regio=
n as
> > > > > requiring an identity mapping. But note that we can't make any
> > > > > assumptions here about the usage of these regions because the IOM=
MU
> > > > > driver simply has no way of knowing what they are being used for.
> > > > >=20
> > > > > Some additional information is required in device tree for the IO=
MMU
> > > > > driver to be able to make that decision.
> > > >=20
> > > > Rob, can you provide any hints on exactly how you want to move this
> > > > forward? I don't know in what direction you'd like to proceed.
> > >=20
> > > Hi Rob,
> > >=20
> > > do you have any suggestions on how to proceed with this? I'd like to =
get
> > > this moving again because it's something that's been nagging me for s=
ome
> > > months now. It also requires changes across two levels in the bootloa=
der
> > > stack as well as Linux and it takes quite a bit of work to make all t=
he
> > > changes, so before I go and rewrite everything I'd like to get the DT
> > > bindings sorted out first.
> > >=20
> > > So just to summarize why I think this simple solution is good enough:=
 it
> > > tries to solve a very narrow and simple problem. This is not an attem=
pt
> > > at describing the firmware's full IOMMU setup to the kernel. In fact,=
 it
> > > is primarily targetted at cases where the firmware hasn't setup an IO=
MMU
> > > at all, and we just want to make sure that when the kernel takes over
> > > and does want to enable the IOMMU, that all the regions that are
> > > actively being accessed by non-quiesced hardware (the most typical
> > > example would be a framebuffer scanning out a splat screen or animati=
on,
> > > but it could equally well be some sort of welcoming tone or music bei=
ng
> > > played back) are described in device tree.
> > >=20
> > > In other words, and this is perhaps better answering your second
> > > question: in addition to describing reserved memory regions, we want =
to
> > > add a bit of information here about the usage of these memory regions.
> > > Some memory regions may contain information that the kernel may want =
to
> > > use (such an external memory frequency scaling tables) and those I wo=
uld
> > > describe as "inactive" memory because it isn't being accessed by
> > > hardware. The framebuffer in this case is the opposite and it is being
> > > actively accessed (hence it is marked "active") by hardware while the
> > > kernel is busy setting everything up so that it can reconfigure that
> > > hardware and take over with its own framebuffer (for the console, for
> > > example). It's also not so much that we know enough about the region =
to
> > > assume it needs identity mapping. We don't really care about that from
> > > the DT point of view. In fact, depending on the rest of the system
> > > configuration, we may not need identity mapping (i.e. if none of the
> > > users of the reserved memory region are behind an IOMMU). But the poi=
nt
> > > here is that the IOMMU drivers can use this "active" property to
> > > determine that if a device is using an "active" region and it is behi=
nd
> > > an IOMMU, then it must identity map that region in order for the
> > > hardware, which is not under the kernel's control yet, to be able to
> > > continue to access that memory through an IOMMU mapping.
> >=20
> > Hmm, "active" is not a property of the memory itself, though, it's real=
ly a
> > property of the device accessing it. If several distinct devices share a
> > carveout region, and for simplicity the bootloader marks it as active
> > because one of those devices happens to be using some part of it at boo=
t, we
> > don't really want to have to do all the reserved region setup for all t=
he
> > other devices unnecessarily, when all that matters is not disrupting on=
e of
> > them when resetting the IOMMU.
> >=20
> > That leads to another possible hiccup - some bindings already have a de=
fined
> > meaning for a "memory-region" property. If we use that to point to some
> > small region for a temporary low-resolution bootsplash screen for visib=
ility
> > to an IOMMU driver, the device's own driver might also interpret it as a
> > private carveout from which it is expected to allocate everything, and =
thus
> > could end up failing to work well or at all.
> >=20
> > I agree that we should only need a relatively simple binding, and that
> > piggybacking off reserved-memory nodes seems like an ideal way of getti=
ng
> > address range descriptions without too much extra complexity; the tricky
> > part is how best to associate those with the other information needed, =
which
> > is really the "iommus" property of the relevant device, and how to make=
 it
> > as generically discoverable as possible. Perhaps it might be workable to
> > follow almost the same approach but with a dedicated property (e.g.
> > "active-memory-region") that the IOMMU code can simply scan the DT for =
to
> > determine relevant device nodes. Otherwise properties on the IOMMU node
> > itself would seem the next most practical option.
>=20
> We did recently introduce a "memory-region-names" property that's used
> to add context for cases where multiple memory regions are used. Perhaps
> the simplest to address the above would be to describe the region as
> active by naming it "active". That has the disadvantage of restricting
> the number of active regions to 1, though I suspect that may even be
> enough for the vast majority of cases where we need this. This would be
> similar to how we use the "dma-mem" string in the "interconnect-names"
> property to specify the "DMA parent" of a device node.
>=20
> Alternatively, we could perhaps support multiple occurrences of "active"
> in the "memory-region-names" property. Or we could add a bit of
> flexibility by considering all memory regions whose names have an
> "active-" prefix as being active.
>=20
> > We've also finally got things going on the IORT RMR side[1], which help=
s add
> > a bit more shape to things too; beyond the actual firmware parsing, DT =
and
> > ACPI systems should definitely be converging on the same internal
> > implementation in the IOMMU layer.
>=20
> Yeah, from a quick look at that series, this actually sounds really
> close to what I'm trying to achieve here.
>=20
> The patch set that I have would nicely complement the code added to
> iommu_dma_get_resv_regions() for RMR regions. It's not exactly the same
> code, but it's basically the DT equivalent of
> iort_dev_rmr_get_resv_regions().

Hi Rob,

what's your preference here for DT bindings? Do you want me to reuse the
existing memory-region/memory-region-names properties, or do you want
something completely separate?

Thierry

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+q6vMACgkQ3SOs138+
s6HFwA//RvTsH3Razxq0jUpBglouVngfodC8jjeEUJ5gHRLh6ln8d+vkh5Qifz4L
acZrCXFUyPuhnKSg+jzkmvufYkiJ1Z16mGzjnKtV420hoBrLZLFS3SBQORU0MSHj
C1bV32HkFSJAIcECA+p2O71ns0bdmhzh2oIUNwtpCSCL612trtm8gzekvuDW3P5C
WBaRoLQMB9CBfs9r2Xt8xhL9nthQKqr5x8Rj2RMWxYbVJ5BK/Co9ZCd4bVSTO6wi
t0edy969cP3ShmKF5vsGufahoVFrsDh/XkvFvCw9fc+KDK7BK855c/E1jIn2DDlE
ZCPvRQfRImVvWr6uj3CMBaZ4aQAFB+aO8f13fXQ+0fdNLT2X7S8hcjFyNlu3GBKr
bKWOhdeDQ8LCvbLwzqndqz3yfR/3dNmTPLhs4Ebw7oiw7cUehnRoqow8uLlXqyD3
/iQJ88P/gutRxgRyin2By+jztGMcxHbvhxmmKM7IJTwDZELSW23jTw9bxIgD57hz
VoEPH5XwHWHWrhKteF0UsgaS1KwKWQ7SsYex/VNEpFQuu094ZwmjRthP3dvG01V/
sbre0QUgmiE+zZ0SusAds+f4dcrB+6nS4GUAuf0jQL6EQEpP8ypSWPJY8+PQgMCC
uC/lqN1gIaornGLd1SAG3fXL4f7l4WFH3cGsTQbDEMPioW6vrNY=
=Jnjt
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
