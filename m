Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FE728AED3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgJLHML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:12:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44722 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgJLHML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:12:11 -0400
Received: by mail-ed1-f65.google.com with SMTP id t20so9489963edr.11;
        Mon, 12 Oct 2020 00:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ht7VpNylzjockp9tJz3zTL+kmNFrrXctjwfHcctC64U=;
        b=evNB5RJPG/++F+iQeoFFpul7jiJqlMWWIEM9A3HXo7IXXLdH4+lbwsTg8jghIY5ot5
         XAyOC+Njoj3aOjm77UUEWC7s+9+0BZfGHdD9+h9t2BbSgxg6dUz05IsW5keKsaZSggjn
         vExiWLpg8BHSULCj8+xDILGPa/lVm8T+KtPnv/xZoKl3BAEmYdxnEtLxxpZIT8xyFKTT
         wb0tUGw7aCenxk+lBb7J5z88IksSlSENxSSw1+4+RgZR1ntLQko2IrFgUeBn7gIeavts
         8mAY5P6qUPK8vRjxg7+ioSweSIXMBaUaNLeoz21ZlnpHXcG35CRoPVeqZin8EMsbb+T5
         OlRQ==
X-Gm-Message-State: AOAM531q3/cR3RkuoVMqsYNHOiYsZFtKXwv8Eo51QQtu/5SLnn6oKBTh
        GMeasjEWCAmEE+NOCDDP7rN2qM4Imyg=
X-Google-Smtp-Source: ABdhPJzI62qIebLAAP/M6A/x67uaLeY0i5ld2+CqEZE+bj6EMN+jwsvz8tiFPjMpObSPCipIyIo7Gw==
X-Received: by 2002:aa7:d1cc:: with SMTP id g12mr12789144edp.195.1602486729006;
        Mon, 12 Oct 2020 00:12:09 -0700 (PDT)
Received: from pi3 ([194.230.155.215])
        by smtp.googlemail.com with ESMTPSA id le12sm10257077ejb.1.2020.10.12.00.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:12:08 -0700 (PDT)
Date:   Mon, 12 Oct 2020 09:12:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] ASoC: samsung: snow: use semicolons rather than
 commas to separate statements
Message-ID: <20201012071205.GA1822@pi3>
References: <1602407979-29038-1-git-send-email-Julia.Lawall@inria.fr>
 <1602407979-29038-7-git-send-email-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1602407979-29038-7-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 11:19:37AM +0200, Julia Lawall wrote:
> Replace commas with semicolons.  What is done is essentially described by
> the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):
> 
> // <smpl>
> @@ expression e1,e2; @@
> e1
> -,
> +;
> e2
> ... when any
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  sound/soc/samsung/snow.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
