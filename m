Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA30D1CBDC5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 07:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgEIFbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 01:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:31:09 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A178C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:31:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k7so261529pjs.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=McjHFsfMyglxdFz38lGhUm1tNt0prdaFRILR+RgnQNE=;
        b=gjJvzG+5BYX9WeWWRGhrmrGe89rZBPW9DhLd6QVhxuIhYoIUNeXOzRw1XzMcEOGXGQ
         UJORe9/LSMYQq78oP5uRH6NoLZ0BgkAjfWbDL1D8tTvS9KPAmk5G2GBNIaAv4CgnEWBz
         TGDxJ6/0VTxGUPrAP7iCKLKp10wQHjOnivZxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=McjHFsfMyglxdFz38lGhUm1tNt0prdaFRILR+RgnQNE=;
        b=iz6fUS5UYhvIWaQfGUrzIn//rDayqvITdM/PxSJ6MHOIwFqgX+mE6TdvLNF35xGB6Y
         /O15r1ewwo00QeLeaAJuABvrykWBnkv+tD+gc7BmWjKY3L5kxIISHMkvDstMs0TRmuUj
         uZiHnF9jZ7HqUrSWSc+PEzbJHj6tlD8hR3ntEdjddeF5VcQxrilyHCxDAJpTBaFBvIja
         /uaVqYXaHYHbwxaIgMj5TXaqOhqhd+/+9+4AR2uWv9s6OLVjrxPoFacWlgeI4LVW06vS
         9TZKUT8EhwbKtI7b49w0fAP6fCwFsAxrJCX11LyH5sGC6YNtA9/tsjDMTQ7gT6lb2Xhc
         3Rtw==
X-Gm-Message-State: AGi0PuYqb2eI/1ZPnMs7XIu9YKtNsvkptXBWvMXEXN7NDVaNTL5qXhbP
        zewcrSDup+hX3lqFhcg3WGf5jw==
X-Google-Smtp-Source: APiQypIIxLMFxwPXcizPIo8Mvfojps1POA1H/qHc1k5tXu33u0U5ECVx88mpdV6N2EHhKoLm3p7sLg==
X-Received: by 2002:a17:902:9044:: with SMTP id w4mr5830489plz.83.1589002268808;
        Fri, 08 May 2020 22:31:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i185sm3487660pfg.14.2020.05.08.22.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:31:08 -0700 (PDT)
Date:   Fri, 8 May 2020 22:31:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/6] exec: Move handling of the point of no return to the
 top level
Message-ID: <202005082228.5C0E44CC6@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87y2q25knl.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2q25knl.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:47:10PM -0500, Eric W. Biederman wrote:
> 
> Move the handing of the point of no return from search_binary_handler
> into __do_execve_file so that it is easier to find, and to keep
> things robust in the face of change.
> 
> Make it clear that an existing fatal signal will take precedence over
> a forced SIGSEGV by not forcing SIGSEGV if a fatal signal is already
> pending.  This does not change the behavior but it saves a reader
> of the code the tedium of reading and understanding force_sig
> and the signal delivery code.
> 
> Update the comment in begin_new_exec about where SIGSEGV is forced.
> 
> Keep point_of_no_return from being a mystery by documenting
> what the code is doing where it forces SIGSEGV if the
> code is past the point of no return.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

I had to read the code around these changes a bit carefully, but yeah,
this looks like a safe cleanup. It is a behavioral change, though (in
that in unmasks non-SEGV fatal signals), so I do wonder if something
somewhere might notice this, but I'd agree that it's the more robust
behavior.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
