Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993CC287546
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgJHNgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgJHNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:36:12 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319F0C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 06:36:12 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so5668625ilo.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e7rKdhz9ciQ35grcxHtJq/vbArd/VYg41u1IRyoy8VI=;
        b=HfGsbetB6A3geRl7IVm3II/NsMYKjFCFSFfoj1iukhJmepiTMLgPiaDn5YGf4i9jz2
         TqzIuKIFdAe11i4HznOu927mFEkzbGbAUlRPOXKK0LtJT4hLAcZdpODNOt9fOtxaUhQv
         k8uAtIVRYHNJi7p8BAWiPjXYOwRdIKTL5bHK+Yzu+P77q2eQzbDsVgeJPVl9KUe5cIF0
         MmGOb6XJUvNH96DiwSkhKRHbINUNOs3sRNpDrKBQkzU5TGoao/lz8X24GZjZWS/F1Ft6
         it2raX3dGmumll3aktLzsGWbzLAgFFLyoH3G7uz0iKOpx01VF03O90IU0ZFs2adTgnvV
         SVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e7rKdhz9ciQ35grcxHtJq/vbArd/VYg41u1IRyoy8VI=;
        b=g8KAeC20cx5BGMIQXZIH8QI/o1PWeYP3DNjFawvQQNWux1xoxMS6OCAF8lzSdU3l7q
         /QkPYPXIACtbaxAPfIoRC64dsJ+jMoxJx+w3ANG8DumLQTm20dVm8TQ0+MoS22wgJClE
         3VzHHA9FTlhxbMR1jj3q69jj3U2J0PdhDUf5zYq2FnP50s2aS9IJcarMM5Mu+Kw1bWSW
         ofarKCoL1pCWD/Qny5xnaQOPbynPsTqCICjOmQ2zkWQlGPJNGK+7UP4+eJVN01XiNUYQ
         tvgxcn06XMnoGfFEeaumWzijCFoPxn4737Kj5NcWXD/phheq/XCPOCKr5k5GC/RbvhsY
         xskw==
X-Gm-Message-State: AOAM5330dySTLXG3++KlIKZn8gOTtVNK/42TObUMF0MqAjcQkTmMMXNK
        qgXPQuvBzELdziI5N7SNLnjgtg==
X-Google-Smtp-Source: ABdhPJz6tDDYK+6C45xazMybLC2eN+4Dol/Z1XWOgrGCAjKxpHzNLZq/+mSHZoSnPk7k+mx1rgBKMQ==
X-Received: by 2002:a92:2591:: with SMTP id l139mr6902795ill.271.1602164171318;
        Thu, 08 Oct 2020 06:36:11 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m10sm2636882ilg.74.2020.10.08.06.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 06:36:10 -0700 (PDT)
Subject: Re: [PATCH 1/6] tracehook: clear TIF_NOTIFY_RESUME in
 tracehook_notify_resume()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
References: <20201005150438.6628-1-axboe@kernel.dk>
 <20201005150438.6628-2-axboe@kernel.dk> <20201008123748.GD9995@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <641b5760-3b0d-0ac9-02e0-5322daba7dad@kernel.dk>
Date:   Thu, 8 Oct 2020 07:36:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008123748.GD9995@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 6:37 AM, Oleg Nesterov wrote:
> Jens, sorry for delay..

No worries, thanks for looking at it!

> On 10/05, Jens Axboe wrote:
>>
>> All the callers currently do this, clean it up and move the clearing
>> into tracehook_notify_resume() instead.
> 
> To me this looks like a good cleanup regardless.

Thanks.

-- 
Jens Axboe

