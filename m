Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445371BC72E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 19:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgD1RwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 13:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgD1Rvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:51:54 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B39C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:51:53 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t3so22744401qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=flDFVuexqKoyIqkmAWtBDr+M8tCMbLOHhMvcareArt8=;
        b=Sst10ryGsYNx9uSgpIPgN5eKD6112WZEwMK3FVoPrZxMBm+yVd54Ezt9p4QkdA5WTq
         pjqAZDhOdlwepcC952DBl1bOO61iNKkxMnwvv0HIh8PJNNrIgdHOwZlWWsFNKknE71t2
         V004LRFArnHZ9sZQEjx1vRSj/ra3S5IsAtdcBWYUATVlUeVMR+7z+rqrJE7XsbWCqWEn
         XAMyfs+DbxSZdjnnPVe2Wr1hEbuxkSOFvE8VKDDUIkVCcX4em5uXJOao/nlXTB7FaJCO
         1GgEr5AI/ysU7vzHNUAO+3Y6lkTv4co1WOjPzUSRGO/VSFV8NvuahG06P7ZfVq1U2mMZ
         dS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=flDFVuexqKoyIqkmAWtBDr+M8tCMbLOHhMvcareArt8=;
        b=FR8IStFul4tzKPtgqKIbrkwD6i5o9iVArAndMzfb3ua80KJjzu8O6AeCX1kRqQhnNw
         RYtzBExPBTE7m1caN7PXEN6D2BLYBCxB5A7CBlNOnQNr/w4zxQK6GoZTeAS2H5Pax0q1
         5PrDBMkFw2FyQFpebhZKiHwtHi1iYndfPmokdh05qTCTBze3ciGXTh7RLM2nzWeJ5iky
         IYitguFtqYrcKMmjHBuL6bMyO7iyPikamzxy2cY3ufVgqVeXrLpAGwMeA/N+ZQzQ/9QG
         fDod+mM79XiiNQjn9ezvfqaDqjXYrKK4Y4LzAeoDsZ6q/vx3U8rxVFZ06Txut6aoLGKp
         UJyA==
X-Gm-Message-State: AGi0Pub/Gy6Ww8nZbG5Igp+3/4o2M8vjlemuLbmCQWa0ZEmdmWe2F2o5
        gjge03CION16YnhLrjMcS0U=
X-Google-Smtp-Source: APiQypJVTFmK3Q1h8uVbuLnnE8k6c+ojs/8anEXhpDX4oUm4rLN2JjDrbG0r0N0AL7L6xe7EhYRRmQ==
X-Received: by 2002:a37:387:: with SMTP id 129mr28891382qkd.147.1588096312867;
        Tue, 28 Apr 2020 10:51:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id v2sm14906214qth.66.2020.04.28.10.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:51:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7B99409A3; Tue, 28 Apr 2020 14:51:49 -0300 (-03)
Date:   Tue, 28 Apr 2020 14:51:49 -0300
To:     Zou Wei <zou_wei@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf report: fix warning Comparison of 0/1 to bool
 variable
Message-ID: <20200428175149.GE5460@kernel.org>
References: <1587904683-3510-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587904683-3510-1-git-send-email-zou_wei@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 26, 2020 at 08:38:03PM +0800, Zou Wei escreveu:
> Fixes coccicheck warning:
> 
> tools/perf/builtin-report.c:1403:2-34: WARNING: Assignment of 0/1 to bool variable


Fixed the subject line to have "assignment", not "comparison",

Thanks, applied,

- Arnaldo
