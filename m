Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163B62A2E98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgKBPsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:48:51 -0500
Received: from smtp1.axis.com ([195.60.68.17]:12960 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgKBPsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1029; q=dns/txt; s=axis-central1;
  t=1604332130; x=1635868130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=emDvkwZPIjF6WYVFC3RClAHvLgz7aKxTRQMdJvh2PTU=;
  b=gI6pruoP3AmM/j3DDMuH2tZ9NKrT4ZSQP1I8LK9hOzFDwcag0xyIcg8k
   rkiJkxX7yTIW8R2WdUPBut9RWJKonnjXx9CBzMTVES6DY5fOIPq3aTZ7d
   tPxBvm7l1miB5zN7mO+n5z1EsMtUjhxIBRwxgd4gag0KtIny33ise9l7a
   0WgmtDg8C9Ms9HF50sNWadtd2R53o6lpsXxhRS3sa0Y3eOJ8mYainikKG
   ASvKZQpPaSoSWG1rF7T0yLG239m17GVPPilMy6izWkGV5Rqmw6UMNYzyX
   fev6FjQ2z8chRqAiIS/0rSS/3K13cNtTsEBXmuUbjRBJhTlLu0at6xyvM
   g==;
IronPort-SDR: AK3nNE7zlFrr5B2n1yu5tDTXYhxfxQ2yXKLLsCDV+ddqsAT7mNk5HvBIRr27hrRC89hDAnP80K
 3hn6qDutnOuhVmP4s4D1zWlvHRltAznMUoBRhveab4UEvL+5z7Zknjux5AsL2BhZOqpi32SrxU
 D2ghFSDtTt3mrbRmeknX2bYh1jXvHM2itjdYkAybBGIgB8aRZ25ItKYOGK+dUFGk00jy3bkYSQ
 QXZL8+LBS94RlbheNpZ53sW67e2xTAmgWvFclGjdyhoDDvxLdLIPVgxu7XbQsgbPhHJvNzMzIh
 Vyc=
X-IronPort-AV: E=Sophos;i="5.77,445,1596492000"; 
   d="scan'208";a="14657650"
Date:   Mon, 2 Nov 2020 16:48:48 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <support.opensource@diasemi.com>,
        <kernel@axis.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] regulator: Add support for DA9121 regulator
Message-ID: <20201102154848.tm5nsydaukyd7rrw@axis.com>
References: <20201029151538.23463-1-vincent.whitchurch@axis.com>
 <20201029151538.23463-3-vincent.whitchurch@axis.com>
 <20201029152843.GC5042@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201029152843.GC5042@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:28:43PM +0000, Mark Brown wrote:
> On Thu, Oct 29, 2020 at 04:15:38PM +0100, Vincent Whitchurch wrote:
> 
> > +	config.init_data = of_get_regulator_init_data(dev, dev->of_node, &da9121_reg);
> > +	if (!config.init_data)
> > +		return -ENOMEM;
> 
> Don't do this, the core can do the DT bit for you and there is no reason
> not to register the device if there are no constraints.  -ENOMEM would
> also be the wrong error code here.

OK, thanks.  I see that I can get the core to do it if I set ->of_match
on the regulator_desc.  I also see that there is some flexibility about
the placement of the constraints (desc->regulators_node is optional).

This chip has only one output which the datasheet calls Buck1, so I will
remove this call and set the desc.of_match field to get the driver to
support a node which looks like this:

      regulator@68 {
        compatible = "dlg,da9121";
        reg = <0x68>;

        buck1 {
            regulator-min-microvolt = <675000>;
            regulator-max-microvolt = <825000>;
        };
      };
