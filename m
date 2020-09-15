Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278B426A4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIOMMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:12:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:45448 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgIOMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:09:50 -0400
IronPort-SDR: pW9dv9gQlygV3P8PyPYWcE8OxSkYE2xVbuZzm0oo4XNdbNpHqFfey6EUi9lRh+GjuNY7rDl5lN
 l5LM+55Xmmzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="156635715"
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="156635715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 05:09:30 -0700
IronPort-SDR: OpWECFioi/uB+JIHVoGKyrUR/3crHOVfLtUiFAzcVeHGWhFbEeLEPQyNAi1CCsSQgglLz5f7l6
 sjUV+OglDI7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,429,1592895600"; 
   d="scan'208";a="409182339"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 15 Sep 2020 05:09:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 15 Sep 2020 15:09:27 +0300
Date:   Tue, 15 Sep 2020 15:09:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/14] TCPM support for FRS and AutoDischarge
 Disconnect
Message-ID: <20200915120927.GA1139641@kuha.fi.intel.com>
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

If this is v6, then where are v2 - v5? And what changed? Why didn't
you just make this v2?


> I also rebased on to off of the recent usb-next tip:
> 5fedf0d295d3 (origin/usb-testing, origin/usb-next) Merge 5.9-rc3 into usb-next
> Which had the following changes causing merge conflict:
> 3ed8e1c2ac99 usb: typec: tcpm: Migrate workqueue to RT priority for processing events
> 6bbe2a90a0bb usb: typec: tcpm: During PR_SWAP, source caps should be sent only after tSwapSourceStart
> 
> Addressed comments from Heikki and Randy which have described in the
> individual commit's change history as well.
> 
> Badhri Jagan Sridharan (14):
>   usb: typec: tcpci: Add register definitions to tcpci
>   usb: typec: tcpci: Add support when hidden tx registers are
>     inaccessible
>   usb: typec: tcpci: update ROLE_CONTROL for DRP
>   usb: typec: tcpci: Add a getter method to retrieve tcpm_port reference
>   usb: typec: tcpci: Add set_vbus tcpci callback
>   dt-bindings: usb: Maxim type-c controller device tree binding document
>   usb: typec: tcpci_maxim: Chip level TCPC driver
>   dt-bindings: connector: Add property to set initial current cap for
>     FRS
>   usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)
>   usb: typec: tcpci: Implement callbacks for FRS
>   usb: typec: tcpci_maxim: Add support for Sink FRS
>   usb: typec: tcpm: Implement enabling Auto Discharge disconnect support
>   usb: typec: tcpci: Implement Auto discharge disconnect callbacks
>   usb: typec: tcpci_maxim: Implemnent set_auto_vbus_discharge_threshold
> 
>  .../bindings/connector/usb-connector.txt      | 128 ++++
>  .../devicetree/bindings/usb/maxim,tcpci.txt   |  44 ++
>  drivers/usb/typec/tcpm/Kconfig                |   5 +
>  drivers/usb/typec/tcpm/Makefile               |  13 +-
>  drivers/usb/typec/tcpm/tcpci.c                | 146 ++++-
>  drivers/usb/typec/tcpm/tcpci.h                |  43 ++
>  drivers/usb/typec/tcpm/tcpci_maxim.c          | 564 ++++++++++++++++++
>  drivers/usb/typec/tcpm/tcpm.c                 | 291 ++++++++-
>  include/dt-bindings/usb/pd.h                  |  10 +
>  include/linux/usb/pd.h                        |  19 +-
>  include/linux/usb/tcpm.h                      |  24 +-
>  include/linux/usb/typec.h                     |  13 +
>  12 files changed, 1266 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.txt
>  create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.c
> 
> 
> base-commit: 5fedf0d295d3ef69fd85fdee4cb68fd3756b54c2
> -- 
> 2.28.0.402.g5ffc5be6b7-goog

-- 
heikki
