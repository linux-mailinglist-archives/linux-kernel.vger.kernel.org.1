Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79AD1B2FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 21:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDUTR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbgDUTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:17:57 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673C8C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:17:57 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f19so16201656iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fg+d9vwBB0VnYM+Wjdo25HAeAJv48I8DsMCOjXRYSG8=;
        b=WxTmLPXr0CN6t9INnjIZm6HWE9QW38vHWbuWfNXcN8JB45LP9RjUQ7HFqJS1djAXRU
         k+P7IT6uNQo+fwAG3q8DqgKjoph9cgAC6XQ0PKjysheJvfoS8V8fnMZ7OgVT1FVIlMA0
         /iwnGO9u9Cb1SzhpdYcUmyotjBJKOdxagT6B9dmmwLeuXQQIxvFnz3odHVnQRxOgDsun
         pjeXRwbbcgBEfq6a0zAcRLm0a5WbMR31UOdNDMm5+FSGu8XKPuVuT57Kj3PsAffgourz
         r/7zjLUsy/uukZFD3XTfmn++PGk5nvBuD0CLCES88WJQB7EJvov0tsSt1VdqXFB5HaeT
         Vfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fg+d9vwBB0VnYM+Wjdo25HAeAJv48I8DsMCOjXRYSG8=;
        b=Yuj0+Hytxi62WZ2B2GkyNib1NBUnzcb4+tNJQPkJkIY3xrHWq2jz8NbuDxQzniURqD
         wyzuL4pAewT73yZUqRKD6aZDeYesUKyk8fnX1D4Gb5g9RtbVyxl1RnMPy8QQEWR7pE1x
         fOI+8IrhbodtP5eNUwz2RZu2DF5wCJ09QgQWAZZvvO/kS/SuaXBNKRGhoBN9p7HfLj5a
         KmJ63oU2TQCjuV0GIxtZPIiGb7Y83JMvMRigf2fxOaQtIyRT0Q9f6BXrU6aNQUiJDtP6
         B5IjHsaU308wrne+kIvBvwHlke8t8lW2FhyHBBCe1YRcNKeCPXMrb2EGdSZHHcww/1Fk
         1lQg==
X-Gm-Message-State: AGi0PubeO1Bdg+3zj7DWUJvW7f7KtfrCqiU4ojM1mjnkCGYtl19Wi9E3
        7AoBomkFocqTyEmdaTiJ86aiuA==
X-Google-Smtp-Source: APiQypJ+r6SoH5WGNOv8uTtJ4RO+FvnSg+7Z68uby7s7ga0AKoakunxfUDh5bzrg79Fuy2kc4j/saw==
X-Received: by 2002:a5d:9490:: with SMTP id v16mr1497006ioj.63.1587496676697;
        Tue, 21 Apr 2020 12:17:56 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c87sm1208311ilg.2.2020.04.21.12.17.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 12:17:55 -0700 (PDT)
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
To:     Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20200421130755.18370-1-longman@redhat.com>
 <20200421105948.4f5a36f5@gandalf.local.home>
 <22ccb042-7d6f-3717-4024-9ec094b2f363@redhat.com>
 <20200421151649.11300568@gandalf.local.home>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3a747a8f-629e-f9d2-088d-963791d99486@kernel.dk>
Date:   Tue, 21 Apr 2020 13:17:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421151649.11300568@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 1:16 PM, Steven Rostedt wrote:
> On Tue, 21 Apr 2020 14:36:29 -0400
> Waiman Long <longman@redhat.com> wrote:
> 
>>> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>>>
>>> -- Steve
>>>  
>> OK, will send a v2 patch to update the commit log. Thanks for the review.
> 
> I think Jens already took this patch.  Doesn't sound like a v2 is needed.

I did, with modified subject line.


-- 
Jens Axboe

