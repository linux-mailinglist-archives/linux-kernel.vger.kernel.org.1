Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19112AAA72
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 10:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgKHJ4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 04:56:06 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:47608 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKHJ4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 04:56:05 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4C5068051F;
        Sun,  8 Nov 2020 10:56:03 +0100 (CET)
Date:   Sun, 8 Nov 2020 10:56:01 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: panel: simple: add missing
 platform_driver_unregister() in panel_simple_init
Message-ID: <20201108095601.GB1129714@ravnborg.org>
References: <20201031011856.137307-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031011856.137307-1-miaoqinglang@huawei.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=i0EeH86SAAAA:8 a=h7ZxxWauLWjVpACnkrQA:9
        a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qinglang

On Sat, Oct 31, 2020 at 09:18:56AM +0800, Qinglang Miao wrote:
> Add the missing platform_driver_unregister() before return
> from panel_simple_init in the error handling case when failed
> to register panel_simple_dsi_driver with CONFIG_DRM_MIPI_DSI
> enabled.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>

Looks relevant, applied to drm-misc-next.

	Sam
