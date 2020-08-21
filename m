Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00324C969
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 03:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgHUBFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 21:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgHUBFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:05:05 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5FAC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 18:05:05 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b2so130415edw.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 18:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSXxxVxBZt5qj3H+1yv/ZiFeWKO2vqSUz4tnuOVfh9U=;
        b=Ox6lZUEybubjhfdPiOKWRZG4qfFEecYwQvufT8kMPiwpTg8/545YywiMSwSKdQaFYQ
         8yTK33s5XJHGaIh16ow88NuFxVBZGDqNfHwhECe1FeiLkw1V9pzS7KCBEv4JMM/Dl6t+
         RmyCaLAagpkumwFoeHNEK99TcKaEkoCH8sEBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSXxxVxBZt5qj3H+1yv/ZiFeWKO2vqSUz4tnuOVfh9U=;
        b=rXcpnNkulatF43oprH8qW/IYH6cBL4vdkGxhP/hHxnFj4w6200vlU5zyqoSeIiSlLq
         y5JR0urLM8C7HHkv1phCvKUToYgesChJcnfqYj3aqX2Y8wjcT54Ppjq5mz/fEUu0tT8l
         fWv8HmMiCGnguAzn/Bj+Fu8SYP0dx/LECBjwFapsyphjrkFSjlPuWVmByRFicJSJy7W6
         +T7Gn/V8MzhQ4Ba6BXkifT0XmavnETAmca9v1qktJ2Z0YR4sMdzaxA7aB8keUFu3jY8K
         Uhw2QSItxiVcuPEgbkjqMetaK61kWa50V/+c200sB3phY8/1Th3lek92xbshhXq1w2XA
         d/9Q==
X-Gm-Message-State: AOAM531BmW3YNcwXwczXvXXpl+TJL6eQrrtpsNs0R9alQecvZJgkRJIk
        dmqI6znyCdxJ5Yg6LkdBs3scZoesaQVB83RhkcYkeA==
X-Google-Smtp-Source: ABdhPJxa+kT00QMBpxe7cjYDje4O13Gp9nSHrcctmkTLHSGiplMHCPalfyONwyQUnB1/nBpstBnLbOK58VZi7MY/GGA=
X-Received: by 2002:a05:6402:297:: with SMTP id l23mr528464edv.145.1597971903431;
 Thu, 20 Aug 2020 18:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <38d00022-730c-948a-917c-d86382df8cb9@canonical.com>
 <4acc34c4-9c17-41f7-2e39-7eda16792572@gmail.com> <CAGt4E5s_=Tai=fTB37VibaCF=2F69vO3ZbVAsBCZXLK2CNiVAQ@mail.gmail.com>
In-Reply-To: <CAGt4E5s_=Tai=fTB37VibaCF=2F69vO3ZbVAsBCZXLK2CNiVAQ@mail.gmail.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Thu, 20 Aug 2020 18:04:52 -0700
Message-ID: <CAGt4E5vBNz6kdXTPLZv1cU=sVKPGvxH75aSLSNe9UqFXUBXxrQ@mail.gmail.com>
Subject: Re: out of bounds access on array error_text[] because of -ETIMEDOUT
 return from __send_command()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 10:23, Markus Mayer <mmayer@broadcom.com> wrote:
>
> On Wed, 19 Aug 2020 at 11:34, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > On 8/18/20 5:21 AM, Colin Ian King wrote:
> > > Hi,
> > >
> > > static analysis with coverity has found a buffer overflow issue with the
> > > brcmstb driver, I believe it may have been introduced with the following
> > > commit:
> > >
> > > commit a7c25759d8d84b64c437a78f05df7314b02934e5
> > > Author: Markus Mayer <mmayer@broadcom.com>
> > > Date:   Tue Apr 2 16:01:00 2019 -0700
> > >
> > >     memory: brcmstb: dpfe: wait for DCPU to be ready
> > >
> > > The static analysis is as follows for the source file
> > > /drivers/memory/brcmstb_dpfe.c :
> > >
> > > 684 static ssize_t generic_show(unsigned int command, u32 response[],
> > > 685                            struct brcmstb_dpfe_priv *priv, char *buf)
> > > 686 {
> > > 687        int ret;
> > > 688
> > >    1. Condition !priv, taking false branch.
> > >
> > > 689        if (!priv)
> > > 690                return sprintf(buf, "ERROR: driver private data not
> > > set\n");
> > > 691
> > >    2. return_constant: Function call __send_command(priv, command,
> > > response) may return -110.
> > >    3. assignment: Assigning: ret = __send_command(priv, command,
> > > response). The value of ret is now -110.
> > >
> > > 692        ret = __send_command(priv, command, response);
> > >    4. Condition ret < 0, taking true branch.
> > >
> > > 693        if (ret < 0)
> > >
> > > Out-of-bounds read (OVERRUN)
> > >    5. overrun-local: Overrunning array error_text of 6 8-byte elements
> > > at element index 110 (byte offset 887) using index -ret (which evaluates
> > > to 110).
> > > 694                return sprintf(buf, "ERROR: %s\n", error_text[-ret]);
> > > 695
> > > 696        return 0;
> > > 697 }
> > >
> > >
> > > Function __send_command() can return -ETIMEDOUT and this causes an
> > > out-of-bounds access on error_text[].
> >
> > Markus, what do you think of this:
> >
> > diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> > index 60e8633b1175..b41c6251ddc3 100644
> > --- a/drivers/memory/brcmstb_dpfe.c
> > +++ b/drivers/memory/brcmstb_dpfe.c
> > @@ -445,7 +445,7 @@ static int __send_command(struct brcmstb_dpfe_priv
> > *priv, unsigned int cmd,
> >         }
> >         if (resp != 0) {
> >                 mutex_unlock(&priv->lock);
> > -               return -ETIMEDOUT;
> > +               return -ffs(DCPU_RET_ERR_TIMEDOUT);
> >         }
> >
> >         /* Compute checksum over the message */
> >
> > That way we only return DCPU-style error code from __send_command and we
> > de-reference error_text accordingly? Or we could just introduce a proper
> > lookup with a function instead of a direct array de-reference.
>
> Let me do some experiments. What you are proposing should work and is
> in line with the current code. A lookup function might be cleaner,
> though.

I submitted a patch for review. See https://lkml.org/lkml/2020/8/20/2291.

Regards,
-Markus
