Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4672D1449
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgLGPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgLGPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:03:32 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F59C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:02:46 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a16so19934417ejj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y5an9IpqP76fFEfITqq2IfrQNyjf5flDTbngmDsa0e0=;
        b=b0PNzOJCtcJg4O6coaXXwXy4BPnkF0lQigfsuS/Eux90pqnc8vuLYlLzaDrAzL4nw9
         8ur8vzz9e0suu4AP8UKavHCm2e3dUXKMAQ+Tc51lywhBH29uIOzdjn8I/YAVi4lFtrYC
         351Alkx/e3g3OBRpwWukHX2WrZtnbdW6tfqqwu6uU+f0XBu0m7lsi1zFFihHPapOT8wF
         Qo6gxm1kLhBuCb7sPzgKvRtuqZWVaQ5NgRQucwzG7mCRbB7yBBsgF6k5V9j39Kw8JrqL
         HLoOu8mwLaoKlDMHrzCuS69mqtOFzCDk8s/FocrZNzZeRjzGQSfybRgb8G9Zzzvi6swq
         ogOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y5an9IpqP76fFEfITqq2IfrQNyjf5flDTbngmDsa0e0=;
        b=ZmpjlG6zlLP09SEESlKcLwwz5RN5DUplcNwLFxEdtqqvJ4oX8juYmIkmHdGL5cZOGl
         y26kNcNV0nKEovkC9YH4CsOjogTek43z0QkR8P9KG6k3cifI5VzGEVcy+n1LaCjJiIQO
         9snaH9d6HxmOoA2NTBTpsEDO0bykfmwkntskd+NTAGhLBZiFDTJskHHAr38rC4BCkqgl
         8uZaXzOuoy2CHsxDaqyFABwlkNAbgb36XbEhvTEb68tl+fP0wiDl4ctN0VK1oDQXj3tt
         plr5A216Ncmir06Cykp2qjthHj4lMnkiRDRALE/DRG9B1SUHpqKw4twuhED3Gxuyn6ky
         +klA==
X-Gm-Message-State: AOAM530Y5b346TMXiWeCWgPvUkOCHrX31a5Dg+yy/ilWfmL6dqhyVYjO
        LxJqfi22UJKeaAD0mwVhQvsu50TTmPKz0ynDNb6VpQ==
X-Google-Smtp-Source: ABdhPJyjHAk4PRj3OIAv9j3xOZdDWo4qndoe9LdmKf3qEzqcDgfah7gXM5L/AoRSiabQqEhraV7b8RX0+RG4TP2SwEE=
X-Received: by 2002:a17:906:9452:: with SMTP id z18mr19468443ejx.389.1607353365047;
 Mon, 07 Dec 2020 07:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20201207145446.169978-1-colin.king@canonical.com> <afd6edda-460c-8488-6e63-438053e88eac@kernel.dk>
In-Reply-To: <afd6edda-460c-8488-6e63-438053e88eac@kernel.dk>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 7 Dec 2020 16:02:34 +0100
Message-ID: <CAMGffEmKW=wa3_UiJA9+SLKcB0q9WmOMThQwoe0pc9oQQ62phA@mail.gmail.com>
Subject: Re: [PATCH][next] block/rnbd: fix a null pointer dereference on dev->blk_symlink_name
To:     Jens Axboe <axboe@kernel.dk>, Colin King <colin.king@canonical.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/7/20 7:54 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently in the case where dev->blk_symlink_name fails to be allocates
> > the error return path attempts to set an end-of-string character to
> > the unallocated dev->blk_symlink_name causing a null pointer dereference
> > error. Fix this by returning with an explicity ENOMEM error (which also
> > is missing in the original code as was not initialized).
>
> Applied, thanks.

Thanks Colin for the fix, and thanks Jens for taking care of this.

Jack Wang
