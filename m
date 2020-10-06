Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED9284F59
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgJFQBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFQBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:01:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC976C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 09:01:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d6300cee9f1eb6b8e192c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6300:cee9:f1eb:6b8e:192c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6DD411EC0179;
        Tue,  6 Oct 2020 18:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602000065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xh3kMdIybf2ebBfP+Kmk9FwzZHy8mrl69W89op7fJCk=;
        b=GOx3x40jaQCJlzEbxooW9zZHYG2BrUmlqIWeUMvJegJ0DRAFC8TUmF7GVtNK+PL48GFqHq
        xOgBqMrIBJZ37r9O/BDp1+ouEqSfVBw9qxFe9Tw45D8iFz2nqpc2GIu37WAL9yn4GEJcsn
        oYLH1A1YMy/ntPzPr2ouwYCJD9zQrh8=
Date:   Tue, 6 Oct 2020 18:00:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/resctrl: Correct MBM total and local values
Message-ID: <20201006160056.GG27700@zn.tnic>
References: <1601331173-185230-1-git-send-email-fenghua.yu@intel.com>
 <20201005093506.GB21151@zn.tnic>
 <20201006004348.GA1415745@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201006004348.GA1415745@otcwcpicx6.sc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:43:48AM +0000, Fenghua Yu wrote:
> I keep this original table here for two reasons:
> 1. It's an original table that can be tracked by any one in the future.
>    If I don't list the original table here, others may wonder where I
>    get the converted table from.

If you wanna document it then put that table in
Documentation/x86/resctrl_ui.rst.

Before you put it there, you can rename that file to

Documentation/x86/resctrl.rst

because after that change, it won't contain UI documentation only
anymore.

Commit messages tend to become hard to dig out in the future, when a lot
of patches accumulate ontop. Even more so if someone renames files so if
you really need to document something, you can either put it a comment
over the code where it is used, or if it is something bigger as this
table, you can put it in Documentation/ and refer to it in the code.

> Ok. I will describe the problem in the commit message.

Just paste the erratum text. That's it - it is small enough.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
