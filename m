Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF19294A83
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437226AbgJUJ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 05:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408708AbgJUJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:28:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D5C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 02:28:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c9a008ba17a7e65985c5f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9a00:8ba1:7a7e:6598:5c5f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A05E1EC034B;
        Wed, 21 Oct 2020 11:28:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603272483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B8PNh72RUAEjbxbklk2bFCscMmmqm3MGhCHMQYSDAJc=;
        b=ri68aJmkERwkM4tgXREmgPqHkDFM8t1oz/7H+YLvDc2rAKODP//LSPk2F0tk5Xm5++RGVq
        Gm+MnvaAzpDwtAy0bJtSjKSHqBz2Jrb4vI5n4Mg8mUot/KhugtXsO7A+SiDgW875EUSh64
        XRXucMGRgnuhW+a2x/8XVUuUzW8FmF8=
Date:   Wed, 21 Oct 2020 11:27:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86-ml <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201021092750.GA4050@zn.tnic>
References: <20201020120232.GD11583@zn.tnic>
 <20201020232700.5510c236d810b7f8a66779e2@kernel.org>
 <20201020143746.GG11583@zn.tnic>
 <20201021095013.d82637f84af564ae4363189d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201021095013.d82637f84af564ae4363189d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 09:50:13AM +0900, Masami Hiramatsu wrote:
> Agreed. So I'm OK for returning the result of "decoding".
> But we also need to note that the returning success doesn't
> mean the instruction is valid. That needs another validator.
>
...

>
> Yes, so let's add the return value (with a note, so that someone
> does not try to use it for validation).

Ok, I'm unclear on that "validation" you talk about. What exactly do
you mean? Can you give an example of how one would determine whether an
instruction is valid? And valid how?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
