Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547D527876D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgIYMkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbgIYMkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:40:47 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C28D620BED;
        Fri, 25 Sep 2020 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601037647;
        bh=lbRAM6gt8YOIzS1RHPbhz+W/oFIDI97Ar2EVRsYK22c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFJceVwcnlc0lMAnpnDt0hTA6mDCmckWNAHDfst/rY4ZB5OgbSgKx7qsLIN0ZXrfZ
         rCz1GLUyDk/sIaUjsvFxfiV1Y7jpaxkc3TwAdm3HW4qC3oPlwk382bD5xCWtRRsfk7
         EJc/ZiP7OZg8g+qOWeCjiAeldmBwd/3Gtqc97UXo=
Date:   Fri, 25 Sep 2020 14:41:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] slimbus: core: check get_addr before removing laddr
 ida
Message-ID: <20200925124101.GB2732292@kroah.com>
References: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
 <20200925095520.27316-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925095520.27316-2-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 10:55:18AM +0100, Srinivas Kandagatla wrote:
> logical address can be either assigned by the SLIMBus controller or the core.
> Core uses IDA in cases where get_addr callback is not provided by the
> controller.
> Core already has this check while allocating IDR, however during absence
> reporting this is not checked. This patch fixes this issue.
> 
> Fixes: 46a2bb5a7f7ea("slimbus: core: Add slim controllers support")

Nit, you need a ' ' before the '(' character...

Also, you don't need all of those characters, you have 1 more than
necessary :)

I'll go fix it up.

greg k-h
