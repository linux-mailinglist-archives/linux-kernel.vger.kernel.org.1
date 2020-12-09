Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F252D376F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 01:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgLIAOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 19:14:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:24657 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgLIAOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 19:14:34 -0500
IronPort-SDR: zDU64yydM2MfYkeiTHaDoDUuAB2cJtpLmxpsdNpUA3lu0o2KdfLKgy80yMAFtWXMR8wGhk4CN1
 Ge3f/xPHCcvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="173232456"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="173232456"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:12:48 -0800
IronPort-SDR: osAd1DN05/7daXrvowPH8L5oEMSqjimTDh/txXh+91Q/bfZGeEXb+zsJdu3wAl3/Ia3SmLuGf1
 zAK5tFSrqlfQ==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="367972580"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:12:48 -0800
Received: from localhost (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id DE3D96363;
        Tue,  8 Dec 2020 16:12:47 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:12:47 -0800
From:   mark gross <mgross@linux.intel.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Rob Herring <robh@kernel.org>, mgross@linux.intel.com,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        markgross@kernel.org, "arnd@arndb.de" <arnd@arndb.de>, bp@suse.de,
        damien.lemoal@wdc.com, Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>
Subject: Re: [PATCH 02/22] dt-bindings: Add bindings for Keem Bay IPC driver
Message-ID: <20201209001247.GA6438@linux.intel.com>
Reply-To: mgross@linux.intel.com
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-3-mgross@linux.intel.com>
 <20201207160152.GB351233@robh.at.kernel.org>
 <ca099c0833dc79f0a88edecd9fb949157eacbf46.camel@linux.intel.com>
 <CABb+yY1Qm4G5rHmRbt8Pyno8h4X6EqesLv1=ybup0fHJ+rnPww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1Qm4G5rHmRbt8Pyno8h4X6EqesLv1=ybup0fHJ+rnPww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 02:31:37PM -0600, Jassi Brar wrote:
> On Mon, Dec 7, 2020 at 12:43 PM Daniele Alessandrelli
> <daniele.alessandrelli@linux.intel.com> wrote:
> >
> > Hi Rob,
> >
> > Thanks for the feedback.
> >
> > On Mon, 2020-12-07 at 10:01 -0600, Rob Herring wrote:
> > > On Tue, Dec 01, 2020 at 02:34:51PM -0800, mgross@linux.intel.com wrote:
> > > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > >
> > > > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > > > enables communication between the Computing Sub-System (CSS) and the
> > > > Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> > > > Bay.
> > > >
> >
> > [cut]
> >
> > > > +
> > > > +description:
> > > > +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> > > > +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> > > > +  Keem Bay.
> > >
> > > Sounds like a mailbox.
> >
> > We did consider using the mailbox framework, but eventually decided
> > against it; mainly because of the following two reasons:
> >
> > 1. The channel concept in the Mailbox framework is different than the
> >    channel concept in Keem Bay IPC:
> >
> >    a. My understanding is that Mailbox channels are meant to be SW
> >       representation of physical HW channels, while in Keem Bay IPC
> >       channels are software abstractions to achieve communication
> >       multiplexing over a single HW link
> >
> In mailbox api, that would be a physical channel shared between various clients.
> 
> >    b. Additionally, Keem Bay IPC has two different classes of channels
> >       (high-speed channels and general-purpose channels) that need to
> >       access the same HW link with different priorities.
> >
> If the priorities are hard (programmed into some register), you could
> do that via dt during channel population.
> If they are soft, that would be handled in the shared channel implementation.
> 
> > 2. The blocking / non-blocking TX behavior of mailbox channels is
> >    defined at channel creation time (by the tx_block value of the
> >    mailbox client passed to mbox_request_channel();
> >
> No, that is checked at mbox_send_message()
> 
> > my understanding
> >    is that the tx_block value cannot be modified after the channel is
> >    created),
> >
> Again no. If you don't queue more than one message at any time you can
> change it between transfers. To be safe you can always change it
> between channel release - request calls.
> 
> >  while in Keem Bay IPC the same channel can be used for
> >    both blocking and non-blocking TX (behavior is controlled by the
> >    timeout argument passed to keembay_ipc_send()).
> >
> > Having said that, I guess that it could be possible to create a Mailbox
> > driver implementing the core communication mechanism used by the Keem
> > Bay IPC and then build our API around it (basically having two
> > drivers). But I'm not sure that would make the code simpler or easier
> > to maintain. Any thoughts on this?
> >
> I think so. Most of KeemBay specific behaviour would be implemented in
> the shared channel above the mailbox api.

Quick question.  By "I think so" do you mean that you feel the keem bay IPC
code will be simpler and easier to maintain if we make yet another driver at the
Keem Bay IPC driver sits on top off?  Or, the current implementation would be
simpler if we rework the implementation to use the mailbox api?

I'm just now ramping on the common mailbox framework so that may be a dumb
question.  I would like to be confident reworking the driver to use the mailbox
api will not lead to blocking issues before we start that.

thanks!

--mark
