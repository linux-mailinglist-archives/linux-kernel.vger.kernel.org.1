Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7624B2FABB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437739AbhARUk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:40:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:11758 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388123AbhARKeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:34:46 -0500
IronPort-SDR: lWHaNGI0fEk8EESmn4AnKcEc9XN7qMxX+R6+LFy+0gHb0j2q+NFzwRKLUmD0YMug/c8cExj4zV
 CQcl7+nFVA3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="165875674"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="165875674"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:32:54 -0800
IronPort-SDR: XNsg8r+7X51sKJdWzEP/HXibKgWg2YheMWmfaX+Ki6PgAh528fj6VYxgm++ot2Sm74MRpYYjrA
 sgoMmGzjibXg==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="466322458"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 02:32:53 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1Rr9-0020Mn-Na; Mon, 18 Jan 2021 12:33:55 +0200
Date:   Mon, 18 Jan 2021 12:33:55 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Daniel Scally <djrscally@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2] software_node: Add kernel-doc comments to exported
 symbols
Message-ID: <20210118103355.GZ4077@smile.fi.intel.com>
References: <20210113000209.322218-1-djrscally@gmail.com>
 <20210118094945.GX11878@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094945.GX11878@paasikivi.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 11:49:46AM +0200, Sakari Ailus wrote:
> On Wed, Jan 13, 2021 at 12:02:09AM +0000, Daniel Scally wrote:

> > + * to_software_node() - Fetch software node associated with a firmware node handle
> 
> Please wrap lines over 80 (unless there's a reason to keep them longer).

Does kernel-doc behave good when you wrap the function summary line?
My impression that summary should be one line.

-- 
With Best Regards,
Andy Shevchenko


