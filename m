Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092D528BF45
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390828AbgJLRz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389885AbgJLRzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:55:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83703C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 10:55:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f06920038fd325cadbd10b1.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:38fd:325c:adbd:10b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00EFA1EC0407;
        Mon, 12 Oct 2020 19:55:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602525354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hYtSoMZOOUt1GXiDpTKuXCN4mrPL0NPFvRWkbA3Dh9c=;
        b=KNAYUXZ49dhFKjois4z3Cjj1LRTgry1AliAH9J1/ZgkU7uOUofFsC88Tq0iNa9IKGNq63p
        BArSZFa7miydt6JIxrlROlDJfYk5IqHmsotYuJpVMF06KHjTLf7I1Cm5srXY8udyvYU4jM
        u0oLwD/4d2jocaIQs/KNRj6fJQxlW/g=
Date:   Mon, 12 Oct 2020 19:55:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v4] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
Message-ID: <20201012175545.GJ22829@zn.tnic>
References: <20201010105421.GA24674@zn.tnic>
 <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
 <20201010161112.GC24674@zn.tnic>
 <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
 <20201012142148.GA22829@zn.tnic>
 <b74a95944a4bc6be1ea4ae8cf065c23e03511ba5.camel@perches.com>
 <20201012171544.GH22829@zn.tnic>
 <5590cd3df8b28cdd077230dda8c99e80436bdcf3.camel@perches.com>
 <20201012173142.GI22829@zn.tnic>
 <73e18a141df7a9259ef47363152bc2595b00bda4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73e18a141df7a9259ef47363152bc2595b00bda4.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 10:40:07AM -0700, Joe Perches wrote:
> Why?  I think it unnecessary.

Joe, I'm sick'n'tired of debating with you what needs to happen.

Please forget that patch altogether - I'll add the functionality to our
own checker script where I don't need to debate with you what I have to
and I have not to do.

And I won't be getting private emails about you teaching me how I should
have replied to your mail. The only "mistake" I made is even thinking
about adding this to checkpatch. Won't happen again.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
