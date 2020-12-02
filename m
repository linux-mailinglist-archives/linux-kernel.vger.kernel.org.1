Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37FA2CC310
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgLBRJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:09:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39802 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgLBRJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:09:08 -0500
Received: from zn.tnic (p200300ec2f161b00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88AA91EC0445;
        Wed,  2 Dec 2020 18:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606928907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ySegBj5bw98Dubr8StQaVFXEi9kv05WveRbfqUYjPM=;
        b=nupJKD0sLAJ4R4UUPVoZaW60JPZLoqvGYStCVadIUPeYcxQBDe1TC8TasvCIz+cBpUSJMI
        dbbQFVbpPp5/4n1DfFyfcTn82NsC40ZfhEmqPlVJx0HXns7PsZW4zbP9lny+lXVOb5CUuO
        WZuBUXZ7PtfjieBd/pKYBpU6ZLcKRCA=
Date:   Wed, 2 Dec 2020 18:08:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, peterz@infradead.org,
        luto@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 04/12] x86/xen: drop USERGS_SYSRET64 paravirt call
Message-ID: <20201202170823.GF2951@zn.tnic>
References: <20201120114630.13552-1-jgross@suse.com>
 <20201120114630.13552-5-jgross@suse.com>
 <20201202123235.GD2951@zn.tnic>
 <6be0d1a5-0079-5d90-0c38-85fe4471f1b8@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6be0d1a5-0079-5d90-0c38-85fe4471f1b8@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 03:48:21PM +0100, Jürgen Groß wrote:
> I wanted to avoid the additional NOPs for the bare metal case.

Yeah, in that case it gets optimized to a single NOP:

[    0.176692] SMP alternatives: ffffffff81a00068: [0:5) optimized NOPs: 0f 1f 44 00 00

which is nopl 0x0(%rax,%rax,1) and I don't think that's noticeable on
modern CPUs where a NOP is basically a rIP increment only and that goes
down the pipe almost for free. :-)

> If you don't mind them I can do as you are suggesting.

Yes pls, I think asm readability is more important than a 5-byte NOP.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
