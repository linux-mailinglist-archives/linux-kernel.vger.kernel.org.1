Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDC1F51F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 12:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgFJKMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 06:12:17 -0400
Received: from ozlabs.org ([203.11.71.1]:43337 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgFJKMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:12:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49hjTT2Stlz9sRh;
        Wed, 10 Jun 2020 20:12:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1591783933;
        bh=6MdS/FrXRihHOHwCWI3wY0oUCxFXp63aKB1vDbSR0HQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rexwtAZxOGeqWScfyZVmEUfI+g1Pta9Fi1LU2fxYj0/NLfSptLzbKLFT6s+H8Kcfe
         VSl8NcsAiM1nX+QCxl7kWEQWa0IUo47fzZOfgbR1D9aQOHdi7VV4MyvCEX1LIEPQK7
         4cazo84S9CwcRIF4f7FFY89q36VoOE0v7+4SeKPg+r+RoWjSJhmgY5ZawCKzlCghfu
         uh9/OXVHVzF9/TX9Gp+gXE7LVCJs1o9l0Njquu5UmQMVu6BobO6peK5kWIvyynd0le
         Wo06N0NgINf2RyO2Tvt/bWgxgWcmIP2W8FGb9282mp2kAGKICMj+mcFg0NGvetSAel
         90lpGQzaLuTFQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@infradead.org>,
        Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kprobes: Use probe_address() to read instructions
In-Reply-To: <20200609055320.GA14237@infradead.org>
References: <7f24b5961a6839ff01df792816807f74ff236bf6.1582567319.git.christophe.leroy@c-s.fr> <159168034650.1381411.840854749818290996.b4-ty@ellerman.id.au> <20200609055320.GA14237@infradead.org>
Date:   Wed, 10 Jun 2020 20:12:39 +1000
Message-ID: <87r1unfcvc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> On Tue, Jun 09, 2020 at 03:28:38PM +1000, Michael Ellerman wrote:
>> On Mon, 24 Feb 2020 18:02:10 +0000 (UTC), Christophe Leroy wrote:
>> > In order to avoid Oopses, use probe_address() to read the
>> > instruction at the address where the trap happened.
>> 
>> Applied to powerpc/next.
>> 
>> [1/1] powerpc/kprobes: Use probe_address() to read instructions
>>       https://git.kernel.org/powerpc/c/9ed5df69b79a22b40b20bc2132ba2495708b19c4
>
> probe_addresss has been renamed to get_kernel_nofault in the -mm
> queue that Andrew sent off to Linus last night.

That commit above is actually already in mainline, I was just _really_
behind on sending the patch notifications.

cheers
