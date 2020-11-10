Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698E52ADCBD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgKJRTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKJRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:19:32 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E707FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:19:31 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id g15so12887010ilc.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m76wOL9hJIJoG0AO/e/uP7Uo91cnrGUskfUQcXSEJaw=;
        b=aUpZC7ktAb3pkvosG5hyA2UaagJt7W8t8r+Klze5728P06woK0Hop3/1nyOuBXNZMK
         y255tazkuEH7++moKa2Q01NtPlRzKa0QbEjbWF/KTGg5+ny4XajqUNJOdAoSRDEnjLKX
         EATzsf/HUdwPrLsULwfVG+iP7zQh6d28EH00g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m76wOL9hJIJoG0AO/e/uP7Uo91cnrGUskfUQcXSEJaw=;
        b=ll3d24SH6j0LqdRCRl2jFiRzGfQX6H2AMLdoES2MsPOBl1pCG5EE0Sfh5wlAEbBtWZ
         3xuhjAHow2iX8pMyRKkLJDKSIrbziRuCY2HxyIBFy/czHQ4wkT8lxsXu0MO5XFA/s5Vs
         5TBSU53QdqZ7wwXmtNw2RsDXJfljjLch0zuM/bUFZgiQK++Bs2s9DxssvKvt/pz9uTKU
         eVcrQsZLwgwc3Gl3ZzWcxaJSH7oEw2ETWe1BnPFJj8EQ+3snUyQ3i50wkLWT+DT0SBnl
         X+yJBGP3VUh0XcLNhztaG5GV+5KKz0/BjVA130tuRnvVIDzoX717zlXRJO3QC8QHF5vo
         ijIQ==
X-Gm-Message-State: AOAM531xdlBEpLMu2bG27JgOORM3JrU3Vt58tIrGvWNVmqDt43K8HvlQ
        YteynycBIf6U+YIOMvm8IXUvLg1xZWMNk+YNtE/2XA==
X-Google-Smtp-Source: ABdhPJyOZv4c/23PoTtO1kXkANOtS7NNt3q+8JYWMPUQzsFB4WGg2bwqjXqsXfBkXcGeHkODJ5NajYAYvE6PE8gBJ/c=
X-Received: by 2002:a92:d60f:: with SMTP id w15mr15072739ilm.235.1605028771245;
 Tue, 10 Nov 2020 09:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid>
 <20201106071107.D7CE3C433C6@smtp.codeaurora.org>
In-Reply-To: <20201106071107.D7CE3C433C6@smtp.codeaurora.org>
From:   Abhishek Kumar <kuabhs@chromium.org>
Date:   Tue, 10 Nov 2020 09:19:20 -0800
Message-ID: <CACTWRwtjvQYUvbWHrajNRkK_sDZRv1hr0kp+o1=6504qv64qKQ@mail.gmail.com>
Subject: Re: [PATCH] ath10k: add option for chip-id based BDF selection
To:     Kalle Valo <kvalo@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the delay, was busy so could not work on V2 . I have
started working on V2 patch. Will upload by today/tomorrow.

Abhishek


On Thu, Nov 5, 2020 at 11:11 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Abhishek Kumar <kuabhs@chromium.org> wrote:
>
> > In some devices difference in chip-id should be enough to pick
> > the right BDF. Add another support for chip-id based BDF selection.
> > With this new option, ath10k supports 2 fallback options.
> >
> > The board name with chip-id as option looks as follows
> > board name 'bus=snoc,qmi-board-id=ff,qmi-chip-id=320'
> >
> > Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Tested-by: Douglas Anderson <dianders@chromium.org>
> > Tested-by: Abhishek Kumar <kuabhs@chromium.org>
>
> There were few checkpatch warnings which I fixed:
>
> $ ath10k-check
> drivers/net/wireless/ath/ath10k/core.c:1501: Alignment should match open parenthesis
> drivers/net/wireless/ath/ath10k/core.c:1512: line length of 92 exceeds 90 columns
> drivers/net/wireless/ath/ath10k/core.c:1521: line length of 92 exceeds 90 columns
>
> The first one was also what Doug commented. I also added Tested-on tags,
> thanks for those. The updated patch is in pending branch (soon).
>
> But is this patch ok to take now? I didn't quite get the conclusion of the
> discussion.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/patch/20201020000506.1.Ifbc28707942179f1cefc7491e995814564495270@changeid/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>
