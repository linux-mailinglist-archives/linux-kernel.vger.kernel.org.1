Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3F2881C9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 07:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgJIFqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 01:46:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45327 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbgJIFqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 01:46:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B08505C00FB;
        Fri,  9 Oct 2020 01:46:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Oct 2020 01:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=lr6M8yNWNeNhl0M7Uihv92Zrbfw
        BaHLmXICbGyQw3sw=; b=FJ/tXpD0Y7sB0j+cc5vQf+iH2TZGeRZXYgUxYBpWp22
        M/rU3q47XK6L2i3skTzn5H7TMHBYmyJ1hCLO6s6/vcaHctVvV5hm+R1CkKVVCj//
        F++o4MQaaNY4+okaADmWuiXixSf4Aw7+cRIS6k1dNrfLUfm0SApp2MnBlxf5T1P3
        bOOtfIct1mPO8ejAgeFGC+fW2H7LF9eNUZHWg6iLKXVStiHlzP3DpNjHtPopYa+X
        KBbqQUpV31r8QtGbkz2345GOsUWTZ0dJiGGxiZU+sWxLXfru2xV+lWDDuTdhyANW
        j7wGnIFAcWIgVrHpPwRMOgNpyMC+LIzwoGyF0nY6Gbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lr6M8y
        NWNeNhl0M7Uihv92ZrbfwBaHLmXICbGyQw3sw=; b=lPzBjITbjluDqdA+x3a6p1
        fXUE5PHtDHEybWDeXsIEc4LTD1nRvMtrs2qxOJUuU39ay5Kgp+e2XzjmpPBaHPRr
        6xozogYcCQr/UQQa6BpPAYlTIaas6JfwDGZM4ZNStAbfoGnlhb+OHjwMDeWZYWhS
        dDdUqu3ZcH7s6Vvrq3n5Eo5z+Xl9dc2nP4kTsCcL0E6en/iLdB9r8Gv2sBZ/jfkF
        8JVvV6BiTZsbeTYI+JdZJQHVHmU1qUQeKF+SNaldHros5EM7AFlp3fmjY5bQKNXF
        6AqMN0Ss43l7BwnEJik6pPv81lZd1kwxmKoYlXVZciY/6CGVODi7YPOAyfGzvDLw
        ==
X-ME-Sender: <xms:TPl_X2caWGvi3VRHyI18GPeLki0nojvAaIU-ndh3AXLSK9zvGq9BJQ>
    <xme:TPl_XwPkJc1LRi_rhqmd6ukmT3iAL9lgMy4n658LaDgNBJNlAK_ov4r6KazaGmkjG
    ROqBmseWdyZag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrhedtgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:TPl_X3gfISg1OAJpOr8-k4XRDHyWWHQNI9BNAKlxOrq21OfubtLnlQ>
    <xmx:TPl_Xz-i4y-sQAFs1-zWDjqhc09qGEN_-cfQbvyNw2cJFVprgpDT0w>
    <xmx:TPl_XytzCFjgas5xRQ1mrLR4mFqrzY6eyElzJ_hw7pnuc0slMwYzRw>
    <xmx:Tfl_X2jnrDMdOayiTncG2in50xxMJQ8nGzSZj7EWovAGH1zPfpc60A>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2AD563064610;
        Fri,  9 Oct 2020 01:46:52 -0400 (EDT)
Date:   Fri, 9 Oct 2020 07:46:50 +0200
From:   Greg KH <greg@kroah.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, BMC-SW <bmc-sw@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
Message-ID: <20201009054650.GA117723@kroah.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-2-ryan_chen@aspeedtech.com>
 <20201009044526.GB111063@kroah.com>
 <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 04:55:19AM +0000, Joel Stanley wrote:
> On Fri, 9 Oct 2020 at 04:45, Greg KH <greg@kroah.com> wrote:
> >
> > On Fri, Oct 09, 2020 at 10:49:35AM +0800, Ryan Chen wrote:
> > > v2:
> > >  -Changed : Add SCSI, BLK_DEV_SD, USB_STORAGE support.
> > > v1:
> > >  -Enable UHCI driver in aspeed_g5_defconfig.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> >
> > Why do you need this in a defconfig?
> 
> I would prefer configurations that are being used to be present in the
> defconfig so we can test it. I think this is a sensible change.

Then it needs to be described in the changelog, otherwise we have no
idea why this is happening :)

thanks,

greg k-h
