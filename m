Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0CA303CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392308AbhAZMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392100AbhAZMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:15:04 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81861C06121F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:14:14 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id e22so33050382iog.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EC39G0Ax8o5xiVZFYRu69aLO5XoCRyDi17a7mGnSFZo=;
        b=r8AYrsZRuCFRQfTfgDZEV7m0HnCGFkrKWhuoxIKBvavhhKyiH91iH0wNKC1ICdxV/0
         YQON8bqY3ZIFiBQLMajIPCAz9F5pNRP8vOEgZRsM6LQccpGbqalsG5wAuDXvPunaoHIw
         ekzTO9byEqgQx2CLxpG6XHiaOEIrrrrqoRI2gCrWR8lLWvvD3O3G6HtIp1+tQdx5Pi01
         vs7/zX/A57ukNR8q//ro81Hwxzjaj0ksC8T6P2xJ3oUaBJf4mTyvmFOYFIsZTb1N4myQ
         kcCqpdYvWEYn9wqDqjLmrPau/rA6DhOrUO5H6mqcpj9/LOEYw3HT5gvXYnyEbkNI+mWd
         I+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EC39G0Ax8o5xiVZFYRu69aLO5XoCRyDi17a7mGnSFZo=;
        b=Sc1dkNi7ApzWfcGiDsyvfX7WVMrWQQdisjoQOxHUKdtDC3RdU3m6XSP9vbtI2O9/OK
         YcL4Al43+aVjOx1louNNJYAGKZSXv5xvDfGwcuHNS80TAwmXI6S/oPCZfVE4+RK8IEU2
         KNEfq800OVkbrHYZU82xNbrQXxbLuUX2uGreFx1Yx4hoCVfPEhjDjVTk3Icaxj+r9tu4
         doxm7q2ZsQ4GQxcxMqrG13XoJguymjrOD8qIRa+gQ/1rVTryA9vKiSOFAdeXTr+gum6f
         AMee/2AI6p/hjdiY5Pf1Z0gKflbLaUPzH9NO2+5e/tyAqo812Ziadi58zuT8QO5d+xq8
         v6Gg==
X-Gm-Message-State: AOAM530GdItdq1Xw2jmDddSM+fmlq9e9M8ziEjMAwQ/S4GsgRTdjfM4d
        5YtPXPYL9qQtv1JBNmFt3uj09FJpwru8fAe8QDUlyg==
X-Google-Smtp-Source: ABdhPJyMRKzi5LXKf6VVfX1CA7f7jhHD11qmds4OoBv4zF/WiFQLxHOInc5RWLzUAs3AKHW09nEdMJrq3TGGyh6DZQM=
X-Received: by 2002:a05:6602:2e83:: with SMTP id m3mr3651738iow.160.1611663253649;
 Tue, 26 Jan 2021 04:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20210126094913.180945-1-raychi@google.com> <YA/ogYkHrbmd1Eyo@kroah.com>
In-Reply-To: <YA/ogYkHrbmd1Eyo@kroah.com>
From:   Ray Chi <raychi@google.com>
Date:   Tue, 26 Jan 2021 20:14:02 +0800
Message-ID: <CAPBYUsAc25n2kFD2VQVkx7oeFXU888MWKGCQeusT4HgV1JKY3w@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: add EXPORT_SYMBOL_GPL for role init functions
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 6:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 26, 2021 at 05:49:13PM +0800, Ray Chi wrote:
> > Currently, role init functions are used in dwc3 driver but
> > can't be called from kernel modules.
> >   dwc3_host_init
> >   dwc3_host_exit
> >   dwc3_gadget_init
> >   dwc3_gadget_exit
> >   dwc3_event_buffers_setup
> >   dwc3_event_buffers_cleanup
> >
> > If other kernel modules want to use these functions, it needs
> > EXPORT_SYMBOL_GPL() to get compile pass.
> >
> > Signed-off-by: Ray Chi <raychi@google.com>
>
> What current kernel configuration fails without this patch applied?  I
> don't see any in-tree users of this as a module that would break, or am
> I missing something?
>
> thanks,
>
> greg k-h

There is no failure for current status. This patch is just used for
any kernel modules
which want to call these functions. I think it is an expandability of
dwc3 core driver.
