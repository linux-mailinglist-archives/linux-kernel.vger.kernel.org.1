Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7583129DA7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgJ1XM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbgJ1XMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:12:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B4CC0613CF;
        Wed, 28 Oct 2020 16:12:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 15so751411pgd.12;
        Wed, 28 Oct 2020 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DiXcq/4UgFcTWCxFf97aJBO24zkVMbG42o5eatrIo3Q=;
        b=cRv6FCoahLU0+oD7yU2JuA+YI1h1CyU8EfjqNWWE56wNz9GefGbSAMvd1uS7eYPW3i
         SO54b32yo/8vUkJTxQhl5UlCHDtjW78gP8APDp6mlzZbH00qxaWy4JVRc4+eV48t8SJQ
         il1yH6s6oyMGituTUtkWElCbHdsKpXKADn2vTphqBJEe6/DdnWvRyJXFvZzNC8Ak0XbF
         9yzKlE4pk3tGmg7ADvyosowfD6b0m8AzpXT4f0vvhZqH2sBbgl2KMOO3kEAUWb9eY0tA
         X5/lVmAdreNXqjjXU8WyjMawbbSbEMg0+K7lp/ceHu9xlyT3VQ3kL/62L9Wlu2mEQvw2
         tdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DiXcq/4UgFcTWCxFf97aJBO24zkVMbG42o5eatrIo3Q=;
        b=kJ5yb4Tf/D3A2+WN6yVWOKbnxmvDLj7WHdYxShMnGmpnWdk/fJOtT3fVE8w1gkIVSl
         2BgWazWH2vNZvyjqZkYfTgDaeA4dDgdAaNISVgTxJ8XtZ3/uikRQ+nbSy/NpRK4EK5y6
         Rf80PEIXB+TN3ch2knsC25cYdb5BDYq03Rxhc7T+Q1kKSe7BM5pCHrwLE18sT4SSywXx
         n3r1slxB2U8A/69gIWzg6BYkcaokM6emnjLlozGKe1L8LZ7J971yoTNZa1+yIeLV3Kq1
         RQxIsc3UA1ebQZSbzclV5zsj7hU73QYbOzd8B4/0pWCAr2LrMCIWDumhwp0GO2xsT+a5
         funA==
X-Gm-Message-State: AOAM53174vocYKK4qCsGBjSVEMCwzYeOJ+6gCHxB3drji86QstTsvWil
        9I0S8dt8YkSC+JCqkJZ9sKlKQlxBvWZvUpuWM2sBfvHqEG++
X-Google-Smtp-Source: ABdhPJysLrUaxcDZmmczpe7hlJebW7o90Nrn8HvCw1Dg2O/UCpzArwZ1r9PWwXeQlZT2c/NGj7DymJXcciBGdlybN2Q=
X-Received: by 2002:a17:90a:3f0f:: with SMTP id l15mr1252712pjc.190.1603926720253;
 Wed, 28 Oct 2020 16:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201026085141.1179-1-rsalvaterra@gmail.com> <20201027012204.GD2412725@google.com>
 <CALjTZvbf4qK6SHEe7OhkTC_o7kaY4oOKQ+kk-D2OUq_ULsYAqQ@mail.gmail.com>
 <20201028101934.GB48825@google.com> <CALjTZvaTiAS1vMyrTNvrfy7KOjemy+tW5-hbTy5SHYfsbRE=_Q@mail.gmail.com>
 <20201028182158.GA128655@google.com>
In-Reply-To: <20201028182158.GA128655@google.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 28 Oct 2020 23:11:49 +0000
Message-ID: <CALjTZvZQyJb=y=XyUzpefEPL-XpK0gMwMW-+0GF1EUrW8Oapzg@mail.gmail.com>
Subject: Re: [PATCH v3] zram: break the strict dependency from lzo
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, again,

On Wed, 28 Oct 2020 at 18:22, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> Right, but well we also need to select ZSMALLOC and CRYPTO for
> zram to become visible (the thing that I found out recently is
> that you can always check the hidden/blocked items by hitting
> 'z' in menuconfig).

Sure, I can fix that too. Should I do it now, or wait for
Andrew's/Minchan's feedback?
And that 'z' key=E2=80=A6 wow. Did you read the kconfig code? I have no ide=
a
how you found that one out, but it sure deserves to be documented
somewhere, it's too useful to be true.

Thanks,
Rui
