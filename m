Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385CD2B5169
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgKPTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgKPTns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:43:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88836C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:43:46 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m6so2905364wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=T3bQsgj6/TdWyaR1j/y5LeOnUCmki2zEPh5MGH2qIZI=;
        b=cq7nQaf4tCgFGEJgMtaGf0UnLrWyEvgcD/PbOLhv94FymY97OT2tyyLmYgWLmR7Z3p
         j5tb+7NxPIOjMpw5PuG/PMn0/6Sf5DZYwKbsIjHJNeL7y18Tm3Nhpt59FH7x7aIIb7Gp
         d2F5kmF7Xdi3JsoMFlw8RLMVWcRpIBm7i8OhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=T3bQsgj6/TdWyaR1j/y5LeOnUCmki2zEPh5MGH2qIZI=;
        b=JMeM8GEaj3v5FJpY1ZEV4ggp+dGZ9RHmpXDQKFdcsDI2yayQ3CmsdvbBNUkq3DMJ4U
         +rgZ8fmn2KbB5DYYg0wPeX7GT3nU7Upcfx+YEVMhBnsavIzYbkcQwmwVv2uiF7HzgA5M
         9Rs0XPcne4CL4uftPN2vBWsxE5nGB5LfkOFeZLJDDBfqVj7ksFZkw2KNEgbE5JaVtCeb
         3wxCgVk7L1oB3ATLx3DgctshCJPWeZfcXHCNT3bWnMA2rSVyWpyYSV6rSuczJUVJrg19
         5jdvGqLPLLb2IwJco0TXMuZuZ38z6PYqseXhFcYMuC5Avsh6sv7kxFhc03qVSzzlbwQM
         ryeA==
X-Gm-Message-State: AOAM530HkZ5sKFOYc1kuE9MIhqJCUKbMd+2mcJOb1XQo+na/H0du81Ct
        +13Yq6izhyyaBhmUeee5Yrjt7w==
X-Google-Smtp-Source: ABdhPJwKERkzMl0LaPFGiAEbmO0JIhahjV99lnngXah18p5ORSHJ7NHB9nGBIQOsW67X2oo2SrIEMg==
X-Received: by 2002:adf:ea03:: with SMTP id q3mr20016106wrm.141.1605555823876;
        Mon, 16 Nov 2020 11:43:43 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t11sm355613wmf.35.2020.11.16.11.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:43:43 -0800 (PST)
Date:   Mon, 16 Nov 2020 20:43:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/27] video: fix some kernel-doc markups
Message-ID: <20201116194341.GE401619@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <21661aed9892a1bacc7ef76a5dc9f5c7b37f5d8f.1605521731.git.mchehab+huawei@kernel.org>
 <20201116153606.GC401619@phenom.ffwll.local>
 <20201116173804.7d64f55f@coco.lan>
 <20201116172404.GD401619@phenom.ffwll.local>
 <20201116181112.GA103421@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116181112.GA103421@ravnborg.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 07:11:12PM +0100, Sam Ravnborg wrote:
> Hi Daniel
> > > Feel free to just merge it via your tree. Patches here are pretty
> > > much independent ;-)
> > 
> > Ok I put it into drm-misc-next. I kinda assumed since there's also a huge
> > effort going on to shut up warnings, plus I think kerneldoc issues are
> > reported by a bunch of build bots nowadays. So assumed you pile this all
> > up.
> 
> Any reason "drm: fix some kernel-doc markups" was not applied?

Oh somehow I thought that one was only for i915 issues. I guess I'll take
a look.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
