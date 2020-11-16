Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B008C2B53F8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 22:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgKPVqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 16:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgKPVqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 16:46:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6F2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 13:46:31 -0800 (PST)
Received: from zn.tnic (p200300ec2f07680009538f4f478c319e.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:6800:953:8f4f:478c:319e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CCC091EC0281;
        Mon, 16 Nov 2020 22:46:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605563189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WXP19OTQruhOZ41O93etcEJyznzBGGAjQKYrxBtGkYg=;
        b=PQH4nEA1ehIj7wE5312dP09RFYcI24FCkpB74CTxwQc/UfAhNEMpEhp/syLE3OowWoZj/k
        VO3atikqAaLfr/rabp8s3mzjkFbStVZAc/JhswRxPKvejZ9/arX+Z+iCYvY53c22f72PvM
        U/3+i34ykgD2USQxbRkfiTIjFyFt1g0=
Date:   Mon, 16 Nov 2020 22:46:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] x86/microcode/intel: check cpu stepping and
 processor flag before saving microcode
Message-ID: <20201116214622.GG1131@zn.tnic>
References: <20201113015923.13960-1-yu.c.chen@intel.com>
 <20201116122735.GA1131@zn.tnic>
 <20201116213019.GB76389@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201116213019.GB76389@otc-nc-03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:30:19PM -0800, Raj, Ashok wrote:
> Stable is still left below. with #v4.10+
> 
> Do you want to keep this? Also do you want him to resend or you have that
> covered?

No Ashok, read the section

"For all other submissions, choose one of the following procedures"

here: Documentation/process/stable-kernel-rules.rst

> Seems clear to me, and the commit log cleanup also makes sense. I
> don't have a system myself,. Will wait for Chen Yu to confirm if it
> works for him as well.

Ok, I'll wait a bit before queuing it for urgent.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
