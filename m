Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F461B1E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 08:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgDUF77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 01:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgDUF77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:59:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AF142076C;
        Tue, 21 Apr 2020 05:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587448799;
        bh=x/6mU5SMHCOal2Ij3Hc+/MYIcd7Tq+Ern6HXgC449+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5+C9ijmAKKwg5eA4F+D37RqPPHLN1J5FazJcIEAkv68dz5mXlKIYxcTJk6FSa7/2
         LDbsxye0ooxHr0WomgQU4wQDwfs1SdKy06J/Xsikrp24brXyuoPHuqqL2MIJqXfHzZ
         4GQBfzYb0i3k5LWvFkgmFKhyKi+igmk/Cq9bOoy4=
Date:   Tue, 21 Apr 2020 07:59:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Evalds Iodzevics <evalds.iodzevics@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        ben@decadent.org.uk
Subject: Re: [PATCH v2] x86/microcode/intel: replace sync_core() with
 native_cpuid_reg(eax)
Message-ID: <20200421055955.GA343434@kroah.com>
References: <20200420120037.1537-1-evalds.iodzevics@gmail.com>
 <20200421085344.1804-1-evalds.iodzevics@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421085344.1804-1-evalds.iodzevics@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:53:44AM +0300, Evalds Iodzevics wrote:
> On Intel it is required to do CPUID(1) before reading the microcode
> revision MSR. Current code in 4.4 an 4.9 relies on sync_core() to call
> CPUID, unfortunately on 32 bit machines code inside sync_core() always
> jumps past CPUID instruction as it depends on data structure boot_cpu_data
> witch are not populated correctly so early in boot sequence.
> 
> It depends on:
> commit 5dedade6dfa2 ("x86/CPU: Add native CPUID variants returning a single
> datum")
> 
> This patch is for 4.4 but also should apply to 4.9
> 
> Signed-off-by: Evalds Iodzevics <evalds.iodzevics@gmail.com>
> ---
>  arch/x86/include/asm/microcode_intel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why are you not sending this to the stable mailing list like I have
pointed out numerous times by sending you a link to _how_ to get a patch
into the stable kernel trees?

Again, here it is:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Please follow that so that we can do this correctly.

thanks,

greg k-h
