Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F103D295436
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506196AbgJUVaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506187AbgJUVaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:30:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DEAC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:30:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c21so4098521ljn.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvkMHt0GAbtDgYL3KpRFDq4C21jdunTAygdT94qSi7A=;
        b=Dko0txgSagp+xh1KY3V9M20nfT+Ux1+GvS1ca+e7GijiKd+tbKZZ7XS9fO2QpJqo0M
         EX6+XbCePy1uh2WxKsL379jsVE0xbwQB1wWt4fhdI94P+5qSaD9bUtFZnrS9mZjep7Pl
         aseeZQdGBykLEPklS+WhF42lA8p5QXmBbo7E4TRX/uxHahdOeFbe8OIahCvDmkhkGkST
         5qEeo9Hy657JKP5z1d2ni4ceFb2hcMk0EZE0iVLugRPdy1AVfv4PWwp2wM8ZnowJkm4o
         TBQ3JzCcCTkVb6T2cnHsr1aGElwo2z2P7miTXBxO9igKorBT+RgEBAba6QxNfkMWqO03
         ZUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvkMHt0GAbtDgYL3KpRFDq4C21jdunTAygdT94qSi7A=;
        b=TwVQKuE05+eLPiUkFll8InE8lLchG2Su1m9jVW7krXmiaW2ZWPIvk53A5XLzFgK0cq
         DEit0neBrqNcyKGC2puYWxGV8jLgtBOFA/efBMDA6gCajZVdmNDIxO6ZD2qxOfVLWvsg
         ynOTGh1UChslBAvFzDXoHH7Y7M9PXzABTV/7LhVZQYjwwyuWu9F6jNGrhEq/1g44cRyE
         b7WLyt8gIMze1h7oe5W3KqXGlHN9wnje4EafBXXWWCtCjuWHy4nI8+nBSaxurJXeR16r
         Hx+poFFvaPISuSWjq3/2PL24w4KwJT/U1dDzKWp9oV2K1xY3ywhzJiOP+VoOylfQZjpO
         8snw==
X-Gm-Message-State: AOAM533U8iDc7zo3rBgpD7AYbpBkc5Rdnef9AYPaYHW1CiFHMeq5KTiu
        IKzmsav7oc9Zy4tJ1UplVHpdPmdHKScntwJ6mokG4Q==
X-Google-Smtp-Source: ABdhPJxVg4C8vJ1STalwkyI39fP21TgMa+uha1pRFAzyGxRsheqtH1EdcHfBQrzZlr7jTDyUXRDhDiL4TiUlaXspspU=
X-Received: by 2002:a2e:9789:: with SMTP id y9mr2111004lji.456.1603315803692;
 Wed, 21 Oct 2020 14:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201020073740.29081-1-geert@linux-m68k.org> <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
In-Reply-To: <CAFd5g44dGaKyDQGPeanE1G8MPzVdVkqbWjJhj+nQJGUgkezz9g@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 22 Oct 2020 05:29:49 +0800
Message-ID: <CABVgOSmRbZqDw83f1Z14nSSVQTeFOvyehXhB=NnbaaANrwe=FQ@mail.gmail.com>
Subject: Re: [PATCH] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS instead of
 selecting it
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        linux-ext4@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 5:15 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Oct 20, 2020 at 12:37 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
> > user may not want to enable.  Fix this by making the test depend on
> > EXT4_FS instead.
> >
> > Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> If I remember correctly, having EXT4_KUNIT_TESTS select EXT4_FS was
> something that Ted specifically requested, but I don't have any strong
> feelings on it either way.

For what it's worth, the upcoming FAT filesystem tests[1] are also
select-ing FAT_FS at the moment, so if this changes here, I'll likely
update it there as well.

-- David

[1]: https://lore.kernel.org/linux-kselftest/20201021061713.1545931-1-davidgow@google.com/T/#u
