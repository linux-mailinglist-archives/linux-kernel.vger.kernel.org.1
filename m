Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369CC28FD00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394311AbgJPDzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394304AbgJPDzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:55:01 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFFC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:55:01 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id f140so809141ybg.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 20:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ot9Zov/qEKxuoRmgcLQBBrNfhdxpMJD/QLZntt713ng=;
        b=uhPd9yZn3+rZNSdCV2aeR/Vr8d27UrrOV3KjvykP/RqxuCqhbYT5MshXbKCn5q62mS
         u3gFJph/6LwXgnCq8jiju+l+Bua6+6vQ7jwSzD29qsuWk589RSupqu/lBtshlZ8dpi2J
         1CmN9KVEHn/bqbUowVt9TDa7wb7Ai6/KJX9ce8nwQRouMMdd0GMgs21aIN6QZQGVw+wb
         Y+679YVN/C3OC+sjVyNkFBJPoQZzwBjzoDm5WgzCQISbOvNE483LQJZZZx8qjAHU76ud
         nQrDdtqOCjQDu87gOQDw2+FdvBExmzUNLXdycAAOj3DINzyyIFNyT3Ic+eHMZJpjapUQ
         S3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ot9Zov/qEKxuoRmgcLQBBrNfhdxpMJD/QLZntt713ng=;
        b=ZN426GtJKAXuIfR+kUzpySJNmGzlIqDO4Bmp3O/s27puQLlLg1n+VCYt3sRwTBxL7S
         gBxV8+c4wQfl2N1BCXa1cWsDpbXs4Z7VEkwfGP67xpMyLZO1GsapxBKHP2LixGktIorY
         BrR/tglKUmzVTSH9xmg/eFNkKsy9EmibfWzrkAZOPohNg7WMpnzQM40pOKtWbAwr21bq
         /a8ObUrRC4IlWXfg5ieC9XraEgBBBl0YAYZ1pgd9RN5I0Bw4rvmK8SnFyfBsEvrcAGNy
         TuREZ4W5Qyqo69R7+3ZtsrdBsfNMkDWtT1BWoa5L0QXmJn7sVvK7tgHlwxxaf0XWF9ug
         QfbQ==
X-Gm-Message-State: AOAM531UviA+SMgfUNUUTKCyjHXJNvPvZP/14/VSItMc2GVWwRl4wz7M
        19Hp6bximbQNgCNwCdJACtwuOOG9DSVn6P4TSXc=
X-Google-Smtp-Source: ABdhPJzBJUy+ssOpQulsLC0AKfwHAysHffyZwaAo+TZyEVQyrQD/MpwGHvZz8CEI4JZybhc/xovcRG7NLT1Ss3ztxyo=
X-Received: by 2002:a25:3b4b:: with SMTP id i72mr2433881yba.22.1602820501017;
 Thu, 15 Oct 2020 20:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201005122732.3429347-1-poeschel@lemonage.de> <20201005122732.3429347-9-poeschel@lemonage.de>
In-Reply-To: <20201005122732.3429347-9-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Oct 2020 05:54:50 +0200
Message-ID: <CANiq72mfmArumdLBqk-td1HAjxVsfu51zdn=uR=7etq98kYF=A@mail.gmail.com>
Subject: Re: [PATCH v4 08/32] auxdisplay: hd44780_common_print
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     open list <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 2:27 PM <poeschel@lemonage.de> wrote:
>
> We create a hd44780_common_print function. It is derived from the
> original charlcd_print. charlcd_print becomes a device independent print
> function, that then only calles via it's ops function pointers, into the

Typos: calles -> calls, it's -> its

> + * @clear_fast: Clear the whole display and set cursor to position 0, 0.

This one is optional, but the comment seems to say it isn't (it is
later removed, so in the end it doesn't matter, but probably we should
write "Optional." here too).

> + * @backlight: Turn backlight on or off. Optional.
> + * @print: just Print one character to the display at current cursor position.

Typo: remove "just"

Cheers,
Miguel
