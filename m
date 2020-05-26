Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EF41E2379
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 15:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgEZN7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 09:59:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:60692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgEZN7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:59:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3935DAD83;
        Tue, 26 May 2020 13:59:39 +0000 (UTC)
Date:   Tue, 26 May 2020 15:59:35 +0200
From:   Jiri Bohac <jbohac@suse.cz>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        ebiederm@xmission.com, jmorris@namei.org, mjg59@google.com,
        dyoung@redhat.com, bhe@redhat.com
Subject: Re: [PATCH] kexec: Do not verify the signature without the lockdown
 or mandatory signature
Message-ID: <20200526135935.ffkfulsjf7xrep63@dwarf.suse.cz>
References: <20200525052351.24134-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525052351.24134-1-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 01:23:51PM +0800, Lianbo Jiang wrote:
> So, here, let's simplify the logic to improve code readability. If the
> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
> is mandated. Otherwise, we lift the bar for any kernel image.

I agree completely; in fact that was my intention when
introducing the code, but I got overruled about the return codes:
https://lore.kernel.org/lkml/20180119125425.l72meyyc2qtrriwe@dwarf.suse.cz/

I like this simplification very much, except this part:

> +	if (ret) {
> +		pr_debug("kernel signature verification failed (%d).\n", ret);

...

> -		pr_notice("kernel signature verification failed (%d).\n", ret);

I think the log level should stay at most PR_NOTICE when the
verification failure results in rejecting the kernel. Perhaps
even lower.

In case verification is not enforced and the failure is
ignored, KERN_DEBUG seems reasonable.

Regards,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

