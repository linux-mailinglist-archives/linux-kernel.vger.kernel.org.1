Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6129D8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbgJ1Wk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388996AbgJ1WkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:40:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB7DC0613CF;
        Wed, 28 Oct 2020 15:40:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k1so1115090ilc.10;
        Wed, 28 Oct 2020 15:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oVUnL5kaK/5rf5G4sA+8aqXRjWDzkxcWebk6ujgD/a4=;
        b=lVdjvlJU8QJiTeX+orF6aiSQkRhcTKXek6pC70EbrVTGQRVobxa66NKgA+x8PuyWhl
         7i51fj9jrqvaY/A+Nq0rUmnagneca6PbrtahlzFwb1oX10Zz7IjDcEYKtKToagfhiKk9
         nZYsz2oDRR8+cBnaHrBk995yn3o0KthFHODqWTmVZ6oWZhh+SQZ4CT3/Y1NgEd4eXJXB
         gY3c+gl2Vp7G1ttS7UXUC9LZiUcWKZ1DBUNf101rzl3vzIm+8SqZwU7esW5mvCcpLYqt
         dlT8aMX4y+r5CvAXeK8QUrg+XWtPiCnylPhhDe6fWShg+SNW0py2hw4zCtU6xpbDOxIC
         3g2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oVUnL5kaK/5rf5G4sA+8aqXRjWDzkxcWebk6ujgD/a4=;
        b=mtaiSImGLciSd83KvlcutPj+voqrFnYh+zrjWKkRdMNNCZLc1mNu7JEYDNzPw4Bq70
         PRwEq69bpqqgRCwgjWPau2fEn6zs9/WdbAUPa1s0N+Po8dQTFyKJkg1ugWDo+CQzYULO
         TopjwXhxd89dkHFiuIlsaYv7Pl9xx1AMcZZG1Oh7quJ58RyJkLeBQj/9f2Dqtq4tjLUp
         B67EqrJmpjdW7/MXJZX2KzTjEc96Z95ID/spMyo7xVfxZ3vv2ML6PVaW5bMXyC/3i1l1
         wxioueo6Gn8izIuGUgo8eoVxQoXFpNXrS9+MWEz1RO5mndBkQ10/1+q342uSTIHfqYV5
         /yng==
X-Gm-Message-State: AOAM530AX6aiKK870p1kanAxwAOvEqccANLP4B5AzaGq58uIxglDK4jp
        nEsdu657w4UnRXZIya+lG/5Je9ow8nFy
X-Google-Smtp-Source: ABdhPJwEfZ3S8cf5PNLPqQJlTMzx7UgTYspNtvNwe66BtBr0YbnEEqapRdlrd4oUtTF14CnlZ5pGnw==
X-Received: by 2002:a63:9d4d:: with SMTP id i74mr4838250pgd.182.1603863047104;
        Tue, 27 Oct 2020 22:30:47 -0700 (PDT)
Received: from PWN (n11212042025.netvigator.com. [112.120.42.25])
        by smtp.gmail.com with ESMTPSA id q8sm4300935pfg.118.2020.10.27.22.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 22:30:46 -0700 (PDT)
Date:   Wed, 28 Oct 2020 01:30:34 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] fbcon: Avoid hard-coding built-in font charcount
Message-ID: <20201028053034.GA1205431@PWN>
References: <cover.1603788511.git.yepeilin.cs@gmail.com>
 <cb5bb49a33ff54fef41e719ee9d301a6a73c5f9c.1603788512.git.yepeilin.cs@gmail.com>
 <54f7d42e07eca2a2f13669575a9de88023ebc1ac.1603788512.git.yepeilin.cs@gmail.com>
 <6c28279a10dbe7a7e5ac3e3a8dd7c67f8d63a9f2.1603788512.git.yepeilin.cs@gmail.com>
 <a3b1b3cdc160fb9aef389c366f387fb27f0aef38.1603788512.git.yepeilin.cs@gmail.com>
 <20201027191353.GO401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027191353.GO401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:13:53PM +0100, Daniel Vetter wrote:
> On Tue, Oct 27, 2020 at 12:37:29PM -0400, Peilin Ye wrote:
> > fbcon_startup() and fbcon_init() are hard-coding the number of characters
> > of our built-in fonts as 256. Recently, we included that information in
> > our kernel font descriptor `struct font_desc`, so use `font->charcount`
> > instead of a hard-coded value.
> > 
> > This patch depends on patch "Fonts: Add charcount field to font_desc".
> > 
> > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> 
> So I think this is correct, but it also doesn't do a hole lot yet. fbcon.c
> still has tons of hard-coded 256 all over, and if (p->userfont).
> 
> I think if we instead set vc->vc_font.charcount both in fbcon_init and in
> fbcon_do_set_font (probably just replace the userfont parameter with
> font_charcount for now), then we could replace these all with
> vc->vc_font.charcount. And the code would already improve quite a bit I
> think.
> 
> With just this change here I think we have even more inconsistency, since
> for built-in fonts vc->vc_font.charcount is now set correctly, but for
> userfonts we need to instead look at FNTCHARCNT(vc->vc_font.data).

You are right, let's remove FNTCHARCNT() altogether. fbcon_do_set_font()
still needs a userfont parameter for refcount handling, I'll just add a
charcount parameter to it.

Peilin

