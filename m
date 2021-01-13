Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B57E2F5196
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbhAMSAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbhAMSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:00:41 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE1BC061786
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:00:01 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id md11so1612662pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=M49+su6FFncBgS/CCqedl4zaR41swmris5y2FQmmX8Q=;
        b=Qp2ZpgMDB8wPfXkD1qxAPN+S6HJHqkyeiYeRindACAarfWpMuamYhPkgCHfb764Zc+
         GwSLBKbmWEekmGCbKIrA8LrNmy2kzc4XglmheYCjmrA7dQ/cA21T5o7zs80a1wSTFiyu
         hIQ0TX9RDpD8TSMaCgDUoF/P830n12KZOOmQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=M49+su6FFncBgS/CCqedl4zaR41swmris5y2FQmmX8Q=;
        b=K8ep39D4capNuMa1XSIGdm6OlAeOqyNzFZLD+apsH3VSwwEtK4G0vr87Mn5K368M3H
         tqxM7QFPt3CUhNyFPI9fg9hkMrRmhE+S2jYU7fupd7YXGbj1DS5bf5n6w4LHh8tpdMB8
         x7MoK7ewQbkm7741ZwZbgWJiMgJt6w0QnUCE8caSE//qJRXMxrdr0yYMXIMNUmrDRRoh
         nuTQEMK9CCjxaJeve+MANpwo/aaJzAZhEtA/Kme1fLN7o3N7lA3mVJ83m23DS6X7iEbN
         /Rr8sKnZJ/uGC+M9ltfkszUVY0iQ6PLsywMfBGjJcFcG/fp8kO2FEEL3eD6zlbpciPH9
         bO4g==
X-Gm-Message-State: AOAM531pEHreD8IflnKaJAv1wq/4plX4XN5RqtRcXAgxe48mLyKVA7ae
        p3d8+6kgGhCASHN37xG2/piwva1joZ5Rug==
X-Google-Smtp-Source: ABdhPJzDPnT7NEWPzGgmFD5HvClTVipXiJQcVnJAsKqYUmyLS4WAIKC6jAGAix2B7xquczdF+zO9Vw==
X-Received: by 2002:a17:902:b7c3:b029:da:74c3:427 with SMTP id v3-20020a170902b7c3b02900da74c30427mr3449507plz.38.1610560801075;
        Wed, 13 Jan 2021 10:00:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x23sm3944638pge.47.2021.01.13.10.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:00:00 -0800 (PST)
Date:   Wed, 13 Jan 2021 09:59:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gcc-plugins: fix gcc 11 indigestion with plugins...
Message-ID: <202101130959.596D763@keescook>
References: <38485.1610500756@turing-police>
 <20210113170836.xvlq5xlmkjpi4zx7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210113170836.xvlq5xlmkjpi4zx7@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 11:08:36AM -0600, Josh Poimboeuf wrote:
> On Tue, Jan 12, 2021 at 08:19:16PM -0500, Valdis Klētnieks wrote:
> > Fedora Rawhide has started including gcc 11,and the g++ compiler
> > throws a wobbly when it hits scripts/gcc-plugins:
> > 
> >   HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
> > In file included from /usr/include/c++/11/type_traits:35,
> >                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
> >                  from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
> >                  from scripts/gcc-plugins/gcc-common.h:7,
> >                  from scripts/gcc-plugins/latent_entropy_plugin.c:78:
> > /usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
> >  C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
> >    32 | #error This file requires compiler and library support \
> > 
> > Patch is more complicated than would otherwise be needed, because
> > older gcc (4.9, 5.4) have gnu++11 but throw an error due to a gcc bug
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> > 
> > Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> > ---
> > diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> > index d66949bfeba4..cc779973724a 100644
> > --- a/scripts/gcc-plugins/Makefile
> > +++ b/scripts/gcc-plugins/Makefile
> > @@ -21,10 +21,13 @@ always-y += $(GCC_PLUGIN)
> >  
> >  GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
> >  
> > +# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
> > +GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
> > +
> >  plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
> > -		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++98 \
> > +		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
> >  		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
> > -		   -ggdb -Wno-narrowing -Wno-unused-variable -Wno-c++11-compat \
> > +		   -ggdb -Wno-narrowing -Wno-unused-variable \
> >  		   -Wno-format-diag
> >  
> >  plugin_ldflags	= -shared
> 
> The first patch has already been merged into Linus' tree, so this
> probably should be an incremental fix on top, with a Fixes: tag.

Yes, please. :)

-- 
Kees Cook
