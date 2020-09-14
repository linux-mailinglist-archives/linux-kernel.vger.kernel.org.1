Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54A26911A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgINQJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgINQGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:06:07 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C27C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:06:06 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h4so654667ioe.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=PfHuzhqivozrl0JO/hRWOhEs9TWX1NzmQbkUCZ2/wrY=;
        b=hfpQCazw+U1xfC8KeblOtY/lfxUs2VwXyMcet9skzioOQ96XuO50EeCAXgvaCr5Fw9
         Sffq1pd7ccyutbQpLxE2LspHrGBhqzh8cFLo74TRa464s9dULMTwMLTV2wAkInuENNqI
         7PoCxm5Kg0wY6hYAi3B2nBe6sHY63Oif+0a8X/3sARzdzZQoHSa68NePnxQWSjtFgzef
         Jgcc/5DK0E0hHY8lQRzsx3cN+JRoLRtIf3d73D8Nv31bCBKlaBh7vtctrgCvPlURhXZV
         Ne/EGXSA69G8mH+NBWPuFWmFBIc2ZdgSXZitkKY8giOJbO8rc2+EcCX0gRjCm9jt9ikj
         Q9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=PfHuzhqivozrl0JO/hRWOhEs9TWX1NzmQbkUCZ2/wrY=;
        b=EhxFO+KSTW409eAcgV2R3F8//0ikuaPGCRRg8ypEhj2lZbn9LlxtJqpemLsE4/J9mk
         gLILuzvYqUIjMVWLh9qIEXhfhxpytepthqZCMzhHhk82bOmwHJ1q2xQ16yEVn81oH/mZ
         J9+NdJEjf1ph9X9t3AfQj2QG81xmLeyKUWyqpnhhhXmaD5+W8xFaHpHoX8af9tP4BjcL
         j9R8xaLsh2hMWYM46q0Jhu7yapT1PzNug6kmbtXmYDpa3kq7JF3g5MXQIAeD7nUR3u18
         uCAdexwKtPd162Y/cSqKBcJK1IRcdcr9gU5j7XyPQvR2pPOPPlxwt50TTrFLj0SF5qUE
         vz5A==
X-Gm-Message-State: AOAM533YL1i3I/KxahadTHvyN+2AUViPYIRSeXjibe6MD0BDkP+ZehAJ
        DJqaWu7ECs6fbkwXTL61Ok3OeCNmG05dDw1NrPmGmK0DU8zsVgAL
X-Google-Smtp-Source: ABdhPJx5okYMPnz3YhG1MI5nLSAAQmzPNUI0c7ddHK+cpe5VcJODGIpO2cVMzQoaDXjX388D6z9omrAdc3K9Kve2zHg=
X-Received: by 2002:a05:6638:69d:: with SMTP id i29mr13914076jab.138.1600099565301;
 Mon, 14 Sep 2020 09:06:05 -0700 (PDT)
MIME-Version: 1.0
From:   Jimmy Bhathena <jimmybhathena@gmail.com>
Date:   Mon, 14 Sep 2020 17:05:55 +0100
Message-ID: <CAGic8ecrhb9T+2xWDpa8q-GXEpmWbUpJt+7uPH=8Jcwt6St+pg@mail.gmail.com>
Subject: Inquiry about hung system after a panic - unable to reboot automatically
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux-Kernel Team

I have a unique situation and request some assistance or guidance.

We are running a software solution which is running on Gentoo OS with
kernel version 3.18.34.

One of our customer encounters frequent hang of the VM which is
running in VMWare environment and we do not have any control over the
customer's VMWare infrastructure.

We have enabled kdump with the debug kernel for the customer and I
have set up the same on our local test environment too. The kdump is
configured and required sysctl settings are also set so that the
system would generate a crashdump upon a sysrq trigger to force a
panic.

On my test environment, the exact same settings work just fine and
upon sending a sysrq trigger 'Alt + SysRQ + c' I get a panic
triggered, and system reboots automatically. However, on the
customer's environment it does not reboot after a panic and the system
just remains hung.

I tried to dump a threadlist like 'Alt + SysRQ + t' and that works on
customer setup suggesting that the sysrq is passed to the kernel but
when attempting to crash, it gets hung and does not reboot and hence
we do not get a valid crashdump.

The settings below are identical on my environment and our customer
env and this is an appliance based solution so we are shipping the OS
and our software with it. The only difference being the VMWare
environment which is different in the customer's setup.

$ sysctl -a | egrep 'panic|sysctl'
error: "Invalid argument" reading key "fs.binfmt_misc.register"
fs.xfs.panic_mask = 0
kernel.hung_task_panic = 0
kernel.panic = 0
kernel.panic_on_io_nmi = 0
kernel.panic_on_oops = 1
kernel.panic_on_unrecovered_nmi = 0
kernel.softlockup_panic = 0
kernel.sysctl_writes_strict = 0
kernel.unknown_nmi_panic = 1
error: permission denied on key 'net.ipv4.route.flush'
error: permission denied on key 'net.ipv6.route.flush'
error: permission denied on key 'vm.compact_memory'
vm.panic_on_oom = 0


I have also tried to send a NMI from the VMWare hypervisor and I get
the same thing. Panic and reboot on my test environment but a hung OS
which does not reboot.

So upon reading the kernel documentation for kernel.panic I also set
the value to 10 on customer setup and still no difference. On my test
setup 0 or 10 it gets me a valid crashdump.
https://www.kernel.org/doc/Documentation/sysctl/kernel.txt

So any suggestions or pointers on what could lead to a successful
trigger of the panic but a hung OS and the only option is to reset the
VM from the hypervisor or it just sits there forever. Thus, I am not
able to get a valid crashdump to investigate the original issue on why
our software is having a problem on the customer environment leading
to infrequent hung VM, whereas other VM's on the same host are all
fine and no hardware issues or errors are seen.

Thank you very much!

Regards,

Jimmy
