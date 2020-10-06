Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E84284C50
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJFNLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:11:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59742 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFNLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:11:04 -0400
Received: from zn.tnic (p200300ec2f0d6300a8f8264196af23e2.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6300:a8f8:2641:96af:23e2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 61D5C1EC032C;
        Tue,  6 Oct 2020 15:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601989863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=clROgJ61P5a49kXfjwMkQ6QsqWJQYwRU0nWrYA+gEvU=;
        b=ApENEiGQkupNE3emSm8NnJUXsbnv4CzTQZmeC4mshXnUqJR++jE/KM1NyqJoAaPFbpFcUI
        CvG2/LNseLYToiBnMZ4Lb1qvbKwBUKGR6d/JiqQ0DU66ueINh0+Dk5AnbWWl/B3tixZxh3
        NoeShd1fYvgJ+cS+/a5ETdYKFMg3//g=
Date:   Tue, 6 Oct 2020 15:10:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 03/13] x86/platform/uv: Adjust references in UV kernel
 modules
Message-ID: <20201006131054.GD27700@zn.tnic>
References: <20201005203929.148656-1-mike.travis@hpe.com>
 <20201005203929.148656-4-mike.travis@hpe.com>
 <20201005211611.GK21151@zn.tnic>
 <7598f508-6c4a-f1df-f83f-2f68bc99578f@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7598f508-6c4a-f1df-f83f-2f68bc99578f@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 02:32:38PM -0700, Mike Travis wrote:
> Yes, there was the MACRO is_uv() that conflicted with the automated
> "generate uv_mmrs.h" PERL script that also uses it that I changed.  I see
> now maybe just getting rid of the entire thing in this file might have been
> better?

If you need to change only this patch then sure, you can send me an
updated one as a reply to this message. If more changes are needed, you
can always do that cleanup later - up to you.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
