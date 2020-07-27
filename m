Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5569F22FBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 00:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgG0WJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 18:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0WJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:09:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFA7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:09:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z3so9831029pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s014Fu1xwHNN4RwGFk636tw81IAkDgxi5ycsV6xSFkQ=;
        b=aafQS2K5krZ17W4Vt8FZZlOCGRGHRXywMIPMsIy9IR7eDzELnw0sYI8c5SpMn0GnQK
         rSKSWefx58uqENPpDy8/vO55C7ap60LTAPLsk4TskiycCBZpdg4MVjKAWAlJX2oQ6suT
         N/9NaA7K1IkFr5gPcmae60IhOYN2hOjMLfVKuZQlz5lmi71zJcXgysEXUqkm7ethPNxJ
         mSTyKjkoKccX0/29zZAtFvtPiaElh2Hq8ddgrgbMZ3JtxTNtlZhvbzZEyhY2oumFGYlr
         zis0AtVSgMETsZPHSK9PuRxuBmlEoZOvhmD0Q+E6hxAPVcTTo2imJ18x3nYp5kFfP4s0
         7sQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s014Fu1xwHNN4RwGFk636tw81IAkDgxi5ycsV6xSFkQ=;
        b=J8CVVhlY8KrR8Ct321NbHtFMSVCyWbGNX8ZF0xg0/0ABlY3loJ3HW6uCu2PEBNnLrj
         VdLPo95BUFH3cGXbVMejUpigWLj5/yBWBQsNxPkO/8WNCkXq8+Tiawb/bRVc88LG6oNJ
         YGiyoi0NS3G+D09dMxpPFX1PCofVTqdQLP3LI+8tbPvYVfIP6DggrfQ71akSvXXPufGr
         4XItkVOXmYyek7WkQJNJyuN4EVpIPJEe89D2gxqtFv68rP9y+HezoouTlSOFjYO8y5OB
         4LuBKI86mD/94MmRo2egoy/HKtYSmhTP0dt6OxqOJ6RACwuNAzmvGlm481dqFf1Vdo0v
         zyfg==
X-Gm-Message-State: AOAM531wK94C9bnFvDrJawMrmIkgspmHu5KMJMBf73y6tW5kMX1lV4KB
        zVnpEYbF7HIuGEqlc56mfOaWKYuA9FKarNBal9DJDg==
X-Google-Smtp-Source: ABdhPJwYABBZaKeiF4yFz8QIfKCcfNujar4nEi7uHURgaMRU5uTm4W5gEACHKKGqo1n/B18S4iGYJjXjWvCaUUJpwsc=
X-Received: by 2002:a63:dd09:: with SMTP id t9mr21283504pgg.41.1595887798083;
 Mon, 27 Jul 2020 15:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200724180523.1393383-1-saravanak@google.com> <CAJZ5v0izVrJeQNroeNS8xu66c8LskHSiCJRQvVvrhWSZV8tL_g@mail.gmail.com>
In-Reply-To: <CAJZ5v0izVrJeQNroeNS8xu66c8LskHSiCJRQvVvrhWSZV8tL_g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 27 Jul 2020 15:09:22 -0700
Message-ID: <CAGETcx8FoSVwneZNEAeqpAfs8OkeMzbCBWYMSkJbQYE5DLHing@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Change delimiter in devlink device's name
 to "--"
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 7:21 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jul 24, 2020 at 8:05 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > The devlink device name is of the form "supplier:consumer". But ":" is
> > fairly common in device names and makes it visually hard to distinguish
> > supplier and consumer. So, replace it with "--" to make it easier.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Well, this makes sense in principle, but I wonder how much risk of
> breaking anything in user space there is?

The original patch got in only a week or two before this patch. So I
don't think there's any real risk of breaking user space here. Also,
it hasn't been part of any kernel release version yet. So I think we
are safe.

Also, Greg already took it.

-Saravana
