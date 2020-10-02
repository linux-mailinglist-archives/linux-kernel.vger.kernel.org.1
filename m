Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1EB281A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbgJBSFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:05:02 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597AC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:05:00 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id 5so1039164vsu.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z8oT57QjyXZZ9y7td9vy4wNcedb44ceZQ7PhsHZieuE=;
        b=SvlX4EEX355dRtFUTXfZgfzLkskG7/cuhJsCvF9/ugjWKtukZTQGqDNo6OPCBM001+
         Hc9q91/NjeOBcW1XscPjxZAH4DeSeP4hdwmOZ2xNF4qX9SXEP6Fj7eEO52OfeUtyo8P4
         +b6xT6oFAnODDg6Uw8KtlABp2I9+yqaNDTAtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z8oT57QjyXZZ9y7td9vy4wNcedb44ceZQ7PhsHZieuE=;
        b=bkJa3KBF2PnQSMjS1Ms1Zz404WS4zTAVCWIfWpqU4SqhpushzN22yJYT31XUuDWymd
         /Dprm44YzqtEO2MzSRq6P+/LivJoP/y8Uf1O3uY+huAV+Wh36MIvQNX1HodMenhMc7Dw
         s6lvYFqoVfj2T/+D6WwiGTuwWp/fsxW9G3WHxbjGAzk7IU92I0IML99Ps6yBUbW1XL2Y
         fG9/DbO/Uz3bmasM5CvNdu2n78qYS6Ap8n/Q+ApfzvllP9Pp9v0HDyjLv8GIQ60aBecs
         vWKr6thfiW5l/j5cyOFx+bazAi9fETzI7M/BDl/O0wHmXJSC5Ch1rXv/UWA5eDey5KbR
         DZcA==
X-Gm-Message-State: AOAM530+4CHahcjxAe3/USYXg03LjR9zKl/I8oddLN7bwtzvtUfenr3I
        Ge6KAzGtcAKqTxRwja7w4nLwf49lVKzqhQ==
X-Google-Smtp-Source: ABdhPJxy0T2Anpb2aETI7Bts8ZKHk2GNabPXD1Au6qu0aWvQuALjyvGbNwoSEYVwkBqrixxQ0fRsrQ==
X-Received: by 2002:a67:ee1a:: with SMTP id f26mr2142387vsp.48.1601661899319;
        Fri, 02 Oct 2020 11:04:59 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id b23sm347761vsh.9.2020.10.02.11.04.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 11:04:58 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id q13so464799vkd.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:04:58 -0700 (PDT)
X-Received: by 2002:a1f:a905:: with SMTP id s5mr2121949vke.9.1601661898118;
 Fri, 02 Oct 2020 11:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201002170526.15450-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20201002170526.15450-1-manivannan.sadhasivam@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Oct 2020 11:04:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W0E2_2PXHedyiTeXbK323gDiSSJyx9n6CMX5D9oR7CNg@mail.gmail.com>
Message-ID: <CAD=FV=W0E2_2PXHedyiTeXbK323gDiSSJyx9n6CMX5D9oR7CNg@mail.gmail.com>
Subject: Re: [PATCH v2] net: qrtr: ns: Fix the incorrect usage of rcu_read_lock()
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Elder <elder@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 2, 2020 at 10:06 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> The rcu_read_lock() is not supposed to lock the kernel_sendmsg() API
> since it has the lock_sock() in qrtr_sendmsg() which will sleep. Hence,
> fix it by excluding the locking for kernel_sendmsg().
>
> While at it, let's also use radix_tree_deref_retry() to confirm the
> validity of the pointer returned by radix_tree_deref_slot() and use
> radix_tree_iter_resume() to resume iterating the tree properly before
> releasing the lock as suggested by Doug.
>
> Fixes: a7809ff90ce6 ("net: qrtr: ns: Protect radix_tree_deref_slot() using rcu read locks")
> Reported-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Alex Elder <elder@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>
> Changes in v2:
>
> * Used radix_tree_deref_retry() and radix_tree_iter_resume() as
> suggested by Doug.
>
>  net/qrtr/ns.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 57 insertions(+), 6 deletions(-)
>
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index 934999b56d60..dadbe2885be2 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -203,15 +203,24 @@ static int announce_servers(struct sockaddr_qrtr *sq)
>         /* Announce the list of servers registered in this node */
>         radix_tree_for_each_slot(slot, &node->servers, &iter, 0) {
>                 srv = radix_tree_deref_slot(slot);
> +               if (!srv)
> +                       continue;
> +               if (radix_tree_deref_retry(srv)) {
> +                       slot = radix_tree_iter_retry(&iter);
> +                       continue;
> +               }
> +               slot = radix_tree_iter_resume(slot, &iter);
> +               rcu_read_unlock();
>
>                 ret = service_announce_new(sq, srv);
>                 if (ret < 0) {
>                         pr_err("failed to announce new service\n");
> -                       goto err_out;
> +                       return ret;
>                 }
> +
> +               rcu_read_lock();
>         }
>
> -err_out:
>         rcu_read_unlock();
>
>         return ret;

nit: you can go back to "return 0" and get rid of the init of "ret =
0" at the beginning of the function.  The need to "return ret" and
init to 0 was introduced by your previous change because of the "goto
err_out" which you no longer have.

...this is true for all your functions, I believe.


> @@ -571,16 +605,33 @@ static int ctrl_cmd_new_lookup(struct sockaddr_qrtr *from,
>         rcu_read_lock();
>         radix_tree_for_each_slot(node_slot, &nodes, &node_iter, 0) {
>                 node = radix_tree_deref_slot(node_slot);
> +               if (!node)
> +                       continue;
> +               if (radix_tree_deref_retry(node)) {
> +                       node_slot = radix_tree_iter_retry(&node_iter);
> +                       continue;
> +               }
> +               node_slot = radix_tree_iter_resume(node_slot, &node_iter);
>
>                 radix_tree_for_each_slot(srv_slot, &node->servers,
>                                          &srv_iter, 0) {
>                         struct qrtr_server *srv;
>
>                         srv = radix_tree_deref_slot(srv_slot);
> +                       if (!srv)
> +                               continue;
> +                       if (radix_tree_deref_retry(srv)) {
> +                               srv_slot = radix_tree_iter_retry(&srv_iter);
> +                               continue;
> +                       }
> +                       srv_slot = radix_tree_iter_resume(srv_slot, &srv_iter);
> +
>                         if (!server_match(srv, &filter))
>                                 continue;
>

nit: move the "srv_slot = radix_tree_iter_resume(srv_slot,
&srv_iter);" line here (after the !server_match() test) so you only
call it if you're doing the unlock?


I'm not too worried about the nits, though it'd be nice to fix them.
Thus, I'll add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

...though I'll remind you that I'm a self-professed clueless person
about RCU and radix trees).

I haven't stress tested anything, but at least I no longer get any
warnings at bootup and my WiFi and modem still probe, so I guess:

Tested-by: Douglas Anderson <dianders@chromium.org>
