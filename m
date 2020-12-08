Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7DC2D285E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgLHKCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:02:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgLHKCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:02:21 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8F9217A0;
        Tue,  8 Dec 2020 10:01:40 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kmZoQ-00H3In-Bb; Tue, 08 Dec 2020 10:01:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Dec 2020 10:01:38 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Haibo Xu <haibo.xu@linaro.org>
Cc:     Steven Price <steven.price@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
In-Reply-To: <CAJc+Z1FRJR5LHw-xZvPpeYF6+v+ZOcLt99X41xOMAbFmB2DJ2A@mail.gmail.com>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
 <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
 <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAJc+Z1FRJR5LHw-xZvPpeYF6+v+ZOcLt99X41xOMAbFmB2DJ2A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b77efceaec433dd98fdf2cd535a9cf40@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: haibo.xu@linaro.org, steven.price@arm.com, drjones@redhat.com, catalin.marinas@arm.com, quintela@redhat.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, dgilbert@redhat.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, will@kernel.org, Dave.Martin@arm.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-08 09:51, Haibo Xu wrote:
> On Mon, 7 Dec 2020 at 22:48, Steven Price <steven.price@arm.com> wrote:
>> 

[...]

>> Sounds like you are making good progress - thanks for the update. Have
>> you thought about how the PROT_MTE mappings might work if QEMU itself
>> were to use MTE? My worry is that we end up with MTE in a guest
>> preventing QEMU from using MTE itself (because of the PROT_MTE
>> mappings). I'm hoping QEMU can wrap its use of guest memory in a
>> sequence which disables tag checking (something similar will be needed
>> for the "protected VM" use case anyway), but this isn't something I've
>> looked into.
> 
> As far as I can see, to map all the guest memory with PROT_MTE in VMM
> is a little weird, and lots of APIs have to be changed to include this 
> flag.
> IMHO, it would be better if the KVM can provide new APIs to load/store 
> the
> guest memory tag which may make it easier to enable the Qemu migration
> support.

On what granularity? To what storage? How do you plan to synchronise 
this
with the dirty-log interface?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
