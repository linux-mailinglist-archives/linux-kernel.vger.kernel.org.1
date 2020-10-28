Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6E229D81E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbgJ1W3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387584AbgJ1W3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:29:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32BDC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:29:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h22so755000wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=WLWDWfUn62HuyKL78MLrBuM1P4gEN0IVPMugnmjyIpc=;
        b=Oj55s1u+HirbuDDCtgGf2TCwNQs1t7Hb/dfEAbtoX4rp6Vi9YOyYi0ZR6vyFEJnv46
         srMzjKdpNzPMuK/b/uwsPoV8xLsInM+031sEoA5Uns+jUhqfFFLnA1zctrfKyId7XHGc
         IbDB6x5ghe+8hsKenVf6Dwci2fYo3m0yskyWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=WLWDWfUn62HuyKL78MLrBuM1P4gEN0IVPMugnmjyIpc=;
        b=DYWnT3Q4Qs7dhAFfUjL6obNO2q8Hmy6VC93LhnbFG+2VMlRRgpi1+WHwZSBKev+J4r
         9+y0PMbSOXkI+225GUOsPrTTiDkvVwvKxPCcGpa7OsZj5caUY/Zb0V1aF8tMzbc004Ls
         /Mmtdk2Jo4bsJDCSxztpnUIg6a8KE8lLzMwEvZ8J48abQBeN4CIhFlDPe2nExqxk8j1S
         36JlSDzV2y0BWHef/dCuBAZR52K5BF3pcKS4aNqXorp3s0nwnkU/SulQcgWQfIOzBN+K
         5wuo41PEdi8Cks5NZkynGLBihB6B5eb6voFQzPs+xZEF3URpAuJGjk/iucx24wa26Yj8
         T48w==
X-Gm-Message-State: AOAM532BZWT4liY9eDycmP2Uck/v9Dk7Yv1bjS9fDvtpD1P6AfhcHkOC
        c01Ps292U+9jdcJWn40Yh+aRn+pbfZeclKsX
X-Google-Smtp-Source: ABdhPJz+EU8YlisomHF2zSjkLF+2zPf9qTQiMauCyQazYiNEgL02k8jKGZP/kZkcr+tV3wxSwpQU7g==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr7567498wmi.186.1603884560710;
        Wed, 28 Oct 2020 04:29:20 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id g5sm5698229wmi.4.2020.10.28.04.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 04:29:19 -0700 (PDT)
Date:   Wed, 28 Oct 2020 12:29:17 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Hoegeun Kwon <hoegeun.kwon@samsung.com>, eric@anholt.net,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        dave.stevenson@raspberrypi.com, sungguk.na@samsung.com
Subject: Re: [PATCH 1/1] drm/vc4: drv: Add error handding for bind
Message-ID: <20201028112917.GW401619@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>, eric@anholt.net,
        airlied@linux.ie, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        dave.stevenson@raspberrypi.com, sungguk.na@samsung.com
References: <20201027041442.30352-1-hoegeun.kwon@samsung.com>
 <CGME20201027041535epcas1p489bbfe80b461f1e5c5deca1a571f1f35@epcas1p4.samsung.com>
 <20201027041442.30352-2-hoegeun.kwon@samsung.com>
 <20201027145431.zasv2oiydglz3n63@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027145431.zasv2oiydglz3n63@gilmour.lan>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 03:54:31PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Oct 27, 2020 at 01:14:42PM +0900, Hoegeun Kwon wrote:
> > There is a problem that if vc4_drm bind fails, a memory leak occurs on
> > the drm_property_create side. Add error handding for drm_mode_config.
> > 
> > Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> 
> Applied, thanks!

Switching over to drmm_ version of this would also be good I think.
Together with the devm_ version for allocating the drm_device you could
delete a pile of that fragile cleanup code.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
