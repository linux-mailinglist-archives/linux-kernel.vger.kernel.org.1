Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CA627F6C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbgJAAcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:32:45 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38769 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgJAAco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:32:44 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1DE765C01DC;
        Wed, 30 Sep 2020 20:32:43 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 30 Sep 2020 20:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=7iVclnjtb+ZxeNGDw5R5J/Z8lQdkETx
        CyZCJnR5NxK4=; b=BGtsAX97KXU6nFh2xvJcxeHU5kgHezXiqIlPOEn1bqG2+6C
        oPO4+zpjV9OshB9+WDBTtBCt8r0j9K8s1nvCN0aCcdkACXCuGKKaYeAWOJd7PzQk
        NGiUzT6VVQNC1p5iMBhj4kjvWdtg6LpZOI6GAgWOVKB2TpKUr3B+d354pV8iCFMD
        VJEZjW0z+ixey8yGR5MBounlJDnAvq88O9yIump/epCqTizcNRcSDSzML7czxdqQ
        hBr+5Ysr1/eL56ZnTWaQPJWz6qZu30LHOhfUkZCw14FQLNY7C8xCAk2v0F84WaNH
        mkmfy8CPeM4/T1QCHWiwwHgRabYexBxYSUzxJbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=7iVcln
        jtb+ZxeNGDw5R5J/Z8lQdkETxCyZCJnR5NxK4=; b=WMbYywhMTt/NGpDH28mNZ1
        Oq92+VFkP5KDdB/RkTYF716PF/bnewo80ASZhlmHFWq78KRRppjvcWfB6qoLXx6+
        sIKtaDaKzKvU0krpmw8pf9z0RZS220fLC7S804T0SZb1rFBTApRPWhiW6UvmcIYg
        AvHZcDidph3aOdjzps188FRGZzvSid8ZbIO1e6TGjYVK5Xv0FdvgJdFGEEMtdXtX
        Xad7j1vvNMftwcpnXfRz4LE4yphqzlm2b/RtwYgQ7vJOkhNfYVf5UDYwVZu4ASRB
        DpasnrWplNF7XUV85LbPqCC38QfgBYfnGttFLQhal/If5oNzwuMRH4KuJuL8UKoQ
        ==
X-ME-Sender: <xms:qSN1X6exQ6UzvWFFA_zGp-HrikC4ArBAO0Y4InA2D3Y-iu875dmGBQ>
    <xme:qSN1X0PKWA8omULUkw9ob6iKrF1JnjOjjBzwQ-Pn45M3pYQvBs7Bg1d1_az71J8i6
    EMHsLm-ea4cQEEX7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtffrrg
    htthgvrhhnpeehhfefkefgkeduveehffehieehudejfeejveejfedugfefuedtuedvhefh
    veeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:qSN1X7ioqtX8fafB7wYiZud-9C7hBrMiT_U6miiYB8PuQcKVnKOBqA>
    <xmx:qSN1X3-SwqvzGzfOI2tz53RLQ4OkDeAqbAXNBmdbGSx9sdasX8jHhg>
    <xmx:qSN1X2s-zlwcRkqz1m-xLTUIEqSyZYp8HxcLSfG045LOvcg8Lh7B-w>
    <xmx:qyN1X6jOrEhsmWuERU3PLRJXRfgkLan_w7jULFKN1UxQHPF1SCrBMA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 45F86E0181; Wed, 30 Sep 2020 20:32:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-382-ge235179-fm-20200928.002-ge2351794
Mime-Version: 1.0
Message-Id: <2b3c4303-ef63-4c34-be00-ff59abc32e69@www.fastmail.com>
In-Reply-To: <b7bcc925-b0da-446f-84a7-1a564a1f4f83@www.fastmail.com>
References: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
 <20200930090603.19891-1-billy_tsai@aspeedtech.com>
 <b7bcc925-b0da-446f-84a7-1a564a1f4f83@www.fastmail.com>
Date:   Thu, 01 Oct 2020 10:02:21 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Billy Tsai" <billy_tsai@aspeedtech.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Ryan Chen" <ryan_chen@aspeedtech.com>
Cc:     BMC-SW@aspeedtech.com
Subject: Re: [RESEND PATCH] ARM: dts: aspeed-g6: Fix gpio memory region
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Oct 2020, at 09:42, Andrew Jeffery wrote:
> Hi Billy,
> 
> On Wed, 30 Sep 2020, at 18:36, Billy Tsai wrote:
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > ---
> >  arch/arm/boot/dts/aspeed-g6.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
> > index 97ca743363d7..b9ec8b579f73 100644
> > --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> > +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> > @@ -357,7 +357,7 @@
> >  				#gpio-cells = <2>;
> >  				gpio-controller;
> >  				compatible = "aspeed,ast2600-gpio";
> > -				reg = <0x1e780000 0x800>;
> > +				reg = <0x1e780000 0x500>;
> 
> We took the 0x800 value from the memory space layout table in the datasheet for 
> the 2600. Should that be updated too? Or are you just limiting the region to 
> the registers currently described rather than the allocated address space?

Ah, actually, I see what's going on. We really have this layout (taking some liberties):

0x1e785000 - 0x1e785500: PGPIO 3.3V
0x1e785500 - 0x1e785600: SGPM1
0x1e785600 - 0x1e785700: SGPM2
0x1e785700 - 0x1e785740: SPGS1
0x1e785740 - 0x1e785780: SPGS2
0x1e785800 - 0x1e786000: PGPIO 1.8V

Ryan: Can you change the address space layout table to reflect this? That way it
still functions as a quick - but accurate - reference.

Andrew
