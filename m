Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4908A1D4E13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 14:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgEOMuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 08:50:04 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21311 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgEOMuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:50:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589546993; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=V+juCDGmzCaworGcppZOetk77nItd73iy2X2+qW6Tmp6+nCEht8wDIrQ5UR4S47AUqGAnlFHJYSVdWTSgXeglXngKWkr3h4jzLfKBKHZCD3MHS+uEE2DIUTew5kKb9ytDfJJc9oKIgmSvz1/wGUi1gsjZaRsuXbjsZk5bTxGMx0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1589546993; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=eKa9B/a0gn/6xbMvZVNBWEY4ReK7vfKHmofTOT6BFFo=; 
        b=WTMAtakiVZTc6C7hxrGlIK3sjuA7lcCWMGvV7XorzJoHGgSTAz4WYJ9DiHtV6nxy/lNsQL6CW37RxhRpHpFprnyW+J3xAw/StVMx4SYhUTTEWrTCq/0nU3J2+Htp9XGWoeyPXaLQlsxHs013SAOF0mX7yhdE62fvaPjZV7gSrHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=embedjournal.com;
        spf=pass  smtp.mailfrom=siddharth@embedjournal.com;
        dmarc=pass header.from=<siddharth@embedjournal.com> header.from=<siddharth@embedjournal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1589546993;
        s=zoho; d=embedjournal.com; i=siddharth@embedjournal.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=eKa9B/a0gn/6xbMvZVNBWEY4ReK7vfKHmofTOT6BFFo=;
        b=ZGNjYl5ggyPglXshZJy6h9IzzOpx5HM9VglK3jYm3tSnOZCpWd0arzvhAJFPIyAw
        Vuc6xxshw2uWJXW4b7eljaNZfohsH18RhJBdroUpkoV5q36heegDid5UzAB47x2Eixl
        FSh1u6rkAoJfRWXaoZ1cI4eGRwBaJZZYb3d6pzDY=
Received: from csiddharth-a01.vmware.com (115.97.41.221 [115.97.41.221]) by mx.zohomail.com
        with SMTPS id 1589546991508700.2100207306029; Fri, 15 May 2020 05:49:51 -0700 (PDT)
Date:   Fri, 15 May 2020 18:19:45 +0530
From:   Siddharth Chandrasekaran <siddharth@embedjournal.com>
To:     Siddharth Chandrasekaran <csiddharth@vmware.com>
Cc:     gregkh@linuxfoundation.org, srostedt@vmware.com,
        linux-kernel@vger.kernel.org, stable@kernel.org,
        srivatsab@vmware.com, dchinner@redhat.com, darrick.wong@oracle.com
Subject: Re: [PATCH] Backport security fixe to 4.9 and 4.4 stable trees
Message-ID: <20200515124945.GA93755@csiddharth-a01.vmware.com>
References: <cover.1589486724.git.csiddharth@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589486724.git.csiddharth@vmware.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch set, I accidentally added another patch I was
working on. Will send v2 with the right patches.

Thanks!

-- Sid.
