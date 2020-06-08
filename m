Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002AD1F1FA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgFHTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFHTSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:18:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F4C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:18:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j18so8888724lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+aTf2gj2lOJ6qgTzBTSu7Nj1KO1oLISUQJXCwIgKPw=;
        b=XycGSfymrTt81KEthuu69tnYBVTU4/J3hiH1z1OY7eG4VVaSI6wY1sNsf3vhH1zEOS
         dZXPuBt2VedjgwEjaYyqKGA7dFvG4VByaiDcz9wEBUo5Wdk675sUio3QpzXNo5zQfjkB
         Fdj//4grkPz8ALLWOhe7NYdYjv8ulkjsZ2EH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+aTf2gj2lOJ6qgTzBTSu7Nj1KO1oLISUQJXCwIgKPw=;
        b=LHozDts/noAvD3cZywGuAEQjtAIKEl+LvOrm4vLSRryWAZOkUe7JhZnbNBli1IpBL2
         ZUsRww4HDDvCtKBKapPaIwzqqNVDSvvVSKlqvJpTFetgT5lGfXoHuQImD/e/L9RNTnN4
         bccdMDi2hGOisdjTvP3MHuxx4Ja7j/iRCm2OY5Ty90G1tFj2VB3yDraMCiHQOJ7fK9iA
         C3XJHpNzzNWUqaE7EzZQFaxb8+QnXLvF3LYY6EPUhEu/SM29WXXRs9xydXDQ2nElbYsn
         QEJB9FgQVr56FCGS7Iq5dZpNnLZ0+7sRzTC/kVG7Kz6Plkv5QcgQWwZOmYlUCnS5hY6J
         Ga+g==
X-Gm-Message-State: AOAM530Px9xB9ngJY//JU+7jyly+n3YS3yb4qGdoguTgyYWE1bcXvEBD
        MaGEQ+5vnXSiDnjNEioBibIiZrbeQ4o=
X-Google-Smtp-Source: ABdhPJwc+bwPF16FdfgcP/S7179lc9r4aHWgV6sSVcGA3MGtU9n+67v0U0oLb3Pv8ivMvmFm8gvZ7w==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr11065330ljj.208.1591643915482;
        Mon, 08 Jun 2020 12:18:35 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k12sm3871907lja.35.2020.06.08.12.18.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:18:34 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id c17so21927541lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:18:34 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr11451625ljj.102.1591643914040;
 Mon, 08 Jun 2020 12:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
 <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com>
 <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk> <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
 <CAHk-=widT2tV+sVPzNQWijtUz4JA=CS=EaJRfC3_9ymuQXQS8Q@mail.gmail.com> <20200608020522.GN23230@ZenIV.linux.org.uk>
In-Reply-To: <20200608020522.GN23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jun 2020 12:18:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBT80kcCTh8fpuYBr6D7O_THew4-KTr2jeMhYfoCd9hg@mail.gmail.com>
Message-ID: <CAHk-=wjBT80kcCTh8fpuYBr6D7O_THew4-KTr2jeMhYfoCd9hg@mail.gmail.com>
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 7:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         return mask & deny ? -EACCES : 0;

I agree that 'deny' would be simpler to read here, but in other places
it would look odd. ie the IS_POSIXACL() thing that checks for "are
group bits set" still wants the mode.

And I'd hate to have us use code that then mixes 'deny' and 'mode'
when they are directly related to each other.

Anyway, I merged the patch as-is, I guess we can make future changes
to this if you feel strongly about it.

              Linus
