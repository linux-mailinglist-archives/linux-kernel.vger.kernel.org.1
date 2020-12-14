Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36B2D9E47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502481AbgLNRzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408047AbgLNRzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:55:10 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB1C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:54:28 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id o19so6728718lfo.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LqrgkPy+zCNpdGlJy55sEFO1oQMSaaqQeWb7wVUwHM=;
        b=hmuyZCwirZ2/zGJKCeArmXdo6mSFxQOCOGuqa/Ao64WDftm8tQ/xhZi5Sc8oANDJ0g
         rQ6KOrZY7kx8LiaWvmMMd/x7m5erN8vLQcKKFxMz15g/biusPM3Dwscs2gXIuRKCVkkF
         9HTacsBGIwnx354xB5tyw1XD0oJ05atjrlfoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LqrgkPy+zCNpdGlJy55sEFO1oQMSaaqQeWb7wVUwHM=;
        b=Vslyeko1nz1e3lDCFmsHzjKrnysTYaYylKWAwHYW8xlTd3WDcS2PZ3k0isHwtKuJyi
         BGRtDJaLp/LqJpfcHmgr2LlZwGIvojv1xd8G++4TGj5bBFmJxjSRFD39E8BPOSfXF5op
         /Hgiu7NotqlKT3rBfvDqoTAvEP4lqyzB4sQz4h8Ojqwqjsguu+04jiHHQ7wExHVWQlBn
         FGF5xeoPbafVMSDOd4kUB83IkSBu0S/j56+jF6EDrETy4P0tx6iGs/fXFrNXj7M+l2yG
         gGojNwJ5yevbTCmnJU+5rn263s+p+6VYQXses3GCLTuU14+pcgLu6eDU6mWnIN/eTjQw
         MQ/A==
X-Gm-Message-State: AOAM531OrzydNmIgV5tdt5sW3FzixJWWs7TLAO4+v+ysU2vHCxVhQuuj
        UPX674C90GJEO/NxK3v0C2TG2zB89OsYjw==
X-Google-Smtp-Source: ABdhPJzhIIgg8G/0H0shebnkYAf131KQXeQh0pYQcGTNidqpj6vfWz5NcI+XSPG00GAtGXzlmQKqQw==
X-Received: by 2002:a05:6512:110a:: with SMTP id l10mr9729341lfg.167.1607968465218;
        Mon, 14 Dec 2020 09:54:25 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z7sm2454191ljm.126.2020.12.14.09.54.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 09:54:23 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id x20so12816220lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:54:22 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr9392758lfd.201.1607968462385;
 Mon, 14 Dec 2020 09:54:22 -0800 (PST)
MIME-Version: 1.0
References: <20201209163950.8494-1-will@kernel.org> <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck> <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com> <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
 <20201214160724.ewhjqoi32chheone@box>
In-Reply-To: <20201214160724.ewhjqoi32chheone@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 09:54:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
Message-ID: <CAHk-=wi80Qp6nZC0yyewhnqvrmPx2h_yWvfq4A25ONb7z9BywQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 8:07 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Here it is. Still barely tested.

Ok, from looking at the patch (not applying it and looking at the end
result), I think the locking - at least for the filemap_map_pages()
case - is a lot easier to understand.

So you seem to have fixed the thing I personally found most confusing. Thanks.

> I expected to hate it more, but it looks reasonable. Opencoded
> xas_for_each() smells bad, but...

I think the open-coded xas_for_each() per se isn't a problem, but I
agree that the startup condition is a bit ugly. And I'm actually
personally more confused by why xas_retry() is needed here, bit not in
many other places. That is perhaps more obvious now that it shows up
twice.

Adding Willy to the cc in case he has comments on that, and can
explain it to me in small words.

[ https://lore.kernel.org/lkml/20201214160724.ewhjqoi32chheone@box/
for context ]

And I actually think it might make even more sense if you moved more
of the pmd handling into "filemap_map_pages_pmd()".

Now it's a bit odd, with filemap_map_pages() containing part of the
pmd handling, and then part being in filemap_map_pages_pmd().

Could we have a "filemap_map_pmd()" that does it all, and then the
filemap_map_pages() logic would be more along the lines of

    if (filemap_map_pmd(vmf, xas)) {
            rcu_read_unlock();
            return;
    }

    ... then handle pte's ...

Hmm?

There may be some shared state thing why you didn't do it, the above
is mostly a syntactic issue.

Thanks,

              Linus
