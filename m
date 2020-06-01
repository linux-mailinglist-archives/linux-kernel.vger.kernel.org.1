Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D679D1EA1A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 12:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgFAKOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 06:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:14:16 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F6CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 03:14:15 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 1so5261913vsl.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 03:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=dteu7F2HW9maWHh219okMdcIHh48ZidMoXpjcQhbbjmtnz8ulNF3GTzDfBxdibuzXE
         tPnKiyASN+ys7B3Y/XolGNjc364m48bxnVtrmDIz9Pznm5cEIXkYMpqNF7seUKP0Ezkg
         VO9rXztLxTLtrFoJCfhuUXGdWuRKjUBhwGYg+HW7XxslwhIRMdi0jBPbYqXG2trQGxHJ
         R4w8Okmn6f/U1Tyb8qH/i5I2G4ly3jmjm7ZEy0yRpKg7hAGKAiO0EavtBgvoMwD/Th5u
         GWMGEuBmw46t+UTT13f/ituEiY5xqzA+3AM53jnG5ELIwyxVO9Lu8OuuiBkGfN4e99YU
         h9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=bAViPJDzVTQcWzsOrO2gZS2UIzZiNgL1ARnNXwC5QVXCPIuHhSWsnYFyqfQhfjfSXx
         xFUoOOiOa7MzIfZnz+wKzr5245IVDJ+QFQ+rAwudRWQ56/cx05TeqD8QyAOoDG07xvNY
         ym1ArDPTXN5tbH+1mfntPml34YcI5WtYfrsxtALM1MNZmzy07yFM55efGLHicmUNeqm9
         V6UTmTsEjMoEXPpewRuEdY1Zultr/uTiSw2f5fdM7E5Y1JLKxHy1eT9zlXhYet25m+Kr
         Dh1mjTK9DsEDPwj1tbnwkG2+518LQn1aU2BCM8u7c5mmvZEQubxuqPx8ogq7UJ8Z5Eox
         qTmw==
X-Gm-Message-State: AOAM533VcfrDhtS0Ubr9/e4d9qveMfSBqOtMwPdDwEcFm5RZFv2KnJPE
        EBoF9vySq6f/YPoCFab/R4QLWOMHUZGSQeB76Ao=
X-Google-Smtp-Source: ABdhPJxe97ruq9nFerkxXo6qonckXmPkwVREKjg94f9QaEXpXRXHqWwSI7e+mn0RDEVYoQG90yQ6tlTLSRem0hZbV0A=
X-Received: by 2002:a67:e9d3:: with SMTP id q19mr13038102vso.220.1591006454373;
 Mon, 01 Jun 2020 03:14:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:7c09:0:0:0:0:0 with HTTP; Mon, 1 Jun 2020 03:14:11 -0700 (PDT)
Reply-To: robertandersonhappy1@gmail.com
From:   robert <ohehehe3055@gmail.com>
Date:   Mon, 1 Jun 2020 03:14:11 -0700
Message-ID: <CADYWKHxGE=Qhukb22bSKPvMNF_0CZ4+UtO=c5miCDN4-YAQmdA@mail.gmail.com>
Subject: =?UTF-8?B?0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsINCc0LXQvdGPINC30L7QstGD0YIg0JHQsNGA?=
        =?UTF-8?B?0YDQvtCx0LXRgNGCINCQ0L3QtNC10YDRgdC+0L0uINCvINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC?=
        =?UTF-8?B?0L3Ri9C5INC80LXQvdC10LTQttC10YAg0L/QviDRgNCw0LHQvtGC0LUg0YEg0LrQu9C40LXQvdGC0LA=?=
        =?UTF-8?B?0LzQuCDQv9C+0LrQvtC50L3QvtC80YMg0LrQu9C40LXQvdGC0YMuINCSIDIwMTUg0LPQvtC00YMg0Lw=?=
        =?UTF-8?B?0L7QuSDQutC70LjQtdC90YIg0L/QviDQuNC80LXQvdC4INCc0LjRgdGC0LXRgCDQmtCw0YDQu9C+0YEs?=
        =?UTF-8?B?INGB0LrQvtC90YfQsNC70YHRjywg0L/RgNC40YfQuNC90LAsINC/0L4g0LrQvtGC0L7RgNC+0Lkg0Y8g?=
        =?UTF-8?B?0YHQstGP0LfQsNC70YHRjyDRgSDQstCw0LzQuCwg0L/QvtGC0L7QvNGDINGH0YLQviDQstGLINC90L4=?=
        =?UTF-8?B?0YHQuNGC0LUg0YLRgyDQttC1INGE0LDQvNC40LvQuNGOINGBINGD0LzQtdGA0YjQuNC8LCDQuCDRjyA=?=
        =?UTF-8?B?0LzQvtCz0YMg0L/RgNC10LTRgdGC0LDQstC40YLRjCDQstCw0YEg0LrQsNC6INCx0LXQvdC10YTQuNGG?=
        =?UTF-8?B?0LjQsNGA0LAg0Lgg0LHQu9C40LbQsNC50YjQuNGFINGA0L7QtNGB0YLQstC10L3QvdC40LrQvtCyINCy?=
        =?UTF-8?B?INC80L7QuCDRgdGA0LXQtNGB0YLQstCwINC/0L7QutC+0LnQvdC+0LPQviDQutC70LjQtdC90YLQsCwg?=
        =?UTF-8?B?0YLQviDQstGLINCx0YPQtNC10YLQtSDRgdGC0L7Rj9GC0Ywg0LrQsNC6INC10LPQviDQsdC70LjQttCw?=
        =?UTF-8?B?0LnRiNC40LUg0YDQvtC00YHRgtCy0LXQvdC90LjQutC4INC4INGC0YDQtdCx0L7QstCw0YLRjCDRgdGA?=
        =?UTF-8?B?0LXQtNGB0YLQstCwLiDQvtGB0YLQsNCy0LjQsiDQtNC10L3RjNCz0Lgg0L3QsNGB0LvQtdC00YHRgtCy?=
        =?UTF-8?B?0L4g0YHQtdC80Lgg0LzQuNC70LvQuNC+0L3QvtCyINC/0Y/RgtC40YHQvtGCINGC0YvRgdGP0Ycg0LQ=?=
        =?UTF-8?B?0L7Qu9C70LDRgNC+0LIg0KHQqNCQINCU0L7Qu9C70LDRgNGLICg3LDUwMCwwMDAsMDAg0LTQvtC70Ls=?=
        =?UTF-8?B?0LDRgNC+0LIg0KHQqNCQKS4g0JzQvtC5INC/0L7QutC+0LnQvdGL0Lkg0LrQu9C40LXQve+/vQ==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


