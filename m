Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C68E2E6494
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633152AbgL1Pwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393070AbgL1Pwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 10:52:32 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB8FC061795
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 07:51:52 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a109so9471133otc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RzPGn0XhLl98gJzDgUp3JtBOs6y+i2JhsNFNR4yU+/Q=;
        b=hI/A/pm8gLa5gbalQQx0mQukHrel3cS+vyanNTZY5Mkqp+QG2gso4DvMepHDQoeHQi
         VlDv48L9ual9jb4l1DlW0GN+6lQ+g9We4HX6KmiMTPRU95LWHgraK0klO6KCt4WW2mM3
         kmxhqnAI3bllIfEUevC8TMpON5QuQ20VdAmyK7Ls6wSuLvcmb/K6VwWWRVXSMuEsPAW4
         huBYSwFyzfmvMf8UEH8zjMtW7jg+PCslKW2YLu/qifuTzWgSOurd5WieX3Zd5t68SJv0
         Yp0uAE4KdGGAj6DXI1PdhdIVZqWlsVOmkbCGHEQBdeR4fJseio3rjR5f7yOeF2sDVG6B
         N4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzPGn0XhLl98gJzDgUp3JtBOs6y+i2JhsNFNR4yU+/Q=;
        b=sqCr/LABidiNEXpj+vYffZsEFwuLqzY7c+eRPAPFjnIhjx++4yGiIGxZFShIDt2Q9F
         nG5v2B/e48XTsMPbvhI2cemE0dpaQpU/mwtyOOoScBqI1+95AIgLklMuvFr1W4tNOWMF
         di97rDrdvgGdU379jAZtFQoBzLWjxwQ/5M8rGejBvWkxOey8s0VJ2dR97KplxsWHAHiG
         2gUf9vNkgtdNUkM7lwq04cNaIwDZHHNIKZyptT5rQF13pJIlxUgsV9IY3OdH28BwADSA
         afD89p5aAkbeB/Xmfv2bV+d6Fw1kadWGlEbPV19uwBGlTXngHhf/8uMqIv+HRJ90WuOi
         aQJA==
X-Gm-Message-State: AOAM530ZRqW7AytkVfH+Jkn+xZantfovqlokXGiZyEErTCTL1nUEFfFF
        hCggqdQNDg9dnPwJklYISr4cZs66h1g=
X-Google-Smtp-Source: ABdhPJxIECF39Nfu9zG2m2snGA9szKrJJCmTnG3ZKc9eyyneehzOMbgSr/JjN5AiLqOyTsdJ7NUcuA==
X-Received: by 2002:a9d:6a06:: with SMTP id g6mr33257912otn.39.1609170712140;
        Mon, 28 Dec 2020 07:51:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l12sm1302181ooq.22.2020.12.28.07.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Dec 2020 07:51:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 28 Dec 2020 07:51:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc1
Message-ID: <20201228155149.GA197954@roeck-us.net>
References: <CAHk-=wg1+kf1AVzXA-RQX0zjM6t9J2Kay9xyuNqcFHWV-y5ZYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1+kf1AVzXA-RQX0zjM6t9J2Kay9xyuNqcFHWV-y5ZYw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 04:04:11PM -0800, Linus Torvalds wrote:
> Two weeks have passed, Christmas is over, and so is the merge window.
> 
> I want to thank all the maintainers who sent in their pull requests
> early: we all wanted to get things done before the holidays really
> hit, and mostly it seemed to work quite well.
> 
> In fact, it was rather nice to handle the big bulk of all the merge
> window pull requests in the first three or four days of the merge
> window.  I wouldn't want to do it that way every time - it would
> stress me out - but as an occasional "let's get it over with so that
> the second week is calm" it really wasn't bad at all.
> 
> It probably helped that 5.11 isn't going to be an LTS release and
> isn't as big as 5.10 was, but it's not small either. Solidly average.
> 
> Well, it's average, unless you look at the actual diffs, and notice
> another huge dump of AMD GPU descriptor header files, which completely
> dwarfs all the "real" changes here. The AMD "Van Gogh" include file
> additions are in fact about two thirds of the whole patch, even if it
> comes from basically one single commit that just adds the register
> definitions. We've had it before, I'm sure we'll see it in the future
> too: header files probably generated from the hardware description for
> all the possible bit masks etc get very very big.
> 
> Oh well. If you ignore that area, everything else looks normal. Driver
> updates dominate, but all the usual other suspects are there: arch
> updates, filesystems, networking, docs and tooling.
> 
> And while it doesn't look like a huge release, it's certainly still
> big enough that what's appended below is just my "merge log". As
> always, my merge logs credit only the people I pull from, which is a
> much smaller set than all the people involved in actually writing the
> patches. As usual we had more than 1500 actual developers, and roughly
> 12,500 changes merged. That's pretty much our average these days.
> 
> Please go kick the tires,
> 

Build results:
	total: 153 pass: 151 fail: 2
Failed builds:
	arm64:allmodconfig
	ia64:defconfig
Qemu test results:
	total: 430 pass: 412 fail: 18
Failed tests:
	arm:raspi2:multi_v7_defconfig:bcm2836-rpi-2-b:initrd
	arm:raspi2:multi_v7_defconfig:sd:bcm2836-rpi-2-b:rootfs
	<all parisc>

Build errors:

arm64:allmodconfig:

ERROR: modpost: "irq_check_status_bit" [drivers/perf/arm_spe_pmu.ko] undefined!

Caused by: fdd029630434 ("genirq: Move status flag checks to core")

ia64:defconfig:

include/linux/mmzone.h:1156:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE

and various related warnings.

Caused by: 214496cb1870 ("ia64: make SPARSEMEM default and disable DISCONTIGMEM")

Fix submitted ("ia64: fix build failure caused by memory model changes").

qemu boot tests:

arm:raspi2:

Hangs during boot.

Caused by: ffdad793d579 ("irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()")

Fix submitted ("irqchip/bcm2836: Fix IPI acknowledgement after conversion to
handle_percpu_devid_irq").

parisc:

Failed to execute /sbin/init (error -12)

Caused by: c49dd3401802 ("mm: speedup mremap on 1GB or larger regions")

More details are in responses to the offending patches.

Guenter
