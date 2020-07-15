Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB49D221829
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 00:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGOW6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 18:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgGOW6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:58:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A5C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:58:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q4so4732773lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fXMEPU6gAVBWg6IQ+xECv6MLETWbdcbr7WGd26o3dM=;
        b=MBC5vtMhzWJZZ9GjdJtx8UdDPaGZja6xgYIgmlwDQwU4kEQhcF0AjO17QURILiA/4B
         tQiejDuF2CcqHQwQcyUdPx4syUjjnCAfwoSBapL59fT69dyD/l2/35n4JLhu67HZ3Ncy
         hH2PMCUltb52qLOa2NBW/07krGkLSfwM2sCDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fXMEPU6gAVBWg6IQ+xECv6MLETWbdcbr7WGd26o3dM=;
        b=ssuV/GJOCzGpSKZ/Rn/kTmAa+oix8RnudrooCZ6pEI3kH32k30oTuvM1O1W1/7M6Ha
         9oEdJSDhi90gpRpZfp6vRQszr6xH3ULRsDbeVLIUihgqhuNQveplPpnWLQwdGU+oGNTe
         pByYYRSLUaUmAj03rkqwKDjpxQUeCjws22KFCWGPpyNY2UNhACBHggvFpy51NuS8gA4H
         /sL52Rap9BC9QRLCR5Qwq9kC+EyP5EBNc0TlkNXRHUlZ1QE7NAzYvv2n9tHOgrp2cqbx
         AbECIMtCOYqk2bfAUyLjizFmDcxpLHSzZm1zA+kvQ1l4pN9ZdJ1d0wRNJ/YkOUITAKND
         Mw4g==
X-Gm-Message-State: AOAM533j0dUWO/RXse5aByaRJVkC9Yl5S6TKNoJpEujGYVTNHVmpQdVb
        pR6Xkn1P9jLDi/2DMu6ihfF4j7Ur6wM=
X-Google-Smtp-Source: ABdhPJw6ok7l+XkbIJs3h2/9JIZ9HYI5U7gpEpA5s9o9Q2k566WB6/jsnnXIJpEULZe1ue38l3Qqhg==
X-Received: by 2002:a2e:760b:: with SMTP id r11mr638078ljc.285.1594853887674;
        Wed, 15 Jul 2020 15:58:07 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id k25sm689574ljk.87.2020.07.15.15.58.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 15:58:06 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id k17so2079286lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 15:58:06 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr608455lfd.31.1594853886124;
 Wed, 15 Jul 2020 15:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205428.GA201569@google.com> <CAHk-=wg-_Oof43pKUHMk4ySdLwpYi7+shFg+aeV18UP2Akiv8g@mail.gmail.com>
 <CAHk-=wg+iVwK7MDXB+BPbhTmP-1eBa-y4vxRNr_G8ETnzv5pZg@mail.gmail.com> <20200715222228.jf2pv5u2wyhtc5o5@box>
In-Reply-To: <20200715222228.jf2pv5u2wyhtc5o5@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 15:57:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
Message-ID: <CAHk-=wgp-ZJ+J250DMaJFBDU2hnhUUqXcUnVnZZ1iFQEK6O-jg@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 3:22 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Sorry, but the patch is broken.

.. instead of taking up knitting - which I'd invariably also screw up
- I took a look.

Yeah, in addition to checking the vm_prev/vm_next vma's, we need to
check the limits of the 'vma' itself. Because we may not be moving the
whole vma.

So the "extend upwards" can only happen if the end address matches the
end address of the current vma (and vice versa for the "extend down"
case).

Then it would hopefully work.

But now I've screwed it up twice, and have a splitting headache, so
rather than stare at this cross-eyed, I'll take a break and hope that
somebody more competent than me looks at the code.

               Linus
