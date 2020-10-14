Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43328E5AE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgJNRqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgJNRqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:46:10 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B98FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:46:10 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a12so3337844ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AZaJPXWNDGZWzFZgqpQzEpS7MiNSjgYXkkad50wZ1Q=;
        b=X0XaLtHUBCZXGIw9YSO+4kWV6USf0yRc+mINuIu/T4o98a49SjvTmCWQwhTxue34Fb
         CnuAAf/bSpAAQFwsfdT5HYwoiVOs5a3PIBQRiP1H2d5sVTll824hB0095J7Sp4J/8r2m
         rQRjgFuKS8hZk8aEwooDyK9RiIlbEFRvN7+1e22mZV/MKnNeZWVo5tWd/X9ndc1rEkT5
         hJPk6z7RA5z/kfwdCNhS8nFwPOL3A63970ahMyNzCRPztC4c7hffV/098g3iqJYxzVVv
         vTVDGVXFDiA5yN4w34mbfuGGYFnvFkSFwNk2McqzRV5O5BKKDxAFFKxUzzV8qSQbVTwS
         qY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AZaJPXWNDGZWzFZgqpQzEpS7MiNSjgYXkkad50wZ1Q=;
        b=hpEBHqcLFHvGgLXDpTl4psSkH0FZJsP0oA0TESpuYj9NvNLtVMiNFgLoCTAqxxvSWs
         Zn8igfKkGaKdQbfci0E+FlP+8IDCZEsRQQ/mDAhfRCqJ7+ZNsaRnVzkao98wfoFnihZA
         zewBzC0L61B7D90oij4Km9SpDXug54koIEheaVmRgtbg9uIqa/pRibdoJUDqLFwjJItM
         IBoyqzUw2g0jEtnCWL3AhU8saWq+bzOzTsfMbfjJNePkyzxguW/1chliskWrY3FCGhLE
         w0tQoIXAv9e+GNzo8X2TJgyI4e4bC73A0rnuUAbiKv3AHLOcTGJ6B6+7Pq7QCqUQjdJf
         42eQ==
X-Gm-Message-State: AOAM530xTpK3OutshvFNP52eJPbHquUJty4skf4bqNzGR+HojE1xKPPB
        DmdaBVkxn0RACDUx/3UTVqDpyJ6GTgL062uDsE9fpYMZnZs=
X-Google-Smtp-Source: ABdhPJybo4M4wILi8aUvrZUMVA77tOrm4EF2DKDFZi5wTOxS0hIiTSmpgjZBHrTkVY9K41xrkX47WCCbtn2qT78J6Ws=
X-Received: by 2002:a25:3b4b:: with SMTP id i72mr816775yba.22.1602697569839;
 Wed, 14 Oct 2020 10:46:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
 <alpine.DEB.2.21.2010140734270.6186@felia> <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
In-Reply-To: <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 14 Oct 2020 19:45:59 +0200
Message-ID: <CANiq72kogiVbBURCrb74_vCPCLb09LGTudxE-QG8US7pX8LqQw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to EXECUTE_PERMISSIONS
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 10:40 AM Joe Perches <joe@perches.com> wrote:
>
> Eek no.
>
> Mindless use of either tool isn't a great thing.

That is up to opinion. I (and others) definitely want to get to the
point the kernel sources are automatically formatted, because it has
significant advantages. The biggest is that it saves a lot of time for
everyone involved.

> Linux source code has generally be created with
> human readability in mind by humans, not scripts.

Code readability is by definition for humans, and any code formatter
(like clang-format) is written for them.

> Please don't try to replace human readable code
> with mindless tools.

Please do :-)

> There is a _lot_ of relatively inappropriate
> output in how clang-format changes existing code
> in the kernel.

Sure, but note that:

  - Code that should be specially-formatted should be in a
clang-format-off section to begin with, so it doesn't count.

  - Some people like to tweak identifiers or refactor code to make it
fit in the line limit beautifully. If you are doing that, then you
should do that for clang-format too. It is not fair to compare both
outputs when the tool is restricted on the transformations it can
perform. You can help the tool, too, the same way you can help
yourself.

  - Some style differences may be worth ignoring if the advantage is
getting automatic formatting.

Cheers,
Miguel
