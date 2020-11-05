Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390132A850F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgKERhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:37:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43987 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKERhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:37:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id y22so2170605oti.10;
        Thu, 05 Nov 2020 09:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SXNYkLqUKc8MTYanbRLkQs7GYK94sIP+QM0jXos7oP4=;
        b=j7VYmspBYuq1ZOwOPonYCtarmLdYHe5J/BLBlnv+lvN+tJiGMmOTI3qf6msKgePWeC
         s7M2ukGruORuoVjHk3nU7jwoxvxYEAZk9UK0EUekOkvabwsScISIn5WlobeflbTii0Pq
         UuqcT4u871hLBy3Tqjnu7m1LKxOzUpBzVyftmc1EWH4vBNlUa9YlrUeBOGZlaVrVm+F3
         ieE5ofU7QHU4LLAmDWxv4y4Q4Xd17IWk9+9Md4NPaLMdy4swyTD7wzzSj57NO3NMCo4r
         /pQxIzOvW20UtLhp21OFOkkG1ZRThWRsAkXQyfhs3vqjr9l6S0gt3OnuEoabq9H+OLaW
         tweQ==
X-Gm-Message-State: AOAM532NlzZJU3/x4kIuZxV4lAuT2OpNgo0EFaOLXHD/PWX5pwVr+0fM
        p/+jcsw7UP0UV1oLhUol6g==
X-Google-Smtp-Source: ABdhPJxAI1k0VyZC87x5xf42TVt2elJ+4+m1P3SWlidqO1VtVuRTtTfa4RTIGmga6gHm4DtZwSpt8Q==
X-Received: by 2002:a9d:12b2:: with SMTP id g47mr2337033otg.354.1604597865604;
        Thu, 05 Nov 2020 09:37:45 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j10sm503462oii.14.2020.11.05.09.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:37:44 -0800 (PST)
Received: (nullmailer pid 1526952 invoked by uid 1000);
        Thu, 05 Nov 2020 17:37:44 -0000
Date:   Thu, 5 Nov 2020 11:37:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Aditya Prayoga <aditya@kobol.io>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: arm: rockchip: Add Kobol Helios64
Message-ID: <20201105173744.GA1526923@bogus>
References: <20201102150658.167161-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102150658.167161-1-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020 16:06:58 +0100, Uwe Kleine-König wrote:
> Document the new board by Kobol introduced recently in
> rockchip/rk3399-kobol-helios64.dts.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
> Hello,
> 
> Heiko pointed out in irc that I missed this bit when submitting support
> for the helios64 board (last submission starting at Message-Id:
> <20201014200030.845759-1-uwe@kleine-koenig.org>).
> 
> Best regards
> Uwe
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
