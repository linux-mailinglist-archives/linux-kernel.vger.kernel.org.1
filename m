Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E56528B87F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389568AbgJLNxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgJLNwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:52:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B36C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:52:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y14so13551705pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k+H22LYyuFn0P0Ry7ATW9f9JgbPKmhFRt6Rf8v/5Ql0=;
        b=p20Y80X4M9Cg0pWpY78nG/Kt87z3GOpjwZcj4ISItR6cRaqBiGvSkbvqvksIZwfKwv
         rW5N1uDiIkXn/iaOxcNmevi4Q41Ao7oyQgkfvvSqo8JRIJ+1Od2SGfrn3tPYQRqAqW+H
         qbQxaeWNfVakPXFjF2dK7WXxL60gaFCAPSc6bRWw7oDcg+6/ApPr+8DgSqqez4z/zmBZ
         VGlykFmaK9y2UUM7toHZUMyfyqCcJkl+ZktP2o/6wfWsE2aEJvm1tfEBeoSA+VcVNVZY
         3KennaJF2a38itIjWv+DqVeMWLklIeZoS4Oy16GhawZavlU92YKuxArLB5gUYMBlAcuM
         0I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k+H22LYyuFn0P0Ry7ATW9f9JgbPKmhFRt6Rf8v/5Ql0=;
        b=PzOTd7utlEBNk9nneHqD/ZIppZ9VFje2OJdWzZA8LMesUP0kuyF7KdGzOGegVCn+lO
         +hIhKc1q3nzWEdVw64LwjIzeEMZlvrI2dnERyj8TrtAzaBta3VpLzDwVy6hNqQGxI07n
         egjQbq0PR1xe/F9bhBCpUAD7p0X60JXytGktLKZkEztOG6ici0QRq+QW2s997KSP+3NH
         dSobOWW4WQMtlLHW9l52cKIxZxUFkR2D0OkSyf5ZfzVxsF/Ijhj3MNLkTvNK5Gg24bn3
         Ef2uFyTam4cAVEzAxrrIs7l1ZCr8Vw4gpuRtApvP1YXB4IXxxwXsslPFmVqF2c+mZTPI
         MpYQ==
X-Gm-Message-State: AOAM530L3DIyv57K2H1P08muktIP5Cm5tvSnisBj+3D+LG79JrCQ/J9h
        M/sLjvY4JWAB9owQxuE0K6Y4XhXouqpQhQqN
X-Google-Smtp-Source: ABdhPJwQHcU+DZ64oDg6SD8CcXTYw+1y1DcVIBKTuWap4hoSFp9OJj7pbJKvGhyeeBEaCCV4S01zgQ==
X-Received: by 2002:a63:1d52:: with SMTP id d18mr13785853pgm.450.1602510772957;
        Mon, 12 Oct 2020 06:52:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a404:280a:90bd:7a49:dcda:1fb1])
        by smtp.gmail.com with ESMTPSA id g85sm20541168pfb.4.2020.10.12.06.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 06:52:52 -0700 (PDT)
Subject: Re: [RFC PATCH] checkpatch: add shebang check to EXECUTE_PERMISSIONS
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20201012054943.1196031-1-ujjwalkumar0501@gmail.com>
 <63053585d41ff81cdaad6cb727eb83d81207041a.camel@perches.com>
From:   Ujjwal Kumar <ujjwalkumar0501@gmail.com>
Message-ID: <5a3fc45f-e5d7-da3d-4b4b-2a23512ff8de@gmail.com>
Date:   Mon, 12 Oct 2020 19:22:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <63053585d41ff81cdaad6cb727eb83d81207041a.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 11:47 am, Joe Perches wrote:
> On Mon, 2020-10-12 at 11:19 +0530, Ujjwal Kumar wrote:
>> checkpatch.pl checks for invalid EXECUTE_PERMISSIONS on source
>> files. The script leverages filename extensions and its path in
>> the repository to decide whether to allow execute permissions on
>> the file or not.
>>
>> Based on current check conditions, a perl script file having
>> execute permissions, without '.pl' extension in its filename
>> and not belonging to 'scripts/' directory is reported as ERROR
>> which is a false-positive.
>>
>> Adding a shebang check along with current conditions will make
>> the check more generalised and improve checkpatch reports.
>> To do so, without breaking the core design decision of checkpatch,
>> we can fetch the first line from the patch itself and match it for
>> a shebang pattern.
>>
>> There can be cases where the first line is not part of the patch.
> 
> For instance: a patch that only changes permissions
> without changing any of the file content.
> 
>>
>> In that case there may be a false-positive report but in the end we
>> will have less false-positives as we will be handling some of the
>> unhandled cases.
> 
>> Signed-off-by: Ujjwal Kumar <ujjwalkumar0501@gmail.com>
>> ---
>> Apologies, I forgot to include linux-kernel@vger.kernel.org so I'm
>> now resending.
>>
>>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -1795,6 +1795,23 @@ sub get_stat_here {
>>  	return $herectx;
>>  }
> 
> First some style trivia:
> 
>> +sub get_shebang {
>> +	my ($linenr, $realfile) = @_;
>> +	my $rawline = "";
>> +	my $shebang = "";
>> +
>> +	$rawline = raw_line($linenr, 3);
>> +	if (defined $rawline &&
>> +		$rawline =~ /^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
> 
> alignment to open parenthesis please
> 
>> +		if (defined $1 && $1 == 1) {
>> +			$shebang = raw_line($linenr, 4);
>> +			$shebang = substr $shebang, 1;
> 
> parentheses around substr please.
> 
>> +		}
>> +	}
>> +
>> +	return $shebang;
>> +}
> 
> And some real notes:
> 
> $realfile isn't used in this function so there doesn't
> seem to be a reason to have it as an function argument.
> 
>> +
>>  sub cat_vet {
>>  	my ($vet) = @_;
>>  	my ($res, $coded);
>> @@ -2680,7 +2697,9 @@ sub process {
>>  # Check for incorrect file permissions
>>  		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
> 
> probably better here to use a capture group for the permissions
> 
> 		if ($line =~ /^new (?:file )?mode (\d+)$/) {
> 			my $mode = substr($1, -3);

This

> 
>>  			my $permhere = $here . "FILE: $realfile\n";
>> +			my $shebang = get_shebang($linenr, $realfile);
>>  			if ($realfile !~ m@scripts/@ &&
> 
> Maybe remove the $realfile directory test as
> there are many source files that are not scripts
> in this directory and its subdirectories.

this

> 
>> +			    $shebang !~ /^#!\s*(\/\w)+.*/ &&
> 
> unnecessary capture group
> 
> and add
> 
> 			   $mode =~ /[1357]/ &&

this

> 
>>  			    $realfile !~ /\.(py|pl|awk|sh)$/) {
> 
> No need for a a capture group here either. (existing defect)

and this.

> 
>>  				ERROR("EXECUTE_PERMISSIONS",
>>  				      "do not set execute permissions for source files\n" . $permhere);
> 
> 
> 

Should these new changes go as a separate patch or can they be
included in the next iteration of this patch?



Thanks
Ujjwal Kumar
