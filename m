Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3781281CF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 22:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgJBU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJBU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 16:29:59 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64323C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 13:29:59 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e5so2408305ils.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FhLp+gt/aFZ8a4cP9x5681ANW42efWsw5G3/zOdmKDI=;
        b=X78OeGMYE53vGxb6k7lJIAAX5siDmGTwGVBI6xwQZvoBjcxdsD1qiH0bw/CtXso8db
         sytPoZj/jAHfB/8NE2BxOWXSc1ng3oP2txcd2XZwNKGihs45h/Q9uyaCjkA+ccm6c6tW
         fCvNUS0esgkVhmbkvg9SsQM7Uz/a9QFmfLHjGTIe72ahexXK800zFFqN5SjRUk+GOaMw
         O40BUylaKSQELxQAWGDYbon4oJmYAG3lpVYHBAnyQxznaZqSXXqnuaEJSyj4mM0eiUXz
         U7T1pD8DbP1ex5ZsE2ach1NoMp0bdHz+A0tcfW14Su3sVI5lBy2+Lnku86PDQuNqD/Ik
         CBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FhLp+gt/aFZ8a4cP9x5681ANW42efWsw5G3/zOdmKDI=;
        b=jqiphz7oOvxoOlxof7duLkOv6T72TNn/glat4b0w/KCRy5I9VADu4bx8xuKkWOE1ZL
         JTCi3h2l6S9PLEV4NNKRUrrW1Rh6Kl9uPuI4jNFCtuQmz1CZfQ5lnvieHFrcWj3spmq/
         xsQDNwktSZAHFbdDQVxvi2XFrvgfPnT2dRg8zoFjfUc1KyC5gbx6MbC7lo2Q3Zj2h9gn
         2FfzX09FpZnhGjf8L/SugtY/VXnm9XtUSjM6mA5xwZ6PSZJFyhksD6w6CGuRyDjJqkDN
         Qi/hj3DmKZEH3RTo6aVJQLuZUFX/OJmhZuuXixI4Gr+akuytFKWsMK/VQHwDXp8RfXkf
         K/SA==
X-Gm-Message-State: AOAM533nKNM4s+qFXPjVLogBgyD4fu4Pt+1NcvhRB6MzJIW4GnPA3PBx
        5OgdXHzt9VuGcoDPgFJGybQlXHYQ3LtTeHatAqo=
X-Google-Smtp-Source: ABdhPJyvzpaKKuH7o6oSQQFWKdaUonXVTmblHyAmich7fPwzQ1o1+ONhbgPkZQ2NRNj/1dCDzVqV+XIA1KkybHm6acQ=
X-Received: by 2002:a05:6e02:10ce:: with SMTP id s14mr3275546ilj.239.1601670598656;
 Fri, 02 Oct 2020 13:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200927230422.11610-1-chunkuang.hu@kernel.org>
In-Reply-To: <20200927230422.11610-1-chunkuang.hu@kernel.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 2 Oct 2020 15:29:47 -0500
Message-ID: <CABb+yY1zq0+sqXuSzkkX9+dTaTZgg5HJyQLC3N-yZx35QLLvDQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Mediatek DRM driver detect CMDQ execution timeout by
 vblank IRQ
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 6:04 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>
> CMDQ helper provide timer to detect execution timeout, but DRM driver
> could have a better way to detect execution timeout by vblank IRQ.
> For DRM, CMDQ command should execute in vblank, so if it fail to
> execute in next 2 vblank, timeout happen. Even though we could
> calculate time between 2 vblank and use timer to delect, this would
> make things more complicated.
>
> This introduce a series refinement for CMDQ mailbox controller and CMDQ
> helper. Remove timer handler in helper function because different
> client have different way to detect timeout. Use standard mailbox
> callback instead of proprietary one to get the necessary data
> in callback function. Remove struct cmdq_client to access client
> instance data by struct mbox_client.
>
> Chun-Kuang Hu (4):
>   soc / drm: mediatek: cmdq: Remove timeout handler in helper function
>   mailbox / soc / drm: mediatek: Use mailbox rx_callback instead of
>     cmdq_task_cb
>   mailbox / soc / drm: mediatek: Remove struct cmdq_client
>   drm/mediatek: Detect CMDQ execution timeout
>
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c  |  54 ++++++---
>  drivers/mailbox/mtk-cmdq-mailbox.c       |  24 ++--
>  drivers/soc/mediatek/mtk-cmdq-helper.c   | 146 ++---------------------
>  include/linux/mailbox/mtk-cmdq-mailbox.h |  25 +---
>  include/linux/soc/mediatek/mtk-cmdq.h    |  54 +--------
>  5 files changed, 66 insertions(+), 237 deletions(-)
>
Please break this into two patchsets - one for mailbox and one for its users.
Also, CC original author and recent major contributors to mtk-cmdq-mailbox.c

Thanks.
