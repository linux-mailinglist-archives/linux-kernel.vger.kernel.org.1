Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8422F53B4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbhAMTyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:54:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728519AbhAMTyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610567593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r9SifleMQOfzHiaSXVluBcJxxBWa1F3orhMkaXNevsg=;
        b=TLvIfejwjNEohSPMT9lSbR/FQEJJ7dafaF0N99NIvI9Myv7LKG0Hb+OLYcGs4W6FgJz+Hg
        MganwzcXz9XoFg+fnrKBNVNhItgeTqfhj9fSIkz00wlFeYDYpJ7N87zoM473zi+UaZKpDS
        f3jGp6X8zf36/CsxttLGyo99xcTU9Jg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-S9hFWNQHNT-CBxPFRSIyUQ-1; Wed, 13 Jan 2021 14:53:10 -0500
X-MC-Unique: S9hFWNQHNT-CBxPFRSIyUQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2E931015C8B;
        Wed, 13 Jan 2021 19:53:07 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 29908100AE41;
        Wed, 13 Jan 2021 19:53:03 +0000 (UTC)
Date:   Wed, 13 Jan 2021 13:53:01 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Anand K Mistry <amistry@google.com>
Cc:     x86@kernel.org, asteinhauser@google.com, tglx@linutronix.de,
        bp@alien8.de, joelaf@google.com,
        Anand K Mistry <amistry@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] x86/speculation: Add finer control for when to issue
 IBPB
Message-ID: <20210113195301.tyeeyrf5y7ajd5yw@treble>
References: <20210113194619.RFC.1.I8f559ecdb01ffa98d5a1ee551cb802f288a81a38@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210113194619.RFC.1.I8f559ecdb01ffa98d5a1ee551cb802f288a81a38@changeid>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 07:47:19PM +1100, Anand K Mistry wrote:
> When IB speculation is conditionally disabled for a process (via prctl()
> or seccomp), IBPB is issued whenever that process is switched to/from.
> However, this results more IBPBs than necessary. The goal is to protect
> a victim process from an attacker poisoning the BTB by issuing IBPB in
> the attacker->victim switch. However, the current logic will also issue
> IBPB in the victim->attacker switch, because there's no notion of
> whether the attacker or victim has IB speculation disabled.
> 
> Instead of always issuing IBPB when either the previous or next process
> has IB speculation disabled, add a boot flag to explicitly choose
> to issue IBPB when the IB spec disabled process is entered or left.
> 
> Signed-off-by: Anand K Mistry <amistry@google.com>
> Signed-off-by: Anand K Mistry <amistry@chromium.org>
> ---
> Background:
> IBPB is slow on some CPUs.
> 
> More detailed background:
> On some CPUs, issuing an IBPB can cause the address space switch to be
> 10x more expensive (yes, 10x, not 10%). On a system that makes heavy use
> of processes, this can cause a very significant performance hit.
> Although we can choose which processes will pay the IBPB
> cost by using prctl(), the performance hit is often still too high
> because IBPB is being issued more often than necessary.
> 
> This proposal attempts to reduce that cost by letting the system
> developer choose whether to issue the IBPB on entry or exit of an IB
> speculation disabled process (default is both, which is current
> behaviour). Documentation/admin-guide/hw-vuln/spectre.rst documents two
> mitigation strategies that use conditional IBPB;
> "Protect sensitive programs", and "Sandbox untrusted programs".

Why make the setting system-wide?  Shouldn't this decision be made on a
per-task basis, depending on whether the task is sensitive or untrusted?

-- 
Josh

