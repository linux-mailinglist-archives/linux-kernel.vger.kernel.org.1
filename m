Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3982FB41E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbhASIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbhASIaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:30:12 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6D0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:29:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 6so11525610wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 00:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d9EPmxgSjplqIloqEd0fjmhaf+3lX7Ca0TE2z4KWzZU=;
        b=Mc5TIayeKmc7ETz+AffYmEItuFJXlQ+LEXC0DXPZd0CeGOe+I1qOEyFh4REscFCZ9K
         QBlcRgDo6dPqK01+Ka8woQ4Ce+Tpfm4FNert/g90UtAxCnBuF6LU1jEhogQ+mzzaEXxv
         DVOpaMrUYFVaILEhToWw1nDQFOPBoeBbLmfVTlycpgZ05pSDTcdv5hEOM/6dSSGRsn7E
         u8N/93WaR4XjU+lnDH7Ix1nIBRz/1r+gwTh3LStekGLavIWm5gbpGGe8mYxhTbrpBfQd
         2LQiofEKLbLBHRRgyFy04sunOBK61oZGum2gRLULFFnGY4r2g62QdNAeo2JEuWOMYptT
         Z8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d9EPmxgSjplqIloqEd0fjmhaf+3lX7Ca0TE2z4KWzZU=;
        b=GHdtgLrjwOmQpOZGfRr6dOyGBu1/wLvmGhS3QTRY1YuCkEtk9lSnGdJCqYliULhjhe
         qGZJHqfk7lvSBZl4HMpA8H3bsR+sEVb2GkPSh65XHbGQSHSRPuPhxevymMARgKc7YRZP
         //rYZiKLxZkMCyK1QpLqp6uhSyoY+GDRpilNTVLkGCr5pTp0UzPyC8PmjMZz+qdrLWXS
         hrPCXzuQZkA0iRqJNLfK9PfLpAz5EHWE4PHhtTwF787nmXlcqD+ecCCQuV6Pl3MXSCmt
         QS/W1eJnY0WfHRJUuLNzL8kuq235YcHyv/OyekBMAc7SR61/kbDo9ItAPU+xAUhh/SQe
         IytQ==
X-Gm-Message-State: AOAM530IjXOEhHIp7iV3li0PVeqDOBSVMxzGHU+ApUwUM6qdL5AlOfW0
        poaNmJqtllNhmhulIsp+zzXqVw==
X-Google-Smtp-Source: ABdhPJxZgbmI7dqTDYKpsJ4RFJ20zHNFbzEsz8E5NfIQ/ie1dHSOozCsng29cOp98WeoUcI4x2Sbrw==
X-Received: by 2002:adf:b519:: with SMTP id a25mr3094280wrd.263.1611044971004;
        Tue, 19 Jan 2021 00:29:31 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b64sm3307488wmb.26.2021.01.19.00.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 00:29:30 -0800 (PST)
Date:   Tue, 19 Jan 2021 08:29:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zack Rusin <zackr@vmware.com>,
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
Message-ID: <20210119082927.GJ4903@dell>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
 <F914D9B9-6DD4-4383-9F7C-8D09FBFE96CE@vmware.com>
 <YAWhDRkSOHbJ+2Le@phenom.ffwll.local>
 <20210118150945.GE4903@dell>
 <YAXDgmWMR9s4OgxN@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YAXDgmWMR9s4OgxN@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021, Daniel Vetter wrote:

> On Mon, Jan 18, 2021 at 03:09:45PM +0000, Lee Jones wrote:
> > On Mon, 18 Jan 2021, Daniel Vetter wrote:
> > 
> > > On Fri, Jan 15, 2021 at 06:27:15PM +0000, Zack Rusin wrote:
> > > > 
> > > > > On Jan 15, 2021, at 13:15, Lee Jones <lee.jones@linaro.org> wrote:
> > > > > 
> > > > > This set is part of a larger effort attempting to clean-up W=1
> > > > > kernel builds, which are currently overwhelmingly riddled with
> > > > > niggly little warnings.
> > > > > 
> > > > > Last set!  All clean after this for; Arm, Arm64, PPC, MIPS and x86.
> > > > 
> > > > Thanks! For all the vmwgfx bits:
> > > > Reviewed-by: Zack Rusin <zackr@vmware.com>
> > > 
> > > Ok I merged everything except vmwgfx (that's for Zack) and i915/nouveau
> > > (those generally go through other trees, pls holler if they're stuck).
> > 
> > Thanks Daniel, you're a superstar!
> > 
> > So Zack will take the vmwgfx parts?  Despite providing a R-b?
> 
> I only merge stuff that's defacto abandoned already. Everything else I try
> to offload to whomever actually cares :-)

Understood.  Thanks for the explanation.

Hopefully Zack actually cares. :D

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
