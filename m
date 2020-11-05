Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222B62A79D0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgKEI5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgKEI4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:56:24 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A34EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:56:24 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w14so766743wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qlo9IXhOQ6pLJRD3jaLC9X1L/2ZX7VI831HTHvpeBa8=;
        b=xmuJWCDzK3jlCfBEJ50sc/1IbsjY0gmBDqL8g3ldbwSWpgm/fV8cViSN+3HRloCj9C
         Z2kdehO9C/uiaLs/N8nx+yKSO+etzk5NcgMZ5AhFdYTRcy2zF7tghfHYIl8ckzJIeYMI
         zhk+pB1ZR2MBYwz3KU2F224M1iQ4itauNSuWP7TSUVfT5VA1nqqhwXuWLh38Yaqsy2sU
         5sZ/tIw0XKEekjwtd+NhDj0PHNX3rfsbAEDB8H60/8yAhYk9Bp/+VLcq11wMAeQ4L6s5
         7f3MEqNcauBzaLGCXAlI+qEe2i2OsX9JTfaym1RXrfco//lIo64cURQYDBcZbX2ZmJuU
         s7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qlo9IXhOQ6pLJRD3jaLC9X1L/2ZX7VI831HTHvpeBa8=;
        b=IEQ255OoUzrq7PPKw05onqvCMlbaGHp4OGU5+2FnxM091vNZuw6b3Nk+XSu1vaJZWj
         tyYbLfqJXCwwdGp3+2JBbxX2c7vIP73YIei6xJS20DQM5IleRqiGBGCS66povJNinl4V
         iOoAibNieDQoSgmGGvRIqSC6aVcqjzMW9NubKTq7URhukdSO70RaoqdPAt1mzckB6ZAt
         RUHD0J9Nz8O8Yf7Up1Wp0aSCtcD44T/I2ImgvFEnCPISYm+sXRpLD1PazvEw3vwCpqDp
         KScdaOhQhBmXvB2V4Et7QGPpXZmN+MhjwEV9AbkmQ+lskIrfEBPfd0M6nGMm4/06w5mT
         vs/A==
X-Gm-Message-State: AOAM530Vca7AX2BETQp67e6Kkl5veqEudiadyFsbZYe9ChvsFtbH3WNK
        ppIg4nZNx9pQxMXjYXynBHlW5fHnNqFVsG/V
X-Google-Smtp-Source: ABdhPJzH/a9LKpMDmiKZXyUKBVpzXU7ZIwergxb+Tl7jScXQppT/23Rj8a4s8jIBfG2F+zCMsF6pKg==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr1546371wrt.51.1604566583248;
        Thu, 05 Nov 2020 00:56:23 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m12sm1433704wrs.92.2020.11.05.00.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 00:56:22 -0800 (PST)
Date:   Thu, 5 Nov 2020 08:56:21 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/36] tty: tty_ldisc: Fix some kernel-doc related
 misdemeanours
Message-ID: <20201105085621.GC4488@dell>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-9-lee.jones@linaro.org>
 <8f07fa1e-d81f-fd43-9dfa-bfb9f9171619@kernel.org>
 <20201105085449.GB4488@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105085449.GB4488@dell>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Lee Jones wrote:

> On Thu, 05 Nov 2020, Jiri Slaby wrote:
> 
> > On 04. 11. 20, 20:35, Lee Jones wrote:
> > >   - Functions must follow directly on from their headers
> > >   - Demote non-conforming kernel-doc header
> > >   - Ensure notes have unique section names
> > >   - Provide missing description for 'reinit'
> > > 
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >   drivers/tty/tty_ldisc.c:158: warning: cannot understand function prototype: 'int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD); '
> > >   drivers/tty/tty_ldisc.c:199: warning: Function parameter or member 'ld' not described in 'tty_ldisc_put'
> > >   drivers/tty/tty_ldisc.c:260: warning: duplicate section name 'Note'
> > >   drivers/tty/tty_ldisc.c:717: warning: Function parameter or member 'reinit' not described in 'tty_ldisc_hangup'
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jiri Slaby <jirislaby@kernel.org>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/tty/tty_ldisc.c | 10 +++++-----
> > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
> > > index fe37ec331289b..aced2bf6173be 100644
> > > --- a/drivers/tty/tty_ldisc.c
> > > +++ b/drivers/tty/tty_ldisc.c
> > > @@ -190,7 +189,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
> > >   	return ld;
> > >   }
> > > -/**
> > > +/*
> > >    *	tty_ldisc_put		-	release the ldisc
> > 
> > Having tty_ldisc_get in kernel-doc, while tty_ldisc_put not doesn't make
> > much sense. What's missing to tty_ldisc_put to conform to kernel-doc?
> 
> Where are they in kernel-doc?  I don't see any references.

Also:

 $ ./scripts/find-unused-docs.sh drivers/tty/
 The following files contain kerneldoc comments for exported functions that are not used in the formatted documentation
 drivers/tty/n_tracesink.c
 drivers/tty/tty_baudrate.c
 drivers/tty/serial/8250/8250_port.c
 drivers/tty/serdev/core.c
 drivers/tty/vt/keyboard.c
 drivers/tty/vt/selection.c
 drivers/tty/vt/consolemap.c
 drivers/tty/vt/vt.c
 drivers/tty/tty_jobctrl.c
 drivers/tty/tty_buffer.c
 drivers/tty/n_tty.c
 drivers/tty/hvc/hvc_console.c
 drivers/tty/tty_ioctl.c
 drivers/tty/sysrq.c
 drivers/tty/tty_ldisc.c                    <---------
 drivers/tty/tty_io.c
 drivers/tty/tty_port.c

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
