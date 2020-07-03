Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F55213FC4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 21:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgGCTFQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Jul 2020 15:05:16 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:6433 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgGCTFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:05:15 -0400
Subject: Re: nr_cpu_ids vs AMD 3970x(32 physical CPUs)
To:     Uladzislau Rezki <urezki@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <GregKroah-Hartmangregkh@linuxfoundation.org>,
        <peterz@infradead.org>
References: <20200703155749.GA6255@pc636>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <8a2a55e6-6087-e4bf-3d35-ed4b4c216369@sony.com>
Date:   Fri, 3 Jul 2020 21:05:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703155749.GA6255@pc636>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CszBjUwD c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=IkcTkHD0fZMA:10 a=_RQrkK6FrEwA:10 a=zQO6xEfzLkKbw6bwTKUA:9 a=0OkEAe7UqRvhMRmr:21 a=-cKQYqgAhFfF71hO:21 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/20 5:57 PM, Uladzislau Rezki wrote:
> Hello, folk.
>
> I have a system based on AMD 3970x CPUs. It has 32 physical cores
> and 64 threads. It seems that "nr_cpu_ids" variable is not correctly
> set on latest 5.8-rc3 kernel. Please have a look below on dmesg output:
>
> <snip>
> urezki@pc638:~$ sudo dmesg | grep 128
> [    0.000000] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GSI 0-23
> [    0.000000] smpboot: Allowing 128 CPUs, 64 hotplug CPUs
> [    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:128 nr_node_ids:1

My 3950 do


[    0.005271] ACPI: SSDT 0x00000000CA1F5000 0003F1 (v02 ALASKA CPUSSDT  01072009 AMI  01072009)
[    0.108266] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.111384] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1

(Fedora F32  5.6.18-300) What motherboard and BIOs do you use?


> ...
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=128, Nodes=1
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=128.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=128
> urezki@pc638:~$
> <snip>
>
> For example SLUB thinks that it deals with 128 CPUs in the system what is
> wrong if i do not miss something. Since nr_cpu_ids is broken(?), thus the
> "cpu_possible_mask" does not correspond to reality as well.
>
> Any thoughts?
>
> Thanks!
>
> --
> Vlad Rezki


