Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADE228146B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbgJBNpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgJBNpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:45:33 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96216206CA;
        Fri,  2 Oct 2020 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601646333;
        bh=5GP9MmZo/x7A2zqlRFFCCczCNneB82NjqhFFjeWecLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AB2cQoLekv1iTygRxhi3WEKCPj11JyHovtVa/95kSNjyU9P8YYJ3lYEXGvcxUMbCn
         w3FM3asfN4jB2egn851s8h9P8yoLGwkzVXyb3QS92aHd0tRnUn6mlAFhhkzU8eG58s
         aq0OBmHghMGE80Fl1O7RpBWfnGOhY5PGo13FCJGE=
Date:   Fri, 2 Oct 2020 15:45:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     pierre kuo <vichy.kuo@gmail.com>
Cc:     rafael@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] driver core: platform: provide
 devm_platform_iounremap_resource
Message-ID: <20201002134532.GA3419175@kroah.com>
References: <20200920113808.22223-1-vichy.kuo@gmail.com>
 <20200920113808.22223-2-vichy.kuo@gmail.com>
 <CAOVJa8F+NZQM4H=1Y683g7DTZQ2z1YSH0pKRCVcN+JmQfEi81g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOVJa8F+NZQM4H=1Y683g7DTZQ2z1YSH0pKRCVcN+JmQfEi81g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:21:37PM +0800, pierre kuo wrote:
> Hi Greg and Rafael:
> Would you please help to review these 2 patches?
> 
> https://lkml.org/lkml/2020/9/20/112
> https://lkml.org/lkml/2020/9/20/113

Please resend, I can't take patches off of a random web site.

Now lore.kernel.org I could take them from :)

thanks,

greg k-h
