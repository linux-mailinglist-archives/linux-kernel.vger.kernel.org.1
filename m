Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CAF2DB5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgLOVWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgLOVVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:21:46 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EEFC06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:21:06 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 4so11729345plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 13:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQbmRDJKcfm0nMG1Zrd5hG96AtVHrMVfiJzxnIRuJBE=;
        b=U1xMu5odAzE/9Jg085hDsQCrdy6XrNPQ3lX/aTSgwjzP4MaJO61XUEoqvOC1ptacGa
         M+4R6IzfGxOXtAobgqXDJnZiXyJBNWKF2UUglf5PHm9vtiwPyBjljtJYD9iYaRqIi4DC
         9GijZhQGUFSe4NEKots2QjX7axwTWdwROMHRJFsMplAxxtEIlGeM63MIjrB4U3bU7UkC
         tsOv68GQEz/2k8Abew/EYxgiejU7ph3rEwGlTwYS+4g8LSxqNW8QxxJUCy6Z470LmjZP
         8pKQrwkCXIr4lFd6Ul7cBi4m4C2+SsHLDtJ+OXCP79FDT2TJ2tmm2nISXViKSNT1JB6e
         JJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQbmRDJKcfm0nMG1Zrd5hG96AtVHrMVfiJzxnIRuJBE=;
        b=uYQp/EDwuxpbk6gLepBAukx5t9FfHUKCcr4ThbxPYlZj3r9UKXcIKhCBMr9Al8zvz0
         8cGPYCHv720TGtKRl8qkovsXCHhm1FwstG8FzXI8wLdV3elGgcXzGGObAW2S3i1xloAD
         P780/U0RvOPc4pTgUgJN4KXklXKU2ZBIuS1VWAGYO7IjMIGUaSd/Y0jAAOvZ5+T6+GK3
         XkU6dpyGJerqjkOCcLTnwjETP2r0zf1gKgdACZqebiuXe+Y0LtAX0jyqqNxHSWRqiwPW
         irqLvORqrYNtUoRWkM7OiBr+vbwJJwV21GVionPYBYzwksfIltG+cq2V55vYTa94xOrd
         RL7Q==
X-Gm-Message-State: AOAM531gMl+2sl+jC9KjLpSY4U2QWcu5hOiVaZET0hhFEmXs22DmhFzH
        2WXi+V7YQ6952r3mbJSuXyG/qZSmF9Oj2zNoHs0=
X-Google-Smtp-Source: ABdhPJymE3tSWJEbkSF97ixTf4/XyFkA/sxBlPvb73SK/66sqLlpUS0xPZkSB6JmCqjfDpw0gI1DIP2lq29uR8XAtlo=
X-Received: by 2002:a17:902:ee11:b029:db:c0d6:581a with SMTP id
 z17-20020a170902ee11b02900dbc0d6581amr29211163plb.54.1608067265568; Tue, 15
 Dec 2020 13:21:05 -0800 (PST)
MIME-Version: 1.0
References: <1608022118-29993-1-git-send-email-yaohaidong369@gmail.com>
In-Reply-To: <1608022118-29993-1-git-send-email-yaohaidong369@gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 15 Dec 2020 15:20:54 -0600
Message-ID: <CABb+yY1a+TUE=+-kc6tbRU8mrxz6eDvnwOUnGOFfcm7vat+niQ@mail.gmail.com>
Subject: Re: [PATCH] add chan->cl check in mbox_chan_received_data()
To:     Haidong Yao <yaohaidong369@gmail.com>
Cc:     natechancellor@gmail.com, ndesaulniers@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Haidong Yao <haidong.yao@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 2:48 AM Haidong Yao <yaohaidong369@gmail.com> wrote:

> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -152,7 +152,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
>  void mbox_chan_received_data(struct mbox_chan *chan, void *mssg)
>  {
>         /* No buffering the received data */
> -       if (chan->cl->rx_callback)
> +       if (chan->cl && chan->cl->rx_callback)
>                 chan->cl->rx_callback(chan->cl, mssg);
>  }
The proper fix is in the controller driver. Which should stop tx/rx
when the channel is freed.

thnx.
