Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E403A2830DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgJEHaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:30:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB17AC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 00:30:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t21so5391364eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 00:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZvquyGjo6OdohUiG/A8csylVnfug5ahvWB2zW5ko35k=;
        b=IWVoIHQ1o151301cUXQKCysumXa7kMl2j4y8laLWJigiRTqa+1Fs6kAXIWunENCANB
         U/MoV4iV4VsU6tPbInmPuDWtDPkEfA8kQcIg+4QqSzCFpxWqhgkY6IjWx8BZ7B1DyR8v
         qPWL5zCi9Oo3y/oGmThuoPhId/u51BYeJYN1wLLUKy5ZXNaf2AO7Dy7/QywdH7qI6XW8
         hTtJPrWviDb932xdq2G5TE+LkFD9lgir1BVhILb2vaFUDwdoXP6+Px0YHe3v3Fl/OTSx
         Y9nM2q5Kn28rzsOKq3Ev4mRqpZI5LRXiGZaL8dLbbqpWK7GrzyUQ4acMESjnQT5ROCuH
         y2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZvquyGjo6OdohUiG/A8csylVnfug5ahvWB2zW5ko35k=;
        b=WpMRRRDPZR5qyFIhLZmqQUV5Ndckb9ERVM4Ajq9VpMF8gFCYvi8VjQTFbif9hbsrSf
         Rj/Ix0R99798FkGTyRUAOISF+hS1lt2Frx0g0V6rf0e0bXYortt1jq7FZVarWkf/hxNb
         inzaivVgHGq2eAsqeZqib2qxI77KgYPNPmw0j5RemlhMIK4S5KSwGzmJW8J9colw+1OC
         4l9RT7Z9cEw9mHI9HR6cgtv5FyTIN3MRHZ4LtUAL9Tv7K58OWhPF/WbDnYI0A1ozGtPE
         VkrQugNaix3PJ45BJjGDuMI5Xlx9rl9zErDlKMotzk9g1QokfftjOqxQqB0bgzWderKA
         IEDw==
X-Gm-Message-State: AOAM530v19yBqB7UaunkfvJTX8dDisD4/eYNArdzndVevZFgBYQfjB57
        hfbY6FKKlx5qvQB3GcvSyKuo8aKkEBVcxVes
X-Google-Smtp-Source: ABdhPJzfHHI3ivhBlXSkK+ClPiNP8EIRMnhjsrAFJS1CZ8CG2qgRICdGZnrzpT2Hfp2ROcKjb8h3sw==
X-Received: by 2002:a50:cf0b:: with SMTP id c11mr15190903edk.87.1601883006427;
        Mon, 05 Oct 2020 00:30:06 -0700 (PDT)
Received: from felia ([2001:16b8:2dcc:7300:fc41:427:81ae:8ef0])
        by smtp.gmail.com with ESMTPSA id u9sm7408611eje.119.2020.10.05.00.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 00:30:05 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 5 Oct 2020 09:30:04 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
cc:     joe@perches.com, linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] checkpatch: add new warnings to author signoff
 checks.
In-Reply-To: <20201005064842.33495-1-dwaipayanray1@gmail.com>
Message-ID: <alpine.DEB.2.21.2010050912210.6202@felia>
References: <20201005064842.33495-1-dwaipayanray1@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Oct 2020, Dwaipayan Ray wrote:

> The author signed-off-by checks are currently very vague.
> Cases like same name or same address are not handled separately.
> 
> For example, running checkpatch on commit be6577af0cef
> ("parisc: Add atomic64_set_release() define to avoid CPU soft lockups"),
> gives:
> 
> WARNING: Missing Signed-off-by: line by nominal patch author
> 'John David Anglin <dave.anglin@bell.net>'
> 
> The signoff line was:
> "Signed-off-by: Dave Anglin <dave.anglin@bell.net>"
> 
> Clearly the author has signed off but with a slightly different version
> of his name. A more appropriate warning would have been to point out
> at the name mismatch instead.
> 
> Introduced three new types of warnings:
> 
> 1) Address matches, but names are different.
>    "James Watson <james@gmail.com>", "James <james@gmail.com>"
> 
> 2) Name matches, but addresses are different.
>    "James Watson <james@watson.com>", "James Watson <james@gmail.com>"
> 
> 3) Name matches, but addresses without mail extensions are same.
>    "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"
> 
> For the 3rd class, a --strict check message is generated, and for the
> other two, warnings are generated.
>

I will start running an evaluation on checkpatch.pl before and after this 
patch to get some insight on this change.
 
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 57 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 31624bbb342e..80feb15f93cb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2347,6 +2347,7 @@ sub process {
>  	my $signoff = 0;
>  	my $author = '';
>  	my $authorsignoff = 0;
> +	my $authorsignoff_ctx = '';
>  	my $is_patch = 0;
>  	my $is_binding_patch = -1;
>  	my $in_header_lines = $file ? 0 : 1;
> @@ -2674,9 +2675,34 @@ sub process {
>  		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
>  			$signoff++;
>  			$in_commit_log = 0;
> -			if ($author ne '') {
> +			if ($author ne ''  && $authorsignoff != 1) {
>  				if (same_email_addresses($1, $author)) {
>  					$authorsignoff = 1;
> +				} else {
> +					my $ctx = $1;
> +					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
> +					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
> +
> +					if($email_address eq $author_address) {
> +						$authorsignoff_ctx = $ctx;
> +						$authorsignoff = 2;
> +					} elsif ($email_name eq $author_name) {
> +						$authorsignoff_ctx = $ctx;
> +						$authorsignoff = 3;
> +
> +						my $address1 = $email_address;
> +						my $address2 = $author_address;
> +
> +						if ($address1 =~ /(\S+)\+\S+(\@.*)/) {
> +							$address1 = $1.$2;
> +						}
> +						if ($address2 =~ /(\S+)\+\S+(\@.*)/) {
> +							$address2 = $1.$2;
> +						}
> +						if($address1 eq $address2) {
> +							$authorsignoff = 4;
> +						}
> +					}
>  				}
>  			}
>  		}
> @@ -6891,9 +6917,32 @@ sub process {
>  		if ($signoff == 0) {
>  			ERROR("MISSING_SIGN_OFF",
>  			      "Missing Signed-off-by: line(s)\n");
> -		} elsif (!$authorsignoff) {
> -			WARN("NO_AUTHOR_SIGN_OFF",
> -			     "Missing Signed-off-by: line by nominal patch author '$author'\n");
> +		} elsif ($authorsignoff != 1) {
> +			# authorsignoff values:
> +			# 0 -> missing sign off
> +			# 1 -> sign off present
> +			# 2 -> address matches, name different
> +			# 3 -> name matches, address different
> +			# 4 -> name matches, address matches without extension
> +
> +			my $ctx_msg = "'Signed-off-by: $authorsignoff_ctx' should be:\n'Signed-off-by: $author'";
> +
> +			if($authorsignoff == 0) {
> +				WARN("NO_AUTHOR_SIGN_OFF",
> +					"Missing Signed-off-by: line by nominal patch author '$author'\n");
> +			}

I think in this case, we could actually turn this into an ERROR; now that 
we have the refined cases (2,3,4) on which we would just warn or 'note' 
with --strict checks.

Lukas

> +			elsif($authorsignoff == 2) {
> +				WARN("NO_AUTHOR_SIGN_OFF",
> +					"Author name mismatch:\n$ctx_msg\n");
> +			}
> +			elsif($authorsignoff == 3) {
> +				WARN("NO_AUTHOR_SIGN_OFF",
> +					"Author address mismatch:\n$ctx_msg\n");
> +			}
> +			elsif($authorsignoff == 4) {
> +				CHK("NO_AUTHOR_SIGN_OFF",
> +					"Author mail extension mismatch:\n$ctx_msg\n");
> +			}
>  		}
>  	}
>  
> -- 
> 2.27.0
> 
> 
