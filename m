Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7965272C13
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgIUQ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgIUQ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:27:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB848C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:27:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id r7so18561639ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8LK5dloOXhiAuv1jzPTpg6aj5g8mwVrNmUPAV9ogWY=;
        b=RFMB/gNwPwfIqudW3R4jXCFsXqrNlGTxVuJ7YvVxCKzq5Y/YUC/Ma6uY7s95wRftZ1
         7s8sQIj4iiCqfqYdGopoS/gZplkdWgCmkY2aCa/c5cevLuamU4HpSU0quOZvV2Xv5EaL
         vunDI/0xHWZgKhUbEF4U4wC7LUJxngCiHSvxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8LK5dloOXhiAuv1jzPTpg6aj5g8mwVrNmUPAV9ogWY=;
        b=RT9m4YH9saq593NhKLf4dxW7V3HvVa/qtwsixaQGk41TEuJkjCyYNierakKQATJZ/2
         cAN8zEMGMZJBcd5MWANK0vDEymlJLqXUY7bM2UqxSv7ijiMzgYJKWXugaVtw5D1oP0g4
         SWZnZZPBLipAbzw7rcQgOrqR3zWVt5TSuyp89GWVH4vgXxZKmWYEXIL/yoOSqEbEbPRG
         SPVHm0zNAm8RJJN9lMr2a6Gy05gnY7z3JsU5KLykmyiZVjIfwffpwpvLSM+XeewPo140
         zVX5BAIpwd0PuaQob8HXuee5nzOKsmjdd30anX++t8oQK2tJ9kaj7ZnVf1i9H9hc0+WS
         HVIQ==
X-Gm-Message-State: AOAM5325LFpYyobzOc9zvxgkSFih3SIOrCoBGC+C82B9Y/TLgl6expOW
        EQfC4s9Sg4KsAXp2PBC8ZatQf+OGNWH2dw==
X-Google-Smtp-Source: ABdhPJzRLOB2BpJb++cxQ0gBdq4sYGsOBtKoLDsYHytalKJmfAEmGZIpEp75o34UXqtrnpACFTm/tQ==
X-Received: by 2002:a17:906:1157:: with SMTP id i23mr267876eja.440.1600705621162;
        Mon, 21 Sep 2020 09:27:01 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id s7sm9274576ejd.103.2020.09.21.09.27.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 09:27:00 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id n13so13370243edo.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:27:00 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr149175ljh.70.1600705241845;
 Mon, 21 Sep 2020 09:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200623052059.1893966-1-david@fromorbit.com> <CAOQ4uxh0dnVXJ9g+5jb3q72RQYYqTLPW_uBqHPKn6AJZ2DNPOQ@mail.gmail.com>
 <20200916155851.GA1572@quack2.suse.cz> <20200917014454.GZ12131@dread.disaster.area>
 <alpine.LSU.2.11.2009161853220.2087@eggly.anvils> <20200917064532.GI12131@dread.disaster.area>
 <alpine.LSU.2.11.2009170017590.8077@eggly.anvils> <20200921082600.GO12131@dread.disaster.area>
 <20200921091143.GB5862@quack2.suse.cz>
In-Reply-To: <20200921091143.GB5862@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Sep 2020 09:20:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir89LPH6A4H2hkxVXT20+dpcw2qQq0GtQJvy87ARga-g@mail.gmail.com>
Message-ID: <CAHk-=wir89LPH6A4H2hkxVXT20+dpcw2qQq0GtQJvy87ARga-g@mail.gmail.com>
Subject: Re: More filesystem need this fix (xfs: use MMAPLOCK around filemap_map_pages())
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Hugh Dickins <hughd@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Theodore Tso <tytso@mit.edu>,
        Martin Brandenburg <martin@omnibond.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Qiuyang Sun <sunqiuyang@huawei.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, nborisov@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 2:11 AM Jan Kara <jack@suse.cz> wrote:
>
> Except that on truncate, we have to unmap these
> anonymous pages in private file mappings as well...

I'm actually not 100% sure we strictly would need to care.

Once we've faulted in a private file mapping page, that page is
"ours". That's kind of what MAP_PRIVATE means.

If we haven't written to it, we do keep things coherent with the file,
but that's actually not required by POSIX afaik - it's a QoI issue,
and a lot of (bad) Unixes didn't do it at all.

So as long as truncate _clears_ the pages it truncates, I think we'd
actually be ok.

The SIGBUS is supposed to happen, but that's really only relevant for
the _first_ access. Once we've accessed the page, and have it mapped,
the private part really means that there are no guarantees it stays
coherent.

In particular, obviously if we've written to a page, we've lost the
association with the original file entirely. And I'm pretty sure that
a private mapping is allowed to act as if it was a private copy
without that association in the first place.

That said, this _is_ a QoI thing, and in Linux we've generally tried
quite hard to stay as coherent as possible even with private mappings.

In fact, before we had real shared file mappings (in a distant past,
long long ago), we allowed read-only shared mappings because we
internally turned them into read-only private mappings and our private
mappings were coherent.

And those "fake" read-only shared mappings actually were much better
than some other platforms "real" shared mappings (*cough*hpux*cough*)
and actually worked with things that mixed "write()" and "mmap()" and
expected coherency.

Admittedly the only case I'm aware of that did that was nntpd or
something like that. Exactly because a lot of Unixes were *not*
coherent (either because they had actual hardware cache coherency
issues, or because their VM was not set up for it).

                 Linus
