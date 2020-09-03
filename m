Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6092B25C87F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 20:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgICSJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 14:09:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICSJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:09:57 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD8620897
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 18:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599156596;
        bh=C205CcD2VMokdGZjSxLWCsMnO75Vt3J45rWeFtKx3hI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PQaovMUzZbWYge6mtMiQjs2m35YJx+Sg2GZEtzwTsJOgacaJ2siFqDqlc/HIojZcQ
         vnfieCoz5B/S9Nl7TH7HZfUMQJ4tlpLWo5tWf7QaHQHWRbPYJafyaDVb/L2hxLcjxy
         7mrx9QjEmenoJzBYbNMF+f3kf2L3V2sjDatZYbM8=
Received: by mail-oi1-f172.google.com with SMTP id 3so4062255oih.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 11:09:56 -0700 (PDT)
X-Gm-Message-State: AOAM532sFldFuBzhk7mVzW3r1e8PncR/1AThWtF8M7GBqg72m22NXTCl
        wlcVus9nW5sXR0dw+c58G1JdY/7oTRakmvlChA==
X-Google-Smtp-Source: ABdhPJxbJUP+v1gxch8C88CmupX09cupl71i5yZp4zfl8RJ4crTNUzLVK/ZUX4wOvujQLI06NssfJaLU9JGoFhESGuo=
X-Received: by 2002:aca:1711:: with SMTP id j17mr2901843oii.152.1599156595613;
 Thu, 03 Sep 2020 11:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599072725.git.nachukannan@gmail.com> <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
In-Reply-To: <CAEXW_YSt49yGH+Wc63zfm4i7n1M_YxETbAA8nxmfDH1B3WFQXg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 3 Sep 2020 12:09:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
Message-ID: <CAL_JsqK7QRgCcD01MfVermvTGgLPj8KC412kxSQg2zsp_46fgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Trace events to pstore
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nachammai Karuppiah <nachukannan@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Brian Norris <computersforpeace@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 3:47 PM Joel Fernandes <joel@joelfernandes.org> wrot=
e:
>
> On Wed, Sep 2, 2020 at 4:01 PM Nachammai Karuppiah
> <nachukannan@gmail.com> wrote:
> >
> > Hi,
> >
> > This patch series adds support to store trace events in pstore.
> >
> > Storing trace entries in persistent RAM would help in understanding wha=
t
> > happened just before the system went down. The trace events that led to=
 the
> > crash can be retrieved from the pstore after a warm reboot. This will h=
elp
> > debug what happened before machine=E2=80=99s last breath. This has to b=
e done in a
> > scalable way so that tracing a live system does not impact the performa=
nce
> > of the system.
>
> Just to add, Nachammai was my intern in the recent outreachy program
> and we designed together a way for trace events to be written to
> pstore backed memory directory instead of regular memory. The basic
> idea is to allocate frace's ring buffer on pstore memory and have it
> right there. Then recover it on reboot. Nachammai wrote the code with
> some guidance :) . I talked to Steve as well in the past about the
> basic of idea of this. Steve is on vacation this week though.

ramoops is already the RAM backend for pstore and ramoops already has
an ftrace region defined. What am I missing?

From a DT standpoint, we already have a reserved persistent RAM
binding too. There's already too much kernel specifics on how it is
used, we don't need more of that in DT. We're not going to add another
separate region (actually, you can have as many regions defined as you
want. They will just all be 'ramoops' compatible).

Rob
