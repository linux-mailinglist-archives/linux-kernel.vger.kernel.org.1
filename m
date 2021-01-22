Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4863002C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbhAVMUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:20:03 -0500
Received: from mga11.intel.com ([192.55.52.93]:30071 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbhAVMJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:09:11 -0500
IronPort-SDR: VQX6iC0+GXyB/EOk3fIQEa4ptAMZTpJyDwz3opKJfgI0s8upgnWwpAJyNWalgX+XVSh1lUHNCS
 /4ViAeqWXXTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="175925333"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="175925333"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 04:07:20 -0800
IronPort-SDR: xdVWlbzc54tcrmDSsFUuM6XScKmUbE3MtfxlwnP0YOKqkRRGgcuHMmnzJ9b4QpRXHgNjwCiUsh
 3CEAABFE9/Gg==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="367399401"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 04:07:18 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2vEj-008qU9-7Q; Fri, 22 Jan 2021 14:08:21 +0200
Date:   Fri, 22 Jan 2021 14:08:21 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] misc: pti: Remove driver for deprecated platform
Message-ID: <YArANXckLdSUoWNZ@smile.fi.intel.com>
References: <20210122114358.39299-1-andriy.shevchenko@linux.intel.com>
 <CAK8P3a2qdugQt61nZ-nabnCsDLCwD5r_9e6tXKksmbue4hJBoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2qdugQt61nZ-nabnCsDLCwD5r_9e6tXKksmbue4hJBoQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 12:58:32PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 22, 2021 at 12:43 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Intel Moorestown and Medfield are quite old Intel Atom based
> > 32-bit platforms, which were in limited use in some Android phones,
> > tablets and consumer electronics more than eight years ago.
> >
> > There are no bugs or problems ever reported outside from Intel
> > for breaking any of that platforms for years. It seems no real
> > users exists who run more or less fresh kernel on it. The commit
> > 05f4434bc130 ("ASoC: Intel: remove mfld_machine") also in align
> > with this theory.
> >
> > Due to above and to reduce a burden of supporting outdated drivers
> > we remove the support of outdated platforms completely.
> >
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Does this mean drivers/sfi/ can get killed off along with
> arch/x86/platforms/{intel-mid,sfi}, or are there still other
> machines using that?

Yes, but it's hard to get Len's attention on it.

FWIW, look at [1].

[1]: https://gitlab.com/andy-shev/next/-/tree/topic/mid-removal

-- 
With Best Regards,
Andy Shevchenko


