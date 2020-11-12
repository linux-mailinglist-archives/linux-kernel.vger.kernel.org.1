Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD52B06DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgKLNl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgKLNl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:41:27 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D17DC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:41:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so2787740plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NbOh3NQvPF5NSQ0ZHg5/eVshkyTIZIL3Bjt3PJ7enmQ=;
        b=eOeIhiQs5zanpHtEgF4hvKJXHW1Pgr3XE6glcFw79NO41KICMwmlm9g1zu2pTSYgxe
         lEVkl1qR+qQzdf/BXqcJSwsaRFj+RFZL7X80O4ZI25Ru4GQ64wsojk07qnvwF8/TedPY
         doYYhRoiASf0OBbCtHCyUfprRzo8ga6appLkb5NZOuXEQ9VWKdS8zlHhgbo1Qd2kQx/Z
         kWWN6TBqa82lXIM5OY/maBFxTn44qXFz73VZOvApx1RgSSnGQQ25SJ/QhOLslFdBU4IV
         r4DPlptwcdtt4ik0F9087dqGKbzjnJRfqEukOKztusqN3X5890IQYjsCqb2SXb3OWeqX
         sfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NbOh3NQvPF5NSQ0ZHg5/eVshkyTIZIL3Bjt3PJ7enmQ=;
        b=HG2XMxZAHF8+pMRl7JirZg+Vttby6pO+zB8Um/+P9gsMtAq7KSjSDCFZLOh4Y2Ny58
         LZqxRZhKw55PAoAoNFGXoNIrJOirUs7qyz6vTRl/lEQIt1p7XOfTOGtjvkpulz92TqG9
         r8ED0xbkE/EAfCRj3YoN0niolLEQKhD0i+XkoX0Va5jgjX7XszLPqASK0Rcx/1bJgOF3
         Dajox8MNmUd6IodH/LtaeAB/dAA6UF1gR9rs/r2QYU6Suth62Gb+jE4LH+ptjnG1AoE7
         IcQ23QFr2YZXTnC6ahcZZihogGoqumx3z5aX6jYfdlI5UgAr+GLpoUCIaZF00FKWkxIy
         +RLQ==
X-Gm-Message-State: AOAM533rbSz4HHxesHaPq+RyJP1+i2YgaZMs6S3gARcrZLpmtf/DSNsN
        hwygRmrQgRwT9wuRamBv+CA=
X-Google-Smtp-Source: ABdhPJxKwhdJcbK9O964YXpi8yqR4FeE30kmOerl/VhRU6RmzYq/1cix6nSsxdhVkubYCZvnL6wJtA==
X-Received: by 2002:a17:902:7283:b029:d7:e4f5:adc7 with SMTP id d3-20020a1709027283b02900d7e4f5adc7mr17385197pll.20.1605188485875;
        Thu, 12 Nov 2020 05:41:25 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 85sm6605505pfa.204.2020.11.12.05.41.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2020 05:41:25 -0800 (PST)
Date:   Thu, 12 Nov 2020 21:41:22 +0800
From:   sunjunyong <sunjy516@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ttyprintk: optimize tpk_close flush code
Message-ID: <20201112134122.GA20821@mi-OptiPlex-7050>
References: <1604469744-8708-1-git-send-email-sunjunyong@xiaomi.com>
 <X6zptw9Fbd3AKbPy@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6zptw9Fbd3AKbPy@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg:
It have no logic that handles NULL in tpk_flush() but tpk_printk().
Do you mean that if i understand correctly?!I think we should not remove 
the logic that handles NULL in tpk_printk() as we don't know if the buf 
from parent caller is null or not.But we transfer a null buf to tpk_printk()
 for previous version of tpk_close, i think it's redundant.

The comment is a hitory tip for other guys to understand.I suggest to 
keep it as before if you like.

thanks
JY
On Thu, Nov 12, 2020 at 08:52:23AM +0100, Greg KH wrote:
> On Wed, Nov 04, 2020 at 02:02:24PM +0800, Junyong Sun wrote:
> > tpk_printk(NULL,0) do nothing but call tpk_flush to
> > flush buffer, so why don't use tpk_flush diretcly?
> > this is a small optimization.
> > 
> > Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
> > ---
> >  drivers/char/ttyprintk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> > index 6a0059e..2ce78b3 100644
> > --- a/drivers/char/ttyprintk.c
> > +++ b/drivers/char/ttyprintk.c
> > @@ -104,7 +104,7 @@ static void tpk_close(struct tty_struct *tty, struct file *filp)
> >  
> >  	spin_lock_irqsave(&tpkp->spinlock, flags);
> >  	/* flush tpk_printk buffer */
> > -	tpk_printk(NULL, 0);
> > +	tpk_flush();
> 
> If you do this, then please remove the logic in tpk_flush() that handles
> NULL as now that logic will not be needed at all, right?
> 
> Also the comment here wouldn't be needed as the code obviously does that
> based on the function call being made :)
> 
> thanks,
> 
> greg k-h
