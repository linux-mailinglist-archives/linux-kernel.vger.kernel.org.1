Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1728F4FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbgJOOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388725AbgJOOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:43:46 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A39BC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:43:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id l16so4395776ilj.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qcgv+2yJUkH/T84kDkk4JbFTa/M9KcP0jfRpeslZ3LQ=;
        b=xmhP1BAAEgSIceO9muBHRjD/8G8w9XY4UWUzPhZBaRXQTiTwE93iK3FVfjB2V/t7cJ
         LRGcPtuc6dsRJhiVXZmU3NnXRuOb/PBwGiP+w9SbqHDcZaFJP5psBWLTrQxL1N+HX9uM
         lH/yY0yHWCLTLoAQ/Gjv1ECJwg6q4dLmHyiCQftPDRTV4xbSgefgtWAII459zA1P78Uv
         qVMLS1Z2iq6FzYmuDFaAgf/UIND9h6uOHL9YvoF2SiGdCwkqKxATAKP271doD6q+GKR2
         LSNjHgvapx22dqL5hw4FrBB/IQigmI/ilXQ4K3+QrhkDDA804nhuLbYX6v3nZj3IL+1W
         qY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qcgv+2yJUkH/T84kDkk4JbFTa/M9KcP0jfRpeslZ3LQ=;
        b=Ymx5NYkkT1hZmqBKiggyp7wC0DK+D3+maoMCUMnjQloNyzHq6h7YO68S7Kuf60yB5Q
         lWBF+T4yXbXQoXzK2JJ5lwiz9VcHiYwWzbUT/dn8FZBQ0CRNcNKB0yJrJ4QKttb5avqf
         6BHswNY8eYZaN4+s4u68Gpb8dnuKR8QnY4RpVLXOmAmW41jwChpoSlJwrGEXxX8UXPKd
         pMlIq8Wu13UcVO+0yJD3k27zdMrM550V4f1fmNvaRUF/7cHF+HMcrufUh9eECUU5zgmT
         Krdgf9Aa4F4a+S1QBa66m7WuGSXKltpQ9ydyv+qRlhcTaMGHEqkEw8ug/BY9wMEccW8E
         j2kA==
X-Gm-Message-State: AOAM532fRSZIGoacUJzqztqgsP91KreuxJktMNSeIwvEiRvb1BEmV7yj
        z8VinsiFdZKZ5lpW5us3UZdo18Xfduh9jA==
X-Google-Smtp-Source: ABdhPJw3SnuM0CVnK+/LFdSp3qvCJ9+lQUg3YjgomaKAmVOoLG3gV1oFjuJzuzYgO1Kb0eq5F1T25w==
X-Received: by 2002:a92:c986:: with SMTP id y6mr3384387iln.10.1602773025483;
        Thu, 15 Oct 2020 07:43:45 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s77sm3479346ilk.8.2020.10.15.07.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 07:43:44 -0700 (PDT)
Subject: Re: [PATCH 1/5] tracehook: clear TIF_NOTIFY_RESUME in
 tracehook_notify_resume()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-2-axboe@kernel.dk> <20201015144207.GF24156@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3cdc9a4e-1133-201f-b737-e4e73185d193@kernel.dk>
Date:   Thu, 15 Oct 2020 08:43:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015144207.GF24156@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 8:42 AM, Oleg Nesterov wrote:
> On 10/15, Jens Axboe wrote:
>>
>> All the callers currently do this, clean it up and move the clearing
>> into tracehook_notify_resume() instead.
>>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> in case you didn't notice I already acked this change ;)
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Apparently I missed that - thanks, added!

-- 
Jens Axboe

