Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98AD290C68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 21:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411135AbgJPTqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 15:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393216AbgJPTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 15:46:21 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D823C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 12:46:18 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id E0C97405C; Fri, 16 Oct 2020 21:46:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valentin-vidic.from.hr; s=2020; t=1602877571;
        bh=l60w3mUmm5RYbV2ePcxGEmUcBIbChTIprFu9HToJeCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1nLdkRxuJJsfXHXO9P/gska7vOIcVNKfq+4iMogEOG6Zg15X2YTbbVtLI12L6LV6F
         +3NxEjAGKvFDFHu1zKrWpKFlVKcI5aWJU5F2+hwcdwwL2GNIQZl09Gcx4RUmtUrBpz
         wD86Ab0Ex1m9qkY9h5rmcdAAJ7SOBoOJYXno1u/u+VqpNbFttP5IB6RqeyUO94D9H0
         lmBljzbn3rF8DyXl0bo7SGH1S8DD93ZI6TalbVtju16bhN6r3nmJcoYBxVsi8467KA
         yVMmf4SJFFTO3EHJSeabrk6db+ibptlTWsEBVHDiyxVVnkgMOKHKmt+H75lvz2z6Aq
         hCkQCkanhEaCL0GPNtoKwXZS436a3i53Mb4WnmAdF4ZSXi/5UKGKVnfwFi0sYHH/dK
         TV6H2cyKWKWoTfN9M8tevzG2WMT1czitzCZtnM2fk6XTk/hWvypGXP2WqmmfH37auQ
         iMF+L5rDxVt3fwG0lQsusKMMpzh6NecsozRT61X2Ru+oGBs2GnRv5nJ5rYEPQxUghA
         qJq3l5J7VpHLtsdrXNRF23DNVRZ/yc/UlX5FXi5prmQS4xk6NsKYjVcE2f1Mm+bdbt
         bD05uFAt7pqGnTp8avEVpxGZpXDP4+8nqQOcRHrfXlJJWYLUr+K7CNgVHwv/7yLn1l
         ocFxufftHewdX66Jjzao6N3c=
Date:   Fri, 16 Oct 2020 21:46:11 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arch/mips/include/asm/addrspace.h:88:37: warning: passing
 argument 1 of 'kfree' makes pointer from integer without a cast
Message-ID: <20201016194611.GK8773@valentin-vidic.from.hr>
References: <202010161852.CGdSDJx5-lkp@intel.com>
 <20201016080251.3e3c4dc0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016080251.3e3c4dc0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:02:51AM -0700, Jakub Kicinski wrote:
> Valentin, looks like we're missing a cast to (void *) or some other
> pointer.. Would you mind sending a fix? You can find cross compilers 
> to test it here, cause this probably only builds for MIPS:
> 
> https://mirrors.edge.kernel.org/pub/tools/crosstool/

Ahh sorry about this, will try to setup cross compiler over the weekend
and check the warning.

-- 
Valentin
