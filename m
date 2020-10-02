Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2790E281E4A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgJBW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBW1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:27:38 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DE6C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 15:27:37 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so1743929pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ieTq1qE7fV31SsmN163NlfY1jbqNTqvm2XluIpqKLDo=;
        b=HN+/Fx1GpIGhfkisl4BGaBLsx7L3XREQDIPh+WvF+DxT2SSrgnq0dFvFKyhmpGvZa1
         Sb83zHUK0DQ4vWO5uroM2opBvUcvfw8LF5IqUOqVN2SfiIECRb22EgTOovVNU17wrBJE
         C+cDOUR3ooBSxfBNmj0IqOXMKZXwksH9wap0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieTq1qE7fV31SsmN163NlfY1jbqNTqvm2XluIpqKLDo=;
        b=E96rPDr0PYTBlwEAEPeA8lpnaxiGpCG+n3dO42KhLyz/pGG2CyG3CJ12pxCNOLLw/N
         dmqREu4EHGo5IDYfLX55XG4BC4HFLzEgwmmZ+IgOleIcL9xXzDtj34OEycxTqY1pWHUu
         mYTrjQrzQefPZ0go5af1SbKe4bgTJgTjEr2AMfQg/pgKrIAI7VwGCDC5/Pz25jJW2BDk
         rZ4ga/3RGZD/EAvkZPcIkcgoJm2qtWNLIjjoRw2DfoYl32jyQigcpQZ8hOQL9BGFT2Pk
         E03qGs7x3am6phkmWUrTkz5n9zwhqFXIQ3nrvuvDTExkEwHD3Lo/2Qgiw0d+dDdxCVSR
         IYow==
X-Gm-Message-State: AOAM533q2toIn9llePU+lnLfJNmxjdRlhuXNbZ56XMPa5DAEnDoMth2g
        3rC0emnrd/28nGWY7IQQkSfdBw==
X-Google-Smtp-Source: ABdhPJw6FQQhAFtb0/j4BJLwnb5NAb6/whRSQcmF96SZ4mtSzKLEb/Kqn6qu+Ke3rn9OoRd+jcZtzQ==
X-Received: by 2002:a62:84c7:0:b029:152:2f5b:aa8 with SMTP id k190-20020a6284c70000b02901522f5b0aa8mr4365404pfd.3.1601677657354;
        Fri, 02 Oct 2020 15:27:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x13sm3087599pfj.199.2020.10.02.15.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 15:27:36 -0700 (PDT)
Date:   Fri, 2 Oct 2020 15:27:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 1/8] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
Message-ID: <202010021526.84B4D81268@keescook>
References: <cover.1600285923.git.joe@perches.com>
 <884235202216d464d61ee975f7465332c86f76b2.1600285923.git.joe@perches.com>
 <20200930115740.GA1611809@kroah.com>
 <202009302108.18B05CA38@keescook>
 <20201001205029.GC915579@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001205029.GC915579@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 10:50:29PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Sep 30, 2020 at 09:17:03PM -0700, Kees Cook wrote:
> > On Wed, Sep 30, 2020 at 01:57:40PM +0200, Greg Kroah-Hartman wrote:
> > > Kees, and Rafael, I don't know if you saw this proposal from Joe for
> > > sysfs files, questions below:
> > 
> > I'm a fan. I think the use of sprintf() in sysfs might have been one of
> > my earliest complaints about unsafe code patterns in the kernel. ;)
> 
> Ok, great.
> 
> > > > +/**
> > > > + *	sysfs_emit - scnprintf equivalent, aware of PAGE_SIZE buffer.
> > > > + *	@buf:	start of PAGE_SIZE buffer.
> > > > + *	@fmt:	format
> > > > + *	@...:	optional arguments to @format
> > > > + *
> > > > + *
> > > > + * Returns number of characters written to @buf.
> > > > + */
> > > > +int sysfs_emit(char *buf, const char *fmt, ...)
> > > > +{
> > > > +	va_list args;
> > > > +	int len;
> > > > +
> > > > +	if (WARN(!buf || offset_in_page(buf),
> > > > +		 "invalid sysfs_emit: buf:%p\n", buf))
> > 
> > I don't want the %p here, but otherwise, sure. I'd also make it a _ONCE
> > variant:
> > 
> > 	if (WARN_ONCE(!buf || offset_in_page(buf),
> > 		 "invalid sysfs_emit: offset_in_page(buf):%zd\n",
> > 		  buf ? offset_in_page(buf) : 0))
> 
> As Joe points out, _ONCE doesn't work because this happens from all
> sysfs files, not just one.

Sure, it's just a question if you want log spamming vs how reachable you
think something might be. I would expect this to be uncommon to
encounter, but very repeatable for whatever system DOES hit it, so doing
_ONCE means they see the report and don't get completely flooded with
it.

I'm fine either way.

-- 
Kees Cook
