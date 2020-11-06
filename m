Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297502A9075
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgKFHgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:36:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:26692 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgKFHgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:36:18 -0500
IronPort-SDR: lbkLOMzWeybjeFKzIeTPLywOMzGc6DVUyszgR2f/87Y98lCipjNv4jgVOAZrebCI2oBmGQejHq
 LYa3Ak1FewHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="166004523"
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="166004523"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 23:36:18 -0800
IronPort-SDR: gLGsKSgpUPznoyv8n67Rw5M+68wGylzyacufXs32ZWTj5kic45/CUvM7VvmmP+fAkMWMJy5Mzg
 4yPc4TwJ0y9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,455,1596524400"; 
   d="scan'208";a="427248745"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 Nov 2020 23:36:15 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 06 Nov 2020 09:36:15 +0200
Date:   Fri, 6 Nov 2020 09:36:15 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v3 2/2] usb: typec: Expose Product Type VDOs via sysfs
Message-ID: <20201106073615.GA4062920@kuha.fi.intel.com>
References: <20201023214328.1262883-1-pmalani@chromium.org>
 <20201023214328.1262883-2-pmalani@chromium.org>
 <20201104174917.GC3913249@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104174917.GC3913249@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 09:49:17AM -0800, Prashant Malani wrote:
> Hi All,
> 
> Was wondering if there were any comments on v3 of this series?

Sorry to keep you waiting with this...

I'm still wondering if the patch 2/2 is what we should use. Right now
I don't have really any better ideas. But give the rest of the week to
think about this.

thanks,

-- 
heikki
