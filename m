Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A91E3289
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 00:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbgEZWaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 18:30:39 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38609 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389911AbgEZWaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:30:39 -0400
Received: by mail-il1-f196.google.com with SMTP id q18so1017415ilm.5;
        Tue, 26 May 2020 15:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uvZTRh4Nznd0Zmmmm65kfOWsQMC5SMuK+6+fcBdpZ+o=;
        b=nLFrzrVEmchqA51F0NmNNbqC5YWQ8frUQMqzkAS/uPOEupW0eCy9Gun7O5wecXAeo8
         MngXnykc+BW1xZ0XpvQ8nqA1UNyWaUFd9oI6R5O/BqaEGBTeng20GaAO6Bzq19hBFcQE
         hrQ248neZgzTeAOU9y2+D7CBMXwH2n+4io/P9SkbpwhV9VCjAiNuWXvC1ZCrhTZP6Ngb
         Rnjt0LbDNg3zdTsGSuJJpCLCRUsqjupp4kL3twm4bC1WNp57x8CnZf51Kj1w9byBoGLE
         qm9hAazWk2wL5z+QBHztqQNJjBXsr7Aqq7DUYgEi4BkX801M6QBX1/o73oQvVzEBZRB+
         UjVw==
X-Gm-Message-State: AOAM530b4ftmvdXcPbCaQwgqVBZ54E5STL6rHrox/jvXUNjCix3e6qnS
        5fwykwE0kd1Ho3Fd01nb2A==
X-Google-Smtp-Source: ABdhPJwRtqirt7lGaLtmACWvkh34S4Us9xy9DiuauaFs+bstalYo6Fnb7i5OYZ0/Fc1Btdw9dnvvUQ==
X-Received: by 2002:a92:b111:: with SMTP id t17mr3386857ilh.241.1590532238328;
        Tue, 26 May 2020 15:30:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k64sm689960ila.4.2020.05.26.15.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:30:37 -0700 (PDT)
Received: (nullmailer pid 502377 invoked by uid 1000);
        Tue, 26 May 2020 22:30:36 -0000
Date:   Tue, 26 May 2020 16:30:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-imx@nxp.com, mturquette@baylibre.com, shawnguo@kernel.org,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com
Subject: Re: [PATCH V5 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Message-ID: <20200526223036.GA502298@bogus>
References: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
 <1589328684-1397-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589328684-1397-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 08:11:20 +0800, Anson Huang wrote:
> Convert the i.MX6Q clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
> Changes since V4:
> 	- add descriptions for interrupts and each item of it.
> ---
>  .../devicetree/bindings/clock/imx6q-clock.txt      | 41 ------------
>  .../devicetree/bindings/clock/imx6q-clock.yaml     | 72 ++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> 

Applied, thanks!
