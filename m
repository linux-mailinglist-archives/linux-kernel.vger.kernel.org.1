Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7641288F0E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389829AbgJIQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:38:57 -0400
Received: from foss.arm.com ([217.140.110.172]:55654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388719AbgJIQi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:38:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F0ABD6E;
        Fri,  9 Oct 2020 09:38:56 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 397E33F66B;
        Fri,  9 Oct 2020 09:38:55 -0700 (PDT)
Date:   Fri, 9 Oct 2020 17:38:48 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] mailbox: Add Broadcom STB mailbox driver
Message-ID: <20201009163848.5tbl5bmvuoj2de2v@bogus>
References: <20200919192235.43872-1-james.quinlan@broadcom.com>
 <20200919192235.43872-3-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919192235.43872-3-james.quinlan@broadcom.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 19, 2020 at 03:22:30PM -0400, Jim Quinlan wrote:
> only implements the agent-to-platform channel;

In that case any reason why you can't reuse the existing smc transport
for SCMI. It was added recently in case you haven't checked the latest
kernel version(v5.8 or above). Check out for drivers/firmware/arm_scmi/smc.c
IIUC rather vaguely Florian was cc-ed on those patches.

> we may implement the platform-to-agent channel in the future.

This is not yet support with that transport, it is hard to generalise
as different vendors have their own solutions there.

> An unusual aspect of this driver is how the completion of an SCMI message
> is indicated.  An SCMI message is initiated with an ARM SMC call, but the
> return of this call does not indicate the execution or completion of the
> message.  Rather, the message's completion is signaled by an interrupt.
>

So are these not fast SMC/HVC calls then ? If so we may need some changes
to that driver. I just rejected multiple message support as we had assumed
fast smc/hvc.

-- 
Regards,
Sudeep
