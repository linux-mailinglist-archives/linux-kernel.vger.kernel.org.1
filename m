Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C0928440A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 04:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgJFCTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJFCTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:19:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD27C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 19:19:48 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c22so13871592ejx.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 19:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RQGQQnzUDnv0mOraeBJTeR9VvHirvaV4JaPm4c+FnM=;
        b=XhNVw1+TBfKHXDS9ILNRhsKTwQkADm6bKZt0zmGoCf9RgtxlAMSHmVejVLnM+hlQ92
         9h1bZRhd7XNx+Pyw4umW8tO3rsbDSYAT7TFN/BzcPFURPd/PbJaqRc0mm9uvXokDH8UD
         twLL6dA+UDImJ+xLxiFncIkwWOcVKLiIe+8/9fcDubmIl8YA6uqSmPA/Wop8j+DGiOzn
         fGXMDXhS5LJFaU/q4N03ythlCP8rgQPXyZn2wsuvvHKD6yWdvHdfCyoIUA5mgHl+16us
         9bIcRZ+VPstpHqmqgrQIz0bq7JqtPJa7d80mrw+1cbzqCm/yjj5Nqh6LXLQdB0eZfSqU
         kSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RQGQQnzUDnv0mOraeBJTeR9VvHirvaV4JaPm4c+FnM=;
        b=a6cDktZnqj8WIa6H9sSXiCcXirPg9fwV/y01kp5bOwOQVqPKjOFbzXY46aUYXKt2J1
         hz5TYVEQBqAez7Sxuveuq/hrWkqTVSVBaYgZlWQnhffHsf7Zl8uOe2wFqpq4HwH7rDGs
         ST1I/jeNDwutTgZsEHL6Ir8NXnsCug95MCVs8HBH93dhOcp5W8WIWkNTwcGz3iksdnl1
         z87iXJfxEZG5FAQSwRj356r5Bldaer5+1QYkXh+BCiPe+RpzeBbdZk2DfMdAvjaY0yuI
         +MTXHrWSeLSH0wOPsZfhcgUDedabUHu9yF+E0behUz1L0g5s7uALmlhmJOO3pJM1WJdg
         ofLg==
X-Gm-Message-State: AOAM531uWrPc/nf8IS3My8CmLzOeR+MCU2P0UaHBRoLhHm4ifXHdCzOl
        7skJwF/Fg1ygTdbebowREdULUkCnqlPby2js90E=
X-Google-Smtp-Source: ABdhPJxdtW1KHo9nm8XsftaIlbJ6Jt+UypzA4SMemizIx7+yhJ4RSe/qGU0OzOwdpL5vrNU/i9b2ut1DDWsxfYGMJEE=
X-Received: by 2002:a17:906:7d52:: with SMTP id l18mr2771101ejp.220.1601950787443;
 Mon, 05 Oct 2020 19:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200929183513.380760-1-alex.popov@linux.com> <91d564a6-9000-b4c5-15fd-8774b06f5ab0@linux.com>
 <CAG48ez1tNU_7n8qtnxTYZ5qt-upJ81Fcb0P2rZe38ARK=iyBkA@mail.gmail.com>
 <20201006004414.GP20115@casper.infradead.org> <202010051905.62D79560@keescook>
In-Reply-To: <202010051905.62D79560@keescook>
From:   Daniel Micay <danielmicay@gmail.com>
Date:   Mon, 5 Oct 2020 22:19:10 -0400
Message-ID: <CA+DvKQ+-k9pk1mUrEiTRKzSsz1ugCiv1A3Owd97dop0HPXa6MA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] Break heap spraying needed for exploiting use-after-free
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
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
        Andrey Konovalov <andreyknvl@google.com>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>, notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will reuse the memory for other things when the whole slab is freed
though. Not really realistic to change that without it being backed by
virtual memory along with higher-level management of regions to avoid
intense fragmentation and metadata waste. It would depend a lot on
having much finer-grained slab caches, otherwise it's not going to be
much of an alternative to a quarantine feature. Even then, a
quarantine feature is still useful, but is less suitable for a
mainstream feature due to performance cost. Even a small quarantine
has a fairly high performance cost.
