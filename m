Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494461D08EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 08:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgEMGsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 02:48:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbgEMGr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:47:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD45120708;
        Wed, 13 May 2020 06:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589352479;
        bh=kZUHIl/hslAIUun/scKZGchu54jJoiD5bFZ7D+UaEso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PuQBkAr5QzzkidCv+HHPPcfF5KJPuORNomc6bYgImz/D7lVfJAhdo6oPqs4sNv/WQ
         usqM4uvdRCJ4UAFK/wATmvjc6E1QcTtnzD9goysPqVRGzP6fPViTp+icxrXVSavUY+
         A2XVYzt2HZ+U1oyHlm8IFeKhhiiJtkb9vZRFPPj4=
Date:   Wed, 13 May 2020 08:47:55 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Idgar, Or" <Or.Idgar@dell.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Ravich, Leonid" <Leonid.Ravich@dell.com>
Subject: Re: CMA enhancement - non-default areas in x86
Message-ID: <20200513064755.GA763968@kroah.com>
References: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:13:55AM +0000, Idgar, Or wrote:
> Hi,
> I'm working with Linux kernel on x86 and needed a way to allocate a very large contiguous memory (around 20GB) for DMA operations.

For what type of device?

> I've found out that CMA is one of the major ways to do so, but our problem is that CMA's default behavior is to create one default area from which all devices can allocate memory.
> when booting, there were some drivers that allocated memory for DMA and used CMA memory if exist. The problem is that it takes memory that we need for our device and we want to make sure this area is dedicated for our device.
> 
> As I saw, the only way to reserve a dedicated area is by enabling OF_RESERVED_MEM which is available for several architectures but excluding x86 (and as far as I understand relies on device tree which is not in use with x86 or at least cannot be configured with OF_RESERVED_MEM).
> 
> I really want to leverage this mechanism/API and thought about modifying the code (and hopefully merge it upstream) so multiple non-default areas will be available for x86 and with a way to consume it by mapping specific area to specific device.
> 
> Is it something that will be open for merging if written properly?

We always will be glad to review patches, no need to ask us about that.
Just post them!

good luck,

greg k-h
