Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288D128B972
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbgJLOAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbgJLOA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:00:27 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:00:27 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k9so3533043qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Osshed0yZw01kGf9tsxsPTMgiFVwAv+3bFml5Qp/S6I=;
        b=Sbr/oBREuW7qcPtzuexM9iqgk70TQmYyzQXuD1cbd5tg3SM9lOdsUrYHoMeDV8DQOy
         UueavBzl67FQvEbouK6Moe2nIYbhuX9Hn/9BejDvPgFbCGiyk2hgSOMhEkN1TeJv/qtG
         QzswFmgdtJF5bzku8cKITDYpnUD0wwK34cI58duEv3gteiqgDliboq3LM6ANyw7Hw7N8
         mr2mtvc7dMULRnVyov6TZVXr7YambYnUtko20U4NfXMHS8v6ODN77S0030C9VFTxb3Jg
         SLdFjX8tM2pYjiRg+V0DWXvSupRdsxN3aGXSBj1Av+um8cbeKqZGirKH6agH6pmHvcXi
         rANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Osshed0yZw01kGf9tsxsPTMgiFVwAv+3bFml5Qp/S6I=;
        b=nEmBYkAcBEPcn5RTwNqwJCEKV7bIjcJRA3U9e/niiBG2X7jfrTIn+pqtTyA7Qo+yRa
         YA/l8jM5T1IWdQ28w+zUx3JMuNYPEiPlwp4eUwxuSOZjUhD8S9z2gqQ9yZZiHPKMcr0I
         hIxWjblPVZwfQ5xiSUEexkekuEV/mL8cBGuIS3vmyd2RK99gBSfEexagkHhkm4lwmDIZ
         +GD6QX0UIcq5iFYUIWmEBYogH3KX0Qr/VWjXm6nP1Cq7x+xIfxhvDsKeoe2UVlRvuDgq
         zXU8hUcSte0YBABi8I3zQaQEGtupFb84DjKZ0D0J/a544zhZD4zKPSEAdpuZezdf8P/P
         Lilw==
X-Gm-Message-State: AOAM531dSL1soPRCvWgALp2jk6KpoU4B5VP2RuxtbBh22zraozlI8Srg
        l6/iNXgr4ndf5617MLTtwlivrETHB4vnsA==
X-Google-Smtp-Source: ABdhPJw5dqvVw9Iz6JJkiQZWH9PQtR8t5RXx3zTYAy1x6STroRwe5T2OtbAH+2M8GDptKbhATZiqWA==
X-Received: by 2002:a05:620a:c92:: with SMTP id q18mr9436584qki.295.1602511226559;
        Mon, 12 Oct 2020 07:00:26 -0700 (PDT)
Received: from localhost (pool-96-232-200-60.nycmny.fios.verizon.net. [96.232.200.60])
        by smtp.gmail.com with ESMTPSA id t65sm12299450qkc.52.2020.10.12.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 07:00:25 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:58:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcontrol: eliminate redundant check in
 __mem_cgroup_insert_exceeded()
Message-ID: <20201012135852.GB188876@cmpxchg.org>
References: <20201012131607.10656-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012131607.10656-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:16:07AM -0400, Miaohe Lin wrote:
> The mz->usage_in_excess >= mz_node->usage_in_excess check is exactly the
> else case of mz->usage_in_excess < mz_node->usage_in_excess. So we could
> replace else if (mz->usage_in_excess >= mz_node->usage_in_excess) with else
> equally. Also drop the comment which doesn't really explain much.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Looks good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
