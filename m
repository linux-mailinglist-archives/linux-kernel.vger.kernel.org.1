Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A4D2C9ECF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgLAKJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:09:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:33408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729694AbgLAKJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:09:16 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD813206E3;
        Tue,  1 Dec 2020 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606817315;
        bh=K2Rfp+NGSTP5Rde0j43LLWZXI/8v5kvrtDtj0kwjPeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zhdvJRl+dU2nn/KJA2WGm7kLcx2neKD9GYh9IxDC4wh5Slx84YfjIekiB/BcATaQ7
         wrfF9cr7xZ2cjKLAvxOHLnq8YUftx8DidGdEutwHuAunjaqOvfeWTRM1HtHF765d5i
         hMR/j6bY01qewxc9RY1x/NUOxKDzG+DzB81Cs3YA=
Date:   Tue, 1 Dec 2020 11:09:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v6 06/18] virt: acrn: Introduce VM management interfaces
Message-ID: <X8YWa8IUCgOARYMS@kroah.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-7-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201093853.12070-7-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 05:38:41PM +0800, shuo.a.liu@intel.com wrote:
> +		vm_param->reserved0 = 0;
> +		vm_param->reserved1 = 0;

NO!

This means that userspace can put whatever crud they want in those
fields, and you will happily zero it out.  Then, when those reserved
fields are wanted to be used in the future, you will take those values
from userspace and accept them as a valid value.  But, since userspace
was sending crud before, now you will take that crud and do something
with it.

TEST IT to verify that it is zero, that way userspace gets it right the
first time, and you don't get it wrong later, as you can not change it
later.

thaqnks,

greg k-h
