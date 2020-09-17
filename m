Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0948426D504
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIQHrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgIQHrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:47:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F76321D43;
        Thu, 17 Sep 2020 07:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600328834;
        bh=CALILkZxFAAAwnWnrpQMoX+SZOHKjQaj7OhbjiEzVps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldPCAyvT8fhBDn6tx7RoNJE/AnFWnL6/6xwKfONdmxDxHatfCnV61IJWkXI8lQy5b
         sRb2m/tTY7mI1LlLh20/u8iI55yGN2agl7XcT6+DU37rB0RAMcELyCeWy4/Af9VeSV
         OPkhdNHetiEEj8JjXJZF0R1ZJ8vz3lbmoCWYKwAM=
Date:   Thu, 17 Sep 2020 09:47:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, rdunlap@infradead.org, daniel@ffwll.ch,
        yuanmingbuaa@gmail.com, w@1wt.eu, nopitydays@gmail.com,
        zhangyunhai@nsfocus.com, luto@amacapital.net,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v3] docs: fb: Remove framebuffer scrollback boot option
Message-ID: <20200917074747.GA3332340@kroah.com>
References: <20200916230150.14516-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916230150.14516-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 04:31:50AM +0530, Bhaskar Chowdhury wrote:
> This patch remove reference to this option in this document and 
> renumbered the sections. This is related to below commits.
> 
> Commit 973c096f6a85(vgacon: remove software scrollback support)
> Commit 50145474f6ef(fbcon: remove soft scrollback code)
>  
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> This version try to correct the previous errors, proper changelog text, subject
> Trying to incorporate Willy's & Greg's suggestions

Better, but...

This should be a patch series, properly numbered and threaded, right?

The text above still has the commit ids not properly referenced, and you
have trailing whitespace in the text too.

Writing the changelog is often times the hardest part of a patch, as you
are finding out.

How about this example, for this specific patch, as a changelog text:

---------
In commit 50145474f6ef ("fbcon: remove soft scrollback code"), the
framebuffer scrollback mode was removed, but the documentation was not
updated.  Properly update the documentation by removing the option that
is no longer present, and update the section numbering because of the
removal.
---------

Doesn't that make more sense about what is happening here, and provide
enough information that when someone 10+ years from now goes and tries
to find out why a boot option went away, what exactly happened and why?

Can you make this type of change to all 4 of these patches and resend
them, with the proper change information below the --- line as a v4
series?

thanks,

greg k-h
