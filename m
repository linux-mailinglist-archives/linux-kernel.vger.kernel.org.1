Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA12BA79D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgKTKlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgKTKlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:41:20 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46898C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:41:19 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id k7so4670607plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 02:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JhgoSSa0VQ0nyn+Q0xsYnxGWeWoI2cCn6P4kqzjhBDk=;
        b=M3elM6KpbCmxPEC9Db9m32mzN8kKezFp8Nbfb1lEwkDZZZJ3Pjqv9u9zaGx5KR5QrF
         P7Sdi6R/irfMNinKcawL4MYdHhU3y6M9zR5gRBLCpax27sRC7qo89sCV5YMgwnY8+fww
         ewUFh/soVDYIAEdNd8qgtOCv+kxIC3t9aeIFbQLg0Hcd6rsSOGH4/b61pCe2drLrnA9b
         IS3e0pKeFwNjte133UyGb8CFgr+OV18ou0eYoRIHBNEDIZfu+84wL8XOxzbfU7zvM04F
         viJmVrNCnb3TM7F8H1uDmOJGuT66QYxxcvYN0EWNLC6WkHEP30jYT8HTXga6xoVKRpQM
         twag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JhgoSSa0VQ0nyn+Q0xsYnxGWeWoI2cCn6P4kqzjhBDk=;
        b=dUohbfX1CLmlFJAWYJz/9a21kTRxA/Vkqec4rNDpeWt8wuzo5mAREuDoMkWAWz06LW
         5NvlFDAQhDI0GtehXw7YIxuAfuIgtgMy6w3IN4EfTk1lwOhCgPOeHAruGVbd8ogrU5C5
         n+MB+tTewRXfrIzE536S/rc4OUG3FStW61NhJRCKz/MuY/h+77SRTjVS0nb/0bi7mLSv
         ROVIMyitLYzGiAaGXnt5ctHBh8AKvqhq5Vn2vIIy8uYJ8D/piTlBfb+SUsoCyw0rgWgr
         XlBfqVbcYcFIrLFzCSdeKaAe7g0hQqD/GejCCv8sITtZS7lIvshUCP0e/SeJqc0ykfDW
         r4mw==
X-Gm-Message-State: AOAM531h8NF4ELIoIKiIsLLDiuFmvxDLqVdzrb66VkTXq/Ox+Y6Lgc4R
        r8tAqw5vtisdEXqPzDz44EE=
X-Google-Smtp-Source: ABdhPJyKOm2ljjvDVJ6ZkrSlgbnBO006Hn2BcZJ/sfVHnB+G3QJ7cQSSG9pnjasd8sPZHC2oJri/og==
X-Received: by 2002:a17:902:c20a:b029:d6:b2d6:8006 with SMTP id 10-20020a170902c20ab02900d6b2d68006mr13442428pll.31.1605868878734;
        Fri, 20 Nov 2020 02:41:18 -0800 (PST)
Received: from ?IPv6:2402:3a80:40a:513c:8f5:b466:78ec:c186? ([2402:3a80:40a:513c:8f5:b466:78ec:c186])
        by smtp.gmail.com with ESMTPSA id f134sm3116387pfa.208.2020.11.20.02.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 02:41:18 -0800 (PST)
Subject: Re: [PATCH v3] checkpatch: add fix option for
 ASSIGNMENT_CONTINUATIONS
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
References: <20201117171856.13284-1-yashsri421@gmail.com>
From:   Aditya <yashsri421@gmail.com>
Message-ID: <48f56f40-a365-faac-542d-0e120fcf4365@gmail.com>
Date:   Fri, 20 Nov 2020 16:11:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117171856.13284-1-yashsri421@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/20 10:48 pm, Aditya Srivastava wrote:
> Currently, checkpatch warns us if an assignment operator is placed
> at the start of a line and not at the end of previous line.
> 
> E.g., running checkpatch on commit 8195b1396ec8 ("hv_netvsc: fix
> deadlock on hotplug") reports:
> 
> CHECK: Assignment operator '=' should be on the previous line
> +	struct netvsc_device *nvdev
> +		= container_of(w, struct netvsc_device, subchan_work);
> 
> Provide a simple fix by appending assignment operator to the previous
> line and removing from the current line, if both the lines are additions
> (ie start with '+')
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> Changes in v2:
> add check if both the lines are additions (ie start with '+')
> 
> Changes in v3:
> quote $operator; test with division assignment operator ('/=')
> 
>  scripts/checkpatch.pl | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index c9aaaa443265..d5bc4d8e4f6c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3542,8 +3542,14 @@ sub process {
>  
>  # check for assignments on the start of a line
>  		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
> -			CHK("ASSIGNMENT_CONTINUATIONS",
> -			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
> +			my $operator = "$1";
> +			if (CHK("ASSIGNMENT_CONTINUATIONS",
> +				"Assignment operator '$1' should be on the previous line\n" . $hereprev) &&
> +			    $fix && $prevrawline =~ /^\+/) {
> +				# add assignment operator to the previous line, remove from current line
> +				$fixed[$fixlinenr - 1] .= " $operator";
> +				$fixed[$fixlinenr] =~ s/$operator\s*//;
> +			}
>  		}
>  
>  # check for && or || at the start of a line
> 

Hi Joe
This patch probably got missed. Please review :)

Thanks
Aditya
