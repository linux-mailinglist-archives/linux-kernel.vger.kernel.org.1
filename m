Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDAE283964
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgJEPSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgJEPSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:18:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47FB920774;
        Mon,  5 Oct 2020 15:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601911095;
        bh=QANsWJBcybVZjCKHtkB8uPRvP8CkCvd8RdqxgHOFkw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4n4Myg6MYeEk+ful+9jc7e5PUpuHFg1RrmEpFyyaDQqPxKkh2EFR/A9CUweeMed9
         fm3K7+Owe8eic0CP72kObf9bG+1wPwT7oeeLej3/lrbYwfNn6rsLnnrFbqtBqtEdi7
         vvqiERDzH2tKLFBCF8vfDO4ZjFXoOyC8iaKMaduc=
Date:   Mon, 5 Oct 2020 17:18:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: Is usb_hcd_giveback_urb() allowed in task context?
Message-ID: <20201005151857.GA2309511@kroah.com>
References: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:08:11PM +0200, Andrey Konovalov wrote:
> Dear USB and USB/IP maintainers,
> 
> While fuzzing the USB/IP stack with syzkaller we've stumbled upon an issue.
> 
> Currently kcov (the subsystem that is used for coverage collection)
> USB-related callbacks assume that usb_hcd_giveback_urb() can only be
> called from interrupt context, as indicated by the comment before the
> function definition. In the USB/IP code, however, it's called from the
> task context (see the stack trace below).
> 
> Is this something that is allowed and we need to fix kcov? Or is this
> a bug in USB/IP?

It's a bug in kcov, and is not true as you have found out :)

thanks,

greg k-h
