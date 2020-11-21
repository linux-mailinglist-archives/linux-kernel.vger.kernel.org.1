Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7DE2BC164
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKUSVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgKUSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:21:38 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABF4C061A4A
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:21:37 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id l11so18182476lfg.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXimiLJTrNupHkZvWwFLioXTRq0xyflB27lsWAkpfI4=;
        b=OWXHkUpTUVUoKPLewahV2bn8y9YWUhTKYYqZPcYsYz/RxIyBL9VvoEJydt/4b22Nc/
         FTt0PAtaMLOG4UkWlpyTiyFvNX9w7VTVF8V5pJRqz8mT2iV3leIIRlo5cQY61ut3NtZU
         1FFF98JuFgYzZovWcgU3304W0AGFjzWEOXuJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXimiLJTrNupHkZvWwFLioXTRq0xyflB27lsWAkpfI4=;
        b=saVHU26iBipnDbgbrWetclMoI/XByq1ABrQlX6HExbHo0g4Hcygu3GJtqRNw6bIn0F
         dgbOmSzQCy1YalcfkJ0aUxrMxqLDgb11oS/HE33IH2nb1mfxHXWXIbmU5z189djqx7rc
         VkOxF8yViyrC2E7q9OLevWJk10jMey0AZE20xPISfb4i5LvQBxOfs00Q0sNwhmX1zoTz
         nPyUNU6dKS1mxQA25zI3MedJC8YkOiIPSfXDB1vUjPgRXju1E0gcTzvn6BeD4oBRusbp
         hSxndUntud4QQ+HhYagW1vM9deojemZT9A1/4uKYfaFLqfbwXhuH6DBX5P/gbIWNMc7Y
         eIgQ==
X-Gm-Message-State: AOAM533M99kCdrEOqe2JM/w30a3YUfp9PRJIYcyZCjV+foSIwpcy1fnR
        93xdvthSXeo36bulV6Dr2JKE0AAiXGAwAw==
X-Google-Smtp-Source: ABdhPJxU0cjZPYsWWCkWTPU1+aVdFee2+ABNcNOHgF+tc416Lwv8WA5Ot4cpj0mU20kNVIDJ5s+viA==
X-Received: by 2002:a19:7e53:: with SMTP id z80mr11530517lfc.250.1605982895224;
        Sat, 21 Nov 2020 10:21:35 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id i187sm681290lji.24.2020.11.21.10.21.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 10:21:34 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id u19so18129869lfr.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 10:21:34 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr11475617lfd.603.1605982893826;
 Sat, 21 Nov 2020 10:21:33 -0800 (PST)
MIME-Version: 1.0
References: <160596800145.154728.7192318545120181269.stgit@warthog.procyon.org.uk>
 <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
In-Reply-To: <160596801020.154728.15935034745159191564.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Nov 2020 10:21:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
Message-ID: <CAHk-=wjttbQzVUR-jSW-Q42iOUJtu4zCxYe9HO3ovLGOQ_3jSA@mail.gmail.com>
Subject: Re: [PATCH 01/29] iov_iter: Switch to using a table of operations
To:     David Howells <dhowells@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 6:13 AM David Howells <dhowells@redhat.com> wrote:
>
> Switch to using a table of operations.  In a future patch the individual
> methods will be split up by type.  For the moment, however, the ops tables
> just jump directly to the old functions - which are now static.  Inline
> wrappers are provided to jump through the hooks.

So I think conceptually this is the right thing to do, but I have a
couple of worries:

 - do we really need all those different versions? I'm thinking
"iter_full" versions in particular. They I think the iter_full version
could just be wrappers that call the regular iter thing and verify the
end result is full (and revert if not). No?

 - I don't like the xxx_iter_op naming - even as a temporary thing.

   Please don't use "xxx" as a placeholder. It's not a great grep
pattern, it's not really descriptive, and we've literally had issues
with things being marked as spam when you use that. So it's about the
worst pattern to use.

   Use "anycase" - or something like that - which is descriptive and
greps much better (ie not a single hit for that pattern in the kernel
either before or after).

 - I worry a bit about the indirect call overhead and spectre v2.

   So yeah, it would be good to have benchmarks to make sure this
doesn't regress for some simple case.

Other than those things, my initial reaction is "this does seem cleaner".

Al?

              Linus
