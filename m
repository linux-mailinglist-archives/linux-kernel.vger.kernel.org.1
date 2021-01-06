Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01EF2EB83C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 03:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbhAFCsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 21:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAFCsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 21:48:00 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37781C06134B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 18:47:20 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id f6so1457265ybq.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 18:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=il33bZNV6ioLITMHVlJWp7whkYU83gTCLO3ihRF6F5g=;
        b=sgUXamF/2NcLow8pndv/M+BHP7nEuMv5Y034NKn2Z/6Syx+4DOvCQljA06xqNtdOY6
         LyxODWQMS6dssq1xluTXXteMJC9FVcNQWWPtEeLgH56EIeBa8kxn+f0llZ8n4rPtQ8Ql
         QXWF0wXD4O84Bz8ua7gOam5bmhhsB0EuO9U3MfHupQRLTLaXq4NSNU1oX5OkPnFHr2s1
         fxbf/3JCAs8bO6pjatS5Lr0cDGk5Zotzn/sqM06rrX2FOoyOnw29OEuqTnuVo8bprQje
         nQsGgOFbzNssvgd+cM13ioMu/hLyqA5zMFPDd3QuObCVQ0ckONY7VOQ/MjAOQQ3oukv/
         cfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=il33bZNV6ioLITMHVlJWp7whkYU83gTCLO3ihRF6F5g=;
        b=Xr51hRyaDN2AYWPyF8yXKF35ri1un64raTdafimO+1zXlaHa5rZkozuh3aF+H3YlI8
         YKk1mOmOUNzbQDjEeKYeBMAcyIFJsuXwjeJtGagbN7q7V4b/R899IsDRhn0g8YVA5rAt
         0a111XYE8sZyPGtCmPN8xyAmmxob9KxAg9nGMHNrx4c+jC4wbAQkEdIhJtVXdoiAmNkb
         aQ1OEsZ7Q8pWVMuzY2GGZHXFE0PmvN3w0qVLqogKzFZ2d9IHw4O3jsOT9c3NZqyXpHbP
         SG87EfylKvvnlZNu3Ix+he3ph8T08bygq8ipWK/P4qecP1VxCFvWYwfgjpLhhZUAL36h
         qLKQ==
X-Gm-Message-State: AOAM5325lcITgOkvpHxoANo255Zv/icxAj9FWTYUtvwJvo7x3Lk4cdoT
        A+DFIaHsDPVFm/KARe3RkJHVtkCTV5HfSVuo6yA7JjjE
X-Google-Smtp-Source: ABdhPJz6FXf4+TbVZwjPTfNSlZ6xp58ZSaAN/ps2NO3ewHVYetfGwm8jgNU1ST0BgySzLcgYrCWBestKzUZp4e/TrcI=
X-Received: by 2002:a5b:949:: with SMTP id x9mr3675192ybq.33.1609901239371;
 Tue, 05 Jan 2021 18:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20210105150124.dvlochv3qrp4wpre@runtux.com> <20210105150518.euxpkga3viadr3r6@runtux.com>
In-Reply-To: <20210105150518.euxpkga3viadr3r6@runtux.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Jan 2021 03:47:08 +0100
Message-ID: <CANiq72mkvqJ1p=Ev6gWD285hkgytnWspaYom0Zwk1c_vSWpnjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay: devicetree doc for HD44780/PCF8574
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Something quick I noticed...

On Tue, Jan 5, 2021 at 4:05 PM Ralf Schlatterbeck <rsc@runtux.com> wrote:
>
> +  display-height-chars:
> +    description: Height of the display, in character cells,

Spurious comma instead of period.

Cheers,
Miguel
