Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031531DBD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 20:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgETSry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 14:47:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59994 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgETSrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:47:53 -0400
Received: from zn.tnic (p200300ec2f0bab0028d24a65f02999fe.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ab00:28d2:4a65:f029:99fe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F35791EC0350;
        Wed, 20 May 2020 20:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590000472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HwICrHSvqXW0KUjMgnBKpXTq3Lwh2cwDngS79k2qZPM=;
        b=llGNjZNz+wSlE07oaDxWE/C5t4nHS0kUHav3B1X9KHnYIDHmoM9guyTAtVNpCafhyHiQiR
        80s5DfMTigf/vl1q9Pz+d+pg0THIGkEqdDX0f1a9kgNQjagkk1rN5BQ7VfwsEAxmpLUh1Y
        NaMCeG/1aocWagcBnEvKdHli2gzeUhk=
Date:   Wed, 20 May 2020 20:47:45 +0200
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
Subject: Re: [PATCH v30 04/20] x86/sgx: Add SGX microarchitectural data
 structures
Message-ID: <20200520184745.GJ1457@zn.tnic>
References: <20200515004410.723949-1-jarkko.sakkinen@linux.intel.com>
 <20200515004410.723949-5-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515004410.723949-5-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:43:54AM +0300, Jarkko Sakkinen wrote:
> +/**
> + * struct sgx_sigstruct_header -  defines author of the enclave
> + * @header1:		constant byte string
> + * @vendor:		must be either 0x0000 or 0x8086

Out of pure curiosity: what is that about?

Nothing in the patchset enforces this, so hw does? If so, why?

Are those vendor IDs going to be assigned by someone or what's up?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
