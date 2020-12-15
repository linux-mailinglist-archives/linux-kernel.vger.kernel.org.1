Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FF52DA9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgLOJMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgLOJEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:04:25 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E532EC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:04:04 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id f16so18623157otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 01:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Os33hzl1I4JrVcBc2NboLIV9AXajTqEGTG/MO5gIIA=;
        b=JSyKIzas5kymBH6tBxEg4KYgJIS7B1ABlQS0ZgbHcDVUhMtOJOIBkUG8oVUf2xyE38
         Yi/DwKl/rcy7yjH3AulYbMJTt0+ojd4c4GkFRfUDBUXDhhdGL1N0TDOAvVIxD+4+acjU
         mONy013pwy8tLKUjRRdsuZz+CRSx1++cmK49I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Os33hzl1I4JrVcBc2NboLIV9AXajTqEGTG/MO5gIIA=;
        b=gVyILgdXHQ92NR0OD9NqZl6Y2XAOEH1G59rrisVDd2FgrJsXYSm140FBg+sZvCXDIS
         xrP8iXWx+ZowJRAI0WUx9Vg8rP2kH8eaiPh3/JqopIkvQXGRuml8GkYbagCeY8qiW5Ch
         QIx0wsxVy0+4NX8uDDMrDOd+2ALTmqjpmtSyIZsLbanet7UnVjO51/jxKqGcrEWGASDC
         RaG9j/PTndwU3u9KxAZ+wE9qBv+Xzurw5k95rRhlXDgQISvFMYnDjOzzOBsQI0uqqg4i
         vknEc7vqy8Jel86yUxUmV2891As4RuUzc0DHViMYd5fScsECOii6NA+Z2F5sW188ip8c
         t6rw==
X-Gm-Message-State: AOAM530jJXD3IsZ7b5paOB+RaQQ/DhRdEx+Z9RnhEkmIeSZCHrBPLMf/
        bny3ibIrypdiINMC1DpcsUXEUg/PINm0mc09++NTog==
X-Google-Smtp-Source: ABdhPJyFYzqWRHlZ726aYfoNePEegTQzd/kmmERgpbYpHGtgjMjXkYZ33v0YYXoHy1iJRlrBAen1+2smr+YM4qBD52o=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr22482636otm.305.1608023044378;
 Tue, 15 Dec 2020 01:04:04 -0800 (PST)
MIME-Version: 1.0
References: <20201214213044.27252-1-linux@roeck-us.net> <CAM9ZRVs3gBoYYQ+M1qUiLpuFTD0c_vxdNgDTXoXisne-Y8ZwQg@mail.gmail.com>
 <20201215005406.GA232073@roeck-us.net>
In-Reply-To: <20201215005406.GA232073@roeck-us.net>
From:   Paul Barker <pbarker@konsulko.com>
Date:   Tue, 15 Dec 2020 09:03:55 +0000
Message-ID: <CAM9ZRVvdPTK79m-fRJ=++3=hUy2onApMVP8EQ2PaYcdVuq_irw@mail.gmail.com>
Subject: Re: [GIT PULL] hwmon updates for v5.11
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 at 00:54, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Dec 14, 2020 at 10:06:23PM +0000, Paul Barker wrote:
> > On Mon, 14 Dec 2020 at 21:32, Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > Paul Barker (3):
> > >       dt-bindings: hwmon: pwm-fan: Support multiple fan tachometer inputs
> >
> > Should this one go in at this stage? The patches to implement support
> > for multiple fan tachometer inputs are still outstanding. So the
> > dt-binding will be left documenting a feature which isn't yet
> > supported.
> >
> I don't see a problem with that, the patch has been in -next for weeks,
> and I announced that I applied it.
>
> Is that a formal objection ?

No, you know the process better than me, I just wanted to ensure the
status was clear. If the patch is ok to be included in this state then
I'm happy.

-- 
Paul Barker
Konsulko Group
