Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC92E26FE6D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgIRN0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgIRN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:26:48 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9031C0A88A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:26:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b2so4892502qtp.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WoBViBDy5KOAoh/IFmmvq1hFC5lBWKi3LJbgCVOvAak=;
        b=WYzV4JSwOKBbAILhniesAD87+6GNHfZR5/KF7g1OAVXOBUYVU0RnhtM8At1x4Bk1df
         kYIJ9CBPTEVTaILzPEdSu9Wd0Q/zSl1TpjnBO3BL6pTzXo3rXdVTWiW1kJy8Mb+Z7c4d
         98MAklpR8a0if5vyWmIyAJWccc7GOQowqHhpVTKG36+aW3Z4RXIHCCc3wciQAVV8mXxY
         kqF10jNHRevkzmywLc8XPbn+70spZ9GWaJhlf1AOI1zlm8BV4G7VRHRPIfu+b4R+qPaC
         +rOFj8yqyGYTqxReHcN2i0tbkUnq/TRYB9zmY7OnTwrtrUn+FhukGYCEcQgjI1wK4aCx
         FB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WoBViBDy5KOAoh/IFmmvq1hFC5lBWKi3LJbgCVOvAak=;
        b=nb0pML8Jt+wzmFA8N1FFjzPrYurV+P9CTDbMXTRDeGFWtK0FuJTUO7gIP0SQRlXMfl
         QpP134VZhr45FhLo29F5D+tCxS5fnUXTt3k+hN72bmeQyTV2qihjIOndjvjyA8eRT//T
         OuYgjiNcB6kFRJP0f12hyu14C0c4icAcznW2r4liiYzWHxMao0fHOj+SH8n+isclRHMZ
         RL8+GVipBJm98CXc/BR2gwGC3G0/fwozuP9gETgwUoG2rW/ug1NZN6wd6IH7HypAs7Sn
         hxubgFG7WnoeeMGhHSd8y38nKRrBKxu7/0VZTEkhGMU8dkCeOVVI1uQ0vTkpGYjm71XE
         SrvA==
X-Gm-Message-State: AOAM530K39c/+yygKi30NqpS5z3Byi1pnS6j7JHZoTjmdd2sPmcWr/Oe
        6jqWiou7P1ZRgvQCJr0nTX8jig==
X-Google-Smtp-Source: ABdhPJxCWlPb1YfzCc8AhG1VYILjRP3pn/B6quLeHYW7+F1CfmtAFFswxdVyqU645LsMkuSZG9dBCA==
X-Received: by 2002:aed:278a:: with SMTP id a10mr21145659qtd.261.1600435606823;
        Fri, 18 Sep 2020 06:26:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w128sm2015848qkb.6.2020.09.18.06.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:26:46 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJGPV-0017Py-F7; Fri, 18 Sep 2020 10:26:45 -0300
Date:   Fri, 18 Sep 2020 10:26:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     izur@habana.ai, Gal Pressman <galpress@amazon.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, SW_Drivers <SW_Drivers@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v3 00/14] Adding GAUDI NIC code to habanalabs driver
Message-ID: <20200918132645.GS8409@ziepe.ca>
References: <20200915133556.21268811@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAFCwf12XZRxLYifSfuB+RGhuiKBytzsUTOnEa6FqfJHYvcVJPQ@mail.gmail.com>
 <20200917171833.GJ8409@ziepe.ca>
 <0b21db8d-1061-6453-960b-8043951b3bad@amazon.com>
 <20200918115601.GP8409@ziepe.ca>
 <CAFCwf12G4FnhjzijZLh_=n59SQMcTnULTqp8DOeQGyX6_q_ayA@mail.gmail.com>
 <20200918121621.GQ8409@ziepe.ca>
 <CAFCwf12YBaka2w2cnTxyX9L=heMnaM6QN1_oJ7h7DxHDmy2Xng@mail.gmail.com>
 <20200918125014.GR8409@ziepe.ca>
 <CAFCwf12oK4RXYhgzXiN_YvXvjoW1Fwx1xBzR3Y5E4RLvzn_vhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf12oK4RXYhgzXiN_YvXvjoW1Fwx1xBzR3Y5E4RLvzn_vhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 04:02:24PM +0300, Oded Gabbay wrote:
 
> The problem with MR is that the API doesn't let us return a new VA. It
> forces us to use the original VA that the Host OS allocated.

If using the common MR API you'd have to assign a unique linear range
in the single device address map and record both the IOVA and the MMU
VA in the kernel struct.

Then when submitting work using that MR lkey the kernel will adjust
the work VA using the equation (WORK_VA - IOVA) + MMU_VA before
forwarding to HW.

EFA doesn't support rkeys, so they are not required to be emulated. It
would have to create rkeys using some guadidv_reg_mr_rkey()

It is important to understand that the usual way we support these
non-RDMA devices is to insist that they use SW to construct a minimal
standards based RDMA API, and then allow the device to have a 'dv' API
to access a faster, highly device specific, SW bypass path.

So for instance you might have some guadidv_post_work(qp) that doesn't
use lkeys and works directly on the MMU_VA. A guadidv_get_mmu_va(mr)
would return the required HW VA from the kernel.

Usually the higher level communication library (UCX, MPI, etc) forms
the dv primitives into something application usable.

> we do if that VA is in the range of our HBM addresses ? The device
> won't be able to distinguish between them. The transaction that is
> generated by an engine inside our device will go to the HBM instead of
> going to the PCI controller and then to the host.
> 
> That's the crust of the problem and why we didn't use MR.

No, the problem with the device is that it doesn't have a lkey/rkey,
so it is stuck with a single translation domain. RoCE compliant
devices are required to have multiple translation domains - each
lkey/rkey specifies a unique translation.

The MR concept is a region of process VA mapped into the device for
device access, and this device *clearly* has that.

Jason
