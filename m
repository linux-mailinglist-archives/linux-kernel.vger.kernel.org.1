Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D4824EF32
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 20:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHWSRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 14:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHWSRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:17:00 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F4AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:17:00 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y26so3005167lfe.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnKpyRAWRyhJsnfjEuUO679mdOG8RFrNfw0DNC4pOc0=;
        b=X1nycomtytoGAhD6s6RaibTAcGAxZPZRkVo3vot8/b9LYGnffAdF1OY82DnLGqqhEp
         HOcbMRaSoHu2hQM8Lv9Y6GefQd6q42MhnMvkFCiA4HRF42frubpc7nNCHZNQ4R4agaza
         FIxpxuqLvauWvIMVnuP6EFyh9PcojPTjAPi3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnKpyRAWRyhJsnfjEuUO679mdOG8RFrNfw0DNC4pOc0=;
        b=R9FMW8sAX749aR1AABN21gVdft8FS340IruHh//fgEAAvtdXco2SrQEsDpmU2VMa+h
         Vqr7LLM1sHzxqeBIbwDesJrNZMYutzvjNL76k7yfssQ7MPVIgduRdx3CZortXBnyxgwa
         PzE9QI6a/QiyspBANZLkpm+3bgfQSOuxi2rJDTPL0EDHLC4ThTZVO3cWKiJPpKq6Bn8f
         5hcp8xbM6YuuBL9P9+E0a5hhUUsvkcsO6vUN9hi8IEPNlJIWg54y1UcXBB02hVus7Skh
         +cJPIW4hqV8+6EK9/ANWojiQf584aoMYz6tHZLdIgD62VKpte0YupgYFX4o/Ym8iw5+v
         NCVg==
X-Gm-Message-State: AOAM531tgAUxBytLx73kBlgMT4udfQ63nEtZdlJmUCl4JvEp3yxw8IqW
        EDW2sRtVfB+FNwxa/xSODoEbJ9vcE/sEVQ==
X-Google-Smtp-Source: ABdhPJxW2B1PMHtsQimpIjoXZkpEP5oMgnJUAOMYv4LynD17ca82Bs7Sv71wJp0Spgc3ArVDVYGTlQ==
X-Received: by 2002:ac2:44d4:: with SMTP id d20mr928937lfm.137.1598206618071;
        Sun, 23 Aug 2020 11:16:58 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id r11sm1723772ljk.46.2020.08.23.11.16.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 11:16:57 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c8so3279054lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 11:16:56 -0700 (PDT)
X-Received: by 2002:ac2:5469:: with SMTP id e9mr954739lfn.125.1598206616565;
 Sun, 23 Aug 2020 11:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <159817113401.5783.14776307451257171431.tglx@nanos> <159817113641.5783.13356693197176111647.tglx@nanos>
In-Reply-To: <159817113641.5783.13356693197176111647.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Aug 2020 11:16:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1PRRxGgEaSf4TWcyja+_rbsmo6qy1d63vS4GfkV_tmA@mail.gmail.com>
Message-ID: <CAHk-=wh1PRRxGgEaSf4TWcyja+_rbsmo6qy1d63vS4GfkV_tmA@mail.gmail.com>
Subject: Re: [GIT pull] perf/urgent for v5.9-rc2
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 1:26 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single update for perf on x86 which ass support for the
> broken down bandwith counters.

Spot the freudian slip..

                   Linus
