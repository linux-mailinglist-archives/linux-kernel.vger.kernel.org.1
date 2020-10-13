Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB9328D4E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgJMTqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbgJMTqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:46:45 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470E9C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:46:45 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m20so669639ljj.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnNbqPovdhhp/fFyFjEzT72km0kDum6U0o2/AnLokdo=;
        b=gyj5i+wwTxy1FvnaKNiokrbfndglfYSKftj2nRRImiAHAM+okhvBdLpD0Tf0qe1T4V
         1U1VCpZuIgFUOqXksG42UsQ7xXowOU+3ysWzrzfTi7DgFKut4WuG4GJhn02tb7vs+Mnn
         FbLy5mk8ODWETTAdFfGv99U4LuXochk30UC9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnNbqPovdhhp/fFyFjEzT72km0kDum6U0o2/AnLokdo=;
        b=aPEDEH+zQcYzQ22D/pNEP5yb1icERK/LG13/n7p6YJdS1JKNB1Pe9ZURDfWXqgSHVG
         S4XBNaee16Mwzf0z5iBLz4wzqMagsgkKpqXMw0ffhP2s6C+/NBuFXTdoi1eC8kdEqyOh
         1POwmwyOkV9lDyylsbzUh5nVRuu0lDTwZyONwo7Xv4sRB+JWLcpwYP73awfiYmaJN3zT
         e5FsfyAMD1Ym/8oY3GyUn6BgSPk8i79Gq6XyopBKIWQqNmfNBJAIOmgMj5EHBP/qJkvv
         dx/Bsfe8EkQJHi8SyZ3EPPSGH4wnqi+neQ4ZBwT6Khs5VhJu1Q+WqPC/qsgkJHN1r7ku
         Q0sQ==
X-Gm-Message-State: AOAM5309gVhwWMUpDRe8KAb05WmQKY9JIGkNW597DH6dSL2E1vy4qF5K
        VhqPtgD8JuqqeUtgwf/qMR55NN55jS+2Ew==
X-Google-Smtp-Source: ABdhPJz77NSmUgdOhFLZnUeL0lN8VjtFZCTpbn2FQogZSrVgxiEFneYB1xLTSSmnsMErYs//yDRHdQ==
X-Received: by 2002:a2e:82cf:: with SMTP id n15mr413477ljh.394.1602618403273;
        Tue, 13 Oct 2020 12:46:43 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b14sm229733lff.300.2020.10.13.12.46.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 12:46:42 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id j30so1078037lfp.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 12:46:41 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr326393lfz.344.1602618401593;
 Tue, 13 Oct 2020 12:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <36a6706d-73e1-64e7-f1f8-8f5ef246d3ea@kernel.dk>
In-Reply-To: <36a6706d-73e1-64e7-f1f8-8f5ef246d3ea@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Oct 2020 12:46:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUjjxhe2qREhdDm5VYYmLJWG2e_-+rgChf1aBkBqmtHw@mail.gmail.com>
Message-ID: <CAHk-=wgUjjxhe2qREhdDm5VYYmLJWG2e_-+rgChf1aBkBqmtHw@mail.gmail.com>
Subject: Re: [GIT PULL] io_uring updates for 5.10-rc1
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 6:46 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Here are the io_uring updates for 5.10.

Very strange. My clang build gives a warning I've never seen before:

   /tmp/io_uring-dd40c4.s:26476: Warning: ignoring changed section
attributes for .data..read_mostly

and looking at what clang generates for the *.s file, it seems to be
the "section" line in:

        .type   io_op_defs,@object      # @io_op_defs
        .section        .data..read_mostly,"a",@progbits
        .p2align        4

I think it's the combination of "const" and "__read_mostly".

I think the warning is sensible: how can a piece of data be both
"const" and "__read_mostly"? If it's "const", then it's not "mostly"
read - it had better be _always_ read.

I'm letting it go, and I've pulled this (gcc doesn't complain), but
please have a look.

                 Linus
