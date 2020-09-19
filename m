Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9216270FFF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgISShB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 14:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgISShB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 14:37:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11898C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 11:37:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so12316877ejr.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+W3x11Vqeu13cYJqp7VA+bHdI/2mlE3EUEllG/+cpoU=;
        b=oJJUqUnsKSj9jYsDTiGYU3X8IH5x6rBwsvOvE0OqFDYP5M/MejuBNpjZXvkHYjmpFP
         AROtZzeY+qjeYDbyDOg+9Smeq1mG38GSvCiz140x1y2EExd/qdfEF/bbRGs74x2QjAeI
         aXYgsIt+F/DqEd5H5La8AehP4H2eTbjWHSqsf5YDCKGPQUm1jkPf2BLe56YmhHzSeuhX
         pHK2NwZyh33l67TwZOOtPElq/82m2CN53lVNKmGxnba4DNSDryV5/kOnnKywrL1V4t4v
         6JZ31xe02u2SMp8FsaO6kjMvmcVqyuB3DmHydvb7Xsig38YTY1PErZEk74mSyYumIfR5
         iUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+W3x11Vqeu13cYJqp7VA+bHdI/2mlE3EUEllG/+cpoU=;
        b=Ln5xsLcNLe8Ffa+RiT53BD+bfiXKrMejgU/5oTnOZgS3Lx/9mvM5PFFvRftoxK15Cg
         FOJP6x5s9U3EYW7M77fwcg7GtzpeY8y7ULEGTtu3Drm43qxq4kdJ3Suv/ywyUY9z6Pu+
         Rgw+j7ohxVa+DINEWQI5//l6Ykwng1xqFTWLn3fq3gzI+qC9x/cXaLBY537xyQC0F+IP
         Bh300dIEfx4jfRqtkazC7poPdqsI6p6XMTw7HCEPPwY0jkkXDxs6b+XUJxfwO9ZkCB/U
         5JEiRO1pQBbgaxOJQSc+wyOpgQskzFE04sXy/o+cwgBeLS6k51wc2JUcYN7TdCrkHPLU
         djqA==
X-Gm-Message-State: AOAM530QcPLLvbin29PFXr1pTW6WVfToskYKXiRMbmEFcq4PsM0BWtn+
        Zbeg9KcEd0VI1zTVoaxP616ZcGfDsFIv8g==
X-Google-Smtp-Source: ABdhPJxRsjyfHMfcFsD+O6VrQPRmTy3NgnJKgdUmxZfKI4Sv0anKZGZPplHvYQiQbJVczeeXRMaKTg==
X-Received: by 2002:a17:906:934f:: with SMTP id p15mr43242079ejw.497.1600540619428;
        Sat, 19 Sep 2020 11:36:59 -0700 (PDT)
Received: from felia ([2001:16b8:2dba:3d00:c552:323e:8340:ec83])
        by smtp.gmail.com with ESMTPSA id o15sm4925622ejr.1.2020.09.19.11.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2020 11:36:58 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sat, 19 Sep 2020 20:36:57 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: extend author Signed-off-by check for split
 From: header
In-Reply-To: <f5d8124e54a50480b0a9fa638787bc29b6e09854.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2009192033030.7901@felia>
References: <20200919081225.28624-1-dwaipayanray1@gmail.com> <ad937bba6ebd306f6e467add90cfd857bb4f2391.camel@perches.com> <alpine.DEB.2.21.2009191950460.7901@felia> <f5d8124e54a50480b0a9fa638787bc29b6e09854.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 Sep 2020, Joe Perches wrote:

> On Sat, 2020-09-19 at 20:12 +0200, Lukas Bulwahn wrote:
> > 
> > On Sat, 19 Sep 2020, Joe Perches wrote:
> > 
> > > On Sat, 2020-09-19 at 13:42 +0530, Dwaipayan Ray wrote:
> > > > Checkpatch did not handle cases where the author From: header
> > > > was split into two lines. The author string went empty and
> > > > checkpatch generated a false NO_AUTHOR_SIGN_OFF warning.
> > > 
> > > It's good to provide an example where the current code
> > > doesn't work.
> > > 
> > 
> > Joe, as this is a linux-kernel-mentees patch, we discussed that before 
> > reaching out to you; you can find Dwaipayan's own evaluation here:
> > 
> > https://lore.kernel.org/linux-kernel-mentees/CABJPP5BOTG0QLFSaRJTb2vAZ_hJf229OAQihHKG4sYd35i_WMw@mail.gmail.com/
> > 
> > Dwaipayan, Joe's comment is still valid; it would be good to describe
> > the reasons why patches might have split lines (as far as see, long 
> > encodings for non-ascii names).
> > 
> > I will run my own evaluation of checkpatch.pl before and after patch 
> > application on Monday and then check if I can confirm Dwaipayan's results.
> > 
> > > It likely would be better to do this by searching forward for
> > > any extension lines after a "^From:' rather than searching
> > > backwards as there can be any number of extension lines.
> > > 
> > 
> > Just to sure what you are talking about...
> > 
> > You mean just to access the next line through the lines array, rather 
> > than using prevheader and trying to decode that one line twice.
> > 
> > I agree the logic is a bit redundant and complicated at the moment.
> > 
> > Once prevheader is non-empty, it already clear that author is '' and 
> > prevheader decodes with that match, because that is the only way to
> > make prevheader non-empty in the first place; at least as far I see it 
> > right now.
> 
> Yeah, something like this (completely untested):
> ---
>  scripts/checkpatch.pl | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3e474072aa90..2c710d05b184 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2679,9 +2679,13 @@ sub process {
>  		}
>  
>  # Check the patch for a From:
> -		if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> +		if ($line =~ /^From:\s*(.*)/i) {
>  			$author = $1;
> -			$author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
> +			my $curline = $linenr;
> +			while (defined($rawlines[$curline] && $rawlines[$curline++] =~ /^ \s*(.*)/) {
> +				$author .= $1;
> +			}
> +			$author = encode("utf8", $author) if ($author =~ /=\?utf-8\?/i);
>  			$author =~ s/"//g;
>  			$author = reformat_email($author);
>  		}
>

Yeah, I get how you would like to see that being implemented. I will work 
with Dwaipayan to get that properly implemented, properly described and 
tested.

But let us keep the fun of that task to Dwaipayan... that is what a 
mentorship is all about :)

Lukas
