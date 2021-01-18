Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FCB2FAB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394287AbhARUSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:18:15 -0500
Received: from mail-1.ca.inter.net ([208.85.220.69]:45435 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437994AbhARURa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:17:30 -0500
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id 7680F2EA30D;
        Mon, 18 Jan 2021 15:16:43 -0500 (EST)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id Ip4T-viMDDji; Mon, 18 Jan 2021 15:03:07 -0500 (EST)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id DA1402EA307;
        Mon, 18 Jan 2021 15:16:42 -0500 (EST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH] checkpatch: Improve TYPECAST_INT_CONSTANT test message
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <f11f2ee7-a909-6ab7-f5a8-67a46e11c1e5@interlog.com>
 <63178794d14d12f28ccf87707f420ba97b90f6fd.camel@perches.com>
 <b9861410-f23d-62aa-cdc9-9e2918359a86@interlog.com>
 <ecefe8dcb93fe7028311b69dd297ba52224233d4.camel@perches.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <1afecb44-cc40-c943-8d6e-eb3f50eaa9f9@interlog.com>
Date:   Mon, 18 Jan 2021 15:16:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ecefe8dcb93fe7028311b69dd297ba52224233d4.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-18 12:19 p.m., Joe Perches wrote:
> Improve the TYPECAST_INT_CONSTANT test by showing the suggested
> conversion for various type of uses like (unsigned int)1 to 1U.

The questionable code snippet was:
         unsigned int nent, nalloc;

         ....
         if (check_add_overflow(nent, (unsigned int)1, &nalloc))

where the check_add_overflow() macro [include/linux/overflow.h]
uses typeid to check its first and second arguments have the
same type. So it is likely others could meet this issue.

Doug Gilbert


> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> Douglas Gilbert sent me a private email (and in that email said he
> 'loves to hate checkpatch' ;) complaining that checkpatch warned on the
> use of the cast of '(unsigned int)1' so make it more obvious why the
> message is emitted by always showing the suggested conversion.
> 
>   scripts/checkpatch.pl | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 016115a62a9f..4f8494527139 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6527,18 +6527,18 @@ sub process {
>   		if ($line =~ /(\(\s*$C90_int_types\s*\)\s*)($Constant)\b/) {
>   			my $cast = $1;
>   			my $const = $2;
> +			my $suffix = "";
> +			my $newconst = $const;
> +			$newconst =~ s/${Int_type}$//;
> +			$suffix .= 'U' if ($cast =~ /\bunsigned\b/);
> +			if ($cast =~ /\blong\s+long\b/) {
> +			    $suffix .= 'LL';
> +			} elsif ($cast =~ /\blong\b/) {
> +			    $suffix .= 'L';
> +			}
>   			if (WARN("TYPECAST_INT_CONSTANT",
> -				 "Unnecessary typecast of c90 int constant\n" . $herecurr) &&
> +				 "Unnecessary typecast of c90 int constant - '$cast$const' could be '$const$suffix'\n" . $herecurr) &&
>   			    $fix) {
> -				my $suffix = "";
> -				my $newconst = $const;
> -				$newconst =~ s/${Int_type}$//;
> -				$suffix .= 'U' if ($cast =~ /\bunsigned\b/);
> -				if ($cast =~ /\blong\s+long\b/) {
> -					$suffix .= 'LL';
> -				} elsif ($cast =~ /\blong\b/) {
> -					$suffix .= 'L';
> -				}
>   				$fixed[$fixlinenr] =~ s/\Q$cast\E$const\b/$newconst$suffix/;
>   			}
>   		}
> 
> 

