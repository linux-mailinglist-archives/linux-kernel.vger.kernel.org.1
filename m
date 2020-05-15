Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881F91D474E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 09:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEOHpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 03:45:15 -0400
Received: from foss.arm.com ([217.140.110.172]:50554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgEOHpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:45:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68E841042;
        Fri, 15 May 2020 00:45:14 -0700 (PDT)
Received: from nicgas01-03-arm-vm (nicgas01-03-arm-vm.shanghai.arm.com [10.169.138.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDBE23F68F;
        Fri, 15 May 2020 00:45:11 -0700 (PDT)
References: <20200427061520.24905-1-nick.gasson@arm.com>
 <20200427103505.GA1476763@krava> <85lflu7v4o.fsf@arm.com>
 <20200514132337.GM5583@kernel.org>
 <CAP-5=fX-dV+VHaPMO2Sw0DFB72YtuSyc23X5S3EvxGxYhAT4kQ@mail.gmail.com>
User-agent: mu4e 1.4.5; emacs 27.0.91
From:   Nick Gasson <nick.gasson@arm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnaldo Carvalho de Melo" <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 0/3] perf jvmti: Various fixes to JVMTI agent
In-reply-to: <CAP-5=fX-dV+VHaPMO2Sw0DFB72YtuSyc23X5S3EvxGxYhAT4kQ@mail.gmail.com>
Date:   Fri, 15 May 2020 15:45:09 +0800
Message-ID: <858sht3am2.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15/20 06:41 am, Ian Rogers wrote:
>
> If you are looking at this code I believe there is a bug in that the
> loop handling jvmtiCompiledMethodLoadInlineRecord is writing out the
> entire line number table before a pc and not just the line number
> table at the pc. This loop in do_get_line_numbers:
>
> if (loc_tab[i].start_location < bci) {
> tab[lines].pc = (unsigned long)pc;
> tab[lines].line_number = loc_tab[i].line_number;
> tab[lines].discrim = 0; /* not yet used */
> tab[lines].methodID = m;
> lines++;
> } else {
>
> It could possibly make sense if it were iterating over the inline data
> in the jvmtiCompiledMethodLoadInlineRecord rather than the line number
> table.
> Fixing this is toward the end of a list of things I need to look at.
>

OK sure, I'll have a look at this. Thanks for the reviews.

--
Thanks,
Nick
