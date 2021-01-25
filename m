Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31216302330
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbhAYJRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbhAYJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19DC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:18:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a9so11259281wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q600Utn5CHHrIrEp71Q3qYBMngzPu277qVinvis4Thk=;
        b=nREyOnY2CVXjIIEvrNx3+72LX7UrbmjuyB7BYUZksPx7CSNK4olcd1+AWp8FLrOoFN
         GHTtm1qdunFTCXQLgY4uq07alzAb3d8otuyYCQZfG2P02YizyyHu6wpMJwRzDI9qkZZP
         vUfWDUdsJZlXRoWGr1LSf51riWezqvxHIFMSOcCJkGeVm7NwcSFBSI7A5/Mv3zjQuVrJ
         9e6wYB9BOdcCFCRlVYB4jCn5vnpV3nWnmHQY3XBKL14gih3DAVuOgD6KGM9Un+pp2/0h
         qLgsQwz090HJYvcp+7bMxXvrdMFsngt/s/LaQRtdEou3kbqLE3RsU5Q0zRjHLc2mBIHy
         XTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q600Utn5CHHrIrEp71Q3qYBMngzPu277qVinvis4Thk=;
        b=tnFCdeVrMu9Zv0QO7cn3BYpYHfq8KwIxX4TspzXylFhEy1dK5gNFk1+MwD79pDjsnu
         2Dr0Rvrs/F4Ng7Kw+j2Mhd7TT2HD9wPa0bcdDMRqZErElmlGxlx+FZy7CgIvvOkTbP+f
         CSDl/nJjN1dPuVSQrusb6YYbbP0plXUl8gBFZpkShmb+nVikMCZNTYR8FreXO2jY6pHB
         9UscnbuzNBlNW7kPchg4XxHVnqLrrm5yOivQKTEDGffLz+TRj6fv6808lFZ00KiCeaZW
         JHrRuvcQ++BuHHe/bCTyO3YVkH6I8MYxV8AOVK7NHrCwvZ20U7YLLVJzp+PuHHpL9twl
         gYUg==
X-Gm-Message-State: AOAM531jUANnX5l60jXpjRRwrDHr6oLdrP/6u4bnK1n3INvy3UQa9bvd
        kr4/fLjCNqp3sW+NyrhC9Z/od4viR4MqLg==
X-Google-Smtp-Source: ABdhPJyQkY+xO02tgsOdElGMDryx1Cc2ynhm51I/0me+mHeenSl+K7hJ5lNV0Ghq0ee1Cqj7JU0tQw==
X-Received: by 2002:a05:6000:1082:: with SMTP id y2mr1166660wrw.27.1611562737449;
        Mon, 25 Jan 2021 00:18:57 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r10sm19915008wmd.15.2021.01.25.00.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 00:18:56 -0800 (PST)
Date:   Mon, 25 Jan 2021 08:18:55 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] kdb: Make memory allocations more robust
Message-ID: <20210125081855.gfq3n6urcmght3ef@maple.lan>
References: <1611313556-4004-1-git-send-email-sumit.garg@linaro.org>
 <CAD=FV=V8HwhdhpCoiZx4XbTMWug0CAxhsnPR+5V9rB0W7QXFTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=V8HwhdhpCoiZx4XbTMWug0CAxhsnPR+5V9rB0W7QXFTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 09:25:44AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jan 22, 2021 at 3:06 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Currently kdb uses in_interrupt() to determine whether its library
> > code has been called from the kgdb trap handler or from a saner calling
> > context such as driver init.  This approach is broken because
> > in_interrupt() alone isn't able to determine kgdb trap handler entry from
> > normal task context. This can happen during normal use of basic features
> > such as breakpoints and can also be trivially reproduced using:
> > echo g > /proc/sysrq-trigger
> 
> I guess an alternative to your patch is to fully eliminate GFP_KDB.
> It always strikes me as a sub-optimal design to choose between
> GFP_ATOMIC and GFP_KERNEL like this.  Presumably others must agree
> because otherwise I'd expect that the overall kernel would have
> something like "GFP_AUTOMATIC"?
> 
> It doesn't feel like it'd be that hard to do something more explicit.
> From a quick glance:
> 
> * I think kdb_defcmd() and kdb_defcmd2() are always called in response
> to a user typing something on the kdb command line.  Those should
> always be GFP_ATOMIC, right?

No. I'm afraid not. The kdb parser is also used to execute
kernel/debug/kdb/kdb_cmds as part of the kdb initialization. This
initialization happens from the init calls rather than from the kgdb
trap handler code.

When I first looked at Sumit's patch I had a similar reaction to you
but, whilst it is clearly it's not impossible to pass flags into the
kdb parser and all its subcommands, I concluded that GFP_KDB is a
better approach.

BTW the reason I insisted on getting rid of the in_atomic() was to make
it clear that GFP_KDB discriminates between exactly two calling contexts
(normal and kgdb trap handler). I was didn't want any hints that imply
GFP_KDB is a (broken) implementation of something like GFP_AUTOMATIC!


Daniel.
