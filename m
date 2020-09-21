Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA92D2727D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgIUOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:38:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:54160 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgIUOiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:38:04 -0400
IronPort-SDR: MyLTTzPZNdRs1y9knQA5YT7HkU3PA6A/V8vEpxP6Pf3ZXE/sOOctC3+xL+Ok2rG7Jyc7tooLHE
 DmAS7mntPx8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="148137710"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="148137710"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 07:38:01 -0700
IronPort-SDR: Yr6Ou9Kpp30JO3lehVBuzaR7PSPo27rLfaSBy8DT+QX8KxyTQEW4BXepBPQWuiBoDqB+JMg3QN
 oBSotKLc1gxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="412309314"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 21 Sep 2020 07:37:58 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 21 Sep 2020 17:37:57 +0300
Date:   Mon, 21 Sep 2020 17:37:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     kernel@puri.sm, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: Re: [PATCH 0/4] RFC: USB C extcon patchset for the tps6598x
Message-ID: <20200921143757.GG1630537@kuha.fi.intel.com>
References: <20200914164639.1487650-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914164639.1487650-1-angus@akkea.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:46:35AM -0700, Angus Ainslie wrote:
> We have a complex set of hardware components to manage our USB C data and
> power. For these to work together we decided to use extcon to communicate
> the system changes as various cables and devices are plugged in/out. We did
> look at usb_roleswitch and the charging framework but thought it would be
> preferable to keep all of the information together in one system.
> 
> The components we have in the system are:
> 
> 1) TPS65982 type USB type C controller
> 2) dwc3 IP in the imx8mq
> 3) BQ25895 battery charger
> 
> I'll break this into 2 parts the data role and the power role.
> 
> For the data role the TPS65982 senses connect and disconnect as well as data
> source/sink. It is also controlling the USB 3 data lanes. The display port and
> USB 3 muxing is handled by a different chip and we'll submit patches for that
> later on. The dwc3 controls the USB 2 data lanes.
> 
> On the power side there are even more moving pieces. The TPS65982 negotiates
> the power delivery contract, the dwc3 senses the BC1.2 charging current and the
> BQ25895 sets whether we are sinking or sourcing current and what the current
> limit is of the sink and source.
> 
> For both the data and power roles no single chip has all of the required
> information. Is using extcon the correct way of doing this and if not what
> are the alternatives ?

Do not use extcon with the Type-C drivers unless you have some really
good reason for not using the dedicated frameworks for each thing. The
reason why we even have some of the dedicated frameworks in the first
place, for example the USB role switch class, is because extcon simply
could not be made to work on every type of hardware architecture.

So you will need to register a power supply in tps6598x.c just like
the other USB Type-C drivers like tcpm.c and ucsi.c if the TPS65982
does not communicated directly with the BQ25895. That can be one
of "supplied_from" (and also "supplied_to" if needed for sourcing) for
the bq25890_changer. You probable only need to implement the
external_power_changed() hook for it if it's missing in order to make
it work. You can also register a power supply in dwc3 and use it as a
second supply for bq25890 if you still really need to handle BC1.2.

The data role should already be handled for you. dwc3 already
registers an USB role switch, and tps6598x.c already configures one.
For data role you should not need any additional code.

Please note that there is also framework for the alt mode muxes.


> The extcon extensions allow us to communicate the the power roles amongst
> the various chips.
> 
> This patch series has been tested with the 5.9-rc4 kernel on the Purism
> Librem5 HW. Assuming this is the correct way to use extcon there will be
> follow on patches to the BQ25895 and dwc3 drivers.
> 
> Strictly speaking only the first 3 patches are needed for extcon support, the
> forth patch decodes the power delivery contracts which makes use of the extcon
> system.
> 
> 
> Angus Ainslie (4):
>   extcon: Add USB VBUS properties
>   usb: typec: tps6589x: register as an extcon provider
>   usb: typec: tps6598x: Add the extcon USB chargers
>   usb: typec: tps6598x: Add the power delivery irq
> 
>  drivers/usb/typec/tps6598x.c | 488 ++++++++++++++++++++++++++++++++++-
>  include/linux/extcon.h       |  17 +-
>  2 files changed, 503 insertions(+), 2 deletions(-)
> 
> -- 
> 2.25.1

thanks,

-- 
heikki
