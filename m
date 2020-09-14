Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2D26943E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgINR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:56:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56572 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgINR4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:56:11 -0400
Received: from zn.tnic (p200300ec2f092600691f19cafd1ebd8c.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2600:691f:19ca:fd1e:bd8c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D142E1EC0572;
        Mon, 14 Sep 2020 19:56:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600106170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1yv+srSKfxeaUyicwWKfbf3lmLFh6cK6P4lFNakTVGE=;
        b=ccZKfPi9JSAAYs7tnXs6Tm2f/iwZRdz1sJqNqmZ4AClNVHIgf7Ui9FFOLMZpix9NE2cu9p
        nLbod5mekSAQwiwNao6so4Lr3Wvux1nQAyYTeTp8r8Pr8G6TJC6rotMACS5IYEIXHFP/Fg
        HypbWQbYxkkLS315C+oRqJpvlB+mnbM=
Date:   Mon, 14 Sep 2020 19:56:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200914175604.GF680@zn.tnic>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:22:53PM -0500, Josh Poimboeuf wrote:
> +/*
> + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> + * pointer.  This prevents speculative dereferences of user-controlled pointers
> + * to kernel space when access_ok() speculatively returns true.  This should be
> + * done *after* access_ok(), to avoid affecting error handling behavior.

Err, stupid question: can this macro then be folded into access_ok() so
that you don't have to touch so many places and the check can happen
automatically?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
