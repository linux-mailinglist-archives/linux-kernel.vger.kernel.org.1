Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0AE2FC295
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbhASVhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbhASVf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:35:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E54C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:34:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id m5so761785pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2tJFhFmEki0cmEwMWsS+zMP0KdbFiK5Gaw2t/H2Lbiw=;
        b=TD0v0a79x0XHb4dVqFE7RvlyuQIwC35CHmRKXf/R0J0ZziICD9BHGu4Z1ABmY3SISV
         UUVhQyqxBXsc82gKuMb5lKlBJkKM5YGfR4DAfXJnBj95ty3Sk5r87KFcHpaB6RMyEfjv
         PJfH7jcmsKuWV8QS6gukq3vl46o7ldKWVB39JlpFsjiODa+CHyJrOOrY7/N/jyWcYPMw
         r6lC7/RpUMhjiopYg8FZ7pLi1gWEkYjxwnbn+xrcCVe+TV0sI7pVZnd4Q20ctCy0UM+Z
         wjFHu6+3dsrv2FoeVavM1/AaFZacuza7YZHh1cOnUihTi1b2LwqLquyPA/km5w0ZV5OU
         Qkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2tJFhFmEki0cmEwMWsS+zMP0KdbFiK5Gaw2t/H2Lbiw=;
        b=pLe0pKhmO4505CScDkGLF2h6g6oqLZECcD420go28HFte1J/jYGwPhAtFSnu48tlSB
         jyE7T2Iwr+zA+WngAL4MuZLtj9umHtbm/ouBmqC+Cujt9W8KO4rLyqZLzeC0hh1AV4ag
         cxNHuLnkUTLjrgiM9JQCGPIUhlqkTU5+eyhG06VS9ARSD0zm6viKh68eiAnuD3orvX3u
         LJ9iOTDP2mJhrIXZ+xO5RkV9JHqYwqHy0go2pTPwUi11MMRlFa29vGL8MmT8A2dG/YAL
         E9C4Si6XFgGqeUPvILvQEhY3iBh/+oA07VGcuZXomGm18FRPSoGLq1G2H+p/cWJpcmE1
         bbHQ==
X-Gm-Message-State: AOAM532p66kAkut4VWQLVN1BqQxuHR4JC0d4PMJRgvT+09v250utCYtP
        jpXfxykCSQkerzpcqvpfyWM2gzaqg5Da4Q==
X-Google-Smtp-Source: ABdhPJx9l1hC3buN+HCmBXCFnwRv5xOWWVkLkGZhPH4WWBjq1jpLOdkXoQE2qZqEgEkc1fq3hp2fRw==
X-Received: by 2002:a17:902:9686:b029:dc:3372:6e14 with SMTP id n6-20020a1709029686b02900dc33726e14mr6697310plp.24.1611092087633;
        Tue, 19 Jan 2021 13:34:47 -0800 (PST)
Received: from localhost (g238.115-65-210.ppp.wakwak.ne.jp. [115.65.210.238])
        by smtp.gmail.com with ESMTPSA id d19sm4069630pjw.37.2021.01.19.13.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 13:34:46 -0800 (PST)
Date:   Wed, 20 Jan 2021 06:34:44 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] drivers/soc/litex: Add restart handler
Message-ID: <20210119213444.GL2002709@lianli.shorne-pla.net>
References: <20210119080938.1832733-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119080938.1832733-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 09:09:38AM +0100, Geert Uytterhoeven wrote:
> Let the LiteX SoC Controller register a restart handler, which resets
> the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, this looks good to me, queued to my linux-next branch.

-Stafford

> @@ -66,8 +71,19 @@ static int litex_check_csr_access(void __iomem *reg_addr)
>  
>  struct litex_soc_ctrl_device {
>  	void __iomem *base;
> +	struct notifier_block reset_nb;
>  };
>  
> +static int litex_reset_handler(struct notifier_block *this, unsigned long mode,
> +			       void *cmd)
> +{
> +	struct litex_soc_ctrl_device *soc_ctrl_dev =
> +		container_of(this, struct litex_soc_ctrl_device, reset_nb);

Nice.

> +	litex_write32(soc_ctrl_dev->base + RESET_REG_OFF, RESET_REG_VALUE);
> +	return NOTIFY_DONE;
> +}
> +

