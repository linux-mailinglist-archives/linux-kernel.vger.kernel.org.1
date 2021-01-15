Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80402F7D09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732507AbhAONqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbhAONqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:46:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8CBF423370;
        Fri, 15 Jan 2021 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610718355;
        bh=ZdRtthMW7ijR/zuyWuxPrJJBCybYnyfzAS3LSCbVKdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZWz4240R3FrkR2Dv1555wL1sF+vbcrKAEIQcxaqTRMNrNnCrKEGg8jsg74cxl3BC
         XOGh0S9dRHp0Bc+gMLMgzVVKT9TvNCTeozO6m7Oi/+EEFmgFCFSdXxrDNhicJz+CN2
         uL8Cl1ea7keO34K3DagW7/Gf/pye0BoFHvZ0L3VQ=
Date:   Fri, 15 Jan 2021 14:45:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andreyknvl@google.com, dvyukov@google.com, mingo@redhat.com,
        elver@google.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/5] docs: ABI: add /sys/kernel/error_report/
 documentation
Message-ID: <YAGckOeJxqCcHKa+@kroah.com>
References: <20210115130336.2520663-1-glider@google.com>
 <20210115130336.2520663-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115130336.2520663-4-glider@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 02:03:34PM +0100, Alexander Potapenko wrote:
> Add ABI documentation for files in /sys/kernel/error_report/
> 
> Requested-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  .../ABI/testing/sysfs-kernel-error_report     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-kernel-error_report
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-error_report b/Documentation/ABI/testing/sysfs-kernel-error_report
> new file mode 100644
> index 000000000000..666d039f93a9
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-kernel-error_report
> @@ -0,0 +1,41 @@
> +What:		/sys/kernel/error_report/
> +Date:		January 2021
> +Contact:	Alexander Potapenko <glider@google.com>,
> +		Marco Elver <elver@google.com>
> +Description:
> +		/sys/kernel/error_report/ contains two files: "report_count"
> +		and "last_report". These files are used to notify userspace
> +		about error reports from the enrolled kernel subsystems (those
> +		that use error_report_start/error_report_end tracepoints).
> +
> +		"report_count" contains the current number of reported errors.
> +		This number is incremented every time the error_report_end
> +		trace event occurs in the kernel.
> +
> +		"last_report" contains the most recent error report; concurrent
> +		report generation results in collection of any one report
> +		("last_report" may not be the last shown on the console).
> +		A "report" is everything the task had printed to the console
> +		between issuing the error_report_start and error_report_end
> +		trace events.
> +
> +		Due to sysfs limitations, the report size is truncated at
> +		PAGE_SIZE. To save space, the leading info in square brackets
> +		printed by CONFIG_PRINTK_TIME and CONFIG_PRINTK_CALLER is
> +		trimmed from the output lines.
> +
> +		Both files use sysfs_notify() to notify userspace about
> +		changes. Userspace programs can use poll() to block until an
> +		error is reported:
> +
> +			pfd.fd = fd;
> +			pfd.events = POLLPRI;
> +			while (1) {
> +				lseek(pfd.fd, 0, SEEK_SET);
> +				poll(&pfd, 1, -1);
> +				read(pfd.fd, buffer, PAGE_SIZE);
> +				/* Process the report in @buffer. */
> +			}
> +
> +		Files in /sys/kernel/error_report/ are available when
> +		CONFIG_ERROR_REPORT_NOTIFY is enabled.

sysfs is "one value per file", please put something like this in
tracefs, as there is no such rules there.  Or debugfs, but please, not
sysfs.

Also, any reason you didn't cc: the sysfs maintainers?

thanks,

greg k-h
