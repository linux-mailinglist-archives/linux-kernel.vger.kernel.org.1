Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE52DC8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgLPWLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgLPWLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:11:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D90BC0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:11:14 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id h186so7026123pfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6+IY/IhhJMCu4cpkdJjbEzKNedX2XzHTOgjr1hO/f3A=;
        b=I3m+T/T7fSUvEZUF5nfeCwLL52FR+inHGLqrQw7CV8DBunzMGHyNrKfG2e2nYiNxv1
         ANFA1aNgOHhlpWIdE8jO0Prdgc/z7gjL2ieMV1cOy7EPbfmYSGPgF9kcIfmqUps068Ep
         2Y0DvCWzHZKQszMPO23a4g5R/VqJ5izwf7rSsONmF1DRGbJPC4RhP2ZSmtWq/9LbWFmd
         VAJ1NZQNumwZtAb7F5WWAb7edx0bEmLChpM+53WscIJ5f8Ujm/NmQUEAz5UhmYEJYrm9
         mtsIzAq3Lm0E9iHSbv3MA5ELuA0zRJVIOuQ9GDjnf2fwj7YC65Vm/xuRvSIqB8TZ7li2
         QSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6+IY/IhhJMCu4cpkdJjbEzKNedX2XzHTOgjr1hO/f3A=;
        b=gg40pVQ0JSWdaiJuP1qds7vFimplHdBOu8B4ETe5eQvcNzUEpv3vqbOUspYpyedefZ
         e/DO1whE6OMFlxsU5tEHKGt/XL0axaoO+9c9EMQWfy+TTo9Z+XSUxWPadx23xfKFwqQf
         HcODNWMf62zHQS8wU3VGGszw/YdOLAhaTtofZ7ZBq4KTMeLbgU5nD2In5jxbvpFiOyxE
         zqKZmSOkRUEbsfYySKv1mCBXKgUw3sd+WPjgCDHEmNKjvPA411ejTfJ2aHg4cmmtuZNT
         ibErW/vZU/o9HdYcAUJzmi5b0MDT2hI1EV/qs3Dbo4MXx78Q6VCjWN8ctlZ/5fUVndC/
         pHaw==
X-Gm-Message-State: AOAM532EE/gcv9Su9Ictes/GdZieMr37/YHzewHwIQq2a6byfKAorq79
        3aZ+VwSX1x6Oj7iC1QrMg1OnjA==
X-Google-Smtp-Source: ABdhPJyPJpsa+CfyNpR7RGgAglOxbD05q6KtyRe/dyPaXJ+G51JaVd/sRigkF93fX6m3tpif3cE3kQ==
X-Received: by 2002:a63:4703:: with SMTP id u3mr35072081pga.199.1608156673862;
        Wed, 16 Dec 2020 14:11:13 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v6sm3548560pfi.31.2020.12.16.14.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 14:11:13 -0800 (PST)
Subject: Re: [PATCH] arm64: make _TIF_WORK_MASK bits contiguous
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        pr-tracker-bot@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
References: <701d4747-bbbb-dbb4-d828-63d096fcc22a@kernel.dk>
 <160815345901.27795.2544235487408028611.pr-tracker-bot@kernel.org>
 <20201216220422.GA19075@C02TD0UTHF1T.local>
 <CAHk-=wja217nCNOAS_bYB35kJRSgnv29fUAUGSGMCpf-aqeycg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3cb5f34-5acf-ac1d-7773-908904be1d86@kernel.dk>
Date:   Wed, 16 Dec 2020 15:11:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wja217nCNOAS_bYB35kJRSgnv29fUAUGSGMCpf-aqeycg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/20 3:06 PM, Linus Torvalds wrote:
> On Wed, Dec 16, 2020 at 2:04 PM Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> Unfortunately the merge resolution broke the build for arm64 -- could
>> you please apply the fixup below? IIUC that matches what we did in
>> linux-next, and builds fine locally.
> 
> Oops. That was a bit too subtle. I didn't realize that the bits really
> wanted to be contiguous, and it wasn't obvious at the point of
> conflict.
> 
> Will apply your fix asap.

Thanks (both Mark and Linus), I didn't know they had to be contiguous
either as an immediate value...

-- 
Jens Axboe

