Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B817A2B5ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 13:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgKQMEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 07:04:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45449 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgKQMEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 07:04:47 -0500
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1kezj2-0003C6-Jk
        for linux-kernel@vger.kernel.org; Tue, 17 Nov 2020 12:04:44 +0000
Received: by mail-ed1-f70.google.com with SMTP id l12so9530576edw.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 04:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVhaLNmBtuqnmi4tGMJBvp0RPN7vCBWkGFN0wZbfqIU=;
        b=mbYn/S7r2k4X1/z6EIdCvnSnMPijzE7XKNlRRqhbY1r6+92kZaA/GPHdaz5ti072r0
         cn1SVkRQxvV5CnlBO2jcR2YvjfUn7iYyMwR2nTkbQ3tJhkshsjFk7BVNTBbg8Ir1sWqL
         kz664PliYoi9mJz3Mb4J8J2R9n5oJGIik2QkoKKc2wSRFYm7MvNF87UbzJeWClj8s/p0
         KRYVh5wWgfMlGvvrV2F/YANEDlu7XPS0O3DRvHZOHhX+3Q6Lqsw1LdBmNhZlC/Q8f90M
         i3QIMWqz6FRgnASD3N+DxHsgXdvhX25Fj2JSWdFi8/4NpPbzaDcwjZo1WnrNXJ91Am5/
         jJZQ==
X-Gm-Message-State: AOAM533bnidDZTm+zwCQrDkKcZRyj7zp+vwkH61uqarHkhASmXhEnbjt
        A5B34/zhZHzXwPMlDQIjP6EfYLtWcQPNkh0ujV3Czhp8azZUniM+4x/Qq9foBGXd6EemNiW6v9W
        eQDCSNoVNXiieRGfTQlx5rCGbWDnPw+FRMhzV2lyYmTkBv8+txNeh6QUFdw==
X-Received: by 2002:a17:906:fcdb:: with SMTP id qx27mr19442471ejb.470.1605614684124;
        Tue, 17 Nov 2020 04:04:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNjl3vH5wIqmDtDTI5xUTL95hPqz+4DoXqLbqHyC7et+hNdTOMMEjmG2P9V+/rCvbOS8n8iZnmmiiRjQEp+Us=
X-Received: by 2002:a17:906:fcdb:: with SMTP id qx27mr19442435ejb.470.1605614683864;
 Tue, 17 Nov 2020 04:04:43 -0800 (PST)
MIME-Version: 1.0
References: <20201117001907.GA1342260@bjorn-Precision-5520> <87h7poeqqn.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7poeqqn.fsf@x220.int.ebiederm.org>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 17 Nov 2020 09:04:07 -0300
Message-ID: <CAHD1Q_zS9Hs8mUsm=q0Ei0kQ+y+wQhkroD+M2eCPKo2xLO6hBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     lukas@wunner.de, linux-pci@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>, andi@firstfloor.org,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, Sinan Kaya <okaya@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Dave Young <dyoung@redhat.com>,
        Gavin Guo <gavin.guo@canonical.com>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Streetman <ddstreet@canonical.com>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:07 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> [...]
> > I think we need to disable MSIs in the crashing kernel before the
> > kexec.  It adds a little more code in the crash_kexec() path, but it
> > seems like a worthwhile tradeoff.
>
> Disabling MSIs in the b0rken kernel is not possible.
>
> Walking the device tree or even a significant subset of it hugely
> decreases the chances that we will run into something that is incorrect
> in the known broken kernel.  I expect the code to do that would double
> or triple the amount of code that must be executed in the known broken
> kernel.  The last time something like that happened (switching from xchg
> to ordinary locks) we had cases that stopped working.  Walking all of
> the pci devices in the system is much more invasive.
>

I think we could try to decouple this problem in 2, if that makes
sense. Bjorn/others can jump in and correct me if I'm wrong. So, the
problem is to walk a PCI topology tree, identify every device and
disable MSI(/INTx maybe) in them, and the big deal with doing that in
the broken kernel before the kexec is that this task is complex due to
the tree walk, mainly. But what if we keep a table (a simple 2-D
array) with the address and data to be written to disable the MSIs,
and before the kexec we could have a parameter enabling a function
that just goes through this array and performs the writes?

The table itself would be constructed by the PCI core (and updated in
the hotplug path), when device discovery is happening. This table
would live in a protected area in memory, with no write/execute
access, this way if the kernel itself tries to corrupt that, we get a
fault (yeah, I know DMAs can corrupt anywhere, but IOMMU could protect
against that). If the parameter "kdump_clear_msi" is passed in the
cmdline of the regular kernel, for example, then the function walks
this simple table and performs the devices' writes before the kexec...

If that's not possible or a bad idea for any reason, I still think the
early_quirks() idea hereby proposed is not something we should
discard, because it'll help a lot of users even with its limitations
(in our case it worked very well).
Also, taking here the opportunity to clarify my understanding about
the limitations of that approach: Bjorn, in our reproducer machine we
had 3 parents in the PCI tree (as per lspci -t), 0000:00, 0000:ff and
0000:80 - are those all under "segment 0" as per your verbiage? In our
case the troublemaker was under 0000:80, and the early_quirks() shut
the device up successfully.

Thanks,


Guilherme
