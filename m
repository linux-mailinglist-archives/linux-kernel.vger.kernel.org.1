Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C551299667
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1791418AbgJZTD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1781699AbgJZTD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:03:57 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C81B420790
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603739037;
        bh=qwnoRCo1R4RfJLgUjcT/fdMEYl7CJRbP6ocAzrkNLc8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MgUhgfSgdtw/dkwD+e8pHlzGqwXBQdVDIIaELNdCvhxKk8wpo7ikZASYsmdz4v166
         bKVneTYzkYXnHXqxQUh/KvzsIdhKMukDu/badg4jZPf1U8AC031dgVbhctk2jrb9Sd
         0GTpdmy7aCzeRMLCawEuurS/tsWnsGHuKqhtyD/E=
Received: by mail-qk1-f182.google.com with SMTP id 140so9426365qko.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 12:03:56 -0700 (PDT)
X-Gm-Message-State: AOAM530zr5vTPCbehgvbWSvm2C1YIyEPUbnzkQLvirzbdOSiQeH79Uqq
        kuEU6K51Jgak0SXx1s/wVL3flPjj0kXf7ePAJxg=
X-Google-Smtp-Source: ABdhPJw6BBoPGjGlIDtQwuPEhCx7xKTVaToDIWOa6kzLyFFyrrXvnTRFloxWvctqCe7Wkj7ht0lbN1hIjBMZuLAo7ok=
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr2593705qki.286.1603739035860;
 Mon, 26 Oct 2020 12:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201026165715.3723704-1-arnd@kernel.org> <s5h4kmg537s.wl-tiwai@suse.de>
In-Reply-To: <s5h4kmg537s.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 26 Oct 2020 20:03:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2kdNuipus=_Jr=Scd5_E+68LDi4zxPLqrT05ffXzD7Xg@mail.gmail.com>
Message-ID: <CAK8P3a2kdNuipus=_Jr=Scd5_E+68LDi4zxPLqrT05ffXzD7Xg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: make snd_kcontrol_new name a normal string
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 6:03 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 26 Oct 2020 17:52:18 +0100,
> Arnd Bergmann wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When building with W=2, there are lots of warnings about the
> > snd_kcontrol_new name field being an array of 'unsigned char'
> > but initialized to a string:
> >
> > include/sound/soc.h:93:48: warning: pointer targets in initialization of 'const unsigned char *' from 'char *' differ in signedness [-Wpointer-sign]
> >
> > Make it a regular 'char *' to avoid flooding the build log with this.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I'm fine to apply this, but I thought we agreed to ignore pointer
> signedness intentionally?  There are lots of such places and we were
> fed up in the past when gcc complained a lot about those...

I'm only sending fixes for the ones in headers that get included in
a lot of places. There are good reasons for building being able to
build specific drivers or directories with W=2, but it's less helpful
if there are many identical warnings.

       Arnd
