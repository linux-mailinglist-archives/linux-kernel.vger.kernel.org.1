Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E11302C49
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbhAYUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbhAYUJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:09:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09632C061756
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:08:21 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p21so14548641lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZeZ/z6nzSFDAV4wLoLwt3dt0tgNMo3emIxIkq4fN40k=;
        b=dl6sqhW2bwwla8KTDatqSOETpc6qOuFiO3hNwqxSjZlozYGXOAn8S8pKuRSZgdbIXp
         POEGbzNrH3AeLjGmkGcts9CBVMpkfEYtlKBuvv48tyzXoZm2uRU5b8e2a3RPN6zJwhmy
         9lXpQzQsohkefQjrRZ2Ac2GnaYPrr6azWKAJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZeZ/z6nzSFDAV4wLoLwt3dt0tgNMo3emIxIkq4fN40k=;
        b=OB1bZwoU0RLD+3BfERMhmEi3OpYJY8FxtY3Jt+EwcGgl7fG4ArHrQGdlib1QRM2jSD
         AvkUe7x1qNJAvVWdbJysJxOYV85VfxzKh3KQ92pX9c8LezR0qF31HqJoO97qMa872s8r
         iFnck791MzjplNrTrG+eiS4X8XdUWDnCm/H1iT21I3zESYHcWejn7D/s6l/R18Y6Vyr1
         O2dmzFHE/AnchS+ecL8THFXMLF7DipaTX57lJ0g3sYgXf10cfDbE+hKHuB+sAk2oSViw
         q+WtJI9aIn5IX7maSQrGcroGOo+8diwink1lDtywfoPn2EA6pyRHpMvDUBMXgyXsckR8
         0aeg==
X-Gm-Message-State: AOAM5314Hsvo4m4qwKi38I01KX4L2ew+kZ9cUlVjhdE0fzKklwIvSD5i
        k2G/oJrhMxpTBxZi8Ym7ry1mlj2BpLEAAw==
X-Google-Smtp-Source: ABdhPJySun2hSPjHGCPPLIy4eqEMR8N3Eb4l3X6QIy7QUnUxWewJEXj6ysaYpk01w9AkzwYkJFmb7g==
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr983985lft.639.1611605299277;
        Mon, 25 Jan 2021 12:08:19 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a16sm570600lfd.59.2021.01.25.12.08.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 12:08:18 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id f17so16873225ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:08:18 -0800 (PST)
X-Received: by 2002:a2e:860f:: with SMTP id a15mr977159lji.411.1611605298101;
 Mon, 25 Jan 2021 12:08:18 -0800 (PST)
MIME-Version: 1.0
References: <20210125190925.3655829-1-samitolvanen@google.com>
 <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com>
 <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com> <CABCJKucWV3V10KRiHN+Oph-nffrBmo6Sc6+jAKJasQ8wFekRJw@mail.gmail.com>
In-Reply-To: <CABCJKucWV3V10KRiHN+Oph-nffrBmo6Sc6+jAKJasQ8wFekRJw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jan 2021 12:08:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiScU+tS8ZSL2-gpuKB5Z-XKLOGkF8WW=bL-8t_KSqxFg@mail.gmail.com>
Message-ID: <CAHk-=wiScU+tS8ZSL2-gpuKB5Z-XKLOGkF8WW=bL-8t_KSqxFg@mail.gmail.com>
Subject: Re: [PATCH] n_tty: fix redirected_tty_write checks after write_iter conversion
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:03 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Neither, I noticed this because the conflicting function declarations
> broke Clang's Control Flow Integrity checking.

Ahh, interesting. Is that automated somewhere, or are you running your
own special checks? It sounds like a useful thing.

I was thinking that maybe I should make some sparse-based cross-file
checker, but it sounds like -fsanitize=cfi (or whatever it is you do)
catches it.

              Linus
