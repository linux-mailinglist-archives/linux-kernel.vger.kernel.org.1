Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F4D2FF31A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAUS0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:26:00 -0500
Received: from foss.arm.com ([217.140.110.172]:43372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbhAUSWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:22:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D74D11B3;
        Thu, 21 Jan 2021 10:21:35 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98A443F66E;
        Thu, 21 Jan 2021 10:21:34 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: 5.11-rc4+git: Shortest NUMA path spans too many nodes
In-Reply-To: <8797fd78-4367-bc5c-3a35-43c544c745e4@linux.ee>
References: <3ec17983-7959-eccd-af25-400056a5877d@linux.ee> <jhjmtx22uv7.mognet@arm.com> <8797fd78-4367-bc5c-3a35-43c544c745e4@linux.ee>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 18:21:32 +0000
Message-ID: <jhjh7na2lsj.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 19:39, Meelis Roos wrote:
>> Could you paste the output of the below?
>>
>>    $ cat /sys/devices/system/node/node*/distance
>
> 10 12 12 14 14 14 14 16
> 12 10 14 12 14 14 12 14
> 12 14 10 14 12 12 14 14
> 14 12 14 10 12 12 14 14
> 14 14 12 12 10 14 12 14
> 14 14 12 12 14 10 14 12
> 14 12 14 14 12 14 10 12
> 16 14 14 14 14 12 12 10
>

Thanks!

>
>> Additionally, booting your system with CONFIG_SCHED_DEBUG=y and
>> appending 'sched_debug' to your cmdline should yield some extra data.
>
> [    0.000000] Linux version 5.11.0-rc4-00015-g45dfb8a5659a (mroos@x4600m2) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1) #55 SMP Thu Jan 21 19:23:10 EET 2021
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc4-00015-g45dfb8a5659a root=/dev/sda1 ro quiet

This is missing 'sched_debug' to get the extra topology debug prints (yes
it needs an extra cmdline argument on top of having CONFIG_SCHED_DEBUG=y),
but I should be able to generate those locally by feeding QEMU the above
distance table.
