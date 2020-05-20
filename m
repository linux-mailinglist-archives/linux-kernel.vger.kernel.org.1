Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386BA1DAFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgETKMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 06:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:12:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8738AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:12:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k13so2558153wrx.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iBcqQ8zxIDDNjlNpFLw9XT6VQWod6ur15qrla/UFJIM=;
        b=GcyRcfEjdfbUfF8SYp6YXFCUiSmHxZEnby3pNjehHWcDBnLM95xiIR946clqhMIo8v
         q+v5u3uDiDhe8BwtjxlihKWI+8U1pWzeM5cAq/iINiMV6zxZz02aD80JLlLBqtdpOr6i
         wADkaP6IfmQ9s+UGfWXE0NcUcb45UtiO5o1CH2/VfQs3ReRWTB16/pQ8rSpnVwBHlAHS
         u7oV2A5AJ6a62eVFO4EYeZjkfGG4F2rfUpPXPh7KKl/I8GnbAZyKp3mlRc5DePAyoJ6s
         uGDQT5aedJV3pbX0QlcaREnlFnSIG4Dm0ONnZ4ppugikoVr/9w451geilvvnMm3tREOk
         0PPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBcqQ8zxIDDNjlNpFLw9XT6VQWod6ur15qrla/UFJIM=;
        b=sSrOIA3MxePrFFZ1qWvXVEFGcE74pVq4vwj/TejCKfsz0zQMrIhH9SSavd4RpLM3wO
         b37NejIpBapEa/Z66i84lN7GOrCkYwYsMIXaCtbu5qjeazpL6Yd1Qk1IhFEi10iraIMG
         d6t9Gk8pkURg3CMXqXcuqqyYdWBCP7S5bW3ZF7oMUl9r/AcsleWk/0tg9d6fTiyeDxuQ
         eOFh4wNQ7knycZ6jImeDXSO1Y6WwDJxSNYjZCmUFsM9wCYPqqFc9mqv6+vZ0LQ22pZHe
         a55jIei9OXJDcEBEnOvXSvNKl4ojGOev+5zdlPlYv82To6EW90gcqSNbhzXzPI8OEVne
         0hkw==
X-Gm-Message-State: AOAM531A0AcgD83uwZsHKVAJMUFVSV1rj8B5uHzQKnsITgcvxMD7dNWo
        7mncoGT5qFcvEHJVLYr45LfWWDW6buc6hKroMtzz2bU=
X-Google-Smtp-Source: ABdhPJypgX0CYZ1BPyRbnRWRWfBgtSJZTe/P5PsSECo15WsGXB6uu7WRt6MROF7Juxl784icOyfURtWML4iF6b7GMoM=
X-Received: by 2002:adf:cc81:: with SMTP id p1mr3338025wrj.192.1589969538224;
 Wed, 20 May 2020 03:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200520040354.3e619918@canb.auug.org.au> <86962843-e786-4a3f-0b85-1e06fbdbd76a@infradead.org>
In-Reply-To: <86962843-e786-4a3f-0b85-1e06fbdbd76a@infradead.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Wed, 20 May 2020 12:12:07 +0200
Message-ID: <CAHg0Huww=oyj0DSuLSKOrJp5vtG_2xLLqM27MAHWNJdLWNeB3A@mail.gmail.com>
Subject: Re: linux-next: Tree for May 19 (block/rnbd/)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, May 19, 2020 at 8:59 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/19/20 11:03 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > News: there will be no linux-next release tomorrow.
> >
> > Changes since 20200518:
> >
>
> seen on i386:
>
> when CONFIG_MODULES is not set/enabled:
>
> ../drivers/block/rnbd/rnbd-clt-sysfs.c: In function 'rnbd_clt_remove_dev_symlink':
> ../drivers/block/rnbd/rnbd-clt-sysfs.c:435:39: error: implicit declaration of function 'module_is_live'; did you mean 'module_driver'? [-Werror=implicit-function-declaration]
>   if (strlen(dev->blk_symlink_name) && module_is_live(THIS_MODULE))
>                                        ^~~~~~~~~~~~~~
>                                        module_driver
>
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>

Looking into this, thank you
