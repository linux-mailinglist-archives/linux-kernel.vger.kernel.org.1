Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF8827158B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgITQDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:03:10 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20418 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbgITQDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:03:10 -0400
X-IronPort-AV: E=Sophos;i="5.77,283,1596492000"; 
   d="scan'208";a="468621384"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 18:03:08 +0200
Date:   Sun, 20 Sep 2020 18:03:07 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     apw@canonical.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: outside repository fatal error
In-Reply-To: <cca15cb7889f25ab010300a3e7e55dd63478c1fc.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009201802270.2966@hadrien>
References: <alpine.DEB.2.22.394.2009201346560.2966@hadrien> <cca15cb7889f25ab010300a3e7e55dd63478c1fc.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 Sep 2020, Joe Perches wrote:

> On Sun, 2020-09-20 at 13:53 +0200, Julia Lawall wrote:
> > The commit bcf4271d4bc3 ("checkpatch: allow not using -f with files that
> > are in git") in linux-next seems to cause checkpatch to fail on a file
> > containing a patch if that file is not in the directory containing the
> > Linux kernel.
>
> Thanks for the report.
>
> > Is that intentional?
>
> No.  It doesn't really fail, it just emits a fatal
> warning from git.
>
> I believe this makes it better by silencing the error.

It seems fine now.

Reviewed-by: Julia Lawall <julia.lawall@inria.fr>

julia

> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3e474072aa90..469f8e7456df 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -981,7 +981,7 @@ sub git_is_single_file {
>
>  	return 0 if ((which("git") eq "") || !(-e "$gitroot"));
>
> -	my $output = `${git_command} ls-files -- $filename`;
> +	my $output = `${git_command} ls-files -- $filename 2>/dev/null`;
>  	my $count = $output =~ tr/\n//;
>  	return $count eq 1 && $output =~ m{^${filename}$};
>  }
>
>
>
>
