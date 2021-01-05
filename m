Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA7D2EB515
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbhAEV47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:56:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32891 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729878AbhAEV46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609883732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MuDUx4MH0K0SVmqM05B+/b+Sc1SbsT6uIL7Ml0ZoRsI=;
        b=GGXJJ2nfKxu9/l4pPMzA5KBhs+qTUJO1cRmfJ2EYQAkr+5s4zqm+lztP3l75alkEUOjjKD
        1MEc7JiNm8xNPpIT8jftvKFwduU5nTlnGMOkitzTZBp4bSXXpWPLC6UDOdfUTQqQ/5y70V
        APBG68FCpxJUEoIcDhJGkdRpXdK0E5M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-We4rDyDRPs2eZTsvKvHEPg-1; Tue, 05 Jan 2021 16:55:31 -0500
X-MC-Unique: We4rDyDRPs2eZTsvKvHEPg-1
Received: by mail-qk1-f199.google.com with SMTP id g26so925767qkk.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:55:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuDUx4MH0K0SVmqM05B+/b+Sc1SbsT6uIL7Ml0ZoRsI=;
        b=Wviua5eJDAI8de9uJ3Fpcoc3God60xqm8dy/Rx/2lgfAPnw1f+iGJCqBr0SioqX9Fa
         rvw8RG8djZB+WjyFkkmpWly6xKDADio24oe9y+ZipA52sAiYlLA5Uq7GlkqzAR6UPKiW
         W2go6bteiZAwbnVJdsCRqW6Tk+CMqlflavEsQmht2zUq8qEREtU66UpapOnc9YB4Dqdl
         qbrPYr6soLR177Ol2IxWAx2FOHc0467UnyMMW9UhRE+KKvAWzrGzggjbAfDHXSxVv9Vk
         r5aPU940kuyGmNWnFB+fLln8tcW4ZDMzpzay0i7rxAwuFkANbFSX5Gbgk9Emsg/zGmqM
         B0Vw==
X-Gm-Message-State: AOAM532JgVLcwVrUYoj5K+zY8Wv0r8XClla3NUuvOvt41gGQ3vf6ERAt
        sB0TFWdfNczkL39vvXXeWwecKvKc4teM4MZ1GtwsxyZoJPOioWzLYbQop3FucmpPl0E1B0rhO3F
        7/uXFiBKc8waBK2fS6F1Hk8sE
X-Received: by 2002:a0c:ab8b:: with SMTP id j11mr1538293qvb.0.1609883730806;
        Tue, 05 Jan 2021 13:55:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKe1OjLc2IENivuNaugdOIvjYNLqtSKNthmfFboAXAUzB89UxCh6LEkO+N8daeAaPm3D45uw==
X-Received: by 2002:a0c:ab8b:: with SMTP id j11mr1538277qvb.0.1609883730623;
        Tue, 05 Jan 2021 13:55:30 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id s19sm245664qta.35.2021.01.05.13.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 13:55:29 -0800 (PST)
Date:   Tue, 5 Jan 2021 16:55:28 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Nadav Amit <namit@vmware.com>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on
 soft-dirty cleanup
Message-ID: <20210105215528.GH149908@xz-x1>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com>
 <X/SuBxFfR+bncRhU@redhat.com>
 <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
 <X/TOhyzggcBL64N2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/TOhyzggcBL64N2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 03:39:35PM -0500, Andrea Arcangeli wrote:
> I'd suggest to coordinate with Peter on that, since I wasn't planning
> to work on this if somebody else offered to do it.

Thanks, Andrea.  Nadav, please go ahead with whatever patch(es) in your mind.
Please let me know if you prefer me to do it, or I'll wait for your new version.

Thanks,

-- 
Peter Xu

