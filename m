Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB1274E50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIWB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:28:07 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:35836 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIWB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:28:06 -0400
Received: by mail-il1-f196.google.com with SMTP id y9so19250237ilq.2;
        Tue, 22 Sep 2020 18:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QS25WlOeUPQHrCUw0cdos8+dV1aU1kXgtHvYAn4oQeE=;
        b=Y465gliKbrNfjI7/JYRPTqgsxxN13/WhSbL2zhQ9Ppd8U7lj2GqOQ7DXqv0uMUb3pA
         KhShtT+f7X/WeRNOmOKUMBSfatyafRpg25Jut/zwzKLC/1fprsuzNUWEWJypNqN0SFU2
         /H73ZegmWFXamfgKB3TSHT84m/gPyg1lezLT3+5tLEzEwRXgtbvPiymoFtbkH5SAq/Ck
         ovlB7SsHjWI4wbmlqduUSKm/FrT/MWKdGuoSxNyp1Czw1Fv2xH4OQLoloK5ZJeENuDdz
         u+3VyEad5f3HNszce8okuOMYBvKXUCFQdvWROdeTJkVchD5Rn5FEYTgFCIsjkQA1dt+V
         gszA==
X-Gm-Message-State: AOAM530DhtOd7ZP2JnqYi2IuKkyASjxS/gqWyRYqfd2Nr2yDFMmIT+yc
        likpsD5tUbybVymwfIY84g==
X-Google-Smtp-Source: ABdhPJyDq6KsxVdqb84529uluzCnDBXafHIUSIQRG2lkorieEL37IUfKunEyKovQlRGvCFWv3dY7UA==
X-Received: by 2002:a92:dd8a:: with SMTP id g10mr4971211iln.125.1600824486322;
        Tue, 22 Sep 2020 18:28:06 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 64sm8414847iob.36.2020.09.22.18.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:28:05 -0700 (PDT)
Received: (nullmailer pid 3655638 invoked by uid 1000);
        Wed, 23 Sep 2020 01:28:04 -0000
Date:   Tue, 22 Sep 2020 19:28:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        dri-devel@lists.freedesktop.org, sam@ravnborg.org
Subject: Re: [PATCH v4 1/4] dt-bindings: vendor-prefixes: Add Shanghai Top
 Display Optolelectronics vendor prefix
Message-ID: <20200923012804.GA3655566@bogus>
References: <20200915121912.4347-1-narmstrong@baylibre.com>
 <20200915121912.4347-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915121912.4347-2-narmstrong@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 14:19:09 +0200, Neil Armstrong wrote:
> Shanghai Top Display Optolelectronics Co., Ltd  is a display manufacturer
> from Shanghai.
> Web site of the company: http://www.shtdo.com/
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
