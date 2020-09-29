Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1BA27CE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgI2NEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgI2NEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:04:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3067CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:04:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id q123so4475181pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v1a6ntYKXiwEGiBIH+GUoX4OWfSKMb/b92UKRWs/rVg=;
        b=ESE7yBhgSflhhrCZj2jJ5Anr7aMT35+5QhYE6bve8kHxgarJ2TK+NO41F+UZQW1fNf
         GmDhLNfMa797B4pRfIWYOHxtpmvzqFSZt7KKeAQbiPYsgvRNfDNIidLKTVZz35apHWHZ
         SMCPnOvynGcZsgf9vQihIKiw7TbLSAy9EEidShmDXeieTnG9MxfAYoFaOlZ47SLt3IL/
         +0YjpcyCmMZeKp4Xm0j+sYcLrRbMc4V+omNY7NsKMVXZlXvStyrA+gUnCCoygm7GhaZP
         W+xCpciIU3G1LKLpx7o1rH5yzEUIBgR0ueELgXsHHvKEe99pL+8NRVjnzrwul2jIEpna
         ih9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v1a6ntYKXiwEGiBIH+GUoX4OWfSKMb/b92UKRWs/rVg=;
        b=m93Xl/9kJ5PmyMt5L2Goyk23c4zwji+l1pdVjxrNuMSVQe2SMIMBX9bMDx2LYxWuTn
         ZRXISDZUq8srmAi3yLKO8jRsbzl+3GUZ2HqFzZDu5zGKb+jlKoyoQTyQvZ1DZ+SSbY+3
         IeEWSHMrLcx6aXTAk6R25ZtpkOc8mRL5ZqnYssn7BvaVWhCjVsa/RkRPDOdA2pbHtOTK
         AIsKvDA6uoUSk/186FJNWcBGwpKzddp5Q1SrggrB/I68JgE1OfNokAe2iz54KLTnuSSf
         ep+KACu6ma2ZNIS/bIEdox/TnhtIMVyJTH3C+tZ3nBKjmBV8RKvIjI5P4/JjgdPNyNnB
         NX/Q==
X-Gm-Message-State: AOAM533DG8PfsRyfgIRhh8bZXkh5jRyz01YX8T8d1kIyx/+UDIiBzo4Y
        B8doBRdlJ74lBa3eCbVDSL4=
X-Google-Smtp-Source: ABdhPJzW1yMCfUwewNlGAVEuYUC5RHK9Jr/VfHP5ONGame5uUJR3uzn8bsu8PZvGyOsbFyWbRGXh6w==
X-Received: by 2002:a17:902:d88e:b029:d0:89f4:6222 with SMTP id b14-20020a170902d88eb02900d089f46222mr4548349plz.10.1601384653584;
        Tue, 29 Sep 2020 06:04:13 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 137sm5732412pfu.149.2020.09.29.06.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:04:12 -0700 (PDT)
Date:   Tue, 29 Sep 2020 22:04:10 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next 1/2] printk: avoid and/or handle record truncation
Message-ID: <20200929130410.GC529@jagdpanzerIV.localdomain>
References: <20200926015526.8921-1-john.ogness@linutronix.de>
 <20200926015526.8921-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926015526.8921-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/26 04:01), John Ogness wrote:
> +	if (text_len > buf_size) {
> +		text_len = buf_size;
> +		truncated = true;
> +	}
> +
>  	prefix_len = info_print_prefix(r->info, syslog, time, prefix);
>  
>  	/*
> @@ -1911,7 +1916,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags,
>  		struct printk_record r;
>  
>  		prb_rec_init_wr(&r, text_len);
> -		if (prb_reserve_in_last(&e, prb, &r, caller_id)) {
> +		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {

Are we going to pass anything other than LOG_LINE_MAX? If not then
maybe we can drop that argument and compare the text_buf_size to
LOG_LINE_MAX?

	-ss
