Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3068D2E3331
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 00:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgL0XQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 18:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgL0XQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 18:16:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A87C061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 15:15:08 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o17so20397069lfg.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 15:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrNOaQo0oSTN20/mx1QqDm0D9Hn4DJtx5m8uXXKpN2M=;
        b=XshKrP2k0PDVU2K6lhXixd1gTp8qTDNhDlzphLGpgfbe84tNYj8XD7eF8JA2/BhefG
         oZ8CeBrJBey0Pe9KTSPuFpO/Kxn8QJTrkjk0Lk3N3/Aminrcw8fb7ZPcYBhYOh8xpxyM
         bKSOKbZhJErLVNxbS7swBwPc48F3MTRdNyekI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrNOaQo0oSTN20/mx1QqDm0D9Hn4DJtx5m8uXXKpN2M=;
        b=sGLSdQv8v2rBKTsH8quT8amZxO2pGWQZ5/qmsWUp9aXir20uTetLj6yjV20hjHcbxR
         fw0dSR4QXwGsmI+PnlNmNiLDy9jgOnnX8ZkSMW6eTzMJyFFMkNNTG/CK4Lhn9Gqp8YDH
         6u2kqA/56nJbPMCazHG14mBtNK747Sv5Kf52l6z4iy6fGpXdFMRg1r831MqpMDliB8xs
         eJ+gUGjvp8zQ5zPjtKMg6HKUfXgfKkCQ1qr+xwbkMSORhJtSamdbdDqE5QUkbpmhRQu1
         PRFgGlvPOSjfoPifyEzTcCWyDZAWaqkpQpFi/Sa+OgpnW6ATc1G7YyRTNKNCqsx5Qn1Z
         zgrQ==
X-Gm-Message-State: AOAM531H8L6LFXWAYPNg4JZAgg9/3hd3PIy01ProiCLudZzozYT5Jlyk
        qja9GFq60MDvvVHZ2VYPPil9mhfSSuU7fA==
X-Google-Smtp-Source: ABdhPJzDLev8EO+wUbCbXvsFb+G6/mhO4zEZIE/nAY7mY+ff1qaREgK3ay7UhaXqX/MvJ8qDXFzL7g==
X-Received: by 2002:a2e:850a:: with SMTP id j10mr20510956lji.265.1609110906667;
        Sun, 27 Dec 2020 15:15:06 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id c7sm5151907lfm.262.2020.12.27.15.15.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 15:15:05 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id x20so20309785lfe.12
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 15:15:05 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr19658039lji.48.1609110905217;
 Sun, 27 Dec 2020 15:15:05 -0800 (PST)
MIME-Version: 1.0
References: <16089960203931@kroah.com> <5ab86253-7703-e892-52b7-e6a8af579822@iki.fi>
 <CAHk-=wgtU5+7jPuPtDEpwhTuUUkA3CBN=V92Jg0Ag0=3LhfKqA@mail.gmail.com>
 <b45f1065-2da9-08c0-26f2-e5b69e780bc6@iki.fi> <CAHk-=wgy6NQrTMwiEWpHUPvW-nfgX7XrBrsxQ6TkRy6NasSFQg@mail.gmail.com>
 <CAHk-=whF=+EzrxP=3zNMH-1L2Nfs7fNoSufqDwOdRQo5qyMwfw@mail.gmail.com> <20201227212531.GD3579531@ZenIV.linux.org.uk>
In-Reply-To: <20201227212531.GD3579531@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Dec 2020 15:14:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXQVE_jGN0ajk+Km925WSbCL16mAZ-UXNkp+nkc1nuQw@mail.gmail.com>
Message-ID: <CAHk-=wiXQVE_jGN0ajk+Km925WSbCL16mAZ-UXNkp+nkc1nuQw@mail.gmail.com>
Subject: Re: LXC broken with 5.10-stable?, ok with 5.9-stable (Re: Linux 5.10.3)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 1:25 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>
> Is there any point in not doing the same (scripted, obviously) for
> all instances with .read == seq_read?  IIRC, Christoph even posted
> something along those lines, but it went nowhere for some reason...

I'd rather limit splice (and kernel_read too, for that matter) as much
as possible. It was a mistake originally to allow it everywhere, and
it's come back to bite us.

So I'd rather have people notice these odd corner cases and get them
fixed one by one than just say "anything goes".

There's hopefully not any actually left anyway...

                  Linus
