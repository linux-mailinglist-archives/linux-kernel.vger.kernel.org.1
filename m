Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F222EF857
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbhAHTnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbhAHTnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:43:39 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D9CC061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:42:58 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m25so25533512lfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zyk0hmvOCmlf96OHjavNOOWZKXPdqm3y4uCVwGOPVVs=;
        b=Twey0HfDIE2MlqEURpSvHVkJLmkrIAf1QsDiId4VmSGRbgzqVpRXfv4JuljsdpWkY2
         hBMh8AEu5reKfgO15Ne6WbVrqrp5hlLzOCuW0IwkjDbpEB4eLNTnEZXOtFjRixzY+rgU
         5G8AG5Ypo8vvd+q3R6RgzYd1DGcjDChC5vVF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zyk0hmvOCmlf96OHjavNOOWZKXPdqm3y4uCVwGOPVVs=;
        b=L/eOPKwmpyQAau32rj6XiKD8Hs23fGEYXmbc52vy+HRXi/2TDLQ6jYgbnJZE57Z7+Z
         VYtqzMa2QCGlKfBqWMLKAkaYezxdvSxvyg7sUcnk1dSBLaFtfpAclz5S+VLP/D9VoA2I
         LSpn5r72b5efpUDt10+0DrcOE9GDeYXDj03OuZJXyq9At8q4xoD3+Oj2yZ/KqEmXi7Ch
         rQ7ErHRkyp1IAEyBEAQ6WR4BViecnPr5Hm/pdPwavrfzquP9wmQRlHGRzFKsM9Bi/Hqv
         W49YwpQnjfFhWp8bbp09DT6GF7dgQ+CNG+2Ut3lH7Ee7yhrjWGGdBZ+BP/QDfpXw3Emn
         sCCw==
X-Gm-Message-State: AOAM530okOdhWxNHb0NBfcv//7GqKBAEsI/+xQdvryfLOQoTOokBjx99
        y62x/jzFhD006irmdbU1/Ep/1UMxBvpFSw==
X-Google-Smtp-Source: ABdhPJxDcRCXf23itER4wwwBtGls+7/3WPGDzDkmRHAMjT4+ROXTpf3sT7jOgvlF7rLSi+OJ64llKw==
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr2133456lfq.585.1610134976489;
        Fri, 08 Jan 2021 11:42:56 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id y13sm2076496lfg.189.2021.01.08.11.42.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 11:42:55 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id o13so25709255lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:42:55 -0800 (PST)
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr2233926ljc.411.1610134974839;
 Fri, 08 Jan 2021 11:42:54 -0800 (PST)
MIME-Version: 1.0
References: <20210108171517.5290-1-will@kernel.org> <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
In-Reply-To: <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 11:42:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=6=7qYKL0RLbzg4vKnT0v_c66n8RYS-CvmUxnO9MxPw@mail.gmail.com>
Message-ID: <CAHk-=wh=6=7qYKL0RLbzg4vKnT0v_c66n8RYS-CvmUxnO9MxPw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 11:34 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, I think that's a side effect of "now the code really makes a lot
> more sense". Your subsequent patches 2-3 certainly are much simpler
> now

On that note - they could be simpler still if this was just done
entirely unconditionally..

I'm taking your word for "it makes sense", but when you say

  On CPUs with hardware AF/DBM, initialising prefaulted PTEs as 'old'
  improves vmscan behaviour and does not appear to introduce any overhead.

in the description for patch 3, it makes me wonder how noticeable the
overhead is on the hardware that _does_ take a fault on old pte's..

IOW, it would be lovely to see numbers if you have any like that..

Both ways, actually. Because I also wonder how noticeable the vmscan
improvement is. You say there's no measurable overhead for platforms
with hardware dirty/accessed bits, but maybe there's not a lot of
measurable improvements from a more exact accessed bit either?

             Linus
