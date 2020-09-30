Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA7F27E744
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgI3K4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgI3K4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:56:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACD5C061755;
        Wed, 30 Sep 2020 03:56:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 34so866140pgo.13;
        Wed, 30 Sep 2020 03:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oHjy/cJNfXXtogE/EOScxb15VZyxV8RmFzlm1RVW7+4=;
        b=ST3Kd8NsgI00gcwe++TnkB9yoG7CcnwaH1PhFE7KHu2q8pACXvMlCKfgfMR4yCUOJu
         ADghrfvzWjSlgIUCxoJM7ZQjtPtxlo33UaHnhi+3+Y8DpDYs9PHoW5N3sZrZ4AtsxomX
         mFlkpo3duTlRy6LZnvVCEyrnEIoRNBO7X87egzV14m7epsPyc/6Jab9yI502MgaWlQae
         2rIIV140OVnyhadXYHdTmEAXDspwTby8A0pU8fE3wJMaoN+2rkgMMdLhX1vm6wpplv37
         0K806v7DDEPK3d+/Gj2NiaXqsYvDUrExl7lmpaOGK+r0m4Qo9ruZgkAAOfZldREf7KOn
         Bihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHjy/cJNfXXtogE/EOScxb15VZyxV8RmFzlm1RVW7+4=;
        b=gt10II51fM9K8psn3wyjUzwPXQYN6rTPVfodAmlNks6pufJNbdquKfvPaAJRZCZRZ5
         wxZNKbunYp/50yHF68n/fBpZJAUQxXVyrEUNFKNx0yYLgd4Lofs4iDvz5micGjFmVRA+
         Z8gnpjZfPQg/ytl56prZlJyZz7k0t+ZOG0AgWteVygnTiOt2StQRHLLLgNj6sddrpzx5
         6BoNKV7TsNFwX79wNmCgU3NCTjhnZYPfwBY+OvnfTImcA27CNeBHJno3muTcwx9AXLe+
         RNCXO2HM48Q0a5HIU39eDzfcnLMUDgFQlVThJKO7NzxyPmI9vHCiunwEhC+3FubyUTxE
         KZfA==
X-Gm-Message-State: AOAM53295aMGEtRORTNWI0SQCZyXPqzF6Q939QTjl9lhDbTRT2YpT1O+
        nl/0fjvaL0ohi7R3eTZ9sA==
X-Google-Smtp-Source: ABdhPJxwDjg9fu9SIBa0weczPWatPsktZqfGJP54jLXM6mwLCAozwhwqJF1pVlQk2zADetgfH2HP7w==
X-Received: by 2002:a63:4e0a:: with SMTP id c10mr1671562pgb.369.1601463362849;
        Wed, 30 Sep 2020 03:56:02 -0700 (PDT)
Received: from PWN ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id l14sm1837033pfc.170.2020.09.30.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 03:56:02 -0700 (PDT)
Date:   Wed, 30 Sep 2020 06:55:53 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200930105553.GA1154238@PWN>
References: <0000000000006b9e8d059952095e@google.com>
 <cover.1600953813.git.yepeilin.cs@gmail.com>
 <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200929123420.GA1143575@PWN>
 <CAKMK7uFY2zv0adjKJ_ORVFT7Zzwn075MaU0rEU7_FuqENLR=UA@mail.gmail.com>
 <20200930071151.GA1152145@PWN>
 <20200930095317.GX438822@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930095317.GX438822@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:53:17AM +0200, Daniel Vetter wrote:
> On Wed, Sep 30, 2020 at 03:11:51AM -0400, Peilin Ye wrote:
> > On Tue, Sep 29, 2020 at 04:38:49PM +0200, Daniel Vetter wrote:
> > > On Tue, Sep 29, 2020 at 2:34 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > > > Ah, and speaking of built-in fonts, see fbcon_startup():
> > > >
> > > >         /* Setup default font */
> > > >                 [...]
> > > >                 vc->vc_font.charcount = 256; /* FIXME  Need to support more fonts */
> > > >                             ^^^^^^^^^^^^^^^
> > > >
> > > > This is because find_font() and get_default_font() return a `struct
> > > > font_desc *`, but `struct font_desc` doesn't contain `charcount`. I
> > > > think we also need to add a `charcount` field to `struct font_desc`.
> > > 
> > > Hm yeah ... I guess maybe struct font_desc should be the starting
> > > point for the kernel internal font structure. It's at least there
> > > already ...
> > 
> > I see, that will also make handling built-in fonts much easier!
> 
> I think the only downside with starting with font_desc as the internal
> font represenation is that there's a few fields we don't need/have for
> userspace fonts (like the id/name stuff). So any helpers to e.g. print out
> font information need to make sure they don't trip over that
> 
> But otherwise I don't see a problem with this, I think.

Yes, and built-in fonts don't use refcount. Or maybe we can let
find_font() and get_default_font() kmalloc() a copy of built-in font
data, then keep track of refcount for both user and built-in fonts, but
that will waste a few K of memory for each built-in font we use...

> > > I think for vc_date->vc_font we might need a multi-step approach:
> > > - first add a new helper function which sets the font for a vc using
> > > an uapi console_font struct (and probably hard-coded assumes cnt ==
> > > 256.
> > 
> > But user fonts may have a charcount different to 256... But yes I'll try
> > to figure out how.
> 
> Hm yeah, maybe we need a helper to give us the charcount then, which by
> default is using the magic negative offset.

Ah, I see! :)

> Then once we've converted everything over to explicitly passing charcount
> around, we can switch that helper. So something like
> 
> int kern_font_charcount(struct kern_font *font);
> 
> Feel free to bikeshed the struct name however you see fit :-)

I think both `kern_font` and `font_desc` makes sense, naming is so
hard...

> > > For first steps I'd start with demidlayering some of the internal
> > > users of uapi structs, like the console_font_op really shouldn't be
> > > used anywhere in any function, except in the ioctl handler that
> > > converts it into the right function call. You'll probably discover a
> > > few other places like this on the go.
> > 
> > Sure, I'll start from this, then cleaning up these dummy functions, then
> > `vc_data`. Thank you for the insights!
> 
> Please don't take this rough plan as fixed, it's just where I'd start from
> browsing the code and your analysis a bit. We'll probably have to adapt as
> we go and more nasty things turn up ...

Sure, I'll first give it a try and see. Thank you!

Peilin Ye

