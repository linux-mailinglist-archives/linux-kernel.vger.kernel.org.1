Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C282AC4A0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 20:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgKITIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 14:08:15 -0500
Received: from mga01.intel.com ([192.55.52.88]:17032 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgKITIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 14:08:15 -0500
IronPort-SDR: eX4uGgaAohvj65uLXrrF/hadLVKTwFtAhf3fU3QzjVC4e4aJbdc9FbdOcwwqIiod2TOoeDRtzL
 0e61YshCnCEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="187810336"
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="187810336"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 11:08:14 -0800
IronPort-SDR: 0r43pxb7JvqR6+RwF6HbyemFwySilAl/4aVAM920R/2Hqeo4gEHRQL0E7JSePlOMhX5Oi2o2DD
 muw/pClS/GKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,464,1596524400"; 
   d="scan'208";a="365174740"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 09 Nov 2020 11:08:09 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 09 Nov 2020 21:08:08 +0200
Date:   Mon, 9 Nov 2020 21:08:08 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Imre Deak <imre.deak@intel.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
Message-ID: <20201109190808.GN6112@intel.com>
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <20201103222013.hypmzlq7uuqufe76@box>
 <71dc852e52bfeafc8c03a6fa3cd5f3cdd4eb6609.camel@redhat.com>
 <20201109115209.rwhoe4zttaxirx6c@box>
 <ea2450953182320516f8e8bf857625c58a18f584.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea2450953182320516f8e8bf857625c58a18f584.camel@redhat.com>
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 12:50:48PM -0500, Lyude Paul wrote:
> Looking at the patches you sent is on my TODO list for this week at least as a
> priority, although I really would have hoped that someone from Intel would
> have looked by now since it's a regression on their end.

What regression are you talking about?

> 
> Gentle ping to Vsyrjala and Imre
> 
> On Mon, 2020-11-09 at 14:52 +0300, Kirill A. Shutemov wrote:
> > On Wed, Nov 04, 2020 at 04:58:14PM -0500, Lyude Paul wrote:
> > > ACK, I will send out a patch for this asap
> > 
> > Any update. AFAICS, v5.10-rc3 is still buggy.
> > 
> 
> -- 
> Cheers,
>  Lyude Paul (she/her)
>  Software Engineer at Red Hat

-- 
Ville Syrjälä
Intel
