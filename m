Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92ADE2C661F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgK0MyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbgK0MyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:54:15 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CEC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:54:15 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f18so5802924ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vkFn5MkJ5eHFvGe+cSGhjvF50/P+N434NKcke2py+jk=;
        b=AA2qPhXsKGN1XSpp/ecMKBH/+y59S29puXcMtCdXmxAihXLqjwAgcw+5ft/XbW4YFN
         8C+p3hDTO9T3Ifp7WBMtU4I32Wo5endD2EwqljyadvpOG0HuVEBCW/FRbjxyEIJylCEE
         iegsUHwBSZhI+NFU4S0QhGpnRnaZNfweDEbyBsO97S/c0eXCxpcvwF9M8aDMPXcRmDJF
         y1L8rbs+j9Fp3OJBELKR46YO6UBjB+pTIGD/mRdms7u3Rnng302Mp6HrXri4e/RDiud9
         HHdUjvfh9Pa+ap9QVh4+s1jSbQMHhoIH5slEaGNqixT4l2OtsDv+I4gU9UQb8glC0VDW
         o/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vkFn5MkJ5eHFvGe+cSGhjvF50/P+N434NKcke2py+jk=;
        b=bg6bTXBIOyuU2w3wP57gHbqHqMPIrjiwKRHo9Jkfm/01lZCHPMtOusDAwo1wK4CV4p
         FmOtGuqctzvNjJrFLsYHnHDg//aX6XKx6pZA6PKCQRm/6LRp0QQP7PO37y9nMh96ooOv
         w8XI+hebwlswE9J1KWhL9Q48xCXNBzrmSpeR/7lQj2tSWuUocKJwCN1JojHhRtBOSUJO
         Q+Mxa5xOqmyBUNscWkDgRKQtGnb9fsxZi4+2dgbvABSB97++OXl6QppThIiy1O7CNXJe
         u52bstkexgiBQLad9Iik2UJWe+Wt/q9FcZfWLiDC6fffA9mbYYzCqaw171sWH4Jc1ECN
         aUSw==
X-Gm-Message-State: AOAM531ZQbopzXot6pvlGzPxuQs84B92XnzxLqZCLqzk89Q1UTehMuEt
        C2ZaauGBG3VcRbGu8ECrnJBmZ7kKnCjzwatw7sry
X-Google-Smtp-Source: ABdhPJxnpJuH1qCcyBG7IdsjjfT2699qABDMeft535WgILhcwKBQromZU8ced70LvOULG8f2QdwuKZNaKM5pVqsXHGQ=
X-Received: by 2002:a2e:8910:: with SMTP id d16mr3480658lji.295.1606481653890;
 Fri, 27 Nov 2020 04:54:13 -0800 (PST)
MIME-Version: 1.0
References: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
In-Reply-To: <1606479915-7259-1-git-send-email-ingleswapnil@gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 27 Nov 2020 13:54:02 +0100
Message-ID: <CAHg0HuzKb0e21bo3V53zskKtk+zaJXhxkU8m4w6Q2DWoWPkU6w@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Adding name to the Contributors List
To:     Swapnil Ingle <ingleswapnil@gmail.com>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
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

Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>

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
