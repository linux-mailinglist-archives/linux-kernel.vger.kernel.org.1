Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774992CA07D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgLAKx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:53:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:57416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgLAKx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:53:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606819961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TyvBSFSCVH42jmUB2hpFXQQFaqAXwy5GGCvM4Ps/q0k=;
        b=tvjxp99M2vWI7boZjVzVgHo/eLe4kCvbjrBoEd47pJuWCx6SyiwsqXsAZcygAMAF2Rqhof
        zFjEDgy6HruYlmHIjGG8DMRwn5fX+zyr58hTIMaFOQ2He5pTeh7sHsxTvWHwu510Kj8IBm
        b4b13vcKmAJ2pOGyzUSU0O0N1Ktrpgs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4052AAC90;
        Tue,  1 Dec 2020 10:52:41 +0000 (UTC)
Date:   Tue, 1 Dec 2020 11:52:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] reboot: hide from sysfs not applicable settings
Message-ID: <X8YgeKHP7AhK37FV@alley>
References: <20201130173717.198952-1-mcroce@linux.microsoft.com>
 <20201130173717.198952-3-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130173717.198952-3-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-11-30 18:37:17, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Not all the reboot settings from both the kernel command line or sysfs
> interface are available to all platforms.
> 
> Filter out reboot_type and reboot_force which are x86 only, and also
> remove reboot_cpu on kernels without SMP support.
> 
> This saves some space, and avoid confusing the user with settings which
> will have no effect.
> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>

Looks good to be.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
