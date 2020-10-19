Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD52928A2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgJSNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:55:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:51770 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbgJSNz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:55:28 -0400
IronPort-SDR: 40hB9xW/WnuhsSwq3i693M36LUwagbZjyRYinQgycHIfcrkJB7X7QdK0Fiv0psbO/bglmtx5LS
 rQ5rE7D+6csg==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="166257574"
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="166257574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 06:55:27 -0700
IronPort-SDR: 9D83PNF9XVXbPxxDX81V9DJwQUlAum87+ShWsbUDqmTtiQfaeSRTMsdKj9jYFRGdJg4707QgDc
 /nFY3D/Ol6sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,394,1596524400"; 
   d="scan'208";a="422187700"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 19 Oct 2020 06:55:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 19 Oct 2020 16:55:22 +0300
Date:   Mon, 19 Oct 2020 16:55:22 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v10 00/15] TCPM support for FRS and AutoDischarge
 Disconnect
Message-ID: <20201019135522.GJ1667571@kuha.fi.intel.com>
References: <20201008061556.1402293-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:15:41PM -0700, Badhri Jagan Sridharan wrote:
> Hi,
> 
> Made two changes:
> 
> 1. Added "additionalProperties: false" as suggested by Rob Herring in
> https://lore.kernel.org/linux-usb/20201005144618.GA154206@bogus/
> 
> 2. Removed FRS dts binding constants to address Rob Herring's comment in
> https://lore.kernel.org/linux-usb/20201006182940.GA2574941@bogus/

I skipped 12/15. I thought that we better wait for Rob's approval for
the device property.

> Thanks,
> Badhri
> 
> Badhri Jagan Sridharan (15):
>   usb: typec: tcpci: Add a getter method to retrieve tcpm_port reference
>   usb: typec: tcpci: Add set_vbus tcpci callback
>   dt-bindings: usb: Maxim type-c controller device tree binding document
>   usb: typec: tcpci_maxim: Chip level TCPC driver
>   dt-bindings: connector: Add property to set initial current cap for
>     FRS
>   usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)
>   usb: typec: tcpci: Implement callbacks for FRS
>   usb: typec: tcpci_maxim: Add support for Sink FRS
>   usb: typec: tcpm: frs sourcing vbus callback
>   usb: typec: tcpci: frs sourcing vbus callback
>   usb: typec: tcpci_max77759: Fix vbus stuck on upon diconnecting sink
>   usb: typec: tcpm: Parse frs type-c current from device tree
>   usb: typec: tcpm: Implement enabling Auto Discharge disconnect support
>   usb: typec: tcpci: Implement Auto discharge disconnect callbacks
>   usb: typec: tcpci_maxim: Enable auto discharge disconnect
> 
>  .../bindings/connector/usb-connector.yaml     |  26 +
>  .../devicetree/bindings/usb/maxim,tcpci.yaml  |  70 +++
>  drivers/usb/typec/tcpm/Kconfig                |   6 +
>  drivers/usb/typec/tcpm/Makefile               |  15 +-
>  drivers/usb/typec/tcpm/tcpci.c                | 102 +++-
>  drivers/usb/typec/tcpm/tcpci.h                |  30 +-
>  drivers/usb/typec/tcpm/tcpci_maxim.c          | 504 ++++++++++++++++++
>  drivers/usb/typec/tcpm/tcpm.c                 | 299 ++++++++++-
>  include/linux/usb/pd.h                        |  19 +-
>  include/linux/usb/tcpm.h                      |  27 +-
>  include/linux/usb/typec.h                     |  12 +
>  11 files changed, 1085 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/maxim,tcpci.yaml
>  create mode 100644 drivers/usb/typec/tcpm/tcpci_maxim.c

thanks,

-- 
heikki
