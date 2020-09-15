Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6426A8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgIOPUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:20:00 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56709 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727180AbgIOOso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:48:44 -0400
Received: (qmail 1003957 invoked by uid 1000); 15 Sep 2020 10:48:43 -0400
Date:   Tue, 15 Sep 2020 10:48:43 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrew_gabbasov@mentor.com,
        Baxter Jim <jim_baxter@mentor.com>,
        "Natsume, Wataru \(ADITJ/SWG\)" <wnatsume@jp.adit-jv.com>,
        "Nishiguchi, Naohiro \(ADITJ/SWG\)" <nnishiguchi@jp.adit-jv.com>,
        =?utf-8?B?5rWF6YeO5oGt5Y+y?= <yasano@jp.adit-jv.com>,
        kernel test robot <rong.a.chen@intel.com>,
        yasushi asano <yazzep@gmail.com>,
        Martin Mueller <Martin.Mueller5@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH v3] USB: hub.c: decrease the number of attempts of
 enumeration scheme
Message-ID: <20200915144843.GB1002979@rowland.harvard.edu>
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
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> 
> Is there hope to give users a knob (build-time or run-time) which would
> enable the behavior expected and thoroughly described in compliance
> docs, particularly chapter "6.7.22 A-UUT Device No Response for
> connection timeout" of "USB On-The-Go and Embedded Host Automated
> Compliance Plan" [**]?

It is possible to add a build-time Kconfig option that would control the 
maximum number of port initialization attempts.  But let's start with 
testing the patch I sent you.  After all, the first step is to get 
something that does what you want correctly.

Alan Stern
