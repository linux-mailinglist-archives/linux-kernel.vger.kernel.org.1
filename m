Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB07427E90F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgI3M7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3M7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:59:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE7FC061755;
        Wed, 30 Sep 2020 05:59:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d19so984245pld.0;
        Wed, 30 Sep 2020 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGONJfBGfiZJ8B5gVDKbSF1BVGKwQjHdLl3ddJo9tVY=;
        b=eJKbz8Q0kBy+c9iBIWhnx+5lDxtWn3fntLUDzpGUW709Er3KPWJPiwrRw6GnRMJeGn
         xodi9WCSndpOjnrfs4XfsryyUrXfJmelVfDFngugKTT/TIFNXxrsEiPfUMqP1E3vrCD3
         Ujq0ESsfFS5bbg1mDhmeYuLR1dazAfdE7Uq5/bVNFR4L68c6+6C+ex5KCWxd9DrWxrL8
         l9Xg8oS6UFCyOsOj81oskbHKdF5QskffRIDpTO3vpxBIuOadWbgZ13hoHaeNF+VI1jCG
         Vaato+9lnzp0K1IkdzExljN8tXbUqiyHcLJodvjhypXRNCpVPsE8Zc3bZbit2DkzcNcL
         wkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGONJfBGfiZJ8B5gVDKbSF1BVGKwQjHdLl3ddJo9tVY=;
        b=XcDpRX9WBby5LwdzMylUwuFWKrA/Ght8FeTOa7z5YWM8OxNOPMW71tgjPmzpoAqZg0
         xvG1a1+3xjHMIQtgV50sfFUhYsCCZuXOIF7MCaW/ztZbKdrxFVyvCfeRmt7jg+FfJdpm
         qhtaDNIEn+0h/szy4hLtwyOOzBsQgbr+gZ9KQwd7UP1lztpcCRcGJDK2Tf5gpMY2+nQi
         pSmAk5i8hl0iZlKeZiD9YnvlF23i4Rq0zYGEq/szJzquvvmUVQ3bMqeulRItagWOnmcS
         Tc3F/mqu6Dyjf+SJ/4WWWwEw7ldCF3E0qx8R8HeyE/u8/zajG/wUVfyfPu7Zlq5aHFOB
         /2gw==
X-Gm-Message-State: AOAM530iv9Ek+lHdQFVZsq1odtSVwKNpbAmr029sXQJyEw0nOJrqw3e8
        h+5Xy2miB5QItI1iRwp1eQ==
X-Google-Smtp-Source: ABdhPJwbSPtClFFI3ea1mNKe4eO1VEd6GSD/SvuAQtvcm7zxPoV0QkXo2AazrpiYHQjW/KT/XysBXQ==
X-Received: by 2002:a17:90b:30c2:: with SMTP id hi2mr921373pjb.89.1601470745283;
        Wed, 30 Sep 2020 05:59:05 -0700 (PDT)
Received: from PWN ([161.117.80.159])
        by smtp.gmail.com with ESMTPSA id u15sm2536438pjx.50.2020.09.30.05.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:59:04 -0700 (PDT)
Date:   Wed, 30 Sep 2020 08:58:55 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Prevent out-of-bounds access for built-in font data
 buffers
Message-ID: <20200930125855.GA1155358@PWN>
References: <3f754d60-1d35-899c-4418-147d922e29af@kernel.org>
 <20200925101300.GA890211@PWN>
 <20200925132551.GF438822@phenom.ffwll.local>
 <20200929123420.GA1143575@PWN>
 <CAKMK7uFY2zv0adjKJ_ORVFT7Zzwn075MaU0rEU7_FuqENLR=UA@mail.gmail.com>
 <20200930071151.GA1152145@PWN>
 <20200930095317.GX438822@phenom.ffwll.local>
 <20200930105553.GA1154238@PWN>
 <CAKMK7uFzWZgs4rvqSXqn_ifr8utG_rNw54+y6CWjdV=Epak-iQ@mail.gmail.com>
 <20200930115211.GC1603625@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930115211.GC1603625@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:52:11PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 30, 2020 at 01:25:14PM +0200, Daniel Vetter wrote:
> > On Wed, Sep 30, 2020 at 12:56 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > > Yes, and built-in fonts don't use refcount. Or maybe we can let
> > > find_font() and get_default_font() kmalloc() a copy of built-in font
> > > data, then keep track of refcount for both user and built-in fonts, but
> > > that will waste a few K of memory for each built-in font we use...
> > 
> > A possible trick for this would be to make sure built-in fonts start
> > out with a refcount of 1. So never get freed. Plus maybe a check that
> > if the name is set, then it's a built-in font and if we ever underflow
> > the refcount we just WARN, but don't free anything.
> > 
> > Another trick would be kern_font_get/put wrappers (we'd want those
> > anyway if the userspace fonts are refcounted) and if kern_font->name
> > != NULL (i.e. built-in font with name) then we simply don't call
> > kref_get/put.
> 
> Ick, don't do that, the first trick of having them start out with an
> increased reference count is the best way here.  Makes the code simpler
> and no special cases for the tear-down path.

I see, I'll just let them start out with 1, and only check `->name !=
NULL` in kern_font_put(). Thank you!

Peilin Ye

