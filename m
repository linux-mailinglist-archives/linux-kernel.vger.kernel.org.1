Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2936721E599
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 04:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGNCW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 22:22:56 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39117 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNCWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:22:55 -0400
Received: by mail-io1-f66.google.com with SMTP id f23so15729337iof.6;
        Mon, 13 Jul 2020 19:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E9zs2BSIxknKvmLl7LMKCsZ/1jQO+w7iUmtbgUR1KY0=;
        b=DOuJ/lntnZ8fpl4EkskiuoLnnMy17O+6iBJwYDInFb3zSi/hoTLid7IMuoQJMuievJ
         CvmjIRXuK455d2wXqso7fsADrm4v/7+isXkhrIGk3OOItwaVGZNXlulBOD8FmLmBZo2F
         ZCd+ok7g8R3m2dx/JjmprWRJeBhDv7F9KPXeet2E+/TpFRzs4SAJ0k96qkUBr/iVooNm
         BYXWcy62/WWRJbRfH1f7lSOMPby/uQ9PT++tCfZQH3n8zZNaAtlim+0JmbsqUIZksaT7
         QDnKm/oISiyNWnHcF/VcpW01x98OquwBecP52b4U0mG6iXnz/+XrKk/H+vzxlF0qTB4C
         pYzQ==
X-Gm-Message-State: AOAM5301mDhOzcgEs4sV530sULw8TM9MV+9Kf7VfIGWx6IWI8A4aKn1E
        e/2dioUErLYRaxooW1pVJg==
X-Google-Smtp-Source: ABdhPJzhWC9AKojuZk6j40YEWnleK5Ux6idoUrgJeNbKK3ONpxXf28xo2JdvFtsu/J7oIlPUbgRQ2w==
X-Received: by 2002:a6b:6c09:: with SMTP id a9mr2750394ioh.178.1594693374184;
        Mon, 13 Jul 2020 19:22:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h5sm8908133ilq.22.2020.07.13.19.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:22:53 -0700 (PDT)
Received: (nullmailer pid 1151513 invoked by uid 1000);
        Tue, 14 Jul 2020 02:22:52 -0000
Date:   Mon, 13 Jul 2020 20:22:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, - <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to
 json-schema
Message-ID: <20200714022252.GA1151466@bogus>
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623114005.791643-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jun 2020 20:40:05 +0900, Masahiro Yamada wrote:
> Convert the UniPhier EVEA sound codec binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Add schema for subnode 'port'
> 
>  .../sound/socionext,uniphier-evea.yaml        | 70 +++++++++++++++++++
>  .../bindings/sound/uniphier,evea.txt          | 26 -------
>  2 files changed, 70 insertions(+), 26 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/uniphier,evea.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
