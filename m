Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA62E81C4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 20:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgLaTQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 14:16:39 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:42405 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgLaTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 14:16:39 -0500
Received: by mail-io1-f46.google.com with SMTP id q137so17789327iod.9;
        Thu, 31 Dec 2020 11:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+lkPg057yNBJ7KmMevFmNY1g6DJbx0e6fBNJvucI1aw=;
        b=q5OxJnrEGhUZl0UptrrgODOaph7s4VEaXJTe2X5OFOfNeit0qom+P+YlYJUocyxwSc
         CoQ4mkQuA/Psaenx0gz+kx9S+bkcYYGSaI+IMwhj4XdywWBhojNIAefaNqz5DCzAoz+3
         /nCZWzg26G3xKgkD7SzKY+MUbr7EnhnFRQqm95KAv+hmY92Sfehu2FRzTdWV8766uePw
         teCxC7QAJQrkGDbll3lrPQf6QYJltb9Btf6URW2nAdddn09DWZs+2dPcHUuI7oEXAlwO
         0xxuRmG0v6fQ8H6T0DnEXlfVUgTEXeYuQoaETSaJLWjY1vqJCeXaAQ1JTEmfBun1aZiT
         Kqbg==
X-Gm-Message-State: AOAM533gmY4sRjviuzekDygqo7txQvhEthPBYQcnmwHDX+Ao+OcaGn1F
        DPXARnEB72OOXlchVldUBA==
X-Google-Smtp-Source: ABdhPJzQhSaOD9fZsc0CStKiCNRiCrKPY1YfqvXlwLB92jNZwRq9tEh7jp3L4CF6RFQY01rdBiffiA==
X-Received: by 2002:a6b:dd13:: with SMTP id f19mr48168674ioc.74.1609442157914;
        Thu, 31 Dec 2020 11:15:57 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f20sm23983991ilr.85.2020.12.31.11.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 11:15:57 -0800 (PST)
Received: (nullmailer pid 2196828 invoked by uid 1000);
        Thu, 31 Dec 2020 19:15:55 -0000
Date:   Thu, 31 Dec 2020 12:15:55 -0700
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     a.hajda@samsung.com, daniel@ffwll.ch, narmstrong@baylibre.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, sam@ravnborg.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        dri-devel@lists.freedesktop.org, peter.ujfalusi@gmail.com,
        airlied@linux.ie, devicetree@vger.kernel.org,
        jernej.skrabec@siol.net
Subject: Re: [PATCH v2] dt-bindings: display: bridge: tc358768: Change
 maintainer information
Message-ID: <20201231191555.GA2196751@robh.at.kernel.org>
References: <20201218083522.21743-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218083522.21743-1-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 10:35:22 +0200, Peter Ujfalusi wrote:
> My employment with TI is coming to an end and I will not have access to
> the board where this bridge is connected to and I will also loose access to
> the manual of the chip.
> 
> Add the missing copyright information, author and change the maintainer to
> Sam Ravnborg (thank you for volenteering!)
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml  | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
