Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA852B2C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgKNItc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 03:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgKNItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 03:49:31 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4213CC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 00:49:30 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id s8so10943609yba.13
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 00:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LHC7TLjMuv0Bqsc9YInmu+Sq1aO1znxsOq7zjGv5yxQ=;
        b=E8zk5pYq73uLas2lesfyYQxN8ybnFwu924J7/cw4fK+yQH4xLWGM67r3fgI3pp+i9R
         kpATtTG1U8FalvvEhSwE61yrcBbbNlwvTlcqtY71k6pLMTb6tlZgc4y08/13Guzsr0v3
         3Y7YNgX3D7YLKxlUhu/lTbBgjOaTG6PsUr1BoSC52YsbeSc1qhJAMs/yswreRVRC/ufL
         +cAQAu2cn5cqorcDitOv9iGLlLyGbTxxtIjRQWrdN5cirW9whpO0ffVxMCIHHp5uIrC/
         kOAJXjgv1isFDpQUxDPoP+pN3pHV2C9bCmnTLrNMWOCC3tJ3zayaweAeBBSHn+ruzB8m
         3NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LHC7TLjMuv0Bqsc9YInmu+Sq1aO1znxsOq7zjGv5yxQ=;
        b=Z9XHCBIe6s6yywZwKkZGFBBXoiBapGWXmNuwIihIca8vZXdCmYvszoxjf2DcpQ9ER2
         OPkqYG/mRC3JmNrRklGBCY/nFwdvxSJU6cjgUKA+f3j8NVyq1Isx+9wkqJDyuVtNBIp/
         XgOWi5xU8lIvnSf4QcRuc+Z6LcAsJAF3+0zFN/zb89xecLa6T3oF0g+ZVbkKJkLehh5v
         Lm7ozANhY2YaZfpOiHDI89Awxbt6vu+KbDRQnnpVlNH3noe8VomHsDIA1h0B+/Pe3jmA
         /DBlzo241uskNvR7tX3hm/ldJRmNxampGTWyXudGbja9RW78/TZPIexhvtElk7VuqYsm
         wlrg==
X-Gm-Message-State: AOAM532Wo5HRch9x5KDoWjoLP0EjrjGy+atTtJkKcUf3oIoRsCbmdNNL
        KY3W+Jxu2xsaxbEIIZIxItgVrj5K4eXkmRqXvlx1gnEhb1g=
X-Google-Smtp-Source: ABdhPJym/VohNf3+KXSVFf5hlwLIcW0WGncOf2MKB3JrhWTKquM6Gc3sLMXbfxy4sDqyKQRmiHeeuNDDi+nEcPPSVGs=
X-Received: by 2002:a25:b792:: with SMTP id n18mr9004847ybh.93.1605343769525;
 Sat, 14 Nov 2020 00:49:29 -0800 (PST)
MIME-Version: 1.0
References: <1605342178-22796-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1605342178-22796-1-git-send-email-zou_wei@huawei.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Nov 2020 09:49:18 +0100
Message-ID: <CANiq72m+V8RxrFmt_hxV3uPYW5d60kxSiB-uiE63YYkURV_4Hg@mail.gmail.com>
Subject: Re: [PATCH -next] auxdisplay: fix platform_no_drv_owner.cocci warning
To:     Zou Wei <zou_wei@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Lars Poeschel <poeschel@lemonage.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zou,

On Sat, Nov 14, 2020 at 9:11 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> ./drivers/auxdisplay/lcd2s.c:373:3-8: No need to set .owner here. The core will do it.

Thanks a lot for the patch. This patch was already submitted by the
kernel test bot, please see
https://lore.kernel.org/lkml/20201111092559.GA67395@c88ae2e89e59/

Cheers,
Miguel
