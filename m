Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C96285703
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgJGDV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:21:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbgJGDVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:21:25 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4C5fkX3sX6z9sTq; Wed,  7 Oct 2020 14:21:23 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Wang Wensheng <wangwensheng4@huawei.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     vaibhav@linux.ibm.com, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, paulus@samba.org, santosh@fossix.org,
        ira.weiny@intel.com, dan.j.williams@intel.com
In-Reply-To: <20200918085951.44983-1-wangwensheng4@huawei.com>
References: <20200918085951.44983-1-wangwensheng4@huawei.com>
Subject: Re: [PATCH -next] powerpc/papr_scm: Fix warnings about undeclared variable
Message-Id: <160204083034.257875.10677454204358541362.b4-ty@ellerman.id.au>
Date:   Wed,  7 Oct 2020 14:21:23 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 08:59:51 +0000, Wang Wensheng wrote:
> Build the kernel with 'make C=2':
> arch/powerpc/platforms/pseries/papr_scm.c:825:1: warning: symbol
> 'dev_attr_perf_stats' was not declared. Should it be static?

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Fix warnings about undeclared variable
      https://git.kernel.org/powerpc/c/4366337490cbe5a35b50e83755be629a502ec7e2

cheers
