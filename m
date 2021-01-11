Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA362F20C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403943AbhAKU1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbhAKU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:27:41 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B595C061786;
        Mon, 11 Jan 2021 12:27:01 -0800 (PST)
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 12847728;
        Mon, 11 Jan 2021 20:27:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 12847728
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1610396821; bh=Qleuqoc2NdcIM44L0gYiLwhd79eolf94h+6PtwawCNw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JQ9fqz5JSIKUtYl4394LM2yFBo1IT105XNjXCRwAxnwIEY24x6V7gavZ/JAxk6ifM
         l+EIf71zpxZB60ODpyQNOJ76UZhGXw/rBZETWWMcwyiOSX3dZj9zKp2rwU1sZo2pbP
         BV5BlFS76j1oyOAk64ocmHgP1SKHtnX9kn6zTTGe5AVvzdrxOsKMIZjj3InfRO/W3y
         ahFS/p0Xo/2ztII3JJPclEVaK0DGZFBy+fbyctvDQ+2VWgUihajX5QLXxRfa1QYfYP
         dlBenM043XmxI3jFqYO+4PbohWnIpKXRZiMI3rJeoesdTVgx96o/MSPDZrc+ggejnP
         73tEQ/8hpBKbQ==
Date:   Mon, 11 Jan 2021 13:26:59 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Duerr <Hannes.Duerr@duagon.com>
Subject: Re: [PATCH] Documentation: document dma device use for mcb
Message-ID: <20210111132659.1b1543a0@lwn.net>
In-Reply-To: <SN4PR0401MB35985663FE8EFD62AD7B42B69BAB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <3bdc8f76b30c2b0e2a2bfab06c2e73797ddc9384.1608305690.git.johannes.thumshirn@wdc.com>
        <SN4PR0401MB35985663FE8EFD62AD7B42B69BAB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 10:19:55 +0000
Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:

> On 18/12/2020 16:35, Johannes Thumshirn wrote:
> > Hannes reported a problem with setting up dma transfers on a mcb device.
> > The problem boiled down to the use of a wrong 'device' for the dma
> > functions.
> > 
> > Document how to setup dma transfers for a IP core on a mcb carrier.  
> 
> Ping?

Sorry, I've been distracted by holidays, merge window, network issues, and
generally watching the news in horror.  The patch is applied now, thanks.

jon
