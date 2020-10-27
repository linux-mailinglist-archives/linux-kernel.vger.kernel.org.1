Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9329BEBB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814523AbgJ0Q4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:56:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46461 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1813802AbgJ0Qyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:54:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id v6so3181364lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEusMx0ZRn138Jwefw1g8V0UKrDDZdcut1bQJdGAhgQ=;
        b=ZmatzM83a70P7B8/xGgnQM2/OG0aO0tUzkC/htVxiakYVLlot0AM874buXlHxDJehX
         ds9dWNZ/n41v2KEd+RL8moBpRKEKHJwd6mHOse8lkbt+ztLaAYrzNJo9+5Ym1Vno+Dzh
         XqswaktvPhQzc8N2erg1+15+XEoKZoIWz33yI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEusMx0ZRn138Jwefw1g8V0UKrDDZdcut1bQJdGAhgQ=;
        b=XLlQFJ8fKsHRVeHagG8kCf8zz1GyM1aD6y8FfqzcfMarAn2lqJLudlzi3PKYsvQ+7Y
         VW8/5RXFfAEnwLKsTZZUCZYhnXVVshIsVIaldQUqfb1kUkrtedgD2aVk+HVXDvQLaGrH
         PfQVPPFCL/aMh+CiJl9WwEOQ+BSxKq3FagDE5MCgyEpc5yqXb9bKDk5aAUJZ7x5rH4vb
         UkPXJztlZLTbq9mPcAYchcVxCDke1rNuT9cvsFiWT/HOjRLggyf/V/wos3bBxDJDbzc0
         D6+jlZJt5cVL/jNQff/pNn4uo9YV1frraXSiteH/jvBDBZRy7Puirh5MLFWOOv8S2MSi
         lyNQ==
X-Gm-Message-State: AOAM531mk28sryLjms5eSJoj/EzAKek7LisILTFNwN4tJ6nIZhjr4o5K
        DhP8nhHFvfbNsETc6GJtqAwOY26N6cwmoA==
X-Google-Smtp-Source: ABdhPJwoDW3u22xB2Yy0BWuHmCj0tlpoM4CEFZ6YXCo/UH4Im+0iF/6ONRRWGYn7MvlhdvNMT3fp2A==
X-Received: by 2002:a19:146:: with SMTP id 67mr1104497lfb.75.1603817689314;
        Tue, 27 Oct 2020 09:54:49 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id x27sm231691lfc.273.2020.10.27.09.54.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 09:54:48 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id p15so2567097ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:54:47 -0700 (PDT)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr1416961ljg.314.1603817687157;
 Tue, 27 Oct 2020 09:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
 <20201027085152.GB10053@infradead.org>
In-Reply-To: <20201027085152.GB10053@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 27 Oct 2020 09:54:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com>
Message-ID: <CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com>
Subject: Re: [PATCH] dcookies: Make dcookies depend on CONFIG_OPROFILE
To:     Christoph Hellwig <hch@infradead.org>,
        William Cohen <wcohen@redhat.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        anmar.oueja@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:52 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Is it time to deprecate and eventually remove oprofile while we're at
> it?

I think it's well past time.

I think the user-space "oprofile" program doesn't actually use the
legacy kernel code any more, and hasn't for a long time.

But I might be wrong. Adding William Cohen to the cc, since he seems
to still maintain it to make sure it builds etc.

             Linus
