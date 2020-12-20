Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D887B2DF66E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgLTSSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgLTSSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:18:44 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1BC061282
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:18:02 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m12so18372070lfo.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpfdwLLEz57xZZQ6pUnIHIytbIt7sjGYXR5+reagHWc=;
        b=QRXq9LNWPBFL2tt01fR8hkq2opbGjD4Q5IX2Pc2U0rBnz2RyBAq6V9DP4Gq/fun0Uq
         x5O6aOSH6Z+7bkrfX8cf7NMYEoGy5661pWF7OVhhieMf3amif6cUjqoZDw82DPcjAiVY
         c+O+aIFvlYgYE9weGEVvhw2z8I0pdpCr7Tz/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpfdwLLEz57xZZQ6pUnIHIytbIt7sjGYXR5+reagHWc=;
        b=II3DmYu41NgfczNoVpI2ELbi0X4//PA3sv5YJx4aMSMMU/oDzBpM0VPRH5W5aayQIm
         syyT641DmrnDRt6YTQwaRzH4z49KIprxdpc0xcgImtPOfn/dfXUSMoU2JCSJQpraGSty
         8mlsxVSE7W5aqhsS0CoB4BQpYhRLH/jeP+rSN3KqwPL4TRr0Fs6vSBJ2XHv6E+m+XATS
         p3sYCNO4TurMC+fzVFARr+gAQjp5lfhRCaRrhYDJMa9juqMEVjMT0PqYcRTqfJ+651mZ
         TaebJS7Z1ymS25Vp4aaVI690+m3c6M6zA31/WvjMVcpXfJMhevx/Wpb+DaStvJ1whWLD
         1ofA==
X-Gm-Message-State: AOAM531hgm7MRzJCwnWztXAyWFebCsdJCtbay/x/UxMGh4j6KCBtSy8E
        jlFSA1AJgvfOVws2sYcQOnoH8/wwhX7skg==
X-Google-Smtp-Source: ABdhPJxEg/gwDi1w+WT3C1lfzJAsIz3NqwYjLak78ydn49B38BuDxY7MokqF4HSwgeamjjA04aLTug==
X-Received: by 2002:a2e:8118:: with SMTP id d24mr3805605ljg.105.1608488280291;
        Sun, 20 Dec 2020 10:18:00 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m26sm1889767ljj.134.2020.12.20.10.17.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 10:17:59 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id y19so18257956lfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 10:17:59 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr4920781lfl.41.1608488279126;
 Sun, 20 Dec 2020 10:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20201219221254.GA3604939@piout.net>
In-Reply-To: <20201219221254.GA3604939@piout.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Dec 2020 10:17:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjOamRwdUH6JSBSeT80XEKdzrEDWY59RPnLbAyjPh4nWw@mail.gmail.com>
Message-ID: <CAHk-=wjOamRwdUH6JSBSeT80XEKdzrEDWY59RPnLbAyjPh4nWw@mail.gmail.com>
Subject: Re: [GIT PULL] RTC for 5.11
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 2:12 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Here is the RTC pull request for 5.11. There is a non trivial conflict
> with the tip tree in include/linux/rtc.h.

Heh. That was actually a trivial one - just changes next to each
other, nothing odd.

It just looked scary because of one side of the change involved code
movement, so the conflict diff ended up being big.

But it wasn't actually a bad conflict - I spent more time looking for
that "non trivial" part you warned about than I spent on the conflict
itself ;)

                  Linus
