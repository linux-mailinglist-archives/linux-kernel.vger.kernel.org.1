Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA5C253847
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHZT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 15:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgHZT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:26:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4813C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:26:41 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id si26so4415039ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TYKPTufiMBAMoTNCgDN7PLKKjOS7TYvnr9DjmBNmXfM=;
        b=FaUxUnjKb0N9Xw2K3ckURq7XBP2BC7VSd74QmXqnGlHpmfsTcG0/cbq0wjQ72NwmtM
         /XRHgHj1rfJMGI+1Wj3VNHM4uo0IrKuS9FTep4/wvrAttKznUFlA2UZIfJWJPZoJ06Ei
         s2yVxWhOI+28JDFT+R83RAGBwXVvIqe78CshI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TYKPTufiMBAMoTNCgDN7PLKKjOS7TYvnr9DjmBNmXfM=;
        b=b+KsuaEHcx/TNyQHcmDk+m3jMvZlenWkvafqJmYRADLluqze0J5A+HXuoxjTSX4O+d
         S0LK/PzcqVvyK0CgGdw9ngzClIIad+WqO7YuQO0arNsj9hLqgrJJr0rIeczzFMlembgl
         DFvjwGc4UdIlqW8CIeUKUYZxuVPb9QB0swoKL+numLFE7oqkVCo9xSR5+z/rf4PjbBr4
         NmhsRZZCi0IeKtCiuWodVoPrtQS5y7U4tzsCdMz3kN4kd2u7Tfr9IpNjpLf3WA402P/U
         Aet/IxRjJ+qgJDKU92Y3ukDQTIsrrSF24pzrIQDmY0M8Ws11QVs8RGwv+jXubePYEBew
         KKiA==
X-Gm-Message-State: AOAM530bGjAoWHPnGjfDXiYxCYCE4KEMW71uAZg0GMFDFUYP5y+u1USp
        TttO9MlCaOZGzHD5Tie0FymdJFOJ/I898kmxlkHuNQ==
X-Google-Smtp-Source: ABdhPJySXvtS1wt72dlTMaNXkc4ygI3g/9G+dTkz6T/HxF6o7ikX7c/MufNQgXY1U/W7PJiGBF7gwXubMG5akFPdVoI=
X-Received: by 2002:a17:906:b2d7:: with SMTP id cf23mr17037501ejb.113.1598470000611;
 Wed, 26 Aug 2020 12:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200819221956.845195-1-vgoyal@redhat.com> <20200819221956.845195-12-vgoyal@redhat.com>
 <CAJfpegsgHE0MkZLFgE4yrZXO5ThDxCj85-PjizrXPRC2CceT1g@mail.gmail.com>
 <20200826155142.GA1043442@redhat.com> <20200826173408.GA11480@stefanha-x1.localdomain>
 <20200826191711.GF3932@work-vm>
In-Reply-To: <20200826191711.GF3932@work-vm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 26 Aug 2020 21:26:29 +0200
Message-ID: <CAJfpegvqZUXsvbWg8K-xosNR+RVwRm2KH+S9mKs6n6Sv65s+Qg@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] fuse: implement FUSE_INIT map_alignment field
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 9:17 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

> Agreed, because there's not much that the server can do about it if the
> client would like a smaller granularity - the servers granularity might
> be dictated by it's mmap/pagesize/filesystem.  If the client wants a
> larger granularity that's it's choice when it sends the setupmapping
> calls.

What bothers me is that the server now comes with the built in 2MiB
granularity (obviously much larger than actually needed).

What if at some point we'd want to reduce that somewhat in the client?
  Yeah, we can't.   Maybe this is not a kernel problem after all, the
proper thing would be to fix the server to actually send something
meaningful.

Thanks,
Miklos
