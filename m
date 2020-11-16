Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594A12B42BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgKPLYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgKPLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:24:34 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:24:32 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id w5so2885636ybj.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zEN/VK7JhiGO6kCOiDOr14UUtqMiJCHR4xVc50CoCjc=;
        b=pzm7WGZ7CONRAMysKdxb/t4T7JEzvtqAJarsXPqYd+qvFbFyBl7luoZaS8rnTFl1wd
         c8QaLe6FAEmgW4a9XdVq/y0Z7NEVMFmO21PhwQVMWvkHv0dd8fGodE8BBBRxiXXVl/Fr
         1SFpXM/LDNxOThsP+pXX4tl2plO10/XMgqHncM9pQIZNCChNgdUJSQ89rqjgjFKMEsbY
         C/6rm7GjHmAoUz6JvfnIcpQZFWOJ7oXV1WU6JfT23JtKFUCmqeC3X4RGPDn5l9lM8EaI
         tGHLNZfqd004zb18SwrAQj7EY+RpZSBV3qZmiUnIg5S5xeXkrEm5sa9mOC3T5BX03WqV
         y4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zEN/VK7JhiGO6kCOiDOr14UUtqMiJCHR4xVc50CoCjc=;
        b=HHEsyEqFeKKF9FqvnLozqcbvz07f/HAn7vPUh64lSCtpewhmL0uJJh2LUF2Fl7IqUo
         jFluwG3/VCLMQ8Gu74EDNkHq1xRGeYOzEjYXSLvr5r5tPbMhq9EyWsGZxd4U8VY84yj3
         zvMxJJ2lHYfIkCT4ZP0GL6GC3AEkjX4nWpkFCc2S5KuBqxL1xVeNVqAG6heNGyORpook
         UIyYzmhk73YAh3+ZiCcfTho3BJS/TKNA4W0LM8YnbC8DhEszU1OhmNUY5KnBb5msydRY
         AmydXO/YjV/iI0w5Kc7/zsnU4jWZ3k5VTSk5Zrz6X77toPNoM9NKjSLEf2cnlBf/G9l7
         igWQ==
X-Gm-Message-State: AOAM5312G4pfz0omMatWy/V3cSrNov6QJF2qugC5lo5FZE98337+R6Rj
        Z/s08hF6uQtvUVc1W3QN8TQBTNO0JjV1FlPZ010=
X-Google-Smtp-Source: ABdhPJyG5rS7dwR6Szg4FjXpfD8dGGDR/xAIJBV1mQ7dVxE8PirFoUJwqzlp/G0Rr4oMYQbmwEWu3YfjFkS3mEJ2N7A=
X-Received: by 2002:a25:2e0d:: with SMTP id u13mr11642564ybu.247.1605525871909;
 Mon, 16 Nov 2020 03:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20201116043532.4032932-1-ndesaulniers@google.com> <20201116043532.4032932-2-ndesaulniers@google.com>
In-Reply-To: <20201116043532.4032932-2-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 16 Nov 2020 12:24:21 +0100
Message-ID: <CANiq72=XRGMAYRc6yXuLYtqAcwbLx_RpqLzPdM1BhOYjX0EQiA@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: boot: include compiler_attributes.h
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 5:35 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> It was also noted in 6a9dc5fd6170 that we could -D__KERNEL__ and
> -include compiler_types.h like the main kernel does, though testing that
> produces a whole sea of warnings to cleanup. This approach is minimally
> invasive.

I would add a comment noting this as a reminder -- it also helps to
entice a cleanup.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
