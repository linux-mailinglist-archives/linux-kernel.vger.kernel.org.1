Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4796C1E3D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 11:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbgE0JDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 05:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388112AbgE0JDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:03:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E29207E8;
        Wed, 27 May 2020 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590570187;
        bh=2jwMruUZ1tzptspb46ikyyfONdQnCtmXiD757qxlIk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMH1wIWSDA6y6hiwb3+IUXGYP1TqH9M6peJSQhUR0Pa7HWNTOLegc+VQ5pp8pF3Ic
         70RYsfvqzRAxK4YmE/zrCLInkmLvLt70sl3G/y1Q8WV3O4p4tKzpM+yQsC8ESVvsaY
         +apTvmiyoXaL2vWE8OUTY3Mh3NdsMQOBpTPpi4mI=
Date:   Wed, 27 May 2020 11:03:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/8] soc: Use custom soc attribute group and
 DEVICE_ATTR_RO
Message-ID: <20200527090305.GD179718@kroah.com>
References: <20200523170859.50003-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523170859.50003-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 06:08:51PM +0100, Sudeep Holla wrote:
> Hi,
> 
> While trying to add SMCCC based SOC_ID support, I found the custom soc
> attribute group which had no users in the tree and check if it can be
> used or can be removed. I realised that it could clean up the custom
> attributes that are added using device_create_file today.

Whole series looks good, nice job.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
