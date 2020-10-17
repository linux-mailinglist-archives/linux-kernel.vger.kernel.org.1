Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C998F291365
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 20:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438748AbgJQSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438736AbgJQSFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 14:05:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961BEC061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 11:05:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h6so7510843lfj.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YzzkfpJGlrB+NzoqhMm5+0wWAh7Rs2lQArX41HEAZCI=;
        b=TKzbCbUH7/c9ZSIadXiw2jBTw8FZOtumacQ3aVsQPG3EMi3ovIrNr1LT83lI/QH6RX
         6SYmz6HeVIjzp5Sr0WpMUwSO9mzQG42mg+5ygnrIHPoOo7L2Cw7XHagFYbBRDwk3tqba
         +KviVi+0xg52SClQeey5o0rS6yC1vNh69NVxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YzzkfpJGlrB+NzoqhMm5+0wWAh7Rs2lQArX41HEAZCI=;
        b=dhC5U2YpTXhaUtv0E9RQJjzYjBn/20IH4faJIRZYRVmxiScV9V/mSWDtgd6NlPzpzL
         w41Hk4lqhAp3L/clWDKUwgyVk+/NaZa/SENiACL52TwvXuJFZQf5tLj9+dSohjVSAxB2
         yWw0qAxbixKk+BWHM8trp4Z8M9JMuO23tdqN53J4MRzDH6NsY7jo7hRUAp9uK94ZYxjn
         wjsXR3t08Rh2OlNxUixiOkiU+9rQcezk2BEznsS4kls+UK2qV5sZO4xFhgHl2IMatbgL
         Syc9YU+rBfU1qQkXkHYRQxWaREa+703n+YP5fhbo4Vp6sOfrnxpfugY3jbjbbzNMHeYw
         odtg==
X-Gm-Message-State: AOAM531IzjErEgxfmvcktADiRBL2gxLRH53P38x8cnPe7g8f1kcUtdJC
        jjm/KFbUYpzpJdJvi1mqLUAeu/+94gksQA==
X-Google-Smtp-Source: ABdhPJyaXWG496YUcO3yCcb5ycxmU/JYK7up78e0tKSnC1oL3nypSKYozibdTOPlPKPG3HW2JwXB3g==
X-Received: by 2002:ac2:5101:: with SMTP id q1mr3116291lfb.560.1602957925649;
        Sat, 17 Oct 2020 11:05:25 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d21sm2107102lfl.62.2020.10.17.11.05.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 11:05:23 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id h6so7510659lfj.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 11:05:22 -0700 (PDT)
X-Received: by 2002:a19:4815:: with SMTP id v21mr3692028lfa.603.1602957921972;
 Sat, 17 Oct 2020 11:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201016123530.GA30444@duo.ucw.cz> <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
 <20201017100234.GA3797@amd>
In-Reply-To: <20201017100234.GA3797@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Oct 2020 11:05:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
Message-ID: <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
Subject: Re: autofs: use __kernel_write() for the autofs pipe writing causes
 regression in -next was Re: 5.9.0-next-20201015: autofs oops in update-binfmts
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Ian Kent <raven@themaw.net>, Ondrej Mosnacek <omosnace@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        autofs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 3:02 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Bad Linus!

Christ people.

The bug is in linux-next, not in mainline.  I've told the people
involved already over a week ago.

I can't do anything about linux-next being broken and people not fixing it.

              Linus
