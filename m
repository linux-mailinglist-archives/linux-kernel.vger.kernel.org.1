Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D2F2F46FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbhAMJA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbhAMJA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:00:28 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEAAC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:59:47 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q7so1082713pgm.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=khY3b9nNLG3pn8j5ObMad/IKodRFErErRiM9bDM1Hc4=;
        b=m6cG2SZeoQC7z+233pF69aduzYVErPg7kpJnAwKckGrYeox/3cz6OJTflqkC44PiAA
         Ua3Dnyw7IzJqquKUSYJT8KQNhPwx/nBUt+TMamSiADca5useKtiXMpzEHpsr0yAW9muC
         jeANNgo8BBvZTjbXVu0nauEXPnwXC+FSgBVFUQYVJwMwOYOo9saJkLZD6BIkz7JDKVR2
         pLzx/RtBzX8qVvXQ5W1+1ttaxU+EtbysSUCzkXMVGYWcUD+i61vC9rRSD4ttddp5Jesx
         uxlQgYEDUlk/5/yBIopyVL7CSZ2GQ+AMakMnm7G6Dx2eldCI/JXBv3SwktDO5jhdL+ej
         QURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=khY3b9nNLG3pn8j5ObMad/IKodRFErErRiM9bDM1Hc4=;
        b=oRPjwvp5jdyzqXFT7U1jWywkAimRDscaIzztNzVV/L4B0M+9WlpiGKtGk/41ZhuCG9
         umVBaQugBDf5061fC1213k41gnaw8uC16FzHxikQkowFsMh5jyXs3LOffpobbA38e/Lp
         9rr7GWvbTVqP6M21lMw7c1LCdesk3LGUxl7HK8k5Pejz8GWaCppTn6quhQWYupnAbaBQ
         2nwVu5d2OU5+lizau3T7ZZVPSiUq0SgGo/bDjVGSuqPVluRzpdEpKxSjpOTCoAdieII+
         YqmHm/6wh+cyqpW6DnpSyTq+o8FDQBtOI+TEGTOuwGNlWqTx2VSm3xdF5PZiS6mWtB2i
         Rmyg==
X-Gm-Message-State: AOAM533RuUGyT4dp3sBfOMnG9REB6voglkzW9cHLkHEX20E3FVa9yaFe
        utU9hbJ0f+kBboziMcLTxfmZB5DfQXbg1bepoQ==
X-Google-Smtp-Source: ABdhPJwVWFuNi6dvy6mSyvRbPP0hwlr8Ien7QxybRLxE1DP9YCSVorjq8qfBj9l8qV1Qf5GS6SEOog==
X-Received: by 2002:a65:688a:: with SMTP id e10mr1141158pgt.347.1610528387165;
        Wed, 13 Jan 2021 00:59:47 -0800 (PST)
Received: from [10.85.112.53] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id e10sm1738764pgu.42.2021.01.13.00.59.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 00:59:46 -0800 (PST)
Subject: [PATCH v2 2/2] MAINTAINERS: Update my email address
From:   Zefan Li <lizefan.x@bytedance.com>
To:     tj@kernel.org
Cc:     Steve Wahl <steve.wahl@hpe.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
Message-ID: <f8fe9c3b-db08-50da-d207-0952be5d2b85@bytedance.com>
Date:   Wed, 13 Jan 2021 16:59:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <75494a75-a74b-3dba-9846-7f51d805023a@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Zefan Li <lizefan.x@bytedance.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a01cd3e0a2b..4987d1ce9ac6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4448,7 +4448,7 @@ F:	include/linux/console*
 
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
-M:	Li Zefan <lizefan@huawei.com>
+M:	Zefan Li <lizefan.x@bytedance.com>
 M:	Johannes Weiner <hannes@cmpxchg.org>
 L:	cgroups@vger.kernel.org
 S:	Maintained
@@ -4472,7 +4472,7 @@ F:	block/blk-throttle.c
 F:	include/linux/blk-cgroup.h
 
 CONTROL GROUP - CPUSET
-M:	Li Zefan <lizefan@huawei.com>
+M:	Zefan Li <lizefan.x@bytedance.com>
 L:	cgroups@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git
-- 
2.11.0

