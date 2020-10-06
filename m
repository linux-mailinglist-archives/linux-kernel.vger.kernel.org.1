Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18852843F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 04:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgJFCJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgJFCJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:09:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE62C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 19:09:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so7103045pgf.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 19:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5uyUjU81WTaoePaJ6pjDUCkELEhzyE83H9lRZhP1V5g=;
        b=jDfIYFTbm5fkMc29R8o9ZHzX7Pte5RCT8w+9F5TNDpMHIl3zGQzp4q/T71oiQgb/Si
         k1O/y8IqkbJWAFT7y97YeQ6EIsYzITVWj2oBZvzYlLyMjwb8Wu46wKdTHdqb5EdpdpIe
         2MJyTF338pNoHuKyl4uFjC7Li4Vt/hvBkHZ6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5uyUjU81WTaoePaJ6pjDUCkELEhzyE83H9lRZhP1V5g=;
        b=eD2pJH9ApWx5hyE5Sf53+tDqOxCCl1Pfx/hRYf++DiKI8L+WW7gHWuH3PLsO6StXv5
         7CRC61Z/njs+A1kVuqjntQoxrRZsK1CFtKbYQ6ltzEaWhG7ZzCjcz6Pk3yDNNCTUpxaL
         X4CHTwt2KXJx6rr6tDITDYT/BG/bt+oKIDFpeJQyQXv0JdGj1JmJa3dQOlIQpogWU04q
         aYbiJfl3bTkMH/JDVG8/S5OaKKB4vz4T4o7CY7wkQBv/fRysP/lrTWD/MZdr8MyBUwi+
         3k4v9eTJzuX+UDt0nkSbxWmJToyGmzLipFDVxikgedGyGt2EQPszLQn8ce+7PGpcvtgT
         3unw==
X-Gm-Message-State: AOAM532sDyZliOv1P2YTEKdVz2XXdjBKQXTtvzJEv3k8fgg0EG3A9FCZ
        sNCIxr5otdseTKDojtHgizlx4g==
X-Google-Smtp-Source: ABdhPJw1yy34c+6y9kLpMI11/8Zi779s/k+fdqtafVTUPFWsVg2uuJr39pC14FmoS/i8HTu+80T8OQ==
X-Received: by 2002:aa7:8249:0:b029:142:2501:3964 with SMTP id e9-20020aa782490000b029014225013964mr2373840pfn.41.1601950167029;
        Mon, 05 Oct 2020 19:09:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm941792pgl.92.2020.10.05.19.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 19:09:25 -0700 (PDT)
Date:   Mon, 5 Oct 2020 19:09:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>, notify@kernel.org
Subject: Re: [PATCH RFC v2 0/6] Break heap spraying needed for exploiting
 use-after-free
Message-ID: <202010051905.62D79560@keescook>
References: <20200929183513.380760-1-alex.popov@linux.com>
 <91d564a6-9000-b4c5-15fd-8774b06f5ab0@linux.com>
 <CAG48ez1tNU_7n8qtnxTYZ5qt-upJ81Fcb0P2rZe38ARK=iyBkA@mail.gmail.com>
 <20201006004414.GP20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006004414.GP20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 01:44:14AM +0100, Matthew Wilcox wrote:
> On Tue, Oct 06, 2020 at 12:56:33AM +0200, Jann Horn wrote:
> > It seems to me like, if you want to make UAF exploitation harder at
> > the heap allocator layer, you could do somewhat more effective things
> > with a probably much smaller performance budget. Things like
> > preventing the reallocation of virtual kernel addresses with different
> > types, such that an attacker can only replace a UAF object with
> > another object of the same type. (That is not an idea I like very much
> > either, but I would like it more than this proposal.) (E.g. some
> > browsers implement things along those lines, I believe.)
> 
> The slab allocator already has that functionality.  We call it
> TYPESAFE_BY_RCU, but if forcing that on by default would enhance security
> by a measurable amount, it wouldn't be a terribly hard sell ...

Isn't the "easy" version of this already controlled by slab_merge? (i.e.
do not share same-sized/flagged kmem_caches between different caches)

The large trouble are the kmalloc caches, which don't have types
associated with them. Having implicit kmem caches based on the type
being allocated there would need some pretty extensive plumbing, I
think?

-- 
Kees Cook
