Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC18290A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436559AbgJPRHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:07:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50396 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436535AbgJPRHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:07:52 -0400
Received: from zn.tnic (p200300ec2f0d0d000a68ceadd6ffefc0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:d00:a68:cead:d6ff:efc0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 224231EC050F;
        Fri, 16 Oct 2020 19:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602868071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zfCrcyFm0qEpEYxy7QuMjtjaeZWx1kOCQyF1pdXhVCY=;
        b=FiFC1V8lcCmd5jI89Esdiwa0VU+vFDmz4jC7dJU1WdOBs7n8dIVghDajZOzoDNUuQ6THBh
        jpVmFAFHihaiGWf3hnoPiVeMSCv7vPhPu/JhdKJdqFwN+/l3SoQF7jUcKlTPk4Mp4ayEtO
        M9NXKIwKiKE9k4o2kQva+uocjjT6wOU=
Date:   Fri, 16 Oct 2020 19:07:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and
 command line
Message-ID: <20201016170726.GH8483@zn.tnic>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201008191623.2881677-5-nivedita@alum.mit.edu>
 <20201016162759.GG8483@zn.tnic>
 <20201016164755.GA1185111@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201016164755.GA1185111@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 12:47:55PM -0400, Arvind Sankar wrote:
> Just for clarity, by cleanups you mean patches 2 and 3? i.e. you want to
> see 1, 4, 2, 3?

It is important for:

[PATCH v2 4/5] x86/boot/64: Explicitly map boot_params and command line

to come first so that it goes in now.

The rest:

[PATCH v2 1/5] x86/boot: Initialize boot_params in startup code
[PATCH v2 2/5] x86/boot: Split out command-line related declarations
[PATCH v2 3/5] x86/boot/64: Show original faulting address in case of error

can come in any order and when ready.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
