Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49592B91F4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgKSMBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgKSMBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:01:30 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D797C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 04:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=knLBXYswT782Ey+RcblRs+pvakWtzlF6q8jukITwxYA=; b=lZa8DC8aEzVUsMSyHoKW2JbolL
        pJQnHS0Ue3hDsOm2FmImsl1hJSgW6Q8esiEE8aRs+WeTdlm5OajXi/fpp2ZgHT3XvmOqCFKyy0C9R
        07RzhW5crnq0hLH0LpU6/y1tDALnsi6/YHMu4gl0+SEXK1ArdaLpho+BtL71ujie4k5IG9qFeZBxy
        5XAW+V8Qw6o/jbJ0Vibg+QYbN4W6bsbaKifNDXQ5TaGCowMPHAbn1Fhg5wsfABVGEPwECNsCiq88G
        /jJHoyjCQ6K0k5moUEh9SogDfKhpoXt/UDlvZxvNUJkUX6EgHzFU7ZQDDr8HFu51z1KbZmyZVcfS6
        e+ofUWnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kficu-0001pE-9C; Thu, 19 Nov 2020 12:01:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D788C301E02;
        Thu, 19 Nov 2020 13:01:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE8082C15A620; Thu, 19 Nov 2020 13:01:22 +0100 (CET)
Date:   Thu, 19 Nov 2020 13:01:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201119120122.GJ3121392@hirez.programming.kicks-ass.net>
References: <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
 <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
 <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
 <20201118082254.GH3121378@hirez.programming.kicks-ass.net>
 <20201119115059.dns4hvull3l3dwx3@shindev.dhcp.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119115059.dns4hvull3l3dwx3@shindev.dhcp.fujisawa.hgst.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:51:00AM +0000, Shinichiro Kawasaki wrote:
> I tried Peter's patch in my test system and result looks good. The warning is
> still observed with 5.10-rc4. With the patch on top of 5.10-rc4, the warning
> disappeared.

The patch on its own is not sufficient to fix things; there needs to be
an accompanying objtool patch to generate the correct unwind
information.

This patch only ensures objtool has enough information to be able to
dtrt, but as it stands it shouldn't even compile, it should complain
about an alternative trying to modify the stack and bail.
