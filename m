Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47C2A84CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbgKERZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgKERZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604597115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPEI/FFuYpiP56PpQA6lk3angxPYKQdyFb9K5UKth0s=;
        b=igm7lnDcf5e+vJ8uND5JrWKUhBl+NprjJYO2Kog+WZxbVC+bv3cDk+BuYZGRoI09p6Nwpn
        ws19xUWm2b6DXtIw6zikf4T1tFsW9TSIuKDKpudI/O3HpZvcW0gWacoDJ/5pKzFjjtEFJp
        N9JV+wnD/M1yXOavJBdDiNdt144YyVs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-RYsnFUv2PxGFqRki8-ud9Q-1; Thu, 05 Nov 2020 12:25:13 -0500
X-MC-Unique: RYsnFUv2PxGFqRki8-ud9Q-1
Received: by mail-qk1-f198.google.com with SMTP id f9so1350812qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WPEI/FFuYpiP56PpQA6lk3angxPYKQdyFb9K5UKth0s=;
        b=YOaH63Mv06yrYwXQ8NDge317VP7cNpLDHmMKe+gnm06KL+UYhTD8K8f8PpEToN6WEj
         o67GjIWadpz84qEeKz/fcMyxhRjMq1g+0vxGbFlOvFdo1vj2B3wVlGs7QTFleN6s+bg5
         gMNwRpr+99bgsUwJhYTcg99djqOBt9TrZT8UeCZ3TqUnL3l71jVepFmM4VMAfHpKCBHw
         LDVlanYYLHXsRmw5fmjeLxDOPbMRvDhVrpghltnXez83wqHonEGUy5IdZYAQ9NEfp/WN
         lgZKuMM4tw3IFNDgKA9Q5ENMsj5p8gfSmCBiGrL7EYyFB/PTGaSX11AP4OJEY2kHwqd0
         Pa/g==
X-Gm-Message-State: AOAM531J1/98pZFMKJhAMClPYk+aj8wz/CjFrdaqfHgSfMihwW8FNhli
        4YKThXIl4ul5lzoGj5FELiipYrqFwxqxOb9V35tEA9L7RC7Q904IXwEYeo0K2Dg1lN9UvxJIEH7
        2PtpymZfZGoMuRJVzAJodXzu/
X-Received: by 2002:a05:6214:146e:: with SMTP id c14mr3309908qvy.22.1604597112249;
        Thu, 05 Nov 2020 09:25:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtmeXVAB1aAnOhzStHrZkBLVBdXifGyhRwR1oX2R19i3a1RqfwAioUGSo4+qVHDn8RU39ntQ==
X-Received: by 2002:a05:6214:146e:: with SMTP id c14mr3309882qvy.22.1604597111984;
        Thu, 05 Nov 2020 09:25:11 -0800 (PST)
Received: from [192.168.1.16] (198-84-214-74.cpe.teksavvy.com. [198.84.214.74])
        by smtp.gmail.com with ESMTPSA id n3sm1226750qta.10.2020.11.05.09.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 09:25:11 -0800 (PST)
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
To:     Thomas Gleixner <tglx@linutronix.de>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan>
 <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
 <87sg9vn40t.fsf@nanos.tec.linutronix.de>
 <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com>
 <87h7qbmqc3.fsf@nanos.tec.linutronix.de>
 <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com>
 <87k0v7kwdc.fsf@nanos.tec.linutronix.de>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <7a4d7b14-1f0b-4c40-2bd1-2582d8b71868@redhat.com>
Date:   Thu, 5 Nov 2020 12:25:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87k0v7kwdc.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 9:38 PM, Thomas Gleixner wrote:
> Coming back to your test coverage argument. I really don't see a problem
> with the requirement of having qemu installed in order to run 'make
> check'.

Cost. It's is cheaper and easier to maintain and deploy containers.

A full VM requires maintaining and updating images, and kernel builds
independent of what the developer is using for their development system.
This goes out of date quickly and needs a lot of resources to maintain.

When you get away from a VM you can then engage the entire developer
community to just run your userspace testing on *their* hardware on *their*
kernels. So I can go to Arm, Intel, AMD, IBM, SUSE, Red Hat, etc. and say:
"All you need to do is run 'make check' and the tests will verify your
hardware and kernel are working correctly." Those developers don't want their
system clocks adjusted during testing, and they are as busy as you and I are.

Container registries and tooling are much lighter weight and support layering
changes on top of base images in ways which allow different testing scenarios.
I don't have any desire to build a similar ecosystem for VM images or wait for
VM+container (kata) tooling to grow up.

If kata grows up quickly perhaps this entire problem becomes solved, but until
then I continue to have a testing need for a distinct CLOCK_REALTIME in a
time namespace (and it need not be unconditional, if I have to engage magic
then I'm happy to do that).

> If you can't ask that from your contributors, then asking me to provide
> you a namespace magic is just hillarious. The contributor who refuses to
> install qemu will also insist to run on some last century kernel which
> does not even know about name spaces at all.

I don't disagree with you, it is *absolutely* a VM tooling issue, and that
containers are easier to maintain, and deploy. With namespaces I can build
glibc, a sysroot, and run it in isolation very quickly.

Just so I understand, let me reiterate your position:

* Adding CLOCK_REALTIME to the kernel is a lot of work given the expected
  guarantees for a local system.

* CLOCK_REALTIME is an expensive resource to maintain, even more expensive
  than other resources where the kernel can balance their usage.

* On balance it would be better to use vm or vm+containers e.g. kata as a
  solution to having CLOCK_REALTIME distinct in the container.
 Thanks for your feedback.

-- 
Cheers,
Carlos.

