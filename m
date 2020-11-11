Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFAA2AE9A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgKKHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:20:51 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:60736 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgKKHUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:20:48 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 2252C2003B;
        Wed, 11 Nov 2020 08:20:39 +0100 (CET)
Date:   Wed, 11 Nov 2020 08:20:37 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        thierry.reding@gmail.com
Subject: Re: [PATCH] drm/panel: add missing platform_driver_unregister() on
 error path
Message-ID: <20201111072037.GA2950611@ravnborg.org>
References: <20201111064425.3395558-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111064425.3395558-1-yangyingliang@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VbvZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=-Gbx0BpZB59qaVUEe18A:9
        a=CjuIK1q_8ugA:10 a=-RoEEKskQ1sA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Wed, Nov 11, 2020 at 02:44:25PM +0800, Yang Yingliang wrote:
> If mipi_dsi_driver_register() failed, platform_driver_unregister()
> need be called.
> 
> Fixes: 210fcd9d9cf1 ("drm/panel: Add support for Panasonic VVX10F004B0")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for the patch but this is already fixed in drm-misx-next.
See:

    commit f2e66f212a9de04afc2caa5ec79057c0ac75c728
    drm: panel: simple: add missing platform_driver_unregister() in panel_simple_init

	Sam
