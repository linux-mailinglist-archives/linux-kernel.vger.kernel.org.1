Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A91C9C91
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 22:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGUme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 16:42:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46579 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726093AbgEGUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588884153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b8a0Z2antnJYCUF8WBh734GS5zKFlaHhrNwslLNb//k=;
        b=bgfGZvWu9ezgraIcODPKZsR9e9Eq+EcgfkxfnPImg+w5Csx1RKlAKL87+iZSip976aTmPJ
        yezRI0K9c4bMumgIM41Pl3evXmp3GkMcu34BirTuyWFUCN3r7kydbnTRcRHcGHDa/NsHlR
        eZjLTM2OG2ioT4Cfk105palrif0UBhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-AT7T8A5AMTS2CeTivjxVYw-1; Thu, 07 May 2020 16:42:31 -0400
X-MC-Unique: AT7T8A5AMTS2CeTivjxVYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0944580183C;
        Thu,  7 May 2020 20:42:29 +0000 (UTC)
Received: from optiplex-lnx (unknown [10.3.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 63D8019C4F;
        Thu,  7 May 2020 20:42:22 +0000 (UTC)
Date:   Thu, 7 May 2020 16:42:19 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kernel: add panic_on_taint
Message-ID: <20200507204219.GJ205881@optiplex-lnx>
References: <20200506222815.274570-1-aquini@redhat.com>
 <C5E11731-5503-45CC-9F72-41E8863ACD27@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C5E11731-5503-45CC-9F72-41E8863ACD27@lca.pw>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 10:50:19PM -0400, Qian Cai wrote:
> 
> 
> > On May 6, 2020, at 6:28 PM, Rafael Aquini <aquini@redhat.com> wrote:
> > 
> > Analogously to the introduction of panic_on_warn, this patch
> > introduces a kernel option named panic_on_taint in order to
> > provide a simple and generic way to stop execution and catch
> > a coredump when the kernel gets tainted by any given taint flag.
> > 
> > This is useful for debugging sessions as it avoids rebuilding
> > the kernel to explicitly add calls to panic() or BUG() into
> > code sites that introduce the taint flags of interest.
> > Another, perhaps less frequent, use for this option would be
> > as a mean for assuring a security policy (in paranoid mode)
> > case where no single taint is allowed for the running system.
> 
> Andrew, you can drop the patch below from -mm now because that one is now obsolete,
> 
> mm-slub-add-panic_on_error-to-the-debug-facilities.patch
>
Please, don't drop it yet. I'll send a patch to get rid of the bits,
once this one gets accepted, if it gets accepted.

-- Rafael 

