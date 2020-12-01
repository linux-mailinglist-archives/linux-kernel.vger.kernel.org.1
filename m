Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDC72CA377
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbgLANJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:09:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388599AbgLANJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:09:13 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:08:28 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id y5so1500742iow.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZGcFuRI/bJF+HhBMzLDe2qGtoT/j0joOqdDzilS2qpo=;
        b=gTV19U7L/PRLjHjLVMBT9mj1qEMnpXhJ4DrO/+phoB5vlcweQ4DDm5pyPwcF/OJKeD
         p1IFSmdvJmxj7FFSzHjtbqBJTkDHtdP2dna0fFX6/moLUXI0ng4cU7iAIkXFEav/LiQL
         g791l9yDscEX979Y+yY4E+S1SLs3YXrE861Bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZGcFuRI/bJF+HhBMzLDe2qGtoT/j0joOqdDzilS2qpo=;
        b=Qm4YoakHWywUCm41Grik3XPMfCbFVaKOB61oFMNDUl2x5FWpnanQkg3OeuVY3uQ1ot
         berwtIbTHWkPfDiDfFozHxajYWXA6cKfGNmWVfp7v47x5xhbduQrT4eFd+3q124XonCu
         kEBu5uDN1+aX01zhg3zbLq9QOmFI3l0rgkevGgliGPUV85AEpTyaiut8MqBnzXN64rVc
         3U0Y7YnmpMdlb+gvYR3FThS9tovQSOGu20K64onVjSaEugwpNDIhUAuG2PRQKo4igUlz
         lqrATXI0WnV2U5ShFvCPRGyxCf5RND8qcAK74w6fYJ6l3QvrlE6k2829JH9mq4tjdDEL
         hVgQ==
X-Gm-Message-State: AOAM533hsW+OKzvir/ZISGflBweRjvF4NutFvi5OmGnnASSkQ3f9k2UR
        vL5q17/mAzlWUP4iHswCo+GeWg==
X-Google-Smtp-Source: ABdhPJxwlwKDoOdC8evZD54rtRTBt2PosvC3O4D1AZaVXoFjuWZXLX6+JWQ51f7bO1ilExJucdfw1A==
X-Received: by 2002:a02:3e86:: with SMTP id s128mr2383118jas.131.1606828107257;
        Tue, 01 Dec 2020 05:08:27 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id u18sm765171iob.53.2020.12.01.05.08.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 05:08:26 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:08:25 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Alban Crequy <alban@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: SECCOMP_IOCTL_NOTIF_ADDFD race condition
Message-ID: <20201201130824.GA27822@ircssh-2.c.rugged-nimbus-611.internal>
References: <CADZs7q4sw71iNHmV8EOOXhUKJMORPzF7thraxZYddTZsxta-KQ@mail.gmail.com>
 <20201130232009.GC38675@cisco>
 <20201201124105.GB103125@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201124105.GB103125@cisco>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 07:41:05AM -0500, Tycho Andersen wrote:
> On Mon, Nov 30, 2020 at 06:20:09PM -0500, Tycho Andersen wrote:
> > Idea 1 sounds best to me, but maybe that's because it's the way I
> > originally did the fd support that never landed :)
> > 
> > But here's an Idea 4: we add a way to remotely close an fd (I don't
> > see that the current infra can do this, but perhaps I didn't look hard
> > enough), and then when you get ENOENT you have to close the fd. Of
> > course, this can't be via seccomp, so maybe it's even more racy.
> 
> Or better yet: what if the kernel closed everything it had added via
> ADDFD if it didn't get a valid response from the supervisor? Then
> everyone gets this bug fixed for free.
> 
> Tycho
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers

This doesn't solve the problem universally because of the (Go) preemption 
problem. Unless we can guarantee that the supervisor can always handle the 
request in fewer than 10ms, or if it implements resumption behaviour. I know 
that resumption behaviour is a requirement no matter what, but the easier we can 
make it to implement resumption, the better chance we are giving users to get 
this right.

I think that the easiest solution is to add to the SECCOMP_IOCTL_NOTIF_RECV
ioctl. Either we have a flag like "block all blockable signals" or pass a
sigset_t directly of which signals to allow (and return an einval if they
try to block non-blockable signals).


