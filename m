Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63C2FCFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbhATLzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:55:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:36525 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387527AbhATLli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:41:38 -0500
IronPort-SDR: sDMf9y9OXPuiTi+mjotVRrSAHVF8UsS30Nakny7+Nepx3QxuXxs7hLAVlQRyRsSw+t7PZs5qj4
 yKin2yY5B/Kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158268631"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="158268631"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 03:39:48 -0800
IronPort-SDR: QzjC7Izy49EIQuw0goGZNWXj5QBSMQf/kSC2+SKsQyQGjGGBnIFOHcUWWoIKQqv+NxZMCIpiun
 lNrAc7LnJ2Ew==
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="402710943"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 03:39:46 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2Bqy-0065ek-TL; Wed, 20 Jan 2021 13:40:48 +0200
Date:   Wed, 20 Jan 2021 13:40:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com,
        rdunlap@infradead.org
Subject: Re: [PATCH v3] software_node: Add kernel-doc comments to exported
 symbols
Message-ID: <YAgWwC5eGojvmWCj@smile.fi.intel.com>
References: <20210120000339.471117-1-djrscally@gmail.com>
 <20210120103504.GH11878@paasikivi.fi.intel.com>
 <c4578b2a-c9a3-bf9d-8c5a-1ea3b1afedb2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4578b2a-c9a3-bf9d-8c5a-1ea3b1afedb2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:11:47AM +0000, Daniel Scally wrote:
> On 20/01/2021 10:35, Sakari Ailus wrote:
> > On Wed, Jan 20, 2021 at 12:03:39AM +0000, Daniel Scally wrote:

> >> +/**
> >> + * fwnode_create_software_node() - Create and register a new software_node
> >> + * @properties: NULL terminated array of properties to assign to the new node
> >> + * @parent: Pointer to a &struct fwnode_handle to assign as parent to the new
> >> + *	    node
> >> + *
> >> + * NOTE: The pointer passed as @parent **must** be to a firmware node handle
> >> + * that was created by registering a software node, meaning is_software_node()
> >> + * must return true when passed that pointer.
> >> + *
> >> + * This function creates a new instance of &struct software_node, assigns it a
> >> + * copy of the given array of properties and registers it as a new fwnode_handle.
> >> + * Freeing of the allocated memory when the fwnode_handle is no longer needed is
> >> + * handled via software_node_release() and does not need to be done separately.
> > Please wrap all lines over 80 unless there's a reason to keep them longer.

> Apologies; I'll cat | awk for lines over the limit from now on rather
> than half-arsing it.

In Vim, for example, you may set the threshold and it will wrap it for you.
Also, taking into account famous *useless use of cat*, you may use `fold` or `fmt`

> >> + *
> >> + * Returns:
> >> + * * fwnode_handle *	- On success
> >> + * * -EINVAL		- When @parent is not associated with a software_node
> >> + * * -ENOMEM		- When memory allocation fails
> >> + * * -Other		- Propagated errors from sub-functions
> >> + */

-- 
With Best Regards,
Andy Shevchenko


