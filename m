Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B8A29AC71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900252AbgJ0Msc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900244AbgJ0Msc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:48:32 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AC00207E8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603802911;
        bh=DY2M/JF8u8++vvY33r9aVEi8JqabvE0ZfMMQQVGhmcY=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=2ZcFMUM3nrTTaQ0d5lbsywi1WRvwoEDYPaA8GBC/U5gzO+fIVEUrM5oNHdsCFv0pA
         ww/GiXUvt81+VEjYhHo8cowIGzz+zKh4OraEeH7z5/4DctGD+AC+iukoNtfOc/Amwg
         jMmTSbIRUXDQWe57h2fVa02hvV5HkRyctPOPaS6c=
Received: by mail-qk1-f181.google.com with SMTP id 188so932781qkk.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:48:31 -0700 (PDT)
X-Gm-Message-State: AOAM531fJ/Nofxtvo0rLtejrSVemC4/jVc86LvOp+qWRnzeNHoeB0sM4
        Sj66abtAQmXRsuTSP8q+7lFfXa6Xxds217HG8a8=
X-Google-Smtp-Source: ABdhPJzwxHTf7owunGVAIo5uhnAazdm93JgL31Odcz4o000UCLcRrbObDpjq7Fu0pxkKcUGAYIwM7AY4//1Wp6iswsw=
X-Received: by 2002:a05:620a:22c9:: with SMTP id o9mr1954826qki.286.1603802910461;
 Tue, 27 Oct 2020 05:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201026215138.3893732-1-arnd@kernel.org> <20201027001316.GA27589@workstation>
In-Reply-To: <20201027001316.GA27589@workstation>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 13:48:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0r0Yy2TWv6gWPUW9rJVuBC9oPAbQgsNQL3TBm+UYrW5Q@mail.gmail.com>
Message-ID: <CAK8P3a0r0Yy2TWv6gWPUW9rJVuBC9oPAbQgsNQL3TBm+UYrW5Q@mail.gmail.com>
Subject: Re: [PATCH] firewire: fix function type cast warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        linux1394-devel@lists.sourceforge.net,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        oscar.carter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:13 AM Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> On Mon, Oct 26, 2020 at 10:51:27PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > gcc -Wextra complains about a suspicious cast:
> >
> > rivers/firewire/core-cdev.c:985:8: warning: cast between incompatible f=
unction types from =E2=80=98void (*)(struct fw_iso_context *, dma_addr_t,  =
void *)=E2=80=99 {aka =E2=80=98void (*)(struct fw_iso_context *, long long =
unsigned int,  void *)=E2=80=99} to =E2=80=98void (*)(struct fw_iso_context=
 *, u32,  size_t,  void *, void *)=E2=80=99 {aka =E2=80=98void (*)(struct f=
w_iso_context *, unsigned int,  long unsigned int,  void *, void *)=E2=80=
=99} [-Wcast-function-type]
> >
> > The behavior is correct in the end, but this is more clearly
> > expressed using a transparent union.
> >
> > Fixes: 872e330e3880 ("firewire: add isochronous multichannel reception"=
)
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/firewire/core-cdev.c |  6 +++---
> >  drivers/firewire/core-iso.c  |  2 +-
> >  include/linux/firewire.h     | 17 ++++++++---------
> >  3 files changed, 12 insertions(+), 13 deletions(-)
>
> Oscar Carter has posted a patch to fix it.
> https://sourceforge.net/p/linux1394/mailman/message/37024966/
>
> I don't know exactly but maintainers seems to overlook it...

Right, that seems fairly similar to my version but avoids the GNU
extension, so it would be better that version.

       Arnd
