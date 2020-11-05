Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7272A7BDB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 11:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbgKEKbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 05:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKEKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 05:31:22 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A590C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 02:31:22 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so1100770pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 02:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VGBAVhOjF+1BxiCG/QGd19p6o0KRA/Zwhk/3kLtyC0c=;
        b=lenVPGBmSJhTb/UugRXW30QVkwiYJB2VZBF7yqxIZcxabmZ5KHJNswuG+t72ZdlM6O
         PAAOueXzrJeQ+J/N4yfUOkXbTLEGZ2zObqHv9JiuVABfy+D6gepDEumNuSHI9FrwXCbU
         TaUyVfFG1OCY+V4o2iZVJZOFQl39F0pQjwYK5FlYBOj+s+rTSRSAsKKl6wSPYazxDK4l
         2xUUCfK9XH8KMeiJWuhkfMsC43jI5pyyF8p02IEC+JEQUJ45Y30sy0k5bFrGGVrItBkP
         HNCv3C/hZnizjUfJFEm3uCc5KsdCjPMrhG5C4xZ/Eq4dzhOWya2q+US6VxP2AKl4mcQ3
         RCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VGBAVhOjF+1BxiCG/QGd19p6o0KRA/Zwhk/3kLtyC0c=;
        b=YvRigA6Hlu/b+c4Zo/FHUkU24HwhJwYqhwlxqngww7dmKm4IIo6iA1U7aFGJGYdnuh
         ro/eKWCwNGdErSjdoEPR1PYvsk1cfD504N4vRzteV22c19IwiKQiJDGQ7lWHHn0qe8qq
         KsjoFvSjSwIIvwVR1J0krSkckybTjHFVsYHp2aNK/O0Hl4FXit9vWxs1CjRfzxTCJEzL
         upnPn4f1QrFI0plFZfEU87NLK13iinkGiFpTsAyBnASS7dfW1ddKnD5mZDUXyCP3TEdi
         q99pbxf0MLx52qZjT46NMlbq8H06RC/f/GNBE8r/j7wsBVxcs7j2Oya9xC/D7pX6utDa
         +jbw==
X-Gm-Message-State: AOAM530UnuwVgXMSQGW3ynk0e7uRaiHAtIem+1UlTXb7J2W4CXek9dts
        F95bjtUj5tipxkJnMnpkSoHEq2+hMz0=
X-Google-Smtp-Source: ABdhPJwStwAjBGuTGKkmIgB0euUBZ1GO72dQX2OO75O1JkDC15NMT+JqeburedC0i5Tq4w/Got6s6Q==
X-Received: by 2002:a63:cf15:: with SMTP id j21mr1745244pgg.116.1604572281886;
        Thu, 05 Nov 2020 02:31:21 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id z10sm1924092pff.218.2020.11.05.02.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 02:31:21 -0800 (PST)
Date:   Thu, 5 Nov 2020 16:01:16 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     daniel@ffwll.ch, mh12gx2825@gmail.com
Subject: Re: [PATCH] drm/vgm: replace idr_init() by idr_init_base()
Message-ID: <20201105103116.GA29881@localhost>
References: <20201104112338.GA29271@localhost>
 <20201105094215.GT401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105094215.GT401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 10:42:15AM +0100, Daniel Vetter wrote:
> On Wed, Nov 04, 2020 at 04:53:38PM +0530, Deepak R Varma wrote:
> > idr_init() uses base 0 which is an invalid identifier. The new function
> > idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> > all lookups that otherwise starts from 0 since 0 is always unused.
> > 
> > References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> > 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> 
> Tiny typo in the commit message summary: s/vgm/vgem/
> 
> Also can you pls resbumit this with intel-gfx mailing list on cc (like for
> i915)? There's a CI bot there which runs a few vgem tests, would be good
> to confirm nothing has been broken.

Hi Daniel,
sure. I will correct the summary typo and also feed it to the CI bot.

Also, according to Felix Kuehling's comment on a similar patch for
drm/amdkfd driver, an ID can be 0. The change I am proposing is more
efficient for conditions that do not want to use ID as 0. Otherwise,
id = 0 is an acceptable possibility. So, my statement that "Id 0 is an invalid
identifier" is not true.

Can you please comment if this is accurate and I should reword my log
message as well?

Thank you.
./drv

> 
> Otherwise lgtm.
> 
> Thanks, Daniel
> 
> > ---
> >  drivers/gpu/drm/vgem/vgem_fence.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/vgem/vgem_fence.c b/drivers/gpu/drm/vgem/vgem_fence.c
> > index 17f32f550dd9..2902dc6e64fa 100644
> > --- a/drivers/gpu/drm/vgem/vgem_fence.c
> > +++ b/drivers/gpu/drm/vgem/vgem_fence.c
> > @@ -233,7 +233,7 @@ int vgem_fence_signal_ioctl(struct drm_device *dev,
> >  int vgem_fence_open(struct vgem_file *vfile)
> >  {
> >  	mutex_init(&vfile->fence_mutex);
> > -	idr_init(&vfile->fence_idr);
> > +	idr_init_base(&vfile->fence_idr, 1);
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
