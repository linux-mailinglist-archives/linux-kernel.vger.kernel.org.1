Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929812CE010
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 21:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbgLCUt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 15:49:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgLCUt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 15:49:58 -0500
Date:   Thu, 3 Dec 2020 12:49:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607028557;
        bh=Iz54XglcOoe77jtz7VvpJX1zZYveIrI7EDKyUjAzBNE=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=gxZrBLg1g38jqJHt+4TRxSacQbXjfAQyuNgBBZy/cHOBt0sXTYgy/SY+E87Kr7A9h
         tFbME0BPQ1cog44iqdXw5RjgsNxbHMs84gS8XcDB3hspHs3AN4ciqPywFHnHriekqe
         +t5UDh5+9/BvJElIScMwNeWi/GHHDLWAYKDfnpIU=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     alex.popov@linux.com
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
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
        Matthew Wilcox <willy@infradead.org>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>, notify@kernel.org
Subject: Re: [PATCH RFC v2 2/6] mm/slab: Perform init_on_free earlier
Message-Id: <20201203124914.25e63b013e9c69c79d481831@linux-foundation.org>
In-Reply-To: <1772bc7d-e87f-0f62-52a8-e9d9ac99f5e3@linux.com>
References: <20200929183513.380760-1-alex.popov@linux.com>
        <20200929183513.380760-3-alex.popov@linux.com>
        <CAG_fn=WY9OFKuy6utMHOgyr+1DYNsuzVruGCGHMDnEnaLY6s9g@mail.gmail.com>
        <1772bc7d-e87f-0f62-52a8-e9d9ac99f5e3@linux.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 22:50:27 +0300 Alexander Popov <alex.popov@linux.com> wrote:

> On 30.09.2020 15:50, Alexander Potapenko wrote:
> > On Tue, Sep 29, 2020 at 8:35 PM Alexander Popov <alex.popov@linux.com> wrote:
> >>
> >> Currently in CONFIG_SLAB init_on_free happens too late, and heap
> >> objects go to the heap quarantine being dirty. Lets move memory
> >> clearing before calling kasan_slab_free() to fix that.
> >>
> >> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> > Reviewed-by: Alexander Potapenko <glider@google.com>
> 
> Hello!
> 
> Can this particular patch be considered for the mainline kernel?

All patches are considered ;) And merged if they're reviewed, tested,
judged useful, etc.

If you think this particular patch should be fast-tracked then please
send it as a non-RFC, standalone patch.  Please also enhance the
changelog so that it actually explains what goes wrong.  Presumably
"objects go to the heap quarantine being dirty" causes some
user-visible problem?  What is that problem?

