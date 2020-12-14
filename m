Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E872DA352
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgLNWWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbgLNWWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:22:20 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1753C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:21:39 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r24so34250543lfm.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYwULZuE9ZcoNTMzzstOJL9WyUKGToS3upqN4M8b+zg=;
        b=NCghVkIrYyHcpOAJeIJotNe35g/Lkjm4iPEsXbEK25AcdYMqZ/sJy6Tmi3rlKMAEvs
         ek6chRDeTunpRTgKz0GGanP/sp3cB3IvX69AlEAun6ewXv36HnAdtFWqhc0nQluqDzrI
         DIMKfc+tz6rUeozWrM3e0fsOG9X1yag/SeT/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYwULZuE9ZcoNTMzzstOJL9WyUKGToS3upqN4M8b+zg=;
        b=UUfLWc1jMnfp5sPj5+J4hIbvodK/xIJgwi+qnWSkPpiNEqO9y8igB618sx1UOXa2mH
         W5fFso/BiQKnDxAPOiWi5qu9I92u42M0kA+3yS/eAnzaC9bz5O/bUe5Iq/4aV424iZeg
         ZAfCsJMpqq2niP453WR5W1mrT0Aw+WPWwF2Mz/gCmnIxktZEPvPMc3m1U59zAioiEZHe
         inoVDHCWpXnNcPL0nOwiIrllzOIRXREymZGqRjOhCclo+Y26X4VFuVCT4KCF6vfRNnDb
         YA1TFRHCUKliFKUzyZ6qviTMVOo8tQw29w+kf0yGhtKLS8gAwgspnaPMhOFXpCgyJPmA
         5rMQ==
X-Gm-Message-State: AOAM531mShj2Ry0Mly46VT7E4uLA7ZfJjC7YMym2s25vO/xFvPC41TTa
        SBcFJvIRq71GHAdOCblCjlom9X9XRKjjmA==
X-Google-Smtp-Source: ABdhPJwoVX8DPTSS/j5Zql7q2p3okMwVeGY0a+KclJxXBRms0VmVDW2QO1I/1vq2Tn2tNFMxIw+8IQ==
X-Received: by 2002:a05:6512:247:: with SMTP id b7mr3971257lfo.171.1607984498036;
        Mon, 14 Dec 2020 14:21:38 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a19sm2462860ljq.79.2020.12.14.14.21.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 14:21:36 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id m12so34292703lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:21:36 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr10754661lfc.253.1607984496318;
 Mon, 14 Dec 2020 14:21:36 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
In-Reply-To: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Dec 2020 14:21:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjue4aOyQQq+C6SEurwe6XABhMyNtsfn1goU==Hf_QUqA@mail.gmail.com>
Message-ID: <CAHk-=wjue4aOyQQq+C6SEurwe6XABhMyNtsfn1goU==Hf_QUqA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.11-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 7:52 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This is an early pull request for drm for 5.11 merge window. I'm going
> to be out for most of the first week of the merge window so thought
> I'd just preempt things and send this early.

Ok, I've merged this, and Dave is likely gone already, but it _looks_
like there's a problem with the drm tree on my Radeon workstation.

It works fine on my i915 laptop.

The symptoms are that the boot just hangs after

   fb0: switching to amdgpudrmfb from EFI VGA

when on a working kernel the next lines are

  amdgpu 0000:49:00.0: vgaarb: deactivate vga console
  [drm] initializing kernel modesetting (POLARIS10 0x1002:0x67DF
0x1DA2:0xE353 0xE7).
  amdgpu 0000:49:00.0: amdgpu: Trusted Memory Zone (TMZ) feature not supported
  [drm] register mmio base: 0xE1C00000
  [drm] register mmio size: 262144

I'm bisecting for more details, but it might take a while, and I
thought I'd start the ball rolling with this initial report in case
somebody goes "Aahh.., we know about that case already, the fix is
XYZ"...

              Linus
