Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810042C4A33
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbgKYVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:41:34 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34553 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbgKYVld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:41:33 -0500
X-Originating-IP: 62.210.143.248
Received: from weirdfishes.localdomain (62-210-143-248.rev.poneytelecom.eu [62.210.143.248])
        (Authenticated sender: m@thi.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7327F60003;
        Wed, 25 Nov 2020 21:41:30 +0000 (UTC)
Received: by weirdfishes.localdomain (Postfix, from userid 1000)
        id 12A0B720488C4; Wed, 25 Nov 2020 22:41:30 +0100 (CET)
Date:   Wed, 25 Nov 2020 22:41:30 +0100
From:   Mathieu Chouquet-Stringer <me@mathieu.digital>
To:     Borislav Petkov <bp@alien8.de>, Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] x86/msr: Filter MSR writes
Message-ID: <20201125214130.GA54301@weirdfishes>
Mail-Followup-To: Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Borislav Petkov <bp@alien8.de>, Matthew Garrett <mjg59@google.com>,
        Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        the arch/x86 maintainers <x86@kernel.org>, kernel-team@fb.com
References: <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <CACdnJuvfhjMNQUYNYWpPMfwTE3xHi7UNPm7HEwUMv_1F3KT4gA@mail.gmail.com>
 <20201117210018.GA4247@weirdfishes>
 <20201117212016.GQ5719@zn.tnic>
 <20201118090929.GC189743@weirdfishes>
 <20201118115027.GF7472@zn.tnic>
 <20201118140427.GA213447@weirdfishes>
 <20201118175048.GK7472@zn.tnic>
 <20201119105344.GA434279@weirdfishes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119105344.GA434279@weirdfishes>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hey Borislav,

On Thu, Nov 19, 2020 at 11:53:44AM +0100, Mathieu Chouquet-Stringer wrote:
> On Wed, Nov 18, 2020 at 06:50:48PM +0100, Borislav Petkov wrote:
> > Please fix the text in Documentation/admin-guide/sysctl/kernel.rst also.
> 
> Done.

I haven't heard from you, what did you think of my last patch?

-- 
Mathieu Chouquet-Stringer                             me@mathieu.digital
            The sun itself sees not till heaven clears.
	             -- William Shakespeare --
