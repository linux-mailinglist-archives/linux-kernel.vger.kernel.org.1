Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B4C3043A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392832AbhAZQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391950AbhAZQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 11:18:39 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0456C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 08:17:57 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v19so11721477pgj.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 08:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=epgYCzdc72kBsoz5/bU1Ciqhlsremw0jcEwfc6vQq00=;
        b=buKxZXNp5UJibZh3nqNGwDHf3vzgy8HQqITHVHIP8ptalwP+WFPqWHplJ+ssAzYibz
         s0Z/Bn+EcuBbwJ5mxpTlbFnUjNFS+OrVHV83Xt03WmpI3B8811kASQXjlI0+xMQkGLKI
         Vw3e2kfOsTThCoPNgAqMCdjTfjlcuWguu8xPidiIargUNrEA0KFJ5P2A4GdBMKPLbXyB
         L+RBnTA0ITU5/w67h/91KqZg602FKiYNTpMg8sz53BTpM7xYT835NPMcmWRfDnD+covK
         0utH7WDNIODvHxfVHRKHUVtWhn+aLevkJkcmuEU9l4opE9a63Qefhgp5EF+bsUicN4eu
         bl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=epgYCzdc72kBsoz5/bU1Ciqhlsremw0jcEwfc6vQq00=;
        b=eoe9rbIJ3sLfa/VtFI2Y/yRt0VVmG3cgGIXXRXg5WHKAYaMrHP2MO3mF+KqgyIFaQe
         Ff9fA/UoojCYKwcmaYF9EnwJ68rvajR7NBa5fNHZ4FXmS0l/o2xF6fb/cIoE+L2o0jRo
         7pCSa125qchKgWuwl8IiYJLPgT7pWKunSlZIcO8hpsAJSlIrXHeRqlkFxHe5mkib6PJi
         BCLCKH/ncZVE6SsfmAhtrgRMpkUkVcUtloCbDl1575257LPekToMBcKKDg0+wLzGKj9y
         3x5Ym9GdZr044NgRO3ZHZ/H2h6XRK+e0t0x1qt1xUI5UG4e7O+0aD/mSu7mx8CUT4Auq
         X+tA==
X-Gm-Message-State: AOAM533Hj08ucCz727jh/XCK1o1UL9Zvz0IBk/JKrTPuGX8BtcJkIm9h
        VQrg0xCrfSZlm0U98dh/QSaIVg==
X-Google-Smtp-Source: ABdhPJzayUmLqyp84K+wfgc4GWyTILacj8dMzGotGEXVhIXyu2CQpO/Go5PZbRnMpxoOHjQZaYTcTg==
X-Received: by 2002:a65:52cc:: with SMTP id z12mr6261716pgp.116.1611677877191;
        Tue, 26 Jan 2021 08:17:57 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a2sm19528814pgi.8.2021.01.26.08.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 08:17:56 -0800 (PST)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 1/6] block, bfq: always inject I/O of
 queues blocked by wakers
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-2-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23cc8281-a869-b260-ba0c-22127db2019b@kernel.dk>
Date:   Tue, 26 Jan 2021 09:17:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126105102.53102-2-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 3:50 AM, Paolo Valente wrote:
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 445cef9c0bb9..a83149407336 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -4487,9 +4487,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
>  			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
>  			bfqq->bic->bfqq[0]->next_rq ?
>  			bfqq->bic->bfqq[0] : NULL;
> +		struct bfq_queue *blocked_bfqq =
> +			!hlist_empty(&bfqq->woken_list) ?
> +			container_of(bfqq->woken_list.first,
> +				     struct bfq_queue,
> +				     woken_list_node)
> +			: NULL;

hlist_first_entry_or_null?

-- 
Jens Axboe

