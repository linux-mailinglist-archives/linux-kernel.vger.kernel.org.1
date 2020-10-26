Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5408D299107
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783906AbgJZPby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:31:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:64147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783897AbgJZPbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:31:53 -0400
IronPort-SDR: yUGGHUg4V7QcFIae2F79HRr1yj3L/9m8/QB2hjvBNsVk+9KG/XLXdPkkWgim/qbcl3gSvfHsiO
 CTAJgRWwoQIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="147795145"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="147795145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 08:31:51 -0700
IronPort-SDR: 5rYE6EcBTdOMe+GccR8gvcxNgSZQUIIpQhXQpDOeRZUPsakbGqXgUah8u6BhLjPnMET5B1u/JU
 ++286BiylgqQ==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="350152841"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 08:31:48 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 26 Oct 2020 17:31:45 +0200
Date:   Mon, 26 Oct 2020 17:31:45 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, andriy.shevchenko@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] thunderbolt: Add the missed ida_simple_remove() in
 ring_request_msix()
Message-ID: <20201026153145.GE2495@lahna.fi.intel.com>
References: <20201015084053.56158-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015084053.56158-1-jingxiangfeng@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 04:40:53PM +0800, Jing Xiangfeng wrote:
> ring_request_msix() misses to call ida_simple_remove() in an error path.
> Add a label 'err_ida_remove' and jump to it.
> 
> Fixes: 046bee1f9ab8 ("thunderbolt: Add MSI-X support")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Applied to thunderbolt.git/fixes, thanks!
