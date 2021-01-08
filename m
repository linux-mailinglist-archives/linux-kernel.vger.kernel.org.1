Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0F62EEAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbhAHBBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbhAHBBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:01:49 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC17C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:01:09 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id y128so7873547ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/P7ZZM4ofuWIA4Z9kNDbpxnZxWc1UDny2fHMN28PyvY=;
        b=jddN2onR7BwhOKfW+091rXuUnJ89PUpYp7/2+ZPpNP8AaUVGtW3n7+x09XxtOHjttr
         9lAJ7+M5+DJ3LMBu4At8gjg+AlMjfdDW8KUlLDci4MXW4jtQFkj3GOlGCsGZVnrFGWMZ
         y9P4dHW/6638+DaTAr3pI3GHaJAhNep+OGROVha4MpymTGURySrn7O38e8f9MXWcGTHm
         A8Jy56AsO3lVu0UstCH9qqwB9YUmVWVY13+NvL2gFssqXYrAeIlo5LUCOiefiByV6GBF
         zUgz3fwD2ymO8kxUDNUIk3cnHT0kqDWr8etfTIk6cpG8GRy1HFcwC94sN+V8/auYllSc
         DhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/P7ZZM4ofuWIA4Z9kNDbpxnZxWc1UDny2fHMN28PyvY=;
        b=Y8SJMADJQizB7DWdiaMXMtgF0pp953i3+bXYuGYiNoWcFdaKMyve1z1RZOyxpvU/4e
         gF3XyDjNvpLaOfcOhilwwrzisZDs2P8vKTjhyhBrPb+GQB9kmDymMEW2lOzv6dqapKT/
         xR1gmud3uv/d/GiGfNCdee1EgaEuXi1BwC5TjOTJpcxHkNQQ4v9Z196P2TvYPQ6mrTCv
         uZMz2Ak0ss5WUxBW3aD79M9LUsG8K272+GxXvhsPstfzKoPPCaWgzSaUnx4XeiH/2DSy
         s2GxX8UBn+RwhmR9q1iLt9gGl/nIvfkduCLLAiBOuR1+2ZCRQlJ/GOcOj0hodZg8iFH3
         Ddjg==
X-Gm-Message-State: AOAM5311y4Y1Xe2zDoDT+p/E+3JjN5TWu7qZvKc9j5kQfE4zNq1vJ3p7
        ET8n45u8//09a/Pfkfu87zOWGIetnnq+ZPJseuMg+Q==
X-Google-Smtp-Source: ABdhPJyIkIJWAnqL2BZraYNLirI9O5lRPwlYEJv/lE3m0NMPYkRFYVCGb3QcRUzeu4soEsiPrjwhM5bC+7FP8wapRG4=
X-Received: by 2002:a25:6604:: with SMTP id a4mr2394920ybc.412.1610067668778;
 Thu, 07 Jan 2021 17:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20210107234136.740371-1-saravanak@google.com> <b3cda25a3e3911a12a8766f141c9e300@walle.cc>
 <CAGETcx-q04E0TW6LMoyoRC64xH25Uogk7twSNEbT411ciZPfUw@mail.gmail.com>
In-Reply-To: <CAGETcx-q04E0TW6LMoyoRC64xH25Uogk7twSNEbT411ciZPfUw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Jan 2021 17:00:32 -0800
Message-ID: <CAGETcx_CJjOxim+CEptLRSgfYAKHBbP8rHW7BY+U7-X+L2eObg@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Fix device link device name collision
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 4:43 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Jan 7, 2021 at 4:14 PM Michael Walle <michael@walle.cc> wrote:
> >
> > Am 2021-01-08 00:41, schrieb Saravana Kannan:
> > > The device link device's name was of the form:
> > > <supplier-dev-name>--<consumer-dev-name>
> > >
> > > This can cause name collision as reported here [1] as device names are
> > > not globally unique. Since device names have to be unique within the
> > > bus/class, add the bus/class name as a prefix to the device names used
> > > to
> > > construct the device link device name.
> > >
> > > So the devuce link device's name will be of the form:
> > > <supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name>:<consumer-dev-name>
> > >
> > > [1] -
> > > https://lore.kernel.org/lkml/20201229033440.32142-1-michael@walle.cc/
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 287905e68dd2 ("driver core: Expose device link details in
> > > sysfs")
> > > Reported-by: Michael Walle <michael@walle.cc>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> >
> > This makes it even worse. Please see below for a full bootlog with the
> > dev_dbg() converted to dev_info() and initcall_debug enabled.
>
> Sorry if I'm missing something obvious (been a long day), but how is
> it worse? I don't see any warnings in this log. I'll reply to your
> other emails separately.
>

Nevermind, I see it now. Also, in the future, if you can dump the logs
in some kind of pastebin site, that'd be nice. Avoid the emails
becoming unwieldy and also avoids the log lines from wrapping.

-Saravana
