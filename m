Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555CF29626A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901471AbgJVQM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901388AbgJVQM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:12:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A43CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:12:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 13so2748545wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VMX/DifcbR2wsB+7u9cm21/M0m5OWH7iQ5Ym+wWVTd8=;
        b=Xydxscdr3WusIX4pGX7uGMhfh8sUvXczDgz9gyLUagvuaaWSVPDshV0/nw+S/ujvRb
         FH3Z9AGMAaSONmp6Z4OKZQiHjT7Kz1shXjWsZTAlAKNMdh4q4ptwhW68NbFUPC2bMFOs
         QENFXchHgbd+LHfGgDBLs46W2FMRLKpPVxW44BDl9EfZiDJSiqmJmm94+iNr78u6sU6H
         Z5+2Gv7RRPN7Fas7BdgBaXZZPucoA/YKda/K2npvDhQw7u0SwakY04jjNWomyNYwhC6K
         oStW/fpirjPdhC136zFbDBYkwJy/tF6bBL196G3MKi5pr9AeQmqwA0LAsQnruTxM1hJ5
         xHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VMX/DifcbR2wsB+7u9cm21/M0m5OWH7iQ5Ym+wWVTd8=;
        b=D8yzJSl7KQbVERPICIl8P250kVQd2H33RpXbB2VBcrKIc6WtqeJKFuMaSChTa91Wfh
         fKwf/5cydySHUewkxzxaFxhUXUiH40PPu08uj0aSfOMuStviygf/fhPsvg1RqvAV5DHT
         +bMT+jTwg41aLfHQATg2LXRcfJ1qcoOpQp1W28zHTTuIPvJVs4942CBsLbGPsVbxhlfP
         OEAuyyRLM+7wCHzPaXobS5mkzWpi61fFnjHKWUQHT+ms1Vb0UyeGxTTVXW0cJhOr7pof
         x0QZMmiKwfJOD5ZxSHQ8I8Ca1riEOUAN8cqFFuD7Oq+/nzLy/ewnAfMCs8i23/Yy9zNG
         StNQ==
X-Gm-Message-State: AOAM533gmylJSx02H+YWZzUVqK1gGtsPETORHPgMI96G0l+t2Fc/RmUs
        25k8oXTmslTVw/b9lymdu0Xzgg==
X-Google-Smtp-Source: ABdhPJwz/1ox94yX0GrTEfj1vpICbGs9jpVKNEFozk1SgsqttyPFzL2Sn6BzAIUujs1m48PtRgDTFQ==
X-Received: by 2002:a1c:cc01:: with SMTP id h1mr3442702wmb.114.1603383176832;
        Thu, 22 Oct 2020 09:12:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id a17sm5128902wra.29.2020.10.22.09.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 09:12:56 -0700 (PDT)
Date:   Thu, 22 Oct 2020 17:12:54 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V9 1/4] fuse: Definitions and ioctl() for passthrough
Message-ID: <20201022161254.GA36774@google.com>
References: <20200924131318.2654747-1-balsini@android.com>
 <20200924131318.2654747-2-balsini@android.com>
 <CAJfpegvB7XJH7sPni7Vj7R4ZwSrDfevfeRRBgvESSgGg=C5tdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvB7XJH7sPni7Vj7R4ZwSrDfevfeRRBgvESSgGg=C5tdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:44:54PM +0200, Miklos Szeredi wrote:
> On Thu, Sep 24, 2020 at 3:13 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > Introduce the new FUSE passthrough ioctl(), which allows userspace to
> > specify a direct connection between a FUSE file and a lower file system
> > file.
> > Such ioctl() requires userspace to specify:
> > - the file descriptor of one of its opened files,
> > - the unique identifier of the FUSE request associated with a pending
> >   open/create operation,
> > both encapsulated into a fuse_passthrough_out data structure.
> > The ioctl() will search for the pending FUSE request matching the unique
> > identifier, and update the passthrough file pointer of the request with the
> > file pointer referenced by the passed file descriptor.
> > When that pending FUSE request is handled, the passthrough file pointer
> > is copied to the fuse_file data structure, so that the link between FUSE
> > and lower file system is consolidated.
> 
> How about returning an ID from the ioctl (like the fuse2 porototype)
> and returning that in fuse_open_out.passthrough_fh?
> 
> Seems a more straightforward interface to me.
> 
> Thanks,
> Miklos

With this patch I tried to avoid any API modifications, for example,
changing fuse_open_out, doing everything at ioctl() time, and limiting the
allocation of dynamic memory.
 
In my next patch set (that I'll share as soon as I have enough hours of
testing with syzkaller) I implemented something similar to fuse2 in terms
of communication between kernel and userspace, with an id passing as you
recommended. So, userspace gets an id from the ioctl() and sends it back to
the kernel through the open/create reply, setting the passthrough_fh field
in fuse_open_out, that originally was the uint32_t padding. This wouldn't
change the fuse_open_out struct size, but is kind of an API breakage.
 
As in fuse2 I'm using IDR to generate the id and track the passthrough
entry information. On the other hand, compared to fuse2, I have one dynamic
IDR for each fuse_conn to prevent the owner of a connection from messing
with the ids of others.
In the upcoming patch set, the elements of each IDR serve the only purpose
of keeping track of the id in the timespan between the ioctl() and the
open/create reply. That IDR entry is removed right after the open/create
request is completed.
If in fuse2 the global IDR is queried for every read/write operation, my
new patch set would still create a "passthrough entry" for each fuse_file
to simplify the access to the lower file system at every read/write,
getting rid of IDR searches for each read/write operation.
 
Does this solution make sense?
 
I'm not sure that the upcoming solution is simpler than this one, but for
sure it keeps the interface more flexible and I like that it is moving in
the direction of fuse2.
 
Thanks,
Alessio

