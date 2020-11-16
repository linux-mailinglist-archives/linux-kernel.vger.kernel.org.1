Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB7B2B4F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 19:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbgKPSaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 13:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388273AbgKPSaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 13:30:05 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9BDC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 10:30:05 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id r17so21247323ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 10:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4q00/4HCGLR/iCG4K4CGo+PKhMPiOw+iZFy1Ah2DnQ=;
        b=PEvHY4Bxv6j8WmTEV/E3ok0hIg+K81VoR9ldIw9njmSiHsmf+pvg90ZJoTegE4/zvJ
         Sa8WAsF0xD1GGQ4j4Tlz66oAcUD1K3q4tF29NbHUWDBvid7U0ADnPETtarOyU5rakLGw
         LTXtedzkNb3Bn/uMsyxZ76Awy+eb7rO5Uq6Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4q00/4HCGLR/iCG4K4CGo+PKhMPiOw+iZFy1Ah2DnQ=;
        b=rZSHdiWPcUJbLsRRjbEtx89F1U1XDmn/tpe51yzNzn6gg3cvZ9/YsKXC3Q0Cmfl5ME
         jqze7JO7cJZlkHn4NfnNFRcuJA3YwBO4rggxlw8yxDhI9DSbHJofKdmwL4OyRS1fUxRK
         o+daGKYyHdcCmhZKpvm9OV3SNWM/GF9r6j619MV3lSD/9/3tPsb7xb5e9Dtz0rTjR1EO
         Q7BxcVIKjrLYQyk9qI7oiQq6WQUSlwCvwOIPEsviE7zhNlV5WA5CvvXLPY5QxzIBbgwk
         XpC7F3PXQyvy0cSuag+41Z6dKTUEQuid2O+ekL1x46SaZIhiHvnQ8OLTzf3ifh4cya++
         yxYw==
X-Gm-Message-State: AOAM530ZiqTUHRmxqdSnxwxQ63FPT1kK5kn6wxbR7hRf51YQvpP+9xbn
        EeP19i53wz8uQl5eqdtk6iuKiwaBpjo8NQ==
X-Google-Smtp-Source: ABdhPJyE4fNe4S82ZJZssdz7oCVHLu1U26lYKLfF2UHgMMSe5vpjDn9gL5M5uJFnc9ygMMK2zJcVeQ==
X-Received: by 2002:a2e:9ec6:: with SMTP id h6mr241092ljk.157.1605551403695;
        Mon, 16 Nov 2020 10:30:03 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id x25sm2805663lfe.262.2020.11.16.10.30.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 10:30:02 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id b17so21231275ljf.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 10:30:02 -0800 (PST)
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr281207ljj.312.1605551401726;
 Mon, 16 Nov 2020 10:30:01 -0800 (PST)
MIME-Version: 1.0
References: <160554375807.96595.16142008590130221699.stgit@devnote2> <160554376709.96595.14400301252651907015.stgit@devnote2>
In-Reply-To: <160554376709.96595.14400301252651907015.stgit@devnote2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 10:29:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj-eXNoAXmtsr3hiLWsJffVpi9sOzy6W-gQwqAqbDBv5A@mail.gmail.com>
Message-ID: <CAHk-=wj-eXNoAXmtsr3hiLWsJffVpi9sOzy6W-gQwqAqbDBv5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tools/bootconfig: Align the bootconfig applied
 initrd image size to 4
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 8:22 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
>         /* TODO: Ensure the @path is initramfs/initrd image */
> -       ret = write(fd, data, size + 8);
> +       ret = write(fd, data, size);
>         if (ret < 0) {
>                 pr_err("Failed to apply a boot config: %d\n", ret);

Side note: that's not the right error check for a write() call.

The problem predates your patch, so it's independent, I just noticed
as I looked at it.

The right error check is

        if (ret != size) {

because partial writes can happen even with regular files (yeah, it's
not POSIX, but NFS is a thing).

And the filesystem filling up is a possibility too, of course.

> +               /* Write padding null characters */
> +               ret = write(fd, padbuf, pad);
> +               if (ret < 0) {
...
> +       ret = write(fd, &size, sizeof(u32));
> +       ret = write(fd, &csum, sizeof(u32));

Those two guys don't check at all...

>         /* Write a magic word of the bootconfig */
>         ret = write(fd, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
>         if (ret < 0) {

.. and same comment.

Anyway, I'm not sure this is worth worrying about - even on NFS the
partial IO thing is basically non-existent.

But the filesystem full (or file size limit, or whatever) case is real
even on POSIX filesystems, and testing for write errors by checking
for a negative return is simply incorrect.

Partial writes are an issue (although the _next_ write will then
return an error, so you have to be unlucky to hit that partial write
on the very last write() that you do and that you test the return
value incorrectly).

The fact that it works in all normal circumstances just means that
these kinds of bugs tend to stay around, until somebody is really
unlocky and then you have inexplicably corrupt files..

                 Linus
