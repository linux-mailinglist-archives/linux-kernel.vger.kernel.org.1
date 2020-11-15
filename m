Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEF52B3780
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKOR5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 12:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKOR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 12:57:50 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A57C0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 09:57:49 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id i17so16138359ljd.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o59BZdkVJF2tiujufffJlPZ8vaTkpZCTYRuWU0rId2Q=;
        b=OahrTwfET9qGvsGfM2qZcnSTlFGXDpok0Pv37BGC91uw5hOdQ0MBZCFKkoMi/+jdKb
         xg5FOJAYHxPZAujCc4xW7YooGGtrxA0fXbqESgjc0nV0qclmyBHkKHXcDEm077ZlGMz+
         /3cahwVB7ry5OCnNL4ggJVU6XedTOqajdmRbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o59BZdkVJF2tiujufffJlPZ8vaTkpZCTYRuWU0rId2Q=;
        b=T5thPHaCTd31vNSlEwElp+rliPVFsfJA6nMX1En00Si/lvt31DwjdppTZ7FMRBkJA4
         IM9u9W5nX4vGVsBA9ZOUPbWMDvKtWPoIrzP+26afMF2+c9yolLVw7NusM5lSffR4xJ2d
         UfBoGH5uxuALSTAMmAeBAJrQOvqHcwDVZFzdcHFLwQBWL6zJC/nDoD2GSLIyD1dzr/6b
         CMmAMNVOEA4AIk6XPktDrH9nkUfpA7wZntbh+Ep2Fv5iAsU6bicm5fgkk1QnNFk2pD4C
         4c5py++LlRnfEXaD2RRAPCf1vIHmyxfwimvBV3Vs9SnQmQi+NPn/fq1WmNKX58heIZUt
         PCyw==
X-Gm-Message-State: AOAM530kZu0bJEJF+289Bo0MXgZ7ZiZVTNhDTtIAq80C9pWtjHOJbFBa
        4i+ZcTus3fyuOCCQIDjUQA1Ra5AFH+IXMA==
X-Google-Smtp-Source: ABdhPJzK6ccrsTTGqzK6LhV1MedI49rAecjBgY9CjVQdXTXjtvm9i2IIi/TRFsc1gmAzjpvkd+WVRA==
X-Received: by 2002:a2e:b047:: with SMTP id d7mr5422163ljl.63.1605463067347;
        Sun, 15 Nov 2020 09:57:47 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id e26sm2405411lfb.66.2020.11.15.09.57.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2020 09:57:45 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id e139so2194252lfd.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 09:57:45 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr51360lfc.133.1605463065313;
 Sun, 15 Nov 2020 09:57:45 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9txyMmW1DWhS--SuYQu4qDK1GPzgHJwxbAfhHT=hUsPODA@mail.gmail.com>
 <20201103222013.hypmzlq7uuqufe76@box>
In-Reply-To: <20201103222013.hypmzlq7uuqufe76@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Nov 2020 09:57:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whPqB1PUVCCcQMjm-YTBnTP7UD_ey2rbXzcJhQufJwcUQ@mail.gmail.com>
Message-ID: <CAHk-=whPqB1PUVCCcQMjm-YTBnTP7UD_ey2rbXzcJhQufJwcUQ@mail.gmail.com>
Subject: Re: [git pull] drm next pull for 5.10-rc1
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Airlie <airlied@gmail.com>, Lyude Paul <lyude@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 2:20 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Thu, Oct 15, 2020 at 11:33:08AM +1000, Dave Airlie wrote:
> >       drm/nouveau/kms: Search for encoders' connectors properly
>
> This commit (09838c4efe9a) broke boot for me. These two hunks in
> particular:

Christ. It's been two weeks. I'm doing -rc4 today, and I still don't
have the fix.

The problem seems entirely obvious, as reported by Kirill: the nv50
code unconditionally calls the "atomic_{dis,en}able()" functions, even
when not everybody was converted.

The fix seems to be to either just do the conversion of the remaining
cases (which looks like just adding an argument to the remaining
functions, and using that for the "atomic" callback), or the trivial
suggestion by Kirill from two weeks ago:

> I hacked up patch to use help->disable/help->enable if atomic_ versions
> are NULL. It worked.

Kirill, since the nouveau people aren't fixing this, can you just send
me your tested patch?

Lyude/Ben - let me just say that I think this is all a huge disgrace.

You had a problem report with a bisected commit, a suggested fix, and
two weeks later there's absolutely _nothing_.

              Linus
