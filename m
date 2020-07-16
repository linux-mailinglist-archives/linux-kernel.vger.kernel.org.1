Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1851222BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 21:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgGPTNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 15:13:25 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35927 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgGPTNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:13:21 -0400
Received: by mail-io1-f68.google.com with SMTP id y2so7227482ioy.3;
        Thu, 16 Jul 2020 12:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIttOoTOPqMFdqazs8PahDWs8uAzKu3fQLp00yEZzEs=;
        b=TbVAODPO+rMbA9zuoD6Z50MZax9GeDZrdAgkp4ldskfYF8MzHxQyeuv8DAIdgXsLsw
         mdTkscg0WEm5r3D6c4zaHjMcAPwa5Ok74eEnl3gbjb5VBNFMs1p4A/9cnXmVM15elc1N
         pBb2Rne6Hw0ffP7AYR5hV1mAcdRvT9vGtnetL11obUkq4bHzub/oh3JNztr8DVcbdj5E
         wOLQ1WQjoftFpY/peFh5C55qkhKR0dTOIxJ7COF6aPtIhzIJ1ZMwPPOVKrD86xgJDlsr
         lcLwEZkWBv4Uh1FGUIQg3OB8EZxyUv8Q6x0qRP9FY9hPdrTczQ/rW2LAlLxq0sp3W149
         t+TQ==
X-Gm-Message-State: AOAM532+3e17TfSy6YHZ8/ymHyqPtsL5944MTfYMBQ4OGlUbgYebYhyq
        MMlMf1zAk27KzKvtYkLzKQ==
X-Google-Smtp-Source: ABdhPJxDve+bGac++TOwwv477fCT+JMtLC0r9pSjhKoL4JqwZLLbzbzYgXnmngm9qddR1vgcFbbpQg==
X-Received: by 2002:a02:8308:: with SMTP id v8mr6689601jag.101.1594926800526;
        Thu, 16 Jul 2020 12:13:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p9sm3201232ilc.78.2020.07.16.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:13:19 -0700 (PDT)
Received: (nullmailer pid 2685058 invoked by uid 1000);
        Thu, 16 Jul 2020 19:13:18 -0000
Date:   Thu, 16 Jul 2020 13:13:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.Kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
Message-ID: <20200716191318.GA2683551@bogus>
References: <20200715221150.v3.2.I113cdbaf66d48b37ac0faefb9b845480d122f3b9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715221150.v3.2.I113cdbaf66d48b37ac0faefb9b845480d122f3b9@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:16:04PM -0700, Bhanu Prakash Maiya wrote:
> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> 
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/cros_ec.txt

Need to update this.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> ---
> 
> Changes in v3:
> - Rebased changes on google,cros-ec.yaml
> 
> Changes in v2:
> - No change
> 
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
