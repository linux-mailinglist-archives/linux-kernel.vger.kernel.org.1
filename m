Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4C2B8666
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgKRVOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:14:18 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F29C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:14:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id a9so5097130lfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yy+yKl/nnqPyJAxAGlya/ZYfyG7i5Dh09osQ1e1Zb6g=;
        b=I3SxDCnIlQBxcqp81lE0LsGpSBKz92rnlT+kaRw2F2srcDq9dkJ1Sp76w+EneB2crJ
         jjxJ6rlRZ/H7KGe4pRCeX3WU0FaNd7GvcXKbANsw3+YiQCi6gaR6eBosWQEA1RgE4i03
         yMpkvwHIOkai0lK+k5mfTOMmicQTxOlm8fR8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yy+yKl/nnqPyJAxAGlya/ZYfyG7i5Dh09osQ1e1Zb6g=;
        b=J6z8LH6Z/q8dO6uzkWX+bvv+K0egmSDW5S5ypPlFTslUHIivsQfsSTHZ5C1CtaxihI
         Xc5TxFhVNG0ujDI6a5aujnFvG21zAuiFIQcKJK0JdgILcJFNO8V1VM4aBeEVfaSYSBIG
         dmKEDaihWtVFKJzA25vqVxIpoxKadzPuHAJrY3higbn1lsnSoyJcKc8P+FsSmfskrJWk
         r0xMCPuP7FtS47cjiuInZ8cPe6zi6NLgHA21kovBrHaxXro4fgW0BVvbGs0rQC+OObzD
         jDHmUFJsyfArl3D4qLzl+iY7+pcJmZI4i5fwb3Co0jDy4sWXlXCQA29q2cv2Ei/hv6IP
         MpDQ==
X-Gm-Message-State: AOAM531HIV1WistfPtGcugoeR/wl6xQ53IeiusdoqUzrZhs9ByBkgWW9
        QKnm4QmDEzUIzxKErWBIEVa6vs5y1/H5nA==
X-Google-Smtp-Source: ABdhPJy5GkkI+rHLAsmZ63KjtIGsYh8ynBLvA8TPuf4VjNqR+SmTwgE6GowkFAV0Lajn1NWEX2j9bA==
X-Received: by 2002:a19:8497:: with SMTP id g145mr4500772lfd.504.1605734055736;
        Wed, 18 Nov 2020 13:14:15 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c14sm3726268lfr.105.2020.11.18.13.14.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 13:14:14 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id r9so5048892lfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 13:14:13 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr4820439lfc.133.1605734053571;
 Wed, 18 Nov 2020 13:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20201118194838.753436396@linutronix.de> <20201118204007.028261233@linutronix.de>
In-Reply-To: <20201118204007.028261233@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Nov 2020 13:13:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6+VXQASpG+X_v8E25X9mARyHULeOfHk1RsNFMMWHafQ@mail.gmail.com>
Message-ID: <CAHk-=wh6+VXQASpG+X_v8E25X9mARyHULeOfHk1RsNFMMWHafQ@mail.gmail.com>
Subject: Re: [patch V4 2/8] mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP which forces the temporary
> mapping even for lowmem pages. This needs to be a seperate config switch
> because this only works on architectures which do not have cache aliasing
> problems.

Very good. And you made sure to have a comment to not enable it for
production systems.

Hopefully people will even read it ;)

              Linus
