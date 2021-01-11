Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9783B2F183E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbhAKO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbhAKO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:26:11 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7491BC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:25:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id u25so17208373lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=smCy1Yjkgz+gZDtvnre1/QglxuwwJh77VQyDG7f7TRE=;
        b=ZUuH8XyUNwUDj/ax6jtLuay1zUfAHTmdAj5OEzyXghQZcVky5ep8DZqIxsMBY2n40g
         c06X17Dy/0BohuoUCgTPEfnF1EKIHFZ+Uin5pZQVE8W7Zie1OKBDts7Fw6CAJ8oUkF0+
         r/h5M78XOTQOyOFRvsAhMPXJIxAmIhjxGdlOX9Hi3+nX64JjFSDQLgrhZZq82sDae6ST
         Awd6jayAfyX09bC+vlJFcEgIfQybESEifE9Tuf2F/hjEouxgD3ozygW24IF04Z8y8ynU
         N9j5pf85cu+j4nquHHa/0nuHULcDcB/q8AmB2mg3d0OdxGBUSWwN2TzUtKlGvU/bY+eL
         /P7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=smCy1Yjkgz+gZDtvnre1/QglxuwwJh77VQyDG7f7TRE=;
        b=KuSY3YjmgIRUrOxCELZMH9whP+26K9Rx49JlHre3aa0AXAQwgUBntC/MzEKjoGaNn5
         KX29zHxIBp0zB/qDSIFVP8UvSckURF8IKl5GNCCE988EfoNLr9L/b7YaID4+y3gN4OWu
         wi8P7+IC+8KLWqt7YaqUVEwg+jefAxN75FJjXLne1GnXGYrXVyN1QtiPNX08UwsRm0jI
         hOe5zM6XizKwCTHVC+WmvNV1pK3oI94fb23asF5JJzTTEiiUjrK6NcCqyzMJW/AkY85M
         lA9hCxEknuLzfeadvNJk/NF/cE9WVgDe+rcQ6PvWmmZgxjbTkX5kw6ZgzXtfA+3uIeWs
         +1wg==
X-Gm-Message-State: AOAM532HF8zjhSz1+EyqhzU/f5i8c2fOKfcoHf9jTNSHhJdziGGiEJrt
        1xuLS2Pngz3iWxLgAhMvPbKSxw==
X-Google-Smtp-Source: ABdhPJyUEIHi1OeJLqcYRsOQdNKTnpdC0urVnyRPLnSVMvyEGUufCwFJNYt2YI+Kmx+uW4swx/YObw==
X-Received: by 2002:a19:f601:: with SMTP id x1mr7048733lfe.256.1610375129044;
        Mon, 11 Jan 2021 06:25:29 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b7sm3440379ljf.76.2021.01.11.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:25:28 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id B18BE102238; Mon, 11 Jan 2021 17:25:33 +0300 (+03)
Date:   Mon, 11 Jan 2021 17:25:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 2/3] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20210111142533.oulduqd76mkpdkst@box>
References: <20210108171517.5290-1-will@kernel.org>
 <20210108171517.5290-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108171517.5290-3-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 05:15:16PM +0000, Will Deacon wrote:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c1f2dc89b8a7..0fb9d1714797 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3051,14 +3051,18 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		if (!pte_none(*vmf->pte))
>  			goto unlock;
>  
> +		/* We're about to handle the fault */
> +		if (vmf->address == address) {
> +			vmf->flags &= ~FAULT_FLAG_PREFAULT;
> +			ret = VM_FAULT_NOPAGE;
> +		} else {
> +			vmf->flags |= FAULT_FLAG_PREFAULT;
> +		}
> +

Do we need to restore the oririnal status of the bit once we are done?

-- 
 Kirill A. Shutemov
