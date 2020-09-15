Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D16026A3EF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgIOLMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:12:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgIOLKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:10:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35C9218AC;
        Tue, 15 Sep 2020 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600167674;
        bh=wFfE5fiM4ubdhDZUDuxOI8nMSLN4cvgcqiQR3bGu0Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PMVLeHv0REyxe99q8amMjinAlAsMG5wWbWH2GaUPW+Eb4ZnO3u6d5rQMha5WYQiZu
         b2jqBRwRYCSyBymfWRfb/mkOTzC2oiJ0ZLI75hyE3cEBhM6YSqrNAWCOyXfPMWNgib
         ST19kempafe2Kp/veIU/nmWxwbSMmaR+xvLJwJNA=
Date:   Tue, 15 Sep 2020 13:01:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew_gabbasov@mentor.com,
        Baxter Jim <jim_baxter@mentor.com>,
        "Natsume, Wataru (ADITJ/SWG)" <wnatsume@jp.adit-jv.com>,
        "Nishiguchi, Naohiro (ADITJ/SWG)" <nnishiguchi@jp.adit-jv.com>,
        =?utf-8?B?5rWF6YeO5oGt5Y+y?= <yasano@jp.adit-jv.com>,
        kernel test robot <rong.a.chen@intel.com>,
        yasushi asano <yazzep@gmail.com>,
        Martin Mueller <Martin.Mueller5@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v3] USB: hub.c: decrease the number of attempts of
 enumeration scheme
Message-ID: <20200915110111.GA269380@kroah.com>
References: <CAEt1Rjq+Fz85KU-aKO+boNE5yL7GiwdopmRd3-FxEL+mzEui-g@mail.gmail.com>
 <20200907155052.2450-1-yazzep@gmail.com>
 <20200907155052.2450-2-yazzep@gmail.com>
 <20200908190402.GA797206@rowland.harvard.edu>
 <CAEt1RjquJZzTctN6dNQSDbUZ9YG2FnEtzTZsoA3a9RtXHxwUmA@mail.gmail.com>
 <CAEt1RjpGcZ4T70tr83pmcD--PzAMboBkbv55qFcRfMz11ZUggw@mail.gmail.com>
 <20200911151228.GA883311@rowland.harvard.edu>
 <20200915094531.GA8046@lxhi-065.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915094531.GA8046@lxhi-065.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:45:31AM +0200, Eugeniu Rosca wrote:
> Dear Alan,
> Dear Greg,
> 
> On Fri, Sep 11, 2020 at 11:12:28AM -0400, Alan Stern wrote:
> 
> > The thing is, I'm afraid that without these retry loops, some devices
> > will stop working.  If that happens, we will not be able to keep this
> > patch in place; we will just have to accept that we fail the PET test.
> > 
> > Alan Stern
> 
> Does this mean that Linux community leaves no choice but to ship a
> forked kernel (with no chance of alignment to upstream) for
> organizations which design embedded devices where USB plays a key
> role, hence requires passing the USB-IF Compliance Program [*]?

We are saying that if you ship such a kernel, we _KNOW_ that it will
fail to work in a number of known systems.  I doubt you want that to
happen if you care about shipping a device, right?

> Is there hope to give users a knob (build-time or run-time) which would
> enable the behavior expected and thoroughly described in compliance
> docs, particularly chapter "6.7.22 A-UUT Device No Response for
> connection timeout" of "USB On-The-Go and Embedded Host Automated
> Compliance Plan" [**]?

Given that the USB-IF has explicitly kicked-out the Linux community from
its specification work and orginization, I personally don't really care
what they say here.  If you are a member of the USB-IF, please work with
them to fix the test to reflect real-world systems and not an idealized
system.  Last I heard, they wanted nothing to do with Linux systems at
all :(

thanks,

greg k-h
