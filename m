Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D571E4B09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgE0Qws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 12:52:48 -0400
Received: from foss.arm.com ([217.140.110.172]:42580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgE0Qwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:52:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1C3755D;
        Wed, 27 May 2020 09:52:46 -0700 (PDT)
Received: from bogus (unknown [10.37.8.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14EC3F305;
        Wed, 27 May 2020 09:52:45 -0700 (PDT)
Date:   Wed, 27 May 2020 17:52:38 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/8] soc: Use custom soc attribute group and
 DEVICE_ATTR_RO
Message-ID: <20200527165238.GA21440@bogus>
References: <20200523170859.50003-1-sudeep.holla@arm.com>
 <20200527090305.GD179718@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527090305.GD179718@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, May 27, 2020 at 11:03:05AM +0200, Greg Kroah-Hartman wrote:
> On Sat, May 23, 2020 at 06:08:51PM +0100, Sudeep Holla wrote:
> > Hi,
> > 
> > While trying to add SMCCC based SOC_ID support, I found the custom soc
> > attribute group which had no users in the tree and check if it can be
> > used or can be removed. I realised that it could clean up the custom
> > attributes that are added using device_create_file today.
> 
> Whole series looks good, nice job.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Both Linus Walleij and Greg have provided Reviewed-by meaning I need to
take this via ARM SoC. I assume it is late for v5.8 now, do you want me
to resend later for you to pick this directly or need pull request ?

--
Regards,
Sudeep
