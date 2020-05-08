Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF911CB459
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 18:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEHQJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 12:09:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33172 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgEHQJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 12:09:40 -0400
Received: from zn.tnic (p200300EC2F0C9800329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9800:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 00FBC1EC008F;
        Fri,  8 May 2020 18:09:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588954179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UqLtVT0FeQmzUfsO+zZA7Gur4b3vfPoCKM3UXxWw5Nc=;
        b=iN9Em3ee7IKvXVDRD1gnQ6cbvugr2wQhogKP7eXqD67gtswC7rOOtpxi2IILZZn8R6GhhB
        cq1F/95hEoQ9cUrVJvKxF3tw7BPxTL6iOodu1idhke6d6zMWH302H08EUQxncJtOq0ikzO
        weWQiPe2GP+hHs2/d+mxS9W+ZmcBJLY=
Date:   Fri, 8 May 2020 18:09:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v7 2/5] seq_buf: Export seq_buf_printf() to external
 modules
Message-ID: <20200508160935.GB19436@zn.tnic>
References: <20200508104922.72565-1-vaibhav@linux.ibm.com>
 <20200508104922.72565-3-vaibhav@linux.ibm.com>
 <20200508113100.GA19436@zn.tnic>
 <87blmy8wm8.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87blmy8wm8.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 05:30:31PM +0530, Vaibhav Jain wrote:
> I am referring to Kernel Loadable Modules with MODULE_LICENSE("GPL")
> here.

And what does "external" refer to? Because if it is out-of-tree, we
don't export symbols for out-of-tree modules.

Looks like you're exporting it for that papr_scm.c thing, which is fine.
But that is not "external".

So?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
