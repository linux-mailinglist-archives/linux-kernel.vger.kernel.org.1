Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B111E7CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 14:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgE2MKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 08:10:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgE2MKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:10:44 -0400
Received: from zn.tnic (p200300ec2f0f5e0065ddb5c3466bc22e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5e00:65dd:b5c3:466b:c22e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 90DD31EC0322;
        Fri, 29 May 2020 14:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590754243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fme/ekO6mAFo1VevPB2Wamp5hira7XgWhTb1mRZL0U4=;
        b=LcyrG+cmwwpLX+o0JQl1zIoxCxanONmg2wiJWs4F5IegP7PRg18vBlIXRKwhjpwJSEgLPI
        wp+tLtAIrRJQ6VvWBdEBSnOtY+p5FNmjRW57S0BYFrBoZtAIE5SVOW5LoD4vZ2tEn258lq
        8FWZfbwGa9PdfJ3MzXK4wFWiYzMbpd0=
Date:   Fri, 29 May 2020 14:10:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, josh@joshtriplett.org, luto@kernel.org,
        kai.huang@intel.com, rientjes@google.com, cedric.xing@intel.com,
        puiterwijk@redhat.com, Jethro Beekman <jethro@fortanix.com>
Subject: Re: [PATCH v30 09/20] mm: Introduce vm_ops->may_mprotect()
Message-ID: <20200529121038.GG9011@zn.tnic>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
 <20200515004410.723949-10-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515004410.723949-10-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:43:59AM +0300, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Add vm_ops()->may_mprotect() to check additional constrains set by a

"constraints"

> subsystem for a mprotect() call.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Acked-by: Jethro Beekman <jethro@fortanix.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/linux/mm.h |  2 ++
>  mm/mprotect.c      | 14 +++++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)

This needs an ACK from an mm person.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
