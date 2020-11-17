Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741792B67E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgKQOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgKQOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:50:19 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D86AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:50:18 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id w10so4471438ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0F9QrEMmipyRzRUrpK0Sko+2gt7s5nXq2Op6QHWtaWY=;
        b=fG8a2uQLrFTPi4znGWSt+P/xgw0UKNCRO0UgviV5HOFquLtz1rjhw5V8zvXFlHMJrK
         ziyyKSm7G2wirbwzmnStcscR4+w0dvLI8v/TuSmOo6hl1OsuWrwneotUFBSRth4FUgpq
         QCTvZCkPbkEPhWqGy0m3MvptcDAjhJ7G5UhY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0F9QrEMmipyRzRUrpK0Sko+2gt7s5nXq2Op6QHWtaWY=;
        b=mcL0Ya5Qa2jLOz3UDLl3jQ4DZHCn1U2ycxZQvwXCKjGdEikuV2hrV09g/HRrfD5sJ4
         ZaI+srfCzXGyF3poE+YtwxTT4dMqWOO1LF4lQKvFudnEhZ1cqcqTRh45Ewh6piL9C2Bl
         R3/+VB3O//x4yHWq+0QD/komTmHW/ssur/XK/RiFqDNXfp+E2hR/zj6ZS85pmvEj8S0l
         ubipqdENXHFKI/cKwwiboZAGynenLCBBRxfbAfFtsaXVyAdWbFLuXjXi//BKSjui0aP1
         Q0L+ZYxcEB83570B9DVYkrmuwz7IFBIHIyZBmw+hds4Vs6QmMByZxls89fgjD3OUp3iq
         1hPw==
X-Gm-Message-State: AOAM5330iAuT0IDULlXsR0rwX+vo8+zu/Vs9d+IgRD9GGyrMay46jkhm
        6fwn5rR5qdGHSQ/MZk0Lmch2IF5FGbQDOw==
X-Google-Smtp-Source: ABdhPJyrANrNGg/dWB9vjRuI4mge19PoX0QvpjAv4oSotcRHIzQB3qpxA6K+J7PWRiUj+YwjUSif5g==
X-Received: by 2002:a92:c042:: with SMTP id o2mr13022311ilf.103.1605624617604;
        Tue, 17 Nov 2020 06:50:17 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c89sm13961342ilf.26.2020.11.17.06.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 06:50:16 -0800 (PST)
Subject: Re: [PATCH v2 01/13] seqnum_ops: Introduce Sequence Number Ops
To:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
 <26cbcc431be5e3ab7d8e0e881d522605a27b1312.1605287778.git.skhan@linuxfoundation.org>
 <20201113210327.GJ17076@casper.infradead.org>
 <20201116144914.GE3121378@hirez.programming.kicks-ass.net>
 <20201116145850.GC3121429@hirez.programming.kicks-ass.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <050d5555-f8b4-f54d-e13c-149815b1b64c@linuxfoundation.org>
Date:   Tue, 17 Nov 2020 07:50:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201116145850.GC3121429@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/20 7:58 AM, Peter Zijlstra wrote:
> On Mon, Nov 16, 2020 at 03:49:14PM +0100, Peter Zijlstra wrote:
>> On Fri, Nov 13, 2020 at 09:03:27PM +0000, Matthew Wilcox wrote:
>>> I think almost all of this information should go into atomic_ops.rst
>>
>> No, we should delete atomic_ops.rst. It's bitrotted nonsense. The only
> 
> Sod it, I'll just queue a deletion. That'll stop people from trying to
> update the trainwreck.
> 

Please don't delete the document. This is one of the documents that has
the information to make decisions about the api usage.

atomic_t information is spread out in various Doc directories. It should
be consolidated, instead of removing files.

thanks,
-- Shuah
