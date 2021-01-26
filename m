Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F7F304018
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405905AbhAZOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405882AbhAZOUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:20:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B0B2206CA;
        Tue, 26 Jan 2021 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611670769;
        bh=b+c5T4n9jRaht6O5yOfV/FqKLavfrxzcJDIn1MjA930=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lBpWeSC29oVeuZA6cKzBaKlSzU0oEFOh2eh/D3NFKYLCkzk4YH+deCKOwPHnwzfE
         B75IGiTpdEHsT2OvpqsSPcj0p1TrDSTL7t5eAmB8JJ29CzJ3wAUlEpg4aL9dbwVkaf
         qBznZa5/CL4hGZXjIZlnS586fJo49ogasQOXQKrk=
Date:   Tue, 26 Jan 2021 15:19:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Howard Yen <howardyen@google.com>,
        Mathias Nyman <mathias.nyman@intel.com>, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] add xhci hooks for USB offload
Message-ID: <YBAk795ccXBPgJWp@kroah.com>
References: <20210119101044.1637023-1-howardyen@google.com>
 <af91bbf1-6731-3e87-4086-de0dbba22c22@intel.com>
 <CAJDAHvbTY3Z_bRg+++uLefWSvCWo_nGq+3OOQX3QHJ2w3X1SQw@mail.gmail.com>
 <ca442ca7-a434-2527-9945-861dafa685cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca442ca7-a434-2527-9945-861dafa685cc@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 05:32:58PM +0200, Mathias Nyman wrote:
> On 20.1.2021 12.04, Howard Yen wrote:
> > On Tue, Jan 19, 2021 at 8:47 PM Mathias Nyman <mathias.nyman@intel.com> wrote:
> >>
> >> On 19.1.2021 12.10, Howard Yen wrote:
> >>> To let the xhci driver support USB offload, add hooks for vendor to have
> >>> customized behavior for the initialization, memory allocation, irq work, and
> >>> device context synchronization. Detail is in each patch commit message.
> >>
> >> Is this related to the usb audio sideband capability that was added to the xHCI specification?
> >> If yes, then we should probably implement the generic parts first, and then add
> >> the vendor specific hooks.
> >>
> >> -Mathias
> >>
> >>
> > 
> > This is for offloading, no matter what type of offloading.
> > I made the hooks generically and can be used for usb audio on the xhci
> > which is not including the usb audio sideband capability.
> > 
> 
> Ok, before adding hooks like this I think we need to see how they are used.
> Do you have the rest of the patches that go on top of this series?
> 
> Maybe it could make sense to use overrides for the functions in struct hc_driver
> instead in some cases? There is support for that already.

What overrides could be done for these changes?  At first glance that
would seem to require a lot of duplicated code in whatever override
happens to be needed.

thanks,

greg k-h
