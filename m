Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F062EA925
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbhAEKsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbhAEKsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:48:50 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAAFC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 02:48:10 -0800 (PST)
Received: from zn.tnic (p200300ec2f103700ba0c0ccd6fae6c32.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:3700:ba0c:ccd:6fae:6c32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0397E1EC04CB;
        Tue,  5 Jan 2021 11:48:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609843687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BiJSPSBYrHbZDXxLcoL/hKKP+MEoHTTHFUnxmu2V1H8=;
        b=m5BTKc3BRApYJTrb+0gdMU2R1sOHfr5r6vaeJ3UVAyYFV4FdsxvqRPQdy7w/rg0/+KwoM7
        Y21FO4xCZD/hHqwIfVNhn/I510VKyHQk9n6D0p0DNaLdEhb6nQFwtuWFgWD3FIAujfqDeo
        OaPCeempX1eZOacAuYwTpBNHVnUxu/U=
Date:   Tue, 5 Jan 2021 11:48:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
Message-ID: <20210105104805.GC28649@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net>
 <20201222130555.GA13463@zn.tnic>
 <20210104161911.38eb3e1e@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104161911.38eb3e1e@lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 04:19:11PM -0700, Jonathan Corbet wrote:
> So I have some questions, I guess...  How often is a backtrace *in a commit
> message* really helpful at all?  The value in problem reports is clear, but
> I'm not sure how often having a backtrace in a commit message will really
> help the reader understand why the patch was written.  But perhaps I'm
> wrong?

Does the subthread here with Sean shed some light on the matter or... ?

> If we do want this advice in our already-too-long submitting-patches
> document,

Thought the same thing when looking at that doc - it is a *lot* and I
guess we should put only very globally relevant info in there...

> we should perhaps give some advice as to what is "relevant
> information" and what is not?

Right, in that subthread, the gist of what we wanna say is to almost
always put the splat in the commit message - except for the example I
gave there and other early boot cases - but leave it to the committer to
do the final decision whether to keep or ditch the splat.

Something like that. Yah, I know, it is fuzzy :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
