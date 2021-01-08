Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00A2EEEA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhAHIgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:36:52 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:52770 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbhAHIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:36:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610094991; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=FBXv1OEG0N3B6hZlapLTMyecBYVCSlwsfuCoe1hhnzA=; b=WWqoDApahEBQPYrLT9BASmTYUlNgx7LU5VRIfxc+Yo7jGezrGaDKGTXYND/49SuOBcDtxMK4
 ffpslMSYITCBysNsVRz7lviPSFFkiWZeorpVcL3luD2p56sSJwqchF5dLvfsck8Ju7tlqbVM
 KN31nPg0oHD6xjAveth41u7Bj0I=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5ff81973661021aa28804612 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 08:36:03
 GMT
Sender: jackp=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF7A8C433CA; Fri,  8 Jan 2021 08:36:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jackp)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3975C433C6;
        Fri,  8 Jan 2021 08:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3975C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jackp@codeaurora.org
Date:   Fri, 8 Jan 2021 00:35:59 -0800
From:   Jack Pham <jackp@codeaurora.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Message-ID: <20210108083559.GD31406@jackp-linux.qualcomm.com>
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
 <1609283011-21997-3-git-send-email-wcheng@codeaurora.org>
 <87k0srcyq7.fsf@kernel.org>
 <37f3412c-9e91-eb1e-3974-bb16546b4b39@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f3412c-9e91-eb1e-3974-bb16546b4b39@synopsys.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On Fri, Jan 08, 2021 at 02:19:30AM +0000, Thinh Nguyen wrote:
> Hi Wesley,
> 
> Felipe Balbi wrote:
> > Hi,
> >
> > Wesley Cheng <wcheng@codeaurora.org> writes:
> >> +void composite_reset(struct usb_gadget *gadget)
> >> +{
> >> +	/*
> >> +	 * Section 1.4.13 Standard Downstream Port of the USB battery charging
> >> +	 * specification v1.2 states that a device connected on a SDP shall only
> >> +	 * draw at max 100mA while in a connected, but unconfigured state.
> > The requirements are different, though. I think OTG spec has some extra
> > requirements where only 8mA can be drawn max. You need to check for the
> > otg flag. Moreover, USB3+ spec has units of 150mA meaning the device
> > can't draw 100mA (IIRC).
> >
> 
> We see issue with this patch series. For our device running at SSP, the
> device couldn't recover from a port reset and remained in eSS.Inactive
> state.
> 
> This patch series is already in Greg's usb-testing. Please review and
> help fix it.
> 
> We can see the failure once the patch "usb: gadget: configfs: Add a
> specific configFS reset callback" is introduced.

Hmm. Does your device use a legacy USB2 PHY (not generic PHY) driver,
and does it implement the usb_phy_set_power() callback? Because
otherwise this new configfs_composite_reset() callback would not have
changed from the original behavior since the newly introduced (in patch
1/3) dwc3_gadget_vbus_draw() callback would simply be a no-op if
dwc->usb2_phy is not present.

If it does turn out to be something with your PHY driver's set_power(),
it's still puzzling since it's directed to only the usb2_phy, so I'm
curious how telling it to draw 100mA could affect SSP operation at all.

Thanks,
Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
