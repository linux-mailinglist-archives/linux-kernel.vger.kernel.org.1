Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92F12EE789
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbhAGVRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbhAGVRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:17:08 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6532DC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:16:28 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b5so4712915pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5fzui2ssAAjv83Q95dR6yA7Ay+ceGXA4laR9uMk3EkM=;
        b=bufj13b1pA5CWLI2Pq822s7h/8DoilsrlNu+qzeY8SID580HNOAAfi1Qmh+Hb7COCv
         E+H3U7qyZ5LHSBh4/SpGg4SUnTyk/CrWGS2+5mvmFMpg2DKqUzDI/DJy0BRJg85FEUK4
         O9sJ+u6wIL66sK2CC5RNwpWxC612Esbrx4Pe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5fzui2ssAAjv83Q95dR6yA7Ay+ceGXA4laR9uMk3EkM=;
        b=kqYIbzOaZhAdjHpGLLrnaxolA/Pqo+ief+bEGuCBE60Vrn98W1a51Gpg3o6cXwBvPh
         c+bc2LkDzJLSAjYwY0N62c2g+SJUyWozGHV6GQNF/s1uV4WFaUcUZCKyb1pxzEvBzUPP
         RnCqz7Mb/MT2AA9l9gKaafVH/68czI+NrlkmVuBjiUgJCe3HyY4zfhFDZg2A+DL/j6ON
         V0dG7nTrFPKrj1MQygRtso6bjHrMrZ4pj9wFEG2TYEsjm7hbGLj4LurRI1hfFuQvbsJd
         OkDRBQBuDDZu9JkbuUNHeIYEhtwCgMeGbGW4md6W0awtmXiLKjnIjkaHKcgV9Ug+ONwA
         6ffw==
X-Gm-Message-State: AOAM531eQtombveGeIbO9I2V9Svtpt/qC0hbz0Nhpxw04dvuQporIf8t
        6hXqMhh0CyBIeyixH6sAg5B7HA==
X-Google-Smtp-Source: ABdhPJwRqig6SLkglfxKbRByV3jzPWHK3fgtkRRkHE9Tz+rnFZX3ekd8S09rx+presosDommRKJtrw==
X-Received: by 2002:a17:90a:730b:: with SMTP id m11mr394327pjk.76.1610054188001;
        Thu, 07 Jan 2021 13:16:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v3sm6349833pjn.7.2021.01.07.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:16:27 -0800 (PST)
Date:   Thu, 7 Jan 2021 13:16:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: deprecated.rst: deprecated strcpy ? (was: [PATCH] checkpatch:
 add a new check for strcpy/strlcpy uses)
Message-ID: <202101071310.3AC5F0C4@keescook>
References: <20210105082303.15310-1-dwaipayanray1@gmail.com>
 <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
 <CABJPP5DQ0Y42z9ej_j06+KaQevT3ztWcwGMkismj4qv5EHvnxA@mail.gmail.com>
 <3ffe616d8c3fb54833bfc4d86cb73427cf6c7add.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ffe616d8c3fb54833bfc4d86cb73427cf6c7add.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 01:28:18AM -0800, Joe Perches wrote:
> On Tue, 2021-01-05 at 14:29 +0530, Dwaipayan Ray wrote:
> > On Tue, Jan 5, 2021 at 2:14 PM Joe Perches <joe@perches.com> wrote:
> > > 
> > > On Tue, 2021-01-05 at 13:53 +0530, Dwaipayan Ray wrote:
> > > > strcpy() performs no bounds checking on the destination buffer.
> > > > This could result in linear overflows beyond the end of the buffer.
> > > > 
> > > > strlcpy() reads the entire source buffer first. This read
> > > > may exceed the destination size limit. This can be both inefficient
> > > > and lead to linear read overflows.
> > > > 
> > > > The safe replacement to both of these is to use strscpy() instead.
> > > > Add a new checkpatch warning which alerts the user on finding usage of
> > > > strcpy() or strlcpy().
> > > 
> > > I do not believe that strscpy is preferred over strcpy.
> > > 
> > > When the size of the output buffer is known to be larger
> > > than the input, strcpy is faster.
> > > 
> > > There are about 2k uses of strcpy.
> > > Is there a use where strcpy use actually matters?
> > > I don't know offhand...
> > > 
> > > But I believe compilers do not optimize away the uses of strscpy
> > > to a simple memcpy like they do for strcpy with a const from
> > > 
> > >         strcpy(foo, "bar");
> > > 
> > 
> > Yes the optimization here definitely helps. So in case the programmer
> > knows that the destination buffer is always larger, then strcpy() should be
> > preferred? I think the documentation might have been too strict about
> > strcpy() uses here:
> > 
> > Documentation/process/deprecated.rst:
> > "strcpy() performs no bounds checking on the destination buffer. This
> > could result in linear overflows beyond the end of the buffer, leading to
> > all kinds of misbehaviors. While `CONFIG_FORTIFY_SOURCE=y` and various
> > compiler flags help reduce the risk of using this function, there is
> > no good reason to add new uses of this function. The safe replacement
> > is strscpy(),..."
> 
> Kees/Jonathan:
> 
> Perhaps this text is overly restrictive.
> 
> There are ~2k uses of strcpy in the kernel.
> 
> About half of these are where the buffer length of foo is known and the
> use is 'strcpy(foo, "bar")' so the compiler converts/optimizes away the
> strcpy to memcpy and may not even put "bar" into the string table.
> 
> I believe strscpy uses do not have this optimization.
> 
> Is there a case where the runtime costs actually matters?
> I expect so.

The original goal was to use another helper that worked on static
strings like this. Linus rejected that idea, so we're in a weird place.
I think we could perhaps build a strcpy() replacement that requires
compile-time validated arguments, and to break the build if not.

i.e.

given:
	char array[8];
	char *ptr;

allow:


	strcpy(array, "1234567");

disallow:

	strcpy(array, "12345678");	/* too long */
	strcpy(array, src);		/* not optimized, so use strscpy? */
	strcpy(ptr, "1234567");		/* unknown destination size */
	strcpy(ptr, src);		/* unknown destination size */

What do you think?

-- 
Kees Cook
