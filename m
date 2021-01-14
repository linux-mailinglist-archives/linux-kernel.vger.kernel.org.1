Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF612F693F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbhANSRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhANSRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:17:14 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A84C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:16:34 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u21so7565093lja.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aft+47NxygdBFcq9TFp+5i9C19WqLdlSHw/uTUCv2iM=;
        b=AgMjhyXp6oKx6fm9HEWMrWNr/lXEqclKxgHaCoAvlOMJ1D6LcOW6GfjutxrkU2cEp+
         IPlvcixV4GV7nx92ho32piLUh2Aj8crb+Re1rjCltubtNGngNzNvYVbYznojeuRtOP2H
         ZQVXkZPhiFkRx0MTXTiZ+uBwhHuwY03R+cENU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aft+47NxygdBFcq9TFp+5i9C19WqLdlSHw/uTUCv2iM=;
        b=oV3LCIWjty50wVpyXeCrnePOnfJ5GPUGbWDoH6/2Qa7lt6zYOO7fzmQ5JWyx5TXnev
         o1TnhMQpDBjl0zkj0GXaAT5ir1mMnFlLJIC1UzJpq+cVCifP4WFHLtiZhzMEXwdjtINf
         hPcT7QK2xhHqrGKGS/mNqjVrpzOf/X1/XjlfkHqUpk+GeZJxfldCw8Mp7mj+VV9i6CjJ
         ueWqy51A47byMp1GawvJc3UeJa4DfxUFYaj6Pv4jtWQmHL7qdKT88DqAvhAJO9yjbxvt
         jof/sG1uGdh0v71CPeydIZm9pcu1M3l/nhZDFcmUdV9KbHKJSeJhIRdRcU2zW+CGuxhE
         D8Lw==
X-Gm-Message-State: AOAM532dzxGw7P83XdYHnhOaKuzyiRawHlFqYg8Rk7JhJGXNtv+UcIyJ
        o05ATmrH89gFMALlfI34/ZscJAiHZWzR5Q==
X-Google-Smtp-Source: ABdhPJwmGh7QSEiq1RKEIOyS4kd5oC9INSZgNnuAl20T77/3g4QoB/dfmnjQ5vnKVcS7HwvG5WlOYA==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7mr3648820ljj.46.1610648192082;
        Thu, 14 Jan 2021 10:16:32 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a18sm535983ljp.5.2021.01.14.10.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 10:16:30 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id h205so9351318lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:16:29 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr3612591lfu.40.1610648189395;
 Thu, 14 Jan 2021 10:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20210114175934.13070-1-will@kernel.org> <20210114175934.13070-5-will@kernel.org>
In-Reply-To: <20210114175934.13070-5-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jan 2021 10:16:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
Message-ID: <CAHk-=wixsPuT5ingsEqj2a1PKuc+rTS_oeD_VL0p8G_3oRiJhA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] mm: Separate fault info out of 'struct vm_fault'
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

On Thu, Jan 14, 2021 at 10:01 AM Will Deacon <will@kernel.org> wrote:
>
> Try to clean this up by splitting the immutable fault information out
> into a new 'struct vm_fault_info' which is embedded in 'struct vm_fault'
> and will later be made 'const'. The vast majority of this change was
> performed with a coccinelle patch:

You may have a reason for doing it this way, but my reaction to this
was: "just make the new embedded struct unnamed".

Then you wouldn't need to do all the automated coccinelle changes.

Is there some reason you didn't do that, or just a "oh, I didn't think of it".

                Linus
