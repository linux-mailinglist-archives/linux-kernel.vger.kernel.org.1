Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC89128442A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 05:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgJFC7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJFC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:59:38 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F84C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 19:59:38 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i3so901564pjz.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 19:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fiV5Hzg7ySfcqy2a5Gsazf3x115DDvbmxR7q2HrgSkI=;
        b=O7s8q01hNdS8xPOYGpuGSbqcdPqPmFgIQrR+3UGUm8X7Td5CxH4u6VqbDj2x4FoK/Z
         2dvl/B8/E7iZvV9lvmGP3LYl7cFjEhnp/6ICKyWhd1N1kCxT6Bp3MzmPcuVt6Gtdok9Y
         RNOgJ/f0GspAw8zEUAN+vBos/zK5W0RLSiIesE2v9lSeSLsF3pKLEoSnpfN5eekP1s1n
         S4McZXZnxXbnuOLzSifpKjD6qNllQ1ec34tlmord9dHh5irbpMkLw8WQKzTWMDfEzjUZ
         kn1m7ERwgPMtCDMqyY0hEIRp7Q+sY1ujjW7VYwWKrcVcl8plP+LQGCfUuRohvmehf/Rd
         iTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fiV5Hzg7ySfcqy2a5Gsazf3x115DDvbmxR7q2HrgSkI=;
        b=Kyu6TiY2Ss7F6X7RWf1fmssayrkiWOscnjeH9/MQoTt2pTmo/xrJFtI7RXtJSRfnzg
         bDpajxvxErpTp9+iGuFAIRgfR22fUBJv72km/Ydw/4FvXb+cwbOxgIUgvhfPZxTp56ja
         D7bZHyGZCJSp4iu2dgcnp+jfBlkz4FA1wyNzm0Ua4thjYVNZ8+ulGI5ucbQXANgkgrta
         Ty4nCSZCmlZmCQNJ5YoLAZ0pD216oPiS094iRbLcir0E6Ct8vUSW7xY+5bl3YQwfAJ1U
         djrUacjj2VNr0eFFa4J1RWg/jMMXB3pdiLdlzsv1/iEfyIekyuu4P307l4cVqFdeWgTe
         Hjbg==
X-Gm-Message-State: AOAM533sntrrrRX+Il60CCDRJvaYpF/ibYFjWP0hQc/MWSpWeUc74Jrm
        yTQQ+Zna3UAesI9sj+CIHzQ=
X-Google-Smtp-Source: ABdhPJwyTfIKhP32gbX9FtTKV5XJT+ZUQL2ymj4M0VrvvUC01Z/rw9RJ0tWWQ8r1AP6ypU5vXkhMZA==
X-Received: by 2002:a17:90b:4398:: with SMTP id in24mr2198671pjb.236.1601953178033;
        Mon, 05 Oct 2020 19:59:38 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q16sm1343999pfu.206.2020.10.05.19.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 19:59:37 -0700 (PDT)
Date:   Tue, 6 Oct 2020 11:59:35 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Shreyas Joshi <shreyas.joshi@biamp.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006025935.GA597@jagdpanzerIV.localdomain>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522100046.GH3464@linux-b0ei>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing Guenter,

On (20/05/22 12:00), Petr Mladek wrote:
> On Fri 2020-05-22 16:53:06, Shreyas Joshi wrote:
> > If uboot passes a blank string to console_setup then it results in a trashed memory.
> > Ultimately, the kernel crashes during freeing up the memory. This fix checks if there
> > is a blank parameter being passed to console_setup from uboot.
> > In case it detects that the console parameter is blank then
> > it doesn't setup the serial device and it gracefully exits.
> > 
> > Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> > ---
> >  V1:
> >     Fixed console_loglevel to default as per the review comments
> > 
> >  kernel/printk/printk.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index ad4606234545..e9ad730991e0 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
> >  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> >  	char *s, *options, *brl_options = NULL;
> >  	int idx;
> > -
> > +	if (str[0] == 0) {
> > +		return 1;
> > +	}
> >  	if (_braille_console_setup(&str, &brl_options))
> >  		return 1;
> 
> I have fixed formatting and pushed it into printk/linux.git,
> branch for-5.8.

Petr, this patch's causing regressions for us. We use blank console= boot
param to bypass dts. It appears that it'd be better to revert the change.

	-ss
