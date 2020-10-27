Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5020A29CADD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829235AbgJ0VDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:03:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38041 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373533AbgJ0VDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:03:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id b2so2410938ots.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=MyXnLNK7IOSxObjzQjXARof4MBzCtf4uf+5fQC51Ucw=;
        b=GWel6yja3p+9z+KCAVSsJgJmSeR1JJxG1us8ner92OwbrbM95UF8FY4hkTK4+3zc05
         8yBgsV1Kwh6N2kM/5//Rv6J1OfUoVtpRdQMs5CGOcZ7lz7n5D/iFZOVJ0TDgnOlLBOpJ
         dq4CrbHpMsWcIMykNA8UhhLIl4z0k2iH6iuwbgmmpwdftCLdy5qzGHsJYJtbMN2re0L3
         kbWhjTxFNTcvanBPwog3jnsjze059t9DMxtvJaEvthckGXeA5o1UE1N12e6zs3oLxGOT
         avJU82PCgOqGaJv4M/A9O3UIFcEKLOrdkwf/z1pCPK3LLDIS0zPQsCjvPOj1sSIrXuuY
         OzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=MyXnLNK7IOSxObjzQjXARof4MBzCtf4uf+5fQC51Ucw=;
        b=oK81LMnLQXvTbSIBQbQINT3eI/u2ILa3rCr6ZYy5HTbhdfQDxuBtqlGUvYrkgk04iX
         l757zwPqILGnWnT2f6mCWYUz7TY3W+GTtx9TjTQMXhjc5t+OqRwleEzjKdC6zaaiSWLc
         /Y1Jt909GHBVX4DViFRXxlQQwXosse8x+GXI2mV/uEEfd6R3NZ7K354FJALxiJScDrq4
         gAzXwH40wOJmiyxK1wwrEBUnajS6HhL3Lo7YICloZHmYRtzCoOOD3bnhywuCs0ddy5Ly
         BOBM9f0xJqpUd0xnsymm833tfK8doRBVaf2c0pOZhfgxkvHFAFqZFb75Tz6reErDxd7k
         B/yg==
X-Gm-Message-State: AOAM5308wcbmLQuRaZXFjqm8mjVCFFicN7cGm3S+FXcYJlLc1zy7FHZJ
        qum4E1PqXlaKmbcrlC6YbQ==
X-Google-Smtp-Source: ABdhPJyrxZFjiKl/XgpHR9IC8xJJVucOKnZXP66h8IzWX8JSD8jbuPaOSmEeMZvzmE8uaGPwd1dusw==
X-Received: by 2002:a9d:649:: with SMTP id 67mr2966814otn.233.1603832621269;
        Tue, 27 Oct 2020 14:03:41 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id m13sm1460502otn.20.2020.10.27.14.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 14:03:40 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:64b8:c481:9aa8:415f])
        by serve.minyard.net (Postfix) with ESMTPSA id EA5B8180057;
        Tue, 27 Oct 2020 21:03:38 +0000 (UTC)
Date:   Tue, 27 Oct 2020 16:03:37 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] [PATCH] ipmi_si: replace spin_lock_irqsave
 by spin_lock in hard IRQ
Message-ID: <20201027210337.GM4296@minyard.net>
Reply-To: minyard@acm.org
References: <1602898810-31783-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602898810-31783-1-git-send-email-tiantao6@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 09:40:10AM +0800, Tian Tao wrote:
> It is redundant to do irqsave and irqrestore in hardIRQ context.

Are ACPI GPEs run in hardirq context?  I looked around a bit and
couldn't tell.  If not, then I can't take this patch.  Otherwise, it's
ok.

-corey

> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/char/ipmi/ipmi_si_intf.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index 45546ac..97452a8 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -1116,7 +1116,6 @@ static void smi_timeout(struct timer_list *t)
>  irqreturn_t ipmi_si_irq_handler(int irq, void *data)
>  {
>  	struct smi_info *smi_info = data;
> -	unsigned long   flags;
>  
>  	if (smi_info->io.si_type == SI_BT)
>  		/* We need to clear the IRQ flag for the BT interface. */
> @@ -1124,14 +1123,14 @@ irqreturn_t ipmi_si_irq_handler(int irq, void *data)
>  				     IPMI_BT_INTMASK_CLEAR_IRQ_BIT
>  				     | IPMI_BT_INTMASK_ENABLE_IRQ_BIT);
>  
> -	spin_lock_irqsave(&(smi_info->si_lock), flags);
> +	spin_lock(&(smi_info->si_lock));
>  
>  	smi_inc_stat(smi_info, interrupts);
>  
>  	debug_timestamp("Interrupt");
>  
>  	smi_event_handler(smi_info, 0);
> -	spin_unlock_irqrestore(&(smi_info->si_lock), flags);
> +	spin_unlock(&(smi_info->si_lock));
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.7.4
> 
> 
> 
> _______________________________________________
> Openipmi-developer mailing list
> Openipmi-developer@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openipmi-developer
