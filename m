Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12121F9B5F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbgFOPEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 11:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgFOPET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:04:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0CBC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:04:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so6948367pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cZpiXSF12XfOjR7Rqd/jEt2LEGNKKJL/5+ZFRXFRJD0=;
        b=eaM7SmlSIbbYYwLlQKQKN3s1VXlgvV97QWt2VnV5p4/rcL2a6keGKOmZZerVKHI+40
         jXEPO1qVaiv5m+SXHbwhiH/PxaBUvSRXcYFvROAK3+px3uBwD5dUDIhjSChledyp5HQB
         pre1jYyts1p/ly8H4Q3OUKwO0r5kMDzrwmD6jsnM+GHGxbVHpmeTnxbjjxnc3rY4dioj
         kuhsgqeRwkAA+x3SVNk1bn4z7+pGD+1B0GulslAa29viVuIvdRf/TahUzErMnPjqghTP
         vzMyWBZMlZ9hc4PzrOHP3JUE9Ib1iJF5h6H1M5DRLwpF5zTxGXdVFe9CeGp4WGr7vYe+
         FoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cZpiXSF12XfOjR7Rqd/jEt2LEGNKKJL/5+ZFRXFRJD0=;
        b=qEUcM1r6v1EGoJ1sdYqU1ggGVu5tJE+Khw0f3lVF/yqTHs+EUUJBZLnmVDnMf9SBFz
         LZmBaT1OM0PlXtjHMIclMOfOUhwnzxG0jX9CAWhuD0lmFMq0FagyntC94lPTkIpehmDP
         SC/Zxi4JjCceNSNpvKwHQSstdTc2n4tNtJ/pcr7KFgZyoZbcPW+aMuicZ2WlJphuoVGV
         C/0k1ja6xVmOfHm4DiLFH8cs7Z4mN8UhS9G4H6YN6zpXaLNTImbuxSlpQOsDR9A5xptH
         zAzZ+0JlHXDxObHdhkSjr0qp2biGTAOGokEBxZ3loRGxQ7yBLfmcvvLgzZVM3O+PA8kr
         Yvkw==
X-Gm-Message-State: AOAM5338j0/RTeiZF/3CFy1HIQ+LHqnVhjCx0uSCYNS7EZk4yH5lQ2lp
        Lc9FJw+OxAx3eR9DwyqAhjkP+fckjYoQjQ==
X-Google-Smtp-Source: ABdhPJyKaUj8lcGi70+zg9pMMQVi3VGnHiJAEoah7XZguN/TFcAWMF2yXVUmShZS3GGkR41IjANMGg==
X-Received: by 2002:a17:902:b787:: with SMTP id e7mr11733374pls.277.1592233458327;
        Mon, 15 Jun 2020 08:04:18 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u7sm14621286pfu.162.2020.06.15.08.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:04:17 -0700 (PDT)
Subject: Re: [PATCH v2 0/4][RESEND] cancel all reqs of an exiting task
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1592205754.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8033114e-069d-e8d0-f476-1f4d4bed3e25@kernel.dk>
Date:   Mon, 15 Jun 2020 09:04:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1592205754.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 1:24 AM, Pavel Begunkov wrote:
> io_uring_flush() {
>         ...
>         if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
>                 io_wq_cancel_pid(ctx->io_wq, task_pid_vnr(current));
> }
> 
> This cancels only the first matched request. The pathset is mainly
> about fixing that. [1,2] are preps, [3/4] is the fix.
> 
> The [4/4] tries to improve the worst case for io_uring_cancel_files(),
> that's when they are a lot of inflights with ->files. Instead of doing
> {kill(); wait();} one by one, it cancels all of them at once.

Applied, thanks.

-- 
Jens Axboe

