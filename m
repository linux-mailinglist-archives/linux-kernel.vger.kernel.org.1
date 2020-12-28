Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7A72E35E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 11:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgL1KX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 05:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgL1KX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 05:23:29 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6012C061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 02:22:48 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 15so7090402pgx.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 02:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ez6/tVB0AA3uK98gtiJ9kcTSMn3gjBIVz5DwqLzPqc8=;
        b=jxIfKfPf6nmn/o//XvSP7lePRuBVBpKNawBvC2IGhRJtjxRG8oBOf8Il/D3KDSXGo9
         Y/Qy0DQIwTgNW/f1M9hlEHiANQDkHrcrTLaI6ISlXnZvZ8hiDx0DXPEh/tzeALUD8/a6
         nsCi9y/btvuXU+OvyylkjpZQxk87NBtArQWJDZSOCPa7T43LwV0SHkF9egIXGoD/QZS7
         SEv2/JPPn9MrNzU0Ti62etcIKxkVGXDzn72AixxGcQ1BnPi9/LhQjdxY1GZ3GfeGwatM
         0aiIJ64tieC947iz/mgQ4KmrdHMiO2iaUurFIB0RKqCnNRAxgEP4CrUeLoNWxtp9mGlR
         uUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ez6/tVB0AA3uK98gtiJ9kcTSMn3gjBIVz5DwqLzPqc8=;
        b=jKwYYm3usOCIq+EEEircv38d0y9oUmfrPBoYzmKzH5TfiqUtm2m0rOCajBo/VCLmAI
         8Eh0KxvJjSgkO81rUja4jDTFAL5rHIs4ng44kOssuU4JoOQBElv//f2e+XaLiWmu4MlT
         Q1z5E3yb2wbptnLTRQPtmilFXp7v4Edg7Sj3pr2yHuF2p09X5C/mvGztSxQ/Xx19vnvv
         XONh++iahwXnjjINbInbwc2KRyy53xEJ1L3WVH6pDht8gwsPZaKD1GatyQTfF59oFv4P
         +XWMmAhftauaavvmuzajifWdKsN1eb15sc5HwbXTnLh/OtvwUOUoQkBVEUyEojZJ6XiO
         rOLw==
X-Gm-Message-State: AOAM530hxzSJ8jylXGWdOdfH65J+o8KRoTYIFoV/oQ7LVZstdlKe5Bja
        wIdA3UKw7jDgcQ3bSmNz2iUPOL8j1sJ4eIIj63M=
X-Google-Smtp-Source: ABdhPJznnfxinb9csIFX7dRokfsKllGI3MdBiIP3/XB6Ff90bz4Jf4Oj4EcO+G2FMR3hrYOpyeZpHiSp/jrlpzJKkrs=
X-Received: by 2002:a63:f016:: with SMTP id k22mr23687183pgh.233.1609150968461;
 Mon, 28 Dec 2020 02:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20201228025339.3210-1-xie.he.0141@gmail.com> <20201228091654.1963-1-hdanton@sina.com>
In-Reply-To: <20201228091654.1963-1-hdanton@sina.com>
From:   Xie He <xie.he.0141@gmail.com>
Date:   Mon, 28 Dec 2020 02:22:37 -0800
Message-ID: <CAJht_ENqaJtUwfcXCC2WXNJi+9_HuYX4SrY-QZd19mZrL0EHBg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: hdlc_ppp: Fix issues when mod_timer is called
 while timer is running
To:     Hillf Danton <hdanton@sina.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Halasa <khc@pm.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 1:17 AM Hillf Danton <hdanton@sina.com> wrote:
>
> On Sun, 27 Dec 2020 18:53:39 -0800 Xie He wrote:
> > ppp_cp_event is called directly or indirectly by ppp_rx with "ppp->lock"
> > held. It may call mod_timer to add a new timer. However, at the same time
> > ppp_timer may be already running and waiting for "ppp->lock". In this
> > case, there's no need for ppp_timer to continue running and it can just
> > exit.
>
> Because the timer callback loses the race in acquiring the ppp->lock
> does not mean it should abort.

I think aborting ppp_timer is the correct solution. When mod_timer is
called by ppp_cp_event, which is (directly or indirectly) called by
ppp_rx, this means we received something on the line that makes the
original timer no longer necessary. If the timer is pending, mod_timer
will delete it. If the timer is running and waiting for the lock, I
think it should abort. This way it would appear that the timer hasn't
fired and is deleted before it fires.

> > If we let ppp_timer continue running, it may call add_timer. This causes
> > kernel panic because add_timer can't be called with a timer pending.
>
> Meanwhie we can defuse the peril following add_timer() added in
> e022c2f07ae5, say by replacing add_timer() with mod_timer().

The code path that calls add_timer is for sending keep-alive packets
when operating in the OPENED state. If we have just changed to the
OPENED state in ppp_cp_event, we should wait for the amount of time
set by the (2nd) mod_timer call in ppp_cp_event, before firing the
timer. We shouldn't fire the timer immediately after we change to the
OPENED state. This is not the intention of the (2nd) mod_timer call in
ppp_cp_event. Therefore aborting ppp_timer is the correct solution.
