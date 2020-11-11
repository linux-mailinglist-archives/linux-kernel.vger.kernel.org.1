Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818142AFA27
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgKKVFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:05:48 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:34338 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKVFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:05:46 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id C762B2006B;
        Wed, 11 Nov 2020 22:05:42 +0100 (CET)
Date:   Wed, 11 Nov 2020 22:05:41 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/kmb: fix spelling mistakes in drm_info and
 drm_dbg messages
Message-ID: <20201111210541.GC3013948@ravnborg.org>
References: <20201109111225.1485190-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109111225.1485190-1-colin.king@canonical.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=DfNHnWVPAAAA:8 a=PDJ5SSlNGPTDK7a3TiwA:9
        a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On Mon, Nov 09, 2020 at 11:12:25AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two spelling mistakes of the word sync in drm_info
> and drm_dbg messages. Fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, applied to drm-misc-next.

	Sam
