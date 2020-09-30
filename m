Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D80527F3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgI3VLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgI3VLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:11:13 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB32C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:11:11 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a3so4107650ejy.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NOk8c2APRYC30UPRAFHZ43REyMt6GV6fXQhIWNvFDgg=;
        b=FabrGy9IuFyWiliExAguoclEsEauU9gRTELnKIQdlsOf7hvYSfdm63GTuSTenjuRMC
         6x6UyqUApJsDpzU+yIAkGQNXLz3NDAgTLSdgQ0RnT20pbrD5HDjaI7lGsyG+ppEematD
         1+THko9mee0t3jZqlvW5BSuIezwc8yKbqq5FQmYsT/c+LGiYv/LI+sjJroX2uYcqlNFu
         reSCo1poeCyGdLu3UV1Q0/MWR/V0wbfHmJhwiwnp/X3WDzVerDpWyvx7kFj/uhqbtYHK
         dYlp9IUIRSkS47SHRHOII4ixUHwLw89dY1zBK4Xid1AA/s0goko7oK8VHmj1uvjyJA+F
         Wntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NOk8c2APRYC30UPRAFHZ43REyMt6GV6fXQhIWNvFDgg=;
        b=SkCYEr+iyJ8PwFYHCbY94VCARs/7jInJyTzkyygnY7wmm0w4CfDEnkQi4rdNjs5TjW
         WRdDlxhDzi2vkJGz6oo7+eZiX8TZFfuRpCQF7yB53I09oro/iQeV99HbFG9rvuIUc8oY
         BbcM6RF2EAdW5YUOt1fOZZ737Zk5RfX+yDzSaUZHF0cCAezeWvVGJh87Jat01j1MhfJ/
         Lnd8NilkvBeOUVdZriK2DIvVrstcelU+WBQBw7yIuAjfVip51KCJ3lEGTuoJtlnZ1tsW
         qpKeMcXWyZDwYlD8LpFB9WhDoprkxKKa6z/V1c9R28YBSV5f3vWU5HDbHfWZ4L4cdTAy
         134A==
X-Gm-Message-State: AOAM5325/LH0SfOpyOMxw+KXvO5SiBBFQqslX3pcxd79PCT0wXw8TIY3
        1Quiqn5xlB0T5HcLppkg+5ZoDVMl8FzZsEBzgtSUjQ==
X-Google-Smtp-Source: ABdhPJxQsB31I9zoUXjTlYNVI1WvPMwYEGQGlHAwZDAxOzXWh7mtbCLtKvFkHMJYFECJN4PKTpunKW9XxNtEYYlph/E=
X-Received: by 2002:a17:906:c447:: with SMTP id ck7mr4739798ejb.358.1601500269817;
 Wed, 30 Sep 2020 14:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200930210824.GA12277@embeddedor>
In-Reply-To: <20200930210824.GA12277@embeddedor>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Sep 2020 23:10:43 +0200
Message-ID: <CAG48ez3X3aZwfde3_2Sc+gdtUGRHfzan6oNFiffAvNzFDSsFDw@mail.gmail.com>
Subject: Re: [PATCH][next] mtd: rawnand: Replace one-element array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:02 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use =E2=80=9Cflexible array members=E2=80=9D[1] for these c=
ases. The older
> style of one-element or zero-length arrays should no longer be used[2].

But this is not such a case, right? Isn't this a true fixed-size
array? It sounds like you're just changing it because it
pattern-matched on "array of length 1 at the end of a struct".

> Refactor the code according to the use of a flexible-array member
> instead of a one-element array. Also, make use of the struct_size()
> helper to calculate the size of the allocation for _nand_. In order
> to keep the code as maintainable as possible and to keep _cs_ as an
> array, add a new macro CS_N to aid in the allocation size calculation,
> in case there is a need for more Chip Select IDs in the future. In the
> meantime, the macro is set to 1. This also avoids having to use a magic
> number '1' as the last argument for struct_size().
[...]
> diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/teg=
ra_nand.c
[...]
> +/* Number of Chip Selects. Currently, only one. */
> +#define CS_N                   1
> +
>  struct tegra_nand_controller {
>         struct nand_controller controller;
>         struct device *dev;
> @@ -183,7 +186,7 @@ struct tegra_nand_chip {
>         u32 config;
>         u32 config_ecc;
>         u32 bch_config;
> -       int cs[1];
> +       int cs[];
>  };
[...]
