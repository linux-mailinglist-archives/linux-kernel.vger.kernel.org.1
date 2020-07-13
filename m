Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5821A955
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGIUu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 16:50:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43935 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgGIUu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:50:57 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so3760336iom.10;
        Thu, 09 Jul 2020 13:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q4goypXlSfIbKuZsx6rZOOklIur5zL9+5WS2m3yf6L8=;
        b=azAPxUt6P/BO+bw4BLcjYqpAjCbby0avvLpzw1Tbs6YPkTR6NMnMSmMPFAOob7gBU9
         Y7BCG8ya+fnLoyuWx+JLDmRfwEn+1nRxLvBoJhoNPIwW8URpKqk2klNsF0ugmu1iHk4P
         OorfzxmeBNXnARnJ+KZHsTASQprPgiYYX8vEVpaBX7PmfHTD9jLsYi9CnQfEy34mQett
         TI2YSaAwcMTXSUiC91p/yMNfs2hoC7A+yNKE+B1SFmbznryYfYkZ2+eDtZbQeQUW9m7D
         SfDsJI+eSMtD8QbR0airONK2oEd6/EZlDO5Ce26u/EWyayZzePa21UnnGUITxkk46CIo
         zO3w==
X-Gm-Message-State: AOAM531gOzZEGW9QRVBJJj/eZx0olq66cfGt+B9ejZt/vQm46DpSlOEs
        IRNJ9LTOd3vo8Zs0uvAnjw==
X-Google-Smtp-Source: ABdhPJwp7A93nPBgC5fckCqt0ndWgAzxen2kDIkyo9KV3eSdH1FK32VaRJmA/NZgzmm/uQR3ITv7Zg==
X-Received: by 2002:a02:1784:: with SMTP id 126mr76296906jah.53.1594327857243;
        Thu, 09 Jul 2020 13:50:57 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id y12sm2422600ilm.38.2020.07.09.13.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:50:56 -0700 (PDT)
Received: (nullmailer pid 864966 invoked by uid 1000);
        Thu, 09 Jul 2020 20:50:55 -0000
Date:   Thu, 9 Jul 2020 14:50:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     andriy.shevchenko@intel.com, sureshkumar.mp@intel.com,
        lakshmi.bai.raja.subramanian@intel.com, devicetree@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Message-ID: <20200709205055.GA864918@bogus>
References: <20200702000934.3258-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200702000934.3258-2-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702000934.3258-2-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jul 2020 08:09:33 +0800, Wan Ahmad Zainie wrote:
> Binding description for Intel Keem Bay eMMC PHY.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/phy/intel,keembay-emmc-phy.yaml  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
