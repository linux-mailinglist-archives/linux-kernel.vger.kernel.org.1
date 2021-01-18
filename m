Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C302FA78E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405559AbhARR3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407061AbhARRWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:22:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC26C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:21:11 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y17so17205844wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mcabCZTC0ctiX7BvFOy/77rikMOebwMRiE/IMCNir9k=;
        b=FjF9TW8nhy9Gz0TiRekI5y1nTijSy4HtuPqCGx12ibM5MDuMQU2SZeRC0/Lc5gDYGj
         prdGv6KdTrJBUmZB+iYWo5a1SHtCqcpGY5u/97TLyhONFJhRAZnorcCWbDfP35u16ZjJ
         FAr8o8af5u1l+gbHg+CA1mUXcGe+bYC38S/4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=mcabCZTC0ctiX7BvFOy/77rikMOebwMRiE/IMCNir9k=;
        b=jYfVxmUowgzSr90G2NS/Cat1KDhco6WeZ66ftVHwIF4nWLEk66yB47+vz7tLD0o18H
         yfozIkJrnOi1fK2/viBGIaUJNCq1kPeNbzUkdqtNQPUP2ddOksVY0FcMGOaQJl9VB8fX
         OfzJO93qgd7S92sdFD3EIoCT1Y+/JZytf7k5v+1XKe2SstR0NIMFgbdr/JhsLNbHVQha
         GS9waam7HxDOAYN1yRKcbNUxkZsFWdAC4Drklq850wIHiyJVoLvw49227rk6890BwbSB
         DLrm/fCVQQtuou+o20CBOFt0wx7XmvhklOS5SayvRMikHjPkbsMabR7NmAnTotSyfnFj
         pY1Q==
X-Gm-Message-State: AOAM532kPTOrBYlRDa4VWc5j7KKrThUvi9r/2yqmuw3E80uMuyRjP/Cy
        jLzlXF6hu0PAPmF+RSI2/BN96Pqx+zJvMIg6
X-Google-Smtp-Source: ABdhPJzY2WOEnEaMMZ51nvju1fIaYxTXy8mS3+BIiF2xcI5bBHn2eizXQ4q3XaruAJ3Wybg/kV0QDA==
X-Received: by 2002:a5d:47af:: with SMTP id 15mr489829wrb.205.1610990469978;
        Mon, 18 Jan 2021 09:21:09 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d2sm30963689wre.39.2021.01.18.09.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 09:21:08 -0800 (PST)
Date:   Mon, 18 Jan 2021 18:21:06 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Zack Rusin <zackr@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Message-ID: <YAXDgmWMR9s4OgxN@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        Zack Rusin <zackr@vmware.com>,
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
 <YAWhDRkSOHbJ+2Le@phenom.ffwll.local>
 <20210118150945.GE4903@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210118150945.GE4903@dell>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:09:45PM +0000, Lee Jones wrote:
> On Mon, 18 Jan 2021, Daniel Vetter wrote:
> 
> > On Fri, Jan 15, 2021 at 06:27:15PM +0000, Zack Rusin wrote:
> > > 
> > > > On Jan 15, 2021, at 13:15, Lee Jones <lee.jones@linaro.org> wrote:
> > > > 
> > > > This set is part of a larger effort attempting to clean-up W=1
> > > > kernel builds, which are currently overwhelmingly riddled with
> > > > niggly little warnings.
> > > > 
> > > > Last set!  All clean after this for; Arm, Arm64, PPC, MIPS and x86.
> > > 
> > > Thanks! For all the vmwgfx bits:
> > > Reviewed-by: Zack Rusin <zackr@vmware.com>
> > 
> > Ok I merged everything except vmwgfx (that's for Zack) and i915/nouveau
> > (those generally go through other trees, pls holler if they're stuck).
> 
> Thanks Daniel, you're a superstar!
> 
> So Zack will take the vmwgfx parts?  Despite providing a R-b?

I only merge stuff that's defacto abandoned already. Everything else I try
to offload to whomever actually cares :-)
-Daniel

> 
> > Note that we have some build issue on some of the configs sfr uses, so drm
> > trees are still stuck on old versions in linux-next. Hopefully should get
> > resolved soon, the bugfix is in some subtree I've heard.
> 
> No worries.  Thanks for letting me know.
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
