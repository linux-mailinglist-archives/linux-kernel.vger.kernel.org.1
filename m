Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516AF206832
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 01:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbgFWXUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 19:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387495AbgFWXUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:20:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBADC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:20:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so139298pfi.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7tx/9GfFI7meR7LlrVVqfR+HUCYTsfN81Kg3AevbFnU=;
        b=Ymp3VmY/jWQoNF1OijqrwQWLfqZZJQEhU9+l6gNLrtWBGVoAMI7RQcQRFuauEjc99x
         aE/ExujAIxh+aXho7etdyLRSbGqmtb9LKfqArgPdy5VNfWk66rfi0j6sDEzCu7AXgBwF
         0BfAKQfyhyoQ/uH9W4TLvi7RU/V8V4eZwdaQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7tx/9GfFI7meR7LlrVVqfR+HUCYTsfN81Kg3AevbFnU=;
        b=bqSO3ZNFHn7cx9WAGQiXzOP5poFVc1lFfCjv4uRa2QjPxPBeV+XDCAedw8WPIXVR3R
         068JzKI3GHKD6UnXGzk1h6Hpt7aYcbuiBS9TxkJWaxSIkAQKuHWBTCksC+5f2Tco0n44
         RFSjJn3BGbPO/63IdhjcjBrUzVUC4p3Wl7ASHFsy9KqPNnfu0M3F1lb2M+h+ZievenF8
         QoyWyHlQHGe2f6R9v+kBVSDgMUzBSIbxpOsz6+qqhsFPiYGlx6LsVIeqL7+6FOz1fj2N
         +/LAeobv8nQyWmWGgazWVxQF3XC50y7e3GnZ1lWrVQNDzJ/FnHuMgrTkDqte8xCQRPto
         P1Vg==
X-Gm-Message-State: AOAM531l/ZWhBEoh6AXX/EakZI9yRve+LWl+QnW1b1Vu1kYS9npO5w5y
        EaoYmFq7GMP1rZ1W4KYOrrngMp/t+FA=
X-Google-Smtp-Source: ABdhPJwPp+16UaiUVkCfWRk1ekgUARx1LFpsqLdVptkXkbAzNFecuQARo/2yMu73ITI6t5pNE6Reyw==
X-Received: by 2002:a63:525a:: with SMTP id s26mr16757277pgl.155.1592954403813;
        Tue, 23 Jun 2020 16:20:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g18sm9617pfk.40.2020.06.23.16.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 16:20:03 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:20:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <202006231619.38108DE0@keescook>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200623211218.GA40110@localhost.localdomain>
 <20200623212214.GA41702@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623212214.GA41702@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:22:14AM +0300, Alexey Dobriyan wrote:
> On Wed, Jun 24, 2020 at 12:12:18AM +0300, Alexey Dobriyan wrote:
> > On Tue, Jun 23, 2020 at 10:39:26AM -0700, Christian Kujau wrote:
> > > Hi,
> > > 
> > > exactly this[0] happened today, on a 5.6.5 kernel:
> > > 
> > >   process '/usr/bin/rsync' started with executable stack
> > > 
> > > But I can't reproduce this message,
> 
> This message is once-per-reboot.
> 
> If you run something with exec stack after the message
> you shouldn't get it second time.

If you want to reset this flag, you can do:

 # echo 1 > /sys/kernel/debug/clear_warn_once

-- 
Kees Cook
