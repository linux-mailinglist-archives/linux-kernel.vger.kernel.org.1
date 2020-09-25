Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BF278982
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgIYNZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgIYNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:25:56 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EC0C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 06:25:55 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so3029857wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=yoij1P7j+Xx2RWFa9SVqI2FsfBHkpzDlIUwpiLGvHCs=;
        b=O5Wv1IsSLOcxCzcYzyGteQ12YwvQDDgtGufFm3QgoL3W9ikTTvLPP56IBzaY85PZFs
         p7JxOohdXRnM2KsAxLCSc5felltd/SWWA6JwHieEfFf8z6q8p7bV0yK56vOcTBaEQJZK
         nQZdCFnKQyDz4RX3JYfbOSd9QXr6fN1Z9n6g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=yoij1P7j+Xx2RWFa9SVqI2FsfBHkpzDlIUwpiLGvHCs=;
        b=eHWtS0bW3ofYzcWzxvciRKMxBN2ALYj7lrR27bxKTpG892KGYr2bV0aAZxSN99DRFn
         gEOs6FTIVREjVJGI3sR/il6RDLKWxouEAPfqJNLb988ltbNxF/4lpu84XjWh0PQbo1LZ
         bJdw2NLqw3UPKFxvjs+oDSp3btWJ1xLUdiEgdc5W1SKTyG5LTY7Oc4W2GeOu67uIk7MI
         r18w4B2m+FKoWRkea3WuoSRZXDwI8TYNhAuicX5kmev1ph5VPdnsVcAXrzeLv3qRXeP2
         UrN+Aa3fyQ9f7SEki2bXISuKB4v6nCNYj0L8mn2BLcQ+MaySnz1hvkWpKZm8jGak66HZ
         qwAw==
X-Gm-Message-State: AOAM5306zHKgun+WOsD5nUy7e1gLpIEaM4lLtn3wTV//tsBKoPhYoXDY
        q7UL6t1sz8hd0PNxR2u7OkMCtA==
X-Google-Smtp-Source: ABdhPJyBZrVOoGGq5hPUstHZ/Y1HyDY0PIguaVz0GuDdkIvNUqMBJyEp1I87FKugY2GqQ8LaJuCahA==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr3071230wmj.19.1601040354194;
        Fri, 25 Sep 2020 06:25:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u2sm3275837wre.7.2020.09.25.06.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 06:25:53 -0700 (PDT)
Date:   Fri, 25 Sep 2020 15:25:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200925132551.GF438822@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925101300.GA890211@PWN>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 06:13:00AM -0400, Peilin Ye wrote:
> Hi all!
> 
> On Fri, Sep 25, 2020 at 08:46:04AM +0200, Jiri Slaby wrote:
> > > In order to perform a reliable range check, fbcon_get_font() needs to know
> > > `FONTDATAMAX` for each built-in font under lib/fonts/. Unfortunately, we
> > > do not keep that information in our font descriptor,
> > > `struct console_font`:
> > > 
> > > (include/uapi/linux/kd.h)
> > > struct console_font {
> > > 	unsigned int width, height;	/* font size */
> > > 	unsigned int charcount;
> > > 	unsigned char *data;	/* font data with height fixed to 32 */
> > > };
> > > 
> > > To make things worse, `struct console_font` is part of the UAPI, so we
> > > cannot add a new field to keep track of `FONTDATAMAX`.
> > 
> > Hi,
> > 
> > but you still can define struct kernel_console_font containing struct
> > console_font and the 4 more members you need in the kernel. See below.
> > 
> > > Fortunately, the framebuffer layer itself gives us a hint of how to
> > > resolve this issue without changing UAPI. When allocating a buffer for a
> > > user-provided font, fbcon_set_font() reserves four "extra words" at the
> > > beginning of the buffer:
> > > 
> > > (drivers/video/fbdev/core/fbcon.c)
> > > 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
> > 
> > I might be missing something (like coffee in the morning), but why don't
> > you just:
> > 1) declare struct font_data as
> > {
> >   unsigned sum, char_count, size, refcnt;
> >   const unsigned char data[];
> > }
> > 
> > Or maybe "struct console_font font" instead of "const unsigned char
> > data[]", if need be.
> > 
> > 2) allocate by:
> >   kmalloc(struct_size(struct font_data, data, size));
> > 
> > 3) use container_of wherever needed
> > 
> > That is you name the data on negative indexes using struct as you
> > already have to define one.
> > 
> > Then you don't need the ugly macros with negative indexes. And you can
> > pass this structure down e.g. to fbcon_do_set_font, avoiding potential
> > mistakes in accessing data[-1] and similar.
> 
> Sorry that I didn't mention it in the cover letter, but yes, I've tried
> this - a new `kernel_console_font` would be much cleaner than negative
> array indexing.
> 
> The reason I ended up giving it up was, frankly speaking, these macros
> are being used at about 30 places, and I am not familiar enough with the
> framebuffer and newport_con code, so I wasn't confident how to clean
> them up and plug in `kernel_console_font` properly...
> 
> Another reason was that, functions like fbcon_get_font() handle both user
> fonts and built-in fonts, so I wanted a single solution for both of
> them. I think we can't really introduce `kernel_console_font` while
> keeping these macros, that would make the error handling logics etc.
> very messy.
> 
> I'm not very sure what to do now. Should I give it another try cleaning
> up all the macros?
> 
> And thank you for reviewing this!

I think the only way to make this work is that we have one place which
takes in the userspace uapi struct, and then converts it once into a
kernel_console_font. With all the error checking.

Then all internal code deals in terms of kernel_console_font, with
properly typed and named struct members and helper functions and
everything. And we might need a gradual conversion for this, so that first
we can convert over invidual console drivers, then subsystems, until at
the end we've pushed the conversion from uapi array to kernel_console_font
all the way to the ioctl entry points.

But that's indeed a huge pile of work, and fair warning: fbcon is
semi-orphaned, so by doing this you'll pretty much volunteer for
maintainership :-)

But I'd be very happy to help get this done and throw some maintainership
credentials at you in the proces ...

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
