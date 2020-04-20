Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8E01B05BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 11:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDTJee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 05:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:34:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE8CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 02:34:34 -0700 (PDT)
Received: from zn.tnic (p200300EC2F08140068F64889F873250A.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:1400:68f6:4889:f873:250a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E18621EC0985;
        Mon, 20 Apr 2020 11:34:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587375273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gRCV9pIoNs6Pdb6DavXoSPnf6a7A5tWe7Fj6CiBqtRs=;
        b=NT086U7GZ6/1irXHWSH9vA5q1XN0h3sJGWtkm8Arq2mUBMeViEUvTui5BZ2iwr+LUyejg8
        43ncHyy4rRB1gYQH4JErC3RGnQtj+kShqfK1KJE127X7Ecx2lLMldg3JQNrw+fj/xirScB
        lsnFMNsYcVXJAW2k5OSPLhnprlmOnqs=
Date:   Mon, 20 Apr 2020 11:34:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 02/15] x86/cpu: Uninline CR4 accessors
Message-ID: <20200420093434.GB3147@zn.tnic>
References: <20200419203137.214111265@linutronix.de>
 <20200419203335.856333226@linutronix.de>
 <20200420090102.GB24518@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420090102.GB24518@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:01:02AM -0700, Christoph Hellwig wrote:
> While this is better than what we had before we really need to have
> a discussion on lkdtm - it needs a lot of crap that otherwise wouldn't
> be exported, and I'm really worried about people enabling it and thus
> adding exports even if they are conditional.

Thought the same too, while looking at that. It is fine and dandy that
it injects all kinds of crap into a running kernel but not at the price
of exporting such internal interfaces.

> Can we force the code to be built in require a boot option for it to
> be activated?

Yes please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
