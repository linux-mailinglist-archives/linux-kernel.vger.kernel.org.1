Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C52C3A58
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgKYHxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:53:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:40016 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgKYHxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:53:16 -0500
IronPort-SDR: ZYx2mFsbvW4+0s162//bTkHz3+wnGVw1t+GWCPJGzLow2rri/bVtf62MXUeEcz2+L2oYc7KPWt
 FaY4mTi1on8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151343657"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="151343657"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 23:53:15 -0800
IronPort-SDR: 0zahDQf4M1kcn9R34YpKYZC+Ks3rWWVdg1TsZ2qqj2b8QNeLRrCfjPLvGEaI1bze4akOgiVQPS
 dGVYDuiW8zdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="432882629"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 Nov 2020 23:53:13 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 25 Nov 2020 09:53:12 +0200
Date:   Wed, 25 Nov 2020 09:53:12 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, bleung@chromium.org
Subject: Re: [PATCH v4 1/2] usb: typec: Consolidate sysfs ABI documentation
Message-ID: <20201125075312.GF1008337@kuha.fi.intel.com>
References: <20201124201033.592576-1-pmalani@chromium.org>
 <20201124203235.GA517388@google.com>
 <20201125074603.GE1008337@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125074603.GE1008337@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 09:46:06AM +0200, Heikki Krogerus wrote:
> On Tue, Nov 24, 2020 at 12:32:35PM -0800, Prashant Malani wrote:
> > Hi,
> > 
> > On Tue, Nov 24, 2020 at 12:10:31PM -0800, Prashant Malani wrote:
> > > Both partner and cable have identity VDOs. These are listed separately
> > > in the Documentation/ABI/testing/sysfs-class-typec. Factor these out
> > > into a common location to avoid the duplication.
> > > 
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > Acked-by: Heikki Krogerus <heikki.krogeurus@linux.intel.com>
> > I copied the Acked-by line from v3 [1] as is, but looks like there was a
> > typo there and the email address should be
> > "heikki.krogerus@linux.intel.com".
> > 
> > Please let me know if it's fine as is or whether I should send another
> > patchset.
> 
> It is fine. Thanks for taking care of that :-)

Arch, no. It's not fine (I don't know what I'm talking about there). I
think it would be better that you do resend.

thanks,

-- 
heikki
