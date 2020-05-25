Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BFD1E0B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 11:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbgEYJ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389492AbgEYJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:57:06 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93363C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:57:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id z5so7833834qvw.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lXJcON4uIxpNxBwaXZsOO47XJesOn1/BpUPO8EArG+w=;
        b=qvMmSe1XAwiiXDHUShXrjRlC8kHXfgYHjV+edzVEs9diOiTb51gVIu8DIFR7Kl1EEw
         5Y6sFR/4qt/etZj+zXMQpnJBCOEpUeTwjkyvlO8aenAuL6yYXWj5/o20G1wXUq4flko1
         0Adu+aOLsPFZhSXfJTg9dh9NB1pX3j29lBaIeuFGFuoJIBmUZdgqF8H4jTnEgquDqytC
         ME1ipTZN5l8O/AB/Fdssqx02XGyIdC7XSoDAlDbHzQ/3e7envCluBo7IUnF4+C/82B+t
         JcEk4VlBKK5Unrbf4qGqJeVpeleWSKtRNitNo1bP6Ul6mHjKPR/3XdUzUOIYp4Q/Az14
         0fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXJcON4uIxpNxBwaXZsOO47XJesOn1/BpUPO8EArG+w=;
        b=WVFsQGO/Uzbl5XN+dfw7mYdjJIZjQE9iioyf6IhgOz02afWDl4b6OKHloufMno0wH8
         7e7DGfd0I3QautuuORJv1znBGfQtRTrlmBK6yQyIUG5/d+xqxmEReyjFteuEGb5GQ/Di
         E2+usda9NE7MtyLJOno6MaipUOzPzTQ1bfqXS9W8JftDbNPvG1HchwwR5w3+bu6ejqDz
         sT3msZAP9F43JJRgatmQGHh7M74tntDcNKl8ZLDeVmAESCtAdT08uH/sNjh1x9kT5wu6
         FSl2UG7pfGZVo/9i/kl6DRzMpcgrmkElzyDSDaCEqE7ETsjhw7S7MHhq4uyrmEnKCJZU
         Fk7w==
X-Gm-Message-State: AOAM532YAFaZAbctAE+ID6kAqAhnCVp+Lh+DcVo4Gh/Xr+JQljM8JJfu
        /1ikrf9gsS2pd/em1+/YxKSYiDIGXC66xM74C9BWag==
X-Google-Smtp-Source: ABdhPJwu98seAlM8B/W6iEB7Cgc17dFjE0Ji2BN+7kajKF3ry3QeBw893G/4FHc1aJT4/bDywXnEMDItzUTJpwb33p8=
X-Received: by 2002:a05:6214:15ce:: with SMTP id p14mr15030956qvz.159.1590400624833;
 Mon, 25 May 2020 02:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200522020212.23460-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200522020212.23460-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 25 May 2020 11:56:53 +0200
Message-ID: <CACT4Y+agmL5ZOWmNBJyLSTuhy7ekp4HTafABUsqqP+XFd7ErKw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] kasan: update documentation for generic kasan
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 4:02 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Generic KASAN will support to record the last two call_rcu() call stacks
> and print them in KASAN report. So that need to update documentation.

Reviewed-and-tested-by: Dmitry Vyukov <dvyukov@google.com>

> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/dev-tools/kasan.rst | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
> index c652d740735d..fede42e6536b 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -193,6 +193,9 @@ function calls GCC directly inserts the code to check the shadow memory.
>  This option significantly enlarges kernel but it gives x1.1-x2 performance
>  boost over outline instrumented kernel.
>
> +Generic KASAN prints up to 2 call_rcu() call stacks in reports, the last one
> +and the second to last.
> +
>  Software tag-based KASAN
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200522020212.23460-1-walter-zh.wu%40mediatek.com.
