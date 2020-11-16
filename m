Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB032B4B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgKPQiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:38:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732229AbgKPQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:38:17 -0500
Received: from coco.lan (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4FD820776;
        Mon, 16 Nov 2020 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605544696;
        bh=1IlOLD7GIBCBf+m09ydYyuX5H9uTpUUyFItnLfJ9lMk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dJGhk5ITMH7hWGlCvMHW9XCxLwnIXHXzcsbb36ndm1A9PQ+4IAdxa7iE4MYlVE14g
         F6GXfRVnKd/WWxOiq5hWJGjxpCAAolYChjeVzryOamdL0ZzyX+Zth7DtKM37DJm1y3
         xxrddbUEgdYb5zx4SuqDTRKNeH387cUGeV92hLII=
Date:   Mon, 16 Nov 2020 17:38:04 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
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
Message-ID: <20201116173804.7d64f55f@coco.lan>
In-Reply-To: <20201116153606.GC401619@phenom.ffwll.local>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
        <21661aed9892a1bacc7ef76a5dc9f5c7b37f5d8f.1605521731.git.mchehab+huawei@kernel.org>
        <20201116153606.GC401619@phenom.ffwll.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 16 Nov 2020 16:36:06 +0100
Daniel Vetter <daniel@ffwll.ch> escreveu:

> On Mon, Nov 16, 2020 at 11:18:06AM +0100, Mauro Carvalho Chehab wrote:
> > Some identifiers have different names between their prototypes
> > and the kernel-doc markup.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I'm assuming you're sending a pull request for this.

Feel free to just merge it via your tree. Patches here are pretty
much independent ;-)

> -Daniel
> 
> > ---
> >  drivers/video/fbdev/core/fbcmap.c | 2 +-
> >  drivers/video/hdmi.c              | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcmap.c b/drivers/video/fbdev/core/fbcmap.c
> > index e5ae33c1a8e8..757d5c3f620b 100644
> > --- a/drivers/video/fbdev/core/fbcmap.c
> > +++ b/drivers/video/fbdev/core/fbcmap.c
> > @@ -59,41 +59,41 @@ static u16 blue16[] __read_mostly = {
> >      0x0000, 0xaaaa, 0x0000, 0xaaaa, 0x0000, 0xaaaa, 0x0000, 0xaaaa,
> >      0x5555, 0xffff, 0x5555, 0xffff, 0x5555, 0xffff, 0x5555, 0xffff
> >  };
> >  
> >  static const struct fb_cmap default_2_colors = {
> >      .len=2, .red=red2, .green=green2, .blue=blue2
> >  };
> >  static const struct fb_cmap default_8_colors = {
> >      .len=8, .red=red8, .green=green8, .blue=blue8
> >  };
> >  static const struct fb_cmap default_4_colors = {
> >      .len=4, .red=red4, .green=green4, .blue=blue4
> >  };
> >  static const struct fb_cmap default_16_colors = {
> >      .len=16, .red=red16, .green=green16, .blue=blue16
> >  };
> >  
> >  
> >  
> >  /**
> > - *	fb_alloc_cmap - allocate a colormap
> > + *	fb_alloc_cmap_gfp - allocate a colormap
> >   *	@cmap: frame buffer colormap structure
> >   *	@len: length of @cmap
> >   *	@transp: boolean, 1 if there is transparency, 0 otherwise
> >   *	@flags: flags for kmalloc memory allocation
> >   *
> >   *	Allocates memory for a colormap @cmap.  @len is the
> >   *	number of entries in the palette.
> >   *
> >   *	Returns negative errno on error, or zero on success.
> >   *
> >   */
> >  
> >  int fb_alloc_cmap_gfp(struct fb_cmap *cmap, int len, int transp, gfp_t flags)
> >  {
> >  	int size = len * sizeof(u16);
> >  	int ret = -ENOMEM;
> >  
> >  	flags |= __GFP_NOWARN;
> >  
> >  	if (cmap->len != len) {
> > diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> > index 1e4cb63d0d11..947be761dfa4 100644
> > --- a/drivers/video/hdmi.c
> > +++ b/drivers/video/hdmi.c
> > @@ -1675,41 +1675,42 @@ static int hdmi_audio_infoframe_unpack(struct hdmi_audio_infoframe *frame,
> >  
> >  	ret = hdmi_audio_infoframe_init(frame);
> >  	if (ret)
> >  		return ret;
> >  
> >  	ptr += HDMI_INFOFRAME_HEADER_SIZE;
> >  
> >  	frame->channels = ptr[0] & 0x7;
> >  	frame->coding_type = (ptr[0] >> 4) & 0xf;
> >  	frame->sample_size = ptr[1] & 0x3;
> >  	frame->sample_frequency = (ptr[1] >> 2) & 0x7;
> >  	frame->coding_type_ext = ptr[2] & 0x1f;
> >  	frame->channel_allocation = ptr[3];
> >  	frame->level_shift_value = (ptr[4] >> 3) & 0xf;
> >  	frame->downmix_inhibit = ptr[4] & 0x80 ? true : false;
> >  
> >  	return 0;
> >  }
> >  
> >  /**
> > - * hdmi_vendor_infoframe_unpack() - unpack binary buffer to a HDMI vendor infoframe
> > + * hdmi_vendor_any_infoframe_unpack() - unpack binary buffer to a HDMI
> > + * 	vendor infoframe
> >   * @frame: HDMI Vendor infoframe
> >   * @buffer: source buffer
> >   * @size: size of buffer
> >   *
> >   * Unpacks the information contained in binary @buffer into a structured
> >   * @frame of the HDMI Vendor information frame.
> >   * Also verifies the checksum as required by section 5.3.5 of the HDMI 1.4
> >   * specification.
> >   *
> >   * Returns 0 on success or a negative error code on failure.
> >   */
> >  static int
> >  hdmi_vendor_any_infoframe_unpack(union hdmi_vendor_any_infoframe *frame,
> >  				 const void *buffer, size_t size)
> >  {
> >  	const u8 *ptr = buffer;
> >  	size_t length;
> >  	int ret;
> >  	u8 hdmi_video_format;
> >  	struct hdmi_vendor_infoframe *hvf = &frame->hdmi;
> > -- 
> > 2.28.0
> >   
> 



Thanks,
Mauro
