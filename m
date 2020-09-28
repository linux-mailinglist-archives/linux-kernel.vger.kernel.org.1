Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBD327AB83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgI1KIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726513AbgI1KIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:08:16 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601287695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W60elhwFQ/C09jwxL9Ojpt8vM3WLlrkiR3zgT2uDTZI=;
        b=ew90q6kPTHGfu7FIm16Hl/pdImiu83iNbctEDik+gib5A3nJ1g7bQYEZQjId2RnpOwns5C
        kKdOhjZsxODs5sxZfyNU0wHmVDAYVaAkBOEQNII0jTtZxPikcP+bJHQxcoPbCWMLBM248c
        8QVoDffw0Uik/77Tf8nM5BMp10ch93w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-PWUQpWqxMQKp6RT7EgfBQA-1; Mon, 28 Sep 2020 06:08:11 -0400
X-MC-Unique: PWUQpWqxMQKp6RT7EgfBQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 895A3801AC4;
        Mon, 28 Sep 2020 10:08:10 +0000 (UTC)
Received: from krava (unknown [10.40.193.42])
        by smtp.corp.redhat.com (Postfix) with SMTP id 389A37EB74;
        Mon, 28 Sep 2020 10:08:08 +0000 (UTC)
Date:   Mon, 28 Sep 2020 12:08:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Hagen Paul Pfeifer <hagen@jauu.net>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: perf script, libperf: python binding bug (bytearrays vs. strings)
Message-ID: <20200928100808.GA3517742@krava>
References: <20200927074312.GA3664097@laniakea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927074312.GA3664097@laniakea>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 09:43:12AM +0200, Hagen Paul Pfeifer wrote:
> Hallo Jiri, Arnaldo,
> 
> after updating Debian (probably with the advent of Python 3.8.5, guessing)
> I get a wired behavior with python scripting. The error is that the python type
> for prev_comm and next_comm are not strings anymore, rather bytearrays. Which
> are incompatible types and scripts will not work anymore. NOTE: common_comm is
> still fine (see swapper & mutex-thread-co), so they must be treated internal
> differently compared to prev_comm and next_comm and possibly show a way to solve
> this problem!
> 
> After bisecting the kernel (perf) even back to v5.6 the problem still exist.
> Compiling perf with PYTHON=python2 do not show any problems - no problems in
> the Python2 world. So I assume with Python 3.8.5 (or other helper library)
> something changed internally. I assume the cause exists in perf forever but
> is now triggered with the new Python3 version.
> 
> How to reproduce:
> 
> make PYTHON=python3
> ./perf record -e sched:sched_switch -a -- sleep 5
> ./perf script --gen-script py
> ./perf script -s ./perf-script.py
> 
> [..]
> sched__sched_switch      7 563231.759525792        0 swapper              prev_comm=bytearray(b'swapper/7\x00\x00\x00\x00\x00\x00\x00'), prev_pid=0, prev_prio=120, prev_state=, next_comm=bytearray(b'mutex-thread-co\x00'), next_pid=3447985, next_prio=120
> Sample: {addr=0, cpu=7, datasrc=84410401, datasrc_decode=N/A|SNP N/A|TLB N/A|LCK N/A, ip=18446744072189289569, period=1, phys_addr=0, pid=0, tid=0, time=563231759525792, transaction=0, values=[(0, 0)], weight=0}
> 
> sched__sched_switch      7 563231.759582596  3447985 mutex-thread-co      prev_comm=bytearray(b'mutex-thread-co\x00'), prev_pid=3447985, prev_prio=120, prev_state=, next_comm=bytearray(b'swapper/7\x00\x00\x00\x00\x00\x00\x00'), next_pid=0, next_prio=120
> Sample: {addr=0, cpu=7, datasrc=84410401, datasrc_decode=N/A|SNP N/A|TLB N/A|LCK N/A, ip=18446744072189289569, period=1, phys_addr=0, pid=3447983, tid=3447985, time=563231759582596, transaction=0, values=[(0, 0)], weight=0}
> 
> 
> See =bytearray(b'swapper/7\x00\x00\x00\x00\x00\x00\x00') - should be swapper/7
> 
> 
> Note: the byte array has the length of 16 - exactly like the kernel
> (TASK_COMM_LEN). I assume this is somehow copied directly into the variables
> and not stringified anymore.
> 
> 
> Even worse: I discovered bytearrays which are not correctly "memseted":
> 	bytearray(b'chrome\x00sandbox\x00\x00')
> 
> chrome should be the comm name, but is 'chromesandbox' somehow. See the null
> bytes in between.
> 
> Jiri, Arnaldo - I tried to fix this. But the Python binding magic for the
> automatically generated events are hard to get comfy.
> 
> Hagen
> 
> PS: assume this fix is also kernel stable relevant.
> 

patch below fixes it for me, but seems strange this was
working till now.. maybe you're the only one using this
with python3 ;-)

jirka


---
diff --git a/tools/perf/util/print_binary.c b/tools/perf/util/print_binary.c
index 599a1543871d..13fdc51c61d9 100644
--- a/tools/perf/util/print_binary.c
+++ b/tools/perf/util/print_binary.c
@@ -50,7 +50,7 @@ int is_printable_array(char *p, unsigned int len)
 
 	len--;
 
-	for (i = 0; i < len; i++) {
+	for (i = 0; i < len && p[i]; i++) {
 		if (!isprint(p[i]) && !isspace(p[i]))
 			return 0;
 	}

