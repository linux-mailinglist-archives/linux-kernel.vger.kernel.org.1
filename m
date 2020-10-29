Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB229DDB4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbgJ2AkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:40:07 -0400
Received: from mail-1.ca.inter.net ([208.85.220.69]:50070 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbgJ2AkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:40:05 -0400
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 760B92EA1CB;
        Wed, 28 Oct 2020 20:40:03 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id PDst0xYkhw-y; Wed, 28 Oct 2020 20:31:57 -0400 (EDT)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id DC9F32EA00E;
        Wed, 28 Oct 2020 20:40:02 -0400 (EDT)
Reply-To: dgilbert@interlog.com
To:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Douglas Gilbert <dgilbert@interlog.com>
Subject: tools/perf: noise from check-headers.sh
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Message-ID: <849974e5-e8b8-d885-e993-a373d9c675bd@interlog.com>
Date:   Wed, 28 Oct 2020 20:40:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Executing that script in linux-stable [lk 5.10.0-rc1] gives the following
output:

Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from 
latest version at 'include/uapi/drm/i915_drm.h'
diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/fscrypt.h' differs from 
latest version at 'include/uapi/linux/fscrypt.h'
diff -u tools/include/uapi/linux/fscrypt.h include/uapi/linux/fscrypt.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from 
latest version at 'include/uapi/linux/kvm.h'
diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/mount.h' differs from 
latest version at 'include/uapi/linux/mount.h'
diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/perf_event.h' differs 
from latest version at 'include/uapi/linux/perf_event.h'
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/prctl.h' differs from 
latest version at 'include/uapi/linux/prctl.h'
diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' 
differs from latest version at 'arch/x86/include/asm/disabled-features.h'
diff -u tools/arch/x86/include/asm/disabled-features.h 
arch/x86/include/asm/disabled-features.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' 
differs from latest version at 'arch/x86/include/asm/required-features.h'
diff -u tools/arch/x86/include/asm/required-features.h 
arch/x86/include/asm/required-features.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs 
from latest version at 'arch/x86/include/asm/cpufeatures.h'
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs 
from latest version at 'arch/x86/include/asm/msr-index.h'
diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/kvm.h' differs 
from latest version at 'arch/x86/include/uapi/asm/kvm.h'
diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
Warning: Kernel ABI header at 'tools/arch/x86/include/uapi/asm/svm.h' differs 
from latest version at 'arch/x86/include/uapi/asm/svm.h'
diff -u tools/arch/x86/include/uapi/asm/svm.h arch/x86/include/uapi/asm/svm.h
Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/sie.h' differs 
from latest version at 'arch/s390/include/uapi/asm/sie.h'
diff -u tools/arch/s390/include/uapi/asm/sie.h arch/s390/include/uapi/asm/sie.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs 
from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs 
from latest version at 'include/uapi/asm-generic/unistd.h'
diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
Warning: Kernel ABI header at 'tools/include/uapi/linux/mman.h' differs from 
latest version at 'include/uapi/linux/mman.h'
diff -u tools/include/uapi/linux/mman.h include/uapi/linux/mman.h
Warning: Kernel ABI header at 
'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version 
at 'arch/x86/entry/syscalls/syscall_64.tbl'
diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl 
arch/x86/entry/syscalls/syscall_64.tbl
Warning: Kernel ABI header at 'tools/perf/util/hashmap.h' differs from latest 
version at 'tools/lib/bpf/hashmap.h'
diff -u tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
Warning: Kernel ABI header at 'tools/perf/util/hashmap.c' differs from latest 
version at 'tools/lib/bpf/hashmap.c'
diff -u tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c


There was a bit of noise in lk 5.9.0-rc1 but it is considerably worse now.

Doug Gilbert
