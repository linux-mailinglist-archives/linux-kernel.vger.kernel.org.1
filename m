Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAF82ED70D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 19:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbhAGS6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 13:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728302AbhAGS6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:58:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDCA123406;
        Thu,  7 Jan 2021 18:57:38 +0000 (UTC)
Date:   Thu, 7 Jan 2021 13:57:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] x86/mce: Add ppin and microcode to mce trace
Message-ID: <20210107135737.6fbba082@gandalf.local.home>
In-Reply-To: <20210107171225.21903-1-tony.luck@intel.com>
References: <20210107171225.21903-1-tony.luck@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Jan 2021 09:12:25 -0800
Tony Luck <tony.luck@intel.com> wrote:

> Steven,

Hi Tony,

> 
> I've been remiss about updating the mce_record trace as new fields
> have been added to "struct mce". What are the ABI implications of a
> patch like the one below (sample only ... there are a couple more fields
> that may need to be added)?
> 
> Are there any size limitations that I might hit adding more items to
> this record?

Nope, this should be all fine. I know that rasdaemon uses libtraceevent
(actually a copy, but should now start checking if its installed on the
system and use the shared one), and that is used to parse the binary data.

> 
> Thanks
> 
> -Tony
> 
> ---
>  include/trace/events/mce.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
> index 1391ada0da3b..cf0e8b9920b7 100644
> --- a/include/trace/events/mce.h
> +++ b/include/trace/events/mce.h
> @@ -33,6 +33,8 @@ TRACE_EVENT(mce_record,
>  		__field(	u8,		cs		)
>  		__field(	u8,		bank		)
>  		__field(	u8,		cpuvendor	)
> +		__field(	u64,		ppin		)
> +		__field(	u32,		microcode	)
>  	),

 # trace-cmd list -e mce_record -F
system: mce
name: mce_record
ID: 105
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:u64 mcgcap;	offset:8;	size:8;	signed:0;
	field:u64 mcgstatus;	offset:16;	size:8;	signed:0;
	field:u64 status;	offset:24;	size:8;	signed:0;
	field:u64 addr;	offset:32;	size:8;	signed:0;
	field:u64 misc;	offset:40;	size:8;	signed:0;
	field:u64 synd;	offset:48;	size:8;	signed:0;
	field:u64 ipid;	offset:56;	size:8;	signed:0;
	field:u64 ip;	offset:64;	size:8;	signed:0;
	field:u64 tsc;	offset:72;	size:8;	signed:0;
	field:u64 walltime;	offset:80;	size:8;	signed:0;
	field:u32 cpu;	offset:88;	size:4;	signed:0;
	field:u32 cpuid;	offset:92;	size:4;	signed:0;
	field:u32 apicid;	offset:96;	size:4;	signed:0;
	field:u32 socketid;	offset:100;	size:4;	signed:0;
	field:u8 cs;	offset:104;	size:1;	signed:0;
	field:u8 bank;	offset:105;	size:1;	signed:0;
	field:u8 cpuvendor;	offset:106;	size:1;	signed:0;

The event looks to be currently 108 bytes (rounds up to the nearest 4
alignment). The sub buffer size (max event size) is 4080 bytes.

Does this help?

-- Steve



>  
>  	TP_fast_assign(
> @@ -53,9 +55,11 @@ TRACE_EVENT(mce_record,
>  		__entry->cs		= m->cs;
>  		__entry->bank		= m->bank;
>  		__entry->cpuvendor	= m->cpuvendor;
> +		__entry->ppin		= m->ppin;
> +		__entry->microcode	= m->microcode;
>  	),
>  
> -	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
> +	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, PPIN: %llx, MICROCODE: %x",
>  		__entry->cpu,
>  		__entry->mcgcap, __entry->mcgstatus,
>  		__entry->bank, __entry->status,
> @@ -66,7 +70,7 @@ TRACE_EVENT(mce_record,
>  		__entry->cpuvendor, __entry->cpuid,
>  		__entry->walltime,
>  		__entry->socketid,
> -		__entry->apicid)
> +		__entry->apicid, __entry->ppin, __entry->microcode)
>  );
>  
>  #endif /* _TRACE_MCE_H */

