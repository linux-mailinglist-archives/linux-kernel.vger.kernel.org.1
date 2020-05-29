Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA71E86EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 20:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgE2SqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 14:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2SqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:46:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23613C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:46:10 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k18so469469ion.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jI4J75zslK5DzN/oAOiAs5aQaZjIw5/hl671zWXDfg=;
        b=0u7utFCWf8UoVkl1fFW02UGLdTLXA8lHRobaDaZxyF+D2+C5Cv4PsCB2sHXUbsd2MH
         YAObRaio3SXyniTOvpq8NMquqBSrMPenGNm6Ga8aWbCwCke3LFTzR4eH9UHuUSZxklpW
         RJ/I1jpatT5qu8Zh/CfUFi6DSitvG6nFCjrrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jI4J75zslK5DzN/oAOiAs5aQaZjIw5/hl671zWXDfg=;
        b=Oes/DzTf+l0vJjIRn7gyu5ipVYCIbXkAGKjdLFscFZZuRN5TLvRy0M1z4K84lXiCLT
         TP0rHNKjxsZqRYentMr3woLqkV1x4LJD7ZTPutX31z3g6iiG8sunFmOWR69vOviNAjGB
         nT8pOcfzwycwseaOG+24fEtvESwk4vFV9kn4zhDNVYpdB9wHr/nqW3zK40qsP0/JKbZ/
         DpskhgHxWkBT5n4bm6qGalNFBBUGG60g4uxnFcNywp+GJEOt4LtisLSzKcY8tVBQyNaZ
         A4KGHdFrY/ILEUnXLrlh9lbyB1npIfjP2EPBYeQB5AKS+3AuWPxeW0qLMTUbvc7CliOQ
         ZSRA==
X-Gm-Message-State: AOAM532enX++4Hbs4YDX/gBY8OBUePZLMGWKMqWHL4ZdH9q5Dfen9TXg
        2qYiXRaleSRLdf5tQONWCVYzGw==
X-Google-Smtp-Source: ABdhPJxqSabZiziCqEytCBApzYTquglzQUMj87GMuYJBRLrh6SI6PK2b2cWHNKInwu7yMF1VfRW7Jw==
X-Received: by 2002:a02:a895:: with SMTP id l21mr8241043jam.82.1590777969201;
        Fri, 29 May 2020 11:46:09 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id h23sm4134751ioj.39.2020.05.29.11.46.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:46:08 -0700 (PDT)
Date:   Fri, 29 May 2020 18:46:07 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 3/3] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Message-ID: <20200529184606.GB11153@ircssh-2.c.rugged-nimbus-611.internal>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-4-sargun@sargun.me>
 <202005290036.3FEFFDA@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005290036.3FEFFDA@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:41:51AM -0700, Kees Cook wrote:
> On Thu, May 28, 2020 at 04:08:58AM -0700, Sargun Dhillon wrote:
> > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> > +
> > +	nextid = req.id + 1;
> > +
> > +	/* Wait for getppid to be called for the second time */
> > +	sleep(1);
> 
> I always rebel at finding "sleep" in tests. ;) Is this needed? IIUC,
> userspace will immediately see EINPROGRESS after the NOTIF_SEND
> finishes, yes?
> 
> Otherwise, yes, this looks good.
> 
> -- 
> Kees Cook
I'm open to better suggestions, but there's a race where if getppid
is not called before the second SECCOMP_IOCTL_NOTIF_ADDFD is called,
you will just get an ENOENT, since the notification ID is not found.

The other approach is to "poll" the child, and wait for it to enter
the second syscall. Calling receive beforehand doesn't work because
it moves the state of the notification in the kernel to received,
and then the kernel doesn't error with EINPROGRESS.
