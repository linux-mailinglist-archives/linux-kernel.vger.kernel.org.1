Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21102B6ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgKQQy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbgKQQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:54:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD06C0613CF;
        Tue, 17 Nov 2020 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SW6fmODD6xDvsJn1TWGyEiF//LJjiV8+TjvQ1ySSA88=; b=lq3YVcTwd+YGG+6GKyTS2U/4rZ
        DH6zs9aNY7ifK5VmgM634jEFYzU+8ke9yjK9E2ysRtCijFn/0j16tWqdg627im/7uemflFmhT6Wrn
        aCARA0U74C4pI5wvVn0clSIzsiclO4FKldfvYQIUER2zef3Jcrchy9LGgmAAs0QvfYqKmp7g4aPCd
        BF1qHl6azNXXwj7eiOoJqvcgNICKuM1cEn0kxZboM8XzAAvRlVbdeWzKr086R7IoSYhHMpIqQahhA
        raFwLkGrH9u78GQfJQwVf8q/TLVUBai4znYY/Ae3TvXPo/7q2ZXfnBt0ggYFBlL93o9QhhVIsx1f7
        ZcuJsSow==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf4Fr-0003VZ-MI; Tue, 17 Nov 2020 16:54:56 +0000
Date:   Tue, 17 Nov 2020 16:54:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4] mm: Optional full ASLR for mmap() and mremap()
Message-ID: <20201117165455.GN29991@casper.infradead.org>
References: <20201026160518.9212-1-toiwoton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026160518.9212-1-toiwoton@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 06:05:18PM +0200, Topi Miettinen wrote:
> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> enables full randomization of memory mappings created with mmap(NULL,
> ...). With 2, the base of the VMA used for such mappings is random,
> but the mappings are created in predictable places within the VMA and
> in sequential order. With 3, new VMAs are created to fully randomize
> the mappings. Also mremap(..., MREMAP_MAYMOVE) will move the mappings
> even if not necessary.

Is this worth it?

https://www.ndss-symposium.org/ndss2017/ndss-2017-programme/aslrcache-practical-cache-attacks-mmu/
