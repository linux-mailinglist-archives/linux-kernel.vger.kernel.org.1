Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C6423A23F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 11:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHCJrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 05:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgHCJrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:47:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B64F20738;
        Mon,  3 Aug 2020 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596448035;
        bh=qpoO7T4TWxeK1V2SJCvaQW+4GFglH2BYvug32jHLcZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zU9zbElCn+GDWj9AK06UOK2yvPDIFQRnBSPFL1gsvV7ntZT2E+Qcj7+sR9u9055C9
         GOYSqzYAeHn84+krzQ6mCctixn+MEBOBB5hcNYXVTKX3hbxQkaaILpXh8oUPpTzXKw
         dNSfKmXr7k4bNv9LkmHODqNtcGWvICQTnAfedGNA=
Date:   Mon, 3 Aug 2020 11:46:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] kobject: Restore old behaviour of kobject_del(NULL)
Message-ID: <20200803094659.GB635660@kroah.com>
References: <20200803082706.65347-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803082706.65347-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:27:06AM +0300, Andy Shevchenko wrote:
> The commit 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in
> kobject_cleanup()") inadvertently dropped a possibility to call kobject_del()
> with NULL pointer. Restore the old behaviour.
> 
> Fixes: 079ad2fb4bf9 ("kobject: Avoid premature parent object freeing in kobject_cleanup()")
> Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: replaced ?: with plain conditional (Greg)
>  lib/kobject.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Thanks, much better, will queue up after -rc1 is out.

greg k-h
