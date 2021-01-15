Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8302F7CFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbhAONpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbhAONpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:45:38 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA57C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:44:58 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h19so5947593qtq.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoLRfGrE41S4rKfeCJicect+XhE5pSOE3WmEeBCuXuk=;
        b=U3zx+BVAitOAr2Gd+STSNJRRoCwfvRyBbauXbZa7327trUmVN3fVWnEbtkhkqIZvP7
         P491msVTjCtxEpZL+/LLOVHLiqE1lr6JVioe9wZdOF+8cKPUfuA7hqbGqX+oDcTxLRlD
         Ik72NXdIr8qV5LdknbXCyw4SDirgmUwNnTyr2Vl8HifJtD3FbefN+hasaBP9Y/Nz7z4b
         Dxvi71H6J9NUAc4H9YdFM4O58lfOMyT9P45/LWGp1yxWRtMy+/oRjkxy72B/Oq/XbCer
         DdycY+6CD489IyMkM0malwmIa+sp5yjmgQLiLVl8y0oFcwl0WpHqhdY7Pdfk1PagpEay
         3VqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoLRfGrE41S4rKfeCJicect+XhE5pSOE3WmEeBCuXuk=;
        b=dfIkZpFFHl60ZWQ3/iljdPDCW90FBum1gQIu81vXoj2eqE4DreW6s+qtbh9P5Rp4XT
         5wCC9Etq0PT0VKBAaX+aH2ctCUQzzMPAq+1doxNRHsxFHtU41DWtC+ItdoYX8i44lEdP
         WFlBSDMcTBhjL46vikLGR/UAe92MlS10x5F9RW4t13X1x//HRD0AoBGYdsmam9qY/p4p
         MB3p78hjLL4qhS32rFdSgSGSm4I46j1dOEe7/OBJI3FGGsD7xdcxuulXoueYD1PLTchN
         AIxohxoSIJIZhs7AIUuwiiaHJoTjGZFmAX+8ktsnsO1a/OZedQoLNgKz6BHxj6x8lKk8
         9TOA==
X-Gm-Message-State: AOAM532NxMHVJ/ayLmrnNvAAgkPmrg1mRqA8fsloMtYFJGiQmQzZb/VZ
        dqx0AS/WRcDkNY1bCDwd7cXlCvxbaNRNAQB445p05A==
X-Google-Smtp-Source: ABdhPJwZ728eO9ujnMjFTFdpqBRVj7UP5jS4tZw2bVSgY8XOblF2mEbsS0MFQqBE16w86HhKEbdRy9TR3CFShVI3+M4=
X-Received: by 2002:ac8:7111:: with SMTP id z17mr11856619qto.369.1610718297471;
 Fri, 15 Jan 2021 05:44:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com> <da60f1848b42dd04a4977e156715c8d0382a1ecd.1610652890.git.andreyknvl@google.com>
 <YAGVCxWTBlv4ZITG@elver.google.com>
In-Reply-To: <YAGVCxWTBlv4ZITG@elver.google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Jan 2021 14:44:46 +0100
Message-ID: <CAG_fn=Wgagm2JXrTXanRe2ue=So2_MAXJWFmjzb2ZvU3GF2VWA@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] kasan: don't run tests when KASAN is not enabled
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 2:13 PM Marco Elver <elver@google.com> wrote:
>
> On Thu, Jan 14, 2021 at 08:36PM +0100, Andrey Konovalov wrote:
> > Don't run KASAN tests when it's disabled with kasan.mode=off to avoid
> > corrupting kernel memory.
> >
> > Link: https://linux-review.googlesource.com/id/I6447af436a69a94bfc35477f6bf4e2122948355e
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
