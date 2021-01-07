Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6272EE9B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbhAGXTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGXTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:19:10 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BADC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 15:18:30 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id y4so7728385ybn.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 15:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2MEhl9KwLb+yQhAXQggqbkA+KvLyopELMA4gBiD0LM=;
        b=IVVGtLqNIUlUG6KDate0kJqWtd5om0Ai84NlyvyDm1P3ZQXQTmJzrrCMiS1A3YrtTd
         Z/Ru519dN5HmMGoq5pDLO2WDfGadHsvagPH3D+D0NF7YQqyKCY8QH4gqE2L29G9CDJ5h
         jS938/TObWN8LOUUleovKU5nxQiGlWXMy2blfl/ZOn+/wdJiNfnnquseUTGxpw65j1O3
         /lrygj9dP1mQ1i7OSIgml167JtzeGFk9Ib8S5ks1H/nCQH/rSu0hhNDGxWIDMznwaGmi
         FnHRCWMKcIqdEYtROc05qkIIZMILUcXgYzdewolq1a0g51xuKAsbptqLQ9F6MuAChYQs
         8hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2MEhl9KwLb+yQhAXQggqbkA+KvLyopELMA4gBiD0LM=;
        b=RLWrYQ9/bnjLrQLqpEhlsjYhgZpOGrzXOWf4Uk31iCN6hKtUHNjt9JPjG5CeGQ2um8
         6zZEcgMbFzT8cbrZgcIuWBzNiblYWRX1WhJ0fpZ+FUgf/tQ4mkMlSaDXOEd/2PVMNizn
         P7wY5fvfoz4Y7VZ+lnfbvwbSt8+350QoAItP4+X/wMEIE6ooAO2UnLzrvSHP0hnY+g9I
         aAGsUNH/1IjVyX2pYi3ksGJmaxM0rc4SCrUoiwdkw57fbO5WGMnDKo+IkiHQ4gi4Ij5G
         AAN+9zzL3l7b7gXmP2YRfTEjxB9DD12k6oMw8oePOvmuX7JgNnJDnZJE3ir4VrzG7so+
         CqOg==
X-Gm-Message-State: AOAM533wZamYJJnr6l1cbWfCQITcRI+1kzMBMWFZHcD3sTdsefJia+ZP
        kn+HQ33TeQMDGMFr5M32tvF/FJEXdjNEOt1lGj1QjN4NFGTaTA==
X-Google-Smtp-Source: ABdhPJxjsIQDozspDcre6CbX7/8Jy9kv2XahmSAefvrbvWmwhqmB+NrWuLXvvhyRkIiwP6h7orwyvus78MHBa0jVc8I=
X-Received: by 2002:a5b:b49:: with SMTP id b9mr1639493ybr.310.1610061509383;
 Thu, 07 Jan 2021 15:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20210106232641.459081-1-saravanak@google.com> <X/bNxMPWKq2nbqS4@kroah.com>
In-Reply-To: <X/bNxMPWKq2nbqS4@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Jan 2021 15:17:53 -0800
Message-ID: <CAGETcx9NzCBGO4=Xo4h_BbbmxGr+VBoMvqFHkYKiQyCYNtBYGQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix device link device name collision
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:59 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 06, 2021 at 03:26:41PM -0800, Saravana Kannan wrote:
> > The device link device's name was of the form:
> > <supplier-dev-name>--<consumer-dev-name>
> >
> > This can cause name collision as reported here [1] as device names are
> > not globally unique. Since device names have to be unique within the
> > bus/class, add the bus/class name as a prefix to the device names used to
> > construct the device link device name.
> >
> > So the devuce link device's name will be of the form:
> > <supplier-bus-name>:<supplier-dev-name>--<consumer-bus-name><consumer-dev-name>
>
> Minor nit, you forgot a ':' in the consumer side of the link here.  The
> code is correct.

Greg,

Do you want me to send a v2 to fix this and add "fixes"? Or will you
just fix it up when picking it up?

-Saravana

>
> >
> > [1] - https://lore.kernel.org/lkml/20201229033440.32142-1-michael@walle.cc/
> > Reported-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > Michael,
> >
> > Can you please test this? This should fix your issue.
> >
> > Having said that, do you have some local DT changes when you are testing
> > this? Because it's not obvious from the DT in upstream what dependency
> > is even being derived from the firmware. I don't see any dependency in
> > upstream DT files between mdio_bus/0000:00:00.1 and
> > pci0000:00/0000:00:00.1
>
> That looks really odd, why is the mdio bus using the same names as the
> pci bus?
>
> But anyway, your dev_bus_name() change here looks good, I'll take that
> as a separate patch no matter what happens here :)
>
> thanks,
>
> greg k-h
