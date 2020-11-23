Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78EFA2C18A5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 23:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbgKWWmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgKWWml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:42:41 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C8E206B7;
        Mon, 23 Nov 2020 22:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606171361;
        bh=G5KMJK/xhxq9PQOxUIPVZ1qBE+U6OLZbaSTGlX0apGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zLGqtcc8QUarpY92GWg+s7En63ifye9Tn1BfLKzCca5RFps86/biVszpom0iGsTEn
         tIkk7VX7eO7dxloDvwSC4eT0Q8tkC1f+e+QkF16EslwUwJU1eS3CNEmhTFzDmleYP2
         DE+mHnh3QzVCGjmNVxS4iyTakkw8AllT1JvJN62A=
Date:   Mon, 23 Nov 2020 16:42:54 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-hardening@vger.kernel.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 004/141] drm/amdgpu: Fix fall-through warnings for Clang
Message-ID: <20201123224254.GB21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <dc55f2cf59d8d3426bf9b01a6555db6de61c9361.1605896059.git.gustavoars@kernel.org>
 <CADnq5_OsDDGcy1EvEOP23pqfF628dGEq=3-hY_G45b_5j4nmtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OsDDGcy1EvEOP23pqfF628dGEq=3-hY_G45b_5j4nmtQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 05:42:38PM -0500, Alex Deucher wrote:
> On Fri, Nov 20, 2020 at 1:24 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> > warnings by explicitly adding multiple break statements instead of just
> > letting the code fall through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied.  Thanks!

Thanks, Alex.
--
Gustavo
