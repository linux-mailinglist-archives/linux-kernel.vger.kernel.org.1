Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF625140A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 10:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgHYITk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 04:19:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:52905 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgHYITj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:19:39 -0400
IronPort-SDR: do3N9EIsd6ZK3JHn6ss/p2E9zqwYJpxXjSSZNI3w9bSslftRgOMFqeC17WJnt7S+9Idyr2C14g
 aAbHx0ED4lyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="174105425"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="174105425"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 01:19:39 -0700
IronPort-SDR: IAyy3XvyJQ+SAT+IwGXbxMgmsJ1zhfw2TY4/QER4Co/2ItAYsuTyCJU8mYDU6OdgbX3Cth9jyR
 XFHHFRaYByzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="402642901"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 25 Aug 2020 01:19:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Aug 2020 11:19:35 +0300
Date:   Tue, 25 Aug 2020 11:19:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
Message-ID: <20200825081935.GE189773@kuha.fi.intel.com>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818084044.GD1891694@smile.fi.intel.com>
 <69e13a74-8b8d-cbc0-915d-ce289e7d4a70@linux.intel.com>
 <CAHp75VfwBnDgR6WR_On1nh+dX4meWrX1Q-CiUKqkV39=o2m5Hg@mail.gmail.com>
 <b9187c39-8d94-6b41-9e1c-b95161b17c1c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9187c39-8d94-6b41-9e1c-b95161b17c1c@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 04:45:38PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> Hi Andy,
> 
> On 19/8/2020 3:55 pm, Andy Shevchenko wrote:
> > On Wed, Aug 19, 2020 at 8:38 AM Ramuthevar, Vadivel MuruganX
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> > > On 18/8/2020 4:40 pm, Andy Shevchenko wrote:
> > > > On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> > > > > USB external connector chip PTN5150 used on the Intel LGM SoC
> > > > > boards to detect the USB type and connection.
> > > > Internally I meant you can send cleanups, but couple of patches here are the
> > > > features and were still under discussion... But here we are.
> > > 
> > > you mean asking us to implement the Heikki suggested as below..
> > > 
> > > Heikki Krogerus: register the port and the partner attached to it with
> > > the USB Type-C connector class in the driver. Is my understaanding
> > > right? if not, please explain it. Thanks!
> > 
> > When you mention somebody, don't forget to Cc them (now done by me).
> Sure, Thank you

So the patches 1-5 are fine. The rest needs to be rewritten.

thanks,

-- 
heikki
