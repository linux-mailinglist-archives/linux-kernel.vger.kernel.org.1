Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA8E22BB1E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 02:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgGXArX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 20:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGXArT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:47:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEB2C0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:47:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so8270783ljn.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUaZ6oEhaxK6LHHxjQm2OcsjcreLEUTmrsVj8KinfEw=;
        b=MfMPxvMDiUBBcl90gFozRhD46ePBTnsGsvmrHjsEBskvGVqG0I3gH9nIf1ESYZxS07
         Sl1DHyZskPVvE8LErPPfUDDDcK+05p7FEM34h0GGpTgr217o11tHoE+fl0bCOD0HqzEx
         RW0W/ERJnL1Dv/2rmNvi0o5hhSw3jqX/7J/oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUaZ6oEhaxK6LHHxjQm2OcsjcreLEUTmrsVj8KinfEw=;
        b=F3IFAHsuTUAgoiKKFoNbFaXiRe150SuC8bHJEEP0njGo1cmu8fN4NBAwQEgEIZ7/Dk
         +0Tfv/6aP15Gqq4E/E78Y3x7iEAsD2RgitaRaVtRzLtoYlD99/iVkp2pK1K303gnJyKB
         vyjlSBGS/uEBbe1n+cNpXQYvlPzaXe26sw3yHQiicCOiBME2p+WXg7L8nUbakbZ43Vwl
         VkMzifmpijwJCcL4FBQIpnbxfcvLSYpmjslws/pdK11AdjbTiLIkRirkX4/+ix9ZKY3t
         4E94qNfNJ3gxeyMDg3kUzwi0endRaJ74wsYw4PgSh/qaylzsnf9oNW2yVVds/caUu26V
         7GPQ==
X-Gm-Message-State: AOAM532ePrpr8RIDh5+lU579j7WOJQccAORTqFt7g4R340gaY+AWEF82
        WEGvNNgOX2BxMGnZYWFlFEkllP1tOYg=
X-Google-Smtp-Source: ABdhPJy1kua/PMLUxwX2xUNJckn8MzlZz7M8crXKNz1He/COQ0gAdIo5lQK5p9yaHY/cUzWdd4+GQQ==
X-Received: by 2002:a2e:9641:: with SMTP id z1mr3166679ljh.173.1595551636834;
        Thu, 23 Jul 2020 17:47:16 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id p4sm3630070lfk.0.2020.07.23.17.47.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 17:47:15 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u12so4297898lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 17:47:15 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr3512335lfo.31.1595551635182;
 Thu, 23 Jul 2020 17:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <CAHk-=whQK3OGwExTzCrwwvuuVaQAgs8KsR-Yv8m1BmXoNZZ=jQ@mail.gmail.com>
 <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com>
 <alpine.LSU.2.11.2007231650170.1281@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2007231650170.1281@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jul 2020 17:46:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgptprCsM9Vv7wvBF6q23rR5WA94pBGD5kfS2sPwgNVyA@mail.gmail.com>
Message-ID: <CAHk-=wgptprCsM9Vv7wvBF6q23rR5WA94pBGD5kfS2sPwgNVyA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Hugh Dickins <hughd@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 5:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> I say that for full disclosure, so you don't wrack your brains
> too much, when it may still turn out to be a screwup on my part.

Sounds unlikely.

If that patch applied even reasonably closely, I don't see how you'd
see a list corruption that wasn't due to the patch.

You'd have had to use the wrong spinlock by mistake due to munging it,
or something crazy like that.

The main list-handling change is

 (a) open-coding of that finish_wait()

 (b) slightly different heuristics for removal in the wakeup function

where (a) was because my original version of finishing the wait needed
to do that return code checking.

So a normal "finish_wait()" just does

        list_del_init(&wait->entry);

where-as my open-coded one replaced that with

        if (!list_empty(&wait->entry)) {
                list_del(&wait->entry);
                ret = -EINTR;
        }

and apart from that "set return to -EINTR because nobody woke us up",
it also uses just a regular "list_del()" rather than a
"list_del_init()". That causes the next/prev field to be poisoned
rather than re-initialized. But that second change was because the
list entry is on the stack, and we're not touching it any more and are
about to return, so I removed the "init" part.

Anyway, (a) really looks harmless. Unless the poisoning now triggers
some racy debug test that had been hidden by the "init". Hmm.

In contrast, (b) means that the likely access patterns of irqs
removing the wait entry from the list might be very different from
before. The old "autoremove" semantics would only remove the entry
from the list when try_to_wake_up() actually woke things up. Now, a
successful bit state _always_ removes it, which was kind of the point.
But it might cause very different list handling patterns.

All the actual list handling looks "obviously safe" because it's
protected by the spinlock, though...

If you do get oopses with the new patch too, try to send me a copy,
and maybe I'll stare at exactly where it happens register contents and
go "aah".

        Linus
