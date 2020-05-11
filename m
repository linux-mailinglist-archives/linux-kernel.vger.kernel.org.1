Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A31CE264
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 20:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgEKSPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731028AbgEKSPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:15:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0241EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:15:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c12so14929397oic.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6mgvjghZiYTF9zH7EeHRTUDg6GuL2xPwV37xssz6FIw=;
        b=vtmAc/wdbIs4w7yFUzlqE/S89iEkcxv6b1eS/OYEtdJOaw1Alx1MAww5YzT2zvZHSv
         itb4PNSLC/D14+IOMaFq4vugbibA+U+1yXqa6r209fGMKw7GbM/0Ly2WyGTAHRu/RDD5
         pHb1T8rITCoIWAXGxgk+UMY45Fp2CtawWc++r8udh/nqpgH2FffdHNbIODk/pTgC8fHh
         pD7mAGXmKihQeswPYHB6eQLvZcoYfP1f8pZ4genVWYYV+w8MYSF2D5crAsS8GQU8HDxo
         ee9mRuSWuQa61U5FsijQDE9MMeRjWPXnC2BPWUSsleSvvlg82a8zCWIE5TngjUMrRJo4
         wbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6mgvjghZiYTF9zH7EeHRTUDg6GuL2xPwV37xssz6FIw=;
        b=jffEyAB8fk7LEbi1qDAXs82Kxr/NL3cfBj7ppNSq6WhOOHxz2lr0IVseLhx8C8up+q
         kNeyA21tUzHCBdnhqoG5pvk9NfiCJHcTEvQ6bwi8PhICR28wHe3wnDG3y2v8FVHGsyUz
         qi5JbohbfbEmVMU5QSzzTGJ4A/PaHp3Emp8oZWpqJ2LAe3XjXjwYvtZPxFNHhik7ha1r
         liq9Py8r2Blu2hOua0mdClqXLWlj2p05DszoLt1VXUIMJdHK0RF7eutEcqzMIB7is8VW
         BERsR01J7BTkLsBbBKu4fNm1/RDAILwwRImsFAiJz34CymWafFDDiR8L+uSHlUKZAAFt
         WOgQ==
X-Gm-Message-State: AGi0PuZF71xHLwrPJYt3kLB6nxoh16Kv/tk9veidTthohscdWF5DI5oZ
        ICwvtiEUZB0dR2WkhPIPpSycjs7cRSAPI7C7v+F+PA==
X-Google-Smtp-Source: APiQypLSdJT4xHf4H+XN7iHPQqXxy0Box30MtYmQzmNbxOVl887RMLB+Lie+VSGxraK1T2rWKPgxAcGRDaNaX7KIhsg=
X-Received: by 2002:aca:3254:: with SMTP id y81mr574945oiy.172.1589220936906;
 Mon, 11 May 2020 11:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200511151334.362-1-srinivas.kandagatla@linaro.org> <20200511151334.362-3-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200511151334.362-3-srinivas.kandagatla@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 11 May 2020 11:15:01 -0700
Message-ID: <CAGETcx8p95B0FpSmibSig7N=B=ZLZqyF7CNwvoht6OaJuux1Cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] slimbus: core: Fix mismatch in of_node_get/put
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 8:13 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> From: Saravana Kannan <saravanak@google.com>
>
> Adding missing corresponding of_node_put
>
> Fixes: 7588a511bdb4 ("slimbus: core: add support to device tree helper")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> [Srini: added fixes tag, removed NULL check and updated log]
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/slimbus/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 1f3beee74fdf..ae1e248a8fb8 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -282,6 +282,7 @@ EXPORT_SYMBOL_GPL(slim_register_controller);
>  /* slim_remove_device: Remove the effect of slim_add_device() */
>  static void slim_remove_device(struct slim_device *sbdev)
>  {
> +       of_node_put(sbdev->dev.of_node);
>         device_unregister(&sbdev->dev);
>  }
>

The edits look fine to me.

-Saravana
