Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4A42D36A5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgLHXCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgLHXCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:02:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D458C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:01:26 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f08002eb81e5fb58e3a10.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:800:2eb8:1e5f:b58e:3a10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B00FD1EC053C;
        Wed,  9 Dec 2020 00:01:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1607468484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Blu5v8fcrvQrvAUlkngUq7c7NQ0Ki8U83FN+6m7vV6Q=;
        b=psFxMRLN9mm0OzN8nYo3NvMVZj4Qkmmz/cJxzG7NTYOuskoBcQI4mUW6uFb7S/0aXG0DP/
        9AP+BBTpY5vHFDBa+gcVy8bzLuXvpzFOUlBHAndkS7AZ2wq/bLCR5xG0i79OIm3rKhnG6V
        C8jqGxsmHW+1cXJrtSZ+kn8LFRw7j9s=
Date:   Wed, 9 Dec 2020 00:01:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com, Jon.Grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH v8] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201208230119.GG27920@zn.tnic>
References: <20201207231057.26403-1-Ashish.Kalra@amd.com>
 <20201208222220.GA27599@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208222220.GA27599@char.us.oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 05:22:20PM -0500, Konrad Rzeszutek Wilk wrote:
> I will fix it up.

So who's picking this up? If not me then I probably should have a
detailed look at the x86 bits before it goes in...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
