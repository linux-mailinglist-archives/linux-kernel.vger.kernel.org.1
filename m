Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F122C10DA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390091AbgKWQjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 11:39:33 -0500
Received: from mail.efficios.com ([167.114.26.124]:47994 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgKWQjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:39:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CB7A730F5C0;
        Mon, 23 Nov 2020 11:39:30 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MFd4rh-P0CLq; Mon, 23 Nov 2020 11:39:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 78F9D30F551;
        Mon, 23 Nov 2020 11:39:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 78F9D30F551
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1606149570;
        bh=cNtmvDZIjvgpSa9J3/Je10qGrhJmkgr8CHtqQHP+eH4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gPC7oO6bZhsfuwa9rDIuBrdI2KKNlSJV7rN5Paoy4hy5NyKd8biXBbwLtGGbZFsb1
         AoMm32qeD8UtZewz8/kgAgyf+Rq9PuYiqNXY4XZqBgYNmpAxXDNh8GbR1Qs3n8i+4p
         S2pIMdHPNh9nFjyX93dpd8RRyqj5H/nm1CXawWxnWW0vW7XhmWI24ijeNzGIMMKmFQ
         1834BLArdn8p9JrIrNPQfmdOYrIH6Pyvz4xf3TEWIbjhPR+6g9XxeLvm3djTV1ZcwU
         +ZpfzomaHUXoKTOlN87OwwMdk1mJgVhDlk5fnrm4j0XRMSdlmPIfVxqhCeLU7CpywE
         GdalAsrJKvm7g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Q53cMOEkkagL; Mon, 23 Nov 2020 11:39:30 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6D69230F3E1;
        Mon, 23 Nov 2020 11:39:30 -0500 (EST)
Date:   Mon, 23 Nov 2020 11:39:30 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Philippe Duplessis-Guindon <pduplessis@efficios.com>
Cc:     linux-trace-devel@vger.kernel.org, rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Message-ID: <725176746.55143.1606149570341.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201123161519.4643-1-pduplessis@efficios.com>
References: <20201123161519.4643-1-pduplessis@efficios.com>
Subject: Re: [RFC PATCH] regmap: remove duplicate `type` field from
 `regcache_sync` trace event
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3975 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3975)
Thread-Topic: regmap: remove duplicate `type` field from `regcache_sync` trace event
Thread-Index: 0EJHYgcTX1/RFLA9H2otie83bMQkyQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,

Some additional feedback:

The patch title could be changed to:

"tracing: Remove duplicate `type` field from regmap `regcache_sync` trace event"

to clarify that this belongs to tracing.

----- On Nov 23, 2020, at 11:15 AM, Philippe Duplessis-Guindon pduplessis@efficios.com wrote:

> I had an error saying that `regcache_sync` had 2 fields named `type` while using
> libtraceevent. This was the format of this event:

Please use the present rather than past when writing a commit message.

> 
>	$ sudo cat /sys/kernel/debug/tracing/events/regmap/regcache_sync/format
>	name: regcache_sync
>	ID: 1216
>	format:
>		field:unsigned short common_type;	offset:0;	size:2; signed:0;
>		field:unsigned char common_flags;	offset:2;	size:1; signed:0;
>		field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
>		field:int common_pid;	offset:4;	size:4;	signed:1;
> 
>		field:__data_loc char[] name;	offset:8;	size:4;	signed:1;
>		field:__data_loc char[] status;	offset:12;	size:4;	signed:1;
>		field:__data_loc char[] type;	offset:16;	size:4;	signed:1;
>		field:int type;    offset:20;    size:4;    signed:1;
> 
>	print fmt: "%s type=%s status=%s", __get_str(name), __get_str(type),
>	__get_str(status)
> 
> Erase the `int field` type, who was not assigned. This field was introduce by

who -> which

was introduce -> was introduced

Ideally you should use git blame to identify which commit introduced this issue.
e.g.:

git blame drivers/base/regmap/trace.h
[...]
593600890110c include/trace/events/regmap.h (Dimitris Papastamos 2011-09-19 14:34:04 +0100 134)                 __assign_str(status, status);
593600890110c include/trace/events/regmap.h (Dimitris Papastamos 2011-09-19 14:34:04 +0100 135)                 __assign_str(type, type);

commit 593600890110c02eb471cf844649dee213870416
Author: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Date:   Mon Sep 19 14:34:04 2011 +0100

    regmap: Add the regcache_sync trace event

This information can be added to the commit message as:

Fixes commit 593600890110c ("regmap: Add the regcache_sync trace event")

Thanks,

Mathieu

> mistake and this commit removes it.
> 
> This is the format of this event after the fix:
> 
>	$ sudo cat /sys/kernel/debug/tracing/events/regmap/regcache_sync/format
>	name: regcache_sync
>	ID: 1266
>	format:
>		field:unsigned short common_type;	offset:0;	size:2;	signed:0;
>		field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
>		field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
>		field:int common_pid;	offset:4;	size:4;	signed:1;
> 
>		field:__data_loc char[] name;	offset:8;	size:4;	signed:1;
>		field:__data_loc char[] status;	offset:12;	size:4;	signed:1;
>		field:__data_loc char[] type;	offset:16;	size:4;	signed:1;
> 
>	print fmt: "%s type=%s status=%s", __get_str(name), __get_str(type),
>	__get_str(status)
> 
> Signed-off-by: Philippe Duplessis-Guindon <pduplessis@efficios.com>
> ---
> drivers/base/regmap/trace.h | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
> index d4066fa079ab..9abee14df9ee 100644
> --- a/drivers/base/regmap/trace.h
> +++ b/drivers/base/regmap/trace.h
> @@ -126,7 +126,6 @@ TRACE_EVENT(regcache_sync,
> 		__string(       name,           regmap_name(map)	)
> 		__string(	status,		status			)
> 		__string(	type,		type			)
> -		__field(	int,		type			)
> 	),
> 
> 	TP_fast_assign(
> --
> 2.25.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
