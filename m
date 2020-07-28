Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24EF230E85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgG1PyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731164AbgG1PyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:54:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0956C2065C;
        Tue, 28 Jul 2020 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595951655;
        bh=5grVaxx03r95Q3bjMQFvf8kKT48kPRH1h2aQey01AlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bs1Pt0CJedojEUmMCvgAYJbQlOmSCtInD81H4/gIm/ln97HpzwdTcSP7vX2VsMLMO
         z1vmrMWQ+kP81aXMJJIrkJFMW30BFLuGfetAA1x5QW6p65uL5lgxpEyDJ+8QNGoeP4
         oPsF/KB5tvhAVgzN9yJ+IidiBQPrESJYN2IvGUWo=
Date:   Tue, 28 Jul 2020 17:54:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [char-misc-next] mei: add device type
Message-ID: <20200728155408.GB4178776@kroah.com>
References: <20200728152546.3041841-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728152546.3041841-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:25:46PM +0300, Tomas Winkler wrote:
> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Some of the device heads are not generic and have
> specific purpose, we need to announce it to the user space
> so it can detect and correct device node via matching
> attributes.
> 
> Generic devices are marked as 'mei' while special
> purpose their own names. Currently we are adding
> 'itouch' string for Intel IPTS devices.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/hw-me.c   | 12 ++++++++++++
>  drivers/misc/mei/hw-me.h   |  5 +++++
>  drivers/misc/mei/hw-txe.c  |  1 +
>  drivers/misc/mei/main.c    | 27 +++++++++++++++++++++++++++
>  drivers/misc/mei/mei_dev.h |  4 ++++
>  drivers/misc/mei/pci-me.c  |  8 ++++----
>  6 files changed, 53 insertions(+), 4 deletions(-)

No Documentation/ABI/ update for this new sysfs file?

:(

