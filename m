Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8832636A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIITdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 15:33:17 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:37526 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIITdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:33:16 -0400
Received: by mail-ej1-f68.google.com with SMTP id nw23so5251017ejb.4;
        Wed, 09 Sep 2020 12:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yh5U4DdKjNhyUaf2ifBbb4LF6J0UbLKo+raAvinnvCc=;
        b=FInsvLBJOjYiufyYIA0L/TE4dnLBIwMRZMh4bjYVAkf9PCiYBe6vNfsSPNrGlqn2w3
         T8HAwxpVDxoHrnT9VoHIPtIbSRggv9JYPpE0Qd1sj9Lq5kylbIbNehQrzFKfVPtxoWer
         Lxaux0yo6oNMQm3VxuKg80COCgiaJHdOD7LaZedm0JrYVRzZeyXiDhIvW1CfZoWSdILS
         leyLD6/sTAu+kavc9e8tbL5lrTKYcg0DODaWBKvYdmwo5Le8djWf82CDMmXr/YOApavF
         PIBZLVWDmPmen3fe46t258R86pe9+H7xs5npR8ROUHcJYGCz7O4RQkW/u3z5XrHuA/tu
         8W3w==
X-Gm-Message-State: AOAM532OhiztGSBHlJtMuDVO3W8O54WFBtBALkpz17jhaudlbmo61Vu9
        XxQQWSBFHBq+42KYavvEpl0=
X-Google-Smtp-Source: ABdhPJzfLTKoQqFfsuyMyzEyLXyZr0KGpy8lDztIEh6WKkxAjXcD2vd6EVWLi/WVCEqwa5g4EAyG9w==
X-Received: by 2002:a17:906:d97b:: with SMTP id rp27mr5520650ejb.18.1599679994274;
        Wed, 09 Sep 2020 12:33:14 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id 40sm3702732edr.67.2020.09.09.12.33.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Sep 2020 12:33:13 -0700 (PDT)
Date:   Wed, 9 Sep 2020 21:33:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: Add binding for MT8167 SMI
Message-ID: <20200909193311.GA15293@kozik-lap>
References: <20200906180938.1117526-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200906180938.1117526-1-fparent@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 08:09:37PM +0200, Fabien Parent wrote:
> Add device tree bindings documentation for MT8167 SMI.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.txt        | 3 ++-
>  .../bindings/memory-controllers/mediatek,smi-larb.txt          | 3 ++-

Thanks, applied.

Best regards,
Krzysztof

