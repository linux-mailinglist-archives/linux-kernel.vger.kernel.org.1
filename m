Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE06E2D76D5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391589AbgLKNok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731818AbgLKNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:44:22 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:43:41 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c5so5450721wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 05:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PuVM1PLYiwpp0lLPJd/iWAVvKsSsyjEYjPBnVrj9k0U=;
        b=wMD6kVpytcLH++f6sDjmXRdlTO8XSZw+X4pXOHG1KprjYYrcjEVEq64tHhrSvccplB
         BHDoRr7GLCauDzQzPbA8oxoc7SwsgdqFeKL2z90AQ0tHWzLOMhK1qqDhMvFjuzUGBEA1
         f0o3OJ3aLLX//U+Qlznt1BqDdTgSdG1h+3slE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PuVM1PLYiwpp0lLPJd/iWAVvKsSsyjEYjPBnVrj9k0U=;
        b=e8Vg2LV2qXYU4atMrKwNR1wB7tzc3NvCXPiHSUn+Lv2Npd89Z6LqesBY6rECiaCEfd
         SvOnZR9teiNgC9uuSpZMcJAsWnRVcjxdvcp/ArzIVd3cKeH2PMM6Q/aNgyt04Se+7B4L
         tUUDO4Np9snzD9QwMjpRHD/37AFQBY+lmFzYUaqwsn1dwXXqmgrv9EpMyuNXwGxX5+nG
         z9io18fOXkbS5HC+RccaOmMYFrY1sk9oiioe9/TsjZmxtfqq8NMLmQvOCSCmgqTzFKNs
         /Y7YvJOAaThBy/11t0V9kjmUys5SWzCPnlFAwUY28ZNsR92/vtIx007l1j9l8GqoTGaK
         tb3w==
X-Gm-Message-State: AOAM533Tm7Zm60a/T82HqJUkMIH/xfvZgqzYM9Ptd0rAOxUEOld90+0E
        ICc1Xv+h7qNvSXRcuPK8pA4apg==
X-Google-Smtp-Source: ABdhPJzaF0Q/PL60zEr7ojj8DmyjE9UbD9tmjKkEpN7TWlOGZh1ZW3syyfIZNJb3wPTH5bpcN0AQ4g==
X-Received: by 2002:adf:a551:: with SMTP id j17mr13894617wrb.217.1607694220431;
        Fri, 11 Dec 2020 05:43:40 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id r13sm14435415wrs.6.2020.12.11.05.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 05:43:40 -0800 (PST)
Date:   Fri, 11 Dec 2020 13:43:39 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "qcai@redhat.com" <qcai@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        walter-zh.wu@mediatek.com
Subject: Re: [PATCH] kasan: fix slab double free when cpu-hotplug
Message-ID: <X9N3i+EwydXFc4HW@chrisdown.name>
References: <20201204102206.20237-1-qiang.zhang@windriver.com>
 <1607083295.22062.15.camel@mtksdccf07>
 <20201204172521.ed9f77164ff9f9fc91f35ee0@linux-foundation.org>
 <1607185035.22062.42.camel@mtksdccf07>
 <20201205170914.e380173074b2deded2ade3d3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201205170914.e380173074b2deded2ade3d3@linux-foundation.org>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Andrew Morton writes:
>@@ -188,6 +190,10 @@ void quarantine_put(struct kasan_free_me
> 	local_irq_save(flags);
>
> 	q = this_cpu_ptr(&cpu_quarantine);
>+	if (q->offline) {
>+		local_irq_restore(flags);
>+		return;
>+	}
> 	qlist_put(q, &info->quarantine_link, cache->size);
> 	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
> 		qlist_move_all(q, &temp);

I'm afraid as well as the issues already identified, this also fails, because 
`quarantine_put` now returns a bool after "kasan: sanitize objects when 
metadata doesn't fit":

     mm/kasan/quarantine.c: In function ‘quarantine_put’:
     mm/kasan/quarantine.c:198:3: error: ‘return’ with no value, in function returning non-void [-Werror=return-type]
       198 |   return;
           |   ^~~~~~
     mm/kasan/quarantine.c:171:6: note: declared here
       171 | bool quarantine_put(struct kmem_cache *cache, void *object)
