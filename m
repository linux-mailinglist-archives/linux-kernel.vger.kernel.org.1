Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863111F5056
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgFJIcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 04:32:50 -0400
Received: from foss.arm.com ([217.140.110.172]:54880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgFJIcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:32:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94771F1;
        Wed, 10 Jun 2020 01:32:49 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37EC23F6CF;
        Wed, 10 Jun 2020 01:32:47 -0700 (PDT)
Date:   Wed, 10 Jun 2020 09:32:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Message-ID: <20200610083237.GA4867@bogus>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609223551.GA1620273@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 04:35:51PM -0600, Rob Herring wrote:
> On Mon, Jun 01, 2020 at 10:45:10AM +0100, Sudeep Holla wrote:
> > Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
> > at virtual interface(VMs).
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
>
> I'm hoping this goes away if the firmware is discoverable, but if not DT
> bindings are DT schema now.
>

Yes, consider it gone. I introduced it to couple of reasons both of which
are now irrelevant. We may revisit this if we need it for Rx/Tx buffer
information. The KVM host may need the binding, this was for the guests/
partitions as Will has already mentioned.

--
Regards,
Sudeep
