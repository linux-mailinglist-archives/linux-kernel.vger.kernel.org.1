Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A3284375
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgJFApP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFApO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:45:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C421C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 17:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d7VSZPo044cxIxYzl44q0fNIFgW7c06/GV69ntJURIg=; b=Onk4Nn051IJxw0teFwDsjobrty
        /hDTEB5jMbF5zBhq7h/fTlEWFJuJQ6/DHdsGOawLRI/mo45t/zac/xr4OyiDc76laFKIS0VcEk+BH
        SYq4Tv0ANxtWGY1KTbNyqsfTQziZajI6DqMlSm0N/V0L2VBSrD7SuPaL+CNX9V22YQ4Q195wh6ypm
        7pCUi+ZoSePY0B1pgMOPGSsQz+I/sPpsHlAsHf2pn9SWMi9v5eMFuQ7aUilqpusQHg3NA00dc5td0
        VN8c8EYbPTr4LFm0wS44cWMhoPLdMg9s4QKWZQkMTSY0VZHbIm8nzywpx6/5N6wVmCH3IKoyT03BA
        WqxfoMhA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPb5S-00007d-KE; Tue, 06 Oct 2020 00:44:14 +0000
Date:   Tue, 6 Oct 2020 01:44:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20201006004414.GP20115@casper.infradead.org>
References: <20200929183513.380760-1-alex.popov@linux.com>
 <91d564a6-9000-b4c5-15fd-8774b06f5ab0@linux.com>
 <CAG48ez1tNU_7n8qtnxTYZ5qt-upJ81Fcb0P2rZe38ARK=iyBkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1tNU_7n8qtnxTYZ5qt-upJ81Fcb0P2rZe38ARK=iyBkA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:56:33AM +0200, Jann Horn wrote:
> It seems to me like, if you want to make UAF exploitation harder at
> the heap allocator layer, you could do somewhat more effective things
> with a probably much smaller performance budget. Things like
> preventing the reallocation of virtual kernel addresses with different
> types, such that an attacker can only replace a UAF object with
> another object of the same type. (That is not an idea I like very much
> either, but I would like it more than this proposal.) (E.g. some
> browsers implement things along those lines, I believe.)

The slab allocator already has that functionality.  We call it
TYPESAFE_BY_RCU, but if forcing that on by default would enhance security
by a measurable amount, it wouldn't be a terribly hard sell ...
