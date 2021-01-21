Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C0D2FE369
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbhAUHFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:05:48 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:43619 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbhAUHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:02:16 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210121070132epoutp04e67c477c5a13336938c03646f1adf700~cLTmamYCW0264602646epoutp041
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:01:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210121070132epoutp04e67c477c5a13336938c03646f1adf700~cLTmamYCW0264602646epoutp041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611212492;
        bh=ZyIfm2xerJ7n5eZHUm+VKML0WJUVbU46w1Su9fus1ig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o1qfHrx4UXH2syiLC2MKQAraI3AdEc5FGV7DPWKh1EUjanbg3YbccYqqYU4Rszi/u
         5ZQ8WwdbTZPx16/2v3XD98kJT7exMxOrxJArsnqVeUCP6vdS6UlvcY7DxB4qS8Jiio
         8zNUaJiTHs1GcgrrfovS/jdYD3roGy8zkRR7Mv/k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210121070128epcas2p3476ad921377c37a9fcadc8b70c541d7b~cLTi-oVDJ1164711647epcas2p31;
        Thu, 21 Jan 2021 07:01:28 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DLtbW1rfZz4x9Pw; Thu, 21 Jan
        2021 07:01:27 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.6A.10621.5C629006; Thu, 21 Jan 2021 16:01:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20210121070117epcas2p2f79aee8554d1c6d94e71efd0a4b248b4~cLTZArSEb1177811778epcas2p2K;
        Thu, 21 Jan 2021 07:01:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210121070117epsmtrp1dab25ef01fafa4412899263a1a181fdb~cLTY-5e6V3022230222epsmtrp1S;
        Thu, 21 Jan 2021 07:01:17 +0000 (GMT)
X-AuditID: b6c32a45-34dff7000001297d-bd-600926c5080c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.7E.13470.DB629006; Thu, 21 Jan 2021 16:01:17 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210121070117epsmtip1c8b35273b41ac8cd85b5ab0b52754318~cLTY2yNTs0633906339epsmtip1Q;
        Thu, 21 Jan 2021 07:01:17 +0000 (GMT)
Date:   Thu, 21 Jan 2021 15:49:56 +0900
From:   Jung Daehwan <dh10.jung@samsung.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
Message-ID: <20210121064956.GA69382@ubuntu>
MIME-Version: 1.0
In-Reply-To: <fbde7781-8eef-ab3a-a339-8a2f61ca83be@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTTPeoGmeCwZvdphbH2p6wWzQvXs9m
        cXnXHDaLRctamS1WLTjA7sDqsWlVJ5vH/rlr2D227P/M6PF5k1wAS1SOTUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgaFhgV5xYm5xaV66XnJ+rpWhgYGRKVBlQk7G828sBZsFK9q+zGRr
        YPzP28XIySEhYCKx9fFGpi5GLg4hgR2MEv0rt7FCOJ8YJaZvXMwG4XxjlFjavYkVpuXti5PM
        EIm9jBL7761jhHCeALXc3cwCUsUioCrx8+FsJhCbTUBL4t6PE8wgtoiAjsSBE+fBFjILXGKU
        mNzZxgaSEBZwl5h4+y5YM6+AtsSZOf9ZIWxBiZMzn4DFOQUcJCbOegU0iINDVEBF4tXBepA5
        EgKP2CVOrdrDDnGei8SUm8vZIGxhiVfHt0DFpSRe9rexg/RKCJRLLJpvB9HbwSix5tNZRoga
        Y4lZz9rBbGaBDIlH725C1StLHLnFAhHmk+g4/BcqzCvR0SYE0aksMf3yBGgASUocfH2OGaLE
        Q+LkOi1I8FxglPi+5CvzBEb5WUgem4VkGYStI7Fg9ye2WUDtzALSEsv/cUCYmhLrd+kvYGRd
        xSiWWlCcm55abFRgiBzXmxjBSVLLdQfj5Lcf9A4xMnEwHmKU4GBWEuF9ZMmRIMSbklhZlVqU
        H19UmpNafIjRFBhNE5mlRJPzgWk6ryTe0NTIzMzA0tTC1MzIQkmct9jgQbyQQHpiSWp2ampB
        ahFMHxMHp1QDU3uPvpeNsfgkp+OS7rMmc162vrtr99zb3+79SpD7u9Rogya7/ZITq48mvFv3
        oEbE+IVyJAPL7ytNKi5zz70OOb55xbEXEV0K9Y9nVE4xtVItt7IOLT/PkdfVqvFzK9PnpDVV
        olIBH3NKDlom3tpWk9b51sf57b4tfh1qqziuzYhj/VHez8Ttwnomxd3zm82/d7mykvpCKyZ6
        /dTmsN53udzxZ0NdvNHLpdunJdjenCe/8n1mi0Leji0VcnKrml7flKg6N937wXvrLP2C+UVn
        rnw4XFSxcv466wuc+m0r8x32nPvkIsWZmphYuuls5Npmi2CJJompESFKKb8/rbU6/tev6+Tx
        X2v/upmtqdoVqsRSnJFoqMVcVJwIAHhFKjQbBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsWy7bCSnO5eNc4Eg4U31S2OtT1ht2hevJ7N
        4vKuOWwWi5a1MlusWnCA3YHVY9OqTjaP/XPXsHts2f+Z0ePzJrkAligum5TUnMyy1CJ9uwSu
        jN9tD9gKPvNVNHzcydzAeIO7i5GTQ0LAROLti5PMXYxcHEICuxklnq/ZzwaRkJRYOvcGO4Qt
        LHG/5QgrRNEjRolDR7axgCRYBFQlfj6czQRiswloSdz7cYIZxBYR0JE4cOI8E0gDs8AlRonr
        9yCKhAXcJSbevgvWzCugLXFmzn+oqRcYJdpvzYVKCEqcnPkEzGYGmnrj30ugZg4gW1pi+T8O
        kDCngIPExFmvmEHCogIqEq8O1k9gFJyFpHkWkuZZCM0LGJlXMUqmFhTnpucWGxYY5qWW6xUn
        5haX5qXrJefnbmIEh7mW5g7G7as+6B1iZOJgPMQowcGsJML7yJIjQYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQam6MpJD3Pmex/SCtzu/0VW5ut1v4sP
        5KV51CarsPXO6Wlf9WvNxYN/HlgL2O7iP/qBX8vW8uAmgaufRGZ5bHh2xnUB263T64sVDjt4
        Wlv0Wz3NuHvhcYd7vF6msLiRqP7m2dOWTBFUe7B+SZCqYOIpR9tF80PMNbZPbM1I6T9db/w5
        ms944csoCetAj++1s9rfm7L/We4rEH9rv3fhW48VgQ/XrOty2zzZYMa7Z7buGmZ8LeyK+pHP
        zJxPPtgk5sMcsNJeacKznnMbeZcpcDvsfW/v9Efu+nrHnWJtnRoLG94L1p5imWzfsy6q/AKH
        ZvydhXPcr01UaeS7YNXDoMw84VcJs7qM1Tf5P5ryLxKUWIozEg21mIuKEwHB/zkU4gIAAA==
X-CMS-MailID: 20210121070117epcas2p2f79aee8554d1c6d94e71efd0a4b248b4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----WZLI4USkVYiVjVtGawWGutc5pNztY3GR2qy8kqsclN4GFAmP=_1566b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610
References: <CGME20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610@epcas2p2.samsung.com>
        <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
        <fbde7781-8eef-ab3a-a339-8a2f61ca83be@synopsys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------WZLI4USkVYiVjVtGawWGutc5pNztY3GR2qy8kqsclN4GFAmP=_1566b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

On Thu, Jan 21, 2021 at 01:00:32AM +0000, Thinh Nguyen wrote:
> Hi,
> 
> Daehwan Jung wrote:
> > Sometimes dwc3_gadget_pullup and dwc3_gadget_set_speed are called after
> > entering suspend. That's why it needs to check whether suspend
> >
> > 1. dwc3 sends disconnect uevent and turn off. (suspend)
> > 2. Platform side causes pullup or set_speed(e.g., adbd closes ffs node)
> > 3. It causes unexpected behavior like ITMON error.
> >
> > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > ---
> >  drivers/usb/dwc3/gadget.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index ee44321..d7d4202 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -2093,6 +2093,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >  	unsigned long		flags;
> >  	int			ret;
> >  
> > +	if (pm_runtime_suspended(dwc->dev))
> > +		return 0;
> > +
> >  	is_on = !!is_on;
> >  
> >  	/*
> > @@ -2403,6 +2406,9 @@ static void dwc3_gadget_set_speed(struct usb_gadget *g,
> >  	unsigned long		flags;
> >  	u32			reg;
> >  
> > +	if (pm_runtime_suspended(dwc->dev))
> > +		return;
> > +
> >  	spin_lock_irqsave(&dwc->lock, flags);
> >  	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
> >  	reg &= ~(DWC3_DCFG_SPEED_MASK);
> 
> This is already addressed in Wesley Cheng's patches. Can you try the
> latest changes of DWC3 in Greg's usb-next branch?
> 
> Thanks,
> Thinh

I checked Wesly Cheng's pathces but it's not same.
What I want to do for this patch is to avoid pullup from platform side.
(android in my case)

It's possible that platform side tries to pullup by UDC_Store after usb is already disconnected.
It can finally run controller and enable irq.

I think we have to avoid it and other possible things related to platform side.


------WZLI4USkVYiVjVtGawWGutc5pNztY3GR2qy8kqsclN4GFAmP=_1566b_
Content-Type: text/plain; charset="utf-8"


------WZLI4USkVYiVjVtGawWGutc5pNztY3GR2qy8kqsclN4GFAmP=_1566b_--
