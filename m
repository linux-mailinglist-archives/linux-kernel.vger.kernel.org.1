Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1253426E1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgIQRE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgIQRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:04:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C16C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:04:18 -0700 (PDT)
Received: from zn.tnic (p200300ec2f105300d80be81ad57dea02.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:5300:d80b:e81a:d57d:ea02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0E6B1EC032C;
        Thu, 17 Sep 2020 19:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600362254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ao7IV8o5DvFqXeDRPhYj7ZKI/xNyV9nR/VUSP/Q6o8E=;
        b=fynMVgFaCtU1SpZ8y0wi5VZm82gQK+RtgjpTWFKmG6eU22ZT8g/cmCAwFl19/KLeS5a/zI
        rKXBqNSMsA9d5kKV4rQqN2Aix9y8R2d/dhiCjM+cnERGVm1bu1jRCr8laS1e8eVIqUDnDp
        RJQVz5zaR7X/N0RmFYqeG0UFWSYfMSQ=
Date:   Thu, 17 Sep 2020 19:04:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Message-ID: <20200917170406.GN31960@zn.tnic>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-6-tony.luck@intel.com>
 <20200916105336.GF2643@zn.tnic>
 <20200916192659.GA30252@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200916192659.GA30252@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replying a bit out of order:

> Both the code and the commit comment need much more of this
> description.

Hell yeah!

On Wed, Sep 16, 2020 at 12:26:59PM -0700, Luck, Tony wrote:
> So we take a another machine check on the same address when
> fault_in_pages_readable() does __get_user().  That ought to break
> us out ... but for some reason I still don't understand didn't.
> But even if it did ... the second machine check is not at all
> a good idea.

And I think this is the important point: for MCEs you absolutely don't
want to take another MCE and even walk into those fields. So what
fault_in_pages_readable() does normally, would be totally wrong. Imagine
you're playing minesweeper - you can't just pre-fault blocks without
counting the mines. :-P

So actually, I'm thinking:

.LMCE_during_user_access:
	mov $-ENODEV, %eax
	ASM_CLAC
	ret

I have no clue which error code we should put there but it should be an
error code which tells you not to retry and to back off immediately.

> Returning zero bytes left to say we completed avoids that. The
> user is guaranteed a SIGBUS when the task_work does fire. So whatever
> system call was in progress is not going to see the apparent
> successful return.

Yes, my only proposition with the error code is in case you're looking
at traces, to recognize that the copying encountered an MCE. In addition
to the "back off immediately" semantics, if there even is such defined
for users of copy_*_user().

> Unless you have some better way out of the dilemmma that the
> real fixup is only scheduled at the point that the extable
> fixup just arranges for a simple local return from the copy.

Right, see above: I think it is imperative *not* to walk into that area
again and not do any retrying.

> When the return to user happens the task_work that was scheduled
> in the machine check handler takes care of the error return to the
> user.

Yeah, let's write that whole flow down somewhere - not in a commit
message - so that it is clear what happens.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
