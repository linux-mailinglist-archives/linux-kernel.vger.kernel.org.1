Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EA52EB896
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 04:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbhAFDqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 22:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbhAFDqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 22:46:08 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77A5C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:45:27 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g25so2410041wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 19:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kuo/Qcc1Loq+dDHNxfTbaVjTvOyr1F76t5abSRokhWU=;
        b=Jg5a0Vff51qV4t15hYtWCMnX911c/SEMsf7muIIXUCOQJPcjP6BKWNri/uLS7tWsQ+
         IQe1rkIDqN89bKtA84SgiVai73YE15h96DHC8rSx9ed6qrkYkAIX8QXq7P+nOEJIsvsD
         8/QUPP314VdBOXJ+YBjVNaNMZrAE0Vr0TT7zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kuo/Qcc1Loq+dDHNxfTbaVjTvOyr1F76t5abSRokhWU=;
        b=UxfmU716JuYlUjrdMJTuzU5qECYGKyjQBiPFo+i3SGSKs8c9YyrRh9j+7BQUHN8Pcj
         sqNCegLwdy22xkFMOgWrE622BdmMv/QAXQtVwSn8IAXz7jlkL24dPG3zN6m/EnTJRBlN
         pqksR9zEmG1knwdlG2u6NkdWre4OA76b2SWPf9QpimXd4vCMfa0dHVR0Q2E1EE16W2uQ
         iMDVEpdXessENoUIya6I25PoTuVZEZabeNCQKO9gRH6nS4TmVoCvhV1ZXyPMXPVUap7y
         PQr/l2iHrridxS0X5oXpuwfyFAhJPyvZXRvmz0B9T4IoKAoc6wLGlyty58vSZbYYS5VA
         a/mQ==
X-Gm-Message-State: AOAM531x9pz8bTBI9Kw7Ni4v/O7sXDwjG4VJQ+NiHN0RzVe5IhDlDhpl
        aBeGBhsjrW92syl7aBDy5h59/w==
X-Google-Smtp-Source: ABdhPJycTNh5zuDlUohYSG6y55UwgTl1uxuXlPPh5f9mWAuC+tmlcGAAzKCCsiSy0LrVnYfjumt2uQ==
X-Received: by 2002:a1c:2d8a:: with SMTP id t132mr1704735wmt.119.1609904725626;
        Tue, 05 Jan 2021 19:45:25 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:5586])
        by smtp.gmail.com with ESMTPSA id c6sm1385737wrh.7.2021.01.05.19.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 19:45:25 -0800 (PST)
Date:   Wed, 6 Jan 2021 03:45:24 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, andi.kleen@intel.com,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
Message-ID: <X/UyVBlSPjOqvbp9@chrisdown.name>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <1609252514-27795-2-git-send-email-feng.tang@intel.com>
 <CALvZod5ir6F6BkJiVoXztNu6CancqJ2sNusg_hwTPcEssYkDdQ@mail.gmail.com>
 <20210106021213.GD101866@shbuild999.sh.intel.com>
 <X/Ux6CT6EsP+QQ8S@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X/Ux6CT6EsP+QQ8S@chrisdown.name>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>solution to the problem -- inclusion should at least be contingent on 
>either having "correct-ish" stats exported to userspace. Displaying 

s/either//
