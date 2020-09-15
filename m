Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D3526B7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIPAbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:31:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgIONot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:44:49 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73672074B;
        Tue, 15 Sep 2020 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600177290;
        bh=v7AaEPR0kX7XlsLnnzITWaQTfJ1yQ7dvfw+3Gv6AWgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fn0BBHTggW6Ry+YEi3kHV40igMsLsuDWlJH2kVmNhhgajy/ZPC8w0XhD0BGSnaSvx
         HCvvEQWdAyopkI+9VSl1it5aqO6yD+D3jnaYzYoSXaRcEm/++U3s8+Jq4Z+bGh1+Z1
         qhVhShP9jH6+V1xZL/WdZCYX4OJ0qVeJGIaisjC8=
Date:   Tue, 15 Sep 2020 15:41:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] docs: fb:  Remove scrollback option
Message-ID: <20200915134127.GA873393@kroah.com>
References: <20200915132736.5264-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915132736.5264-1-unixbhaskar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 06:57:36PM +0530, Bhaskar Chowdhury wrote:
> 
> This patch remove the scrollback option under boot option.
> Plus readjust the numbers for the options in that section.
> 
> This is the effect of these commits:
> 
> 973c096(vgacon: remove software scrollback support)
> 5014547(fbcon: remove soft scrollback code)

The kernel documentation file:
	https://www.kernel.org/doc/html/latest/process/submitting-patches.html
in section 2, describes how to show git ids within changelog text
properly (the number of characters and the rest.)

Can you fix this up and resend?

And this is a v2 patch, right?  Always document what changed from
previous patches below the --- line, as the above link asks for.

thanks,

greg k-h
