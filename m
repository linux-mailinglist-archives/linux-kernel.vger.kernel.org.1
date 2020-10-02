Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E903281E2B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgJBWSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgJBWSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:18:50 -0400
Received: from X1 (c-76-21-107-111.hsd1.ca.comcast.net [76.21.107.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D475120738;
        Fri,  2 Oct 2020 22:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601677130;
        bh=Wqwf0m/QWXfi+uOhsxyJ2gAfBaP0kgwacLBXPbYLv+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1Nw0aIIcveOAxk+GRw9AQbQMBUZMJ2rygQO81RxOHAtUhqRUUnOFjGZY1/+4mLJ7k
         F052EphzTjrCFsJWQmRcZp0MHLI77pEC1fmmxPBNaCmxnxJXjGcr9gVPOzJV9UZc/5
         nfDt3S8Htu8KAfrnLdpclGv8r1yVzVazf2YNZQrE=
Date:   Fri, 2 Oct 2020 15:18:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Emit a warning on embedded filenames
Message-Id: <20201002151849.840bd4c1187d870f328da056@linux-foundation.org>
In-Reply-To: <1fd5f9188a14acdca703ca00301ee323de672a8d.camel@perches.com>
References: <1fd5f9188a14acdca703ca00301ee323de672a8d.camel@perches.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020 11:28:10 -0700 Joe Perches <joe@perches.com> wrote:

> Embedding the complete filename path inside the file
> isn't particularly useful as often the path is moved
> around and becomes incorrect.
> 
> Emit a warning when the source contains the filename.
> 
> ...
>
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3273,6 +3273,12 @@ sub process {
>  			}
>  		}
>  
> +# check for embedded filenames
> +		if ($rawline =~ /^\+.*\Q$realfile\E/) { di
> +			WARN("EMBEDDED_FILENAME",
> +			     "It's generally not useful to have the filename in the file\n" . $herecurr);
> +		}
> +

I removed that " di".  Please check that I merged the correct version
of this!
