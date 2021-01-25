Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67390302CF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbhAYUu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbhAYUuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 15:50:39 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE4FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:49:59 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id f2so11809065ljp.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOrvL3WE9CXeeQC1DryhJmY7YvE6n4IGLTv5pZc3Drs=;
        b=avfzDpjVYh+sznZbJ0EBB2/etLvBbrqgMwIWnYNKJX59fXhDMsAIWDA0vpRnYQXU5w
         l0OqTjaGROJmkRILZq+nYxfRP0Ze7uMO6V1aEWx+mOI1oIw6dzF/oAUnXOFtkEPl0+DC
         NlTqVJJfGkRXkAeM3Ab4/8qUFz0xUJiyp0kGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOrvL3WE9CXeeQC1DryhJmY7YvE6n4IGLTv5pZc3Drs=;
        b=J6E3y6E1ogV/zkUKpQjcgjilU1oaxNEkBr8QusrjyQKG7JwGHt3/Nhdpu7rGodrIW/
         Ibz7W3NsQH5HUn41AlOufm4IO/ZP8fIo4vO1YqE/ZRAMmqEsNseHf3AnveLR0pwZCXpa
         jg2/E1112mrafSmM1gXQ2erqKjqMhTEfJKhklVyZgxTysUwvzrfG3kh9b7GLhc/S46UX
         rKClxjMjVifcQH3viselo/cM+bBTsK2KT1uep4kE4eLAazf245zSylfxKD9fHDCngJ8M
         1HqTtsFdygUE6MLLZR5kBCC9UyTmQMlSmwClxVV+gVNpn6Ay6kdmPubZTFxdRK9hyWIw
         wmVg==
X-Gm-Message-State: AOAM531dWi2iLpxjBusSQs3r0jRms597ZPNP3iXdrgHct9Nw7vqo2E04
        5XoodNzl2nGL+Zvt4O+UgZux73++Yb5Q9A==
X-Google-Smtp-Source: ABdhPJwLuXC2cerXmgHF2L1H9uinN/tRjrBCRHvsQTaZTbGIcEMRwHW3oBQOhkx6sc7wtRtb0GWcjw==
X-Received: by 2002:a2e:6f05:: with SMTP id k5mr1026890ljc.400.1611607797456;
        Mon, 25 Jan 2021 12:49:57 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id k5sm1372331ljg.119.2021.01.25.12.49.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 12:49:56 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id o10so19745125lfl.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 12:49:56 -0800 (PST)
X-Received: by 2002:a19:c14c:: with SMTP id r73mr974362lff.201.1611607796008;
 Mon, 25 Jan 2021 12:49:56 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <161160687463.28991.354987542182281928@build.alporthouse.com>
In-Reply-To: <161160687463.28991.354987542182281928@build.alporthouse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jan 2021 12:49:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com>
Message-ID: <CAHk-=wh23BXwBwBgPmt9h2EJztnzKKf=qr5r=B0Hr6BGgZ-QDA@mail.gmail.com>
Subject: Re: Linux 5.11-rc5
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:35 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Linus Torvalds (2021-01-25 01:06:40)
> > Mike Rapoport (3):
> ...
> >       mm: fix initialization of struct page for holes in memory layout
>
> We have half a dozen or so different machines in CI that are silently
> failing to boot, that we believe is bisected to this patch.

That commit reverts cleanly - so if you can verify that reverting it
fixes your CI machines, I think that that's the right thing to do for
now, unless Mike can figure out some obvious "Duh!" moment from your
working dmesg.

Mike: should we perhaps revert the first patch too (commit
bde9cfa3afe4: "x86/setup: don't remove E820_TYPE_RAM for pfn 0")?

                Linus
