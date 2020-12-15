Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088122DB639
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgLOWCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:02:55 -0500
Received: from www62.your-server.de ([213.133.104.62]:37772 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgLOWCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:02:48 -0500
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kpIOG-000EHG-IF; Tue, 15 Dec 2020 23:01:52 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kpIOG-000M2l-7T; Tue, 15 Dec 2020 23:01:52 +0100
Subject: Re: [PATCH 03/15] perf: Add build id data in mmap2 event
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20201214105457.543111-1-jolsa@kernel.org>
 <20201214105457.543111-4-jolsa@kernel.org>
 <20201215155226.GK258566@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <30ef464f-fc0b-bf5b-33e0-e207b754199d@iogearbox.net>
Date:   Tue, 15 Dec 2020 23:01:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201215155226.GK258566@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26018/Tue Dec 15 15:37:09 2020)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Arnaldo,

On 12/15/20 4:52 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Dec 14, 2020 at 11:54:45AM +0100, Jiri Olsa escreveu:
>> Adding support to carry build id data in mmap2 event.
>>
>> The build id data replaces maj/min/ino/ino_generation
>> fields, which are also used to identify map's binary,
>> so it's ok to replace them with build id data:
>>
>>    union {
>>            struct {
>>                    u32       maj;
>>                    u32       min;
>>                    u64       ino;
>>                    u64       ino_generation;
>>            };
>>            struct {
>>                    u8        build_id_size;
>>                    u8        __reserved_1;
>>                    u16       __reserved_2;
>>                    u8        build_id[20];
>>            };
>>    };
> 
> Alexei/Daniel, this one depends on BPFs build id routines to be exported
> for use by the perf kernel subsys, PeterZ already acked this, so can you
> guys consider getting the first three patches in this series via the bpf
> tree?
> 
> The BPF bits were acked by Song.

All the net-next and therefore also bpf-next bits for 5.11 were just merged
by Linus into his tree. If you need the first 3 from [0] to land for this merge
window, it's probably easiest if you take them in and send them via perf tree
directly in case you didn't send out a pull-req yet.. (alternatively I'll ping
David/Jakub if they plan to make a 2nd net-next pull-req end of this week).

Thanks,
Daniel

  [0] https://lore.kernel.org/lkml/20201214105457.543111-1-jolsa@kernel.org/
