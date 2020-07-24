Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A2722CBB5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGXRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGXRK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:10:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8193AC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:10:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so5535077pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZnPHclC6+qPirs2OzlzBaPpy9luS1xKwM1kwdp3jws=;
        b=NlvfE3oDgS37ALwOwpurjIKddIbaCMe31kaUitURIUnktln05P90IYxg6oFa/HnZYM
         hVhO4XTjsUHrBHhJksFsMIDUWAfRpGDVpOcxQk8bMqUdcnHZdy9jzfnavU1xLDZjyWnu
         P2K4eDkhYB0UkIAu1OX9IO1Z9H/fLxeV/ttrynSYWuP7CK4tyHSJ95fWPl9e8ZNcsG+5
         ns8BEqSl/tXWcs/dcy1sTisxiOOWNRkz3KoulHOFzMNQeMgkNyf8j7KpuSltrm+DvFzX
         jYbKrZEmIAplHJLcPvBjMFScYtXQ2ql0lVJRvyKR891ETejQZCzfTcSwfwQuAoSkPjxB
         cAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZnPHclC6+qPirs2OzlzBaPpy9luS1xKwM1kwdp3jws=;
        b=ghhI9hHC2YBwVFLm2pPPKbtIxy90F7B/I3by9rIFVcBFbAyeN9G9t0Upm4LGmtkrxY
         t1MKkfFflcy8dwM5PNZh1Lye3ddRfKeIy+tg1eHVxnuEhQmOqLc0d3pLwiTcHAA9zzS3
         h7Ylc9o/9aUDTjCW6SMilC3uPBfvoRi0M9AygglXnSgCIqHrjbzfmj0YfQiYdpPwNQ3T
         AoPkvzkIJlMLaDlZCJQXr2Ko8QMyq81z1qM/VNMC+tbR7j5oldH/m/U/TOT3ZfM5ocIP
         +qoQsZkWG5sNb66PbglcZK451GHWGKRRH01L/83ZvumA2hj7GsCJJdoCXI32SrmR4+jR
         Hlog==
X-Gm-Message-State: AOAM533F+XakMFl4UwLfhOnU91+jRvjcSdqYbVszTgQAbfqlK3lKscKa
        6c7iIroz86euKdgfkKP3Cv1QUg==
X-Google-Smtp-Source: ABdhPJwVjWrYK81nqEulx40FKPXj6fUdIM/j5LImuMSwFYgxXf6iXcgedJRJznZFqwXkpNs8btGSlw==
X-Received: by 2002:a63:5a17:: with SMTP id o23mr9463311pgb.218.1595610656008;
        Fri, 24 Jul 2020 10:10:56 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id b13sm6969611pjl.7.2020.07.24.10.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:10:55 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:10:47 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Andres Beltran" <lkmlabelt@gmail.com>
Cc:     "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <wei.liu@kernel.org>,
        <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Michael Kelley" <mikelley@microsoft.com>,
        <parri.andrea@gmail.com>,
        "Saruhan Karademir" <skarade@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Fix variable assignments in
 hv_ringbuffer_read()
Message-ID: <20200724101047.34de7e49@hermes.lan>
In-Reply-To: <20200724164606.43699-1-lkmlabelt@gmail.com>
References: <20200724164606.43699-1-lkmlabelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 09:46:06 -0700
"Andres Beltran" <lkmlabelt@gmail.com> wrote:

> Assignments to buffer_actual_len and requestid happen before packetlen
> is checked to be within buflen. If this condition is true,
> hv_ringbuffer_read() returns with these variables already set to some
> value even though no data is actually read. This might create
> inconsistencies in any routine calling hv_ringbuffer_read(). Assign values
> to such pointers after the packetlen check.
> 
> Signed-off-by: Andres Beltran <lkmlabelt@gmail.com>
> ---
>  drivers/hv/ring_buffer.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
> index 356e22159e83..e277ce7372a4 100644
> --- a/drivers/hv/ring_buffer.c
> +++ b/drivers/hv/ring_buffer.c
> @@ -350,12 +350,13 @@ int hv_ringbuffer_read(struct vmbus_channel
> *channel,
>  
>  	offset = raw ? 0 : (desc->offset8 << 3);
>  	packetlen = (desc->len8 << 3) - offset;
> -	*buffer_actual_len = packetlen;
> -	*requestid = desc->trans_id;
>  
>  	if (unlikely(packetlen > buflen))
>  		return -ENOBUFS;
>  
> +	*buffer_actual_len = packetlen;
> +	*requestid = desc->trans_id;
> +
>  	/* since ring is double mapped, only one copy is necessary */
>  	memcpy(buffer, (const char *)desc + offset, packetlen);
>  

What is the rationale for this change, it may break other code.

A common API model in Windows world where this originated
is to have a call where caller first
makes request and then if the requested buffer is not big enough the
caller look at the actual length and allocate a bigger buffer.

Did you audit all the users of this API to make sure they aren't doing that.

