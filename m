Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A4B2FAA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437464AbhARTfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437323AbhART07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:26:59 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CB0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:26:19 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f11so19400247ljm.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0dUgEF/OwYH5Cy4Vraqpbc5c5GySZK4BL/XBpkfWysE=;
        b=MZBsVSGABFRi1Faq5ThVU9o9JrzK6AScjQUS2Rt+SYImLjUBefcj3pLy4mMAtLGGLj
         VcC1UOuzg8Q+ldEIU6l2Pw+XlKitSjEadL/Wl6zXz3vTfuH8XL4osjODrsT/jki3lK/M
         TPrXjTjXHg3kZrHq4YaZhTrWXaCOhHC5BVtVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0dUgEF/OwYH5Cy4Vraqpbc5c5GySZK4BL/XBpkfWysE=;
        b=kD2vun3gLgbj0NowPUabPkSCmH8dQnvdOcT6sm1UHLeB/PNlFecyqtKF4+JuUG/Uma
         FiBnDni/gYXkvSgfBm8yfXgAMDtldTCF0/as9OhNCP3w43IOPLBptZszeiWF8nT0qW9C
         8MkS4iv0hnxrqFssQ99PBWodr/rp3P4+GcvThhB7b7+UuWWzFLM/xTFH0yaKZ0jwuG49
         Mis2Nl4EmmOQqDDbREWu1PG1vWjpIra9vAKsxj/NBKvnvGyGHaAcArRXqEK7PPjtoww5
         6nCYg0/cwQfmV/Xu4G6JD9PfsxEjnAQ8k+jGlP58J8cUarpgNJL2bFzImXOqryixn8kF
         87cA==
X-Gm-Message-State: AOAM531vMQCBGI3I3DFG37zi3+APqiIpXLHAhly5gCZDDiGlBaqIv/NK
        8QEbWs4gFV6Q9WRVUqRP+N934qNUll4yhw==
X-Google-Smtp-Source: ABdhPJyZ2zOVBt4qgK21vil1GGqiGYIXWsEV24Y3aimFKtgoMuuSBRnZqaDXxIDaE0RZzaqhpTk0yA==
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr448673ljm.266.1610997977626;
        Mon, 18 Jan 2021 11:26:17 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j15sm1665532lfb.13.2021.01.18.11.26.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 11:26:16 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id v24so19010912lfr.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:26:16 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr244283lfh.377.1610997976259;
 Mon, 18 Jan 2021 11:26:16 -0800 (PST)
MIME-Version: 1.0
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <f184764a283bdf3694478fa35ad41d2b3ec38850.camel@sipsolutions.net>
 <20210118085311.GA2735@lst.de> <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
In-Reply-To: <ece3af8e4512517da220bdd2f43119ca889f6c61.camel@sipsolutions.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Jan 2021 11:26:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
Message-ID: <CAHk-=wiiqjO5c_JK5-jW6=JzxoQ26uNHyKtbJfTW+6Ryw9Sv9w@mail.gmail.com>
Subject: Re: Splicing to/from a tty
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Christoph Hellwig <hch@lst.de>, Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:58 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> > I think just wiring up iter_file_splice_write would work.  Al?
>
> Seems to work for the simple test case that I had, at least:

Mind sending me a signed-off patch for this?

Yeah, I know it's a trivial one-liner, but I much prefer having an
author with a patch and a sign-off to just doing it personally and
reaping all that glory for it..

           Linus
