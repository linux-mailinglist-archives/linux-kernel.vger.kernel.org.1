Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B061828DD9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgJNJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbgJNJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:36 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD9C08EADC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:37:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f19so811252pfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vNrLxhuzbKySTdaq3eK6IYs4qYFra1Niz95iXgK6Jj4=;
        b=cjD4hai8nvmN++DcR3kvZkEq/tP8L40YpzvCPlc1ePqdY1yVT4JeA3OyuLC4W3e1K6
         6g+xwrF/3qc5tVO4LZ1OR/ICoupDOTDlTFkLsGQvmzNxkDIDGhFTkBUkcJaWzr3GRxMk
         lGIalkMtRUo+mFS6WFpI420AIzjcLspBbrklvjlYwnFmtxgj58/WvxgbpXvEFYcxRGfY
         sLxv+V3HQFLs4wTtJ/tursNEIZDI9JR+TlZstbItQSZ+IcKyAAixFOMDyrqVWd+re+wg
         5FRLz2g5W+UUPxzw/1FNbGPqzsvuQbQP4wQdVIC1muE+0mzfQdDauwIowzItn3ATHWPk
         1KYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vNrLxhuzbKySTdaq3eK6IYs4qYFra1Niz95iXgK6Jj4=;
        b=JoLYqYJhvOl2yBWJ+GlXNraaQkbxZ+yx9tPKVLG7hFwARodeXWfPyzlPHhp+nzOw8j
         epovQiRQLxV1bFdmB3OZpTlz33E3ePlkV8heqvFoHULImWaGCPGTxxUylYp6V4Bdj8A4
         JHGHyMtSadGuvLOQymPOmtNKJ1mN+z8Y0hSPdgue7dIPYxCHlmOYalEoM5hav4nPAUsR
         V3yOsD553yyu+wLnuUs2Q1WpI883JrqdU4jANrYNUbxD7bm5yKDnZhtHD6poMm95RHOv
         1wNl8watsah114IZLxNcep2BJEvTdNOxsvpVZHdBTCoFvJRWZ1IWDiHAmV9WnhfDSrQr
         rrXQ==
X-Gm-Message-State: AOAM532ABANz6DBWaq87bNNvjOFXZxAw8VsLKP+UgVaNQCuoKKIftCS6
        vyOvMUPPM0H12slQcc+OUh2HOQ==
X-Google-Smtp-Source: ABdhPJylS9WM3J27JvugooESy3X8ZP2DkugADfW8R9kmS5rfhg9PZZ7pOQiiHHcwmhl2bDhMJ1JARQ==
X-Received: by 2002:a65:4bcc:: with SMTP id p12mr1491715pgr.353.1602632271367;
        Tue, 13 Oct 2020 16:37:51 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id u27sm810116pgm.60.2020.10.13.16.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 16:37:50 -0700 (PDT)
Subject: Re: [PATCHSET RFC v3 0/6] Add support for TIF_NOTIFY_SIGNAL
To:     Thomas Gleixner <tglx@linutronix.de>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org, peterz@infradead.org,
        live-patching@vger.kernel.org
References: <20201005150438.6628-1-axboe@kernel.dk>
 <20201008145610.GK9995@redhat.com>
 <alpine.LSU.2.21.2010090959260.23400@pobox.suse.cz>
 <e33ec671-3143-d720-176b-a8815996fd1c@kernel.dk>
 <9a01ab10-3140-3fa6-0fcf-07d3179973f2@kernel.dk>
 <alpine.LSU.2.21.2010121921420.10435@pobox.suse.cz>
 <3c3616f2-8801-1d42-6d7d-3dfbf977edb2@kernel.dk>
 <87lfg9og3b.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f5009735-c4e4-816a-d02f-29f7da7ab287@kernel.dk>
Date:   Tue, 13 Oct 2020 17:37:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87lfg9og3b.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 5:34 PM, Thomas Gleixner wrote:
> Jens,
> 
> On Tue, Oct 13 2020 at 13:39, Jens Axboe wrote:
>> On 10/12/20 11:27 AM, Miroslav Benes wrote:
>> I'm continuing to hone the series, what's really missing so far is arch
>> review. Most conversions are straight forward, some I need folks to
>> definitely take a look at (arm, s390). powerpc is also a bit hair right
>> now, but I'm told that 5.10 will kill a TIF flag there, so that'll make
>> it trivial once I rebase on that.
> 
> can you pretty please not add that to anything which is not going
> through kernel/entry/ ?

Certainly, tif-task_work is just a holding ground for all of it so
far. Once the core bits are agreed upon and merged, then I'll bounce
the rest through the arch maintainers. So please don't view it as
on cohesive series, it only is up until (and including):

commit 8dc14b576a9bf13dba4993e4ddb4068d39dee1e9
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 1 13:29:21 2020 -0600

    task_work: use TIF_NOTIFY_SIGNAL if available


> The amount of duplicated and differently buggy, inconsistent and
> incomplete code in syscall and exception handling is just annoying.
> 
> It's perfectly fine if we keep that #ifdeffery around for a while and
> encourage arch folks to move over to the generic infrastructure instead
> of proliferating the status quo by adding this to their existing pile.

Agree

> The #ifdef guarding this in set_notify_signal() and other core code
> places wants to be:
> 
>     #if defined(CONFIG_GENERIC_ENTRY) && defined(TIF_NOTIFY_SIGNAL)

OK no problem, I'll fix that up.

-- 
Jens Axboe

