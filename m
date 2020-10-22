Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC1629661A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371848AbgJVUme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896368AbgJVUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:42:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D920C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:42:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh6so1597092plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M48Z6dq4Jhpe3JgUiGHx76Ra14zyQBkL7sy6RyPYqsE=;
        b=tqQKw8yfbOISqEcFPoYrhOHz6zTw8moGivLgeSpH6f0nev+ZF8PFQMRwnMnPiwvD6g
         2gBXGMJYaL54tTYK5g+TKtdHkfBXvLVpDrbucm8WeMh/cRni7umcVePSKAIm8n5G5rAI
         CX8/3IyLiDixZaMxqEWCWeMfzy7F0y18Z+hmAy9xOuaq6yqONXa+U05Ewj99IE3n8aT/
         73k1NRkZ+DkydDcHzqhTk5bGvxCsQ3TBFHRFAj+B+6Z0+frbVMtGJgO3oPP8qizQQA4Z
         5kBBQAonmHQPr8ug1nzXxsvzxNLxOaebi1ERdsoRHeoDjmv2dpy0IeoX4UbIserB5qcV
         7OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M48Z6dq4Jhpe3JgUiGHx76Ra14zyQBkL7sy6RyPYqsE=;
        b=TV9+3xMX3CBctWkVWbbkd2ZK4UR/AkKOK7bmwA2j9NuI89OI2gyluD+1w4+76hu0zK
         dEde+hkmAkCH6e02ajTfW5F3/639rxe+8Jm8vtQhfGiXS8pwkp4+1fGM1rnaEhfkl6mY
         68QqVThHm5PPy8QRlVWjiTclDCWN0Pz7X1c8mOg82KBA6TKN+18ySgMT8tzSioqILaHK
         kEFad8r9/gnx/9dGz5+/3f5XhvCz1NfQxWHpx/tRbpeCFH05vrBqiVg8CZKOOUL5vilN
         zkBXiM9XK23o9DS5W628EvMG1XBu/iRs7iLJ9DNzpi5xtSD5nkaw+8uITHeQQpMoOEpM
         Mgvg==
X-Gm-Message-State: AOAM531k76lHH/I88NRLtFRORhxdHHeQBq/d7smn4L1CKUyKt0CBq0TJ
        zOmZ/vRHu1qaCO8RYvxj47VCMyhKmWZ/8dZjMaiu0jVnZUkO5A==
X-Google-Smtp-Source: ABdhPJymmYg+WiV/imoEhD5kjgx0cbehw+o61MV9WBX9bVP1AO8BGWs9+9Ahs8UXNlMep72HHNrY+fjTzvqNpJg5KYI=
X-Received: by 2002:a17:902:c24b:b029:d3:f3e6:1915 with SMTP id
 11-20020a170902c24bb02900d3f3e61915mr4264388plg.56.1603399352926; Thu, 22 Oct
 2020 13:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
In-Reply-To: <fe8abcc88cff676ead8ee48db1e993e63b0611c7.1603327264.git.joe@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Oct 2020 13:42:21 -0700
Message-ID: <CAKwvOdmUPA9XupXwYHy_qT7P+LrUc+wseT79K_oqw=3y6bwLfg@mail.gmail.com>
Subject: Re: [PATCH] treewide: Convert macro and uses of __section(foo) to __section("foo")
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.On Wed, Oct 21, 2020 at 7:36 PM Joe Perches <joe@perches.com> wrote:
>
> Use a more generic form for __section that requires quotes to avoid
> complications with clang and gcc differences.
>
> Remove the quote operator # from compiler_attributes.h __section macro.
>
> Convert all unquoted __section(foo) uses to quoted __section("foo").
> Also convert __attribute__((section("foo"))) uses to __section("foo")
> even if the __attribute__ has multiple list entry forms.
>
> Conversion done using a script:
>
> Link: https://lore.kernel.org/lkml/75393e5ddc272dc7403de74d645e6c6e0f4e70eb.camel@perches.com/2-convert_section.pl
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> This conversion was previously submitted to -next last month
> https://lore.kernel.org/lkml/46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com/
>
> Nick Desaulniers found a defect in the conversion of 2 boot files
> for powerpc, but no other defect was found for any other arch.

Untested, but:
Reviewed-by: Nick Desaulniers <ndesaulniers@gooogle.com>

Good job handling the trickier cases when the attribute was mixed with
others, and printing it in scripts/mod/modpost.c.

The only cases that *might* be similar to PPC are:
>  arch/s390/boot/startup.c              |  2 +-
>  arch/x86/boot/compressed/pgtable_64.c |  2 +-
>  arch/x86/purgatory/purgatory.c        |  4 ++--

So a quick test of x86_64 and s390 would be good.

Thanks for the patch.

>
> The script was corrected to avoid converting these 2 files.
>
> There is no difference between the script output when run on today's -next
> and Linus' tree through commit f804b3159482, so this should be reasonable to
> apply now.


-- 
Thanks,
~Nick Desaulniers
