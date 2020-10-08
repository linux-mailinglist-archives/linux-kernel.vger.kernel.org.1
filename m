Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA26E286D30
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgJHDeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgJHDeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:34:44 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CFEC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:34:42 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id p15so5961937ejm.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CaPHumkgFkI3PiRe3v+z7NayTtqpVh+ASQuHBImim/8=;
        b=lK6IDZdrcllW9tWUoCGJANRlWJcBtRWm75PLV1hFbAHsoAOs7kIK5EO3gOrz8gXY1M
         3LdsGYO877gS5Zt0k8xTSumA+XRS9Hmt7wwOksbTAIfFT/WVyosUOubRy6JsmqMAVkWy
         RUbfLMRUu2oup8CtzBfWRtz76bsK0V1tWjLEmKd1UABzkgZz/dbONdeGWwqI3YiMWTnz
         SBkIarIO3SuWsd45pOcfXHh2urZZpARapZJGKQZi/QWRbq0RvQt079AsVgfUR6Ea5P/j
         4dvIxXifH1Upy9/DOCxqqbbWw7v29ICLzreEgisz4LZLMjQv2tJXSRUV7TRm/eE9NCRr
         xogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CaPHumkgFkI3PiRe3v+z7NayTtqpVh+ASQuHBImim/8=;
        b=cDMOwX52CWR4ozF/NfIkxfAVqD7KqC6aVBoEqCtJ9HOI762LJba5Ye1THwqepZ1Asm
         G31g3hbbNIpSzxniGvI32RM5UEJb9mikfc/bngi0/pq8tgos2JtHqBZNkhx8ilKaGB8w
         ydePiAgxVQq7WxTxpIsDs7MXex/sLXXEdFa83YNShQ+9B8EvzER0V4sbWz4A5wxG1X/3
         2ZebmPu0D7+jhZI1yJp+ENW5WE5WNWWFrS5J4tU3IJDnHgB8Bz/KQZ5DVPxK7TfMH/Ax
         b+q0Q1xcumpbQbl3bLW8YslntFCrTpD9rCIfUabhg7cFJif3qEuTpR7PuGhOAn4d4f1V
         /vrQ==
X-Gm-Message-State: AOAM531xFj+mk9PeeLyPiVSUTQ5QTbIqESW5Kq6KBVceNsFracn8ib9D
        mtlWg9tUBjM+lPCHfG2yhszhzNymQIs=
X-Google-Smtp-Source: ABdhPJyD9l7Euyo7aymK1YsGEt+wsIBnYpsK2QHzdY22j4/goCd8ng5CUNz/2j8Nw+PLaEqsiV6t2w==
X-Received: by 2002:a17:906:95d1:: with SMTP id n17mr6797187ejy.75.1602128081557;
        Wed, 07 Oct 2020 20:34:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id jw9sm2983442ejb.33.2020.10.07.20.34.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Oct 2020 20:34:40 -0700 (PDT)
Date:   Thu, 8 Oct 2020 03:34:40 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] ftrace: replace do_for_each_ftrace_rec() with
 for_ftrace_rec_iter()
Message-ID: <20201008033440.zpk2afmgvs5aruq2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
 <20200831031104.23322-6-richard.weiyang@linux.alibaba.com>
 <20201006104217.005cec7c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006104217.005cec7c@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 10:42:17AM -0400, Steven Rostedt wrote:
>On Mon, 31 Aug 2020 11:11:03 +0800
>Wei Yang <richard.weiyang@linux.alibaba.com> wrote:
>
>> Now we have two similar infrastructure to iterate ftrace_page and
>> dyn_ftrace:
>> 
>>   * do_for_each_ftrace_rec()
>>   * for_ftrace_rec_iter()
>> 
>> The 2nd one, for_ftrace_rec_iter(), looks more generic, so preserve it
>> and replace do_for_each_ftrace_rec() with it.
>> 
>
>I also didn't pull in this patch. The reason is that the
>for_ftrace_rec_iter() is specific for external usage (for archs to use) and
>requires two function calls to do the iterations.
>
>The do_for_each_ftrace_rec() is a faster, light weight version, but for
>internal use only.
>
>I rather keep both, as each has their own, but slightly different, use
>cases.
>

Got it, thanks

>-- Steve

-- 
Wei Yang
Help you, Help me
