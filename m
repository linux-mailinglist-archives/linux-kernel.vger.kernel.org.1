Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70192BC4B5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgKVJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 04:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgKVJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 04:26:20 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EC8C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 01:26:20 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id g19so13102029otp.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 01:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cAfiTUIi51Zz1nSxKjmyN2eOu7EUD/alyMpW55bSe4=;
        b=nVO6DSBoAw/G5phgnfeDSdFqoUccaAFQGv6ZWl8MNh3tLuDIcDxEOkatRdqudo03x0
         xZehrlP83C7fSvTirhyj6tsvMI+UkhmMR2N+WHNR9ctdctG0Ez7y6DxNjndy0thYO5zu
         LIN0tNGOXE3nYq7KGuJMiT3fSmVUqy0aHceQCbWAz1l/gDZsCENQUQkomyicMkYvGBo3
         efaELh9etcDLIBVJg1QSKhu6YWNSJeuvpkeMAsyukqEVuZ0ReJqCTX7LzAsZr+Q/pLLt
         mjf96x3DmJF9A6ur3Vf04oXbzsyv609cA8irt1MJLtCysgtV7zJK98Srsb+XAmZeRZ2Y
         231Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cAfiTUIi51Zz1nSxKjmyN2eOu7EUD/alyMpW55bSe4=;
        b=O5aNE3LGi3E55+Z7Cj3cEY4fAi/bcGUm9KbbuRWKNMdKjmfTdKqJhKnYmfEY9noxVh
         iwg4nHbdl/pg6Za+zUw89egcCzade8hTMue1lij0S9oXVLntoOX0TP8ttMYVwasGevut
         oVK1+5PC92T+LMRrJwsUQZDYqQmPZxAAGPVtFbVSd/Me6XifuAmSFQx0F3Q1cU7M/30d
         f5qPSl1ZH1RZQzLChb+ao9l3P1KQ1YYHErEkAF+0vWZE2U4UfWseBYeKJ/iQH6ehaVNQ
         V50LrS2i9hRVEbmkvxzsB/DrQPv0w8ocjX5SK5lHGlV7srtB9GpszzIJbHklcx+y1Elc
         DHgg==
X-Gm-Message-State: AOAM532Lx3/TnsiOC7q7I7EUkloKJz57nv/vVzM+L/OQWyssU+8mLrZr
        U3euV33kjlMHj6zcludDTAsa1qNDbL27VT1qU2N7a04jOkII/w==
X-Google-Smtp-Source: ABdhPJyAFibWOCLIaKkVKGwSOtGD6nI0mtsN1dU6rQR2CZXLXD5JnFVkiZxDBFr1vol4PHRP3TNJKH4IDX2AJyCZNUU=
X-Received: by 2002:a05:6830:1c8:: with SMTP id r8mr19676586ota.324.1606037179862;
 Sun, 22 Nov 2020 01:26:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
In-Reply-To: <c505109fe0c02f648e16caa83d8a9773afd696b1.1605896059.git.gustavoars@kernel.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Sun, 22 Nov 2020 10:26:09 +0100
Message-ID: <CAHUa44G1B8_CSahTJ1uOUMLcDfpVKHUaoN+u87BywkVwyhjnRw@mail.gmail.com>
Subject: Re: [PATCH 061/141] tee: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 7:33 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
>
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/tee/tee_core.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens
