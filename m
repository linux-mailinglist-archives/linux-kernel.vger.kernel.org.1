Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049982858C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgJGGq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGGq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:46:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EE9C061755;
        Tue,  6 Oct 2020 23:46:57 -0700 (PDT)
Received: from zn.tnic (p4fed3407.dip0.t-ipconnect.de [79.237.52.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 826AE1EC0212;
        Wed,  7 Oct 2020 08:46:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602053215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q3MT753Y/9T6S8HO3C+jWdr+lYhKeiRn2qSy7VpKpIQ=;
        b=MfbUqRG4dUAs3yTl7QD/QyEiilxS+72zjLDGrms7Xzx6r1LkaI7b2eJvyqpw+BQhf46bzT
        1Zc7+RCqWcB5O3MeUkHHavGCya3FMwIyBae/OlVjFtmMlldxt+ti84AKyEoPhZ3SHzo31K
        OxmHVaHujCL3IusiA9pZlpS7ozCc3C4=
Date:   Wed, 7 Oct 2020 08:44:37 +0200
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
Subject: Re: [PATCH v4 02/13] x86/platform/uv: Remove SCIR MMR references for
 UVY systems.
Message-ID: <20201007064437.GA5607@zn.tnic>
References: <20201005203929.148656-1-mike.travis@hpe.com>
 <20201005203929.148656-3-mike.travis@hpe.com>
 <20201006131602.GE27700@zn.tnic>
 <eedfeab5-1bba-ad0c-4590-60fccf08aef2@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eedfeab5-1bba-ad0c-4590-60fccf08aef2@hpe.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 06:11:04PM -0700, Mike Travis wrote:
> I thought there was more references to the UVY class which currently has
> only UV5 as a member.  There might be UV5 references where they should be
> UVY.  The struct references use "uvy" as the selector so the grep should
> look for upper and lower case.

Try it for yourself on a tree *before* your patchset:

$ git grep --ignore-case uvy

> The UV5 system is still in the design stage so we are doing development
> using simulators.  More UV5 support is expected to arrive as needed. (The
> earlier class was UVX if interested.)

So to answer the question myself as yours is not really answering it:
this subject means "UV" not "UVY". UVY support is beginning to be added
with this series here.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
