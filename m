Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39009269952
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgINW6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:58:50 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36975 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgINW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:58:46 -0400
Received: by mail-il1-f196.google.com with SMTP id q4so1213248ils.4;
        Mon, 14 Sep 2020 15:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RKxn9ltTeGk0IfBnG8P7vO3oM47OWQ2uxYOxzfrKlsA=;
        b=dRsUUUUGr6zb4mP9aUzMmg9hlgnOHw7avHiswIIX8x9/e7fc+nvZ5TrRrVUkMjnST9
         0h6CYDhrBERR8qV3vAkJPl7cqeTclUMGe3/ZVq6sKDKFn0ZlW84sxGXGa36l/eMYFfgm
         YWlFLj5rCOi8ZtBgZHxI4B8j9rbPqI1BSNaTqaTukQjNzeSi7DyRfHoGfy5/iPNvSprL
         WNNYXv8Z8+CY0AgKrZSM0hQRr3d825CUIn+tyvxpzgyPlxCeCMo3pOUuR9JYK1EeINw4
         IKKQwlZ/xV1hEYdZkCmRpGymVNGZ/JOP5hogL3pTzae0jmQRajklr3mq2wGdYF5siq/U
         StqQ==
X-Gm-Message-State: AOAM532tRthX4kPVeqMP9nPNcNf6BFgWITPHPkQGK1l573xwtHs+m/Mi
        k8QYK5dR3rD52J1OiGqqAg==
X-Google-Smtp-Source: ABdhPJz6RwllSQxsqBRALQYuJie5kN26/ggu2+F6pAUHNple19DCIa7Sh1W/ch2mMtZYqjGoDexgKA==
X-Received: by 2002:a92:d08a:: with SMTP id h10mr9933338ilh.109.1600124325487;
        Mon, 14 Sep 2020 15:58:45 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id u9sm6367518iow.26.2020.09.14.15.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 15:58:44 -0700 (PDT)
Received: (nullmailer pid 428538 invoked by uid 1000);
        Mon, 14 Sep 2020 22:58:43 -0000
Date:   Mon, 14 Sep 2020 16:58:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Yes Optoelectronics
Message-ID: <20200914225843.GA428486@bogus>
References: <20200904180821.302194-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904180821.302194-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 23:38:19 +0530, Jagan Teki wrote:
> Add vendor dt-bindings for Yes Optoelectronics Co.,Ltd.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
