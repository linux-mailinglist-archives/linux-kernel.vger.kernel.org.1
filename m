Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51B2E0374
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgLVAgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVAgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:36:22 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93600C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:35:42 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 11so10463349oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=utAs4BsBafFg5CO7BzyorgN8nRiJc1gfhKJ1KiWwQzc=;
        b=m+zxZb7Hsx8Kp3C0DV8CJa2cLKDsEAqCzCOrdENq/AjyPVK2RjfTAA9t4ikUb4knC1
         2i5BzIpEczdOlN6zcToKm8m9EI93jn3DBTeFJOw6PVI1/aN0MlMHsEMStRt9qDdwAeZ2
         yNmRpfssLfrzyvYw2j6b4FcE+0zr+I1OQsTZ7PesV/5AbFuu0s0jCbuKWKNy3lj0SeVX
         kfmAcRgmace6vjcMbyuth4kM/sXv1a289gJhamS3qWAd74LO0sr2UcMOpuJ+i7kfwp4j
         s74MdbKmSducRBZ9zMv85xoODnxIntZWBThijpy3Z1J9zi7k9V08CsBtdkz7VdHKRq2v
         64qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=utAs4BsBafFg5CO7BzyorgN8nRiJc1gfhKJ1KiWwQzc=;
        b=sbaGUv1hw/iTSKTY0LPh62DDC/vDw/p3xeFmvQIAV6iT9ECbSHivbkVhu6nSdUapOD
         ezFOR4eOh2CR1vF1R8zdk9tLECbk5SWKIORQigLxeLgr06xDx+bmQSafgsrTlljdTKWP
         vkPB5yaJu0TvITEdiEUOU+NrEgk/seq66STmegSf1qb9pHfIEYMkJer2BJ0ii/5o1VJo
         RSkOWxIJKZINEVrL663K15UdJzMbPagdJd+oF6+k8HA/+dgdSQ/CmlQDxgWCA3RV/u/b
         peeBYZjNOr6HlqkZ2w2wISB+1PGSwSmjYRe6e03U/B6aeJB6+dd1fx/0VlO7BX0SGRa8
         Q5XQ==
X-Gm-Message-State: AOAM533uTEBrJ/iou8KvEtZ1FgYrBpoj6CIRtwPsed/oIK91S+XbIER5
        cv+KP70sIYWrTkxA0HyOriYeHw==
X-Google-Smtp-Source: ABdhPJyt/TRdVAYoCTwgIUEk7pgrWzJ7kAhCFbdJjEttgDSv2xfvZQA9F5ao1jqhdtkfkpCp+o6WHg==
X-Received: by 2002:a9d:73d1:: with SMTP id m17mr13734625otk.187.1608597341826;
        Mon, 21 Dec 2020 16:35:41 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p4sm3959687oib.24.2020.12.21.16.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:35:41 -0800 (PST)
Date:   Mon, 21 Dec 2020 18:35:39 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     rishabhb@codeaurora.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH] remoteproc: Create a separate workqueue for recovery
 tasks
Message-ID: <X+E/W2Sf6fkNaiTC@builder.lan>
References: <1607806087-27244-1-git-send-email-rishabhb@codeaurora.org>
 <X9k+xmg9SULEbJXe@builder.lan>
 <dc9940f0-7fe3-d1da-acb5-580ae7366c9b@linaro.org>
 <87c3f902b94bc243fc28e0ce79303dd4@codeaurora.org>
 <35e2106f-d738-4018-50f2-17afcbc627f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e2106f-d738-4018-50f2-17afcbc627f7@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Dec 12:49 CST 2020, Alex Elder wrote:

> On 12/17/20 12:21 PM, rishabhb@codeaurora.org wrote:
> > On 2020-12-17 08:12, Alex Elder wrote:
> > > On 12/15/20 4:55 PM, Bjorn Andersson wrote:
> > > > On Sat 12 Dec 14:48 CST 2020, Rishabh Bhatnagar wrote:
> > > > 
> > > > > Create an unbound high priority workqueue for recovery tasks.
> > > 
> > > I have been looking at a different issue that is caused by
> > > crash notification.
> > > 
> > > What happened was that the modem crashed while the AP was
> > > in system suspend (or possibly even resuming) state.  And
> > > there is no guarantee that the system will have called a
> > > driver's ->resume callback when the crash notification is
> > > delivered.
> > > 
> > > In my case (in the IPA driver), handling a modem crash
> > > cannot be done while the driver is suspended; i.e. the
> > > activities in its ->resume callback must be completed
> > > before we can recover from the crash.
> > > 
> > > For this reason I might like to change the way the
> > > crash notification is handled, but what I'd rather see
> > > is to have the work queue not run until user space
> > > is unfrozen, which would guarantee that all drivers
> > > that have registered for a crash notification will
> > > be resumed when the notification arrives.
> > > 
> > > I'm not sure how that interacts with what you are
> > > looking for here.  I think the workqueue could still
> > > be unbound, but its work would be delayed longer before
> > > any notification (and recovery) started.
> > > 
> > >                     -Alex
> > > 
> > > 
> > In that case, maybe adding a "WQ_FREEZABLE" flag might help?
> 
> Yes, exactly.  But how does that affect whatever you were
> trying to do with your patch?
> 

I don't see any impact on Rishabh's change in particular, syntactically
it would just be a matter of adding another flag and the impact would be
separate from his patch.

In other words, creating a separate work queue to get the long running
work off the system_wq and making sure that these doesn't run during
suspend & resume seems very reasonable to me.

The one piece that I'm still contemplating is the HIPRIO, I would like
to better understand the actual impact - or perhaps is this a result of
everyone downstream moving all their work to HIPRIO work queues,
starving the recovery?

Regards,
Bjorn
