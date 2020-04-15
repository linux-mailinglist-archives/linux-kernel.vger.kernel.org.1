Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C051A991B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895700AbgDOJgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 05:36:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48606 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895690AbgDOJgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:36:37 -0400
Received: from zn.tnic (p200300EC2F095B00CCE44E2D0BBEAA22.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:cce4:4e2d:bbe:aa22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B12241EC0BFD;
        Wed, 15 Apr 2020 11:36:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586943395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tF0zXvP6dsoEGYoP3+FSRAMw3UmN5J8sq/q+JVx/ThE=;
        b=CIH6Up1eTJmxcNsVgNQfgz5HUijWK4Feyyzw7Dnv3/cqfb4tcACFgNR3iuy4if/2mQ3YeH
        bptWTrMKCNkNRzzLgYPaHnl3e1KDyzyw/l4rdQFc5nlUVf6DOOJEQjDYRqHcBExaK1Tk12
        UfoQeoue8N/+PCbmj7YfzDsP5iKpdMQ=
Date:   Wed, 15 Apr 2020 11:36:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     CodyYao-oc <CodyYao-oc@zhaoxin.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        cooperyan@zhaoxin.com, codyyao@zhaoxin.com
Subject: Re: [PATCH] x86/perf: Add hardware performance events support for
 Zhaoxin CPU.
Message-ID: <20200415093635.GD31016@zn.tnic>
References: <1586747669-4827-1-git-send-email-CodyYao-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1586747669-4827-1-git-send-email-CodyYao-oc@zhaoxin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 11:14:29AM +0800, CodyYao-oc wrote:
> Zhaoxin CPU has provided facilities for monitoring performance
> via PMU(Performance Monitor Unit), but the functionality is unused so far.
> Therefore, add support for zhaoxin pmu to make performance related
> hardware events available.
> 
> Signed-off-by: CodyYao-oc <CodyYao-oc@zhaoxin.com>
> Reported-by: kbuild test robot <lkp@intel.com>

What exactly did the 0day bot report?

Put that in []

above the Reported-by line pls.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
