Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82882F60A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbhANL7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:59:02 -0500
Received: from foss.arm.com ([217.140.110.172]:48722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbhANL7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:59:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 063311042;
        Thu, 14 Jan 2021 03:58:16 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.42.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7493F719;
        Thu, 14 Jan 2021 03:58:14 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:58:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: arch/arm64/kernel/syscall.c:164:6: warning: no previous
 prototype for 'do_el0_svc_compat'
Message-ID: <20210114115811.GC2739@C02TD0UTHF1T.local>
References: <202101141046.n8iPO3mw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101141046.n8iPO3mw-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:41:59AM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
>    arch/arm64/kernel/syscall.c:157:6: warning: no previous prototype for 'do_el0_svc' [-Wmissing-prototypes]
>      157 | void do_el0_svc(struct pt_regs *regs)
>          |      ^~~~~~~~~~
> >> arch/arm64/kernel/syscall.c:164:6: warning: no previous prototype for 'do_el0_svc_compat' [-Wmissing-prototypes]
>      164 | void do_el0_svc_compat(struct pt_regs *regs)
>          |      ^~~~~~~~~~~~~~~~~

Looks like this is down to syscall.c not including <asm/exception.h>,
since do_el0_svc_compat() has a prototype there.

I'll spin a patch...

Mark.
