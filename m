Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D26E2F1E67
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390611AbhAKTAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:00:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38498 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390544AbhAKTAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:00:33 -0500
Received: from zn.tnic (p200300ec2f088f00ad31e6206ee73146.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8f00:ad31:e620:6ee7:3146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C517E1EC0489;
        Mon, 11 Jan 2021 19:59:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610391591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=us7qoCe/w1eJbMrY+78t0RsUed+Wq5UHTnhMqMv8qX8=;
        b=YhAMoTw9HgJRbsz574dOfG7QEqtr9XT4VvOsNwtEF8sozLMksbvtg1gv6eQlJ/0L+4MuW1
        ZEGJz7wJdue7hhdGAa/PvZysfDfGi1RoXsCRHqOk4h14DFceQ2WKSDEWULBGn72khKTgn0
        fDfMLCyZKd6A0JFBKhVFDNc2ugDAvnc=
Date:   Mon, 11 Jan 2021 19:59:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Hyunwook (Wooky) Baek" <baekhw@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V2] x86/sev-es: Fix SEV-ES #VC handler for string port IO
Message-ID: <20210111185947.GF25645@zn.tnic>
References: <20210110071102.2576186-1-baekhw@google.com>
 <1c7f7df6-11f0-e290-cb26-6d8c01b45e2c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c7f7df6-11f0-e290-cb26-6d8c01b45e2c@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:29:08PM -0600, Tom Lendacky wrote:
> Shouldn't this have a Fixes: tag?

Yah, moving to x86/urgent after a quick IRC clarification.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
