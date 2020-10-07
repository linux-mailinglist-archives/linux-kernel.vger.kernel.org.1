Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B06286823
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgJGTRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGTRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:17:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C14C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 12:17:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b193so1179653pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 12:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EZMSE/xQ7AzIngGK3w5Ap7k+DggxMKKSrbX6SyQ019g=;
        b=SZhSXd1ccYKVdiga/5hBcXZZesYb5d1PFbu+8OjMa7Mlg62ELjJTkWVlu8RJqyaUJm
         J1+UqS1KPJp4raeG40fQt2RPcpJLxhr9wg0GV/IACJMhk76suxw/EvWPFEmgxUJGaoDU
         nMm7F6eeMgAWfcYXP0d9yLsUAaSkJWomMGHs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EZMSE/xQ7AzIngGK3w5Ap7k+DggxMKKSrbX6SyQ019g=;
        b=FDanGRzAQy5sdYWUzrf3KDfS1jyLEor7OiCOEs1scyJVau1aix7NnqEbdq1DPOZx38
         LpN33vFgXaYISx4T2t3xKPK+AZ0ewTHxvZ15X224QT7v+v6zB6kB/oRpxIjq+MJsUxpH
         dQOgjlH17fc6an6b1d2jIvrg8UjGTF8E0prSa7cxxyEVf49+QEyJ3E7tz5XwH/1BgC62
         vYgQ6Pxq7imJdHhiUZU6Hv20nhJHn7D4gGLPW7l4IYVEzb8dZg1sIUcRZMXRZFHIt0Ql
         OmcUawORUB4lzAkbPAQyxYogKgins1NXS4WSDyN1EtSkOLQ3yinpT+gyMh307jc2w6v6
         wnxQ==
X-Gm-Message-State: AOAM532ayIFt/2IwAqD9kr9Z8STk6f0yK/logMEmNElFWK7baszdf3o4
        zPVhxd5aYFZf+H4b7WwpgLBELQ==
X-Google-Smtp-Source: ABdhPJxSZ58HQ14M6xAuImI7StMZrCjyYHvJE0/IhXi3VSO+yGRJkNFLSJFofW7GUBPqBFMkujTJog==
X-Received: by 2002:a05:6a00:1585:b029:142:2501:35ed with SMTP id u5-20020a056a001585b0290142250135edmr4439365pfk.77.1602098247651;
        Wed, 07 Oct 2020 12:17:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e19sm4428262pfl.135.2020.10.07.12.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:17:26 -0700 (PDT)
Date:   Wed, 7 Oct 2020 12:17:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     WeiXiong Liao <gmpy.liaowx@gmail.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: use case for register_pstore_blk?
Message-ID: <202010071147.F6E57A32@keescook>
References: <20201006155220.GA11668@lst.de>
 <202010070007.8FF59EC42@keescook>
 <20201007075537.GA12531@lst.de>
 <20201007083715.GA15695@lst.de>
 <202010071130.7EA00291@keescook>
 <20201007184258.GA6157@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007184258.GA6157@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 08:42:58PM +0200, Christoph Hellwig wrote:
> The problem with the block code is that it is completely broken.

This seems like hyperbole.

> It uses on-stack structures where it can't,

Do you mean the ones in pstore_blk_init() and pstore_blk_exit()? Those
are fine -- they're what provide the "driverless" module-param loaded
"best_effort" target. Do you seem something unsafe about it?

> it pokes into internals of the block device read/write path for
> absolutely no reason,

Do you mean psblk_generic_blk_read() and psblk_generic_blk_write()?
These are for writing to the block device... I'm happy to adjust this
if you can show me the better API. (This was being developed in the
middle of the iov_iter changes, so perhaps I missed a more appropriate
way to do things.)

> and it uses name_to_dev_t which must not be used in new code.

What?

include/linux/mount.h:
extern dev_t name_to_dev_t(const char *name);

init/do_mounts.c:
/*
 *      Convert a name into device number.  We accept the following
 *      variants:
 ...
 *      If name doesn't have fall into the categories above, we return
 *      (0,0).
 *      block_class is used to check if something is a disk name. If the
 *      disk
 *      name contains slashes, the device name has them replaced with
 *      bangs.
 */
dev_t name_to_dev_t(const char *name)

There are no comments about it being deprecated.

And even I had guessed to double-check, there isn't even a hit
on lkml about it that I can easily find:
https://lore.kernel.org/lkml/?q=name_to_dev_t+%22new+code%22
https://lore.kernel.org/lkml/?q=name_to_dev_t+deprecated

Where did this happen, where was it documented, and what should be used
instead?

> Or in other words: it is a complete piece of crap full of layering
> violations that should never have been merged in that form.

Gee thanks. I obviously don't agree with you.

> It also does not happen to share code with the mtd case.

What? Yes it does: it explicitly uses the pstore/blk configuration
callback to get the details configured at boot to identify and configure
the backing device. This is specifically designed this way to avoid
repeating the mistake of having per-backing-device configuration that is
essentially only actually used by the pstore storage layer. i.e. the very
thing I'm trying to get away from in ramoops, efi-pstore, etc: storage
configuration is tied to the pstore storage layer (i.e. pstore/blk and
pstore/zone), not the specific backing device (i.e. MTD, blk, RAM, NVRAM,
EFI variables, etc).

So, yes, I think it'd be fine to drop the unused EXPORTs, and I welcome
corrections to the generic read/write routines, I very specifically do
not want to rip out having a block device as a backing device, nor do I
want to revert the configuration management to being backing device
specific.

-- 
Kees Cook
