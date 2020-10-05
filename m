Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 080082841F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 23:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgJEVMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 17:12:32 -0400
Received: from mail.efficios.com ([167.114.26.124]:58384 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJEVMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:12:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C77C8246884;
        Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Hf10uEkEsVOW; Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 76789246799;
        Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 76789246799
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601932350;
        bh=02giAsCeuBcy2HgomFgqE/qs7iqfJn2HocHaXYEj+yw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Lx9QbtBJIdeawpE2S64F/R3v7lGP1yFjUIyMoDBXlLKVMamweMVKUWHC9k+6/JLrR
         Z3gjyMdFq5zj9wvYufnsYI2ACzAyfzB4DLXfl3qo83UL2ZuWHbO9wZEpClFe0SeQs9
         HkVQEJCZax+dNXQMW7T6V4vuFoEQXZNHxhn8507i2OXOBibfTwqNDGF4W6nicVEwPL
         H9DbwC4pCHQrPCsZpvg7G1fdmVmZ5BN+1qGlUdnlDWt4w7jRIElWclcWpVNRVVOiWZ
         Z6NRi3SEbKU74GdymgsiPl0sCgYaL48UFWfNGaNu5SmTiIa0g/ShZFSqhaDHNO1aOW
         AQIEjZQL1RjNg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5mJcgMKitmH8; Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6360824662E;
        Mon,  5 Oct 2020 17:12:30 -0400 (EDT)
Date:   Mon, 5 Oct 2020 17:12:30 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, lwn@lwn.net,
        linux-kernel@vger.kernel.org
Message-ID: <1413973086.8258.1601932350315.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.12.3 and 2.11.6 (Linux kernel tracer)
 (security fix)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Index: vjTqqbv2yEVXycLsMDpnieqt0uH3CA==
Thread-Topic: LTTng-modules 2.12.3 and 2.11.6 (Linux kernel tracer) (security fix)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These releases include a security fix for the LTTng kernel tracer.

This issue was introduced very early in the LTTng modules 2.0 development,
prior to the lttng-modules v2.0.0 release. Therefore all lttng-modules
releases are affected. Users are encouraged to upgrade.

See master branch commit (6f192a1604ec "fix: don't allow userspace copy to read kernel memory")
    
    This patch fixes a security issue which allows the root user to read
    arbitrary kernel memory. Considering the security model used in LTTng
    userspace tooling for kernel tracing, this bug also allows members of
    the 'tracing' group to read arbitrary kernel memory.
    
    Calls to __copy_from_user_inatomic() where wrongly enclosed in
    set_fs(KERNEL_DS) defeating the access_ok() calls and allowing to read
    from kernel memory if a kernel address is provided.
    
    Remove all set_fs() calls around __copy_from_user_inatomic().
    
    As a side effect this will allow us to support v5.10 which should remove
    set_fs().

You will find below details on how to reproduce this issue to check whether
your version of lttng-modules is vulnerable or not.

While reviewing this code, we also noticed that the lttng_strlen_user_inatomic
could theoretically cause a long preemption-off critical section because it is
an unbounded loop. We added an arbitrary 1MB size limit to the size of user
strings to prevent this. It can be found as
master branch commit (eb94dcd91d4e "fix: Add a 1MB limit to lttng_strlen_user_inatomic")

A fix for the system call filter table was introduced, which should speed up
system call tracing when only specific system calls are selected.
master branch commit (badfe9f5c396e "Fix: system call filter table")

Besides this, commits adding support for Linux kernel 5.9, as well as newer Ubuntu
kernels were integrated into the 2.12.3 and 2.11.6 releases.

Finally, a fix for dependency issue when building LTTng-modules within the
Linux kernel tree without CONFIG_FTRACE was integrated.

Security issue (kernel memory disclosure to root user and 'tracing' group)
reproducer:

cat /proc/kallsyms
[...]
ffffffffaa9c3f81 r __kstrtab_sunrpc_cache_update
[...]

Create userspace program 'exploit' issuing:

  open((void*)(uintptr_t)0xffffffffaa9c3f81, 0);

Run lttng-sessiond as root.

Then trace as tracing group user:

lttng create
lttng enable-event -k --syscall 'openat'
lttng add-context -k -t procname
lttng start

Run 'exploit' program as unprivileged user.

lttng stop
lttng view | grep exploit | tail -n 2

In the "Vulnerable" case, the symbol name can be found in the filename field
of the openat event in the trace. With the fix, an empty string is saved in the
filename field instead. Vulnerable case:

[17:02:57.265276947] (+0.000960778) compudjdev syscall_entry_openat: { cpu_id = 22 }, { procname = "exploit" }, { dfd = -100, filename = "sunrpc_cache_update", flags = ( "O_RDONLY" : container = 0 ), mode = ( <unknown> : container = 0 ) }
[17:02:57.265284413] (+0.000007466) compudjdev syscall_exit_openat: { cpu_id = 22 }, { procname = "exploit" }, { ret = -14 }

With fix:

[16:58:51.229342728] (+0.000906591) compudjdev syscall_entry_openat: { cpu_id = 22 }, { procname = "exploit" }, { dfd = -100, filename = "", flags = ( "O_RDONLY" : container = 0 ), mode = ( <unknown> : container = 0 ) }
[16:58:51.229348988] (+0.000006260) compudjdev syscall_exit_openat: { cpu_id = 22 }, { procname = "exploit" }, { ret = -14 }

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
