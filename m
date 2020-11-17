Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320792B6CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbgKQSNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKQSNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:13:44 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A031C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:13:44 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so24112202wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XUZThx36p3R01Q+OVZgC7ap+liimQUklKkO3YYLInjI=;
        b=pX+RHuLMITy1MSvnEX1opAwiuvv2Np3vNifM0kwC8d6WVZyNg+AdihEsvkn3hXp8Re
         3nBbUAVATInJR21EJkc3p2bhareTwPXUWAqpw3/ekms5J0snEHbv1p3d8Pf4tG9SibXa
         3xGqQ+c/ywhiljpumUxG/N0OvVpjKfnVfY+PDKgNl9bkbp7LXGKyQpU+UPGAbZKmftbs
         Xdg0s+53b/b0+soH3/rDaMDGMfoxhU1m+5HRXA/7rJ+DW6UpwiJ5JID0XfGZUu6vvv37
         z5/KEC+pCxOXh0K1GaG0zl8YJUUco+0GjP+hYtzEoOriVXLN1y84GdGqcVaBQwmm7vDq
         kAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XUZThx36p3R01Q+OVZgC7ap+liimQUklKkO3YYLInjI=;
        b=h55SvTleW/MjgaauF7umQZedkhh8/y1IERT0+yKoOXv9cnNX3pd/rQAQwRYyRBOjky
         +D5hxL1HBQUPr/8uYPxmk+0IQrBimFSGJyG/hzTF70Lb2D4uMYp8BRljsjJkoRdHowV+
         3zJMf9+lIWoGFEPn2Iz+P6Akep5bqiaUdyP9bj1xVFxt0OfK4/erVAscBH6vvdFYc68h
         GX6j7Z91e9BK0UnaIy1a6deNspL1540d9/cRcpURAFHmjiBLEYn4z0IcIlcCABZBkhcY
         UJqJQLzPuyqobTspXBFsIQotijYl8j2GNR74mj+30k5yNqSPUxXY+cKkInVKcKhAMiUk
         byPQ==
X-Gm-Message-State: AOAM533WgPMN3TFEYlZnTZf+R7hH6egxEGnUFmxdeG4vt9txqNUQy0ds
        qfjnwI/IRmOIdPAi+ZLZkPJjFygxAg/qLn0y
X-Google-Smtp-Source: ABdhPJzdDhitlcjhywQsflVnI9g5fvH8tJ02VlY73QUwKH2fOOZiML4WaajFIWJsxc97BVGkQwFU0Q==
X-Received: by 2002:a5d:6050:: with SMTP id j16mr897945wrt.158.1605636822648;
        Tue, 17 Nov 2020 10:13:42 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id x6sm4815167wmc.48.2020.11.17.10.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 10:13:41 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:13:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch
Subject: Re: [PATCH 03/42] drm/drm_dp_mst_topology: Remove set but never used
 variable 'len'
Message-ID: <20201117181340.GM1869941@dell>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-4-lee.jones@linaro.org>
 <20201117172925.GN401619@phenom.ffwll.local>
 <20201117181250.GL1869941@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117181250.GL1869941@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020, Lee Jones wrote:

> On Tue, 17 Nov 2020, Daniel Vetter wrote:
> 
> > On Mon, Nov 16, 2020 at 05:40:33PM +0000, Lee Jones wrote:
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >  drivers/gpu/drm/drm_dp_mst_topology.c: In function ‘drm_dp_send_query_stream_enc_status’:
> > >  drivers/gpu/drm/drm_dp_mst_topology.c:3263:6: warning: variable ‘len’ set but not used [-Wunused-but-set-variable]
> > > 
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <mripard@kernel.org>
> > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > Going to apply this, but I noticed that the return value of the
> > build_query_stream_enc_status() is pointless. Can you pls follow up with
> > an additional patch to change that to void?
> 
> I can.

Looks like you're getting dropped again!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
