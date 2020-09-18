Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3A26EA1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIRApQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgIRApK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:45:10 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFD0C061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:45:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z13so4734216iom.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 17:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e4G74ayMYYm8alkLYYmxH5Uc6z5TXOik34xjtBhvtLM=;
        b=J1QMh/1DktBhJdqjoXuxY3tyon15N3kc1z8ngxb5e/y1Z0pWANPU7Bx7uxQgLhZ1Q9
         wwkoGQOQ0FE3gF4jZQfFy5ywK4bLNJfCRdw2p3h6CDy2bxUNATRhwWSasY/9tJjxXGEP
         S5+ai3a8KkHhphKkpN/iU4UqHR0nywadXaTkv757v42pFUk0VK93zsraPmdmiCwyTRsH
         aHrgk2QrUdHcYL5kWsUfFVvO5Q+y+v0wfKvi9Y2/A+G5BHd350+iabu1ztvnZZYfvaJJ
         h1VJMWmzNORhkFwNls0qARP57lbPiBse3i4gLLMkZFRn1tFU9cC/9tiSCIxn9sStvsPP
         +hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e4G74ayMYYm8alkLYYmxH5Uc6z5TXOik34xjtBhvtLM=;
        b=Z99dKHhRsmHByRl/SIZHWEo9Q+cuGxzqu1oQwdeEHvwxi5LHyP34IPLPMiTQxs4hkK
         DpoKDe4DjAtPj5ijUp93G7kxK3BdnjzIl2kNs1XmtJyR+XwH2rlxk26R64izAuHt3GVt
         +rQnuSpdOa7ShXXjzh0Y1l+NhB4FHkwZQVCiRl7UrYpemXWX/g0xANsmmLdzWpne478H
         sE+T0ZU4RhhRWMmsqC5RSXJnGLLJd9+k/Csp/F7EbkbAMpk9IDsUG+drMsfHW1IB6M0q
         LEvX6P4CZcWQfoZA3QwHhs7YHj7vCtTE+j0ol9HW5Vwzx92hrF2TEDoQ6koFw+5aEmhQ
         /qKQ==
X-Gm-Message-State: AOAM533viMi1LiVIC873EvIyyCWEjITw3Y5ykJErGRZcPAfyP9Xl7sLA
        x0nOebF9RKEL9LeSBB7swDH4TuxIU4E1bF7sPYnoiFDfkOI=
X-Google-Smtp-Source: ABdhPJwanZJw1WRBbyHvHyiYFr5PUCc2D56a5CUrtsyhpRF0XY0IgkY/0bUSD/Sh0RBXfH9dZPXjR9Tbvbi8SqHbmb8=
X-Received: by 2002:a05:6602:154e:: with SMTP id h14mr25664671iow.17.1600389909156;
 Thu, 17 Sep 2020 17:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153648.5475-1-ztong0001@gmail.com> <20200916165433.GA3675881@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4B-KpRvFuf+5YR4iOqNzic=fuYm=_seqwLoLp9+_xOqdA@mail.gmail.com> <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200917171437.GB3766534@dhcp-10-100-145-180.wdl.wdc.com>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Thu, 17 Sep 2020 20:44:58 -0400
Message-ID: <CAA5qM4Bj3BqYt-J=YqWKMWLFxDaMwQa4qAqPibyikpX5FBSzRQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix NULL pointer dereference
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm..Yeah.. I see your point.
I was naivly thinking the command_id was the culprit.

On Thu, Sep 17, 2020 at 1:14 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Sep 17, 2020 at 12:56:59PM -0400, Tong Zhang wrote:
> > The command_id in CQE is writable by NVMe controller, driver should
> > check its sanity before using it.
>
> We already do that.
