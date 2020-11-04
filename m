Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E31C2A5B93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 02:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgKDBL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 20:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgKDBL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 20:11:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC6EC040203
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 17:11:25 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z3so474427pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 17:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pl/YNzAKN3RGIriL5hG0VIj4hFBWq5DGVvwHyQw7P6M=;
        b=IwjoCjX2v2yBZVCRqjZPam1XrZi6jUDEbqtbz9FDsaDZ8f+wS8CRRKymvpymlBBnKb
         2SFXBR0l4XTa4NvoAx0KA+6vBtgBvSX5oIdYjfsskYTnnfwoNvCVKf89vg2Ryt9lfsQq
         dFyxBjy/quM2ARMnstuJdW1tBeufQd1AJWe7Nx9LXkx7XPEMSJuTVMUfugh8bTL89XGs
         p7QpTCzqdBUSOlRLQFzj6mLy6I0rDL0Ob85gGL4dfm1Or8cs4x3AC6UCzcvWepV6WIej
         rIJfVtkQwmyVMOHcKNIN5RTgwj9DFVWAZfmzjihfyOHXbhqHAbPQ6GsmiM/EW8fuxCRK
         8n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pl/YNzAKN3RGIriL5hG0VIj4hFBWq5DGVvwHyQw7P6M=;
        b=G9+A5PLiWvavxDw6sCpGabSTjVz2KeCNI/Z/+Lq07PpoTCj86o/Dq+DwydCJ5zyD0d
         C0klIcYDtwqpyF9oG5tG/s9Ebgg+ANwOYpe4azL3M7NhdleZPYqaS6owZx0BzzN9ESJZ
         4/ccFIvlJZVk0aVrCrgmy6sKPvSQnh90YOxm3MBX6/0Ew7/XykEBuEPLFC91vjSwa+tM
         gK0aC9pMhRb1mv0NR+2f0xlQPyniqiOjGHEG7cmBnuH2MkH8xtHyjzrAz1/rzfE9Cx9D
         NWe0qf7N7UuZ+p7zIZZa/QcMz8hCbNt92j8+xT1FGzPttGhTK8s472oh05wtqBj0AFTq
         R/Qg==
X-Gm-Message-State: AOAM5335TLrp/6mW6luViNrvVask3J0vXWkNohJ93d+BFSnDgC4G0GrB
        CSjV9vCiqhVAWd+MiD2rVsxiGmz2SkxoZyoGOoY+vA==
X-Google-Smtp-Source: ABdhPJx4Cr+0ulOH13raYoijBsEFq5nyPF9WpKEENfwEgCgYfj/YpbStidPfpi1PjHnXZ2raQ3o52wYva+00gHgT/I4=
X-Received: by 2002:a65:4b81:: with SMTP id t1mr3071636pgq.263.1604452284771;
 Tue, 03 Nov 2020 17:11:24 -0800 (PST)
MIME-Version: 1.0
References: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
In-Reply-To: <363325b4a85f094ba9cf06301dd022912ec79d03.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Nov 2020 17:11:13 -0800
Message-ID: <CAKwvOdnC1Sp-eBykrawt0FSG_kHu-FU_i7QjVkFEmNx75Hxf3g@mail.gmail.com>
Subject: Re: [RFC PATCH] .clang-format: Remove conditional comments
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 10:29 AM Joe Perches <joe@perches.com> wrote:
>
> Now that the clang minimum supported version is > 10.0, enable the
> commented out conditional reformatting key:value lines in the file.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> Hey Miguel.
>
> I don't use this, but on its face it seems a reasonable change
> if the commented out key:value lines are correct.

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
