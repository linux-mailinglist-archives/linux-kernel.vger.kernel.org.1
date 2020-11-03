Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718D92A438D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgKCKz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgKCKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:55:27 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A26DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 02:55:27 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id p19so3111466wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 02:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+KRoxaxWoP931pjhgr3QuPJCTEb7tuzgIbQbwmrzu9g=;
        b=Ol04UUQSfW6ux3RlOkA+C6+MmHfaKF74G+UFYH5yLKmlvLHa9sMqriK/aq/ywbcAuQ
         Xnk83l/kUwaPaQp0nU6bevo5gwJ7RO7DE0bc4PQQ3RCyXpudJDJojvMzMWavOa2nGuuS
         8+vOwvYk800pCIgua1SGmBKC4pZ1dWYP9GhlO+88pvhqlOcTkrRXZekOqjHFVWBiD9O+
         Z0M8wibCQ3rXXzu97iz1U0eNGMrZLHnjas9qzmEXARzZvBlx+OHVf3qqkPqVC0z6mA8Q
         bHUglms3pdQfbwweNAItA4ljBTit8bVGWWzNAnWRtUwv7x7O6zBsYC9ZMOc1Dk8pwXHL
         rHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+KRoxaxWoP931pjhgr3QuPJCTEb7tuzgIbQbwmrzu9g=;
        b=jlIiUZtKrbBYnDjEOWa3RRStNCw05Hyi6fd4fDZ8vi+aRsG27PSfA0JTX8sX2cn6fD
         AyZZ68nUFEY3+TsLJ2DFVUPT7EPPNk0HeYj0HQ0k8Njnb7UvrTWbw1zD5xQhxNdv2RSs
         fQyb25uQjd3cIF7z0bEJxx2tNdsPe0un1Ijgbqk8VeslpCQmvqWahDzCpHcTshcpyaVL
         ISg3Y9H95SvEmk3guTkn3EAbqyddv/3nJVfDvw6SA/eIp3MQXBZPWbbZ+i0cqa3+G51n
         T+LRWGd8fjpcJF/p07X4ZauV6TSHafFfV2iHxGube/kUiiA9I6iC9dsmXBw+56gEUpU1
         ZE0w==
X-Gm-Message-State: AOAM5329ZQ+351B7ubgdHszzvMLs7Q0HWp8ZQeLp+eHcKr6MsAq0J63N
        UaaQNO025Bj06Z1aI/dDHzfopg==
X-Google-Smtp-Source: ABdhPJyHMlpjYWcgrY1NvCUqCBWvWxQQy2Hu/2TVnz7K91UtDbRzNOBmUhJ1oX0oDJrv7tqX2td3sQ==
X-Received: by 2002:a1c:b746:: with SMTP id h67mr2876554wmf.43.1604400926171;
        Tue, 03 Nov 2020 02:55:26 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t5sm2638295wmg.19.2020.11.03.02.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 02:55:25 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:55:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] Fonts: Replace discarded const qualifier
Message-ID: <20201103105523.GO4488@dell>
References: <20201030181822.570402-1-lee.jones@linaro.org>
 <20201102183242.2031659-1-yepeilin.cs@gmail.com>
 <20201103085324.GL4488@dell>
 <CAKMK7uGV10+TEWWMJod1-MRD1jkLqvOGUu4Qk9S84WJAUaB7Mg@mail.gmail.com>
 <20201103091538.GA2663113@kroah.com>
 <20201103095239.GW401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103095239.GW401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020, Daniel Vetter wrote:

> On Tue, Nov 03, 2020 at 10:15:38AM +0100, Greg KH wrote:
> > On Tue, Nov 03, 2020 at 09:58:18AM +0100, Daniel Vetter wrote:
> > > On Tue, Nov 3, 2020 at 9:53 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Mon, 02 Nov 2020, Peilin Ye wrote:
> > > >
> > > > > From: Lee Jones <lee.jones@linaro.org>
> > > > >
> > > > > Commit 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros for built-in
> > > > > fonts") introduced the following error when building rpc_defconfig (only
> > > > > this build appears to be affected):
> > > > >
> > > > >  `acorndata_8x8' referenced in section `.text' of arch/arm/boot/compressed/ll_char_wr.o:
> > > > >     defined in discarded section `.data' of arch/arm/boot/compressed/font.o
> > > > >  `acorndata_8x8' referenced in section `.data.rel.ro' of arch/arm/boot/compressed/font.o:
> > > > >     defined in discarded section `.data' of arch/arm/boot/compressed/font.o
> > > > >  make[3]: *** [/scratch/linux/arch/arm/boot/compressed/Makefile:191: arch/arm/boot/compressed/vmlinux] Error 1
> > > > >  make[2]: *** [/scratch/linux/arch/arm/boot/Makefile:61: arch/arm/boot/compressed/vmlinux] Error 2
> > > > >  make[1]: *** [/scratch/linux/arch/arm/Makefile:317: zImage] Error 2
> > > > >
> > > > > The .data section is discarded at link time.  Reinstating acorndata_8x8 as
> > > > > const ensures it is still available after linking.  Do the same for the
> > > > > other 12 built-in fonts as well, for consistency purposes.
> > > > >
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > > Fixes: 6735b4632def ("Fonts: Support FONT_EXTRA_WORDS macros for built-in fonts")
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > Co-developed-by: Peilin Ye <yepeilin.cs@gmail.com>
> > > > > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > >   - Fix commit ID to 6735b4632def in commit message (Russell King
> > > > >     <linux@armlinux.org.uk>)
> > > > >   - Add `const` back for all 13 built-in fonts (Daniel Vetter
> > > > >     <daniel.vetter@ffwll.ch>)
> > > > >   - Add a Fixes: tag
> > > > >
> > > > >  lib/fonts/font_10x18.c     | 2 +-
> > > > >  lib/fonts/font_6x10.c      | 2 +-
> > > > >  lib/fonts/font_6x11.c      | 2 +-
> > > > >  lib/fonts/font_6x8.c       | 2 +-
> > > > >  lib/fonts/font_7x14.c      | 2 +-
> > > > >  lib/fonts/font_8x16.c      | 2 +-
> > > > >  lib/fonts/font_8x8.c       | 2 +-
> > > > >  lib/fonts/font_acorn_8x8.c | 2 +-
> > > > >  lib/fonts/font_mini_4x6.c  | 2 +-
> > > > >  lib/fonts/font_pearl_8x8.c | 2 +-
> > > > >  lib/fonts/font_sun12x22.c  | 2 +-
> > > > >  lib/fonts/font_sun8x16.c   | 2 +-
> > > > >  lib/fonts/font_ter16x32.c  | 2 +-
> > > > >  13 files changed, 13 insertions(+), 13 deletions(-)
> > > >
> > > > LGTM.
> > > >
> > > > Thanks for keeping my authorship.  Much appreciated.
> > > 
> > > Should I stuff this into drm-misc-fixes? Or will someone else pick
> > > this up? Greg?
> > > 
> > > I guess drm-misc-fixes might be easiest since there's a bunch of other
> > > fbcon/font stuff in the queue in drm-misc from Peilin.
> > 
> > You can take it:
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Applied to drm-misc-fixes, thanks everyone!

Would you be kind enough to let us know when this lands in Mainline
please?  We'll need to back-port it to start fixing up our Stable
kernels ASAP.

TIA.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
