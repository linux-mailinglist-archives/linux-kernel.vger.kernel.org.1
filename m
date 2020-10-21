Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AAA294F87
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444042AbgJUPIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444035AbgJUPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:08:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE8C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:08:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id h24so3729055ejg.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=iSyaRKWVARoZdONObMuoKlVR1YsqMgVG5e09nC+pEas=;
        b=HWuw1p3Fv7JdA7FrnVBvzz7Kf00KqP9bdvppStnyS7V6NTPDSheM/fsfIZIWM77Grb
         dqbwKBS6+miA2jNbbJvRUAshUXtyJKN+rvTFkxIubSB7l+ntoRwBkVDe5jaMx1OZw6jY
         URiexH5UX+/Am3NZVcRqjxU3S9MLNBpqYzjrReefAHfpVjCQX2eeOWbp8dHxnnoCIwjW
         Ocg+qqoJzLj+svW6izkR/EwG6a9lorOvC+gc0xDdHIC2obbMBIWKU/9nrJzYpbupwPLm
         ERSK01mns72pjCRHoTnwTgSj3CvWOpQRT0sKtGQ7Jw6/pHysMKLQ4Ndfo4NRFxinsRbL
         xsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=iSyaRKWVARoZdONObMuoKlVR1YsqMgVG5e09nC+pEas=;
        b=QLNbHPnyCzYYldvV0UxkLDG5LU3vuTarL62OZRQWzxplSlPptqJjDiCLz1aFGmCSHY
         Yu03mNnxRGK5zRf2OSExLTEOlEGPhj5nx7M1rAYYnVZRPE6ox+2JLoGRra8su3/MHz0C
         N1gE0NYQU0F8Zq/DTbFLTXCLk8JNyK8t7UIs4XlsVlRrW4fpIKg+i/oV3yhnvF43ZBQm
         EB6ivWXGCJ+wA+54SJdNqqHwkZXG20Hjxw1zUzlmF0YJ8HxkwsfJBnLkP08umuWzlwCt
         o/GSBlijlBrF59rjDqZjSTG39QX6qOg0+t4J/EXCBZs+HPAXw1VAU/fAvhS0+GDxkMCo
         zgsw==
X-Gm-Message-State: AOAM5318a5lMTpvJUwDEakTNKdB8C1wSpSp1dcbDK8DakPNTkyS26+1X
        LIJNrzUm7DffWqNUm/nZ0kcYTj762p6uAQ==
X-Google-Smtp-Source: ABdhPJwrR37x4tEMkqh0acFcsNIlj6wpwzWomHf4OzvYEw3sQ8Bp69tYaahv2MrvXTB7Fys3d3/6IQ==
X-Received: by 2002:a17:906:3799:: with SMTP id n25mr3908094ejc.6.1603292930710;
        Wed, 21 Oct 2020 08:08:50 -0700 (PDT)
Received: from felia ([2001:16b8:2dac:c500:c428:3741:a9e9:6e3d])
        by smtp.gmail.com with ESMTPSA id j3sm2305372edh.25.2020.10.21.08.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:08:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 21 Oct 2020 17:08:48 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Aditya Srivastava <yashsri421@gmail.com>
cc:     joe@perches.com, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD
 warning
In-Reply-To: <20201021150120.29920-1-yashsri421@gmail.com>
Message-ID: <alpine.DEB.2.21.2010211704230.5382@felia>
References: <20201021150120.29920-1-yashsri421@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 21 Oct 2020, Aditya Srivastava wrote:

> Presence of hexadecimal address or symbol results in false warning
> message by checkpatch.pl.
> 
> For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
> memory leak in mptcp_subflow_create_socket()") results in warning:
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'ff'
>     00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....
> 
> Here, it reports 'ff' to be repeated, but it is in fact part of some
> address or code, where it has to be repeated.
> In this case, the intent of the warning to find stylistic issues in
> commit messages is not met and the warning is just completely wrong in
> this case.
> 
> To avoid all such reports, add an additional regex check for a repeating
> pattern of 4 or more 2-lettered words separated by space in a line.
> 
> A quick evaluation on v5.6..v5.8 showed that this fix reduces
> REPEATED_WORD warnings from 2797 to 1043.
> 
> A quick manual check found all cases are related to hex output in
> commit messages.
>

Aditya, one thing I just noticed the commit message header is a bit
uninformative.

How about something like:

identify typical hex output for a better REPEATED_WORD check

Other than that, it looks good. You might want to share the link to the 
complete report of differences before and after this patch for Joe to 
check as well.

Lukas

> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  scripts/checkpatch.pl | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 9b9ffd876e8a..78aeb7a3ca3d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3050,8 +3050,10 @@ sub process {
>  			}
>  		}
>  
> -# check for repeated words separated by a single space
> -		if ($rawline =~ /^\+/ || $in_commit_log) {
> +# check for repeated words separated by a single space and
> +# avoid repeating hex occurrences like 'ff ff fe 09 ...'
> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> +		$rawline !~ /(\b[0-9a-f]{2}( )+){4,}/) {
>  			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
>  
>  				my $first = $1;
> -- 
> 2.17.1
> 
> 
