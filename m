Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D544293D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407397AbgJTNXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406939AbgJTNXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:23:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7FDC0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:23:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so2076134lfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YOStyH/7LuatejjFDX2j2ehpEVwT4LckE9LJLX9gUUQ=;
        b=uB/FJSNOYhS3S8jPYL+7qgt2xhtyebbRsTieLjA3ZpFVNj5QvWgcYpE23lbGdj5YUu
         xi5Tye6w8MY5qq4xss3oy53fDj9NdTOaq+K+vyGy+qC4XN22/2shDP1uWJIIQn8jeNmR
         F67LVO4zmM+UCOwXGQtPLVLc17oEJcQYxPQPTWCT2rlaUmbGQJMAQeNFZ6Tks0k23coR
         uXPdvCwo3iOeWBNcUIjcWRhRR+vxRgLrhMooW3XrTkODH26F4VReK6jdn7vAJMGaqx1J
         UszwA+rzC0gyC064jfmy1+Um3u+ylyvFye1Vyefbm2W0M2h0ADkYVGSuFyfHSfzqrWJq
         0NIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YOStyH/7LuatejjFDX2j2ehpEVwT4LckE9LJLX9gUUQ=;
        b=DXbiC4K50yexZJopZxHQ6j9pf48Q/V4A6P5V05BFdLX1/tqhwri0nzX9P35Lkve/qe
         Ej+t3XxexAf3UMrQ7hVoTyinv3wkM4nLbnKsMkgx1yCIvf1FX4kty6JsYGG+tOCbKICJ
         pN8Wv3nHMUmWWS1VJETmTm4gd5w78+mU7/b0PG1bAfiqVSNze+oLcpLwBjbb1fgrbw1Z
         Q6atnIMR5kl6q38R6oFGbeMdo4gqkks1oM8axr7cbWYO3HfzUekLEJb7bmesBXdEfHK2
         gTD+4P6bx+Opd4g/dsGPguNxXsS7c4lnquWU3HbuLak82XsYTD8IeKTWexyWpGHUhnRZ
         52CA==
X-Gm-Message-State: AOAM533w3xk+6Tt1REs8Bf1lvAy6sRR7AJdFA91FUYl2AduKmmwfWY2X
        FdLGjihDkMwGbCc+ycGt82fDVMgfv+P63y1ywolYFw==
X-Google-Smtp-Source: ABdhPJzPznNapkqemojFnILkXX7OUt5oTt6d2sBb3JZu/G5I1LLzfHt8+HHjGDSLE4PWGLbE/3TBZ8Va7tqZImbCJC0=
X-Received: by 2002:a19:191:: with SMTP id 139mr870209lfb.502.1603200191514;
 Tue, 20 Oct 2020 06:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201019190249.7825-1-trix@redhat.com>
In-Reply-To: <20201019190249.7825-1-trix@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Oct 2020 15:23:00 +0200
Message-ID: <CACRpkdb73_05OYb8Wu68+uw=p1edbnCfCSXOYL0fvDB2F=zL-Q@mail.gmail.com>
Subject: Re: [PATCH] pci: remove unneeded break
To:     trix@redhat.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 9:03 PM <trix@redhat.com> wrote:

> From: Tom Rix <trix@redhat.com>
>
> A break is not needed if it is preceded by a return
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
