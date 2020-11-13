Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063C42B22BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKMRn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgKMRn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:43:56 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AC5C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:43:55 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so15117890lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bui3w/JDmgOw56pph2MwTaqoXkk3b91lkGXCtSBMmk4=;
        b=ViCHZOfB3ZVrI2719JIrjtqmLfchSmXmpK21j+SATESz6ZigO26ldGyvMAUqhLcZC/
         U6CmuuMZYQXfAwAT4ompuYoa5ieUR47EdQeayRl28Np4wPFq8HkOc4SkhTPRiGS9OCxI
         ceL6XTVxbyzEGNE6gqZtJ/NR2OTEZi+5uJ9ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bui3w/JDmgOw56pph2MwTaqoXkk3b91lkGXCtSBMmk4=;
        b=pmsbyKDxfNWH6tnKSR7DKIovrb6fYuAfkgBP5ahLxbgIN8HwyVKcNTl9xT9CaQhb3p
         5JSTjTUwZDUYrGO+1GXU7M02uLgyU01ybn68CClsV85PUrWrkhV7dZ0skRAEPIq+tihG
         +YlYxuh5Z5UoK65U6+TUf/VmYen1Sy3rpHIRj/W/0uQAA4DB2XmHc0KlFuXB2et8B2jF
         7jgn3e4wD+T6O2FCmCyIuiGNIk+jfGj+BMw25WDfpSBMyruEVyB4wyTiYX2GLjMypuKL
         WuujXSyoGPPZd8FOsgjN3UTNgy5JJsLwNzgCYjaJAF8i9zapGK4GIoyt+YDrYPssSbVI
         7nmw==
X-Gm-Message-State: AOAM530zAJakyGnDJONujadtVlJa8xxxHGd03vecRrXMT7To4n+9hqcb
        WM5C+LzT1jQ1iQ/BcgAPR2+61of4wmjIjA==
X-Google-Smtp-Source: ABdhPJwg1OhtqHtZzJXd7QsDBcXBIaYUu60J45FlbmZXL1auBobO5m6LwBPP0nosW1WMOzjj1qkxUA==
X-Received: by 2002:a05:6512:2033:: with SMTP id s19mr1423297lfs.462.1605289428907;
        Fri, 13 Nov 2020 09:43:48 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id k23sm1704612ljh.95.2020.11.13.09.43.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 09:43:48 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id s9so11656441ljo.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:43:48 -0800 (PST)
X-Received: by 2002:a2e:3503:: with SMTP id z3mr1445096ljz.70.1605289427081;
 Fri, 13 Nov 2020 09:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20201113082930.27da4612@oasis.local.home>
In-Reply-To: <20201113082930.27da4612@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Nov 2020 09:43:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whO3bt9wCFX-v54RYewdAuovVEDx9DHJ0SbhrzCwY3aEA@mail.gmail.com>
Message-ID: <CAHk-=whO3bt9wCFX-v54RYewdAuovVEDx9DHJ0SbhrzCwY3aEA@mail.gmail.com>
Subject: Re: [GIT PULL] bootconfig: Extend the magic check range to the
 preceding 3 bytes
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chen Yu <yu.chen.surf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 5:29 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Fix alignment of bootconfig
>
> GRUB may align the init ramdisk size to 4 bytes, the magic number at the
> end of the init ramdisk that denotes bootconfig is attached may not be at
> the exact end of the ramdisk. The kernel needs to check back at least 4
> bytes.

I've pulled this, but this really smells to me.

Isn't the thing that actually _writes_ that BOOTCONFIG_MAGIC able to
fix this properly? I'm looking at the bootconfig tool, and wondering
why that doesn't know about the alignment thing, for example.

And the fact that this got screwed up means that the BOOTCONFIG
documentation needs updating too, so that the rules are documented and
proper.

                      Linus
