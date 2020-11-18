Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B054B2B7CB5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgKRLaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgKRLaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:30:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADA0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:30:01 -0800 (PST)
Received: from zn.tnic (p200300ec2f0caf00530924e6be7c3eae.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:5309:24e6:be7c:3eae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E5CC1EC04B9;
        Wed, 18 Nov 2020 12:29:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605698999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OgYajlOI1q6yag3exq5oVHdCfPZ2gQ2BbYRUSYh5t/E=;
        b=FEpJkJLW9XsNhJoekx42Od69miyIVAQrvlSnNEVyuuFZw6xpfg36/WpQXumksBhjpmWxBh
        4yqDy4cFD+1pkKAYN8VZDKgvfi4BY+jQZ+b7+pffEK1YMNX+eJRm7iF9YlhCWrft3pYVCb
        BbBBkH3HF6xWYfOO1x2NDRq8xqr6V5Q=
Date:   Wed, 18 Nov 2020 12:29:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com, Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
Message-ID: <20201118112952.GB7472@zn.tnic>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
 <20201117212608.GS5719@zn.tnic>
 <b63ec614-8a49-728d-aa61-76339378183f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b63ec614-8a49-728d-aa61-76339378183f@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 08:41:42AM +0100, Alexandre Chartre wrote:
> Well, it looks like I wrongfully assume that KPTI was a well known performance
> overhead since it was introduced (because it adds extra page-table switches),
> but you are right I should be presenting my own numbers.

Here's one recipe, courtesy of Mel:

https://github.com/gormanm/mmtests

"
./run-mmtests.sh --no-monitor --config configs/config-workload-poundsyscall test-default

# reboot the machine with pti disabled

./run-mmtests.sh --no-monitor --config configs/config-workload-poundsyscall test-nopti

poundsyscall just calls getppid() so it's a light-weight syscall and a
proxy measure for syscall entry/exit costs. To do the actual compare

cd work/log
../../compare-kernels.sh

and see what gain there is from disabling pti. If you want to compare
the other direction

../../compare-kernels.sh --baseline test-nopti --compare test-default

If you get an error about BinarySearch

(echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan
yes | cpan List::BinarySearch

Only se the second line if you want to interactively confirm what cpan
should download and install."

I've CCed him should you have any questions.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
