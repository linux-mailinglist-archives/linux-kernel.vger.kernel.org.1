Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622792DD9E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbgLQU0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgLQU0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:26:42 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F8FC0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:26:01 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m25so60938955lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CikbSbNMtOT1DkJUvzo0sBjOQ+qtDs9BHGAn5VvobJU=;
        b=ezhj7zQbSkXgdYHrDhrfOgNHKRUEiPlxnmymIeQuNKzeqbH0fooXfYbJyHgqpX9nGX
         /EG4n8UUZVskOIGZjgwk8TfMVIq3xKlBWjqzggGGMiCDQ2TuuV0sEB4yZoSWnCrgtEJ9
         asTjuWuE4GO4tcoOS5l8wfbGu1w6tUTvGFLiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CikbSbNMtOT1DkJUvzo0sBjOQ+qtDs9BHGAn5VvobJU=;
        b=giTI7bhTJO0V54dRlPfvxxu7t/KX/DPkdkb2VyQMQox89DG0tZae9dQxsCU8rUvDqj
         yiFdYhMMb5mce+ecn0vwaMiuO4x+UNjSLL5LQx5aEnsrTRmKS8jdMAYkNUkzOw2ZPRqG
         1dfbxY9TGm/rf8if4iSjVm7nMZUWMBjiL/l3CFUhhdLE9KL2A022uSdUBT53pvTqE0p2
         1vGE5FPFEek5O0M9ooPv+cw2DYHmb39J7VKamawsHu8KLbzlSkDW4xKY3Jn5KmgoBPZN
         q1WaeKUGl1uGSU3Q3g9FEkdn51QHrIhtIAP5N/t/o2ap12/66gSLecMMBq136AdVpUBp
         jAow==
X-Gm-Message-State: AOAM530xMj4ju6hcvIT4YBiGE88t8IEd+5gCmn9wXlT/EfzKcZYQyMHq
        frnmRxMi+7HXvVoILNoS+toqB8SoF5IbEA==
X-Google-Smtp-Source: ABdhPJwWaO1kLLbgjr6sp8Bk5mdv9XJx49sLPjJO7VjHnWnCDPcNRi1ynEd5eQy+wH04o2o2NaXbZg==
X-Received: by 2002:a2e:8244:: with SMTP id j4mr429771ljh.322.1608236759932;
        Thu, 17 Dec 2020 12:25:59 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id x2sm689790lff.207.2020.12.17.12.25.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 12:25:58 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id u18so60996767lfd.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 12:25:58 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr190413lfc.253.1608236758308;
 Thu, 17 Dec 2020 12:25:58 -0800 (PST)
MIME-Version: 1.0
References: <a47c68f255f9fd9361f0c17ccf1273d905fd0bd1.camel@hammerspace.com>
In-Reply-To: <a47c68f255f9fd9361f0c17ccf1273d905fd0bd1.camel@hammerspace.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Dec 2020 12:25:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi74uq4CGeWtSYfMcdgWdpkiwbM5u7ULryCOPM1ZAdFXw@mail.gmail.com>
Message-ID: <CAHk-=wi74uq4CGeWtSYfMcdgWdpkiwbM5u7ULryCOPM1ZAdFXw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS client changes for 5.11
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 10:05 AM Trond Myklebust
<trondmy@hammerspace.com> wrote:
>
>   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-
> 5.11-1
>
> for you to fetch changes up to
> 52104f274e2d7f134d34bab11cada8913d4544e2:

pr-tracker-bot doesn't seem to have reacted to this email.

I suspect it's because of the odd and unfortunate line breaks in it,
but who knows. Maybe it's just delayed (but the other filesystem pulls
seem to have been tracked).

Anyway, it's pulled, even if the automation seems to not have noticed.

            Linus
