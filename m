Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2A2A879A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732165AbgKETwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:52:38 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54162C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 11:52:37 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id n63so2002978qte.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D3FDe8UgpelV/PGX9SMOeLG5mjEbJxZHhY57CHNG72Q=;
        b=DnWyN+J6UKOatH9kcqext9yg/T0HnwNvZKOXMY6rrpb1vtwc86xZ7CZ4MzoC97qloL
         +9yhZueWtt5TtaViz+Gn1A4qJCCnUjyKZp+gjn88/641Ny+dzmIPHvbL5j6QY5karlmC
         HEcMMGirXcMppiX96wQYSgGtE0a/FdsUVfCka9eDnnJKfN/fMqNZuVQ4Pjp/RQD1GAvD
         S034unryiLDBDlPxzfL2LnksLN2bECHndaGSymP0yA2bySOXlKN8/d0AEeqnswu+AIR7
         sgImnD8TcCdaTDFfcnxCAGx9Xk/odgmlkJR+lAhUb0V17Y1qfHZBK5ckW382x5mvU4Yt
         ++wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D3FDe8UgpelV/PGX9SMOeLG5mjEbJxZHhY57CHNG72Q=;
        b=ghGJoCpzBjUoyfX8RG4ZyAJyn2CFBJJZ+qiYBLXcHOwMSMFhlUqo4HRutAwCIGKk6h
         Rd4dRxutfynPKqKFj0Rjh9eof7kxMXtBve4llM1NDLTmNiu2moXHOPxZErGNOy3RcP2D
         Oe79gpGxDfuLyRVsrNr97KNTYtXt5ciPPKEWjIsItLAFY5Ecy1lCfZgKwuEXXa5c/4iN
         3SIiGh0rhw6XFESfU2lJRQHwFH0EvJ8Y4xoZtScWOVcaw+HD6Sz97ammq1ejp+klnAuP
         OewT7DghazJzmrdUYNGMHo/s9lQ6689SCNbrWvwQ+o7DG+nL5UZg3d1vaZy/FFiF3g8R
         iBdA==
X-Gm-Message-State: AOAM530efKyxWsmWOGSxhl6HO8BC3qOydqOZ83kZ/lIZgoM/Bl+2+spC
        ezQw+Mz5x+/QaTUj/IgZVOSA5A==
X-Google-Smtp-Source: ABdhPJzoo5ik4k55cSFQOg+psdZVvhFwyadZWQMIeDT78AYi13BNFOzssApa4HejRcRx/naX7+eEoQ==
X-Received: by 2002:ac8:5ccf:: with SMTP id s15mr3697060qta.375.1604605956558;
        Thu, 05 Nov 2020 11:52:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r16sm1730106qkm.1.2020.11.05.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:52:35 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kalJD-000MwV-B2; Thu, 05 Nov 2020 15:52:35 -0400
Date:   Thu, 5 Nov 2020 15:52:35 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/gup_benchmark: mark gup_benchmark_init as __init
 function
Message-ID: <20201105195235.GI36674@ziepe.ca>
References: <20201103081016.16532-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103081016.16532-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 09:10:16PM +1300, Barry Song wrote:
> gup_benchmark_init() is only called during initialization, mark it as
> __init to save some memory.
> 
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  mm/gup_benchmark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hardly seems worthwhile, but looks correct

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
