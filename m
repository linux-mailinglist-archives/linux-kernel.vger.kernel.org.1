Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC8249299
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 03:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHSB7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 21:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgHSB7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:59:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A75C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 18:59:46 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 185so23566983ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 18:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9exB8ZTcwLia2sz4SxcTMYrc7X+fUZoixqks6xkGbbw=;
        b=fhXX37S2dWTvZf3nyXGAek5Bh0VxvSnrhtiQ42Ig6uY1fIm1pe5CuLtSHIT3/GqQUa
         qFS8b+fxDiqwWgdHAgskDCpLTsKT0JY7EFGtwJ5rgV34b4dwVX8iUfYOgLUknC19IzWF
         2fMEsc3wskb3M4IdaNpMXE055qvEM3iUQLU+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9exB8ZTcwLia2sz4SxcTMYrc7X+fUZoixqks6xkGbbw=;
        b=rc2OJz1TTGVEZlZ9b8LERy0c6306QldxlBzOn5hXcaeRcgN64BJmrqLgstAQ7s5BU0
         TeiVe62t4yTIXsvitSxprUBqiNeg38wD7iOsxs0gfx7Ezi0E2VVBCeBVNcVIISbnqz/P
         eDw3UdiZyL4T9HoIOb/6AtBRC3OV5TzIR1D6+t+MBB/M/D7W8lBY7LRZ8pobPPifxpOf
         4rKzh2f4cZeQ4J41ZC7uZjLnuTPvFUge66pcKBTFwbJvGcEgbhFsDNhPOfTXLzCEDY+B
         1FGAYvrFsaPyI8GtfpUbXgoQH09tBDz3ZquO7cWFNg6aAf7MRBbUuUbgsnz0F5n8QjBF
         kV1w==
X-Gm-Message-State: AOAM531tssxOh8LUzUtGweWbe8YAYGqxBarP7iDK0HelOQSGrM4muo55
        NeYRGBzkYfK51BmGZK57d9TBSNnH5OIYsA==
X-Google-Smtp-Source: ABdhPJyMCEf9ZrMCXOTawfHQPNw+JuR8ks5ujNtd4Wzube5NMp3Yow4jEqD9bH93SnwHX4mKMKOElw==
X-Received: by 2002:a2e:5852:: with SMTP id x18mr10323150ljd.132.1597802384780;
        Tue, 18 Aug 2020 18:59:44 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m20sm7004814lfb.72.2020.08.18.18.59.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 18:59:44 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 185so23566941ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 18:59:43 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr10334797ljc.371.1597802383309;
 Tue, 18 Aug 2020 18:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200817161132.GA4711@amd> <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
In-Reply-To: <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 18:59:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
Message-ID: <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to mainline
To:     Dave Airlie <airlied@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pavel Machek <pavel@ucw.cz>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 6:13 PM Dave Airlie <airlied@gmail.com> wrote:
>
> I think there's been some discussion about reverting that change for
> other reasons, but it's quite likely the culprit.

Hmm. It reverts cleanly, but the end result doesn't work, because of
other changes.

Reverting all of

   763fedd6a216 ("drm/i915: Remove i915_gem_object_get_dirty_page()")
   7ac2d2536dfa ("drm/i915/gem: Delete unused code")
   9e0f9464e2ab ("drm/i915/gem: Async GPU relocations only")

seems to at least build.

Pavel, does doing those three reverts make things work for you?

               Linus
