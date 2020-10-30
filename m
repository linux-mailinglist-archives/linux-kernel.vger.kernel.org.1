Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853DA29FC32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgJ3DaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgJ3DaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:30:19 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C14C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:30:17 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id f7so5377651oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oMY9pxFypCz+sF9iqPwWsJbC9qvwpmj8H4dhF+NfdQ=;
        b=Cm2BCBaE0HkCTyOU/fbadFmrRd5FXxeBg8UMkDSDS1j6UyRSiTx5urdd8HHKLA6zHR
         hY06B2HqNpN+dCebixLmWfx7eJpaIQ4VrKXtvWStO+woq17+xkAiZkij8073l2qZVMfM
         /yge+eZBZQbEZ/DBrYRiyEwSv4qYPr5cGlc8O/WbKQmnfcMStPl+g4wLrSNImh8CLwEI
         32NkObz9twkgzIWYkvMls7X2hNLrhSJiqi21XNx9Ccop5rYvlKeKtv+Okwy0RirNRC9k
         UhOiE8R4dvHFjQ6CydKSNwMesYjB2yeiEnVXHYw6SK2UD0VGcyum+RxmbZdvVbJBb7FG
         MbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oMY9pxFypCz+sF9iqPwWsJbC9qvwpmj8H4dhF+NfdQ=;
        b=Fxn8QBwyLw1TWv59XZwWaUlQHPF/ybi6l/7LETvkhNVEgfUVoTqlek6jdP7mIhHHiZ
         EZLxYblmTF3XBcj+ZwTp/CMSTtJq7rLgRvI76BZp/Sm50VgaBrbSL+Yo7cMlkgfmc5Nl
         EcsZhYRbhk0sX2oHazsnUUNNHFUDQGWp72mk8rYRTRxGIS9C173I0etjEUOlHW2DDPSv
         vGkgVAfPqBS8oGSi/fmI1ba2og+5A3Icroqj1ECwh2EQu2TP/p3RRqWOki8IFZn0jV+9
         65WSaAnndWWOQPcCYsoMXDhyvG0MqB44eGjWRNhW5h2tInO9I5ggGUq/i4k2VEPD7b69
         3D2g==
X-Gm-Message-State: AOAM533tTOEZRkMFVjdJJrUZE4a41LJ+mWZbw1sbmpkkngVAFth/DXIR
        LGAnz0HxZNvnqg8pK6AB+a0l7P9TSjFdmVV6bM/eIQ==
X-Google-Smtp-Source: ABdhPJyoYlDfNB9INSs49MENv3IRsfUKToKB7mwBdmNjsIcA5aDVVdbolYFcxBttTKe/8dItjxvA3P8hwe661BVNN2c=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr224448oia.169.1604028616954;
 Thu, 29 Oct 2020 20:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201030023427.3078-1-hdanton@sina.com>
In-Reply-To: <20201030023427.3078-1-hdanton@sina.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 29 Oct 2020 20:30:04 -0700
Message-ID: <CALAqxLU1=vScNWfxc-Ji9F_cY311z8GuFLiFT0q0PrDyJVxViA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] dma-buf: system_heap: Allocate higher order pages
 if available
To:     Hillf Danton <hdanton@sina.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Simon Ser <contact@emersion.fr>,
        James Jones <jajones@nvidia.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 7:34 PM Hillf Danton <hdanton@sina.com> wrote:
> On Thu, 29 Oct 2020 12:34:51 -0700 John Stultz wrote:
> > As for your comment on HPAGE_PMD_ORDER (9 on arm64/arm) and
> > PAGE_ALLOC_COSTLY_ORDER(3), I'm not totally sure I understand your
> > question? Are you suggesting those values would be more natural orders
> > to choose from?
>
> The numbers, 9 and 3, are not magic themselves but under the mm diretory
> they draw more attentions than others do. Sometimes it would take two
> minutes for me to work out that HPAGE_PMD_ORDER does not mean 1MiB, on
> platforms like arm64 or not.

Yes, I can say it took me longer than two minutes to dig around and
work out HPAGE_PMD_ORDER for my last reply.  :)

Though I'm still a bit unsure if you are proposing something more than
just a comment to explain why order 8 and order 4 allocations are used
in my patch? Please let me know if so.

thanks
-john
