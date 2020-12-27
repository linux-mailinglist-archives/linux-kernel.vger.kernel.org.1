Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C862E31A6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 16:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgL0PLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 10:11:36 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:29086 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgL0PLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 10:11:36 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0BRFAYUr000847;
        Mon, 28 Dec 2020 00:10:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0BRFAYUr000847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1609081835;
        bh=do2zu1OH3hpkggNQ8T4D67CVIMzmt11X3sAFNqs/IFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=flrnmYMMuYxSO7Lc1pzO3Th4cQMYI1Gfkmz+craqIEUlxTTU9BHSMFW4cr5DCqBW5
         IRvlqiauRIIkHVb8ZjuksR6Eniu1pgVoSMPYu7tl5npHP9GpiYA8h4pc7dGry/jwGD
         lN5n/cR9aWluxEA1vbG7NiRuOvust5L1PKkM8E5Xvr83LttKbS1/FsE2EWywYokEyX
         S9/nrBxCgZbHKqx/pfDkND4QBGYdyfZYJO5eGgCbqZ7sP+gt+0FYisPl1lvviY3DNN
         acag9hLTsZmY1Hnr7//WdXooduCc7pfVu2Ka+gUMhfKXkFIY3q6ML9mBTP0g/2ktXm
         8aS9It6YJZRQw==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id iq13so4653564pjb.3;
        Sun, 27 Dec 2020 07:10:35 -0800 (PST)
X-Gm-Message-State: AOAM531XodXABfvJPsSgzRO4MoeDC5C2Jam/ppGAEJosoEm12qU30V49
        plVkvWxatq05p1u9YDV6qjGXiaUWhbwTN8X8zlA=
X-Google-Smtp-Source: ABdhPJybusihigpLBnrUv9y6gvoFYtFIiM+rxEASqAd/cn7oU9r0c3OQ5/nDEpbtMOnajgUOP1Y7+akYAdtINprWsTE=
X-Received: by 2002:a17:902:b415:b029:dc:42b1:9b26 with SMTP id
 x21-20020a170902b415b02900dc42b19b26mr26106771plr.71.1609081834110; Sun, 27
 Dec 2020 07:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20201227024446.17018-1-rdunlap@infradead.org>
In-Reply-To: <20201227024446.17018-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 28 Dec 2020 00:09:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYt8E6NnzytPLCLb46uMJWQ0ykQOiixKVbdNQPDr8iXw@mail.gmail.com>
Message-ID: <CAK7LNATYt8E6NnzytPLCLb46uMJWQ0ykQOiixKVbdNQPDr8iXw@mail.gmail.com>
Subject: Re: [PATCH v2] local64.h: make <asm/local64.h> mandatory
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 11:45 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Make <asm-generic/local64.h> mandatory in include/asm-generic/Kbuild
> and remove all arch/*/include/asm/local64.h arch-specific files since
> they only #include <asm-generic/local64.h>.
>
> This fixes build errors on arch/c6x/ and arch/nios2/ for
> block/blk-iocost.c.
>
> Build-tested on 21 of 25 arch-es. (tools problems on the others)
>
> Yes, we could even rename <asm-generic/local64.h> to
> <linux/local64.h> and change all #includes to use
> <linux/local64.h> instead.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>




> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Would some $maintainer please plan to apply/merge this.
>
> v2: instead of making local64.h a generic-y header file and adding it
> to the missing arch/ header locations, make it a mandotory-y header file
> and remove it from most arch/ header locations. (Christoph)
>
-- 
Best Regards
Masahiro Yamada
