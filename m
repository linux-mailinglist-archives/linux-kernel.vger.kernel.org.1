Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5249E296458
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369492AbgJVSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901462AbgJVSAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:00:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98635C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:00:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f38so1087509pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+Jm50fe41wfDpU30qvqkj0sqMT/OM8dCaofZzxuvBXc=;
        b=Ked+h/0SpWqtiUKSQ+9P+ieLMEYOUTVO+Qm1xZegAoXCKTnpLFKnApIRgEQNuVl+xY
         23Ki0jXwUy5jxqKjbS2p6j57kwY3nhDmCf37yAxUZIDdarrFWzYtYwszarW8AmN7W1tK
         QaLA/Ut1Q91UzjmR8M+CJmabUDT+4GAGKWWZS3k2oqfzBELUTGLx66J0bAP5qIk5i6tN
         Vs7wLG8jgWwCSeX8OCz+Zk0H6cEsdJR9buSyEVvsBbfH6HCvq04fuHMoF5qKL3KXNRtP
         LOqXn+Ehbt1GJq1WgSjRK/9M7jcRx4qYct5wkhxVGQiCFzuQpUmPwAr76h/VN6Cd6ywY
         QO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+Jm50fe41wfDpU30qvqkj0sqMT/OM8dCaofZzxuvBXc=;
        b=jpaWQN1vIi8524FVeLGd6P22DyhAPe0xWuJpj/D2TV7xveBBPiWvIvXcmrA05FCsXO
         aAdUonPNM6vFDYtbmRYgmau0TbMGzLH7cV9JmO+UKXaMdqMfeY2GpDlQ5HlJt3qH3f+A
         2ZPxo68fV3gPdWx+S7xiKMGfaNggMWmqTmSN0eSVfe9ZJR3cGVQqYRg8DWGNho6ly8/4
         76Ko/lA5iCyPZDfzfDcpv4FagbFFVTLfLLq/wPtPwdsLx+cSGoDbEWiVfgK2GHcMcvGE
         sfT/0Dz9Rp5srMtopLdsyJe7QFk/BBEfs8gjn6ilsq4FTUyHYg+dEh2IwnxzylWKyDhy
         Agig==
X-Gm-Message-State: AOAM533WnAVKybj6vN9L41wtYrcjxiw3Yy84J4f2eZHtBhRq1eET9ypP
        EjZC0GE8SXmpM56t3i3fGJYm5w==
X-Google-Smtp-Source: ABdhPJxn4taYlIWRahvkIvssJLMcCUQ84+ML8jbNY9JiGAhKblgzms/4vt1AYrhAFZgNDcVQ+MsviA==
X-Received: by 2002:a65:5a0d:: with SMTP id y13mr3202032pgs.436.1603389633998;
        Thu, 22 Oct 2020 11:00:33 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id u12sm2512347pji.30.2020.10.22.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 11:00:32 -0700 (PDT)
Date:   Thu, 22 Oct 2020 11:00:32 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
In-Reply-To: <20201022151844.489337-1-hannes@cmpxchg.org>
Message-ID: <alpine.DEB.2.23.453.2010221100150.1331349@chino.kir.corp.google.com>
References: <20201022151844.489337-1-hannes@cmpxchg.org>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020, Johannes Weiner wrote:

> As huge page usage in the page cache and for shmem files proliferates
> in our production environment, the performance monitoring team has
> asked for per-cgroup stats on those pages.
> 
> We already track and export anon_thp per cgroup. We already track file
> THP and shmem THP per node, so making them per-cgroup is only a matter
> of switching from node to lruvec counters. All callsites are in places
> where the pages are charged and locked, so page->memcg is stable.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: David Rientjes <rientjes@google.com>

Nice!
