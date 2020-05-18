Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9B41D73C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgERJTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 05:19:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34843 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbgERJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589793538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wUvuFHtpRP2kms7NhYOoam9/bRncTEMEMk1lIVn22aw=;
        b=Z6lCW/3tJuAsMF7dkkG/GcH0NH/UsY3Lgsgc76UeWRKNX+s/6osuHNZcEkDbCwxHhAH2tI
        oBesYTz5Fy12Dn1MZbIwjf3V1KiYPSbCLvt+sOrQQvqhuDYkqha1/GxNDlnfhypF5pf4Ss
        kv/IdoO2I+/erPnLOhSRUXPS31YBP8A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-RD-5gBVIN1mgqrAtxEwWgQ-1; Mon, 18 May 2020 05:18:57 -0400
X-MC-Unique: RD-5gBVIN1mgqrAtxEwWgQ-1
Received: by mail-wm1-f70.google.com with SMTP id m11so2824427wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=wUvuFHtpRP2kms7NhYOoam9/bRncTEMEMk1lIVn22aw=;
        b=fz8LncxmeYoQBgXkKTlzFkexFidS81Q5uyvXcCiE0+53XyZreKxCXsjIxqfj4+MjG6
         cosr5M8azrn7dTx759yMlQUOCyzI25UbxRsJpofPEo/IrkPVhLJ71ssui3uO+5eua/Hs
         /qXbnxlRHOvYZ33VAr5xAk1i1PdbBiRRlu+qss+3FpB5+G5C1uD0Am36lmRWDSBsp5Um
         eleC7AsmCtFl0tpXFFfDj3W4F7HkC+OMb6Jq9yLRSwwGhLNjRfMnB40Qk0E+Ya+uQZDW
         qZyfkBMbdft1bYtNLYVHGgaHZ7RM5NhkCXpqqVufQ6M1YsE0Pmk8ARvFMRP/O+GFKaBc
         pz0w==
X-Gm-Message-State: AOAM530FGT6qZKHlPPh6e0LhWQ2NjewUbSJ5yMWTufRJuToI3IxihSOf
        AVVq5V8VReMzFxwlZSefg89VL86AwDnD497yK0SI1KZApbL5MLYlyX9i/ANLl8SJHnE4Ax7JhYe
        jdVoYs9Q+0Wy9rc8/AtgCWiuJ
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr19179746wme.154.1589793535934;
        Mon, 18 May 2020 02:18:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwi7pOADLN/te5X0J+pmMiiuSIEST5v0Ejiqlgn996sQFmMXUsyHPVUkRkXSpo0mOyUHs5dug==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr19179715wme.154.1589793535716;
        Mon, 18 May 2020 02:18:55 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z11sm15011531wrr.32.2020.05.18.02.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 02:18:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Anastassios Nanos <ananos@nubificus.co.uk>
Cc:     kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] Expose KVM API to Linux Kernel
In-Reply-To: <CALRTab-mEYtRG4zQbSGoAri+jg8xNL-imODv=MWE330Hkt_t+Q@mail.gmail.com>
References: <cover.1589784221.git.ananos@nubificus.co.uk> <87y2ppy6q0.fsf@nanos.tec.linutronix.de> <CALRTab-mEYtRG4zQbSGoAri+jg8xNL-imODv=MWE330Hkt_t+Q@mail.gmail.com>
Date:   Mon, 18 May 2020 11:18:53 +0200
Message-ID: <87o8qlvbwi.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anastassios Nanos <ananos@nubificus.co.uk> writes:

> Moreover, it doesn't involve *any* mode switch at all while printing
> out the result of the  addition of these two registers -- which I
> guess for a simple use-case like this it isn't much.
> But if we were to scale this to a large number of exits (and their
> respective handling in user-space) that would incur significant
> overhead.

Eliminating frequent exits to userspace when the guest is already
running is absolutely fine but eliminating userspace completely, even
for creation of the guest, is something dubious. To create a simple
guest you need just a dozen of IOCTLs, you'll have to find a really,
really good showcase when it makes a difference. 

E.g. I can imagine the following use-case: you need to create a lot of
guests with the same (or almost the same) memory contents and allocating
and populating this memory in userspace takes time. But even in this
use-case, why do you need to terminate your userspace? Or would it be
possible to create guests from a shared memory? (we may not have
copy-on-write capabilities in KVM currently but this doesn't mean they
can't be added).

Alternatively, you may want to mangle vmexit handling somehow and
exiting to userspace seems slow. Fine, let's add eBPF attach points to
KVM and an API to attach eBPF code there.

I'm, however, just guessing. I understand you may not want to reveal
your original idea for some reason but without us understanding what's
really needed I don't see how the change can be reviewed.

-- 
Vitaly

