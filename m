Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C852AB1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgKIHbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:31:31 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:52268 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:31:31 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 1D1D780537;
        Mon,  9 Nov 2020 08:31:29 +0100 (CET)
Date:   Mon, 9 Nov 2020 08:31:27 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: riva: remove some unused varibles
Message-ID: <20201109073127.GC1715181@ravnborg.org>
References: <1604822519-65607-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1604822519-65607-1-git-send-email-alex.shi@linux.alibaba.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=SRrdq9N9AAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
        a=e5mUnYsNAAAA:8 a=K4B7_0IVxdEOLhH2ft8A:9 a=QEXdDO2ut3YA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Sun, Nov 08, 2020 at 04:01:59PM +0800, Alex Shi wrote:
> Couple of variables are actually useless, remove them to save some gcc
> warning:
> drivers/video/fbdev/riva/riva_hw.c:250:21: warning: variable ‘mlwm’ set
> but not used [-Wunused-but-set-variable]
> drivers/video/fbdev/riva/riva_hw.c:665:15: warning: variable ‘vraw’ set
> but not used [-Wunused-but-set-variable]
> drivers/video/fbdev/riva/riva_hw.c:665:9: warning: variable ‘craw’ set
> but not used [-Wunused-but-set-variable]
> drivers/video/fbdev/riva/riva_hw.c:659:73: warning: variable ‘align’ set
> but not used [-Wunused-but-set-variable]
> drivers/video/fbdev/riva/riva_hw.c:659:50: warning: variable
> ‘color_key_enable’ set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Antonino Daplas <adaplas@gmail.com> 
> Cc: linux-fbdev@vger.kernel.org 
> Cc: dri-devel@lists.freedesktop.org 
> Cc: linux-kernel@vger.kernel.org 

Thanks, applied to drm-misc-next. The fix will appear in -next in a week
or so.

	Sam
