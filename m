Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0562D2D18B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLGSop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:44:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:37546 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgLGSop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:44:45 -0500
IronPort-SDR: SwaZvXZNEYOk3pefD7QmzkHbjfYTFiuokP+wxKC8/fjnDihqYMbfA6k81JisqcAg+/nDM+NN4R
 k5UdyJRtwALQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="173863024"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="173863024"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:42:59 -0800
IronPort-SDR: 4q1QkbrDFOWczQuFKzjAG/3IvadRyFdoq4xHVYdsBZ0wa4Fy4EcTzijJ0AeL0/IDnvlrcoqNsG
 JjtoFZDcJ9Xg==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="363259943"
Received: from slenno2-mobl1.ger.corp.intel.com ([10.252.9.227])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 10:42:54 -0800
Message-ID: <ca099c0833dc79f0a88edecd9fb949157eacbf46.camel@linux.intel.com>
Subject: Re: [PATCH 02/22] dt-bindings: Add bindings for Keem Bay IPC driver
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, mgross@linux.intel.com,
        daniele.alessandrelli@intel.com
Cc:     markgross@kernel.org, arnd@arndb.de, bp@suse.de,
        damien.lemoal@wdc.com, gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 07 Dec 2020 18:42:07 +0000
In-Reply-To: <20201207160152.GB351233@robh.at.kernel.org>
References: <20201201223511.65542-1-mgross@linux.intel.com>
         <20201201223511.65542-3-mgross@linux.intel.com>
         <20201207160152.GB351233@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the feedback.

On Mon, 2020-12-07 at 10:01 -0600, Rob Herring wrote:
> On Tue, Dec 01, 2020 at 02:34:51PM -0800, mgross@linux.intel.com wrote:
> > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > 
> > Add DT binding documentation for the Intel Keem Bay IPC driver, which
> > enables communication between the Computing Sub-System (CSS) and the
> > Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
> > Bay.
> > 

[cut]

> > +
> > +description:
> > +  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
> > +  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
> > +  Keem Bay.
> 
> Sounds like a mailbox.

We did consider using the mailbox framework, but eventually decided
against it; mainly because of the following two reasons:

1. The channel concept in the Mailbox framework is different than the
   channel concept in Keem Bay IPC:

   a. My understanding is that Mailbox channels are meant to be SW
      representation of physical HW channels, while in Keem Bay IPC
      channels are software abstractions to achieve communication
      multiplexing over a single HW link

   b. Additionally, Keem Bay IPC has two different classes of channels 
      (high-speed channels and general-purpose channels) that need to
      access the same HW link with different priorities.

2. The blocking / non-blocking TX behavior of mailbox channels is
   defined at channel creation time (by the tx_block value of the
   mailbox client passed to mbox_request_channel(); my understanding 
   is that the tx_block value cannot be modified after the channel is
   created), while in Keem Bay IPC the same channel can be used for
   both blocking and non-blocking TX (behavior is controlled by the
   timeout argument passed to keembay_ipc_send()).

Having said that, I guess that it could be possible to create a Mailbox
driver implementing the core communication mechanism used by the Keem
Bay IPC and then build our API around it (basically having two
drivers). But I'm not sure that would make the code simpler or easier
to maintain. Any thoughts on this?


>  
> 
> What's the relationship between this and the xlink thing?
> 

xLink internally uses Keem Bay IPC to communicate with the VPU.
Basically, Keem Bay IPC is the lowest layer of the xLink stack.




