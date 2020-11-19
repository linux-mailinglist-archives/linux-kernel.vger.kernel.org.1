Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD42B992A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgKSRUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbgKSRUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:20:04 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7888C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:20:04 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y18so5990413ilp.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 09:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Cuh0RTTSFAlmIPVhGB92scgG2gp7uIXGl6U8eaIkwws=;
        b=VGMYR7GIyigGqFMlURJN1OniF74reh1UdQXfBzrlKlnYeM+WRXlnHYCvAek+XLZl+j
         fnMW4SKO1FBIJPHj2Yi6SohZxhvFabSdCp+cz9YCH2FNIeSNV62dzclA+evfaJH2QBOs
         Or3W4G6dSf6MJ1czMoPcLasp5lrGvUJu9RH+cPxkDlBy4F/tLGo6R8vg1bhpk8h1xlPH
         IvcvRDOyW/1XkjXvhwz6Jdg17E9LYTylvdyqaf7yXdmNocIbZLtvoDsXU01T+/2RfZkY
         6xDKT6SF2aNEgX7rlD69MPQQakerXRxeaE3nPaaZ/WCkz12FdpPJxXHzisFXq1ATjZy+
         LFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cuh0RTTSFAlmIPVhGB92scgG2gp7uIXGl6U8eaIkwws=;
        b=GYo9BkEGhxB1yki53x/aHU4+5R3QZpHSeU0F60ioJA9vV+zRNUWoQj68URmC2NFKtq
         HrHdWPYUjOeisrWcZhNp9luX+Hb/4VPamT3MfesrpqJ/YlkWseuSfWxlr/suk6933lT0
         AfY+1BFcBZQ1Syae5EGB7o8kUgIkCXyU7MTQyB+kzlsePtXCCTSsXq6bruu4qTv4H48Z
         2g86/E5LOf0P9U+RApLZ8Df0vj9U/9D4eXfjTnZ6bV+vj0E/n9qS3axqyqtn3yoVu49S
         GF2JZ0s762dSXHmYXOy10W9Ay4iwy5D0j30JD1pRKfJ4yAtvTSkTczOUWm/7vXHyxqoP
         rpsw==
X-Gm-Message-State: AOAM533T7oo8M3HFb0LLcxe8cRJpE4RefChS8DhWqe77AD+EH0UwIpOd
        UPFjIlyIAosVNbCDIIipbD+t+8z/dNUnHw==
X-Google-Smtp-Source: ABdhPJxqW+pxzeKvGrbOkUbneyIPxMDLzPVQq32823a3f0cted9sUHxsKt6LdBhk+atDCT70aCQa4g==
X-Received: by 2002:a92:d143:: with SMTP id t3mr2340629ilg.35.1605806403250;
        Thu, 19 Nov 2020 09:20:03 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x5sm237863ilc.15.2020.11.19.09.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 09:20:02 -0800 (PST)
Subject: Re: [PATCH 0/2] optimise iov_iter
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <cover.1605799583.git.asml.silence@gmail.com>
 <2b50322d-821f-469e-6f57-072b54e25ef4@kernel.dk>
 <629cabf2-3a23-9d95-dd88-281ef4d49ddd@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <72a1df1a-810b-5bf1-39bd-b702188a875b@kernel.dk>
Date:   Thu, 19 Nov 2020 10:20:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <629cabf2-3a23-9d95-dd88-281ef4d49ddd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 10:14 AM, Pavel Begunkov wrote:
> On 19/11/2020 16:46, Jens Axboe wrote:
>> On 11/19/20 8:29 AM, Pavel Begunkov wrote:
>>> The first patch optimises iov_iter_npages() for the bvec case, and the
>>> second helps code generation to kill unreachable code.
>>>
>>> Pavel Begunkov (2):
>>>   iov_iter: optimise iov_iter_npages for bvec
>>>   iov_iter: optimise iter type checking
>>>
>>>  include/linux/uio.h | 10 +++++-----
>>>  lib/iov_iter.c      | 10 +++++-----
>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>
>> Nice! Tested this and confirmed both the better code generation,
>> and reduction in overhead in iov_iter_npages().
> 
> Thanks! Did you find t-put/etc. boost with your setup?

Yeah, for this kind of test, if we shave 1% off the stack overhead,
that directly yields an increase in peak IOPS. My numbers were close
to yours, dropped about 1% of system overhead.

-- 
Jens Axboe

