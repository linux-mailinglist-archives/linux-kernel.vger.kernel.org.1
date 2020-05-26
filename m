Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3D21E32A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 00:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392143AbgEZWbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 18:31:41 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38706 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:31:39 -0400
Received: by mail-il1-f194.google.com with SMTP id q18so1019399ilm.5;
        Tue, 26 May 2020 15:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dG0yREiJ8rMigfSfPZSI5NcnyO0i13MGt4qNl+maJjs=;
        b=sSOavBq+EiqYb0po4IJRVm3kNfb4S4G70gZcNhSpQpZSb9Bx9kFq+XIUZBFPT1BGAF
         sP2GFLAYXB7UkMQvl9bZ/6kqTEWGHNC3oi/iUWxAC6SUjBa+6sGV49KOottVKgZ+0uAy
         2WdLXxH/1p+OOnZAqPfZqr7RYZ8/BKisaIJVTiWuHbitWOGLzD7cxDDeZEQ9Rv/4fgNw
         JmDyFoyhAizIhBApQ/1iNaHUpoJE2g7V03vP4dFysEUan5iqjUeVoJTW6SLNkgDY3Gur
         iTYsJyR8dNVDxC4o7XemY+Bz5WsIMFUlf8l/2eWx5LdYUMbJk/MM/K8jj82DhaX1fmQW
         11tg==
X-Gm-Message-State: AOAM533AtlE8h6Y8FcOrUhu/R9Zl+QA1UIyvthVuPRPeTYMnCxL/rq49
        S7vf0BsGOCU5l4HBEGbuKA==
X-Google-Smtp-Source: ABdhPJwYDuX0YBr0ghAF5q2Z3W0G8nV9//YxCnJwp57gwK8cUcmcS4rq7IEJAlPQZESwfKHB2R+QCA==
X-Received: by 2002:a92:b0d:: with SMTP id b13mr3323423ilf.225.1590532298662;
        Tue, 26 May 2020 15:31:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n21sm457321ioj.43.2020.05.26.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:31:38 -0700 (PDT)
Received: (nullmailer pid 504590 invoked by uid 1000);
        Tue, 26 May 2020 22:31:36 -0000
Date:   Tue, 26 May 2020 16:31:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-kernel@vger.kernel.org, Linux-imx@nxp.com,
        shawnguo@kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, s.hauer@pengutronix.de,
        mturquette@baylibre.com, festevam@gmail.com, kernel@pengutronix.de
Subject: Re: [PATCH V5 5/5] dt-bindings: clock: Convert i.MX6UL clock to
 json-schema
Message-ID: <20200526223136.GA504539@bogus>
References: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
 <1589328684-1397-6-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589328684-1397-6-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 08:11:24 +0800, Anson Huang wrote:
> Convert the i.MX6UL clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
> Changes since V4:
> 	- add descriptions for interrupts and each item of it.
> ---
>  .../devicetree/bindings/clock/imx6ul-clock.txt     | 13 -----
>  .../devicetree/bindings/clock/imx6ul-clock.yaml    | 66 ++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
> 

Applied, thanks!
