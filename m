Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008D91DC317
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 01:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgETXnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 19:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgETXnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:43:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA9C05BD43
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:43:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q16so2037376plr.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FzigqvCYVoWhJQjGnZdN10eq4UVPeXb2NdIvrtIBgdk=;
        b=S8TpZMqqF+vCdU5tBHdSe/IPfbqyqb2zQD2+XXASut4eAydcA2VnRgFtcX25M/0feS
         G3Eq8oEgHI5fKit7gG8wXj2RA1JJUI3tqo3ysm1Ori/jhahRsENZ2LKpLJbAtqm3rRuO
         HGmsY3G7a7tmtLva5XdGTPe8sPmoXHkmOypU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FzigqvCYVoWhJQjGnZdN10eq4UVPeXb2NdIvrtIBgdk=;
        b=MIzkm7CKC2p7IS4jN4bG0VfDFSvx6Jndvdxqjmfs35+aXiyIFoW0BubTmY52DwK+cG
         0JzPkN+kZcHnEhbYqj5z0jVhrdYjz0WyIVJv4vnifzmgTz/kGUC3U0bIqP6wGx87tx84
         5dteyt5A22gki82vvB6jRa53sAjXHs1MuPXTfGhC0tiuUpZQO3BHAkkeToVfP7hCbGBZ
         hFW+TmXSco/4CubVjkakWWARHFJeqaCfMrdkauVSthHUDU8CbdVyg57Cf0UrUHjIl3iA
         Pd4gm6xx5KOdif7ryhekRdlxG8bLvdvQGt6nriau4vDqUye+aqLMLYj6k4/uSKZFp9Qa
         gxXA==
X-Gm-Message-State: AOAM532EO+GKHYVN8WuOj8Imms4maxN/Ykg7iPPjPe//LYNGjCNevOIv
        8Q5XmheuuCgQTvyRtgdK4iT4ZA==
X-Google-Smtp-Source: ABdhPJzAmXhGgMQ9bm3JEcA9zNoKFZ1bL5DiGR8yLS6nj0HxejjmJnyhib07lt61xKLuMTlbQKDt7w==
X-Received: by 2002:a17:902:7:: with SMTP id 7mr6893114pla.157.1590018210903;
        Wed, 20 May 2020 16:43:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s123sm3007557pfs.170.2020.05.20.16.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 16:43:29 -0700 (PDT)
Date:   Wed, 20 May 2020 16:43:28 -0700
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
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 0/8] exec: Control flow simplifications
Message-ID: <202005201642.E1C6B4A457@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87d06ygssl.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d06ygssl.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:12:10PM -0500, Eric W. Biederman wrote:
> 
> I have pushed this out to:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-next
> 
> I have collected up the acks and reviewed-by's, and fixed a couple of
> typos but that is it.

Awesome!

> If we need comment fixes or additional cleanups we can apply that on top
> of this series.   This way the code can sit in linux-next until the
> merge window opens.
> 
> Before I pushed this out I also tested this with Kees new test of
> binfmt_misc and did not find any problems.

Did this mean to say binfmt_script? It'd be nice to get a binfmt_misc
test too, though.

Thanks!

-Kees

-- 
Kees Cook
