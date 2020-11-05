Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D12A79AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgKEIxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgKEIxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:53:19 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E97C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:53:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so757040wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WpbbC60jA8vbXB1BII+d/WIO26oOwmqU8T35Zpa5f7c=;
        b=kKsH8yPF3VunpoDOaD8BENd9pyU0Ual13erj/sQR31jv+GDFWA9pclNrwxmn/WtC+9
         lSSE3k/BLKEDq5JogMrrtnmIeb2LJKIu4qQOsaAQdgJoGbmvuNSt8XbHyjeQP+jGLFk2
         MHvCjNoAgegIuUDVqvl8R2lVSwIQuN/AAX9WHVIF2qsT5dkgowHFz4u9N0VB9PiWGIpm
         7AfIjN+wodrP1Jk9kyBqkFPEq8KyKG9Slym0TMSSRZb/zY3ot2+HjQc7+9Yjmm5sMp1I
         hchAY0hXvW6Dyr7YgXs9Og6PoC7FyV0MHi0WuAgYC+Ed0Fpu6YUYIxdE9ZSjIgRJ6m6b
         2WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WpbbC60jA8vbXB1BII+d/WIO26oOwmqU8T35Zpa5f7c=;
        b=l3a9FKkaPYr/qEMyvI9UoCx5R+HyZUlbyaQq0iiQZcS5UVTg18Td6hafKgycsO+cVc
         mkImUQbyhnZ4YIpSvvXNve2gy+eHFKGgV21Y5llYMybiPQaZw9eGjZrVpSqpzsmcodkm
         Z4/4FEuWCjNijWr0fLcH/a6FcLxKr1KSMGe5PalRR/S+YMump0vbM7f+5vPVrmZ0EDDP
         AckZUX7941orGtG8NHhYBhGe3RmqNn6gb+1cSO0k72vEEjBM7yp1ckaC/D8aTCFWrZzj
         I0tHSRIgdlf942niRMzUf44quvLvaurYn0ihcpViw9H3UtZbA9E8eMt4Ml6IsvrXreOV
         s/9A==
X-Gm-Message-State: AOAM531cgxgRXiw/uopoGP8/2pbb4dnjqtqiogJPQkgIHpytLQ7MtDZ7
        ixj9HND/hmPEgagRGygTYrSKisS7IDJdpWaV
X-Google-Smtp-Source: ABdhPJw4ZFoiRPslz0DMxzR/My7gY74YfgyH4UuFCtofGhvsdvrtEK2v9/xvkdaTAwsJdcS5nLroVQ==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr1514050wmc.176.1604566398176;
        Thu, 05 Nov 2020 00:53:18 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id d63sm95828wmd.12.2020.11.05.00.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:53:17 -0800 (PST)
Date:   Thu, 5 Nov 2020 08:53:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Holloway <alfie@dcs.warwick.ac.uk>,
        -- <julian@uhunix.uhcc.hawaii.edu>,
        Marko Kohtala <Marko.Kohtala@hut.fi>,
        Bill Hawes <whawes@star.net>,
        "C. Scott Ananian" <cananian@alumni.princeton.edu>,
        Russell King <rmk@arm.linux.org.uk>,
        Andrew Morton <andrewm@uow.edu.eu>
Subject: Re: [PATCH 12/36] tty: tty_io: Fix some kernel-doc issues
Message-ID: <20201105085315.GA4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-13-lee.jones@linaro.org>
 <715cfe26-18d3-a035-0cf8-958f1235b4f7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <715cfe26-18d3-a035-0cf8-958f1235b4f7@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Jiri Slaby wrote:

> On 04. 11. 20, 20:35, Lee Jones wrote:
> > Demote non-conformant headers and supply some missing descriptions.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/tty/tty_io.c:218: warning: Function parameter or member 'file' not described in 'tty_free_file'
> >   drivers/tty/tty_io.c:566: warning: Function parameter or member 'exit_session' not described in '__tty_hangup'
> >   drivers/tty/tty_io.c:1077: warning: Function parameter or member 'tty' not described in 'tty_send_xchar'
> >   drivers/tty/tty_io.c:1077: warning: Function parameter or member 'ch' not described in 'tty_send_xchar'
> >   drivers/tty/tty_io.c:1155: warning: Function parameter or member 'file' not described in 'tty_driver_lookup_tty'
> >   drivers/tty/tty_io.c:1508: warning: Function parameter or member 'tty' not described in 'release_tty'
> >   drivers/tty/tty_io.c:1508: warning: Function parameter or member 'idx' not described in 'release_tty'
> >   drivers/tty/tty_io.c:2973: warning: Function parameter or member 'driver' not described in 'alloc_tty_struct'
> >   drivers/tty/tty_io.c:2973: warning: Function parameter or member 'idx' not described in 'alloc_tty_struct'
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jirislaby@kernel.org>
> > Cc: Nick Holloway <alfie@dcs.warwick.ac.uk>
> > Cc: -- <julian@uhunix.uhcc.hawaii.edu>
> > Cc: Marko Kohtala <Marko.Kohtala@hut.fi>
> > Cc: Bill Hawes <whawes@star.net>
> > Cc: "C. Scott Ananian" <cananian@alumni.princeton.edu>
> > Cc: Russell King <rmk@arm.linux.org.uk>
> > Cc: Andrew Morton <andrewm@uow.edu.eu>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/tty/tty_io.c | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > index 88b00c47b606e..f50286fb080da 100644
> > --- a/drivers/tty/tty_io.c
> > +++ b/drivers/tty/tty_io.c
> > @@ -2961,7 +2965,7 @@ static struct device *tty_get_device(struct tty_struct *tty)
> >   }
> > -/**
> > +/*
> >    *	alloc_tty_struct
> >    *
> >    *	This subroutine allocates and initializes a tty structure.
> 
> Why do you randomly sometimes fix kernel-doc and sometimes remove functions
> from kernel-doc? What's the rule?

The decision is made quickly (I am fixing literally 1000's of these),
but the process is definitely not random.

If there has been little or no attempt to document the function, it
gets demoted.  If the developer has had a good crack at providing
descriptions and/or the header is just suffering with a little
incompleteness/doc-rot, then I'll fix it up.

Here for example, no attempt was made to provide any proper
documentation.

> For example, alloc_tty_struct is among the
> ones, I would like to see fixed instead of removed from kernel-doc.

There is nothing stopping anyone from providing said descriptions and
promoting it back up to kernel-doc.  If you have good reasons for it
to be properly documented with kernel-doc, then it should also be
referenced from /Documentation using the kernel-doc:: notation.

Also see: scripts/find-unused-docs.sh

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
