Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36DA82AB583
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgKIKxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:53:53 -0500
Received: from mga14.intel.com ([192.55.52.115]:47402 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgKIKxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:53:53 -0500
IronPort-SDR: kZjDxM7EyUyJf0E1UIRyTIGe+g8yF65biy7y0ZOQtrLYXuzSSqkiCpYMoaOOb5sKfgtZkBE1M6
 3vyZ+x3TPFKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="168998713"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="168998713"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:53:48 -0800
IronPort-SDR: NTCpmKnf5EdAo+iIXcsujuo6fkf3g4ItRHgCV/UPeGyFvVhap4eGgt/oUyTEx4IvsQ0JiLYPcf
 Db1hWDEeRvqw==
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="327228204"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 02:53:47 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kc4oz-0059eK-3s; Mon, 09 Nov 2020 12:54:49 +0200
Date:   Mon, 9 Nov 2020 12:54:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 1/3] vt: keyboard, use GENMAASK()/BIT() macros instead
 of open coded variants
Message-ID: <20201109105449.GX4077@smile.fi.intel.com>
References: <20201106143551.43908-1-andriy.shevchenko@linux.intel.com>
 <e461a47754974c0d8d0b61981b77ae80@AcuMS.aculab.com>
 <CAHp75VfTFL_7bJ5HyyuATVk32+buD9JoNDhyf1noAfoFGqJ_OQ@mail.gmail.com>
 <56794a31-26ed-39eb-4082-75b5ec7cf28a@kernel.org>
 <CAHp75VeO6inzfRGSEBWgW0OCzjE9uT6LoXeQzHDdg4FiRemYWQ@mail.gmail.com>
 <20201109102759.GT4077@smile.fi.intel.com>
 <0bbc9282-3655-26f3-468f-4dccd7ded741@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0bbc9282-3655-26f3-468f-4dccd7ded741@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 11:41:31AM +0100, Jiri Slaby wrote:
> On 09. 11. 20, 11:27, Andy Shevchenko wrote:
> > On Mon, Nov 09, 2020 at 12:10:27PM +0200, Andy Shevchenko wrote:
> > > On Mon, Nov 9, 2020 at 11:57 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > > > On 06. 11. 20, 17:06, Andy Shevchenko wrote:
> > 
> > ...
> > 
> > > > sorry,
> > > 
> > > Consider this then as RFC.
> > > What about the rest of the series?
> > 
> > I got the answer, thanks!
> > So, I will drop the first patch and resend the rest with your Ack.
> 
> As I wrote the BIT pieces are mostly fine too…

Okay, I will try again with BIT() conversion only.

-- 
With Best Regards,
Andy Shevchenko


