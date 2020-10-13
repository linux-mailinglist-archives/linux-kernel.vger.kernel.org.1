Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF36928CDDA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgJMMOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgJMMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68DC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:14:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so16595033pfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=62xj6Z5K6RaOB3QGkKQ3gtjEFjGAuL9DJs4xyn/7xfk=;
        b=TiLUessVNvPerT33mxDAafifPiaIZtStQjLAvsJW93Crb1377hc+gWtbpb0E8oRgmU
         Aeas5RvEIh4a9+ARLdDsf7qvMQjLBH5oQAK2r3ohPfVVjE+8KUFwkEYflc+lKZfEWykW
         3PHvBjeSxWkQZuU9D+MH5CAC+NjtxtSrAOQD2g0m83IfewyD6vfB6R3HwuY9E05knkk7
         idki0wfLcoZfNnxss61659mWeCVz0n4HVYmTVOKJV9MJd41HFTv0OihT/frwrG5o1wzP
         /UHSiK8achMg0+I8h97J4MHgSVqHkVBY3jlnEUMSnyKTeJN8mTrv2UlBV0ZW9KOLmk6i
         04Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=62xj6Z5K6RaOB3QGkKQ3gtjEFjGAuL9DJs4xyn/7xfk=;
        b=b2vsEVvGe9XTUCCQSzl0e80gnEe2sFZIJR9EQ79mxZJOTkw7KYie8exPpfOUkxj6VL
         e1p+mETqArMdNbg3Y3IoReVV6KYo9babFKous0T85C9teNiTI8EVEY0yCK2ADwQSFLq6
         BbJ6IsBuXXFi2MuQ1WUWr8lKQ7QnhBIDYBbtFTlF5+Y9xp76Nle+BGl1RN32tX7C+gpu
         C62kWkBFfpq7Ri4278s+jVIGE2zuXWkPfICC3i4hb7GPsUnLvYS1WztOtZ9DC+52UFMC
         I9F2FTGI1zMZS0B2+fDSGdQwdVGsc52kZBjNdXIDPgyXumDrLvTB6rz83RmEoRFqpO82
         6TSA==
X-Gm-Message-State: AOAM533tEU3Itx5t+sFKd2neup8vt50eJ82AQsGMJ7mTU3jzlLCt8Wgw
        vJKLX9JDF6dHllqqBH5jjtk=
X-Google-Smtp-Source: ABdhPJweAawdGQMKXJlXVfvEq1MWE1cIqNb50IZn1NW5sE0z0kyVzdNB7szq15efpz0/TtLvSj9+ww==
X-Received: by 2002:a62:6408:0:b029:154:dde2:a5eb with SMTP id y8-20020a6264080000b0290154dde2a5ebmr29126945pfb.30.1602591243907;
        Tue, 13 Oct 2020 05:14:03 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:a404:280a:90bd:7a49:dcda:1fb1])
        by smtp.gmail.com with ESMTPSA id z6sm23508878pfg.12.2020.10.13.05.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 05:14:03 -0700 (PDT)
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
To:     Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
From:   Ujjwal Kumar <ujjwalkumar0501@gmail.com>
Message-ID: <da3053be-f27e-f99c-0a8a-447adb9733d2@gmail.com>
Date:   Tue, 13 Oct 2020 17:43:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/20 5:31 pm, Ujjwal Kumar wrote:
> checkpatch.pl checks for invalid EXECUTE_PERMISSIONS on source
> files. The script leverages filename extensions and its path in
> the repository to decide whether to allow execute permissions on
> the file or not.
> 
> Based on current check conditions, a perl script file having
> execute permissions, without '.pl' extension in its filename
> and not belonging to 'scripts/' directory is reported as ERROR
> which is a false positive.
> 
> Adding a shebang check along with current conditions will make
> the check more generalised and improve checkpatch reports.
> To do so, without breaking the core design decision of checkpatch,
> we can fetch the first line from the patch itself and match it for
> a shebang pattern.
> 
> There can be cases where the first line is not part of the patch.
> For instance: a patch that only changes permissions without
> changing any of the file content.
> In that case there may be a false positive report but in the end we
> will have less false positives as we will be handling some of the
> unhandled cases.
> 
> Signed-off-by: Ujjwal Kumar <ujjwalkumar0501@gmail.com>
> ---
> Changes in v2:
>   - Spelling correction and add example to commit
>     message
>   - Code style changes
>   - Remove unncessary function argument
>   - Use non-capturing group in regexp
> 
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fab38b493cef..7ebbee9c3672 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1795,6 +1795,23 @@ sub get_stat_here {
>  	return $herectx;
>  }
> 
> +sub get_shebang {
> +	my ($linenr) = @_;
> +	my $rawline = "";
> +	my $shebang = "";
> +
> +	$rawline = raw_line($linenr, 3);

I'm wondering if the range information can be at a
different offset from the 'new mode line'.

> +	if (defined($rawline) &&
> +	    $rawline =~ /^\@\@ -\d+(?:,\d+)? \+(\d+)(,(\d+))? \@\@/) {
> +		if (defined($1) && $1 == 1) {
> +			$shebang = raw_line($linenr, 4);
> +			$shebang = substr($shebang, 1);
> +		}
> +	}
> +
> +	return $shebang;
> +}
> +
>  sub cat_vet {
>  	my ($vet) = @_;
>  	my ($res, $coded);
> @@ -2680,7 +2697,9 @@ sub process {
>  # Check for incorrect file permissions
>  		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
>  			my $permhere = $here . "FILE: $realfile\n";
> +			my $shebang = get_shebang($linenr);
>  			if ($realfile !~ m@scripts/@ &&
> +			    $shebang !~ /^#!\s*(?:\/\w)+.*/ &&
>  			    $realfile !~ /\.(py|pl|awk|sh)$/) {

Consider the following case:
a python script file with '.py' filename extension but without
a shebang line. Would it be meaningful to allow execute permission
on such a file?

>  				ERROR("EXECUTE_PERMISSIONS",
>  				      "do not set execute permissions for source files\n" . $permhere);
> 
> base-commit: 148fdf990dee4efd23c1114811b205de9c966680
> --
> 2.26.2
> 

Thanks
Ujjwal Kumar
