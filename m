Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868C62B987C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgKSQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgKSQrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:47:01 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5116C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:46:59 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id l12so5970362ilo.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FaAZ3Ie6S4Ojl8IwJ7YfwRCdnjPQtizRhqlrShWzHSw=;
        b=zeKR4T+NvyvQCgl3HJ9IUz0nFCmDPyPffNjPihBKuBviHjsn0NLfJ+KImxOGTviP6F
         iyR45a75WIMB3CcAQZQSAdVIc6Nk8eUTv5NTQODrsvMEoNCPARLgOwJo9TQlBnmY0HpO
         8HSr5ymO22054vQ+v5b73KmecdCR2f0w5h0Ixdza9HZP9/bXhJ/NUvT2ky685QuSPYYB
         95DeZECFTXQPk4mY3iV5K+SRtSp4uRn9Vfw7yuhzGThC0jkfdQ54jZQOMMibMcfQyEcT
         19hlwWMMfDQyMMyeUOEncnr8MKVb2juJnZ+L6Bv8iBNgSavnf5ALf6jTrNlkhnWFXVIp
         6sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FaAZ3Ie6S4Ojl8IwJ7YfwRCdnjPQtizRhqlrShWzHSw=;
        b=B+4i4lKCiuHvTE1UhNMNDV2aZBIAxlH3LSNHRQ7hqKkFvow0hFx4CuprSFOApM2cv8
         /4GOXOSDJEel6MqzSlj4Du0Pmq+3ThR6e2cd0kIKr8MoITp5q7uXhj5JrrIsB26J0dAo
         l7NDs8JSFnW9CreboVyQnpxHcPaoFGHqPpJPv9mvV7RT+6Ro86fo4YV25HFo1OLrt1gr
         kTlxZk4l/7veF5XP+fYE6Sj7D+V2jNvBn7kTxq2P/oSRoukoK+p2awPKj+BtgW5mVKLk
         LzuripWnw66WFoHQq1z7342Mb+yRZyxIcDZVb1jcpVKNWJTxsMm5ryec1iHSGLWz/vlD
         DzOg==
X-Gm-Message-State: AOAM530HFZZIaKrd1olSNS3x2BDM9LD+c/cU20mbqSQDzHZ0GLXwSujD
        TYg+hREtB9YkeLFgZqdPXzz4nNQJtKcRnA==
X-Google-Smtp-Source: ABdhPJxX3WvEa5ao8bfs8kI6M75hJG4I+/QU4VLpOR9ir2ZfnBPp26ILs3ypZw77yzcqFQJX7x4KgQ==
X-Received: by 2002:a92:cb50:: with SMTP id f16mr944655ilq.225.1605804418878;
        Thu, 19 Nov 2020 08:46:58 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o124sm190932ila.62.2020.11.19.08.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:46:58 -0800 (PST)
Subject: Re: [PATCH 0/2] optimise iov_iter
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <cover.1605799583.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2b50322d-821f-469e-6f57-072b54e25ef4@kernel.dk>
Date:   Thu, 19 Nov 2020 09:46:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1605799583.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 8:29 AM, Pavel Begunkov wrote:
> The first patch optimises iov_iter_npages() for the bvec case, and the
> second helps code generation to kill unreachable code.
> 
> Pavel Begunkov (2):
>   iov_iter: optimise iov_iter_npages for bvec
>   iov_iter: optimise iter type checking
> 
>  include/linux/uio.h | 10 +++++-----
>  lib/iov_iter.c      | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)

Nice! Tested this and confirmed both the better code generation,
and reduction in overhead in iov_iter_npages().

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

