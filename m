Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907F22B4CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbgKPRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731709AbgKPRYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:24:09 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D4C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:24:08 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id m125so13086485wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=VT/xySWsVOOU8SioegJzXoHfZdY+mhRolZpe9MYTwM8=;
        b=AnPxyDUVdxrbYZafs+evqvV9ZfNXxX1h9lH21wgUCNgsI7J8G3xvWjuq8L6wrYpZo6
         r9CA9RY7hplgno4XMoJIy3j0V8HPqOpZkW0KLHMn3sxHRnNA6f0wMZCc2nxTLiSRixLC
         zTldjVpBwgEn8pr9vN+HnGkf3iNyB3gArgb+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=VT/xySWsVOOU8SioegJzXoHfZdY+mhRolZpe9MYTwM8=;
        b=o56W09lKJZ5H0hY8+p8w41+bgu75xLwcYMv1C0gdYtkwxoZ0IkUkyEp6UHmXECyavv
         +Y8Mny7liyN3cAKHJ6GcWkhS+aDUjcFIkou5g3F8NGG1wz0uacgqt5gJuDfGaFjQe7PG
         2fHKGPYX5ED8RbED27S6vwnh/XSCJjMXwR0qjlGAeHx4soSGdL82buQjaxKkKXpBDVC5
         CxhGDhXAiWhdtY1L2YGLOr1RQWPl9m0VLbnCQDaHHgmWPWUV5+64FtubLLBs8iC0uTie
         lyCxZWxh2hI5JpekKcqkC/vmk4A4zdn4opWmkEFM9Q+VL5ORXKJnIOwFWpGvfeQyd6Pn
         4MOA==
X-Gm-Message-State: AOAM5322ScsqI6UDHjFjT4botH5fFVyT7NytkGWl3N6/0gZA0tYkMEoY
        gDpvbbuSiY17F+kiYn2i8pSLmw==
X-Google-Smtp-Source: ABdhPJyXF+9a4eCq88+bEfmvIMaLyiW2+ODDxhn8ltHzU+MOVfk/7Rgjqldak/b7tn81SkFuLZhKFA==
X-Received: by 2002:a7b:ce8a:: with SMTP id q10mr16552904wmj.101.1605547446987;
        Mon, 16 Nov 2020 09:24:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s133sm20767714wmf.30.2020.11.16.09.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:24:06 -0800 (PST)
Date:   Mon, 16 Nov 2020 18:24:04 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/27] video: fix some kernel-doc markups
Message-ID: <20201116172404.GD401619@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <21661aed9892a1bacc7ef76a5dc9f5c7b37f5d8f.1605521731.git.mchehab+huawei@kernel.org>
 <20201116153606.GC401619@phenom.ffwll.local>
 <20201116173804.7d64f55f@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116173804.7d64f55f@coco.lan>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 05:38:04PM +0100, Mauro Carvalho Chehab wrote:
> Em Mon, 16 Nov 2020 16:36:06 +0100
> Daniel Vetter <daniel@ffwll.ch> escreveu:
> 
> > On Mon, Nov 16, 2020 at 11:18:06AM +0100, Mauro Carvalho Chehab wrote:
> > > Some identifiers have different names between their prototypes
> > > and the kernel-doc markup.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> > 
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > I'm assuming you're sending a pull request for this.
> 
> Feel free to just merge it via your tree. Patches here are pretty
> much independent ;-)

Ok I put it into drm-misc-next. I kinda assumed since there's also a huge
effort going on to shut up warnings, plus I think kerneldoc issues are
reported by a bunch of build bots nowadays. So assumed you pile this all
up.
-Daniel

> 
> > -Daniel
> > 
> > > ---
> > >  drivers/video/fbdev/core/fbcmap.c | 2 +-
> > >  drivers/video/hdmi.c              | 3 ++-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/fbcmap.c
> > > index e5ae33c1a8e8..757d5c3f620b 100644
> > > --- a/drivers/video/fbdev/core/fbcmap.c
> > > +++ b/drivers/video/fbdev/core/fbcmap.c
> > > @@ -59,41 +59,41 @@ static u16 blue16[] __read_mostly = {
> > >      0x0000, 0xaaaa, 0x0000, 0xaaaa, 0x0000, 0xaaaa, 0x0000, 0xaaaa,
> > >      0x5555, 0xffff, 0x5555, 0xffff, 0x5555, 0xffff, 0x5555, 0xffff
> > >  };
> > >  
> > >  static const struct fb_cmap default_2_colors = {
> > >      .len=2, .red=red2, .green=green2, .blue=blue2
> > >  };
> > >  static const struct fb_cmap default_8_colors = {
> > >      .len=8, .red=red8, .green=green8, .blue=blue8
> > >  };
> > >  static const struct fb_cmap default_4_colors = {
> > >      .len=4, .red=red4, .green=green4, .blue=blue4
> > >  };
> > >  static const struct fb_cmap default_16_colors = {
> > >      .len=16, .red=red16, .green=green16, .blue=blue16
> > >  };
> > >  
> > >  
> > >  
> > >  /**
> > > - *	fb_alloc_cmap - allocate a colormap
> > > + *	fb_alloc_cmap_gfp - allocate a colormap
> > >   *	@cmap: frame buffer colormap structure
> > >   *	@len: length of @cmap
> > >   *	@transp: boolean, 1 if there is transparency, 0 otherwise
> > >   *	@flags: flags for kmalloc memory allocation
> > >   *
> > >   *	Allocates memory for a colormap @cmap.  @len is the
> > >   *	number of entries in the palette.
> > >   *
> > >   *	Returns negative errno on error, or zero on success.
> > >   *
> > >   */
> > >  
> > >  int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t flags)
> > >  {
> > >  	int size = len * sizeof(u16);
> > >  	int ret = -ENOMEM;
> > >  
> > >  	flags |= __GFP_NOWARN;
> > >  
> > >  	if (cmap->len != len) {
> > > diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> > > index 1e4cb63d0d11..947be761dfa4 100644
> > > --- a/drivers/video/hdmi.c
> > > +++ b/drivers/video/hdmi.c
> > > @@ -1675,41 +1675,42 @@ static int hdmi_audio_infoframe_unpack(struct hdmi_audio_infoframe *frame,
> > >  
> > >  	ret = hdmi_audio_infoframe_init(frame);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > >  	ptr += HDMI_INFOFRAME_HEADER_SIZE;
> > >  
> > >  	frame->channels = ptr[0] & 0x7;
> > >  	frame->coding_type = (ptr[0] >> 4) & 0xf;
> > >  	frame->sample_size = ptr[1] & 0x3;
> > >  	frame->sample_frequency = (ptr[1] >> 2) & 0x7;
> > >  	frame->coding_type_ext = ptr[2] & 0x1f;
> > >  	frame->channel_allocation = ptr[3];
> > >  	frame->level_shift_value = (ptr[4] >> 3) & 0xf;
> > >  	frame->downmix_inhibit = ptr[4] & 0x80 ? true : false;
> > >  
> > >  	return 0;
> > >  }
> > >  
> > >  /**
> > > - * hdmi_vendor_infoframe_unpack() - unpack binary buffer to a HDMI vendor infoframe
> > > + * hdmi_vendor_any_infoframe_unpack() - unpack binary buffer to a HDMI
> > > + * 	vendor infoframe
> > >   * @frame: HDMI Vendor infoframe
> > >   * @buffer: source buffer
> > >   * @size: size of buffer
> > >   *
> > >   * Unpacks the information contained in binary @buffer into a structured
> > >   * @frame of the HDMI Vendor information frame.
> > >   * Also verifies the checksum as required by section 5.3.5 of the HDMI 1.4
> > >   * specification.
> > >   *
> > >   * Returns 0 on success or a negative error code on failure.
> > >   */
> > >  static int
> > >  hdmi_vendor_any_infoframe_unpack(union hdmi_vendor_any_infoframe *frame,
> > >  				 const void *buffer, size_t size)
> > >  {
> > >  	const u8 *ptr = buffer;
> > >  	size_t length;
> > >  	int ret;
> > >  	u8 hdmi_video_format;
> > >  	struct hdmi_vendor_infoframe *hvf = &frame->hdmi;
> > > -- 
> > > 2.28.0
> > >   
> > 
> 
> 
> 
> Thanks,
> Mauro

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
