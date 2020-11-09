Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C042AB4D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgKIK1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:27:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:45583 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgKIK06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:26:58 -0500
IronPort-SDR: bWS/+40ge1U4EInJfKTfr8Hb4qMbc70usPMpFwpHtuwKcFz+hzQ+CQ6Yzi79t0tVoWA8478cJ8
 VWz+4ROGUmeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="168996287"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="168996287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:26:58 -0800
IronPort-SDR: pOgkfBk4vIVkHuHNLdaDqbbv8Vhn6v7f9hu2VbhdBv3lfrEk2KtT0rqIIGuKJFrH6phQlIS9uT
 2TrnAG7brjcA==
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="530679062"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:26:57 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kc4P1-0059KW-M1; Mon, 09 Nov 2020 12:27:59 +0200
Date:   Mon, 9 Nov 2020 12:27:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
Message-ID: <20201109102759.GT4077@smile.fi.intel.com>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
 <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
 <56794a31-26ed-39eb-4082-75b5ec7cf28a@kernel.org>
 <CAHp75VeO6inzfRGSEBWgW0OCzjE9uT6LoXeQzHDdg4FiRemYWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeO6inzfRGSEBWgW0OCzjE9uT6LoXeQzHDdg4FiRemYWQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 12:10:27PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 9, 2020 at 11:57 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > On 06. 11. 20, 17:06, Andy Shevchenko wrote:

...

> > sorry,
> 
> Consider this then as RFC.
> What about the rest of the series?

I got the answer, thanks!
So, I will drop the first patch and resend the rest with your Ack.

-- 
With Best Regards,
Andy Shevchenko


