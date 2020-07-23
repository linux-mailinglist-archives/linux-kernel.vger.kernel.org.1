Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB0C22B233
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 17:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgGWPLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 11:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727940AbgGWPLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:11:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD1C20771;
        Thu, 23 Jul 2020 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595517070;
        bh=lou3FzXpILjbYCI2pCqDsP5iW+uI60hWnt6VY6f+T1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/CnPJohw4SwWxEh9+nl4JiRDRW9qOvCptekC2LJ8toUnt9kaHIranDC0G1jrEKJs
         Wu6csYX0EZRXTVZwUo2/3hnVAK5nvdHRjIeNb5RwXNvgu7dlg55W+05MREWzpVJ2oj
         B7Zh8lsCKWmkoGf1Jb6DXXLeP7hGOMFmUUFcPVTA=
Date:   Thu, 23 Jul 2020 17:11:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v8 0/2] debugfs: Add access restriction option
Message-ID: <20200723151114.GA2793748@kroah.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200716071511.26864-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716071511.26864-1-peter.enderborg@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:15:09AM +0200, Peter Enderborg wrote:
> Since debugfs include sensitive information it need to be treated
> carefully. But it also has many very useful debug functions for userspace.
> With this option we can have same configuration for system with
> need of debugfs and a way to turn it off. This gives a extra protection
> for exposure on systems where user-space services with system
> access are attacked.
> 
> v2. Removed MOUNT as part of restrictions. Added API's restrictions as
>     separate restriction.
> v3  Updated Documentation after Randy Dunlap reviews and suggestions.
> v4  Removed #ifdefs from inode.c and using internal.h for configuration
>     and now using BIT() for that. Function is now always on, and are
>     instead selected by a built in default or command line parameter.
>     Changed return value on debug_mount
>     Reported-by: kernel test robot <lkp@intel.com>
>     Im not sure about that it is right
> v5  Added notes to config help suggested by GregKH.
>     Removed _BIT from names, white-space and tab.
>     (checkpatch did not complain).
> v6  Using ALLOW instead of ACCESS as name on BIT's. Change the fs to
>     mount to make it clear and easy to understand.
> v7  Updated Kconfig.debug with Randy Dunlap corrections.
> v8  Spell fixes from Randy and using else-if for command argument
>     parser.
>     
> 

Thanks for sticking with this, now queued up!

greg k-h
