Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9672B15E9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 07:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKMGqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 01:46:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgKMGqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:46:01 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7879820B80;
        Fri, 13 Nov 2020 06:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605249961;
        bh=2IrTy598p5eO9wUbXEXxTKsfXd945Fw5j2OUTg3vc/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMR+Phe4fxTEMlgID3/X2hbOGxu2oMWxSthh1WOKCZn1He3cDP4lZqzn0yiw4mJSr
         S9oe53hqG/W3sYaIZl44PQ01/nhCOMRD2Xh9RsfJN22+vxZz7acFVnrXdt+6LOLG3u
         BJEs9uuLGttEL7vCwgAUQUGIyOsaGjUyFkdV4jhg=
Date:   Fri, 13 Nov 2020 07:46:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King <linux@armlinux.org.uk>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [Fonts]  9522750c66:  fio.read_iops 7.5% improvement
Message-ID: <X64r4X/By+0BTc6a@kroah.com>
References: <20201112140625.GA21612@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112140625.GA21612@xsang-OptiPlex-9020>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 10:06:25PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a 7.5% improvement of fio.read_iops due to commit:
> 
> 
> commit: 9522750c66c689b739e151fcdf895420dc81efc0 ("Fonts: Replace discarded const qualifier")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

I strongly doubt this :)

