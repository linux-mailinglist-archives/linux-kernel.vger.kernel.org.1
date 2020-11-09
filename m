Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF522AB538
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgKIKno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:43:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:63573 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgKIKno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:43:44 -0500
IronPort-SDR: CBrc/3zF+AxZNahoKoNLRjWIkwn3NzEq1h3nGTvAM2PvUfh8wBX4bGq/hXd04UdEIHe8it4B4G
 FGXiZgZ6+1LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="157565334"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="157565334"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:43:43 -0800
IronPort-SDR: QssM4JRppmN870+5zeayVWKZ+9jprtXYFBLDzo0V9+GlkzYMVH2b5P2hXyK6EHPScyKjZekG8/
 fp6KUmhnXrPQ==
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="540792752"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:43:41 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kc4fD-0059Wt-V0; Mon, 09 Nov 2020 12:44:43 +0200
Date:   Mon, 9 Nov 2020 12:44:43 +0200
From:   'Andy Shevchenko' <andy.shevchenko@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
Message-ID: <20201109104443.GW4077@smile.fi.intel.com>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
 <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
 <56794a31-26ed-39eb-4082-75b5ec7cf28a@kernel.org>
 <CAHp75VeO6inzfRGSEBWgW0OCzjE9uT6LoXeQzHDdg4FiRemYWQ@mail.gmail.com>
 <88282a0514984e2b943628f1476c3bbd@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88282a0514984e2b943628f1476c3bbd@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:20:42AM +0000, David Laight wrote:
> > On Mon, Nov 9, 2020 at 11:57 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > > On 06. 11. 20, 17:06, Andy Shevchenko wrote:

...

> > > Another instance of an even worse switch:
> > > -               if (arg & ~0x77)
> > > +               if (arg & ~(GENMASK(6, 4) | GENMASK(2, 0)))
> > 
> > It exactly shows what bits we are accepting and what are not. 0x77 you
> > need to translate to the bitmap and then figure out the bit numbers.
> > This is error prone as shown in some cases.
> 
> We all know what 0xff and 0x77 mean.

Oh, do you expect one with curiosity and absence of C/Linux kernel experience
may not try to understand the code easily? We have real examples of such
curious people, and honestly I admire them much more than people who knows what
0x77 or 0xff means in every case by heart (yes, at some point of time I used to
program Z80 directly from my mind in assembly, but does it really a must for
a curious reader / contributor?).

> It is ingrained from years of writing software.
> 
> Now it may be that the 0x77 is related to masking off
> some other bit values.
> In that case you could have a named constant based on the
> names of the other bit values.
> But if you are putting in simple constants there is nothing
> wrong with hex.

It makes code harder to understand. Besides that GENMASK() and BIT() avoids UB
which is often happen when programmers doesn't think about (yes, we may discuss
about poorness of C standard etc, but this what we have now).

-- 
With Best Regards,
Andy Shevchenko


