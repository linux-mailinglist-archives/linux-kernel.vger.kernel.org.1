Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777A426ACC0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgIOROf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:14:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:8830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbgIOQZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:25:28 -0400
IronPort-SDR: ssRMu3xklpQ5+Uhk9YtLD4Kj+eH3y6cARSN78Kn4/8y6VF8zZL08q+os/BdD7A/kqaRC5H3R2Z
 rv7Dy3CStktg==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156687742"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="156687742"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 09:24:57 -0700
IronPort-SDR: rKm/a9Dk8YSf/5e9Ac2pt+XCF4aLm5pQi53ifBr9ObtPnYN8hhV00QUnVkiUoavzTVHiDnM3cJ
 WXqkV6z8odaA==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="482888549"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 09:24:56 -0700
Date:   Tue, 15 Sep 2020 09:24:55 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] x86/mce: Provide method to find out the type of
 exception handle
Message-ID: <20200915162455.GA7818@agluck-desk2.amr.corp.intel.com>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-4-tony.luck@intel.com>
 <20200915091132.GD14436@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915091132.GD14436@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:11:32AM +0200, Borislav Petkov wrote:
> On Tue, Sep 08, 2020 at 10:55:14AM -0700, Tony Luck wrote:
> > Avoid a proliferation of ex_has_*_handler() functions by having just
> > one function that returns the type of the handler (if any).
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/include/asm/extable.h     |  9 ++++++++-
> >  arch/x86/kernel/cpu/mce/severity.c |  5 ++++-
> >  arch/x86/mm/extable.c              | 12 ++++++++----
> >  3 files changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
> > index d8c2198d543b..56ec02e024ad 100644
> > --- a/arch/x86/include/asm/extable.h
> > +++ b/arch/x86/include/asm/extable.h
> > @@ -29,10 +29,17 @@ struct pt_regs;
> >  		(b)->handler = (tmp).handler - (delta);		\
> >  	} while (0)
> >  
> > +enum handler_type {
> > +	HANDLER_NONE,
> > +	HANDLER_FAULT,
> > +	HANDLER_UACCESS,
> > +	HANDLER_OTHER
> 
> EX_HANDLER_* I guess - HANDLER is too generic.

Yup. Will change.

> > @@ -125,17 +125,21 @@ __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
> >  }
> >  EXPORT_SYMBOL(ex_handler_clear_fs);
> >  
> > -__visible bool ex_has_fault_handler(unsigned long ip)
> > +__visible enum handler_type ex_fault_handler_type(unsigned long ip)
> 
> Why __visible?

I didn't look that hard at this. Just kept the same because the
function I was replacing was also __visible.

But it looks like this commit:

  80a3e3949b8f ("x86/extable: Mark exception handler functions visible")

shouldn't have touched this function. This one is only called from C code,
not from assembler like the others.

Will drop the __visible (and note in commit comment)

Thanks

-Tony
