Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6BF26ADBF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgIOTjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:39:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:34965 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727971AbgIOTgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:36:00 -0400
IronPort-SDR: IpHkPfXDT28U3rFz8KDO+H0AEhNQ8J9SYAKbKMOUKk5uUO9GBX/wWYzYfElstq4EoUz0zlMrfW
 03VaCU900J7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="159386766"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="159386766"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 12:35:54 -0700
IronPort-SDR: i2m5jk7nUWDhIcarS7CMsRRt9ERB90Cv8RG/ApZVbBpRKGqGU6fG49uc78PWAFvbeTy9FLSCUx
 hUSdv5ho7g7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="288114814"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 15 Sep 2020 12:35:49 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 15 Sep 2020 22:35:49 +0300
Date:   Tue, 15 Sep 2020 22:35:49 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        yi.zhang@huawei.com, Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
Subject: Re: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool
 warning
Message-ID: <20200915193549.GP6112@intel.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
 <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com>
 <CADnq5_NoeFbBAMT6s_ictVXsUc2tx1U48MLxnMbAr2Sd58jyYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NoeFbBAMT6s_ictVXsUc2tx1U48MLxnMbAr2Sd58jyYA@mail.gmail.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 03:16:32PM -0400, Alex Deucher wrote:
> I question the value of these warnings.  Why even have a boolean type
> if you are going to get warnings when you use them...
> That said, applied to avoid getting these patches again and again
> every time someone sees this.

if (this_is_sparta)
if (this_is_sparta == true)
if (this_is_sparta != false)

I think the first one reads the best, and avoids having to
decide between truth and falsehood :)

> 
> Alex
> 
> On Wed, Sep 9, 2020 at 9:21 AM Christian König <christian.koenig@amd.com> wrote:
> >
> > Acked-by: Christian König <christian.koenig@amd.com> for the series.
> >
> > Am 09.09.20 um 15:07 schrieb Zheng Bin:
> > > Zheng Bin (8):
> > >    drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
> > >    drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.c
> > >    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.c
> > >    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.c
> > >    drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
> > >    drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
> > >    drm/amd/amdgpu: fix comparison pointer to bool warning in
> > >      amdgpu_atpx_handler.c
> > >    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c
> > >
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
> > >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
> > >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
> > >   drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
> > >   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
> > >   8 files changed, 11 insertions(+), 11 deletions(-)
> > >
> > > --
> > > 2.26.0.106.g9fadedd
> > >
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
