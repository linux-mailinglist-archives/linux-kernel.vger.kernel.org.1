Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D738302D26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732422AbhAYVBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbhAYTqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:46:24 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ACDC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:45:32 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f11so16774950ljm.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syJuf9O5ZY7LJlX8RFLkH84nx7PJyz0ipreUlnGtkr8=;
        b=PlSjQOA16FQTRiDiYrGHNDGYrqEDyKIJLFNYD0R7oUV9+QRSealBG24kbjV4W2iRL9
         kCdVwFe7pzM98gvdHJNdaLewBijzW2qy6NV4UQtH/GCjFycHPUH/EzEekOTkhjlZzSSc
         7v2d8VitaA+d38AzYAvhdYQuTHoM4vSDEd8ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syJuf9O5ZY7LJlX8RFLkH84nx7PJyz0ipreUlnGtkr8=;
        b=YziHTMHmPPoWOVyH0VQAZK56TJtlGUpjHbC+NOpyPE/xwHMptGl4rtWS5i4Zf7PkKV
         W1+iwm/CipNBWhoGD4sNmNnIl1VKDrs44QQ5q5JQDx9ZJF1Bn2C0bh8NAcJL89Ybm1Z1
         HNgC7r5UUmV+D/W0yl8YgjOQWCaFcJfs1V7GcB/OZ026esTn/ZAF6bSdNGGImbgfG1cY
         LHcz965QYWUtJg8D1gwP45jWRUUu0AR8mAaKpkDCC0fUJ5qvrSDYnd/3FDXqJlNjAExn
         sGFYXJUAecN4q14nWUIBSO5js5ukQanmaravBYWgvkQkirtl7uI3RdXR1gMZODi1laIa
         q6Fg==
X-Gm-Message-State: AOAM530ON4loUxvY8zk0BfI2/BePfdxnefBhxyuJUZmF+bDJ9jOclQ3r
        E6/IljmTP3oaIEzviSGm9aWVT1RcPXxUpw==
X-Google-Smtp-Source: ABdhPJyxfis+JMzMGBajVHEKyxIScCtZh+9xWc9LaHA0Cmay6yYeq4rIJkJiKR8HlBf4Q1TIdmNNPw==
X-Received: by 2002:a2e:98ca:: with SMTP id s10mr977709ljj.283.1611603930230;
        Mon, 25 Jan 2021 11:45:30 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t25sm2089722lfl.105.2021.01.25.11.45.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:45:29 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id i187so9267116lfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:45:29 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr876753lff.201.1611603928929;
 Mon, 25 Jan 2021 11:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20210125190925.3655829-1-samitolvanen@google.com> <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com>
In-Reply-To: <CAHk-=wj0NKCw30deEEThF+9_F7JDobfO-VTJm64gqvp4zzsWfg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jan 2021 11:45:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com>
Message-ID: <CAHk-=wi8mBdnj7QEO9yRzzoJDc+JqfKgy1gXU9iZL8=fF=YO8g@mail.gmail.com>
Subject: Re: [PATCH] n_tty: fix redirected_tty_write checks after write_iter conversion
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Obvious ACK from me.

Greg - if you have nothing else lined up in the tty tree, I can take
this fix directly if it's easier.

And Sami - how did you actually notice? Some lint-like tool, or is
there something that actually broke from n_tty not handling a
redirected tty right?

            Linus
