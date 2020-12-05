Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3112CFFA6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 00:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgLEXLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 18:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEXLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 18:11:21 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7B7C0613D4
        for <linux-kernel@vger.kernel.org>; Sat,  5 Dec 2020 15:10:35 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s9so10820669ljo.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 15:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cF7ghIHQxa0oYVBM5yXcvLkf+Bbmp2gqnwBTDnrEniE=;
        b=Kwk7qdIpCTjn5wKTkjAJn04/bgxnzHRQHY+1KSehk3rpzeI2uWC+sjclVwAbYYBInu
         6IOqXIi3xlGO6pr0te0GAm3phMgA8zlmqFgDDFvoeA6HEaMWLBgDvWczH8Owe2x+kelX
         qe7tBtHZObgmHMDhBK1LeEE08JOeM8dvhRd+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cF7ghIHQxa0oYVBM5yXcvLkf+Bbmp2gqnwBTDnrEniE=;
        b=X/w1AOsX57ZPZAsc3eV7R1DooXYZXsIXa9x0u7ht8ZYwH3K9QqyrBqpJpiKpGLYXPj
         zM3cdIbjIi/XGqNg56zGbHyzKN8s+wYbYyUVp2gilTANm3r2xALU8X1zOeV898XiMZPy
         n8y1+dQPrmJfDzqC4BvrHxLt87ItgWXlZy5wa0cq9jaxktMXtni1D9Kw4JvECJ0+2+8E
         IRooo6kxiqNmERL8CvyhwzbWtBPzxyk63eTQlg08rPDQXmP5XhIJW2MIv49qeaDKnLw2
         7jCyAghCsq/sHgsbKOeub3ney5m/UY9LwmAhcOLiSJP6aRGs0N4iWOYm1VPCwUeVk+eP
         n6ww==
X-Gm-Message-State: AOAM5331cQ2Vt9exDdW1P+CDrGxNHQuvopdn+CFMDSyEUGR2NxEOdzLC
        RlqSljDRXHRyVvS/eqOjJY1XQY79XBWheA==
X-Google-Smtp-Source: ABdhPJyIPPoAWXXDZaeg7IXRvJ8zeYtz5jQdzuSS/6pwOp71pAk/uxQcobIi/eFC/7cpq23cxbskhA==
X-Received: by 2002:a05:651c:c2:: with SMTP id 2mr5770675ljr.104.1607209833364;
        Sat, 05 Dec 2020 15:10:33 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 5sm2409900lfr.197.2020.12.05.15.10.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 15:10:32 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id d20so12741752lfe.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 15:10:31 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr5383021lfy.352.1607209831516;
 Sat, 05 Dec 2020 15:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20201205143250.2378b9f9@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
In-Reply-To: <20201205143250.2378b9f9@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Dec 2020 15:10:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjQYjRusiGfXTywSg5xC8knhP6uesDfO3J=bgu5uevtyA@mail.gmail.com>
Message-ID: <CAHk-=wjQYjRusiGfXTywSg5xC8knhP6uesDfO3J=bgu5uevtyA@mail.gmail.com>
Subject: Re: sparse annotation for error types?
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        edwin.peer@broadcom.com,
        Zhang Changzhong <zhangchangzhong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 2:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Am I the only one who thinks this would be a good idea?

I don't think it's likely to be very useful, because a very common
pattern is to not have that separate "return 0" in the middle, but
more along the lines of

        err = first_step(obj, 1);
        if (err)
                return err;

        if (some_check(obj)) {
                err = -EINVAL; /* need explicit error set! */
                goto err_undo_1s;
        }

        err = second_step(obj, param);
        if (err)
                goto err_undo_1s;

        err = third_step(obj, 0);

   err_undo_2s:
        second_undo(obj);
   err_undo_1s:
        first_undo(obj);
        return err;

iow, the "undo" parts are often done even for the success cases. This
is particularly true when those first steps are locking-related, and
the code always wants to unlock.

Sparse also doesn't really do any value analysis, so I suspect it
wouldn't be trivial to implement in sparse anyway.

Syntactically, I also think it's wrong to annotate the variable - I
think the place to annotate would be the return statement, and say
"must be negative" there. Kind of similar to having function arguments
annotated as "must not be NULL" (which sparse also doesn't do, but
some other checking tools do, and sparse can at least _parse_
"__nonnull" even if it ends up being ignored).

It's a bit similar to gcc's has a "returns_nonnull" function
attribute, but that one is not "per return", it's a global "this
function cannot return NULL" thing so that callers can then be
optimized and NULL checks removed. So it's very similar to the
"argument is non-null" in that it's for warnings at the *caller*, not
the function itself.

So if we want sparse support for this, I'd suggest something more akin
to a smarter compile-time assert, IOW more like having a

        compile_time_assert(err < 0);
        return err;

and then sparse (or any other checker) could warn when there's a path
that results in "err" not being negative.

Having some kind of smarter compile-time assert could be useful in
general, but as mentioned, sparse doesn't really do value range
propagation right now, so..

Luc, any reactions?

          Linus
