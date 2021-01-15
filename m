Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D821F2F6FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbhAOBIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbhAOBIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:08:30 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78134C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:07:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p80so1390558ybg.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vegfqptpw1wNPtbTqAfiW5JhWvOgA4LdeJqD1gHWX4E=;
        b=lOQmMFYv/aAziyh/CpnrmFrAuR95FZjxoihmzPKf5C20G5ryMDRKpfuRq8YbB7RmZ9
         i7WQA/T7Gp4Annewc4jjMNWHnCq0u450OfGzqLyN6MR5kF+W5EBcECvrknNTLOTfoauK
         LhvokVXMoCM0VyqXGrMpmFt8GQ097SpFiwuvKNiadmE61sYGAVaE7dYeTpXKGaJo4/Dd
         rWFaK1EsooRQ8n5p3R2u4yuz9NVs2S5gCS8gk6LxELL46mzZs2R1YZ2yDT5/fzWOoo48
         CMLCtq3nQ03KL0+WnQbb8EzeXKwa1dqxUSPfVD5/ALrfQrV9l/gnbtl25B+TqJiXIYHg
         PfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vegfqptpw1wNPtbTqAfiW5JhWvOgA4LdeJqD1gHWX4E=;
        b=KLuEDuqhJQMRuOVLWIPHuIv+5G9/sLeq4HXbETh5hx1uXivEBUf8pqk57hM7S+zyOD
         6vMsvEdzv7VNwuKIrTkEFb57F7cBfIXJdvlTJA2xJLja8u75a22hhQLo/pP2LVIC6BwW
         ktKfJuw6sFCPBhdIxau6a4OWrVviOFeAlT8m1VfbNlbBhqo8bNBspqguV+bEspi+xbFe
         P7QKzwoHBqM3GfFM/UWkqOl6drwkcuc5sQTiCb0r6na2m/fkN7bVWtpx4k45U2F16dHP
         53KwrSySBoiekC4zIDqYie4M20v+EU7BYMJXIGd3+XZOObk9G7HM14gpXp0N82su/NVS
         Z86A==
X-Gm-Message-State: AOAM530E7o2CEPfbewUDpZfV7Hr9wWsIIfR+/iAsGuTfja0CWA6pYnWL
        F4LO4ZCX+bAgsnAHGSl6DilMwdFBtHEYVOcqd10=
X-Google-Smtp-Source: ABdhPJxF5i0TbGLOYkGZ82ttxe9Qf3lU5+lSqU2BfXphVfUAUnBmPSlnU0vmlYu60m4pWXIfJluI9AxX3aNNbAPKUZs=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:d24a:: with SMTP id
 j71mr14341774ybg.13.1610672869563; Thu, 14 Jan 2021 17:07:49 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:07:46 -0800
In-Reply-To: <1610500731-30960-1-git-send-email-jjohnson@codeaurora.org>
Message-Id: <20210115010746.3839839-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <1610500731-30960-1-git-send-email-jjohnson@codeaurora.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Re: [PATCH 1/2] kbuild: simplify cmd_mod
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jjohnson@codeaurora.org
Cc:     eberman@quicinc.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, mkalikot@codeaurora.org,
        psodagud@quicinc.com, Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mahesh Kumar Kalikot Veetil <mkalikot@codeaurora.org>
> 
> Modules with a large number of compilation units can exceed execv
> argument list resulting in E2BIG (Argument list too long) error.
> 
> Fix this by replacing shell 'echo > file' into a more native
> $(file op filename[,text]) option.
> 
> Signed-off-by: Mahesh Kumar Kalikot Veetil <mkalikot@codeaurora.org>
> Signed-off-by: Jeff Johnson <jjohnson@codeaurora.org>
> ---
>  scripts/Makefile.build | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 4c058f1..252b7d2 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -279,10 +279,11 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
>  	$(call if_changed_rule,cc_o_c)
>  	$(call cmd,force_checksrc)
>  
> -cmd_mod = { \
> -	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
> -	$(undefined_syms) echo; \
> -	} > $@
> +cmd_mod = $(file >$@,\
> +		$(if $($*-objs)$($*-y)$($*-m), \
> +			$(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), \
> +			$(@:.mod=.o))) \
> +	$(undefined_syms) echo >> $@

I find the indendation to be a readability improvement. Thanks for the
patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>  
>  $(obj)/%.mod: $(obj)/%.o FORCE
>  	$(call if_changed,mod)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
> 
