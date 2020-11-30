Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9E2C8371
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgK3LqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:46:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:31970 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbgK3LqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:46:17 -0500
IronPort-SDR: RKn/gd9KXLMAy8/VbrACMrw/71heikcMOSAUJKq0u5qBEL/53gcS8UYvmdGdVWoDe1aN+kXPP8
 UzS9+Zrhy3Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9820"; a="160392529"
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="160392529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 03:44:36 -0800
IronPort-SDR: s2R/T5uKFWY4B4ng2gvpMs5b4ntMCGvBV0Ah/SoNDQ6vELroI7EQIWxL68MolzqQ8VfU4xNtsE
 Fsky4thcQS4g==
X-IronPort-AV: E=Sophos;i="5.78,381,1599548400"; 
   d="scan'208";a="480623594"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 03:44:34 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 30 Nov 2020 13:44:31 +0200
Date:   Mon, 30 Nov 2020 13:44:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/12] thunderbolt: USB4 NVM upgrade improvements & Maple
 Ridge support
Message-ID: <20201130114431.GV5246@lahna.fi.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 06:55:11PM +0300, Mika Westerberg wrote:
> Hi all,
> 
> This series improves the USB4 router NVM upgrade functionality and adds
> support for USB4 router operations proxy implemented by recent Intel
> Thunderbolt firmware connection manager. The last patch adds support for
> Intel Maple Ridge that is the first discrete Thunderbolt/USB4 controller
> from Intel.
> 
> This also includes a couple of minor cleanups and improvements around
> debug logging.
> 
> Mika Westerberg (12):
>   thunderbolt: Move max_boot_acl field to correct place in struct icm
>   thunderbolt: Log which connection manager implementation is used
>   thunderbolt: Log adapter numbers in decimal in path activation/deactivation
>   thunderbolt: Keep the parent runtime resumed for a while on device disconnect
>   thunderbolt: Return -ENOTCONN when ERR_CONN is received
>   thunderbolt: Perform USB4 router NVM upgrade in two phases
>   thunderbolt: Pass metadata directly to usb4_switch_op()
>   thunderbolt: Pass TX and RX data directly to usb4_switch_op()
>   thunderbolt: Add connection manager specific hooks for USB4 router operations
>   thunderbolt: Move constants for USB4 router operations to tb_regs.h
>   thunderbolt: Add USB4 router operation proxy for firmware connection manager
>   thunderbolt: Add support for Intel Maple Ridge

All applied to thunderbolt.git/next.
