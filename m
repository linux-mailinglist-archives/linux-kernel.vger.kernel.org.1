Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C122A14D1
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgJaJaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgJaJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:30:18 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D2DC0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 02:30:16 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id f6so7292535ybr.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUD+MdgfTFtmtn8kuvTQUtRoa2PlNwVBxjbqphie3GU=;
        b=gONWpHzYhR5RSgAO9zbDzwI7VDjdtUqBr3YfpOJpbndUViGhuu+04A1RdqnsYVCjli
         2ZguMVbgmaG0kZRZVXtafjdm1m6xsXs4MQjvSXo8sG0zaf2DpmPwaRLZvucqakkqH0qI
         4tdWUVLtMFKXkj1iwq4849vqhS2GsBj2vXtE+/QO8AVs+w/RgoU4J9YzSaMNP7Y5AyxK
         CkWSkgo7ZIDB0Hw7L+Wxy6mjv0uJwSXgIHTTm5MAWBuhJUckE2yecCKNWEojErYeF6Q4
         GZPXUDZzo31wEuvsMInkdTZ3nODNOj5Ez3Q/KzykQS9Q1udIIcrDmH/aADeEpzCvpo4P
         qldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUD+MdgfTFtmtn8kuvTQUtRoa2PlNwVBxjbqphie3GU=;
        b=kAycJxw2hCnCCBo7bQyn0F9kmTwd45wAHeSoiNq7OuBMiBqo6A040ZI8taQ53AOmuA
         Xmw/CNzSgjwVapy6Nn7l+6VmtFuYDqBHNAf4r/++wUKVgHHWvLjCk92VdkQ8nkr1T9on
         oY0NOSR2eNCkMskUSZeR9oz+KsonWmYCk69tXZ9wohgtlSLdhjhpesLjJ7FgauMZTiQO
         NFlTFVGBW/rxh4IFcfV8PTssRP4MjiXMKSvhcAFCoPY1Rmtw7u1hsDQp5SbVWzevsDoc
         YWHq5Z83y871chGOnneLLB4yYqpbcClnx6Yjsckrn6CIEHh2xLEV8Dc8nSFsqNVWtOFd
         bROQ==
X-Gm-Message-State: AOAM531bIGYzu46AWhkF83YC+aLtKxwIJYorQNv9m+oVDhDprZ/S1hBb
        /+hi1h0GD79lxptx6+awwAPYJI/XqGu40/ytIac=
X-Google-Smtp-Source: ABdhPJxmGQjPDBtFAEEsmhdtTHQSnTCEg6FzETII8fB4Jbi4zMENekwpr++cA34pbeNv6sI4vmv+DRp0JnMrd1WY2JI=
X-Received: by 2002:a25:b792:: with SMTP id n18mr9631815ybh.93.1604136616253;
 Sat, 31 Oct 2020 02:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201029095231.311083-1-poeschel@lemonage.de>
In-Reply-To: <20201029095231.311083-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 31 Oct 2020 10:30:05 +0100
Message-ID: <CANiq72ktdqzTByRwVBHmZ6Fpyr5438O7Mg-fbLopmjFY5qaGtA@mail.gmail.com>
Subject: Re: [PATCH 00/25] Make charlcd device independent
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Thu, Oct 29, 2020 at 10:52 AM <poeschel@lemonage.de> wrote:
>
> Changes in v5:
> - patch 1: Fix a commit message typo: of -> on
> - patch 2: Remove some unnecessary newlines
> - patch 8: Fix some typos
> - patch 14: Fix commit message typo: it's -> its
> - patch 15: this patch is squashed together from the former individual
>   hd44780_common_ function patches
> - patch 16: combined two cleanup patches
> - patch 17: I did previously undo commit 3f03b6498 which was a mistake.
>   This is now corrected.
> - patch 24: Picked up Robs Reviewed-by
> - patch 25: use hex_to_bin like in commit 3f03b6498 but for the lcd2s.c
>   file

Thanks a lot for all that! Please take a look at my other two messages
for v5. We are almost there...

Cheers,
Miguel
