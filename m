Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA9302DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbhAYV2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbhAYVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:19:40 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67A7C061756
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:18:59 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i63so9133933pfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q+E2QKYZrluBg1iBjQcak9MCibuQJCXbencd0L2CEXM=;
        b=w4IcicZbBoygZLxK2+ZjwfLVCA5GB0v4cbBBX+5PEGG9DjSu4dgMOET+57SXcJyBd/
         vONyKRVJJf7NIkT/Tg8JeJgtTzy9mceZ2+wyfmL+2bGpbzJej1eUsz6MlHoX3AX4elY8
         VV7onfeGs/WwGYsk1MfxUoGHtNg/yn0j/Qt6ty/YrR68JosNkFYn1HnFoSnhWCw2yt8P
         68/WR/FiZ+28j3UrwQBmd8iVwyucoP8IzkssTqyen0IEwUwQUc3XagTD+InltkBjrMew
         n8D5wE3Gn7iV9CtrMoTtcFas09mEAaQhUgX+aK0k7DZRFPgtIveXLAHXuc6wRWCoTcR8
         cdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q+E2QKYZrluBg1iBjQcak9MCibuQJCXbencd0L2CEXM=;
        b=q3zmGvtaNH5atNBOwzn7fcO/mpxai2UmRL7SLIbko7Uh77nR8Q51/p1jfhqRqdsM26
         Iot2CEM+Sp67Bd++nUasscG+v/BGjaBBkoMuAedDnd5NHUZGWMRYhtAQH6iMe63pgWXB
         rwTD65dwkfH6ASsOuWBgkvI3+I0XQ9UMnn94uRXaTzsPM+cNQ272vpfHHVELFxv+eW7J
         85iNL78MsuzXaPylEwjJPNPqG1LegvIAobv67wD2zHVkDLV1V+RdLiVxxqEH8ezLjxui
         xYse1htZ2aLwJSdPCE+8ij2qX8PQ2AhJyoDYKG4Uk6MVJVmQSEUI3JgoD1Ard/lUOF/S
         rImQ==
X-Gm-Message-State: AOAM533/7wATSaG6GjiTIVYFJ366MGGDuIVCyYvV2A0FTKFnsBcodF9c
        PjVvybzqQQZrxmIemEh+Vfzp0Lhn8asJzg==
X-Google-Smtp-Source: ABdhPJwLqpaGmQeIn98hN4B/n7hJ4LVC8tm8BvqnQxWCX+m2eS68Fwi/gy7lTD0qb2ib36JEDvAIaw==
X-Received: by 2002:a65:5b47:: with SMTP id y7mr2363233pgr.221.1611609539114;
        Mon, 25 Jan 2021 13:18:59 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id n1sm240830pjv.47.2021.01.25.13.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 13:18:58 -0800 (PST)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/6] block, bfq: second batch of fixes
 and improvements
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210125190248.49338-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <50888903-86bd-0815-e671-58df34aa01e2@kernel.dk>
Date:   Mon, 25 Jan 2021 14:18:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 12:02 PM, Paolo Valente wrote:
> Hi,
> here's batch 2/3.
> 
> Thanks,
> Paolo
> 
> Paolo Valente (6):
>   block, bfq: replace mechanism for evaluating I/O intensity
>   block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
>   block, bfq: fix switch back from soft-rt weitgh-raising
>   block, bfq: save also weight-raised service on queue merging
>   block, bfq: save also injection state on queue merging
>   block, bfq: make waker-queue detection more robust
> 
>  block/bfq-iosched.c | 328 ++++++++++++++++++++++++++------------------
>  block/bfq-iosched.h |  29 ++--
>  2 files changed, 214 insertions(+), 143 deletions(-)

Applied, thanks.

-- 
Jens Axboe

