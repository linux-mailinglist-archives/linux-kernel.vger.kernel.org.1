Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACE3276020
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 20:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgIWSl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgIWSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 14:41:26 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82C5C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:41:26 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o20so184558pfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rW754kdSeC+5SARwT/M0llY0UwvaZxS5/EZ5bZwwy64=;
        b=EP/MpImeaOKiy1KnXWYeq4+1sbW01XF8UmUImt5vmYNmZ+n/W8lwax9U/xj4hGOEWV
         VHkZP1Knhb0448r/9raS5tTfDm3qLDR8/6awDAzmgK5v38mk5VuUgWPorNSk/Mf+lGLF
         3mtbZM3Yac5M3ZgaxHsn5FcV67MamJIbMqwhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rW754kdSeC+5SARwT/M0llY0UwvaZxS5/EZ5bZwwy64=;
        b=fjCMmgMHYZ/AKweLEztuLckIgDJ7j3T5bTKwXbvvJ4XW3OrG71gM1eclqif5+WePxs
         6Ouda6acW9yOg2O4TYPVBAm8leebYGuBkLI+LyfrREkMkM77XWZ0G2LjaYssL81tBY0j
         hCChUVrBK4H9ZR1I2dNN9kp8skmcQFIRaxwt1c9KLIFmxgr4j13Nk/chXNhVah7ejWX6
         YIMHWHzv3msEwgPXSzeXj8NI9KaT0zbu0NIYMu5DK2iHSa04DreZEBrWKZQ2s4vs/SsH
         srOWZa+zy7n3PYIDUYUHTcCYPHSwohBqq3VmUcP0nAEBzW29pDF/A6I26iueVLc1gQQc
         Rrjg==
X-Gm-Message-State: AOAM53064n8CseMlOETzg6muKu02RSiEHDeCtxkPoi/7hhv5JxOCpBrY
        7Riedq0hXcZgD/uvOPytMl6szJSEfNszLG7I
X-Google-Smtp-Source: ABdhPJzEChCCcNROo2Z5jNvV4nZ5Td5wLsnZiQaCwuvQqrviw6H9EuQlaEK3o1TA8c+3PYzDPXAzgQ==
X-Received: by 2002:a63:40e:: with SMTP id 14mr934575pge.85.1600886486183;
        Wed, 23 Sep 2020 11:41:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gx5sm218629pjb.57.2020.09.23.11.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 11:41:25 -0700 (PDT)
Date:   Wed, 23 Sep 2020 11:41:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Peter Jones <pjones@redhat.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/7] efi: pstore: disentangle from deprecated efivars
 module
Message-ID: <202009231140.B4648C6@keescook>
References: <20200923161404.17811-1-ardb@kernel.org>
 <20200923161404.17811-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923161404.17811-2-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 06:13:58PM +0200, Ard Biesheuvel wrote:
> The EFI pstore implementation relies on the 'efivars' abstraction,
> which encapsulates the EFI variable store in a way that can be
> overridden by other backing stores, like the Google SMI one.
> 
> On top of that, the EFI pstore implementation also relies on the
> efivars.ko module, which is a separate layer built on top of the
> 'efivars' abstraction that exposes the [deprecated] sysfs entries
> for each variable that exists in the backing store.
> 
> Since the efivars.ko module is deprecated, and all users appear to
> have moved to the efivarfs file system instead, let's prepare for
> its removal, by removing EFI pstore's dependency on it.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

With this and the other pstore patch, do the pstore self-tests still
pass on an EFI system?

If so, please consider both:

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
