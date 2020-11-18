Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8FD2B7AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgKRKL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:11:28 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46877 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgKRKL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:11:28 -0500
Received: by mail-lf1-f65.google.com with SMTP id v144so2089804lfa.13;
        Wed, 18 Nov 2020 02:11:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGpdVE+rKOq+8Wn4JdXKLQPl0kAf32HiTfPsjME0osY=;
        b=LcEOMKJz+idxQGoW67B7pqm+OYF0a9J2R/P2I/0fwMwHHAbdaE7nDFC+NPLl7IyRHn
         RPTasSm90zBE1eTLG9oV9AJohINYvBqj9j6TLGc9opRCDPA5G98G0cvQbrH1sbciVbtJ
         6bmXXRZITO6vNTQvMZ3nMBrpx+fsEfmf6UaTnU8d/58E+MRO/Y6phwUZJY6gj447ijOx
         5BCA0QfHXJ6JgkeplDROEgVUI8qPaD012NtHYjLch18maWrcw51HX1zDqiAH47bgaDkv
         dbhtqqfqtEyxuDP3qzbFpT3LSEQ7PqPm0PPL5sQgIYpDT8L4+LfrVxwB3i3L/Wv2hOZy
         PAww==
X-Gm-Message-State: AOAM533XF0plP+hfeqAyvJA4t8Kg28TPr+nuHGeVkN0uNunPhbGVKB/I
        P6AMsKq8/pCMXX1PEMPCxKs=
X-Google-Smtp-Source: ABdhPJyGq9e3C1lA0FeXHKjI/MZrE75UAkQlNddOM6nQ/7YDa9mVMtv1YKU71cguqLlKneB5ZWxFYg==
X-Received: by 2002:a19:b95:: with SMTP id 143mr3297249lfl.51.1605694285885;
        Wed, 18 Nov 2020 02:11:25 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id i141sm3343558lfi.195.2020.11.18.02.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 02:11:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kfKR0-00025E-7Y; Wed, 18 Nov 2020 11:11:30 +0100
Date:   Wed, 18 Nov 2020 11:11:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH v2] USB: serial: mos7720: defer state restore to a
 workqueue
Message-ID: <X7TzUr+nl+P4SL6c@localhost>
References: <20201104162534.GY4085@localhost>
 <20201105001307.lelve65nif344cfs@linux-p48b.lan>
 <20201105082540.GA4085@localhost>
 <20201106061713.lgghl4xnvdmkvges@linux-p48b.lan>
 <20201113091443.GI4085@localhost>
 <20201114042725.ofs7zbzmxg32tbbi@linux-p48b.lan>
 <X7KyPrY8FDH4C/gm@localhost>
 <20201116223102.eliwt7uh5rkiiq5h@linux-p48b.lan>
 <X7P6P018BQSypuP6@localhost>
 <20201117164837.vzhcumyoww3tf5ix@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117164837.vzhcumyoww3tf5ix@linux-p48b.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 08:48:37AM -0800, Davidlohr Bueso wrote:
> The parallel port restore operation currently defers writes
> to a tasklet, if it sees a locked disconnect mutex. The
> driver goes to a lot of trouble to ensure writes happen
> in a non-blocking context, but things can be greatly
> simplified if it's done in regular process context and
> this is not a system performance critical path. As such,
> instead of doing the state restore writes in irq context,
> use a workqueue and just do regular synchronous writes.
> 
> In addition to the cleanup, this also imposes less on the
> overall system as tasklets have been deprecated because
> of it's BH implications, potentially blocking a higher
> priority task from running. We also get rid of hacks
> such as trylocking a mutex in irq, something which does

So this was never done in irq either. Perhaps you can remove that bit
too.

> not play nice with priority boosting in PREEMPT_RT.
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> Changes from v1: remove bogus irq comment.

You seem to have some problem with your mail setup. The patch fails to
apply, and both checkpatch and git warn about the patch being corrupt:

	warning: Patch sent with format=flowed; space at the end of lines might be lost.
	Applying: USB: serial: mos7720: defer state restore to a workqueue
	error: corrupt patch at line 12
	Patch failed at 0001 USB: serial: mos7720: defer state restore to a workqueue

Can you look into that and verify that you can send the patch to
yourself and apply it first?

Johan
