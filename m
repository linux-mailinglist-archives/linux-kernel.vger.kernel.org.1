Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F592297241
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750819AbgJWP12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:27:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:31158 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462254AbgJWP11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:27:27 -0400
IronPort-SDR: qSsfzkXXkgt5z5LGIrprJ9ZHf+S+xfW1ag2tXsOAaDdveEe2a4us1WLwE/NsqhkhTo1qH/8IdG
 iCEwv/D8OlGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="165098112"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="165098112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 08:27:24 -0700
IronPort-SDR: 3Fs3y3ZJZi0vPaN4bVpebT2ToW8yu8kA2stZvwxqC8hZLdCQutq5ILFGxS4BUnBmIQduJc3YGW
 NJgbDW3n3DPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="scan'208";a="321768874"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 23 Oct 2020 08:27:20 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 23 Oct 2020 18:27:19 +0300
Date:   Fri, 23 Oct 2020 18:27:19 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Pekka Paalanen <ppaalanen@gmail.com>
Subject: Re: [Intel-gfx] drm_modes: signed integer overflow
Message-ID: <20201023152719.GV6112@intel.com>
References: <47527cdb-2eda-b5a3-d77c-3855b91a0b61@infradead.org>
 <20201022101423.GI6112@intel.com>
 <BaLsmzqZNUi-nVbYiLstRgspKGlLahAI8vM2_NPfos2PxM0N9lycj-Zn5TdqNtEHB-jeWgmzw9EHJxq4H5552tVi4bAZXTLnP0y1QsTPFtY=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BaLsmzqZNUi-nVbYiLstRgspKGlLahAI8vM2_NPfos2PxM0N9lycj-Zn5TdqNtEHB-jeWgmzw9EHJxq4H5552tVi4bAZXTLnP0y1QsTPFtY=@emersion.fr>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 03:14:20PM +0000, Simon Ser wrote:
> On Thursday, October 22, 2020 12:14 PM, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> 
> > On Wed, Oct 21, 2020 at 08:13:43PM -0700, Randy Dunlap wrote:
> >
> > > Hi,
> > > With linux-next 20201021, when booting up, I am seeing this:
> > > [ 0.560896] UBSAN: signed-integer-overflow in ../drivers/gpu/drm/drm_modes.c:765:20
> > > [ 0.560903] 2376000 * 1000 cannot be represented in type 'int'
> >
> > Dang. Didn't realize these new crazy >8k modes have dotclocks reaching
> > almost 6 GHz, which would overflow even u32. I guess we'll switch to
> > 64bit maths. Now I wonder how many other places can hit this overflow
> > in practice...
> 
> Can you provide an example of a full crazy >8k mode?

These are two extreme cases:
        /* 216 - 10240x4320@100Hz 64:27 */
        { DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 5940000, 10240, 12432,
                   12608, 13200, 0, 4320, 4336, 4356, 4500, 0,
                   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
          .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, },
        /* 217 - 10240x4320@120Hz 64:27 */
        { DRM_MODE("10240x4320", DRM_MODE_TYPE_DRIVER, 5940000, 10240, 10528,
                   10704, 11000, 0, 4320, 4336, 4356, 4500, 0,
                   DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC),
          .picture_aspect_ratio = HDMI_PICTURE_ASPECT_64_27, }

> I'm trying to get
> a fix for my user-space [1], and I'm wondering if int32_t is enough
> after dividing by mode->htotal.
> 
> CC Pekka, just FYI (I think Weston has similar code).
> 
> [1]: https://github.com/swaywm/wlroots/pull/2450

What's with those 1000000LL constants? Are you storing
clock in Hz units?

-- 
Ville Syrjälä
Intel
