Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAE274B50
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIVVnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgIVVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:43:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D95C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:43:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id bw23so2118248pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 14:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=53UukHq1kI2LdwgBLERIarUaHHt0dzvP8+s+/bYd0A4=;
        b=Yo/dZ0rKd7ba8E4CjQo7R++SRdvO91W2Be1bVaFPNpmftnEjeKNMhZyfqtTOHgkWss
         NA8eRjWJXrhuQbVpp/7JhT0BMEbSDuZUo44llHK33htMK3ZJX/eQ6LnsomI/f72O4GMa
         /+zTRQXI3bTC/qi3kJ4wNKx/TwM8xJxGFH2ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=53UukHq1kI2LdwgBLERIarUaHHt0dzvP8+s+/bYd0A4=;
        b=F2aJrBEnsndsN0f0detWLsRg6cta226Gr77ZpmKk5D/kNOqMqBbRTkAPuXDDTg+8qf
         XU8Wo9cQIajjwdc5N9CrOeNCxSxQVPS+lhtv52CQSnwyC7kqkydkAc1+U4HHrG8QH8mh
         e/q5phaJVlqSkC/XqbtmAhDXuRKy4uq4mcArEHg+jir3me0PsSrp/ofVJ86RDi2RnMo9
         PJcojHjHsVMIChKNFuHqXetcvUDw+cV40JmrLoW6TKV6I6rsA2h1/x9FpxeOT8PifA4R
         z/5FeGC74dJbQ8lz9Aj1xYBwIsClLEVMw670WItt9m30uMfhEnEXQWag44lbL/AvHkyA
         HjvA==
X-Gm-Message-State: AOAM532O/xZDimuetgjqggBBlpOJ7voa1u0jExfpRv+pg6EfcwElcFTC
        Yk1t/y9aEtynyZlzJmLhw9/nWA==
X-Google-Smtp-Source: ABdhPJy9rBpspmhIKC5WF3bw8wowSoG4ZWVQC2GUasuY/7UVLzNqqUZ6h/5v8Wo5mE23MeV9k84F1g==
X-Received: by 2002:a17:90b:707:: with SMTP id s7mr5518349pjz.25.1600811021681;
        Tue, 22 Sep 2020 14:43:41 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id y25sm15572761pfn.71.2020.09.22.14.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 14:43:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200914210047.GA232617@bogus>
References: <20200903221828.3657250-1-swboyd@chromium.org> <20200914210047.GA232617@bogus>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT properties
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>
Date:   Tue, 22 Sep 2020 14:43:39 -0700
Message-ID: <160081101949.310579.13737183960958276765@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2020-09-14 14:00:47)
> On Thu, Sep 03, 2020 at 03:18:28PM -0700, Stephen Boyd wrote:
> > +  semtech,cs1-gain-factor:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#definitions/uint32
> > +      - enum: [1, 2, 4, 8]
>=20
> Now that everyone is trained on 'allOf', you can drop it. json-schema=20
> draft8 changed this behavior.
>=20

Ok. Do I need $ref: still or that is implicit now?
