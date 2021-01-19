Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FB12FBBF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbhASQG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391784AbhASQFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:05:55 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:05:15 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id c12so8477992qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZUwgc+g9mchGKVE7WOGECm+yGS6+mRJiFamQj4yLWK8=;
        b=l+FN26P89X2IT4CVTLoKplG/hUiyrJzNy6+llZfcYxvkulpLtBseWdcId5CJwk6ELQ
         jmBIc1ClHx4xnR+qByPhMYOPrtERcxJO0ELdQg7uTQVdeSpBT39y3p8zZ082Hlu6C7IK
         PiVpKgirPVgWhRdCPSR3UoGUjB0iMXm8m422Ba4+FIF1c69m5fomO7SI5XPUHBtG5nEp
         XFAXhIJREOG2OsYTth+0Iks9186dm/xfnLF9FYd4TC+aIw7TLdxBt7EwnFqMYYaL8oMU
         WTDYYKVqetYI3GevAuKHwxDglL/KDpYEvjdVScKsJSwRfL9NXj+4Zyny4nmg7jspdWYz
         6kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZUwgc+g9mchGKVE7WOGECm+yGS6+mRJiFamQj4yLWK8=;
        b=H9jDrr4y1QNnMuEmINFVVVm3lu1r2VX9BgS4ty9tUxyzXKiN1KFc/QUsckwIcQMORe
         NOxxvlLDNzB1K1iA6Zus0Gyl0k37d6BRDo0FgcwKJUB/tpA5o4XgF/0HiIm0fg4/A7yP
         Hk4ZMFleXYwIHTOAkrH78bymsOfPvDQpVmUeQDsmD6Rdw2z4tLXfCrzHHUKu9EFqOVgL
         N7GJcnIZ0JZilkpErIH2+/mV0Ab1h03M0YRMT8zVlRXX742MytNpjTrgFlpdYO5Fou0I
         da7lGbtu4sUnC5y12KShXRCxQv2Md6JO5PdXBqa+DaCi7VkSB9394zG/Yd/MxVhMMaRz
         tqnA==
X-Gm-Message-State: AOAM5338sciZh3x0s46W/BRbSzblZVIe+Z8F6Re4/Bgxy7hk1oj+JyuY
        JU2InFFH2V/Umhr0FBhQ5SE=
X-Google-Smtp-Source: ABdhPJyF5TSXSRum4qj7gOpzVNCZ3E7s6l3DfLgFwNHfsN3/QhZsOAs02jPuUU4BUsHiEXAwsDGKAQ==
X-Received: by 2002:ac8:7259:: with SMTP id l25mr4804984qtp.1.1611072314227;
        Tue, 19 Jan 2021 08:05:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:4cbf])
        by smtp.gmail.com with ESMTPSA id v145sm13587664qka.27.2021.01.19.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:05:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jan 2021 11:04:29 -0500
From:   Tejun Heo <tj@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: tracing the name of the workqueue instead of
 it's address
Message-ID: <YAcDDYrRRUWTkAwR@mtj.duckdns.org>
References: <20210104124306.24375-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104124306.24375-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 08:43:06PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> This patch tracing workqueue name instead of it's address, the
> new format is as follows.
> 
> workqueue_queue_work: work struct=0000000084e3df56 function=
> drm_fb_helper_dirty_work workqueue=events req_cpu=256 cpu=1
> 
> This tell us to know which workqueue our work is queued.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Applied to wq/for-5.12.

Thanks.

-- 
tejun
