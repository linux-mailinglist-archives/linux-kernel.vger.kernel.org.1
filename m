Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A472FB8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392748AbhASN2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392732AbhASNSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:18:35 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B72C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:17:42 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e7so21862906ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0WyZ0QjeeZxPEOPKkoltDAJRX7zc5vT1YGzpNcNLdg=;
        b=LOKDOAdbletZJxnT+nSaBkOgX3NZbBgWpZRAbqYlUul6ZCkyKN8zA/ia6Ds6vE5yoj
         rjts812XBS1aFJraX8QRugBXIJEBGr4LGwdRH+jybZVowZvtW78kbI7rfTy96mMLSrjK
         W3Y8Ev5DiFpdt/ZkLfMvVp5uAUaXzntEN1Q1i/pJCmp9HjUntST5omCO4tP+jC4hqdG/
         xCHgoSSBEZu8vp+rszoxN06cH5TsSSI3sTfNeWTZpZcFVz83GQi02J6w6uamqUKyFu+U
         XlMupOFR8JDQmhHkZxcEo2OyGgaqizv6soDyTUexM9eL7n9wxRl9WWti86pE3KwXvcde
         8R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0WyZ0QjeeZxPEOPKkoltDAJRX7zc5vT1YGzpNcNLdg=;
        b=UY6xmGwoV+R6VoS1D8AocVSJ47Gf1lgX8uF16mE6Jqotsj5udgengkCgqJKhBjD4Cf
         s3qNSyjo8va/61Cd2iXH1Qdozyn1dlfxYLzQVji6EaCsvkIfL1XmtPF+wP/LW2A7OzmP
         ODr+zkDmHRlzL7D2ttD28IpYs/KhjBU9v1BgC+hXuzUFV0E4+ZE/JuVWH1SyVe2V4CSY
         nreOxTdWwsRKq6504Z3X2RT0xjWEu8FFbGvt5mF91Hky+4CpNSfrLE4QzmGPWWRcqkaF
         Q96hwz58haO8xTn2aCnAIQg8p+2szIxDvDsDPbM2EOSrdAuUxqffQBYgKOPX4OTHD18S
         5H4Q==
X-Gm-Message-State: AOAM533MQiIlO+0Cr7INU22oMPd1B90s5PJM33T1OPv0mB2fmd4ZuFF5
        Yd/0yhDUpWyyNczFz4psOjtrEQqAUsWWFxLcLhg=
X-Google-Smtp-Source: ABdhPJxQLFCiId4xaE1FKf4J06dsRKMnZPjV3ri61od/WV6lWyDqFZBH6nkjkiiP7QKazbjZWcJthNp/sVBpsj2S7Fg=
X-Received: by 2002:a2e:90c8:: with SMTP id o8mr484635ljg.43.1611062260956;
 Tue, 19 Jan 2021 05:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20201109113233.9012-1-dbrazdil@google.com> <20201110101542.GA17572@infradead.org>
 <b174c468e3df6dc7874b9ab886b38009@kernel.org>
In-Reply-To: <b174c468e3df6dc7874b9ab886b38009@kernel.org>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Tue, 19 Jan 2021 15:17:29 +0200
Message-ID: <CAE=NcraN8NcnJEneno=U6dPj3esHSjChfqu9XKLNPE49ULhxwQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/24] Opt-in always-on nVHE hypervisor
To:     Marc Zyngier <maz@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 1:19 PM Marc Zyngier <maz@kernel.org> wrote:

> > Why?  I thought we were trying to kill nVHE off now that newer CPUs
> > provide the saner virtualization extensions?
>
> We can't kill nVHE at all, because that is the only game in town.
> You can't even buy a decent machine with VHE, no matter how much money
> you put on the table.

As I mentioned it earlier, we did this type of nVHE hypervisor and the
proof of concept is here:
https://github.com/jkrh/kvms

See the README. It runs successfully on multiple pieces of arm64
hardware and provides a tiny QEMU based development environment via
the makefiles for the QEMU 'max' CPU. The code is rough, the amount of
man hours put to it is not sky high, but it does run. I'll update a
new kernel patch to patches/ dir for one of the later kernels
hopefully next week, up to now we have only supported kernels between
4.9 .... 5.6 as this is what our development hardware(s) run with. It
requires a handful of hooks in the kvm code, but the actual kvm calls
are just rerouted back to the kernel symbols. This way the hypervisor
itself can be kept very tiny.

The s2 page tables are fully owned by the hyp and the guests are
unmapped from the host memory when configured with the option (we call
it host blinding). Multiple VMs can be run without pinning them into
the memory.  It also provides a tiny out of tree driver prototype stub
to protect the critical sections of the kernel memory beyond the
kernel's own reach. There are still holes in the implementation such
as the virtio-mapback handling via whitelisting and paging integrity
checks, and many things are not quite all the way there yet. One step
at a time.


--
Janne
