Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E726C055
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgIPJTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgIPJTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:19:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA533C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:19:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so6028915wrn.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=NetssDfLMpPwZ1ag5RCqykVyQO38ofbrcIBQ7qHK6pY=;
        b=Ih8d12tnCiF6uwywXnhdLjx6PI2H06LVi+m03GEr/Fd5oZX3vRtgoINf4zGiJAx6En
         +lEqQy/dRUhekUTDbyU8OneJwf6mBEvC3CkUJ9949+GgQWa8WTsnEosxFyW4bOcBQCS2
         L8wlwN++fkiZjGTf3XXc61r+HXl/RTToPMm/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NetssDfLMpPwZ1ag5RCqykVyQO38ofbrcIBQ7qHK6pY=;
        b=sz39IoiOqgp8VxvqtmxuDWIJe++Nik41aVpCiC8J8ACtNU9ZWvMT3DwbbX/kaJzl1f
         moN3DgnnscjaE36WPeTaUIP0AlpuoTqRC4jpWypyiXj6vmzW6ProXbLmd1juLCxKRTs/
         5dVtSNu3jShPe31t0IMVn2ol+NR3n/yRd2y9gPnTrzNzOackDi5lGSmHfGBmrB+cpkQs
         mBUvQEZt2Gn8PKl7izL0O4M8hJA8elQsram2HDvM+cmNy+A7dWZl9AuFR5UJbp3DvhA5
         CsiawaZX8F0yxZJI07G6pKoXPrqPeNr2YOIR34Up6oBVHHcCC56LwcO9DN9ehyQGkteJ
         IKog==
X-Gm-Message-State: AOAM533u4s1smK79v6n0xGpfqg3GM2eXfoELeyfiH4rHSykCIjvkiQF6
        8/t1h92zDg/Z1zpVfT3+Sn3weg==
X-Google-Smtp-Source: ABdhPJxQZxpUmYxi0pmhuEEug8N7pJYz8tL3t/YNJnSm6QP+Q5v8ZqUWUl++HQ2YBXkGzAVTeiMD6w==
X-Received: by 2002:adf:f80a:: with SMTP id s10mr27111493wrp.351.1600247946114;
        Wed, 16 Sep 2020 02:19:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id r14sm31759089wrn.56.2020.09.16.02.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 02:19:05 -0700 (PDT)
Date:   Wed, 16 Sep 2020 11:19:03 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-aspeed@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: make linux-aspeed list remarks consistent
Message-ID: <20200916091903.GZ438822@phenom.ffwll.local>
Mail-Followup-To: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200912183334.22683-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200912183334.22683-1-lukas.bulwahn@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 12, 2020 at 08:33:34PM +0200, Lukas Bulwahn wrote:
> Commit f15a3ea80391 ("MAINTAINERS: Add ASPEED BMC GFX DRM driver entry")
> does not mention that linux-aspeed@lists.ozlabs.org is moderated for
> non-subscribers, but the other three entries for
> linux-aspeed@lists.ozlabs.org do.
> 
> By 'majority vote' among entries, let us assume it was just missed here and
> adjust it to be consistent with others.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on master and next-20200911
> 
> Joel, please ack.
> David, Daniel, please pick this minor non-urgent clean-up patch.

Pushed to drm-misc-next, thanks.
-Daniel

> This patch submission will also show me if linux-aspeed is moderated or
> not. I have not subscribed to linux-aspeed and if it shows up quickly in
> the archive, the list is probably not moderated; and if it takes longer,
> it is moderated, and hence, validating the patch.
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26af84f97353..f2561c3fc9db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5448,7 +5448,7 @@ F:	drivers/gpu/drm/panel/panel-arm-versatile.c
>  
>  DRM DRIVER FOR ASPEED BMC GFX
>  M:	Joel Stanley <joel@jms.id.au>
> -L:	linux-aspeed@lists.ozlabs.org
> +L:	linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>  S:	Supported
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/gpu/aspeed-gfx.txt
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
