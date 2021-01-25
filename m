Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA623036AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbhAZGho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbhAYOcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:32:13 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6BE23121;
        Mon, 25 Jan 2021 14:28:49 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l42rH-009tNN-FP; Mon, 25 Jan 2021 14:28:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 25 Jan 2021 14:28:47 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v5 18/21] arm64: Move "nokaslr" over to the early
 cpufeature infrastructure
In-Reply-To: <CAMj1kXGTu8AtMnm7NxB8M2xFuXHSKzAx2hjjeaAW2v-usvavVQ@mail.gmail.com>
References: <20210125105019.2946057-1-maz@kernel.org>
 <20210125105019.2946057-19-maz@kernel.org>
 <CAMj1kXFcc+0At5+9Keo1MF=TeGE9-eOHtSpK7yVy5jzwXt6KCA@mail.gmail.com>
 <3a98ff1db79c90c96038b924eb534643@kernel.org>
 <CAMj1kXGTu8AtMnm7NxB8M2xFuXHSKzAx2hjjeaAW2v-usvavVQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <32b49beb87b25303d71fd2f7053c7959@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-25 14:19, Ard Biesheuvel wrote:
> On Mon, 25 Jan 2021 at 14:54, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On 2021-01-25 12:54, Ard Biesheuvel wrote:

[...]

>> > This struct now takes up
>> > - ~100 bytes for the characters themselves (which btw are not emitted
>> > into __initdata or __initconst)
>> > - 6x8 bytes for the char pointers
>> > - 6x24 bytes for the RELA relocations that annotate these pointers as
>> > quantities that need to be relocated at boot (on a kernel built with
>> > KASLR)
>> >
>> > I know it's only a drop in the ocean, but in this case, where the
>> > struct is statically declared and defined only once, and in the same
>> > place, we could easily turn this into
>> >
>> > static const struct {
>> >    char alias[24];
>> >    char param[20];
>> > };
>> >
>> > and get rid of all the overhead. The only slightly annoying thing is
>> > that the array sizes need to be kept in sync with the largest instance
>> > appearing in the array, but this is easy when the struct type is
>> > declared in the same place where its only instance is defined.
>> 
>> Fair enough. I personally find the result butt-ugly, but I agree
>> that it certainly saves some memory. Does the following work for
>> you? I can even give symbolic names to the various constants (how
>> generous of me! ;-).
>> 
> 
> To be honest, I was anticipating more of a discussion, but this looks
> reasonable to me.

It looked like a reasonable ask: all the strings are completely useless
once the kernel has booted, and I'm the first to moan that I can't boot
an arm64 kernel with less than 60MB of RAM (OK, it's a pretty bloated
kernel...).

> Does 'char    feature[80];' really need 80 bytes though?

It really needs 75 bytes, because of this:

	{ "arm64.nopauth",
	  "id_aa64isar1.gpi=0 id_aa64isar1.gpa=0 "
	  "id_aa64isar1.api=0 id_aa64isar1.apa=0"	   },

80 is a round enough number.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
