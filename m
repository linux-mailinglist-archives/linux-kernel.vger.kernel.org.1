Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F5F2AF323
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgKKOJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgKKOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:09:33 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92395C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:09:32 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y16so2249886ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4F6RReVm27W/nhwX00zKDRay2swOnSHsIeTk0Gn+ySk=;
        b=THd6YZbKXouhcPK7EKGkOIz/sPDjdTWa6OIUxDfH0TaVX5NwEoyp8i74NqBppgZRFY
         OKy9PBmigzR296Nl3mP7zfsbFF1xxlqHHcw6uatuyCtvcMs3Xqx/kdOhbzZZfEPBDRxu
         Thndl+h/RBqE2jSttLaubWJkwcl4yIHRA4CMtQ2rjCCe1y+4xUWi1A4ZJfpEnNbO+QM3
         I6bmuoHikOnN8ZSoxTf9TSr9le540XckkeZPfmnxfSJuljSLhoQOd5Cl6efDQBrARvlo
         1wfr4Xp3wGwZyffltHH9uMOdrXWHWds+e1Tfh+p/eyo5ISA43ZdK3EPp9hXYBX/idEDU
         Po+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4F6RReVm27W/nhwX00zKDRay2swOnSHsIeTk0Gn+ySk=;
        b=i/3/rrXhQkbdfNX5cwp7KnDbxThiIn03zoRUxlz1ccL4AyeROrBpyzeCeE+BQKHEoH
         pQgy2KYSYwvWIQ33HsYhf6ioNXY2z69EINxy8LlgNvQ8ycvkH77c+cL2bzH2sVqpShsr
         sqyzFPTC+hcbt6WaWLaTRjfKlxbzl62Fd9AFbVhFXFznA8zdtM5aY/l+QNGSL9jJAeMt
         YxwWBB0yxExjJ00awXAmKqT8McrxivvI9VN5Vy1KZnqUfkCHl3AiZeVzUV/T4fOdPHoK
         5DddPbVRDZhuyxgCsXeY6bS63EUJiekJJswvWpt/RtRpC0DQlArgqJczN75HdJRHm8Yk
         npyg==
X-Gm-Message-State: AOAM530YtzWbnbu2EwL1yp9+1nrFYl1GR/oBX0iglGzL/YSoI/1Kxs4n
        qyrWVU6JZOXzIvwnyPG0OYOmeeNX7jBwJ315YnB4HQ==
X-Google-Smtp-Source: ABdhPJwAg11sK3F0ifRwK3lK8O7cB89hYdWEnxHVyWaVKYaofoDtDv+qsUOkDjyCjd0eZ3pniwiZNWVZVf5qJJP62Uo=
X-Received: by 2002:a2e:8604:: with SMTP id a4mr10729544lji.100.1605103770994;
 Wed, 11 Nov 2020 06:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20201019141008.871177-1-daniel@0x0f.com> <20201019141008.871177-4-daniel@0x0f.com>
 <CACRpkdZNr6sDqJhg3KcX0bCbcd8fh2gXFYbS1r2H2Sq+vGqjUw@mail.gmail.com>
 <3fd04aeb5047d8059ddecc1eda19c2e4@kernel.org> <CAFr9PX=vxCCQgCWe9FPb6Z=0=a48HwGOfM_uOG3SqGN9VSYQUA@mail.gmail.com>
 <71f3632bee262a18e1b7edb74980ae9a@kernel.org> <CACRpkdYr+yhyROQzaYfFrGwG74DuZiA=fMVOesgOKrDajhTodQ@mail.gmail.com>
 <bc0ab2f10bb72fe5b455ca12958f6444@kernel.org>
In-Reply-To: <bc0ab2f10bb72fe5b455ca12958f6444@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 15:09:19 +0100
Message-ID: <CACRpkdaTknFRSm4pcSf-v7Be8A_SnMMrhegu6W67gUjOJVLEBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gpio: msc313: MStar MSC313 GPIO driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:19 PM Marc Zyngier <maz@kernel.org> wrote:
> On 2020-11-10 14:02, Linus Walleij wrote:

> >> Probably nothing more than setting the callback to
> >> irq_chip_set_affinity_parent,
> >
> > Hm, is this something all GPIO irqchips used on SMP systems
> > should be doing? Or just hierarchical ones?
>
> Probably only the hierarchical ones. I'd expect the non-hierarchical
> GPIOs to be muxed behind a single interrupt, which makes it impossible
> to move a single GPIO around, and moving the mux interrupt would break
> userspace's expectations that interrupts move independently of each
> others.

I found two suspects and sent patches. I think I might have some
more candidates down in pinctrl. I do have some hierarchical IRQ
that is on UP systems, I suppose these are not affected.

Yours,
Linus Walleij
