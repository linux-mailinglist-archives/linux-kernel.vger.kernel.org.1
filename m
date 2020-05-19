Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA131D9B82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgESPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 11:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgESPnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:43:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFDC08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:43:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so6356pgn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nDCjU7k2XMPXVzp/hHLiozXK2Q7t2yiQQnE2aeBeopA=;
        b=ySydS5S7NCcxW2sO7kS+ESFm9nQcmN/vQ1Ctcc2Rq1jGiYT7ZWbKXfY72i8et7nX5n
         LfGZysbkrQHm7rcDOyJ3Y4qiMNCm4NwoW8MCWbcUuh1v7ZOsguXwMwQ8azkHXUMoPnXt
         towh7OUR/rQbM440RD8pH1hzeLTe+XUpe+eUsHdYKHIrKU4vp/W2LVMouqFMxFIOJBCZ
         H+5ALyj3F6b8YRvBv7FGISsB4hKfLfn2oU6Yk7zOdl32d803oWftxco18RPOfCrX1OpD
         nMkw1sjMd4Ydu3NYoftN1uhAs9iDcaiVbpRbqraSykeGXnVnHj/sVeQ3hW730HQQShtc
         bmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nDCjU7k2XMPXVzp/hHLiozXK2Q7t2yiQQnE2aeBeopA=;
        b=pRLvIFpj6fdNdIzQnqu2QFUCPuQSpVEmUrVE2ovmNg4Fg3zPOUx/MNMLbI21zneGg1
         jQTODrE+PJR/Fuez0e06btouB8lVA6CQmtZh1jCitdovtD9EtNSwv03REyFlMv18VAgv
         vC4jIvfyohnMssi9LAzVi8HAX+jN5cwagfwBCDhi+hCcAGu0SWkYGwFeZbqFzOm7k1OP
         zW+OZGgxZ9jUMWqCBb78v8mUwpRvsN42zfa+NJE/I7xv1DIqDCHKJealC4pFEeFZ679r
         vagaboHi8mKFBjcGL0KeqrEXGNuRovhr7REEVwokyEHPK/26R5TrwVpK74Ms/AUArr7B
         xSKA==
X-Gm-Message-State: AOAM530BOKH99ou7OOtwM55m2jLkMariahMSIxYyAWiOGnn3vwgh9jVG
        8mjf4l09Xwjljd/8Cw4ZdbHpCv45j5g=
X-Google-Smtp-Source: ABdhPJwTeViFpRe8oPY+FVS1lEyfrccIDBCPotb4uA6K/7gsrYzywZ8Vs+MxlhratyhUQ38VLXp/uQ==
X-Received: by 2002:a63:b0f:: with SMTP id 15mr6801029pgl.6.1589902980570;
        Tue, 19 May 2020 08:43:00 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:14f4:acbd:a5d0:25ca? ([2605:e000:100e:8c61:14f4:acbd:a5d0:25ca])
        by smtp.gmail.com with ESMTPSA id p30sm980275pgn.58.2020.05.19.08.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 08:42:59 -0700 (PDT)
Subject: Re: [PATCH] block: Remove unused flush_queue_delayed in struct
 blk_flush_queue
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d4104441539e9d8d2bc29a9c970713ba1ef2105d.1589715744.git.baolin.wang7@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec068795-5fd9-9d90-19bc-c145456fa5c5@kernel.dk>
Date:   Tue, 19 May 2020 09:42:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d4104441539e9d8d2bc29a9c970713ba1ef2105d.1589715744.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/20 5:49 AM, Baolin Wang wrote:
> The flush_queue_delayed was introdued to hold queue if flush is
> running for non-queueable flush drive by commit 3ac0cc450870
> ("hold queue if flush is running for non-queueable flush drive"),
> but the non mq parts of the flush code had been removed by
> commit 7e992f847a08 ("block: remove non mq parts from the flush code"),
> as well as removing the usage of the flush_queue_delayed flag.
> Thus remove the unused flush_queue_delayed flag.

Applied, thanks.

-- 
Jens Axboe

