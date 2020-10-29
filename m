Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD129F004
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgJ2PdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:33:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33658 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgJ2PdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:33:15 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kY9vC-0001LQ-SV; Thu, 29 Oct 2020 15:33:03 +0000
Date:   Thu, 29 Oct 2020 16:33:01 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v5 0/3] time namespace aware system boot time
Message-ID: <20201029153301.aahwxau6ijyol357@wittgenstein>
References: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201027204258.7869-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 09:42:55PM +0100, Michael Weiß wrote:
> Time namespaces make it possible to virtualize time inside of
> containers, e.g., it is feasible to reset the uptime of a container
> to zero by setting the time namespace offset for boottime to the
> negated current value of the CLOCK_BOOTTIME.
> 
> However, the boot time stamp provided by getboottime64() does not
> take care of time namespaces. The resulting boot time stamp 'btime'
> provided by /proc/stat does not show a plausible time stamp inside
> the time namespace of a container.
> 
> We address this by shifting the value returned by getboottime64()
> by subtracting the boottime offset of the time namespace.
> (A selftest to check the expected /proc/stat 'btime' inside the
> namespace is provided.)
> 
> Further, to avoid to show processes as time travelers inside of the
> time namespace the boottime offset then needs to be added to the
> start_boottime provided by the task_struct.
> 
> v5 Changes:
> Added tags, Thanks Andrei and Thomas for reviews and comments.
> Updated commit message of [2/3] as indicated by Thomas.
> 
> v4 Changes:
> Avoid type conversions back and forth between timespec64 and ktime_t
> in 'proc/stat.c' as suggested by Andrei.
> Introduced timens_sub_boottime() in 'time_namespace.h' to provide
> better coder readability/consistency.
> 
> v3 Changes:
> leave getboottime64() unchanged and shift the boot timestamp in
> 'fs/proc/stat.c' as result of the discussion with Andrei and Thomas.
> 
> v2 Changes:
> Fixed compile errors with TIME_NS not set in config

Thank you Michael,

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

As discussed with Thomas, I'm picking this up now!

Thanks!
Christian
