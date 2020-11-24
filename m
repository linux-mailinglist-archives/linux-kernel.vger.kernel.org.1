Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDE32C20DC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgKXJEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbgKXJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:04:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46658C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:04:33 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e3600a9cb1df0e98d070c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:a9cb:1df0:e98d:70c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6C931EC0411;
        Tue, 24 Nov 2020 10:04:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606208671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6kMx6CvQEut1O2ATzEvOMdVThQx+i717xnGHX3Jg8qU=;
        b=XI3UpvuFRjCdrLWhgf7EC4LKLXAmctWaSMFnpzgoAUsi1xoMswvJ8RtUPwbcOUrprHIIgD
        35WAvbpYz/L50dZlnAX612/D34ep//wdmN4XdIi6pSsoHmEXlFt6ySwUKRWGY7ns88EGCn
        /UPxQZDHcjSGVgr0bgrr/v86OSDlFbM=
Date:   Tue, 24 Nov 2020 10:04:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com, jon.grimm@amd.com, rientjes@google.com
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20201124090431.GC4009@zn.tnic>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic>
 <20201123175632.GA21539@char.us.oracle.com>
 <20201123225631.GA16055@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201123225631.GA16055@ashkalra_ubuntu_server>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:56:31PM +0000, Ashish Kalra wrote:
> As i mentioned earlier, the patch was initially based on using a % of
> guest memory,

Can you figure out how much the guest memory is and then allocate a
percentage?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
