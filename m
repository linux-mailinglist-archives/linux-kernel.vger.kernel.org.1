Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38931E4E70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgE0Tn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:43:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39035 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0Tn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:43:57 -0400
Received: by mail-io1-f68.google.com with SMTP id c8so7068997iob.6;
        Wed, 27 May 2020 12:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GUrJtprj5c3Q6P3WiWHCXYx5EZjMx+zSQ65Aqq79Qkc=;
        b=l/vOTH2I3k37/QoYholNv3q1JvXMrYlswtPqyyfqtdQYJBSZYaWGQl89SRT2noZWmf
         4cJp8sGPSPNvmphpRPVZcgi5A2eJ7h75vhRUh78qPLQvW19XNfwD59eiIh6hMvu5I33C
         kSTvJtiIKiJofFjoIY6cI6zH+oX5erJO1d00iNdZSywbws62tVCuEgRqwgj9nlWYaZEy
         ypd9yYnzWJW9lbvxAMOjQGU6YJNOxBcSbHKdhu0neAxvBbFJOBP7wOp4y5TO3LkSR5t2
         EGgMRow0q+3F6uE64ApLahihJVZ6vnhHzpniTdrCaL1SON55AbA1lesevCDVcfu+g4bX
         9PDA==
X-Gm-Message-State: AOAM533BAuQrNtawFMy3M/1FBaJKcs1maPeex1UWhrPh2fOXPBYGTTOE
        yJqoxaLK2FQzRA7cxghb9yix4AQ=
X-Google-Smtp-Source: ABdhPJyAV35v+m3Fm1hqRkAmUa5z/rhqdH7c6f0oXIVXpt/6vydKgGe4ynC6RMhX7oFyXa/oag9WLw==
X-Received: by 2002:a6b:5915:: with SMTP id n21mr20633033iob.103.1590608634996;
        Wed, 27 May 2020 12:43:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l7sm2253517ilh.54.2020.05.27.12.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:43:54 -0700 (PDT)
Received: (nullmailer pid 2617897 invoked by uid 1000);
        Wed, 27 May 2020 19:43:53 -0000
Date:   Wed, 27 May 2020 13:43:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linus.walleij@linaro.org, broonie@kernel.org,
        myungjoo.ham@samsung.com, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, lee.jones@linaro.org,
        cw00.choi@samsung.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 2/7] extcon: arizona: Move binding over to dtschema
Message-ID: <20200527194353.GA2617805@bogus>
References: <20200513095720.8867-1-ckeepax@opensource.cirrus.com>
 <20200513095720.8867-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513095720.8867-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 10:57:15 +0100, Charles Keepax wrote:
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v2.
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/extcon/extcon-arizona.txt  |  76 -------------
>  .../devicetree/bindings/extcon/wlf,arizona.yaml    | 125 +++++++++++++++++++++
>  2 files changed, 125 insertions(+), 76 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-arizona.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
> 

Applied, thanks!
