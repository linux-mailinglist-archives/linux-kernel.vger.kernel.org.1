Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E890C1DEE8D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgEVRqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 13:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbgEVRqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:46:52 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A95E92072C;
        Fri, 22 May 2020 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590169612;
        bh=D18/tscbxNYJt7Qi51OajMBP8/Y1ftjXaTbS8M/yx6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nb6aIsQcHONH6fn8FyPFvbOOwO3QjVHZd40VefUzq2Aa6TUjr/ikpuBaIan+XiE/L
         mVYg8LPnlNqb6RaLcUR4WMGfypNbRiJ1qbMenZVRKfUrBPOve31RnG2Wr53k7AUMae
         l+prLfZh08RC2CGMiwEo2m1OO8NeU57g1c2xzUoU=
Date:   Fri, 22 May 2020 12:51:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] drm/amdgpu/smu10: Replace one-element array and use
 struct_size() helper
Message-ID: <20200522175142.GF29907@embeddedor>
References: <20200519225545.GA2066@embeddedor>
 <1065d63e-7959-e4b4-af4e-70607ba92296@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1065d63e-7959-e4b4-af4e-70607ba92296@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:42:27AM +0200, Christian König wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 
> May I suggest that we add a section how to correctly do this to
> Documentation/process/coding-style.rst or similar document?
> 

That's already on my list. :)

> I've seen a bunch of different approaches and some even doesn't work with
> some gcc versions and result in a broken binary.
> 

Do you have an example of that one that doesn't work with some GCC
versions? It'd be interesting to take a look...

Thanks
--
Gustavo
