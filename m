Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B42B283260
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgJEIoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:44:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58526 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEIoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:44:17 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kPM6Q-0003G9-WC
        for linux-kernel@vger.kernel.org; Mon, 05 Oct 2020 08:44:15 +0000
Received: by mail-wr1-f71.google.com with SMTP id 47so1445595wrc.19
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 01:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dZFx1GeJTo2ZK4IcFjyCCesPDlIGbBOPYfFpSWVIbpo=;
        b=Nf+QErOMH3LdvBZ4iiMsgPT9BcTY6vFmTG+A7easVJ/5yEGmowXklfw9r1BMmkPzP6
         FkaTS3fBZpntqvHzmNJYrM4bu/zlxHoCAK9/i1s7Cakw+8K8JkBvYhWxhipmOWAMF0J1
         p3Ig5umVMDRufTo96/2vyGP1sEsB60dQEz9WpcV7uIQAjMSuWnv4bIB5VsvVKI5Zoh8O
         SetoZwSjgLjVnwCKu8loOj7SZwq61YQ03y3/QmpuRQkhi0NGiJsFkeht+ualymWxA1r9
         ptlyIMGDf1afSZW+RQ0jZogB9GYk9pyFILnc90LzxEP2iKzi8HVW2ks8lZQBMfdoBBi8
         kdPQ==
X-Gm-Message-State: AOAM530JQ6Qrv3TdDRWIrC2SwLhLCNeMq+WPOywACE/UcvaQUKrZchJW
        FBfTiMBuWlNGJPUsu3rhoqsPR8vjt42wHKAyDR8DAHDDrFDzDW1KXJSs5OoMGYcBGNTt6awsIEy
        O+DNH38vg0aq46kt3vih9y8LzQLOb2hKGI//Vt5n/fQ==
X-Received: by 2002:a7b:cc02:: with SMTP id f2mr15260338wmh.1.1601887454688;
        Mon, 05 Oct 2020 01:44:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwGutvomMW+ZkXDkOPcBrLdaEr1nkvazEGt7P+cRzR/ommpl2rxO5gLvSjXflb6uzW3HKjHwA==
X-Received: by 2002:a7b:cc02:: with SMTP id f2mr15260308wmh.1.1601887454379;
        Mon, 05 Oct 2020 01:44:14 -0700 (PDT)
Received: from localhost (host-79-36-133-218.retail.telecomitalia.it. [79.36.133.218])
        by smtp.gmail.com with ESMTPSA id 63sm12440058wrh.71.2020.10.05.01.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:44:13 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:44:12 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Semenzato <semenzato@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v2] Opportunistic memory reclaim
Message-ID: <20201005084412.GA735812@xps-13-7390>
References: <20201005081313.732745-1-andrea.righi@canonical.com>
 <20201005083516.GR4555@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005083516.GR4555@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 10:35:16AM +0200, Michal Hocko wrote:
> A similar thing has been proposed recently by Shakeel
> http://lkml.kernel.org/r/20200909215752.1725525-1-shakeelb@google.com
> Please have a look at the follow up discussion.

Thanks for pointing this out, I wasn't aware of that patch and yes, it's
definitely similar. I'll follow up on that.

-Andrea
