Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767BC29DD5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgJ2Ahb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730542AbgJ2Agm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:36:42 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2632C0613CF;
        Wed, 28 Oct 2020 17:36:41 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h21so1520475iob.10;
        Wed, 28 Oct 2020 17:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hj+EqoJ8khAy+Vvj816RirpNw6YjRUZJZt51nQOVs9A=;
        b=WDaDEm/HR31rW3seXD21SpWBhLX18ll6nk59wfAMrgPjv7+fXCXdYMu+bbxwtZD3IH
         reCyayIdO360QckMZOp7SrTSpAiFNwtYzuQuO6tJEr94/pjWHoT64GCDfGsr7//1c/y5
         2452BZ1SMBbtpQXB/eaFAJ9zoEHxtjICIO/Fy4xLIjZaKQBwvkCgDq5B6TQnzPQRsPIr
         fUHOx8m7k1oq5ilbErRMNM9z3vEvy66uVJ8W5hIBpMu9u1ixhrxmKD9EEpMO6P8Vus4v
         eg3362JIW1W46MGWxiMJKSIFCEBHxdduO7FgVcPTvgRLmZ+gkfam/T2LquNGM7aZIJWb
         52Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hj+EqoJ8khAy+Vvj816RirpNw6YjRUZJZt51nQOVs9A=;
        b=uMEAJN2s7xhNKUfZxkcavkU6+vyc4b1iTvpzMxIIFUvdprIvyRb6REsy56gCAXrnH4
         zIaT2OvtMU7InExs3JO1cERHeYJTPi/2EVGw21q/ld0PAbzfPl5l7fe89THQrZbhvXhm
         P6dYLp4Y8ZeRbTiU+meOVa1xVG8hUE+nbOVv9agEibZHfZLPZ7JoehqAkg4bi7DhgJCY
         RjnrLpzOzQS7TVfJN2hUdLW7NnOkVnMZgJZfGoOEtut2gBN3Ue0Exr72TxjmzgLM7Hx8
         XQuSmYbpL9h63O1g0pTzUofybdd5agObdDKQwigox/J402E3+71xCxkrEuEb8LpHsJ3j
         2j0w==
X-Gm-Message-State: AOAM533D0ZlSGvZjR5us7Gq4WGrJ/+FfaI73txx3FzSGMk+ehXdGIEwz
        RNkgoDJXRU1KmFD1fFMy/Ro1Df2ZBplMukcUgxQRfedhMg==
X-Google-Smtp-Source: ABdhPJxyjvfm11vXjLtnOL7Ew8CVvRI3+5J1kk7AZqwoTBfvzm1Rvt4nRnK4vBW5cI+uszft4zpdV628LBBb1osqpZE=
X-Received: by 2002:a92:85d5:: with SMTP id f204mr4716737ilh.45.1603864978212;
 Tue, 27 Oct 2020 23:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com>
 <871rhq7j1h.fsf@nanos.tec.linutronix.de> <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
 <CAHD1Q_x99XW1zDr5HpVR27F_ksHLkaxc2W83e-N6F_xLYKyGbQ@mail.gmail.com> <87y2js3ghv.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2js3ghv.fsf@nanos.tec.linutronix.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 28 Oct 2020 14:02:45 +0800
Message-ID: <CAFgQCTtnKB+p5uhRu3JpmBvHbQ8Vhv0TrKek9_3CWbtbcyM1Kw@mail.gmail.com>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Guilherme Piccoli <gpiccoli@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>, linux-doc@vger.kernel.org,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 3:59 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
[...]
>
> And contrary to Liu's patches which try to disable a requested interrupt
> if too many of them arrive, the kernel cannot do anything because there
> is nothing to disable in your case. That's why you needed to do the MSI
> disable magic in the early PCI quirks which run before interrupts get
> enabled.
>
> Also Liu's patch only works if:
>
>   1) CONFIG_IRQ_TIME_ACCOUNTING is enabled

I wonder whether it can not be a default option or not by the following method:
  DEFINE_STATIC_KEY_FALSE(irqtime_account), and enable it according to
a boot param.

This will have no impact on performance with the disabled branch.
Meanwhile users can easily turn on the option to detect an irq flood
without  recompiling the kernel.

If it is doable, I will rework only on [1/2].
>
>   2) the runaway interrupt has been requested by the relevant driver in
>      the dump kernel.

Yes, it raises a big challenge to my method. Kdump kernel miss the
whole picture of the first kernel's irq routing.

Thanks,
Pingfan
