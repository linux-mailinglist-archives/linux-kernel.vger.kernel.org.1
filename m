Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8CF290CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393617AbgJPU3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390751AbgJPU3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:29:30 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB58C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:29:30 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o9so1872672plx.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H7i+8CG0VezDxncLDsSfvwAV5Z67ulpr447ijtY2QB0=;
        b=fQzmAQbQ2NZGk+Uzvb2BlGacXVYAzvn9WHtQkDiyThI7jHzE1dQH3neGn9q6jy0i+E
         pMyomEgKN8Xf4qzO2TI5rScNx7iDW//zJjVRGQvgBkwVlBb8c1RjO1O+R2iYAqKPkVDR
         WSLIbWHTjUFd1u5ZycvGqQYWNCy/9qgXQ11jucRiuO+E/0XnfxDZUtCfZ20HHX5YiCX/
         bg2YuFrwjWZw9XMt+JMvUKUp3eRslIbVKHOM16ScMo9PNcd8L0ItmrxOLh0xPuXcR2G1
         FAcy1KDrTpmiIO1OE1UY5lXWQFqrP5LyD0MFVQT55HgHcLhU/eKHLlINaz7OppOuYY3Z
         2Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=H7i+8CG0VezDxncLDsSfvwAV5Z67ulpr447ijtY2QB0=;
        b=T52t/Gh9dYzyf0mYg1o5bCCjxLSPc465154QZ1f59dPJemeG4IvUcLsRvXwj56IDfF
         U8b9hIMYv+zaXzrPt4/Q/6TcjPmEk0NIB5b5gm7s6I0twTNuLdYUqDmTE751MH2Buz09
         Te+lM26Dp5LbSwOKbkRq1EsXl+eqKho/ZQhT54M+El2YjnyvgIyztDaGpG73a+pV3a8f
         lyxYYxLrXGa8wCACA7lo8xwxNOdfhl8Jzou8uLZiSVR4rg9UYe+aWVbfELO8S5+ufA8w
         rW4Xy0NomIAairSDgdL5tVLZvAU2CjjdaE/+ddPsCcfVaLU4Avh3VY4yT37sHNoaBxcW
         jRPw==
X-Gm-Message-State: AOAM533ZjAa9DfkpFG94+lIUXXMutwHKCvnScNP+gDDf/Ct9NuPIFwir
        qzyjXqBiBDAutJQNEKrrqQ0=
X-Google-Smtp-Source: ABdhPJwu3BwQqhHl7G7SuuhIVedhg4GEtNmK3nsmk7gaYG3uLezYG+f3s/seQmHSbscErI0cRPekWw==
X-Received: by 2002:a17:902:d34a:b029:d3:dcb5:a84c with SMTP id l10-20020a170902d34ab02900d3dcb5a84cmr5722171plk.81.1602880169945;
        Fri, 16 Oct 2020 13:29:29 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id c12sm3841110pgi.14.2020.10.16.13.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:29:28 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 16 Oct 2020 13:29:26 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, rajekumar@google.com,
        amosbianchi@google.com, joaodias@google.com
Subject: Re: [PATCH] zram: support a page writeback
Message-ID: <20201016202926.GB1976566@google.com>
References: <20201012071452.1613131-1-minchan@kernel.org>
 <20201016002547.GA2412725@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016002547.GA2412725@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Fri, Oct 16, 2020 at 09:25:47AM +0900, Sergey Senozhatsky wrote:
> On (20/10/12 00:14), Minchan Kim wrote:
> >  
> >  With the command, zram writeback idle pages from memory to the storage.
> >  
> > +If admin want to write a specific page in zram device to backing device,
> > +they could write the page index into the interface.
> > +
> > +	echo 1251 > /sys/block/zramX/writeback
> > +
> 
> May be we can make it more explicit?
> 
> 	echo "page_index=123" > /sys/block/zramX/writeback
> 
> Just in case of future extensions. E.g. someone might want to
> have something like
> 
> 	echo "idle_nr=123" > /sys/block/zramX/writeback
> 
> which would write_back 123 idle pages max.
> 
> 	-ss

Make sense. I will use echo "block_index" since page size could be
changed later(e.g., some pages are 4K, some are THP).
I will revise it at next spin.

Thanks, Sergey!
