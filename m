Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0A22FAB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394325AbhARUdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:33:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:11977 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388775AbhARKiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:38:46 -0500
IronPort-SDR: X8W3KY2KAi7Hh7nwtXNUS/V01PsXq/lz/r8bJECokesqxM8oFmiR3X75hWxpXWw/IsfZuxjMyR
 Nd7AKHknjt9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="165875940"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="165875940"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:36:58 -0800
IronPort-SDR: 4CKY186Jke9fZ2XXwQDWU/oL++KfjHpQW1zZrzgKm+INR6pXPFCZG3EhnZ5xYL0xzzO8mvqUI9
 NH2kyEdoodWQ==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="399078589"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:36:55 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id EBA03208D7; Mon, 18 Jan 2021 12:36:53 +0200 (EET)
Date:   Mon, 18 Jan 2021 12:36:53 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2] software_node: Add kernel-doc comments to exported
 symbols
Message-ID: <20210118103653.GY11878@paasikivi.fi.intel.com>
References: <20210113000209.322218-1-djrscally@gmail.com>
 <20210118094945.GX11878@paasikivi.fi.intel.com>
 <20210118103355.GZ4077@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118103355.GZ4077@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:33:55PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 18, 2021 at 11:49:46AM +0200, Sakari Ailus wrote:
> > On Wed, Jan 13, 2021 at 12:02:09AM +0000, Daniel Scally wrote:
> 
> > > + * to_software_node() - Fetch software node associated with a firmware node handle
> > 
> > Please wrap lines over 80 (unless there's a reason to keep them longer).
> 
> Does kernel-doc behave good when you wrap the function summary line?

It does, it's not uncommon to have it split across over multiple lines.

-- 
Sakari Ailus
