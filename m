Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816CE2E0E84
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLVTAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 14:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgLVTAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 14:00:10 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F473C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:59:30 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b5so1849692pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GIU1lxgdheNY3YZkLwNG9YluqFCxKTH5t+4e0p31AF8=;
        b=aSA3Ey2pPtevrJzSOukq1685OXL7ChsLhGyjmCnNZHhtnsejwgh5ebDAd8SRLEyI6F
         SMe3HgJJEPeOdTS+fNlJsv1STrMzPJxuImcNjr4kYkiNYWzj7tRSbGOcPYelcOzCb4oM
         I0GUj0ovapKEzdkMv50BfmOPS6dsQ9MB+hazPEWxa5nDhWvqr6uNtzZBU1BWKKTEPkrc
         HUMPO4Qcv7JoPfMCoUiSdvvFrQtTa/5SV3FEyhL5eyzXnK4UEA9W+US0Pi+mALyzj98C
         LbCJb1o6p85kSupFELJDNtZddrd1SuoxjTqjLu5+uOUGK6ztY0HPk/bipNDkNcAR0ADj
         hQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GIU1lxgdheNY3YZkLwNG9YluqFCxKTH5t+4e0p31AF8=;
        b=tmGfqNWE/CE511JRgmiwmm7jp/J31N03DI0Zya/76bDWtwVIjqSKOvhIm5ZjSdyZiC
         K21gPed2uhSiMkkjTgIVbyZNS2Fn1mtOgq9Vctzb1oaWozWYbznRg6lPh5ITvyubznG7
         D7rRoklkW2WImDMAOrnnJ9SKSSvOX2g7fYgTWXROnt2+9c9GgoKDllif8yvr1XUVLOIL
         /sssscpO8L1oJxVIVmUjartJfBO0cszC1FdXAAUlmjjZ6cvuVmDKpo/GbuiNzhcazW9k
         jp9NgcA5Owl+jbzWtblsKjUqibS1isHmUejb7MVw1LptQPNIxJoY9Mn9+yJEIhjyDzF6
         q/cw==
X-Gm-Message-State: AOAM533AzqvgvqJoSvE8uzeQ7xqY7yDUy4GZViXj+VMp3Vmt5wnZie1E
        SUacqizCc3Wg4atcozFs6JHXpbxHZybfpA==
X-Google-Smtp-Source: ABdhPJygcnuVxuB0y1aVK/tNs3GusjHqrXTH02tAg9N8WkfxKnqVrNqfORDzZVrg4FH/qP8Nbe4Krg==
X-Received: by 2002:a17:902:9f89:b029:dc:3032:e439 with SMTP id g9-20020a1709029f89b02900dc3032e439mr20005581plq.35.1608663569605;
        Tue, 22 Dec 2020 10:59:29 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id n128sm21618232pga.55.2020.12.22.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:59:28 -0800 (PST)
Date:   Tue, 22 Dec 2020 10:59:22 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jonathan Corbet <corbet@lwn.net>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
Message-ID: <X+JCCqTJkgZASj7T@google.com>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net>
 <20201222130555.GA13463@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222130555.GA13463@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020, Borislav Petkov wrote:
> Ok, here's the next one which I think, is also, not really controversial.

Heh, are you trying to jinx yourself?

> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 5ba54120bef7..0ffb21366381 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -679,6 +679,26 @@ generates appropriate diffstats by default.)
>  See more details on the proper patch format in the following
>  references.
>  
> +Backtraces in commit mesages
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Backtraces help document the call chain leading to a problem. However,
> +not all backtraces are helpful. For example, early boot call chains are
> +unique and obvious.

I'd argue that there is still value in the backtrace though, e.g. I find them
very helpful when doing git archaeology.  A backtrace is an easily recognizable
signature (don't have to read a bunch of text to understand there was a splat of
some kind), and the call stack is often helpful even if it is unique, e.g. for
unfamiliar code (including early boot chains) and/or code that is substantially
different from the current upstream.

> Copying the full dmesg output verbatim, however,
> +adds distracting information like timestamps, module lists, register and
> +stack dumps.
> +
> +Therefore, the most useful backtraces should distill the relevant
> +information from the dump, which makes it easier to focus on the real
> +issue. Here is an example of a well-trimmed backtrace::
> +
> +  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000000000000064)
> +  at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
> +  Call Trace:
> +  mba_wrmsr
> +  update_domains
> +  rdtgroup_mkdir
> +
>  .. _explicit_in_reply_to:

I'd prefer not to encourage people to strip the info after the function name,
though I do agree it's somewhat distracting (especially the offset/size).  The
module, call site in the function, exact file/line if available, etc... provides
context that I find helpful for building a mental model of what went wrong.
E.g. which modules are in play, which short wrapper functions can likely be
glossed over, etc...
