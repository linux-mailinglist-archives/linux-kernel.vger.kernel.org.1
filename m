Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6033F28F560
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbgJOO4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388856AbgJOO4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:56:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F03C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:56:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 67so4813122iob.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AURqElLapXfIq1JtkqDTZMuELCauu1vdJG7L6jXFcKU=;
        b=sSAfg4AYXOFZCFNYkNGm/lC1+de9uqy6ujB1GXTiKPsKVpnnTn752c9RUNwQDjDHrp
         O8BLjxEcibfhIIfYkZQo4ldOTIj/h86z4FutmZFEgIffQWKBu89vxh97D1x4AcI3DDQd
         Na9zYkoO8NriBao2qi32kZqT7zEHcKyx3E2ioKuyvWGXelLR9sa+r0GWbPjKVkkpIR5q
         D93orduTmYKPin9VlxHtWkt6r8lBf7tb1Lj1X82u3EvwNJ2be7x9LVCEytVKt++xFwyH
         USjsqn0N1vAiEr8Si6VRCPi/Ya+gAWiiKLb9bo8QRwYUeHCBLtdhaTPr46SRxOZ2OSp+
         p6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AURqElLapXfIq1JtkqDTZMuELCauu1vdJG7L6jXFcKU=;
        b=fUydBGTKrr52Ks+kbnBjEaI1u6SZaPeDDI7b6b8oWqOOa1RcIKfUlT+cLFDyMedoSA
         5wTK8Y1aNw4rJnvfxvmcJhIjiqYYAVlJYRIsQGlbiVZh47dMO3JWUCm265TQzKdhDXpF
         zO4ygXwc3yXte/CRxpg092nwGNPdxi7jD763Zvq8oh4+J9jdUR2rbhvLCdy4S4MKxvNV
         +MVFn2momQ/uCjJ6wcn4/cAVEbDhzHD6FjrSWCcJosvn6ZU4HD9cSSGOI3C7xOxuPTu0
         tK1L1prjWzzrbsOWoGb7skvZyp7Jwpsac9qCL9FbdLTaSu9UoV9593pWVGP3MIvaaEKs
         Jo7Q==
X-Gm-Message-State: AOAM532w0OEjdr0iu51FKXerpaHpIF1Byx1P1SxSEWtTF0wCZMEFNs4M
        QOXHsTWjNwtZrwjuUYSOMOGBpg==
X-Google-Smtp-Source: ABdhPJzLp0ghQwKMj3fGnZqXE6trkU/wVwv6YXUokKAxI5FjspONir29jz521ZzOGC4e6ntSzCdKeg==
X-Received: by 2002:a6b:fc18:: with SMTP id r24mr3523381ioh.127.1602773778903;
        Thu, 15 Oct 2020 07:56:18 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y8sm2751899ilq.2.2020.10.15.07.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 07:56:18 -0700 (PDT)
Subject: Re: [PATCH 3/5] kernel: add support for TIF_NOTIFY_SIGNAL
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
References: <20201015131701.511523-1-axboe@kernel.dk>
 <20201015131701.511523-4-axboe@kernel.dk> <20201015143151.GB24156@redhat.com>
 <5d231aa1-b8c7-ae4e-90bb-211f82b57547@kernel.dk>
 <20201015143728.GE24156@redhat.com>
 <788b31b7-6acc-cc85-5e91-d0c2538341b7@kernel.dk>
 <20201015144713.GJ24156@redhat.com> <20201015145359.GA14671@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c51b1579-10dd-c818-e601-a07f07501f42@kernel.dk>
Date:   Thu, 15 Oct 2020 08:56:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201015145359.GA14671@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 8:53 AM, Oleg Nesterov wrote:
> On 10/15, Oleg Nesterov wrote:
>>
>> On 10/15, Jens Axboe wrote:
>>>
>>> That is indeed a worry. From a functionality point of view, with the
>>> major archs supporting it, I'm not too worried about that side. But it
>>> does mean that we'll be stuck with the ifdeffery forever, which isn't
>>> great.
>>
>> plus we can't kill the ugly JOBCTL_TASK_WORK.
> 
> not to mention we can not change freezer/livepatch to use NOTIFY_SIGNAL,
> or add new users of set_notify_signal().

Yeah I know, there's a whole slew of cleanups and code removal that
can happen after this series, once all archs are converted. See:

https://git.kernel.dk/cgit/linux-block/log/?h=tif-task_work.arch

which is all of that on top of this series.

-- 
Jens Axboe

