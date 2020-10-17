Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE092910B2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411520AbgJQILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 04:11:38 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:48574 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391998AbgJQILh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 04:11:37 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1817680613;
        Sat, 17 Oct 2020 10:11:34 +0200 (CEST)
Date:   Sat, 17 Oct 2020 10:11:32 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH] drm/via: reduce no need mutex_lock area
Message-ID: <20201017081132.GD2568873@ravnborg.org>
References: <20200814083021.8962-1-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814083021.8962-1-bernard@vivo.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=fu7ymmwf c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=1WtWmnkvAAAA:8 a=LC9wdpaYjE8W-MlJmK4A:9
        a=CjuIK1q_8ugA:10 a=-_UHfarfsM-RsASml2Jt:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard.

On Fri, Aug 14, 2020 at 01:30:19AM -0700, Bernard Zhao wrote:
> In function via_mem_alloc`s error branch, DRM_ERROR is protected
> in the mutex_lock(&dev->struct_mutex) area.
> >From the code, we see that DRM_ERROR is just an error log print
> without any struct element, there is no need to protect this.
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Thanks, applied to drm-misc-next.

The patch will show up in -next in a few weeks.

	Sam
