Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483AA1F203A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 21:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgFHTmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 15:42:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55758 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgFHTmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:42:53 -0400
Received: from zn.tnic (p200300ec2f26d700ade61a8be514ef2f.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:d700:ade6:1a8b:e514:ef2f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A2EEF1EC02B1;
        Mon,  8 Jun 2020 21:42:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591645372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dCPdfHY3b4SJMjy1igOIQZqz+WhDVbR2ecXgIC5dVPI=;
        b=KtM+79hHUbFa7x/eC4H4e2fQ/16JDwfETDFBD3HxVvxhIlU+rvVjkY7WJ03nTCQdu8DuwU
        /IMewNXZSkxOkDFirrKsXQN8bkZoUH+XRe2da0m0eCwnfiwjTFzTBblKGF/85W6jspdSAf
        /2a2k/cWPRtxQLRoRRHp932c1INvVA0=
Date:   Mon, 8 Jun 2020 21:42:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Benjamin Thiel <b.thiel@posteo.de>,
        Juergen Gross <jgross@suse.com>, x86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/xen: Fix a -Wmissing prototypes warning for
 xen_start_kernel()
Message-ID: <20200608194245.GC21538@zn.tnic>
References: <20200606142721.19486-1-b.thiel@posteo.de>
 <21d6821e-e488-138e-a0be-2177c4aa13b2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d6821e-e488-138e-a0be-2177c4aa13b2@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 03:30:13PM -0400, Boris Ostrovsky wrote:
> TBH I am not sure it's worth a new header file for a routine that is
> only called from assembly (and never returns). I'd just add the
> prototype right above function definition, with a comment describing
> why. 

Right, that works too.

> I see a few examples of this in the tree. Or maybe we even have an
> attribute for this case?

Not that I'm aware of.

> (I also suspect the same may be needed for xen_prepare_pvh() BTW).

Yeah, Benni is working through the rest of them. Btw, the final goal of
this whole work is to enable -Wmissing-prototypes by default on x86.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
