Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE671D474D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 09:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgEOHor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 03:44:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52439 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgEOHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:44:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id z4so112980wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 00:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vJVWJQVk8CciTsSCvsqJGG8XKk2NT2HP/Zje3wxePpk=;
        b=Nj54Wor2yF2UtoHvPKf8CCT6bpACcqk7Zc9DZRZFiMVBh270jguWqstgA689Gyxhh1
         30bdBtppDtZAKJf09ZBGTPRUo4dahaRRBwkJmFNdXkJ5PdxJoB8amPmPYzehXYc9Xe+e
         6NdCXuMRWSBWuScKYmy6BTKN0XvILbeB8y5adrRV3mzqi9cS+CLvBVwbJi0EVM1+Y0HW
         tTHVW0yviTzU6mApo9ijai5mqeBkTDciMFxZktFhRuPKHPwM2esAIJplSnU7RpcAvcV7
         wLyhQTbm0eyUhPpIVsial2RHD0fnH6ewrMhacPoFyuuCRurK1eEn34gLuAANWUx54sQm
         /fWQ==
X-Gm-Message-State: AOAM531s8LrP7kmtWUNlhhperFkAjdx4slDNlBqjTzQ6war7YMLbIfJG
        WbQahAbzoe4dk6cMsU66uUM=
X-Google-Smtp-Source: ABdhPJzvvHdgX5ui4nSJTmyuDZ8V7G9BS6vKsmATdulV+5BVtxjVEsfdhBS0PT9CUX0cVS6RBi/lDg==
X-Received: by 2002:a05:600c:1403:: with SMTP id g3mr2660839wmi.51.1589528685290;
        Fri, 15 May 2020 00:44:45 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id p17sm5856361wmi.3.2020.05.15.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 00:44:44 -0700 (PDT)
Date:   Fri, 15 May 2020 09:44:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: adjust vm_committed_as_batch according to vm
 overcommit policy
Message-ID: <20200515074443.GI29153@dhcp22.suse.cz>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-4-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588922717-63697-4-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-05-20 15:25:17, Feng Tang wrote:
> When checking a performance change for will-it-scale scalability
> mmap test [1], we found very high lock contention for spinlock of
> percpu counter 'vm_committed_as':

Btw. you are focusing on a microbenchmark here but I believe that there
are non-synthetic worklaods which would benefit from a larger batch.
E.g. large in memory databases which do large mmaps during startups
from multiple threads.
-- 
Michal Hocko
SUSE Labs
