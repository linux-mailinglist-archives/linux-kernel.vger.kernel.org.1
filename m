Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B92D65E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404180AbgLJTFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:05:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53870 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390475AbgLJTFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:05:09 -0500
Received: from zn.tnic (p200300ec2f0d410017205789a0fcbfc3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4100:1720:5789:a0fc:bfc3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F3E551EC053F;
        Thu, 10 Dec 2020 20:04:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607627062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gBPo35cr755KDczL40MYpAmqwRmKAJRe1c7xYq33J+E=;
        b=qaH6poEKPonLWEQR8dSSVUhcVQp8HX5X+7zLCsAuYOyuX33tUVqCTk3MxQfojd6F1VaC1w
        99JB25O41VWYQU36R7/b2aTmdO3aAQK8gUEBGnd0nf0toosgPhOe4Sa/Dmkw9lyCUR49oc
        eB5OL+xSPoWniIaFhKxwinEv3Os7kvw=
Date:   Thu, 10 Dec 2020 20:04:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/reboot/quirks: Add Zotac ZBOX CI327 nano PCI reboot
 quirk
Message-ID: <20201210190418.GG26529@zn.tnic>
References: <1524eafd-f89c-cfa4-ed70-0bde9e45eec9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1524eafd-f89c-cfa4-ed70-0bde9e45eec9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 12:39:57PM +0100, Heiner Kallweit wrote:
> On this system the M.2 PCIe WiFi card isn't detected after reboot,
> only after cold boot. reboot=pci fixes this behavior.
> In [0] the same issue is described, although on another system and
> with another Intel WiFi card. In case it's relevant, both systems
> have Celeron CPU's.
> The dicussion in [0] involved the PCI maintainer, and proposal was
> to go with the PCI reboot quirk on affected systems until a more
> generic fix is available.
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=202399

But this quirk is for your system only - the one in the bugzilla entry
would need another one? Or?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
