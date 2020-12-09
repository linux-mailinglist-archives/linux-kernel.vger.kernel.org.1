Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392612D3C32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgLIH3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgLIH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:29:42 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06022C061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 23:29:02 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so1076979ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 23:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Zj5DPkVA+r8BY8grkrGXrKENzcJFViNC4dse1Xab7k=;
        b=Luy9ckydK7DY1T68dQx5nl2tqj9OEnzCw1O3NbTsjHebN8cyCaDcTGf5b3e/eBvhIO
         RWU5PJy+bNDKrfTYreYgC4KudXWXCkq1liTbqcIn6wDyeWeLqFv21eygfpYuXQXNl+sg
         ksx6uOXE5OdmvCPf5s+/yGDqyS+xeSxXqofUKY6tvKkt5VaxZZfM+EwH0BnQKIwvNtpb
         rV76jUrNhDwy2cAHeC4RZmMF6/DkdAUhA67higBnO7MT36jlK2/yr8BTPm/sNsXstuHq
         v1HK2dApLS4dDYA67nWLlHu4jd5LACrP1PoRkhfmMR6rd9IpMNNITsLy1lK+07M3Vrsu
         BMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Zj5DPkVA+r8BY8grkrGXrKENzcJFViNC4dse1Xab7k=;
        b=tJgphWy//32R3bgXE5917C5dP/HY1ZVIN0EcWOfsDhrOkfbCOGWAfD2vc2cZwK69EU
         bPYrpWb5rbHZmzAnyyV+A7beHQ8uMbzgSeepA3Sf0te8CQ1Bzad20n3pRTYvc5XAfnk8
         8zoYfKS8Q3FYvK0POjBl4uEI+MZAafU9fm47mXPDtWJsqNJz7hgLPicdl2ym6mB6EWJp
         0QPMz8n3TMdCKtTX42+SO1bji9JWDWm1JyNsEB2AviiabxPaLPmJiuQ+Eax8dTed7i95
         538mShDuKjXq/DWIZiymUK980QEi5qGdx+n4LjBAtuvo6pTAL19hi2slA4O5HP597gjk
         z+eQ==
X-Gm-Message-State: AOAM533h9Vmr6hl4PzPbMM94I+trtAA3fS2EP6ONK1RGa+C+iw5aquCB
        6Z0Vj/FALvQmTTFvvaWWek/oYvuwg1MmaaKpqego/w==
X-Google-Smtp-Source: ABdhPJzBQTNsBD4F37AkZK4YDah2uQpxEAq65TmFGkEPRml5F0xa7RESyhXv/dbcUJQq6AViXQdh2UMsmHM8FXKK7ig=
X-Received: by 2002:a2e:8608:: with SMTP id a8mr528481lji.89.1607498940309;
 Tue, 08 Dec 2020 23:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20201208232102.339587-1-dlatypov@google.com>
In-Reply-To: <20201208232102.339587-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 9 Dec 2020 15:28:48 +0800
Message-ID: <CABVgOSkmXwWu0fG7vNqFaxxcAgJyVNpk1FPrFASkoYUWz8XMsQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: simplify kconfig is_subset_of() logic
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 7:21 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Don't use an O(nm) algorithm* and make it more readable by using a dict.
>
> *Most obviously, it does a nested for-loop over the entire other config.
> A bit more subtle, it calls .entries(), which constructs a set from the
> list for _every_ outer iteration.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
Thanks! This works great here: I didn't time it to see how much faster
it is, but it's clearly an improvement.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David
