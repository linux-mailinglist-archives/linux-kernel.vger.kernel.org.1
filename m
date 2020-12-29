Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7B12E7542
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 00:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgL2Xsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 18:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgL2Xsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 18:48:42 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26927C06179E
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 15:48:02 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g15so10141322pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 15:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpodWtOja8+8IgQp2uqm+eXTXrWRDnzD9wzyhFOEunM=;
        b=ZPN8t/RShB+vZaktcFvJMDn8rfY8t57pa7UwrbvLkaDEri+Ny4a8r10Km9QCWJtlv3
         KeS9ZmaCCRYV4koYUsXTYUIMwbDWIlMoJNv+W81i1zK/P+GAJ46KoCivWeUUjC9a6YWH
         oEmaFS56HwkTNG9/l5614oEECZ/pf2PMdpZLkiATp18keq506vwGfZCtnya+P+ZZ996d
         zcQXPNfajxDJri7E8p+hoG+zHMKpiYC6BBJYkL/4EwL3SqBc/QantedHIeBnmZttDepY
         S5SGD2OdeHCIA9tLnx8qt0+2iDlE+GajlrD5OPOU2YoKO8E/zMY7knhhgjygK5+HRgGf
         SPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpodWtOja8+8IgQp2uqm+eXTXrWRDnzD9wzyhFOEunM=;
        b=D+UE6DsEViiqwE+QOyMMIiVLaq+eWUibvpJRgr4ifbGVHte7EOVi+FLC4FGIZCbik2
         m5TOY7izM+B5VobSeEBzcAaUWL0pxRnQqh3x7mIivznmxq0H8u4rK2T/qNEhRxD45uvH
         1uyOn7j62ZtE64RnNPKKl9Lq9I4Iw+jZF5c/2gWEB12CW1koXE9hc9V3If6VI2aQBvBD
         GZxkxT2xexFkvf6MXKpXAK3Mwk4w1f5eGZlLHiwEm6Idbd9TiqPLIXB9Fy7pWSWGwYiS
         GaY55sHiFs4DTD/rD5dA0LhrgcqSbcbQz/O25eYZ/FVg2cVx9f1x3/odMIzkdec8gXCg
         M5Gg==
X-Gm-Message-State: AOAM533ODIkJVPRdk2D4QC//jHCosZhYIOHvqXmqcHsDhPGbjjtv/ynm
        uzI6kOGKLp0mg8QcQciGj+DuTw==
X-Google-Smtp-Source: ABdhPJx1F45NRQCfWmkqeCvBNvQ/AtsH1YOZfRIEoF4NJfpqvzUUjlNj2gy71Do6H5g4LKoltCceLg==
X-Received: by 2002:a63:4821:: with SMTP id v33mr50398388pga.7.1609285681645;
        Tue, 29 Dec 2020 15:48:01 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:8f91:de2a:ac8a:800e? (2603-8001-2900-d1ce-8f91-de2a-ac8a-800e.res6.spectrum.com. [2603:8001:2900:d1ce:8f91:de2a:ac8a:800e])
        by smtp.gmail.com with ESMTPSA id g3sm4244239pjt.34.2020.12.29.15.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 15:48:01 -0800 (PST)
Subject: Re: [PATCH] block: add debugfs stanza for QUEUE_FLAG_NOWAIT.
To:     Andres Freund <andres@anarazel.de>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Christoph Hellwig <hch@lst.de>
References: <20201228192717.1015629-1-andres@anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2fdcc766-0999-02bb-5ed9-e943dbb81277@kernel.dk>
Date:   Tue, 29 Dec 2020 16:48:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201228192717.1015629-1-andres@anarazel.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/20 12:27 PM, Andres Freund wrote:
> This was missed in 021a24460dc2. Leads to the numeric value of
> QUEUE_FLAG_NOWAIT (i.e. 29) showing up in
> /sys/kernel/debug/block/*/state.

Applied, thanks.

-- 
Jens Axboe

