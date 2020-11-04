Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F332A6E35
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbgKDThv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731175AbgKDTg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:27 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01DD220729
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604518587;
        bh=5RcMW3W3qVOOhA0b+fzHGW4F3/aiLdBwREBN5Khlf94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mvcC7kOK8NVoArXYa28vkABu5W3B/WefyVloVKwWvelKoC3kevJathvfGcXxW4VPN
         cuR/0M0CvfUjVjxccw0rDcp7I5LyiUmlxCBGY9FSaXMmtR19VquseuRp/inYhijBO2
         gUEhhGIhvC1qg30v0l1YaH3z8TwmwY2mX1CztB60=
Received: by mail-wm1-f52.google.com with SMTP id 23so2545598wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:26 -0800 (PST)
X-Gm-Message-State: AOAM530ediO7vlPAmdJOn4hOXXDWPn9XcHVJ9FLlOLauifL8MM6wfcb+
        0MPmJJynKkm1nV8VFtCocoRGGe+56J8oy54XyR8=
X-Google-Smtp-Source: ABdhPJyZP8r9+R8yatJg4Ap9kL8YkZ3QwlqvvB44MG8DgWVJx3Wo3fT/UDFbsOkK//S7cXew8TVWLjMiKIlXerg992k=
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr6154334wma.75.1604518585511;
 Wed, 04 Nov 2020 11:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20201104191334.393972-1-ndesaulniers@google.com>
In-Reply-To: <20201104191334.393972-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 4 Nov 2020 20:36:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3wAikP-KkGUiznqnc5f7Uja_UaYxvkCLVtcHDu1tYuGA@mail.gmail.com>
Message-ID: <CAK8P3a3wAikP-KkGUiznqnc5f7Uja_UaYxvkCLVtcHDu1tYuGA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: mark LLVM as maintained rather than supported
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 8:13 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Funding secured.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Did you mix up the two? "Supported" is defined as "Someone is actually
paid to look after this.", and it sounds like you are saying that this is now
the case but wasn't earlier.

     Arnd
