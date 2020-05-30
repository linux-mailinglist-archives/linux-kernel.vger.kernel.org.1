Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942EA1E92C8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgE3RP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 13:15:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:9738 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728927AbgE3RP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 13:15:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49Z7PQ0Llbz6R;
        Sat, 30 May 2020 19:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1590858954; bh=Z3I4iqZssynvHyIKkwc6iDvd5nliuSp4CpNF2Pe2wjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOSBYLRusv3Q/rjMxE1zs2NN4DEyNHJGK/TmI/Pn73IjzqCb6n9BeQbySI153D5Of
         /EDPJmGkaNznqiFa+bv6jj4gH2kAMt4Z0U3DiHypy2RlaajEwXoxVbvv95lUYdGeqC
         uDhDzQpqBm2HA+arpNXgw+11Jxyqhx8z9sLbHpTIqFMao6kPRt3E2jdQrpbrLUrbBP
         6YmTxTtDiyKfzPmoeFi4czir6i/1Eh6dal0C0tOow1zhQ2PJ0Fnavd/hNcV36QIrOm
         mK2vqSes+ekR/yE3VBQLDGPOUkZzmR+DhGscx4q0GAE3rCvQ/kM81JuwRQJC3pisd8
         aw7UAjoOUmqhg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Sat, 30 May 2020 19:15:52 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Peter Chen <peter.chen@nxp.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_acm: don't disable disabled EP
Message-ID: <20200530171552.GC16333@qmqm.qmqm.pl>
References: <237e4bc8c63680f9ce0388d35b4c34a856ed8595.1590690518.git.mirq-linux@rere.qmqm.pl>
 <20200529081104.GD32755@b29397-desktop>
 <20200529135524.GA14614@qmqm.qmqm.pl>
 <AM7PR04MB715735B54F24293ABF7B37908B8C0@AM7PR04MB7157.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM7PR04MB715735B54F24293ABF7B37908B8C0@AM7PR04MB7157.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 01:03:17AM +0000, Peter Chen wrote:
>  
> > > > @@ -425,9 +425,11 @@ static int acm_set_alt(struct usb_function *f, unsigned
> > intf, unsigned alt)
> > > >  	/* we know alt == 0, so this is an activation or a reset */
> > > >
> > > >  	if (intf == acm->ctrl_id) {
> > > > -		dev_vdbg(&cdev->gadget->dev,
> > > > -				"reset acm control interface %d\n", intf);
> > > > -		usb_ep_disable(acm->notify);
> > > > +		if (acm->notify->enabled) {
> > > > +			dev_vdbg(&cdev->gadget->dev,
> > > > +					"reset acm control interface %d\n", intf);
> > > > +			usb_ep_disable(acm->notify);
> > > > +		}
> > >
> > > But it does not fix any issues, the usb_ep_disable checks 'enabled' flag.
> > 
> > It generates spurious trace events if you enable them.
> You mean the trace events from core.c? If it is, we could try to improve it
> and indicate it is already enabled or disabled.

It is indicated in return code, but the problem is that this generates
noise and wastes debugging time. The problem I was seeing manifested
itself as disabling disabled EPs and desync of EP state between core
and UDC driver. The patch avoids the noise and makes the code obvious.
(This check was there at some point in time, BTW.)

Best Regards,
Micha³ Miros³aw
