Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D44326316E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 18:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgIIQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgIIQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:09:25 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D900C061756
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:09:20 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so1766810qvk.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XOUyPTsa2Cy1aBInD+QuWOlrkZOb1oPn3ygyN5HSAlw=;
        b=LoZsiyRN6z3nQTE+reJEuHSLJx/sEAeC0/lg9Ji/pYlB7dC9jGShyT3icZv0Jh+YaM
         EYDrMJiztU1bZr5xo1De0LQt8sutI/Gr9qQ7/n2Dj9y6PqFSdYF6U94Rg9WYCPglKd1d
         0XX9IN2kGMxwHWlJICG360S5k88hyLU+4KSmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XOUyPTsa2Cy1aBInD+QuWOlrkZOb1oPn3ygyN5HSAlw=;
        b=idEkoV9rgv4K8y6s4oSDlTTJzxTqCO2/EVf0iq5MHeBRhyEyhU//HnWoWZLafQMmm1
         kqjaQKsOrafFrxQ+HOSHmRxbmCXAOm6EkKX9w6rQF1gDBKWtqNA/rcl8be1L99dSOUVq
         4qIgaRm4l51tK3Ctg8bc+6n6guIopAKRMpJS1mOyGg5EQsLvc1Yo/OiMfshWRSCG80S1
         OqYPjs0OfmWOm1GjKbIRxCbItT6yz24gJ/b0ZfXZu2G51QuGr01N2JOCkaB+qGz/I3bw
         t4RIOJ2WQUcUl0uHoPzbdMiXmJz3y787Mg8tRmgQ/i06nFaBvqGKbtnAJgnpAQ+OmAOP
         5uvQ==
X-Gm-Message-State: AOAM533/FjxBR7ALT+07S6VLxmQiCpeFOOCgSs9WJ8kasRG8CRLTI884
        g+pq9oSv0v5noM6FCuz9aQd5hA==
X-Google-Smtp-Source: ABdhPJyL7+T9zIVmdMwKB1/q+iv+QjLVbUi6SxoPu8hTWkv8uve1cnVGV+9GR+PjfuPGIhHSCec3Ng==
X-Received: by 2002:a0c:b35d:: with SMTP id a29mr4590496qvf.19.1599667759190;
        Wed, 09 Sep 2020 09:09:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:16fd])
        by smtp.gmail.com with ESMTPSA id q3sm2817689qkq.132.2020.09.09.09.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:09:18 -0700 (PDT)
Date:   Wed, 9 Sep 2020 17:09:17 +0100
From:   Chris Down <chris@chrisdown.name>
To:     zangchunxin@bytedance.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
Message-ID: <20200909160917.GA1569471@chrisdown.name>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200909152047.27905-1-zangchunxin@bytedance.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! This looks reasonable to me, and avoids hard-to-reason-about changes in 
the existing semantics.

zangchunxin@bytedance.com writes:
>Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
>Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Chris Down <chris@chrisdown.name>
