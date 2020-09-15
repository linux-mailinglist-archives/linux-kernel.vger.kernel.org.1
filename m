Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC226A27F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgIOJpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:45:47 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:38685 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgIOJpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:45:46 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id D840E3C04C0;
        Tue, 15 Sep 2020 11:45:41 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SMoPaaUSd9to; Tue, 15 Sep 2020 11:45:36 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 3138F3C00C1;
        Tue, 15 Sep 2020 11:45:36 +0200 (CEST)
Received: from lxhi-065.adit-jv.com (10.72.94.30) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 15 Sep
 2020 11:45:35 +0200
Date:   Tue, 15 Sep 2020 11:45:31 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew_gabbasov@mentor.com>, Baxter Jim <jim_baxter@mentor.com>,
        "Natsume, Wataru (ADITJ/SWG)" <wnatsume@jp.adit-jv.com>,
        "Nishiguchi, Naohiro (ADITJ/SWG)" <nnishiguchi@jp.adit-jv.com>,
        =?utf-8?B?5rWF6YeO5oGt5Y+y?= <yasano@jp.adit-jv.com>,
        kernel test robot <rong.a.chen@intel.com>,
        yasushi asano <yazzep@gmail.com>,
        Martin Mueller <Martin.Mueller5@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH v3] USB: hub.c: decrease the number of attempts of
 enumeration scheme
Message-ID: <20200915094531.GA8046@lxhi-065.adit-jv.com>
References: <CAEt1Rjq+Fz85KU-aKO+boNE5yL7GiwdopmRd3-FxEL+mzEui-g@mail.gmail.com>
 <20200907155052.2450-1-yazzep@gmail.com>
 <20200907155052.2450-2-yazzep@gmail.com>
 <20200908190402.GA797206@rowland.harvard.edu>
 <CAEt1RjquJZzTctN6dNQSDbUZ9YG2FnEtzTZsoA3a9RtXHxwUmA@mail.gmail.com>
 <CAEt1RjpGcZ4T70tr83pmcD--PzAMboBkbv55qFcRfMz11ZUggw@mail.gmail.com>
 <20200911151228.GA883311@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200911151228.GA883311@rowland.harvard.edu>
X-Originating-IP: [10.72.94.30]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Alan,
Dear Greg,

On Fri, Sep 11, 2020 at 11:12:28AM -0400, Alan Stern wrote:

> The thing is, I'm afraid that without these retry loops, some devices
> will stop working.  If that happens, we will not be able to keep this
> patch in place; we will just have to accept that we fail the PET test.
> 
> Alan Stern

Does this mean that Linux community leaves no choice but to ship a
forked kernel (with no chance of alignment to upstream) for
organizations which design embedded devices where USB plays a key
role, hence requires passing the USB-IF Compliance Program [*]?

Is there hope to give users a knob (build-time or run-time) which would
enable the behavior expected and thoroughly described in compliance
docs, particularly chapter "6.7.22 A-UUT Device No Response for
connection timeout" of "USB On-The-Go and Embedded Host Automated
Compliance Plan" [**]?

[*] https://www.usb.org/compliance
[**] https://www.usb.org/sites/default/files/otgeh_compliance_plan_1_2.pdf

-- 
Best regards,
Eugeniu Rosca
