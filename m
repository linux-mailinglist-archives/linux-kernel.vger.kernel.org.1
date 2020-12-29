Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964612E72FE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL2SVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL2SVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:21:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD66C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 10:21:09 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id l23so1930912pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 10:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrwZVRACwCg/e90lYyTObv+TWc0w3XAzWydYSJtQB4s=;
        b=Y/SjpHNXSo0Q6CxHwHxlkIZejG2sOseUh8O8q5fZVQ2T37sDwFAQ+epHSTSJyaYE4F
         18u2nWHLRua0oxrSXO9ID4H2ou+widD13+wm8H9ZFvsSrZGv+S3O6Rvbef5Dy2pPviJl
         LDo9WR1pPIwabqNPuh+AeuWnYg8E0wGT4KyjL5415kV8oY5atv/8PysP1SrZ00+YgRVQ
         1U5wPXLi1P1LQl70M5uDMM4EWQHtQmkdpyKOZgcYiHrpYMSCsagMV8H9OoQuQNMr1HOr
         5o18jFSKlmfNGYbZTvkjLfrNyU1iOWxWMqs1XqjMsqUpVB560INoaRRvO0LDtboxT/Ld
         FOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrwZVRACwCg/e90lYyTObv+TWc0w3XAzWydYSJtQB4s=;
        b=prjO8bYLF1yr2jMCWoXnweOIjET1gX7raIjw5o3VjTsbzryfAffRwufHOLWWvxnUvO
         uRsMqAKuXZetl92D1FcKfsvv5oUdluTXtWdMguZ/DbZNRuSaU1q+w0uUjrjYTggoLgJ7
         yT6MzgkwzjcC8hyEalF3ypMxxkqiKjebM5E2DLGuWfCbEdeyYmGlxCbC+jK7mZrdU9Z6
         XpOTfD1fXZfAfsoCNXOGg8WIQ2RXEG3lJqlbTNfG/ep6q947QWqhqHCMSwJG+Ei9Ybh6
         dZny6CsjVcWmNSQZUqZhdxXRgVVa5qIa7QNwqC+FpYdIlKt3aGqgT8bixEXc7Iq3vLpd
         kjoA==
X-Gm-Message-State: AOAM533yG/2QX0f1NZ7EvP6Spbpk/LoO+/C8jBTDRpTwuK5f1454wBW1
        780BgvC+msZOqqkqTyk65etTpbESVoS5cXrDZIiqCQnAlcI=
X-Google-Smtp-Source: ABdhPJz1LMObzBF/ro6Ksyw4yl7aw8d8AY5S2RL0w7c3Cq1DaQRpj5UTnAx+cYPX0GYWzIskEq1hvpeEsBK16o5zzdE=
X-Received: by 2002:a17:90a:c910:: with SMTP id v16mr5069600pjt.198.1609266069221;
 Tue, 29 Dec 2020 10:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20201228025339.3210-1-xie.he.0141@gmail.com> <20201228091654.1963-1-hdanton@sina.com>
 <CAJht_ENqaJtUwfcXCC2WXNJi+9_HuYX4SrY-QZd19mZrL0EHBg@mail.gmail.com> <20201229081034.2026-1-hdanton@sina.com>
In-Reply-To: <20201229081034.2026-1-hdanton@sina.com>
From:   Xie He <xie.he.0141@gmail.com>
Date:   Tue, 29 Dec 2020 10:20:58 -0800
Message-ID: <CAJht_EN5kmPLSUM=h7D_0Y=g0AwE+16jx71H8op1kFHJ8ZsbVg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: hdlc_ppp: Fix issues when mod_timer is called
 while timer is running
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Halasa <khc@pm.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 12:10 AM Hillf Danton <hdanton@sina.com> wrote:
>
> >The code path that calls add_timer is for sending keep-alive packets
> >when operating in the OPENED state. If we have just changed to the
> >OPENED state in ppp_cp_event, we should wait for the amount of time
> >set by the (2nd) mod_timer call in ppp_cp_event, before firing the
>
> What if your change also covers the first case of mod_timer() in
> ppp_cp_event()?

Yes, for the 1st mod_timer call in ppp_cp_event, the situation is the
same. If it is called, it means we are sending out a Configure Request
or Terminate Request. In this case, we should wait for the amount of
time set by this mod_timer call, before firing the timer. We shouldn't
fire the timer immediately because this is not the intention of this
mod_timer call.

> >timer. We shouldn't fire the timer immediately after we change to the
> >OPENED state. This is not the intention of the (2nd) mod_timer call in
> >ppp_cp_event. Therefore aborting ppp_timer is the correct solution.
> >
> Given an expiring timer, is it the right time to call ppp_tx_flush() in
> addition to add/mod_timer()?

Do you mean when we are aborting ppp_timer, whether we need to call
ppp_tx_flush in the aborted ppp_timer? I don't think so. Because when
ppp_rx (which directly or indirectly calls ppp_cp_event) releases the
lock, it will call ppp_tx_flush. So we don't need to call it again.
