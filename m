Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE392D1ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgLHAOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgLHAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:14:42 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE9C061257
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 16:13:18 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g18so10564373pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 16:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dc3t9mRBpnlT44bCLhGzwWThsrC3gxEqUeJxmxZZ+lk=;
        b=xsirvh8ATlDyuCU+cX8nhCJ8eA24b5LLLk7M3C7wX0+d3uwYveTYpU5TpRd1x1IyPv
         hnaAveAfnRZ5Ce+nrl9/Nxt94ehpdMHVdHahwkZ7sfJAPR0ECdxqHFZaBnEYBX1n3oDs
         Rp52vz7lvJWg7JKFsdZIIt2TrS3bb54frwm+2juNKE1+mn31NKqrK4N0mj/fmIw7HE1h
         gvWPBaDxtIN/IzJ4vXr8mojoCyLQPEFprgtw5o8vEgODyyKpvxEfIWP29X3xnYYlPcNx
         xnv8bIjKmEBMOYblSUsNLG3OShkl7+iuDo4cjCcdziRIp5hNwYpCTTMgngmW1mn+dAdQ
         S6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dc3t9mRBpnlT44bCLhGzwWThsrC3gxEqUeJxmxZZ+lk=;
        b=S+/qFDl7QmnMZdN+9G2niJqTVvF1kbpZO6rLN931TL2plcQvOh0Snijzh0OLCDGCWf
         GcMuoRE07B9BhBirJUIhQ5pjqlg0iLopA5RscN9iBtlu2m8gOs/zrth5RLCfh8hBF+5+
         pcjaI/m4Vjif/e2lrLhK82WvBaQHdmrFygmPSBpeCO1onZa3HHPpXcf4kf5bOlxfVe7y
         nXFKfm2u4P57CFUwdqUmI385L1E2xBOWM/gpEFzOFoGHlDUr7DzEixgVDPsSEggAkvJL
         L6qIpGwm17ULUqOR7wWExNdlQ94ZvzOlAgMniYqpi//FJlqlFhMTa8qBghBZRMefto9u
         Y9OQ==
X-Gm-Message-State: AOAM531Y06sgc8GyfSQDbOksbLJARwzKCeuF/YnHxlvXmr35Fr9r+NBy
        ed5+tz5t+g1R1/yRHTsAolLhaZscL4bE1g==
X-Google-Smtp-Source: ABdhPJzcYjIjGcWM85g3oUzqjlr5TcChOclvb0wo6EHyZavtmXqLSW/ZEQ0BdaW6sx47Tz71feoFAA==
X-Received: by 2002:a17:90a:7842:: with SMTP id y2mr1335115pjl.36.1607386398251;
        Mon, 07 Dec 2020 16:13:18 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gz2sm522596pjb.2.2020.12.07.16.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 16:13:17 -0800 (PST)
Subject: Re: [PATCH v2 for-next 0/4] optimise sbitmap deferred clear
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1606058975.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ebc2f40-201a-3617-f521-66e894de95fd@kernel.dk>
Date:   Mon, 7 Dec 2020 17:13:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1606058975.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/20 8:35 AM, Pavel Begunkov wrote:
> sbitmap takes away some cycles for my tag-deficient test, removal of
> locking in sbitmap_deferred_clear() gives +~1% throuhput.
> 
> [1/4] and [4/4] are simple, it'd be great if someone could double
> check for ordering issues for other two patches.
> 
> v2: add 3rd (CAS -> atomic and) and 4th patches

Applied, thanks.

-- 
Jens Axboe

