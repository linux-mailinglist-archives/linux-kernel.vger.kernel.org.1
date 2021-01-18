Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1992F9CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbhARKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388565AbhARJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:49:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6804BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:49:12 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 7so8540363wrz.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 01:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=sSYFbfM9Da4W4yprSISGK+rzbCaBhrTeqyICcu8isSI=;
        b=MEID5dXH0nAohh2t20OSBRbwIults+Y/clL8d5Zoywl8pG1vX9oAoUrqgWkbct+D5T
         sBmb4oJykFGr6XGscyQLi/YCSPNQFigACWi29fujWnFtHb44075JIbDRffBALOeLKQUI
         7JI+AfFtlTN/8lxLCWUr6MNTTny2Zg53dmImk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=sSYFbfM9Da4W4yprSISGK+rzbCaBhrTeqyICcu8isSI=;
        b=dWgYiRaWfYzPWYbvX5dEUqaC3nristrvhPNT1yeC5PE8cYjUkmEMrN4jH/qw1ZJtvE
         fqPT+zBOgIzej8vD5Xx5olx4bgWzscy7l3XH3iiI827WCEwRKXSLLknc1/+2zq8An+3r
         ZC0k0PZWszDcrPJZSpmLn/ZZn85EPfAIkmBvtF16llC5N+DPqGfxyj5KUIw+drZqiPEg
         7dtAap0FYxP/+uOq5djLoSbgavm2QuVHf47qMDJFifkMBMhivg4sT31EgaJZidrphLkt
         u6jWsWASENboE55qCnY5NmrfcWHBr92idAGVUZ70QN5xcgHLNQQ3Qf1dEtEYYUjhlKks
         Br1Q==
X-Gm-Message-State: AOAM530OKE74+7hr+CW7YaG0G57CaXrdmSXXbewUMC8BTVhq68N8t0NW
        LKjdSaHl2yQNbwOO3Eq3iGfZAQ==
X-Google-Smtp-Source: ABdhPJyNkHEjNj8L2i9pban7G0FrBR6GRuJU2SUW/Pv5bihvSUPM5fAgGbUHMl7RRn6n+jn+EXOFoQ==
X-Received: by 2002:adf:e990:: with SMTP id h16mr25656063wrm.307.1610963351184;
        Mon, 18 Jan 2021 01:49:11 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k131sm12400386wmb.37.2021.01.18.01.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 01:49:10 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:49:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Zack Rusin <zackr@vmware.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eddie Dong <eddie.dong@intel.com>,
        Eric Anholt <eric@anholt.net>, Faith <faith@valinux.com>,
        Gareth Hughes <gareth@valinux.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        Jackie Li <yaodong.li@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jan Safrata <jan.nikitenko@gmail.com>,
        Jesse Barnes <jesse.barnes@intel.com>,
        jim liu <jim.liu@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Keith Packard <keithp@keithp.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Min He <min.he@intel.com>,
        Niu Bing <bing.niu@intel.com>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Pei Zhang <pei.zhang@intel.com>,
        Ping Gao <ping.a.gao@intel.com>,
        Rob Clark <rob.clark@linaro.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tina Zhang <tina.zhang@intel.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhiyuan Lv <zhiyuan.lv@intel.com>
Subject: Re: [PATCH 00/29] [Set 15] Finally rid W=1 warnings from GPU!
Message-ID: <YAVZk3XKNf9W7guC@phenom.ffwll.local>
Mail-Followup-To: Zack Rusin <zackr@vmware.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Eddie Dong <eddie.dong@intel.com>, Eric Anholt <eric@anholt.net>,
        Faith <faith@valinux.com>, Gareth Hughes <gareth@valinux.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
        Jackie Li <yaodong.li@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jan Safrata <jan.nikitenko@gmail.com>,
        Jesse Barnes <jesse.barnes@intel.com>, jim liu <jim.liu@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Keith Packard <keithp@keithp.com>,
        Kevin Tian <kevin.tian@intel.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Min He <min.he@intel.com>,
        Niu Bing <bing.niu@intel.com>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Pei Zhang <pei.zhang@intel.com>, Ping Gao <ping.a.gao@intel.com>,
        Rob Clark <rob.clark@linaro.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tina Zhang <tina.zhang@intel.com>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Zhiyuan Lv <zhiyuan.lv@intel.com>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
 <F914D9B9-6DD4-4383-9F7C-8D09FBFE96CE@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F914D9B9-6DD4-4383-9F7C-8D09FBFE96CE@vmware.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 06:27:15PM +0000, Zack Rusin wrote:
> 
> > On Jan 15, 2021, at 13:15, Lee Jones <lee.jones@linaro.org> wrote:
> > 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> > 
> > Last set!  All clean after this for; Arm, Arm64, PPC, MIPS and x86.
> 
> Thanks! For all the vmwgfx bits:
> Reviewed-by: Zack Rusin <zackr@vmware.com>

Can you pls push them to drm-misc-next? I'm planning to go pull in all the
other patches later today that belong into drm-misc-next, but some patch
monkey help would be really great :-)

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
