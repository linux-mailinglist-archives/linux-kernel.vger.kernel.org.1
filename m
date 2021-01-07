Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BFC2ED550
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbhAGRSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbhAGRSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:18:23 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B732342C;
        Thu,  7 Jan 2021 17:17:42 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kxYuq-005tOZ-LY; Thu, 07 Jan 2021 17:17:40 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Jan 2021 17:17:40 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of: property: Add device link support for interrupts
In-Reply-To: <CAGETcx8D6Q7XojOnRCPNAZWcxhNt5ebFCp6gyh-cuKeaKfS2Bw@mail.gmail.com>
References: <20201218210750.3455872-1-saravanak@google.com>
 <2a6dbcc83d5aca7a3340e0cf4d751cdc@kernel.org>
 <20201231211240.GA2333246@robh.at.kernel.org> <877dovlgdl.wl-maz@kernel.org>
 <CAGETcx9WJdYkQcwJLTF4j9jR4kyrDpXG8ZMuCecK2Hv-HXFgBg@mail.gmail.com>
 <CAGETcx_y6pj-8xEUfMi164iFTiDLVcdATofkOTjvFBCSAQY3sw@mail.gmail.com>
 <CAL_JsqJX_eWEU=0STW0rjxO=0NVgpuV5rD-5utD7Yzd6otPFvw@mail.gmail.com>
 <CAGETcx8D6Q7XojOnRCPNAZWcxhNt5ebFCp6gyh-cuKeaKfS2Bw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <29319d4bd3c6f8a19a6f800aff0f8f93@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: saravanak@google.com, robh@kernel.org, gregkh@linuxfoundation.org, frowand.list@gmail.com, khilman@baylibre.com, kernel-team@android.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-07 17:08, Saravana Kannan wrote:
> On Thu, Jan 7, 2021 at 8:48 AM Rob Herring <robh@kernel.org> wrote:
>> 
>> On Wed, Jan 6, 2021 at 6:26 PM Saravana Kannan <saravanak@google.com> 
>> wrote:
>> >
>> > On Wed, Jan 6, 2021 at 10:52 AM Saravana Kannan <saravanak@google.com> wrote:

[...]

>> > > I wasn't aware of interrupt-map until a few weeks ago and didn't know
>> > > it carried phandles. I can add support for that too. There's no reason
>> > > for all of them to go in one patch though.
>> >
>> > Hmm... I looked at
>> > Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>> > and it has no documentation for interrupt-map. There's a bunch of
>> > references to it in device specific DT binding documentation but I
>> > don't want to rely on those for correctness.
>> 
>> See the DT spec and there's also details on elinux.org. It's only
>> existed since the 1990s.
> 
> Thanks :) Will try to find it there.

My document of reference is [1]. Although interrupt-map appears
there in the context of PCI, it is in no way specific to a specific
bus.

HTH,

         M.

[1] https://www.openbios.org/data/docs/rec.intmap.d09.pdf
-- 
Jazz is not dead. It just smells funny...
