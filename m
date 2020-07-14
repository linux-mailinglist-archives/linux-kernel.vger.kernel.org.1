Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E052B21F664
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGNPra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgGNPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:47:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18418C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:47:30 -0700 (PDT)
Received: from nazgul.tnic (77-85-108-148.ip.btc-net.bg [77.85.108.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0A701EC0344;
        Tue, 14 Jul 2020 17:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1594741646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GYuwCWwzK+ziSG55zkdLFouJVnC8IgBoEQyI2gj6P44=;
        b=POLxeDk+OXvpF/ABe/kUqflUXRd9pZrkAXqFjTbyR28YPDutmFZP+tGHGEVYaO54asx1GA
        teljim4zuVfvnqBkWxSWE1k4fDpGKMX1E1NRwMflnJlx0PP4N3xlgo5R7XBUfkCKlmxT+f
        4Pr88qaEHYTY4gZFSsk4rms5P6wa+BU=
Date:   Tue, 14 Jul 2020 17:47:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        tony.luck@intel.com, torvalds@linux-foundation.org, x86@kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200714154728.GA3101@nazgul.tnic>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714121955.GA2080@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 01:19:55PM +0100, Chris Down wrote:
> That is, even with pr_err_ratelimited, we still end up logging on basically
> every single write, even though it's from the same TGID writing to the same
> MSRs, and end up becoming >80% of kmsg.
> 
> Of course, one can boot with `allow_writes=1` to avoid these messages at

Yes, use that.

From a quick scan over that "tool" you pointed me at, it pokes at some
MSRs from userspace which the kernel *also* writes to and this is
exactly what should not be allowed.

As to the "MSR hack", please describe what the issue is exactly so that
we can get the proper people involved. If anything, this needs to be
fixed in the kernel properly. If people are waiting for a year for a
BIOS fix, I'd say there's a very slim chance for that to ever happen...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
