Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777132F1FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391156AbhAKTvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbhAKTvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:51:32 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4928AC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:50:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id p12so166456pju.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n6ls+HCeSi/UAGSF82kmFOo5CUAwHtYihLvyPgL0mcE=;
        b=H8QTkAzz/CeEF6/0Vl1CTWBMYc/3JUp0GGJBSpkbejf0BMipsZqtGfUzN7Jjgc7t18
         1Jfhjcnv8nEpLFEsI85m5V2Do69agxrK4EKE81AEH2PDf69QwM/T+1ryVsFHN2OFFAQL
         W3NnhhLBGonsRHVxbY4xVLnczBS7PwApeaLkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6ls+HCeSi/UAGSF82kmFOo5CUAwHtYihLvyPgL0mcE=;
        b=lhr9fSoycDeMXxAResVty6GeKQ4hNj0EeDDbB5xLWX5gFwYks3G6X4QbsN8IwLH7v5
         DuP+qhHCnW1ZGpNFvOGo5Km7SVVgssJb0/SrBWyTW1Ini9aQT4/kzbkDhaMFRVm1gH28
         Y/thprEA4nYrE3tpKxHk9ImOlTGtgD5au4rlWgdQR07iJi3XVlf19EYEIc7kXlBFOIH3
         dfdnF1maDSnF7x2Lr43HiipndyTLbAZ+c40/3NSFuTKXEIKAaPd7g9SVx5sj+AaAYcqs
         CjSfT8R6l1UGmNOM2zlEIMWFL8Dn+0PTCxTdrri/YLiKBA7NuMjS6fbO7JdPuxjRRAoC
         RMZQ==
X-Gm-Message-State: AOAM532UaJyVcfPTKkIgOmP3Et7zRNoxtI8QaVPgrKId8neBFKJc0TiA
        7+/iSAFlBD+TlRpMs02Qv5dLFg==
X-Google-Smtp-Source: ABdhPJxKa7QP3e4sq1yJcAafKZZT/e+hen74xAJGxhKWlM/2If7MuvrSisNeNB/Dxb26DvWCKVgWEw==
X-Received: by 2002:a17:902:d48c:b029:de:2fb:98a with SMTP id c12-20020a170902d48cb02900de02fb098amr859988plg.59.1610394651729;
        Mon, 11 Jan 2021 11:50:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t135sm451741pfc.39.2021.01.11.11.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:50:50 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:50:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Xiaoming Ni <nixiaoming@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        yzaikin@google.com, adobriyan@gmail.com,
        linux-fsdevel@vger.kernel.org, vbabka@suse.cz, wangle6@huawei.com
Subject: Re: [PATCH v2] proc_sysctl: fix oops caused by incorrect command
 parameters.
Message-ID: <202101111149.20A58E1@keescook>
References: <20210108023339.55917-1-nixiaoming@huawei.com>
 <20210108092145.GX13207@dhcp22.suse.cz>
 <829bbba0-d3bb-a114-af81-df7390082958@huawei.com>
 <20210108114718.GA13207@dhcp22.suse.cz>
 <202101081152.0CB22390@keescook>
 <20210108201025.GA17019@dhcp22.suse.cz>
 <20210108175008.da3c60a6e402f5f1ddab2a65@linux-foundation.org>
 <bc098af4-c0cd-212e-d09d-46d617d0acab@huawei.com>
 <20210111142131.GA22493@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111142131.GA22493@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 03:21:31PM +0100, Michal Hocko wrote:
> On Mon 11-01-21 11:48:19, Xiaoming Ni wrote:
> [...]
> > patch3:
> > 	+++ b/fs/proc/proc_sysctl.c
> > 	@@ -1770,6 +1770,9 @@ static int process_sysctl_arg(char *param, char *val,
> > 							return 0;
> > 			}
> > 
> > 	+       if (!val)
> > 	+               return -EINVAL;
> > 	+
> > 			/*
> > 			 * To set sysctl options, we use a temporary mount of proc, look up the
> > 			 * respective sys/ file and write to it. To avoid mounting it when no
> > 
> > sysctl log for patch3:
> > 	Setting sysctl args: `' invalid for parameter `hung_task_panic'
> [...]
> > When process_sysctl_arg() is called, the param parameter may not be the
> > sysctl parameter.
> > 
> > Patch3 or patch4, which is better?
> 
> Patch3

Oh, I see the issue here -- I thought we were only calling
process_sysctl_arg() with valid sysctl fields. It looks like we're not,
which means it should silently ignore everything that isn't a sysctl
field, and only return -EINVAL when it IS a sysctl but it lacks a value.

-- 
Kees Cook
