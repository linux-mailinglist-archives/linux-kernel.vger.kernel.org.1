Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7712B2B1DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKMO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:56:07 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:49626 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbgKMO4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:56:04 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 21780804F9;
        Fri, 13 Nov 2020 15:55:58 +0100 (CET)
Date:   Fri, 13 Nov 2020 15:55:57 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/kmb: fix array out-of-bounds writes to
 kmb->plane_status[]
Message-ID: <20201113145557.GB3647624@ravnborg.org>
References: <20201113120121.33212-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113120121.33212-1-colin.king@canonical.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=DfNHnWVPAAAA:8 a=fighymmnzFzAkJHgI4oA:9
        a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin.

On Fri, Nov 13, 2020 at 12:01:21PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Writes to elements in the kmb->plane_status array in function
> kmb_plane_atomic_disable are overrunning the array when plane_id is
> more than 1 because currently the array is KMB_MAX_PLANES elements
> in size and this is currently #defined as 1.  Fix this by defining
> KMB_MAX_PLANES to 4.

I fail to follow you here.
In kmb_plane_init() only one plane is allocated - with id set to 0.
So for now only one plane is allocated thus kmb_plane_atomic_disable()
is only called for this plane.

With your change we will start allocating four planes, something that is
not tested.

Do I miss something?

	Sam

