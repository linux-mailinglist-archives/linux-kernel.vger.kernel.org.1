Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5335E1C0E71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgEAHFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 03:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAHFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:05:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 432AD20787;
        Fri,  1 May 2020 07:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588316740;
        bh=jYNhlYnFtixV0yMkmtZtTWGf5j9cLn7aPBRr6wi5fJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj19+ZqqfEzypqnR6XVc2An/vln/tzKyCpEEiGSpr6D4oqqo3lGgitV104SmxOrvs
         odRbzMqcNBlNp28qtXx5QRxVRYMiZHIkE2C1lMw+vLyD3KLh8e3C6rTCLI9jrsnqNg
         VbQyE1KTSjO/XKmpUBTUsAOrAlw9qHuECHuobW0A=
Date:   Fri, 1 May 2020 09:05:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     balbi@kernel.org, syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in gadget_dev_desc_UDC_store
Message-ID: <20200501070538.GB887524@kroah.com>
References: <CAEAjamvq+puThrxfo80TOy=xgbQEQNT6xvxy4w6hP2O1By66uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamvq+puThrxfo80TOy=xgbQEQNT6xvxy4w6hP2O1By66uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 11:03:54PM -0400, Kyungtae Kim wrote:
> We report a bug (in linux-5.6.8) found by FuzzUSB (a modified version
> of syzkaller).
> 
> This happened when the size of "name" buffer is smaller than that of
> "page" buffer
> (after function kstrdup executed at line 263).
> I guess it comes from the "page" buffer containing 0 value in the middle.
> So accessing the "name" buffer with "len" variable, which is used to
> indicate the size of "page" buffer,
> triggered memory access violation.
> To fix, it may need to check the size of name buffer, and try to use
> right index variable.

Can you submit a patch for this as you have a reproducer to test the
issue?

thanks,

greg k-h
