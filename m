Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F2D28DCEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgJNJVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbgJNJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:43 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ED1C08EC69
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:54:55 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b6so359295pju.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OoUJ7lX2R2U0c2LHktECeAhkCF1e5wdtf2xgBEgdwtw=;
        b=DNZ/9V7zjzzagTKx2A67mUvfnjhrS37F0MEsqUwC5Vdim2aFAL+3kCokjEwz/BhKbz
         zH5wPTY3bDJ+VXiRiGm5KdLhafUnlbXGhZ3S0WLKpLRV5ARq9hGIbQpVK7CNJBQB0oho
         DJAJ5YBkaNDmkv1clj+abfmz+ceiIjQLiRBUUuKHQ/+telPHiJ/rj3LtqP8Qo/LipAGx
         pa0ezECnTrg4jlVs27wqJ1ZclY4TEBtxanSMG+hMD7jCeSz1tsAqUWgvYOf5egkQwqMq
         qnHEKYX9fUyUH+yVGvt5AAmPa1/+pgxrWP2jmZ13FIvwGHsn2NchGfjIGhyCZNJ4BjR1
         J64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OoUJ7lX2R2U0c2LHktECeAhkCF1e5wdtf2xgBEgdwtw=;
        b=Pp+BQGXBGOMHfWkHBglMMeRWO16sp4vsLD3ZaGZVpS4UX+T13w461lV/OgpIMOxmBZ
         kD+ZXDQ8+JRHdZXwYSYl0lX8cfOaIGXLcm/n0pt3AIPU23mOIY7lJNNuNoQQRs10T8/x
         PF63aQJ4Oen6HYbwOaQRAy/x8kxAwkdj6M7SLsrpy9NzJRxzI1pXyvNknKzDKEGXZmES
         ZAe6MADXZjkHNsVdPNzqYDomggktlD0mO7LsAUsv0bE3QwkCGeQ/bQN3oDdYQssCdK33
         JAHX2S8KU6fXrCHmOC79gTxOl7311bC9TUNRTYYzom/uS7NOiPEsRv2/tOuuQgdtJU5g
         X66g==
X-Gm-Message-State: AOAM530Ze7SCYkc5rDquM1zNTCklYnlKj2NWpMZskLyfmRayy4zukfH/
        hFPUTkRGTG+woi6k2Q6KIxLejOmMFBkaTfNg
X-Google-Smtp-Source: ABdhPJws+u5VscfkfvF+d9f/ewTOW4jptZRkhRaXc1AF9uDwkxAqMc9t1EPXpRGrYy0WXKz35/n92Q==
X-Received: by 2002:a17:90a:e00f:: with SMTP id u15mr791287pjy.87.1602633294801;
        Tue, 13 Oct 2020 16:54:54 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id g4sm844641pgj.15.2020.10.13.16.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 16:54:54 -0700 (PDT)
Subject: Re: [PATCH 3/4] kernel: add support for TIF_NOTIFY_SIGNAL
To:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org
References: <20201008152752.218889-1-axboe@kernel.dk>
 <20201008152752.218889-4-axboe@kernel.dk> <20201009144328.GB14523@redhat.com>
 <e8319a4c-334a-e888-7d31-f43b4ae6822a@kernel.dk>
 <875z7dd70p.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bdd8ddad-5433-8f54-fbec-20a5f6f8bec2@kernel.dk>
Date:   Tue, 13 Oct 2020 17:54:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z7dd70p.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 5:45 PM, Thomas Gleixner wrote:
> On Fri, Oct 09 2020 at 09:13, Jens Axboe wrote:
>>> Hmm. I just noticed that only x86 uses arch_do_signal(), so perhaps you can
>>> add this change to this patch right now? Up to you.
>>
>> Sure, we can do that. Incremental on top then looks like the below. I don't
>> feel that strongly about it, but it is nice to avoid re-testing the
>> flags.
> 
> Yes it makes sense. Can you please make the signature change of
> arch_do_signal() in a preparatory patch and only make use of it when you
> add the TIF bit to x86?

Ala:

https://git.kernel.dk/cgit/linux-block/commit/?h=tif-task_work&id=6a150da501727f6bdca4786a02c0a57160e13079

with the pre generic patch being:

https://git.kernel.dk/cgit/linux-block/commit/?h=tif-task_work&id=add2e252ae8481350239c3cb893aed490c05c397

-- 
Jens Axboe

