Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7F32EE9AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 00:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbhAGXPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 18:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbhAGXPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 18:15:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 41AF023435;
        Thu,  7 Jan 2021 23:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610061303;
        bh=6WmSpRAgxw55H+AbxkHQPUr//pcs3FzD3Dgc0jvHpXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jVO+iKiakCwJHdLcs3X8bz8PCIMIF+quXTAHHEJqc3zGiprIGvqp9ebHqiP3i3u7K
         d9BFYpD4aZg2meEtFCUljyYuNEVF1CZtrUcS7/G5u19RjVU25X9ADoAJWnDjfyfmRl
         XOfmQ6w2eGvcvUBMgFrzSVjA/fnmyczYEA+WYZio=
Date:   Thu, 7 Jan 2021 15:15:02 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: Fix potential double free in
 hugetlb_register_node() error path
Message-Id: <20210107151502.7c581d98078ba90e63553dd4@linux-foundation.org>
In-Reply-To: <a8753475-e9a8-a730-c095-086530ecdd17@oracle.com>
References: <20210107123249.36964-1-linmiaohe@huawei.com>
        <a8753475-e9a8-a730-c095-086530ecdd17@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 11:59:38 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 1/7/21 4:32 AM, Miaohe Lin wrote:
> > In hugetlb_sysfs_add_hstate(), we would do kobject_put() on hstate_kobjs
> > when failed to create sysfs group but forget to set hstate_kobjs to NULL.
> > Then in hugetlb_register_node() error path, we may free it again via
> > hugetlb_unregister_node().
> > 
> > Fixes: a3437870160c ("hugetlb: new sysfs interface")
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  mm/hugetlb.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Thanks, this is a potential issue that should be fixed.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> This has been around for a long time (more than 12 years).  I suspect
> nobody actually experienced this issue.  You just discovered via code
> inspection.  Correct?
> At one time cc stable would not be accepted for this type of issue,
> not sure about today.

sysfs_create_group() will only fail if something is terribly messed up
- probably it has never happened to anyone.  I don't think the
cc:stable is justified here.

