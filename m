Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616422A31EF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKBRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBRrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:47:43 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F06C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:47:43 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id c80so3990097oib.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ta8nke5A5mobw52bQz/6c9ICTuEFY5bZssEx/BCuN+U=;
        b=aPd+GJ7X7SpgqrcQU40H4fMr+1SBaIGBTLYglypXsKQf3Nx/gTNlZ5SPgt6G7O3ybS
         2haR7/p6QYCrANpqnFpaFwUWysuD9yuJdn1q0XoHILq7HKBztKF44nLSFPpL8er3tIyn
         Poa4Um7y3fL5e8o7IeroI9y1tez+RwdQSjg4Fknq5t9ESSBR2Pjr6Yv2M8K6pE3zlt0s
         zqPZtuXoZaVmdNFgoAlMbYgc+IPhskrfPvQO+m+SHIvpJtPAXrcOjf6ZTjEOYwDS7wYY
         rCZqdmNl/QFUhYKXLVnl9o/YptMDUIf4rqjxR/BF7dJQtV8g40W7VmK2BOZ3fyW8vwLs
         xXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ta8nke5A5mobw52bQz/6c9ICTuEFY5bZssEx/BCuN+U=;
        b=Lpku5jJSckoKw5KoXsR3fg8N13nLyDq+0B3Y5Hbrrj+ElNdIFT0oyHI7KVGoJkLFm0
         GRSlcLgZ2kayfUoOEJiVTiI3Z1zO77X3qEgH3K6WTVrwxXzqDUWUyGWMRYux7VVDHj1a
         sabxxkSuJVVnMaophhL/pd26JEuBX1ppqGt2X2SHaDWuEqv6b+nm4rvepT6UtLUi3N1L
         5aiKzZbDadwQGIi7REW04zlwrfEL7D9bEwFdqOtwwC9h7LPqrvvsV6fDWgSEa2HxI7PF
         8RtWVVaER/FEPhXeo8m9PtpppZJxBi6b31igAUTlHPZesOs1v5KShfvMbBjb5qou+YBt
         154g==
X-Gm-Message-State: AOAM531bRBgLJKvgX/i+s5HXQR7WmAj0SSxRJw7Vy/QsFw98a8FijNWU
        0GN2X3dccT3k7PrafK5z56mouA==
X-Google-Smtp-Source: ABdhPJxXvHPb/Z0m00NEXuUGbpnQdMiSETV2s6AftgGLyCuMxVSYXQjN11p6yK5xF1LNSrj3NSX0nA==
X-Received: by 2002:aca:b145:: with SMTP id a66mr11230119oif.92.1604339263266;
        Mon, 02 Nov 2020 09:47:43 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w70sm748613oiw.29.2020.11.02.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:47:42 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:47:40 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Siddharth Gupta <sidgup@codeaurora.org>
Cc:     agross@kernel.org, ohad@wizery.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, rishabhb@codeaurora.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 2/4] remoteproc: coredump: Add minidump functionality
Message-ID: <20201102174740.GA223412@builder.lan>
References: <1601690757-25726-1-git-send-email-sidgup@codeaurora.org>
 <1601690757-25726-3-git-send-email-sidgup@codeaurora.org>
 <20201026210912.GA4611@builder.lan>
 <ad4c375b-7051-bcce-a86c-febb72267caa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad4c375b-7051-bcce-a86c-febb72267caa@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29 Oct 18:54 CDT 2020, Siddharth Gupta wrote:

> 
> On 10/26/2020 2:09 PM, Bjorn Andersson wrote:
> > On Fri 02 Oct 21:05 CDT 2020, Siddharth Gupta wrote:
[..]
> > > diff --git a/drivers/remoteproc/remoteproc_elf_helpers.h b/drivers/remoteproc/remoteproc_elf_helpers.h
> > > index 4b6be7b..d83ebca 100644
> > > --- a/drivers/remoteproc/remoteproc_elf_helpers.h
> > > +++ b/drivers/remoteproc/remoteproc_elf_helpers.h
> > > @@ -11,6 +11,7 @@
> > >   #include <linux/elf.h>
> > >   #include <linux/types.h>
> > > +#define MAX_NAME_LENGTH 16
> > This name is too generic. Why is it 16?
> 
> I will update the name to  MAX_SHDR_NAME_LEN. In our usecase we didn't
> expect a length of the section name to exceed
> 16 characters (MAX_REGION_NAME_LENGTH defined in qcom_minidump.h in patch
> 03/04). It might change later if users
> want to increase the size. What would you prefer the max name length for the
> section header to be?
> 

If you calculate the size of the region based on the strings I don't see
why you need to limit it here - and you shouldn't use a bounded version
of strcpy in this case either.

I don't think this part of the code should truncate the strings, if we
need to sanitize the strings make sure to do that when you populate the
list.

Thanks,
Bjorn
