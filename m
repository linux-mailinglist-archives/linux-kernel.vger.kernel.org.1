Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10252C88A3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgK3Px6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3Px6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:53:58 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C47C0613CF;
        Mon, 30 Nov 2020 07:53:17 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x15so6709622pll.2;
        Mon, 30 Nov 2020 07:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XL+gEtLKF5TbtWhyDLeu71fgcb40bHQjbGEt03J+KJQ=;
        b=mjqR2XRw0sTw8mfSziT6pQr3iztcPuVSjvpyvfaKwfseqpGTxcvE79mhP820ksdGKc
         CY7d9iuh895rz38mvIN4uTna7isa9zaeZnUTas9Gd7bBr+TqLXiHm2n4nPmtZORYZyJ4
         rjmeGklmItUURRQ2i3HbLKOEI4LhlUPa3Kh1bCRG1yfzxWQ8QjUbwz2xjZXWyaJcX0Km
         lM1Tt2RgzL4GJ3HOtLtXEERqksoyXfNNnrHsnt6GE3qVxTg3em8FQLzpu7O1FPM60YZy
         4aIc6onqGeBo+aMF8eCPRsq8l8WY0bEwLo29umN09V7ZL46fR4g2+gRv5p+02WyPLYTd
         7DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XL+gEtLKF5TbtWhyDLeu71fgcb40bHQjbGEt03J+KJQ=;
        b=cXM7tT2I1r/nydfKGLGwJRJ9BWoefR7KiyThy1iaDJtMlpmDGDv+89INNc0Q/PgCpS
         0hsnKy5ulq3E18E9IcqHHydoelwVInLq1sRXZ2YplDy/O0WE61IafOuYOwMpv81MvoOl
         jLTRztmKMurbasKqDwxJjeU0UHuFbEeaAKeY+xZ2lNwbDxfpYon1KyVE/gQTzrg2jLS4
         ybdKf6fKdR9/kH1F57KEjolfwOlkddwuYw57LhuZ2wE98sOFM5kv7hUfg6a12s2Yjnx3
         CnMheeu7ADzdm1fnSklQzqb53jTJWStA1EryWYpyHyzcwpiqbcRLyjhu1ciLuwlwwUxw
         pOLA==
X-Gm-Message-State: AOAM533rvP/K0H8jPH+GbN/v+U4CYanHj5GlvYa+/BfwYpgfMIP3V33Y
        KLZq7DJApoFVdl+o4/DQ8Cg=
X-Google-Smtp-Source: ABdhPJxiVoJPKZalI/tDDI2rv1drqlE/C7sDL3EpVHr85z2lOu1xRvzNmy67S8eDuDPPZFaAfWPoSQ==
X-Received: by 2002:a17:90a:4405:: with SMTP id s5mr26762160pjg.219.1606751597508;
        Mon, 30 Nov 2020 07:53:17 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m11sm17625628pfa.24.2020.11.30.07.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 07:53:16 -0800 (PST)
Date:   Tue, 1 Dec 2020 00:53:14 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH] printk: remove obsolete dead assignment
Message-ID: <X8UVamNsa+8fwnAL@jagdpanzerIV.localdomain>
References: <20201130124915.7573-1-lukas.bulwahn@gmail.com>
 <X8URvRhAB2AE4DZT@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8URvRhAB2AE4DZT@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/11/30 16:37), Petr Mladek wrote:
> On Mon 2020-11-30 13:49:15, Lukas Bulwahn wrote:
[..]
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index f279d4fbd9dd..6e4e38b7cd91 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -741,7 +741,6 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
> >  			if (LOG_FACILITY(u) != 0)
> >  				facility = LOG_FACILITY(u);
> >  			endp++;
> > -			len -= endp - line;
> >  			line = endp;
> >  		}
> >  	}
> 
> Yup, it was used to write the trailing '\0'. But it is done earlier
> now. So, it is not longer needed.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr
> 
> PS: I'll give it few days just in case anyone else would want to
> review it. I'll push it then unless anyone complains.

FWIW, looks good to me
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
