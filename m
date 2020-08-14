Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FEC244F85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 23:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgHNVUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 17:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgHNVUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 17:20:30 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4BC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:20:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w14so11371558ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1lbAbFBQuIeJImY27l6K3oclAsau8+FFUbSkE/Wafq8=;
        b=cgQxv1vcc1pzqPVOeRVuKNTS+NzcZcPHYcWgUDfx4dU8bEkUCu6RcqvWk7HrG9rPLt
         CUuv/WUHxa1ap1k35KVj++2tA/PYR60ue6xSxdA6TkaDtnmrrbGaIT9UuoxaVbhIwdpC
         SbpUoNz/2EDiXg0Qh4tmO4A2Fm2zXrrSpW6HQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1lbAbFBQuIeJImY27l6K3oclAsau8+FFUbSkE/Wafq8=;
        b=X3WAdaFt4Bs3ClrX+bPlHgTg8TeZ5gZoEV5gx5KysfOjnuoZqB/yAtIJkhhijRodB2
         UKs2RVwte7jj52kVBg6RF1U1BWu9kmdsUWImlLLlc7Tk19TlkE4bAPGAQMKGHSyuqLzT
         l3Kw5F7f6NG7k1qa1lC/iJp8xD5c7OLo5x2ff/7T6f8FYxO1YaLXJNN02xycEFzxDtLU
         ozY3YFVzw8GbwJewJkXPyc5c0mPd2IjhiFe5y98dAWVw+ClC7+pR47P+1GqIJFUpN9yq
         s14x+PNDnsz+yWXFjtx8h+IWxELUEJOmjDHIIROdhG5g91/pwzS5C1nUEn2giulFKJ0F
         svnQ==
X-Gm-Message-State: AOAM530+9dWuunjd87X/SZzoXoXNMW2tOWyHkuwROO81P52Z9yxYniAW
        ayVz2Dadqktlx2ScNUxaO0OtLgHfpFW/gQ==
X-Google-Smtp-Source: ABdhPJyUyKdTj1r6YQ5WJUPKMfGRuGxHqvRZCNrNnCObZk3SGQ4UySeJ3W6P/2kVTlBWFA0iqDY4lw==
X-Received: by 2002:a2e:2c18:: with SMTP id s24mr1988979ljs.260.1597440028529;
        Fri, 14 Aug 2020 14:20:28 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v20sm1983920lji.64.2020.08.14.14.20.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 14:20:27 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id m15so5504981lfp.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 14:20:27 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr2049842lfo.125.1597440027201;
 Fri, 14 Aug 2020 14:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <159742071192.30851.2328227964586183297.tglx@nanos> <159742071312.30851.9658771452402261764.tglx@nanos>
In-Reply-To: <159742071312.30851.9658771452402261764.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 14:20:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi24a5etbq8ZBAcuyoOEu45pgTUdvwpu4+uvVXeUQ=-PQ@mail.gmail.com>
Message-ID: <CAHk-=wi24a5etbq8ZBAcuyoOEu45pgTUdvwpu4+uvVXeUQ=-PQ@mail.gmail.com>
Subject: Re: [GIT pull] timers/core for v5.9-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 9:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> please pull the latest timers/core branch from:

.. again no diffstat. I think you've borked your scripts.

               Linus
