Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B47426F75F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 09:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIRHvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 03:51:32 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54880 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIRHvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 03:51:32 -0400
Received: from zn.tnic (p200300ec2f0c2600a65c515d56d1ce56.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:2600:a65c:515d:56d1:ce56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 104D01EC0493;
        Fri, 18 Sep 2020 09:51:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600415491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ucWOOaamsnfWldDhXEqdm7OvFhqDmKoYFhw/F/rZesk=;
        b=KzZh3DnHuJbu0797y3scP5G518NOzHVNqZ/pIkkO8/no/q6xK9fijC9Hlfn3HmvlRzQNeM
        logeK5CDQCWYS78+YOjqXIDn9pzw9Xp8mROzenW3L/kdKsu7MehKBsZ+iKrzcGz2I3kCh9
        1be3XkdFSHsJr9GWSuXVIJZYQrFpoZY=
Date:   Fri, 18 Sep 2020 09:51:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Message-ID: <20200918075125.GB6585@zn.tnic>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-6-tony.luck@intel.com>
 <20200916105336.GF2643@zn.tnic>
 <20200916192659.GA30252@agluck-desk2.amr.corp.intel.com>
 <20200917170406.GN31960@zn.tnic>
 <20200917215751.GB16591@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917215751.GB16591@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 02:57:51PM -0700, Luck, Tony wrote:
> On Thu, Sep 17, 2020 at 07:04:06PM +0200, Borislav Petkov wrote:
> > So actually, I'm thinking:
> > 
> > .LMCE_during_user_access:
> > 	mov $-ENODEV, %eax
> > 	ASM_CLAC
> > 	ret
> > 
> > I have no clue which error code we should put there but it should be an
> > error code which tells you not to retry and to back off immediately.
> 
> That does look a lot easier to understand *at this point* in the code.
> 
> But the existing iterator code is not expecting an error code.  Just a
> count of bytes not copied.
> 
> So doing this would mean some surgery on the maze of giant #defines that
> is lib/iov_iter.c

Ok, since the user task is guaranteed to get the SIGBUS, let's just
resort to documenting this properly for now and we can consider more
involved surgery later, if really needed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
