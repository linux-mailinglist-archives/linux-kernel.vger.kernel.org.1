Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4DC2D4C80
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgLIVH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:07:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49438 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387880AbgLIVHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:07:54 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607548032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L7i3CPNAPt2KU+IZb9dhE7iSR6cyuRM8HyieTAr/YYg=;
        b=kq1OHmCQNTXmjFxRiiYQCtMcgHsW2nl9XwXEhd2UDC34JY4VqsuqNqWdgTS3YK0B2HTN0a
        GLiGRqcl4feIgRGti60S5LHayQAwiZFaJ2AcyKwnEyQbepXQ2jz8X8vNbxqDaot95wevaf
        Lz67AUgT8+6fwzbCvE7SbExB3ThHr/fHr+UAilkliO85KAQIMK7eww5bH7SAetpnob4Kqc
        q6ySWnueDo4tqYCw7qzFmoI9zbcSv58CxsWPgdnODOP/uZ4j59J5/wPRhcDpcZpcic0r+V
        wcfFMs/wLf2fAEfHBp8cin02bVRhQTrk424mMLHkmAmUY5hzxKqvWbPQgnwCnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607548032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L7i3CPNAPt2KU+IZb9dhE7iSR6cyuRM8HyieTAr/YYg=;
        b=htO3ZaH9N+kRa526lyS/ICS9mPFUq9txIKXd3dIhl9PtBy0srICRWtTNhIRq5W11XlRqAu
        yEM17S/seRxu7uBg==
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     peterz@infradead.org, luto@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware\, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 03/12] x86/pv: switch SWAPGS to ALTERNATIVE
In-Reply-To: <20201120114630.13552-4-jgross@suse.com>
References: <20201120114630.13552-1-jgross@suse.com> <20201120114630.13552-4-jgross@suse.com>
Date:   Wed, 09 Dec 2020 22:07:12 +0100
Message-ID: <871rfylmdb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20 2020 at 12:46, Juergen Gross wrote:
> SWAPGS is used only for interrupts coming from user mode or for
> returning to user mode. So there is no reason to use the PARAVIRT
> framework, as it can easily be replaced by an ALTERNATIVE depending
> on X86_FEATURE_XENPV.
>
> There are several instances using the PV-aware SWAPGS macro in paths
> which are never executed in a Xen PV guest. Replace those with the
> plain swapgs instruction. For SWAPGS_UNSAFE_STACK the same applies.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
