Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483C5248A9D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHRPxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 11:53:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36606 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgHRPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:52:49 -0400
Received: by mail-io1-f65.google.com with SMTP id t15so21721786iob.3;
        Tue, 18 Aug 2020 08:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lx00Sr/aZOdih/hQAlMDGCR8xD487Khs44wwEWuKUqw=;
        b=SZR2aiz0H0MRJo3lFNrNA9Bs1ZOREGoN+q+RX1snfV1+7vMuUKsuZJaQ7HeHrKDhZn
         7VqBnX0KmZxzjri3hsFRl97vWoX9lhr6PeFu0WH8BfGIUokZzGy+5iZOHE3ynphvdVc7
         To5YpAi/u5/tTo+5BVbqTuFf8wSgi1jwkRjgBcrvBZSvDHhZRa2k2PY9Vm7X2q913/Qf
         0QaAEc+GQdeCSaYt5GumDO3R3OgLFHSnODD+1xw7kQzuxI9x6tOXD9lP8QZWcq6lZTlz
         l3sGNObSKJADxAVtIkSqNbu8TVwehJWHSnGFXvOZzKvnmXwkgyRIakTlZzkuJaGBo0Mu
         lCoQ==
X-Gm-Message-State: AOAM533R+qNipYXcLc150onSZSKVoIO0pQzuZrlrZHv7+0XFikYuD8oJ
        wblMr+7aUDO/cOf/pLNff29HhwkOTQ==
X-Google-Smtp-Source: ABdhPJzqLS80p1GkQnW8MVkgZZOsRmFstEf7dY00kta91ejEPnghDx1rRCer+xSMD8zGCRqy+94LqA==
X-Received: by 2002:a6b:f608:: with SMTP id n8mr16801845ioh.148.1597765968343;
        Tue, 18 Aug 2020 08:52:48 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w13sm11785561ilj.70.2020.08.18.08.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:52:47 -0700 (PDT)
Received: (nullmailer pid 3528723 invoked by uid 1000);
        Tue, 18 Aug 2020 15:52:45 -0000
Date:   Tue, 18 Aug 2020 09:52:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        kernel@pengutronix.de, fugang.duan@nxp.com,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com,
        mturquette@baylibre.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, sboyd@kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V3 4/5] dt-bindings: serial: Convert MXS auart to
 json-schema
Message-ID: <20200818155245.GA3528677@bogus>
References: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
 <1597721685-9280-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597721685-9280-4-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 11:34:44 +0800, Anson Huang wrote:
> Convert the MXS auart binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V2:
> 	- update maintainer.
> ---
>  .../devicetree/bindings/serial/fsl-mxs-auart.txt   | 53 -------------
>  .../devicetree/bindings/serial/fsl-mxs-auart.yaml  | 91 ++++++++++++++++++++++
>  2 files changed, 91 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> 

Applied, thanks!
