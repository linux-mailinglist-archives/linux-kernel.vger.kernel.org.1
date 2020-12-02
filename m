Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865542CB83F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbgLBJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387891AbgLBJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:11:41 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE02C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:10:55 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so366138qvb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jHXxAEFihpGexQosJgOwtA1rTxwRBPimbOCJs6PdyiQ=;
        b=Y5QtHYdkrX6aP/Zfes2Iz6RXNnojW27vyX/5CgTqb+ITygoCCJ2dfDbg2zQfOXAiic
         PF4gIiC7/Pfg7hZ/9b5KyW8cmfjNRwejA5zB5Pca6v0+vP80S/2MNkkd29UrKFoqUPwY
         EGUNWFX4S8E1fm9eVVgvgwraAIP7bfzNE460M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHXxAEFihpGexQosJgOwtA1rTxwRBPimbOCJs6PdyiQ=;
        b=B7+WUnxfuuP81SO3X/I3pbE/WKvYQD8A1Z5XfRwLS5BxUXSEgNmkENzk4AEDk9wZYE
         SNLJa8HVTex/5os5hAFih5JaDa4jY0Ji8dDT7bCcwpca9vmHo2PWrfsPRKywBWuTxEt5
         iEjUuO6/TZa4Dn7sjGl9a5UUR6hw2V235oiXr+MoPZLgJ3NdZBJBUANRFcN+9C9jXLvo
         5GvN/qQbR8/bvy3qkBx9WNUPlVK5zP6SWoa39KBHMunQCayWhCT6j0XparP5jHtia7Tp
         BlHIgr3NoDKyakZQSMR1y2GBVWWJDqm8e3Du+b6bfD6YVsISX/3Z5VdjJFDEOen9hSIk
         wrZQ==
X-Gm-Message-State: AOAM533EL1SRIrDhyA3ZWdVBwzaCMlm/qm7DhrFu8L18AcxUkAFrFPap
        DifIw2RACvJ+8D1EhNJDe6EvZvgVv90YPAT62/95hA==
X-Google-Smtp-Source: ABdhPJytwEIZuRyGn05kO7fcdgPdlwgix3LuGPG61AnTa6cEDH4lUg49k1PEGAjiN9bs36DCjIusI58CiLW25Da9z0Y=
X-Received: by 2002:a0c:8e47:: with SMTP id w7mr1540726qvb.55.1606900254283;
 Wed, 02 Dec 2020 01:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20201201134330.3037007-1-daniel@0x0f.com> <20201201134330.3037007-11-daniel@0x0f.com>
 <20201201150425.GC1551@shell.armlinux.org.uk>
In-Reply-To: <20201201150425.GC1551@shell.armlinux.org.uk>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 2 Dec 2020 18:10:43 +0900
Message-ID: <CAFr9PXnME5UCyOdkRGFO2+=gv27grcq35Adrtio3ex4hq0CWEQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] ARM: mstar: SMP support
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     DTML <devicetree@vger.kernel.org>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        olof@lixom.net, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh@kernel.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Wed, 2 Dec 2020 at 00:04, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Dec 01, 2020 at 10:43:30PM +0900, Daniel Palmer wrote:
> > +     np = of_find_compatible_node(NULL, NULL, "mstar,smpctrl");
> > +     smpctrl = of_iomap(np, 0);
> > +
> > +     if (!smpctrl)
> > +             return -ENODEV;
>
> Wouldn't -ENOMEM be more appropriate here?

There seems to be examples of both -ENOMEM and -ENODEV in other ARM platforms.
arch/arm/mach-aspeed/platsmp.c uses -ENODEV for example.

I went with -ENODEV there as the source of the error is most likely
the node not being in the device tree.
I didn't check the result of of_find_compatible_node() because for the
memory barrier code in the same file I was told it wasn't necessary.

Thanks,

Daniel
