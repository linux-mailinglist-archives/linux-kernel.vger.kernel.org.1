Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEB01C5AF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgEEPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 11:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729365AbgEEPXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:23:41 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC04C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:23:40 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w11so1774558iov.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TPwxKE0klTjrvpCqkN/+GZfurYoGuk/drCYIDVYxA1Q=;
        b=W1y7ye3xLvDWbdVRSKUUL0S+8HrvaPz16PwNA1IjuoxOj8GVxyKW6B6/eMTtHRlIiw
         ocp5PbDJkd5E3DLCWaXeitPpzuGHudOfwlWg5LSj3q6nff83JSBz6DvAeONP/hmEapQN
         2PMBRjrlNEg2eUMQbLK8DAdexla7k7MjnyfemM6nfThLo7eD7rFlFkWVMDUygtBKHDAT
         EPuG8ZLDOPKyb2jXLzt4Midt4KUy4VERIq5gbofnW+NSfKhJpCNaV2ggpvueRJd3SYgV
         vJ5Ed3Tpb+IfkIPJNBfbUrpSCFTJ1tXMu2dTSd1JsQcgNW0A9aaSgJdy9OWOhe932euT
         CXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TPwxKE0klTjrvpCqkN/+GZfurYoGuk/drCYIDVYxA1Q=;
        b=iNwW+iXqI98eqFQIQgseIk/MxChHrM3To460KB2nY9/YMR/PuiL8HtbCzBOaEaG0CJ
         K7PvDLdabxIlQUPWJ6vYgm0v+pjPvybMwuPyDITTn5vdxyrlQWd0I/mhldNbzgdM0UKP
         3EzWryEfgrk0vvn2o/clo449pK+/mNzheAc6vG55Td3S0+kWc6+3q/QeHmaAVKkbwOvt
         YNaNn76sg2jixNOswgARs0T/UhVmj6V9ccfW+NkYzG/O09s5S8T1kOCfd/eSBDkNqZjJ
         uFIm/ktbPXKT4MGFj482qcd/1hpUd6glHGGmR1Ef9E4RKQwM5MGF/2KkX2v5RaQBtMAe
         B9iQ==
X-Gm-Message-State: AGi0PuZWAuI3prHf5boRT8WKAbDP7sRx+uqjWsATZzX4aMQg2sOzU2FB
        E0BUY/H3qQ60++SBqNGtLBqlZA==
X-Google-Smtp-Source: APiQypJAq2tEbNFshdQhYM92AuCn6z2zFmJm/tKNnvOKeooJrHtg/Dbe1zAetTS+9IMeiH2nlyuzxg==
X-Received: by 2002:a5e:a607:: with SMTP id q7mr3877260ioi.109.1588692218512;
        Tue, 05 May 2020 08:23:38 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y70sm1893526ilk.47.2020.05.05.08.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 08:23:37 -0700 (PDT)
Subject: Re: [block/for-5.7] iocost: protect iocg->abs_vdebt with
 iocg->waitq.lock
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Vlad Dmitriev <vvd@fb.com>
References: <20200504232754.GB3209250@mtj.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4377265-1605-077b-9415-183c8efe3da5@kernel.dk>
Date:   Tue, 5 May 2020 09:23:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504232754.GB3209250@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/20 5:27 PM, Tejun Heo wrote:
> Subject: iocost: protect iocg->abs_vdebt with iocg->waitq.lock
> 
> abs_vdebt is an atomic_64 which tracks how much over budget a given cgroup
> is and controls the activation of use_delay mechanism. Once a cgroup goes
> over budget from forced IOs, it has to pay it back with its future budget.
> The progress guarantee on debt paying comes from the iocg being active -
> active iocgs are processed by the periodic timer, which ensures that as time
> passes the debts dissipate and the iocg returns to normal operation.
> 
> However, both iocg activation and vdebt handling are asynchronous and a
> sequence like the following may happen.
> 
> 1. The iocg is in the process of being deactivated by the periodic timer.
> 
> 2. A bio enters ioc_rqos_throttle(), calls iocg_activate() which returns
>    without anything because it still sees that the iocg is already active.
> 
> 3. The iocg is deactivated.
> 
> 4. The bio from #2 is over budget but needs to be forced. It increases
>    abs_vdebt and goes over the threshold and enables use_delay.
> 
> 5. IO control is enabled for the iocg's subtree and now IOs are attributed
>    to the descendant cgroups and the iocg itself no longer issues IOs.
> 
> This leaves the iocg with stuck abs_vdebt - it has debt but inactive and no
> further IOs which can activate it. This can end up unduly punishing all the
> descendants cgroups.
> 
> The usual throttling path has the same issue - the iocg must be active while
> throttled to ensure that future event will wake it up - and solves the
> problem by synchronizing the throttling path with a spinlock. abs_vdebt
> handling is another form of overage handling and shares a lot of
> characteristics including the fact that it isn't in the hottest path.
> 
> This patch fixes the above and other possible races by strictly
> synchronizing abs_vdebt and use_delay handling with iocg->waitq.lock.

Applied, thanks.

-- 
Jens Axboe

