Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0D71AB367
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390797AbgDOV2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 17:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729585AbgDOV2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:28:03 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEBEC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:28:02 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l11so3896309lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mkb6wSNoRk1OlC/if/7Kst4oK65lFQ6w8njdJebIWcc=;
        b=qux+Gbm2lAWVYosEyjNgX6Wpr54g07vbWofzCEQWsXItlJNukKjpv4fh+Wa/qEDNTz
         GJvgN/MKUWkh1NP+4BQAyHgHuAUnYmfIg6R77aJAbXDphSr+2KXpWHh8KrrolJr6rj3p
         0PrsR1ladZCNy7TxlOmA6OW1KeEGdLfmVrNMjqadTa8+EDeSVgiTGoujJOpUUUC78PRt
         egbK3z5EDy+QTFnTqLqMcr6sGT9cHiYBKQx0zxu8gXJIutuxYOnCJxLufDRqUe93t7MG
         7YSlUY2KrlQDs2BjWKl+epd5QrL2JlQAvEsVRgqkqKFdIfivDXP8wwISUcurl1AmXg3d
         sNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkb6wSNoRk1OlC/if/7Kst4oK65lFQ6w8njdJebIWcc=;
        b=Sz9Oec/4IyKET7xv/WKOfS15Xjnjk5faOj5RqNcRcvYwwPjc8hQ/EXd5ZLaQF8005k
         sTjPjBfMeW2bqOFgBTtDKNSfPPI+yUARaJFcLLKs7w5l5AHcrWc9vPNsRzFmEQoCjcY0
         QXuhG81pb9A5mb2bw5Pge0Kb+gTls/K7VKQFOC93LsvvSJqquO1JnWZOOGIlXqrVWPj/
         9WXKZf72K3x0D+92TWo5QIYn361jKcLpsRUCc33zV1KRtFC1HpFetv1HmXGQVgCLAoSn
         QuVHQmTVFpxQsGyZSAQttfT4IZpRooto/hktTygrzv33dRia0peLzsB7rKxl7P9s3ImF
         iGPw==
X-Gm-Message-State: AGi0PuYQp0Kw2J9GDhJQGr5fYW366oFYqujWUXFu8CP9NK0suhnHb1x7
        K6SlikPuaXTo1dWsX8bskh6IzZV8RSI3DrpHcS1a6Q==
X-Google-Smtp-Source: APiQypIepQnzV5Bfn7cf8bAwx0BpkpxyfPDAlFI7U8s810COu4MBHoFRESFus27Kqr6HelOuxibh6jPClEFo5LlrBj0=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr4084748lfa.194.1586986080980;
 Wed, 15 Apr 2020 14:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200306132505.8D3B88030795@mail.baikalelectronics.ru>
In-Reply-To: <20200306132505.8D3B88030795@mail.baikalelectronics.ru>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Apr 2020 23:27:49 +0200
Message-ID: <CACRpkda3YpCxVii1r5F-q=b_Eh7ixbtprWykUH7xPDxPZR0gwQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] gpio: dwapb: Fix reference clocks usage
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have applied the v3 version of the patch set after some tinkering
with the b4 tool.

For some reason some patches are missing in my inbox and also
on som mailing lists, they are not in my spamfolder even.

Anyways with some help from Konstantin I managed to get the
series out using the b4 tool and applied it.

Thanks!
Linus Walleij
