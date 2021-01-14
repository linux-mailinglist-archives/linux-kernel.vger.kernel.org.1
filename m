Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C65F2F6CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 22:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbhANVIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 16:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbhANVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 16:08:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E9EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:07:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 203so3183681ybz.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Od5mYrBputSjJFGBKg3W1pEBcGlpib1bLvjQs/hloB4=;
        b=wJfVvK4/Zt5codxwwwZCvvEyV6W+xcr93R8yi2xqrTD/AEYm0/UEQRVfHQBgXXVfm+
         IA5j/i0WnmGcUt0XLEyH+zyi1EdQVCzXO0DdogxsmWAfa271IIDAl51KTXbMG+QE70Py
         iDvYaNyRoDFdkJqSA7Wo7uA4jarprhNN/qfaWxzU5FzGd/Um2/JIl3UAmvHyPEJRXp4I
         vLbb/B1oWS7mS/Ce/83vC+EfoUDyFOJ1NFqFdOfJ+c8YdT2mSInUgWowzKpsjcON3dS0
         4qEXHrdP1JAPg8RMzsuBqFMrh+wEPvovJlyfi6yB/Xk+2NMQDi6/hsg9NZ+X885nQrnk
         Oq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Od5mYrBputSjJFGBKg3W1pEBcGlpib1bLvjQs/hloB4=;
        b=BX+KptBFg6vblpwep2IUcnAeHNwHDl9Ci/jKN+hUOxQMguVkQ7EScmPgxS6MsWWtSB
         IrNorBdDwB3Xsdqcmu8LG1zqBdszVQx3bEBLIQ5ph120vTHu4wn+SQfsdln1JwllyZ4K
         WMId41ilhCFbK6DmAGrdZ7WmLm35sEtW3rnkcBN3v34VYkLZQn53zX7pfnaMeWxGWH36
         AKO2haJ+hx/20+5fMZ/+izTIjleCo7nJFTFBBKiK+1LxHHeMjJN3WYmZhAk1/bpowUOX
         acq1627A7IPdYn+OGSUsuWP0u5kCuAHCPKPafZbKv0bkza5zA9WwA2zY9eAx0Hm9sA71
         wXwA==
X-Gm-Message-State: AOAM531LQ9kiO4fXntU4PidXCfK0+CsgixYdZLU5iVDvJSUKUcWsvXYs
        w/NzUqvsGdfuXHn0Sj1o6P3EaJFPvVKBJNFUix0=
X-Google-Smtp-Source: ABdhPJzc0iDbC8S94zZ004rBvGEeoa2WqO4GppJtv9SOfLJcJlMYtoFbmfX+IJl62vJxRuQ7u+o1NjgSvm6a5WCduRQ=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:29c1:: with SMTP id
 p184mr52665ybp.34.1610658455420; Thu, 14 Jan 2021 13:07:35 -0800 (PST)
Date:   Thu, 14 Jan 2021 13:07:33 -0800
In-Reply-To: <1610500731-30960-2-git-send-email-jjohnson@codeaurora.org>
Message-Id: <20210114210733.3490303-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <1610500731-30960-2-git-send-email-jjohnson@codeaurora.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: Re: [PATCH 2/2] kbuild: handle excessively long argument lists
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     jjohnson@codeaurora.org
Cc:     eberman@quicinc.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, mkalikot@codeaurora.org,
        psodagud@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mahesh Kumar Kalikot Veetil <mkalikot@codeaurora.org>
> 
> Modules with a large number of compilation units may be
> exceeding AR and LD command argument list. Handle this gracefully by
> writing the long argument list in a file. The command line options
> read from file are inserted in place of the original @file option.
> 
> The usage is well documented at
> https://www.gnu.org/software/make/manual/html_node/File-Function.html
> 
> Signed-off-by: Mahesh Kumar Kalikot Veetil <mkalikot@codeaurora.org>
> Signed-off-by: Jeff Johnson <jjohnson@codeaurora.org>
> ---
>  scripts/Makefile.build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 252b7d2..d5ef345 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -425,7 +425,11 @@ $(obj)/lib.a: $(lib-y) FORCE
>  # module is turned into a multi object module, $^ will contain header file
>  # dependencies recorded in the .*.cmd file.
>  quiet_cmd_link_multi-m = LD [M]  $@
> -      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
> +      cmd_link_multi-m =					\
> +	$(file >$@.in,$(filter %.o,$^))				\
> +	$(LD) $(ld_flags) -r -o $@ @$@.in;			\
> +	rm -f $@.in
> +endif

Was this build tested?

$ make LLVM=1 LLVM_IAS=1 -j72 defconfig
scripts/Makefile.build:432: *** extraneous 'endif'.  Stop.
make: *** [Makefile:535: scripts_basic] Error 2

(Please cc me on v2)

>  
>  $(multi-used-m): FORCE
>  	$(call if_changed,link_multi-m)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project


