Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73B326E6E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIQUr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQUr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:47:59 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:47:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v123so3755753qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lCEuifrXNBJR2RXDLzYRqd6rWThqodFNE/B/8/e6FCo=;
        b=BMvJaOE08sKp4cbKESDzN+KbtJLb332vgYme/GXpRWM9fJ8lUZOfV5N2S34Aq/0QgH
         J91ZnVOZutDuH79jmUBOzo4u6GxuYMx3wMXqGbXquddg6njn6ccgVMGgmhtwTVywQBEs
         6X0l7NiuZEsY1CMb6AksOE5RIlF2hD8cstBg5RW/jEMujVAmqR/SZCMqyEO77C4SEzNF
         sBvMLty/k+Vpi0fqKANyu8vsRbHDmZCETNFneJp5e6Txs0KodavGWxQVumx4nHpumfkF
         FXN4QXE9hjXEL32Ag9mf2TtlvA6T0WQm19g8d2ZlSFurFehskaJeb6teX9oDi7xnn+cB
         kpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lCEuifrXNBJR2RXDLzYRqd6rWThqodFNE/B/8/e6FCo=;
        b=mht2CBVDIfbcnRAGnMHbETB9CSg1KON1JSHRHdA0xe02j75A6qsgRSn4YBjk9HEjzX
         yOAwyo7yCqdY5TNL5V6BBpgvir2dLR2aEUjBTNlFF2sK3p8skO8XU55PXdmF5xjGe9yA
         aKwIM7zUihg4igJH12OA9kWjiaR0pjC9wXM77Z1Jo00FZSqpmbOGMvu+rZHWmUYxiEtD
         HiEn4CJiNsm1Uy7zDDeRcnQfPkr1FlXf5CBfwbOqBQsR02cJ+4KO8PFc0HUwzZgcVPHZ
         QJkO6UG88n3RVkZ6dTcImtip+aTKd+4CDB2WjbMleahBN4O99SWQXtxwcWEuuY6hXJ8A
         thwA==
X-Gm-Message-State: AOAM533fVcPgUJurAHxOOUvafMZ8ksU2/YLKwwrmNmARLv9Y04LxqX43
        CMGgO54o4my4mgn6Met9cGhXAnht9imaSlpA2fE=
X-Google-Smtp-Source: ABdhPJyPa/1PhZFqqEdeyHeSrDNSBkFT9T8g9ywxA6fcNWSTba8ZEtigVY3KkbI52SDeiZMdFsaJE+YwXTglAj6k9Qw=
X-Received: by 2002:ae9:eb42:: with SMTP id b63mr29547439qkg.106.1600375678460;
 Thu, 17 Sep 2020 13:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091037.3794172-1-chengzhihao1@huawei.com>
 <CAFLxGvxA9pw8D6Q8GbBD0SUP+EHhOsZmRMSPxrW4sq0gYi9N9Q@mail.gmail.com> <b82cd435-437d-e384-c95e-a7e031559c7e@huawei.com>
In-Reply-To: <b82cd435-437d-e384-c95e-a7e031559c7e@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 17 Sep 2020 22:47:46 +0200
Message-ID: <CAFLxGvxXE_jb7nGMn9XOzaFb6SELspQ2Dvdc7zs5i5G8XK3UfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ubifs: xattr: Fix some potential memory leaks while
 iterating entries
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 5:25 AM Zhihao Cheng <chengzhihao1@huawei.com> wrot=
e:
> =E5=9C=A8 2020/9/14 3:08, Richard Weinberger =E5=86=99=E9=81=93:
> > On Mon, Jun 1, 2020 at 11:11 AM Zhihao Cheng <chengzhihao1@huawei.com> =
wrote:
> The kill_xattrs process is more intuitive without the pxent. However,
> the release process for the memory (stores xent->name) is similar to
> 'pxent'. If you think it's better than v1, I will send v2.

You are right. We don't gain much. So I'll take v1.
Thanks a lot for fixing!

--=20
Thanks,
//richard
