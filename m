Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BCC2DEB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 23:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgLRW2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 17:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgLRW2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 17:28:49 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F1C0617A7;
        Fri, 18 Dec 2020 14:28:09 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id q1so3602426ilt.6;
        Fri, 18 Dec 2020 14:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZjpjdjP/kx6CmrGSWKO3qDoSaGWe4tkhPwI5BTAB6Hg=;
        b=mjniCRyiPZkXoykePXVkZ0bS77EKQD9F/T55XbhY7/Sj3RfOVyppEncN3kSwQUwToj
         iIDx6Z0v3RoA8MLg85Jb8hiMz915VWqFAuiYUU6kEIalyXVClMt8sQGa1oftIeQOcGWk
         F6YflUxRbzvNZl9ePaSgqfkah1KvqAcqYBPyMlhdVzPt6YjiaE388HUhFAO6lCJ+3EQy
         bb6VF7UCtN+zWzp2AJF0JQe7OoHtltGd53ge6btLsqwb2T9aJKKf5KCF/yYlTEb74Azd
         ZuAQvnXE+bfBwLnY4buYL8P144Cl7dAjy9ETb2FnoFyyr/YqNWvbKTtSKlT0ev09OWB4
         qNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZjpjdjP/kx6CmrGSWKO3qDoSaGWe4tkhPwI5BTAB6Hg=;
        b=lg5cIEuAl/0sR/HPbl/KuViU1LR2XtCfDmBRCp1DWLJXZ98Wr0ua3c9mB09RfUHrqw
         +QDCGVDnCUon0TbCcBjAxeWBCzEWdxIBYGrhq+yvsYcbs1llkQevMLmjnRgMxn4rSi0W
         xhzDjXzew5/CG+TrR9CREF36B7ZMZ7M6+kpiTwvAiHi/6wLLcMXyCXLbEqHgn9Sep/bg
         WuHWB4IDjv/f7k/hZmiwMUse7K55heTtJGFNexUz85E8Z8NJJW6ibp9gN9buecustyB/
         vsjxWxxmaKNm4AHjLdXrEvF3u+FwFK9TxdGv8CxP/1obrDqI0IrqtnOxLcZI+R24SP43
         oq9w==
X-Gm-Message-State: AOAM531NN/S3SQlSBiDrB26DnAG2noGK2lS7e24u2o9QLjyBbWYKazVG
        wAz0vxe1tzW7V+k3IXLYUsjenDhn4iY/csk0a9k=
X-Google-Smtp-Source: ABdhPJz4V2ybF74i3zOnSHOmYeV46WBCxPwW1bWE9wxqp/hie6Lvqw4UTUeQY9H8xEQ+qX/UkbvcpHVQGAYBcXYWHHc=
X-Received: by 2002:a05:6e02:8d:: with SMTP id l13mr6310898ilm.163.1608330488850;
 Fri, 18 Dec 2020 14:28:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5e:dd01:0:0:0:0:0 with HTTP; Fri, 18 Dec 2020 14:28:08
 -0800 (PST)
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
From:   Kjetil Oftedal <oftedal@gmail.com>
Date:   Fri, 18 Dec 2020 23:28:08 +0100
Message-ID: <CALMQjD-M4MN+zcZ0t4P5hvtjbd57azmNRmsj9jvwyHFquY84Vw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Andreas Larsson <andreas@gaisler.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Denis Efremov <efremov@linux.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2020, Sam Ravnborg <sam@ravnborg.org> wrote:
> The sun4m and sun4d based SPARC machines was very popular in the
> 90'ties and was then replaced by the more powerful sparc64
> class of machines.
> Today there is only Gentoo that to my best knowledge supports
> sparc32 and people have moved on to more capable HW.
>
> Cobham Gaisler have variants of the LEON processer that
> runs sparc32 - and they are in production today.
>
> With this patchset I propose to sunset sun4m and sun4d and move
> focus to a more streamlined support for LEON.
>
> One downside is that qemu supports sun4m - and we may loose
> some testing possibilities when sun4m is dropped. qemu supports
> LEON to some degree - I have not yet tried it out.
>
> Andreas from Gaisler have indicated that they may be more active
> upstream on sparc32 - and this will only be easier with a kernel
> where the legacy stuff is dropped.
>

This makes me a bit sad. But I guess I haven't had any time to put
into the sparc32 port
for many years, so I guess it is time to let go.

But I do believe that by doing this we should make sure we are not
putting ourselves
in a position where the sparc kernel-developers don't have access to
any real sparc32
hardware.

SUN machines were at least plentiful. The LEON-family of processors
being targeted
towards the rad-hardened market are not so much available.

Maybe Gaisler can contribute some systems, or make some available remotely?

Best regards,
Kjetil Oftedal
