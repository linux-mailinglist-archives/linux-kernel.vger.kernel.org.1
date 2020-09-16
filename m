Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7A26BE6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgIPHov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIPHoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:44:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92A6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:44:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so5820422wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=gACftkqjBuyjf+zxcwTdPE4aVk82AzAE+qvbHK69U/A=;
        b=VW8jw8YEYjZgdPD435inAB/oRSzC7kFip/OyJ50F6TkuQejvY7gjR6mMsmxb0pgZu4
         0CWP/EKGJlgXwKBxMGZRAGyo8YNjbwIeX8bFmIOvcVV31Y66W5BD1Fw01Y/T4jmL+drS
         SoNWdGUp7DaS1aBBYPItmTnL4mdzRmkENIMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=gACftkqjBuyjf+zxcwTdPE4aVk82AzAE+qvbHK69U/A=;
        b=Cp9wNiRkuelof0ZPalIDqVvY2eWS/fIr2597Mj99xWARJ+qwkoRR2d5HnQZzDrRSdR
         Z4UxJOYQRrtCRqzho6sB4VEhbNv+NorA3MBb+PQxzinQCODtf3wnv5lYRCGtApn9Is+7
         Xn7Bp0Wmol0UGfGPJ5EECtMnpjn0RgD1qvZY2j2HWiMMTTFREsjZkU/R+suLb59KmTOh
         8rS/g0IZdCxEW5007yhkTT0QGSNIspZ4Mg1gk1sfPO6GFqf+mmlefPVYszOab4Z2YWU8
         Tj1EeaS9sS4he7rs+/pOi4NppkcsY/KB0MzXGapDj3CkatS9M4WepICJZIveHfB4i/B/
         qRwA==
X-Gm-Message-State: AOAM531U6EaPoAEw0MrVEFPDGwz/9ZJQf06vOKlrHCXT8u9sUsfEWpc2
        OJDJ+h7RHh/7+tQXXy3EGwUkYA==
X-Google-Smtp-Source: ABdhPJz1K5cCNxbRhfiXX5qHSgznwHKvu3aphdwgb8xTXLmzsdmPPiKGgtxrfodwW8+zN4AkEr3WKQ==
X-Received: by 2002:adf:fec7:: with SMTP id q7mr25329042wrs.293.1600242284167;
        Wed, 16 Sep 2020 00:44:44 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b64sm3003219wmh.13.2020.09.16.00.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 00:44:43 -0700 (PDT)
Date:   Wed, 16 Sep 2020 09:44:41 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>,
        george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, syzkaller-bugs@googlegroups.com,
        b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, natechancellor@gmail.com
Subject: Re: [PATCH] fbcon: Fix user font detection test at fbcon_resize().
Message-ID: <20200916074441.GT438822@phenom.ffwll.local>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>,
        george.kennedy@oracle.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, syzkaller-bugs@googlegroups.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        natechancellor@gmail.com
References: <00000000000024be1505ad487cbb@google.com>
 <f6e3e611-8704-1263-d163-f52c906a4f06@I-love.SAKURA.ne.jp>
 <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c52e8cd-e4cb-cd0b-40d5-b9654aec09f3@I-love.SAKURA.ne.jp>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 09:01:06AM +0900, Tetsuo Handa wrote:
> Greg, will you pick up this patch?
> 
> It seems that finding the real cause of [3] and actually fixing [3] will be difficult.
> Since I can't reproduce [3] locally, I will have to try flood of "#syz test" requests
> for debug printk() patches.

Grasping for straws, but have you retested with the scrollback code
removed already? That was full of fail and we outright deleted it:

50145474f6ef ("fbcon: remove soft scrollback code")

Cheers, Daniel

> 
> On 2020/09/11 7:57, Tetsuo Handa wrote:
> > syzbot is reporting OOB read at fbcon_resize() [1], for
> > commit 39b3cffb8cf31117 ("fbcon: prevent user font height or width change
> >  from causing potential out-of-bounds access") is by error using
> > registered_fb[con2fb_map[vc->vc_num]]->fbcon_par->p->userfont (which was
> > set to non-zero) instead of fb_display[vc->vc_num].userfont (which remains
> > zero for that display).
> > 
> > We could remove tricky userfont flag [2], for we can determine it by
> > comparing address of the font data and addresses of built-in font data.
> > But since that commit is failing to fix the original OOB read [3], this
> > patch keeps the change minimal in case we decide to revert altogether.
> > 
> > [1] https://syzkaller.appspot.com/bug?id=ebcbbb6576958a496500fee9cf7aa83ea00b5920
> > [2] https://syzkaller.appspot.com/text?tag=Patch&x=14030853900000
> > [3] https://syzkaller.appspot.com/bug?id=6fba8c186d97cf1011ab17660e633b1cc4e080c9
> > 
> > Reported-by: syzbot <syzbot+b38b1ef6edf0c74a8d97@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Fixes: 39b3cffb8cf31117 ("fbcon: prevent user font height or width change from causing potential out-of-bounds access")
> > Cc: George Kennedy <george.kennedy@oracle.com>
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index 66167830fefd..dae7ae7f225a 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -2203,7 +2203,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
> >  	struct fb_var_screeninfo var = info->var;
> >  	int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
> >  
> > -	if (ops->p && ops->p->userfont && FNTSIZE(vc->vc_font.data)) {
> > +	if (p->userfont && FNTSIZE(vc->vc_font.data)) {
> >  		int size;
> >  		int pitch = PITCH(vc->vc_font.width);
> >  
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
