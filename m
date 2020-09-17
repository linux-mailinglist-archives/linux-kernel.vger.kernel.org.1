Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165BD26E173
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgIQQ60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 12:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgIQQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 12:57:12 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2E9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:57:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id q4so2973099ils.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bC1NcC/3gidYXCraT60Gha0Mskxal5CIrv7vcfFm264=;
        b=sog7KaMBpFzPZ3X+j8JIxEP8Br4VuN/7bbEbqQ6pgKnWfUg+mphsD4ykMF4p7N3xE8
         TX0oRzojfHz/tkwzrqGaB7cov2rrVWj2cohzLfxXJDhqs+ssiTrawp2cR6AEnJsPajFG
         CFABejwOXs0LhY7rdRnP0BnlzMHQUYisOPHVt65NAUJ3BmKxMjWhbkwDZizccHNP6L2C
         9xYX5X+OpIs14f7hv0Bqi0nyH0wteb/H4IVY6mdi40+uaB5h1ZheE9z5SIt7mB1GSx6r
         bBzDe163r5aQwI6dLgMKAx+oQzdCjhVkAR/H4W2QypVb/Y/82/YiwrKBPmO+1aZWV6XD
         BpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bC1NcC/3gidYXCraT60Gha0Mskxal5CIrv7vcfFm264=;
        b=ZNlUcJDP0tb62AkPSWpYMK6VMKO3HNViVr6EQM5ICWiQdoNlMb6cd4YZl4ib7G6X6y
         YIi4bX13HUOTDcy52+Yb/TzEO6Vp+UV6ucqp/k6S64IURCvZeWvS0rzTAVm+Rrnu1Vxr
         wB7pLA3s0EQ8KxG1+pSM0wxZnN3GzvuwfPM6r12VxTx+AxQmERrrbN1DoQiF/IxkQq8N
         OIC3zcDzXDyRsn1vzSrK0ZQdDoQnAuzXGBSKAv4s0jCxUVCs9e9x6g/LvvtUWDF+Eb57
         k06zzfEyA8A7/RC4NmBTVCpbj1WhAh+0mgoTer10YbWzAl7PpElyS1Q+ErNQ3CYhOIJ6
         Dhcg==
X-Gm-Message-State: AOAM530QyF0MODhg9n3GxcyTkj7bEHtJOMXJ1RGTFDE+k0hFMnsywAA5
        hXYIfDuud/JUqwvY5rFtP65zEKc0uglsDjCiTjg=
X-Google-Smtp-Source: ABdhPJzryqIcyg4u45DMs3RqBmJvDVkP+yaW9gZAShRD12e7AUM84+dryjgpeBwIQ5GY9XEXjTPw9YMBgpWVWQlmR+w=
X-Received: by 2002:a05:6e02:c07:: with SMTP id d7mr26971412ile.301.1600361830153;
 Thu, 17 Sep 2020 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153648.5475-1-ztong0001@gmail.com> <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 17 Sep 2020 12:56:59 -0400
Message-ID: <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command_id in CQE is writable by NVMe controller, driver should
check its sanity before using it.
- Tong

On Wed, Sep 16, 2020 at 12:54 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Wed, Sep 16, 2020 at 11:36:49AM -0400, Tong Zhang wrote:
> > @@ -960,6 +960,8 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
> >       }
> >
> >       req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
> > +     if (!req)
> > +             return;
>
> As I mentioned before, blk_mq_tag_to_rq() returns NULL if the tag
> exceeds the depth. We already verify the tag prior to calling this
> function, so what's the real root cause for how we're winding up with
> NULL here? I'm only asking this because it sounds like there's a bug
> somewhere else and this change is masking over it.
>
>
> >       trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
> >       if (!nvme_try_complete_req(req, cqe->status, cqe->result))
> >               nvme_pci_complete_rq(req);
