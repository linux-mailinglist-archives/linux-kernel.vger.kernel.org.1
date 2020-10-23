Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9A297780
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 21:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbgJWTGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 15:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753941AbgJWTGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 15:06:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6363C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:06:51 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dt13so3771352ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4lS64+CIkEXj0LI534exHK/L2eCN1aE6oeDWK6Q60TI=;
        b=bKjrg/BTwofBH/U3Uv+J7Fsgz6uorca/VrAa5Mmdp2kymvGZfjwOi5DsGKDPyXGK2R
         mXJJTX8sY19YgaUZ1mXyQSyKZY2F7+SrzKuJQ1IFBMHRg/gnMf0k48m+V/NKlneH82jP
         Y8y9R+sACYF/624oYn7ImAMQGzUhyh0QT2MMzCYG4MyEd3TZPyTY9RDY8QSKJ3sfCw0Y
         JzuTxBEdpku8AKFAUk7dd495kwl2vpCg6+ondDuiBUkb50MkaqrP6lSjoODyllfovro7
         gNOwaDbJNYfpmbU464Wf5R7K/jKvG4oIVbvP6og3HXgMHBAP46hSe+6BTcB14xIeiwUd
         WX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4lS64+CIkEXj0LI534exHK/L2eCN1aE6oeDWK6Q60TI=;
        b=QhzNr1mjE7jt1vsUia3gh5sPcyaVSJa0UaDASIiTQBry9hZOGTQGfToIj2v/9dcPcf
         t65qcICTFZoPUnUVwGA7b29ecHV4VE3rBt/fDZP8xwQtlkk9m/dNlmQa1mP0xFHU8okC
         yw+Zx+U3glRtB0UFQcSXbaw00cF+JvtYmsJKpd2XJbxPqV4/Jxp73S4BBDX7oHbrSeaf
         bsrlDVMVXjoOa83gnGEDrw6GtD7YKGs+lT9EIwhvj6dhPeGi1CJLevI6He87lbV7tqEW
         AU0YRELaPIhCw7+adU8QM26q/5KX7gGLb8Y0xDZw8dAcc6zFnqeaq0nmZTVtsMP67Thz
         10og==
X-Gm-Message-State: AOAM530Ss9X2Tz+X8M7DYKMtfFRReFaAfMjm0Ut5IZeSayZYxG7JpzET
        2pgeVDs55FBEKkesVQJm2QM=
X-Google-Smtp-Source: ABdhPJyH46ldAtfaD69Y5dJ+HhF0gNO8fnQ+urFkvH2ShhjpNuCPcbDEiydLlTxNe5I6XxbLFob0xA==
X-Received: by 2002:a17:906:1bea:: with SMTP id t10mr3345016ejg.305.1603480010286;
        Fri, 23 Oct 2020 12:06:50 -0700 (PDT)
Received: from felia ([2001:16b8:2d20:a600:91f0:3b46:85c0:ebc7])
        by smtp.gmail.com with ESMTPSA id q3sm1176478edv.17.2020.10.23.12.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 12:06:49 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 23 Oct 2020 21:06:42 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Aditya Srivastava <yashsri421@gmail.com>
cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
In-Reply-To: <20201023133828.19609-1-yashsri421@gmail.com>
Message-ID: <alpine.DEB.2.21.2010232104150.11676@felia>
References: <20201023133828.19609-1-yashsri421@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Oct 2020, Aditya Srivastava wrote:

> Presence of hexadecimal address or symbol results in false warning
> message by checkpatch.pl.
> 
> For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
> memory leak in mptcp_subflow_create_socket()") results in warning:
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'ff'
>     00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....
> 
> Similarly, the presence of list command output in commit results in
> an unnecessary warning.
> 
> For example, running checkpatch on commit 899e5ffbf246 ("perf record:
> Introduce --switch-output-event") gives:
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'root'
>   dr-xr-x---. 12 root root    4096 Apr 27 17:46 ..
> 
> Here, it reports 'ff' and 'root to be repeated, but it is in fact part
> of some address or code, where it has to be repeated.
> 
> In these cases, the intent of the warning to find stylistic issues in
> commit messages is not met and the warning is just completely wrong in
> this case.
> 
> To avoid these warnings, add additional regex check for the
> directory permission pattern and avoid checking the line for this
> class of warning. Similarly, to avoid hex pattern, check if the word
> consists of hex symbols and skip this warning if it is not among the
> common english words formed using hex letters.
> 
> A quick evaluation on v5.6..v5.8 showed that this fix reduces
> REPEATED_WORD warnings from 2797 to 907.
> 
> A quick manual check found all cases are related to hex output or
> list command outputs in commit messages.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>

I think this strategy now makes sense and has the right complexity for a 
good heuristics in this case.

Nice job, Aditya.

Are you ready for a next challenge of this kind? Would you like to work on 
further rules that can be improved with your evaluation approach?

Lukas

> ---
>  scripts/checkpatch.pl | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9b9ffd876e8a..3bd8205c48d8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3051,7 +3051,9 @@ sub process {
>  		}
>  
>  # check for repeated words separated by a single space
> -		if ($rawline =~ /^\+/ || $in_commit_log) {
> +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> +				$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {
>  			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
>  
>  				my $first = $1;
> @@ -3065,6 +3067,17 @@ sub process {
>  				next if ($first ne $second);
>  				next if ($first eq 'long');
>  
> +				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
> +				my @non_hex_words = (
> +					"add", "added", "ace", "aced", "bad", "be", "bed", "bead",
> +					"beaded", "bedded", "cab", "cabbed", "cede", "ceded",
> +					"dead", "deaf", "deb", "decade", "deed", "deface", "defaced", "efface",
> +					"effaced", "face", "faced", "fade", "faded", "fed", "fee", "feed"
> +				);
> +				if ($first =~ /\b[0-9a-f]{2,}\b/) {
> +					next if (!grep(/^$first$/, @non_hex_words));
> +				}
> +
>  				if (WARN("REPEATED_WORD",
>  					 "Possible repeated word: '$first'\n" . $herecurr) &&
>  				    $fix) {
> -- 
> 2.17.1
> 
> 
