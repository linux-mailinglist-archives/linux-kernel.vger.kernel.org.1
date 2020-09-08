Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312D326209E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgIHUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgIHPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:11:12 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13416C00459C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:09:49 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l63so16337729edl.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qeNAwf96U+vrersmX6/zX5LAcMEPOlKjRQFFX9HVgVo=;
        b=d04XD4wuGYZKDFoeUGggqqzXwzd0VsEDo6lGpROBTOkED3kJI1+94j6ITiYOUVrlW7
         un4Fs5b6mF3ge0DnXus6rBSJM+U7qyxKRB+WD9TCYpPVeq9KHU6VzdHDzX6axffUg1Ze
         tNgxHZmOUVWjGOubJIYSMS3BHyReZG57/KUfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qeNAwf96U+vrersmX6/zX5LAcMEPOlKjRQFFX9HVgVo=;
        b=Y8y4v959CqqzxXF1zix5kzcRbBmzbwptWb3oJBGtqaCie3iUG0wKlcXl7HsdYuGjz0
         EjzipahzJ9wecMj1AG/ItFsXwK9bXYbM+ZI6YQDZ5CrSrZATeeX70bdhfoQgh0ZiUv2q
         AZwPvcL8WeB+YdArcAS1NAYa5mzfI5Z9XrdlJgOStZYmQtB35dnHCMrfmvYlD4AweiCG
         Ip22WaV7d9Cl8AbrBi7h4es+rg7+QS2OguU75zxCdavp/QqX3cNjfowaHxH3sAau7joz
         gzfgSaPtyYuyKggwrrrDfDIeXfsYWq6vF2+DDR8ievmGjYZzIQatgadPl6Z8kLGJIyeH
         rb0Q==
X-Gm-Message-State: AOAM531JEQpAglYBoPHs0VD3KkMPtgcThw+i4iHtHfrR2fWJnrMtcLZB
        dgpQQ7/RfcuQn4LeHIz047FQrw==
X-Google-Smtp-Source: ABdhPJxDBr5+O5eYvDzGM29LFm9OajpzqSaZp8GDx0Q2+MDUSqtVvvBDLIIVW9I+DX7jhLkjasC/qQ==
X-Received: by 2002:a05:6402:615:: with SMTP id n21mr26220771edv.59.1599577786255;
        Tue, 08 Sep 2020 08:09:46 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4614])
        by smtp.gmail.com with ESMTPSA id y21sm6926839eju.46.2020.09.08.08.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:09:45 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:09:45 +0100
From:   Chris Down <chris@chrisdown.name>
To:     zangchunxin@bytedance.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm/vmscan: fix infinite loop in drop_slab_node
Message-ID: <20200908150945.GA1301981@chrisdown.name>
References: <20200908142456.89626-1-zangchunxin@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200908142456.89626-1-zangchunxin@bytedance.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop_caches by its very nature can be extremely performance intensive -- if 
someone wants to abort after trying too long, they can just send a 
TASK_KILLABLE signal, no? If exiting the loop and returning to usermode doesn't 
reliably work when doing that, then _that's_ something to improve, but this 
looks premature to me until that's demonstrated not to work.

zangchunxin@bytedance.com writes:
>In one drop caches action, only traverse memcg once maybe is better.
>If user need more memory, they can do drop caches again.

Can you please provide some measurements of the difference in reclamation in 
practice?
