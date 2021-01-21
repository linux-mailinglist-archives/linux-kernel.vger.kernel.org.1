Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1162FF5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbhAUUcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 15:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbhAUUbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:31:00 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4112C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:30:19 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o19so4435248lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 12:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=896t3XFraNFaUpJ/WXoxxUghqXuMbEjBhaMz/gtS348=;
        b=K2i0lVeEjB2y6CXAjGcel9x4JSIg81Q1kC2NxxuY4Ld0TwUvcOTwyiWfjO9rlCuG8K
         w490zA9pWssE6t436TYJo6j/P4TSz7i6FwtS2T8NtlVzIipnn+yVV7uwjgwG2a41sd2Y
         Dr1FMshe1fjrpRk5989Moe+MyDW7/yQSglu7X6FK3OliC3FDsY8uWqGD2MNglFQTVbEQ
         MCz4ZrYmA43dNaCjKw2Vd5jn2EZFuXWNv7jhgkLt1b5qvk0Qg2wwSbWzLiZol29sLcpE
         0xRQBzJxRpEVYmpPZOLEEmri1sRHHib9G/A22yKWbo0keNFopoIF7Av4S2wTOyuY0vbj
         Tw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=896t3XFraNFaUpJ/WXoxxUghqXuMbEjBhaMz/gtS348=;
        b=TvyaoMej4EVsZVDrgKrK/Q5UfY57192brqM7qvehBzDKnklqnJwSHQEBILn0SzVu72
         tMf87IPZRtw90HwVzJx6P9iAnX4GHmLDvRV6JM9KtP7ZqliULjYVSSPYSZQLIG0fqYRi
         ytTW/9I8kJMxPROW90Q7KT7Xqqpcm5ZpQOUJC5Gbe9Pzk4FMc4Nk94FjghPFVPuZ9EtU
         9b56W9W469Ylo8SLfRWJis2lnkJ3lrMnypM742Z0N+w2vVGnc8meD3F7VoEwLitf52Jo
         WNYzihpJtDKOfFapoM//YfZBEDoJUlY38IZcvLjCKagmVRTqLmn+IzlCg5WUEHAc0sBq
         B7HQ==
X-Gm-Message-State: AOAM530k29Be65a0z7W5ix+MGuG23p8xBD8/a/3gGYYhUPz/WPaL1WHj
        u5SilDjoJUW+SLzO+uhE10Gc3aYtzVOeOghdHjA=
X-Google-Smtp-Source: ABdhPJw5rqo7HedIqkIAMBVdBvtFsx/QR+P1Y95q5N23Ty3a8DLrFyxSCgn+QZ3GKAdHjYFK/nnARbP+PG0zOf3ebLM=
X-Received: by 2002:a05:6512:694:: with SMTP id t20mr469379lfe.151.1611261018385;
 Thu, 21 Jan 2021 12:30:18 -0800 (PST)
MIME-Version: 1.0
References: <20210121170736.2266-1-scott.branden@broadcom.com> <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
In-Reply-To: <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jan 2021 22:31:07 +0200
Message-ID: <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com>
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 10:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Fri, Jan 22, 2021 at 2:17 AM Scott Branden
> <scott.branden@broadcom.com> wrote:
> >
> > Use python3 instead of python in diffconfig Shebang line.
> > python2 was sunset January 1, 2000 and environments do not need
> > to support python any more.

> Just from curiosity, what problem is this solving?
>
> Is there a distribution where 'python' does not exist,
> but 'python3' does ?

Yes. Called surprise surprise Debian
An it's a rare case when I agree with them.


-- 
With Best Regards,
Andy Shevchenko
