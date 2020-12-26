Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3194E2E2E46
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 14:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgLZNqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 08:46:37 -0500
Received: from mib.mailinblack.com ([137.74.84.110]:48866 "EHLO
        mib.mailinblack.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgLZNqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 08:46:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by mib.mailinblack.com (Postfix) with ESMTP id A713E1A0C8F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 13:45:54 +0000 (UTC)
Received: from mib.mailinblack.com (localhost [127.0.0.1])
        by mib.mailinblack.com
        with SMTP (Mib Daemon ) id KJ5RBB5Y;
        Sat, 26 Dec 2020 13:45:54 +0000 (UTC)
Received: from zimbra2.kalray.eu (zimbra2.kalray.eu [92.103.151.219])
        by mib.mailinblack.com (Postfix) with ESMTPS id 726091A0C8C;
        Sat, 26 Dec 2020 13:45:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 48F0A27E037B;
        Sat, 26 Dec 2020 14:45:54 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id kBewNzRAM07n; Sat, 26 Dec 2020 14:45:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 6B06F27E038D;
        Sat, 26 Dec 2020 14:45:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 6B06F27E038D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1608990353;
        bh=fgOzqQxzU52gKfSAIdzn9Y4OtV2/Ocd6nBnt3Hhg4Bc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QCUMrsn4YsWVW5VOtIdio2qmYp+FQjZFROx2pBbK/gqObDZU9eAWUqRhd+jj1uZS6
         4YcrK0wdoqLGBq6vS921mzarZ2cGpK3ReBItLXVXrNfcNmVeK2Knn/5CTS8xTlsuEo
         4M8Tm299ZIH8KV7ufamMElJ9tdJWyY8JKRJNqJAw=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Fk39_gqKPTl; Sat, 26 Dec 2020 14:45:53 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 51BB727E037B;
        Sat, 26 Dec 2020 14:45:53 +0100 (CET)
Date:   Sat, 26 Dec 2020 14:45:44 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: dwc2: Try usb_get_phy_by_phandle instead of
 usb_get_phy
Message-ID: <20201226134522.fqpsd2fzlri2rcni@tellis.lin.mbt.kalray.eu>
References: <20201216165935.9149-1-jmaselbas@kalray.eu>
 <d753fafc-a50a-d19b-d872-78f34dfa01ca@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d753fafc-a50a-d19b-d872-78f34dfa01ca@synopsys.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artur,

On Fri, Dec 25, 2020 at 11:41:04AM +0000, Artur Petrosyan wrote:
> > @@ -251,7 +251,12 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
> >   	}
> >   
> >   	if (!hsotg->phy) {
> > -		hsotg->uphy = devm_usb_get_phy(hsotg->dev, USB_PHY_TYPE_USB2);
> > +		if (hsotg->dev->of_node)
> > +			i = of_property_match_string(hsotg->dev->of_node, "phy-names", "usb2-phy");
> 
> According the device tree you have provided the value of "i" will always 
> be "0".
Yes

> > +		if (hsotg->dev->of_node && i >= 0)
> > +			hsotg->uphy = devm_usb_get_phy_by_phandle(hsotg->dev, "phys", i);
> 
> Why do you use the value of "i" while in "<&usb_phy0>" you have only one 
> phy. If you had several phy-names and the value of "i" gets more than 0, 
> then based on your usb_phy0 "devm_usb_get_phy_by_phandle" function will 
> return error. So, maybe it would be more correct (based on your device 
> tree), to use below command
> hsotg->uphy = devm_usb_get_phy_by_phandle(hsotg->dev, "phys", 0);
Yes I could use 0 instead of i, but I would like this to work not only
for my case where the "usb2-phy" phandle comes first.

I've tried to follow what's done in phy-core.c, as done by the function
phy_get. Where it first call "of_property_match_string" and then get the
phy with the matched index.

I don't see how, in my case, the function "devm_usb_get_phy_by_phandle" can
be called with i greater than 0, and returning an error.

Best,
Jules

