Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738BC219CF5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGIKGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgGIKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:06:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F1C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:06:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w27so1190966qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYZh0HDct7EvWrh08V2VUFBZGUG8j1YW7X9xdQQstqg=;
        b=JssfrsI9q4a9e/ZI7loh1iE1EJ89c+4Jo4Vznfaao/PSuhSZ9w59Vea2lkPHoQ1nYy
         V8yDOr4iTZIkyjgAv9UqD7EZthgTxcTrCXvDv/J85BkD8XAxKPh+Qknl3sG4gfRty+3D
         Ble9sHQeIfzv27PeL06xqDQbNJt4DT//GJAxwKJBivVfAwY8IueNqVKkaSXU1dfPKjSP
         0TaPUE/sCknBUPPuYKYUwVq5HKQ78QWoJg0Zii5AdXcXZ938sfGSNPblu0PCMgj+Im2K
         c1E1xnVG/QSDkJa7j/jm1I89QhJ9Hg5QW0VMhFg3niRinw9sgF55+XKBZKvYdwN+K5RQ
         akFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYZh0HDct7EvWrh08V2VUFBZGUG8j1YW7X9xdQQstqg=;
        b=sXuWWY7Ppql9XGy8deZgOjZ4AQGtWEilpHrd3s1e6uqgag8SlMNjDANup4/6Lw+HTL
         kVTMJy7T2Y6uWfvU6eerRgictDBQxlkocC7hUQ2ozJvZk7fQnU/qA72rbUlZHJKSqHGu
         IuxH+Vv+Shi5jnZgFe8ujS/BZoyWQpIob7Z+beFzdu3OQpXIzn6m4ptsM0WeY94KzuRX
         utIS/sI9utIqACGvd1gKYhQYcIB8NeKTjJW0zZmoowAVoE1IKmoUr7xohojqaPM2oWvL
         uaXw3M8z6AZKWvAWUjP4i3Ki8ch1GFyqBGZjuJ2+lwO9EfBztB3Om/uopb9qtMy6+p6v
         eC2Q==
X-Gm-Message-State: AOAM53111boH3X8n4er2BPDKObIJLrPWKgEeEYdiPZ035rmEA6wAz7Il
        +v6fNAgLXbujYxq8kdx6PtD/qYi8IYFVipTtJewXmM8s
X-Google-Smtp-Source: ABdhPJzF1XdYKoYcEH2fBYYgsSptyJ+OeZOdaCdGgxgRYXL/oYNVmi9EN0IelvN/YIe700361hL2bl0v7rxTcpS7Hy4=
X-Received: by 2002:aed:21da:: with SMTP id m26mr45842495qtc.197.1594289193967;
 Thu, 09 Jul 2020 03:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200708041600.768775-1-warthog618@gmail.com> <20200708041600.768775-9-warthog618@gmail.com>
In-Reply-To: <20200708041600.768775-9-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 9 Jul 2020 12:06:23 +0200
Message-ID: <CAMpxmJUbd6tFp12q7+iEW5DUEvLdDKhnNMRChatRUUzvshC=iw@mail.gmail.com>
Subject: Re: [PATCH 08/17] gpiolib: cdev: use blocking notifier call chain
 instead of atomic
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 6:19 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Replace usage of atomic_notifier_call_chain with
> blocking_notifier_call_chain as the notifier function,
> lineinfo_changed_notify, calls gpio_desc_to_lineinfo,
> which calls pinctrl_gpio_can_use_line, which can sleep.
>
> The chain isn't being called from an atomic context so the
> the blocking notifier is a suitable substitute.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

In the back of my mind I still think I chose atomic notifiers for a
reason but I can't remember it now. Anyway, we can apply it and see if
anything bad happens and potentially just revert it.

Bart
