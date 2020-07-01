Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE96B210A85
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 13:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgGALuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 07:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbgGALuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:50:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF5C061755;
        Wed,  1 Jul 2020 04:50:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so24632288iow.7;
        Wed, 01 Jul 2020 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3SjamrzdoV6Lv6LSu8QDEuogUTexcNLV7u7c76k39o=;
        b=kWzFUXW1roeS6p+g8N3Atsru7ku5HSZorvbDmNovwAnCI61CDlJ6EOQjIJjyXUpdAx
         DZonXot2tbbyz6HJn0+oOYCsc8LCP+yhkfUtWfiX5DbeC5WE3Yv8ML6kK4o1517u5zqW
         5Akhs/ADyCB4RrUUeUFaZEhnKJrmjNDl2mnVUBf18PiuNUNwF8yMx7LVampxUj5xzvr+
         mLwxQ+1j2P/7bX4EjXGCKnml3XyE2PYDS/oX9OxrPZmSBg66lpw+5x9sT+5ajZlNC00j
         bTh8B+4tiaRlzWqdeROwfnT928UC04IuKMUhdN+FUEvyXeNeizMMtth4n9SJMbBS8fmC
         FeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3SjamrzdoV6Lv6LSu8QDEuogUTexcNLV7u7c76k39o=;
        b=Cy2O+uRH+EHSe/d2YhIMvfstwO+1cy1Uq1knmVN9CUtrWQvQT26A21d4wXDEIxclWv
         NFJkX8QnifebRIf9tw1pqc0w114af0guDmNs/4ZaQl/DNMZxPkZYOSiko6cU9pMkAk3j
         6FjpehCDIyp1MxfrfcYKCOrT/dPXS7GmibV/uNf2Yxldwh6meYqpRc64cSZI9I44aNRv
         LbNFKBjGIw76u6ci9LmPOWZAFiqhr1wrVPc+ZcTD/BX0USegSNBnFU5RDAICkgUVuMhy
         VXpUsmMqVg1GcCla0ymbr6+varIFR7WzQWxIl1kB+PcKh98my75FSflJk99nGDl3h1n8
         U1TQ==
X-Gm-Message-State: AOAM531iM2GYJY0Vzq1QAMssB9jTCs0Z2huwr/f+GeHK+BCfPeEjNtTm
        Zw27ZlY/XRRhU2LeHToKB325Pey0ZYnQ+vwQE+C8TgbdVo0=
X-Google-Smtp-Source: ABdhPJzhtZ8mM3w5oWh/BhpF2GLYh2CSXejsz4TxFbKoSv6c3fByKszUtn3YvCPF2b6DQiioNW8m5+bhdl2yRnnYFNE=
X-Received: by 2002:a02:30c4:: with SMTP id q187mr27362747jaq.102.1593604213494;
 Wed, 01 Jul 2020 04:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200201161931.29665-1-lukas.bulwahn@gmail.com>
 <20200201131453.32018229@gandalf.local.home> <20200201190222.GC13359@kernel.org>
In-Reply-To: <20200201190222.GC13359@kernel.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 1 Jul 2020 13:50:02 +0200
Message-ID: <CAKXUXMzfnVw_SMbuO7z=+M0LS3kv92Aqw5ZkKZEEK9BwnFQCsQ@mail.gmail.com>
Subject: Re: [PATCH RFC] MAINTAINERS: add TRACE EVENT LIBRARY section
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        linux-trace-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 1, 2020 at 8:02 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Sat, Feb 01, 2020 at 01:14:53PM -0500, Steven Rostedt escreveu:
> > On Sat,  1 Feb 2020 17:19:31 +0100
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > > The git history shows that the files under ./tools/lib/traceevent/ are
> > > being developed and maintained by Tzetomir Stoyanov and Steven Rostedt
> > > and are discussed on the linux-trace-devel list.
> > >
> > > Add a suitable section in MAINTAINERS for patches to reach them.
> > >
> > > This was identified with a small script that finds all files only
> > > belonging to "THE REST" according to the current MAINTAINERS file, and I
> > > acted upon its output.
> >
> > Thanks Lukas!
> >
> > Arnaldo, would you like to take this?
> >
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> Sure
>

Arnaldo, I think you never picked this patch and it did not make it
into mainline. I checked that the patch still applies to the current
master, so maybe you can pick it now. It is a minor non-urgent patch
and cannot break any builds :)

Thanks,

Lukas
