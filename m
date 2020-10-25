Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F8129833A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418378AbgJYS4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418065AbgJYS43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:56:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A021C061755
        for <linux-kernel@vger.kernel.org>; Sun, 25 Oct 2020 11:56:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603652187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1UukNP0q3W1R5QbuG0C+xk3tKiIph6i9eTzeoe/w094=;
        b=WPkXuqChqXtSN5u16M2V3kcxTq2TmIER4tLm6LduzO3dQmV6ryxnv8tWGIgXrYPmeRkjDV
        ziE0WQwHk4Qn/CszUPXX/1Sz0dj+q+WvV3nKn0SfZ7/uLOZp3LBVfrze+L8g8EvedFEMWk
        aQjZAkqn/E64IhUIc6ZDZKgpJ62gKeYiAPppYRlyn3NswVXTixz2HA4X/8nXEURJvFTWfo
        EEJo5yetVVmDkS+OnFazABRoQReL1Rf5euMDZZWDwT7ealAczMcjqRnJzEcEsxFUAsNJFP
        DrwC+BdUoH+zQA7drx1Q0UryFO9efbT4h8//2woyo+TlDnnWOGUo9aqNX6Nyvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603652187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1UukNP0q3W1R5QbuG0C+xk3tKiIph6i9eTzeoe/w094=;
        b=pS5/GMApi47dBlumBDHGgPxW+IRms7R5C0waZgDaMsAApExMQChUSbO2PW0eOPWlfnBnGO
        2R/4x4vAgOIb63Dw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.10-rc1
In-Reply-To: <CAHk-=whYsdbVzNdPPFKNY1R0d79jdDv442qx1DwLT=RRq6xxcw@mail.gmail.com>
References: <160363590465.1234.11586095980767794789.tglx@nanos> <160363590947.1234.141731936248952516.tglx@nanos> <CAHk-=whYsdbVzNdPPFKNY1R0d79jdDv442qx1DwLT=RRq6xxcw@mail.gmail.com>
Date:   Sun, 25 Oct 2020 19:56:27 +0100
Message-ID: <87sga23zj8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25 2020 at 11:34, Linus Torvalds wrote:
> On Sun, Oct 25, 2020 at 7:25 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Restore the original #DE Oops message so tools which parse crash or dmesg
>> find what they expect.
>
> Hmm. I already got this one from Borislav as a different commit
> (5f1ec1fd3225: "x86/traps: Fix #DE Oops message regression"), so I'm

Hrm. Why didn't I notice?

> skipping this pull request as unnecessary.

Sure.

> I'm assuming nobody has based any work on top of it, and if they have,
> it's not the end of the world to get the duplicate commit, but it
> seems pointless to do a pull that ends up with no code changes at all
> for me.

Fair enough.
