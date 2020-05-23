Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663931DF80C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387906AbgEWPgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 11:36:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgEWPgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:36:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8236207F7;
        Sat, 23 May 2020 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590248206;
        bh=iNgQyRFkPo4T6r4KrsKV1rutOYMdI9Jp2l3mBAYVHJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wwNKkkyCnwDejsKRcTgqrGIgCQBGoIrXEHqx7BIrywNUsHMEpY+ZJuaPd6gffHHvc
         cT5j9htvRVEbi009ZG6N3ATarnmisIY+dRT9x7cQL92+Mnk3103NTAZxLiRdlEz7SB
         Z4uVXUR+ujVl2Yzvhl3xpUaozEc003DXaHMb2IUc=
Date:   Sat, 23 May 2020 17:36:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200523153643.GA226270@kroah.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> In the function kobject_cleanup(), kobject_del(kobj) is
> called before the kobj->release(). That makes it possible to
> release the parent of the kobject before the kobject itself.
> 
> To fix that, adding function __kboject_del() that does
> everything that kobject_del() does except release the parent
> reference. kobject_cleanup() then calls __kobject_del()
> instead of kobject_del(), and separately decrements the
> reference count of the parent kobject after kobj->release()
> has been called.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Tested-by: Brendan Higgins <brendanhiggins@google.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  lib/kobject.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)

Stepping back, now that it turns out this patch causes more problems
than it fixes, how is everyone reproducing the original crash here?

Is it just the KUNIT_DRIVER_PE_TEST that is causing the issue?

In looking at 7589238a8cf3 ("Revert "software node: Simplify
software_node_release() function""), the log messages there look
correct.  sysfs can't create a duplicate file, and so when your test is
written to try to create software nodes, you always have to check the
return value.  If you run the test in parallel, or before another test
has had a chance to clean up, the function will fail, correctly.

So what real-world thing is this test "failure" trying to show?

thanks,

greg k-h
