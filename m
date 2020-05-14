Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB4B1D2CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 12:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgENKas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 06:30:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:21982 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgENKas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 06:30:48 -0400
IronPort-SDR: pLImOBEUxtXtVXtZ0mGTW5pmD2DmIC2OLwopBQZ2Kbra3LCRz+A0tDtSctqK7is9WpQSYQSUlc
 143frwlQKaDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 03:30:41 -0700
IronPort-SDR: r8Nk4+fFZDhHQX1Zr5aadLZd0qYhhg8PahPl/N9JBp9dR1cRkCMqrCW/Bju5Hl2/p1DmAMRMdf
 RXckwUinazsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="464281101"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2020 03:30:39 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jZB8U-006bX7-7k; Thu, 14 May 2020 13:30:42 +0300
Date:   Thu, 14 May 2020 13:30:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Fengping Yu <fengping.yu@mediatek.com>
Cc:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/3] drivers: input: keyboard: Add mtk keypad driver
Message-ID: <20200514103042.GA185537@smile.fi.intel.com>
References: <20200514061747.25466-1-fengping.yu@mediatek.com>
 <20200514061747.25466-3-fengping.yu@mediatek.com>
 <20200514102701.GZ185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514102701.GZ185537@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:27:01PM +0300, Andy Shevchenko wrote:
> On Thu, May 14, 2020 at 02:17:48PM +0800, Fengping Yu wrote:
> > From: "fengping.yu" <fengping.yu@mediatek.com>
> > 
> > This adds matrix keypad support for Mediatek SoCs.
> 
> ...
> 
> > +config KEYBOARD_MTK_KPD
> > +	tristate "MediaTek Keypad Support"
> 
> > +	depends on OF && HAVE_CLK
> 
> What makes it OF dependent?

Actually you missed regmap dependencies or selection. I dunno which one should
be used (IIRC selection).

> > +	help
> > +	  Say Y here if you want to use the keypad on MediaTek SoCs.
> > +	  If unsure, say N.
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called mtk-kpd.


-- 
With Best Regards,
Andy Shevchenko


