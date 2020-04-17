Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2541AE1D3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgDQQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 12:07:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:31795 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgDQQHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:07:45 -0400
IronPort-SDR: sGF2UtUQ7xGoz1h9xvLAb7+Sh5MrjChB6GXIN1fF3zYsbd8U7vGdxJrXAq7/p/AgSTg/ymdUy3
 bVL0ULogRvFA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 09:07:41 -0700
IronPort-SDR: 1HQJvjnolJPKFAP62COZ9TMk7tX9XoyU6VSAa4A7mIedIlinFnA7I98Cnc8kxK0YKbxP0gp0PZ
 IYjUtkB9s9xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="364367135"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 17 Apr 2020 09:07:37 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 17 Apr 2020 19:07:36 +0300
Date:   Fri, 17 Apr 2020 19:07:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Ronald G. Minnich" <rminnich@gmail.com>
Cc:     "Ronald G. Minnich" <rminnich@google.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: controllers: intel-spi: Add support for
 command line partitions
Message-ID: <20200417160736.GE2586@lahna.fi.intel.com>
References: <20200417152613.176554-1-rminnich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417152613.176554-1-rminnich@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 08:26:11AM -0700, Ronald G. Minnich wrote:
> On Intel platforms, the usable SPI area is located several
> MiB in from the start, to leave room for descriptors and
> the Management Engine binary. Further, not all the remaining
> space can be used, as the last 16 MiB contains firmware.
> 
> To make the SPI usable for mtdblock and other devices,
> it is necessary to enable command line partitions so the
> middle usable region can be specified.
> 
> Add a part_probes array which includes only "cmdelineparts",
> and change to mtd_device_parse_register to use this part_probes.
> 
> Signed-off-by: Ronald G. Minnich <rminnich@google.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
