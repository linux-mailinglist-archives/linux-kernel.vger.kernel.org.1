Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE1295763
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507645AbgJVE4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507638AbgJVE4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:56:49 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F5BC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:56:47 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v5so444575wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y5P/hyU4ScvAx/EuzAVzabXFsXcQii1dHFcND32fY44=;
        b=QG4642Xxh4SfN4OSOAOu9x60OncbquO6Ht7WBZcZXSdYNGDKlyL7jqNBEeS3vVbyZW
         4/m6kprv7jgurEUAMc1UILxnn2x1UgJyViNlYqzPDiBrQIOhI0qi/WBWNmkF+1fEmKHK
         1RqeQeDRrwlIvSfuFai9e6dA+j2PitHcSCZmXi4lr88o/84wjARxXQeSRYZ4Qzn4yImP
         g9g9gRfMm6afAzJLHsWFWtKoWjQBeJVHeMnSr/JKsZlHGr4FYqxJWMkLzyFxF5cIzKN7
         0AoRHReAyGvdoqTkNajnXL5vxMPO1nrMHDZv+6mjRrQfVKettuATAsh+gOLxailVpV1Q
         oH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y5P/hyU4ScvAx/EuzAVzabXFsXcQii1dHFcND32fY44=;
        b=tbAMfq6n8b7xF0uGRBwH2wQYJ9oqQr11dNFfn2hhMkDPG4RecThzG8bB3tE/bE9689
         DiJfcTJ4Qq5XR6TcdgEkP84prM55xH9chykUDTrvNw7z9gtsQig0o880tk1virqCVnPJ
         vyMbIwQaxzJp5NXqrsmjdGqu67qa4QBlBZa7ed0t9chaI19zJneJWv1LSudTWUO4bVWp
         sqxoXyAQTc6qmvtnkcpZnp6dXTz6dn4zLusTNAJJ8OPgXGYiKE/JMUGlYacDtwWp8xvO
         nYqEGHt2VaO+Qbpf60iBN8tm3223UHjL+b1ARLcN0fSyE2aOGj2Pze/hEJxLiVZvlEY3
         JwOA==
X-Gm-Message-State: AOAM531e2Ny1cBhzZR/73qEelX39V7eZGpS/zB1aShKIbFftjznllMhq
        KNeQPhZ7I7Vr8irydv311LaYQFfxTjIs+p+CI4w=
X-Google-Smtp-Source: ABdhPJzDSZHkXyivAg1JC/UinLS//1E7fm00gygHDmWVOvMP2nVYANSGY3iwZPGaPnBVnJuW/hUgPjMU2IOJhamzao8=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr658734wma.70.1603342603598;
 Wed, 21 Oct 2020 21:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201019144311.18260-1-trix@redhat.com> <2f951197-b93e-d0c9-153f-2ddd1b195b3f@amd.com>
 <7179e50d-f29b-811d-030b-f2cfe3a1a502@amd.com>
In-Reply-To: <7179e50d-f29b-811d-030b-f2cfe3a1a502@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 22 Oct 2020 00:56:31 -0400
Message-ID: <CADnq5_NdJ36NZbWwL4QT5ZNKX4wEbyJNB2NOaoxpMyrs8RBjHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unneeded break
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        trix@redhat.com, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        yogesh.mohanmarimuthu@amd.com, "Cyr, Aric" <Aric.Cyr@amd.com>,
        Igor.Kravchenko@amd.com, Colin Ian King <colin.king@canonical.com>,
        Tao Zhou <tao.zhou1@amd.com>, Dennis Li <Dennis.Li@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Oct 19, 2020 at 11:08 AM Harry Wentland <harry.wentland@amd.com> wr=
ote:
>
> On 2020-10-19 10:55 a.m., Christian K=C3=B6nig wrote:
> > Am 19.10.20 um 16:43 schrieb trix@redhat.com:
> >> From: Tom Rix <trix@redhat.com>
> >>
> >> A break is not needed if it is preceded by a return or break
> >>
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> >
> >> ---
> >>   drivers/gpu/drm/amd/display/dc/dce/dce_transform.c      | 1 -
> >>   drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 7 -------
> >>   drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 7 -------
> >>   drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 7 -------
> >>   drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 7 -------
> >>   drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c   | 7 -------
> >>   drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 7 -------
> >>   7 files changed, 43 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> >> b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> >> index 2a32b66959ba..130a0a0c8332 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> >> @@ -1330,7 +1330,6 @@ static bool configure_graphics_mode(
> >>               REG_SET(OUTPUT_CSC_CONTROL, 0,
> >>                   OUTPUT_CSC_GRPH_MODE, 0);
> >>               break;
> >> -            break;
> >>           case COLOR_SPACE_SRGB_LIMITED:
> >>               /* TV RGB */
> >>               REG_SET(OUTPUT_CSC_CONTROL, 0,
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> >> b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> >> index d741787f75dc..42c7d157da32 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
> >> @@ -418,25 +418,18 @@ static int map_transmitter_id_to_phy_instance(
> >>       switch (transmitter) {
> >>       case TRANSMITTER_UNIPHY_A:
> >>           return 0;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_B:
> >>           return 1;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_C:
> >>           return 2;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_D:
> >>           return 3;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_E:
> >>           return 4;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_F:
> >>           return 5;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_G:
> >>           return 6;
> >> -    break;
> >>       default:
> >>           ASSERT(0);
> >>           return 0;
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> >> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> >> index 2bbfa2e176a9..382581c4a674 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> >> @@ -471,25 +471,18 @@ static int map_transmitter_id_to_phy_instance(
> >>       switch (transmitter) {
> >>       case TRANSMITTER_UNIPHY_A:
> >>           return 0;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_B:
> >>           return 1;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_C:
> >>           return 2;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_D:
> >>           return 3;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_E:
> >>           return 4;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_F:
> >>           return 5;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_G:
> >>           return 6;
> >> -    break;
> >>       default:
> >>           ASSERT(0);
> >>           return 0;
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> >> b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> >> index b622b4b1dac3..7b4b2304bbff 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
> >> @@ -446,25 +446,18 @@ static int map_transmitter_id_to_phy_instance(
> >>       switch (transmitter) {
> >>       case TRANSMITTER_UNIPHY_A:
> >>           return 0;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_B:
> >>           return 1;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_C:
> >>           return 2;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_D:
> >>           return 3;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_E:
> >>           return 4;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_F:
> >>           return 5;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_G:
> >>           return 6;
> >> -    break;
> >>       default:
> >>           ASSERT(0);
> >>           return 0;
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> >> b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> >> index 16fe7344702f..3d782b7c86cb 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
> >> @@ -383,25 +383,18 @@ static int map_transmitter_id_to_phy_instance(
> >>       switch (transmitter) {
> >>       case TRANSMITTER_UNIPHY_A:
> >>           return 0;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_B:
> >>           return 1;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_C:
> >>           return 2;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_D:
> >>           return 3;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_E:
> >>           return 4;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_F:
> >>           return 5;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_G:
> >>           return 6;
> >> -    break;
> >>       default:
> >>           ASSERT(0);
> >>           return 0;
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> >> b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> >> index 5a5a9cb77acb..e9dd78c484d6 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
> >> @@ -453,25 +453,18 @@ static int map_transmitter_id_to_phy_instance(
> >>       switch (transmitter) {
> >>       case TRANSMITTER_UNIPHY_A:
> >>           return 0;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_B:
> >>           return 1;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_C:
> >>           return 2;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_D:
> >>           return 3;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_E:
> >>           return 4;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_F:
> >>           return 5;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_G:
> >>           return 6;
> >> -    break;
> >>       default:
> >>           ASSERT(0);
> >>           return 0;
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> >> b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> >> index 0eae8cd35f9a..9dbf658162cd 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> >> @@ -458,25 +458,18 @@ static int map_transmitter_id_to_phy_instance(
> >>       switch (transmitter) {
> >>       case TRANSMITTER_UNIPHY_A:
> >>           return 0;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_B:
> >>           return 1;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_C:
> >>           return 2;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_D:
> >>           return 3;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_E:
> >>           return 4;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_F:
> >>           return 5;
> >> -    break;
> >>       case TRANSMITTER_UNIPHY_G:
> >>           return 6;
> >> -    break;
> >>       default:
> >>           ASSERT(0);
> >>           return 0;
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
