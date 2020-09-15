Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943D926A671
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 15:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIONo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 09:44:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:44272 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgIONmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:42:21 -0400
IronPort-SDR: uuk7rt+Bx5gRn6vhLtoIv0hXsKasV/ilT5Q9LcHstlAKPealUwj6CV3oeAChZowsSIuQvA1my4
 d8oH0ovxb4vQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="138760631"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="138760631"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:33:50 -0700
IronPort-SDR: j6TeeDyGh39bdU5PkSMdU1urcJOKOPuTNaIj4Pkf8xXLqQVkzQolliJ1Drn9AqnVOPjYEIKWfJ
 +H33ywpqXyDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="409202130"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 06:33:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 16:33:47 +0300
Date:   Tue, 15 Sep 2020 16:33:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/14] TCPM support for FRS and AutoDischarge
 Disconnect
Message-ID: <20200915133347.GK1139641@kuha.fi.intel.com>
References: <20200901025927.3596190-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901025927.3596190-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:59:13PM -0700, Badhri Jagan Sridharan wrote:
> First of all apologies for mixing up the patch version as noted by
> Heikki and Greg. All of them were v1's but since I was manually adding
> the version numbers I mixed them up. Using the --reroll-count option
> now. Updating the patch version to v6 (highest version number in the
> previous patchset + 1) to avoid confusion.
> 
> I also rebased on to off of the recent usb-next tip:
> 5fedf0d295d3 (origin/usb-testing, origin/usb-next) Merge 5.9-rc3 into usb-next
> Which had the following changes causing merge conflict:
> 3ed8e1c2ac99 usb: typec: tcpm: Migrate workqueue to RT priority for processing events
> 6bbe2a90a0bb usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart
> 
> Addressed comments from Heikki and Randy which have described in the
> individual commit's change history as well.

I'll try to study the AutoDischarge a bit before reviewing the last
patches. They all appeared to be only about AutoDischarge. Sorry, I
didn't have time for that yet. If Guenter is fine with those, then
feel free to add my ACK to those patches. But Guenter really should
review these in any case. Hope he has time.

Br,

-- 
heikki
