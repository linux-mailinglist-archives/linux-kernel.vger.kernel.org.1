Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5D22F640A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbhANPO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbhANPO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:14:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EA9C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:13:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a12so6120128wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVLo5BPEqp+ye9g7cufxibCuaIAS/DGP9Yi79MJe9kY=;
        b=won0B5uHrjcqRlYjUBBkQbM3sbSz2hhH2cmVKpt4Ejx9JxdBRVg6pImH5f443q5HOh
         78JEtbonxLP52mtFifp+IFC3Tg6fLsmPrf2ENbLTvxWeydvjHc81pIIznh5QL8MyioVs
         esT8hqXtDMpc/g1jAwtv7aClyIwCN0yEgTyNO5K2a+4veWHrb61A0rq4AaUkLeWflNiT
         zPpdqqHPLGtVNFTw0s4I1HJJcV1178Z4Rcb6qlscDcLRu4XaiiLMzghdoKq54bH8Mcf9
         CCDsDzVdyyBCrfNofVJNVAJc4l8PXU6JPEjY/u032Sdsc6URYYQQvTMg5RZj464ZOOFp
         gJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVLo5BPEqp+ye9g7cufxibCuaIAS/DGP9Yi79MJe9kY=;
        b=C6TDtMvm1pSsFaHKrdd34D6bXuR4Q45LnKXZQrEWlsrDJMQzhYhO809Sa3cbWmlOaZ
         HVUcnj0MHAxT0aLEvDAS9GZnVTfOk3NAjkCgW/nNF/yJwehki+AY0/b4gIOjzL517ayL
         JpkFCAES/a3qGdtRXDxm+PpGihgRzngNt1yBeMtuIzlU3qdht4Tjo3V+QvOmRDObsmfK
         Kbyvgu41GeaS1IwovcZDj2TSxh7ptRmxwPH/Fav6BD3Dc4BorB1F19Obe5zPQyrJnb/P
         EORTXS1HRoy02xL3QgbC2Po7IGIBgjQ0V5CHsdXZzH8NasggsF2lB+zaaDT44iTfmDnq
         9jWA==
X-Gm-Message-State: AOAM533Uf6PR86dMqfBRFr7GAVCrI++cPr8iUb8lHAyPotHVVVpzMpBR
        3swyzhLlBdws+CNdMOmd/1CJ4JVo1zV54DiWnc8B2LtgpBZd3A==
X-Google-Smtp-Source: ABdhPJxIkBqRfL1TF0JHl+rSbpZvhnN+YU5tGFaa2jlCW3niHYNg6rtHJ77oUw71r3ViG1agFniqfvEOa37mjrVCYbw=
X-Received: by 2002:adf:a388:: with SMTP id l8mr8389014wrb.354.1610637225415;
 Thu, 14 Jan 2021 07:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com> <20210107025731.226017-7-warthog618@gmail.com>
In-Reply-To: <20210107025731.226017-7-warthog618@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 14 Jan 2021 16:13:34 +0100
Message-ID: <CAMpxmJUv4mQXDVY6cVPTFTK02i9LTH-eiWTPMGTyrdAcNM3n4g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] selftests: gpio: port to GPIO uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 3:59 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> Add a port to the GPIO uAPI v2 interface and make it the default.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
