Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF95F2B286E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKMWVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:21:37 -0500
Received: from ms.lwn.net ([45.79.88.28]:51034 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgKMWVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:21:09 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9C5EF734;
        Fri, 13 Nov 2020 22:21:07 +0000 (UTC)
Date:   Fri, 13 Nov 2020 15:21:06 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 2/2] kernel-doc: Handle function typedefs without
 asterisks
Message-ID: <20201113152106.7b4a07ee@lwn.net>
In-Reply-To: <20201030144713.201372-3-pbonzini@redhat.com>
References: <20201030144713.201372-1-pbonzini@redhat.com>
        <20201030144713.201372-3-pbonzini@redhat.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 15:47:13 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> From: Eduardo Habkost <ehabkost@redhat.com>
> 
> Example of typedef that was not parsed by kernel-doc:
> 
>   typedef void (ObjectUnparent)(Object *obj);
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

So as you've undoubtedly noticed, reading those kernel-doc regexes is ... a
wee bit on the painful side.  Trying to compare two of them in a patch to
figure out what you have done is even worse.  I suspect we want these
patches, but can you please supply a changelog that describes the change? 

> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 5b5caa7642f7..1a9c918aa653 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1302,7 +1302,7 @@ sub dump_typedef($$) {
>      $x =~ s@/\*.*?\*/@@gos;	# strip comments.
>  
>      # Parse function prototypes
> -    if ($x =~ /typedef\s+(\w+\s*\**)\s*\(\*\s*(\w\S+)\s*\)\s*\((.*)\);/ ||
> +    if ($x =~ /typedef\s+(\w+\s*\**)\s*\(\*?\s*(\w\S+)\s*\)\s*\((.*)\);/ ||

Here it appears that you are making the "*" before the function-pointer
name optional, right?  It really would help to say so in the changelog.

This is true for the other patch as well.

>  	$x =~ /typedef\s+(\w+\s*\**)\s*(\w\S+)\s*\s*\((.*)\);/) {
>  
>  	# Function typedefs

Thanks,

jon
