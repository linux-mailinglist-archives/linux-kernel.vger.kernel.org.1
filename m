Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9502E7D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 01:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgLaAVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 19:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgLaAVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 19:21:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FA4C061573;
        Wed, 30 Dec 2020 16:21:03 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id q22so23816461eja.2;
        Wed, 30 Dec 2020 16:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BUPikVF2YhEEKQI5Y2qiZcki+hY/VRakhQdbEx50LzY=;
        b=eCfTfvnTSoETeoHWDtlPFBxXiFMqw5JyKtkKrysmrUVQZ/z6d6a68qEeVM2gJ0d2Ec
         E3ekMZFUmWM9e0d3vypsF7LsLbyLNfkoDpYpRXqwUjjPY03cZH/OwBOLC29GW/p2PlGR
         DJPTyHZsd3WO/5b7R4nYGizIEiOFN6QHIbRJfaWV/bj7vUw/lYmQnnEr8WSUyfyuwxRR
         xqEVvKb78sd0cU+m7jGAJ4s0EukY1JzsYhNWbJzXqGdujJzYG5fprZOvWVfcBuMZbLXT
         tGGH6jGEKpetHjLt4Xw27vG5dsOiF8/z7U/VSUkcpV0HAR0vxDbXxsFRNVAC8Z3jSk0S
         /7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BUPikVF2YhEEKQI5Y2qiZcki+hY/VRakhQdbEx50LzY=;
        b=Cwdph6Uxh2U1a71TG4zRXxlo4DlJpJiSkqZSdomPye/8WyAMmHF333KjjsVT+nmIfx
         SeMIvM7AxWQvsgiYfdiHaibAhfTT5MJnRrJ60FBNf52h0oDM/+xZNqWZ3Prv7D1j+w85
         Lz31Y4iYGwe0YVM67+dl6CnoCHtcmc1mgFS5xXald8GsJ3L9mFv9qdAnnPGf1CiDw9NA
         ERbDxs0WoOl3EoyaHaVM3C1dsNqKh7N8V0J0D5x61x9zVy824KDbs4XbFd4Rn0CDrmkd
         6/uNc1bmxrE1cV2Zi096+yQvjscGGItOWRiRAccSLbUeCZOgzF+rIOF5ZbR85uRHLozw
         ZUpA==
X-Gm-Message-State: AOAM530aahZ++glG2F8VHt9+oOu7qfICkBAe+nvVc56z50QDgqPlP7n4
        tJFpzc2+25R/SK8OJiJJ623WUI1cPK+BdGKsWAw=
X-Google-Smtp-Source: ABdhPJwPCA51yecoVh1NsrourKwLdniqdG8nHLj2lo69ygPJMIxAVscbGV6Z8ZEgziKSsvpIRq8AzfyWFG5HoYvhEG8=
X-Received: by 2002:a17:906:4050:: with SMTP id y16mr49858880ejj.537.1609374062329;
 Wed, 30 Dec 2020 16:21:02 -0800 (PST)
MIME-Version: 1.0
References: <20201230103729.2272-1-christianshewitt@gmail.com> <20201230103729.2272-2-christianshewitt@gmail.com>
In-Reply-To: <20201230103729.2272-2-christianshewitt@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 31 Dec 2020 01:20:51 +0100
Message-ID: <CAFBinCA91_wZ9r9v2HyvU0sX2smYdsijECim94WjRwpqu1qP4A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add support for the
 Beelink GS-King-X
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 11:38 AM Christian Hewitt
<christianshewitt@gmail.com> wrote:
>
> The Shenzen AZW (Beelink) GS-King-X is based on the Amlogic W400 reference
> board with an S922X-H chip.
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
