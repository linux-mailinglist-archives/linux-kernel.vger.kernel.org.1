Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9432CC6F9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbgLBTtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbgLBTtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:49:06 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27989C0613CF;
        Wed,  2 Dec 2020 11:48:26 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id p21so968632pjv.0;
        Wed, 02 Dec 2020 11:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dnQQ0ZO/6p33z1swbZoImrPF097nMjWL47oIMo++/1Y=;
        b=onJj8ipStbxkxO1WMW4vx6wNj6v6na0K0VYBNmFQ/TgoUyd1X+QuhKWOM9Q2hUY4uH
         PI37PA+QRy74rDEnFaGWxAzDOBo/WwymM51gZXXQOIeAvykEhSD9kByS6NDbeDQOB0gB
         dlSeHl0n0tNFnc/5e9QnxMwqAgMeviGwIfyu1tYVbluA5Ss8u/LWXKPoAaERlFD6mzv6
         y0iRo9mnNUd1x93YRZ/L1vC1OMPIef0qOKvWcNYnRo7seGzgbAUkxIabKOFy7bf+dKKu
         reBPVovWJfqqzr4y5seDB6W6wi5zyl6DyaNJ9ZUbn3blZQP7AEpNJYLMolGv8hzQiGdQ
         UItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dnQQ0ZO/6p33z1swbZoImrPF097nMjWL47oIMo++/1Y=;
        b=jTnf/r68TCZsuXXLjP2BMUWTlJypXsZlkkyu0WVPRj0+ayJX2RHVE3mGzAMlZJhL0h
         Wcayuo3UdezPJe41Ly3GsoqG2WSil/fsjPz8nQCvx+Xk/JLptqVEk3iUlCtfDYzgdpsA
         6JFB1p5NDXa39CmO7KwUh0P6F0vBXe7wHXv0DDiWK+nryalbtGxmSCH73V60UYgUvkU7
         jOdT1ejKW/JYYUlhZAqCY1U84E06irRO5MQ/HnOGLo9kkqbUbHaP7GQvzwrmyHB4rtC3
         fbKs/ST6WF1rc6ogj4lrmZ8p0Cs1dfWBv8gGpVAYWl0SFKRy/6ccDVYi60dw4DvylYLF
         g59Q==
X-Gm-Message-State: AOAM530iD5PhC+i8Qeb1Rk/rM0a5RktvaMht6bxqHYyWoOsl0n1Mhkzz
        oiqiOGVW/bvJt3etI+Xpcfo=
X-Google-Smtp-Source: ABdhPJynOsl/9mtFMTtbS3krXbaXRE8MqaHaMr7m3r88/8eYsCbneJHJzz+ir6n8gXwRYSd8V2dkSg==
X-Received: by 2002:a17:902:ee53:b029:da:4c68:2795 with SMTP id 19-20020a170902ee53b02900da4c682795mr4119802plo.7.1606938505659;
        Wed, 02 Dec 2020 11:48:25 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i10sm547720pfk.206.2020.12.02.11.48.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 11:48:25 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:45:31 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Add support for si476x codec
Message-ID: <20201202194530.GA1498@Asurada-Nvidia>
References: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:57:47AM +0800, Shengjiu Wang wrote:
> The si476x codec is used for FM radio function on i.MX6
> auto board, it only supports recording function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
