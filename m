Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EED2C65F1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgK0MtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728910AbgK0MtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:49:16 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B79C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:49:15 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id l5so5564654edq.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLxlW/gEhLdaoeknORQbB3xpeNHDsUxRze8Z8bH4egc=;
        b=ShRJZTqQ5FfdO4ONy4BOdejADoVoxPejEMT5ZCwrog94iqOpSC9bV+Hx7iCD5Yyzcf
         xwQ9ERuCouISSaGxHRDlPxZhKNTUIZyTTM9MuFlWerBDQrCKlUfvxCP+xJ5BD2AxYIFJ
         2UPER0z03O3hKBw64agptEeOoqrIatzbDy0FDHSnXlpdkslw/lhvvv3duBN8bzULxnGr
         34udYFCSayv/T4VJ7xuKF4qm89fIjASK1e9kQ76CYAKKcwewyFOt7xHGIPwcbmiqyTe2
         Vn4CR2dH5t4PZxFAJWxSuoGaEBNZsuI7CSLDKR8vX+vV/Gpu0pB60KvNp/3ZRE3BV0q8
         1RHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLxlW/gEhLdaoeknORQbB3xpeNHDsUxRze8Z8bH4egc=;
        b=AjN7NgiQf3uxO0zLdQ/5Cjh66uCTJORJEmnABfqFLlaWPVh0Co4LdwWyer1T7TxoPQ
         6VgB1FyCM1fr8Beupx/jP5XBUwBTQSdg09SGCW9IaeKVqgk0AFkrBUpM42ZLzwzQr4XW
         GY8fMakm9+BuJm49wsnAcAJ3pOypsgyJ++GhwxoOYcM98sSGpN1JV47cCH9ljUhGPEqB
         j0H7Ffl6OpxCy0IwjSQ1y4alBg/yhOx3j5sVe6yQcOuM+B9MHqnH5AgkSMLM/h95QFNF
         +WlGkb4dm/zEJSwxhUfKGsHaxk3nB3LC4Y6F9EDdbL+v2ZTcQkFxhd4eKhM4Fa40xpVG
         fhCQ==
X-Gm-Message-State: AOAM5311qV/DSfy72I6LvILehTdzIPf5Q9IlByGEtjNQmwMTvJ80yKtd
        DU6syT0IL5yJ4F8hfXfmKlQf5DL8dq/aiFV6Ysqn2g==
X-Google-Smtp-Source: ABdhPJyiCIe+eQjcHroPmqnP59s6SYoo9yIxwORecYyCI3l02nP0cUJvNwqxcWOmRmuJ0dgWwUGjnpcRUy/iey1aITg=
X-Received: by 2002:a05:6402:3089:: with SMTP id de9mr7512723edb.100.1606481354525;
 Fri, 27 Nov 2020 04:49:14 -0800 (PST)
MIME-Version: 1.0
References: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
In-Reply-To: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 27 Nov 2020 13:49:03 +0100
Message-ID: <CAMGffEm9KRH9GBP6FOTE9GUJGJzY+p3-_Xm9-BTapec3L3mu1g@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Adding name to the Contributors List
To:     Swapnil Ingle <ingleswapnil@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:RNBD BLOCK DRIVERS" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 1:31 PM Swapnil Ingle <ingleswapnil@gmail.com> wrote:
>
> Adding name to the Contributors List
>
> Signed-off-by: Swapnil Ingle <ingleswapnil@gmail.com>
Hi, Swapnil,

Thanks for your past contributions, sorry for missing your name on the list.
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/README | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/block/rnbd/README b/drivers/block/rnbd/README
> index 1773c0a..080f58a 100644
> --- a/drivers/block/rnbd/README
> +++ b/drivers/block/rnbd/README
> @@ -90,3 +90,4 @@ Kleber Souza <kleber.souza@profitbricks.com>
>  Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
>  Milind Dumbare <Milind.dumbare@gmail.com>
>  Roman Penyaev <roman.penyaev@profitbricks.com>
> +Swapnil Ingle <ingleswapnil@gmail.com>
> --
> 1.8.3.1
>
