Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C082889A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388284AbgJINVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:21:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59831 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgJINVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:21:34 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kQsKw-0005qq-I7; Fri, 09 Oct 2020 13:21:30 +0000
Date:   Fri, 9 Oct 2020 15:21:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 0/4] time namespace aware system boot time
Message-ID: <20201009132129.3vzdgzyy7gloou6v@wittgenstein>
References: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201008053944.32718-1-michael.weiss@aisec.fraunhofer.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 07:39:40AM +0200, Michael Weiß wrote:
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
> start_bootime provided by the task_struct.
> 
> v2 Changes:
> Fixed compile errors with TIME_NS not set in config
> Reported-by: kernel test robot <lkp@intel.com>

Hey Michael,

Thanks for the patches. This looks like a good idea to me. Since
/proc/uptime is now virtualized according to the timens the caller is in
btime has to be virtualized too.

Christian
