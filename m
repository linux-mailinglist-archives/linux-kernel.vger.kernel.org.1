Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AF923B8AE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 12:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgHDKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 06:20:36 -0400
Received: from foss.arm.com ([217.140.110.172]:42222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbgHDKUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:20:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A13D1FB;
        Tue,  4 Aug 2020 03:20:35 -0700 (PDT)
Received: from bogus (unknown [10.37.12.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5A83F718;
        Tue,  4 Aug 2020 03:20:33 -0700 (PDT)
Date:   Tue, 4 Aug 2020 11:20:25 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jason Liu <jason.hui.liu@nxp.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, ashal@kernel.org,
        maz@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: kexec: no need to do irq_chip->irq_mask if it
 already masked
Message-ID: <20200804102025.GA15199@bogus>
References: <20200804085657.10776-1-jason.hui.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804085657.10776-1-jason.hui.liu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Marc Z

On Tue, Aug 04, 2020 at 04:56:57PM +0800, Jason Liu wrote:
> No need to do the irq_chip->irq_mask() if it already masked.
> BTW, unconditionally do the irq_chip->irq_mask() will also bring issues
> when the irq_chip in the runtime PM suspend. Accessing registers of the
> irq_chip will bring in the exceptions. For example on the i.MX:
>

The change looks good and is inline with the additional checks we do for
eoi and disable. However, the imx_irqsteer_irq_mask is not safe to be
called with runtime suspend. What happens if some driver using the irq
on this chip calls disable_irq when this irqchip is suspended ?

-- 
Regards,
Sudeep
