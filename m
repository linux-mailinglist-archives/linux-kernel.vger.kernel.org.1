Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19CB2F86CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbhAOUik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbhAOUij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:38:39 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE84C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:37:58 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id j26so6994231qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ONGB3AHOc3y6FZ2WAHLyfcmNTf3gmBuRCktJIAjkbf0=;
        b=rOuxT5OLcjz2fu55fjaSR3BureD0trIBU2NNRgSjr8rbGnQchWZZS6Gt4dzdxsUbBx
         Ukn9/aGyTQKeOUMqqxYOmlJ5Tq3nLJqTnD32fBajVb2tHvdVwqXOIcebe3BDcalswZdO
         v2Sriq2OnA2XifeyGWWiu/TSyozZJo6xQiM0v61XlquubkGjsc9dYqnAj/dgDAnmFLEY
         xWy0ri5onxkW/sBgUtE2uTOI2vhipvx4xwOWBFU8TUA0i5wINsFY8nihA+KtxseL9Jvx
         UKVUnw6znx9+hpjSI6kmV5jW6eWOk2tZUIalr1ZrhREP+xjQ6lIIUJ9v/jFDXTbmvH/V
         cp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ONGB3AHOc3y6FZ2WAHLyfcmNTf3gmBuRCktJIAjkbf0=;
        b=UbUYAwKa7ntFWaDEPxloBHQrZVaXk+YLU4Lc9E1RskRroo6SxyTQx9TWdRQHKP9OX1
         luFMGrD6NSY05Gbh8p9qiF4oqlFSUXxI8Rj69ggTWeeQZVcON2D/TLQBTpubjaQqqxuS
         x7Qt3tDNCOuMJzMS5QYsjHrOV5xjUkbiWKbh8ceg7hCwfCrTNS/JXJdf3AWvVjd0IomH
         DeV6utEFzzKim7APsEkDzEyrTL1iSf6KjziY7z6002uy3o6AfRlBNqNz926G5+bqyUb6
         cL2LN8xt8i9HPZVQDzRJ3PIbPWnUhFWDM9glFUIn/bG9OIljirDn5C4k+NZOJhDk1QoH
         1u3w==
X-Gm-Message-State: AOAM530RV86nsrhctXXCMxCmXEBjdMtUw430KVu5V299aViqUauyjInE
        BYSFcINCkPdzUoYRCJtd6A0=
X-Google-Smtp-Source: ABdhPJx3ABPUy0ZfUzSb1u61kY+Oysoh5+1f7JQovW/hOQiiTH3xnd24/uZfqCDuELhfza4SaYO+OQ==
X-Received: by 2002:ac8:7301:: with SMTP id x1mr13448091qto.375.1610743078127;
        Fri, 15 Jan 2021 12:37:58 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:97cc])
        by smtp.gmail.com with ESMTPSA id s8sm5399637qtq.32.2021.01.15.12.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:37:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 15 Jan 2021 15:37:11 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH] cpuset: fix typos in comments
Message-ID: <YAH89xue7hf1UNCs@mtj.duckdns.org>
References: <1610512661-135383-1-git-send-email-aubrey.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610512661-135383-1-git-send-email-aubrey.li@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:37:41PM +0800, Aubrey Li wrote:
> Change hierachy to hierarchy and congifured to configured, no functionality
> changed.
> 
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>

Applied to cgroup/for-5.12.

Thanks.

-- 
tejun
