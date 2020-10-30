Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E112A0DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbgJ3Sqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgJ3Sqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:46:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36343C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:46:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id h21so8535768iob.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rKR3nSyjdOhRFeCLOasGmXfLUPItd6VT/MZ6kYlzlTI=;
        b=ws87XD6GkkTF54VE/BqitpkVccv5nuUdtr1a4OWKvH3izPR1Dlnm8Vdllij2bllowW
         s0ntfmIP4ghwFzRWMAo18OFqKKxqjd15SpmEJXH9txb6m27Kb2eF8D5sWMlWUEzpwKgx
         oZzOQnASHz/BVD+6xNxDsBPssUrsnkrC90T0MDAXk1SNYBmMtmF1V7qgkeGC1d/1s+h1
         Iytr+wISlR254q72Q8F5ur+VPUq9T9CnmviNcY++AnKjXEpSV3vkcgFN+7KmbToRsc7W
         kjqvP+IcJoIuVDImTMuUUNxX0t2ZNlwbruQEEE/mk+R2Vt9u9tibJD9i3klGsFesGJjo
         JrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rKR3nSyjdOhRFeCLOasGmXfLUPItd6VT/MZ6kYlzlTI=;
        b=f3VA+p5a+uV6TAP+NA9cN93YqPPQKyQDgeD6tq3YxdJYdPT6ZvBd6w5bWGR8YSIXs1
         jcmJ4Al9BPAEX/P3MHWaIWz5XYpzQ5nmNbdwYqhNB6PS7+LEgHL/avSSiIwDigOiw+ts
         w+9nSzIvv1M1UImZ/FWyaA7b1W9d9mSH6Bn1bxow0NbLpIFCnTVTZY5hXsg5xC+wBe68
         SeIMDBxS3/mXMWgN/hZqdyMlDXuUnWN8VD4tjcF94t1ghU1uQNHaMRrCmCbWtqp4v5Go
         BKnAekTEf8bj9fOO9zgUuo5hMNhnYmXbVDBQItfTvkC5U7L7WNuPPaMcs1jrLn9kewqf
         MFMg==
X-Gm-Message-State: AOAM533qUrZDila+iVyPm27HQr9fvdpwNB75KtJquDat4fqVMlzT7l6y
        3RVtZFvCS7vcr9IkgxIDRtomMgMH4rWZww==
X-Google-Smtp-Source: ABdhPJzPFbRkZgb5bbf+bDEq874LE5nnjojpANWw5M3akdwtJptMRqmVA6N5+ffeaQFVo6f0M85H9A==
X-Received: by 2002:a02:ba13:: with SMTP id z19mr3094188jan.122.1604083588943;
        Fri, 30 Oct 2020 11:46:28 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c1sm5687324ile.0.2020.10.30.11.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 11:46:28 -0700 (PDT)
Subject: Re: [PATCH -next] fs: Fix memory leaks in do_renameat2() error paths
To:     Al Viro <viro@zeniv.linux.org.uk>, Qian Cai <cai@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201030152407.43598-1-cai@redhat.com>
 <20201030184255.GP3576660@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad9357e9-8364-a316-392d-7504af614cac@kernel.dk>
Date:   Fri, 30 Oct 2020 12:46:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201030184255.GP3576660@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 12:42 PM, Al Viro wrote:
> On Fri, Oct 30, 2020 at 11:24:07AM -0400, Qian Cai wrote:
>> We will need to call putname() before do_renameat2() returning -EINVAL
>> to avoid memory leaks.
>>
>> Fixes: 3c5499fa56f5 ("fs: make do_renameat2() take struct filename")
>> Signed-off-by: Qian Cai <cai@redhat.com>
> 
> May I ask where has the original commit been posted for review?  And why
> the bleeding hell does io_uring touch rename-related codepaths in the
> first place?

See other reply, it's being posted soon, just haven't gotten there yet
and it wasn't ready.

It's a prep patch so we can call do_renameat2 and pass in a filename
instead. The intent is not to have any functional changes in that prep
patch. But once we can pass in filenames instead of user pointers, it's
usable from io_uring.

I'll post this as soon as I get around to it, it's been on the back
burner for the last month or so.

-- 
Jens Axboe

