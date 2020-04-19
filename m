Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358C11AF93B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 12:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgDSKLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 06:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725832AbgDSKLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 06:11:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB5BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 03:11:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 188so1386672wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPL9S1h8o0rRpV0oBvZBgAnOMy9T0looSd7h13xoNU0=;
        b=AAkCmJ1G7OyK9DttpInjwgMggyHT+zcQrWSKhIZBYQMTGXkuIv3kha0kJG9wm4JrPx
         PHv1oRj8f/q81k+fxlS74UofSXdPMB0c5fc4dRwOUiLe/EYebcSmjGNPAUd4xEfa0DH5
         ZSJhfsn7dpqtJ21wtPKQE58NPjobBp8saMjart9y/G5Eo8pKwn1+NDbISolpDGdcNM9G
         yyRsPAeenAN84hhc74aau9aUB3nUG7EGUG8KAnhTJ/ih09L574mbn7nLqp22aiF7EdAf
         sleItuSVSWtdI3shHFwbF0ddmIemWbUpQ8LHIyKvK2FUYFMrcpVdGHwNCKuqTf7g7nTf
         Ekyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPL9S1h8o0rRpV0oBvZBgAnOMy9T0looSd7h13xoNU0=;
        b=pkpXDXmsU+QqI6Y7xg2h3yePzltqrZZrYUv8N3UV3/RnJvluD1a9lmdDTWU+4YaxnZ
         MUHfDgOXTkSDZXurfEQQY/L5Owhf4lhk9AsesWkMkC41ZTEiLtZ9Y1pHqWfrlq/wakfV
         OTwb1ZMtlD2scU+xaCwwgTH8TsbkE86jT6FaAzGeGX9WnMOF+2lo8atI+QDEku3/fG2z
         NcIDvdvfxCCj1WphZSFEhnx3QOycECcCTI22iOaLZXdhm8nsGDTcUuFR4CE/HvlfBQ74
         NLB6fdLudo3w02/fl7xVcTvkVrvufaso7YQSggWiF+bedF/zUoRuznxXAeKoHul+O78o
         H1Dw==
X-Gm-Message-State: AGi0PuaLa7r253C/uM7N6ESYODTjNh3SjPy3trTGB/QXx/lw2Ie6YSRv
        spf3yBazHUzgewW/bOt7nLWzWhBfRGiZB3oX7wZmCA==
X-Google-Smtp-Source: APiQypLm24p30p3MS1TLZPmkjyU2qfduUvsdWwC0UTBOiar5ClalYC4XQG5E5xQtAztJ1WXo8h3lO7el/wwUdzf7hbw=
X-Received: by 2002:a05:600c:2a52:: with SMTP id x18mr11779917wme.37.1587291063492;
 Sun, 19 Apr 2020 03:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200419100848.63472-1-glider@google.com>
In-Reply-To: <20200419100848.63472-1-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Sun, 19 Apr 2020 12:10:52 +0200
Message-ID: <CAG_fn=WaQnb9U+iOgsEPag_+mt0UEzFyhQBN0mkX2swAhuHTuA@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: allocate initialized memory in fill_thread_core_info()
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, sunhaoyl@outlook.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08 PM <glider@google.com> wrote:
>
> KMSAN reported uninitialized data being written to disk when dumping
> core. As a result, several kilobytes of kmalloc memory may be written to
> the core file and then read by a non-privileged user.
>
> Reported-by: sam <sunhaoyl@outlook.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Please also include the following tag:

Link: https://github.com/google/kmsan/issues/76
