Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77322819A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 16:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgGUOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGUOEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:04:46 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4D0C0619DA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:04:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so24217038ljl.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtktXB94UoE1zwpGw4L7DaOAMB9VthZKcyfMWewtchM=;
        b=yLLccylqygcGxLogT7uDUU7Zoo5Gf+rgoWnJxkrvtrNuUUC2Rm99zffl7dgXLUcsxV
         JUsR4Mi/ot+fvK33v6Uu9vN0B0j5hKnXMEescl1VOpltOAT9W+Gc7AkhEo0n8b2nQ3N9
         d/+3tCKJOzeU0p9NOt2e8P3KvgBHGGWOMJu6pZa/vhd+Kz+Aay2PlVhVJ3TIu9jZxoPC
         r0KQv2Q360/8fCEcxHhs7RkvZv/6qZQ6+getRlZ//wMfZEIDwVEjPXekSUXa5CcHoapM
         VtDgPKHLENtTXQEZU/5R51RZaY8KybsI0FcI9GKc9mCGpjhucIPruaTfi5edb2oyHwpN
         f/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtktXB94UoE1zwpGw4L7DaOAMB9VthZKcyfMWewtchM=;
        b=LEMsD5vph3H5GUUCSJ6i1et4AxvMoLIDiGYav6ev1m5j9ZCAF4GkYaSMf6iATZdXJ3
         Gc9aP5/wJQcz1T0rBWx9SI9lzqLnyzyZNe3cq7FCLxyiwKgz73Q5zSAS7u5P/c83B5NH
         wGQEpkp6cwLSeEP0GImKGbHMm0lAV4ik4zI8r1HUF0K1J84Bo1a0QqF5NrgMopD2g8T7
         aWyDgI9odldYiuB55NqKkI1FbgqYUAuvNOIIn8O98y/zPeNZS1fdqyRiY4LUecA13VEg
         1Mxxio5K/CEs++UZM7pcU7HDXdM4GC0xCNVHST4e1Xq5C63T63Hb8iZT75QBy7K4pGNs
         4YQw==
X-Gm-Message-State: AOAM530WW2t1bTLXe5Hm0A8p4lh/irHs+34wjI+34omUBwF+/U7wQcHR
        tZLpAaKNusPhRBeNcqtxC3daMcmQnN4tZfRH9fb7Pw==
X-Google-Smtp-Source: ABdhPJypCfBIap1qfVyDPf9GKnF6IcierHr4eIXAb39wsTOTb1+XEiOppOE1PPcvOhD3UUXSdtIpISL/xoX/eMJE4Q8=
X-Received: by 2002:a2e:8046:: with SMTP id p6mr13595138ljg.100.1595340284205;
 Tue, 21 Jul 2020 07:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200720154548.12453-1-paul@crapouillou.net>
In-Reply-To: <20200720154548.12453-1-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 21 Jul 2020 16:04:33 +0200
Message-ID: <CACRpkdaqOFgjNkD0m0A3XTXYfh10YuAVYKxd-8cFk0WDsC0mZQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: ingenic,pinctrl: Support pinmux/pinconf nodes
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, od@zcrc.me,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 5:45 PM Paul Cercueil <paul@crapouillou.net> wrote:

> Add YAML to describe the pinmux/pinconf sub-nodes of the pinctrl IP on
> Ingenic SoCs.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Patch applied.

Yours,
Linus Walleij
