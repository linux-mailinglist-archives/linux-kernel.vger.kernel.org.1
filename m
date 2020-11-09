Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DEA2AC1A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgKIRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:03:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:43532 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730149AbgKIRDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:03:35 -0500
IronPort-SDR: eFCNoFklhm19oM2drghXZnYL+77Yp8IL+lkbtjz5CFujIlrIBx8wOA6NpfevLCctc0vGewd/ZK
 JYIIxRwhyGaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="254541080"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="254541080"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 09:03:33 -0800
IronPort-SDR: YUB9rDe1NwP0iYMkD/1klmnf7j8zbUufpdzd8PIdfkSOXE+YFzbqWx8As7cJa337ZnDbYe564X
 BObVE0/JZwsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="365535760"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga007.jf.intel.com with SMTP; 09 Nov 2020 09:03:26 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 09 Nov 2020 19:03:24 +0200
Date:   Mon, 9 Nov 2020 19:03:24 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        David Francis <David.Francis@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/19] gpu: drm: selftests: test-drm_dp_mst_helper: Place
 'struct drm_dp_sideband_msg_req_body' onto the heap
Message-ID: <20201109170324.GJ6112@intel.com>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-15-lee.jones@linaro.org>
 <20201109151937.GF6112@intel.com>
 <20201109161258.GX2063125@dell>
 <20201109162015.GH6112@intel.com>
 <20201109164004.GZ2063125@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201109164004.GZ2063125@dell>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 04:40:04PM +0000, Lee Jones wrote:
> On Mon, 09 Nov 2020, Ville Syrjälä wrote:
> 
> > On Mon, Nov 09, 2020 at 04:12:58PM +0000, Lee Jones wrote:
> > > On Mon, 09 Nov 2020, Ville Syrjälä wrote:
> > > 
> > > > On Thu, Nov 05, 2020 at 02:45:12PM +0000, Lee Jones wrote:
> > > > > The stack is too full.
> > > > > 
> > > > > Fixes the following W=1 kernel build warning(s):
> > > > > 
> > > > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c: In function ‘sideband_msg_req_encode_decode’:
> > > > >  drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c:161:1: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > > > 
> > > > > Cc: David Airlie <airlied@linux.ie>
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > > Cc: David Francis <David.Francis@amd.com>
> > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  .../drm/selftests/test-drm_dp_mst_helper.c    | 29 ++++++++++++-------
> > > > >  1 file changed, 18 insertions(+), 11 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > index 1d696ec001cff..0a539456f6864 100644
> > > > > --- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > +++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
> > > > > @@ -120,44 +120,51 @@ sideband_msg_req_equal(const struct drm_dp_sideband_msg_req_body *in,
> > > > >  static bool
> > > > >  sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
> > > > >  {
> > > > > -	struct drm_dp_sideband_msg_req_body out = {0};
> > > > > +	struct drm_dp_sideband_msg_req_body *out;
> > > > 
> > > > How big is it? And why is it that big?
> > > 
> > > It's a struct of a union of structs.
> > > 
> > > And it's all allocated on the stack.  Bad news!
> > 
> > That doesn't answer my questions.
> 
> It answers the second question.

Not really. A combination of structs and unions could be
pretty much any size.

> 
> The answer to the first question you can `grep` for yourself. ;)

I would rather run pahole on it. But why would you require
reviewers to jump through such extra hoops when you could
just put that information into the commit message? With that
anyone could review this without having to do a lot of extra
work.

-- 
Ville Syrjälä
Intel
