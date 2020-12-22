Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2302E03F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 02:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgLVBmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 20:42:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30994 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgLVBmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 20:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608601248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRRvKU+EXcp4nwVeh9OjdOtZKDLzmxvTspfH8E8JPAA=;
        b=X9Rs6shTNtVpHb5mBI3bBt69B9e8mTbjESO5aLyd8ajG09QLZncexaUl9Q+aNm2u3WcPEd
        2JAT6/QYfd8Q24venZ8201DKaVcBVYXCqXFdbWUib6pjYuZ7yYiKjKngHTHTeOfCtrdqgJ
        3rqJytgy9kToCgrm7MfOeb+XGZcZ8eI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-HmDTTF-2P0OIxqcHUCxYxA-1; Mon, 21 Dec 2020 20:40:44 -0500
X-MC-Unique: HmDTTF-2P0OIxqcHUCxYxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9E39180A089;
        Tue, 22 Dec 2020 01:40:42 +0000 (UTC)
Received: from localhost (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40FD4369A;
        Tue, 22 Dec 2020 01:40:41 +0000 (UTC)
Date:   Tue, 22 Dec 2020 09:40:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [RFC]: kexec: change to handle memory/cpu changes
Message-ID: <20201222014039.GA2237@MiWiFi-R3L-srv>
References: <b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/20 at 10:50am, Eric DeVolder wrote:
...
> The cell contents show the number of seconds it took for the system to
> process all of the 3840 memblocks. The value in parenthesis is the
> number of kdump unload-then-reload operations per second.
> 
>           1 480GB DIMM   480 1GB DIMMs
> -------+-----------------+----------------+
>  RHEL7 | 181s (21.2 ops) | 389s (9.8 ops) |
> -------+-----------------+----------------+
>  RHEL8 |  86s (44.7 ops) | 419s (9.2 ops) |
> -------+-----------------+----------------+
> 
> The scenario of adding 480 1GiB virtual DIMMs takes more time given
> the larger number of round trips of QEMU -> kernel -> udev -> kernel ->
> QEMU, and are both roughly 400s.
> 
> The RHEL7 system process all 3840 memblocks individually and perform
> 3840 kdump unload-then-reload operations.
> 
> However, RHEL8 data in the best case scenario (1 480GiB DIMM) suggests
> that approximately 86/4= 21 kdump unload-then-reload operations
> happened, and in the worst case scenario (480 1GiB DIMMs), the data
> suggests that approximately 419/4 = 105 kdump unload-then-reload
> operations happened. For RHEL8, the final number of kdump
> unload-then-reload operations are 0.5% (21 of 3840) and 2.7% (105 of
> 3840), respectively, compared to that of the RHEL7 system.
> 
> The throttle approach is quite effective in reducing the number of
> kdump unload-then-reload operations. However, the kdump capture kernel
> is still reloaded multiple times, and each kdump capture kernel reload
> is a race window in which kdump can fail.
> 
> A quick peek at Ubuntu 20.04 LTS reveals it has 50-kdump-tools.rules
> that looks like:
> 
>   SUBSYSTEM=="memory", ACTION=="online", PROGRAM="/usr/sbin/kdump-config try-reload"
>   SUBSYSTEM=="memory", ACTION=="offline", PROGRAM="/usr/sbin/kdump-config try-reload"
>   SUBSYSTEM=="cpu", ACTION=="add", PROGRAM="/usr/sbin/kdump-config try-reload"
>   SUBSYSTEM=="cpu", ACTION=="remove", PROGRAM="/usr/sbin/kdump-config try-reload"
>   SUBSYSTEM=="cpu", ACTION=="offline", PROGRAM="/usr/sbin/kdump-config try-reload"
> 
> which produces the equivalent behavior to RHEL7 whereby every event
> results in a kdump capture kernel reload.
> 
> Fedora 33 and CentOS 8-stream behave the same as RHEL8.
> 
> Perhaps a better solution is to rewrite the vmcoreinfo structure that
> contains the memory and CPU layout information, as those changes to
> memory and CPUs occur. Rewriting vmcoreinfo is an in-kernel activity
> and would certainly avoid the relatively large unload-then-reload
> times of the kdump capture kernel. The pointer to the vmcoreinfo
> structure is provided to the capture kernel via the elfcorehdr=
> parameter to the capture kernel cmdline. Rewriting the vmcoreinfo
> structure as well as rewriting the capture kernel cmdline parameter is
> needed to utilize this approach.

Great investigation and conclusion, and very nice idea as below. When I
read the first half of this mail, I thought maybe we could add a new
option to kexec-tools utility for updating eflcorehdr only when hotplug
udev events detected. Then come to this part, I would say yes, doing it
inside kernel looks better. A special handling for hotplug looks
necessary as you have said, I will check what we can do and give back
some details, thanks for doing these.

Thanks
Baoquan

> 
> Based upon some amount of examining code, I think the challenges
> involved in updating the CPU and memory layout in-kernel are:
> 
>  - adding call-outs on the add_memory()/try_remove_memory() and
>    cpu_up()/cpu_down() paths for notifying the kdump subsystem of
>    memory and/or CPU changes.
> 
>  - updating the struct kimage with the memory or CPU changes
> 
>  - Rewriting the vmcoreinfo structure from the data contained
>    in struct kimage, eg crash_prepare_elf64_headers()
> 
>  - Installing the updated vmcoreinfo struct via
>    kimage_crash_copy_vmcoreinfo() and rewriting the kdump kernel
>    cmdline in order to update parameter elfcorehdr= with the
>    new address
> 
> As I am not overly familiar with all the code paths involved, yet, I'm
> sure the devil is in the details. However, due the kexec_file_load
> syscall, it appears most of the infrastructure is already in place,
> and we essentially need to tap into it again for memory and cpu
> changes.
> 
> It appears that this change could be applicable to both kexec_load and
> kexec_file_load, it has the potential to (eventually) simplify the
> userland kexec utility for kexec_load, and would eliminate the need
> for 98-kexec.rules and the associated churn.
> 
> Comments please!
> eric
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

