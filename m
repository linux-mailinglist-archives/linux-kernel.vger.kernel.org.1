Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774F6282540
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 17:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgJCP4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 11:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgJCP4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 11:56:43 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24CA5206DD;
        Sat,  3 Oct 2020 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601740602;
        bh=+Qr/oi93hmMNoul0FY76l1kh6zO+V2R/n1xArY6qIqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k11E+SRPgcQ4czycOaNSTlsSzTTRYfSBlnH4pAjuSsiNBaY8AB6Mq1MIq1yv2Z/rG
         zMr1UImBinO5S+KrnMY0QJguUJzEddDJK9etp5l9tooIB/XOHr5FknGrTtIeJJAnOR
         +Wlv3ez4y17OomSnMbkPqhmT3qCIZ8gXQQRs37Us=
Date:   Sat, 3 Oct 2020 17:57:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v9 02/15] usb: typec: tcpci: Add set_vbus tcpci callback
Message-ID: <20201003155726.GC1509449@kroah.com>
References: <20200929024004.244992-1-badhri@google.com>
 <20200929024004.244992-3-badhri@google.com>
 <20201002133952.GA3411859@kroah.com>
 <20201002134041.GA3412330@kroah.com>
 <CAPTae5LBeY1qifPmGce+6Cu2hjVx=QZazk53Y=n6RPPRAuozLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5LBeY1qifPmGce+6Cu2hjVx=QZazk53Y=n6RPPRAuozLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 09:08:00AM -0700, Badhri Jagan Sridharan wrote:
> Hi Greg,
> 
> Yes I tested it on usb-next before sending it out.
> 
>   630 |  tcpci->tcpc.enable_frs = tcpci_enable_frs;
> 
> In https://patchwork.kernel.org/project/linux-usb/list/?series=356837
> i.e v9 version of this series,
> Patch 7 i.e. https://patchwork.kernel.org/patch/11804847/ is where the
> above line is added.
> 
> I restested in combinations [1]  [2] [3] [4]. All of them were clear
> cherry-picks. I didnt any merge conflicts.
> 
> Maybe you are applying patches in a different order ?

I didn't think so.  Can you try applying the patches, in order, and
building after each one to see if you get the same error or not?

My usb-next branch is up to date with all of the recent patches.

thanks,

greg k-h
