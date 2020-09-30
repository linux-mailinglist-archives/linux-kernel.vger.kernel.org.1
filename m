Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4B327EE03
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgI3P4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3P4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:56:41 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79993C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:56:41 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id cr8so1131763qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JiVCTNkd5z0wAMKWbNh0KXmrcEj0udA/gKZKa+V4uPI=;
        b=BcM3XgWxfWsGNSnSn58+s3PRrQp4hZLVuCRH8bzL/XPbdPW4+kGhb1jm4Twkwaj3oq
         16cABXPrl+QfaT5hs7ZqTGNa85gJs3lN56Az0C3/1IX76CKD8D6y2tYL4DxycZUdPX8M
         RT9AF5Xnix9k6KXOOUF6qPMxOfZqNUDbI+mfrzqqYGklmjFNT3BkAcGVjxIKHgf3qNEU
         yMUwRqzV5SwitjPL20t16Z07KgqY4z6QYHKxJavp0O23owHzRRJKN/EFnAM+LL0d1XNP
         +mdu+FRXRvFYJeHWVPNIIFA8O0LA/ucjQnyI05ycZFTHdARLoh6S+ecI0Yh1w4obyO52
         2jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JiVCTNkd5z0wAMKWbNh0KXmrcEj0udA/gKZKa+V4uPI=;
        b=ZxjYIYi+eui8Jor50q1NpeQ/VkkfqbV1SYGK4sKQob/fpTRB7ifhz8qjX9+YJGlYT9
         gWVsuaLlrXyJunIoc0qJAxfe5HwUMRDddWMOht66/826MV/JEbYTGIu1RRV46T7qVk3l
         y9cdinJmmR+KJxi1ffzJOHSzHqPmeCJwRJrO60Pk3ItXNCETxQgoTD8UD7/NyVB2gufx
         3trwvfDVHHkEjtSiT/xq6H0DZP1sGeFKrKEFbZsgzrLezKWHtmxir0kfRMcNxRbucblj
         oHtsmuc2bV7wPz3UVr/mt5N3Kz/7s4buRCCiVJCWbOnTYw26IR+5SD+4FxlCmuCQK00r
         bIaQ==
X-Gm-Message-State: AOAM530PVLpFw4/k899hUkg4CJhpU4vnOM5qAeBakjBliqRNyhC9Uamk
        f6gZnrIg+it0CXFiGgUAPbU=
X-Google-Smtp-Source: ABdhPJw4ANufMovxtypxexuQ0beQ6BoTgM9M7QbgjuPIoGuzLV77CDCUHKpow9riDtRKm867jq0eNQ==
X-Received: by 2002:a0c:e152:: with SMTP id c18mr2982345qvl.41.1601481400327;
        Wed, 30 Sep 2020 08:56:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fa])
        by smtp.gmail.com with ESMTPSA id i62sm2618113qkf.36.2020.09.30.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 08:56:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Sep 2020 11:56:38 -0400
From:   Tejun Heo <tj@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     pmladek@suse.com, hdanton@sina.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kthread_worker: Prevent queuing delayed work from
 timer_fn when it is being canceled
Message-ID: <20200930155638.GA4441@mtj.duckdns.org>
References: <20200927055449.21389-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927055449.21389-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 01:54:49PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> There is a small race window when a delayed work is being canceled and
> the work still might be queued from the timer_fn:
> 
> 	CPU0						CPU1
> kthread_cancel_delayed_work_sync()
>    __kthread_cancel_work_sync()
>      __kthread_cancel_work()
>         work->canceling++;
> 					      kthread_delayed_work_timer_fn()
> 						   kthread_insert_work();
> 
> BUG: kthread_insert_work() should not get called when work->canceling
> is set.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Acked-by: Tejun Heo <tj@kernel.org>

This prolly should go throgh -mm. Can you please also add a stable: tag?

Thanks.

-- 
tejun
