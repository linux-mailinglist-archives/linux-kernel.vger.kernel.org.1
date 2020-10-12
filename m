Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82D628B785
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgJLNoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbgJLNm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:42:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BEC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:42:58 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l24so16993570edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b4faYRFRQ8RGTZdeupRc42TOCl885dcPlgvi53SvHzg=;
        b=FiGCHq9YN5YJQMroD++jc7rXJZIN7u2rNOE2VCSljuB73ut1oEm6E7hB5UWAztBqVx
         d7if3OSQEygljOxXRZBPUv+vNhdANJa6cKpenwJhRnWo3qj95mEIv2BwDP39rbHQG9D+
         kb9ESz/b0d714dzkm6gVCvk2TvVrwy2vc+kFYZej0p43rCNU3K8m7e2I8UM4O7C14beM
         zonu7VFxTlh0oQuzediUwd6IO+RXn/604iDTSXzvdBrkWKof2Q5kU6bGe+dVHZTZoKo6
         CSlReuftKiQaTGn22STBUNqOfqTzwLRD8ofN0y1beAhDjerMPIhGdXJEIMlEZ8O00HRz
         57yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=b4faYRFRQ8RGTZdeupRc42TOCl885dcPlgvi53SvHzg=;
        b=Gn6JhUcCgRJcrftbY/v2RjbVESgAoPS2j8X3SalWql9T1XjD3s7LsMmdj/zdyvQwFu
         SQ/3ZN48Y8J0p45kuKLi1qTxpvvBjPBDHuW+99N37zAO3UaXN/lf3Xxj+b67xyWS4/L8
         ud9huApTozwBnEieN2MZFUb0JnvQ8NCYshjpAdaZfG4SosYIIoYS+/vt3BzwjS9ilcTM
         KheILoa9X+D22CMUDFX02dSrHWTiI9ZjhVD+NZKXIsuJuyXLcJC82JYcKQZhwuA5SDH4
         kmgm+iWwz+LoA05Sn55N/nIJw5SLjTL5Ps8esqsb0vC+G7AEAmpIE5LR0xWaOVFQXruI
         gDCg==
X-Gm-Message-State: AOAM530eyZCWT74PmgJsESwPlSIaWobIJ28LyyEDz4K9dtSGWe7neIVL
        vP40N6N7lB2BjyI1ENGkMYY=
X-Google-Smtp-Source: ABdhPJxTQ3033TVhWCAhpEUHjQ1bPvP/mlFJSol0sX4o0aUDYq7VZX7RGVnqGwp3R9makOPeKjeeKQ==
X-Received: by 2002:aa7:dd4e:: with SMTP id o14mr14306436edw.203.1602510177219;
        Mon, 12 Oct 2020 06:42:57 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id k1sm10748853edl.0.2020.10.12.06.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 06:42:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 15:42:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Missing [GIT PULL] request for
 <tip.git#locking-urgent-2020-10-11>
Message-ID: <20201012134255.GB2023362@gmail.com>
References: <CA+icZUUK3sgpHyY1h_pdzJzkX1bY46opLYytRKRzeCxBNzTX4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUK3sgpHyY1h_pdzJzkX1bY46opLYytRKRzeCxBNzTX4A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sedat Dilek <sedat.dilek@gmail.com> wrote:

> Hi,
> 
> yesterday, I saw Ingo tagged "locking-urgent-2020-10-11" in tip Git.
> 
> Did you drop it or was this for Linux v5.9 final and the git-pull
> request was simply forgotten?
> 
> Just curious.

So I ran the pull request script to send the tree to Linus, but on final 
review decided not to send it, as there was a pending bugreport against the 
tree, it was very late in the cycle and the commits were pretty fresh. I 
sent two other trees (x86/urgent and perf/urgent).

This is why there's a signed tag for locking/urgent, but no pull request.
:-)

Thanks,

	Ingo
