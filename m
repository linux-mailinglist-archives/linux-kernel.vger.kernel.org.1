Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19C82A455D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgKCMmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:42:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:42622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgKCMmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:42:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D46EAC6F;
        Tue,  3 Nov 2020 12:42:41 +0000 (UTC)
Date:   Tue, 3 Nov 2020 13:43:23 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Zack Weinberg <zackw@panix.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME
 support plans in Linux time namespaces
Message-ID: <20201103124323.GA8061@yuki.lan>
References: <20201030110229.43f0773b@jawa>
 <20201030135816.GA1790@yuki.lan>
 <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com>
 <87sg9vn40t.fsf@nanos.tec.linutronix.de>
 <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com>
 <87h7qbmqc3.fsf@nanos.tec.linutronix.de>
 <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com>
 <87k0v7kwdc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0v7kwdc.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> Virtualization is the right answer to the testing problem and if people
> really insist on running their broken legacy apps past 2038, then stick
> them into a VM and charge boatloads of money for that service.

Let me just emphasise this with a short story. Before I release LTP I do
a lot of pre-release testruns to make sure that all tests works well on
a different distributions and kernel versions.

Before I wrote a script that automated this[1] i.e. runs all the tests in
qemu and filters out the interesting results it took me a few days of
manual labor to finish the task. Now I just schedulle the jobs and after
a day or two I get the results. Even if the tested kernel crashes, which
happens a lot, the machine is just restarted automatically and the
testrun carries on with a next test. All in all the work that has been
put into the solution wasn't that big to begin with it took me a week to
write a first prototype from a scratch.

[1] https://github.com/metan-ucw/runltp-ng

-- 
Cyril Hrubis
chrubis@suse.cz
