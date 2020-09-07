Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225D125F2C1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 07:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIGFrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 01:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgIGFrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 01:47:32 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DB820732;
        Mon,  7 Sep 2020 05:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599457652;
        bh=a5/cEIfWcSChJxUlNOZzqt8Opy8n1npVY2hwYGW1gGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rENsCMts3CvNXOxvQBkjMQXGS5wtwS44RE0bhwLam9rSZ+OsWVcRPdF7G58SeUhV0
         2ntcJk2vA/cIz9Y/3pBEQuJ9NN8v/Bir93iVS+w24XHg66aLFcm0+LB63plNIdEhtB
         MEf0R+O/LZnf08NcwP6Im3nD7uQk4E2g5ZC32cJ8=
Date:   Mon, 7 Sep 2020 07:47:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] block : Fix use-after-free Read
 in delete_partition
Message-ID: <20200907054729.GA280798@kroah.com>
References: <20200906201158.14014-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906201158.14014-1-anant.thazhemadam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:41:56AM +0530, Anant Thazhemadam wrote:
> A use-after-free read of the kobject member being casted out to the
> device structure containing it seems to be potentially possible
> due to unsafe casting using container_of (since an edge case such
> as when the ptr being casted might be NULL or problematic is not
> accounted for).
> Using container_of_safe resolves this issue, with no obvious tradeoffs
> and without considerable expense.

No, now every caller has to check for NULL, and that would mean that you
now need to fix up hundreds of different places in the kernel.

Please fix the root cause that would cause NULL to be passed to this
call in the block code, don't paper over the issue here.

thanks,

greg k-h
