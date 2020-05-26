Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067A01DA3B2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 23:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgESVfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 17:35:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESVfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:35:17 -0400
Received: from zn.tnic (p200300ec2f0b87001461a870af27ee92.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8700:1461:a870:af27:ee92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D4091EC0116;
        Tue, 19 May 2020 23:35:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589924116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1ykpi21obY+XaGMcXU9D3SqpikMORIbPx2CZglhHLAA=;
        b=IzodQmR1oJltF2LAW7hloN2gY/GvgvfvgraPkJhYFSsHrE8VE+UbC6kWu0tJlnNZmnVbMz
        qWPM0MdiG/36WBkUxW/kAXg3DWT4a2A6sWGfAfQnRxdEQtu0cMQ+ksqXiSWb8e5Z4VfVCT
        Mzlon8lLshWtu5CYFc3jFjcJ+5Vs+jY=
Date:   Tue, 19 May 2020 23:35:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6 0/4] x86/resctrl: Enable user to view and select
 thread throttling mode
Message-ID: <20200519213516.GF444@zn.tnic>
References: <cover.1589922949.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1589922949.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 02:28:27PM -0700, Reinette Chatre wrote:
> V5 upstream submission available from:
> https://lore.kernel.org/lkml/cover.1589844108.git.reinette.chatre@intel.com

Is there any chance for not spamming us with this patchset almost every
day?

From Documentation/process/submitting-patches.rst:

"Wait for a minimum of one week before resubmitting or pinging reviewers
- possibly longer during busy times like merge windows."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
